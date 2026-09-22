#!/usr/bin/env python3
"""Robust parser for minified Lua (dispatch tree). Handles strings, comments, all block forms."""
import re, pickle

TOK = re.compile(r'''
    (?P<ws>\s+)
  | (?P<num>\d+\.\d+|\d+|0x[0-9a-fA-F]+)
  | (?P<str>"(?:\\.|[^"\\])*"|'(?:\\.|[^'\\])*')
  | (?P<longstr>\[(=*)\[.*?\]\2\])
  | (?P<comment>--(?:\[(=*)\[.*?\]\2\]|[^\n]*))
  | (?P<name>[A-Za-z_][A-Za-z0-9_]*)
  | (?P<op>==|~=|<=|>=|\.\.|//|::|[-+*/%^#<>=(){}\[\];:,.])
''', re.VERBOSE | re.DOTALL)

KEYWORDS = {'if','then','elseif','else','end','for','while','do','function',
            'repeat','until','local','return','break','continue','in','nil','true','false','not','and','or'}

def tokenize(txt):
    toks = []
    i = 0
    n = len(txt)
    while i < n:
        m = TOK.match(txt, i)
        if not m:
            toks.append(('other', txt[i])); i += 1; continue
        kind = m.lastgroup
        val = m.group()
        if kind == 'ws' or kind == 'comment':
            i = m.end(); continue
        if kind == 'name':
            toks.append(('kw' if val in KEYWORDS else 'name', val))
        elif kind in ('num', 'str', 'longstr'):
            toks.append(('lit', val))
        else:
            toks.append(('op', val))
        i = m.end()
    return toks

