\echo "Loading users fixtures..."

SET client_min_messages TO WARNING;

INSERT INTO public.users
    (
        id,
        username,
        email,
        password_hash
    )
        SELECT
            ('1de9c987-08ab-32fe-e218-89c124cd' || to_char(seq, 'FM0000'))::uuid, -- id
            'username' || to_char(seq, 'FM000') , -- username
            'username ' || to_char(seq, 'FM000') || '@example.com', -- email
            '$2a$11$27s.UnSqrdSGwYSmacQzcOzjgZJFsmAQRY6OhcHTEWA4pmRFxYEWy' -- crypt('password', gen_salt('bf',11)) I don't use crypt function in fixture to speedup it
        FROM
            GENERATE_SERIES(1, 50) seq;

\echo "Users fixtures loaded"
