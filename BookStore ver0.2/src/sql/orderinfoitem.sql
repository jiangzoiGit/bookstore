create table orderinfoitem(
id int primary key auto_increment,
orderid int default null,
bookid int not null,
booknum int not null
);