# coding=utf-8
from openerp.osv import fields,osv

class book (osv.osv):
    _name='hp.hp'
    _columns = {
        'hocphan':fields.char('Học phần', size=25, required=True, translate=True),
        'sotinchi':fields.integer('Số tín chỉ'),
        'hptienquyet':fields.integer('Học phần tiên quyết'),
        'tbl_hptq': fields.many2many('hp.hp', 'hp_hp', 'id', 'create_uid', ''),
    }
book()

class lop (osv.osv):
    _name='lhp.lhp'
    _columns = {
        'malhp':fields.char('Mã Học phần', size=50, required=True, translate=True),
        'tenhp':fields.selection([('a', "Lập trình nâng cao"), ('KTLT','Kỹ thuật lập trình'), ('VeCV','Vẽ cảnh vật')], 'Tên học phần', select=True, default='a'),
        'giangvien':fields.selection([('h', "Trần Quốc Hùng"), ('kw','KaiWen'), ('x','Xue'), ('f','Fu')], 'Giảng viên', select=True),
        'ngaybatdau':fields.date('Ngày bắt đầu', size=50),
        'ngayketthuc':fields.date('Ngày kết thúc', size=50),
        'ghichu':fields.text('', size=200, required=True, translate=False),
    }
lop()
