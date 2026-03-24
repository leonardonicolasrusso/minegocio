-- ============================================
-- minegocio.com.ar — Script SQL para Supabase
-- Ejecutar en: Supabase > SQL Editor > New query
-- ============================================

-- ── STORES ──────────────────────────────────
create table if not exists stores (
  id          uuid primary key default gen_random_uuid(),
  created_at  timestamp with time zone default now(),

  -- Datos del negocio
  name        text not null,
  owner       text not null,
  slug        text not null unique,
  description text,
  rubro       text,
  zona        text,
  wa          text not null,
  pagos       text,

  -- Acceso del vendedor
  email       text not null unique,
  password    text not null,

  -- Plan y estado
  plan        text not null default 'basico' check (plan in ('basico','pro')),
  status      text not null default 'trial'  check (status in ('trial','active','blocked')),
  expiry      date not null default (current_date + interval '30 days'),

  -- Métricas
  wa_clicks   integer not null default 0,
  income      integer not null default 0
);

-- ── PRODUCTS ────────────────────────────────
create table if not exists products (
  id          uuid primary key default gen_random_uuid(),
  created_at  timestamp with time zone default now(),

  store_id    uuid not null references stores(id) on delete cascade,
  name        text not null,
  description text,
  price       numeric(10,2) not null default 0,
  photo_url   text,
  active      boolean not null default true,
  position    integer not null default 0
);

-- ── WA_CLICKS ───────────────────────────────
create table if not exists wa_clicks (
  id          uuid primary key default gen_random_uuid(),
  created_at  timestamp with time zone default now(),

  store_id    uuid not null references stores(id) on delete cascade,
  product_id  uuid references products(id) on delete set null,
  type        text default 'consulta' check (type in ('consulta','pedido'))
);

-- ── ÍNDICES ─────────────────────────────────
create index if not exists idx_products_store   on products(store_id);
create index if not exists idx_wa_clicks_store  on wa_clicks(store_id);
create index if not exists idx_stores_slug      on stores(slug);
create index if not exists idx_stores_email     on stores(email);
create index if not exists idx_stores_expiry    on stores(expiry);

-- ── ROW LEVEL SECURITY ──────────────────────
-- Stores: solo lectura pública por slug
alter table stores   enable row level security;
alter table products enable row level security;
alter table wa_clicks enable row level security;

-- Política: cualquiera puede leer una tienda activa por su slug
create policy "tienda publica activa" on stores
  for select using (status in ('active','trial') and expiry >= current_date);

-- Política: cualquiera puede leer productos de tiendas activas
create policy "productos publicos" on products
  for select using (
    active = true and
    exists (
      select 1 from stores s
      where s.id = products.store_id
      and s.status in ('active','trial')
      and s.expiry >= current_date
    )
  );

-- Política: insertar clicks (anónimo puede registrar)
create policy "registrar click" on wa_clicks
  for insert with check (true);

-- Política: el admin puede leer todo (via service role key)
-- Nota: las operaciones del panel admin usan service_role key del lado del servidor

-- ── DATOS DE DEMO (opcional) ─────────────────
-- Descomantá esto para tener datos de prueba

/*
insert into stores (name, owner, slug, description, rubro, zona, wa, pagos, email, password, plan, status, expiry, wa_clicks, income)
values
  ('JAE Accesorios',     'Jorge Acevedo', 'jae-accesorios',     'Controles remotos y cargadores. Envíos a todo el país.', 'Electrónica', 'Rosario, Santa Fe', '3415550001', 'Transferencia, Efectivo', 'jae@demo.com',      '123456', 'basico', 'active', current_date + 18, 47,  3000),
  ('Librería Vitreaux',  'Ana Benítez',   'libreria-vitreaux',  'Todo para la escuela, la oficina y el arte.',            'Librería',    'Rosario Centro',    '3415550002', 'Efectivo, MercadoPago',  'vitreaux@demo.com', '123456', 'pro',    'active', current_date + 25, 132, 5000),
  ('Dietética Natureza', 'Laura Montes',  'dietetica-natureza', 'Productos naturales y saludables.',                      'Dietética',   'Rosario',           '3415550003', 'Efectivo, Transferencia','natureza@demo.com', '123456', 'pro',    'trial',  current_date + 12, 23,  0);
*/

-- ============================================
-- FIN DEL SCRIPT
-- ============================================
