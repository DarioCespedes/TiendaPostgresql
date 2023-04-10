--
-- PostgreSQL database dump
--

-- Dumped from database version 14.7
-- Dumped by pg_dump version 14.7

-- Started on 2023-04-09 23:44:44

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 2 (class 3079 OID 16537)
-- Name: dblink; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS dblink WITH SCHEMA public;


--
-- TOC entry 3355 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION dblink; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION dblink IS 'connect to other PostgreSQL databases from within a database';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 210 (class 1259 OID 16534)
-- Name: usuvip; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuvip (
    id integer,
    fecha date
);


ALTER TABLE public.usuvip OWNER TO postgres;

--
-- TOC entry 3349 (class 0 OID 16534)
-- Dependencies: 210
-- Data for Name: usuvip; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuvip (id, fecha) FROM stdin;
1	2023-01-02
\.


--
-- TOC entry 3356 (class 0 OID 0)
-- Dependencies: 210
-- Name: TABLE usuvip; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.usuvip TO usuario_consulta;


-- Completed on 2023-04-09 23:44:44

--
-- PostgreSQL database dump complete
--

