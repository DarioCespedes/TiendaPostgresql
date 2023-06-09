PGDMP         ,        	        {            tienda    14.7    14.7 E    <           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            =           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            >           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            ?           1262    16405    tienda    DATABASE     e   CREATE DATABASE tienda WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Spanish_Colombia.1252';
    DROP DATABASE tienda;
                postgres    false            �            1255    16531    misegundopl()    FUNCTION     6  CREATE FUNCTION public.misegundopl() RETURNS trigger
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
 $   DROP FUNCTION public.misegundopl();
       public          postgres    false            �            1259    16441    compras    TABLE     �   CREATE TABLE public.compras (
    id integer NOT NULL,
    total numeric,
    "tipo de pago" character varying,
    id_usuario integer,
    producto integer
);
    DROP TABLE public.compras;
       public         heap    postgres    false            @           0    0    TABLE compras    ACL     H   GRANT SELECT,INSERT,UPDATE ON TABLE public.compras TO usuario_consulta;
          public          postgres    false    218            �            1259    16440    compras_id_seq    SEQUENCE     �   CREATE SEQUENCE public.compras_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.compras_id_seq;
       public          postgres    false    218            A           0    0    compras_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.compras_id_seq OWNED BY public.compras.id;
          public          postgres    false    217            �            1259    16521    conteousuarios    TABLE     s   CREATE TABLE public.conteousuarios (
    id integer NOT NULL,
    total integer,
    tiempo time with time zone
);
 "   DROP TABLE public.conteousuarios;
       public         heap    postgres    false            �            1259    16520    conteousuarios_id_seq    SEQUENCE     �   CREATE SEQUENCE public.conteousuarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.conteousuarios_id_seq;
       public          postgres    false    224            B           0    0    conteousuarios_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.conteousuarios_id_seq OWNED BY public.conteousuarios.id;
          public          postgres    false    223            �            1259    16414 	   empleados    TABLE     �   CREATE TABLE public.empleados (
    id integer NOT NULL,
    identificacion character varying,
    nombre character varying(50),
    sexo "char",
    id_tienda integer
);
    DROP TABLE public.empleados;
       public         heap    postgres    false            C           0    0    TABLE empleados    ACL     J   GRANT SELECT,INSERT,UPDATE ON TABLE public.empleados TO usuario_consulta;
          public          postgres    false    212            �            1259    16413    empleados_id_seq    SEQUENCE     �   CREATE SEQUENCE public.empleados_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.empleados_id_seq;
       public          postgres    false    212            D           0    0    empleados_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.empleados_id_seq OWNED BY public.empleados.id;
          public          postgres    false    211            �            1259    16423    gastos    TABLE     �   CREATE TABLE public.gastos (
    id integer NOT NULL,
    fecha date,
    descripcion character varying(50),
    valor numeric,
    id_tienda integer
);
    DROP TABLE public.gastos;
       public         heap    postgres    false            E           0    0    TABLE gastos    ACL     G   GRANT SELECT,INSERT,UPDATE ON TABLE public.gastos TO usuario_consulta;
          public          postgres    false    214            �            1259    16505    gastos_altos    MATERIALIZED VIEW     �   CREATE MATERIALIZED VIEW public.gastos_altos AS
 SELECT gastos.id,
    gastos.fecha,
    gastos.descripcion,
    gastos.valor,
    gastos.id_tienda
   FROM public.gastos
  WHERE (gastos.valor > (9000)::numeric)
  WITH NO DATA;
 ,   DROP MATERIALIZED VIEW public.gastos_altos;
       public         heap    postgres    false    214    214    214    214    214            �            1259    16422    gastos_id_seq    SEQUENCE     �   CREATE SEQUENCE public.gastos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.gastos_id_seq;
       public          postgres    false    214            F           0    0    gastos_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.gastos_id_seq OWNED BY public.gastos.id;
          public          postgres    false    213            �            1259    16501    letras_inicio    VIEW     �  CREATE VIEW public.letras_inicio AS
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
     DROP VIEW public.letras_inicio;
       public          postgres    false    212    212    212    212            �            1259    16450 	   productos    TABLE     ^   CREATE TABLE public.productos (
    id integer NOT NULL,
    descripcion character varying
);
    DROP TABLE public.productos;
       public         heap    postgres    false            G           0    0    TABLE productos    ACL     J   GRANT SELECT,INSERT,UPDATE ON TABLE public.productos TO usuario_consulta;
          public          postgres    false    220            �            1259    16449    productos_id_seq    SEQUENCE     �   CREATE SEQUENCE public.productos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.productos_id_seq;
       public          postgres    false    220            H           0    0    productos_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.productos_id_seq OWNED BY public.productos.id;
          public          postgres    false    219            �            1259    16407 
   sucursales    TABLE     �   CREATE TABLE public.sucursales (
    id integer NOT NULL,
    nombre character varying(50),
    correo character varying(50),
    direccion character varying(50)
);
    DROP TABLE public.sucursales;
       public         heap    postgres    false            I           0    0    TABLE sucursales    ACL     K   GRANT SELECT,INSERT,UPDATE ON TABLE public.sucursales TO usuario_consulta;
          public          postgres    false    210            �            1259    16406    sucursales_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sucursales_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.sucursales_id_seq;
       public          postgres    false    210            J           0    0    sucursales_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.sucursales_id_seq OWNED BY public.sucursales.id;
          public          postgres    false    209            �            1259    16432    usuarios    TABLE     �   CREATE TABLE public.usuarios (
    id integer NOT NULL,
    nombre character varying(50),
    celular character varying(50),
    compra numeric,
    id_sucursal integer
);
    DROP TABLE public.usuarios;
       public         heap    postgres    false            K           0    0    TABLE usuarios    ACL     I   GRANT SELECT,INSERT,UPDATE ON TABLE public.usuarios TO usuario_consulta;
          public          postgres    false    216            �            1259    16431    usuarios_id_seq    SEQUENCE     �   CREATE SEQUENCE public.usuarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.usuarios_id_seq;
       public          postgres    false    216            L           0    0    usuarios_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.usuarios_id_seq OWNED BY public.usuarios.id;
          public          postgres    false    215            �           2604    16444 
   compras id    DEFAULT     h   ALTER TABLE ONLY public.compras ALTER COLUMN id SET DEFAULT nextval('public.compras_id_seq'::regclass);
 9   ALTER TABLE public.compras ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    218    217    218            �           2604    16524    conteousuarios id    DEFAULT     v   ALTER TABLE ONLY public.conteousuarios ALTER COLUMN id SET DEFAULT nextval('public.conteousuarios_id_seq'::regclass);
 @   ALTER TABLE public.conteousuarios ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    224    223    224            �           2604    16417    empleados id    DEFAULT     l   ALTER TABLE ONLY public.empleados ALTER COLUMN id SET DEFAULT nextval('public.empleados_id_seq'::regclass);
 ;   ALTER TABLE public.empleados ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    211    212    212            �           2604    16426 	   gastos id    DEFAULT     f   ALTER TABLE ONLY public.gastos ALTER COLUMN id SET DEFAULT nextval('public.gastos_id_seq'::regclass);
 8   ALTER TABLE public.gastos ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    213    214    214            �           2604    16453    productos id    DEFAULT     l   ALTER TABLE ONLY public.productos ALTER COLUMN id SET DEFAULT nextval('public.productos_id_seq'::regclass);
 ;   ALTER TABLE public.productos ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    219    220    220            �           2604    16410    sucursales id    DEFAULT     n   ALTER TABLE ONLY public.sucursales ALTER COLUMN id SET DEFAULT nextval('public.sucursales_id_seq'::regclass);
 <   ALTER TABLE public.sucursales ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    209    210    210            �           2604    16435    usuarios id    DEFAULT     j   ALTER TABLE ONLY public.usuarios ALTER COLUMN id SET DEFAULT nextval('public.usuarios_id_seq'::regclass);
 :   ALTER TABLE public.usuarios ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    215    216            4          0    16441    compras 
   TABLE DATA           R   COPY public.compras (id, total, "tipo de pago", id_usuario, producto) FROM stdin;
    public          postgres    false    218   2M       9          0    16521    conteousuarios 
   TABLE DATA           ;   COPY public.conteousuarios (id, total, tiempo) FROM stdin;
    public          postgres    false    224   �M       .          0    16414 	   empleados 
   TABLE DATA           P   COPY public.empleados (id, identificacion, nombre, sexo, id_tienda) FROM stdin;
    public          postgres    false    212   N       0          0    16423    gastos 
   TABLE DATA           J   COPY public.gastos (id, fecha, descripcion, valor, id_tienda) FROM stdin;
    public          postgres    false    214   @X       6          0    16450 	   productos 
   TABLE DATA           4   COPY public.productos (id, descripcion) FROM stdin;
    public          postgres    false    220   ei       ,          0    16407 
   sucursales 
   TABLE DATA           C   COPY public.sucursales (id, nombre, correo, direccion) FROM stdin;
    public          postgres    false    210   �i       2          0    16432    usuarios 
   TABLE DATA           L   COPY public.usuarios (id, nombre, celular, compra, id_sucursal) FROM stdin;
    public          postgres    false    216   �u       M           0    0    compras_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.compras_id_seq', 11, true);
          public          postgres    false    217            N           0    0    conteousuarios_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.conteousuarios_id_seq', 6, true);
          public          postgres    false    223            O           0    0    empleados_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.empleados_id_seq', 181, true);
          public          postgres    false    211            P           0    0    gastos_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.gastos_id_seq', 201, true);
          public          postgres    false    213            Q           0    0    productos_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.productos_id_seq', 1, false);
          public          postgres    false    219            R           0    0    sucursales_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.sucursales_id_seq', 102, true);
          public          postgres    false    209            S           0    0    usuarios_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.usuarios_id_seq', 107, true);
          public          postgres    false    215            �           2606    16448    compras compras_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.compras
    ADD CONSTRAINT compras_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.compras DROP CONSTRAINT compras_pkey;
       public            postgres    false    218            �           2606    16526 "   conteousuarios conteousuarios_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.conteousuarios
    ADD CONSTRAINT conteousuarios_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.conteousuarios DROP CONSTRAINT conteousuarios_pkey;
       public            postgres    false    224            �           2606    16421    empleados empleados_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.empleados
    ADD CONSTRAINT empleados_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.empleados DROP CONSTRAINT empleados_pkey;
       public            postgres    false    212            �           2606    16430    gastos gastos_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.gastos
    ADD CONSTRAINT gastos_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.gastos DROP CONSTRAINT gastos_pkey;
       public            postgres    false    214            �           2606    16457    productos productos_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.productos DROP CONSTRAINT productos_pkey;
       public            postgres    false    220            �           2606    16412    sucursales sucursales_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.sucursales
    ADD CONSTRAINT sucursales_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.sucursales DROP CONSTRAINT sucursales_pkey;
       public            postgres    false    210            �           2606    16439    usuarios usuarios_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_pkey;
       public            postgres    false    216            �           2620    16532    usuarios mitrigger    TRIGGER     m   CREATE TRIGGER mitrigger AFTER INSERT ON public.usuarios FOR EACH ROW EXECUTE FUNCTION public.misegundopl();
 +   DROP TRIGGER mitrigger ON public.usuarios;
       public          postgres    false    225    216            �           2606    16493    compras compras_productos_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.compras
    ADD CONSTRAINT compras_productos_fkey FOREIGN KEY (producto) REFERENCES public.productos(id) NOT VALID;
 H   ALTER TABLE ONLY public.compras DROP CONSTRAINT compras_productos_fkey;
       public          postgres    false    220    3221    218            �           2606    16488    compras compras_usuarios_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.compras
    ADD CONSTRAINT compras_usuarios_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id) NOT VALID;
 G   ALTER TABLE ONLY public.compras DROP CONSTRAINT compras_usuarios_fkey;
       public          postgres    false    218    3217    216            �           2606    16478 !   empleados empleados_sucursal_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.empleados
    ADD CONSTRAINT empleados_sucursal_fkey FOREIGN KEY (id_tienda) REFERENCES public.sucursales(id) NOT VALID;
 K   ALTER TABLE ONLY public.empleados DROP CONSTRAINT empleados_sucursal_fkey;
       public          postgres    false    3211    212    210            �           2606    16473    gastos gastos_sucursales_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.gastos
    ADD CONSTRAINT gastos_sucursales_fkey FOREIGN KEY (id_tienda) REFERENCES public.sucursales(id) NOT VALID;
 G   ALTER TABLE ONLY public.gastos DROP CONSTRAINT gastos_sucursales_fkey;
       public          postgres    false    214    210    3211            �           2606    16483    usuarios usuarios_sucursal_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_sucursal_fkey FOREIGN KEY (id_sucursal) REFERENCES public.sucursales(id) NOT VALID;
 I   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_sucursal_fkey;
       public          postgres    false    210    216    3211            7           0    16505    gastos_altos    MATERIALIZED VIEW DATA     /   REFRESH MATERIALIZED VIEW public.gastos_altos;
          public          postgres    false    222    3387            4   �   x�E�A
