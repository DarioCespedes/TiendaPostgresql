PGDMP         ,        	        {            vip    14.7    14.7 	               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    16533    vip    DATABASE     b   CREATE DATABASE vip WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Spanish_Colombia.1252';
    DROP DATABASE vip;
                postgres    false                        3079    16537    dblink 	   EXTENSION     :   CREATE EXTENSION IF NOT EXISTS dblink WITH SCHEMA public;
    DROP EXTENSION dblink;
                   false                       0    0    EXTENSION dblink    COMMENT     _   COMMENT ON EXTENSION dblink IS 'connect to other PostgreSQL databases from within a database';
                        false    2            �            1259    16534    usuvip    TABLE     ?   CREATE TABLE public.usuvip (
    id integer,
    fecha date
);
    DROP TABLE public.usuvip;
       public         heap    postgres    false                       0    0    TABLE usuvip    ACL     6   GRANT ALL ON TABLE public.usuvip TO usuario_consulta;
          public          postgres    false    210                      0    16534    usuvip 
   TABLE DATA           +   COPY public.usuvip (id, fecha) FROM stdin;
    public          postgres    false    210                x�3�4202�50�50����� ��     