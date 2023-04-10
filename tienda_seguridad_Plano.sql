--
-- PostgreSQL database dump
--

-- Dumped from database version 14.7
-- Dumped by pg_dump version 14.7

-- Started on 2023-04-09 23:42:13

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
-- TOC entry 225 (class 1255 OID 16531)
-- Name: misegundopl(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.misegundopl() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

DECLARE
	empl record;
	contador integer :=0;
BEGIN
	FOR empl IN SELECT * FROM usuarios LOOP
		contador := contador + 1;
	END LOOP;
	INSERT INTO conteousuarios(total, tiempo ) VALUES (contador, now());
	RETURN NEW;
END



$$;


ALTER FUNCTION public.misegundopl() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 218 (class 1259 OID 16441)
-- Name: compras; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.compras (
    id integer NOT NULL,
    total numeric,
    "tipo de pago" character varying,
    id_usuario integer,
    producto integer
);


ALTER TABLE public.compras OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16440)
-- Name: compras_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.compras_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.compras_id_seq OWNER TO postgres;

--
-- TOC entry 3392 (class 0 OID 0)
-- Dependencies: 217
-- Name: compras_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.compras_id_seq OWNED BY public.compras.id;


--
-- TOC entry 224 (class 1259 OID 16521)
-- Name: conteousuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conteousuarios (
    id integer NOT NULL,
    total integer,
    tiempo time with time zone
);


ALTER TABLE public.conteousuarios OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16520)
-- Name: conteousuarios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.conteousuarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.conteousuarios_id_seq OWNER TO postgres;

--
-- TOC entry 3393 (class 0 OID 0)
-- Dependencies: 223
-- Name: conteousuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.conteousuarios_id_seq OWNED BY public.conteousuarios.id;


--
-- TOC entry 212 (class 1259 OID 16414)
-- Name: empleados; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.empleados (
    id integer NOT NULL,
    identificacion character varying,
    nombre character varying(50),
    sexo "char",
    id_tienda integer
);


ALTER TABLE public.empleados OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16413)
-- Name: empleados_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.empleados_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.empleados_id_seq OWNER TO postgres;

--
-- TOC entry 3395 (class 0 OID 0)
-- Dependencies: 211
-- Name: empleados_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.empleados_id_seq OWNED BY public.empleados.id;


--
-- TOC entry 214 (class 1259 OID 16423)
-- Name: gastos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gastos (
    id integer NOT NULL,
    fecha date,
    descripcion character varying(50),
    valor numeric,
    id_tienda integer
);


ALTER TABLE public.gastos OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16505)
-- Name: gastos_altos; Type: MATERIALIZED VIEW; Schema: public; Owner: postgres
--

CREATE MATERIALIZED VIEW public.gastos_altos AS
 SELECT gastos.id,
    gastos.fecha,
    gastos.descripcion,
    gastos.valor,
    gastos.id_tienda
   FROM public.gastos
  WHERE (gastos.valor > (9000)::numeric)
  WITH NO DATA;


ALTER TABLE public.gastos_altos OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 16422)
-- Name: gastos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.gastos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gastos_id_seq OWNER TO postgres;

--
-- TOC entry 3397 (class 0 OID 0)
-- Dependencies: 213
-- Name: gastos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.gastos_id_seq OWNED BY public.gastos.id;


--
-- TOC entry 221 (class 1259 OID 16501)
-- Name: letras_inicio; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.letras_inicio AS
 SELECT empleados.id,
    empleados.identificacion,
    empleados.nombre,
    empleados.sexo,
        CASE
            WHEN ((empleados.nombre)::text ~~* 'a%'::text) THEN 'Empieza por A'::text
            WHEN ((empleados.nombre)::text ~~* 'e%'::text) THEN 'Empieza por E'::text
            WHEN ((empleados.nombre)::text ~~* 'i%'::text) THEN 'Empieza por I'::text
            WHEN ((empleados.nombre)::text ~~* 'o%'::text) THEN 'Empieza por O'::text
            WHEN ((empleados.nombre)::text ~~* 'u%'::text) THEN 'Empieza por U'::text
            ELSE NULL::text
        END AS "case"
   FROM public.empleados;


ALTER TABLE public.letras_inicio OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16450)
-- Name: productos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.productos (
    id integer NOT NULL,
    descripcion character varying
);


ALTER TABLE public.productos OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16449)
-- Name: productos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.productos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.productos_id_seq OWNER TO postgres;

--
-- TOC entry 3399 (class 0 OID 0)
-- Dependencies: 219
-- Name: productos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.productos_id_seq OWNED BY public.productos.id;


--
-- TOC entry 210 (class 1259 OID 16407)
-- Name: sucursales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sucursales (
    id integer NOT NULL,
    nombre character varying(50),
    correo character varying(50),
    direccion character varying(50)
);


ALTER TABLE public.sucursales OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 16406)
-- Name: sucursales_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sucursales_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sucursales_id_seq OWNER TO postgres;

--
-- TOC entry 3401 (class 0 OID 0)
-- Dependencies: 209
-- Name: sucursales_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sucursales_id_seq OWNED BY public.sucursales.id;


--
-- TOC entry 216 (class 1259 OID 16432)
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    id integer NOT NULL,
    nombre character varying(50),
    celular character varying(50),
    compra numeric,
    id_sucursal integer
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16431)
-- Name: usuarios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usuarios_id_seq OWNER TO postgres;

--
-- TOC entry 3403 (class 0 OID 0)
-- Dependencies: 215
-- Name: usuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuarios_id_seq OWNED BY public.usuarios.id;


--
-- TOC entry 3207 (class 2604 OID 16444)
-- Name: compras id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compras ALTER COLUMN id SET DEFAULT nextval('public.compras_id_seq'::regclass);


--
-- TOC entry 3209 (class 2604 OID 16524)
-- Name: conteousuarios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conteousuarios ALTER COLUMN id SET DEFAULT nextval('public.conteousuarios_id_seq'::regclass);


