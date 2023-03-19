--
-- PostgreSQL database dump
--

-- Dumped from database version 14.7 (Ubuntu 14.7-1.pgdg22.04+1)
-- Dumped by pg_dump version 14.7 (Ubuntu 14.7-1.pgdg22.04+1)

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
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: istfuss; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.istfuss (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    istfuss numeric NOT NULL,
    name character varying(255) NOT NULL
);


--
-- Name: istgkfz; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.istgkfz (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    istgkfz numeric NOT NULL,
    name character varying(255) NOT NULL
);


--
-- Name: istkrad; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.istkrad (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    istkrad numeric NOT NULL,
    name character varying(255) NOT NULL
);


--
-- Name: istpkw; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.istpkw (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    istpkw numeric NOT NULL,
    name character varying(255) NOT NULL
);


--
-- Name: istrad; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.istrad (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    istrad numeric NOT NULL,
    name character varying(255) NOT NULL
);


--
-- Name: istsonstig; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.istsonstig (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    istsonstig numeric NOT NULL,
    name character varying(255) NOT NULL
);


--
-- Name: postgis_unfallorte; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.postgis_unfallorte (
    ogc_fid integer NOT NULL,
    objectid integer,
    uidentstla character varying,
    uland character varying,
    uregbez character varying,
    ukreis character varying,
    ugemeinde character varying,
    ujahr character varying,
    umonat character varying,
    ustunde character varying,
    uwochentag character varying,
    ukategorie character varying,
    uart character varying,
    utyp1 character varying,
    ulichtverh character varying,
    istrad character varying,
    istpkw character varying,
    istfuss character varying,
    istkrad character varying,
    istgkfz character varying,
    istsonstig character varying,
    linrefx double precision,
    linrefy double precision,
    xgcswgs84 double precision,
    ygcswgs84 double precision,
    ustrzustan character varying,
    wkb_geometry public.geometry(Point,4326)
);


--
-- Name: postgis_unfallorte_ogc_fid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.postgis_unfallorte_ogc_fid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: postgis_unfallorte_ogc_fid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.postgis_unfallorte_ogc_fid_seq OWNED BY public.postgis_unfallorte.ogc_fid;


--
-- Name: postgis_verwaltungsgebiete; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.postgis_verwaltungsgebiete (
    ogc_fid integer NOT NULL,
    objid character varying,
    beginn date,
    ade integer,
    gf integer,
    bsg integer,
    ars character varying,
    ags character varying,
    sdv_ars character varying,
    gen character varying,
    bez character varying,
    ibz integer,
    bem character varying,
    nbd character varying,
    sn_l character varying,
    sn_r character varying,
    sn_k character varying,
    sn_v1 character varying,
    sn_v2 character varying,
    sn_g character varying,
    fk_s3 character varying,
    nuts character varying,
    ars_0 character varying,
    ags_0 character varying,
    wsk date,
    wkb_geometry public.geometry(MultiPolygon,4326)
);


--
-- Name: postgis_verwaltungsgebiete_ogc_fid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.postgis_verwaltungsgebiete_ogc_fid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: postgis_verwaltungsgebiete_ogc_fid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.postgis_verwaltungsgebiete_ogc_fid_seq OWNED BY public.postgis_verwaltungsgebiete.ogc_fid;


--
-- Name: uart; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.uart (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    uart numeric NOT NULL,
    name character varying(255) NOT NULL
);


--
-- Name: ukategorie; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ukategorie (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    ukategorie numeric NOT NULL,
    name character varying(255) NOT NULL
);


--
-- Name: uland; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.uland (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    uland numeric NOT NULL,
    name character varying(255) NOT NULL
);


--
-- Name: ulichtverh; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ulichtverh (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    ulichtverh numeric NOT NULL,
    name character varying(255) NOT NULL
);


--
-- Name: umonat; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.umonat (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    umonat numeric NOT NULL,
    name character varying(255) NOT NULL
);


--
-- Name: ustrzustan; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ustrzustan (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    ustrzustan numeric NOT NULL,
    name character varying(255) NOT NULL
);


