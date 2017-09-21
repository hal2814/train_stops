--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.2
-- Dumped by pg_dump version 9.6.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: cities; Type: TABLE; Schema: public; Owner: Guest
--

CREATE TABLE cities (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE cities OWNER TO "Guest";

--
-- Name: cities_id_seq; Type: SEQUENCE; Schema: public; Owner: Guest
--

CREATE SEQUENCE cities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cities_id_seq OWNER TO "Guest";

--
-- Name: cities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Guest
--

ALTER SEQUENCE cities_id_seq OWNED BY cities.id;


--
-- Name: stops; Type: TABLE; Schema: public; Owner: Guest
--

CREATE TABLE stops (
    id integer NOT NULL,
    city character varying,
    train character varying,
    arrival time without time zone,
    city_id integer,
    train_id integer
);


ALTER TABLE stops OWNER TO "Guest";

--
-- Name: stops_id_seq; Type: SEQUENCE; Schema: public; Owner: Guest
--

CREATE SEQUENCE stops_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE stops_id_seq OWNER TO "Guest";

--
-- Name: stops_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Guest
--

ALTER SEQUENCE stops_id_seq OWNED BY stops.id;


--
-- Name: trains; Type: TABLE; Schema: public; Owner: Guest
--

CREATE TABLE trains (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE trains OWNER TO "Guest";

--
-- Name: trains_id_seq; Type: SEQUENCE; Schema: public; Owner: Guest
--

CREATE SEQUENCE trains_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE trains_id_seq OWNER TO "Guest";

--
-- Name: trains_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Guest
--

ALTER SEQUENCE trains_id_seq OWNED BY trains.id;


--
-- Name: cities id; Type: DEFAULT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY cities ALTER COLUMN id SET DEFAULT nextval('cities_id_seq'::regclass);


--
-- Name: stops id; Type: DEFAULT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY stops ALTER COLUMN id SET DEFAULT nextval('stops_id_seq'::regclass);


--
-- Name: trains id; Type: DEFAULT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY trains ALTER COLUMN id SET DEFAULT nextval('trains_id_seq'::regclass);


--
-- Data for Name: cities; Type: TABLE DATA; Schema: public; Owner: Guest
--

COPY cities (id, name) FROM stdin;
1	Seattle
2	Portland
3	Phoenix
4	Los Angeles
5	Singapore
6	San Francisco
7	Santa Barbara
\.


--
-- Name: cities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Guest
--

SELECT pg_catalog.setval('cities_id_seq', 7, true);


--
-- Data for Name: stops; Type: TABLE DATA; Schema: public; Owner: Guest
--

COPY stops (id, city, train, arrival, city_id, train_id) FROM stdin;
1	Seattle	Amtrak line1	12:30:00	1	1
2	Portland	Amtrak line1	16:45:00	2	1
3	Phoenix	BNSF line1	08:30:00	3	2
4	Los Angeles	BNSF line5	13:00:00	4	4
5	Seattle	Amtrak line1	16:34:00	1	1
6	Seattle	BNSF line1	16:50:00	1	2
7	Phoenix	BNSF line1	12:45:00	3	2
8	Los Angeles	Amtrak line4	12:45:00	4	5
9	Los Angeles	Thomas	15:45:00	4	6
10	Singapore	BNSF line5	13:34:00	5	4
11	San Francisco	Amtrak line4	13:09:00	6	5
12	San Francisco	BFG5000	10:45:00	6	7
13	Portland	Thomas	08:34:00	2	6
14	Seattle	Mark Express	14:03:00	1	8
15	San Francisco	Santa Barbara	01:02:00	6	9
16	Santa Barbara	Santa Barbara	17:00:00	7	9
\.


--
-- Name: stops_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Guest
--

SELECT pg_catalog.setval('stops_id_seq', 16, true);


--
-- Data for Name: trains; Type: TABLE DATA; Schema: public; Owner: Guest
--

COPY trains (id, name) FROM stdin;
1	Amtrak line1
2	BNSF line1
3	Amtrak line2
4	BNSF line5
5	Amtrak line4
6	Thomas
7	BFG5000
8	Mark Express
9	Santa Barbara
\.


--
-- Name: trains_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Guest
--

SELECT pg_catalog.setval('trains_id_seq', 9, true);


--
-- Name: cities cities_pkey; Type: CONSTRAINT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (id);


--
-- Name: stops stops_pkey; Type: CONSTRAINT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY stops
    ADD CONSTRAINT stops_pkey PRIMARY KEY (id);


--
-- Name: trains trains_pkey; Type: CONSTRAINT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY trains
    ADD CONSTRAINT trains_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