--
-- TOC entry 3204 (class 2604 OID 16417)
-- Name: empleados id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empleados ALTER COLUMN id SET DEFAULT nextval('public.empleados_id_seq'::regclass);


--
-- TOC entry 3205 (class 2604 OID 16426)
-- Name: gastos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gastos ALTER COLUMN id SET DEFAULT nextval('public.gastos_id_seq'::regclass);


--
-- TOC entry 3208 (class 2604 OID 16453)
-- Name: productos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos ALTER COLUMN id SET DEFAULT nextval('public.productos_id_seq'::regclass);


--
-- TOC entry 3203 (class 2604 OID 16410)
-- Name: sucursales id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sucursales ALTER COLUMN id SET DEFAULT nextval('public.sucursales_id_seq'::regclass);


--
-- TOC entry 3206 (class 2604 OID 16435)
-- Name: usuarios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN id SET DEFAULT nextval('public.usuarios_id_seq'::regclass);


--
-- TOC entry 3380 (class 0 OID 16441)
-- Dependencies: 218
-- Data for Name: compras; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.compras (id, total, "tipo de pago", id_usuario, producto) FROM stdin;
1	5000	fisico	1	2
2	15000	efectivo	2	1
3	1000	Virtual	3	2
4	12345	efectivo	4	3
5	4567	Virtual	5	4
6	5841	efectivo	6	5
7	1237	Virtual	7	6
8	4539	efectivo	8	7
9	1288	Virtual	9	8
10	8588	efectivo	10	9
11	3510	Virtual	11	10
\.


--
-- TOC entry 3385 (class 0 OID 16521)
-- Dependencies: 224
-- Data for Name: conteousuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.conteousuarios (id, total, tiempo) FROM stdin;
1	105	11:42:08.963175-05
2	106	11:42:43.776303-05
6	107	11:45:33.044378-05
\.


--
-- TOC entry 3374 (class 0 OID 16414)
-- Dependencies: 212
-- Data for Name: empleados; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.empleados (id, identificacion, nombre, sexo, id_tienda) FROM stdin;
1	123456789	empleado1	m	1
2	5297170915	Y-Solowarm	M	1
3	9471840821	Ventosanzap	F	2
4	6268030559	Bigtax	M	3
5	9698881409	Biodex	F	4
6	5548744127	Stronghold	F	5
7	8921036202	Transcof	M	6
8	4203162602	Fix San	F	7
9	5295430715	Gembucket	F	8
10	0283244143	Tampflex	F	9
11	4375459239	Sonair	F	10
12	0684796929	Sub-Ex	F	11
13	6230250101	Temp	M	12
14	0797301240	Toughjoyfax	F	13
15	3923453531	Zontrax	M	14
16	7083884722	Alphazap	F	15
17	3580617370	Bytecard	M	16
18	7285048097	Sub-Ex	F	17
19	2181620644	Ronstring	F	18
20	3086600519	Bitchip	M	19
21	6009774551	Quo Lux	F	20
22	4118459701	Stringtough	M	21
23	5424801072	Greenlam	F	22
24	2099287473	Otcom	F	23
25	0366808613	Job	F	24
26	1912207427	Sub-Ex	F	25
27	8949492032	Transcof	M	26
28	6947554950	Redhold	F	27
29	1151065188	Opela	F	28
30	9957144537	Veribet	F	29
31	5505519520	It	M	30
32	2623460256	Konklab	M	31
33	4183551862	Stim	M	32
34	4049196573	Matsoft	F	33
35	2240104619	Lotstring	M	34
36	3344714422	Voyatouch	M	35
37	9642770059	Flexidy	F	36
38	8105230860	Tin	F	37
39	3581753545	Lotstring	M	38
40	3402655020	Zoolab	M	39
41	5343935958	Transcof	F	40
42	3785623550	Zathin	M	41
43	8772516526	Andalax	M	42
44	5966608792	It	F	43
45	0238363740	Flowdesk	M	44
46	2066163392	Otcom	F	45
47	7313775067	Sub-Ex	M	46
48	5373862207	Stim	M	47
49	6363376432	Zaam-Dox	M	48
50	3725493413	Biodex	F	49
51	8387730211	Quo Lux	M	50
52	5241896961	Transcof	F	51
53	7305537071	Matsoft	F	52
54	8121607574	Sonsing	F	53
55	9568342559	Zathin	F	54
56	4775948415	Aerified	M	55
57	5973997197	Transcof	M	56
58	9868862868	Otcom	M	57
59	7109259889	Toughjoyfax	F	58
60	7646003034	Cardify	M	59
61	0891222804	Stringtough	F	60
62	0841070113	Flexidy	F	61
63	0161012493	Stim	M	62
64	1427461120	Sonsing	F	63
65	0295009292	Matsoft	M	64
66	4317999072	Daltfresh	M	65
67	3541929588	Duobam	F	66
68	2232550125	Lotstring	F	67
69	0902404474	Lotlux	F	68
70	1875545824	Stronghold	F	69
71	6224226997	Flowdesk	F	70
72	4967240070	Tres-Zap	F	71
73	7750941193	Bitchip	F	72
74	3383026124	Veribet	M	73
75	8921017348	Ventosanzap	F	74
76	3245550502	Bigtax	M	75
77	8663301790	Zaam-Dox	F	76
78	7630063407	Home Ing	M	77
79	0858544717	Treeflex	F	78
80	8634745406	Flowdesk	F	79
81	8726418282	Opela	F	80
82	2902996012	Tin	M	1
83	0447240110	Domainer	F	2
84	7319049759	Prodder	F	3
85	9478456857	Veribet	M	4
86	4076126785	Temp	M	5
87	5331196136	Rank	F	6
88	7659881140	Lotstring	F	7
89	3116591784	Voyatouch	F	8
90	7596409334	Konklab	F	9
91	7800249506	Viva	F	10
92	3034454813	Stronghold	F	11
93	6862783009	Hatity	F	12
94	1791725554	Cardify	F	13
95	7589408697	Tampflex	M	14
96	9334667540	Pannier	F	15
97	3728121428	Stim	F	16
98	6838189577	Andalax	F	17
99	0199247250	Tempsoft	F	18
100	2292906554	Ronstring	M	19
101	4777659143	Zamit	M	20
102	3087529060	Holdlamis	M	21
103	6611493786	Trippledex	F	22
104	7495647426	Latlux	F	23
105	6322251163	It	F	24
106	5913948416	Sonsing	M	25
107	5304087690	Home Ing	F	26
108	6264798118	Toughjoyfax	F	27
109	7765794868	Keylex	F	28
110	5375985756	Latlux	M	29
111	4307846605	Bytecard	M	30
112	4206286906	Home Ing	M	31
113	9482925785	Quo Lux	F	32
114	8235231026	Tin	M	33
115	1132872855	Vagram	M	34
116	3906620867	Tin	M	35
117	5015955499	Vagram	M	36
118	4197948743	Veribet	M	37
119	3168994448	Toughjoyfax	M	38
120	6959219884	Fix San	M	39
121	1037745744	Alphazap	F	40
122	9319058423	Matsoft	M	41
123	9958591537	Sub-Ex	F	42
124	7898770633	Flowdesk	M	43
125	8382633676	Tin	M	44
126	6218499723	Ventosanzap	F	45
127	9162645668	Hatity	F	46
128	3653078016	Solarbreeze	M	47
129	4786083305	Tempsoft	M	48
130	6177285309	Veribet	M	49
131	9449436711	Namfix	F	50
132	3170884174	Gembucket	F	51
133	4470920207	Matsoft	F	52
134	9435067891	Bytecard	M	53
135	8976300475	Domainer	F	54
136	4843116025	Sonair	F	55
137	3430864690	Tempsoft	M	56
138	9587522109	Redhold	M	57
139	8924116282	Namfix	F	58
140	3622418052	Wrapsafe	M	59
141	7981095360	Alpha	F	60
142	8266256217	Alphazap	F	61
143	8842210668	Transcof	F	62
144	9350835231	Cookley	F	63
145	9100151149	Sonsing	M	64
146	6034381533	Kanlam	M	65
147	1556683952	Andalax	F	66
148	9940461356	Daltfresh	F	67
149	4239963915	Bitchip	M	68
150	3154174338	Vagram	F	69
151	5919021047	It	F	70
152	1768195188	Tresom	M	71
153	6983684702	Bitwolf	F	72
154	2710196581	Regrant	M	73
155	2624366822	Transcof	F	74
156	5728570615	Otcom	M	75
157	1993524460	Zaam-Dox	F	76
158	0511003501	Mat Lam Tam	M	77
159	8019585729	Namfix	F	78
160	2828694712	Alphazap	F	79
161	5420522098	Fixflex	F	80
162	4692601787	Matsoft	F	81
163	1702644758	Matsoft	M	82
164	2557453153	Mat Lam Tam	M	83
165	0685228940	Sonsing	M	84
166	4440124356	Konklux	M	85
167	3688190882	Toughjoyfax	F	86
168	9873293213	Vagram	F	87
169	9108288119	Ventosanzap	M	88
170	1530564387	Overhold	M	89
171	8176995991	Zoolab	M	90
172	7909496702	Home Ing	M	91
173	2801937665	Aerified	M	92
174	0663588367	Span	F	93
175	5799657594	Zamit	M	94
176	2373103915	Alphazap	F	95
177	6001477485	Fixflex	F	96
178	8454078363	Greenlam	F	97
179	5734851914	Stim	M	98
180	6265714341	Bitwolf	F	99
181	1652455728	Ronstring	M	100
\.


