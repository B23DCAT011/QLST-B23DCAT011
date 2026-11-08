# -*- coding: utf-8 -*-
"""Sinh tang thuc the (package model) va script tao bang CSDL tu chinh thiet ke cua bai tap 3.

Chay tu thu muc `bài tập 4`:  python tools/gen_code.py
- Dau vao 1: ../bài tập 3/plantuml/01_class_thucthe_thietke.puml (Hinh 2 - 42 lop thuc the pha thiet ke)
  -> QLST1/src/model/<Lop>.java : moi thuoc tinh cua lop thanh mot bien private cung ten, cung kieu,
     kem get/set; quan he ke thua (<|--) thanh `extends`.
- Dau vao 2: ../bài tập 3/plantuml/02_csdl_hethong.puml (Hinh 3 - 35 bang)
  -> QLST1/database/qlst1_schema.sql : moi bang mot CREATE TABLE, dung ten cot, kieu, khoa (PK, FK, U, N).

Quy doi kieu (giong cach casestudy cai dat thiet ke): integer -> int, float -> float, boolean -> boolean,
Date -> java.util.Date, String -> String, Lop -> Lop, Lop[] -> ArrayList<Lop>.
"""
import os
import re

BASE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DESIGN = os.path.join(os.path.dirname(BASE), 'bài tập 3', 'plantuml')
PROJECT = os.path.join(BASE, 'QLST1')

JAVA_TYPE = {'integer': 'int', 'float': 'float', 'boolean': 'boolean', 'Date': 'Date', 'String': 'String'}


def parse_classes(text):
    classes = {}
    for m in re.finditer(r'^class (\w+) \{(.*?)^\}', text, re.S | re.M):
        attrs = []
        for line in m.group(2).splitlines():
            line = line.strip()
            if line.startswith('-'):
                name, typ = [x.strip() for x in line[1:].split(':')]
                attrs.append((name, typ))
        classes[m.group(1)] = attrs
    parents = dict((c, p) for p, c in re.findall(r'^(\w+) <\|-- (\w+)', text, re.M))
    return classes, parents


def java_type(t):
    if t.endswith('[]'):
        return 'ArrayList<%s>' % t[:-2]
    return JAVA_TYPE.get(t, t)


def gen_model():
    text = open(os.path.join(DESIGN, '01_class_thucthe_thietke.puml'), encoding='utf-8').read()
    classes, parents = parse_classes(text)
    out_dir = os.path.join(PROJECT, 'src', 'model')
    os.makedirs(out_dir, exist_ok=True)
    for cls, attrs in classes.items():
        types = [java_type(t) for _, t in attrs]
        imports = []
        if any(t.startswith('ArrayList') for t in types):
            imports.append('import java.util.ArrayList;')
        if 'Date' in types:
            imports.append('import java.util.Date;')
        ext = ' extends %s' % parents[cls] if cls in parents else ''
        lines = ['package model;', '']
        if imports:
            lines += imports + ['']
        lines.append('/**')
        lines.append(' * Lớp thực thể %s (biểu đồ lớp thực thể pha thiết kế - Hình 2).' % cls)
        lines.append(' */')
        lines.append('public class %s%s {' % (cls, ext))
        for (name, _), jt in zip(attrs, types):
            lines.append('    private %s %s;' % (jt, name))
        lines.append('')
        lines.append('    public %s() {' % cls)
        lines.append('        super();')
        lines.append('    }')
        for (name, _), jt in zip(attrs, types):
            cap = name[0].upper() + name[1:]
            getter = ('is' if jt == 'boolean' else 'get') + cap
            lines += ['',
                      '    public %s %s() {' % (jt, getter),
                      '        return %s;' % name,
                      '    }',
                      '',
                      '    public void set%s(%s %s) {' % (cap, jt, name),
                      '        this.%s = %s;' % (name, name),
                      '    }']
        lines.append('}')
        open(os.path.join(out_dir, cls + '.java'), 'w', encoding='utf-8', newline='\n').write('\n'.join(lines) + '\n')
    return classes


