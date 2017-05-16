SET statement_timeout = 0;
SET lock_timeout = 0;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

-- Name: plpgsql; Type: EXTENSION

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;

-- Name: EXTENSION plpgsql; Type: COMMENT

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

-- Name: addresses; Type: TABLE

CREATE TABLE addresses (
    id BIGSERIAL PRIMARY KEY,
    user_id bigint NOT NULL,
    postal_code character varying NOT NULL,
    prefecture character varying NOT NULL,
    city character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

-- Name: admin_users; Type: TABLE

CREATE TABLE admin_users (
    id BIGSERIAL PRIMARY KEY,
    user_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

-- Name: ar_internal_metadata; Type: TABLE

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

-- Name: comments; Type: TABLE

CREATE TABLE comments (
    id BIGSERIAL PRIMARY KEY,
    post_id bigint NOT NULL,
    user_id bigint NOT NULL,
    body text NOT NULL,
    deleted_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

-- Name: information; Type: TABLE

CREATE TABLE information (
    id BIGSERIAL PRIMARY KEY,
    title character varying NOT NULL,
    body text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

-- Name: post_tags; Type: TABLE

CREATE TABLE post_tags (
    id BIGSERIAL PRIMARY KEY,
    post_id bigint,
    tag_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

-- Name: posts; Type: TABLE

CREATE TABLE posts (
    id BIGSERIAL PRIMARY KEY,
    user_id bigint NOT NULL,
    title character varying NOT NULL,
    body text NOT NULL,
    deleted_at timestamp without time zone,
    comment_count integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

-- Name: schema_migrations; Type: TABLE

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);

-- Name: tags; Type: TABLE

CREATE TABLE tags (
    id BIGSERIAL PRIMARY KEY,
    value character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

-- Name: users; Type: TABLE

CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    name character varying NOT NULL,
    birth_date date,
    gender integer,
    description text,
    image character varying,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    confirmation_token character varying,
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);

-- Name: index_addresses_on_user_id; Type: INDEX

CREATE UNIQUE INDEX index_addresses_on_user_id ON addresses USING btree (user_id);

-- Name: index_admin_users_on_user_id; Type: INDEX

CREATE UNIQUE INDEX index_admin_users_on_user_id ON admin_users USING btree (user_id);

-- Name: index_comments_on_post_id; Type: INDEX

CREATE INDEX index_comments_on_post_id ON comments USING btree (post_id);

-- Name: index_comments_on_user_id; Type: INDEX

CREATE INDEX index_comments_on_user_id ON comments USING btree (user_id);

-- Name: index_post_tags_on_post_id; Type: INDEX

CREATE INDEX index_post_tags_on_post_id ON post_tags USING btree (post_id);

-- Name: index_post_tags_on_post_id_and_tag_id; Type: INDEX

CREATE UNIQUE INDEX index_post_tags_on_post_id_and_tag_id ON post_tags USING btree (post_id, tag_id);

-- Name: index_post_tags_on_tag_id; Type: INDEX

CREATE INDEX index_post_tags_on_tag_id ON post_tags USING btree (tag_id);

-- Name: index_posts_on_user_id; Type: INDEX

CREATE INDEX index_posts_on_user_id ON posts USING btree (user_id);

-- Name: index_tags_on_value; Type: INDEX

CREATE UNIQUE INDEX index_tags_on_value ON tags USING btree (value);

-- Name: index_users_on_confirmation_token; Type: INDEX

CREATE UNIQUE INDEX index_users_on_confirmation_token ON users USING btree (confirmation_token);

-- Name: index_users_on_email; Type: INDEX

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);

-- Name: index_users_on_reset_password_token; Type: INDEX

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);

-- Name: admin_users fk_rails_c4f75db4e4; Type: FK CONSTRAINT

ALTER TABLE ONLY admin_users
    ADD CONSTRAINT fk_rails_c4f75db4e4 FOREIGN KEY (user_id) REFERENCES users(id);

-- Name: post_tags fk_rails_c9d8c5063e; Type: FK CONSTRAINT

ALTER TABLE ONLY post_tags
    ADD CONSTRAINT fk_rails_c9d8c5063e FOREIGN KEY (tag_id) REFERENCES tags(id);

-- Name: post_tags fk_rails_fdf74b486b; Type: FK CONSTRAINT

ALTER TABLE ONLY post_tags
    ADD CONSTRAINT fk_rails_fdf74b486b FOREIGN KEY (post_id) REFERENCES posts(id);

-- PostgreSQL database dump complete

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20170416105333'),
('20170416112639'),
('20170416113641'),
('20170416114803'),
('20170427015255'),
('20170427015322'),
('20170427121448'),
('20170509053650');