--
-- TOC entry 3376 (class 0 OID 16423)
-- Dependencies: 214
-- Data for Name: gastos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.gastos (id, fecha, descripcion, valor, id_tienda) FROM stdin;
1	2023-02-02	electricidad	12000	1
2	2023-02-10	Almonds Ground Blanched	2935	1
3	2023-01-27	Bread - Dark Rye	3572	2
4	2023-08-16	Energy - Boo - Koo	4317	3
5	2023-03-14	Basil - Pesto Sauce	5608	4
6	2023-05-08	Onions - Dried, Chopped	3324	5
7	2023-02-12	Dikon	4229	6
8	2023-10-08	Cranberry Foccacia	8556	7
9	2023-04-08	Nescafe - Frothy French Vanilla	4167	8
10	2023-01-27	Banana - Leaves	4663	9
11	2023-07-06	Salt - Sea	2174	10
12	2023-12-13	Pesto - Primerba, Paste	6669	11
13	2023-02-11	Halibut - Whole, Fresh	4120	12
14	2023-10-10	Tomatoes - Vine Ripe, Yellow	5102	13
15	2023-01-23	Lid Tray - 12in Dome	4243	14
16	2023-08-21	Cheese - Asiago	7680	15
17	2023-03-02	Wooden Mop Handle	2122	16
18	2023-09-27	Wine - Zonnebloem Pinotage	4162	17
19	2023-11-19	Bread - Italian Sesame Poly	2891	18
20	2023-05-03	Island Oasis - Strawberry	1574	19
21	2023-11-09	Wine - Saint - Bris 2002, Sauv	6762	20
22	2023-08-31	Lid - 3oz Med Rec	5079	21
23	2023-08-30	Sesame Seed	4569	22
24	2023-04-07	Rice Pilaf, Dry,package	9790	23
25	2023-01-17	Wine - White, Ej	5381	24
26	2023-10-19	Sugar - Cubes	6495	25
27	2023-08-16	Tomato Paste	1164	26
28	2023-10-02	Pie Shell - 5	1171	27
29	2023-10-28	Bandage - Fexible 1x3	3655	28
30	2023-09-03	Blueberries	5669	29
31	2023-11-21	Wine - Gewurztraminer Pierre	2472	30
32	2023-05-29	Cup - 6oz, Foam	2441	31
33	2023-10-09	Chicken - Whole Fryers	8632	32
34	2023-06-21	Lettuce - Iceberg	8257	33
35	2023-02-19	Coconut - Creamed, Pure	7053	34
36	2023-02-21	Veal - Inside Round / Top, Lean	1524	35
37	2023-12-14	Cheese - Asiago	6046	36
38	2023-03-21	Sauce Bbq Smokey	1389	37
39	2023-08-29	Salt - Rock, Course	3883	38
40	2023-07-28	Wine - Conde De Valdemar	2591	39
41	2023-09-10	Lid Coffee Cup 8oz Blk	3417	40
42	2023-01-29	Shrimp - 150 - 250	3565	41
43	2023-09-14	Bag - Bread, White, Plain	2705	42
44	2023-09-01	Oil - Olive, Extra Virgin	5733	43
45	2023-06-13	Sole - Dover, Whole, Fresh	9922	44
46	2023-09-12	Sprite - 355 Ml	6223	45
47	2023-10-13	Chef Hat 25cm	7159	46
48	2023-04-22	Wine - White, Lindemans Bin 95	5393	47
49	2023-09-30	Cheese - Pied De Vents	4182	48
50	2023-06-19	Cod - Black Whole Fillet	9968	49
51	2023-08-22	Cheese - Wine	7855	50
52	2023-07-04	Cheese - Feta	7853	51
53	2023-02-13	Buffalo - Short Rib Fresh	6951	52
54	2023-03-20	Onions - White	8505	53
55	2023-10-29	Sauce - Thousand Island	2249	54
56	2023-10-26	Squid Ink	9838	55
57	2023-06-30	Vaccum Bag - 14x20	4345	56
58	2023-11-28	Wine - Pinot Noir Pond Haddock	4815	57
59	2023-09-11	Pasta - Agnolotti - Butternut	4596	58
60	2023-10-30	Broom And Brush Rack Black	2115	59
61	2023-07-09	Bread - Hot Dog Buns	5141	60
62	2023-02-01	Bread - Focaccia Quarter	3358	61
63	2023-02-13	Flower - Commercial Bronze	1027	62
64	2023-08-20	Wine - Two Oceans Cabernet	6277	63
65	2023-08-28	Cup - 6oz, Foam	7823	64
66	2023-10-03	Towel Dispenser	8859	65
67	2023-09-08	Tart Shells - Sweet, 2	1306	66
68	2023-10-08	Cups 10oz Trans	3845	67
69	2023-03-01	Grenadillo	4462	68
70	2023-12-07	The Pop Shoppe - Root Beer	1763	69
71	2023-05-08	Flour - Buckwheat, Dark	9408	70
72	2023-02-08	Wine - Casillero Del Diablo	3947	71
73	2023-10-19	Mangoes	5259	72
74	2023-09-14	Beer - Mill St Organic	5289	73
75	2023-06-25	Wine - Magnotta, White	5562	74
76	2023-05-28	Potatoes - Instant, Mashed	7808	75
77	2023-01-06	The Pop Shoppe - Grape	8663	76
78	2023-03-12	Wine - Magnotta, Merlot Sr Vqa	5523	77
79	2023-09-05	Everfresh Products	4457	78
80	2023-11-24	Lamb - Leg, Diced	7082	79
81	2023-08-23	Sour Puss Raspberry	9202	80
82	2023-04-22	Mustard - Pommery	7611	81
83	2023-07-15	Lobster - Tail 6 Oz	8591	82
84	2023-07-22	Lemon Pepper	8055	83
85	2023-09-05	Fish - Artic Char, Cold Smoked	7232	84
86	2023-09-05	Beef Cheek Fresh	2677	85
87	2023-03-10	Ocean Spray - Ruby Red	8912	86
88	2023-04-17	Dc - Frozen Momji	2433	87
89	2023-01-11	Tuna - Salad Premix	2681	88
90	2023-03-23	Beans - Wax	6281	89
91	2023-01-18	Chocolate Liqueur - Godet White	8320	90
92	2023-09-18	Flour - Strong Pizza	5605	91
93	2023-06-12	Wine - Bouchard La Vignee Pinot	1135	92
94	2023-03-14	Cod - Fillets	3536	93
95	2023-11-17	Milkettes - 2%	1339	94
96	2023-11-11	Onions - Dried, Chopped	3983	95
97	2023-04-07	Tea - Herbal Sweet Dreams	2380	96
98	2023-08-27	Mustard - Dry, Powder	8232	97
99	2023-01-18	Nescafe - Frothy French Vanilla	8205	98
100	2023-03-10	Artichoke - Bottom, Canned	2560	99
101	2023-12-14	Cheese - Asiago	4778	100
102	2023-12-07	Yeast - Fresh, Fleischman	3461	1
103	2023-02-09	Dome Lid Clear P92008h	6325	2
104	2023-11-18	Wine - Shiraz South Eastern	9953	3
105	2023-04-02	Pork - Liver	8894	4
106	2023-12-02	Chicken - Livers	1776	5
107	2023-01-12	Veal - Shank, Pieces	1836	6
108	2023-08-04	Muffin Mix - Lemon Cranberry	9072	7
109	2023-03-08	Cut Wakame - Hanawakaba	3624	8
110	2023-06-20	Scallops - U - 10	8268	9
111	2023-09-08	Nantucket - Carrot Orange	6572	10
112	2023-01-19	Soup - Knorr, Ministrone	8059	11
113	2023-08-31	Mix - Cocktail Ice Cream	1566	12
114	2023-08-27	Beef - Short Ribs	2904	13
115	2023-03-06	Bread Sour Rolls	8330	14
116	2023-10-01	Ranchero - Primerba, Paste	9652	15
117	2023-07-22	Wine - Magnotta - Belpaese	1264	16
118	2023-12-26	Bread Cranberry Foccacia	5280	17
119	2023-03-22	Tea Peppermint	1303	18
120	2023-01-15	Tea - Herbal Orange Spice	1585	19
121	2023-12-22	Wine - Ice Wine	1210	20
122	2023-07-03	Coffee Beans - Chocolate	9971	21
123	2023-10-21	Sour Puss - Tangerine	8819	22
124	2023-05-28	Wine - Two Oceans Sauvignon	7965	23
125	2023-04-02	Cake - Bande Of Fruit	3759	24
126	2023-05-01	Muffin - Carrot Individual Wrap	5732	25
127	2023-08-03	Tomatoes - Plum, Canned	4672	26
128	2023-03-05	Sauce - Gravy, Au Jus, Mix	3275	27
129	2023-09-28	Coffee - Frthy Coffee Crisp	9442	28
130	2023-11-10	Flower - Commercial Spider	4158	29
131	2023-06-26	Mix Pina Colada	4839	30
132	2023-04-19	Pike - Frozen Fillet	7022	31
133	2023-08-06	Tomatoes - Orange	5315	32
134	2023-10-05	Food Colouring - Orange	4281	33
135	2023-09-03	Wine - Casillero Deldiablo	8827	34
136	2023-08-07	Longos - Lasagna Veg	8687	35
137	2023-07-28	Beer - Muskoka Cream Ale	4329	36
138	2023-01-24	Grapes - Red	1487	37
139	2023-06-17	Appetizer - Shrimp Puff	1270	38
140	2023-04-26	Wine - Manischewitz Concord	2344	39
141	2023-03-17	Lamb - Whole, Fresh	3873	40
142	2023-10-14	Bread - French Stick	2946	41
143	2023-08-02	Appetizer - Lobster Phyllo Roll	4439	42
144	2023-12-25	Brandy - Orange, Mc Guiness	9089	43
145	2023-10-23	Coffee Cup 12oz 5342cd	1354	44
146	2023-08-25	Halibut - Whole, Fresh	2044	45
147	2023-01-31	Longos - Assorted Sandwich	8361	46
148	2023-06-24	Foam Cup 6 Oz	8664	47
149	2023-03-13	Red Snapper - Fillet, Skin On	3778	48
150	2023-03-14	Veal - Eye Of Round	9208	49
151	2023-02-28	Tomatoes Tear Drop Yellow	2467	50
152	2023-02-14	Milk - 2%	5250	51
153	2023-05-19	Tomatoes - Plum, Canned	1615	52
154	2023-06-26	Tuna - Yellowfin	3090	53
155	2023-01-13	Yokaline	8225	54
156	2023-11-05	Compound - Passion Fruit	6130	55
157	2023-07-28	Jagermeister	1124	56
158	2023-07-16	Phyllo Dough	1700	57
159	2023-09-15	Marjoram - Dried, Rubbed	9679	58
160	2023-01-25	Cotton Wet Mop 16 Oz	3720	59
161	2023-09-14	Veal - Eye Of Round	3046	60
162	2023-12-05	Appetizer - Spring Roll, Veg	4178	61
163	2023-08-23	Pepper - Chilli Seeds Mild	2980	62
164	2023-12-09	Water Chestnut - Canned	9617	63
165	2023-05-25	Chicken - Whole	7408	64
166	2023-11-14	Rum - Mount Gay Eclipes	8195	65
167	2023-01-13	Bonito Flakes - Toku Katsuo	6469	66
168	2023-09-01	Gingerale - Diet - Schweppes	6983	67
169	2023-02-14	Tuna - Canned, Flaked, Light	2747	68
170	2023-05-27	Soup - Campbellschix Stew	3852	69
171	2023-02-10	Onions - Spanish	2941	70
172	2023-04-26	Raisin - Golden	8619	71
173	2023-08-15	Orange Roughy 6/8 Oz	3857	72
174	2023-09-15	Veal - Shank, Pieces	7370	73
175	2023-08-20	Beef Dry Aged Tenderloin Aaa	4806	74
176	2023-01-09	Artichokes - Knobless, White	2782	75
177	2023-10-26	Ecolab - Mikroklene 4/4 L	2855	76
178	2023-04-23	Fib N9 - Prague Powder	1730	77
179	2023-10-04	Miso Paste White	3659	78
180	2023-09-15	Bread - Assorted Rolls	9332	79
181	2023-02-04	Vector Energy Bar	4330	80
182	2023-09-22	Pur Source	2684	81
183	2023-12-19	Wine - Sauvignon Blanc	9303	82
184	2023-05-10	Cookies - Amaretto	4422	83
185	2023-08-17	Bols Melon Liqueur	9583	84
186	2023-08-15	Juice - Apple, 341 Ml	9819	85
187	2023-10-09	Oneshot Automatic Soap System	3869	86
188	2023-06-13	Energy Drink - Redbull 355ml	9292	87
189	2023-07-01	Port - 74 Brights	5352	88
190	2023-02-02	Tomatoes - Yellow Hot House	5405	89
191	2023-03-21	Melon - Cantaloupe	2311	90
192	2023-09-15	Mortadella	3693	91
193	2023-12-23	Cheese - Cheddar, Mild	9539	92
194	2023-11-05	Wine - Trimbach Pinot Blanc	9010	93
195	2023-12-25	Crush - Cream Soda	8381	94
196	2023-01-29	Burger Veggie	1756	95
197	2023-04-27	Wine - Fume Blanc Fetzer	2580	96
198	2023-11-21	Pop - Club Soda Can	5165	97
199	2023-02-17	Beans - French	2794	98
200	2023-11-09	Dome Lid Clear P92008h	8931	99
201	2023-02-04	Lamb Leg - Bone - In Nz	2384	100
\.


