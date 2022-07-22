drop table if exists accounts;

create table accounts(
    id serial primary key,
    full_name varchar(20) not null,
    balance dec(10,2) not null
);

insert into accounts (
    full_name, balance
)
values (
    'abc', 1000
),
(
    'def', 2000
);

select * from accounts;

create or replace procedure transaction (
    sender int,
    receiver int,
    amount dec
)
language plpgsql
as $$
begin
    update accounts
    set balance = balance - amount
    where id = sender;

    update accounts
    set balance = balance + amount
    where id = receiver;

    commit;

end;$$;

call transaction(1, 2, 100);


create or replace procedure transaction (
    sender int,
    receiver int,
    amount dec
)
language plpgsql
as $$
begin
    update accounts
    set balance = balance - amount
    where id = sender;

    update accounts
    set balance = balance + amount
    where id = receiver;

    commit;

end;$$;

call transaction(1, 2, 50);
call transaction(2, 1, 50);

select * from accounts;
