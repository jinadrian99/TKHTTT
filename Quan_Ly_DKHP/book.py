# coding=utf-8
from openerp.osv import fields,osv

class book (osv.osv):
    _name='hp.hp'
    _columns = {
        'hocphan':fields.char('Học phần', size=25, required=True, translate=True),
        'sotinchi':fields.integer('Số tín chỉ'),
        'hptienquyet':fields.integer('Học phần tiên quyết'),
        'tbl_hptq': fields.many2many('hp.hp', 'hp_hp', 'id', 'create_uid', ''),
        # 'project_ids': fields.many2many('project.project', 'project_task_type_rel', 'type_id', 'project_id', 'Projects'),
    }
    
book()
