                            >  #w     #�  �   	  %�    alter table Permission drop constraint FK57F7A1EFC04829CA
alter table Tree drop constraint FK27E7BE28A16313
alter table Assignment drop constraint FKB3FD62ED72AD026F
alter table Assignment drop constraint FKB3FD62EDFC41E6F3
alter table Assignment drop constraint FKB3FD62EDC04829CA
alter table Assignment drop constraint FKB3FD62EDDBC0580E
alter table Assignment drop constraint FKB3FD62ED1D3ED888
alter table Subject drop constraint FKF3E2ED0C89D6221
alter table Category drop constraint FK6DD211EC04829CA
alter table Function_Permission drop constraint FKA507F4962ECB972A
alter table Function_Permission drop constraint FKA507F496FC41E6F3
alter table Function drop constraint FK5629D7F84D477E99
alter table Function drop constraint FK5629D7F8C04829CA
alter table TreeNode drop constraint FK5676FAE0CC680D39
alter table TreeNodeRelationship drop constraint FKF6A57538368D8BE7
alter table TreeNodeRelationship drop constraint FKF6A57538C2003E9D
alter table Subsystem drop constraint FK9758A04FCC680D39

drop table Permission if exists
drop table SubjectType if exists
drop table Tree if exists
drop table Assignment if exists
drop table PrivilegedSubject if exists
drop table TreeType if exists
drop table Subject if exists
drop table Category if exists
drop table Function_Permission if exists
drop table Function if exists
drop table TreeNode if exists
drop table TreeNodeRelationship if exists
drop table Subsystem if exists

create table Permission (
 permissionID varchar(255) not null,
 modifyDateTime timestamp not null,
 subsystemID varchar(255) not null,
 createDateTime timestamp not null,
 createDbAccount varchar(255) not null,
 createUserID varchar(255),
 createContext varchar(255),
 modifyDbAccount varchar(255) not null,
 modifyUserID varchar(255),
 modifyContext varchar(255),
 comment varchar(255),
 primary key (permissionID)
 )
create table SubjectType (
 subjectTypeID varchar(255) not null,
 modifyDateTime timestamp not null,
 adapterClass varchar(255),
 name varchar(255) not null,
 createDateTime timestamp not null,
 createDbAccount varchar(255) not null,
 createUserID varchar(255),
 createContext varchar(255),
 modifyDbAccount varchar(255) not null,
 modifyUserID varchar(255),
 modifyContext varchar(255),
 comment varchar(255),
 primary key (subjectTypeID)
 )
create table Tree (
 treeID varchar(255) not null,
 modifyDateTime timestamp not null,
 treeTypeID varchar(255) not null,
 name varchar(255) not null,
 createDateTime timestamp not null,
 createDbAccount varchar(255) not null,
 createUserID varchar(255),
 createContext varchar(255),
 modifyDbAccount varchar(255) not null,
 modifyUserID varchar(255),
 modifyContext varchar(255),
 comment varchar(255),
 primary key (treeID)
 )
create table Assignment (
 AssignmentID integer generated by default as identity (start with 1),
 modifyDateTime timestamp not null,
 grantorID varchar(255),
 grantorTypeID varchar(255),
 granteeID varchar(255),
 granteeTypeID varchar(255),
 subsystemID varchar(255) not null,
 functionID varchar(255) not null,
 scopeID varchar(255) not null,
 status varchar(255) not null,
 canGrant bit not null,
 grantOnly bit not null,
 createDateTime timestamp not null,
 createDbAccount varchar(255) not null,
 createUserID varchar(255),
 createContext varchar(255),
 modifyDbAccount varchar(255) not null,
 modifyUserID varchar(255),
 modifyContext varchar(255),
 comment varchar(255)
 )
create table PrivilegedSubject (
 subjectID varchar(255) not null,
 subjectTypeID varchar(255) not null,
 modifyDateTime timestamp not null,
 createDateTime timestamp not null,
 createDbAccount varchar(255) not null,
 createUserID varchar(255),
 createContext varchar(255),
 modifyDbAccount varchar(255) not null,
 modifyUserID varchar(255),
 modifyContext varchar(255),
 comment varchar(255),
 primary key (subjectID, subjectTypeID)
 )
create table TreeType (
 treeTypeID varchar(255) not null,
 modifyDateTime timestamp not null,
 adapterClass varchar(255),
 name varchar(255) not null,
 createDateTime timestamp not null,
 createDbAccount varchar(255) not null,
 createUserID varchar(255),
 createContext varchar(255),
 modifyDbAccount varchar(255) not null,
 modifyUserID varchar(255),
 modifyContext varchar(255),
 comment varchar(255),
 primary key (treeTypeID)
 )
