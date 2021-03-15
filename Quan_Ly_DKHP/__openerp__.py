#noi dung cua file mo ta
{
    "name":"Quản lý đăng ký học phần", #ten cua module
    "version": "1.0",
    "author": "TranQuocHung",
    "description": "This module is used to manage HocPhan", #mo ta module
    "website": "",
    "category":"General",
    "depends":["base"],#khai bao nhung module lien quan
    "init_xml":[],
    "demo_xml":["book_demo.xml"],
    "update_xml":["book_view_2.xml","book_view.xml","book_menu.xml"],
    "data" : ["data_view.xml"],
    "active":False,
    "installable":True,
    'css': ['static/src/css/qlhp.css'],
}