class P:
    def __init__(self, toks):
        self.t = toks
        self.i = 0

    def peek(self, k=0):
        j = self.i + k
        return self.t[j] if j < len(self.t) else ('eof', '')

    def at(self, val, kind='kw'):
        t = self.peek()
        return t[0] == kind and t[1] == val

    def at_name_like(self):
        t = self.peek()
        return t[0] in ('name', 'lit', 'op') or (t[0] == 'kw' and t[1] in ('nil','true','false','not','function'))

    # ---- block: parse until 'end' (or 'else'/'elseif' if stop_at_else). 'until' also ends (repeat body).
    def parse_block(self, stop_at_else=False, stop_at_until=False):
        items = []
        while self.i < len(self.t):
            kind, val = self.peek()
            if kind == 'kw':
                if val == 'end':
                    return items
                if val in ('else', 'elseif') and stop_at_else:
                    return items
                if val == 'until' and stop_at_until:
                    return items
                if val == 'if':
                    items.append(self.parse_if()); continue
                if val in ('for', 'while', 'do', 'function', 'repeat', 'local', 'return', 'break', 'continue'):
                    items.append(self.parse_stmt()); continue
                # 'not','and','or','in','nil','true','false' start expressions -> raw stmt
                items.append(self.parse_raw_stmt()); continue
            # non-kw start: raw statement (expression statement or assignments etc)
            items.append(self.parse_raw_stmt())
        return items

    def parse_raw_stmt(self):
        """Consume tokens until we hit a statement keyword at bracket-depth 0, or a block end."""
        start = self.i
        depth = 0
        while self.i < len(self.t):
            kind, val = self.peek()
            if kind == 'op':
                if val in ('(', '[', '{'):
                    depth += 1
                elif val in (')', ']', '}'):
                    depth -= 1
                elif depth == 0 and val == ';' and self.i > start:
                    self.i += 1
                    raw = self.render(start, self.i - 1)
                    if raw.strip():
                        return ('raw', raw.strip().rstrip(';').strip())
                    start = self.i
                    continue
            elif kind == 'kw':
                if depth == 0:
                    if val in ('end',):
                        raw = self.render(start, self.i)
                        return ('raw', raw.strip().rstrip(';').strip()) if raw.strip() else ('raw', '')
                    if val in ('else', 'elseif'):
                        raw = self.render(start, self.i)
                        return ('raw', raw.strip().rstrip(';').strip()) if raw.strip() else ('raw', '')
                    if val == 'until':
                        raw = self.render(start, self.i)
                        return ('raw', raw.strip().rstrip(';').strip()) if raw.strip() else ('raw', '')
                    if val in ('if', 'for', 'while', 'do', 'function', 'return', 'break', 'continue', 'repeat'):
                        # statement boundary: end current raw, caller will pick up new stmt
                        raw = self.render(start, self.i)
                        if raw.strip():
                            return ('raw', raw.strip().rstrip(';').strip())
                        # shouldn't reach (loop start handles those)
                        self.parse_stmt(); continue
                elif val == 'function':
                    pass
            self.i += 1
        raw = self.render(start, self.i)
        return ('raw', raw.strip().rstrip(';').strip()) if raw.strip() else ('raw', '')

    def parse_stmt(self):
        """Handle compound statement: for/while/do/function/repeat/local/return/break/continue"""
        kind, val = self.peek()
        if val == 'function':
            # function name(params) body end  (only as statement; anonymous handled in raw)
            start = self.i
            self.i += 1
            depth = 1  # for the function body
            # skip name/params until we see balanced body
            # approach: find 'end' matching: track by scanning keywords from here
            # function header: name(.name)*(params) then body
            # scan tokens; count nested block openers
            d = 0
            while self.i < len(self.t):
                k2, v2 = self.peek()
                if k2 == 'kw':
                    if v2 in ('function', 'if', 'for', 'while', 'do', 'repeat'):
                        d += 1
                    elif v2 in ('end', 'until'):
                        d -= 1
                        if d == 0:
                            self.i += 1
                            break
                self.i += 1
            return ('raw', self.render(start, self.i))
        if val in ('for', 'while'):
            # header up to 'do' — the 'do' belongs to header; then block; then 'end'
            start = self.i
            self.i += 1
            # skip header: until kw 'do' at paren-depth 0
            d = 0
            while self.i < len(self.t):
                k2, v2 = self.peek()
                if k2 == 'op':
                    if v2 in ('(', '[', '{'): d += 1
                    elif v2 in (')', ']', '}'): d -= 1
                elif k2 == 'kw' and v2 == 'do' and d == 0:
                    self.i += 1
                    break
                self.i += 1
            body = self.parse_block()
            # consume 'end'
            if self.at('end'): self.i += 1
            return ('raw', self.render(start, self.i))
        if val == 'do':
            start = self.i
            self.i += 1
            body = self.parse_block()
            if self.at('end'): self.i += 1
            return ('raw', self.render(start, self.i))
        if val == 'repeat':
            start = self.i
            self.i += 1
            body = self.parse_block(stop_at_until=True)
            if self.at('until'): self.i += 1
            # skip condition until statement boundary
            self.parse_raw_stmt()
            return ('raw', self.render(start, self.i))
        if val == 'function':
            pass
        # local/return/break/continue
        start = self.i
        self.i += 1
        if val == 'function':
            self.i -= 1
            return self.parse_stmt()
        if val == 'local':
            # local x = function...end  or  local x = expr;  — parse as raw stmt from start
            self.i = start
            return self.parse_raw_stmt()
        if val == 'return':
            # return exprlist until statement boundary ('end','else','until') or ';'
            d = 0
            while self.i < len(self.t):
                k2, v2 = self.peek()
                if k2 == 'op':
                    if v2 in ('(', '[', '{'): d += 1
                    elif v2 in (')', ']', '}'): d -= 1
                    elif v2 == ';' and d == 0:
                        self.i += 1
                        break
                elif k2 == 'kw' and d == 0 and v2 in ('end', 'else', 'elseif', 'until'):
                    break
                self.i += 1
            return ('raw', self.render(start, self.i))
        # break/continue
        return ('raw', self.render(start, self.i))

    def parse_if(self):
        assert self.at('if')
        branches = []
        first = True
        while True:
            if first:
                self.i += 1  # skip 'if'
                first = False
            else:
                self.i += 1  # skip 'elseif'
            # cond until 'then'
            cstart = self.i
            d = 0
            while self.i < len(self.t):
                k2, v2 = self.peek()
                if k2 == 'op':
                    if v2 in ('(', '[', '{'): d += 1
                    elif v2 in (')', ']', '}'): d -= 1
                elif k2 == 'kw' and v2 == 'then' and d == 0:
                    break
                self.i += 1
            cond = self.render(cstart, self.i)
            self.i += 1  # skip 'then'
            block = self.parse_block(stop_at_else=True)
            branches.append((cond, block))
            kind, val = self.peek()
            if val == 'elseif':
                continue
            if val == 'else':
                self.i += 1
                eblock = self.parse_block()
                if self.at('end'): self.i += 1
                return ('if', branches, eblock)
            # 'end'
            if self.at('end'): self.i += 1
            return ('if', branches, None)

    def render(self, a, b):
        return ' '.join(v for k, v in self.t[a:b])

if __name__ == '__main__':
    txt = open('dispatch.txt').read()
    toks = tokenize(txt)
    print("tokens:", len(toks))
    p = P(toks)
    items = p.parse_block()
    print("consumed:", p.i, "/", len(toks))
    pickle.dump(items, open('dispatch_ast.pkl', 'wb'))

    # count
    def cnt(nodes):
        r = 0
        for nd in nodes:
            r += 1
            if nd[0] == 'if':
                for c, b in nd[1]: r += cnt(b)
                if nd[2] is not None: r += cnt(nd[2])
        return r
    print("nodes:", cnt(items))