SQL_TYPE = {'integer(10)': 'INT(10)', 'float': 'FLOAT', 'date': 'DATE', 'tinyint(1)': 'TINYINT(1)'}


def gen_schema():
    text = open(os.path.join(DESIGN, '02_csdl_hethong.puml'), encoding='utf-8').read()
    tables = []
    for m in re.finditer(r'^entity (\w+) \{(.*?)^\}', text, re.S | re.M):
        cols = []
        for line in m.group(2).splitlines():
            fm = re.match(r'\s*\{field\} (\w+) : ([\w()]+)(?: \[([^\]]*)\])?', line)
            if fm:
                keys = [k.strip() for k in (fm.group(3) or '').split(',') if k.strip()]
                cols.append((fm.group(1), fm.group(2), keys))
        tables.append((m.group(1), cols))
    pk_of = {t: [c for c, _, k in cols if 'PK' in k][0] for t, cols in tables}

    def ref_table(col):
        name = col[:-2]                              # bo duoi "id"
        name = re.sub(r'^(from|to)', '', name)       # fromStorageLocation1id, toStorageLocation1id
        return name if name.startswith('tbl') else 'tbl' + name

    out = ['-- CSDL qlst1 cua he thong QLST (35 bang), sinh tu bieu do thiet ke CSDL (Hinh 3, bai tap 3).',
           '-- Quy uoc: PK = khoa chinh, FK = khoa ngoai, U = gia tri duy nhat, N = cho phep NULL.',
           'DROP DATABASE IF EXISTS qlst1;',
           'CREATE DATABASE qlst1 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;',
           'USE qlst1;',
           'SET FOREIGN_KEY_CHECKS = 0;', '']
    for t, cols in tables:
        defs, cons = [], []
        for c, typ, keys in cols:
            st = SQL_TYPE.get(typ, typ.upper())
            null = 'NULL' if 'N' in keys else 'NOT NULL'
            auto = ' AUTO_INCREMENT' if ('PK' in keys and 'FK' not in keys) else ''
            defs.append('  `%s` %s %s%s' % (c, st, null, auto))
            if 'PK' in keys:
                cons.append('  PRIMARY KEY (`%s`)' % c)
            if 'U' in keys:
                cons.append('  UNIQUE KEY `uq_%s_%s` (`%s`)' % (t, c, c))
            if 'FK' in keys:
                rt = ref_table(c)
                cons.append('  CONSTRAINT `fk_%s_%s` FOREIGN KEY (`%s`) REFERENCES `%s` (`%s`)' % (t, c, c, rt, pk_of[rt]))
        for a, b in UNIQUE_PAIRS.get(t, []):
            cons.append('  UNIQUE KEY `uq_%s_cap` (`%s`, `%s`)' % (t, a, b))
        out.append('CREATE TABLE `%s` (\n%s\n) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;\n'
                   % (t, ',\n'.join(defs + cons)))
    out.append('SET FOREIGN_KEY_CHECKS = 1;')
    db_dir = os.path.join(PROJECT, 'database')
    os.makedirs(db_dir, exist_ok=True)
    open(os.path.join(db_dir, 'qlst1_schema.sql'), 'w', encoding='utf-8', newline='\n').write('\n'.join(out) + '\n')
    return tables


# Rang buoc duy nhat theo cap cot (muc "Rang buoc toan ven", Phan IV bai tap 3)
UNIQUE_PAIRS = {
    'tblSuppliedItem1': [('tblSupplyContract1id', 'tblItem1id')],
    'tblStockReceiptDetail1': [('tblStockReceiptNote1id', 'tblSuppliedItem1id')],
    'tblCartItem1': [('tblCart1id', 'tblItem1id')],
    'tblOrderDetail1': [('tblOnlineOrder1id', 'tblItem1id')],
    'tblInvoiceDetail1': [('tblInvoice1id', 'tblItem1id')],
}

if __name__ == '__main__':
    c = gen_model()
    t = gen_schema()
    print('model: %d lop | schema: %d bang' % (len(c), len(t)))
