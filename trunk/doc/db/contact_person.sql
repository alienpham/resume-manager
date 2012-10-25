create table contact_person
(
   contact_person_id    int unsigned not null auto_increment,
   company_id           int unsigned not null,
   title                enum('Mr.','Mrs.','Ms.') not null,
   full_name            varchar(50) not null,
   job_title            varchar(100) not null,
   tel_1                varchar(30),
   tel_2                varchar(30),
   fax                  varchar(30),
   mobile_1             varchar(30),
   mobile_2             varchar(30),
   email_1              varchar(100),
   email_2              varchar(100),
   address              varchar(150),
   primary key (contact_person_id),
   constraint FK_company_3 foreign key (company_id)
      references company (company_id) on delete cascade on update restrict
);