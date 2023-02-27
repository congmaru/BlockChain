create table ETH_INFO
(
    net_url    varchar(100) not null,
    latest_bno varchar(100) null
);

create table transactions
(
    id                int auto_increment
        primary key,
    hash              varchar(256) not null,
    nonce             varchar(100) null,
    block_hash        varchar(256) null,
    block_number      varchar(100) null,
    transaction_index varchar(100) null,
    from_hash         varchar(256) null,
    to_hash           varchar(256) null,
    value             varchar(100) null,
    gas_price         varchar(100) null,
    gas               varchar(100) null,
    input             varchar(300) null,
    creates           varchar(256) null,
    public_key        varchar(256) null,
    raw               varchar(256) null,
    r                 varchar(256) null,
    s                 varchar(256) null,
    v                 int          null,
    stored_at         timestamp    not null
);

create table users
(
    id         int auto_increment
        primary key,
    name       varchar(100) not null,
    email      varchar(100) not null,
    created_at timestamp    not null,
    password   varchar(100) not null
);

create table items
(
    id            int auto_increment
        primary key,
    name          varchar(100)         not null,
    category      varchar(100)         not null,
    explanation   varchar(255)         null,
    available     tinyint(1) default 1 not null,
    seller        int                  not null,
    registered_at timestamp            not null,
    image         varchar(255)         not null,
    constraint items_users__fk
        foreign key (seller) references users (id)
);

create table purchases
(
    id               int auto_increment
        primary key,
    purchase_id      int              not null,
    created_at       timestamp        not null,
    seller_id        int              not null,
    buyer_id         int              not null,
    item_id          int              not null,
    state            char default 'I' not null,
    contract_address varchar(45)      not null,
    constraint purchases_purchase_id_uindex
        unique (purchase_id),
    constraint purchases_items_id_fk
        foreign key (item_id) references items (id),
    constraint purchases_users__fk
        foreign key (buyer_id) references users (id),
    constraint purchases_users_id_fk
        foreign key (seller_id) references users (id)
);

create index purchases_users_id_fk_2
    on purchases (seller_id);

create table wallets
(
    id              int auto_increment
        primary key,
    address         varchar(100)          not null,
    owner_id        int                   not null,
    balance         decimal(25) default 0 null,
    receiving_count int         default 0 null,
    cash            int(10)     default 0 null,
    constraint wallets_users__fk
        foreign key (owner_id) references users (id)
);