--
-- Name: utyp1; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.utyp1 (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    utyp1 numeric NOT NULL,
    name character varying(255) NOT NULL
);


--
-- Name: uwochentag; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.uwochentag (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    uwochentag numeric NOT NULL,
    name character varying(255) NOT NULL
);


--
-- Name: postgis_unfallorte ogc_fid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.postgis_unfallorte ALTER COLUMN ogc_fid SET DEFAULT nextval('public.postgis_unfallorte_ogc_fid_seq'::regclass);


--
-- Name: postgis_verwaltungsgebiete ogc_fid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.postgis_verwaltungsgebiete ALTER COLUMN ogc_fid SET DEFAULT nextval('public.postgis_verwaltungsgebiete_ogc_fid_seq'::regclass);


--
-- Name: istfuss istfuss_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.istfuss
    ADD CONSTRAINT istfuss_pkey PRIMARY KEY (id);


--
-- Name: istgkfz istgkfz_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.istgkfz
    ADD CONSTRAINT istgkfz_pkey PRIMARY KEY (id);


--
-- Name: istkrad istkrad_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.istkrad
    ADD CONSTRAINT istkrad_pkey PRIMARY KEY (id);


--
-- Name: istpkw istpkw_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.istpkw
    ADD CONSTRAINT istpkw_pkey PRIMARY KEY (id);


--
-- Name: istrad istrad_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.istrad
    ADD CONSTRAINT istrad_pkey PRIMARY KEY (id);


--
-- Name: istsonstig istsonstig_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.istsonstig
    ADD CONSTRAINT istsonstig_pkey PRIMARY KEY (id);


--
-- Name: postgis_unfallorte postgis_unfallorte_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.postgis_unfallorte
    ADD CONSTRAINT postgis_unfallorte_pkey PRIMARY KEY (ogc_fid);


--
-- Name: postgis_verwaltungsgebiete postgis_verwaltungsgebiete_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.postgis_verwaltungsgebiete
    ADD CONSTRAINT postgis_verwaltungsgebiete_pkey PRIMARY KEY (ogc_fid);


--
-- Name: uart uart_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.uart
    ADD CONSTRAINT uart_pkey PRIMARY KEY (id);


--
-- Name: ukategorie ukategorie_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ukategorie
    ADD CONSTRAINT ukategorie_pkey PRIMARY KEY (id);


--
-- Name: uland uland_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.uland
    ADD CONSTRAINT uland_pkey PRIMARY KEY (id);


--
-- Name: ulichtverh ulichtverh_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ulichtverh
    ADD CONSTRAINT ulichtverh_pkey PRIMARY KEY (id);


--
-- Name: umonat umonat_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umonat
    ADD CONSTRAINT umonat_pkey PRIMARY KEY (id);


--
-- Name: ustrzustan ustrzustan_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ustrzustan
    ADD CONSTRAINT ustrzustan_pkey PRIMARY KEY (id);


--
-- Name: utyp1 utyp1_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.utyp1
    ADD CONSTRAINT utyp1_pkey PRIMARY KEY (id);


--
-- Name: uwochentag uwochentag_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.uwochentag
    ADD CONSTRAINT uwochentag_pkey PRIMARY KEY (id);


--
-- Name: postgis_unfallorte_wkb_geometry_geom_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX postgis_unfallorte_wkb_geometry_geom_idx ON public.postgis_unfallorte USING gist (wkb_geometry);


--
-- Name: postgis_verwaltungsgebiete_wkb_geometry_geom_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX postgis_verwaltungsgebiete_wkb_geometry_geom_idx ON public.postgis_verwaltungsgebiete USING gist (wkb_geometry);


--
-- Name: unfallorte_gix; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX unfallorte_gix ON public.postgis_unfallorte USING gist (wkb_geometry);


--
-- Name: verwaltungsgebiete_gix; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX verwaltungsgebiete_gix ON public.postgis_verwaltungsgebiete USING gist (wkb_geometry);


--
-- PostgreSQL database dump complete
--

