--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1 (Ubuntu 15.1-1.pgdg20.04+1)
-- Dumped by pg_dump version 17.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: auth; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO supabase_admin;

--
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA extensions;


ALTER SCHEMA extensions OWNER TO postgres;

--
-- Name: pg_cron; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_cron WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_cron; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_cron IS 'Job scheduler for PostgreSQL';


--
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql;


ALTER SCHEMA graphql OWNER TO supabase_admin;

--
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql_public;


ALTER SCHEMA graphql_public OWNER TO supabase_admin;

--
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: pgbouncer
--

CREATE SCHEMA pgbouncer;


ALTER SCHEMA pgbouncer OWNER TO pgbouncer;

--
-- Name: pgsodium; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA pgsodium;


ALTER SCHEMA pgsodium OWNER TO supabase_admin;

--
-- Name: pgsodium; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgsodium WITH SCHEMA pgsodium;


--
-- Name: EXTENSION pgsodium; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgsodium IS 'Pgsodium is a modern cryptography library for Postgres.';


--
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA realtime;


ALTER SCHEMA realtime OWNER TO supabase_admin;

--
-- Name: storage; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA storage;


ALTER SCHEMA storage OWNER TO supabase_admin;

--
-- Name: vault; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA vault;


ALTER SCHEMA vault OWNER TO supabase_admin;

--
-- Name: pg_graphql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_graphql WITH SCHEMA graphql;


--
-- Name: EXTENSION pg_graphql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_graphql IS 'pg_graphql: GraphQL support';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: pgjwt; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgjwt WITH SCHEMA extensions;


--
-- Name: EXTENSION pgjwt; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgjwt IS 'JSON Web Token API for Postgresql';


--
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE auth.aal_level OWNER TO supabase_auth_admin;

--
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


ALTER TYPE auth.code_challenge_method OWNER TO supabase_auth_admin;

--
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE auth.factor_status OWNER TO supabase_auth_admin;

--
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


ALTER TYPE auth.factor_type OWNER TO supabase_auth_admin;

--
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


ALTER TYPE auth.one_time_token_type OWNER TO supabase_auth_admin;

--
-- Name: continents; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.continents AS ENUM (
    'Africa',
    'Antarctica',
    'Asia',
    'Europe',
    'Oceania',
    'North America',
    'South America'
);


ALTER TYPE public.continents OWNER TO postgres;

--
-- Name: game_context; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.game_context AS (
	loc_array_players_id_left bigint[],
	loc_array_players_id_right bigint[],
	loc_array_substitutes_left integer[],
	loc_array_substitutes_right integer[],
	loc_matrix_player_stats_left real[],
	loc_matrix_player_stats_right real[],
	loc_array_team_weights_left real[],
	loc_array_team_weights_right real[],
	loc_period_game integer,
	loc_minute_game integer,
	loc_date_start_period timestamp without time zone
);


ALTER TYPE public.game_context OWNER TO postgres;

--
-- Name: action; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


ALTER TYPE realtime.action OWNER TO supabase_admin;

--
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


ALTER TYPE realtime.equality_op OWNER TO supabase_admin;

--
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);


ALTER TYPE realtime.user_defined_filter OWNER TO supabase_admin;

--
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


ALTER TYPE realtime.wal_column OWNER TO supabase_admin;

--
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


ALTER TYPE realtime.wal_rls OWNER TO supabase_admin;

--
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


ALTER FUNCTION auth.email() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


ALTER FUNCTION auth.jwt() OWNER TO supabase_auth_admin;

--
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


ALTER FUNCTION auth.role() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


ALTER FUNCTION auth.uid() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: postgres
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_cron_access() OWNER TO postgres;

--
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: postgres
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    func_is_graphql_resolve bool;
BEGIN
    func_is_graphql_resolve = (
        SELECT n.proname = 'resolve'
        FROM pg_event_trigger_ddl_commands() AS ev
        LEFT JOIN pg_catalog.pg_proc AS n
        ON ev.objid = n.oid
    );

    IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language sql
        as $$
            select graphql.resolve(
                query := query,
                variables := coalesce(variables, '{}'),
                "operationName" := "operationName",
                extensions := extensions
            );
        $$;

        -- This hook executes when `graphql.resolve` is created. That is not necessarily the last
        -- function in the extension so we need to grant permissions on existing entities AND
        -- update default permissions to any others that are created after `graphql.resolve`
        grant usage on schema graphql to postgres, anon, authenticated, service_role;
        grant select on all tables in schema graphql to postgres, anon, authenticated, service_role;
        grant execute on all functions in schema graphql to postgres, anon, authenticated, service_role;
        grant all on all sequences in schema graphql to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on tables to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on functions to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on sequences to postgres, anon, authenticated, service_role;

        -- Allow postgres role to allow granting usage on graphql and graphql_public schemas to custom roles
        grant usage on schema graphql_public to postgres with grant option;
        grant usage on schema graphql to postgres with grant option;
    END IF;

END;
$_$;


ALTER FUNCTION extensions.grant_pg_graphql_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: postgres
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    IF NOT EXISTS (
      SELECT 1
      FROM pg_roles
      WHERE rolname = 'supabase_functions_admin'
    )
    THEN
      CREATE USER supabase_functions_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION;
    END IF;

    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
    ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

    ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
    ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

    REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
    REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

    GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_net_access() OWNER TO postgres;

--
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: postgres
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_ddl_watch() OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_drop_watch() OWNER TO supabase_admin;

--
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


ALTER FUNCTION extensions.set_graphql_placeholder() OWNER TO supabase_admin;

--
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: postgres
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
    RAISE WARNING 'PgBouncer auth request: %', p_usename;

    RETURN QUERY
    SELECT usename::TEXT, passwd::TEXT FROM pg_catalog.pg_shadow
    WHERE usename = p_usename;
END;
$$;


ALTER FUNCTION pgbouncer.get_auth(p_usename text) OWNER TO postgres;

--
-- Name: calculate_age(bigint, timestamp with time zone, timestamp with time zone); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.calculate_age(inp_multiverse_speed bigint, inp_date_birth timestamp with time zone, inp_date_now timestamp with time zone DEFAULT now()) RETURNS double precision
    LANGUAGE plpgsql
    AS $$

BEGIN

  RETURN EXTRACT(EPOCH FROM (inp_date_now - inp_date_birth)) / (14 * 7 * 24 * 60 * 60 / inp_multiverse_speed::double precision);

END;

$$;


ALTER FUNCTION public.calculate_age(inp_multiverse_speed bigint, inp_date_birth timestamp with time zone, inp_date_now timestamp with time zone) OWNER TO postgres;

--
-- Name: club_create_players(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.club_create_players(inp_id_club bigint) RETURNS void
    LANGUAGE plpgsql
    AS $$

DECLARE

    loc_id_multiverse INT8; -- id of the multiverse

    loc_id_country INT8; -- id of the country

    loc_id_default_teamcomp INT8; -- id of the default teamcomp

    loc_id_player INT8; -- Players id

    array_id_players INT8[21]; -- Array of players id to set in the teamcomp

BEGIN



    -- Get the multiverse and country of the club

    SELECT id_multiverse, id_country INTO loc_id_multiverse, loc_id_country

        FROM clubs WHERE id = inp_id_club;



    ------ Generate the array of players with null values

    array_id_players := array_fill(NULL::bigint, ARRAY[21]);



    ------ Goalkeepers

    -- Main Goalkeeper

    loc_id_player := players_create_player(

        inp_id_multiverse := loc_id_multiverse,

        inp_id_club := inp_id_club,

        inp_id_country := loc_id_country,

        inp_age := 26.5 + 4 * RANDOM(),

        inp_shirt_number := 1,

        inp_notes := 'Experienced GoalKeeper');

    -- Set in the array

    array_id_players[1] := loc_id_player;



    -- Second but younger goalkeeper

    loc_id_player := players_create_player(

        inp_id_multiverse := loc_id_multiverse,

        inp_id_club := inp_id_club,

        inp_id_country := loc_id_country,

        inp_age := 16 + 4 * RANDOM(),

        inp_shirt_number := 12,

        inp_notes := 'Young GoalKeeper');

    -- Set in the array

    array_id_players[12] := loc_id_player;



    ------ Defenders

    -- First (experienced) back winger

    loc_id_player := players_create_player(

        inp_id_multiverse := loc_id_multiverse,

        inp_id_club := inp_id_club,

        inp_id_country := loc_id_country,

        inp_age := 25 + 5 * RANDOM(),

        inp_shirt_number := 2,

        inp_notes := 'Experienced Back Winger');

    -- Set in the array

    array_id_players[2] := loc_id_player;



    -- Second (younger) back winger

    loc_id_player := players_create_player(

        inp_id_multiverse := loc_id_multiverse,

        inp_id_club := inp_id_club,

        inp_id_country := loc_id_country,

        inp_age := 20 + 5 * RANDOM(),

        inp_shirt_number := 3,

        inp_notes := 'Intermediate Age Back Winger');

    -- Set in the array

    array_id_players[3] := loc_id_player;

    

    -- Third (young) back winger

    loc_id_player := players_create_player(

        inp_id_multiverse := loc_id_multiverse,

        inp_id_club := inp_id_club,

        inp_id_country := loc_id_country,

        inp_age := 16 + 4 * RANDOM(),

        inp_shirt_number := 13,

        inp_notes := 'Young Back Winger');

    -- Set in the array

    array_id_players[13] := loc_id_player;



    -- First (experienced) central defender

    loc_id_player := players_create_player(

        inp_id_multiverse := loc_id_multiverse,

        inp_id_club := inp_id_club,

        inp_id_country := loc_id_country,

        inp_age := 25 + 5 * RANDOM(),

        inp_shirt_number := 4,

        inp_notes := 'Experienced Central Back');

    -- Set in the array

    array_id_players[4] := loc_id_player;



    -- Second (younger) central defender

    loc_id_player := players_create_player(

        inp_id_multiverse := loc_id_multiverse,

        inp_id_club := inp_id_club,

        inp_id_country := loc_id_country,

        inp_age := 20 + 5 * RANDOM(),

        inp_shirt_number := 5,

        inp_notes := 'Intermediate Age Central Back');

    -- Set in the array

    array_id_players[5] := loc_id_player;



    -- Third (younger) central defender

    loc_id_player := players_create_player(

        inp_id_multiverse := loc_id_multiverse,

        inp_id_club := inp_id_club,

        inp_id_country := loc_id_country,

        inp_age := 16 + 4 * RANDOM(),

        inp_shirt_number := 14,

        inp_notes := 'Young Central Back');

    -- Set in the array

    array_id_players[14] := loc_id_player;



    ------ Midfielders

    -- First (experienced) midfielder

    loc_id_player := players_create_player(

        inp_id_multiverse := loc_id_multiverse,

        inp_id_club := inp_id_club,

        inp_id_country := loc_id_country,

        inp_age := 25 + 5 * RANDOM(),

        inp_shirt_number := 6,

        inp_notes := 'Experienced Midfielder');

    -- Set in the array

    array_id_players[6] := loc_id_player;



    -- Second (younger) midfielder

    loc_id_player := players_create_player(

        inp_id_multiverse := loc_id_multiverse,

        inp_id_club := inp_id_club,

        inp_id_country := loc_id_country,

        inp_age := 20 + 5 * RANDOM(),

        inp_shirt_number := 10,

        inp_notes := 'Intermediate Age Midfielder');

    -- Set in the array

    array_id_players[10] := loc_id_player;



    -- Third (younger) midfielder

    loc_id_player := players_create_player(

        inp_id_multiverse := loc_id_multiverse,

        inp_id_club := inp_id_club,

        inp_id_country := loc_id_country,

        inp_age := 16 + 4 * RANDOM(),

        inp_shirt_number := 15,

        inp_notes := 'Young Midfielder');

    -- Set in the array

    array_id_players[15] := loc_id_player;



    ------ Wingers

    -- First (experienced) winger

    loc_id_player := players_create_player(

        inp_id_multiverse := loc_id_multiverse,

        inp_id_club := inp_id_club,

        inp_id_country := loc_id_country,

        inp_age := 25 + 5 * RANDOM(),

        inp_shirt_number := 7,

        inp_notes := 'Experienced Winger');

    -- Set in the array

    array_id_players[7] := loc_id_player;



    -- Second (younger) winger

    loc_id_player := players_create_player(

        inp_id_multiverse := loc_id_multiverse,

        inp_id_club := inp_id_club,

        inp_id_country := loc_id_country,

        inp_age := 20 + 5 * RANDOM(),

        inp_shirt_number := 8,

        inp_notes := 'Intermediate Age Winger');

    -- Set in the array

    array_id_players[8] := loc_id_player;



    -- Third (younger) winger

    loc_id_player := players_create_player(

        inp_id_multiverse := loc_id_multiverse,

        inp_id_club := inp_id_club,

        inp_id_country := loc_id_country,

        inp_age := 16 + 4 * RANDOM(),

        inp_shirt_number := 16,

        inp_notes := 'Young Winger');

    -- Set in the array

    array_id_players[16] := loc_id_player;



    ------ Strikers

    -- First (experienced) striker

    loc_id_player := players_create_player(

        inp_id_multiverse := loc_id_multiverse,

        inp_id_club := inp_id_club,

        inp_id_country := loc_id_country,

        inp_age := 25 + 5 * RANDOM(),

        inp_shirt_number := 9,

        inp_notes := 'Experienced Striker');

    -- Set in the array

    array_id_players[9] := loc_id_player;



    -- Second (younger) striker

    loc_id_player := players_create_player(

        inp_id_multiverse := loc_id_multiverse,

        inp_id_club := inp_id_club,

        inp_id_country := loc_id_country,

        inp_age := 20 + 5 * RANDOM(),

        inp_shirt_number := 11,

        inp_notes := 'Intermediate Age Striker');

    -- Set in the array

    array_id_players[11] := loc_id_player;



    -- Third (young) striker

    loc_id_player := players_create_player(

        inp_id_multiverse := loc_id_multiverse,

        inp_id_club := inp_id_club,

        inp_id_country := loc_id_country,

        inp_age := 16 + 4 * RANDOM(),

        inp_shirt_number := 17,

        inp_notes := 'Young Striker');

    -- Set in the array

    array_id_players[17] := loc_id_player;



    ------ Store the array of players in the default teamcomp

    UPDATE games_teamcomp SET 

        description = 'Default Teamcomp',

        idgoalkeeper = array_id_players[1],

        idleftbackwinger = array_id_players[2],

        idleftcentralback = array_id_players[5],

        idcentralback = NULL,

        idrightcentralback = array_id_players[4],

        idrightbackwinger = array_id_players[3],

        idleftwinger = array_id_players[8],

        idleftmidfielder = array_id_players[6],

        idcentralmidfielder = NULL,

        idrightmidfielder = array_id_players[10],

        idrightwinger = array_id_players[7],

        idleftstriker = array_id_players[9],

        idcentralstriker = NULL,

        idrightstriker = array_id_players[11],

        idsub1 = array_id_players[12],

        idsub2 = array_id_players[13],

        idsub3 = array_id_players[14],

        idsub4 = array_id_players[15],

        idsub5 = array_id_players[16],

        idsub6 = array_id_players[17]

    WHERE id_club = inp_id_club

        AND season_number = 0

        AND week_number = 1;



    ------ Store the teamcomp of the young team

    UPDATE games_teamcomp SET

        description = 'Young Team',

        idgoalkeeper = array_id_players[12],

        idleftbackwinger = array_id_players[13],

        idleftcentralback = array_id_players[5],

        idcentralback = NULL,

        idrightcentralback = array_id_players[14],

        idrightbackwinger = array_id_players[3],

        idleftwinger = array_id_players[16],

        idleftmidfielder = array_id_players[15],

        idcentralmidfielder = NULL,

        idrightmidfielder = array_id_players[10],

        idrightwinger = array_id_players[8],

        idleftstriker = array_id_players[17],

        idcentralstriker = NULL,

        idrightstriker = array_id_players[11],

        idsub1 = array_id_players[1],

        idsub2 = array_id_players[2],

        idsub3 = array_id_players[4],

        idsub4 = array_id_players[6],

        idsub5 = array_id_players[7],

        idsub6 = array_id_players[9]

    WHERE id_club = inp_id_club

        AND season_number = 0

        AND week_number = 2;



        ------ Store the array of players in the default teamcomp

    UPDATE games_teamcomp SET 

        description = 'Stronger Left Wing',

        idgoalkeeper = array_id_players[1],

        idleftbackwinger = array_id_players[2],

        idleftcentralback = array_id_players[4],

        idcentralback = NULL,

        idrightcentralback = array_id_players[5],

        idrightbackwinger = array_id_players[3],

        idleftwinger = array_id_players[7],

        idleftmidfielder = array_id_players[6],

        idcentralmidfielder = NULL,

        idrightmidfielder = array_id_players[10],

        idrightwinger = array_id_players[8],

        idleftstriker = array_id_players[9],

        idcentralstriker = NULL,

        idrightstriker = array_id_players[11],

        idsub1 = array_id_players[12],

        idsub2 = array_id_players[13],

        idsub3 = array_id_players[14],

        idsub4 = array_id_players[15],

        idsub5 = array_id_players[16],

        idsub6 = array_id_players[17]

    WHERE id_club = inp_id_club

        AND season_number = 0

        AND week_number = 3;



        ------ Store the array of players in the default teamcomp

    UPDATE games_teamcomp SET 

        description = 'Stronger Right Wing',

        idgoalkeeper = array_id_players[1],

        idleftbackwinger = array_id_players[3],

        idleftcentralback = array_id_players[5],

        idcentralback = NULL,

        idrightcentralback = array_id_players[4],

        idrightbackwinger = array_id_players[2],

        idleftwinger = array_id_players[8],

        idleftmidfielder = array_id_players[10],

        idcentralmidfielder = NULL,

        idrightmidfielder = array_id_players[6],

        idrightwinger = array_id_players[7],

        idleftstriker = array_id_players[11],

        idcentralstriker = NULL,

        idrightstriker = array_id_players[9],

        idsub1 = array_id_players[12],

        idsub2 = array_id_players[13],

        idsub3 = array_id_players[14],

        idsub4 = array_id_players[15],

        idsub5 = array_id_players[16],

        idsub6 = array_id_players[17]

    WHERE id_club = inp_id_club

        AND season_number = 0

        AND week_number = 4;



END;

$$;


ALTER FUNCTION public.club_create_players(inp_id_club bigint) OWNER TO postgres;

--
-- Name: club_handle_new_user_asignement(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.club_handle_new_user_asignement() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$

DECLARE

  teamcomp RECORD;

  league RECORD;

BEGIN



    ------ Check that the club is available

    IF (OLD.username IS NOT NULL) THEN

        RAISE EXCEPTION 'This club already belongs to: %', OLD.username;

    END IF;



    ------ Check that the user can have an additional club

    IF ((SELECT COUNT(*) FROM clubs WHERE username = NEW.username) >

        (SELECT number_clubs_available FROM profiles WHERE username = NEW.username))

    THEN

        RAISE EXCEPTION 'You can not have an additional club assigned to you';

    END IF;



    ------ Set default club if it's the only club

    IF (SELECT COUNT(*) FROM clubs WHERE username = NEW.username) = 0 THEN

        UPDATE profiles SET id_default_club = NEW.id WHERE username = NEW.username;

    END IF;



    ------ Check that it's the last level league of the continent

--    IF (

--        SELECT level FROM leagues WHERE id = NEW.id_league) <>

--        (SELECT max(LEVEL) FROM leagues WHERE continent = NEW.continent AND id_multiverse = NEW.id_multiverse)

--    THEN

--        RAISE EXCEPTION 'You can not assign a user to a league that is not of the last level';

--    END IF;



    -- Log history

    INSERT INTO clubs_history (id_club, description)

    VALUES (NEW.id, 'User {' || NEW.username || '} has been assigned to the club');



    -- Update the club row

    UPDATE clubs SET can_update_name = TRUE, user_since = Now() WHERE id = NEW.id;



    ------ The players of the old club become free players

    -- Log the history of the players

    INSERT INTO players_history (id_player, id_club, description)

        SELECT id, id_club, 'Left ' || string_parser(id_club, 'idClub') || ' because a new owner took control'

        FROM players WHERE id_club = NEW.id;

  

    -- Release the players

    UPDATE players SET

        id_club = NULL,

        date_arrival = NOW(),

        shirt_number = NULL,

        expenses_missed = 0,

        motivation = 60 + random() * 30,

        transfer_price = 100,

        date_bid_end = date_trunc('minute', NOW()) + (INTERVAL '1 week' / (SELECT speed FROM multiverses WHERE id = NEW.id_multiverse))

        WHERE id_club = NEW.id;



    -- Reset the default teamcomps of the club to NULL everywhere

    FOR teamcomp IN

        SELECT * FROM games_teamcomp WHERE id_club = NEW.id AND season_number = 0

    LOOP

        PERFORM teamcomp_copy_previous(inp_id_teamcomp := teamcomp.id, INP_SEASON_NUMBER := - 999);

    END LOOP;



    -- Generate the new team of the club

    PERFORM club_create_players(inp_id_club := NEW.id);



    -- If its the only club of the user set default club

    IF (SELECT id_default_club FROM profiles WHERE username = NEW.username) IS NULL THEN

        UPDATE profiles SET id_default_club = NEW.id WHERE username = NEW.username;

    END IF;



    -- If the league has no more free clubs, generate new lower leagues

    IF ((SELECT count(*)

        FROM clubs

        JOIN leagues ON clubs.id_league = leagues.id

        WHERE clubs.id_multiverse = 1

        AND leagues.continent = NEW.continent

        AND leagues.level = (

            SELECT MAX(level)

            FROM leagues

            WHERE leagues.id_multiverse = NEW.id_multiverse

            )

        AND clubs.username IS NULL) = 0)

    THEN

-- Generate new lower leagues from the current lowest level leagues

        FOR league IN (

            SELECT * FROM leagues WHERE

                id_multiverse = NEW.id_multiverse AND

                level > 0 AND

                id NOT IN (SELECT id_upper_league FROM leagues WHERE id_multiverse = NEW.id_multiverse

                    AND id_upper_league IS NOT NULL))

        LOOP

            PERFORM leagues_create_lower_leagues(

                inp_id_upper_league := league.id, inp_max_level := league.level + 1);

        END LOOP;



        -- Reset the week number of the multiverse to simulate the games

        UPDATE multiverses SET week_number = 1 WHERE id = NEW.id_multiverse;



        -- Handle the season by simulating the games

        PERFORM handle_season_main();

    END IF;



    -- Return the new record to proceed with the update

    RETURN NEW;

END;

$$;


ALTER FUNCTION public.club_handle_new_user_asignement() OWNER TO postgres;

--
-- Name: clubs_create_club(bigint, bigint, public.continents, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.clubs_create_club(inp_id_multiverse bigint, inp_id_league bigint, inp_continent public.continents, inp_number bigint) RETURNS void
    LANGUAGE plpgsql
    AS $$

DECLARE

    loc_id_country INT8; -- id of the country

    loc_id_club INT8; -- id of the newly created club

    loc_id_player INT8; -- Players id

BEGIN



    ------ Fetch a random country from the continent for this club

    SELECT id INTO loc_id_country

    FROM countries

    WHERE continent = inp_continent

    ORDER BY random()

    LIMIT 1;



    ------ INSERT new club

    INSERT INTO clubs (id_multiverse, id_league, id_league_next_season, id_country, continent, pos_league)

        VALUES (inp_id_multiverse, inp_id_league, inp_id_league, loc_id_country, inp_continent, inp_number)

        RETURNING id INTO loc_id_club; -- Get the newly created id for the club



    ------ Generate name of the club

    UPDATE clubs SET name = 'Bot ' || loc_id_club WHERE clubs.id = loc_id_club;



    ------ INSERT Init finance for this new club

    INSERT INTO finances (id_club, amount, description) VALUES (loc_id_club, 250000, 'Club Initialisation');

    ------ INSERT Init fans for this new club

    INSERT INTO fans (id_club, additional_fans, mood) VALUES (loc_id_club, 1000, 60);

    ------ INSERT Init club_history for this new club

    INSERT INTO clubs_history (id_club, description) VALUES (loc_id_club, 'Creation of the club');

    ------ INSERT Init stadium for this new club

    INSERT INTO stadiums (id_club, seats, name) VALUES (loc_id_club, 50, 'Stadium ' || loc_id_club);



    ------ Create the default teamcomps

    INSERT INTO games_teamcomp (id_club, season_number, week_number, name, description) VALUES

        (loc_id_club, 0, 1, 'Default 1', 'Default 1'),

        (loc_id_club, 0, 2, 'Default 2', 'Default 2'),

        (loc_id_club, 0, 3, 'Default 3', 'Default 3'),

        (loc_id_club, 0, 4, 'Default 4', 'Default 4'),

        (loc_id_club, 0, 5, 'Default 5', 'Default 5'),

        (loc_id_club, 0, 6, 'Default 6', 'Default 6'),

        (loc_id_club, 0, 7, 'Default 7', 'Default 7');



    ------------------------------------------------------------------------

    ------------------------------------------------------------------------

    ------------ Create the team players

    PERFORM club_create_players(inp_id_club := loc_id_club);

    

END;

$$;


ALTER FUNCTION public.clubs_create_club(inp_id_multiverse bigint, inp_id_league bigint, inp_continent public.continents, inp_number bigint) OWNER TO postgres;

--
-- Name: handle_new_user(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.handle_new_user() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
begin
    insert into public.profiles(uuid_user, username, email)
    values(new.id, new.raw_user_meta_data->>'username', new.email);

    return new;
end;
$$;


ALTER FUNCTION public.handle_new_user() OWNER TO postgres;

--
-- Name: initialize_leagues_teams_and_players(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.initialize_leagues_teams_and_players() RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    multiverse RECORD; -- Record for the multiverses loop
    game RECORD; -- Record for the game loop
    continent public.continents; -- Continent loop
    max_level_league INT8 := 2; -- Maximum level of the leagues to create
    loc_id_league INT8; -- Temporary variable to store the id of the newly created leagues
BEGIN

    -- Loop throuh all multiverses
    FOR multiverse IN (SELECT * FROM multiverses ORDER BY id) LOOP
    
        -- Create the 6 international leagues
        FOR I IN 1..6 LOOP
            INSERT INTO leagues (id_multiverse, season_number, continent, level, number, name, id_upper_league, cash_last_season)
            VALUES (multiverse.id, multiverse.season_number, NULL, 0, I, 
                CASE
                    WHEN I=1 THEN 'Champions'
                    WHEN I=2 THEN '2nd'
                    WHEN I=3 THEN '3rd'
                    ELSE I || 'th'
                END || ' International Cup',
                NULL, 0);
        END LOOP;
        
        -- Loop through the continents to create the master league of each continent
        FOR continent IN (SELECT unnest FROM unnest(enum_range(NULL::public.continents))
            WHERE unnest != 'Antarctica') LOOP

            loc_id_league := leagues_create_league( -- Function to create new league
                inp_id_multiverse := multiverse.id, -- Id of the multiverse
                inp_season_number := multiverse.season_number, -- Season number
                inp_continent := continent, -- Continent of the league
                inp_level := 1, -- Level of the league
                inp_number := 1, -- Number of the league
                inp_id_upper_league := NULL); -- Id of the upper league

            -- Create its lower leagues until max level reached
            PERFORM leagues_create_lower_leagues( -- Function to create the lower leagues
                inp_id_upper_league := loc_id_league, -- Id of the upper league
                inp_max_level := max_level_league); -- Maximum level of the league to create

        END LOOP; -- End of the loop through continents
        
        -- Generate the games_teamcomp and the games of the season 
        PERFORM main_generate_games_and_teamcomps(
            inp_id_multiverse := multiverse.id,
            inp_season_number := multiverse.season_number,
            inp_date_start := multiverse.date_season_start);

        UPDATE leagues SET is_finished = TRUE WHERE id_multiverse = multiverse.id;
        -- Populate the league games of this season
        FOR game IN (
            SELECT * FROM games
                WHERE id_multiverse = multiverse.id
                AND season_number = multiverse.season_number
                AND week_number <= 10
        ) LOOP

            -- Populate the game with the clubs
            PERFORM main_populate_game(game);

        END LOOP; -- End of the game loop

        UPDATE leagues SET is_finished = NULL WHERE id_multiverse = multiverse.id;

        -- Generate the games_teamcomp and the games of the season 
        PERFORM main_generate_games_and_teamcomps(
            inp_id_multiverse := multiverse.id,
            inp_season_number := multiverse.season_number + 1,
            inp_date_start := multiverse.date_season_end);
        
    END LOOP; -- End of the loop through multiverses

END;
$$;


ALTER FUNCTION public.initialize_leagues_teams_and_players() OWNER TO postgres;

--
-- Name: is_player_in_teamcomp(bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.is_player_in_teamcomp(inp_id_player bigint, inp_id_game bigint) RETURNS boolean
    LANGUAGE plpgsql
    AS $$

BEGIN

    -- Check if the player is present in any of the available positions

    IF EXISTS (

        SELECT 1

        FROM public.games_team_comp

        WHERE id_game = inp_id_game

          AND (idgoalkeeper = inp_id_player 

                OR idleftbackwinger = inp_id_player 

                OR idleftcentralback = inp_id_player 

                OR idcentralback = inp_id_player 

                OR idrightcentralback = inp_id_player 

                OR idrightbackwinger = inp_id_player 

                OR idleftwinger = inp_id_player 

                OR idleftmidfielder = inp_id_player 

                OR idcentralmidfielder = inp_id_player 

                OR idrightmidfielder = inp_id_player 

                OR idrightwinger = inp_id_player 

                OR idleftstriker = inp_id_player 

                OR idcentralstriker = inp_id_player 

                OR idrightstriker = inp_id_player 

                OR idsub1 = inp_id_player 

                OR idsub2 = inp_id_player 

                OR idsub3 = inp_id_player 

                OR idsub4 = inp_id_player 

                OR idsub5 = inp_id_player 

                OR idsub6 = inp_id_player)

    ) THEN

        RETURN TRUE;

    ELSE

        RETURN FALSE;

    END IF;

END;

$$;


ALTER FUNCTION public.is_player_in_teamcomp(inp_id_player bigint, inp_id_game bigint) OWNER TO postgres;

--
-- Name: leagues_create_league(bigint, bigint, public.continents, bigint, bigint, bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.leagues_create_league(inp_id_multiverse bigint, inp_season_number bigint, inp_continent public.continents, inp_level bigint, inp_number bigint, inp_id_upper_league bigint, inp_id_league_to_create bigint DEFAULT NULL::bigint) RETURNS bigint
    LANGUAGE plpgsql
    AS $$

DECLARE

    upper_league RECORD; -- Record for the upper league

    loc_id_league bigint; -- id of the created league

BEGIN



    ------ Insert a new row in the leagues table

    INSERT INTO leagues (id, id_multiverse, season_number, continent, level, number, name, id_upper_league)

    VALUES (COALESCE(inp_id_league_to_create, nextval('leagues_id_seq')), inp_id_multiverse, inp_season_number, inp_continent, inp_level, inp_number, 

        ---- Name of the league

        CASE

            WHEN inp_continent = 'Africa' THEN 'AF'

            WHEN inp_continent = 'North America' THEN 'NA'

            WHEN inp_continent = 'South America' THEN 'SA'

            WHEN inp_continent = 'Asia' THEN 'AS'

            WHEN inp_continent = 'Europe' THEN 'EU'

            WHEN inp_continent = 'Oceania' THEN 'OC'

            ELSE inp_continent || '???'

        END || inp_level || CASE WHEN inp_level = 1 THEN '' ELSE '(' || inp_number || ')' END,

        inp_id_upper_league)

    RETURNING id INTO loc_id_league;



    -- Create the new clubs for this new league

    FOR I IN 1..6 LOOP

        PERFORM clubs_create_club( -- Function to create new club

            inp_id_multiverse := inp_id_multiverse, -- Id of the multiverse

            inp_id_league := loc_id_league, -- Id of the league

            inp_continent := inp_continent, -- Continent of the club

            inp_number := I); -- Number creation

    END LOOP;



    -- Update the multiverse cash printed

    UPDATE multiverses SET

        cash_printed = cash_printed + (SELECT cash_last_season FROM leagues WHERE id = loc_id_league)

        WHERE id = inp_id_multiverse;



    -- Return the id of the newly created league

    RETURN loc_id_league;

END;

$$;


ALTER FUNCTION public.leagues_create_league(inp_id_multiverse bigint, inp_season_number bigint, inp_continent public.continents, inp_level bigint, inp_number bigint, inp_id_upper_league bigint, inp_id_league_to_create bigint) OWNER TO postgres;

--
-- Name: leagues_create_lower_leagues(bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.leagues_create_lower_leagues(inp_id_upper_league bigint, inp_max_level bigint) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    upper_league RECORD; -- Record for the upper league
    loc_id_league INT8; -- Temporary variable to store the id of the newly created leagues
BEGIN

    ------ Fetch the upper league
    SELECT * FROM leagues INTO upper_league WHERE id = inp_id_upper_league;

    ------ If the league is at the maximum level, return
    IF inp_max_level > upper_league.level THEN

    ------ Generate the two lower leagues of the upper league
    -- Create the first lower league
    loc_id_league := leagues_create_league( -- Function to create new league
        inp_id_multiverse := upper_league.id_multiverse, -- Id of the multiverse
        inp_season_number := upper_league.season_number, -- Season number
        inp_continent := upper_league.continent, -- Continent of the league
        inp_level := upper_league.level + 1, -- Level of the league
        inp_number := (2 * upper_league.number - 1), -- Number of the league
        inp_id_upper_league := inp_id_upper_league); -- Id of the upper league

    -- Create its own lower league
    PERFORM leagues_create_lower_leagues( -- Function to create the lower leagues
        inp_id_upper_league := loc_id_league, -- Id of the upper league
        inp_max_level := inp_max_level); -- Maximum level of the league to create
    
    -- Second lower league
    PERFORM leagues_create_league( -- Function to create new league
        inp_id_multiverse := upper_league.id_multiverse, -- Id of the multiverse
        inp_season_number := upper_league.season_number, -- Season number
        inp_continent := upper_league.continent, -- Continent of the league
        inp_level := upper_league.level + 1, -- Level of the league
        inp_number := (2 * upper_league.number - 1) + 1, -- Number of the league
        inp_id_upper_league := inp_id_upper_league, -- Id of the upper league
        inp_id_league_to_create := - loc_id_league); -- Id of the league (opposite of the one created before)

    -- Create its own lower league
    PERFORM leagues_create_lower_leagues( -- Function to create the lower leagues
        inp_id_upper_league := - loc_id_league, -- Id of the upper league
        inp_max_level := inp_max_level); -- Maximum level of the league to create

    ------ Update the upper_league to store the main lower_league id (the other league is the opposite id)
    UPDATE leagues SET
        id_lower_league = loc_id_league
    WHERE id = inp_id_upper_league;

    END IF;

END;
$$;


ALTER FUNCTION public.leagues_create_lower_leagues(inp_id_upper_league bigint, inp_max_level bigint) OWNER TO postgres;

--
-- Name: main(boolean); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.main(IN is_cron boolean DEFAULT false)
    LANGUAGE plpgsql
    AS $$

DECLARE

    multiverse RECORD; -- Record for the multiverses loop

    loc_time_of_next_handling INTERVAL; -- Variable to store the time of the next handling

BEGIN



    IF is_cron IS TRUE THEN

        -- RAISE EXCEPTION '************ KILL THE CRON !!!';

    END IF;



    -- Acquire a SHARE lock on the multiverses table to allow reads but prevent writes

    LOCK TABLE multiverses IN SHARE MODE;



    ------------------------------------------------------------------------------------------------------------------------------------------------

    ------------------------------------------------------------------------------------------------------------------------------------------------

    ------ Loop through all multiverses

    FOR multiverse IN (

        SELECT * FROM multiverses ORDER BY id)

    LOOP

        -- Start a new transaction for each multiverse

        -- BEGIN

            ------ Loop while the current date is before the next handling date

            LOOP

                ------ Refresh the multiverse record to get the updated week_number and date_handling

                SELECT *,

                    date_season_start + (INTERVAL '24 hours' * (7 * (week_number - 1) + day_number) / speed)

                        AS date_handling

                INTO multiverse

                FROM multiverses

                WHERE id = multiverse.id;



                ------ Calculate the time of the next handling of the multiverse

                loc_time_of_next_handling := multiverse.date_handling - now();



                ------ If it's in the future, exit the loop and wait for the next handling

                IF loc_time_of_next_handling > INTERVAL '0 seconds' THEN

                    RAISE NOTICE '****** MAIN: %: S%W%D%: date_handling= % (NOW()=%) NO ==> %', multiverse.name, multiverse.season_number, multiverse.week_number, multiverse.day_number, multiverse.date_handling, now(), loc_time_of_next_handling;

                    EXIT;

                ELSE

                    RAISE NOTICE '****** MAIN: %: S%W%D%: date_handling= % (NOW()=%) YES ==> %', multiverse.name, multiverse.season_number, multiverse.week_number, multiverse.day_number, multiverse.date_handling, now(), loc_time_of_next_handling;

                END IF;



                ------ Handle the transfers

                PERFORM transfers_handle_transfers(

                    inp_multiverse := multiverse

                );



                ------ Check if we can pass to the next day

                IF main_simulate_day(inp_multiverse := multiverse) = FALSE THEN

                    EXIT;

                END IF;



                IF multiverse.day_number = 7 THEN

    

                    ------ Handle the clubs (weekly finances etc...)

                    PERFORM main_handle_clubs(multiverse);



                    ------ Handle the players (stats increase etc...)

                    PERFORM main_handle_players(multiverse);



                    ------ Handle season (promotions, relegations etc...)

                    PERFORM main_handle_season(multiverse);

                END IF;



                RAISE NOTICE '**** MAIN: Multiverse [%] S%W%D%: Incrementing to next day for handling', multiverse.name, multiverse.season_number, multiverse.week_number, multiverse.day_number;

                ------ Update the week number of the multiverse

                UPDATE multiverses SET

                    day_number = CASE

                        WHEN day_number = 7 THEN 1

                        ELSE day_number + 1

                        END,

                    week_number = CASE

                        WHEN day_number = 7 THEN week_number + 1

                        ELSE week_number

                        END

                WHERE id = multiverse.id;



                ------ Avoid handling more than a full week in one run

                IF multiverse.day_number = 1 THEN

                    EXIT;

                END IF;

            END LOOP; -- End of the LOOP



            ------ Handle the transfers

            PERFORM transfers_handle_transfers(

                inp_multiverse := multiverse

            );



            ------ Store the last run date of the multiverse

            UPDATE multiverses SET

                last_run = now(),

                error = NULL

            WHERE id = multiverse.id;



            -- IF multiverse.id = 2 THEN

            --     RAISE NOTICE 'STOP THE SECOND MULTIVERSE';

            --     RAISE EXCEPTION 'STOP THE SECOND MULTIVERSE';

            -- END IF;



        -- EXCEPTION



        --     WHEN OTHERS THEN

        --         -- Rollback the transaction in case of an error

        --         ROLLBACK;

        --         RAISE NOTICE 'Error processing multiverse %: %', multiverse.id, SQLERRM;



        --         -- Raise exception when not in cron mode

        --         IF is_cron IS FALSE THEN

        --             RAISE EXCEPTION 'Error processing multiverse %: %', multiverse.id, SQLERRM;

        --         END IF;



        --         -- Store the error message in the multiverse record

        --         UPDATE multiverses SET

        --             error = SQLERRM

        --         WHERE id = multiverse.id;

        -- END;

        ------ Commit the transaction for the current multiverse

        COMMIT;

    END LOOP; -- End of the loop through the multiverses



    RAISE NOTICE '************ END MAIN !!!';

    -- RAISE EXCEPTION '************ END MAIN !!!';

END;

$$;


ALTER PROCEDURE public.main(IN is_cron boolean) OWNER TO postgres;

--
-- Name: main_generate_games_and_teamcomps(bigint, bigint, timestamp with time zone); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.main_generate_games_and_teamcomps(inp_id_multiverse bigint, inp_season_number bigint, inp_date_start timestamp with time zone) RETURNS void
    LANGUAGE plpgsql
    AS $$

DECLARE

    multiverse RECORD; -- Record for multiverse loop

    league RECORD; -- Record for league loop

    club RECORD; -- Record for club loop

    loc_interval_1_week INTERVAL; -- Date interval between games

    loc_id_game_1 bigint; -- Id of the game

    loc_id_game_2 bigint; -- Id of the game

    loc_id_game_3 bigint; -- Id of the game

    loc_id_game_4 bigint; -- Id of the game

    loc_id_game_transverse bigint := NULL; -- Id of the game used to make friendly game between winners of first barrage 1 between brother leagues 

BEGIN



    -- Loop through the multiverses

    FOR multiverse IN

        (SELECT * FROM multiverses WHERE id = inp_id_multiverse)

    LOOP



        -- Calculate the date interval for 1 week depending on the multiverse speed

        loc_interval_1_week := INTERVAL '7 days' / multiverse.speed; -- Date interval between games

    

------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------

------------ Loop through the normal leagues of the multiverse

        FOR league IN

            (SELECT * FROM leagues

            WHERE id_multiverse = multiverse.id

            ORDER BY continent, level)

        LOOP



            -- Loop through the clubs of the league

            FOR club IN

                (SELECT * FROM clubs WHERE id_league = league.id ORDER BY pos_league)

            LOOP



                -- Loop through the 14 weeks of the season

                FOR J IN 1..14 LOOP



                    -- Insert the games_teamcomp for the club for the 10 weeks of the season

                    INSERT INTO games_teamcomp (id_club, week_number, season_number, name, description)

                    VALUES (club.id, J, inp_season_number, 'S' || inp_season_number || 'G' || J, 'Season ' || inp_season_number || ' Game ' || J);



                END LOOP; -- End of the loop for the weeks of the season

            END LOOP; -- End of the club loop



------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------

------------ Create the championship games for the weeks 1 to 10

            IF league.level > 0 THEN



                INSERT INTO games (

id_multiverse, id_league, season_number, week_number, date_start, is_league, pos_club_left, pos_club_right, id_league_club_left, id_league_club_right, id_games_description) VALUES

            -- Week 1 and 10

(multiverse.id, league.id, inp_season_number, 1, inp_date_start, TRUE, 1, 2, league.id, league.id, 1),

(multiverse.id, league.id, inp_season_number, 1, inp_date_start, TRUE, 4, 3, league.id, league.id, 1),

(multiverse.id, league.id, inp_season_number, 1, inp_date_start, TRUE, 5, 6, league.id, league.id, 1),

(multiverse.id, league.id, inp_season_number, 10, inp_date_start + loc_interval_1_week * 9, TRUE, 2, 1, league.id, league.id, 10),

(multiverse.id, league.id, inp_season_number, 10, inp_date_start + loc_interval_1_week * 9, TRUE, 3, 4, league.id, league.id, 10),

(multiverse.id, league.id, inp_season_number, 10, inp_date_start + loc_interval_1_week * 9, TRUE, 6, 5, league.id, league.id, 10),

            -- Week 2 and 9

(multiverse.id, league.id, inp_season_number, 2, inp_date_start + loc_interval_1_week, TRUE, 3, 1, league.id, league.id, 2),

(multiverse.id, league.id, inp_season_number, 2, inp_date_start + loc_interval_1_week, TRUE, 2, 5, league.id, league.id, 2),

(multiverse.id, league.id, inp_season_number, 2, inp_date_start + loc_interval_1_week, TRUE, 6, 4, league.id, league.id, 2),

(multiverse.id, league.id, inp_season_number, 9, inp_date_start + loc_interval_1_week * 8, TRUE, 1, 3, league.id, league.id, 9),

(multiverse.id, league.id, inp_season_number, 9, inp_date_start + loc_interval_1_week * 8, TRUE, 5, 2, league.id, league.id, 9),

(multiverse.id, league.id, inp_season_number, 9, inp_date_start + loc_interval_1_week * 8, TRUE, 4, 6, league.id, league.id, 9),

            -- Week 3 and 8

(multiverse.id, league.id, inp_season_number, 3, inp_date_start + loc_interval_1_week * 2, TRUE, 1, 5, league.id, league.id, 3),

(multiverse.id, league.id, inp_season_number, 3, inp_date_start + loc_interval_1_week * 2, TRUE, 3, 6, league.id, league.id, 3),

(multiverse.id, league.id, inp_season_number, 3, inp_date_start + loc_interval_1_week * 2, TRUE, 4, 2, league.id, league.id, 3),

(multiverse.id, league.id, inp_season_number, 8, inp_date_start + loc_interval_1_week * 7, TRUE, 5, 1, league.id, league.id, 8),

(multiverse.id, league.id, inp_season_number, 8, inp_date_start + loc_interval_1_week * 7, TRUE, 6, 3, league.id, league.id, 8),

(multiverse.id, league.id, inp_season_number, 8, inp_date_start + loc_interval_1_week * 7, TRUE, 2, 4, league.id, league.id, 8),

            -- Week 4 and 7

(multiverse.id, league.id, inp_season_number, 4, inp_date_start + loc_interval_1_week * 3, TRUE, 6, 1, league.id, league.id, 4),

(multiverse.id, league.id, inp_season_number, 4, inp_date_start + loc_interval_1_week * 3, TRUE, 5, 4, league.id, league.id, 4),

(multiverse.id, league.id, inp_season_number, 4, inp_date_start + loc_interval_1_week * 3, TRUE, 2, 3, league.id, league.id, 4),

(multiverse.id, league.id, inp_season_number, 7, inp_date_start + loc_interval_1_week * 6, TRUE, 1, 6, league.id, league.id, 7),

(multiverse.id, league.id, inp_season_number, 7, inp_date_start + loc_interval_1_week * 6, TRUE, 4, 5, league.id, league.id, 7),

(multiverse.id, league.id, inp_season_number, 7, inp_date_start + loc_interval_1_week * 6, TRUE, 3, 2, league.id, league.id, 7),

            -- Week 5 and 6

(multiverse.id, league.id, inp_season_number, 5, inp_date_start + loc_interval_1_week * 4, TRUE, 1, 4, league.id, league.id, 5),

(multiverse.id, league.id, inp_season_number, 5, inp_date_start + loc_interval_1_week * 4, TRUE, 6, 2, league.id, league.id, 5),

(multiverse.id, league.id, inp_season_number, 5, inp_date_start + loc_interval_1_week * 4, TRUE, 5, 3, league.id, league.id, 5),

(multiverse.id, league.id, inp_season_number, 6, inp_date_start + loc_interval_1_week * 5, TRUE, 4, 1, league.id, league.id, 6),

(multiverse.id, league.id, inp_season_number, 6, inp_date_start + loc_interval_1_week * 5, TRUE, 2, 6, league.id, league.id, 6),

(multiverse.id, league.id, inp_season_number, 6, inp_date_start + loc_interval_1_week * 5, TRUE, 3, 5, league.id, league.id, 6);



            END IF; -- End of the creation of the championship games



------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------

------------ Create the games for week 11 to 14

            -- Create the international league games for the internation leagues

            IF league.level = 0 THEN -- International leagues

                

                -- 3 international league cups for 1st, 2nd and 3rd of top level leagues

                IF league.number <= 3 THEN



                    -- Schedule the international league cup games

                    INSERT INTO games (

id_multiverse, id_league, season_number, week_number, date_start, is_league, is_home_game, pos_club_left, pos_club_right, id_league_club_left, id_league_club_right, id_games_description) VALUES

            -- Week 11 (First Round)

(multiverse.id, league.id, inp_season_number, 11, inp_date_start + loc_interval_1_week * 10, TRUE, TRUE, 1, 4, league.id, league.id, 11),

(multiverse.id, league.id, inp_season_number, 11, inp_date_start + loc_interval_1_week * 10, TRUE, TRUE, 2, 5, league.id, league.id, 11),

(multiverse.id, league.id, inp_season_number, 11, inp_date_start + loc_interval_1_week * 10, TRUE, TRUE, 3, 6, league.id, league.id, 11),

            -- Week 12 (Second Round)

(multiverse.id, league.id, inp_season_number, 12, inp_date_start + loc_interval_1_week * 11, TRUE, TRUE, 1, 5, league.id, league.id, 12),

(multiverse.id, league.id, inp_season_number, 12, inp_date_start + loc_interval_1_week * 11, TRUE, TRUE, 2, 6, league.id, league.id, 12),

(multiverse.id, league.id, inp_season_number, 12, inp_date_start + loc_interval_1_week * 11, TRUE, TRUE, 3, 4, league.id, league.id, 12),

            -- Week 13 (Third Round)

(multiverse.id, league.id, inp_season_number, 13, inp_date_start + loc_interval_1_week * 12, TRUE, TRUE, 1, 6, league.id, league.id, 13),

(multiverse.id, league.id, inp_season_number, 13, inp_date_start + loc_interval_1_week * 12, TRUE, TRUE, 2, 4, league.id, league.id, 13),

(multiverse.id, league.id, inp_season_number, 13, inp_date_start + loc_interval_1_week * 12, TRUE, TRUE, 3, 5, league.id, league.id, 13),

            -- Week 14 (Cup round)

(multiverse.id, league.id, inp_season_number, 14, inp_date_start + loc_interval_1_week * 13, TRUE, FALSE, 1, 2, league.id, league.id, 14),

(multiverse.id, league.id, inp_season_number, 14, inp_date_start + loc_interval_1_week * 13, TRUE, FALSE, 3, 4, league.id, league.id, 15),

(multiverse.id, league.id, inp_season_number, 14, inp_date_start + loc_interval_1_week * 13, TRUE, FALSE, 5, 6, league.id, league.id, 16);



                -- Friendly games (week11 and 12) between 4th, 5th and 6th of top level leagues while waiting for barrages

                ELSE

                    

                    -- 3*2 international friendly games between 4th, 5th and 6th of master leagues for week 11 and 12

                    INSERT INTO games (

id_multiverse, id_league, season_number, week_number, date_start, is_friendly, is_cup, pos_club_left, pos_club_right, id_league_club_left, id_league_club_right, id_games_description) VALUES

(multiverse.id, league.id, inp_season_number, 11, inp_date_start + loc_interval_1_week * 10, TRUE, TRUE, 6, 1, league.id, league.id, 151),

(multiverse.id, league.id, inp_season_number, 12, inp_date_start + loc_interval_1_week * 11, TRUE, TRUE, 1, 5, league.id, league.id, 161),

(multiverse.id, league.id, inp_season_number, 11, inp_date_start + loc_interval_1_week * 10, TRUE, TRUE, 5, 2, league.id, league.id, 152),

(multiverse.id, league.id, inp_season_number, 12, inp_date_start + loc_interval_1_week * 11, TRUE, TRUE, 2, 4, league.id, league.id, 162),

(multiverse.id, league.id, inp_season_number, 11, inp_date_start + loc_interval_1_week * 10, TRUE, TRUE, 4, 3, league.id, league.id, 153),

(multiverse.id, league.id, inp_season_number, 12, inp_date_start + loc_interval_1_week * 11, TRUE, TRUE, 3, 6, league.id, league.id, 163);



                END IF;



------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------

------------ Create the barrages games for the normal leagues

            ELSE IF league.id < 0 THEN -- Select only the left leagues



            -- {1, 2} are the champions of the lower leagues league.id and -league.id 

            -- {3, 4} are the 2nd of the lower leagues league.id and -league.id 

            -- {5, 6} are the 2nd of the lower leagues league.id and -league.id



            ---- 4th, 5th and 6th Friendly Games for Week11 and 12

            -- Friendly games between 4th, 5th, 6th of this league and 4th, 5th, 6th of symmetric league for two first weeks (not for first level leagues because they already play friendly international)

                IF league.level >= 2 THEN



                    INSERT INTO games (

id_multiverse, id_league, season_number, week_number, date_start, is_friendly, is_cup, pos_club_left, pos_club_right, id_league_club_left, id_league_club_right, id_games_description) VALUES

(multiverse.id, league.id_upper_league, inp_season_number, 11, inp_date_start + loc_interval_1_week * 10, TRUE, TRUE, 4, 4, league.id, -league.id, 171),

(multiverse.id, league.id_upper_league, inp_season_number, 12, inp_date_start + loc_interval_1_week * 11, TRUE, TRUE, 4, 4, -league.id, league.id, 181),

(multiverse.id, league.id_upper_league, inp_season_number, 11, inp_date_start + loc_interval_1_week * 10, TRUE, TRUE, 5, 5, league.id, -league.id, 172),

(multiverse.id, league.id_upper_league, inp_season_number, 12, inp_date_start + loc_interval_1_week * 11, TRUE, TRUE, 5, 5, -league.id, league.id, 182),

(multiverse.id, league.id_upper_league, inp_season_number, 11, inp_date_start + loc_interval_1_week * 10, TRUE, TRUE, 6, 6, league.id, -league.id, 173),

(multiverse.id, league.id_upper_league, inp_season_number, 12, inp_date_start + loc_interval_1_week * 11, TRUE, TRUE, 6, 6, -league.id, league.id, 183);

                

                END IF;



                ---- Barrage1

                -- Week 11 and 12: Games between both 1st of the lower leagues ==> Winner goes up, Loser plays barrage against 5th of upper league

                INSERT INTO games (

id_multiverse, id_league, season_number, week_number, date_start, is_relegation, pos_club_left, pos_club_right, id_league_club_left, id_league_club_right, id_games_description) VALUES

(multiverse.id, league.id_upper_league, inp_season_number, 11, inp_date_start + loc_interval_1_week * 10, TRUE, 1, 1, league.id, -league.id, 211)

RETURNING id INTO loc_id_game_1;

                INSERT INTO games (

id_multiverse, id_league, season_number, week_number, date_start, is_relegation, is_cup, pos_club_left, pos_club_right, id_league_club_left, id_league_club_right, is_return_game_id_game_first_round, id_games_description) VALUES

(multiverse.id, league.id_upper_league, inp_season_number, 12, inp_date_start + loc_interval_1_week * 11, TRUE, TRUE, 1, 1, -league.id, league.id, loc_id_game_1, 212)

RETURNING id INTO loc_id_game_1;

                -- Week 13 and 14: Friendly game between winner of the barrage 1 and winner of the barrage 1 from the symmetric league

                IF loc_id_game_transverse IS NULL THEN

                    -- Store the game id for the next winner of the barrage 1 from league that will play friendly game against the winner of this league barrage 1  

                    loc_id_game_transverse := loc_id_game_1;

                ELSE

                    -- Then we can insert the game between two winners of barrage 1

                    INSERT INTO games (

id_multiverse, id_league, season_number, week_number, date_start, is_friendly, pos_club_left, pos_club_right, id_game_club_left, id_game_club_right, id_games_description) VALUES

(multiverse.id, league.id_upper_league, inp_season_number, 13, inp_date_start + loc_interval_1_week * 12, TRUE, 1, 1, loc_id_game_1, loc_id_game_transverse, 215)

RETURNING id INTO loc_id_game_2;

                    INSERT INTO games (

id_multiverse, id_league, season_number, week_number, date_start, is_friendly, is_cup, pos_club_left, pos_club_right, id_game_club_left, id_game_club_right, is_return_game_id_game_first_round, id_games_description) VALUES

(multiverse.id, league.id_upper_league, inp_season_number, 14, inp_date_start + loc_interval_1_week * 13, TRUE, TRUE, 1, 1, loc_id_game_transverse, loc_id_game_1, loc_id_game_2, 216);

                    -- Reset to NULL for next leagues

                    loc_id_game_transverse := NULL;

                END IF;



                -- Week 13 and 14: Relegation Game Between 5th of the upper league and Loser of the barrage1

                INSERT INTO games (

id_multiverse, id_league, season_number, week_number, date_start, is_relegation, pos_club_left, pos_club_right, id_game_club_left, id_league_club_right, id_games_description) VALUES

(multiverse.id, league.id_upper_league, inp_season_number, 13, inp_date_start + loc_interval_1_week * 12, TRUE, 2, 5, loc_id_game_1, league.id_upper_league, 213)

RETURNING id INTO loc_id_game_2;

                INSERT INTO games (

id_multiverse, id_league, season_number, week_number, date_start, is_relegation, is_cup, pos_club_left, pos_club_right, id_league_club_left, id_game_club_right, is_return_game_id_game_first_round, id_games_description) VALUES

(multiverse.id, league.id_upper_league, inp_season_number, 14, inp_date_start + loc_interval_1_week * 13, TRUE, TRUE, 5, 2, league.id_upper_league, loc_id_game_1, loc_id_game_2, 214);

            

                ---- Barrage2

                -- Week 11

                -- Game1: Barrage between 2nd and 3rd {2nd of left league vs 3rd of right league}

                INSERT INTO games (

id_multiverse, id_league, season_number, week_number, date_start, is_relegation, is_cup, pos_club_left, pos_club_right, id_league_club_left, id_league_club_right, id_games_description) VALUES

(multiverse.id, league.id_upper_league, inp_season_number, 11, inp_date_start + loc_interval_1_week * 10, TRUE, TRUE, 2, 3, league.id, -league.id, 311)

RETURNING id INTO loc_id_game_3;

                -- Game2: Barrage between 2nd and 3rd {2nd of right league vs 3rd of left league}

                INSERT INTO games (

id_multiverse, id_league, season_number, week_number, date_start, is_relegation, is_cup, pos_club_left, pos_club_right, id_league_club_left, id_league_club_right, id_games_description) VALUES

(multiverse.id, league.id_upper_league, inp_season_number, 11, inp_date_start + loc_interval_1_week * 10, TRUE, TRUE, 2, 3, -league.id, league.id, 312)

RETURNING id INTO loc_id_game_4;

                -- Week12

                -- Game1: Barrage between winners of the first round {Winner of loc_id_game_1 vs Winner of loc_id_game_2} => Winner plays barrage and loser plays friendly

                INSERT INTO games (

id_multiverse, id_league, season_number, week_number, date_start, is_relegation, is_cup, pos_club_left, pos_club_right, id_game_club_left, id_game_club_right, id_games_description) VALUES

(multiverse.id, league.id_upper_league, inp_season_number, 12, inp_date_start + loc_interval_1_week * 11, TRUE, TRUE, 1, 1, loc_id_game_3, loc_id_game_4, 321)

RETURNING id INTO loc_id_game_1;

                -- Game2: Friendly between losers of first round {Loser of loc_id_game_1 vs Loser of loc_id_game_2} => Winner plays international friendly game and loser plays friendly

                INSERT INTO games (

id_multiverse, id_league, season_number, week_number, date_start, is_friendly, is_cup, pos_club_left, pos_club_right, id_game_club_left, id_game_club_right, id_games_description) VALUES

(multiverse.id, league.id_upper_league, inp_season_number, 12, inp_date_start + loc_interval_1_week * 11, TRUE, TRUE, 2, 2, loc_id_game_3, loc_id_game_4, 322)

RETURNING id INTO loc_id_game_2;

                ------ Week 13 and 14

                -- Relegation between 4th of master league and Winner of the barrage2

                INSERT INTO games (

id_multiverse, id_league, season_number, week_number, date_start, is_relegation, pos_club_left, pos_club_right, id_league_club_left, id_game_club_right, id_games_description) VALUES

(multiverse.id, league.id_upper_league, inp_season_number, 13, inp_date_start + loc_interval_1_week * 12, TRUE, 4, 1, league.id_upper_league, loc_id_game_1, 331)

RETURNING id INTO loc_id_game_3;

                INSERT INTO games (

id_multiverse, id_league, season_number, week_number, date_start, is_relegation, is_cup, pos_club_left, pos_club_right, id_game_club_left, id_league_club_right, is_return_game_id_game_first_round, id_games_description) VALUES

(multiverse.id, league.id_upper_league, inp_season_number, 14, inp_date_start + loc_interval_1_week * 13, TRUE, TRUE, 1, 4, loc_id_game_1, league.id_upper_league, loc_id_game_3, 332);

                ------ Week 13

                -- Friendly game between loser of second round of barrage 2 and winner of friendly game between losers of the first round of the barrage 2

                INSERT INTO games (

id_multiverse, id_league, season_number, week_number, date_start, is_friendly, is_cup, pos_club_left, pos_club_right, id_game_club_left, id_game_club_right, id_games_description) VALUES

(multiverse.id, league.id_upper_league, inp_season_number, 13, inp_date_start + loc_interval_1_week * 12, TRUE, TRUE, 2, 2, loc_id_game_1, loc_id_game_2, 341)

RETURNING id INTO loc_id_game_3;

                -- Friendly game between winner of friendly game between losers of first round of barrage 2 and 6th club from the upper league (that is going down)

                INSERT INTO games (

id_multiverse, id_league, season_number, week_number, date_start, is_friendly, is_cup, pos_club_left, pos_club_right, id_game_club_left, id_league_club_right, id_games_description) VALUES

(multiverse.id, league.id_upper_league, inp_season_number, 13, inp_date_start + loc_interval_1_week * 12, TRUE, TRUE, 1, 6, loc_id_game_2, league.id_upper_league, 342)

RETURNING id INTO loc_id_game_4;

                ------ Week 14

                -- Friendly Game between winners of last two friendly games loc_id_game_3 and loc_id_game_4

                INSERT INTO games (

id_multiverse, id_league, season_number, week_number, date_start, is_friendly, is_cup, pos_club_left, pos_club_right, id_game_club_left, id_game_club_right, id_games_description) VALUES

(multiverse.id, league.id_upper_league, inp_season_number, 14, inp_date_start + loc_interval_1_week * 13, TRUE, TRUE, 1, 1, loc_id_game_3, loc_id_game_4, 351);

                -- Friendly Game between losers of last two friendly games loc_id_game_3 and loc_id_game_4

                INSERT INTO games (

id_multiverse, id_league, season_number, week_number, date_start, is_friendly, is_cup, pos_club_left, pos_club_right, id_game_club_left, id_game_club_right, id_games_description) VALUES

(multiverse.id, league.id_upper_league, inp_season_number, 14, inp_date_start + loc_interval_1_week * 13, TRUE, TRUE, 2, 2, loc_id_game_3, loc_id_game_4, 352);





------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------

------------ Create the friendly games for the clubs 4th, 5th and 6th for the last level leagues

                IF league.id_lower_league IS NULL THEN

                    -- Friendly Games between clubs of symmetric last level leagues

                    INSERT INTO games (

id_multiverse, id_league, season_number, week_number, date_start, is_friendly, is_cup, pos_club_left, pos_club_right, id_league_club_left, id_league_club_right, id_games_description) VALUES

(multiverse.id, league.id_upper_league, inp_season_number, 13, inp_date_start + loc_interval_1_week * 12, TRUE, TRUE, 4, 5, league.id, -league.id, 431),

(multiverse.id, league.id_upper_league, inp_season_number, 13, inp_date_start + loc_interval_1_week * 12, TRUE, TRUE, 5, 6, league.id, -league.id, 432),

(multiverse.id, league.id_upper_league, inp_season_number, 13, inp_date_start + loc_interval_1_week * 12, TRUE, TRUE, 6, 4, league.id, -league.id, 433),

(multiverse.id, league.id_upper_league, inp_season_number, 14, inp_date_start + loc_interval_1_week * 13, TRUE, TRUE, 4, 5, -league.id, league.id, 441),

(multiverse.id, league.id_upper_league, inp_season_number, 14, inp_date_start + loc_interval_1_week * 13, TRUE, TRUE, 5, 6, -league.id, league.id, 442),

(multiverse.id, league.id_upper_league, inp_season_number, 14, inp_date_start + loc_interval_1_week * 13, TRUE, TRUE, 6, 4, -league.id, league.id, 443);



                END IF; -- End of the friendly games for the last level leagues

            END IF; -- End of the leagues with id < 0

        END IF; -- End of the games for week 11 to 14



        -- Set the boolean to false to say games generation is ok and avoid running the loop again

        UPDATE leagues SET is_finished = FALSE WHERE id = league.id;



        END LOOP; -- End of the league loop

    END LOOP; -- End of the multiverse loop



END;

$$;


ALTER FUNCTION public.main_generate_games_and_teamcomps(inp_id_multiverse bigint, inp_season_number bigint, inp_date_start timestamp with time zone) OWNER TO postgres;

--
-- Name: main_handle_clubs(record); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.main_handle_clubs(inp_multiverse record) RETURNS void
    LANGUAGE plpgsql
    AS $$

DECLARE

    club RECORD; -- Record for the clubs loop

    loc_id_player bigint; -- Variable to store the player's id

BEGIN



    ------ Store the clubs' revenues and expenses in the history_weekly table

    INSERT INTO public.clubs_history_weekly (

        id_club, season_number, week_number,

        number_fans, staff_weight, scouts_weight,

        cash, revenues_sponsors, revenues_transfers_done, revenues_total,

        expenses_staff_applied, expenses_players, expenses_scouts_applied, expenses_tax, expenses_transfers_done, expenses_total,

        league_points, pos_league, league_goals_for, league_goals_against,

        elo_points, expenses_players_ratio_target, expenses_players_ratio,

        expenses_staff_target, expenses_scouts_target

    )

    SELECT

        id, inp_multiverse.season_number, inp_multiverse.week_number,

        number_fans, staff_weight, scouts_weight,

        cash, revenues_sponsors, revenues_transfers_done, revenues_total,

        expenses_staff_applied, expenses_players, expenses_scouts_applied, expenses_tax, expenses_transfers_done, expenses_total,

        league_points, pos_league, league_goals_for, league_goals_against,

        elo_points, expenses_players_ratio_target, expenses_players_ratio,

        expenses_staff_target, expenses_scouts_target

    FROM clubs

    WHERE id_multiverse = inp_multiverse.id;



    WITH clubs_finances AS (

        SELECT

            clubs.id AS id_club, -- Club's id

            clubs.cash, -- Club's cash

            -- Staff expenses applied this week

            CASE

                WHEN clubs.cash >= 3 * clubs.expenses_staff_target THEN clubs.expenses_staff_target

                ELSE 0

            END AS expenses_staff_applied,

            -- Scouting network expenses applied this week

            CASE

                WHEN clubs.cash >= 3 * clubs.expenses_scouts_target THEN clubs.expenses_scouts_target

                ELSE 0

            END AS expenses_scouts_applied,

            -- Players expenses ratio applied this week

            CASE

                WHEN clubs.cash > 0 THEN expenses_players_ratio_target

                ELSE 0

            END AS expenses_players_ratio_applied,

            -- Total expenses missed for the players

            SUM(LEAST(players.expenses_missed, players.expenses_expected)) AS total_expenses_missed_to_pay

        FROM clubs

        LEFT JOIN players ON players.id_club = clubs.id

        WHERE clubs.id_multiverse = inp_multiverse.id

        GROUP BY clubs.id

    ),

    -- Update players' expenses

    player_expenses AS (

        UPDATE players SET

        expenses_payed = CEIL(expenses_expected * clubs_finances.expenses_players_ratio_applied)

            + CASE

                WHEN clubs_finances.cash > 3 * clubs_finances.total_expenses_missed_to_pay THEN

                    LEAST(expenses_missed, expenses_expected)

                ELSE 0

            END

    FROM clubs_finances

    WHERE players.id_club = clubs_finances.id_club),

    ------ Insert messages for clubs that paid missed expenses

    message_debt_payed AS (

        INSERT INTO messages_mail (id_club_to, sender_role, title, message)

    SELECT 

        id_club AS id_club_to, 'Treasurer' AS sender_role,

        --inp_multiverse.date_handling + INTERVAL '1 second' * EXTRACT(SECOND FROM CURRENT_TIMESTAMP) + INTERVAL '1 millisecond' * EXTRACT(MILLISECOND FROM CURRENT_TIMESTAMP),

        clubs_finances.total_expenses_missed_to_pay || 'Missed Expenses Paid' AS title,

        'The previous missed expenses (' || clubs_finances.total_expenses_missed_to_pay || ') have been paid for week ' || inp_multiverse.week_number || '. The club now has available cash: ' || cash || '.' AS message

    FROM clubs_finances

    WHERE cash > 3 * total_expenses_missed_to_pay

    AND total_expenses_missed_to_pay > 0)

    -- Update clubs' finances based on calculations

    UPDATE clubs SET

        expenses_staff_applied = clubs_finances.expenses_staff_applied,

        expenses_scouts_applied = clubs_finances.expenses_scouts_applied,

        expenses_players_ratio = clubs_finances.expenses_players_ratio_applied

    FROM clubs_finances

    WHERE clubs.id = clubs_finances.id_club;



    ------ Send mail for clubs that are in debt

    INSERT INTO messages_mail (id_club_to, sender_role, title, message)

        SELECT 

            id AS id_club_to, 'Treasurer' AS sender_role,

            'Negative Cash: Staff, Souts and Players not paid' AS title,

            'The club is in debt (available cash: ' || cash || ') for week ' || inp_multiverse.week_number || ': The staff, scouts and players will not be paid this week because the club is in debt, rectify the situation quickly !' AS message

        FROM 

            clubs

        WHERE 

            id_multiverse = inp_multiverse.id

            AND cash < 0;



    ------ Update the clubs finances

    UPDATE clubs SET

        -- Tax is 1% of the available cash

        expenses_tax = GREATEST(0, FLOOR(cash * 0.05)),

        -- Players expenses are the expected expenses of the players * the ratio applied by the club

        expenses_players = COALESCE((SELECT SUM(expenses_payed)

            FROM players 

            WHERE id_club = clubs.id), 0),

        -- Update the staff weight of the club 

        staff_weight = LEAST(5000, GREATEST(0.1, 

            (staff_weight + expenses_staff_applied) * 0.5)),

        -- Update the scouting network weight

        -- scouts_weight = LEAST(5000, GREATEST(0.1, 

        --     (scouts_weight + expenses_scouts_applied) * 0.5))

        scouts_weight = FLOOR(scouts_weight * 0.99) + expenses_scouts_applied

    WHERE id_multiverse = inp_multiverse.id;



    -- Update the clubs revenues and expenses in the list

    UPDATE clubs SET

        revenues_total = revenues_sponsors

            + revenues_transfers_done,

        expenses_total = expenses_tax +

            expenses_players +

            expenses_staff_applied +

            expenses_scouts_applied +

            expenses_transfers_done

    WHERE id_multiverse = inp_multiverse.id;



    ------ Update the club's cash

    UPDATE clubs SET

        cash = cash + revenues_total - expenses_total

        -- We need to handle the revenues and expenses that were already paid in the cash

            - revenues_transfers_done + expenses_transfers_done,

        revenues_transfers_done = 0,

        expenses_transfers_done = 0

    WHERE id_multiverse = inp_multiverse.id;



    ------ Update the leagues cash by paying club expenses and players salaries and cash last season

    UPDATE leagues SET

        cash = cash + (

            SELECT COALESCE(SUM(expenses_total), 0)

            FROM clubs WHERE id_league = leagues.id),

        cash_last_season = cash_last_season - (

            SELECT COALESCE(SUM(revenues_sponsors), 0)

            FROM clubs WHERE id_league = leagues.id)

    WHERE id_multiverse = inp_multiverse.id

    AND level > 0;

    

    ------ Handle clubs that have less then 11 players

    FOR club IN

        (SELECT

            clubs.id,

            clubs.id_multiverse,

            clubs.name,

            clubs.id_country,

            clubs.continent,

            COUNT(players.id) AS player_count,

            11 - COUNT(players.id) AS missing_players,

            15 + 5 * RANDOM() AS player_age

        FROM clubs

        LEFT JOIN players ON players.id_club = clubs.id

        WHERE clubs.id_multiverse = inp_multiverse.id

        AND clubs.username IS NULL -- Only for bot clubs

        GROUP BY clubs.id, clubs.name, clubs.id_country, clubs.continent

        HAVING COUNT(players.id) < 11)

    LOOP



        -- Create the missing players

        loc_id_player := players_create_player(

            inp_id_multiverse := club.id_multiverse,

            inp_id_club := club.id,

            inp_id_country := club.id_country,

            inp_age := club.player_age,

            inp_stats := ARRAY[

                0 + POWER(RANDOM(), 3) * club.player_age, -- keeper

                0 + RANDOM() * club.player_age, -- defense

                0 + RANDOM() * club.player_age, -- passes

                0 + RANDOM() * club.player_age, -- playmaking

                0 + RANDOM() * club.player_age, -- winger

                0 + RANDOM() * club.player_age, -- scoring

                0 + POWER(RANDOM(), 3) * club.player_age], -- freekick

            inp_notes := 'New Player'

        );



        -- Store in the club history

        INSERT INTO clubs_history

            (id_club, description)

        VALUES (

            club.id,

            string_parser(club.id, 'idClub') || ' joined the squad because of a lack of players'

        );



    END LOOP;



END;

$$;


ALTER FUNCTION public.main_handle_clubs(inp_multiverse record) OWNER TO postgres;

--
-- Name: main_handle_players(record); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.main_handle_players(inp_multiverse record) RETURNS void
    LANGUAGE plpgsql
    AS $$

DECLARE

    rec_player RECORD; -- Record for the player selection

BEGIN



    ------ Store player's stats in the history

    INSERT INTO players_history_stats

        (created_at, id_player, performance_score,

        expenses_payed, expenses_expected, expenses_missed,

        keeper, defense, passes, playmaking, winger, scoring, freekick,

        motivation, form, stamina, energy, experience, training_points_used)

    SELECT

        inp_multiverse.date_handling, id, performance_score,

        expenses_payed, expenses_expected, expenses_missed,

        keeper, defense, passes, playmaking, winger, scoring, freekick,

        motivation, form, stamina, energy, experience, training_points_used

    FROM players

    WHERE id_multiverse = inp_multiverse.id;



    ------ Update the players expenses_missed

    UPDATE players SET

        expenses_missed = CASE

            WHEN id_club IS NULL THEN 0

            ELSE GREATEST(

                0,

                expenses_missed - expenses_payed + expenses_expected)

        END

    WHERE id_multiverse = inp_multiverse.id;



    ------ Update players motivation, form and stamina

    UPDATE players SET

        motivation = LEAST(100, GREATEST(0,

            motivation + (random() * 20 - 8) -- Random [-8, +12]

            + ((70 - motivation) / 10) -- +7; -3 based on value

            - ((expenses_missed / expenses_expected) ^ 0.5) * 10

            -- Lower motivation based on age for bot clubs from 30 years old

            - CASE WHEN id_club IS NULL OR (SELECT username FROM clubs WHERE id = id_club) IS NOT NULL THEN 0

                ELSE GREATEST(0, calculate_age(inp_multiverse.speed, date_birth, inp_multiverse.date_handling) - 30) * RANDOM() END)

        ),

        form = LEAST(100, GREATEST(0,

            form + (random() * 20 - 10) + ((70 - form) / 10)

            )), -- Random [-10, +10] AND [+7; -3] based on value AND clamped between 0 and 100

        stamina = LEAST(100, GREATEST(0,

            stamina + (random() * 20 - 10) + ((70 - stamina) / 10)

            )), -- Random [-10, +10] AND [+7; -3] based on value AND clamped between 0 and 100

        experience = experience + 0.025

    WHERE id_multiverse = inp_multiverse.id;



    ------ If player's motivation is too low, risk of leaving club

    FOR rec_player IN (

        SELECT *, player_get_full_name(id) AS full_name FROM players

            WHERE id_multiverse = inp_multiverse.id

            AND id_club IS NOT NULL

            AND date_bid_end IS NULL

            AND motivation < 20

    ) LOOP

    

        -- If motivation = 0 ==> 100% chance of leaving, if motivation = 20 ==> 0% chance of leaving

        IF random() < (20 - rec_player.motivation) / 20 THEN

        

            -- Set date_bid_end for the demotivated players

            UPDATE players SET

                date_bid_end = inp_multiverse.date_handling + (INTERVAL '6 days' / inp_multiverse.speed),

                transfer_price = - 100

            WHERE id = rec_player.id;



            -- Create a new mail warning saying that the player is leaving club

            INSERT INTO messages_mail (

                id_club_to, sender_role, title, message)

            VALUES

                (rec_player.id_club, 'Treasurer',

                string_parser(rec_player.id, 'idPlayer') || ' asked to leave the club !',

                string_parser(rec_player.id, 'idPlayer') || ' will be leaving the club before next week because of low motivation: ' || rec_player.motivation || '.');



--RAISE NOTICE '==> RageQuit => % (%) has asked to leave club [%]', rec_player.full_name, rec_player.id, rec_player.id_club;



        ELSE



            -- Create a new mail warning saying that the player is at risk leaving club

            INSERT INTO messages_mail (

                id_club_to, sender_role, title, message)

            VALUES

                (rec_player.id_club, 'Coach',

                string_parser(rec_player.id, 'idPlayer') || ' has low motivation: ' || ROUND(rec_player.motivation::numeric, 1),

                string_parser(rec_player.id, 'idPlayer') || ' has low motivation: ' || ROUND(rec_player.motivation::numeric, 1) || ' and is at risk of leaving your club');



        END IF;

    END LOOP;



    ------ Update players stats based on training points

    WITH player_data AS (

        SELECT 

            players.id, -- Player's id

            --calculate_age(multiverses.speed, players.date_birth) AS age, -- Player's age

            (25 - calculate_age(multiverses.speed, players.date_birth, inp_multiverse.date_handling))/10 AS coef_age, -- Player's age

            training_points_available, -- Initial training points

            training_coef, -- Array of coef for each stat

            (COALESCE(clubs.staff_weight, 1000) / 5000) ^ 0.3 AS staff_coef, -- Value between 0 and 1 [0 => 0, 5000 => 1]

            training_coef[1]+training_coef[2]+training_coef[3]+training_coef[4]+training_coef[5]+training_coef[6]+training_coef[7] AS sum_training_coef

        FROM players

        LEFT JOIN clubs ON clubs.id = players.id_club

        LEFT JOIN multiverses ON multiverses.id = players.id_multiverse

        WHERE players.id_multiverse = inp_multiverse.id

    ), player_data2 AS (

        SELECT 

            player_data.*,

            training_points_available +

                3 * (0.25 + 0.75 * staff_coef) + -- The more staff_coeff, the closer to 1

                5 * coef_age

            --0

            AS updated_training_points_available, -- Updated training points based on age and staff weight

            ARRAY(

                SELECT (1 - staff_coef) + CASE WHEN sum_training_coef = 0 THEN 1.0 ELSE coef / sum_training_coef::float END

                FROM UNNEST(training_coef) AS coef

            ) AS updated_training_coef -- Updated training_coef ARRAY

        FROM player_data

    ), player_data3 AS (

        SELECT 

            player_data2.*,

            (SELECT SUM(value) FROM UNNEST(updated_training_coef) AS value) AS total_sum

        FROM player_data2

    ), final_data AS (

        SELECT 

            player_data3.*,

            ARRAY(

                SELECT updated_training_points_available * value / total_sum

                FROM UNNEST(updated_training_coef) AS value

            ) AS normalized_training_coef

        FROM player_data3

    )

    UPDATE players SET

        keeper = GREATEST(0,

            keeper + 

            CASE WHEN normalized_training_coef[1] > 0 THEN

                normalized_training_coef[1] * (1 - (keeper / 100))

            ELSE normalized_training_coef[1] END),

        defense = GREATEST(0,

            defense + 

            CASE WHEN normalized_training_coef[2] > 0 THEN

                normalized_training_coef[2] * (1 - (defense / 100))

            ELSE normalized_training_coef[2] END),

        passes = GREATEST(0,

            passes + 

            CASE WHEN normalized_training_coef[3] > 0 THEN

                normalized_training_coef[3] * (1 - (passes / 100))

            ELSE normalized_training_coef[3] END),

        playmaking = GREATEST(0,

            playmaking + 

            CASE WHEN normalized_training_coef[4] > 0 THEN

                normalized_training_coef[4] * (1 - (playmaking / 100))

            ELSE normalized_training_coef[4] END),

        winger = GREATEST(0,

            winger + 

            CASE WHEN normalized_training_coef[5] > 0 THEN

                normalized_training_coef[5] * (1 - (winger / 100))

            ELSE normalized_training_coef[5] END),

        scoring = GREATEST(0,

            scoring + 

            CASE WHEN normalized_training_coef[6] > 0 THEN

                normalized_training_coef[6] * (1 - (scoring / 100))

            ELSE normalized_training_coef[6] END),

        freekick = GREATEST(0,

            freekick + 

            CASE WHEN normalized_training_coef[7] > 0 THEN

                normalized_training_coef[7] * (1 - (freekick / 100))

            ELSE normalized_training_coef[7] END),

        training_points_available = 0,

        training_points_used = training_points_used + updated_training_points_available

    FROM final_data

    WHERE players.id = final_data.id;



    ------ Calculate player performance score

    UPDATE players

    SET performance_score = players_calculate_player_best_weight(

        ARRAY[keeper, defense, playmaking, passes, scoring, freekick, winger,

        motivation, form, experience, energy, stamina]

    )

    WHERE id_multiverse = inp_multiverse.id;



END;

$$;


ALTER FUNCTION public.main_handle_players(inp_multiverse record) OWNER TO postgres;

--
-- Name: main_handle_season(record); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.main_handle_season(inp_multiverse record) RETURNS void
    LANGUAGE plpgsql
    AS $$

DECLARE

    loc_record RECORD; -- Record for the game loop

    loc_id_player bigint; -- Variable to store the inserted player's ID

BEGIN



    ------------------------------------------------------------------------

    ------------------------------------------------------------------------

    ------------ Handle the weeks of the season

    CASE

        ---- Handle the 10th week of the season

        WHEN inp_multiverse.week_number = 10 THEN

RAISE NOTICE '*** MAIN: Multiverse [%] S%W%D%: HANDLE SEASON: WEEK10', inp_multiverse.name, inp_multiverse.season_number, inp_multiverse.week_number, inp_multiverse.day_number;

            -- Update the normal leagues to say that they are finished

            UPDATE leagues SET is_finished = TRUE

            WHERE id_multiverse = inp_multiverse.id

            AND level > 0;



            -- Update each club by default staying at their position

            UPDATE clubs SET

                pos_league_next_season = pos_league,

                id_league_next_season = id_league,

                pos_last_season = pos_league

            WHERE id_multiverse = inp_multiverse.id;



            ------ Send mail to each club indicating their position in the league

            WITH club_league_info AS (

                SELECT 

                    clubs.id,

                    clubs.id_multiverse,

                    clubs.continent,

                    clubs.id_country,

                    clubs.id_league,

                    leagues.season_number,

                    leagues.id_upper_league,

                    leagues.id_lower_league,

                    -- Calculate overall points

                    (10000000 - (leagues.level * 100000)) + ((7 - clubs.pos_league) * 10000) + (clubs.league_points * 1000) + clubs.league_goals_for - clubs.league_goals_against AS overall_points,

                    leagues.level,

                    clubs.pos_league,

                    clubs.league_points,

                    clubs.league_goals_for - clubs.league_goals_against AS goal_diff,

                    -- Calculate overall ranking

                    ROW_NUMBER() OVER (ORDER BY (10000000 - (leagues.level * 100000)) + ((7 - clubs.pos_league) * 10000) + (clubs.league_points * 1000) + clubs.league_goals_for - clubs.league_goals_against DESC) AS overall_ranking

                FROM clubs

                JOIN leagues ON leagues.id = clubs.id_league

                WHERE clubs.id_multiverse = inp_multiverse.id

                ORDER BY overall_points DESC

            )

            -- Send mail to each club indicating their position in the league

            INSERT INTO messages_mail (id_club_to, sender_role, title, message)

            SELECT 

                id AS id_club_to, 'Coach' AS sender_role,

                -- inp_multiverse.date_handling + INTERVAL '1 second' * EXTRACT(SECOND FROM CURRENT_TIMESTAMP) + INTERVAL '1 millisecond' * EXTRACT(MILLISECOND FROM CURRENT_TIMESTAMP),

                'Finished ' || 

                CASE 

                    WHEN pos_league = 1 THEN '1st'

                    WHEN pos_league = 2 THEN '2nd'

                    WHEN pos_league = 3 THEN '3rd'

                    ELSE pos_league || 'th'

                END

                || ' of ' || string_parser(id_league, 'idLeague') || ' in season ' || inp_multiverse.season_number AS title,

                CASE

                    -- 1st place

                    WHEN pos_league = 1 THEN

                        -- Highest league plays international games

                        CASE WHEN id_upper_league IS NULL THEN

                            'We are the champions of ' || string_parser(id_league, 'idLeague') || ' for season ' || inp_multiverse.season_number || ' ! We will play the 1st international league during the interseason ! That''s fantastic !'

                        -- Other leagues play barrages to win promotion

                        ELSE

                            'We are the champions of ' || string_parser(id_league, 'idLeague') || ' for season ' || inp_multiverse.season_number || ' ! We will play the 1st barrage to try and win our promotion to the upper league ! Let''s do it !'

                        END

                    WHEN pos_league = 2 THEN

                        -- Highest league plays international games

                        CASE WHEN id_upper_league IS NULL THEN

                            'We finished 2nd of ' || string_parser(id_league, 'idLeague') || ' for season ' || inp_multiverse.season_number || ' ! We will play the 2nd international league during the interseason ! That''s fantastic !'

                        -- Other leagues play barrages to win promotion

                        ELSE

                            'We finished 2nd of ' || string_parser(id_league, 'idLeague') || ' for season ' || inp_multiverse.season_number || ' ! We will play the 2nd barrage to try and win our promotion to the upper league ! Let''s do it !'

                        END

                    WHEN pos_league = 3 THEN

                        -- Highest league plays international games

                        CASE WHEN id_upper_league IS NULL THEN

                            'We finished 3rd of ' || string_parser(id_league, 'idLeague') || ' for season ' || inp_multiverse.season_number || ' ! We will play the 3rd international league during the interseason ! That''s fantastic !'

                        -- Other leagues play barrages to win promotion

                        ELSE

                            'We finished 3rd of ' || string_parser(id_league, 'idLeague') || ' for season ' || inp_multiverse.season_number || ' ! We will play the 2nd barrage to try and win our promotion to the upper league ! Let''s do it !'

                        END

                    WHEN pos_league = 4 THEN

                        -- Lowest league plays friendly games during interseason

                        CASE WHEN id_lower_league IS NULL THEN

                            'We finished 4th of ' || string_parser(id_league, 'idLeague') || ' for season ' || inp_multiverse.season_number || ' ! We will play some friendly games during the interseason ! It''s a good opportunity to test new tactics for the next season !'

                        -- Other leagues play barrages to avoid relegation

                        ELSE

                            'We finished 4th of ' || string_parser(id_league, 'idLeague') || ' for season ' || inp_multiverse.season_number || ' ! We will play against the winner of the 2nd barrage in order to avoid demotion ! The season is not over yet, keep the players focused !'

                        END

                    WHEN pos_league = 5 THEN

                        -- Lowest league plays friendly games during interseason

                        CASE WHEN id_lower_league IS NULL THEN

                            'We finished 5th of ' || string_parser(id_league, 'idLeague') || ' for season ' || inp_multiverse.season_number || ' ! We will play some friendly games during the interseason ! It''s a good opportunity to test new tactics for the next season !'

                        -- Other leagues play barrages to avoid relegation

                        ELSE

                            'We finished 5th of ' || string_parser(id_league, 'idLeague') || ' for season ' || inp_multiverse.season_number || ' ! We will play against the team from the 1st barrage in order to avoid demotion ! The season is not over yet, keep the players focused !'

                        END

                    WHEN pos_league = 6 THEN

                        -- Lowest league plays friendly games during interseason

                        CASE WHEN id_lower_league IS NULL THEN

                            'Rough season... We finished last of ' || string_parser(id_league, 'idLeague') || ' for season ' || inp_multiverse.season_number || ' ! We will play some friendly games during the interseason ! It''s a good opportunity to test new tactics for the next season !'

                        -- Other leagues play barrages to avoid relegation

                        ELSE

                            'Rough season... We finished last of ' || string_parser(id_league, 'idLeague') || ' for season ' || inp_multiverse.season_number || ' ! We will be demoted to the lower league... But don''t give up, we will come back stronger next season !'

                        END

                END AS message

            FROM club_league_info;



            ------ Insert into clubs_history table

            INSERT INTO clubs_history (id_club, description)

            SELECT

                clubs.id AS id_club,

                'Season ' || inp_multiverse.season_number || 'Finished ' ||

                CASE

                    WHEN pos_league = 1 THEN '1st'

                    WHEN pos_league = 2 THEN '2nd'

                    WHEN pos_league = 3 THEN '3rd'

                    ELSE pos_league || 'th'

                END

                || ' of ' || string_parser(leagues.id, 'idLeague') || ' of ' || leagues.continent AS description

            FROM clubs

            JOIN leagues ON clubs.id_league = leagues.id

            WHERE clubs.id_multiverse = inp_multiverse.id;



            -- Insert into players_history table

            INSERT INTO players_history (id_player, id_club, description, is_ranking_description)

            SELECT

                players.id AS id_player, players.id_club AS id_club,

                'Season ' || inp_multiverse.season_number || ': ' || 

                CASE

                    WHEN clubs.pos_league = 1 THEN 'Champions'

                    WHEN clubs.pos_league = 2 THEN '2nd'

                    WHEN clubs.pos_league = 3 THEN '3rd'

                    WHEN clubs.pos_league = 4 THEN '4th'

                    WHEN clubs.pos_league = 5 THEN '5th'

                    WHEN clubs.pos_league = 6 THEN '6th'

                END

                || ' of ' || string_parser(clubs.id_league, 'idLeague') || '

                with ' || string_parser(clubs.id, 'idClub') || ' in ' || clubs.continent AS description,

                TRUE AS is_ranking_description

            FROM players

            JOIN clubs ON players.id_club = clubs.id

            JOIN leagues ON leagues.id = clubs.id_league

            WHERE clubs.id_multiverse = inp_multiverse.id

            AND id_club IS NOT NULL;



        ---- Handle the 13th week of the season ==> Intercontinental Cup Leagues are finished

        WHEN inp_multiverse.week_number = 13 THEN

RAISE NOTICE '*** MAIN: Multiverse [%] S%W%D%: HANDLE SEASON: WEEK13', inp_multiverse.name, inp_multiverse.season_number, inp_multiverse.week_number, inp_multiverse.day_number;

            -- Update the special leagues to say that they are finished

            UPDATE leagues SET is_finished = TRUE

            WHERE id_multiverse = inp_multiverse.id AND level = 0;



        ---- Handle the 14th week of the season ==> Season is over, start a new one

        WHEN inp_multiverse.week_number = 14 THEN

RAISE NOTICE '*** MAIN: Multiverse [%] S%W%D%: HANDLE SEASON: WEEK14', inp_multiverse.name, inp_multiverse.season_number, inp_multiverse.week_number, inp_multiverse.day_number;



            -- Generate the games_teamcomp and the games of the next season

            PERFORM main_generate_games_and_teamcomps(

                inp_id_multiverse := inp_multiverse.id,

                inp_season_number := inp_multiverse.season_number + 2,

                inp_date_start := inp_multiverse.date_season_end + (14 * INTERVAL '7 days' / inp_multiverse.speed)

            );



            -- Update multiverses table for starting next season

            UPDATE multiverses SET

                date_season_start = date_season_end,

                date_season_end = date_season_end + (14 * INTERVAL '7 days' / inp_multiverse.speed),

                season_number = season_number + 1,

                week_number = 0

            WHERE id = inp_multiverse.id;



            -- Update leagues

            UPDATE leagues SET

                season_number = season_number + 1,

                is_finished = NULL,

                cash_last_season = (cash / 1400) * 1400,

                cash = cash - (cash / 1400) * 1400

            WHERE id_multiverse = inp_multiverse.id;



            -- Update clubs

            UPDATE clubs SET

                season_number = season_number + 1,

                id_league = id_league_next_season,

                -- id_league_next_season = NULL,

                revenues_sponsors_last_season = revenues_sponsors,

                revenues_sponsors = (SELECT cash_last_season FROM leagues WHERE id = id_league) * 

                    CASE 

                        WHEN pos_league = 1 THEN 0.20

                        WHEN pos_league = 2 THEN 0.18

                        WHEN pos_league = 3 THEN 0.17

                        WHEN pos_league = 4 THEN 0.16

                        WHEN pos_league = 5 THEN 0.15

                        WHEN pos_league = 6 THEN 0.14

                        ELSE 0

                    END

                / 14,

                pos_league = pos_league_next_season,

                pos_league_next_season = NULL,

                league_points = 0,

                league_goals_for = 0,

                league_goals_against = 0

            WHERE id_multiverse = inp_multiverse.id;



            -- Ensure there are always 6 clubs per league

            FOR loc_record IN (

                SELECT leagues.id AS league_id, array_agg(clubs.id) AS club_ids

                FROM leagues

                JOIN clubs ON clubs.id_league = leagues.id

                WHERE leagues.id_multiverse = inp_multiverse.id

                AND LEVEL > 0

                GROUP BY leagues.id

                HAVING count(leagues.id) <> 6

            ) LOOP

                RAISE EXCEPTION 'League % does not contain exactly 6 clubs. Clubs: %', loc_record.league_id, loc_record.club_ids;

            END LOOP;



            WITH club_expenses AS (

                SELECT 

                    id_club,

                    SUM(expenses_expected) AS total_player_expenses

                FROM players

                GROUP BY id_club

            )

            -- Send mail to each club indicating their position in the league

            INSERT INTO messages_mail (id_club_to, sender_role, title, message)

                SELECT 

                    id AS id_club_to, 'Treasurer' AS sender_role,

                    -- inp_multiverse.date_season_start + (INTERVAL '7 days' * inp_multiverse.week_number / inp_multiverse.speed),

                    'New season ' || inp_multiverse.season_number + 1 || ' starts for league ' || string_parser(clubs.id_league, 'idLeague') AS title,

                    string_parser(clubs.id_league, 'idLeague') || ' season ' || inp_multiverse.season_number + 1 || ' is ready to start. This season we managed to secure ' || revenues_sponsors || ' per week from sponsors (this season we had ' || revenues_sponsors_last_season || '). The players salary will amount for ' || COALESCE(club_expenses.total_player_expenses, 0) || ' per week and the targeted staff expenses is ' || expenses_staff_target AS message

                FROM clubs

                LEFT JOIN club_expenses ON club_expenses.id_club = clubs.id

            WHERE clubs.id_multiverse = inp_multiverse.id;



            -- Update players

            UPDATE players SET

                -- expenses_expected = FLOOR(

                --     (expenses_expected * 0.75 + 

                --     (100 +

                --     GREATEST(keeper, defense, playmaking, passes, winger, scoring, freekick) +

                --     (keeper + defense + playmaking + passes + winger + scoring + freekick) / 3

                --     ) * 0.25)),

                expenses_expected = FLOOR(

                    (expenses_expected * 0.75 + 

                    (50 +

                    (GREATEST(keeper, defense, playmaking, passes, winger, scoring, freekick) / 2) +

                    (keeper + defense + playmaking + passes + winger + scoring + freekick) / 4

                    ) * 0.25)),

                training_points_used = 0

            WHERE id_multiverse = inp_multiverse.id;



        ELSE

    END CASE;



    ------------------------------------------------------------------------

    ------------------------------------------------------------------------

    ------------ Try to populate the games for weeks greater than 10

    IF inp_multiverse.week_number >= 10 THEN

        ------ Loop through the list of games that can be populated

        FOR loc_record IN (

            SELECT games.* FROM games

            JOIN games_description ON games.id_games_description = games_description.id

            WHERE id_multiverse = inp_multiverse.id

            AND season_number = (SELECT season_number FROM multiverses WHERE id = inp_multiverse.id)

            AND games_description.week_set_up = (SELECT week_number FROM multiverses WHERE id = inp_multiverse.id)

            AND (id_club_left IS NULL OR id_club_right IS NULL)

            ORDER BY games.id

        ) LOOP

--RAISE NOTICE '*** MAIN: Populating games for Multiverse [%] S% WEEK % ==> id_game = %', inp_multiverse.name, inp_multiverse.season_number, inp_multiverse.week_number, loc_record.id;

            PERFORM main_populate_game(loc_record);

        END LOOP; --- End of the game loop

    END IF; -- End of the week_number check



END;

$$;


ALTER FUNCTION public.main_handle_season(inp_multiverse record) OWNER TO postgres;

--
-- Name: main_populate_game(record); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.main_populate_game(rec_game record) RETURNS void
    LANGUAGE plpgsql
    AS $$

DECLARE

    loc_array_id_clubs bigint[2]; -- Array of the clubs ids

    loc_array_id_leagues bigint[2]; -- Array of the leagues ids

    loc_array_id_games bigint[2]; -- Array of the games ids

    loc_array_pos_clubs bigint[2]; -- Array of the pos_number

    loc_array_selected_id_clubs bigint[]; -- Id of the clubs selected for the league or the game

    id_game_debug bigint[] := ARRAY[1831]; --Id of the game for debug

BEGIN



    loc_array_id_clubs = ARRAY[rec_game.id_club_left, rec_game.id_club_right];

    loc_array_id_leagues = ARRAY[rec_game.id_league_club_left, rec_game.id_league_club_right];

    loc_array_id_games = ARRAY[rec_game.id_game_club_left, rec_game.id_game_club_right];

    loc_array_pos_clubs = ARRAY[rec_game.pos_club_left, rec_game.pos_club_right];



--RAISE NOTICE 'rec_game.id = % # rec_game.id_league = %', rec_game.id, rec_game.id_league;

-- IF rec_game.id = ANY(id_game_debug) THEN

-- RAISE NOTICE 'rec_game.id= %', rec_game.id;

-- RAISE NOTICE 'loc_array_id_clubs = %', loc_array_id_clubs;

-- RAISE NOTICE 'loc_array_id_leagues = %', loc_array_id_leagues;

-- RAISE NOTICE 'loc_array_id_games = %', loc_array_id_games;

-- RAISE NOTICE 'loc_array_pos_clubs = %', loc_array_pos_clubs;

-- END IF;

    -- Loop through the two clubs: left then right

    FOR I IN 1..2 LOOP



        -- If the club is not set yet, we try to set it

        IF loc_array_id_clubs[I] IS NULL THEN



------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------

            ------ Try to set it with the id_league

            IF loc_array_id_leagues[I] IS NOT NULL THEN



IF rec_game.id = ANY(id_game_debug) THEN

RAISE NOTICE 'Entr├®e dans le IF de LEAGUES: loc_array_id_leagues[I]= %', loc_array_id_leagues[I];

END IF;

             

                -- Reset the array to null

                loc_array_selected_id_clubs := NULL;



                -- If this a first level league

                IF (SELECT level FROM leagues WHERE id = loc_array_id_leagues[I]) = 0 THEN



                    -- For the first part of the international games, we select the clubs from their continental league

                    IF rec_game.week_number < 14 THEN



                        -- Select the 6 club ids that finished at the potition of the number of the league from the top level leagues

                        SELECT ARRAY_AGG(id) INTO loc_array_selected_id_clubs FROM (

                            SELECT id FROM clubs

                                WHERE id_league IN (

                                    SELECT id FROM leagues WHERE level = 1

                                    AND id_multiverse = rec_game.id_multiverse

                                )

                                AND pos_league = (

                                    SELECT number FROM leagues WHERE id = loc_array_id_leagues[I]

                                )

                                ORDER BY league_points

                        ) AS clubs_ids;



                    -- Otherwise it's the last part of the intercontinetal cup games so we rank the clubs

                    ELSE



                        -- Check if the league is finished or not

                        IF (SELECT is_finished FROM leagues WHERE id = loc_array_id_leagues[I]) = TRUE THEN



-- Big fat query for ranking international league clubs

WITH filtered_games AS (

    SELECT id, week_number, id_club_left, score_left, id_club_right, score_right

    FROM games

    WHERE id_league = loc_array_id_leagues[I]

    AND season_number = rec_game.season_number

    AND week_number IN (11, 12, 13)

    AND is_league IS TRUE

),

games_with_points AS (

    SELECT id_club,

           SUM(points) AS total_points,

           SUM(goals_for) - SUM(goals_against) AS goal_average,

           SUM(goals_for) AS goals_for,

           SUM(goals_against) AS goals_against

    FROM (

        SELECT id_club_left AS id_club,

               CASE

                   WHEN score_left > score_right THEN 3

                   WHEN score_left = score_right THEN 1

                   ELSE 0

               END AS points,

               score_left AS goals_for,

               score_right AS goals_against

        FROM filtered_games

        UNION ALL

        SELECT id_club_right AS id_club,

               CASE

                   WHEN score_right > score_left THEN 3

                   WHEN score_right = score_left THEN 1

                   ELSE 0

               END AS points,

               score_right AS goals_for,

               score_left AS goals_against

        FROM filtered_games

    ) AS subquery

    GROUP BY id_club

)

SELECT array_agg(id_club) INTO loc_array_selected_id_clubs FROM (

    SELECT games_with_points.*, league_points AS previous_league_points

    FROM games_with_points

    JOIN clubs ON clubs.id = games_with_points.id_club

    ORDER BY total_points DESC, goal_average DESC, goals_for DESC, goals_against, previous_league_points DESC

) as subquery;



--raise notice 'OUTPUT OF BIG FAT loc_array_selected_id_clubs = %',loc_array_selected_id_clubs;



                        END IF; -- End of the league is_finished check

                    END IF;



                -- If this a normal league

                ELSE



                    -- Check if the league is finished or not

                    --IF (SELECT is_finished FROM leagues WHERE id = loc_array_id_leagues[I]) = TRUE THEN



                        -- Select the club ids of the leagues in the right order

                        SELECT ARRAY_AGG(id) INTO loc_array_selected_id_clubs FROM (

                            SELECT id FROM clubs

                                WHERE id_league = loc_array_id_leagues[I]

                                ORDER BY pos_league

                        ) AS clubs_ids;



                    --END IF; -- End of the league is_finished check



                END IF; -- End of the league level check



                -- Check that 6 clubs have been selected

                IF ARRAY_LENGTH(loc_array_selected_id_clubs, 1) = 6 THEN

                    

                    -- Update the games table

                    IF I = 1 THEN

                        UPDATE games SET

                            id_club_left = loc_array_selected_id_clubs[loc_array_pos_clubs[I]],

                            elo_left = (SELECT elo_points FROM clubs WHERE id = loc_array_selected_id_clubs[loc_array_pos_clubs[I]])

                            WHERE id = rec_game.id;

                    ELSE

                        UPDATE games SET

                            id_club_right = loc_array_selected_id_clubs[loc_array_pos_clubs[I]],

                            elo_right = (SELECT elo_points FROM clubs WHERE id = loc_array_selected_id_clubs[loc_array_pos_clubs[I]])

                            WHERE id = rec_game.id;

                    END IF;

--                -- Then there is an error

--                ELSE

--                    RAISE EXCEPTION 'The league with id: % does not have 6 clubs ==> Found %', rec_game.id_league_club_left, ARRAY_LENGTH(loc_array_selected_id_clubs, 1);

                END IF;



IF rec_game.id = ANY(id_game_debug) THEN

RAISE NOTICE 'SELECTED CLUBS IN THE LEAGUE ARE: loc_array_selected_id_clubs= %', loc_array_selected_id_clubs;

END IF;



------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------

            ------ Try to set it with the game id

            ELSEIF loc_array_id_games[I] IS NOT NULL THEN



                -- Check if the depending game is_played or not

                IF (SELECT date_end FROM games WHERE id = loc_array_id_games[I]) IS NOT NULL THEN

--RAISE NOTICE 'Depending game loc_array_id_games[I]= %', loc_array_id_games[I];

--RAISE NOTICE 'Game: % | club_left = % VS club_right %', (SELECT id FROM games WHERE id = loc_array_id_games[I]), (SELECT score_cumul_with_penalty_left FROM games WHERE id = loc_array_id_games[I]), (SELECT score_cumul_with_penalty_right FROM games WHERE id = loc_array_id_games[I]);

                    loc_array_selected_id_clubs := NULL;

                    -- Select the 2 club ids that played the game and order them by the score 1: Winner 2: Loser

                    SELECT ARRAY[

                        CASE

                            WHEN score_cumul_with_penalty_left > score_cumul_with_penalty_right THEN id_club_left

                            WHEN score_cumul_with_penalty_right >= score_cumul_with_penalty_left THEN id_club_right

                            ELSE NULL

                        END,

                        CASE

                            WHEN score_cumul_with_penalty_left > score_cumul_with_penalty_right THEN id_club_right

                            WHEN score_cumul_with_penalty_right >= score_cumul_with_penalty_left THEN id_club_left

                            ELSE NULL

                        END

                    ] INTO loc_array_selected_id_clubs

                    FROM games

                    WHERE id = loc_array_id_games[I];

--RAISE NOTICE '###### Game %: loc_array_selected_id_clubs = Winner: % Loser: % [Score: (%-%) Cumul (%-%)]', loc_array_id_games[I], loc_array_selected_id_clubs[1], loc_array_selected_id_clubs[2],

--(SELECT score_left FROM games WHERE id = loc_array_id_games[I]), (SELECT score_right FROM games WHERE id = loc_array_id_games[I]), (SELECT score_cumul_with_penalty_left FROM games WHERE id = loc_array_id_games[I]), (SELECT score_cumul_with_penalty_right FROM games WHERE id = loc_array_id_games[I]);



--IF rec_game.id = ANY(id_game_debug) THEN

--RAISE NOTICE 'loc_array_selected_id_clubs = %', loc_array_selected_id_clubs;

--END IF;



                    -- Check that there 2 clubs in the game

                    IF loc_array_selected_id_clubs[1] IS NULL OR loc_array_selected_id_clubs[2] IS NULL THEN

                        RAISE EXCEPTION 'The game with id: % does not have 2 clubs ==> Found %', loc_array_id_games[I], loc_array_selected_id_clubs;

                    END IF;



                    -- Update the games table

                    IF I = 1 THEN

                        UPDATE games SET

                            id_club_left = loc_array_selected_id_clubs[loc_array_pos_clubs[I]],

                            elo_left = (SELECT elo_points FROM clubs WHERE id = loc_array_selected_id_clubs[loc_array_pos_clubs[I]])

                            WHERE id = rec_game.id;

                    ELSE

                        UPDATE games SET

                            id_club_right = loc_array_selected_id_clubs[loc_array_pos_clubs[I]],

                            elo_right = (SELECT elo_points FROM clubs WHERE id = loc_array_selected_id_clubs[loc_array_pos_clubs[I]])

                            WHERE id = rec_game.id;

                    END IF;

                    

                END IF; -- End of the game is_played check



------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------

            ------ Then it's a special case

            ELSE

                RAISE EXCEPTION 'Cannot set the left club of the game with id: % ==> Both inputs (id_league and id_game are null)', rec_game.id;

            END IF;

        END IF;



    END LOOP; -- End of the 2 clubs loop (left and right)

END;

$$;


ALTER FUNCTION public.main_populate_game(rec_game record) OWNER TO postgres;

--
-- Name: main_simulate_day(record); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.main_simulate_day(inp_multiverse record) RETURNS boolean
    LANGUAGE plpgsql
    AS $$

DECLARE

    league RECORD; -- Record for the leagues loop

    club RECORD; -- Record for the clubs loop

    game RECORD; -- Record for the game loop

    is_league_game_finished bool; -- If a game from the league was played, recalculate the rankings

    pos integer; -- Position in the league

BEGIN



    ---- Increase players energy

    UPDATE players

        SET energy = LEAST(100,

            energy + (100 - energy) / 5)

    WHERE id_multiverse = inp_multiverse.id;



    ------ Handling of the day 7 ==> Game day

    IF inp_multiverse.day_number = 7 THEN



        ------------ Loop through all leagues of the multiverse

        FOR league IN (

            SELECT * FROM leagues WHERE id_multiverse = inp_multiverse.id)

        LOOP



            ------ Loop through the games that need to be played for the current week of the current league

            FOR game IN

                (SELECT id FROM games

                    WHERE id_league = league.id

                    AND date_end IS NULL

                    AND season_number <= inp_multiverse.season_number

                    AND week_number <= inp_multiverse.week_number

                    AND now() > date_start

                    ORDER BY season_number, week_number, id)

            LOOP



                -- Simulate the game

                PERFORM simulate_game_main(inp_id_game := game.id);



            END LOOP; -- End of the loop of the games simulation



            -- Set to FALSE by default

            is_league_game_finished := FALSE;



            ------ Loop through the games that are finished for the current week of the current league

            FOR game IN

                (SELECT id FROM games

                    WHERE id_league = league.id

                    AND now() >= date_end

                    AND is_playing = TRUE

                    AND season_number <= inp_multiverse.season_number

                    AND week_number <= inp_multiverse.week_number

                    ORDER BY id)

            LOOP

                PERFORM simulate_game_set_is_played(inp_id_game := game.id);



                -- Say that a game from the league was finished

                is_league_game_finished := TRUE;



            END LOOP; -- End of the loop of the games simulation



            -- If a game from the league was played, recalculate the rankings

            IF is_league_game_finished = TRUE THEN

                -- Calculate rankings for normal leagues

                IF league.LEVEL > 0 AND inp_multiverse.week_number <= 10 THEN

                    -- Calculate rankings for each clubs in the league

                    pos := 1;

                    FOR club IN

                        (SELECT * FROM clubs

                            WHERE id_league = league.id

                            ORDER BY league_points DESC,

                                (league_goals_for - league_goals_against) DESC,

                                pos_last_season,

                                created_at ASC)

                    LOOP

                        -- Update the position in the league of this club

                        UPDATE clubs

                            SET pos_league = pos

                            WHERE id = club.id;



                        -- Update the leagues rankings

                        UPDATE leagues

                            SET id_clubs[pos] = club.id,

                            points[pos] = club.league_points

                            WHERE id = league.id;



                        -- Update the position

                        pos := pos + 1;



                    END LOOP; -- End of the loop through clubs

                END IF; -- End of the calculation of the rankings of the normal leagues

            END IF; -- End of the check if a game from the league was played

        END LOOP; -- End of the loop through leagues



        ------ If all games of the week are finished, return TRUE

        IF (

            -- Check if there are games from the current week that are not finished

            SELECT COUNT(id)

            FROM games

            WHERE id_multiverse = inp_multiverse.id

            AND is_playing <> FALSE

            AND season_number = inp_multiverse.season_number

            AND week_number = inp_multiverse.week_number) > 0

        THEN

            RETURN FALSE;

        ELSE

            RETURN TRUE;

        END IF;

    END IF; -- End of the handling of week 7



    RETURN TRUE; -- Return TRUE to say that we can pass to the next day

    

END;

$$;


ALTER FUNCTION public.main_simulate_day(inp_multiverse record) OWNER TO postgres;

--
-- Name: player_change_shirt_number(bigint, bigint, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.player_change_shirt_number(inp_id_player bigint, inp_id_club bigint, inp_shirt_number integer) RETURNS void
    LANGUAGE plpgsql
    AS $$

BEGIN



    ------ CHECKS: General

    IF inp_id_player IS NULL THEN

        RAISE EXCEPTION 'Player id cannot be NULL';

    ELSIF inp_id_club IS NULL THEN

        RAISE EXCEPTION 'Club id cannot be NULL';

    END IF;





    IF (SELECT id_club FROM players WHERE id = inp_id_player) != inp_id_club THEN

        RAISE EXCEPTION 'The player does not belong to the club';

    END IF;



    IF inp_shirt_number < 0 THEN

        RAISE EXCEPTION 'Shirt number cannot be negative';

    ELSIF inp_shirt_number > 99 THEN

        RAISE EXCEPTION 'Shirt number cannot be higher than 99';

    ---- Check: Shirt number should be unique in the club

    -- ELSIF inp_shirt_number IN (

    --     SELECT p.shirt_number

    --     FROM players p

    --     JOIN players p2 ON p.id_club = p2.id_club

    --     WHERE p2.id = inp_id_player

    --       AND p.id != p2.id

    -- ) THEN

    --     ---- If we force the value, remove the other player's shirt number

    --     IF inp_force = TRUE THEN

    --         -- Remove the shirt number from the other player

    --         UPDATE players

    --             SET shirt_number = NULL

    --         WHERE id_club = inp_id_club AND shirt_number = inp_shirt_number;

    --     ELSE

    --         -- Raise an exception

    --         RAISE EXCEPTION 'Shirt number % is already taken by %', inp_shirt_number, (SELECT player_get_full_name(id) FROM players WHERE shirt_number = inp_shirt_number AND id_club = inp_id_club);

    

    --     END IF;

    END IF;



    ---- Update the shirt number of the player and remove it from others in the same club

    UPDATE players

    SET shirt_number =

        CASE

            WHEN id = inp_id_player THEN inp_shirt_number

            ELSE NULL

        END

    WHERE id_club = inp_id_club

    AND (shirt_number = inp_shirt_number OR id = inp_id_player);



END;

$$;


ALTER FUNCTION public.player_change_shirt_number(inp_id_player bigint, inp_id_club bigint, inp_shirt_number integer) OWNER TO postgres;

--
-- Name: player_get_full_name(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.player_get_full_name(id_player bigint) RETURNS text
    LANGUAGE plpgsql
    AS $$

DECLARE

    player_name text;

BEGIN

    SELECT first_name || ' ' || UPPER(last_name) || 

           COALESCE(' (' || surname || ')', '') INTO player_name

    FROM players

    WHERE id = id_player;



    RETURN player_name;

END;

$$;


ALTER FUNCTION public.player_get_full_name(id_player bigint) OWNER TO postgres;

--
-- Name: player_remove_from_teamcomps(record); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.player_remove_from_teamcomps(rec_player record) RETURNS integer
    LANGUAGE plpgsql
    AS $$

BEGIN



    ------ Remove the player id from the teamcomps of his club where he appears

    UPDATE games_teamcomp

        SET

            idgoalkeeper = CASE WHEN idgoalkeeper = rec_player.id THEN NULL ELSE idgoalkeeper END,

            idleftbackwinger = CASE WHEN idleftbackwinger = rec_player.id THEN NULL ELSE idleftbackwinger END,

            idleftcentralback = CASE WHEN idleftcentralback = rec_player.id THEN NULL ELSE idleftcentralback END,

            idcentralback = CASE WHEN idcentralback = rec_player.id THEN NULL ELSE idcentralback END,

            idrightcentralback = CASE WHEN idrightcentralback = rec_player.id THEN NULL ELSE idrightcentralback END,

            idrightbackwinger = CASE WHEN idrightbackwinger = rec_player.id THEN NULL ELSE idrightbackwinger END,

            idleftwinger = CASE WHEN idleftwinger = rec_player.id THEN NULL ELSE idleftwinger END,

            idleftmidfielder = CASE WHEN idleftmidfielder = rec_player.id THEN NULL ELSE idleftmidfielder END,

            idcentralmidfielder = CASE WHEN idcentralmidfielder = rec_player.id THEN NULL ELSE idcentralmidfielder END,

            idrightmidfielder = CASE WHEN idrightmidfielder = rec_player.id THEN NULL ELSE idrightmidfielder END,

            idrightwinger = CASE WHEN idrightwinger = rec_player.id THEN NULL ELSE idrightwinger END,

            idleftstriker = CASE WHEN idleftstriker = rec_player.id THEN NULL ELSE idleftstriker END,

            idcentralstriker = CASE WHEN idcentralstriker = rec_player.id THEN NULL ELSE idcentralstriker END,

            idrightstriker = CASE WHEN idrightstriker = rec_player.id THEN NULL ELSE idrightstriker END,

            idsub1 = CASE WHEN idsub1 = rec_player.id THEN NULL ELSE idsub1 END,

            idsub2 = CASE WHEN idsub2 = rec_player.id THEN NULL ELSE idsub2 END,

            idsub3 = CASE WHEN idsub3 = rec_player.id THEN NULL ELSE idsub3 END,

            idsub4 = CASE WHEN idsub4 = rec_player.id THEN NULL ELSE idsub4 END,

            idsub5 = CASE WHEN idsub5 = rec_player.id THEN NULL ELSE idsub5 END,

            idsub6 = CASE WHEN idsub6 = rec_player.id THEN NULL ELSE idsub6 END,

            idsub7 = CASE WHEN idsub7 = rec_player.id THEN NULL ELSE idsub7 END

    WHERE is_played IS FALSE

    AND id_club = rec_player.id_club;



    ------ Try to correct the errors in the main default teamcomp

    PERFORM teamcomp_correct_teamcomp_errors(

        inp_id_teamcomp := (

            SELECT id

            FROM games_teamcomp

            WHERE id_club = rec_player.id_club

            AND season_number = 0

            AND week_number = 1

        )

    );



END;

$$;


ALTER FUNCTION public.player_remove_from_teamcomps(rec_player record) OWNER TO postgres;

--
-- Name: players_calculate_date_birth(bigint, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.players_calculate_date_birth(inp_id_multiverse bigint, inp_age double precision DEFAULT NULL::double precision) RETURNS timestamp with time zone
    LANGUAGE plpgsql
    AS $$

DECLARE

  multiverse_speed double precision;

BEGIN

  -- Get the speed from the multiverses table

  SELECT speed INTO multiverse_speed FROM multiverses WHERE id = inp_id_multiverse;



  -- If inp_age is NULL, generate a random age

  IF inp_age IS NULL THEN

    inp_age := 15 + (random() * (32 - 15));

  END IF;



  -- Calculate and return the date of birth

  RETURN NOW() - (inp_age * 14 * 7 * 24 * 60 * 60 / multiverse_speed) * INTERVAL '1 second';

END;

$$;


ALTER FUNCTION public.players_calculate_date_birth(inp_id_multiverse bigint, inp_age double precision) OWNER TO postgres;

--
-- Name: players_calculate_performance_score(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.players_calculate_performance_score(inp_id_player bigint) RETURNS void
    LANGUAGE plpgsql
    AS $$

DECLARE

    performance_score FLOAT4; -- Player performance score

BEGIN

    -- Calculate player performance score and update the player record

    UPDATE players

    SET performance_score = players_calculate_player_best_weight(

        ARRAY[keeper, defense, playmaking, passes, scoring, freekick, winger,

        motivation, form, experience, energy, stamina]

    )

    WHERE id = inp_id_player;



END;

$$;


ALTER FUNCTION public.players_calculate_performance_score(inp_id_player bigint) OWNER TO postgres;

--
-- Name: players_calculate_player_best_weight(real[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.players_calculate_player_best_weight(inp_player_stats real[]) RETURNS double precision
    LANGUAGE plpgsql
    AS $$

DECLARE

    player_weight_array float8[7] := '{0,0,0,0,0,0,0}'; -- Array to hold player weights on the team (LeftDefense, CentralDefense, RightDefense, MidField, LeftAttack, CentralAttack, RightAttack)

    player_weight float8 := 0; -- Weight of the player

    player_max_weight float8 := 0; -- Maximum weight of the player

BEGIN



    -- Loop through the 14 available positions of the team

    FOR i IN 1..14 LOOP

        -- Calculate the weight of the player for the given position

        player_weight_array := players_calculate_player_weight(inp_player_stats, i);

        -- Calculate the sum of the weights

        FOR j IN 1..7 LOOP

            player_weight := player_weight + player_weight_array[j];

        END LOOP;

        -- Check if the weight is higher than the maximum weight

        IF player_weight > player_max_weight THEN

            player_max_weight := player_weight;

        END IF;
        -- Reset player_weight
        player_weight := 0;

    END LOOP;

--RAISE NOTICE 'player_max_weight= %', player_max_weight;

    RETURN player_max_weight;

END;

$$;


ALTER FUNCTION public.players_calculate_player_best_weight(inp_player_stats real[]) OWNER TO postgres;

--
-- Name: players_calculate_player_weight(real[], integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.players_calculate_player_weight(inp_player_stats real[], inp_position integer) RETURNS real[]
    LANGUAGE plpgsql
    AS $$

DECLARE

    CoefMatrix float4[14][7][6] := 

    '{{{0.125,0.05,0,0,0,0},{0.25,0.1,0,0,0,0},{0.125,0.05,0,0,0,0},{0,0,0.05,0.1,0,0},{0,0,0.05,0,0,0},{0,0,0.05,0,0,0},{0,0,0.05,0,0,0}},

      {{0,0.2,0,0,0,0},{0,0.15,0,0,0,0},{0,0.05,0,0,0,0},{0,0,0.05,0.1,0,0},{0,0,0.1,0,0.25,0.05},{0,0,0.05,0,0,0},{0,0,0,0,0,0}},

      {{0,0.15,0,0,0,0},{0,0.3,0,0,0,0},{0,0.05,0,0,0,0},{0,0,0.1,0.1,0,0},{0,0,0.1,0,0.05,0},{0,0,0.1,0,0,0.05},{0,0,0,0,0,0}},

      {{0,0.1,0,0,0,0},{0,0.3,0,0,0,0},{0,0.1,0,0,0,0},{0,0,0.1,0.1,0,0},{0,0,0.05,0,0,0},{0,0,0.1,0,0,0.1},{0,0,0.05,0,0,0}},

      {{0,0.1,0,0,0,0},{0,0.3,0,0,0,0},{0,0.1,0,0,0,0},{0,0,0.1,0.1,0,0},{0,0,0.05,0,0,0},{0,0,0.1,0,0,0.1},{0,0,0.05,0,0,0}},

      {{0,0.05,0,0,0,0},{0,0.3,0,0,0,0},{0,0.15,0,0,0,0},{0,0,0.1,0.1,0,0},{0,0,0,0,0,0},{0,0,0.1,0,0,0.05},{0,0,0.1,0,0.05,0}},

      {{0,0.15,0,0,0,0},{0,0.05,0,0,0,0},{0,0,0,0,0,0},{0,0,0.05,0.2,0,0},{0,0,0.1,0,0.15,0.1},{0,0,0.05,0,0.05,0.1},{0,0,0,0,0,0}},

      {{0,0.05,0,0,0,0},{0,0.15,0,0,0,0},{0,0,0,0,0,0},{0,0,0.05,0.3,0,0},{0,0,0.05,0,0.1,0},{0,0,0.2,0,0,0.1},{0,0,0,0,0,0}},

      {{0,0.05,0,0,0,0},{0,0.1,0,0,0,0},{0,0.05,0,0,0,0},{0,0,0.1,0.3,0,0},{0,0,0.1,0,0,0},{0,0,0.1,0,0,0.1},{0,0,0.1,0,0,0}},

      {{0,0,0,0,0,0},{0,0.15,0,0,0,0},{0,0.05,0,0,0,0},{0,0,0.05,0.3,0,0},{0,0,0,0,0,0},{0,0,0.2,0,0,0.1},{0,0,0.05,0,0.1,0}},

      {{0,0,0,0,0,0},{0,0.05,0,0,0,0},{0,0.15,0,0,0,0},{0,0,0.05,0.2,0,0},{0,0,0,0,0,0},{0,0,0.05,0,0.05,0.1},{0,0,0.1,0,0.15,0.1}},

      {{0,0.1,0,0,0,0},{0,0,0,0,0,0},{0,0,0,0,0,0},{0,0,0.05,0.2,0,0},{0,0,0.1,0,0.05,0.1},{0,0,0.05,0,0.05,0.3},{0,0,0,0,0,0}},

      {{0,0.025,0,0,0,0},{0,0.05,0,0,0,0},{0,0.025,0,0,0,0},{0,0,0.05,0.2,0,0},{0,0,0.05,0,0.05,0.05},{0,0,0.05,0,0.1,0.2},{0,0,0.05,0,0.05,0.05}},

      {{0,0,0,0,0,0},{0,0,0,0,0,0},{0,0.1,0,0,0,0},{0,0,0.05,0.2,0,0},{0,0,0,0,0,0},{0,0,0.05,0,0.05,0.3},{0,0,0.1,0,0.05,0.1}}}';

    player_weight float4[7] := '{0,0,0,0,0,0,0}'; -- Array to hold player weights on the team (LeftDefense, CentralDefense, RightDefense, MidField, LeftAttack, CentralAttack, RightAttack)

    player_coef float4; -- Coefficient of the player stats

BEGIN



    -- Check if the position is between 1 and 14

    IF inp_position < 1 OR inp_position > 14 THEN

        RAISE EXCEPTION 'Position must be between 1 and 14';

    END IF;



    -- Calculate the coefficient of the player stats (motiation, form, experiennce, energy)

    -- player_coef := 1 + ((inp_player_stats[8] + inp_player_stats[9] + inp_player_stats[10] + inp_player_stats[12]) / 400.0);

    player_coef := 1 + ((inp_player_stats[8] + inp_player_stats[9] + inp_player_stats[10]) / 300.0);



    -- Loop through the 7 team stats (LeftDefense, CentralDefense, RightDefense, MidField, LeftAttack, CentralAttack, RightAttack)

    FOR i IN 1..7 LOOP

        -- Loop through the 6 player stats (keeper, defense, passes, playmaking, winger, scoring, NO FREEKINK !)

        FOR j IN 1..6 LOOP

            player_weight[i] := player_weight[i] + inp_player_stats[j] * CoefMatrix[inp_position][i][j];

        END LOOP;



        -- Add the coefficients of the player stats

        player_weight[i] := player_weight[i] * player_coef;

    END LOOP;



    RETURN player_weight;

END;

$$;


ALTER FUNCTION public.players_calculate_player_weight(inp_player_stats real[], inp_position integer) OWNER TO postgres;

--
-- Name: players_check_club_players_count_no_less_than_16(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.players_check_club_players_count_no_less_than_16() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

BEGIN

    IF (SELECT COUNT(*) FROM players

        WHERE id_club = NEW.id_club

        AND date_bid_end IS NULL

    ) <= 16 THEN

        RAISE EXCEPTION 'A club cannot have less than 16 players, cannot put to sell or fire player';

    END IF;

    RETURN NEW;

END;

$$;


ALTER FUNCTION public.players_check_club_players_count_no_less_than_16() OWNER TO postgres;

--
-- Name: players_create_player(bigint, bigint, bigint, double precision, bigint, text, double precision[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.players_create_player(inp_id_multiverse bigint, inp_id_club bigint, inp_id_country bigint, inp_age double precision, inp_shirt_number bigint DEFAULT NULL::bigint, inp_notes text DEFAULT NULL::text, inp_stats double precision[] DEFAULT NULL::double precision[]) RETURNS bigint
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$

DECLARE

    loc_new_player_id bigint; -- Variable to store the inserted player's ID

    loc_top_two_stats double precision[];

    loc_training_coef double precision[];

    loc_tmp double precision; -- Temporary variable for calculations

BEGIN



    ------ Check if the player creation is from scouts

    IF inp_notes = 'Young Scouted' THEN

        IF (SELECT scouts_weight FROM clubs WHERE id = inp_id_club) < 7000 THEN

            RAISE EXCEPTION 'The club does not have enough scout network strength to scout a new player';

        ELSE

            UPDATE clubs SET scouts_weight = scouts_weight - 7000 WHERE id = inp_id_club;

        END IF;

    END IF;



    ------ If the inp_stats array is NULL, generate random stats based on the player's age and inp_notes

    IF inp_stats IS NULL THEN

        loc_tmp := 3.0 * (inp_age - 15); -- Age: (15 ==> 35) ==> Value: [0 ==> 60]

        ---- Goalkeepers

        IF inp_shirt_number IN (1, 12) THEN

            inp_stats := ARRAY[

                loc_tmp + 10 * (1 + random()), -- Keeper: BaseValue(age) + Random(10 ==> 20)

                loc_tmp + 10 * random(), -- Defense: BaseValue(age) + Random(0 ==> 5)

                loc_tmp + 10 * random(), -- Passes: BaseValue(age) + Random(0 ==> 5)

                loc_tmp * random(), -- Playmaking: Random(0 ==> BaseValue(age))

                loc_tmp * random(), -- Winger: Random(0 ==> BaseValue(age))

                loc_tmp * random(), -- Scoring: Random(0 ==> BaseValue(age))

                loc_tmp + 10 * random()]; -- Freekick

        ---- Back Wingers

        ELSIF inp_shirt_number IN (2, 3, 13) THEN

            inp_stats := ARRAY[

                0, -- Keeper

                loc_tmp + 10 * (1 + random()), -- Defense

                loc_tmp + 10 * random(), -- Passes

                loc_tmp + 10 * random(), -- Playmaking

                loc_tmp + 10 * random(), -- Winger

                0, -- Scoring

                0]; -- Freekick

        ---- Central Backs

        ELSIF inp_shirt_number IN (4, 5, 14) THEN

            inp_stats := ARRAY[

                0, -- Keeper

                loc_tmp + 10 * (1 + random()), -- Defense

                loc_tmp + 10 * random(), -- Passes

                loc_tmp * 10 * random(), -- Playmaking

                0, -- Winger

                0, -- Scoring

                0]; -- Freekick

        ---- Midfielders

        ELSIF inp_shirt_number IN (6, 10, 15) THEN

            inp_stats := ARRAY[

                0, -- Keeper

                loc_tmp + 10 * random(), -- Defense

                loc_tmp + 10 * (1 + random()), -- Passes

                loc_tmp + 10 * (1 + random()), -- Playmaking

                0, -- Winger

                0, -- Scoring

                0]; -- Freekick

        ---- Wingers

        ELSIF inp_shirt_number IN (7, 8, 16) THEN

            inp_stats := ARRAY[

                0, -- Keeper

                loc_tmp + 10 * random(), -- Defense

                loc_tmp + 10 * random(), -- Passes

                loc_tmp + 10 * random(), -- Playmaking

                loc_tmp + 10 * (1 + random()), -- Winger

                loc_tmp + 10 * random(), -- Scoring

                0]; -- Freekick

        ---- Strikers

        ELSIF inp_shirt_number IN (9, 11, 17) THEN

            inp_stats := ARRAY[

                0, -- Keeper

                0, -- Defense

                loc_tmp + 10 * random(), -- Passes

                loc_tmp + 10 * random(), -- Playmaking

                loc_tmp + 10 * random(), -- Winger

                loc_tmp + 10 * (1 + random()), -- Scoring

                0]; -- Freekick

        ELSE

            RAISE EXCEPTION 'Invalid shirt_number when creating a player with no stats given (must be between 1 and 17)';

        END IF;

    END IF;



    -- Find the two highest values in inp_stats

    loc_top_two_stats := (

        SELECT ARRAY(

            SELECT val

            FROM unnest(inp_stats) AS val

            ORDER BY val DESC

            LIMIT 2

        )

    );



    -- Create the training_coef array with 1 for the two highest stats and 0 for the others

    loc_training_coef := ARRAY[

        CASE WHEN inp_stats[1] = ANY(loc_top_two_stats) THEN 1 ELSE 0 END,

        CASE WHEN inp_stats[2] = ANY(loc_top_two_stats) THEN 1 ELSE 0 END,

        CASE WHEN inp_stats[3] = ANY(loc_top_two_stats) THEN 1 ELSE 0 END,

        CASE WHEN inp_stats[4] = ANY(loc_top_two_stats) THEN 1 ELSE 0 END,

        CASE WHEN inp_stats[5] = ANY(loc_top_two_stats) THEN 1 ELSE 0 END,

        CASE WHEN inp_stats[6] = ANY(loc_top_two_stats) THEN 1 ELSE 0 END,

        CASE WHEN inp_stats[7] = ANY(loc_top_two_stats) THEN 1 ELSE 0 END

    ];



    ------------------------------------------------------------------------

    ------------------------------------------------------------------------

    ------ Create player

    INSERT INTO players (

        id_multiverse, id_club, id_country,

        date_birth, experience,

        keeper, defense, passes, playmaking, winger, scoring, freekick,

        training_coef,

        shirt_number, notes, notes_small

    ) VALUES (

        inp_id_multiverse, inp_id_club, inp_id_country,

        players_calculate_date_birth(inp_id_multiverse := inp_id_multiverse, inp_age := inp_age), 3.0 * (inp_age - 15.0),

        inp_stats[1], inp_stats[2], inp_stats[3], inp_stats[4], inp_stats[5], inp_stats[6], inp_stats[7],

        loc_training_coef,

        inp_shirt_number,

        -- Notes (if not given use the shirt number to determine the player's position)

        CASE

            WHEN inp_notes IS NOT NULL THEN inp_notes

            WHEN inp_shirt_number IN (1, 12) THEN 'GoalKeeper'

            WHEN inp_shirt_number IN (2, 3, 13) THEN 'Back Winger'

            WHEN inp_shirt_number IN (4, 5, 14) THEN 'Central Back'

            WHEN inp_shirt_number IN (6, 10, 15) THEN 'Midfielder'

            WHEN inp_shirt_number IN (7, 8, 16) THEN 'Winger'

            WHEN inp_shirt_number IN (9, 11, 17) THEN 'Striker'

            ELSE NULL

        END,

        -- Small notes

        CASE

            WHEN inp_notes IS NOT NULL THEN

            CASE

                WHEN inp_notes = 'Experienced GoalKeeper' THEN 'GK1'

                WHEN inp_notes = 'Young GoalKeeper' THEN 'GK2'

                WHEN inp_notes = 'Experienced Back Winger' THEN 'BW1'

                WHEN inp_notes = 'Intermediate Age Back Winger' THEN 'BW2'

                WHEN inp_notes = 'Young Back Winger' THEN 'BW3'

                WHEN inp_notes = 'Experienced Central Back' THEN 'CB1'

                WHEN inp_notes = 'Intermediate Age Central Back' THEN 'CB2'

                WHEN inp_notes = 'Young Central Back' THEN 'CB3'

                WHEN inp_notes = 'Experienced Midfielder' THEN 'MF1'

                WHEN inp_notes = 'Intermediate Age Midfielder' THEN 'MF2'

                WHEN inp_notes = 'Young Midfielder' THEN 'MF3'

                WHEN inp_notes = 'Experienced Winger' THEN 'WG1'

                WHEN inp_notes = 'Intermediate Age Winger' THEN 'WG2'

                WHEN inp_notes = 'Young Winger' THEN 'WG3'

                WHEN inp_notes = 'Experienced Striker' THEN 'ST1'

                WHEN inp_notes = 'Intermediate Age Striker' THEN 'ST2'

                WHEN inp_notes = 'Young Striker' THEN 'ST3'

                WHEN inp_notes = 'Old Experienced player' THEN 'OLDXP'

                WHEN inp_notes = 'Youngster 1' THEN 'YOUNG1'

                WHEN inp_notes = 'Youngster 2' THEN 'YOUNG2'

                WHEN inp_notes = 'Young Scouted' THEN 'SCOUT'

                ELSE 'None ???' END

            WHEN inp_shirt_number IS NOT NULL THEN

            CASE

                WHEN inp_shirt_number IN (1, 12) THEN 'GK'

                WHEN inp_shirt_number IN (2, 3, 13) THEN 'BW'

                WHEN inp_shirt_number IN (4, 5, 14) THEN 'CB'

                WHEN inp_shirt_number IN (6, 10, 15) THEN 'MF'

                WHEN inp_shirt_number IN (7, 8, 16) THEN 'WG'

                WHEN inp_shirt_number IN (9, 11, 17) THEN 'ST'

                ELSE 'None ??' END

            ELSE 'None ?'

        END)

    RETURNING id INTO loc_new_player_id;



    ------ Log player history

    INSERT INTO players_history (id_player, id_club, description)

    VALUES (loc_new_player_id, inp_id_club,

    'Joined ' || string_parser(inp_id_club, 'idClub') ||

    CASE

        WHEN inp_notes = 'Young Scouted' THEN ' as a young scouted player'

        WHEN inp_notes = 'Old Experienced player' THEN ' as an old experienced player'

        ELSE ' as a free player'

    END);



    ------ Send a message to the club for scouted players

    IF inp_notes = 'Young Scouted' THEN

        INSERT INTO messages_mail (id_club_to, sender_role, title, message)

            VALUES

                (inp_id_club, 'Scout',

                'New Scouted Player: ' || string_parser(loc_new_player_id, 'idPlayer'),

                string_parser(loc_new_player_id, 'idPlayer') || ' joined the squad, check him out, i''ve been keeping an eye on him for a while and given some good training he might be a future star !');

    END IF;

    

    ------ Return the new player's ID

    RETURN loc_new_player_id;

END;

$$;


ALTER FUNCTION public.players_create_player(inp_id_multiverse bigint, inp_id_club bigint, inp_id_country bigint, inp_age double precision, inp_shirt_number bigint, inp_notes text, inp_stats double precision[]) OWNER TO postgres;

--
-- Name: players_handle_new_player_created(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.players_handle_new_player_created() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$

DECLARE

    loc_first_name TEXT;

    loc_last_name TEXT;

BEGIN



    ------ Check that the user can have an additional club

    IF (NEW.username <> NULL) THEN

        IF ((SELECT COUNT(*) FROM players WHERE username = NEW.username) >

        (SELECT number_players_available FROM profiles WHERE username = NEW.username)

        ) THEN

            RAISE EXCEPTION 'You can not have an additional player assigned to you';

        END IF;

    END IF;



    ------ Generate player name

    WITH country_query AS (

        SELECT first_name, last_name

        FROM players_names

        WHERE id_country = NEW.id_country

        LIMIT 100

    ),

    other_country_query AS (

        SELECT first_name, last_name

        FROM players_names 

        WHERE id_country != NEW.id_country 

        LIMIT (100 - (SELECT COUNT(*) FROM country_query))

    ),

    combined_query AS (

        SELECT * FROM country_query

        UNION ALL

        SELECT * FROM other_country_query

    )

    SELECT first_name INTO loc_first_name FROM combined_query ORDER BY RANDOM() LIMIT 1; -- Fetch a random first name  

        WITH country_query AS (

        SELECT first_name, last_name

        FROM players_names 

        WHERE id_country = NEW.id_country 

        LIMIT 100

    ),

    other_country_query AS (

        SELECT first_name, last_name

        FROM players_names 

        WHERE id_country != NEW.id_country 

        LIMIT (100 - (SELECT COUNT(*) FROM country_query))

    ),

    combined_query AS (

        SELECT * FROM country_query

        UNION ALL

        SELECT * FROM other_country_query

    )

    SELECT last_name INTO loc_last_name FROM combined_query ORDER BY RANDOM() LIMIT 1; -- Fetch a random last name

    -- Store the name in the player row

    IF (NEW.first_name IS NULL OR NEW.first_name = '') THEN

        NEW.first_name = loc_first_name;

    END IF;

    IF (NEW.last_name IS NULL OR NEW.last_name = '') THEN

        NEW.last_name = loc_last_name;

    END IF;



    ------ Store the multiverse speed

    NEW.multiverse_speed = (SELECT speed FROM multiverses WHERE id = NEW.id_multiverse);



    ------ Calculate the expected expenses

    NEW.expenses_expected = FLOOR((50 +

        GREATEST(NEW.keeper, NEW.defense, NEW.playmaking, NEW.passes, NEW.winger, NEW.scoring, NEW.freekick) / 2 +

        (NEW.keeper + NEW.defense + NEW.passes + NEW.playmaking + NEW.winger + NEW.scoring + NEW.freekick) / 4

        ) * 0.75);



    ------ Calculate experience

    IF NEW.experience IS NULL THEN

        NEW.experience = 2 * (calculate_age(inp_multiverse_speed := NEW.multiverse_speed, inp_date_birth := NEW.date_birth) - 10);

    END IF;



    ------ Calculate the performance score

    NEW.performance_score = players_calculate_player_best_weight(

        ARRAY[NEW.keeper, NEW.defense, NEW.playmaking, NEW.passes, NEW.scoring, NEW.freekick, NEW.winger,

        NEW.motivation, NEW.form, NEW.experience, NEW.energy, NEW.stamina]

    );



    -- Log history

    --INSERT INTO players_history (id_player, description)

    --VALUES (NEW.id, 'User ' || NEW.username || ' has been assigned to the club');



    -- Return the new record to proceed with the update

    RETURN NEW;

END;

$$;


ALTER FUNCTION public.players_handle_new_player_created() OWNER TO postgres;

--
-- Name: players_pay_expenses_missed(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.players_pay_expenses_missed() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

BEGIN


    -- Check if the club has enough cash to pay the missed expenses

    IF (SELECT cash FROM clubs

        WHERE id = NEW.id_club) < NEW.expenses_missed THEN

        RAISE EXCEPTION 'Club does not have enough cash to pay the missed expenses';

    END IF;



    -- Deduct the missed expenses from the club's cash

    UPDATE clubs

    SET cash = cash - OLD.expenses_missed

    WHERE id = NEW.id_club;



    RETURN NEW;

END;

$$;


ALTER FUNCTION public.players_pay_expenses_missed() OWNER TO postgres;

--
-- Name: random_selection_of_index_from_array_with_weight(real[], integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.random_selection_of_index_from_array_with_weight(inp_array_weights real[], inp_additionnal_weight integer DEFAULT 0) RETURNS bigint
    LANGUAGE plpgsql
    AS $$

DECLARE

    loc_sum float8 := 0; -- Sum of the weights

    loc_cumulative_prob float8 := 0; -- Cumulative probability

    loc_random_value float8; -- Random value

    I int; -- Index for the loop

BEGIN



    ------ Calculate the sul of the weights

    FOR I IN 1..array_length(inp_array_weights, 1) LOOP

        ---- Check if the weight is negative

        IF inp_array_weights[I] < 0 THEN

            RAISE EXCEPTION 'Selection of index from weighted array ==> a negative weight at index % for %', I, inp_array_weights;

        END IF;

        ---- Add the weight to the sum

        loc_sum := loc_sum + inp_array_weights[I];

    END LOOP;



    ------ Add the additionnal weight

    loc_sum := loc_sum + inp_additionnal_weight;



    IF loc_sum = 0 THEN

        RAISE EXCEPTION 'Total sum of 0 (division by 0), cannot fetch an index: %', inp_array_weights;

    END IF;



    ------ Generate random value

    loc_random_value := random();



    ------ Loop through the array and calculate the cumulative probability

    FOR I IN 1..array_length(inp_array_weights, 1) LOOP

        loc_cumulative_prob := loc_cumulative_prob + (inp_array_weights[I] / loc_sum);

        ---- If the random value is less than the cumulative probability

        IF loc_random_value <= loc_cumulative_prob THEN

            -- Return the index of the selected item

            RETURN I;

        END IF;

    END LOOP;



    RETURN NULL; -- Return NULL if no index is selected

END;

$$;


ALTER FUNCTION public.random_selection_of_index_from_array_with_weight(inp_array_weights real[], inp_additionnal_weight integer) OWNER TO postgres;

--
-- Name: reset_project(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.reset_project() RETURNS void
    LANGUAGE plpgsql
    AS $$

DECLARE

    table_name TEXT;
    multiverse RECORD; -- Record of the multiverse
    loc_date_start timestamp with time zone;
    loc_interval_1_week INTERVAL; -- Time for a week in a given multiverse

BEGIN

    PERFORM set_config('statement_timeout', '5min', true);


    -- List of table names to alter sequences

    FOR table_name IN

        SELECT unnest(ARRAY['leagues'
        ,'clubs', 'clubs_history'
        ,'players', 'players_history'
        ,'games', 'game_events', 'games_teamcomp', 'game_orders', 'games_stats'
        ,'fans'
        ,'finances'
        ,'messages_mail'
        --,'stadiums'
        --,'transfers_bids'
        ]) -- Add your table names here

    LOOP
	    -- Delete tables
	    EXECUTE 'TRUNCATE TABLE ' || quote_ident(table_name) || ' CASCADE;';
	    

        -- Construct and execute the ALTER SEQUENCE command for each table

        EXECUTE 'ALTER SEQUENCE ' || pg_get_serial_sequence(table_name, 'id') || ' RESTART WITH 1';

    END LOOP;
--RETURN;

    UPDATE profiles SET id_default_club = NULL;

    
    FOR multiverse IN (
        SELECT * FROM multiverses
        --WHERE speed = 1
        )
    LOOP
        
        -- Multiverse interval for 1 week
        loc_interval_1_week := INTERVAL '7 days' / multiverse.speed;
        
        -- When the season starts (TWEAK HERE FOR MODIFING GAMES ORGANIZATION)
--        loc_date_start := date_trunc('week', current_date) + INTERVAL '5 days 20 hours' - (loc_interval_1_week * 5);
        --loc_date_start := date_trunc('week', current_date) + INTERVAL '20 hours' - (loc_interval_1_week * 12);
        --loc_date_start := date_trunc('hour', CURRENT_TIMESTAMP) - (loc_interval_1_week * 15);
        loc_date_start := date_trunc('hour', CURRENT_TIMESTAMP); -- + INTERVAL '1 hour';

        -- Update multiverse row
        UPDATE multiverses SET
            date_season_start = loc_date_start,
            date_season_end = loc_date_start + (loc_interval_1_week * 14),
            season_number = 1, week_number = 1, day_number = 1,
            cash_printed = 0,
            last_run = now(), error = NULL
            WHERE speed = multiverse.speed;
        
    END LOOP;

    -- Generate leagues, clubs and players
    PERFORM initialize_leagues_teams_and_players();

    INSERT INTO game_orders (id_teamcomp, id_player_out, id_player_in, minute)
    VALUES (1, 1, 2, 40);

    --UPDATE clubs SET cash = 100000 WHERE id IN (1,2);
    --UPDATE clubs SET cash = -100000 WHERE id = 3;

    -- Set clubs to test user
    update clubs set id_country = 83, username='zOuateRabbit' WHERE id IN (44);
    update clubs set id_country = 83, username='Mathiasdelabitas', name = 'Mat FC' WHERE id in (43);
    --update clubs set username='Mathiasdelabitas' WHERE id IN(2,3,4,5,6);
    --update players set username='zOuateRabbit' where id in (1,2,3);
    --update players set username='Mathiasdelabitas' where id in (4,5,6);

    -- Simulate games
    --CALL main();




END $$;


ALTER FUNCTION public.reset_project() OWNER TO postgres;

--
-- Name: simulate_game_calculate_game_weights(real[], bigint[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.simulate_game_calculate_game_weights(inp_player_array real[], inp_subs bigint[]) RETURNS double precision[]
    LANGUAGE plpgsql
    AS $$

DECLARE

    -- team_weights float8[7] := '{1000,1000,1000,1000,1000,1000,1000}'; -- Returned array holding team stats {LeftDefense, CentralDefense, RightDefense, MidField, LeftAttack, CentralAttack, RightAttack}

    team_weights float4[7] := '{100,100,100,100,100,100,100}'; -- Returned array holding team stats {LeftDefense, CentralDefense, RightDefense, MidField, LeftAttack, CentralAttack, RightAttack}

    player_stats float4[12]; -- Players stats array {keeper, defense, passes, playmaking, winger, scoring, freekick, motivation, form, experience, stamina, energy}

    player_weights float4[7]; -- Tmp array for holding player stats and weights

    loc_energy_coefficient float4;

BEGIN

    -- Loop through the 14 positions of the team

    FOR i IN 1..14 LOOP

        -- Fetch the stats of the player playing at the position i {keeper, defense, passes, playmaking, winger, scoring, freekick}

        FOR j IN 1..12 LOOP

            player_stats[j] := inp_player_array[inp_subs[i]][j];

        END LOOP;



        -- Fetch the weights of the player playing at the position i  {LeftDefense, CentralDefense, RightDefense, MidField, LeftAttack, CentralAttack, RightAttack}

        -- player_weights := players_calculate_player_weight(player_stats, i);

        player_weights := players_calculate_player_weight(player_stats, i);



        -- Calculate the energy coefficient of the player

        loc_energy_coefficient := player_stats[12] / 100.0;



        -- Add the player weights to the team weights

        FOR j IN 1..7 LOOP

            team_weights[j] := team_weights[j] + player_weights[j] * loc_energy_coefficient;

        END LOOP;

    END LOOP;



    RETURN team_weights;

END;

$$;


ALTER FUNCTION public.simulate_game_calculate_game_weights(inp_player_array real[], inp_subs bigint[]) OWNER TO postgres;

--
-- Name: simulate_game_fetch_player_for_event(bigint[], double precision[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.simulate_game_fetch_player_for_event(inp_array_player_ids bigint[], inp_array_multiplier double precision[] DEFAULT '{1,1,1,1,1,1,1,1,1,1,1,1,1,1}'::double precision[]) RETURNS bigint
    LANGUAGE plpgsql
    AS $$

DECLARE

    loc_sum float8 := 0; -- Sum of the multipliers

    loc_cumulative_prob float8 := 0; -- Cumulative probability

    loc_random_value float8; -- Random value

    I int8; -- Index for the loop

BEGIN



    -- Calculate the sum of the weights

    FOR I IN 1..14 LOOP

        loc_sum := loc_sum + inp_array_multiplier[I];

    END LOOP;



    -- Generate random value and select player

    loc_random_value := random();

    FOR I IN 1..14 LOOP

        loc_cumulative_prob := loc_cumulative_prob + (inp_array_multiplier[I] / loc_sum);

        IF loc_random_value <= loc_cumulative_prob THEN

            RETURN I;

            EXIT;

        END IF;

    END LOOP;



    RETURN NULL;

END;

$$;


ALTER FUNCTION public.simulate_game_fetch_player_for_event(inp_array_player_ids bigint[], inp_array_multiplier double precision[]) OWNER TO postgres;

--
-- Name: simulate_game_fetch_player_stats(bigint[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.simulate_game_fetch_player_stats(inp_player_ids bigint[]) RETURNS double precision[]
    LANGUAGE plpgsql
    AS $$

DECLARE

    player_stats float8[21][12] := array_fill(0::float8, ARRAY[21,12]);

    temp_stats float8[10]; -- Temporary array to hold stats for a single player

    i INT;

    j INT;

BEGIN



    ------ Loop through the input player IDs and fetch their stats

    FOR i IN 1..21 LOOP -- 21 players per game per team

        IF inp_player_ids[i] IS NOT NULL THEN

            -- Select player stats into temp_stats

            SELECT ARRAY[keeper, defense, passes, playmaking, winger, scoring, freekick,

                motivation, form, experience, stamina, energy]

            INTO temp_stats

            FROM players

            WHERE id = inp_player_ids[i];



            IF FOUND THEN

                FOR j IN 1..12 LOOP -- Loop through the 12 player stats

                    player_stats[i][j] := temp_stats[j];

                END LOOP;

            ELSE

                RAISE EXCEPTION 'Player with ID % not found', inp_player_ids[i];

            END IF;

        END IF;

    END LOOP;



    ------ Return the player stats array

    RETURN player_stats;



END;

$$;


ALTER FUNCTION public.simulate_game_fetch_player_stats(inp_player_ids bigint[]) OWNER TO postgres;

--
-- Name: simulate_game_fetch_random_player_id_based_on_weight_array(bigint[], real[], real, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.simulate_game_fetch_random_player_id_based_on_weight_array(inp_array_player_ids bigint[], inp_array_weights real[] DEFAULT NULL::real[], inp_offset_values real DEFAULT NULL::real, inp_null_possible boolean DEFAULT false) RETURNS bigint
    LANGUAGE plpgsql
    AS $$

DECLARE

    loc_number_of_elements int8 := array_length(inp_array_player_ids, 1); -- Number of elements in the array

    loc_fetched_index int8; -- Index of the fetched player

BEGIN



    -- If the multiplier array is not provided, set all the multipliers to 1

    IF inp_array_weights IS NULL THEN

        FOR I IN 1..loc_number_of_elements LOOP

            inp_array_weights[I] := 1;

        END LOOP;

    END IF;

    IF inp_offset_values IS NOT NULL THEN

        FOR I IN 1..loc_number_of_elements LOOP

            inp_array_weights[I] := inp_array_weights[I] + inp_offset_values;

        END LOOP;

    END IF;



    -- Randomly select index based on the weight

    loc_fetched_index := random_selection_of_index_from_array_with_weight(inp_array_weights := inp_array_weights);



    -- Handle the null return value

    IF loc_fetched_index IS NULL THEN

        IF inp_null_possible THEN

            RETURN NULL;

        ELSE -- If no player is selected and null is not possible, raise an exception

            RAISE EXCEPTION 'NULL index selected in function simulate_game_fetch_random_player_id_based_on_weight_array';

        END IF;

    -- If the index is out of bounds, raise an exception

    ELSIF loc_fetched_index > loc_number_of_elements THEN

        RAISE EXCEPTION 'Index fetched is greater than the number of elements in the array in function simulate_game_fetch_random_player_id_based_on_weight_array';

    -- If the index is less than 1, raise an exception

    ELSIF loc_fetched_index < 1 THEN

        RAISE EXCEPTION 'Index fetched is less than 1 in function simulate_game_fetch_random_player_id_based_on_weight_array';

    -- If the fetched index is null, return null if null is possible, otherwise raise an exception

    ELSIF inp_array_player_ids[loc_fetched_index] IS NULL THEN

        IF inp_null_possible THEN

            RETURN NULL;

        ELSE

            RAISE EXCEPTION 'NULL id selected in function simulate_game_fetch_random_player_id_based_on_weight_array';

        END IF;

    -- If everything is fine, return the fetched player id

    ELSE

        RETURN inp_array_player_ids[loc_fetched_index];

    END IF;



    RETURN NULL;

END;

$$;


ALTER FUNCTION public.simulate_game_fetch_random_player_id_based_on_weight_array(inp_array_player_ids bigint[], inp_array_weights real[], inp_offset_values real, inp_null_possible boolean) OWNER TO postgres;

--
-- Name: simulate_game_goal_opportunity(record, public.game_context, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.simulate_game_goal_opportunity(rec_game record, context public.game_context, is_left_club boolean) RETURNS TABLE(is_goal boolean)
    LANGUAGE plpgsql
    AS $$

DECLARE

    loc_matrix_side_multiplier float4[14][3] := '{

                        {0,0,0},

        {5,2,1},{2,4,1},{1,5,1},{1,4,2},{1,2,5},

        {5,2,1},{2,4,1},{1,5,1},{1,4,2},{1,2,5},

                {5,2,1},{3,5,3},{1,2,5}

        }'; -- Matrix to hold the multiplier to get the players that made the event (14 players, 3 sides(left, center, right))

    loc_array_attack_multiplier float4[14] := '{

            0,

        2,1,1,1,2,

        3,2,2,2,3,

          5,5,5

        }'; -- Array to hold the multiplier to get the offensive players

    loc_array_defense_multiplier float4[14] := '{

            2,

        5,5,5,5,5,

        3,3,3,3,3,

          1,1,1

        }'; -- Array to hold the multiplier to get the offensive players

    I INT;

    J INT;

    loc_weight_attack float4 := 0; -- The weight of the attack

    loc_weight_defense float4 := 0; -- The weight of the defense

    loc_sum_weights_attack float4 := 0;

    loc_sum float8 := 0;

    loc_array_weights float4[14]; -- Array to hold the multipliers of the players

    loc_id_player_attack INT8; -- The ID of the player who made the event

    loc_id_player_passer INT8; -- The ID of the player who made the pass

    loc_id_player_defense INT8; -- The ID of the player who defended

    random_value float4;

    loc_pos_striking INT8 := 6; -- The position of striking in the list of 7 stats ()

    loc_pos_defense INT8:= 2; -- The position of defense in the list of 7 stats

    loc_pos_passing INT8 := 3; -- The position of passing in the list of 7 stats

    loc_event_type TEXT; -- Event type 'Goal', Opportunity', 'Injury' etc...

    loc_array_team_weights_attack float4[];

    loc_array_team_weights_defense float4[];

    loc_array_player_ids_attack int8[];

    loc_array_player_ids_defense int8[];

    loc_matrix_player_stats_attack float4[][];

    loc_matrix_player_stats_defense float4[][];

BEGIN

    IF is_left_club THEN

        loc_array_team_weights_attack := context.loc_array_team_weights_left;

        loc_array_team_weights_defense := context.loc_array_team_weights_right;

        loc_array_player_ids_attack := context.loc_array_players_id_left;

        loc_array_player_ids_defense := context.loc_array_players_id_right;

        loc_matrix_player_stats_attack := context.loc_matrix_player_stats_left;

        loc_matrix_player_stats_defense := context.loc_matrix_player_stats_right;

    ELSE

        loc_array_team_weights_attack := context.loc_array_team_weights_right;

        loc_array_team_weights_defense := context.loc_array_team_weights_left;

        loc_array_player_ids_attack := context.loc_array_players_id_right;

        loc_array_player_ids_defense := context.loc_array_players_id_left;

        loc_matrix_player_stats_attack := context.loc_matrix_player_stats_right;

        loc_matrix_player_stats_defense := context.loc_matrix_player_stats_left;

    END IF;

--RAISE NOTICE 'Right: %', context.loc_array_team_weights_right;

--RAISE NOTICE 'Left: %', context.loc_array_team_weights_left;



    -- Initialize the attack weight

    loc_sum_weights_attack := loc_array_team_weights_attack[5]+loc_array_team_weights_attack[6]+loc_array_team_weights_attack[7]; -- Sum of the attack weights of the attack team



    -- Random value to check which side is the attack

    random_value := random();



    -- Check which side is the attack with a loop

    FOR I IN 1..3 LOOP

        -- Add the weight of the side to the sum

        loc_sum := loc_sum + loc_array_team_weights_attack[4+I];



        IF random_value < (loc_sum / loc_sum_weights_attack) THEN -- Then the attack is on this side

            -- Fetch the attacker of the event

            FOR J IN 1..14 LOOP

                loc_array_weights[J] := loc_array_attack_multiplier[J] * loc_matrix_side_multiplier[J][I] * loc_matrix_player_stats_attack[J][loc_pos_striking]; -- Calculate the multiplier to fetch players for the event

            END LOOP;

            

            loc_id_player_attack = simulate_game_fetch_random_player_id_based_on_weight_array(

                inp_array_player_ids := loc_array_player_ids_attack[1:14],

                inp_array_weights := loc_array_weights,

                inp_offset_values := 1,

                inp_null_possible := true); -- Fetch the player who scored for this event

            

            -- Fetch the player who made the pass if an attacker was found

            IF loc_id_player_attack IS NOT NULL THEN

                FOR J IN 1..14 LOOP

                    loc_array_weights[J] = loc_array_attack_multiplier[J] * loc_matrix_side_multiplier[J][I] * loc_matrix_player_stats_attack[J][loc_pos_passing]; -- Calculate the multiplier to fetch players for the EVENT

                    IF loc_array_player_ids_attack[J] = loc_id_player_attack THEN

                        loc_array_weights[J] = 0; -- Set the attacker to 0 cause he cant be passer

                    END IF;

                END LOOP;

                

                loc_id_player_passer = simulate_game_fetch_random_player_id_based_on_weight_array(

                    inp_array_player_ids := loc_array_player_ids_attack[1:14],

                    inp_array_weights := loc_array_weights,

                    inp_offset_values := 1,

                    inp_null_possible := true); -- Fetch the player who passed the ball to the striker for this event

            END IF;



            -- Fetch the defender of the event

            FOR J IN 1..14 LOOP

                IF loc_matrix_player_stats_defense[J][loc_pos_defense] + 1 <> 0 THEN

                    loc_array_weights[J] = loc_array_defense_multiplier[J] * loc_matrix_side_multiplier[J][I] * (1 / (loc_matrix_player_stats_defense[J][loc_pos_defense] + 1)); -- Calculate the multiplier to fetch players for the event

                ELSE

                    loc_array_weights[J] = 0;

                END IF;

            END LOOP;

            

            loc_id_player_defense = simulate_game_fetch_random_player_id_based_on_weight_array(

                inp_array_player_ids := loc_array_player_ids_defense[1:14],

                inp_array_weights := loc_array_weights,

                inp_offset_values := 1,

                inp_null_possible := true); -- Fetch the opponent player responsible for the goal (only for description)



             -- Weight of the attack

            loc_weight_attack := loc_array_team_weights_attack[4+I];

            -- Weight of the defense

            loc_weight_defense := loc_array_team_weights_defense[I];



            -- Check if the attack is successful

            IF random() < ((loc_weight_attack / loc_weight_defense) - 0.5) THEN

                loc_event_type := 'goal';

                is_goal := true;

            ELSE

                loc_event_type := 'opportunity';

                is_goal := false;

            END IF;

            

            EXIT;

        END IF;

    END LOOP;



    -- Insert into the game events table and return the id of the newly inserted row

    INSERT INTO game_events(id_game, id_club, id_player, id_player2, id_player3, event_type, game_period, game_minute, date_event)

    VALUES (

        rec_game.id, -- The id of the game

        CASE WHEN is_left_club THEN rec_game.id_club_left ELSE rec_game.id_club_right END, -- The id of the club

        loc_id_player_attack, -- The id of the attacker

        loc_id_player_passer, -- The id of the passer

        loc_id_player_defense, -- The id of the defender

        loc_event_type, -- Type of the event

        context.loc_period_game, -- The period of the game

        context.loc_minute_game, -- The minute of the game

        context.loc_date_start_period + INTERVAL '1 minute' * context.loc_minute_game -- The date of the event

    );



    RETURN QUERY SELECT is_goal;

END;

$$;


ALTER FUNCTION public.simulate_game_goal_opportunity(rec_game record, context public.game_context, is_left_club boolean) OWNER TO postgres;

--
-- Name: simulate_game_handle_orders(bigint, bigint[], bigint[], bigint, bigint, timestamp without time zone, bigint, record); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.simulate_game_handle_orders(inp_teamcomp_id bigint, array_players_id bigint[], array_substitutes bigint[], game_minute bigint, game_period bigint, period_start timestamp without time zone, score bigint, game record) RETURNS integer[]
    LANGUAGE plpgsql
    AS $$

DECLARE

    game_order RECORD;

    pos_position_out INTEGER;

    pos_position_in INTEGER;

BEGIN

    FOR game_order IN

        (SELECT * FROM game_orders

            WHERE id_teamcomp = inp_teamcomp_id

            AND minute <= game_minute

            AND (condition IS NULL OR score >= condition)

            AND minute_real IS NULL)

    LOOP

        pos_position_out := NULL;

        pos_position_in := NULL;

        -- Loop through the players id to find the 2 players to substitute

        FOR i IN 1..21 LOOP

            -- Store the position of the players to substitute

            IF array_players_id[i] = game_order.id_player_out THEN

                pos_position_out := i;

            END IF;

            IF array_players_id[i] = game_order.id_player_in THEN

                pos_position_in := i;

            END IF;

        END LOOP;

        -- Check if the players are found in the teamcomp

        IF pos_position_out IS NULL THEN

            -- Store the event in the game

            INSERT INTO game_events (id_game, id_event_type, id_club, game_period, game_minute, date_event, id_player)

            VALUES (game.id, 8, game.id_club_left, game_period, game_minute, period_start + (INTERVAL '1 minute' * game_minute), game_order.id_player_out);

        

            -- Update the game order

            UPDATE game_orders SET minute_real = -1 WHERE id = game_order.id;

        ELSIF pos_position_in IS NULL THEN

            -- Store the event in the game

            INSERT INTO game_events (id_game, id_event_type, id_club, game_period, game_minute, date_event, id_player)

            VALUES (game.id, 8, game.id_club_left, game_period, game_minute, period_start + (INTERVAL '1 minute' * game_minute), game_order.id_player_in);

        

            -- Update the game order

            UPDATE game_orders SET minute_real = -1 WHERE id = game_order.id;

        ELSE

            -- Substitute the players

            array_substitutes[pos_position_out] := pos_position_in;

            array_substitutes[pos_position_in] := pos_position_out;

            -- Store the event in the game

            INSERT INTO game_events (id_game, event_type, id_club, game_period, game_minute, date_event, id_player, id_player2)

            VALUES (game.id, 'substitution', game.id_club_left, game_period, game_minute, period_start + (INTERVAL '1 minute' * game_minute), game_order.id_player_in, game_order.id_player_out);

        

            -- Update the game order

            UPDATE game_orders SET minute_real = game_minute WHERE id = game_order.id;

        END IF;

    END LOOP;



    -- Return the substitutes array

    RETURN array_substitutes;

END;

$$;


ALTER FUNCTION public.simulate_game_handle_orders(inp_teamcomp_id bigint, array_players_id bigint[], array_substitutes bigint[], game_minute bigint, game_period bigint, period_start timestamp without time zone, score bigint, game record) OWNER TO postgres;

--
-- Name: simulate_game_main(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.simulate_game_main(inp_id_game bigint) RETURNS void
    LANGUAGE plpgsql
    AS $$

DECLARE

    rec_game RECORD; -- Record of the game

    loc_array_players_id_left int8[21]; -- Array of players id for 21 slots of players

    loc_array_players_id_right int8[21]; -- Array of players id for 21 slots of players

    loc_array_substitutes_left int4[21] := ARRAY[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21]; -- Array for storing substitutions

    loc_array_substitutes_right int4[21] := ARRAY[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21]; -- Array for storing substitutions

    loc_matrix_player_stats_left float4[21][12]; -- Matrix to hold player stats [21 players x {keeper, defense, passes, playmaking, winger, scoring, freekick, motivation, form, experience, stamina, energy}]

    loc_matrix_player_stats_right float4[21][12]; -- Matrix to hold player stats [21 players x {keeper, defense, passes, playmaking, winger, scoring, freekick, motivation, form, experience, stamina, energy}]

    loc_matrix_player_weights_left float4[14][7]; -- Matrix to hold player weights [14 players x {left defense, central defense, right defense, midfield, left attack, central attack, right attack}]

    loc_matrix_player_weights_right float4[14][7]; -- Matrix to hold player weights [14 players x {left defense, central defense, right defense, midfield, left attack, central attack, right attack}]

    loc_array_team_weights_left float4[7]; -- Array for team weights [left defense, central defense, right defense, midfield, left attack, central attack, right attack]

    loc_array_team_weights_right float4[7]; -- Array for team weights [left defense, central defense, right defense, midfield, left attack, central attack, right attack]

    loc_period_game int; -- The period of the game (e.g., first half, second half, extra time)

    loc_minute_period_start int; -- The minute where the period starts

    loc_minute_period_end int := 0; -- The minute where the period ends

    loc_minute_period_extra_time int; -- The extra time for the period

    loc_minute_game int; -- The minute of the game

    loc_date_start_period timestamp; -- The date and time of the period

    loc_score_left int := 0; -- The score of the left team

    loc_score_right int := 0; -- The score of the right team

    loc_score_penalty_left int; -- The score of the left team for the penalty shootout

    loc_score_penalty_right int; -- The score of the right team for the penalty shootout

    loc_score_left_previous int := 0; -- The score of the left team previous game

    loc_score_right_previous int := 0; -- The score of the right team with previous game

    minutes_half_time int8 := 45; -- 45

    minutes_extra_time int8 := 15; -- 15

    penalty_number int8; -- The number of penalties

    context game_context; -- Game context

    index_player int; -- Index of the player

BEGIN

    ------------------------------------------------------------------------------------------------------------------------------------------------

    ------------------------------------------------------------------------------------------------------------------------------------------------

    ------------ Step 1: Get game details and initial checks

    SELECT games.*,

        gtl.id AS id_teamcomp_club_left, 

        gtr.id AS id_teamcomp_club_right,

        cl.name AS name_club_left, cl.username AS username_club_left,

        cr.name AS name_club_right, cr.username AS username_club_right

    INTO rec_game 

    FROM games

    JOIN games_teamcomp gtl ON games.id_club_left = gtl.id_club AND games.season_number = gtl.season_number AND games.week_number = gtl.week_number

    JOIN games_teamcomp gtr ON games.id_club_right = gtr.id_club AND games.season_number = gtr.season_number AND games.week_number = gtr.week_number

    JOIN clubs cl ON games.id_club_left = cl.id

    JOIN clubs cr ON games.id_club_right = cr.id

    WHERE 

        games.id = inp_id_game;



    IF NOT FOUND THEN

        RAISE EXCEPTION 'Game [%] does not exist or the teamcomp was not found for the JOIN', inp_id_game;

    ELSIF rec_game.date_end IS NOT NULL THEN

        RAISE EXCEPTION 'Game [%] has already being played', inp_id_game;

    ELSIF rec_game.id_club_left IS NULL THEN

        RAISE EXCEPTION 'Game [%] doesnt have any left club defined', inp_id_game;

    ELSIF rec_game.id_club_right IS NULL THEN

        RAISE EXCEPTION 'Game [%] doesnt have any right club defined', inp_id_game;

    ELSIF rec_game.id_teamcomp_club_left IS NULL THEN

        RAISE EXCEPTION 'Game [%]: Teamcomp not found for club % for season % and week %', inp_id_game, rec_game.id_club_left, rec_game.season_number, rec_game.week_number;

    ELSIF rec_game.id_teamcomp_club_right IS NULL THEN

        RAISE EXCEPTION 'Game [%]: Teamcomp not found for club % for season % and week %', inp_id_game, rec_game.id_club_right, rec_game.season_number, rec_game.week_number;

    END IF;





    ------ Set that the game is_playing

    UPDATE games SET

        is_playing = TRUE

    WHERE id = rec_game.id;



    ------ Update the games teamcomp to say that the game is played

    UPDATE games_teamcomp SET

        is_played = TRUE

    WHERE id IN (rec_game.id_teamcomp_club_left, rec_game.id_teamcomp_club_right);



    ------------------------------------------------------------------------------------------------------------------------------------------------

    ------------------------------------------------------------------------------------------------------------------------------------------------

    ------------ Step 2: Check teamcomps

    ------ Check if there is an error in the left teamcomp

--RAISE NOTICE '###### Game [%] - Checking teamcomps % - %', inp_id_game, rec_game.id_club_left, rec_game.id_club_right;

--RAISE NOTICE '###### Game [%] - Club% [%] VS Club% [%]', inp_id_game, rec_game.id_club_left, (SELECT array_agg(id) FROM players where id_club = rec_game.id_club_left), rec_game.id_club_right, (SELECT array_agg(id) FROM players where id_club = rec_game.id_club_right);

    BEGIN 

        ---- If the left teamcomp has an error, then try to correct it

        IF teamcomp_check_and_try_populate_if_error(

            inp_id_teamcomp := rec_game.id_teamcomp_club_left)

        IS NOT TRUE THEN

            loc_score_left := -1;

        END IF;

    EXCEPTION

        WHEN OTHERS THEN

            loc_score_left := -1;

    END;

    

    ------ Check if there is an error in the right teamcomp

    BEGIN

        ---- If the right teamcomp has an error, then try to correct it

        IF teamcomp_check_and_try_populate_if_error(

            inp_id_teamcomp := rec_game.id_teamcomp_club_right)

        IS NOT TRUE THEN

            loc_score_right := -1;

        END IF;

    EXCEPTION

        WHEN OTHERS THEN

            loc_score_right := -1;

    END;



-- RAISE NOTICE 'Game [%] - Club% [% - %] Club%', inp_id_game, rec_game.id_club_left, loc_score_left, loc_score_right, rec_game.id_club_right;



    ------ If one of the clubs is forfeit

    IF loc_score_left = -1 OR loc_score_right = -1 THEN

        ---- If both clubs are forfeit

        IF loc_score_left = -1 AND loc_score_right = -1 THEN



            -- Send mails to the clubs

            INSERT INTO messages_mail (id_club_to, created_at, sender_role, title, message)

            VALUES

                (rec_game.id_club_left, rec_game.date_start, 'Referee',

                    'ERROR TEAMCOMP: For ' || string_parser(rec_game.id, 'idGame') || ' of S' || rec_game.season_number || 'W' || rec_game.week_number,

                    'We were not able to give a valid teamcomp for the ' || string_parser(rec_game.id, 'idGame') || ' of S' || rec_game.season_number || 'W' || rec_game.week_number || ' against ' || rec_game.name_club_right || ' but they didnt either, we will see what the league decides but it might end with a draw'),

                (rec_game.id_club_right, rec_game.date_start, 'Referee',

                    'ERROR TEAMCOMP: For ' || string_parser(rec_game.id, 'idGame') || ' of S' || rec_game.season_number || 'W' || rec_game.week_number,

                    'We were not able to give a valid teamcomp for the ' || string_parser(rec_game.id, 'idGame') || ' of S' || rec_game.season_number || 'W' || rec_game.week_number || ' against ' || rec_game.name_club_left || ' but they didnt either, we will see what the league decides but it might end with a draw');



        ---- If the left club is forfeit

        ELSEIF loc_score_left = -1 THEN

            loc_score_right := 3; -- Set the right club as winner by 3-0



            -- Send mails to the clubs

            INSERT INTO messages_mail (id_club_to, created_at, sender_role, title, message)

            VALUES

                (rec_game.id_club_left, rec_game.date_start, 'Referee',

                    'ERROR TEAMCOMP: For ' || string_parser(rec_game.id, 'idGame') || ' of S' || rec_game.season_number || 'W' || rec_game.week_number,

                    'We were not able to give a valid teamcomp for the ' || string_parser(rec_game.id, 'idGame') || ' of S' || rec_game.season_number || 'W' || rec_game.week_number || ' against ' || rec_game.name_club_right || ' is not valid, we will see what the league decides but it might end with a 3-0 defeat'),

                (rec_game.id_club_right, rec_game.date_start, 'Referee',

                    'ERROR TEAMCOMP: For ' || string_parser(rec_game.id, 'idGame') || ' of S' || rec_game.season_number || 'W' || rec_game.week_number,

                    rec_game.name_club_left || ', our opponent for the ' || string_parser(rec_game.id, 'idGame') || ' of S' || rec_game.season_number || 'W' || rec_game.week_number || ' was not able to give a valid teamcomp, we will see what the league decides but it might end with a 3-0 victory');



        ---- If the right club is forfeit

        ELSE

            loc_score_left := 3; -- Set the left club as winner by 3-0



            -- Send mails to the clubs

            INSERT INTO messages_mail (id_club_to, created_at, sender_role, title, message)

            VALUES

                (rec_game.id_club_left, rec_game.date_start, 'Referee',

                    string_parser(rec_game.id, 'idGame') || ' of S' || rec_game.season_number || 'W' || rec_game.week_number || ': Opponent has no valid teamcomp',

                    rec_game.name_club_right || ', our opponent for the ' || string_parser(rec_game.id, 'idGame') || ' of S' || rec_game.season_number || 'W' || rec_game.week_number || ' was not able to give a valid teamcomp, we will see what the league decides but it might end with a 3-0 victory'),

                (rec_game.id_club_right, rec_game.date_start, 'Referee',

                    string_parser(rec_game.id, 'idGame') || ' of S' || rec_game.season_number || 'W' || rec_game.week_number || ': Cannot validate teamcomp',

                    'We were not able to give a valid teamcomp for the ' || string_parser(rec_game.id, 'idGame') || ' of S' || rec_game.season_number || 'W' || rec_game.week_number || ' against ' || rec_game.name_club_left || ' is not valid, we will see what the league decides but it might end with a 3-0 defeat');



        END IF;



    ------ If the game needs to be simulated, then set the initial score

    ELSE

        ------------------------------------------------------------------------------------------------------------------------------------------------

        ------------------------------------------------------------------------------------------------------------------------------------------------

        ------------ Step 2: Fetch, calculate and store data in arrays

        ------ Fetch players id of the club for this game

        loc_array_players_id_left := teamcomp_fetch_players_id(inp_id_teamcomp := rec_game.id_teamcomp_club_left);

        loc_array_players_id_right := teamcomp_fetch_players_id(inp_id_teamcomp := rec_game.id_teamcomp_club_right);



            ------ Update player to say they are currently playing a game

        UPDATE players SET

            is_playing = TRUE,

            id_games_played = id_games_played || rec_game.id

        WHERE id = ANY(loc_array_players_id_left)

           OR id = ANY(loc_array_players_id_right);

        

        ------ Fetch constant player stats matrix

        loc_matrix_player_stats_left := simulate_game_fetch_player_stats(loc_array_players_id_left);

        loc_matrix_player_stats_right := simulate_game_fetch_player_stats(loc_array_players_id_right);



        ------------------------------------------------------------------------------------------------------------------------------------------------

        ------------------------------------------------------------------------------------------------------------------------------------------------

        ------------ Step 3: Simulate game

        ------ Loop through the periods of the game (e.g., first half, second half, extra time)

        FOR loc_period_game IN 1..4 LOOP



            ---- Set the minute where the period ends

            IF loc_period_game = 1 THEN

                loc_date_start_period := rec_game.date_start; -- Start date of the first period is the start date of the game

                loc_minute_period_start := 0; -- Start minute of the first period

                loc_minute_period_end := loc_minute_period_start + minutes_half_time; -- Start minute of the first period

                loc_minute_period_extra_time := 2 + ROUND(random() * 3); -- Extra time for the period

            ELSEIF loc_period_game = 2 THEN

                loc_date_start_period := loc_date_start_period + (45 + loc_minute_period_extra_time) * INTERVAL '1 minute'; -- Start date of the second period is the start date of the game plus 45 minutes + extra time

                loc_minute_period_start := 45; -- Start minute of the second period

                loc_minute_period_end := loc_minute_period_start + minutes_half_time; -- Start minute of the first period

                loc_minute_period_extra_time := 3 + ROUND(random() * 5); -- Extra time for the period



                ------ Update players energy

                FOR I IN 1..21 LOOP

                    ---- Increase energy

                    loc_matrix_player_stats_left[I][12] := loc_matrix_player_stats_left[I][12] + 10.0 * (1.0 + loc_matrix_player_stats_left[I][11]/100.0);

                    loc_matrix_player_stats_right[I][12] := loc_matrix_player_stats_right[I][12] + 10.0 * (1.0 + loc_matrix_player_stats_right[I][11]/100.0);

                END LOOP;



            ELSEIF loc_period_game = 3 THEN

                loc_score_left_previous := COALESCE(rec_game.score_previous_left, 0);

                loc_score_right_previous := COALESCE(rec_game.score_previous_right, 0);

                -- Check if the game is over already (e.g., if the game is not a cup game or if the scores are different)

                IF rec_game.is_cup = FALSE

                    AND (loc_score_left + loc_score_left_previous) <> (loc_score_right + loc_score_right_previous) THEN

                    EXIT; -- If the game is over, then exit the loop

                END IF;

                loc_date_start_period := loc_date_start_period + (45 + loc_minute_period_extra_time) * INTERVAL '1 minute'; -- Start date of the first prolongation is the start date of the second half plus 45 minutes + extra time

                loc_minute_period_start := 90; -- Start minute of the first period

                loc_minute_period_end := loc_minute_period_start + minutes_extra_time; -- Start minute of the first period

                loc_minute_period_extra_time := ROUND(random() * 2); -- Extra time for the period



                ------ Update players energy

                FOR I IN 1..21 LOOP

                    ---- Increase energy

                    loc_matrix_player_stats_left[I][12] := loc_matrix_player_stats_left[I][12] + 5.0 * (1.0 + loc_matrix_player_stats_left[I][11]/100.0);

                    loc_matrix_player_stats_right[I][12] := loc_matrix_player_stats_right[I][12] + 5.0 * (1.0 + loc_matrix_player_stats_right[I][11]/100.0);

                END LOOP;



            ELSE

                loc_date_start_period := loc_date_start_period + (15 + loc_minute_period_extra_time) * INTERVAL '1 minute'; -- Start date of the second prolongation is the start date of the first prolongation plus 15 minutes + extra time

                loc_minute_period_start := 105; -- Start minute of the first period

                loc_minute_period_end := loc_minute_period_start + minutes_extra_time; -- Start minute of the first period

                loc_minute_period_extra_time := 2 + ROUND(random() * 4); -- Extra time for the period



                ------ Update players energy

                FOR I IN 1..21 LOOP

                    ---- Increase energy

                    loc_matrix_player_stats_left[I][12] := loc_matrix_player_stats_left[I][12] + 5.0 * (1.0 + loc_matrix_player_stats_left[I][11]/100.0);

                    loc_matrix_player_stats_right[I][12] := loc_matrix_player_stats_right[I][12] + 5.0 * (1.0 + loc_matrix_player_stats_right[I][11]/100.0);

                END LOOP;

            END IF;



            ------ Cheat CODE to calculate only once

            ------ Calculate team weights (Array of 7 floats: LeftDefense, CentralDefense, RightDefense, MidField, LeftAttack, CentralAttack, RightAttack)

            --loc_array_team_weights_left := simulate_game_calculate_game_weights(loc_matrix_player_stats_left, loc_array_substitutes_left);

            --loc_array_team_weights_right := simulate_game_calculate_game_weights(loc_matrix_player_stats_right, loc_array_substitutes_right);



            ------ Iterate through the minutes of the game to generate the events of the game

            FOR loc_minute_game IN loc_minute_period_start..loc_minute_period_end + loc_minute_period_extra_time LOOP

     

                ------------------------------------------------------------------------

                ------------------------------------------------------------------------

                ------ Handle orders

                -- Handle orders for left club

                -- loc_array_substitutes_left := simulate_game_handle_orders(

                --     inp_teamcomp_id := rec_game.id_teamcomp_club_left,

                --     array_players_id := loc_array_players_id_left,

                --     array_substitutes := loc_array_substitutes_left,

                --     game_minute := loc_minute_game,

                --     game_period := loc_period_game,

                --     period_start := loc_date_start_period,

                --     score := loc_score_left - loc_score_right,

                --     game := rec_game);



                -- -- Handle orders for right club

                -- loc_array_substitutes_right := simulate_game_handle_orders(

                --     inp_teamcomp_id := rec_game.id_teamcomp_club_right,

                --     array_players_id := loc_array_players_id_right,

                --     array_substitutes := loc_array_substitutes_right,

                --     game_minute := loc_minute_game,

                --     game_period := loc_period_game,

                --     period_start := loc_date_start_period,

                --     score := loc_score_right - loc_score_left,

                --     game := rec_game);



                ------ Calculate team weights (Array of 7 floats: LeftDefense, CentralDefense, RightDefense, MidField, LeftAttack, CentralAttack, RightAttack)

                loc_array_team_weights_left := simulate_game_calculate_game_weights(loc_matrix_player_stats_left, loc_array_substitutes_left);

                loc_array_team_weights_right := simulate_game_calculate_game_weights(loc_matrix_player_stats_right, loc_array_substitutes_right);



                ------ Set the game context

                context := ROW(

                    loc_array_players_id_left,

                    loc_array_players_id_right,

                    loc_array_substitutes_left,

                    loc_array_substitutes_right,

                    loc_matrix_player_stats_left,

                    loc_matrix_player_stats_right,

                    loc_array_team_weights_left,

                    loc_array_team_weights_right,

                    loc_period_game,

                    loc_minute_game,

                    loc_date_start_period

                )::game_context;



                ------ Simulate a minute of the game and update the scores

                SELECT simulate_game_minute.loc_score_left, simulate_game_minute.loc_score_right

                INTO loc_score_left, loc_score_right

                FROM simulate_game_minute(

                    rec_game := rec_game,

                    context := context,

                    inp_score_left := loc_score_left,

                    inp_score_right := loc_score_right

                );



                ------ Insert a new row in the game_stats table

                INSERT INTO games_stats (id_game, period, minute, weights_left, weights_right)

                VALUES (rec_game.id, loc_period_game, loc_minute_game, loc_array_team_weights_left, loc_array_team_weights_right);

                

                ------ Update players stats (energy, experience)

                FOR I IN 1..14 LOOP

                    index_player := loc_array_substitutes_left[I];

                    IF loc_array_players_id_left[index_player] IS NOT NULL THEN

                        ---- Reduce energy

                        loc_matrix_player_stats_left[index_player][12] := GREATEST(0,

                            loc_matrix_player_stats_left[index_player][12] - 1 + loc_matrix_player_stats_left[index_player][11] / 200.0);

                        ---- Increase experience

                        loc_matrix_player_stats_left[index_player][10] := LEAST(100,

                            loc_matrix_player_stats_left[index_player][10] + 0.015);

                    END IF;

                    index_player := loc_array_substitutes_right[I];

                    IF loc_array_players_id_right[index_player] IS NOT NULL THEN

                        ---- Reduce energy

                        loc_matrix_player_stats_right[index_player][12] := GREATEST(0,

                            loc_matrix_player_stats_right[index_player][12] - 1 + loc_matrix_player_stats_right[index_player][11] / 200.0);

                        ---- Increase experience

                        loc_matrix_player_stats_right[index_player][10] := LEAST(100,

                            loc_matrix_player_stats_right[index_player][10] + 0.015);

                    END IF;

                END LOOP;



            END LOOP; -- End loop on the minutes of the game



            -- If the game went to extra time and the scores are still equal, then simulate a penalty shootout

            IF loc_period_game = 4

            AND rec_game.is_cup IS TRUE

            AND (loc_score_left + loc_score_left_previous) = (loc_score_right + loc_score_right_previous) THEN

                -- Simulate a penalty shootout

                penalty_number := 1; -- Initialize the loop counter

                loc_score_penalty_left := 0; -- Initialize the score of the left team for the penalty shootout

                loc_score_penalty_right := 0; -- Initialize the score of the right team for the penalty shootout

                WHILE penalty_number <= 5 OR loc_score_penalty_left = loc_score_penalty_right LOOP

                    IF random() < 0.5 THEN

                        loc_score_penalty_left := loc_score_penalty_left + 1;

                    END IF;

                    IF random() < 0.5 THEN

                        loc_score_penalty_right := loc_score_penalty_right + 1;

                    END IF;

                    penalty_number := penalty_number + 1;

                END LOOP;

                loc_minute_period_extra_time := loc_minute_period_extra_time + (2 * penalty_number);

            END IF;

        END LOOP; -- End loop on the first half, second half and extra time for cup

        

        ------ Calculate the end time of the game

        loc_minute_period_end := loc_minute_period_end + loc_minute_period_extra_time;



    END IF; -- End if the game needs to be simulated



    ------ Store the players stats

    FOR I IN 1..21 LOOP

        IF loc_array_players_id_left[I] IS NOT NULL THEN

            UPDATE players SET

                -- training_points_available = training_points_available + 5,

                energy = loc_matrix_player_stats_left[I][12],

                experience = loc_matrix_player_stats_left[I][10]

            WHERE id = loc_array_players_id_left[I];

        END IF;

        IF loc_array_players_id_right[I] IS NOT NULL THEN

            UPDATE players SET

                -- training_points_available = training_points_available + 5,

                energy = loc_matrix_player_stats_right[I][12],

                experience = loc_matrix_player_stats_right[I][10]

            WHERE id = loc_array_players_id_right[I];

        END IF;

    END LOOP;



    ------------ Store the results

    ------ Store the score

    UPDATE games SET

        -- date_end = date_start + (loc_minute_period_end * INTERVAL '1 minute'),

        date_end = NOW(),

        ---- Score of the game

        score_left = CASE WHEN loc_score_left = -1 THEN 0 ELSE loc_score_left END,

        score_right = CASE WHEN loc_score_right = -1 THEN 0 ELSE loc_score_right END,

        is_left_forfeit = CASE WHEN loc_score_left = -1 THEN TRUE ELSE FALSE END,

        is_right_forfeit = CASE WHEN loc_score_right = -1 THEN TRUE ELSE FALSE END,

        ---- Score of the penalty shootout

        score_penalty_left = loc_score_penalty_left,

        score_penalty_right = loc_score_penalty_right,

        ---- Score (cumulative) of the game with penalty shootout / 1000

        score_cumul_with_penalty_left = loc_score_left_previous +

            + CASE WHEN loc_score_left = -1 THEN 0 ELSE loc_score_left END

            + COALESCE(loc_score_penalty_left, 0) / 1000.0,

        score_cumul_with_penalty_right = loc_score_right_previous +

            + CASE WHEN loc_score_right = -1 THEN 0 ELSE loc_score_right END

            + COALESCE(loc_score_penalty_right, 0) / 1000.0

    WHERE id = rec_game.id;



    ------ Store the score if ever a game is a return game of this one

    UPDATE games SET

        score_previous_left = CASE WHEN loc_score_right = - 1 THEN 0 ELSE loc_score_right END,

        score_previous_right = CASE WHEN loc_score_left = - 1 THEN 0 ELSE loc_score_left END

    WHERE is_return_game_id_game_first_round = rec_game.id;



END;

$$;


ALTER FUNCTION public.simulate_game_main(inp_id_game bigint) OWNER TO postgres;

--
-- Name: simulate_game_main2(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.simulate_game_main2(inp_id_game bigint) RETURNS void
    LANGUAGE plpgsql
    AS $$

DECLARE

    rec_game RECORD; -- Record of the game

    rec_players_init_l RECORD; -- Record of the players (initial)

    rec_players_init_r RECORD; -- Record of the players (initial)

    rec_players_recalc_l RECORD; -- Record of the players recalculated

    rec_players_recalc_r RECORD; -- Record of the players recalculated

    -- loc_period_game int; -- The period of the game (e.g., first half, second half, extra time)

    -- loc_minute_period_start int; -- The minute where the period starts

    -- loc_minute_period_end int := 0; -- The minute where the period ends

    -- loc_minute_extra_time int; -- The extra time for the period

    -- loc_minute_game int; -- The minute of the game

    -- rec_game.period_start_date timestamp; -- The date and time of the period

    -- loc_score_left int := 0; -- The score of the left team

    -- loc_score_right int := 0; -- The score of the right team

    loc_score_penalty_left int := 0; -- The score of the left team for the penalty shootout

    loc_score_penalty_right int := 0; -- The score of the right team for the penalty shootout

    loc_score_left_previous int := 0; -- The score of the left team previous game

    loc_score_right_previous int := 0; -- The score of the right team with previous game

    minutes_half_time int8 := 45; -- 45

    minutes_extra_time int8 := 15; -- 15

    penalty_number int8; -- The number of penalties

    context game_context; -- Game context



        loc_array_players_id_left int8[21]; -- Array of players id for 21 slots of players

    loc_array_players_id_right int8[21]; -- Array of players id for 21 slots of players

    loc_array_substitutes_left int8[21] := ARRAY[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21]; -- Array for storing substitutions

    loc_array_substitutes_right int8[21] := ARRAY[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21]; -- Array for storing substitutions

    loc_matrix_player_stats_left float8[21][12]; -- Matrix to hold player stats [21 players x {keeper, defense, passes, playmaking, winger, scoring, freekick, motivation, form, experience, stamina, energy}]

    loc_matrix_player_stats_right float8[21][12]; -- Matrix to hold player stats [21 players x {keeper, defense, passes, playmaking, winger, scoring, freekick, motivation, form, experience, stamina, energy}]

    loc_matrix_player_weights_left float8[14][7]; -- Matrix to hold player weights [14 players x {left defense, central defense, right defense, midfield, left attack, central attack, right attack}]

    loc_matrix_player_weights_right float8[14][7]; -- Matrix to hold player weights [14 players x {left defense, central defense, right defense, midfield, left attack, central attack, right attack}]

    loc_array_team_weights_left float8[7]; -- Array for team weights [left defense, central defense, right defense, midfield, left attack, central attack, right attack]

    loc_array_team_weights_right float8[7]; -- Array for team weights [left defense, central defense, right defense, midfield, left attack, central attack, right attack]

BEGIN

    ------------------------------------------------------------------------------------------------------------------------------------------------

    ------------------------------------------------------------------------------------------------------------------------------------------------

    ------------ Step 1: Get game details and initial checks

    SELECT games.*,

        gtl.id AS id_teamcomp_club_left, 

        gtr.id AS id_teamcomp_club_right,

        ARRAY(SELECT 0.0::float4 FROM generate_series(1, 7)) AS weights_left,

        ARRAY(SELECT 0.0::float4 FROM generate_series(1, 7)) AS weights_right,

        cl.name AS name_club_left, cl.username AS username_club_left,

        cr.name AS name_club_right, cr.username AS username_club_right,

        1 AS period_number,

        games.date_start AS period_start_date,

        0 AS minute_period_start,

        45 AS minute_period_end,

        1 + RANDOM() * 3 AS minute_extra_time,

        0 AS minute_game

    INTO rec_game

    FROM games

    JOIN games_teamcomp gtl ON games.id_club_left = gtl.id_club AND games.season_number = gtl.season_number AND games.week_number = gtl.week_number

    JOIN games_teamcomp gtr ON games.id_club_right = gtr.id_club AND games.season_number = gtr.season_number AND games.week_number = gtr.week_number

    JOIN clubs cl ON games.id_club_left = cl.id

    JOIN clubs cr ON games.id_club_right = cr.id

    WHERE 

        games.id = inp_id_game;



    IF NOT FOUND THEN

        RAISE EXCEPTION 'Game [%] does not exist or the teamcomp was not found for the JOIN', inp_id_game;

    ELSIF rec_game.date_end IS NOT NULL THEN

        RAISE EXCEPTION 'Game [%] has already being played', inp_id_game;

    ELSIF rec_game.id_club_left IS NULL THEN

        RAISE EXCEPTION 'Game [%] doesnt have any left club defined', inp_id_game;

    ELSIF rec_game.id_club_right IS NULL THEN

        RAISE EXCEPTION 'Game [%] doesnt have any right club defined', inp_id_game;

    ELSIF rec_game.id_teamcomp_club_left IS NULL THEN

        RAISE EXCEPTION 'Game [%]: Teamcomp not found for club % for season % and week %', inp_id_game, rec_game.id_club_left, rec_game.season_number, rec_game.week_number;

    ELSIF rec_game.id_teamcomp_club_right IS NULL THEN

        RAISE EXCEPTION 'Game [%]: Teamcomp not found for club % for season % and week %', inp_id_game, rec_game.id_club_right, rec_game.season_number, rec_game.week_number;

    END IF;



    ------ Set that the game is_playing

    UPDATE games SET

        is_playing = TRUE

    WHERE id = rec_game.id;



    ------ Update the games teamcomp to say that the game is played

    UPDATE games_teamcomp SET

        is_played = TRUE

    WHERE id IN (rec_game.id_teamcomp_club_left, rec_game.id_teamcomp_club_right);



    ------ Update player to say they are currently playing a game

    UPDATE players SET

        is_playing = TRUE

    WHERE id_club IN (rec_game.id_club_left, rec_game.id_club_right);



    ------------------------------------------------------------------------------------------------------------------------------------------------

    ------------------------------------------------------------------------------------------------------------------------------------------------

    ------------ Step 2: Check teamcomps

    ------ Check if there is an error in the left teamcomp

--RAISE NOTICE '###### Game [%] - Checking teamcomps % - %', inp_id_game, rec_game.id_club_left, rec_game.id_club_right;

--RAISE NOTICE '###### Game [%] - Club% [%] VS Club% [%]', inp_id_game, rec_game.id_club_left, (SELECT array_agg(id) FROM players where id_club = rec_game.id_club_left), rec_game.id_club_right, (SELECT array_agg(id) FROM players where id_club = rec_game.id_club_right);

    BEGIN 

        ---- If the left teamcomp has an error, then try to correct it

        IF teamcomp_check_and_try_populate_if_error(

            inp_id_teamcomp := rec_game.id_teamcomp_club_left)

        IS NOT TRUE THEN

            rec_game.score_left := -1;

        END IF;

    EXCEPTION

        WHEN OTHERS THEN

            rec_game.score_left := -1;

    END;

    

    ------ Check if there is an error in the right teamcomp

    BEGIN

        ---- If the right teamcomp has an error, then try to correct it

        IF teamcomp_check_and_try_populate_if_error(

            inp_id_teamcomp := rec_game.id_teamcomp_club_right)

        IS NOT TRUE THEN

            rec_game.score_right := -1;

        END IF;

    EXCEPTION

        WHEN OTHERS THEN

            rec_game.score_right := -1;

    END;



RAISE NOTICE 'Game [%] - Club% [% - %] Club%', inp_id_game, rec_game.id_club_left, rec_game.score_left, rec_game.score_right, rec_game.id_club_right;



    ------ If one of the clubs is forfeit

    IF rec_game.score_left = -1 OR rec_game.score_right = -1 THEN

        ---- If both clubs are forfeit

        IF rec_game.score_left = -1 AND rec_game.score_right = -1 THEN



            -- Send mails to the clubs

            INSERT INTO messages_mail (id_club_to, created_at, sender_role, title, message)

            VALUES

                (rec_game.id_club_left, rec_game.date_start, 'Referee',

                    'Game of S' || rec_game.season_number || 'W' || rec_game.week_number || ': Cannot validate teamcomp',

                    'We were not able to give a valid teamcomp for the game of S' || rec_game.season_number || 'W' || rec_game.week_number || ' against ' || rec_game.name_club_right || ' but they didnt either, we will see what the league decides but it might end with a draw'),

                (rec_game.id_club_right, rec_game.date_start, 'Referee',

                    'Game of S' || rec_game.season_number || 'W' || rec_game.week_number || ': Cannot validate teamcomp',

                    'We were not able to give a valid teamcomp for the game of S' || rec_game.season_number || 'W' || rec_game.week_number || ' against ' || rec_game.name_club_left || ' but they didnt either, we will see what the league decides but it might end with a draw');



        ---- If the left club is forfeit

        ELSEIF rec_game.score_left = -1 THEN

            rec_game.score_right := 3; -- Set the right club as winner by 3-0



            -- Send mails to the clubs

            INSERT INTO messages_mail (id_club_to, created_at, sender_role, title, message)

            VALUES

                (rec_game.id_club_left, rec_game.date_start, 'Referee',

                    'Game of S' || rec_game.season_number || 'W' || rec_game.week_number || ': Cannot validate teamcomp',

                    'We were not able to give a valid teamcomp for the game of S' || rec_game.season_number || 'W' || rec_game.week_number || ' against ' || rec_game.name_club_right || ' is not valid, we will see what the league decides but it might end with a 3-0 defeat'),

                (rec_game.id_club_right, rec_game.date_start, 'Referee',

                    'Game of S' || rec_game.season_number || 'W' || rec_game.week_number || ': Opponent has no valid teamcomp',

                    rec_game.name_club_left || ', our opponent for the game of S' || rec_game.season_number || 'W' || rec_game.week_number || ' was not able to give a valid teamcomp, we will see what the league decides but it might end with a 3-0 victory');



        ---- If the right club is forfeit

        ELSE

            rec_game.score_left := 3; -- Set the left club as winner by 3-0



            -- Send mails to the clubs

            INSERT INTO messages_mail (id_club_to, created_at, sender_role, title, message)

            VALUES

                (rec_game.id_club_left, rec_game.date_start, 'Referee',

                    'Game of S' || rec_game.season_number || 'W' || rec_game.week_number || ': Opponent has no valid teamcomp',

                    rec_game.name_club_right || ', our opponent for the game of S' || rec_game.season_number || 'W' || rec_game.week_number || ' was not able to give a valid teamcomp, we will see what the league decides but it might end with a 3-0 victory'),

                (rec_game.id_club_right, rec_game.date_start, 'Referee',

                    'Game of S' || rec_game.season_number || 'W' || rec_game.week_number || ': Cannot validate teamcomp',

                    'We were not able to give a valid teamcomp for the game of S' || rec_game.season_number || 'W' || rec_game.week_number || ' against ' || rec_game.name_club_left || ' is not valid, we will see what the league decides but it might end with a 3-0 defeat');



        END IF;



    ------ If the game needs to be simulated, then set the initial score

    ELSE



        rec_game.score_left := 0;

        rec_game.score_right := 0;



RAISE NOTICE 'Game [%] - Club% [% - %] Club%', inp_id_game, rec_game.id_club_left, rec_game.score_left, rec_game.score_right, rec_game.id_club_right;





DROP TABLE IF EXISTS teamcomp_L;

-- -- Create temporary table for teamcomp

CREATE TEMPORARY TABLE teamcomp_L AS

WITH teamcomp AS (

    SELECT

        UNNEST(ARRAY[

            gt.idgoalkeeper,

            gt.idleftbackwinger,

            gt.idleftcentralback,

            gt.idcentralback,

            gt.idrightcentralback,

            gt.idrightbackwinger,

            gt.idleftwinger,

            gt.idleftmidfielder,

            gt.idcentralmidfielder,

            gt.idrightmidfielder,

            gt.idrightwinger,

            gt.idleftstriker,

            gt.idcentralstriker,

            gt.idrightstriker,

            gt.idsub1,

            gt.idsub2,

            gt.idsub3,

            gt.idsub4,

            gt.idsub5,

            gt.idsub6

        ]) AS id_players,

        generate_series(1, 20) AS position_id

    FROM games_teamcomp gt

    WHERE id = rec_game.id_teamcomp_club_left

), players_stats AS (

    SELECT

        teamcomp.position_id,

        games_possible_position.position_name,

        games_possible_position.coefs AS players_coef,

        teamcomp.id_players,

        (players.first_name || ' ' || players.last_name) AS full_name,

        teamcomp.position_id AS subs,

        ARRAY[

            COALESCE(players.keeper, 0),

            COALESCE(players.defense, 0),

            COALESCE(players.passes, 0),

            COALESCE(players.playmaking, 0),

            COALESCE(players.winger, 0),

            COALESCE(players.scoring, 0),

            COALESCE(players.freekick, 0)

        ] AS players_stats,

        ARRAY[

            COALESCE(players.motivation, 0),

            COALESCE(players.form, 0),

            COALESCE(players.experience, 0),

            COALESCE(players.energy, 0),

            COALESCE(players.stamina, 0)

        ] AS players_stats_other

    FROM

        teamcomp

    JOIN

        games_possible_position ON teamcomp.position_id = games_possible_position.id

    LEFT JOIN

        players ON teamcomp.id_players = players.id

    ORDER BY

        teamcomp.position_id)

SELECT

    ps.position_id,

    ps.position_name,

    0 AS goals_scored,

    0 AS goals_pass,

    --ps.players_coef,

    ps.id_players,

    ps.players_stats,

    ps.players_stats_other,

    ARRAY[

        (SELECT SUM(c * s) FROM UNNEST(ps.players_coef[1:1]) AS c, UNNEST(ps.players_stats[1:6]) AS s), -- LeftDefense

        (SELECT SUM(c * s) FROM UNNEST(ps.players_coef[2:2]) AS c, UNNEST(ps.players_stats[1:6]) AS s), -- CentralDefense

        (SELECT SUM(c * s) FROM UNNEST(ps.players_coef[3:3]) AS c, UNNEST(ps.players_stats[1:6]) AS s), -- RightDefense

        (SELECT SUM(c * s) FROM UNNEST(ps.players_coef[4:4]) AS c, UNNEST(ps.players_stats[1:6]) AS s), -- MidField

        (SELECT SUM(c * s) FROM UNNEST(ps.players_coef[5:5]) AS c, UNNEST(ps.players_stats[1:6]) AS s), -- LeftAttack

        (SELECT SUM(c * s) FROM UNNEST(ps.players_coef[6:6]) AS c, UNNEST(ps.players_stats[1:6]) AS s), -- Central Attack

        (SELECT SUM(c * s) FROM UNNEST(ps.players_coef[7:7]) AS c, UNNEST(ps.players_stats[1:6]) AS s) -- Right Attack

    ] AS players_weights_init,

    ARRAY(SELECT 0.0::float4 FROM generate_series(1, 7)) AS players_weights_recalc

FROM

    players_stats ps

ORDER BY

    ps.position_id;



DROP TABLE IF EXISTS teamcomp_R;

-- -- Create temporary table for teamcomp

CREATE TEMPORARY TABLE teamcomp_R AS

WITH teamcomp AS (

    SELECT

        UNNEST(ARRAY[

            gt.idgoalkeeper,

            gt.idleftbackwinger,

            gt.idleftcentralback,

            gt.idcentralback,

            gt.idrightcentralback,

            gt.idrightbackwinger,

            gt.idleftwinger,

            gt.idleftmidfielder,

            gt.idcentralmidfielder,

            gt.idrightmidfielder,

            gt.idrightwinger,

            gt.idleftstriker,

            gt.idcentralstriker,

            gt.idrightstriker,

            gt.idsub1,

            gt.idsub2,

            gt.idsub3,

            gt.idsub4,

            gt.idsub5,

            gt.idsub6

        ]) AS id_players,

        generate_series(1, 20) AS position_id

    FROM games_teamcomp gt

    WHERE id = rec_game.id_teamcomp_club_right

), players_stats AS (

    SELECT

        teamcomp.position_id,

        games_possible_position.position_name,

        games_possible_position.coefs AS players_coef,

        teamcomp.id_players,

        (players.first_name || ' ' || players.last_name) AS full_name,

        teamcomp.position_id AS subs,

        ARRAY[

            COALESCE(players.keeper, 0),

            COALESCE(players.defense, 0),

            COALESCE(players.passes, 0),

            COALESCE(players.playmaking, 0),

            COALESCE(players.winger, 0),

            COALESCE(players.scoring, 0),

            COALESCE(players.freekick, 0)

        ] AS players_stats,

        ARRAY[

            COALESCE(players.motivation, 0),

            COALESCE(players.form, 0),

            COALESCE(players.experience, 0),

            COALESCE(players.energy, 0),

            COALESCE(players.stamina, 0)

        ] AS players_stats_other

    FROM

        teamcomp

    JOIN

        games_possible_position ON teamcomp.position_id = games_possible_position.id

    LEFT JOIN

        players ON teamcomp.id_players = players.id

    ORDER BY

        teamcomp.position_id)

SELECT

    ps.position_id,

    ps.position_name,

    0 AS goals_scored,

    0 AS goals_pass,

    --ps.players_coef,

    ps.id_players,

    ps.players_stats,

    ps.players_stats_other,

    ARRAY[

        (SELECT SUM(c * s) FROM UNNEST(ps.players_coef[1:1]) AS c, UNNEST(ps.players_stats[1:6]) AS s), -- LeftDefense

        (SELECT SUM(c * s) FROM UNNEST(ps.players_coef[2:2]) AS c, UNNEST(ps.players_stats[1:6]) AS s), -- CentralDefense

        (SELECT SUM(c * s) FROM UNNEST(ps.players_coef[3:3]) AS c, UNNEST(ps.players_stats[1:6]) AS s), -- RightDefense

        (SELECT SUM(c * s) FROM UNNEST(ps.players_coef[4:4]) AS c, UNNEST(ps.players_stats[1:6]) AS s), -- MidField

        (SELECT SUM(c * s) FROM UNNEST(ps.players_coef[5:5]) AS c, UNNEST(ps.players_stats[1:6]) AS s), -- LeftAttack

        (SELECT SUM(c * s) FROM UNNEST(ps.players_coef[6:6]) AS c, UNNEST(ps.players_stats[1:6]) AS s), -- Central Attack

        (SELECT SUM(c * s) FROM UNNEST(ps.players_coef[7:7]) AS c, UNNEST(ps.players_stats[1:6]) AS s) -- Right Attack

    ] AS players_weights_init,

    ARRAY(SELECT 0.0::float4 FROM generate_series(1, 7)) AS players_weights_recalc

FROM

    players_stats ps

ORDER BY

    ps.position_id;



-- RAISE NOTICE '%', (SELECT array_agg(players_weights_init) FROM teamcomp_L);



        ------------------------------------------------------------------------------------------------------------------------------------------------

        ------------------------------------------------------------------------------------------------------------------------------------------------

        ------------ Step 3: Simulate game

        ------ Loop through the periods of the game (e.g., first half, second half, extra time)

        WHILE rec_game.date_end IS NULL LOOP



            ------ Cheat CODE to calculate only once

            ------ Calculate team weights (Array of 7 floats: LeftDefense, CentralDefense, RightDefense, MidField, LeftAttack, CentralAttack, RightAttack)

            --rec_game.array_team_weights_left := simulate_game_calculate_game_weights(rec_game.matrix_player_stats_left, rec_game.array_substitutes_left);

            --rec_game.array_team_weights_right := simulate_game_calculate_game_weights(rec_game.matrix_player_stats_right, rec_game.array_substitutes_right);



            ------ Calculate the events of the game with one event every minute

            FOR rec_game.minute_game IN rec_game.minute_period_start..rec_game.minute_period_end + rec_game.minute_extra_time LOOP



                ------------------------------------------------------------------------

                ------------------------------------------------------------------------

                ------ Handle orders

                -- Handle orders for left club

                -- loc_array_substitutes_left := simulate_game_handle_orders(

                --     inp_teamcomp_id := rec_game.id_teamcomp_club_left,

                --     array_players_id := loc_array_players_id_left,

                --     array_substitutes := loc_array_substitutes_left,

                --     game_minute := rec_game.minute_game,

                --     game_period := rec_game.period_number,

                --     period_start := rec_game.period_start_date,

                --     score := rec_game.score_left - rec_game.score_right,

                --     game := rec_game);



                -- -- Handle orders for right club

                -- loc_array_substitutes_right := simulate_game_handle_orders(

                --     inp_teamcomp_id := rec_game.id_teamcomp_club_right,

                --     array_players_id := loc_array_players_id_right,

                --     array_substitutes := loc_array_substitutes_right,

                --     game_minute := rec_game.minute_game,

                --     game_period := rec_game.period_number,

                --     period_start := rec_game.period_start_date,

                --     score := rec_game.score_right - rec_game.score_left,

                --     game := rec_game);



RAISE NOTICE '%', (SELECT array_agg(players_weights_init) FROM teamcomp_L);



UPDATE teamcomp_L SET

    players_weights_recalc = ARRAY[

        players_weights_init[1] * (1 + random() * 0.1),

        players_weights_init[2] * (1 + random() * 0.1),

        players_weights_init[3] * (1 + random() * 0.1),

        players_weights_init[4] * (1 + random() * 0.1),

        players_weights_init[5] * (1 + random() * 0.1),

        players_weights_init[6] * (1 + random() * 0.1),

        players_weights_init[7] * (1 + random() * 0.1)

    ];



RAISE NOTICE '%', (SELECT array_agg(players_weights_recalc) FROM teamcomp_L);



SELECT ARRAY[

    SUM(players_weights_recalc[1]),

    SUM(players_weights_recalc[2]),

    SUM(players_weights_recalc[3]),

    SUM(players_weights_recalc[4]),

    SUM(players_weights_recalc[5]),

    SUM(players_weights_recalc[6]),

    SUM(players_weights_recalc[7])

] INTO rec_game.weights_left FROM teamcomp_L;



UPDATE teamcomp_R SET

    players_weights_recalc = ARRAY[

        players_weights_init[1] * (1 + random() * 0.1),

        players_weights_init[2] * (1 + random() * 0.1),

        players_weights_init[3] * (1 + random() * 0.1),

        players_weights_init[4] * (1 + random() * 0.1),

        players_weights_init[5] * (1 + random() * 0.1),

        players_weights_init[6] * (1 + random() * 0.1),

        players_weights_init[7] * (1 + random() * 0.1)

    ];



SELECT ARRAY[

    SUM(players_weights_recalc[1]),

    SUM(players_weights_recalc[2]),

    SUM(players_weights_recalc[3]),

    SUM(players_weights_recalc[4]),

    SUM(players_weights_recalc[5]),

    SUM(players_weights_recalc[6]),

    SUM(players_weights_recalc[7])

] INTO rec_game.weights_right FROM teamcomp_R;



RAISE NOTICE '% - %', rec_game.weights_left, rec_game.weights_right;



RAISE NOTICE 'BEFORE: rec_game= %', rec_game;

RAISE NOTICE 'BEFORE: Game [%] - Club% [% - %] Club%', rec_game.id, rec_game.id_club_left, rec_game.score_left, rec_game.score_right, rec_game.id_club_right;

                --SELECT simulate_game_minute_new(rec_game := rec_game) INTO rec_game;

                PERFORM simulate_game_minute_new(inp_rec_game := rec_game);

RAISE NOTICE 'AFTER: Game [%] - [% - %]', rec_game.id, rec_game.score_left, rec_game.score_right;

RAISE NOTICE 'AFTER: Game [%] - Club% [% - %] Club%', inp_id_game, rec_game.id_club_left, rec_game.score_left, rec_game.score_right, rec_game.id_club_right;



                -- ------ Reduce the players energy

                -- FOR I IN 1..14 LOOP

                --     IF loc_array_players_id_left[loc_array_substitutes_left[I]] IS NOT NULL THEN

                --         loc_matrix_player_stats_left[I][9] := GREATEST(0,

                --             loc_matrix_player_stats_left[loc_array_substitutes_left[I]][9] - 1 + loc_matrix_player_stats_left[loc_array_substitutes_left[I]][10] / 200.0);

                --     END IF;

                --     IF loc_array_players_id_right[loc_array_substitutes_right[I]] IS NOT NULL THEN

                --         loc_matrix_player_stats_right[I][9] := GREATEST(0,

                --             loc_matrix_player_stats_right[loc_array_substitutes_right[I]][9] - 1 + loc_matrix_player_stats_right[loc_array_substitutes_right[I]][10] / 200.0);

                --     END IF;

                -- END LOOP;



            END LOOP; -- End loop on the minutes of the game

                

            rec_game.period_number := rec_game.period_number + 1; -- Increment the period number



            ---- Reset the minutes of the period

            -- IF rec_game.period_number = 1 THEN

            --     rec_game.period_start_date := rec_game.date_start; -- Start date of the first period is the start date of the game

            --     rec_game.minute_period_start := 0; -- Start minute of the first period

            --     rec_game.minute_period_end := rec_game.minute_period_start + minutes_half_time; -- Start minute of the first period

            --     rec_game.minute_extra_time := 2 + ROUND(random() * 3); -- Extra time for the period

            -- ELSE

            IF rec_game.period_number = 2 THEN

                rec_game.period_start_date := rec_game.period_start_date + (45 + rec_game.minute_extra_time) * INTERVAL '1 minute'; -- Start date of the second period is the start date of the game plus 45 minutes + extra time

                rec_game.minute_period_start := 45; -- Start minute of the second period

                rec_game.minute_period_end := rec_game.minute_period_start + minutes_half_time; -- Start minute of the first period

                rec_game.minute_extra_time := 3 + ROUND(random() * 5); -- Extra time for the period

            ELSEIF rec_game.period_number = 3 THEN

                -- If the game is_cup we fetch the previous score if a previous game exists

                IF rec_game.is_cup IS TRUE THEN

                    rec_game.score_left_previous = 0;

                    rec_game.score_right_previous = 0;

                    -- If the game has a previous first round game

                    IF rec_game.is_return_game_id_game_first_round IS NOT NULL THEN



                        -- Fetch score from previous game

                        SELECT 

                            CASE 

                                WHEN id_club_left = rec_game.id_club_left THEN FLOOR(score_left)

                                WHEN id_club_right = rec_game.id_club_left THEN FLOOR(score_right)

                                ELSE NULL

                            END,

                            CASE 

                                WHEN id_club_left = rec_game.id_club_right THEN FLOOR(score_left)

                                WHEN id_club_right = rec_game.id_club_right THEN FLOOR(score_right)

                                ELSE NULL

                            END

                        INTO rec_game.score_left_previous, rec_game.score_right_previous

                        FROM games WHERE id = rec_game.is_return_game_id_game_first_round;



                        IF rec_game.score_left_previous IS NULL THEN

                            RAISE EXCEPTION 'Cannot find the score of the first game of the left club % in the game %', rec_game.id_club_left, rec_game.is_return_game_id_game_first_round;

                        END IF;



                        IF rec_game.score_right_previous IS NULL THEN

                            RAISE EXCEPTION 'Cannot find the score of the first game of the right club % in the game %', rec_game.id_club_right, rec_game.is_return_game_id_game_first_round;

                        END IF;



                    END IF;

                END IF;

                -- Check if the game is over already (e.g., if the game is not a cup game or if the scores are different)

                IF rec_game.is_cup = FALSE AND (rec_game.score_left + rec_game.score_left_previous) <> (rec_game.score_right + rec_game.score_right_previous) THEN

                    EXIT; -- If the game is over, then exit the loop

                END IF;

                rec_game.period_start_date := rec_game.period_start_date + (45 + rec_game.minute_extra_time) * INTERVAL '1 minute'; -- Start date of the first prolongation is the start date of the second half plus 45 minutes + extra time

                rec_game.minute_period_start := 90; -- Start minute of the first period

                rec_game.minute_period_end := rec_game.minute_period_start + minutes_extra_time; -- Start minute of the first period

                rec_game.minute_extra_time := ROUND(random() * 3); -- Extra time for the period

            ELSE

                rec_game.period_start_date := rec_game.period_start_date + (15 + rec_game.minute_extra_time) * INTERVAL '1 minute'; -- Start date of the second prolongation is the start date of the first prolongation plus 15 minutes + extra time

                rec_game.minute_period_start := 105; -- Start minute of the first period

                rec_game.minute_period_end := rec_game.minute_period_start + minutes_extra_time; -- Start minute of the first period

                rec_game.minute_extra_time := 2 + ROUND(random() * 4); -- Extra time for the period

            END IF;



            -- If the game went to extra time and the scores are still equal, then simulate a penalty shootout

            IF rec_game.period_number = 4

            AND rec_game.is_cup IS TRUE

            AND (rec_game.score_left + loc_score_left_previous) = (rec_game.score_right + loc_score_right_previous) THEN

                -- Simulate a penalty shootout

                penalty_number := 1; -- Initialize the loop counter

                WHILE penalty_number <= 5 OR loc_score_penalty_left = loc_score_penalty_right LOOP

                    IF random() < 0.5 THEN

                        loc_score_penalty_left := loc_score_penalty_left + 1;

                    END IF;

                    IF random() < 0.5 THEN

                        loc_score_penalty_right := loc_score_penalty_right + 1;

                    END IF;

                    penalty_number := penalty_number + 1;

                END LOOP;

                rec_game.minute_extra_time := rec_game.minute_extra_time + (2 * penalty_number);

            END IF;

        END LOOP; -- End loop on the first half, second half and extra time for cup

        

        ------ Calculate the end time of the period

        rec_game.minute_period_end := rec_game.minute_period_end + rec_game.minute_extra_time;



    END IF; -- End if the game needs to be simulated



    -- Update players experience and stats

    PERFORM simulate_game_process_experience_gain(

        inp_id_game :=  rec_game.id,

        inp_list_players_id_left := loc_array_players_id_left,

        inp_list_players_id_right := loc_array_players_id_right

    );

    

    ------------ Store the results

    ------ Store the score

    UPDATE games SET

        date_end = date_start + (rec_game.minute_period_end * INTERVAL '1 minute'),

        --date_end = NOW(),

        score_left = rec_game.score_left,

        score_right = rec_game.score_right,

        score_cumul_left = score_cumul_left + loc_score_left_previous + (loc_score_penalty_left / 1000.0)

            + CASE WHEN rec_game.score_left = - 1 THEN 0 ELSE rec_game.score_left END,

        score_cumul_right = score_cumul_right + loc_score_right_previous + (loc_score_penalty_right / 1000.0)

            + CASE WHEN rec_game.score_right = - 1 THEN 0 ELSE rec_game.score_right END

    WHERE id = rec_game.id;



    ------ Store the score if ever a game is a return game of this one

    UPDATE games SET

        score_cumul_left = CASE WHEN rec_game.score_right = - 1 THEN 0 ELSE rec_game.score_right END,

        score_cumul_right = CASE WHEN rec_game.score_left = - 1 THEN 0 ELSE rec_game.score_left END

    WHERE is_return_game_id_game_first_round = rec_game.id;



END;

$$;


ALTER FUNCTION public.simulate_game_main2(inp_id_game bigint) OWNER TO postgres;

--
-- Name: simulate_game_minute(record, public.game_context, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.simulate_game_minute(rec_game record, context public.game_context, inp_score_left integer, inp_score_right integer) RETURNS TABLE(loc_score_left integer, loc_score_right integer)
    LANGUAGE plpgsql
    AS $$

DECLARE

    loc_goal_opportunity float4; -- Probability of opportunity

    loc_team_left_goal_opportunity float4; -- Probability of left team opportunity

    is_goal boolean;

    loc_score_left int := inp_score_left;

    loc_score_right int := inp_score_right;

BEGIN

    loc_goal_opportunity = 0.05; -- Probability of a goal opportunity

    -- loc_goal_opportunity = 0.00; -- Probability of a goal opportunity (for having 0-0 scores)



    loc_team_left_goal_opportunity = LEAST(GREATEST((context.loc_array_team_weights_left[4] / context.loc_array_team_weights_right[4])-0.5, 0.2), 0.8);



    IF random() < loc_goal_opportunity THEN -- Simulate an opportunity

        IF random() < loc_team_left_goal_opportunity THEN -- Simulate an opportunity for the left team

            is_goal := simulate_game_goal_opportunity(

                rec_game := rec_game,

                context := context,

                is_left_club := TRUE

            );



            IF is_goal THEN

                loc_score_left := loc_score_left + 1;

            END IF;

        ELSE -- Simulate an opportunity for the right team

            is_goal := simulate_game_goal_opportunity(

                rec_game := rec_game,

                context := context,

                is_left_club := FALSE

            );



            IF is_goal THEN

                loc_score_right := loc_score_right + 1;

            END IF;

        END IF;

    END IF;



    RETURN QUERY SELECT loc_score_left, loc_score_right;

END;

$$;


ALTER FUNCTION public.simulate_game_minute(rec_game record, context public.game_context, inp_score_left integer, inp_score_right integer) OWNER TO postgres;

--
-- Name: simulate_game_minute_new(record); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.simulate_game_minute_new(INOUT inp_rec_game record) RETURNS record
    LANGUAGE plpgsql
    AS $$

DECLARE

    loc_goal_opportunity float4; -- Probability of opportunity

    loc_team_left_goal_opportunity float4; -- Probability of left team opportunity

    is_goal boolean;

BEGIN



RAISE NOTICE 'inp_rec_game= %', inp_rec_game;



    loc_goal_opportunity = 0.05; -- Probability of a goal opportunity

    loc_goal_opportunity = 1.0; -- Probability of a goal opportunity

    -- loc_goal_opportunity = 0.00; -- Probability of a goal opportunity (for having 0-0 scores)



RAISE NOTICE '### loc_team_left_goal_opportunity: % VS %', inp_rec_game.weights_left[4], inp_rec_game.weights_right[4];

    loc_team_left_goal_opportunity = LEAST(GREATEST((inp_rec_game.weights_left[4] / inp_rec_game.weights_right[4]) - 0.5, 0.2), 0.8);

RAISE NOTICE '### loc_team_left_goal_opportunity: %', loc_team_left_goal_opportunity;

    IF random() < loc_goal_opportunity THEN -- Simulate an opportunity

    

        IF random() < loc_team_left_goal_opportunity THEN -- Simulate an opportunity for the left team

            -- is_goal := simulate_game_goal_opportunity(

            --     inp_rec_game := inp_rec_game,

            --     context := context,

            --     is_left_club := TRUE

            -- );



            -- IF is_goal THEN

                inp_rec_game.score_left := inp_rec_game.score_left + 1;

RAISE NOTICE '### GOAL LEFT';

RAISE NOTICE 'DURING: Game [%] - [% - %]', inp_rec_game.id, inp_rec_game.score_left, inp_rec_game.score_right;



            -- END IF;

        ELSE -- Simulate an opportunity for the right team

            -- is_goal := simulate_game_goal_opportunity(

            --     inp_rec_game := inp_rec_game,

            --     context := context,

            --     is_left_club := FALSE

            -- );



            -- IF is_goal THEN

                inp_rec_game.score_right := inp_rec_game.score_right + 1;

RAISE NOTICE '### GOAL RIGHT';

RAISE NOTICE 'DURING: Game [%] - [% - %]', inp_rec_game.id, inp_rec_game.score_left, inp_rec_game.score_right;

            -- END IF;

        END IF;

    END IF;



END;

$$;


ALTER FUNCTION public.simulate_game_minute_new(INOUT inp_rec_game record) OWNER TO postgres;

--
-- Name: simulate_game_n_times(bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.simulate_game_n_times(inp_id_game bigint, inp_number_run bigint DEFAULT 100) RETURNS bigint[]
    LANGUAGE plpgsql
    AS $$
DECLARE
    loc_game_was_already_played BOOLEAN; -- Flag to check if the game is already played
    loc_record_game_events game_events%ROWTYPE; -- Temporary record to store the game events
    loc_id_club_left INT; -- ID of the home team
    loc_id_club_right INT; -- ID of the away team
    loc_n_goals_left INT; -- Number of goals scored by the home team
    loc_n_goals_right INT; -- Number of goals scored by the away team
    loc_n_victory INT := 0; -- Number of victories
    loc_n_draw INT := 0; -- Number of draws
    loc_n_defeat INT := 0; -- Number of defeats
BEGIN

    -- Set the id_club_left and id_club_right
    SELECT id_club_left, id_club_right INTO loc_id_club_left, loc_id_club_right FROM games WHERE id = inp_id_game;

    -- Check if the game is already played
    SELECT is_played INTO loc_game_was_already_played FROM games WHERE id = inp_id_game;

    -- If the game is already played, return
    IF loc_game_was_already_played THEN
        
        -- Reset the game isPlayed flag
        UPDATE games SET is_played = FALSE WHERE id = inp_id_game;

        -- Store the game events in a temporary record
        -- UPDATE game_events SET id_game = -inp_id_game WHERE id_game = inp_id_game;
        -- Create a temporary table to store the game events
        CREATE TEMPORARY TABLE temp_game_events AS SELECT * FROM game_events WHERE id_game = inp_id_game;

    END IF;

    -- Clean the game events
    DELETE FROM game_events WHERE id_game = inp_id_game;

    -- Loop through the number of runs
    FOR I IN 1..inp_number_run LOOP

        -- Simulate the game
        PERFORM simulate_game(inp_id_game);

        -- Count the number of victories, draws and defeats
        SELECT COUNT(*) INTO loc_n_goals_left FROM game_events WHERE id_game = inp_id_game AND id_club = loc_id_club_left;
        SELECT COUNT(*) INTO loc_n_goals_right FROM game_events WHERE id_game = inp_id_game AND id_club = loc_id_club_right;

        -- Update the statistics
        IF loc_n_goals_left > loc_n_goals_right THEN
            loc_n_victory := loc_n_victory + 1;
        ELSIF loc_n_goals_left = loc_n_goals_right THEN
            loc_n_draw := loc_n_draw + 1;
        ELSE
            loc_n_defeat := loc_n_defeat + 1;
        END IF;
    RAISE NOTICE 'loc_n_victory= %', loc_n_victory;

        -- Reset the game isPlayed flag
        UPDATE games SET is_played = FALSE WHERE id = inp_id_game;
    
        -- Clean the game events
        DELETE FROM game_events WHERE id_game = inp_id_game;

    END LOOP;

    -- If the game was already played, restore the original game events
    IF loc_game_was_already_played THEN
        -- Restore the original game events
        INSERT INTO game_events SELECT * FROM temp_game_events;
        -- Drop the temporary table
        DROP TABLE temp_game_events;

        -- Update the game isPlayed flag
        UPDATE games SET is_played = TRUE WHERE id = inp_id_game;
    END IF;

    -- Return the number of victories, draws and defeats
    RETURN ARRAY[loc_n_victory, loc_n_draw, loc_n_defeat];

END;
$$;


ALTER FUNCTION public.simulate_game_n_times(inp_id_game bigint, inp_number_run bigint) OWNER TO postgres;

--
-- Name: simulate_game_set_is_played(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.simulate_game_set_is_played(inp_id_game bigint) RETURNS void
    LANGUAGE plpgsql
    AS $$

DECLARE

    rec_game RECORD; -- Record to store the game data

    text_title_winner TEXT; -- Title of the message for the left club

    text_title_loser TEXT; -- Title of the message for the right club

    text_message_winner TEXT; -- Message of the message for the left club

    text_message_loser TEXT; -- Message of the message for the right club

    tmp_text1 TEXT; -- Tmp text 1

    tmp_text2 TEXT; -- Tmp text 2

BEGIN



    ------ Store the game record

    SELECT games.*,

        score_cumul_with_penalty_left - score_cumul_with_penalty_right AS score_diff,

        ---- Game presentation

        CASE

            WHEN is_friendly THEN 'friendly '

            WHEN is_relegation THEN 'relegation '

            WHEN is_cup THEN 'cup '

            WHEN is_league THEN ''

            ELSE 'ERROR '

        END || string_parser(games.id, 'idGame') || ' of ' || string_parser(games.id_league, 'idLeague') AS game_presentation,

        ---- Score of the game

        score_left::TEXT || CASE WHEN is_left_forfeit = TRUE THEN 'F' ELSE '' END ||

        CASE WHEN score_penalty_left IS NOT NULL THEN '[' || score_penalty_left || ']' ELSE '' END ||

        '-' ||

        CASE WHEN score_penalty_right IS NOT NULL THEN '[' || score_penalty_right || ']' ELSE '' END ||

        score_right::TEXT || CASE WHEN is_right_forfeit = TRUE THEN 'F' ELSE '' END

        AS text_score_game,

        ---- Overall text (if the game is a return game, display the overall winner etc...)

        CASE

            WHEN is_return_game_id_game_first_round IS NULL THEN

                ''

            ELSE 'Overall '

        END AS overall_text,

        ---- Id of the club who won the overall game

        CASE

            WHEN score_cumul_with_penalty_left > score_cumul_with_penalty_right THEN games.id_club_left

            ELSE games.id_club_right

        END AS id_club_overall_winner,

        ---- Id of the club who lost the overall game

        CASE

            WHEN score_cumul_with_penalty_left > score_cumul_with_penalty_right THEN games.id_club_right

            ELSE games.id_club_left

        END AS id_club_overall_loser,

        leagues.level AS league_level,

        leagues.number AS league_number,

        leagues.id_lower_league AS id_lower_league,

        games_description.description AS game_description,

        ROUND(games_description.elo_weight -- Base weight from the type of the game

            * CASE 

                WHEN ABS(score_left-score_right) = 1 THEN 1.0

                WHEN ABS(score_left-score_right) = 2 THEN 1.5

                ELSE (11 + ABS(score_left-score_right)) / 8.0

            END -- Weight multiplier based on the difference of goals

            * (CASE WHEN score_left > score_right THEN 1.0 WHEN score_left < score_right THEN 0.0 ELSE 0.5 END -- Result of the game

            - games.expected_elo_result[array_length(games.expected_elo_result, 1)])) -- Expected result of the game

            AS exchanged_elo_points

    INTO rec_game

    FROM games

    JOIN leagues ON leagues.id = games.id_league

    JOIN games_description ON games_description.id = games.id_games_description

    WHERE games.id = inp_id_game;



-- RAISE NOTICE 'expected_elo_score= % || exchanged_ranking_points= %', rec_game.expected_elo_score, rec_game.exchanged_ranking_points;



    ------ Start writing the messages to be sent to the clubs

    tmp_text1 := rec_game.text_score_game || ' in ' ||  rec_game.game_presentation || ' against ';

    text_title_winner := rec_game.overall_text || CASE

            WHEN rec_game.score_cumul_with_penalty_left = rec_game.score_cumul_with_penalty_right THEN ' Draw '

            ELSE ' Victory ' END || tmp_text1 || string_parser(rec_game.id_club_overall_loser, 'idClub');

    text_title_loser := rec_game.overall_text || CASE

            WHEN rec_game.score_cumul_with_penalty_left = rec_game.score_cumul_with_penalty_right THEN ' Draw '

            ELSE ' Defeat ' END || tmp_text1 || string_parser(rec_game.id_club_overall_winner, 'idClub');

    text_message_winner := text_title_winner || ' for the game: ' || rec_game.game_description;

    text_message_loser := text_title_loser || ' for the game: ' || rec_game.game_description;



    ------ Update message and league position for specific games

    ---- Handling of the international cup games (1st place game)

    IF rec_game.id_games_description = 131 THEN



        -- Send messages

        text_title_winner := text_title_winner || ': International Cup Victory';

        text_title_loser := text_title_loser || ': 2nd Place in International Cup';

        text_message_winner := text_message_winner || '. This great victory in the International Cup means that we are the champions of the competition. Congratulations to you and all the players, we made it !';

        text_message_loser := text_message_loser || '. This defeat in the International Cup means that we are the 2nd of the competition. It''s a disappointment but we''ll come back stronger next season, I''m sure we can make it !';



        ---- Insert into clubs_history table

        INSERT INTO clubs_history (id_club, is_ranking_description, description)

        VALUES (

            rec_game.id_club_overall_winner, TRUE,

            'Season ' || rec_game.season_number || ': Finished 1st of ' || string_parser(rec_game.id_league, 'idLeague')),

        (

            rec_game.id_club_overall_loser, TRUE,

            'Season ' || rec_game.season_number || 'Finished 2nd of ' || string_parser(rec_game.id_league, 'idLeague'));



        ---- Insert into the players_history table for winning club

        INSERT INTO players_history (id_player, id_club, description, is_ranking_description)

            SELECT

                id AS id_player, id_club AS id_club,

                'Season ' || rec_game.season_number || ': Victory in International League'

                || ' of ' || string_parser(rec_game.id_league, 'idLeague') || ' with ' || string_parser(id_club, 'idClub'),

                TRUE AS is_ranking_description

            FROM players

            WHERE id_club = rec_game.id_club_overall_winner;



        ---- Insert into the players_history table for losing club

        INSERT INTO players_history (id_player, id_club, description, is_ranking_description)

            SELECT

                id AS id_player, id_club AS id_club,

                'Season ' || rec_game.season_number || ': 2nd Place in International League'

                || ' of ' || string_parser(rec_game.id_league, 'idLeague') || ' with ' || string_parser(id_club, 'idClub'),

                TRUE AS is_ranking_description

            FROM players

            WHERE players.id_club = rec_game.id_club_overall_loser;



    ------ Handling of the 3rd place game of the international cups

    ELSEIF rec_game.id_games_description IN (132, 133) THEN

        tmp_text1 :=

        CASE

            WHEN rec_game.id_games_description = 132 THEN '3rd Place game of the '

            ELSE '5th Place game of the '

        END ||

        CASE

            WHEN rec_game.league_number = 1 THEN ' Champions International Cup'

            WHEN rec_game.league_number = 2 THEN ' Seconds International Cup'

            ELSE ' Thirds International Cup'

        END;



        -- Send messages

        text_title_winner := text_title_winner || ': Victory in ' || tmp_text1;

        text_title_loser := text_title_loser || ': Defeat in ' || tmp_text1;

        text_message_winner := text_message_winner || '. This is a great victory in the ' || tmp_text1 || ' ! Next season let''s try to make it to the very top !';

        text_message_loser := text_message_loser || '. Sad defeat in the ' || tmp_text1 || ' ... It''s a disappointment but we''ll come back stronger next season, I''m sure we can make it !';



        ---- Insert into clubs_history table

        INSERT INTO clubs_history (id_club, is_ranking_description, description)

        VALUES (rec_game.id_club_overall_winner, TRUE,

            'Season ' || rec_game.season_number || ': Finished 3rd of ' || string_parser(rec_game.id_league, 'idLeague')),

        (

            rec_game.id_club_overall_loser, TRUE,

            'Season ' || rec_game.season_number || 'Finished 4th of ' || string_parser(rec_game.id_league, 'idLeague'));



        ---- Insert into the players_history table for winning club

        INSERT INTO players_history (id_player, id_club, is_ranking_description, description)

            SELECT

                id AS id_player, id_club AS id_club, TRUE AS is_ranking_description,

                'Season ' || rec_game.season_number || ': Victory in ' || tmp_text1

                || ' of ' || string_parser(rec_game.id_league, 'idLeague') || ' with ' || string_parser(id_club, 'idClub')

            FROM players

            WHERE id_club = rec_game.id_club_overall_winner;



        ---- Insert into the players_history table for losing club

        INSERT INTO players_history (id_player, id_club, is_ranking_description, description)

            SELECT

                id AS id_player, id_club AS id_club, TRUE AS is_ranking_description,

                'Season ' || rec_game.season_number || ': Defeat in ' || tmp_text1

                || ' of ' || string_parser(rec_game.id_league, 'idLeague') || ' with ' || string_parser(id_club, 'idClub')

            FROM players

            WHERE id_club = rec_game.id_club_overall_loser;



    -- First leg games of barrage 1 games

    ELSEIF rec_game.id_games_description = 211 THEN

        -- Draw

        IF rec_game.score_diff = 0 THEN

            text_title_winner := text_title_winner || ': Leg 1 Draw';

            text_title_loser := text_title_loser || ': Leg 1 Draw';

            text_message_winner := text_message_winner || '. The first leg of the barrage ended in a draw, nothing is lost, we can still make it in the second leg, let''s go !';

            text_message_loser := text_message_loser || '. The first leg of the barrage ended in a draw, nothing is lost, we can still make it in the second leg, let''s go !';

        ELSE

            text_title_winner := text_title_winner || ': Leg 1 Victory';

            text_title_loser := text_title_loser || ': Leg 1 Defeat';

            text_message_winner := text_message_winner || '. Great victory in the first leg of the barrage, we are so close to promotion, keep the team focused !';

            text_message_loser := text_message_loser || '. Unfortunately we have lost the first leg of the barrage. Nothing is lost, we can still make it in the second leg, let''s go !';

        END IF; --End right club won



    -- Return game of the first barrage (between firsts of opposite leagues)

    ELSIF rec_game.id_games_description = 212 THEN



        -- Send messages

        text_title_winner := text_title_winner || ': promotion to ' || string_parser(rec_game.id_league, 'idLeague');

        text_title_loser := text_title_loser || ': no direct promotion to ' || string_parser(rec_game.id_league, 'idLeague');

        text_message_winner := text_message_winner || '. This overall victory means that we will be playing in the upper league ' || string_parser(rec_game.id_league, 'idLeague') || ' next season. Congratulations to you and all the players, it''s time to party !';

        text_message_loser := text_message_loser || '. This overall defeat means that we will have to play another barrage against the 5th of the upper league ' || string_parser(rec_game.id_league, 'idLeague') || ' in order to take his place. We can do it, let''s go !';



        -- Winner of the barrage 1 is promoted to the upper league

        UPDATE clubs SET

            pos_league_next_season = 6,

            id_league_next_season = rec_game.id_league

        WHERE id = rec_game.id_club_overall_winner;



        -- 6th of the upper league is automatically droped down to the league of the winner of barrage 1

        UPDATE clubs SET

            pos_league_next_season = 3,

            id_league_next_season = (SELECT id_league FROM clubs WHERE id = rec_game.id_club_overall_winner)

        WHERE id = (SELECT id FROM clubs WHERE id_league = rec_game.id_league AND pos_league = 6);



        -- Send message to the club going down

        INSERT INTO messages_mail (id_club_to, sender_role, title, message) 

        VALUES

            ((SELECT id FROM clubs WHERE id_league = rec_game.id_league AND pos_league = 6), 'Coach',

            rec_game.game_presentation || ' of barrage 1 played ==> DEMOTED to ' ||

                string_parser((SELECT id_league FROM clubs WHERE id = rec_game.id_club_overall_winner),'idLeague'),

            string_parser(rec_game.id_club_overall_winner, 'idClub') || ' won the barrage 1 ' || rec_game.game_presentation || ' against ' || string_parser(rec_game.id_club_overall_loser, 'idClub') ||

            '. Next season we will play in ' || string_parser((SELECT id_league FROM clubs WHERE id = rec_game.id_club_overall_winner),'idLeague'));





    -- First leg games of barrage 1 games

    ELSIF rec_game.id_games_description = 213 THEN

        -- Draw

        IF rec_game.score_diff = 0 THEN

            text_title_winner := text_title_winner || ': Leg 1 Draw';

            text_title_loser := text_title_loser || ': Leg 1 Draw';

            text_message_winner := text_message_winner || '. The first leg of the barrage ended in a draw, nothing is lost, we can still make it in the second leg, let''s go !';

            text_message_loser := text_message_loser || '. The first leg of the barrage ended in a draw, nothing is lost, we can still make it in the second leg, let''s go !';

        ELSE

            text_title_winner := text_title_winner || ': Leg 1 Victory';

            text_title_loser := text_title_loser || ': Leg 1 Defeat';

            text_message_winner := text_message_winner || '. Great victory in the first leg of the barrage, we are so close to promotion, keep the team focused !';

            text_message_loser := text_message_loser || '. Unfortunately we have lost the first leg of the barrage. Nothing is lost, we can still make it in the second leg, let''s go !';

        END IF; --End right club won



    -- 4th and final game of the barrage 2 (week 14) between 5th of the upper league and loser of the barrage 1

    ELSEIF rec_game.id_games_description = 214 THEN

        

        -- Left club (5th of upper league) won so both clubs stay in their league

        IF rec_game.score_diff > 0 THEN

            -- 5th of upper league won, both clubs stay at their place and league

-- RAISE NOTICE '*** 2A: Left Club % (from league= %) won the game % (type= 214) and will stay in current league %', rec_game.id_club_left, rec_game.id_league_club_left2, rec_game.id, rec_game.id_league_club_left2;

-- RAISE NOTICE 'Right Club % (from league= %) lost the game % (type= 214) and will stay in current league %', rec_game.id_club_right, rec_game.id_league_club_right2, rec_game.id, rec_game.id_league_club_right2;



            -- Send messages

            text_title_winner := text_title_winner || ': BARRAGE2 Victory => We avoided relegation';

            text_title_loser := text_title_loser || ': BARRAGE2 Defeat => We failed to get promoted';

            text_message_winner := text_message_winner || '. This overall victory in the 2nd barrage means that we avoided relegation in a lower league. Congratulations to you and all the players, what a relief !';

            text_message_loser := text_message_loser || '. This overall defeat in the 2nd barrage means that we failed to get promoted to the upper league. It''s a disappointment but we''ll come back stronger next season, I''m sure we can make it !';



        -- Right club (loser of barrage 1) won so he is promoted to the league of the 5th of the upper league

        ELSE



-- RAISE NOTICE '*** 2B: Left Club % (from league= %) lost the game % (type= 214) and will be demoted to league %', rec_game.id_club_left, rec_game.id_league_club_left2, rec_game.id, rec_game.id_league_club_right2;

-- RAISE NOTICE 'Right Club % (from league= %) won the game % (type= 214) and will be promoted to league %', rec_game.id_club_right, rec_game.id_league_club_right2, rec_game.id, rec_game.id_league_club_left2;

            -- 5th of upper league lost, 5th of upper league will be demoted to the league of the winner of the game (loser of barrage 1)

            UPDATE clubs SET

                -- pos_league_next_season = (SELECT pos_league FROM clubs WHERE id = rec_game.id_club_right),

                pos_league_next_season = 1,

                id_league_next_season = (SELECT id_league FROM clubs WHERE id = rec_game.id_club_right)

            WHERE id = rec_game.id_club_left;



            -- Loser of barrage 1 won, he will be promoted to the league of the 5th of the upper league

            UPDATE clubs SET

                pos_league_next_season = 5,

                id_league_next_season = (SELECT id_league FROM clubs WHERE id = rec_game.id_club_left)

            WHERE id = rec_game.id_club_right;



            -- Send messages

            text_title_winner := text_title_winner || ': BARRAGE2 Defeat => We are demoted...';

            text_title_loser := text_title_loser || ': BARRAGE2 Victory => We are promoted !';

            text_message_winner := text_message_winner || '. This overall defeat in the 2nd barrage means that we are relegated to a lower league. It''s a disappointment but we''ll come back stronger next season, I''m sure we can make it !';

            text_message_loser := text_message_loser || '. This overall victory in the 2nd barrage means that we are promoted to the upper league next season. Congratulations to you and all the players, we made it !';



        END IF;



    ELSEIF rec_game.id_games_description IN (311, 312) THEN

    -- IF rec_game.id_games_description IN (311, 312, 331) THEN

        text_title_winner := text_title_winner || ': BARRAGE2 Game1 Victory';

        text_title_loser := text_title_loser || ': BARRAGE2 Defeat';

        text_message_winner := text_message_winner || '. Great victory in the first game of the barrage2, we are so close to promotion, keep the team focused !';

        text_message_loser := text_message_loser || '. Unfortunately we have lost the first game of the barrage. We won''t go up this season but we can make it next season ! We will play some friendly games for the rest of the interseason, use this time to prepare for the next season and try out new tactics and players !';



    -- Return game of the barrage 3 (week 14) between the 4th of the upper league and the winner of the 2nd round of the barrage 3

    ELSEIF rec_game.id_games_description = 332 THEN

        -- Left club (4th of upper league) won, both clubs stay in their league

        IF rec_game.score_diff > 0 THEN



-- RAISE NOTICE '*** 3A: Left Club % (from league= %) won the game % (type= 214) and will stay in current league %', rec_game.id_club_left, rec_game.id_league_club_left2, rec_game.id, rec_game.id_league_club_left2;

-- RAISE NOTICE 'Right Club % (from league= %) lost the game % (type= 214) and will stay in current league %', rec_game.id_club_right, rec_game.id_league_club_right2, rec_game.id, rec_game.id_league_club_right2;



            -- Send messages

            text_title_winner := text_title_winner || ': BARRAGE3 Victory => We avoided relegation';

            text_title_loser := text_title_loser || ': BARRAGE3 Defeat => We failed to get promoted';

            text_message_winner := text_message_winner || '. This overall victory in the 3rd barrage means that we avoided relegation in a lower league. Congratulations to you and all the players, what a relief !';

            text_message_loser := text_message_loser || '. This overall defeat in the 3rd barrage means that we failed to get promoted to the upper league. It''s a disappointment but we''ll come back stronger next season, I''m sure we can make it !';



        -- Right club (winner of the 2nd round of the barrage 2) won

        ELSE



-- RAISE NOTICE '*** 3B: Left Club % (from league= %) lost the game % (type= 214) and will be demoted to league %', rec_game.id_club_left, rec_game.id_league_club_left2, rec_game.id, rec_game.id_league_club_right2;

-- RAISE NOTICE 'Right Club % (from league= %) won the game % (type= 214) and will be promoted to league %', rec_game.id_club_right, rec_game.id_league_club_right2, rec_game.id, rec_game.id_league_club_left2;



            UPDATE clubs SET

                -- pos_league_next_season = (SELECT pos_league FROM clubs WHERE id = rec_game.id_club_right),

                pos_league_next_season = 4,

                -- id_league_next_season = (SELECT id_league FROM clubs WHERE id = rec_game.id_club_right)

                id_league_next_season = (SELECT id_league FROM clubs WHERE id = rec_game.id_club_right)

            WHERE id = rec_game.id_club_left;



            UPDATE clubs SET

                -- pos_league_next_season = (SELECT pos_league FROM clubs WHERE id = rec_game.id_club_left),

                pos_league_next_season = 1,

                -- id_league_next_season = (SELECT id_league FROM clubs WHERE id = rec_game.id_club_left)

                id_league_next_season = (SELECT id_league FROM clubs WHERE id = rec_game.id_club_left)

            WHERE id = rec_game.id_club_right;



            -- Send messages

            text_title_winner := text_title_winner || ': BARRAGE3 Defeat => We are demoted...';

            text_title_loser := text_title_loser || ': BARRAGE3 Victory => We are promoted !';

            text_message_winner := text_message_winner || '. This overall defeat in the 3rd barrage means that we are relegated to a lower league. It''s a disappointment but we''ll come back stronger next season, I''m sure we can make it !';

            text_message_loser := text_message_loser || '. This overall victory in the 3rd barrage means that we are promoted to the upper league next season. Congratulations to you and all the players, we made it !';



        END IF; -- End right club won

    END IF; -- End of the handling of the different games



    ------ Send messages

    INSERT INTO messages_mail (id_club_to, sender_role, title, message)

    VALUES

        (rec_game.id_club_overall_winner, 'Coach', text_title_winner, text_message_winner),

        (rec_game.id_club_overall_loser, 'Coach', text_title_loser, text_message_loser);





    ------ Set the game as played

    UPDATE games SET

        is_playing = FALSE,

        elo_exchanged_points = rec_game.exchanged_elo_points

    WHERE id = rec_game.id;



    ------ Update player to say they are not playing anymore

    UPDATE players SET

        is_playing = FALSE

    WHERE id_club IN (rec_game.id_club_left, rec_game.id_club_right);



    ------ Update left club

    UPDATE clubs SET

        lis_last_results = lis_last_results || 

            CASE 

                WHEN rec_game.score_diff > 0 THEN 3

                WHEN rec_game.score_diff < 0 THEN 0

                ELSE 1

            END,

        number_fans = CASE

            WHEN rec_game.score_diff > 0 THEN number_fans + 1

            WHEN rec_game.score_diff < 0 THEN number_fans - 1

            ELSE number_fans END,

        elo_points = elo_points + rec_game.exchanged_elo_points

    WHERE id = rec_game.id_club_left;



    ------ Update right club

    UPDATE clubs SET

        lis_last_results = lis_last_results || 

            CASE 

                WHEN rec_game.score_diff > 0 THEN 0

                WHEN rec_game.score_diff < 0 THEN 3

                ELSE 1

            END,

        number_fans = CASE

            WHEN rec_game.score_diff > 0 THEN number_fans - 1

            WHEN rec_game.score_diff < 0 THEN number_fans + 1

            ELSE number_fans END,

        elo_points = elo_points - rec_game.exchanged_elo_points

    WHERE id = rec_game.id_club_right;



    ------ Update the league points for games before week 10

    IF rec_game.week_number <= 10 THEN

        UPDATE clubs SET

            league_points = league_points + 

                CASE 

                    WHEN rec_game.score_diff > 0 THEN 3

                    WHEN rec_game.score_diff < 0 THEN 0

                    ELSE 1

                END,

            league_goals_for = league_goals_for + CASE WHEN rec_game.score_left = -1 THEN 0 ELSE rec_game.score_left END,

            league_goals_against = league_goals_against + CASE WHEN rec_game.score_right = -1 THEN 0 ELSE rec_game.score_right END

        WHERE id = rec_game.id_club_left;



        UPDATE clubs SET

            league_points = league_points + 

                CASE 

                    WHEN rec_game.score_diff > 0 THEN 0

                    WHEN rec_game.score_diff < 0 THEN 3

                    ELSE 1

                END,

            league_goals_for = league_goals_for + CASE WHEN rec_game.score_right = -1 THEN 0 ELSE rec_game.score_right END,

            league_goals_against = league_goals_against + CASE WHEN rec_game.score_left = -1 THEN 0 ELSE rec_game.score_left END

        WHERE id = rec_game.id_club_right;

    END IF;



END;

$$;


ALTER FUNCTION public.simulate_game_set_is_played(inp_id_game bigint) OWNER TO postgres;

--
-- Name: simulate_week_games(record, bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.simulate_week_games(multiverse record, inp_season_number bigint, inp_week_number bigint) RETURNS boolean
    LANGUAGE plpgsql
    AS $$

DECLARE

    league RECORD; -- Record for the leagues loop

    club RECORD; -- Record for the clubs loop

    game RECORD; -- Record for the game loop

    is_league_game_finished bool; -- If a game from the league was played, recalculate the rankings

    pos integer; -- Position in the league

BEGIN



    ------------ Loop through all leagues of the multiverse

    FOR league IN (

        SELECT * FROM leagues WHERE id_multiverse = multiverse.id)

    LOOP



        ------ Loop through the games that need to be played for the current week of the current league

        FOR game IN

            (SELECT id FROM games

                WHERE id_league = league.id

                AND date_end IS NULL

                AND season_number <= inp_season_number

                AND week_number <= inp_week_number

                AND now() > date_start

                ORDER BY season_number, week_number, id)

        LOOP



            -- Simulate the game

            PERFORM simulate_game_main(inp_id_game := game.id);

        

        END LOOP; -- End of the loop of the games simulation



        -- Set to FALSE by default

        is_league_game_finished := FALSE;



        ------ Loop through the games that are finished for the current week of the current league

        FOR game IN

            (SELECT id FROM games

                WHERE id_league = league.id

                AND now() >= date_end

                AND is_playing = TRUE

                AND season_number <= inp_season_number

                AND week_number <= inp_week_number

                ORDER BY id)

        LOOP

            PERFORM simulate_game_set_is_played(inp_id_game := game.id);



            -- Say that a game from the league was finished

            is_league_game_finished := TRUE;

        

        END LOOP; -- End of the loop of the games simulation



        -- If a game from the league was played, recalculate the rankings

        IF is_league_game_finished = TRUE THEN

            -- Calculate rankings for normal leagues

            IF league.LEVEL > 0 AND multiverse.week_number <= 10 THEN

                -- Calculate rankings for each clubs in the league

                pos := 1;

                FOR club IN

                    (SELECT * FROM clubs

                        WHERE id_league = league.id

                        ORDER BY league_points DESC,

                            (league_goals_for - league_goals_against) DESC,

                            pos_last_season,

                            created_at ASC)

                LOOP

                    -- Update the position in the league of this club

                    UPDATE clubs

                        SET pos_league = pos

                        WHERE id = club.id;



                    -- Update the leagues rankings

                    UPDATE leagues

                        SET id_clubs[pos] = club.id,

                        points[pos] = club.league_points

                        WHERE id = league.id;



                    -- Update the position

                    pos := pos + 1;

                    

                END LOOP; -- End of the loop through clubs

            END IF; -- End of the calculation of the rankings of the normal leagues

        END IF; -- End of the check if a game from the league was played

    END LOOP; -- End of the loop through leagues



    ------ If all games of the week are finished, return TRUE

    IF (

        -- Check if there are games from the current week that are not finished

        SELECT COUNT(id)

        FROM games

        WHERE is_playing <> FALSE

        AND season_number = inp_season_number

        AND week_number = inp_week_number) > 0

    THEN

        RETURN FALSE;

    ELSE

        RETURN TRUE;

    END IF;

    

END;

$$;


ALTER FUNCTION public.simulate_week_games(multiverse record, inp_season_number bigint, inp_week_number bigint) OWNER TO postgres;

--
-- Name: string_parser(bigint, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.string_parser(inp_id bigint, inp_entity_type text, inp_text text DEFAULT NULL::text) RETURNS text
    LANGUAGE plpgsql
    AS $$

DECLARE

    loc_record RECORD;

    loc_name TEXT;

BEGIN

    CASE inp_entity_type

        WHEN 'idPlayer' THEN

            SELECT id, player_get_full_name(id) AS full_name INTO loc_record FROM players WHERE id = inp_id;

            loc_name := COALESCE(inp_text, loc_record.full_name);

        WHEN 'idClub' THEN

            SELECT id, name INTO loc_record FROM clubs WHERE id = inp_id;

            loc_name := COALESCE(inp_text, loc_record.name);

        WHEN 'idLeague' THEN

            SELECT id, name INTO loc_record FROM leagues WHERE id = inp_id;

            loc_name := COALESCE(inp_text, loc_record.name);

        WHEN 'idGame' THEN

            SELECT id, 'S' || season_number || 'W' || week_number || ' game' AS name INTO loc_record FROM games WHERE id = inp_id;

            loc_name := COALESCE(inp_text, loc_record.name);

        WHEN 'idTeamcomp' THEN

            SELECT id, 'S' || season_number || 'W'  || week_number || ' teamcomp' AS name INTO loc_record FROM teamcomps WHERE id = inp_id;

            loc_name := COALESCE(inp_text, loc_record.name);

        -- WHEN 'user' THEN

        --     SELECT id, 'league' || level || '.' || number AS name INTO loc_record FROM leagues WHERE id = inp_id;

        --     RETURN '{idUser:' || id || '}';

        -- WHEN 'continent' THEN

        --     -- ...existing code...

        --     RETURN '{continent:' || id || '}';

        ELSE

            RAISE EXCEPTION 'Invalid entity type: %', inp_entity_type;

    END CASE;

    RETURN '{' || inp_entity_type || ':' || loc_record.id || ',' || loc_name || '}';

END;

$$;


ALTER FUNCTION public.string_parser(inp_id bigint, inp_entity_type text, inp_text text) OWNER TO postgres;

--
-- Name: teamcomp_check_and_try_populate_if_error(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.teamcomp_check_and_try_populate_if_error(inp_id_teamcomp bigint) RETURNS boolean
    LANGUAGE plpgsql
    AS $$

DECLARE

    loc_player_count INT; -- Number of missing players in the team composition

    loc_players_id INT8[21]; -- Array to hold player IDs from games_teamcomp table

    loc_random_players INT8[]; -- Array to hold random player IDs that are used to set the missing positions

BEGIN



--RAISE NOTICE '###### TRY POPULATE TEAMCOMP[%] FIRST CHECK', inp_id_teamcomp;

    ------ If the inputed teamcomp is valid

    IF teamcomp_check_or_correct_errors(

        inp_id_teamcomp := inp_id_teamcomp,

        inp_bool_try_to_correct := FALSE) IS TRUE

    THEN

--RAISE NOTICE '### TRY POPULATE TEAMCOMP 1: VALID';

        RETURN TRUE; -- Return TRUE

    END IF;

--RAISE NOTICE '### TRY POPULATE TEAMCOMP 1: NOT VALID';



--RAISE NOTICE '###### TRY POPULATE TEAMCOMP[%] TRY POPULATE DEFAULT', inp_id_teamcomp;

    ------ Otherwise, try to copy the first default teamcomp

    PERFORM teamcomp_copy_previous(inp_id_teamcomp := inp_id_teamcomp);



    ------ If the newly inputed teamcomp is valid

    IF teamcomp_check_or_correct_errors(

        inp_id_teamcomp := inp_id_teamcomp,

        inp_bool_try_to_correct := FALSE) IS TRUE

    THEN

--RAISE NOTICE '### TRY POPULATE TEAMCOMP 2: VALID';

        RETURN TRUE; -- Return TRUE

    END IF;

--RAISE NOTICE '### TRY POPULATE TEAMCOMP 2: NOT VALID';



--RAISE NOTICE '###### TRY POPULATE TEAMCOMP[%] TRY TO CORRECT', inp_id_teamcomp;

    ------ Otherwise, try to populate the teamcomp with the final function to correct errors

    RETURN teamcomp_check_or_correct_errors(

        inp_id_teamcomp := inp_id_teamcomp,

        inp_bool_try_to_correct := TRUE,

        inp_bool_notify_user := TRUE);



END;

$$;


ALTER FUNCTION public.teamcomp_check_and_try_populate_if_error(inp_id_teamcomp bigint) OWNER TO postgres;

--
-- Name: teamcomp_check_or_correct_errors(bigint, boolean, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.teamcomp_check_or_correct_errors(inp_id_teamcomp bigint, inp_bool_try_to_correct boolean DEFAULT false, inp_bool_notify_user boolean DEFAULT false) RETURNS boolean
    LANGUAGE plpgsql
    AS $$

DECLARE

    rec_teamcomp RECORD; -- Record to store the teamcomp

    array_id_players int8[]; -- Array of the players id in the teamcomp

    array_id_players_tmp INT[] := NULL; -- Helper Array of players id for removing and adding

    loc_count INT; -- Number of players in the teamcomp

    I INT; -- Variable for loop index

    text_return TEXT[] := ARRAY[]::TEXT[]; -- Array to store error messages

BEGIN



    ------ Fetch the teamcomp record

    SELECT * INTO rec_teamcomp FROM games_teamcomp WHERE id = inp_id_teamcomp;



    ------ If the teamcomp is not in the database, return an error

    IF NOT FOUND THEN

        RAISE EXCEPTION 'The teamcomp with id % does not exist', inp_id_teamcomp;

    END IF;



    ------ Fetch players id into a temporary array

    array_id_players := teamcomp_fetch_players_id(inp_id_teamcomp := inp_id_teamcomp);



--RAISE NOTICE '###### 0) array_id_players: %', array_id_players;



    -- array_id_players := ARRAY[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20];

    -- array_id_players := ARRAY[1, 2, 3, NULL, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, NULL, NULL, NULL, 18, 19, 20];

--RAISE NOTICE '0) array_id_players: %', array_id_players;

    ------------------------------------------------------------------------------------------------------------------------

    ------------------------------------------------------------------------------------------------------------------------

    ------------ Remove any player ID that is not from the club anymore

    ------ Select the players id that are in the teamcomp but not in the club anymore

    SELECT array_agg(id) INTO array_id_players_tmp FROM players

    WHERE id = ANY(array_id_players)

    AND id_club IS DISTINCT FROM rec_teamcomp.id_club;



--RAISE NOTICE 'Players from club%: %', rec_teamcomp.id_club, (SELECT array_agg(id) FROM players WHERE id_club = rec_teamcomp.id_club);

--RAISE NOTICE '==> PLAYERS IN TEAMCOMP BUT NOT IN CLUB: array_id_players_tmp: %', array_id_players_tmp;



    ------ If there are players that are not from the club anymore, remove them from the teamcomp

    IF array_id_players_tmp IS NOT NULL THEN

        ------ Loop through the teamcomp players and set null when id in array_id_players_tmp

        FOR I IN 1..21 LOOP

            --- Loop through the players in the teamcomp

            IF array_id_players[I] = ANY(array_id_players_tmp) THEN



                -- Append the player to the text to return

                text_return := array_append(text_return, '[' || player_get_full_name(array_id_players[I]) || '] in slot [' || I ||'] is not in the club anymore');

                

                -- If the boolean is set to true, remove the player from the teamcomp

                IF inp_bool_try_to_correct THEN

                    array_id_players[I] := NULL;

                END IF;

            END IF;

        END LOOP;

    END IF;



--RAISE NOTICE '1) array_id_players: %', array_id_players;



    ------------------------------------------------------------------------------------------------------------------------

    ------------------------------------------------------------------------------------------------------------------------

    ------------ Remove players when they appear more than once in the teamcomp

    ------ Initialize the array of seen IDs

    array_id_players_tmp := ARRAY[]::INT[];



    ------ Iterate through the list of players and remove the duplicates

    FOR I IN 1..array_length(array_id_players, 1) LOOP

        -- Check if the ID has been seen before

        IF array_id_players[I] = ANY(array_id_players_tmp) THEN

            

            ---- Append the duplicate player to the text to return

            text_return := array_append(text_return, player_get_full_name(array_id_players[I]) || ' is already present in the teamcomp');

            

            ---- If the boolean is set to true, remove the players from the teamcomp

            IF inp_bool_try_to_correct THEN

                array_id_players[I] := NULL;

            END IF;

        ELSE

            -- Add the ID to the seen_ids array

            array_id_players_tmp := array_append(array_id_players_tmp, array_id_players[I]);

        END IF;

    END LOOP;



--RAISE NOTICE '2) array_id_players= %', array_id_players;



    ------------------------------------------------------------------------------------------------------------------------

    ------------------------------------------------------------------------------------------------------------------------

    ------------ Remove any player that make the teamcomp have more than 11 players in the 14 first positions

    SELECT COUNT(id) INTO loc_count FROM unnest(array_remove(array_id_players[1:14],NULL)) AS id;

--RAISE NOTICE 'START Number of players in the 14 starting positions: loc_count= %', loc_count;

    

    ------ If the boolean is set to true, remove the players from the teamcomp

    IF inp_bool_try_to_correct THEN

        

        ------ While there are more than 11 players in the teamcomp

        WHILE loc_count > 11 LOOP

            -- Loop through the 3 central positions (13, 4, 9) and remove the player if there is one

            FOR idx IN 1..3 LOOP

                I := CASE idx

                    WHEN 1 THEN 13

                    WHEN 2 THEN 4

                    WHEN 3 THEN 9

                END;



                -- If the player is not null, remove it

                IF array_id_players[I] IS NOT NULL THEN



                    -- Loop through the 7 subs positions and find a place for the removed player

                    FOR J IN 15..21 LOOP



                        -- If there is a slot available

                        IF array_id_players[J] IS NULL THEN



                            -- Store the removed player to the available sub slot

                            array_id_players[J] := array_id_players[I];

                            EXIT;

                        END IF;

                    END LOOP;



                    -- Remove the player from the teamcomp

                    array_id_players[I] := NULL;



                    -- Update the count of players in the teamcomp

                    loc_count := loc_count - 1;

                    EXIT; -- Exit the loop

                END IF;

            END LOOP;

        END LOOP;



--RAISE NOTICE '3) array_id_players= %', array_id_players;



        ------------------------------------------------------------------------------------------------------------------------

        ------------------------------------------------------------------------------------------------------------------------

        ------------ Add players to the teamcomp if there are less than 11 players

        ------ Select the players from the club that are not in the starting positions

        SELECT array_agg(id ORDER BY performance_score DESC) INTO array_id_players_tmp FROM players

        WHERE id NOT IN (

            SELECT unnest(array_remove(array_id_players[1:14], NULL))

        )

        AND id_club = rec_teamcomp.id_club;



--RAISE NOTICE 'AVAILABLE PLAYERS= %', array_id_players_tmp;



        ------ While there are less than 11 players in the teamcomp, try to fill the missing positions

        WHILE loc_count < 11 AND array_length(array_id_players_tmp, 1) > 0 LOOP

            -- Loop through the 11 first positions and add the player if there is none

            FOR idx IN 1..11 LOOP

                I := CASE idx

                    WHEN 1 THEN 1

                    WHEN 2 THEN 2

                    WHEN 3 THEN 3

                    WHEN 4 THEN 5

                    WHEN 5 THEN 6

                    WHEN 6 THEN 7

                    WHEN 7 THEN 8

                    WHEN 8 THEN 10

                    WHEN 9 THEN 11

                    WHEN 10 THEN 12

                    WHEN 11 THEN 14

                END;



                -- If the position is null, add the player

                IF array_id_players[I] IS NULL THEN



                    -- Add the player to the teamcomp

                    array_id_players[I] := array_id_players_tmp[1];



                    -- Remove the player from the list of available players

                    array_id_players_tmp := array_id_players_tmp[2:array_length(array_id_players_tmp, 1)];



                    -- Remove the added player if he is in the subs positions

                    FOR J IN 15..21 LOOP

                        IF array_id_players[I] = array_id_players[J] THEN

                            array_id_players[J] := NULL;

                        END IF;

                    END LOOP;



                    loc_count := loc_count + 1;

                    EXIT;

                END IF; -- End if position is null

            END LOOP; -- End for the 11 main starting positions

        END LOOP; -- End while loc_count < 11 AND players available



        ------------------------------------------------------------------------------------------------------------------------

        ------------------------------------------------------------------------------------------------------------------------

        ------------ Finally try to populate the subs positions

        ------ Select the players from the club that are not in the starting positions

        SELECT array_agg(id ORDER BY performance_score DESC) INTO array_id_players_tmp FROM players

        WHERE id NOT IN (SELECT unnest(array_remove(array_id_players, NULL)))

        AND id_club = rec_teamcomp.id_club;



    ------ OPTIMIZE THIS PART !!!!!!!!!!!!

        ------ Loop through the subs positions and add the players if there are any

        FOR I IN 15..21 LOOP

            -- If the position is null, add the player

            IF array_id_players[I] IS NULL AND array_length(array_id_players_tmp, 1) > 0 THEN



                -- Add the player to the teamcomp

                array_id_players[I] := array_id_players_tmp[1];



                -- Remove the player from the list of available players

                array_id_players_tmp := array_id_players_tmp[2:array_length(array_id_players_tmp, 1)];



            END IF;

        END LOOP;



    END IF; -- End if try to correct



--RAISE NOTICE 'END Number of players in the 14 starting positions: loc_count= %', loc_count;

    

    IF loc_count < 10 THEN

        text_return := array_append(text_return, 11-loc_count || ' players missing in the starting slots of the teamcomp');

    ELSIF loc_count = 10 THEN

        text_return := array_append(text_return, ' 1 player missing in the starting slot of the teamcomp');

    ELSIF loc_count = 12 THEN

        text_return := array_append(text_return, ' 1 extra player found in the starting slot of the teamcomp, (12 players instead of 11)');

    ELSIF loc_count > 12 THEN

        text_return := array_append(text_return, loc_count - 11 || ' extra players found in the starting slots of the teamcomp, (' || loc_count || ' instead of 11)');

    END IF;



--RAISE NOTICE '5) array_id_players= %', array_id_players;

--RAISE NOTICE '###### Errors in teamcomp %: %', inp_id_teamcomp, text_return;



    ------------------------------------------------------------------------------------------------------------------------

    ------------------------------------------------------------------------------------------------------------------------

    ------------ Update the games_teamcomp table with the new corrected list of players id

    ------ If some errors were found, update the teamcomp error field

    IF array_length(text_return, 1) > 0 THEN

        

        ---- If the boolean is set to true, update the teamcomp with the corrected list of players

        IF inp_bool_try_to_correct = TRUE THEN

            UPDATE games_teamcomp SET 

                idgoalkeeper = array_id_players[1],

                idleftbackwinger = array_id_players[2],

                idleftcentralback = array_id_players[3],

                idcentralback = array_id_players[4],

                idrightcentralback = array_id_players[5],

                idrightbackwinger = array_id_players[6],

                idleftwinger = array_id_players[7],

                idleftmidfielder = array_id_players[8],

                idcentralmidfielder = array_id_players[9],

                idrightmidfielder = array_id_players[10],

                idrightwinger = array_id_players[11],

                idleftstriker = array_id_players[12],

                idcentralstriker = array_id_players[13],

                idrightstriker = array_id_players[14],

                idsub1 = array_id_players[15],

                idsub2 = array_id_players[16],

                idsub3 = array_id_players[17],

                idsub4 = array_id_players[18],

                idsub5 = array_id_players[19],

                idsub6 = array_id_players[20],

                idsub7 = array_id_players[21]

            WHERE id = inp_id_teamcomp;

            ---- The update will triger the trigger to update the teamcomp error field



            ---- If the user needs to be notified, send a message to the user

            IF inp_bool_notify_user IS TRUE THEN



                ---- Send a message to the user

                INSERT INTO messages_mail (id_club_to, sender_role, title, message)

                    VALUES

                        (rec_teamcomp.id_club, 'Coach',

                        -- (SELECT date_now FROM multiverses WHERE id = (SELECT id_multiverse FROM clubs WHERE id = rec_teamcomp.id_club)),

                        array_length(text_return, 1) || ' Errors in teamcomp of S' || rec_teamcomp.season_number || 'W' || rec_teamcomp.week_number,

                        'I tried correcting the ' || string_parser(rec_teamcomp.id, 'idTeamcomp') || ' for the game of S' || rec_teamcomp.season_number || 'W' || rec_teamcomp.week_number || '. It contained ' || array_length(text_return, 1) || ' errors !');



            END IF;



            ---- Return true if the teamcomp is now valid

            IF (SELECT error FROM games_teamcomp WHERE id = inp_id_teamcomp) IS NULL THEN

--RAISE NOTICE 'Teamcomp % is now valid (TRY TO CORRECT TRUE)', inp_id_teamcomp;

                RETURN TRUE;

            ELSE -- Otherwise return false

--RAISE NOTICE 'Teamcomp % is not valid (TRY TO CORRECT TRUE)', inp_id_teamcomp;

                RETURN FALSE;

            END IF;



        ---- Otherwise, store the error messages in the teamcomp error field

        ELSE

            UPDATE games_teamcomp SET error = text_return WHERE id = inp_id_teamcomp;

--RAISE NOTICE 'Teamcomp % is not valid (TRY TO CORRECT FALSE)', inp_id_teamcomp;

            RETURN FALSE;

        END IF;

    ------ Otherwise set the error field to null

    ELSE

        UPDATE games_teamcomp SET error = NULL WHERE id = inp_id_teamcomp;

--RAISE NOTICE 'Teamcomp % is valid (TRY TO CORRECT FALSE)', inp_id_teamcomp;

        RETURN TRUE;

    END IF;



--RAISE NOTICE '*** FIN array_id_players= %', array_id_players;



END;

$$;


ALTER FUNCTION public.teamcomp_check_or_correct_errors(inp_id_teamcomp bigint, inp_bool_try_to_correct boolean, inp_bool_notify_user boolean) OWNER TO postgres;

--
-- Name: teamcomp_copy_previous(bigint, bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.teamcomp_copy_previous(inp_id_teamcomp bigint, inp_season_number bigint DEFAULT 0, inp_week_number bigint DEFAULT 1) RETURNS void
    LANGUAGE plpgsql
    AS $$

DECLARE

    loc_id_teamcomp_ref bigint;

BEGIN



    -- Set all to NULL

    IF inp_season_number = -999 THEN

        UPDATE games_teamcomp SET

            idgoalkeeper = NULL,

            idleftbackwinger = NULL, idleftcentralback = NULL, idcentralback = NULL, idrightcentralback = NULL, idrightbackwinger = NULL,

            idleftwinger = NULL, idleftmidfielder = NULL, idcentralmidfielder = NULL, idrightmidfielder = NULL, idrightwinger = NULL,

            idleftstriker = NULL, idcentralstriker = NULL, idrightstriker = NULL,

            idsub1 = NULL, idsub2 = NULL, idsub3 = NULL, idsub4 = NULL, idsub5 = NULL, idsub6 = NULL, idsub7 = NULL

        WHERE id = inp_id_teamcomp;



    ELSE



        -- Fetch the teamcomp id of the reference to copy from

        SELECT id INTO loc_id_teamcomp_ref FROM games_teamcomp

        WHERE id_club = (

            SELECT id_club FROM games_teamcomp WHERE id = inp_id_teamcomp

            ) AND season_number = inp_season_number AND week_number = inp_week_number;



        -- Set the players id from the previous teamcomp

        UPDATE games_teamcomp SET

            idgoalkeeper = teamcomp_ref.idgoalkeeper,

            idleftbackwinger = teamcomp_ref.idleftbackwinger,

            idleftcentralback = teamcomp_ref.idleftcentralback,

            idcentralback = teamcomp_ref.idcentralback,

            idrightcentralback = teamcomp_ref.idrightcentralback,

            idrightbackwinger = teamcomp_ref.idrightbackwinger,

            idleftwinger = teamcomp_ref.idleftwinger,

            idleftmidfielder = teamcomp_ref.idleftmidfielder,

            idcentralmidfielder = teamcomp_ref.idcentralmidfielder,

            idrightmidfielder = teamcomp_ref.idrightmidfielder,

            idrightwinger = teamcomp_ref.idrightwinger,

            idleftstriker = teamcomp_ref.idleftstriker,

            idcentralstriker = teamcomp_ref.idcentralstriker,

            idrightstriker = teamcomp_ref.idrightstriker,

            idsub1 = teamcomp_ref.idsub1,

            idsub2 = teamcomp_ref.idsub2,

            idsub3 = teamcomp_ref.idsub3,

            idsub4 = teamcomp_ref.idsub4,

            idsub5 = teamcomp_ref.idsub5,

            idsub6 = teamcomp_ref.idsub6,

            idsub7 = teamcomp_ref.idsub7

        FROM (

            SELECT

                idgoalkeeper,

                idleftbackwinger, idleftcentralback, idcentralback, idrightcentralback, idrightbackwinger,

                idleftwinger, idleftmidfielder, idcentralmidfielder, idrightmidfielder, idrightwinger,

                idleftstriker, idcentralstriker, idrightstriker,

                idsub1, idsub2, idsub3, idsub4, idsub5, idsub6, idsub7

            FROM games_teamcomp

            WHERE id = loc_id_teamcomp_ref

        ) AS teamcomp_ref

        WHERE id = inp_id_teamcomp;

    END IF;



    -- Clean the game orders

    DELETE FROM game_orders WHERE id_teamcomp = inp_id_teamcomp;



    IF inp_season_number != -999 THEN

        -- Insert the game orders

        INSERT INTO game_orders (id_teamcomp, id_player_out, id_player_in, minute, condition)

        SELECT inp_id_teamcomp, id_player_out, id_player_in, minute, condition

        FROM game_orders

        WHERE id_teamcomp = loc_id_teamcomp_ref;

    END IF;



END;

$$;


ALTER FUNCTION public.teamcomp_copy_previous(inp_id_teamcomp bigint, inp_season_number bigint, inp_week_number bigint) OWNER TO postgres;

--
-- Name: teamcomp_fetch_players(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.teamcomp_fetch_players(inp_id_teamcomp bigint) RETURNS TABLE(position_id integer, position_name text, players_coef double precision[], id_players bigint, full_name text, subs integer, players_stats double precision[], players_stats_other double precision[])
    LANGUAGE plpgsql
    AS $$

BEGIN

    RETURN QUERY

    WITH teamcomp AS (

        SELECT

            UNNEST(ARRAY[

                gt.idgoalkeeper,

                gt.idleftbackwinger,

                gt.idleftcentralback,

                gt.idcentralback,

                gt.idrightcentralback,

                gt.idrightbackwinger,

                gt.idleftwinger,

                gt.idleftmidfielder,

                gt.idcentralmidfielder,

                gt.idrightmidfielder,

                gt.idrightwinger,

                gt.idleftstriker,

                gt.idcentralstriker,

                gt.idrightstriker,

                gt.idsub1,

                gt.idsub2,

                gt.idsub3,

                gt.idsub4,

                gt.idsub5,

                gt.idsub6

            ]) AS id_players,

            UNNEST(ARRAY[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]) AS position_id -- Match positions

        FROM games_teamcomp gt

        WHERE gt.id = inp_id_teamcomp

    )

    SELECT

        teamcomp.position_id,

        games_possible_position.position_name,

        games_possible_position.coefs::double precision[] AS players_coef,

        teamcomp.id_players,

        (players.first_name || ' ' || players.last_name) AS full_name,

        teamcomp.position_id AS subs,

        ARRAY[

            COALESCE(players.keeper, 0),

            COALESCE(players.defense, 0),

            COALESCE(players.passes, 0),

            COALESCE(players.playmaking, 0),

            COALESCE(players.winger, 0),

            COALESCE(players.scoring, 0),

            COALESCE(players.freekick, 0)

        ] AS players_stats,

        ARRAY[

            COALESCE(players.motivation, 0),

            COALESCE(players.form, 0),

            COALESCE(players.experience, 0),

            COALESCE(players.energy, 0),

            COALESCE(players.stamina, 0)

        ] AS players_stats_other

    FROM

        teamcomp

    JOIN

        games_possible_position ON teamcomp.position_id = games_possible_position.id

    LEFT JOIN

        players ON teamcomp.id_players = players.id

    ORDER BY

        teamcomp.position_id;

END;

$$;


ALTER FUNCTION public.teamcomp_fetch_players(inp_id_teamcomp bigint) OWNER TO postgres;

--
-- Name: teamcomp_fetch_players_id(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.teamcomp_fetch_players_id(inp_id_teamcomp bigint) RETURNS bigint[]
    LANGUAGE plpgsql
    AS $$

BEGIN

    -- Fetch the players id from the given teamcomp

    RETURN (

        SELECT ARRAY[

            idgoalkeeper, idleftbackwinger, idleftcentralback, idcentralback, idrightcentralback, idrightbackwinger,

            idleftwinger, idleftmidfielder, idcentralmidfielder, idrightmidfielder, idrightwinger,

            idleftstriker, idcentralstriker, idrightstriker,

            idsub1, idsub2, idsub3, idsub4, idsub5, idsub6, idsub7

        ]

        FROM games_teamcomp

        WHERE id = inp_id_teamcomp

    );

END;

$$;


ALTER FUNCTION public.teamcomp_fetch_players_id(inp_id_teamcomp bigint) OWNER TO postgres;

--
-- Name: transfers_handle_new_bid(bigint, bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.transfers_handle_new_bid(inp_id_player bigint, inp_id_club_bidder bigint, inp_amount bigint) RETURNS void
    LANGUAGE plpgsql
    AS $$

DECLARE

    latest_bid RECORD; -- Current highest bid on the player

    rec_player RECORD; -- Player record

    rec_club_bidder RECORD; -- Club bidder record

BEGIN



    ------ CHECKS

    IF inp_id_player IS NULL THEN

        RAISE EXCEPTION 'Player id cannot be NULL';

    ------ Check: Bid should be at least 100

    ELSIF inp_amount < 100 THEN

        RAISE EXCEPTION 'The amount of the bid cannot be lower than 100 ==> %', inp_amount;

    ------ Check: Club id cannot be null

    ELSIF inp_id_club_bidder IS NULL THEN

        RAISE EXCEPTION 'Club id cannot be null !';

    END IF;

    

    ------ Get the player record

    SELECT players.*, player_get_full_name(players.id) AS full_name, multiverses.speed INTO rec_player

    FROM players

    LEFT JOIN clubs ON clubs.id = players.id_club

    JOIN multiverses ON multiverses.id = players.id_multiverse

    WHERE players.id = inp_id_player;

    

    ------ CHECKS on the player record

    IF NOT FOUND THEN

        RAISE EXCEPTION 'Player with id % does not exist', inp_id_player;

    ------ Check that the bidding time isn't over yet

    ELSIF rec_player.date_bid_end < now() THEN

        RAISE EXCEPTION 'Cannot bid on % because the bidding time is over', rec_player.full_name;

    END IF;



    ------ Get the club bidder record

    SELECT * INTO rec_club_bidder FROM clubs WHERE id = inp_id_club_bidder;



    ------ CHECKS on the club bidder record

    IF NOT FOUND THEN

        RAISE EXCEPTION 'Club with id % does not exist', inp_id_club_bidder;

    ------ Check: Club should have enough available cash

    ELSEIF rec_club_bidder.cash < inp_amount THEN

        RAISE EXCEPTION '% does not have enough cash (%) to place a bid of % !', rec_club_bidder.name, rec_club_bidder.cash, inp_amount;

    ------ Check that the multiverse are the same between the club and the player

    ELSIF rec_player.id_multiverse != rec_club_bidder.id_multiverse THEN

        RAISE EXCEPTION 'Player multiverse id (%) is different then the one of the club (%)', rec_player.id_multiverse, rec_club_bidder.id_multiverse;

    END IF;



    -- Get the latest bid made on the player

    SELECT * INTO latest_bid

    FROM (

        SELECT *

        FROM transfers_bids

        WHERE id_player = inp_id_player

        ORDER BY created_at DESC

        LIMIT 1

    ) AS latest_bid;



    ------ Handle normal players

    IF rec_player.username IS NULL THEN



        ---- If there was a previous bid

        IF latest_bid IS NOT NULL THEN



            -- Check: Bid should be at least 1% increase from the previous bid

            IF inp_amount < CEIL(latest_bid.amount * 1.01)  THEN

                RAISE EXCEPTION 'The new bid (%) should be greater than 1 percent of the previous bid (%) !', inp_amount, latest_bid.amount;

            END IF;



            -- Reset available cash for previous bidder

            UPDATE clubs SET

                cash = cash + latest_bid.amount,

                expenses_transfers_expected = expenses_transfers_expected - latest_bid.amount

            WHERE id = latest_bid.id_club;



            -- Update the selling club expected revenues

            IF rec_player.id_club IS NOT NULL THEN

                UPDATE clubs SET

                    revenues_transfers_expected = revenues_transfers_expected - latest_bid.amount

                WHERE id = rec_player.id_club;

            END IF;

            

            -- Send message to previous bidder

            INSERT INTO messages_mail (id_club_to, sender_role, title, message)

            VALUES (

                latest_bid.id_club, 'Treasurer',

                'Outbided on ' || string_parser(rec_player.id, 'idPlayer'),

                'A new bid of ' || inp_amount || ' was made on ' || string_parser(rec_player.id, 'idPlayer') || ' by ' || string_parser(rec_club_bidder.id, 'idClub') || '. We are not favourite anymore');

            

        END IF;



        ---- Insert the new bid

        INSERT INTO transfers_bids (id_player, id_club, amount, name_club)

        VALUES (rec_player.id, rec_club_bidder.id, inp_amount, (SELECT name FROM clubs WHERE id = rec_club_bidder.id));



        ---- Decrease available cash for current bidder

        UPDATE clubs SET

            cash =  cash - inp_amount,

            expenses_transfers_expected = expenses_transfers_expected + inp_amount

            WHERE id = inp_id_club_bidder;



        ---- Update the selling club expected revenues

        IF rec_player.id_club IS NOT NULL THEN

            UPDATE clubs SET

                revenues_transfers_expected = revenues_transfers_expected + inp_amount

            WHERE id = rec_player.id_club;

        END IF;



        ---- Update players table with the new transfer_price and date_bid_end

        UPDATE players SET

            transfer_price = CASE

                WHEN transfer_price < 0 THEN - inp_amount

                ELSE inp_amount

            END,

            date_bid_end = CASE

                WHEN date_bid_end < NOW() + INTERVAL '5 minutes' THEN

                    date_trunc('minute', NOW()) + INTERVAL '5 minutes'

                ELSE date_bid_end

            END

        WHERE id = rec_player.id;



    ------ Handle incarnated players

    ELSE



    END IF;



END;

$$;


ALTER FUNCTION public.transfers_handle_new_bid(inp_id_player bigint, inp_id_club_bidder bigint, inp_amount bigint) OWNER TO postgres;

--
-- Name: transfers_handle_transfers(record); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.transfers_handle_transfers(inp_multiverse record) RETURNS void
    LANGUAGE plpgsql
    AS $$

DECLARE

    player RECORD; -- Record variable to store each row from the query

    last_bid RECORD; -- Record variable to store the last bid for each player

    teamcomp RECORD; -- Record variable to store the teamcomp

    loc_tmp INT8; -- Variable to store the count of rows affected by the query

BEGIN



    -- Query to select rows to process (bids finished and player is not currently playing a game)

    FOR player IN (

        SELECT *, player_get_full_name(id) AS full_name

            FROM players

            WHERE date_bid_end < NOW()

            AND is_playing = FALSE

            AND id_multiverse = inp_multiverse.id

    ) LOOP



        -- Get the last bid on the player

        SELECT * INTO last_bid

            FROM transfers_bids

            WHERE id_player = player.id

            ORDER BY amount DESC

            LIMIT 1;



        ------ If no bids are found

        IF NOT FOUND THEN



            ---- If the player is clubless

            IF player.id_club IS NULL THEN



                -- Update player to make bidding next week

                UPDATE players SET

                    date_bid_end = date_trunc('minute', NOW()) + (INTERVAL '1 week' / inp_multiverse.speed),

                    expenses_expected = CEIL(0.9 * expenses_expected),

                    transfer_price = 100

                WHERE id = player.id;

            

            ---- If the player has a club

            ELSE



                -- If the player asked to leave the club or was fired

                IF player.transfer_price = -100 THEN



                    -- Insert a message to say that the player left the club

                    INSERT INTO messages_mail (id_club_to, sender_role, created_at, title, message) VALUES

                        (player.id_club, 'Treasurer', player.date_bid_end,

                        string_parser(player.id, 'idPlayer') || ' found no bidder and leaves the club',

                        string_parser(player.id, 'idPlayer') || ' has not received any bid, the selling is over and he is not part of the club anymore. He is now clubless and was removed from the club''s teamcomps.');



                    -- Insert a new row in the clubs_history table

                    INSERT INTO clubs_history

                        (id_club, description)

                        VALUES (

                            player.id_club,

                            string_parser(player.id, 'idPlayer') || ' left the club and is now clubless because no bids were made on him'

                    );



                    -- Insert a new row in the players_history table

                    INSERT INTO players_history

                        (id_player, id_club, description)

                        VALUES (

                            player.id, player.id_club,

                            'Left ' || string_parser(player.id_club, 'idClub') || ' because no bids were made on him'

                    );



                    -- Update the player to set him as clubless

                    UPDATE players SET

                        id_club = NULL,

                        date_arrival = date_bid_end,

                        shirt_number = NULL,

                        expenses_missed = 0,

                        motivation = 60 + random() * 30,

                        transfer_price = 100,

                        date_bid_end = date_trunc('minute', NOW()) + (INTERVAL '1 week' / inp_multiverse.speed)

                    WHERE id = player.id;



                    -- Remove the player from the club's teamcomps where he appears

                    FOR teamcomp IN (

                        SELECT id FROM games_teamcomp

                        WHERE id_club = player.id_club

                        AND is_played = FALSE)

                    LOOP

                        PERFORM teamcomp_check_or_correct_errors(

                            inp_id_teamcomp := teamcomp.id,

                            inp_bool_try_to_correct := TRUE,

                            inp_bool_notify_user := FALSE);

                    END LOOP;



                    ------ If the club is a bot club

                    IF (SELECT username FROM clubs WHERE id = player.id_club) IS NULL THEN

                        

                        -- Create a new player to replace the one that left

                        loc_tmp := players_create_player(

                            inp_id_multiverse := player.id_multiverse,

                            inp_id_club := player.id_club,

                            inp_id_country := player.id_country,

                            inp_age := 15 + RANDOM() * 5,

                            inp_shirt_number := player.shirt_number

                        );



                        -- Store in the club history

                        INSERT INTO clubs_history

                            (id_club, description)

                        VALUES (

                            club.id,

                            string_parser(loc_tmp, 'idPlayer') || ' joined the squad because of a lack of players');



                    END IF;



                -- Then the player is not sold

                ELSE



                    -- Insert a message to say that the player was not sold

                    INSERT INTO messages_mail (

                        id_club_to, created_at, sender_role, title, message)

                    VALUES

                        (player.id_club, player.date_bid_end, 'Treasurer',

                        string_parser(player.id, 'idPlayer') || ' not sold and stays in the club',

                        string_parser(player.id, 'idPlayer') || ' has not received any bid, the selling is canceled and he will stay in the club');



                    -- Insert a new row in the players_history table

                    INSERT INTO players_history

                        (id_player, id_club, description)

                    VALUES (

                        player.id,

                        player.id_club,

                        'Put on transfer list by ' || string_parser(player.id_club, 'idClub') || ' but no bids were made'

                    );



                    -- Update the player to remove the date bid end

                    UPDATE players SET

                        date_bid_end = NULL,

                        transfer_price = NULL

                    WHERE id = player.id;



                END IF;

            END IF;

        ------ Then at least one bid was made

        ELSE



            -- If the player is clubless

            IF player.id_club IS NULL THEN



                -- Insert a message to say that the player was sold

                INSERT INTO messages_mail (

                    id_club_to, created_at, sender_role, title, message)

                VALUES

                    (last_bid.id_club, player.date_bid_end, 'Treasurer',

                    string_parser(player.id, 'idPlayer') || ' (clubless player) bought for ' || last_bid.amount,

                    string_parser(player.id, 'idPlayer') || ' who was clubless has been bought for ' || last_bid.amount);



            ELSE



                -- Insert a message to say that the player was sold

                INSERT INTO messages_mail

                    (id_club_to, created_at, sender_role, title, message)

                VALUES

                    (player.id_club, player.date_bid_end, 'Treasurer',

                        string_parser(player.id, 'idPlayer') || ' sold for ' || last_bid.amount,

                        string_parser(player.id, 'idPlayer') || ' has been sold for ' || last_bid.amount || ' to ' || string_parser(last_bid.id_club, 'idClub') || '. He is now not part of the club anymore and has been removed from the club''s teamcomps'),

                    (last_bid.id_club, player.date_bid_end, 'Treasurer',

                        string_parser(player.id, 'idPlayer') || ' bought for ' || last_bid.amount,

                        string_parser(player.id, 'idPlayer') || ' has been bought for ' || last_bid.amount || '. I hope he will be a good addition to our team !');



                -- Update the selling club's cash

                UPDATE clubs SET

                    cash = cash + last_bid.amount,

                    revenues_transfers_expected = revenues_transfers_expected - last_bid.amount,

                    revenues_transfers_done = revenues_transfers_done + last_bid.amount

                    WHERE id = player.id_club;



                -- Remove the player from the club's teamcomps where he appears

                FOR teamcomp IN (

                    SELECT id FROM games_teamcomp

                    WHERE id_club = player.id_club

                    AND is_played = FALSE)

                LOOP

                    PERFORM teamcomp_check_or_correct_errors(

                        inp_id_teamcomp := teamcomp.id,

                        inp_bool_try_to_correct := TRUE,

                        inp_bool_notify_user := FALSE);

                END LOOP;



            END IF;



            -- Update the buying club's cash

            UPDATE clubs SET

                expenses_transfers_expected = expenses_transfers_expected - last_bid.amount,

                expenses_transfers_done = expenses_transfers_done + last_bid.amount

            WHERE id = last_bid.id_club;



            -- Insert a new row in the clubs_history table

            INSERT INTO clubs_history

                (id_club, description)

            VALUES (

                last_bid.id_club,

                string_parser(player.id, 'idPlayer') || ' joined the club for ' || last_bid.amount

            );



            -- Insert a new row in the players_history table

            INSERT INTO players_history

                (id_player, id_club, description)

                VALUES (

                    player.id,

                    player.id_club,

                    'Joined ' || string_parser(last_bid.id_club, 'idClub') || ' for ' || last_bid.amount

                );



            -- Update id_club of player

            UPDATE players SET

                id_club = last_bid.id_club,

                date_arrival = date_bid_end,

                motivation = LEAST(100, motivation + 10),

                transfer_price = NULL,

                date_bid_end = NULL

            WHERE id = player.id;



            ------ If the club is a bot club

            IF (SELECT username FROM clubs WHERE id = player.id_club) IS NULL THEN

                

                -- Create a new player to replace the one that left

                loc_tmp := players_create_player(

                    inp_id_multiverse := player.id_multiverse,

                    inp_id_club := player.id_club,

                    inp_id_country := player.id_country,

                    inp_age := 15 + RANDOM() * 5,

                    inp_shirt_number := player.shirt_number

                );



                -- Store in the club history

                INSERT INTO clubs_history

                    (id_club, description)

                VALUES (

                    club.id,

                    string_parser(loc_tmp, 'idPlayer') || ' joined the squad because of a lack of players');



            END IF;



        END IF;



        -- Remove bids for this transfer from the transfer_bids table

        DELETE FROM transfers_bids WHERE id_player = player.id;

        

    END LOOP;









    --     ------ Handle clubs that have less then 11 players

    -- FOR club IN

    --     (SELECT

    --         clubs.id,

    --         clubs.id_multiverse,

    --         clubs.name,

    --         clubs.id_country,

    --         clubs.continent,

    --         COUNT(players.id) AS player_count,

    --         11 - COUNT(players.id) AS missing_players,

    --         15 + 5 * RANDOM() AS player_age

    --     FROM clubs

    --     LEFT JOIN players ON players.id_club = clubs.id

    --     WHERE clubs.id_multiverse = inp_multiverse.id

    --     AND clubs.username IS NULL -- Only for bot clubs

    --     GROUP BY clubs.id, clubs.name, clubs.id_country, clubs.continent

    --     HAVING COUNT(players.id) < 11)

    -- LOOP



    --     -- Create the missing players

    --     loc_id_player := players_create_player(

    --         inp_id_multiverse := club.id_multiverse,

    --         inp_id_club := club.id,

    --         inp_id_country := club.id_country,

    --         inp_age := club.player_age,

    --         inp_stats := ARRAY[

    --             0 + POWER(RANDOM(), 3) * club.player_age, -- keeper

    --             0 + RANDOM() * club.player_age, -- defense

    --             0 + RANDOM() * club.player_age, -- passes

    --             0 + RANDOM() * club.player_age, -- playmaking

    --             0 + RANDOM() * club.player_age, -- winger

    --             0 + RANDOM() * club.player_age, -- scoring

    --             0 + POWER(RANDOM(), 3) * club.player_age], -- freekick

    --         inp_notes := 'New Player'

    --     );



    --     -- Store in the club history

    --     INSERT INTO clubs_history

    --         (id_club, description)

    --     VALUES (

    --         club.id,

    --         string_parser(club.id, 'idClub') || ' joined the squad because of a lack of players'

    --     );



    -- END LOOP;





END;

$$;


ALTER FUNCTION public.transfers_handle_transfers(inp_multiverse record) OWNER TO postgres;

--
-- Name: trg_update_elo_expected_result(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trg_update_elo_expected_result() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

BEGIN

    ------- Calculate the expected ELO result of the game

    UPDATE games

        SET expected_elo_result = expected_elo_result || 1.0 / (1.0 + POWER(10.0, ((

            elo_right - elo_left - CASE WHEN is_home_game THEN 100 ELSE 0 END) / 400.0)))

    WHERE id = NEW.id

    AND is_playing IS NULL;



    RETURN NEW;

END;

$$;


ALTER FUNCTION public.trg_update_elo_expected_result() OWNER TO postgres;

--
-- Name: trg_update_elo_points(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trg_update_elo_points() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

BEGIN

    ------ Update the elo scores of the incoming games of the club that got its elo points updated

    UPDATE games

        SET 

            elo_left = CASE WHEN id_club_left = NEW.id THEN NEW.elo_points ELSE elo_left END,

            elo_right = CASE WHEN id_club_right = NEW.id THEN NEW.elo_points ELSE elo_right END

    WHERE (id_club_left = NEW.id OR id_club_right = NEW.id)

    AND is_playing IS NULL;



    RETURN NEW;

END;

$$;


ALTER FUNCTION public.trg_update_elo_points() OWNER TO postgres;

--
-- Name: trigger_game_events_set_random_id_event_type(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trigger_game_events_set_random_id_event_type() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

DECLARE

  loc_id_event_type bigint;

BEGIN

  SELECT id INTO loc_id_event_type

  FROM game_events_type

  WHERE event_type = NEW.event_type

  ORDER BY RANDOM()

  LIMIT 1;



  NEW.id_event_type = loc_id_event_type;

  RETURN NEW;

END;

$$;


ALTER FUNCTION public.trigger_game_events_set_random_id_event_type() OWNER TO postgres;

--
-- Name: trigger_teamcomps_check_error_in_teamcomp(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trigger_teamcomps_check_error_in_teamcomp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

BEGIN

    -- Call the reusable function

    PERFORM teamcomp_check_or_correct_errors(

        inp_id_teamcomp := NEW.id,
        inp_bool_try_to_correct := FALSE,
        inp_bool_notify_user := FALSE 

    );



    RETURN NEW;

END;

$$;


ALTER FUNCTION public.trigger_teamcomps_check_error_in_teamcomp() OWNER TO postgres;

--
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
-- Regclass of the table e.g. public.notes
entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

-- I, U, D, T: insert, update ...
action realtime.action = (
    case wal ->> 'action'
        when 'I' then 'INSERT'
        when 'U' then 'UPDATE'
        when 'D' then 'DELETE'
        else 'ERROR'
    end
);

-- Is row level security enabled for the table
is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

subscriptions realtime.subscription[] = array_agg(subs)
    from
        realtime.subscription subs
    where
        subs.entity = entity_;

-- Subscription vars
roles regrole[] = array_agg(distinct us.claims_role::text)
    from
        unnest(subscriptions) us;

working_role regrole;
claimed_role regrole;
claims jsonb;

subscription_id uuid;
subscription_has_access bool;
visible_to_subscription_ids uuid[] = '{}';

-- structured info for wal's columns
columns realtime.wal_column[];
-- previous identity values for update/delete
old_columns realtime.wal_column[];

error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

-- Primary jsonb output for record
output jsonb;

begin
perform set_config('role', null, true);

columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'columns') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

old_columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'identity') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

for working_role in select * from unnest(roles) loop

    -- Update `is_selectable` for columns and old_columns
    columns =
        array_agg(
            (
                c.name,
                c.type_name,
                c.type_oid,
                c.value,
                c.is_pkey,
                pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
            )::realtime.wal_column
        )
        from
            unnest(columns) c;

    old_columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(old_columns) c;

    if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            -- subscriptions is already filtered by entity
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 400: Bad Request, no primary key']
        )::realtime.wal_rls;

    -- The claims role does not have SELECT permission to the primary key of entity
    elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 401: Unauthorized']
        )::realtime.wal_rls;

    else
        output = jsonb_build_object(
            'schema', wal ->> 'schema',
            'table', wal ->> 'table',
            'type', action,
            'commit_timestamp', to_char(
                ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
            ),
            'columns', (
                select
                    jsonb_agg(
                        jsonb_build_object(
                            'name', pa.attname,
                            'type', pt.typname
                        )
                        order by pa.attnum asc
                    )
                from
                    pg_attribute pa
                    join pg_type pt
                        on pa.atttypid = pt.oid
                where
                    attrelid = entity_
                    and attnum > 0
                    and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
            )
        )
        -- Add "record" key for insert and update
        || case
            when action in ('INSERT', 'UPDATE') then
                jsonb_build_object(
                    'record',
                    (
                        select
                            jsonb_object_agg(
                                -- if unchanged toast, get column name and value from old record
                                coalesce((c).name, (oc).name),
                                case
                                    when (c).name is null then (oc).value
                                    else (c).value
                                end
                            )
                        from
                            unnest(columns) c
                            full outer join unnest(old_columns) oc
                                on (c).name = (oc).name
                        where
                            coalesce((c).is_selectable, (oc).is_selectable)
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                    )
                )
            else '{}'::jsonb
        end
        -- Add "old_record" key for update and delete
        || case
            when action = 'UPDATE' then
                jsonb_build_object(
                        'old_record',
                        (
                            select jsonb_object_agg((c).name, (c).value)
                            from unnest(old_columns) c
                            where
                                (c).is_selectable
                                and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                        )
                    )
            when action = 'DELETE' then
                jsonb_build_object(
                    'old_record',
                    (
                        select jsonb_object_agg((c).name, (c).value)
                        from unnest(old_columns) c
                        where
                            (c).is_selectable
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                    )
                )
            else '{}'::jsonb
        end;

        -- Create the prepared statement
        if is_rls_enabled and action <> 'DELETE' then
            if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                deallocate walrus_rls_stmt;
            end if;
            execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
        end if;

        visible_to_subscription_ids = '{}';

        for subscription_id, claims in (
                select
                    subs.subscription_id,
                    subs.claims
                from
                    unnest(subscriptions) subs
                where
                    subs.entity = entity_
                    and subs.claims_role = working_role
                    and (
                        realtime.is_visible_through_filters(columns, subs.filters)
                        or (
                          action = 'DELETE'
                          and realtime.is_visible_through_filters(old_columns, subs.filters)
                        )
                    )
        ) loop

            if not is_rls_enabled or action = 'DELETE' then
                visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
            else
                -- Check if RLS allows the role to see the record
                perform
                    -- Trim leading and trailing quotes from working_role because set_config
                    -- doesn't recognize the role as valid if they are included
                    set_config('role', trim(both '"' from working_role::text), true),
                    set_config('request.jwt.claims', claims::text, true);

                execute 'execute walrus_rls_stmt' into subscription_has_access;

                if subscription_has_access then
                    visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                end if;
            end if;
        end loop;

        perform set_config('role', null, true);

        return next (
            output,
            is_rls_enabled,
            visible_to_subscription_ids,
            case
                when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                else '{}'
            end
        )::realtime.wal_rls;

    end if;
end loop;

perform set_config('role', null, true);
end;
$$;


ALTER FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;
BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
    END IF;
    -- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
        PERFORM realtime.send (row_data, event_name, topic_name);
    ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
END;

$$;


ALTER FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) OWNER TO supabase_admin;

--
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


ALTER FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) OWNER TO supabase_admin;

--
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    declare
      res jsonb;
    begin
      execute format('select to_jsonb(%L::'|| type_::text || ')', val)  into res;
      return res;
    end
    $$;


ALTER FUNCTION realtime."cast"(val text, type_ regtype) OWNER TO supabase_admin;

--
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;


ALTER FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) OWNER TO supabase_admin;

--
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


ALTER FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) OWNER TO supabase_admin;

--
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS SETOF realtime.wal_rls
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
      with pub as (
        select
          concat_ws(
            ',',
            case when bool_or(pubinsert) then 'insert' else null end,
            case when bool_or(pubupdate) then 'update' else null end,
            case when bool_or(pubdelete) then 'delete' else null end
          ) as w2j_actions,
          coalesce(
            string_agg(
              realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
              ','
            ) filter (where ppt.tablename is not null and ppt.tablename not like '% %'),
            ''
          ) w2j_add_tables
        from
          pg_publication pp
          left join pg_publication_tables ppt
            on pp.pubname = ppt.pubname
        where
          pp.pubname = publication
        group by
          pp.pubname
        limit 1
      ),
      w2j as (
        select
          x.*, pub.w2j_add_tables
        from
          pub,
          pg_logical_slot_get_changes(
            slot_name, null, max_changes,
            'include-pk', 'true',
            'include-transaction', 'false',
            'include-timestamp', 'true',
            'include-type-oids', 'true',
            'format-version', '2',
            'actions', pub.w2j_actions,
            'add-tables', pub.w2j_add_tables
          ) x
      )
      select
        xyz.wal,
        xyz.is_rls_enabled,
        xyz.subscription_ids,
        xyz.errors
      from
        w2j,
        realtime.apply_rls(
          wal := w2j.data::jsonb,
          max_record_bytes := max_record_bytes
        ) xyz(wal, is_rls_enabled, subscription_ids, errors)
      where
        w2j.w2j_add_tables <> ''
        and xyz.subscription_ids[1] is not null
    $$;


ALTER FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
      select
        (
          select string_agg('' || ch,'')
          from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
        )
        || '.'
        || (
          select string_agg('' || ch,'')
          from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
          )
      from
        pg_class pc
        join pg_namespace nsp
          on pc.relnamespace = nsp.oid
      where
        pc.oid = entity
    $$;


ALTER FUNCTION realtime.quote_wal2json(entity regclass) OWNER TO supabase_admin;

--
-- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  BEGIN
    -- Set the topic configuration
    SET LOCAL realtime.topic TO topic;

    -- Attempt to insert the message
    INSERT INTO realtime.messages (payload, event, topic, private, extension)
    VALUES (payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      -- Capture and notify the error
      PERFORM pg_notify(
          'realtime:system',
          jsonb_build_object(
              'error', SQLERRM,
              'function', 'realtime.send',
              'event', event,
              'topic', topic,
              'private', private
          )::text
      );
  END;
END;
$$;


ALTER FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) OWNER TO supabase_admin;

--
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    /*
    Validates that the user defined filters for a subscription:
    - refer to valid columns that the claimed role may access
    - values are coercable to the correct column type
    */
    declare
        col_names text[] = coalesce(
                array_agg(c.column_name order by c.ordinal_position),
                '{}'::text[]
            )
            from
                information_schema.columns c
            where
                format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
                and pg_catalog.has_column_privilege(
                    (new.claims ->> 'role'),
                    format('%I.%I', c.table_schema, c.table_name)::regclass,
                    c.column_name,
                    'SELECT'
                );
        filter realtime.user_defined_filter;
        col_type regtype;

        in_val jsonb;
    begin
        for filter in select * from unnest(new.filters) loop
            -- Filtered column is valid
            if not filter.column_name = any(col_names) then
                raise exception 'invalid column for filter %', filter.column_name;
            end if;

            -- Type is sanitized and safe for string interpolation
            col_type = (
                select atttypid::regtype
                from pg_catalog.pg_attribute
                where attrelid = new.entity
                      and attname = filter.column_name
            );
            if col_type is null then
                raise exception 'failed to lookup type for column %', filter.column_name;
            end if;

            -- Set maximum number of entries for in filter
            if filter.op = 'in'::realtime.equality_op then
                in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
                if coalesce(jsonb_array_length(in_val), 0) > 100 then
                    raise exception 'too many values for `in` filter. Maximum 100';
                end if;
            else
                -- raises an exception if value is not coercable to type
                perform realtime.cast(filter.value, col_type);
            end if;

        end loop;

        -- Apply consistent order to filters so the unique constraint on
        -- (subscription_id, entity, filters) can't be tricked by a different filter order
        new.filters = coalesce(
            array_agg(f order by f.column_name, f.op, f.value),
            '{}'
        ) from unnest(new.filters) f;

        return new;
    end;
    $$;


ALTER FUNCTION realtime.subscription_check_filters() OWNER TO supabase_admin;

--
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


ALTER FUNCTION realtime.to_regrole(role_name text) OWNER TO supabase_admin;

--
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


ALTER FUNCTION realtime.topic() OWNER TO supabase_realtime_admin;

--
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


ALTER FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) OWNER TO supabase_storage_admin;

--
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
_filename text;
BEGIN
	select string_to_array(name, '/') into _parts;
	select _parts[array_length(_parts,1)] into _filename;
	-- @todo return the last part instead of 2
	return reverse(split_part(reverse(_filename), '.', 1));
END
$$;


ALTER FUNCTION storage.extension(name text) OWNER TO supabase_storage_admin;

--
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


ALTER FUNCTION storage.filename(name text) OWNER TO supabase_storage_admin;

--
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[1:array_length(_parts,1)-1];
END
$$;


ALTER FUNCTION storage.foldername(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::int) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


ALTER FUNCTION storage.get_size_by_bucket() OWNER TO supabase_storage_admin;

--
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


ALTER FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) OWNER TO supabase_storage_admin;

--
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(name COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                        substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1)))
                    ELSE
                        name
                END AS name, id, metadata, updated_at
            FROM
                storage.objects
            WHERE
                bucket_id = $5 AND
                name ILIKE $1 || ''%'' AND
                CASE
                    WHEN $6 != '''' THEN
                    name COLLATE "C" > $6
                ELSE true END
                AND CASE
                    WHEN $4 != '''' THEN
                        CASE
                            WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                                substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                name COLLATE "C" > $4
                            END
                    ELSE
                        true
                END
            ORDER BY
                name COLLATE "C" ASC) as e order by name COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_token, bucket_id, start_after;
END;
$_$;


ALTER FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text) OWNER TO supabase_storage_admin;

--
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


ALTER FUNCTION storage.operation() OWNER TO supabase_storage_admin;

--
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
  v_order_by text;
  v_sort_order text;
begin
  case
    when sortcolumn = 'name' then
      v_order_by = 'name';
    when sortcolumn = 'updated_at' then
      v_order_by = 'updated_at';
    when sortcolumn = 'created_at' then
      v_order_by = 'created_at';
    when sortcolumn = 'last_accessed_at' then
      v_order_by = 'last_accessed_at';
    else
      v_order_by = 'name';
  end case;

  case
    when sortorder = 'asc' then
      v_sort_order = 'asc';
    when sortorder = 'desc' then
      v_sort_order = 'desc';
    else
      v_sort_order = 'asc';
  end case;

  v_order_by = v_order_by || ' ' || v_sort_order;

  return query execute
    'with folders as (
       select path_tokens[$1] as folder
       from storage.objects
         where objects.name ilike $2 || $3 || ''%''
           and bucket_id = $4
           and array_length(objects.path_tokens, 1) <> $1
       group by folder
       order by folder ' || v_sort_order || '
     )
     (select folder as "name",
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[$1] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where objects.name ilike $2 || $3 || ''%''
       and bucket_id = $4
       and array_length(objects.path_tokens, 1) = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


ALTER FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


ALTER FUNCTION storage.update_updated_at_column() OWNER TO supabase_storage_admin;

--
-- Name: secrets_encrypt_secret_secret(); Type: FUNCTION; Schema: vault; Owner: supabase_admin
--

CREATE FUNCTION vault.secrets_encrypt_secret_secret() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
		BEGIN
		        new.secret = CASE WHEN new.secret IS NULL THEN NULL ELSE
			CASE WHEN new.key_id IS NULL THEN NULL ELSE pg_catalog.encode(
			  pgsodium.crypto_aead_det_encrypt(
				pg_catalog.convert_to(new.secret, 'utf8'),
				pg_catalog.convert_to((new.id::text || new.description::text || new.created_at::text || new.updated_at::text)::text, 'utf8'),
				new.key_id::uuid,
				new.nonce
			  ),
				'base64') END END;
		RETURN new;
		END;
		$$;


ALTER FUNCTION vault.secrets_encrypt_secret_secret() OWNER TO supabase_admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE auth.audit_log_entries OWNER TO supabase_auth_admin;

--
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text NOT NULL,
    code_challenge_method auth.code_challenge_method NOT NULL,
    code_challenge text NOT NULL,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone
);


ALTER TABLE auth.flow_state OWNER TO supabase_auth_admin;

--
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.flow_state IS 'stores metadata for pkce logins';


--
-- Name: identities; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE auth.identities OWNER TO supabase_auth_admin;

--
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- Name: instances; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE auth.instances OWNER TO supabase_auth_admin;

--
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE auth.mfa_amr_claims OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);


ALTER TABLE auth.mfa_challenges OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid
);


ALTER TABLE auth.mfa_factors OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


ALTER TABLE auth.one_time_tokens OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


ALTER TABLE auth.refresh_tokens OWNER TO supabase_auth_admin;

--
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: supabase_auth_admin
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE auth.refresh_tokens_id_seq OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: supabase_auth_admin
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


ALTER TABLE auth.saml_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


ALTER TABLE auth.saml_relay_states OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE auth.schema_migrations OWNER TO supabase_auth_admin;

--
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- Name: sessions; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text
);


ALTER TABLE auth.sessions OWNER TO supabase_auth_admin;

--
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


ALTER TABLE auth.sso_domains OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


ALTER TABLE auth.sso_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- Name: users; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


ALTER TABLE auth.users OWNER TO supabase_auth_admin;

--
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- Name: clubs_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clubs_history (
    id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    id_club bigint NOT NULL,
    description text NOT NULL,
    is_ranking_description boolean DEFAULT false NOT NULL,
    is_transfer_description boolean DEFAULT false NOT NULL
);


ALTER TABLE public.clubs_history OWNER TO postgres;

--
-- Name: COLUMN clubs_history.is_ranking_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.clubs_history.is_ranking_description IS 'If the description is a ranking description (champions of etc...)';


--
-- Name: club_names_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.clubs_history ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.club_names_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: clubs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clubs (
    id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    id_multiverse bigint NOT NULL,
    id_league bigint NOT NULL,
    name text,
    number_fans integer DEFAULT 500 NOT NULL,
    id_country bigint NOT NULL,
    pos_last_season smallint,
    pos_league bigint NOT NULL,
    id_league_next_season bigint NOT NULL,
    pos_league_next_season bigint,
    username text,
    staff_weight real DEFAULT '0'::real NOT NULL,
    lis_last_results smallint[] DEFAULT '{}'::smallint[] NOT NULL,
    can_update_name boolean DEFAULT true NOT NULL,
    continent public.continents NOT NULL,
    user_since timestamp with time zone,
    cash integer DEFAULT 10000 NOT NULL,
    expenses_players_ratio_target real DEFAULT '1'::real NOT NULL,
    expenses_staff_applied integer DEFAULT 1000 NOT NULL,
    expenses_players integer DEFAULT 0 NOT NULL,
    expenses_total integer DEFAULT 0 NOT NULL,
    revenues_sponsors integer DEFAULT 3000 NOT NULL,
    revenues_total integer DEFAULT 0 NOT NULL,
    expenses_players_ratio real DEFAULT '1'::real NOT NULL,
    expenses_tax integer DEFAULT 0 NOT NULL,
    league_points integer DEFAULT 0 NOT NULL,
    league_goals_for integer DEFAULT 0 NOT NULL,
    league_goals_against integer DEFAULT 0 NOT NULL,
    revenues_sponsors_last_season integer DEFAULT 0 NOT NULL,
    expenses_staff_target integer DEFAULT 1000 NOT NULL,
    scouts_weight integer DEFAULT 7000 NOT NULL,
    expenses_scouts_target smallint DEFAULT '500'::smallint NOT NULL,
    expenses_scouts_applied smallint DEFAULT '0'::smallint NOT NULL,
    expenses_transfers_done integer DEFAULT 0 NOT NULL,
    expenses_transfers_expected integer DEFAULT 0 NOT NULL,
    revenues_transfers_done integer DEFAULT 0 NOT NULL,
    revenues_transfers_expected integer DEFAULT 0 NOT NULL,
    elo_points integer DEFAULT 1500 NOT NULL,
    season_number smallint DEFAULT '1'::smallint NOT NULL,
    CONSTRAINT clubs_expenses_players_ratio_check CHECK ((expenses_players_ratio >= (0)::double precision)),
    CONSTRAINT clubs_expenses_scouts_check CHECK ((expenses_scouts_target >= 0)),
    CONSTRAINT clubs_expenses_staff_target_check CHECK ((expenses_staff_target >= 0)),
    CONSTRAINT clubs_staff_weight_check CHECK ((staff_weight >= (0)::double precision))
);


ALTER TABLE public.clubs OWNER TO postgres;

--
-- Name: COLUMN clubs.pos_last_season; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.clubs.pos_last_season IS 'Last Season Poisition';


--
-- Name: COLUMN clubs.can_update_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.clubs.can_update_name IS 'Boolean: Is the club name updatable ?';


--
-- Name: COLUMN clubs.continent; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.clubs.continent IS 'Store continent because some countries can have the choice between multiple continents';


--
-- Name: COLUMN clubs.user_since; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.clubs.user_since IS 'Date when last user in control took control';


--
-- Name: COLUMN clubs.cash; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.clubs.cash IS 'Available cash';


--
-- Name: COLUMN clubs.expenses_players_ratio_target; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.clubs.expenses_players_ratio_target IS 'Players expenses ratio wished to be applied';


--
-- Name: COLUMN clubs.expenses_staff_target; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.clubs.expenses_staff_target IS 'Theoretical value per weak dedicated to staff (will be applied if enough cash)';


--
-- Name: COLUMN clubs.expenses_scouts_target; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.clubs.expenses_scouts_target IS 'Weekly investment made in the scouting network';


--
-- Name: COLUMN clubs.expenses_transfers_done; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.clubs.expenses_transfers_done IS 'Transfers done this week';


--
-- Name: COLUMN clubs.expenses_transfers_expected; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.clubs.expenses_transfers_expected IS 'Expected expenses with bids done';


--
-- Name: COLUMN clubs.revenues_transfers_done; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.clubs.revenues_transfers_done IS 'Revenues from transfers this week';


--
-- Name: COLUMN clubs.elo_points; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.clubs.elo_points IS 'elo kind of ranking system';


--
-- Name: COLUMN clubs.season_number; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.clubs.season_number IS 'Season_number used for streaming games page';


--
-- Name: clubs_history_weekly; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clubs_history_weekly (
    id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    number_fans integer NOT NULL,
    pos_league bigint NOT NULL,
    season_number integer NOT NULL,
    staff_weight real DEFAULT '0'::real NOT NULL,
    cash integer DEFAULT 10000 NOT NULL,
    expenses_players_ratio_target real DEFAULT '1'::real NOT NULL,
    expenses_staff_applied integer DEFAULT 1000 NOT NULL,
    expenses_players integer DEFAULT 0 NOT NULL,
    expenses_total integer DEFAULT 0 NOT NULL,
    revenues_sponsors integer DEFAULT 3000 NOT NULL,
    revenues_total integer DEFAULT 0 NOT NULL,
    expenses_players_ratio real DEFAULT '1'::real NOT NULL,
    expenses_tax integer DEFAULT 0 NOT NULL,
    league_points integer DEFAULT 0 NOT NULL,
    league_goals_for integer DEFAULT 0 NOT NULL,
    league_goals_against integer DEFAULT 0 NOT NULL,
    expenses_staff_target integer DEFAULT 1000 NOT NULL,
    scouts_weight integer DEFAULT 7000 NOT NULL,
    expenses_scouts_target smallint DEFAULT '500'::smallint NOT NULL,
    expenses_scouts_applied smallint DEFAULT '0'::smallint NOT NULL,
    expenses_transfers_done integer DEFAULT 0 NOT NULL,
    revenues_transfers_done integer DEFAULT 0 NOT NULL,
    elo_points integer NOT NULL,
    week_number smallint NOT NULL,
    id_club bigint NOT NULL,
    CONSTRAINT clubs_expenses_players_ratio_check CHECK ((expenses_players_ratio >= (0)::double precision)),
    CONSTRAINT clubs_expenses_scouts_check CHECK ((expenses_scouts_target >= 0)),
    CONSTRAINT clubs_expenses_staff_target_check CHECK ((expenses_staff_target >= 0)),
    CONSTRAINT clubs_staff_weight_check CHECK ((staff_weight >= (0)::double precision))
);


ALTER TABLE public.clubs_history_weekly OWNER TO postgres;

--
-- Name: TABLE clubs_history_weekly; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.clubs_history_weekly IS 'Clubs weekly history';


--
-- Name: COLUMN clubs_history_weekly.cash; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.clubs_history_weekly.cash IS 'Available cash';


--
-- Name: COLUMN clubs_history_weekly.expenses_players_ratio_target; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.clubs_history_weekly.expenses_players_ratio_target IS 'Players expenses ratio wished to be applied';


--
-- Name: COLUMN clubs_history_weekly.expenses_staff_target; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.clubs_history_weekly.expenses_staff_target IS 'Theoretical value per weak dedicated to staff (will be applied if enough cash)';


--
-- Name: COLUMN clubs_history_weekly.expenses_scouts_target; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.clubs_history_weekly.expenses_scouts_target IS 'Weekly investment made in the scouting network';


--
-- Name: COLUMN clubs_history_weekly.expenses_transfers_done; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.clubs_history_weekly.expenses_transfers_done IS 'Transfers done this week';


--
-- Name: COLUMN clubs_history_weekly.revenues_transfers_done; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.clubs_history_weekly.revenues_transfers_done IS 'Revenues from transfers this week';


--
-- Name: COLUMN clubs_history_weekly.elo_points; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.clubs_history_weekly.elo_points IS 'elo kind of ranking system';


--
-- Name: clubs_history_weekly_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.clubs_history_weekly ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.clubs_history_weekly_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: clubs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.clubs ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.clubs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: countries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.countries (
    id bigint NOT NULL,
    name text NOT NULL,
    iso2 text NOT NULL,
    iso3 text,
    local_name text,
    continent public.continents,
    is_active boolean DEFAULT false NOT NULL,
    activated_at timestamp with time zone,
    continents public.continents[] NOT NULL
);


ALTER TABLE public.countries OWNER TO postgres;

--
-- Name: TABLE countries; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.countries IS 'Full list of countries.';


--
-- Name: COLUMN countries.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.countries.name IS 'Full country name.';


--
-- Name: COLUMN countries.iso2; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.countries.iso2 IS 'ISO 3166-1 alpha-2 code.';


--
-- Name: COLUMN countries.iso3; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.countries.iso3 IS 'ISO 3166-1 alpha-3 code.';


--
-- Name: COLUMN countries.local_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.countries.local_name IS 'Local variation of the name.';


--
-- Name: COLUMN countries.is_active; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.countries.is_active IS 'Does the country have leagues ?';


--
-- Name: countries_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.countries ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.countries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: countries_old; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.countries_old (
    id bigint NOT NULL,
    name text NOT NULL,
    iso2 text NOT NULL,
    iso3 text,
    local_name text,
    continent public.continents,
    is_active boolean DEFAULT false NOT NULL,
    activated_at timestamp with time zone,
    continents public.continents[]
);


ALTER TABLE public.countries_old OWNER TO postgres;

--
-- Name: TABLE countries_old; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.countries_old IS 'This is a duplicate of countries';


--
-- Name: COLUMN countries_old.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.countries_old.name IS 'Full country name.';


--
-- Name: COLUMN countries_old.iso2; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.countries_old.iso2 IS 'ISO 3166-1 alpha-2 code.';


--
-- Name: COLUMN countries_old.iso3; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.countries_old.iso3 IS 'ISO 3166-1 alpha-3 code.';


--
-- Name: COLUMN countries_old.local_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.countries_old.local_name IS 'Local variation of the name.';


--
-- Name: COLUMN countries_old.is_active; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.countries_old.is_active IS 'Does the country have leagues ?';


--
-- Name: countries_old_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.countries_old ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.countries_old_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: fans; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fans (
    id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    id_club bigint NOT NULL,
    additional_fans bigint DEFAULT '0'::bigint NOT NULL,
    mood smallint DEFAULT '0'::smallint NOT NULL
);


ALTER TABLE public.fans OWNER TO postgres;

--
-- Name: fans_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.fans ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.fans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: finances; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.finances (
    id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    id_club bigint NOT NULL,
    amount bigint NOT NULL,
    description text NOT NULL
);


ALTER TABLE public.finances OWNER TO postgres;

--
-- Name: finances_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.finances ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.finances_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: game_events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.game_events (
    id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    id_game bigint NOT NULL,
    id_event_type bigint,
    id_player bigint,
    id_club bigint,
    game_minute smallint,
    date_event timestamp with time zone,
    game_period smallint,
    id_player2 bigint,
    id_player3 bigint,
    event_type text
);


ALTER TABLE public.game_events OWNER TO postgres;

--
-- Name: COLUMN game_events.game_minute; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.game_events.game_minute IS 'Minute in the game when the event happened';


--
-- Name: COLUMN game_events.date_event; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.game_events.date_event IS 'Timestamp of the event';


--
-- Name: COLUMN game_events.game_period; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.game_events.game_period IS 'Period of the event (first, second hald etc...)';


--
-- Name: game_events_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.game_events ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.game_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: game_events_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.game_events_type (
    id bigint NOT NULL,
    event_type text NOT NULL,
    description text NOT NULL
);


ALTER TABLE public.game_events_type OWNER TO postgres;

--
-- Name: game_events_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.game_events_type ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.game_events_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: game_orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.game_orders (
    id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    id_teamcomp bigint NOT NULL,
    id_player_out bigint NOT NULL,
    id_player_in bigint NOT NULL,
    minute smallint,
    condition smallint,
    minute_real smallint,
    error text
);


ALTER TABLE public.game_orders OWNER TO postgres;

--
-- Name: COLUMN game_orders.id_player_out; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.game_orders.id_player_out IS 'Number of the position to be swaped';


--
-- Name: COLUMN game_orders.minute; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.game_orders.minute IS 'Minute of the game where the sub should be made';


--
-- Name: COLUMN game_orders.condition; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.game_orders.condition IS 'Difference in goals before doing the sub';


--
-- Name: COLUMN game_orders.minute_real; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.game_orders.minute_real IS 'real game minute when the sub was made';


--
-- Name: games; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.games (
    id bigint NOT NULL,
    date_start timestamp with time zone,
    id_stadium uuid,
    week_number smallint NOT NULL,
    is_cup boolean DEFAULT false NOT NULL,
    is_league boolean DEFAULT false NOT NULL,
    is_friendly boolean DEFAULT false NOT NULL,
    id_league bigint,
    id_multiverse bigint NOT NULL,
    season_number bigint NOT NULL,
    id_club_left bigint,
    id_club_right bigint,
    pos_club_left bigint,
    pos_club_right bigint,
    id_league_club_left bigint,
    id_league_club_right bigint,
    id_game_club_left bigint,
    id_game_club_right bigint,
    is_return_game_id_game_first_round bigint,
    score_left smallint,
    score_right smallint,
    score_previous_left smallint,
    score_previous_right smallint,
    is_relegation boolean DEFAULT false NOT NULL,
    date_end timestamp with time zone,
    id_games_description bigint,
    is_playing boolean,
    score_penalty_left smallint,
    score_penalty_right smallint,
    score_cumul_with_penalty_left double precision,
    score_cumul_with_penalty_right double precision,
    is_left_club_overall_winner boolean,
    is_home_game boolean DEFAULT true NOT NULL,
    is_left_forfeit boolean DEFAULT false NOT NULL,
    is_right_forfeit boolean DEFAULT false NOT NULL,
    elo_left integer,
    elo_right integer,
    expected_elo_result real[],
    elo_exchanged_points smallint
);


ALTER TABLE public.games OWNER TO postgres;

--
-- Name: COLUMN games.pos_club_left; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.games.pos_club_left IS 'Position of the left club';


--
-- Name: COLUMN games.id_league_club_left; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.games.id_league_club_left IS 'Id_league from where the left club comes from from';


--
-- Name: COLUMN games.id_league_club_right; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.games.id_league_club_right IS 'Id_league from where the left right comes from from';


--
-- Name: COLUMN games.id_game_club_left; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.games.id_game_club_left IS 'Id_game from where the left club comes from';


--
-- Name: COLUMN games.id_game_club_right; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.games.id_game_club_right IS 'Id_game from where the right club comes from from';


--
-- Name: COLUMN games.id_games_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.games.id_games_description IS 'Description of the game';


--
-- Name: COLUMN games.is_playing; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.games.is_playing IS 'NULL: Game not started, TRUE: is currently playing, FALSE: is played';


--
-- Name: COLUMN games.is_left_club_overall_winner; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.games.is_left_club_overall_winner IS 'Did the left club won the overall game (TRUE, FALSE, NULL for draw)';


--
-- Name: games_description; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.games_description (
    id bigint NOT NULL,
    description text NOT NULL,
    week_number smallint,
    week_set_up smallint DEFAULT '0'::smallint NOT NULL,
    elo_weight smallint NOT NULL
);


ALTER TABLE public.games_description OWNER TO postgres;

--
-- Name: COLUMN games_description.week_number; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.games_description.week_number IS 'Week when this game can be organized';


--
-- Name: COLUMN games_description.elo_weight; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.games_description.elo_weight IS 'Game coefficient for the calculation of the ranking points';


--
-- Name: games_description_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.games_description ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.games_description_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: games_possible_position; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.games_possible_position (
    id bigint NOT NULL,
    position_name text NOT NULL,
    is_titulaire boolean DEFAULT true NOT NULL,
    coefs real[]
);


ALTER TABLE public.games_possible_position OWNER TO postgres;

--
-- Name: games_possible_position_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.games_possible_position ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.games_possible_position_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: games_stats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.games_stats (
    id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    id_game bigint,
    period smallint NOT NULL,
    minute smallint NOT NULL,
    weights_left real[] NOT NULL,
    weights_right real[] NOT NULL
);


ALTER TABLE public.games_stats OWNER TO postgres;

--
-- Name: games_stats_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.games_stats ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.games_stats_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: games_subs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.game_orders ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.games_subs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: games_teamcomp; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.games_teamcomp (
    id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    id_club bigint NOT NULL,
    idgoalkeeper bigint,
    idleftbackwinger bigint,
    idleftcentralback bigint,
    idcentralback bigint,
    idrightcentralback bigint,
    idrightbackwinger bigint,
    idleftwinger bigint,
    idleftmidfielder bigint,
    idcentralmidfielder bigint,
    idrightmidfielder bigint,
    idrightwinger bigint,
    idleftstriker bigint,
    idcentralstriker bigint,
    idrightstriker bigint,
    idsub1 bigint,
    idsub2 bigint,
    idsub3 bigint,
    idsub4 bigint,
    idsub5 bigint,
    idsub6 bigint,
    stats_defense_center double precision,
    stats_defense_left double precision,
    stats_defense_right double precision,
    stats_midfield double precision,
    stats_attack_left double precision,
    stats_attack_center double precision,
    stats_attack_right double precision,
    idsub7 bigint,
    week_number bigint NOT NULL,
    season_number bigint NOT NULL,
    name text NOT NULL,
    description text NOT NULL,
    is_played boolean DEFAULT false NOT NULL,
    error text[] DEFAULT '{"''Have not been checked yet''"}'::text[],
    CONSTRAINT games_teamcomp_name_check CHECK ((length(name) <= 12))
);


ALTER TABLE public.games_teamcomp OWNER TO postgres;

--
-- Name: games_team_comp_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.games_teamcomp ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.games_team_comp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: leagues; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.leagues (
    id bigint NOT NULL,
    id_multiverse bigint NOT NULL,
    season_number bigint NOT NULL,
    continent public.continents,
    level smallint NOT NULL,
    id_upper_league bigint,
    number bigint NOT NULL,
    is_finished boolean,
    id_clubs bigint[],
    points double precision[],
    cash bigint DEFAULT '0'::bigint NOT NULL,
    cash_last_season bigint DEFAULT '840000'::bigint NOT NULL,
    id_lower_league bigint,
    name text DEFAULT ''::text NOT NULL,
    CONSTRAINT leagues_cash_check CHECK ((cash >= 0)),
    CONSTRAINT leagues_level_check CHECK ((level >= 0))
);


ALTER TABLE public.leagues OWNER TO postgres;

--
-- Name: COLUMN leagues.is_finished; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.leagues.is_finished IS 'NULL: League games generation not done, FALSE: done, TRUE: season is over';


--
-- Name: COLUMN leagues.id_clubs; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.leagues.id_clubs IS 'Id of the clubs of the league';


--
-- Name: COLUMN leagues.cash; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.leagues.cash IS 'communal pot of the league';


--
-- Name: leagues_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.leagues ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.leagues_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: matches_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.games ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.matches_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.messages (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    profile_id uuid DEFAULT auth.uid() NOT NULL,
    content character varying(500) NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


ALTER TABLE public.messages OWNER TO postgres;

--
-- Name: TABLE messages; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.messages IS 'Holds individual messages sent on the app.';


--
-- Name: messages_mail; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.messages_mail (
    id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    id_club_to bigint,
    title text NOT NULL,
    message text,
    is_read boolean DEFAULT false NOT NULL,
    date_delete timestamp with time zone,
    is_favorite boolean DEFAULT false NOT NULL,
    username_from text,
    sender_role text DEFAULT 'NULL'::text,
    username_to text
);


ALTER TABLE public.messages_mail OWNER TO postgres;

--
-- Name: TABLE messages_mail; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.messages_mail IS 'Mails';


--
-- Name: COLUMN messages_mail.sender_role; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.messages_mail.sender_role IS 'If the sender is from the club';


--
-- Name: messages_mail_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.messages_mail ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.messages_mail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: multiverses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.multiverses (
    id bigint NOT NULL,
    season_number bigint DEFAULT '1'::bigint NOT NULL,
    date_season_start timestamp with time zone DEFAULT now() NOT NULL,
    date_season_end timestamp with time zone DEFAULT now() NOT NULL,
    week_number smallint DEFAULT '1'::smallint NOT NULL,
    cash_printed bigint DEFAULT '0'::bigint NOT NULL,
    speed smallint NOT NULL,
    name text DEFAULT 'NULL'::text NOT NULL,
    day_number smallint DEFAULT '1'::smallint NOT NULL,
    last_run timestamp with time zone DEFAULT now() NOT NULL,
    error text
);


ALTER TABLE public.multiverses OWNER TO postgres;

--
-- Name: TABLE multiverses; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.multiverses IS 'Different universes speed';


--
-- Name: COLUMN multiverses.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.multiverses.id IS 'Primary key: speed = games per weak';


--
-- Name: COLUMN multiverses.season_number; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.multiverses.season_number IS 'Current season of this multiverse';


--
-- Name: COLUMN multiverses.cash_printed; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.multiverses.cash_printed IS 'Total amount of theoric cash printed';


--
-- Name: COLUMN multiverses.speed; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.multiverses.speed IS 'Speed = Number of virtual weeks per real week => 1: 1.weak-1 / 7: 1.day-1 / 168: 1.h-1 / 1008: 1.10min-1)';


--
-- Name: COLUMN multiverses.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.multiverses.name IS 'Name of the multiverse';


--
-- Name: players; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.players (
    id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    id_club bigint,
    first_name text NOT NULL,
    last_name text NOT NULL,
    date_birth timestamp with time zone NOT NULL,
    id_country bigint NOT NULL,
    keeper real DEFAULT '0'::real NOT NULL,
    defense real DEFAULT '0'::real NOT NULL,
    playmaking real DEFAULT '0'::real NOT NULL,
    passes real DEFAULT '0'::real NOT NULL,
    scoring real DEFAULT '0'::real NOT NULL,
    freekick real DEFAULT '0'::real NOT NULL,
    winger real DEFAULT '0'::real NOT NULL,
    date_end_injury timestamp with time zone,
    date_bid_end timestamp with time zone,
    date_arrival timestamp with time zone DEFAULT now() NOT NULL,
    surname text,
    id_multiverse bigint NOT NULL,
    username text,
    training_points_available real DEFAULT '0'::real NOT NULL,
    shirt_number smallint,
    notes text DEFAULT ''::text,
    multiverse_speed smallint NOT NULL,
    performance_score real,
    is_playing boolean DEFAULT false NOT NULL,
    expenses_missed bigint DEFAULT '0'::bigint NOT NULL,
    experience real DEFAULT '0'::real NOT NULL,
    expenses_payed integer DEFAULT 0 NOT NULL,
    expenses_expected integer,
    motivation real DEFAULT '70'::real NOT NULL,
    form real DEFAULT '70'::real NOT NULL,
    stamina real DEFAULT '70'::real NOT NULL,
    training_coef integer[] DEFAULT '{0,1,3,1,0,0,0}'::integer[] NOT NULL,
    training_points_used real DEFAULT '0'::real NOT NULL,
    energy real DEFAULT '100'::real NOT NULL,
    transfer_price bigint,
    notes_small text DEFAULT ''::text,
    id_games_played bigint[] DEFAULT '{}'::bigint[] NOT NULL,
    CONSTRAINT players_first_name_check CHECK ((length(first_name) <= 24)),
    CONSTRAINT players_last_name_check CHECK ((length(last_name) <= 24)),
    CONSTRAINT players_notes_small_check CHECK ((length(notes_small) <= 6)),
    CONSTRAINT players_shirt_number_check CHECK (((shirt_number < 100) AND (shirt_number >= 0))),
    CONSTRAINT players_surname_check CHECK ((length(surname) < 24))
);


ALTER TABLE public.players OWNER TO postgres;

--
-- Name: COLUMN players.date_arrival; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.players.date_arrival IS 'Arrival Date of the player in this club (or since free player)';


--
-- Name: COLUMN players.training_points_available; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.players.training_points_available IS 'Available training points for the player';


--
-- Name: COLUMN players.performance_score; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.players.performance_score IS 'Overall preformance score based on stats';


--
-- Name: COLUMN players.is_playing; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.players.is_playing IS 'Is the player currently playing';


--
-- Name: COLUMN players.expenses_missed; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.players.expenses_missed IS 'Total amount of missed expenses';


--
-- Name: COLUMN players.stamina; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.players.stamina IS '70';


--
-- Name: COLUMN players.training_coef; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.players.training_coef IS 'Training coefficients to increase player stats with training points';


--
-- Name: COLUMN players.training_points_used; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.players.training_points_used IS 'Training points used since beginning of the season';


--
-- Name: COLUMN players.notes_small; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.players.notes_small IS 'Small notes (max 6 chars)';


--
-- Name: COLUMN players.id_games_played; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.players.id_games_played IS 'List of games where the player participated';


--
-- Name: players_favorite; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.players_favorite (
    id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    id_club bigint NOT NULL,
    id_player bigint NOT NULL,
    notes text,
    date_delete timestamp with time zone
);


ALTER TABLE public.players_favorite OWNER TO postgres;

--
-- Name: TABLE players_favorite; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.players_favorite IS 'Followed players by clubs';


--
-- Name: COLUMN players_favorite.date_delete; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.players_favorite.date_delete IS 'Date when to remove this player as favorite';


--
-- Name: players_favorite_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.players_favorite ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.players_favorite_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: players_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.players_history (
    id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    id_player bigint NOT NULL,
    description text,
    id_club bigint,
    is_ranking_description boolean DEFAULT false NOT NULL,
    is_transfer_description boolean DEFAULT false NOT NULL
);


ALTER TABLE public.players_history OWNER TO postgres;

--
-- Name: players_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.players_history ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.players_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: players_history_stats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.players_history_stats (
    id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    keeper real NOT NULL,
    defense real NOT NULL,
    playmaking real NOT NULL,
    passes real NOT NULL,
    scoring real NOT NULL,
    freekick real NOT NULL,
    winger real NOT NULL,
    id_player bigint NOT NULL,
    motivation real NOT NULL,
    form real NOT NULL,
    stamina real NOT NULL,
    experience real NOT NULL,
    performance_score real NOT NULL,
    expenses_expected integer NOT NULL,
    expenses_payed integer NOT NULL,
    expenses_missed integer NOT NULL,
    training_points_used real NOT NULL,
    energy integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.players_history_stats OWNER TO postgres;

--
-- Name: players_history_stats_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.players_history_stats ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.players_history_stats_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: players_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.players ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.players_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: players_names; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.players_names (
    id bigint NOT NULL,
    id_country bigint,
    first_name text,
    last_name text,
    CONSTRAINT players_names_first_name_check CHECK ((length(first_name) <= 24)),
    CONSTRAINT players_names_last_name_check CHECK ((length(last_name) <= 24))
);


ALTER TABLE public.players_names OWNER TO postgres;

--
-- Name: players_names_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.players_names ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.players_names_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: players_poaching; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.players_poaching (
    id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    id_club bigint NOT NULL,
    id_player bigint NOT NULL,
    promised_expenses smallint,
    promised_price integer NOT NULL
);


ALTER TABLE public.players_poaching OWNER TO postgres;

--
-- Name: TABLE players_poaching; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.players_poaching IS 'Table for poaching players';


--
-- Name: players_poaching_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.players_poaching ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.players_poaching_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.profiles (
    uuid_user uuid NOT NULL,
    username text,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    id_default_club bigint,
    last_username_update timestamp with time zone DEFAULT now() NOT NULL,
    email character varying,
    number_clubs_available smallint DEFAULT '1'::smallint NOT NULL,
    number_players_available smallint DEFAULT '1'::smallint NOT NULL,
    credits_available double precision DEFAULT '0'::double precision NOT NULL,
    credits_used double precision DEFAULT '0'::double precision NOT NULL,
    CONSTRAINT profiles_clubs_available_check CHECK ((number_clubs_available > 0)),
    CONSTRAINT profiles_players_available_check CHECK ((number_players_available > 0)),
    CONSTRAINT username_validation CHECK ((username ~* '^[A-Za-z0-9_]{3,24}$'::text))
);


ALTER TABLE public.profiles OWNER TO postgres;

--
-- Name: TABLE profiles; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.profiles IS 'Holds all of users profile information';


--
-- Name: COLUMN profiles.number_clubs_available; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.profiles.number_clubs_available IS 'Number of clubs available for this user';


--
-- Name: COLUMN profiles.number_players_available; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.profiles.number_players_available IS 'Number of players available for this user';


--
-- Name: stadiums; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stadiums (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    id_club bigint,
    seats bigint DEFAULT '22000'::bigint,
    name character varying
);


ALTER TABLE public.stadiums OWNER TO postgres;

--
-- Name: transfers_bids; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transfers_bids (
    id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    amount bigint NOT NULL,
    id_club bigint NOT NULL,
    id_player bigint NOT NULL,
    name_club text NOT NULL
);


ALTER TABLE public.transfers_bids OWNER TO postgres;

--
-- Name: transfers_bids_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.transfers_bids ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.transfers_bids_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: transfers_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transfers_history (
    id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    id_club bigint NOT NULL,
    id_players_history bigint NOT NULL,
    amount bigint
);


ALTER TABLE public.transfers_history OWNER TO postgres;

--
-- Name: transfers_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.transfers_history ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.transfers_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: universes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.multiverses ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.universes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: messages; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
)
PARTITION BY RANGE (inserted_at);


ALTER TABLE realtime.messages OWNER TO supabase_realtime_admin;

--
-- Name: messages_2025_01_18; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_01_18 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_01_18 OWNER TO supabase_admin;

--
-- Name: messages_2025_01_19; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_01_19 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_01_19 OWNER TO supabase_admin;

--
-- Name: messages_2025_01_20; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_01_20 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_01_20 OWNER TO supabase_admin;

--
-- Name: messages_2025_01_21; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_01_21 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_01_21 OWNER TO supabase_admin;

--
-- Name: messages_2025_01_22; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_01_22 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_01_22 OWNER TO supabase_admin;

--
-- Name: messages_2025_01_23; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_01_23 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_01_23 OWNER TO supabase_admin;

--
-- Name: messages_2025_01_24; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_01_24 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_01_24 OWNER TO supabase_admin;

--
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE realtime.schema_migrations OWNER TO supabase_admin;

--
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


ALTER TABLE realtime.subscription OWNER TO supabase_admin;

--
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: buckets; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text
);


ALTER TABLE storage.buckets OWNER TO supabase_storage_admin;

--
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: migrations; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE storage.migrations OWNER TO supabase_storage_admin;

--
-- Name: objects; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb
);


ALTER TABLE storage.objects OWNER TO supabase_storage_admin;

--
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb
);


ALTER TABLE storage.s3_multipart_uploads OWNER TO supabase_storage_admin;

--
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.s3_multipart_uploads_parts OWNER TO supabase_storage_admin;

--
-- Name: decrypted_secrets; Type: VIEW; Schema: vault; Owner: supabase_admin
--

CREATE VIEW vault.decrypted_secrets AS
 SELECT secrets.id,
    secrets.name,
    secrets.description,
    secrets.secret,
        CASE
            WHEN (secrets.secret IS NULL) THEN NULL::text
            ELSE
            CASE
                WHEN (secrets.key_id IS NULL) THEN NULL::text
                ELSE convert_from(pgsodium.crypto_aead_det_decrypt(decode(secrets.secret, 'base64'::text), convert_to(((((secrets.id)::text || secrets.description) || (secrets.created_at)::text) || (secrets.updated_at)::text), 'utf8'::name), secrets.key_id, secrets.nonce), 'utf8'::name)
            END
        END AS decrypted_secret,
    secrets.key_id,
    secrets.nonce,
    secrets.created_at,
    secrets.updated_at
   FROM vault.secrets;


ALTER VIEW vault.decrypted_secrets OWNER TO supabase_admin;

--
-- Name: messages_2025_01_18; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_01_18 FOR VALUES FROM ('2025-01-18 00:00:00') TO ('2025-01-19 00:00:00');


--
-- Name: messages_2025_01_19; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_01_19 FOR VALUES FROM ('2025-01-19 00:00:00') TO ('2025-01-20 00:00:00');


--
-- Name: messages_2025_01_20; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_01_20 FOR VALUES FROM ('2025-01-20 00:00:00') TO ('2025-01-21 00:00:00');


--
-- Name: messages_2025_01_21; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_01_21 FOR VALUES FROM ('2025-01-21 00:00:00') TO ('2025-01-22 00:00:00');


--
-- Name: messages_2025_01_22; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_01_22 FOR VALUES FROM ('2025-01-22 00:00:00') TO ('2025-01-23 00:00:00');


--
-- Name: messages_2025_01_23; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_01_23 FOR VALUES FROM ('2025-01-23 00:00:00') TO ('2025-01-24 00:00:00');


--
-- Name: messages_2025_01_24; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_01_24 FOR VALUES FROM ('2025-01-24 00:00:00') TO ('2025-01-25 00:00:00');


--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: clubs_history club_names_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clubs_history
    ADD CONSTRAINT club_names_pkey PRIMARY KEY (id);


--
-- Name: clubs clubs_club_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clubs
    ADD CONSTRAINT clubs_club_name_key UNIQUE (name);


--
-- Name: clubs_history_weekly clubs_history_weekly_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clubs_history_weekly
    ADD CONSTRAINT clubs_history_weekly_pkey PRIMARY KEY (id);


--
-- Name: clubs clubs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clubs
    ADD CONSTRAINT clubs_pkey PRIMARY KEY (id);


--
-- Name: countries_old countries_old_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.countries_old
    ADD CONSTRAINT countries_old_pkey PRIMARY KEY (id);


--
-- Name: countries countries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (id);


--
-- Name: fans fans_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fans
    ADD CONSTRAINT fans_pkey PRIMARY KEY (id);


--
-- Name: finances finances_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.finances
    ADD CONSTRAINT finances_pkey PRIMARY KEY (id);


--
-- Name: game_events game_events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_events
    ADD CONSTRAINT game_events_pkey PRIMARY KEY (id);


--
-- Name: game_events_type game_events_type_description_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_events_type
    ADD CONSTRAINT game_events_type_description_key UNIQUE (description);


--
-- Name: game_events_type game_events_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_events_type
    ADD CONSTRAINT game_events_type_pkey PRIMARY KEY (id);


--
-- Name: games_description games_description_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_description
    ADD CONSTRAINT games_description_pkey PRIMARY KEY (id);


--
-- Name: games_possible_position games_possible_position_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_possible_position
    ADD CONSTRAINT games_possible_position_pkey PRIMARY KEY (id);


--
-- Name: games_possible_position games_possible_position_position_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_possible_position
    ADD CONSTRAINT games_possible_position_position_name_key UNIQUE (position_name);


--
-- Name: games_stats games_stats_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_stats
    ADD CONSTRAINT games_stats_pkey PRIMARY KEY (id);


--
-- Name: game_orders games_subs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_orders
    ADD CONSTRAINT games_subs_pkey PRIMARY KEY (id);


--
-- Name: games_teamcomp games_team_comp_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_teamcomp
    ADD CONSTRAINT games_team_comp_pkey PRIMARY KEY (id);


--
-- Name: leagues leagues_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leagues
    ADD CONSTRAINT leagues_pkey PRIMARY KEY (id);


--
-- Name: games matches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT matches_pkey PRIMARY KEY (id);


--
-- Name: messages_mail messages_mail_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages_mail
    ADD CONSTRAINT messages_mail_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: multiverses multiverses_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.multiverses
    ADD CONSTRAINT multiverses_id_key UNIQUE (id);


--
-- Name: players_favorite players_favorite_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players_favorite
    ADD CONSTRAINT players_favorite_pkey PRIMARY KEY (id);


--
-- Name: players_favorite players_favorite_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players_favorite
    ADD CONSTRAINT players_favorite_unique UNIQUE (id_club, id_player);


--
-- Name: players_history players_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players_history
    ADD CONSTRAINT players_history_pkey PRIMARY KEY (id);


--
-- Name: players_history_stats players_history_stats_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players_history_stats
    ADD CONSTRAINT players_history_stats_pkey PRIMARY KEY (id);


--
-- Name: players players_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_id_key UNIQUE (id);


--
-- Name: players_names players_names_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players_names
    ADD CONSTRAINT players_names_pkey PRIMARY KEY (id);


--
-- Name: players players_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_pkey PRIMARY KEY (id);


--
-- Name: players_poaching players_poaching_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players_poaching
    ADD CONSTRAINT players_poaching_pkey PRIMARY KEY (id);


--
-- Name: profiles profiles_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_email_key UNIQUE (email);


--
-- Name: profiles profiles_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_id_key UNIQUE (uuid_user);


--
-- Name: profiles profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_pkey PRIMARY KEY (uuid_user);


--
-- Name: profiles profiles_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_username_key UNIQUE (username);


--
-- Name: stadiums stadiums_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stadiums
    ADD CONSTRAINT stadiums_pkey PRIMARY KEY (id);


--
-- Name: transfers_bids transfers_bids_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transfers_bids
    ADD CONSTRAINT transfers_bids_pkey PRIMARY KEY (id);


--
-- Name: transfers_history transfers_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transfers_history
    ADD CONSTRAINT transfers_history_pkey PRIMARY KEY (id);


--
-- Name: multiverses universes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.multiverses
    ADD CONSTRAINT universes_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2025_01_18 messages_2025_01_18_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_01_18
    ADD CONSTRAINT messages_2025_01_18_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2025_01_19 messages_2025_01_19_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_01_19
    ADD CONSTRAINT messages_2025_01_19_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2025_01_20 messages_2025_01_20_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_01_20
    ADD CONSTRAINT messages_2025_01_20_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2025_01_21 messages_2025_01_21_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_01_21
    ADD CONSTRAINT messages_2025_01_21_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2025_01_22 messages_2025_01_22_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_01_22
    ADD CONSTRAINT messages_2025_01_22_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2025_01_23 messages_2025_01_23_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_01_23
    ADD CONSTRAINT messages_2025_01_23_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2025_01_24 messages_2025_01_24_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_01_24
    ADD CONSTRAINT messages_2025_01_24_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- Name: clubs_history_weekly_cash_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX clubs_history_weekly_cash_idx ON public.clubs_history_weekly USING btree (cash);


--
-- Name: clubs_history_weekly_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX clubs_history_weekly_id_idx ON public.clubs_history_weekly USING btree (id);


--
-- Name: idx_clubs_cash; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clubs_cash ON public.clubs USING btree (cash);


--
-- Name: idx_clubs_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clubs_id ON public.clubs USING btree (id);


--
-- Name: idx_clubs_id_multiverse; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clubs_id_multiverse ON public.clubs USING btree (id_multiverse);


--
-- Name: idx_players_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_players_id ON public.players USING btree (id);


--
-- Name: idx_players_id_club; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_players_id_club ON public.players USING btree (id_club);


--
-- Name: idx_players_id_multiverse; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_players_id_multiverse ON public.players USING btree (id_multiverse);


--
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


--
-- Name: subscription_subscription_id_entity_filters_key; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_key ON realtime.subscription USING btree (subscription_id, entity, filters);


--
-- Name: bname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- Name: messages_2025_01_18_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_01_18_pkey;


--
-- Name: messages_2025_01_19_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_01_19_pkey;


--
-- Name: messages_2025_01_20_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_01_20_pkey;


--
-- Name: messages_2025_01_21_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_01_21_pkey;


--
-- Name: messages_2025_01_22_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_01_22_pkey;


--
-- Name: messages_2025_01_23_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_01_23_pkey;


--
-- Name: messages_2025_01_24_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_01_24_pkey;


--
-- Name: users on_auth_user_created; Type: TRIGGER; Schema: auth; Owner: supabase_auth_admin
--

CREATE TRIGGER on_auth_user_created AFTER INSERT ON auth.users FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();


--
-- Name: game_events before_insert_game_events; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_insert_game_events BEFORE INSERT ON public.game_events FOR EACH ROW EXECUTE FUNCTION public.trigger_game_events_set_random_id_event_type();


--
-- Name: players check_club_cash_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER check_club_cash_trigger BEFORE UPDATE OF expenses_missed ON public.players FOR EACH ROW WHEN (((old.expenses_missed > 0) AND (new.expenses_missed = 0) AND (new.expenses_missed < old.expenses_missed))) EXECUTE FUNCTION public.players_pay_expenses_missed();


--
-- Name: players player_creation_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER player_creation_trigger BEFORE INSERT ON public.players FOR EACH ROW EXECUTE FUNCTION public.players_handle_new_player_created();


--
-- Name: games trg_update_expected_elo_score_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_update_expected_elo_score_trigger AFTER UPDATE OF elo_left, elo_right ON public.games FOR EACH ROW WHEN (((old.elo_left IS DISTINCT FROM new.elo_left) OR (old.elo_right IS DISTINCT FROM new.elo_right))) EXECUTE FUNCTION public.trg_update_elo_expected_result();


--
-- Name: games_teamcomp trigger_teamcomps_check_error_in_teamcomp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_teamcomps_check_error_in_teamcomp AFTER UPDATE OF idgoalkeeper, idleftbackwinger, idleftcentralback, idcentralback, idrightcentralback, idrightbackwinger, idleftwinger, idleftmidfielder, idcentralmidfielder, idrightmidfielder, idrightwinger, idleftstriker, idcentralstriker, idrightstriker, idsub1, idsub2, idsub3, idsub4, idsub5, idsub6, idsub7 ON public.games_teamcomp FOR EACH ROW EXECUTE FUNCTION public.trigger_teamcomps_check_error_in_teamcomp();


--
-- Name: clubs update_elo_points_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_elo_points_trigger AFTER UPDATE OF elo_points ON public.clubs FOR EACH ROW WHEN ((old.elo_points IS DISTINCT FROM new.elo_points)) EXECUTE FUNCTION public.trg_update_elo_points();


--
-- Name: clubs username_update_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER username_update_trigger AFTER UPDATE OF username ON public.clubs FOR EACH ROW EXECUTE FUNCTION public.club_handle_new_user_asignement();


--
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: supabase_admin
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: clubs_history_weekly clubs_history_weekly_id_club_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clubs_history_weekly
    ADD CONSTRAINT clubs_history_weekly_id_club_fkey FOREIGN KEY (id_club) REFERENCES public.clubs(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: clubs clubs_id_country_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clubs
    ADD CONSTRAINT clubs_id_country_fkey FOREIGN KEY (id_country) REFERENCES public.countries(id) ON UPDATE CASCADE;


--
-- Name: clubs clubs_id_league_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clubs
    ADD CONSTRAINT clubs_id_league_fkey FOREIGN KEY (id_league) REFERENCES public.leagues(id) ON UPDATE CASCADE;


--
-- Name: clubs clubs_id_league_next_season_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clubs
    ADD CONSTRAINT clubs_id_league_next_season_fkey FOREIGN KEY (id_league_next_season) REFERENCES public.leagues(id) ON UPDATE CASCADE;


--
-- Name: clubs clubs_id_multiverse_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clubs
    ADD CONSTRAINT clubs_id_multiverse_fkey FOREIGN KEY (id_multiverse) REFERENCES public.multiverses(id) ON UPDATE CASCADE;


--
-- Name: clubs clubs_username_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clubs
    ADD CONSTRAINT clubs_username_fkey FOREIGN KEY (username) REFERENCES public.profiles(username) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: game_events game_events_id_club_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_events
    ADD CONSTRAINT game_events_id_club_fkey FOREIGN KEY (id_club) REFERENCES public.clubs(id) ON UPDATE CASCADE;


--
-- Name: game_events game_events_id_player2_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_events
    ADD CONSTRAINT game_events_id_player2_fkey FOREIGN KEY (id_player2) REFERENCES public.players(id) ON UPDATE CASCADE;


--
-- Name: game_events game_events_id_player3_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_events
    ADD CONSTRAINT game_events_id_player3_fkey FOREIGN KEY (id_player3) REFERENCES public.players(id) ON UPDATE CASCADE;


--
-- Name: games games_id_club_left_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_id_club_left_fkey FOREIGN KEY (id_club_left) REFERENCES public.clubs(id) ON UPDATE CASCADE;


--
-- Name: games games_id_club_right_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_id_club_right_fkey FOREIGN KEY (id_club_right) REFERENCES public.clubs(id) ON UPDATE CASCADE;


--
-- Name: games games_id_game_club_left_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_id_game_club_left_fkey FOREIGN KEY (id_game_club_left) REFERENCES public.games(id) ON UPDATE CASCADE;


--
-- Name: games games_id_game_club_right_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_id_game_club_right_fkey FOREIGN KEY (id_game_club_right) REFERENCES public.games(id) ON UPDATE CASCADE;


--
-- Name: games games_id_games_description_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_id_games_description_fkey FOREIGN KEY (id_games_description) REFERENCES public.games_description(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: games games_id_league_club_left_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_id_league_club_left_fkey FOREIGN KEY (id_league_club_left) REFERENCES public.leagues(id) ON UPDATE CASCADE;


--
-- Name: games games_id_league_club_right_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_id_league_club_right_fkey FOREIGN KEY (id_league_club_right) REFERENCES public.leagues(id) ON UPDATE CASCADE;


--
-- Name: games games_id_league_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_id_league_fkey FOREIGN KEY (id_league) REFERENCES public.leagues(id) ON UPDATE CASCADE;


--
-- Name: games games_id_multiverse_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_id_multiverse_fkey FOREIGN KEY (id_multiverse) REFERENCES public.multiverses(id) ON UPDATE CASCADE;


--
-- Name: games games_is_return_game_id_game_first_round_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_is_return_game_id_game_first_round_fkey FOREIGN KEY (is_return_game_id_game_first_round) REFERENCES public.games(id) ON UPDATE CASCADE;


--
-- Name: games_stats games_stats_id_game_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_stats
    ADD CONSTRAINT games_stats_id_game_fkey FOREIGN KEY (id_game) REFERENCES public.games(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: game_orders games_subs_id_player_in_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_orders
    ADD CONSTRAINT games_subs_id_player_in_fkey FOREIGN KEY (id_player_in) REFERENCES public.players(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: game_orders games_subs_id_player_out_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_orders
    ADD CONSTRAINT games_subs_id_player_out_fkey FOREIGN KEY (id_player_out) REFERENCES public.players(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: game_orders games_subs_id_teamcomp_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_orders
    ADD CONSTRAINT games_subs_id_teamcomp_fkey FOREIGN KEY (id_teamcomp) REFERENCES public.games_teamcomp(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: games_teamcomp games_team_comp_idsub7_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_teamcomp
    ADD CONSTRAINT games_team_comp_idsub7_fkey FOREIGN KEY (idsub7) REFERENCES public.players(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: leagues leagues_id_multiverse_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leagues
    ADD CONSTRAINT leagues_id_multiverse_fkey FOREIGN KEY (id_multiverse) REFERENCES public.multiverses(id) ON UPDATE CASCADE;


--
-- Name: leagues leagues_id_upper_league_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leagues
    ADD CONSTRAINT leagues_id_upper_league_fkey FOREIGN KEY (id_upper_league) REFERENCES public.leagues(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: messages_mail messages_mail_id_club_to_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages_mail
    ADD CONSTRAINT messages_mail_id_club_to_fkey FOREIGN KEY (id_club_to) REFERENCES public.clubs(id) ON UPDATE CASCADE;


--
-- Name: messages_mail messages_mail_username_from_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages_mail
    ADD CONSTRAINT messages_mail_username_from_fkey FOREIGN KEY (username_from) REFERENCES public.profiles(username) ON UPDATE CASCADE;


--
-- Name: messages_mail messages_mail_username_to_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages_mail
    ADD CONSTRAINT messages_mail_username_to_fkey FOREIGN KEY (username_to) REFERENCES public.profiles(username) ON UPDATE CASCADE;


--
-- Name: messages messages_profile_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_profile_id_fkey FOREIGN KEY (profile_id) REFERENCES public.profiles(uuid_user) ON DELETE CASCADE;


--
-- Name: players_favorite players_favorite_id_club_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players_favorite
    ADD CONSTRAINT players_favorite_id_club_fkey FOREIGN KEY (id_club) REFERENCES public.clubs(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: players_favorite players_favorite_id_player_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players_favorite
    ADD CONSTRAINT players_favorite_id_player_fkey FOREIGN KEY (id_player) REFERENCES public.players(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: players_history players_history_id_player_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players_history
    ADD CONSTRAINT players_history_id_player_fkey FOREIGN KEY (id_player) REFERENCES public.players(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: players players_id_club_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_id_club_fkey FOREIGN KEY (id_club) REFERENCES public.clubs(id) ON UPDATE CASCADE;


--
-- Name: players players_id_multiverse_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_id_multiverse_fkey FOREIGN KEY (id_multiverse) REFERENCES public.multiverses(id) ON UPDATE CASCADE;


--
-- Name: players_names players_names_id_country_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players_names
    ADD CONSTRAINT players_names_id_country_fkey FOREIGN KEY (id_country) REFERENCES public.countries(id) ON UPDATE CASCADE;


--
-- Name: players_poaching players_poaching_id_club_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players_poaching
    ADD CONSTRAINT players_poaching_id_club_fkey FOREIGN KEY (id_club) REFERENCES public.clubs(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: players_poaching players_poaching_id_player_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players_poaching
    ADD CONSTRAINT players_poaching_id_player_fkey FOREIGN KEY (id_player) REFERENCES public.players(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: players players_username_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_username_fkey FOREIGN KEY (username) REFERENCES public.profiles(username) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: profiles profiles_uuid_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_uuid_user_fkey FOREIGN KEY (uuid_user) REFERENCES auth.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: game_events public_game_events_id_event_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_events
    ADD CONSTRAINT public_game_events_id_event_type_fkey FOREIGN KEY (id_event_type) REFERENCES public.game_events_type(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: game_events public_game_events_id_game_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_events
    ADD CONSTRAINT public_game_events_id_game_fkey FOREIGN KEY (id_game) REFERENCES public.games(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: game_events public_game_events_id_player_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_events
    ADD CONSTRAINT public_game_events_id_player_fkey FOREIGN KEY (id_player) REFERENCES public.players(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: games public_games_id_stadium_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT public_games_id_stadium_fkey FOREIGN KEY (id_stadium) REFERENCES public.stadiums(id) ON UPDATE CASCADE;


--
-- Name: games_teamcomp public_games_team_comp_idcentralback_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_teamcomp
    ADD CONSTRAINT public_games_team_comp_idcentralback_fkey FOREIGN KEY (idcentralback) REFERENCES public.players(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: games_teamcomp public_games_team_comp_idcentralmidfielder_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_teamcomp
    ADD CONSTRAINT public_games_team_comp_idcentralmidfielder_fkey FOREIGN KEY (idcentralmidfielder) REFERENCES public.players(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: games_teamcomp public_games_team_comp_idcentralstriker_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_teamcomp
    ADD CONSTRAINT public_games_team_comp_idcentralstriker_fkey FOREIGN KEY (idcentralstriker) REFERENCES public.players(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: games_teamcomp public_games_team_comp_idgoalkeeper_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_teamcomp
    ADD CONSTRAINT public_games_team_comp_idgoalkeeper_fkey FOREIGN KEY (idgoalkeeper) REFERENCES public.players(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: games_teamcomp public_games_team_comp_idleftbackwinger_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_teamcomp
    ADD CONSTRAINT public_games_team_comp_idleftbackwinger_fkey FOREIGN KEY (idleftbackwinger) REFERENCES public.players(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: games_teamcomp public_games_team_comp_idleftcentralback_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_teamcomp
    ADD CONSTRAINT public_games_team_comp_idleftcentralback_fkey FOREIGN KEY (idleftcentralback) REFERENCES public.players(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: games_teamcomp public_games_team_comp_idleftmidfielder_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_teamcomp
    ADD CONSTRAINT public_games_team_comp_idleftmidfielder_fkey FOREIGN KEY (idleftmidfielder) REFERENCES public.players(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: games_teamcomp public_games_team_comp_idleftstriker_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_teamcomp
    ADD CONSTRAINT public_games_team_comp_idleftstriker_fkey FOREIGN KEY (idleftstriker) REFERENCES public.players(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: games_teamcomp public_games_team_comp_idleftwinger_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_teamcomp
    ADD CONSTRAINT public_games_team_comp_idleftwinger_fkey FOREIGN KEY (idleftwinger) REFERENCES public.players(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: games_teamcomp public_games_team_comp_idrightbackwinger_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_teamcomp
    ADD CONSTRAINT public_games_team_comp_idrightbackwinger_fkey FOREIGN KEY (idrightbackwinger) REFERENCES public.players(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: games_teamcomp public_games_team_comp_idrightcentralback_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_teamcomp
    ADD CONSTRAINT public_games_team_comp_idrightcentralback_fkey FOREIGN KEY (idrightcentralback) REFERENCES public.players(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: games_teamcomp public_games_team_comp_idrightmidfielder_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_teamcomp
    ADD CONSTRAINT public_games_team_comp_idrightmidfielder_fkey FOREIGN KEY (idrightmidfielder) REFERENCES public.players(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: games_teamcomp public_games_team_comp_idrightstriker_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_teamcomp
    ADD CONSTRAINT public_games_team_comp_idrightstriker_fkey FOREIGN KEY (idrightstriker) REFERENCES public.players(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: games_teamcomp public_games_team_comp_idrightwinger_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_teamcomp
    ADD CONSTRAINT public_games_team_comp_idrightwinger_fkey FOREIGN KEY (idrightwinger) REFERENCES public.players(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: games_teamcomp public_games_team_comp_idsub1_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_teamcomp
    ADD CONSTRAINT public_games_team_comp_idsub1_fkey FOREIGN KEY (idsub1) REFERENCES public.players(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: games_teamcomp public_games_team_comp_idsub2_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_teamcomp
    ADD CONSTRAINT public_games_team_comp_idsub2_fkey FOREIGN KEY (idsub2) REFERENCES public.players(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: games_teamcomp public_games_team_comp_idsub3_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_teamcomp
    ADD CONSTRAINT public_games_team_comp_idsub3_fkey FOREIGN KEY (idsub3) REFERENCES public.players(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: games_teamcomp public_games_team_comp_idsub4_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_teamcomp
    ADD CONSTRAINT public_games_team_comp_idsub4_fkey FOREIGN KEY (idsub4) REFERENCES public.players(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: games_teamcomp public_games_team_comp_idsub5_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_teamcomp
    ADD CONSTRAINT public_games_team_comp_idsub5_fkey FOREIGN KEY (idsub5) REFERENCES public.players(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: games_teamcomp public_games_team_comp_idsub6_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_teamcomp
    ADD CONSTRAINT public_games_team_comp_idsub6_fkey FOREIGN KEY (idsub6) REFERENCES public.players(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: players_history_stats public_players_history_stats_id_player_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players_history_stats
    ADD CONSTRAINT public_players_history_stats_id_player_fkey FOREIGN KEY (id_player) REFERENCES public.players(id) ON UPDATE CASCADE;


--
-- Name: players public_players_id_country_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT public_players_id_country_fkey FOREIGN KEY (id_country) REFERENCES public.countries(id) ON UPDATE CASCADE;


--
-- Name: transfers_bids public_transfers_bids_id_player_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transfers_bids
    ADD CONSTRAINT public_transfers_bids_id_player_fkey FOREIGN KEY (id_player) REFERENCES public.players(id) ON UPDATE CASCADE;


--
-- Name: transfers_history public_transfers_history_id_player_history_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transfers_history
    ADD CONSTRAINT public_transfers_history_id_player_history_fkey FOREIGN KEY (id_players_history) REFERENCES public.players_history(id) ON UPDATE CASCADE;


--
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- Name: transfers_bids All for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "All for all users" ON public.transfers_bids USING (true) WITH CHECK (true);


--
-- Name: game_orders Enable all for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable all for all users" ON public.game_orders USING (true);


--
-- Name: players_favorite Enable all for authenticated users only; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable all for authenticated users only" ON public.players_favorite TO authenticated USING (true) WITH CHECK (true);


--
-- Name: messages_mail Enable insert for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable insert for all users" ON public.messages_mail FOR INSERT WITH CHECK (true);


--
-- Name: messages Enable insert for authenticated users only; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable insert for authenticated users only" ON public.messages FOR INSERT TO authenticated WITH CHECK (true);


--
-- Name: clubs Enable read access for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable read access for all users" ON public.clubs FOR SELECT USING (true);


--
-- Name: clubs_history_weekly Enable read access for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable read access for all users" ON public.clubs_history_weekly FOR SELECT USING (true);


--
-- Name: game_events Enable read access for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable read access for all users" ON public.game_events FOR SELECT USING (true);


--
-- Name: games Enable read access for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable read access for all users" ON public.games FOR SELECT USING (true);


--
-- Name: games_description Enable read access for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable read access for all users" ON public.games_description FOR SELECT USING (true);


--
-- Name: games_stats Enable read access for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable read access for all users" ON public.games_stats FOR SELECT USING (true);


--
-- Name: leagues Enable read access for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable read access for all users" ON public.leagues FOR SELECT USING (true);


--
-- Name: messages Enable read access for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable read access for all users" ON public.messages FOR SELECT USING (true);


--
-- Name: players Enable read access for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable read access for all users" ON public.players FOR SELECT USING (true);


--
-- Name: game_events_type Enable read for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable read for all users" ON public.game_events_type FOR SELECT USING (true);


--
-- Name: games_teamcomp Enable read for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable read for all users" ON public.games_teamcomp FOR SELECT USING (true);


--
-- Name: messages_mail Enable read for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable read for all users" ON public.messages_mail FOR SELECT USING (true);


--
-- Name: clubs Enable update for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable update for all users" ON public.clubs FOR UPDATE USING (true);


--
-- Name: games_teamcomp Enable update for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable update for all users" ON public.games_teamcomp FOR UPDATE USING (true);


--
-- Name: messages_mail Enable update for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable update for all users" ON public.messages_mail FOR UPDATE USING (true);


--
-- Name: players Enable update for users based on username of authenticated; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable update for users based on username of authenticated" ON public.players FOR UPDATE USING (true);


--
-- Name: players INSERT for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "INSERT for all users" ON public.players FOR INSERT WITH CHECK (true);


--
-- Name: profiles Profiles are viewable by everyone; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Profiles are viewable by everyone" ON public.profiles FOR SELECT TO authenticated, anon USING (true);


--
-- Name: players_history Read access for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Read access for all users" ON public.players_history FOR SELECT USING (true);


--
-- Name: players_history_stats Read access for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Read access for all users" ON public.players_history_stats FOR SELECT USING (true);


--
-- Name: clubs_history Read for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Read for all users" ON public.clubs_history FOR SELECT USING (true);


--
-- Name: countries Read for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Read for all users" ON public.countries FOR SELECT USING (true);


--
-- Name: multiverses Read for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Read for all users" ON public.multiverses FOR SELECT USING (true);


--
-- Name: profiles Update for users based on user_id; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Update for users based on user_id" ON public.profiles FOR UPDATE USING ((( SELECT auth.uid() AS uid) = uuid_user));


--
-- Name: clubs; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.clubs ENABLE ROW LEVEL SECURITY;

--
-- Name: clubs_history; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.clubs_history ENABLE ROW LEVEL SECURITY;

--
-- Name: clubs_history_weekly; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.clubs_history_weekly ENABLE ROW LEVEL SECURITY;

--
-- Name: countries; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.countries ENABLE ROW LEVEL SECURITY;

--
-- Name: countries_old; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.countries_old ENABLE ROW LEVEL SECURITY;

--
-- Name: fans; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.fans ENABLE ROW LEVEL SECURITY;

--
-- Name: finances; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.finances ENABLE ROW LEVEL SECURITY;

--
-- Name: game_events; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.game_events ENABLE ROW LEVEL SECURITY;

--
-- Name: game_events_type; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.game_events_type ENABLE ROW LEVEL SECURITY;

--
-- Name: game_orders; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.game_orders ENABLE ROW LEVEL SECURITY;

--
-- Name: games; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.games ENABLE ROW LEVEL SECURITY;

--
-- Name: games_description; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.games_description ENABLE ROW LEVEL SECURITY;

--
-- Name: games_possible_position; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.games_possible_position ENABLE ROW LEVEL SECURITY;

--
-- Name: games_stats; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.games_stats ENABLE ROW LEVEL SECURITY;

--
-- Name: games_teamcomp; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.games_teamcomp ENABLE ROW LEVEL SECURITY;

--
-- Name: leagues; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.leagues ENABLE ROW LEVEL SECURITY;

--
-- Name: messages; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.messages ENABLE ROW LEVEL SECURITY;

--
-- Name: messages_mail; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.messages_mail ENABLE ROW LEVEL SECURITY;

--
-- Name: multiverses; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.multiverses ENABLE ROW LEVEL SECURITY;

--
-- Name: players; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.players ENABLE ROW LEVEL SECURITY;

--
-- Name: players_favorite; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.players_favorite ENABLE ROW LEVEL SECURITY;

--
-- Name: players_history; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.players_history ENABLE ROW LEVEL SECURITY;

--
-- Name: players_history_stats; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.players_history_stats ENABLE ROW LEVEL SECURITY;

--
-- Name: players_names; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.players_names ENABLE ROW LEVEL SECURITY;

--
-- Name: players_poaching; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.players_poaching ENABLE ROW LEVEL SECURITY;

--
-- Name: profiles; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

--
-- Name: stadiums; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.stadiums ENABLE ROW LEVEL SECURITY;

--
-- Name: transfers_bids; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.transfers_bids ENABLE ROW LEVEL SECURITY;

--
-- Name: transfers_history; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.transfers_history ENABLE ROW LEVEL SECURITY;

--
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime OWNER TO postgres;

--
-- Name: supabase_realtime clubs; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.clubs;


--
-- Name: supabase_realtime clubs_history_weekly; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.clubs_history_weekly;


--
-- Name: supabase_realtime countries; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.countries;


--
-- Name: supabase_realtime countries_old; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.countries_old;


--
-- Name: supabase_realtime fans; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.fans;


--
-- Name: supabase_realtime finances; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.finances;


--
-- Name: supabase_realtime game_events; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.game_events;


--
-- Name: supabase_realtime game_events_type; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.game_events_type;


--
-- Name: supabase_realtime game_orders; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.game_orders;


--
-- Name: supabase_realtime games; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.games;


--
-- Name: supabase_realtime games_description; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.games_description;


--
-- Name: supabase_realtime games_stats; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.games_stats;


--
-- Name: supabase_realtime games_teamcomp; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.games_teamcomp;


--
-- Name: supabase_realtime leagues; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.leagues;


--
-- Name: supabase_realtime messages; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.messages;


--
-- Name: supabase_realtime messages_mail; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.messages_mail;


--
-- Name: supabase_realtime multiverses; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.multiverses;


--
-- Name: supabase_realtime players; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.players;


--
-- Name: supabase_realtime players_favorite; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.players_favorite;


--
-- Name: supabase_realtime players_history_stats; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.players_history_stats;


--
-- Name: supabase_realtime players_poaching; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.players_poaching;


--
-- Name: supabase_realtime profiles; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.profiles;


--
-- Name: supabase_realtime transfers_bids; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.transfers_bids;


--
-- Name: SCHEMA auth; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA auth TO anon;
GRANT USAGE ON SCHEMA auth TO authenticated;
GRANT USAGE ON SCHEMA auth TO service_role;
GRANT ALL ON SCHEMA auth TO supabase_auth_admin;
GRANT ALL ON SCHEMA auth TO dashboard_user;
GRANT ALL ON SCHEMA auth TO postgres;


--
-- Name: SCHEMA extensions; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA extensions TO anon;
GRANT USAGE ON SCHEMA extensions TO authenticated;
GRANT USAGE ON SCHEMA extensions TO service_role;
GRANT ALL ON SCHEMA extensions TO dashboard_user;


--
-- Name: SCHEMA cron; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA cron TO postgres WITH GRANT OPTION;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO postgres;
GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO service_role;


--
-- Name: SCHEMA realtime; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA realtime TO postgres;
GRANT USAGE ON SCHEMA realtime TO anon;
GRANT USAGE ON SCHEMA realtime TO authenticated;
GRANT USAGE ON SCHEMA realtime TO service_role;
GRANT ALL ON SCHEMA realtime TO supabase_realtime_admin;


--
-- Name: SCHEMA storage; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT ALL ON SCHEMA storage TO postgres;
GRANT USAGE ON SCHEMA storage TO anon;
GRANT USAGE ON SCHEMA storage TO authenticated;
GRANT USAGE ON SCHEMA storage TO service_role;
GRANT ALL ON SCHEMA storage TO supabase_storage_admin;
GRANT ALL ON SCHEMA storage TO dashboard_user;


--
-- Name: FUNCTION email(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.email() TO dashboard_user;


--
-- Name: FUNCTION jwt(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.jwt() TO postgres;
GRANT ALL ON FUNCTION auth.jwt() TO dashboard_user;


--
-- Name: FUNCTION role(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.role() TO dashboard_user;


--
-- Name: FUNCTION uid(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.uid() TO dashboard_user;


--
-- Name: FUNCTION alter_job(job_id bigint, schedule text, command text, database text, username text, active boolean); Type: ACL; Schema: cron; Owner: supabase_admin
--

GRANT ALL ON FUNCTION cron.alter_job(job_id bigint, schedule text, command text, database text, username text, active boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION job_cache_invalidate(); Type: ACL; Schema: cron; Owner: supabase_admin
--

GRANT ALL ON FUNCTION cron.job_cache_invalidate() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION schedule(schedule text, command text); Type: ACL; Schema: cron; Owner: supabase_admin
--

GRANT ALL ON FUNCTION cron.schedule(schedule text, command text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION schedule(job_name text, schedule text, command text); Type: ACL; Schema: cron; Owner: supabase_admin
--

GRANT ALL ON FUNCTION cron.schedule(job_name text, schedule text, command text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION schedule_in_database(job_name text, schedule text, command text, database text, username text, active boolean); Type: ACL; Schema: cron; Owner: supabase_admin
--

GRANT ALL ON FUNCTION cron.schedule_in_database(job_name text, schedule text, command text, database text, username text, active boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION unschedule(job_id bigint); Type: ACL; Schema: cron; Owner: supabase_admin
--

GRANT ALL ON FUNCTION cron.unschedule(job_id bigint) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION unschedule(job_name name); Type: ACL; Schema: cron; Owner: supabase_admin
--

GRANT ALL ON FUNCTION cron.unschedule(job_name name) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION algorithm_sign(signables text, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.algorithm_sign(signables text, secret text, algorithm text) FROM postgres;
GRANT ALL ON FUNCTION extensions.algorithm_sign(signables text, secret text, algorithm text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.algorithm_sign(signables text, secret text, algorithm text) TO dashboard_user;


--
-- Name: FUNCTION armor(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO dashboard_user;


--
-- Name: FUNCTION armor(bytea, text[], text[]); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea, text[], text[]) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO dashboard_user;


--
-- Name: FUNCTION crypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.crypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION dearmor(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.dearmor(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO dashboard_user;


--
-- Name: FUNCTION decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION decrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION gen_random_bytes(integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_bytes(integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO dashboard_user;


--
-- Name: FUNCTION gen_random_uuid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_uuid() FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text, integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text, integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO dashboard_user;


--
-- Name: FUNCTION grant_pg_cron_access(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.grant_pg_cron_access() FROM postgres;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO dashboard_user;


--
-- Name: FUNCTION grant_pg_graphql_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.grant_pg_graphql_access() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION grant_pg_net_access(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.grant_pg_net_access() FROM postgres;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO dashboard_user;


--
-- Name: FUNCTION hmac(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION hmac(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_reset(userid oid, dbid oid, queryid bigint); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint) TO dashboard_user;


--
-- Name: FUNCTION pgp_armor_headers(text, OUT key text, OUT value text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO dashboard_user;


--
-- Name: FUNCTION pgp_key_id(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_key_id(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgrst_ddl_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_ddl_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgrst_drop_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_drop_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION set_graphql_placeholder(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.set_graphql_placeholder() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION sign(payload json, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.sign(payload json, secret text, algorithm text) FROM postgres;
GRANT ALL ON FUNCTION extensions.sign(payload json, secret text, algorithm text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.sign(payload json, secret text, algorithm text) TO dashboard_user;


--
-- Name: FUNCTION try_cast_double(inp text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.try_cast_double(inp text) FROM postgres;
GRANT ALL ON FUNCTION extensions.try_cast_double(inp text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.try_cast_double(inp text) TO dashboard_user;


--
-- Name: FUNCTION url_decode(data text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.url_decode(data text) FROM postgres;
GRANT ALL ON FUNCTION extensions.url_decode(data text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.url_decode(data text) TO dashboard_user;


--
-- Name: FUNCTION url_encode(data bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.url_encode(data bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.url_encode(data bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.url_encode(data bytea) TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v1(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v1mc(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1mc() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v3(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v4(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v4() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v5(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_nil(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_nil() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_dns(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_dns() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_oid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_oid() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_url(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_url() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_x500(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_x500() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO dashboard_user;


--
-- Name: FUNCTION verify(token text, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.verify(token text, secret text, algorithm text) FROM postgres;
GRANT ALL ON FUNCTION extensions.verify(token text, secret text, algorithm text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.verify(token text, secret text, algorithm text) TO dashboard_user;


--
-- Name: FUNCTION comment_directive(comment_ text); Type: ACL; Schema: graphql; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql.comment_directive(comment_ text) TO postgres;
GRANT ALL ON FUNCTION graphql.comment_directive(comment_ text) TO anon;
GRANT ALL ON FUNCTION graphql.comment_directive(comment_ text) TO authenticated;
GRANT ALL ON FUNCTION graphql.comment_directive(comment_ text) TO service_role;


--
-- Name: FUNCTION exception(message text); Type: ACL; Schema: graphql; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql.exception(message text) TO postgres;
GRANT ALL ON FUNCTION graphql.exception(message text) TO anon;
GRANT ALL ON FUNCTION graphql.exception(message text) TO authenticated;
GRANT ALL ON FUNCTION graphql.exception(message text) TO service_role;


--
-- Name: FUNCTION get_schema_version(); Type: ACL; Schema: graphql; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql.get_schema_version() TO postgres;
GRANT ALL ON FUNCTION graphql.get_schema_version() TO anon;
GRANT ALL ON FUNCTION graphql.get_schema_version() TO authenticated;
GRANT ALL ON FUNCTION graphql.get_schema_version() TO service_role;


--
-- Name: FUNCTION increment_schema_version(); Type: ACL; Schema: graphql; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql.increment_schema_version() TO postgres;
GRANT ALL ON FUNCTION graphql.increment_schema_version() TO anon;
GRANT ALL ON FUNCTION graphql.increment_schema_version() TO authenticated;
GRANT ALL ON FUNCTION graphql.increment_schema_version() TO service_role;


--
-- Name: FUNCTION graphql("operationName" text, query text, variables jsonb, extensions jsonb); Type: ACL; Schema: graphql_public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO postgres;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO anon;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO authenticated;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO service_role;


--
-- Name: FUNCTION lo_export(oid, text); Type: ACL; Schema: pg_catalog; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pg_catalog.lo_export(oid, text) FROM postgres;
GRANT ALL ON FUNCTION pg_catalog.lo_export(oid, text) TO supabase_admin;


--
-- Name: FUNCTION lo_import(text); Type: ACL; Schema: pg_catalog; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pg_catalog.lo_import(text) FROM postgres;
GRANT ALL ON FUNCTION pg_catalog.lo_import(text) TO supabase_admin;


--
-- Name: FUNCTION lo_import(text, oid); Type: ACL; Schema: pg_catalog; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pg_catalog.lo_import(text, oid) FROM postgres;
GRANT ALL ON FUNCTION pg_catalog.lo_import(text, oid) TO supabase_admin;


--
-- Name: FUNCTION get_auth(p_usename text); Type: ACL; Schema: pgbouncer; Owner: postgres
--

REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO pgbouncer;


--
-- Name: FUNCTION crypto_aead_det_decrypt(message bytea, additional bytea, key_uuid uuid, nonce bytea); Type: ACL; Schema: pgsodium; Owner: pgsodium_keymaker
--

GRANT ALL ON FUNCTION pgsodium.crypto_aead_det_decrypt(message bytea, additional bytea, key_uuid uuid, nonce bytea) TO service_role;


--
-- Name: FUNCTION crypto_aead_det_encrypt(message bytea, additional bytea, key_uuid uuid, nonce bytea); Type: ACL; Schema: pgsodium; Owner: pgsodium_keymaker
--

GRANT ALL ON FUNCTION pgsodium.crypto_aead_det_encrypt(message bytea, additional bytea, key_uuid uuid, nonce bytea) TO service_role;


--
-- Name: FUNCTION crypto_aead_det_keygen(); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

GRANT ALL ON FUNCTION pgsodium.crypto_aead_det_keygen() TO service_role;


--
-- Name: FUNCTION calculate_age(inp_multiverse_speed bigint, inp_date_birth timestamp with time zone, inp_date_now timestamp with time zone); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.calculate_age(inp_multiverse_speed bigint, inp_date_birth timestamp with time zone, inp_date_now timestamp with time zone) TO anon;
GRANT ALL ON FUNCTION public.calculate_age(inp_multiverse_speed bigint, inp_date_birth timestamp with time zone, inp_date_now timestamp with time zone) TO authenticated;
GRANT ALL ON FUNCTION public.calculate_age(inp_multiverse_speed bigint, inp_date_birth timestamp with time zone, inp_date_now timestamp with time zone) TO service_role;


--
-- Name: FUNCTION club_create_players(inp_id_club bigint); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.club_create_players(inp_id_club bigint) TO anon;
GRANT ALL ON FUNCTION public.club_create_players(inp_id_club bigint) TO authenticated;
GRANT ALL ON FUNCTION public.club_create_players(inp_id_club bigint) TO service_role;


--
-- Name: FUNCTION club_handle_new_user_asignement(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.club_handle_new_user_asignement() TO anon;
GRANT ALL ON FUNCTION public.club_handle_new_user_asignement() TO authenticated;
GRANT ALL ON FUNCTION public.club_handle_new_user_asignement() TO service_role;


--
-- Name: FUNCTION clubs_create_club(inp_id_multiverse bigint, inp_id_league bigint, inp_continent public.continents, inp_number bigint); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.clubs_create_club(inp_id_multiverse bigint, inp_id_league bigint, inp_continent public.continents, inp_number bigint) TO anon;
GRANT ALL ON FUNCTION public.clubs_create_club(inp_id_multiverse bigint, inp_id_league bigint, inp_continent public.continents, inp_number bigint) TO authenticated;
GRANT ALL ON FUNCTION public.clubs_create_club(inp_id_multiverse bigint, inp_id_league bigint, inp_continent public.continents, inp_number bigint) TO service_role;


--
-- Name: FUNCTION handle_new_user(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.handle_new_user() TO anon;
GRANT ALL ON FUNCTION public.handle_new_user() TO authenticated;
GRANT ALL ON FUNCTION public.handle_new_user() TO service_role;


--
-- Name: FUNCTION initialize_leagues_teams_and_players(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.initialize_leagues_teams_and_players() TO anon;
GRANT ALL ON FUNCTION public.initialize_leagues_teams_and_players() TO authenticated;
GRANT ALL ON FUNCTION public.initialize_leagues_teams_and_players() TO service_role;


--
-- Name: FUNCTION is_player_in_teamcomp(inp_id_player bigint, inp_id_game bigint); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.is_player_in_teamcomp(inp_id_player bigint, inp_id_game bigint) TO anon;
GRANT ALL ON FUNCTION public.is_player_in_teamcomp(inp_id_player bigint, inp_id_game bigint) TO authenticated;
GRANT ALL ON FUNCTION public.is_player_in_teamcomp(inp_id_player bigint, inp_id_game bigint) TO service_role;


--
-- Name: FUNCTION leagues_create_league(inp_id_multiverse bigint, inp_season_number bigint, inp_continent public.continents, inp_level bigint, inp_number bigint, inp_id_upper_league bigint, inp_id_league_to_create bigint); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.leagues_create_league(inp_id_multiverse bigint, inp_season_number bigint, inp_continent public.continents, inp_level bigint, inp_number bigint, inp_id_upper_league bigint, inp_id_league_to_create bigint) TO anon;
GRANT ALL ON FUNCTION public.leagues_create_league(inp_id_multiverse bigint, inp_season_number bigint, inp_continent public.continents, inp_level bigint, inp_number bigint, inp_id_upper_league bigint, inp_id_league_to_create bigint) TO authenticated;
GRANT ALL ON FUNCTION public.leagues_create_league(inp_id_multiverse bigint, inp_season_number bigint, inp_continent public.continents, inp_level bigint, inp_number bigint, inp_id_upper_league bigint, inp_id_league_to_create bigint) TO service_role;


--
-- Name: FUNCTION leagues_create_lower_leagues(inp_id_upper_league bigint, inp_max_level bigint); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.leagues_create_lower_leagues(inp_id_upper_league bigint, inp_max_level bigint) TO anon;
GRANT ALL ON FUNCTION public.leagues_create_lower_leagues(inp_id_upper_league bigint, inp_max_level bigint) TO authenticated;
GRANT ALL ON FUNCTION public.leagues_create_lower_leagues(inp_id_upper_league bigint, inp_max_level bigint) TO service_role;


--
-- Name: PROCEDURE main(IN is_cron boolean); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON PROCEDURE public.main(IN is_cron boolean) TO anon;
GRANT ALL ON PROCEDURE public.main(IN is_cron boolean) TO authenticated;
GRANT ALL ON PROCEDURE public.main(IN is_cron boolean) TO service_role;


--
-- Name: FUNCTION main_generate_games_and_teamcomps(inp_id_multiverse bigint, inp_season_number bigint, inp_date_start timestamp with time zone); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.main_generate_games_and_teamcomps(inp_id_multiverse bigint, inp_season_number bigint, inp_date_start timestamp with time zone) TO anon;
GRANT ALL ON FUNCTION public.main_generate_games_and_teamcomps(inp_id_multiverse bigint, inp_season_number bigint, inp_date_start timestamp with time zone) TO authenticated;
GRANT ALL ON FUNCTION public.main_generate_games_and_teamcomps(inp_id_multiverse bigint, inp_season_number bigint, inp_date_start timestamp with time zone) TO service_role;


--
-- Name: FUNCTION main_handle_clubs(inp_multiverse record); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.main_handle_clubs(inp_multiverse record) TO anon;
GRANT ALL ON FUNCTION public.main_handle_clubs(inp_multiverse record) TO authenticated;
GRANT ALL ON FUNCTION public.main_handle_clubs(inp_multiverse record) TO service_role;


--
-- Name: FUNCTION main_handle_players(inp_multiverse record); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.main_handle_players(inp_multiverse record) TO anon;
GRANT ALL ON FUNCTION public.main_handle_players(inp_multiverse record) TO authenticated;
GRANT ALL ON FUNCTION public.main_handle_players(inp_multiverse record) TO service_role;


--
-- Name: FUNCTION main_handle_season(inp_multiverse record); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.main_handle_season(inp_multiverse record) TO anon;
GRANT ALL ON FUNCTION public.main_handle_season(inp_multiverse record) TO authenticated;
GRANT ALL ON FUNCTION public.main_handle_season(inp_multiverse record) TO service_role;


--
-- Name: FUNCTION main_populate_game(rec_game record); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.main_populate_game(rec_game record) TO anon;
GRANT ALL ON FUNCTION public.main_populate_game(rec_game record) TO authenticated;
GRANT ALL ON FUNCTION public.main_populate_game(rec_game record) TO service_role;


--
-- Name: FUNCTION main_simulate_day(inp_multiverse record); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.main_simulate_day(inp_multiverse record) TO anon;
GRANT ALL ON FUNCTION public.main_simulate_day(inp_multiverse record) TO authenticated;
GRANT ALL ON FUNCTION public.main_simulate_day(inp_multiverse record) TO service_role;


--
-- Name: FUNCTION player_change_shirt_number(inp_id_player bigint, inp_id_club bigint, inp_shirt_number integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.player_change_shirt_number(inp_id_player bigint, inp_id_club bigint, inp_shirt_number integer) TO anon;
GRANT ALL ON FUNCTION public.player_change_shirt_number(inp_id_player bigint, inp_id_club bigint, inp_shirt_number integer) TO authenticated;
GRANT ALL ON FUNCTION public.player_change_shirt_number(inp_id_player bigint, inp_id_club bigint, inp_shirt_number integer) TO service_role;


--
-- Name: FUNCTION player_get_full_name(id_player bigint); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.player_get_full_name(id_player bigint) TO anon;
GRANT ALL ON FUNCTION public.player_get_full_name(id_player bigint) TO authenticated;
GRANT ALL ON FUNCTION public.player_get_full_name(id_player bigint) TO service_role;


--
-- Name: FUNCTION player_remove_from_teamcomps(rec_player record); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.player_remove_from_teamcomps(rec_player record) TO anon;
GRANT ALL ON FUNCTION public.player_remove_from_teamcomps(rec_player record) TO authenticated;
GRANT ALL ON FUNCTION public.player_remove_from_teamcomps(rec_player record) TO service_role;


--
-- Name: FUNCTION players_calculate_date_birth(inp_id_multiverse bigint, inp_age double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.players_calculate_date_birth(inp_id_multiverse bigint, inp_age double precision) TO anon;
GRANT ALL ON FUNCTION public.players_calculate_date_birth(inp_id_multiverse bigint, inp_age double precision) TO authenticated;
GRANT ALL ON FUNCTION public.players_calculate_date_birth(inp_id_multiverse bigint, inp_age double precision) TO service_role;


--
-- Name: FUNCTION players_calculate_performance_score(inp_id_player bigint); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.players_calculate_performance_score(inp_id_player bigint) TO anon;
GRANT ALL ON FUNCTION public.players_calculate_performance_score(inp_id_player bigint) TO authenticated;
GRANT ALL ON FUNCTION public.players_calculate_performance_score(inp_id_player bigint) TO service_role;


--
-- Name: FUNCTION players_calculate_player_best_weight(inp_player_stats real[]); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.players_calculate_player_best_weight(inp_player_stats real[]) TO anon;
GRANT ALL ON FUNCTION public.players_calculate_player_best_weight(inp_player_stats real[]) TO authenticated;
GRANT ALL ON FUNCTION public.players_calculate_player_best_weight(inp_player_stats real[]) TO service_role;


--
-- Name: FUNCTION players_calculate_player_weight(inp_player_stats real[], inp_position integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.players_calculate_player_weight(inp_player_stats real[], inp_position integer) TO anon;
GRANT ALL ON FUNCTION public.players_calculate_player_weight(inp_player_stats real[], inp_position integer) TO authenticated;
GRANT ALL ON FUNCTION public.players_calculate_player_weight(inp_player_stats real[], inp_position integer) TO service_role;


--
-- Name: FUNCTION players_check_club_players_count_no_less_than_16(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.players_check_club_players_count_no_less_than_16() TO anon;
GRANT ALL ON FUNCTION public.players_check_club_players_count_no_less_than_16() TO authenticated;
GRANT ALL ON FUNCTION public.players_check_club_players_count_no_less_than_16() TO service_role;


--
-- Name: FUNCTION players_create_player(inp_id_multiverse bigint, inp_id_club bigint, inp_id_country bigint, inp_age double precision, inp_shirt_number bigint, inp_notes text, inp_stats double precision[]); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.players_create_player(inp_id_multiverse bigint, inp_id_club bigint, inp_id_country bigint, inp_age double precision, inp_shirt_number bigint, inp_notes text, inp_stats double precision[]) TO anon;
GRANT ALL ON FUNCTION public.players_create_player(inp_id_multiverse bigint, inp_id_club bigint, inp_id_country bigint, inp_age double precision, inp_shirt_number bigint, inp_notes text, inp_stats double precision[]) TO authenticated;
GRANT ALL ON FUNCTION public.players_create_player(inp_id_multiverse bigint, inp_id_club bigint, inp_id_country bigint, inp_age double precision, inp_shirt_number bigint, inp_notes text, inp_stats double precision[]) TO service_role;


--
-- Name: FUNCTION players_handle_new_player_created(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.players_handle_new_player_created() TO anon;
GRANT ALL ON FUNCTION public.players_handle_new_player_created() TO authenticated;
GRANT ALL ON FUNCTION public.players_handle_new_player_created() TO service_role;


--
-- Name: FUNCTION players_pay_expenses_missed(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.players_pay_expenses_missed() TO anon;
GRANT ALL ON FUNCTION public.players_pay_expenses_missed() TO authenticated;
GRANT ALL ON FUNCTION public.players_pay_expenses_missed() TO service_role;


--
-- Name: FUNCTION random_selection_of_index_from_array_with_weight(inp_array_weights real[], inp_additionnal_weight integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.random_selection_of_index_from_array_with_weight(inp_array_weights real[], inp_additionnal_weight integer) TO anon;
GRANT ALL ON FUNCTION public.random_selection_of_index_from_array_with_weight(inp_array_weights real[], inp_additionnal_weight integer) TO authenticated;
GRANT ALL ON FUNCTION public.random_selection_of_index_from_array_with_weight(inp_array_weights real[], inp_additionnal_weight integer) TO service_role;


--
-- Name: FUNCTION reset_project(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.reset_project() TO anon;
GRANT ALL ON FUNCTION public.reset_project() TO authenticated;
GRANT ALL ON FUNCTION public.reset_project() TO service_role;


--
-- Name: FUNCTION simulate_game_calculate_game_weights(inp_player_array real[], inp_subs bigint[]); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.simulate_game_calculate_game_weights(inp_player_array real[], inp_subs bigint[]) TO anon;
GRANT ALL ON FUNCTION public.simulate_game_calculate_game_weights(inp_player_array real[], inp_subs bigint[]) TO authenticated;
GRANT ALL ON FUNCTION public.simulate_game_calculate_game_weights(inp_player_array real[], inp_subs bigint[]) TO service_role;


--
-- Name: FUNCTION simulate_game_fetch_player_for_event(inp_array_player_ids bigint[], inp_array_multiplier double precision[]); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.simulate_game_fetch_player_for_event(inp_array_player_ids bigint[], inp_array_multiplier double precision[]) TO anon;
GRANT ALL ON FUNCTION public.simulate_game_fetch_player_for_event(inp_array_player_ids bigint[], inp_array_multiplier double precision[]) TO authenticated;
GRANT ALL ON FUNCTION public.simulate_game_fetch_player_for_event(inp_array_player_ids bigint[], inp_array_multiplier double precision[]) TO service_role;


--
-- Name: FUNCTION simulate_game_fetch_player_stats(inp_player_ids bigint[]); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.simulate_game_fetch_player_stats(inp_player_ids bigint[]) TO anon;
GRANT ALL ON FUNCTION public.simulate_game_fetch_player_stats(inp_player_ids bigint[]) TO authenticated;
GRANT ALL ON FUNCTION public.simulate_game_fetch_player_stats(inp_player_ids bigint[]) TO service_role;


--
-- Name: FUNCTION simulate_game_fetch_random_player_id_based_on_weight_array(inp_array_player_ids bigint[], inp_array_weights real[], inp_offset_values real, inp_null_possible boolean); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.simulate_game_fetch_random_player_id_based_on_weight_array(inp_array_player_ids bigint[], inp_array_weights real[], inp_offset_values real, inp_null_possible boolean) TO anon;
GRANT ALL ON FUNCTION public.simulate_game_fetch_random_player_id_based_on_weight_array(inp_array_player_ids bigint[], inp_array_weights real[], inp_offset_values real, inp_null_possible boolean) TO authenticated;
GRANT ALL ON FUNCTION public.simulate_game_fetch_random_player_id_based_on_weight_array(inp_array_player_ids bigint[], inp_array_weights real[], inp_offset_values real, inp_null_possible boolean) TO service_role;


--
-- Name: FUNCTION simulate_game_goal_opportunity(rec_game record, context public.game_context, is_left_club boolean); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.simulate_game_goal_opportunity(rec_game record, context public.game_context, is_left_club boolean) TO anon;
GRANT ALL ON FUNCTION public.simulate_game_goal_opportunity(rec_game record, context public.game_context, is_left_club boolean) TO authenticated;
GRANT ALL ON FUNCTION public.simulate_game_goal_opportunity(rec_game record, context public.game_context, is_left_club boolean) TO service_role;


--
-- Name: FUNCTION simulate_game_handle_orders(inp_teamcomp_id bigint, array_players_id bigint[], array_substitutes bigint[], game_minute bigint, game_period bigint, period_start timestamp without time zone, score bigint, game record); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.simulate_game_handle_orders(inp_teamcomp_id bigint, array_players_id bigint[], array_substitutes bigint[], game_minute bigint, game_period bigint, period_start timestamp without time zone, score bigint, game record) TO anon;
GRANT ALL ON FUNCTION public.simulate_game_handle_orders(inp_teamcomp_id bigint, array_players_id bigint[], array_substitutes bigint[], game_minute bigint, game_period bigint, period_start timestamp without time zone, score bigint, game record) TO authenticated;
GRANT ALL ON FUNCTION public.simulate_game_handle_orders(inp_teamcomp_id bigint, array_players_id bigint[], array_substitutes bigint[], game_minute bigint, game_period bigint, period_start timestamp without time zone, score bigint, game record) TO service_role;


--
-- Name: FUNCTION simulate_game_main(inp_id_game bigint); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.simulate_game_main(inp_id_game bigint) TO anon;
GRANT ALL ON FUNCTION public.simulate_game_main(inp_id_game bigint) TO authenticated;
GRANT ALL ON FUNCTION public.simulate_game_main(inp_id_game bigint) TO service_role;


--
-- Name: FUNCTION simulate_game_main2(inp_id_game bigint); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.simulate_game_main2(inp_id_game bigint) TO anon;
GRANT ALL ON FUNCTION public.simulate_game_main2(inp_id_game bigint) TO authenticated;
GRANT ALL ON FUNCTION public.simulate_game_main2(inp_id_game bigint) TO service_role;


--
-- Name: FUNCTION simulate_game_minute(rec_game record, context public.game_context, inp_score_left integer, inp_score_right integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.simulate_game_minute(rec_game record, context public.game_context, inp_score_left integer, inp_score_right integer) TO anon;
GRANT ALL ON FUNCTION public.simulate_game_minute(rec_game record, context public.game_context, inp_score_left integer, inp_score_right integer) TO authenticated;
GRANT ALL ON FUNCTION public.simulate_game_minute(rec_game record, context public.game_context, inp_score_left integer, inp_score_right integer) TO service_role;


--
-- Name: FUNCTION simulate_game_minute_new(INOUT inp_rec_game record); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.simulate_game_minute_new(INOUT inp_rec_game record) TO anon;
GRANT ALL ON FUNCTION public.simulate_game_minute_new(INOUT inp_rec_game record) TO authenticated;
GRANT ALL ON FUNCTION public.simulate_game_minute_new(INOUT inp_rec_game record) TO service_role;


--
-- Name: FUNCTION simulate_game_n_times(inp_id_game bigint, inp_number_run bigint); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.simulate_game_n_times(inp_id_game bigint, inp_number_run bigint) TO anon;
GRANT ALL ON FUNCTION public.simulate_game_n_times(inp_id_game bigint, inp_number_run bigint) TO authenticated;
GRANT ALL ON FUNCTION public.simulate_game_n_times(inp_id_game bigint, inp_number_run bigint) TO service_role;


--
-- Name: FUNCTION simulate_game_set_is_played(inp_id_game bigint); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.simulate_game_set_is_played(inp_id_game bigint) TO anon;
GRANT ALL ON FUNCTION public.simulate_game_set_is_played(inp_id_game bigint) TO authenticated;
GRANT ALL ON FUNCTION public.simulate_game_set_is_played(inp_id_game bigint) TO service_role;


--
-- Name: FUNCTION simulate_week_games(multiverse record, inp_season_number bigint, inp_week_number bigint); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.simulate_week_games(multiverse record, inp_season_number bigint, inp_week_number bigint) TO anon;
GRANT ALL ON FUNCTION public.simulate_week_games(multiverse record, inp_season_number bigint, inp_week_number bigint) TO authenticated;
GRANT ALL ON FUNCTION public.simulate_week_games(multiverse record, inp_season_number bigint, inp_week_number bigint) TO service_role;


--
-- Name: FUNCTION string_parser(inp_id bigint, inp_entity_type text, inp_text text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.string_parser(inp_id bigint, inp_entity_type text, inp_text text) TO anon;
GRANT ALL ON FUNCTION public.string_parser(inp_id bigint, inp_entity_type text, inp_text text) TO authenticated;
GRANT ALL ON FUNCTION public.string_parser(inp_id bigint, inp_entity_type text, inp_text text) TO service_role;


--
-- Name: FUNCTION teamcomp_check_and_try_populate_if_error(inp_id_teamcomp bigint); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.teamcomp_check_and_try_populate_if_error(inp_id_teamcomp bigint) TO anon;
GRANT ALL ON FUNCTION public.teamcomp_check_and_try_populate_if_error(inp_id_teamcomp bigint) TO authenticated;
GRANT ALL ON FUNCTION public.teamcomp_check_and_try_populate_if_error(inp_id_teamcomp bigint) TO service_role;


--
-- Name: FUNCTION teamcomp_check_or_correct_errors(inp_id_teamcomp bigint, inp_bool_try_to_correct boolean, inp_bool_notify_user boolean); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.teamcomp_check_or_correct_errors(inp_id_teamcomp bigint, inp_bool_try_to_correct boolean, inp_bool_notify_user boolean) TO anon;
GRANT ALL ON FUNCTION public.teamcomp_check_or_correct_errors(inp_id_teamcomp bigint, inp_bool_try_to_correct boolean, inp_bool_notify_user boolean) TO authenticated;
GRANT ALL ON FUNCTION public.teamcomp_check_or_correct_errors(inp_id_teamcomp bigint, inp_bool_try_to_correct boolean, inp_bool_notify_user boolean) TO service_role;


--
-- Name: FUNCTION teamcomp_copy_previous(inp_id_teamcomp bigint, inp_season_number bigint, inp_week_number bigint); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.teamcomp_copy_previous(inp_id_teamcomp bigint, inp_season_number bigint, inp_week_number bigint) TO anon;
GRANT ALL ON FUNCTION public.teamcomp_copy_previous(inp_id_teamcomp bigint, inp_season_number bigint, inp_week_number bigint) TO authenticated;
GRANT ALL ON FUNCTION public.teamcomp_copy_previous(inp_id_teamcomp bigint, inp_season_number bigint, inp_week_number bigint) TO service_role;


--
-- Name: FUNCTION teamcomp_fetch_players(inp_id_teamcomp bigint); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.teamcomp_fetch_players(inp_id_teamcomp bigint) TO anon;
GRANT ALL ON FUNCTION public.teamcomp_fetch_players(inp_id_teamcomp bigint) TO authenticated;
GRANT ALL ON FUNCTION public.teamcomp_fetch_players(inp_id_teamcomp bigint) TO service_role;


--
-- Name: FUNCTION teamcomp_fetch_players_id(inp_id_teamcomp bigint); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.teamcomp_fetch_players_id(inp_id_teamcomp bigint) TO anon;
GRANT ALL ON FUNCTION public.teamcomp_fetch_players_id(inp_id_teamcomp bigint) TO authenticated;
GRANT ALL ON FUNCTION public.teamcomp_fetch_players_id(inp_id_teamcomp bigint) TO service_role;


--
-- Name: FUNCTION transfers_handle_new_bid(inp_id_player bigint, inp_id_club_bidder bigint, inp_amount bigint); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.transfers_handle_new_bid(inp_id_player bigint, inp_id_club_bidder bigint, inp_amount bigint) TO anon;
GRANT ALL ON FUNCTION public.transfers_handle_new_bid(inp_id_player bigint, inp_id_club_bidder bigint, inp_amount bigint) TO authenticated;
GRANT ALL ON FUNCTION public.transfers_handle_new_bid(inp_id_player bigint, inp_id_club_bidder bigint, inp_amount bigint) TO service_role;


--
-- Name: FUNCTION transfers_handle_transfers(inp_multiverse record); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.transfers_handle_transfers(inp_multiverse record) TO anon;
GRANT ALL ON FUNCTION public.transfers_handle_transfers(inp_multiverse record) TO authenticated;
GRANT ALL ON FUNCTION public.transfers_handle_transfers(inp_multiverse record) TO service_role;


--
-- Name: FUNCTION trg_update_elo_expected_result(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.trg_update_elo_expected_result() TO anon;
GRANT ALL ON FUNCTION public.trg_update_elo_expected_result() TO authenticated;
GRANT ALL ON FUNCTION public.trg_update_elo_expected_result() TO service_role;


--
-- Name: FUNCTION trg_update_elo_points(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.trg_update_elo_points() TO anon;
GRANT ALL ON FUNCTION public.trg_update_elo_points() TO authenticated;
GRANT ALL ON FUNCTION public.trg_update_elo_points() TO service_role;


--
-- Name: FUNCTION trigger_game_events_set_random_id_event_type(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.trigger_game_events_set_random_id_event_type() TO anon;
GRANT ALL ON FUNCTION public.trigger_game_events_set_random_id_event_type() TO authenticated;
GRANT ALL ON FUNCTION public.trigger_game_events_set_random_id_event_type() TO service_role;


--
-- Name: FUNCTION trigger_teamcomps_check_error_in_teamcomp(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.trigger_teamcomps_check_error_in_teamcomp() TO anon;
GRANT ALL ON FUNCTION public.trigger_teamcomps_check_error_in_teamcomp() TO authenticated;
GRANT ALL ON FUNCTION public.trigger_teamcomps_check_error_in_teamcomp() TO service_role;


--
-- Name: FUNCTION apply_rls(wal jsonb, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO supabase_realtime_admin;


--
-- Name: FUNCTION broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO postgres;
GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO dashboard_user;


--
-- Name: FUNCTION build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO postgres;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO anon;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO service_role;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION "cast"(val text, type_ regtype); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO postgres;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO dashboard_user;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO anon;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO authenticated;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO service_role;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO supabase_realtime_admin;


--
-- Name: FUNCTION check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO postgres;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO anon;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO authenticated;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO service_role;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO supabase_realtime_admin;


--
-- Name: FUNCTION is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO postgres;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO anon;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO service_role;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO supabase_realtime_admin;


--
-- Name: FUNCTION quote_wal2json(entity regclass); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO postgres;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO anon;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO authenticated;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO service_role;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO supabase_realtime_admin;


--
-- Name: FUNCTION send(payload jsonb, event text, topic text, private boolean); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO postgres;
GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO dashboard_user;


--
-- Name: FUNCTION subscription_check_filters(); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO postgres;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO dashboard_user;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO anon;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO authenticated;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO service_role;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO supabase_realtime_admin;


--
-- Name: FUNCTION to_regrole(role_name text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO postgres;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO anon;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO authenticated;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO service_role;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO supabase_realtime_admin;


--
-- Name: FUNCTION topic(); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.topic() TO postgres;
GRANT ALL ON FUNCTION realtime.topic() TO dashboard_user;


--
-- Name: TABLE audit_log_entries; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.audit_log_entries TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.audit_log_entries TO postgres;
GRANT SELECT ON TABLE auth.audit_log_entries TO postgres WITH GRANT OPTION;


--
-- Name: TABLE flow_state; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.flow_state TO postgres;
GRANT SELECT ON TABLE auth.flow_state TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.flow_state TO dashboard_user;


--
-- Name: TABLE identities; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.identities TO postgres;
GRANT SELECT ON TABLE auth.identities TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.identities TO dashboard_user;


--
-- Name: TABLE instances; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.instances TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.instances TO postgres;
GRANT SELECT ON TABLE auth.instances TO postgres WITH GRANT OPTION;


--
-- Name: TABLE mfa_amr_claims; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_amr_claims TO postgres;
GRANT SELECT ON TABLE auth.mfa_amr_claims TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_amr_claims TO dashboard_user;


--
-- Name: TABLE mfa_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_challenges TO postgres;
GRANT SELECT ON TABLE auth.mfa_challenges TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_challenges TO dashboard_user;


--
-- Name: TABLE mfa_factors; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_factors TO postgres;
GRANT SELECT ON TABLE auth.mfa_factors TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_factors TO dashboard_user;


--
-- Name: TABLE one_time_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.one_time_tokens TO postgres;
GRANT SELECT ON TABLE auth.one_time_tokens TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.one_time_tokens TO dashboard_user;


--
-- Name: TABLE refresh_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.refresh_tokens TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.refresh_tokens TO postgres;
GRANT SELECT ON TABLE auth.refresh_tokens TO postgres WITH GRANT OPTION;


--
-- Name: SEQUENCE refresh_tokens_id_seq; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO dashboard_user;
GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO postgres;


--
-- Name: TABLE saml_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_providers TO postgres;
GRANT SELECT ON TABLE auth.saml_providers TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_providers TO dashboard_user;


--
-- Name: TABLE saml_relay_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_relay_states TO postgres;
GRANT SELECT ON TABLE auth.saml_relay_states TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_relay_states TO dashboard_user;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.schema_migrations TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.schema_migrations TO postgres;
GRANT SELECT ON TABLE auth.schema_migrations TO postgres WITH GRANT OPTION;


--
-- Name: TABLE sessions; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sessions TO postgres;
GRANT SELECT ON TABLE auth.sessions TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sessions TO dashboard_user;


--
-- Name: TABLE sso_domains; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_domains TO postgres;
GRANT SELECT ON TABLE auth.sso_domains TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_domains TO dashboard_user;


--
-- Name: TABLE sso_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_providers TO postgres;
GRANT SELECT ON TABLE auth.sso_providers TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_providers TO dashboard_user;


--
-- Name: TABLE users; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.users TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.users TO postgres;
GRANT SELECT ON TABLE auth.users TO postgres WITH GRANT OPTION;


--
-- Name: TABLE job; Type: ACL; Schema: cron; Owner: supabase_admin
--

GRANT SELECT ON TABLE cron.job TO postgres WITH GRANT OPTION;


--
-- Name: TABLE job_run_details; Type: ACL; Schema: cron; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE cron.job_run_details TO postgres WITH GRANT OPTION;


--
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE extensions.pg_stat_statements FROM postgres;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE extensions.pg_stat_statements TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE extensions.pg_stat_statements TO dashboard_user;


--
-- Name: TABLE pg_stat_statements_info; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE extensions.pg_stat_statements_info FROM postgres;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE extensions.pg_stat_statements_info TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE extensions.pg_stat_statements_info TO dashboard_user;


--
-- Name: SEQUENCE seq_schema_version; Type: ACL; Schema: graphql; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE graphql.seq_schema_version TO postgres;
GRANT ALL ON SEQUENCE graphql.seq_schema_version TO anon;
GRANT ALL ON SEQUENCE graphql.seq_schema_version TO authenticated;
GRANT ALL ON SEQUENCE graphql.seq_schema_version TO service_role;


--
-- Name: TABLE decrypted_key; Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE pgsodium.decrypted_key TO pgsodium_keyholder;


--
-- Name: TABLE masking_rule; Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE pgsodium.masking_rule TO pgsodium_keyholder;


--
-- Name: TABLE mask_columns; Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE pgsodium.mask_columns TO pgsodium_keyholder;


--
-- Name: TABLE clubs_history; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.clubs_history TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.clubs_history TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.clubs_history TO service_role;


--
-- Name: SEQUENCE club_names_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.club_names_id_seq TO anon;
GRANT ALL ON SEQUENCE public.club_names_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.club_names_id_seq TO service_role;


--
-- Name: TABLE clubs; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.clubs TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.clubs TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.clubs TO service_role;


--
-- Name: TABLE clubs_history_weekly; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.clubs_history_weekly TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.clubs_history_weekly TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.clubs_history_weekly TO service_role;


--
-- Name: SEQUENCE clubs_history_weekly_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.clubs_history_weekly_id_seq TO anon;
GRANT ALL ON SEQUENCE public.clubs_history_weekly_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.clubs_history_weekly_id_seq TO service_role;


--
-- Name: SEQUENCE clubs_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.clubs_id_seq TO anon;
GRANT ALL ON SEQUENCE public.clubs_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.clubs_id_seq TO service_role;


--
-- Name: TABLE countries; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.countries TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.countries TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.countries TO service_role;


--
-- Name: SEQUENCE countries_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.countries_id_seq TO anon;
GRANT ALL ON SEQUENCE public.countries_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.countries_id_seq TO service_role;


--
-- Name: TABLE countries_old; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.countries_old TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.countries_old TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.countries_old TO service_role;


--
-- Name: SEQUENCE countries_old_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.countries_old_id_seq TO anon;
GRANT ALL ON SEQUENCE public.countries_old_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.countries_old_id_seq TO service_role;


--
-- Name: TABLE fans; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.fans TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.fans TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.fans TO service_role;


--
-- Name: SEQUENCE fans_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.fans_id_seq TO anon;
GRANT ALL ON SEQUENCE public.fans_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.fans_id_seq TO service_role;


--
-- Name: TABLE finances; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.finances TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.finances TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.finances TO service_role;


--
-- Name: SEQUENCE finances_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.finances_id_seq TO anon;
GRANT ALL ON SEQUENCE public.finances_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.finances_id_seq TO service_role;


--
-- Name: TABLE game_events; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.game_events TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.game_events TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.game_events TO service_role;


--
-- Name: SEQUENCE game_events_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.game_events_id_seq TO anon;
GRANT ALL ON SEQUENCE public.game_events_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.game_events_id_seq TO service_role;


--
-- Name: TABLE game_events_type; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.game_events_type TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.game_events_type TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.game_events_type TO service_role;


--
-- Name: SEQUENCE game_events_type_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.game_events_type_id_seq TO anon;
GRANT ALL ON SEQUENCE public.game_events_type_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.game_events_type_id_seq TO service_role;


--
-- Name: TABLE game_orders; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.game_orders TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.game_orders TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.game_orders TO service_role;


--
-- Name: TABLE games; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.games TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.games TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.games TO service_role;


--
-- Name: TABLE games_description; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.games_description TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.games_description TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.games_description TO service_role;


--
-- Name: SEQUENCE games_description_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.games_description_id_seq TO anon;
GRANT ALL ON SEQUENCE public.games_description_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.games_description_id_seq TO service_role;


--
-- Name: TABLE games_possible_position; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.games_possible_position TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.games_possible_position TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.games_possible_position TO service_role;


--
-- Name: SEQUENCE games_possible_position_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.games_possible_position_id_seq TO anon;
GRANT ALL ON SEQUENCE public.games_possible_position_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.games_possible_position_id_seq TO service_role;


--
-- Name: TABLE games_stats; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.games_stats TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.games_stats TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.games_stats TO service_role;


--
-- Name: SEQUENCE games_stats_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.games_stats_id_seq TO anon;
GRANT ALL ON SEQUENCE public.games_stats_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.games_stats_id_seq TO service_role;


--
-- Name: SEQUENCE games_subs_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.games_subs_id_seq TO anon;
GRANT ALL ON SEQUENCE public.games_subs_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.games_subs_id_seq TO service_role;


--
-- Name: TABLE games_teamcomp; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.games_teamcomp TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.games_teamcomp TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.games_teamcomp TO service_role;


--
-- Name: SEQUENCE games_team_comp_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.games_team_comp_id_seq TO anon;
GRANT ALL ON SEQUENCE public.games_team_comp_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.games_team_comp_id_seq TO service_role;


--
-- Name: TABLE leagues; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.leagues TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.leagues TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.leagues TO service_role;


--
-- Name: SEQUENCE leagues_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.leagues_id_seq TO anon;
GRANT ALL ON SEQUENCE public.leagues_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.leagues_id_seq TO service_role;


--
-- Name: SEQUENCE matches_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.matches_id_seq TO anon;
GRANT ALL ON SEQUENCE public.matches_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.matches_id_seq TO service_role;


--
-- Name: TABLE messages; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.messages TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.messages TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.messages TO service_role;


--
-- Name: TABLE messages_mail; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.messages_mail TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.messages_mail TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.messages_mail TO service_role;


--
-- Name: SEQUENCE messages_mail_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.messages_mail_id_seq TO anon;
GRANT ALL ON SEQUENCE public.messages_mail_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.messages_mail_id_seq TO service_role;


--
-- Name: TABLE multiverses; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.multiverses TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.multiverses TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.multiverses TO service_role;


--
-- Name: TABLE players; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.players TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.players TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.players TO service_role;


--
-- Name: TABLE players_favorite; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.players_favorite TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.players_favorite TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.players_favorite TO service_role;


--
-- Name: SEQUENCE players_favorite_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.players_favorite_id_seq TO anon;
GRANT ALL ON SEQUENCE public.players_favorite_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.players_favorite_id_seq TO service_role;


--
-- Name: TABLE players_history; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.players_history TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.players_history TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.players_history TO service_role;


--
-- Name: SEQUENCE players_history_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.players_history_id_seq TO anon;
GRANT ALL ON SEQUENCE public.players_history_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.players_history_id_seq TO service_role;


--
-- Name: TABLE players_history_stats; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.players_history_stats TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.players_history_stats TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.players_history_stats TO service_role;


--
-- Name: SEQUENCE players_history_stats_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.players_history_stats_id_seq TO anon;
GRANT ALL ON SEQUENCE public.players_history_stats_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.players_history_stats_id_seq TO service_role;


--
-- Name: SEQUENCE players_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.players_id_seq TO anon;
GRANT ALL ON SEQUENCE public.players_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.players_id_seq TO service_role;


--
-- Name: TABLE players_names; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.players_names TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.players_names TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.players_names TO service_role;


--
-- Name: SEQUENCE players_names_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.players_names_id_seq TO anon;
GRANT ALL ON SEQUENCE public.players_names_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.players_names_id_seq TO service_role;


--
-- Name: TABLE players_poaching; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.players_poaching TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.players_poaching TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.players_poaching TO service_role;


--
-- Name: SEQUENCE players_poaching_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.players_poaching_id_seq TO anon;
GRANT ALL ON SEQUENCE public.players_poaching_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.players_poaching_id_seq TO service_role;


--
-- Name: TABLE profiles; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.profiles TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.profiles TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.profiles TO service_role;


--
-- Name: TABLE stadiums; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.stadiums TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.stadiums TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.stadiums TO service_role;


--
-- Name: TABLE transfers_bids; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.transfers_bids TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.transfers_bids TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.transfers_bids TO service_role;


--
-- Name: SEQUENCE transfers_bids_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.transfers_bids_id_seq TO anon;
GRANT ALL ON SEQUENCE public.transfers_bids_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.transfers_bids_id_seq TO service_role;


--
-- Name: TABLE transfers_history; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.transfers_history TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.transfers_history TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.transfers_history TO service_role;


--
-- Name: SEQUENCE transfers_history_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.transfers_history_id_seq TO anon;
GRANT ALL ON SEQUENCE public.transfers_history_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.transfers_history_id_seq TO service_role;


--
-- Name: SEQUENCE universes_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.universes_id_seq TO anon;
GRANT ALL ON SEQUENCE public.universes_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.universes_id_seq TO service_role;


--
-- Name: TABLE messages; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.messages TO postgres;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.messages TO dashboard_user;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO authenticated;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO service_role;


--
-- Name: TABLE messages_2025_01_18; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.messages_2025_01_18 TO postgres;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.messages_2025_01_18 TO dashboard_user;


--
-- Name: TABLE messages_2025_01_19; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.messages_2025_01_19 TO postgres;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.messages_2025_01_19 TO dashboard_user;


--
-- Name: TABLE messages_2025_01_20; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.messages_2025_01_20 TO postgres;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.messages_2025_01_20 TO dashboard_user;


--
-- Name: TABLE messages_2025_01_21; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.messages_2025_01_21 TO postgres;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.messages_2025_01_21 TO dashboard_user;


--
-- Name: TABLE messages_2025_01_22; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.messages_2025_01_22 TO postgres;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.messages_2025_01_22 TO dashboard_user;


--
-- Name: TABLE messages_2025_01_23; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.messages_2025_01_23 TO postgres;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.messages_2025_01_23 TO dashboard_user;


--
-- Name: TABLE messages_2025_01_24; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.messages_2025_01_24 TO postgres;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.messages_2025_01_24 TO dashboard_user;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.schema_migrations TO postgres;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.schema_migrations TO dashboard_user;
GRANT SELECT ON TABLE realtime.schema_migrations TO anon;
GRANT SELECT ON TABLE realtime.schema_migrations TO authenticated;
GRANT SELECT ON TABLE realtime.schema_migrations TO service_role;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.schema_migrations TO supabase_realtime_admin;


--
-- Name: TABLE subscription; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.subscription TO postgres;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.subscription TO dashboard_user;
GRANT SELECT ON TABLE realtime.subscription TO anon;
GRANT SELECT ON TABLE realtime.subscription TO authenticated;
GRANT SELECT ON TABLE realtime.subscription TO service_role;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.subscription TO supabase_realtime_admin;


--
-- Name: SEQUENCE subscription_id_seq; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO service_role;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO supabase_realtime_admin;


--
-- Name: TABLE buckets; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.buckets TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.buckets TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.buckets TO service_role;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.buckets TO postgres;


--
-- Name: TABLE migrations; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.migrations TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.migrations TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.migrations TO service_role;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.migrations TO postgres;


--
-- Name: TABLE objects; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.objects TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.objects TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.objects TO service_role;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.objects TO postgres;


--
-- Name: TABLE s3_multipart_uploads; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.s3_multipart_uploads TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO anon;


--
-- Name: TABLE s3_multipart_uploads_parts; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.s3_multipart_uploads_parts TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO anon;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: cron; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA cron GRANT ALL ON SEQUENCES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: cron; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA cron GRANT ALL ON FUNCTIONS TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: cron; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA cron GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON SEQUENCES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON FUNCTIONS TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: pgsodium; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium GRANT ALL ON SEQUENCES TO pgsodium_keyholder;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: pgsodium; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO pgsodium_keyholder;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: pgsodium_masks; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium_masks GRANT ALL ON SEQUENCES TO pgsodium_keyiduser;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: pgsodium_masks; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium_masks GRANT ALL ON FUNCTIONS TO pgsodium_keyiduser;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: pgsodium_masks; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium_masks GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO pgsodium_keyiduser;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO service_role;


--
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


ALTER EVENT TRIGGER issue_graphql_placeholder OWNER TO supabase_admin;

--
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


ALTER EVENT TRIGGER issue_pg_cron_access OWNER TO supabase_admin;

--
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


ALTER EVENT TRIGGER issue_pg_graphql_access OWNER TO supabase_admin;

--
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: postgres
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


ALTER EVENT TRIGGER issue_pg_net_access OWNER TO postgres;

--
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


ALTER EVENT TRIGGER pgrst_ddl_watch OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


ALTER EVENT TRIGGER pgrst_drop_watch OWNER TO supabase_admin;

--
-- PostgreSQL database dump complete
--