--
-- TOC entry 3382 (class 0 OID 16450)
-- Dependencies: 220
-- Data for Name: productos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.productos (id, descripcion) FROM stdin;
1	Agua
2	Gaseosa
3	Arroz
4	Pollo
5	Carne
6	Queso
7	Cerdo
8	Harina
9	Pan
10	Huevos
\.


--
-- TOC entry 3372 (class 0 OID 16407)
-- Dependencies: 210
-- Data for Name: sucursales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sucursales (id, nombre, correo, direccion) FROM stdin;
1	Gerente1	gerente1@corre.com	direccion1
2	Tienda1	tienda@correo.com	Manzana 1
3	Dynazzy	rshallo0@technorati.com	51319 Acker Plaza
4	Janyx	mseward1@mail.ru	741 Stuart Crossing
5	Browseblab	mlongford2@cocolog-nifty.com	3 Pepper Wood Park
6	Thoughtmix	ecampbelldunlop3@canalblog.com	413 Northport Center
7	Gabspot	fcathrall4@sourceforge.net	561 Doe Crossing Junction
8	Trunyx	zbrendish5@list-manage.com	9 Waxwing Trail
9	Divape	jdoyle6@howstuffworks.com	4604 Lake View Place
10	Kaymbo	brobardet7@nba.com	81 Hollow Ridge Pass
11	Edgewire	ugantzman8@alexa.com	23873 Monica Point
12	Einti	jjeavons9@tmall.com	31678 Washington Circle
13	Yacero	kkilbridea@mozilla.org	9 Dwight Terrace
14	Blogtag	mkebellb@homestead.com	6295 Northridge Terrace
15	Skiptube	sbahlc@wordpress.org	4 Wayridge Lane
16	Oyoyo	barmalld@forbes.com	60068 Bay Crossing
17	Zoomcast	wclinese@usatoday.com	67157 Sunnyside Circle
18	Jabbertype	pdudsonf@spiegel.de	3 Oneill Alley
19	Brightbean	bledgleyg@chron.com	044 Ryan Lane
20	Brainsphere	rrobroeh@dell.com	6 Stone Corner Street
21	Zoovu	lposseli@infoseek.co.jp	2283 Stuart Avenue
22	Eire	awickersleyj@ft.com	4609 Arrowood Way
23	Kazu	hallsoppk@mtv.com	59874 Dennis Point
24	Skiptube	kwaleranl@vistaprint.com	431 Laurel Court
25	Muxo	aeddiem@china.com.cn	46915 Park Meadow Court
26	Tagcat	ilantuffen@oaic.gov.au	04070 7th Point
27	Feedfire	nstandishbrookso@msu.edu	6790 Packers Way
28	Youfeed	gkeelep@ucoz.com	9 Pierstorff Junction
29	Skyvu	tclemotq@youku.com	4 Melvin Plaza
30	Shufflester	aborkettr@admin.ch	0 Everett Parkway
31	Rhynoodle	mfidells@ycombinator.com	94 Hayes Trail
32	InnoZ	jheathwoodt@surveymonkey.com	385 Buena Vista Terrace
33	Twitterbridge	cgeriu@zdnet.com	2902 Forest Parkway
34	Tambee	bhastiev@salon.com	91 Donald Terrace
35	Bluejam	hyanovw@nytimes.com	4 Stang Terrace
36	Browsetype	dverlindenx@ask.com	5061 3rd Hill
37	Vinder	sgirviny@amazon.co.uk	345 Sachtjen Center
38	Wordify	mvigrassz@taobao.com	3 Redwing Alley
39	Jaloo	gjudson10@purevolume.com	69353 Springview Court
40	Trudoo	vgommey11@tripadvisor.com	23292 Kropf Road
41	Blognation	tpurkiss12@mit.edu	59 Maywood Terrace
42	Yadel	cdyne13@diigo.com	9 Cherokee Parkway
43	Podcat	adowdney14@examiner.com	5 Hallows Crossing
44	Blogtags	lrandalston15@gizmodo.com	72 Hauk Way
45	Buzzbean	mstepto16@spotify.com	5297 Commercial Trail
46	Twiyo	bflorey17@paginegialle.it	00 Pond Place
47	Yozio	mestrella18@wikipedia.org	77 Bunting Crossing
48	Chatterpoint	dflay19@rediff.com	4 Ridgeway Plaza
49	Chatterbridge	hdelgua1a@histats.com	60531 Mandrake Junction
50	Devshare	ldellorto1b@unc.edu	875 Manufacturers Court
51	Talane	rkaines1c@ca.gov	35 Maryland Park
52	Latz	ogentile1d@geocities.com	311 Linden Avenue
53	Mycat	scurrey1e@biblegateway.com	92234 Sutteridge Terrace
54	Vinte	okeyworth1f@etsy.com	22903 Mallard Court
55	Tagtune	pbuffin1g@weather.com	2 Ridgeview Court
56	Jayo	ejakaway1h@sogou.com	07 Randy Center
57	Bubbletube	dvedishchev1i@xing.com	9 Union Way
58	Einti	rblackstone1j@aol.com	9383 Kropf Park
59	Tazz	vglason1k@chicagotribune.com	9256 Myrtle Pass
60	Zazio	cwort1l@ihg.com	1472 Anderson Drive
61	Kwinu	anelles1m@pen.io	06 Merchant Parkway
62	Photobug	aeardley1n@1und1.de	893 Kings Avenue
63	Skilith	lwinkle1o@mozilla.com	9315 Kropf Avenue
64	Ntags	wmacklin1p@yandex.ru	4766 Cascade Trail
65	Vinder	aprocter1q@cdc.gov	734 Vahlen Avenue
66	Eadel	mbaumadier1r@newsvine.com	378 Canary Lane
67	Fiveclub	mmurtimer1s@vimeo.com	8276 Milwaukee Crossing
68	Tambee	zikins1t@ucoz.ru	44280 Sunnyside Hill
69	Browsezoom	zjiruca1u@canalblog.com	86302 Comanche Junction
70	Feedfire	cbarclay1v@photobucket.com	716 Fuller Crossing
71	Realbridge	kcollishaw1w@over-blog.com	44 Chive Street
72	Tagtune	lfierman1x@wikimedia.org	630 Chive Court
73	Centimia	lheinle1y@example.com	084 Veith Center
74	Edgeify	jtointon1z@shareasale.com	2871 Moland Way
75	Twitterbeat	gwilmot20@prweb.com	934 Brentwood Terrace
76	Gabcube	obeahan21@elegantthemes.com	84 Rockefeller Street
77	Katz	kault22@soup.io	5 Portage Plaza
78	Skivee	bridgewell23@cbsnews.com	08 Bellgrove Place
79	Pixonyx	sfennessy24@mozilla.com	8 Bunting Park
80	Chatterpoint	dbreach25@reddit.com	792 Nova Hill
81	Kazu	gmaddrell26@bigcartel.com	05790 Bellgrove Park
82	Realcube	lgilks27@mapy.cz	90 Cambridge Hill
83	Wikibox	vbraham28@amazon.co.uk	7 Thackeray Lane
84	Youfeed	hharridge29@nyu.edu	6288 Park Meadow Plaza
85	Kaymbo	sbossingham2a@google.de	47302 Anzinger Point
86	Quatz	btather2b@free.fr	53 Havey Point
87	Meembee	bglauber2c@myspace.com	197 Brown Road
88	Zava	gjindrak2d@netlog.com	5280 Autumn Leaf Center
89	Ooba	wcrowhurst2e@paypal.com	85291 Acker Point
90	Cogilith	rbottrell2f@upenn.edu	21291 Continental Pass
91	Leenti	credit2g@gravatar.com	540 Monterey Alley
92	Photobug	klaite2h@dot.gov	198 Novick Crossing
93	Trudeo	scockill2i@google.co.jp	92 Delaware Trail
94	Einti	lcufley2j@squidoo.com	5 Mosinee Junction
95	Bubbletube	kvalentim2k@usnews.com	30 Mesta Point
96	Twitterworks	jpollie2l@usgs.gov	12529 Pond Way
97	Vidoo	gevins2m@networksolutions.com	69 Delladonna Avenue
98	Yoveo	wbridell2n@businessinsider.com	313 Gina Court
99	Bluezoom	dupstell2o@tinypic.com	5 Waywood Crossing
100	Topicshots	bleighton2p@arizona.edu	10 Esker Lane
101	Zoomcast	svanarsdall2q@virginia.edu	9 Packers Hill
102	Yakijo	hragless2r@github.com	16059 Morning Junction
\.