create table Subject (
 subjectID varchar(255) not null,
 modifyDateTime timestamp not null,
 subjectTypeID varchar(255) not null,
 name varchar(255) not null,
 description varchar(255),
 displayId varchar(255),
 createDateTime timestamp not null,
 createDbAccount varchar(255) not null,
 createUserID varchar(255),
 createContext varchar(255),
 modifyDbAccount varchar(255) not null,
 modifyUserID varchar(255),
 modifyContext varchar(255),
 comment varchar(255),
 primary key (subjectID)
 )
create table Category (
 categoryID varchar(255) not null,
 modifyDateTime timestamp not null,
 subsystemID varchar(255) not null,
 status varchar(255) not null,
 name varchar(255) not null,
 createDateTime timestamp not null,
 createDbAccount varchar(255) not null,
 createUserID varchar(255),
 createContext varchar(255),
 modifyDbAccount varchar(255) not null,
 modifyUserID varchar(255),
 modifyContext varchar(255),
 comment varchar(255),
 primary key (categoryID)
 )
create table Function_Permission (
 functionID varchar(255) not null,
 permissionID varchar(255) not null,
 primary key (permissionID, functionID)
 )
create table Function (
 functionID varchar(255) not null,
 modifyDateTime timestamp not null,
 subsystemID varchar(255) not null,
 categoryID varchar(255) not null,
 status varchar(255) not null,
 name varchar(255) not null,
 helpText varchar(255) not null,
 createDateTime timestamp not null,
 createDbAccount varchar(255) not null,
 createUserID varchar(255),
 createContext varchar(255),
 modifyDbAccount varchar(255) not null,
 modifyUserID varchar(255),
 modifyContext varchar(255),
 comment varchar(255),
 primary key (functionID)
 )
create table TreeNode (
 nodeID varchar(255) not null,
 modifyDateTime timestamp not null,
 treeID varchar(255) not null,
 status varchar(255) not null,
 name varchar(255) not null,
 type varchar(255),
 createDateTime timestamp not null,
 createDbAccount varchar(255) not null,
 createUserID varchar(255),
 createContext varchar(255),
 modifyDbAccount varchar(255) not null,
 modifyUserID varchar(255),
 modifyContext varchar(255),
 comment varchar(255),
 primary key (nodeID)
 )
create table TreeNodeRelationship (
 nodeID varchar(255) not null,
 parentNodeID varchar(255) not null,
 primary key (parentNodeID, nodeID)
 )
create table Subsystem (
 subsystemID varchar(255) not null,
 modifyDateTime timestamp not null,
 status varchar(255) not null,
 name varchar(255) not null,
 helpText varchar(255) not null,
 treeID varchar(255),
 createDateTime timestamp not null,
 createDbAccount varchar(255) not null,
 createUserID varchar(255),
 createContext varchar(255),
 modifyDbAccount varchar(255) not null,
 modifyUserID varchar(255),
 modifyContext varchar(255),
 comment varchar(255),
 primary key (subsystemID)
 )

alter table Permission add constraint FK57F7A1EFC04829CA foreign key (subsystemID) references Subsystem
alter table Tree add constraint FK27E7BE28A16313 foreign key (treeTypeID) references TreeType
alter table Assignment add constraint FKB3FD62ED72AD026F foreign key (scopeID) references TreeNode
alter table Assignment add constraint FKB3FD62EDFC41E6F3 foreign key (functionID) references Function
alter table Assignment add constraint FKB3FD62EDC04829CA foreign key (subsystemID) references Subsystem
alter table Assignment add constraint FKB3FD62EDDBC0580E foreign key (grantorID, grantorTypeID) references PrivilegedSubject
alter table Assignment add constraint FKB3FD62ED1D3ED888 foreign key (granteeID, granteeTypeID) references PrivilegedSubject
alter table Subject add constraint FKF3E2ED0C89D6221 foreign key (subjectTypeID) references SubjectType
alter table Category add constraint FK6DD211EC04829CA foreign key (subsystemID) references Subsystem
alter table Function_Permission add constraint FKA507F4962ECB972A foreign key (permissionID) references Permission
alter table Function_Permission add constraint FKA507F496FC41E6F3 foreign key (functionID) references Function
alter table Function add constraint FK5629D7F84D477E99 foreign key (categoryID) references Category
alter table Function add constraint FK5629D7F8C04829CA foreign key (subsystemID) references Subsystem
alter table TreeNode add constraint FK5676FAE0CC680D39 foreign key (treeID) references Tree
alter table TreeNodeRelationship add constraint FKF6A57538368D8BE7 foreign key (parentNodeID) references TreeNode
alter table TreeNodeRelationship add constraint FKF6A57538C2003E9D foreign key (nodeID) references TreeNode
alter table Subsystem add constraint FK9758A04FCC680D39 foreign key (treeID) references Tree
     �   �   A                                                                                                                                                                                                                                                   �fo�?�20        ��@��@�              /home/cvs/signet/sql/hsql.sql acohen 1.1 hsql.sql    @Added some blank lines to delineate sections of the ddl. /lmcrae      �   �   A �`    2  ckid   
 �       �DProjector DataTEXTCWIE                        