create table userinfo(
id int primary key auto_increment,
username varchar(50) not null,
password varchar(50) not null,
privilege int not null,
balance double
);