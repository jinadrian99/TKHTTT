# coding=utf-8
from openerp.osv import fields,osv

class book (osv.osv):
    _name='hp.hp'
    _columns = {
        'hocphan':fields.char('Học phần', size=25, required=True, translate=True),
        'sotinchi':fields.integer('Số tín chỉ'),
        'hptienquyet':fields.integer('Học phần tiên quyết')
    }
    
book()
