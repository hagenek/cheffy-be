-- Drop tables
drop TABLE if exists message;
drop TABLE if exists conversation;

drop TABLE if exists recipe_favorite;
drop TABLE if exists ingredient;
drop TABLE if exists step;
drop TABLE if exists recipe;

drop TABLE if exists account;

-- Create schema

CREATE TABLE account (
    uid TEXT not null primary key,
    "name" TEXT,
    picture TEXT,
    unique(uid)
);

CREATE TABLE recipe (
    recipe_id TEXT not null primary key,
    "public" boolean not null,
    prep_time int not null,
    "name" TEXT not null,
    img TEXT,
    favorite_count int check (favorite_count >= 0) default 0,
    uid TEXT not null references account(uid) on delete cascade
);

CREATE TABLE step (
    step_id TEXT not null primary key,
    sort int not null,
    description TEXT not null,
    recipe_id TEXT not null references recipe(recipe_id) on delete cascade
);

CREATE TABLE ingredient (
    ingredient_id TEXT not null primary key,
    sort int not null,
    "name" TEXT not null,
    amount int not null,
    measure TEXT not null,
    recipe_id TEXT not null references recipe(recipe_id) on delete cascade
);

CREATE TABLE conversation (
    conversation_id TEXT not null,
    uid TEXT not null,
    notifications int not null check (notifications >= 0) default 0,
    primary key (conversation_id, uid)
);

CREATE TABLE message (
    message_id TEXT not null primary key,
    message_body TEXT not null,
    uid TEXT not null references account(uid) on delete cascade,
    conversation_id TEXT not null,
    CREATEd_at timestamp not null default now()
);

CREATE TABLE recipe_favorite (
    id serial not null primary key,
    recipe_id TEXT not null references recipe(recipe_id) on delete cascade,
    uid TEXT not null references account(uid) on delete cascade
);