--
-- TOC entry 3378 (class 0 OID 16432)
-- Dependencies: 216
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (id, nombre, celular, compra, id_sucursal) FROM stdin;
1	seql	147852369	1	2
2	Toughjoyfax	04-703-2477	1	1
3	Job	43-956-0164	2	2
4	Sonsing	88-687-1318	3	3
5	Bigtax	68-897-6120	4	4
6	Bytecard	70-690-9988	5	5
7	Tempsoft	87-172-2813	6	6
8	Opela	67-572-9628	7	7
9	Bitchip	29-885-6932	8	8
10	Greenlam	89-721-1118	9	9
11	Alpha	01-990-0246	10	10
12	Holdlamis	62-485-8367	11	11
13	Home Ing	17-571-1802	12	12
14	Y-Solowarm	87-901-6262	13	13
15	Zoolab	39-338-6721	14	14
16	Bigtax	93-697-8533	15	15
17	Voltsillam	00-386-5796	16	16
18	Tempsoft	68-938-6208	17	17
19	Voltsillam	54-292-0222	18	18
20	Flexidy	87-233-9660	19	19
21	Voltsillam	62-805-7862	20	20
22	Bigtax	90-893-8787	21	21
23	Alpha	09-021-2817	22	22
24	Zaam-Dox	14-570-3713	23	23
25	Zoolab	68-562-5199	24	24
26	Matsoft	00-276-5443	25	25
27	Quo Lux	43-176-5725	26	26
28	It	21-620-8279	27	27
29	Subin	85-384-3650	28	28
30	Veribet	95-862-8554	29	29
31	Konklux	65-760-8434	30	30
32	Zathin	67-236-6255	31	31
33	Tin	72-396-2904	32	32
34	Greenlam	09-473-8149	33	33
35	Y-find	10-610-0154	34	34
36	Cardguard	81-596-3211	35	35
37	Zoolab	61-669-2501	36	36
38	Sonair	33-162-1163	37	37
39	It	76-245-4392	38	38
40	Ronstring	68-442-9190	39	39
41	Hatity	33-668-3810	40	40
42	Keylex	02-717-0711	41	41
43	Zathin	61-315-9517	42	42
44	Matsoft	15-528-1561	43	43
45	Tres-Zap	84-603-9395	44	44
46	Bamity	45-657-3332	45	45
47	Solarbreeze	78-813-4788	46	46
48	Overhold	62-639-6849	47	47
49	Voltsillam	75-649-4042	48	48
50	Overhold	32-846-2045	49	49
51	Bytecard	56-526-6379	50	50
52	Subin	02-780-5965	51	51
53	Konklab	92-930-8442	52	52
54	Fixflex	10-361-1976	53	53
55	Alpha	58-953-9549	54	54
56	Mat Lam Tam	66-883-3623	55	55
57	Alphazap	73-047-8289	56	56
58	Subin	74-958-2008	57	57
59	Stringtough	89-709-9976	58	58
60	Zathin	46-025-1107	59	59
61	Home Ing	44-562-7483	60	60
62	Namfix	55-499-4819	61	61
63	Konklux	88-229-4706	62	62
64	Holdlamis	94-673-3873	63	63
65	Bitchip	53-836-4007	64	64
66	Stronghold	44-198-1469	65	65
67	Zontrax	77-440-1531	66	66
68	Duobam	81-588-3056	67	67
69	Vagram	52-074-9193	68	68
70	Fintone	81-801-2003	69	69
71	Ronstring	56-617-1384	70	70
72	Bitwolf	61-320-8691	71	71
73	Overhold	21-705-4593	72	72
74	Home Ing	21-404-0942	73	73
75	Quo Lux	41-683-6019	74	74
76	Cookley	66-414-7940	75	75
77	Alpha	92-245-7245	76	76
78	Bytecard	10-536-7207	77	77
79	Bytecard	90-622-6461	78	78
80	Flowdesk	83-266-0985	79	79
81	Keylex	95-342-6811	80	80
82	It	84-351-7761	81	81
83	Solarbreeze	54-423-7472	82	82
84	Stronghold	75-831-9660	83	83
85	Zoolab	66-022-2006	84	84
86	Solarbreeze	70-068-3496	85	85
87	It	14-252-5425	86	86
88	Greenlam	79-933-6779	87	87
89	Kanlam	59-275-2006	88	88
90	Cookley	75-144-9917	89	89
91	Sonsing	96-082-8417	90	90
92	It	39-364-8325	91	91
93	Fintone	87-734-0233	92	92
94	Temp	03-653-4273	93	93
95	Redhold	46-380-4592	94	94
96	Konklab	60-756-2861	95	95
97	Alphazap	49-976-4254	96	96
98	Tres-Zap	61-173-5334	97	97
99	Solarbreeze	00-202-6729	98	98
100	Opela	83-177-0767	99	99
101	Domainer	72-656-0382	100	100
102	trigger	1234	3	4
103	PRUEBA	12345	200	5
104	PRUEBA2	12345	2001	7
105	prueba3	12444444	1234	4
106	prueba4	1244442	4444	2
107	prueba7	1242	1111	8
\.