�0D���a�e[�|���	!C!Ц=�.��|�@!`��DF�?m����{��j��:?��]�Ĕu��DE�R����,��f�n'�(4�Lm2Cesf6X�QL��QIe��[7�?��5:      9   A   x�-ɹ�0����ɧǨ���!ݵa�a�>K�U\�;��V%�Q_D�
w�:񨈼GL:      .   
  x�]��r7�����x��s�ī$kk��]�Z�ތ���5�QQtb����H]�rU4�p���'1e-�u7n���p;��8��i�Uj��?��M���a�q�<K��*-��}���a��5ܻ+}v%�RP������Eɫ륷�$��t;~���/N5�������w���i}�3�յ%�Ct�w����t�ۊo.ǐ�O��j��ٻa˒��[s
�}�2nn�}�:�yԼbK�O����������E\NU����{7m�Վ�DJ˕�G�|�y�w["�%q��	��#���dj�)H�����}����n��%϶R7ѓ&q��~7+$�Kq5���\������pPU�KuI[(RS����i��ں⥹���B��=V/�Ei�J����}��V�����\
��T�$�O_V������ךU�������7{e��e���+�~7�oo�de�7�i��DB���8n��ƖF3/�=R�ܛ��i~�|TG�qM+�����~�},�Eb5�Ź��h����	.���������v�}�S��
����Қ{s?�{�|
�w��)K�һ��l��=ER����~ۛ��竑�g�Ž��_�Í=�;�ĊV"��iR�)�r�^��_���ξ��O�<�r����S�X�}*�Jζ9��0=����N��m/�S)bwW�yu�h/->5�$h��Õ�G�c$��/�巚ǰ)�X81��8MO��>#Cʩ'��Ί����ȋ�����a���]����Z�Q�(�|��ֳ�39�����Z��t�Uɳ�SK%U�rE�܎_mE��`�R�$�d��>WW��Z5��OXR|n�&
��������
�H�d*�q6�_N��9Bb˹���I�=�@wVZ;ʹ+��������(��G�kb{8�ƭ�(�F��E)�j͖;��T����R��O��${�9k�-&/0��j�(P�ZQ��Nt����[o�!�>�ǃ�y�У�������q:�)�៉��ݣ�잳�f-[�apE�x��d )����"�$���dO�ʔ�K&	c��)��=�N��QGV1D�$I��[������`=R���,�R����f�R<2Ę�m,{��՗�B�%����z���<,�F[̗3�tO���Z�������\��R4�<���s�W�9���=��G���DSИ�u��kl�f$s�_�}%<"!N�1(O�2[��B���s����@))�BT����6GD��"KӦ�H�q|����xgB.͡\��F��X���){[��_D��U�s���>a���~9m��v�̈́Ѳ�{'Ki��n����$��Ȅ�T�օN�7*�:z����3w�{;lm�Ѕ�ߺA��_TO����ql���l�@8$�i*`tA����oqV����U�$]Z	���v��h�uد��>@F�M*[��z��0��	�#�opĜ�0zq��R`��~���,���{�F�	:7��Eg��zD�b�c��tѱ�0�)�i�>%�lz��c��=f�0b"�Ldc���feu/$�"t��xo}?�tҷT�3p
�[����0����Ă̛��SςLB2��R���Ā�1Is��S�\d�[�# d-=����(CB3�1I�!4A����*o&f^���.6����UO��6ؐD�b0��`Ѩ��m�m	uX��)Ws�� �r��ꖧ;`!\��1�Q݇��n�����Lۈ��q	���%���%(����R�s�t�,����Z3wX֗}M�O@?���S��(��%g��	m9��P >���5�kTw�G��b�;���K��,�yR�Q.����/��Y���ە����v�C��JE��a��z����Ȕ��d=��$���V�����8�)���V��?���j�H�0�
dyR������W+|~A%Bx�F�)��҅p�$�8�x ����X��I����"��g�`4[7-���J���h�s���NhNq��b��|D�1^�a+�u�����x`Y�;C�D�̾9`		G?�m�?/�X!�mĪ�@�bw;�A�67��y�������ډ=.��"J��]9O�2oܫa��t"Ы�9&q�X,|"�
-cׂDR��f�
�gp&���/p �ŊZ�!�c��|��,���e=$!h"|\ji�s�rdl2�!dY�s1�)b�紾;�	� ��s�5���#�>�	ǲ[R��]�K)!�@j����G!av3V�8C�?��@��Wљ2�4����y�~�<!��
���4��-�	�$~-=A���5x���qEm�@OX�`<��G ��e�4�a��d4=�����e@\�$��kC#ZPz���4�[ ����q:�0�)�Ȉ�������=���~M���X8�!T�IQ�Y&/3�W���-1�����1�:��h������|=�H����,fSG#�6ZQ�o��KG$��N�N��H���9uHƧ]��������1���Bv�CI��]�V53υ��6��j7��_':�@�j�U_��J���%���\	��H���rb��K�	���o���:�f|      0      x��Y[s�6�}&~_���ą����%�c�坩l�$�#�Tx����4HteR[�W��L��>��n�$�rq����+���rSn�6�y�e	g��ϒ�����.��6C�M�+Wo�~��V(<+�g�e^$׭w��2���C����
����!s�u����O]7��{�$R�"LM��K.�kו��໾IWn��D��$���9�7&�u��}�-��"��7��"��bE<K�|(M��<��ff���-7��׾m_�O�f�6�K�R:)��^ �?|�q�_��6�O��H����*�H���0�m�W��ͭw�}�H�Eb��C�e����z<��.�y!�1>���H�< my���]���}���	猋xR�|qU����M�/(�n��r �3.��#֧����S���O�~񧯪�%Qe��*�I$��6}j���N?4G��J�pɸ���yr�����]u��5I�bP�3��·���:�kN�Wo+�4���f|*���o�e�?M]�u��c�P�M�v����O�q~�=��=R�jd�sG�>4�k��nX�Ŋɯj|�ޣ )%��u/�65!cY��/d��ʕ5%�����I�U��D��dy>gE���T4o�ߦ�~���@��>�˒)ܕGIK���2�d�<�����z����6J�-,�%X��s�����+Q��4��:��MV�εx�fX�b��x�by�l�l�2�\#*��E[��C���($�
l�|�`�����h�-⥞�?�u�S�C$B+|�0�����j�E��~n��` ��|���о�#��Ez�#�����|���'�B7o���� ��x<�/7T��Qh�W�v��x�ș8c�)�[�� ,*��KL�@q�	�/m6M��ez$�zh�)�@2���֯�Q"��r�.|�K�Ԝ.�Zj�'*C(&�H���3��^&��xw ��z�w�:6�Z�&�`��f�g�zl6Pm3�H�k��fB�7�~��j돮E��e��Ȃ��n��g�S�à1��r����ydD�	h\e�g�2[+0 �"��Dd:pq���
��2��<�I����}�����N���Flwx^()�T3�`�U����ۋ�Tk-^J&u(OV�AP�+��U����R1Y���3h���6Ǥ��B4�4s�������)��k�1�U	�L���h���ۀ��{(7��0���QqEA�7�s�C�|��iȰe�����)���|�Ҙ�����������҅��]ER��7m5ZO)�_T9S2Vn@Hd;��3�"�ة�/ӧ}3t��#ɃM� %���"\�=���5h��*�� �_�f3ӱ����(�@e(͔�l47A���� �v�Bʡ��`*��&B%�p�������P�޷�
�Չ2LgsĈ�m�czE��}�H�� )����oDY���>4;|��r4�Θ�Mq~��.]�_�k��՜�w�}�k�A;�#�
~P!��~�HdP�3!R7%��I�7�j�Ɓ3kT���@0���?�0h"_A�V<!�*�Pv'_w���Y+����&y�QF�
Z��}���'Ӛ��.q8u)��M�>ȗ0 ]L۹ �����n�V���H�6�8���b?�����aU��k� y�djˊ3X��"�C�`sx�{��b'V�EƊ^�y�@W�m������Q���w��5$����Y!ߑ�p��m0C�}��ۅ_�{J
��Ȉ��������ĺh!$�����@>��M��ֻ�s�������������ϭ;���Q�Q�x��P�|�~JWm��o��P5E���|`��`�gb�f;l�%��0�d��er����w !g`��2��E�@�0tz�;�>���ɘ9��n@
Z괇�9�8��pf�ܺ���f�E�<9�N���zU�3#�'��[��r���@�F0����T����/7��\K�^mG�3�7F2��?BE<��凉�s��b&zzhz�����a�
��M`��N`Q� �6�T����_%|$��ع���!�R0" �����<rn���yd�:p	t�� ���Y߅~��U�|[�=��c�1��g-�'�1��~�݈���w ��7G��J,gV��K�6{����Į�~�8b�A�3�[�QlA2
.�
f�\~H�� �z'��|����������X�l1#@��)�_h��F&���J;L�}��5���E��؁�}�R�Q�X��v���op69��&�lYA�,��Đľo�8����F��D�>s�Oܮ,@
x+�1v��z�l��|�m�pP��PJ��YT5�%�i0���d��,���
˘���W��uo)�ߧiLjk�L��P1����@l�IJ�z���q�@�S�l�9:��������հ��y;7�!��Y��i�-ޕ?�W�{�=T�t��6R@�;�HzI��{���	P"���A�uV<Q�79�8CQi��?�U���6!עB�2�$�F��q ��	���iAXwe]vԌ�Hn܆��͓񈘶=Q&��q����@.��na@�	�5�[*�3z���<(n�v |aFx��f��8V�#�>d^�V/j _����@�f�A���X~�ɂRga1�#������{�<��!<��+�+����!x�R�f;0N9� �L/d<_��q�a�L�3�A�� �<zPg%�C-��V"|މ���^XJZŀy�
MnH��:�ƍ,�h^�1e���9��KG~Z����r; E��HhZ�ia��`I�E�C5D.�� ͣ�?����� ث!�m��$"'�H��^��I%Z#�=�-L0ԁ�h�+��2?�����\r�f �y�B]�C3A��u�b�= �hg��Cy�Qҧѱ�P����?3�L���J���qUIv�ihO@
\ֻ��$} U,܍��ގN�`#����J0�-$��8n]�փ^��
�� �bѢf6�Cwhnd���B4��9�X�ef��M.�Kz'�,�t�
�ؗo��Ӛ�ņ.�!�޼e����5ɗ)�7Z�l�
)��E�7-��0�w�
a0H@x޳�\ ��7��
b�y�JM�.��?;ԇ�+�?0#\4*i�,#[�J���$�{�~p�����I�*���4���2� �BIZ�p�X?�ۄ�␀TF��������{p;�{�	��H�:�a4�Jh�e���,���T)z�Վ�vvv�� ��� �"��Z�yV򏯁�º�&��z���%�J����ɇ#Ҵ���-���jq�#�}������FQ��UqM����&W>~�>�Wtm�X?��O4J�;6
h��X�� �S�k^�:v��k�-�Ի��A��n���
��04/�d��Ͱ�C�0 Z�\&������WƸ��y��|���^��P�0�u����,x _�Np�b��s-a5`�W��w�)P5�E`!ɋ�n�:6^NCSY� VU�
:���¯��=G��N�����<l[��nQ��7��Q���yÆL���ק�1�}�T%��+&�t����.���4�9���/ז�/\ǻZ��$�n\���-�6�:�h�i4���1�Ч�Ox1~nK��ݾ����5�-�Tar�7�y�n���z��Di \�����DD�'�䴘��b��p�el�g�ؾ[��
 ZDDQ���z��}M�/&��-�\.g���~!p�@��Y6�Z�j��|���tڪA@W�T:\ �yE.��	����3��:yA�ʋ�k�#9�uX��Pyh��E�������]�H>�������<J"-mhx/�hl)���i
ChZ[F�-SsV���G�n�kn"�u�o�t���v�?d�@4q��{y�%3
�aF�~��4<������/��a8M��(���9�!�WG�b���!�c�����5��
��+�q�W`�ǧP3zYA�ep���<!9]6X2�p� ����ab���H���x^��#�e�6��w�Ȳ>��f=T]k   ��洹��ꦠ�}�i�2-$ݑ��:�� �ysF݅�����_�Ï��I�lt5ƴ�F���	�L��-�7�zDᶞ�B[AKn#~��;��v�	6��niY�m��y����vpI��<�@�˛`zn~��C�a�]�Z ic��D^-(��Wb�*�� .7�N�Ӏ�<|��W "�@ƽ��[	�!�[5�÷)gp  }K���,��� ��8���8C��r�X8*k���N�և��f���7�2ɰ����d��$���      6   W   x��9
�@���1�}�b�᚛8� ;0��z�*�W�X%�%a���>��<��xT�س&�E�4����(�$�*�e}-�(H�1��      ,   �  x�]X�v�6|F :�|��,3����Or�$�$� � `��_?�-�y�-�]���%%?+���?Xg���H/��:i4=������s{�����q�z���U��m%֍\)sd^t�6�{�-hF��Mw6����r�o��g29q嶧l�R=؅T9M>��[����9��CA�Zsu�U�%�2z8ۧ��3�?hy�k�(K>�y�-_��ܞ%�<�e�$����4�B�~���됂j�x<�Y�~�M�?T�*�3o�l<9u܏�̙�va�AO��&�x�9���;�"j��.!�[�R�ҍS��&\=l%o�����}��á!��ς<�fU�d#����t5��P�c����"�"�5T�z$��uji�iQW�+�[O�4�Š;�����8w�����\�s�\�ªW�y;�fu�%�Fˎ'���@S�#~J��$��h�0?�*[hY�HǍH�����S-#"Dk��,Uke/8��M*�PF���U�M�gamL&'o��2�EhZ�:L�y��xW�6��/3z9Y�Og9��ĵ|TC���
��]9\�3�q�%�c5+��mȤg�l+�J��cY'o��
HZ����:�<�vJj�[���ˊU�i�zuH��
5p߶��ݝ��wF�����z���(J�F)�h쇲��k�*������o:�y�q�z�$=�y.��G0�X��1�^��)�.���<����Ґ�e!jF�BI&��8!�8��4�4��;/�\�^pU���W���;�;:�w�~<D�ih�y>��_6qh�*O������<_F˵b���lwd9/V($�X�*���l}/ńIA��iD��"*B����!�@l"��	����`.|A}��1��x��"?	џB�EJ������� ��o��,�eK�&�儃d8��̖��v��x�{:��Fڠ+Z������j�󲥎�E�]L�#�4"r�a	o��{�x?I�d$�����}��e�|W��(A�� ql��[T�l���/|nץ,%����E�F)���-�"����E�.����l�:�B�,#���#�6r�t�>ra�
��MsL��x�M�94�B�vߤ�0���&�.���B-�Od+�����崓9�y�����>["!{	l�~fܝ7x!��_��CV�/�K� -Z�2>�[�a9�,/�O��������+�G�V2]�`��7�9��C���o����2�OQ�̀�Ũe��E�d��0\��oXΏa��8y�4��R歜y��M��I�_��O�G��CN�̢�@��,��)���X.�䑯�����)��!]�jA3�K9���<�`����C�W�3�`SlA@Y�L�Ub��wD��=W`���m2�v[���r�����v�B9��7�dap���5iS�T���$W;��2�2��Iz+����6�%�'G���~��y.ߤ!aA~�5�J���6̪
��DO_3�ɻ���AHHR|��8u:�茣E�ۤ�~f�̈�����[�>�
�!Yo�#xѐ�HދL�J�cV�2�=����pj9��aЪH� � g�����"�,��+����"%�q#f ڥ�g�0�S���ӑT��Qd�qxp�bC�k%f��}�}�Q�f �r�n�y`�*1��	�c)$v����gS��ҙ[Ȥ�t`� `;�ҭ��0�(AA@:r���p|����X%��z�wQx-��
&B7�����y�_��D��n�,mw��q���&ì��U�A��H�x��s�l��"��^E�<�֫�ٕG�(�B��br�"�9X�&h^����"%%�B����Nl���x+�2b6��Lɇ�x�.�-
բ��E�4x��A�H��^fa�+�G�p�(1/�oK�yK�~$'�G�_'��Lg=��s��,�w�uP���eqWfxӡ1�o��q��
X�#����$?F	�Z�L��R˴�:��V�F�L�]7oUb�X�Z��L�	����d�w�:�P.���$���>�n�	��ߦ�$O��7F1N��٧�.�ܞ�]:N�l+u�a\Bϸ�^Y__JG����yk<�6l+Z&?-�}��+\�bs�z�Ue�Wze���M)�ΣwY�/S'�1��(�Ӌ("���F�*#�Ar���QHX�q0�j���F�`��q]	���n,
�+�N�u14Q�ݪ��w��d�J?�b�ګhw���۰	7�2�~]`��Qp �L���q��AYO"�^�
��x��i6�9
&|�a�_Ձ��obկxK�Ŵu�{����`у}U� �M�++$ڭi���U�>�c�`�QI�0�z�c��ws�k�y���àKK5̲�b��c��7�ś��X75Huvi��~�B�*l��ݒ���Ik�ɥ����ߛ�*�<F/�w&�������������wZ��Y���uqߎ]��=���`�� \y�F���"��$�YB'[GFڲ:�p�&��{�"�Bl^Z��mڱiu3Z�i/H`�޼W]C�/FO�ѝ�P �X����	˝�;	����ol��eYg�5��ϡ��-1��7�&��5>�������%Ki8������8DJ~���6ŧ��p�w�÷D�"l��f8��^�X?��:L�:���4Yt�m�@#@"���l�'@�^(�a{�&�'(P��gM���{�����|4x��F���!}�@,���g��/D�@=����e+������9�H�nK(E�7s��	�A0��Mh�N���0�{�c�kMHH�[�>���"^P�k�:�2h�.!�P�0��g�h��6M\x���'C�[�V������qĮ`��C�\��>2�Ό[	�����m�I�����������U�7f��e�۩�e���ǰ.��!��h�s����㲩/�Œa������������      2   �  x�U��R[GE����?0��_�8��jWŕ�C8�b�C���_��$�j�9��/�wO���ߵ��z��	5��r{q��r>݉Ϯ��bn�ӠI~\N%'7Ju>�,L�w��f����]�ͅ�$IZ���b���]���d�Z���n�{ڞI����]�mr2_]�,�;1W-��C�*U��z=�'��~5vi�tp����յ��z/8LQ�t^����f=]I���B �!CC���ח�������� ^C������Fjt�=U�@����j~�)���G	f����-��Ӵ���X9L��"�e=�J.%JFX��P�*6Y4�KT0M�/���jm�x�R��=�LI�P9�=�s��1�9�dG$�HT|ҕ�|���Vg�rL��V�-��30龸�I	X􊗧�=�N���T�S���&G ![��t�^-w$O.��(R4�x��.-a��*?O�}�"6
�3��il������;�j��f'S(�Î��6�ǆG�i���=]m�V��]���:����y�:�w2���_
a ���Y6�\V�I�iNY�$���ô��k��V.-E�$f)�	�8�J7<��)�g�Yn�3�! R�T`��jsO�'h��n̚�|�H]��\��
�S���R��%�:\,���i�6��j�.�b���iX�(c���4����e�w[}z�33������[���e�<u�+�i��f��o�k̐o��͔>>-�
bc@d�&��A�݅RA%Ls���|�>L�B+�5�((ge�_2τC�4F�z��Es#���=��gi�UHTI��f��y{�(�+�[;=���/f��>�7o!�+L:��ɔ���8Z�Q���I�����yi���z�JLKz�e�G2�qg1SH�����JI��US���8��(&��d-��z��t���f�"�	<3	�-���*CM��؁�j�ᶌ�N�(�Ҵ0a{��l���z�}T|��yl<��A�Ci�Ars��A˝��1E�~���Ww����S��tP�S�6Q�m1e��~�2J���Lk9l�������ê�l.�}%�0�cf��E���f�E[c8<\e�ժ�˫����sJ`�S@ �)�O[�i$�
�tL2����l��f��r���$T��vq��XL����Ӳ>�O��_A���󁣨cC�s�Z@-j���s
��pTK��QpQ�R=�Բ��o���z�72et�D Lc�?��l�����`��q,`p��-R�f���ᔝS#C�i8�ֵ�2[>��7�h"���LPC{x�<!Z�#>`��M�L�Ehx�f
՞+�3�)O7S������a��I�q�����r��~)?���ef��EY�DE�"�(�e�� ��Uј%�F�|ߛ2�o��YA�	��J�E]Q駮p`��,�>R<��� ��dqfx�
�ӥf�$>A�ʁ�͵CxE�XLG޿MI�LR�g�)��v>{!�
��dL)��±X�����E�3!Bo��"b�F�я��ď��)�)y�b_T���+1������ݞ��N`��#[��r5�6���w��p��?Da/.8�v3O�������o_~����_�c�?����c�\oo�Ӊ`����W}<ˏg�;��Ɉ<5;�i0r�__���D�     