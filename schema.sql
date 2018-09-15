DROP TABLE employees CASCADE;
DROP TABLE clients CASCADE;
DROP TABLE cases CASCADE;
DROP TABLE tasks CASCADE;
DROP TABLE docs CASCADE;
DROP TABLE case_assignments CASCADE;
DROP TABLE task_assignments CASCADE;
DROP TABLE task_docs CASCADE;


CREATE TABLE employees (
	employee_id	BIGSERIAL PRIMARY KEY,
	name	TEXT	NOT NULL,
	description	TEXT,
	email TEXT UNIQUE
);

CREATE TABLE clients (
	client_id	BIGSERIAL		PRIMARY KEY,
	name	TEXT NOT NULL,
	description TEXT,
	email TEXT UNIQUE
);

CREATE TABLE cases (
	case_id		BIGSERIAL PRIMARY KEY,
	client_id	BIGINT	REFERENCES clients ON DELETE CASCADE,
	title	TEXT,
	description	TEXT,
	started	TIMESTAMP WITH TIME ZONE,
	UNIQUE (client_id, title)
);

CREATE TABLE tasks(
	task_id	BIGSERIAL PRIMARY KEY,
	case_id	BIGINT REFERENCES cases ON DELETE CASCADE,
	title	TEXT,
	description	TEXT,
	status TEXT,
	estimated_hours	INTERVAL,
	billed_hours INTERVAL,
	completed_timestamp	TIMESTAMP,
	depends_on	BIGINT REFERENCES tasks ON DELETE CASCADE,
	UNIQUE (case_id, description)
);

CREATE TABLE task_assignments (
	assignment_id BIGSERIAL PRIMARY KEY,
	employee_id	BIGINT REFERENCES employees ON DELETE CASCADE,
	task_id BIGINT REFERENCES tasks ON DELETE CASCADE
);

CREATE TABLE case_assignments (
	assignment_id BIGSERIAL PRIMARY KEY,
	employee_id	BIGINT REFERENCES employees ON DELETE CASCADE,
	case_id BIGINT REFERENCES cases ON DELETE CASCADE
);

CREATE TABLE docs(
	doc_id BIGSERIAL PRIMARY KEY,
	title TEXT NOT NULL,
	doc_text TEXT,
	case_id BIGINT REFERENCES cases ON DELETE CASCADE,
	location TEXT NOT NULL
);

CREATE TABLE task_docs(
	task_id BIGINT references tasks ON DELETE CASCADE,
	doc_id BIGINT references docs ON DELETE CASCADE,
	PRIMARY KEY(task_id, doc_id)
);


grant all privileges on schema public to redash;
grant all privileges on all tables in schema public to redash;
grant all privileges on all sequences in schema public to redash;