\echo "Schema creating..."

SET client_min_messages TO WARNING;

CREATE TABLE public.users (
  id                 UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  username           CITEXT NOT NULL UNIQUE,
  email              VARCHAR DEFAULT NULL,
  password_hash      VARCHAR DEFAULT NULL,

  created_at         TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at         TIMESTAMPTZ NOT NULL DEFAULT now()
);

\echo "Schema created"