--
-- TOC entry 3404 (class 0 OID 0)
-- Dependencies: 217
-- Name: compras_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.compras_id_seq', 11, true);


--
-- TOC entry 3405 (class 0 OID 0)
-- Dependencies: 223
-- Name: conteousuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.conteousuarios_id_seq', 6, true);


--
-- TOC entry 3406 (class 0 OID 0)
-- Dependencies: 211
-- Name: empleados_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.empleados_id_seq', 181, true);


--
-- TOC entry 3407 (class 0 OID 0)
-- Dependencies: 213
-- Name: gastos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.gastos_id_seq', 201, true);


--
-- TOC entry 3408 (class 0 OID 0)
-- Dependencies: 219
-- Name: productos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.productos_id_seq', 1, false);


--
-- TOC entry 3409 (class 0 OID 0)
-- Dependencies: 209
-- Name: sucursales_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sucursales_id_seq', 102, true);


--
-- TOC entry 3410 (class 0 OID 0)
-- Dependencies: 215
-- Name: usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuarios_id_seq', 107, true);


--
-- TOC entry 3219 (class 2606 OID 16448)
-- Name: compras compras_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compras
    ADD CONSTRAINT compras_pkey PRIMARY KEY (id);


--
-- TOC entry 3223 (class 2606 OID 16526)
-- Name: conteousuarios conteousuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conteousuarios
    ADD CONSTRAINT conteousuarios_pkey PRIMARY KEY (id);


