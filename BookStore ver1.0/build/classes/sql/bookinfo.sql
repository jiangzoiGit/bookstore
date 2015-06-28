create table bookinfo(
id int primary key auto_increment,
bookname varchar(50) not null,
image varchar(50),
detail varchar(500),
ISBN varchar(20),
booknum int not null,
price double not null,
category varchar(20)
);