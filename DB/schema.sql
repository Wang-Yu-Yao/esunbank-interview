create table if not exists user
(
    UserID        int auto_increment
    primary key,
    UserName      varchar(255)                        not null,
    Email         varchar(255)                        not null,
    PasswordHash  varchar(255)                        not null,
    Salt          varchar(255)                        not null,
    CoverImage    varchar(255)                        null,
    Biography     text                                null,
    CreatedAt     timestamp default CURRENT_TIMESTAMP null,
    cover_image   varchar(255)                        null,
    created_at    timestamp default CURRENT_TIMESTAMP not null,
    password_hash varchar(255)                        not null,
    user_name     varchar(255)                        not null,
    constraint Email
    unique (Email)
    );

create table if not exists post
(
    PostID     int auto_increment
    primary key,
    UserID     int                                 not null,
    content    varchar(255)                        not null,
    Image      varchar(255)                        null,
    CreatedAt  timestamp default CURRENT_TIMESTAMP null,
    created_at timestamp default CURRENT_TIMESTAMP not null,
    constraint post_ibfk_1
    foreign key (UserID) references user (UserID)
    on delete cascade
    );

create table if not exists comment
(
    CommentID  int auto_increment
    primary key,
    UserID     int                                 not null,
    PostID     int                                 not null,
    content    varchar(255)                        not null,
    CreatedAt  timestamp default CURRENT_TIMESTAMP null,
    created_at timestamp default CURRENT_TIMESTAMP not null,
    constraint comment_ibfk_1
    foreign key (UserID) references user (UserID)
    on delete cascade,
    constraint comment_ibfk_2
    foreign key (PostID) references post (PostID)
    on delete cascade
    );

create index PostID
    on comment (PostID);

create index UserID
    on comment (UserID);

create index UserID
    on post (UserID);

create table if not exists posts
(
    id         int auto_increment
    primary key,
    content    varchar(255) not null,
    created_at datetime(6)  not null,
    image      varchar(255) null,
    title      varchar(255) not null,
    user_id    int          not null,
    constraint FKam8ar6luvp8afhfu20gfsydo9
    foreign key (user_id) references user (UserID)
    );

