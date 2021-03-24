DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'product_condition') THEN
        create type product_condition as enum('NEW', 'REFURBISHED', 'USED', 'OPEN_BOX');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'currency') THEN
        create type currency as enum('USD', 'EUR', 'JPY', 'INR', 'GER', 'CHI');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'product_description_type') THEN
        create type product_description_type as enum('PLAIN_TEXT', 'HTML');
    END IF;
END
$$;

create table if not exists product_category (
    id uuid primary key not null default uuid_generate_v4(),
    name text not null,
    created_at timestamp with time zone not null,
    created_by text,
    updated_at timestamp with time zone not null,
    updated_by text,
);

create table if not exists product_subcategory (
    id uuid primary key not null default uuid_generate_v4(),
    name text not null,
    category_id uuid not null,
    created_at timestamp with time zone not null,
    created_by text,
    updated_at timestamp with time zone not null,
    updated_by text,
    constraint fk_product_subcategory_category_id foreign key (category_id)
    references product_category(id)
    on cascade delete
);

create table if not exists product (
    id uuid primary key not null DEFAULT uuid_generate_v4(),
    name text not null,
    item_number text not null default ,
    category_id uuid,
    subcategory_id uuid,
    brand text,
    model text,
    description text,
    images_dir text,
    condition product_condition,
    price numeric(18, 2),
    currency currency,
    created_at timestamp with time zone not null,
    created_by text,
    updated_at timestamp with time zone not null,
    updated_by text,
    constraint uk_product_item_number unique (item_number)
    constraint fk_product_category_id foreign key (category_id)
    references category(id),
    constraint fk_product_sub_category_id foreign key (sub_category_id)
    references sub_category(id)
);

create table if not exists product_details (
    product_id uuid primary key not null,
    item_specs jsonb not null,
    package_details text[] not null,
    description text,
    description_type product_description_type
);
