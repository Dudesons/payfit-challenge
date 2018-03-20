CREATE DATABASE mattermost WITH OWNER postgres;

CREATE USER mattermost WITH password 'mattermost';
GRANT ALL PRIVILEGES ON DATABASE mattermost TO mattermost;

CREATE USER monitoring WITH password 'monitoring';
GRANT SELECT ON pg_stat_database TO monitoring;

CREATE USER backup WITH password 'backup';
GRANT ALL PRIVILEGES ON DATABASE mattermost TO backup;
ALTER USER backup WITH SUPERUSER;