--
-- TOC entry 3213 (class 2606 OID 16421)
-- Name: empleados empleados_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empleados
    ADD CONSTRAINT empleados_pkey PRIMARY KEY (id);


--
-- TOC entry 3215 (class 2606 OID 16430)
-- Name: gastos gastos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gastos
    ADD CONSTRAINT gastos_pkey PRIMARY KEY (id);


--
-- TOC entry 3221 (class 2606 OID 16457)
-- Name: productos productos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_pkey PRIMARY KEY (id);


--
-- TOC entry 3211 (class 2606 OID 16412)
-- Name: sucursales sucursales_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sucursales
    ADD CONSTRAINT sucursales_pkey PRIMARY KEY (id);


--
-- TOC entry 3217 (class 2606 OID 16439)
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);


--
-- TOC entry 3229 (class 2620 OID 16532)
-- Name: usuarios mitrigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER mitrigger AFTER INSERT ON public.usuarios FOR EACH ROW EXECUTE FUNCTION public.misegundopl();


--
-- TOC entry 3228 (class 2606 OID 16493)
-- Name: compras compras_productos_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compras
    ADD CONSTRAINT compras_productos_fkey FOREIGN KEY (producto) REFERENCES public.productos(id) NOT VALID;


--
-- TOC entry 3227 (class 2606 OID 16488)
-- Name: compras compras_usuarios_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compras
    ADD CONSTRAINT compras_usuarios_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id) NOT VALID;


