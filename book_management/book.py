# coding=utf-8
from openerp.osv import fields,osv

class book (osv.osv):
    _name='book.book'
    _columns = {
        #cac thuoc tinh cua lop book
        'name':fields.char('Tên sách', size=25, required=True, translate=True),
        'pages':fields.integer('Tổng số trang'),
        'author':fields.char('Tác giả',size=100, required=True, translate=True),
        'genre':fields.selection([('tt','Truyện tranh'),('tn','Truyện ngắn'),
                                 ('tth','Tiểu thuyết'),('th','Thơ')],'Thể loại'),
        'published_date':fields.datetime('Ngày phát hành'),
        'active':fields.boolean('Đang bán ?'),
        'notes':fields.text('Chi tiết')
    }
    _defaults={
        'pages':0,
        'active':True
    }
book() #tao 1 the hien cho lop book_book
