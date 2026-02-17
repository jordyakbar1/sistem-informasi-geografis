--
-- PostgreSQL database dump
--

\restrict uP27fMZThIcYE5tId6BnvCB9531UV5HZPIkSr7T6MX6HAgauhkydPYyiG5msiYp

-- Dumped from database version 18.2
-- Dumped by pg_dump version 18.2

-- Started on 2026-02-17 23:30:29

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
-- TOC entry 2 (class 3079 OID 16606)
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- TOC entry 5954 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 226 (class 1259 OID 17695)
-- Name: fasilitas_umum; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fasilitas_umum (
    id integer NOT NULL,
    nama character varying(100),
    jenis character varying(50),
    alamat text,
    geom public.geometry(Point,4326)
);


ALTER TABLE public.fasilitas_umum OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 17694)
-- Name: fasilitas_umum_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fasilitas_umum_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.fasilitas_umum_id_seq OWNER TO postgres;

--
-- TOC entry 5955 (class 0 OID 0)
-- Dependencies: 225
-- Name: fasilitas_umum_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fasilitas_umum_id_seq OWNED BY public.fasilitas_umum.id;


--
-- TOC entry 228 (class 1259 OID 17705)
-- Name: jalan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jalan (
    id integer NOT NULL,
    nama character varying(100),
    geom public.geometry(LineString,4326)
);


ALTER TABLE public.jalan OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 17704)
-- Name: jalan_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.jalan_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.jalan_id_seq OWNER TO postgres;

--
-- TOC entry 5956 (class 0 OID 0)
-- Dependencies: 227
-- Name: jalan_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.jalan_id_seq OWNED BY public.jalan.id;


--
-- TOC entry 230 (class 1259 OID 17715)
-- Name: wilayah; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wilayah (
    id integer NOT NULL,
    nama character varying(100),
    geom public.geometry(Polygon,4326)
);


ALTER TABLE public.wilayah OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 17714)
-- Name: wilayah_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wilayah_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.wilayah_id_seq OWNER TO postgres;

--
-- TOC entry 5957 (class 0 OID 0)
-- Dependencies: 229
-- Name: wilayah_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wilayah_id_seq OWNED BY public.wilayah.id;


--
-- TOC entry 5779 (class 2604 OID 17698)
-- Name: fasilitas_umum id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fasilitas_umum ALTER COLUMN id SET DEFAULT nextval('public.fasilitas_umum_id_seq'::regclass);


--
-- TOC entry 5780 (class 2604 OID 17708)
-- Name: jalan id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jalan ALTER COLUMN id SET DEFAULT nextval('public.jalan_id_seq'::regclass);


--
-- TOC entry 5781 (class 2604 OID 17718)
-- Name: wilayah id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wilayah ALTER COLUMN id SET DEFAULT nextval('public.wilayah_id_seq'::regclass);


--
-- TOC entry 5944 (class 0 OID 17695)
-- Dependencies: 226
-- Data for Name: fasilitas_umum; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fasilitas_umum (id, nama, jenis, alamat, geom) FROM stdin;
1	Masjid Al Ikhlas	Masjid	Jl Mawar	0101000020E61000007D2079E750505A40971AA19FA98715C0
2	SD Negeri 1	Sekolah	Jl Melati	0101000020E61000003108AC1C5A505A40D578E926318815C0
3	Puskesmas Sukarame	Puskesmas	Jl Kenanga	0101000020E6100000AAF1D24D62505A40F0A7C64B378915C0
4	SMA Negeri 2	Sekolah	Jl Dahlia	0101000020E61000009CC420B072505A400AD7A3703D8A15C0
5	Masjid Nurul Iman	Masjid	Jl Anggrek	0101000020E61000008D976E1283505A4025068195438B15C0
\.


--
-- TOC entry 5946 (class 0 OID 17705)
-- Dependencies: 228
-- Data for Name: jalan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jalan (id, nama, geom) FROM stdin;
1	Gg Alun Alun 3	0102000020E61000000300000059E90FD6644E5A403248579BC77B15C0E8C30856594E5A40C53F30A4D37B15C094DF4CC14F4E5A403402E3D4D77B15C0
2	Gg Alun Alun 2	0102000020E6100000030000006503B340504E5A40EEB28EF42B7C15C0C801703D5E4E5A400A921BC41D7C15C01CFA4908674E5A4064E8A06C137C15C0
3	Gg Alun Alun 1	0102000020E610000003000000E4DEE5D0664E5A40A6D036A5627C15C038EDA3345D4E5A40735A4F52727C15C04B42C7B0504E5A40DB9827617C7C15C0
\.


--
-- TOC entry 5778 (class 0 OID 16925)
-- Dependencies: 221
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- TOC entry 5948 (class 0 OID 17715)
-- Dependencies: 230
-- Data for Name: wilayah; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wilayah (id, nama, geom) FROM stdin;
1	Wilayah Rajabasa Barat	0103000020E61000000100000005000000FCA9F1D24D4E5A4008AC1C5A647B15C0DF4F8D976E4E5A4008AC1C5A647B15C0DF4F8D976E4E5A403D0AD7A3707D15C0FCA9F1D24D4E5A403D0AD7A3707D15C0FCA9F1D24D4E5A4008AC1C5A647B15C0
2	Wilayah Rajabasa Timur	0103000020E61000000100000005000000DF4F8D976E4E5A4008AC1C5A647B15C0C3F5285C8F4E5A4008AC1C5A647B15C0C3F5285C8F4E5A403D0AD7A3707D15C0DF4F8D976E4E5A403D0AD7A3707D15C0DF4F8D976E4E5A4008AC1C5A647B15C0
\.


--
-- TOC entry 5958 (class 0 OID 0)
-- Dependencies: 225
-- Name: fasilitas_umum_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fasilitas_umum_id_seq', 5, true);


--
-- TOC entry 5959 (class 0 OID 0)
-- Dependencies: 227
-- Name: jalan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.jalan_id_seq', 3, true);


--
-- TOC entry 5960 (class 0 OID 0)
-- Dependencies: 229
-- Name: wilayah_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wilayah_id_seq', 2, true);


--
-- TOC entry 5786 (class 2606 OID 17703)
-- Name: fasilitas_umum fasilitas_umum_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fasilitas_umum
    ADD CONSTRAINT fasilitas_umum_pkey PRIMARY KEY (id);


--
-- TOC entry 5788 (class 2606 OID 17713)
-- Name: jalan jalan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jalan
    ADD CONSTRAINT jalan_pkey PRIMARY KEY (id);


--
-- TOC entry 5790 (class 2606 OID 17723)
-- Name: wilayah wilayah_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wilayah
    ADD CONSTRAINT wilayah_pkey PRIMARY KEY (id);


-- Completed on 2026-02-17 23:30:29

--
-- PostgreSQL database dump complete
--

\unrestrict uP27fMZThIcYE5tId6BnvCB9531UV5HZPIkSr7T6MX6HAgauhkydPYyiG5msiYp