--
-- TOC entry 3224 (class 2606 OID 16478)
-- Name: empleados empleados_sucursal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empleados
    ADD CONSTRAINT empleados_sucursal_fkey FOREIGN KEY (id_tienda) REFERENCES public.sucursales(id) NOT VALID;


--
-- TOC entry 3225 (class 2606 OID 16473)
-- Name: gastos gastos_sucursales_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gastos
    ADD CONSTRAINT gastos_sucursales_fkey FOREIGN KEY (id_tienda) REFERENCES public.sucursales(id) NOT VALID;


--
-- TOC entry 3226 (class 2606 OID 16483)
-- Name: usuarios usuarios_sucursal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_sucursal_fkey FOREIGN KEY (id_sucursal) REFERENCES public.sucursales(id) NOT VALID;


--
-- TOC entry 3391 (class 0 OID 0)
-- Dependencies: 218
-- Name: TABLE compras; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE public.compras TO usuario_consulta;


--
-- TOC entry 3394 (class 0 OID 0)
-- Dependencies: 212
-- Name: TABLE empleados; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE public.empleados TO usuario_consulta;


--
-- TOC entry 3396 (class 0 OID 0)
-- Dependencies: 214
-- Name: TABLE gastos; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE public.gastos TO usuario_consulta;


--
-- TOC entry 3398 (class 0 OID 0)
-- Dependencies: 220
-- Name: TABLE productos; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE public.productos TO usuario_consulta;


--
-- TOC entry 3400 (class 0 OID 0)
-- Dependencies: 210
-- Name: TABLE sucursales; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE public.sucursales TO usuario_consulta;


--
-- TOC entry 3402 (class 0 OID 0)
-- Dependencies: 216
-- Name: TABLE usuarios; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE public.usuarios TO usuario_consulta;


--
-- TOC entry 3383 (class 0 OID 16505)
-- Dependencies: 222 3387
-- Name: gastos_altos; Type: MATERIALIZED VIEW DATA; Schema: public; Owner: postgres
--

REFRESH MATERIALIZED VIEW public.gastos_altos;


-- Completed on 2023-04-09 23:42:13

--
-- PostgreSQL database dump complete
--

