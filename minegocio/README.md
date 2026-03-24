# minegocio.com.ar

Tu negocio online en 5 minutos.

---

## Estructura del proyecto

```
minegocio/
├── public/
│   ├── index.html           → Landing page (minegocio.com.ar)
│   ├── 404.html             → Página de error / tienda bloqueada
│   ├── jae-accesorios.html  → Demo catálogo (Plan Básico)
│   └── libreria-vitreaux.html → Demo tienda (Plan Pro)
├── admin/
│   └── index.html           → Panel Administrador (solo vos)
├── panel/
│   └── index.html           → Panel Tienda (vendedores)
├── vercel.json              → Configuración de rutas
└── supabase-schema.sql      → Script de base de datos
```

---

## URLs una vez publicado

| URL | Qué es |
|-----|--------|
| `minegocio.com.ar` | Landing page pública |
| `minegocio.com.ar/admin` | Panel Administrador |
| `minegocio.com.ar/panel-tienda` | Panel Tienda (vendedores) |
| `minegocio.com.ar/jae-accesorios` | Demo catálogo |
| `minegocio.com.ar/libreria-vitreaux` | Demo tienda |

---

## Credenciales de acceso (demo)

**Panel Administrador**
- Email: `admin@minegocio.com.ar`
- Contraseña: `admin2025`

**Panel Tienda (demo vendedor)**
- Email: `demo@minegocio.com`
- Contraseña: `123456`

---

## Cómo publicar en Vercel

1. Entrá a vercel.com e iniciá sesión
2. Click en "Add New Project"
3. Subí esta carpeta completa (Import > drag & drop o conectá GitHub)
4. Dejá todas las opciones por defecto
5. Click en Deploy
6. Una vez publicado, agregá tu dominio: Settings > Domains > minegocio.com.ar

---

## Base de datos Supabase

- Project URL: https://mbeplryehybxsifkltod.supabase.co
- El schema ya fue ejecutado (tablas: stores, products, wa_clicks)
- Próximo paso: conectar los paneles a Supabase

---

## Próximos pasos

- [ ] Conectar Panel Administrador a Supabase
- [ ] Conectar Panel Tienda a Supabase
- [ ] Conectar tiendas públicas a Supabase (leer productos reales)
- [ ] Configurar dominio minegocio.com.ar en Vercel

---

Creado con Claude · Anthropic
