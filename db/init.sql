CREATE TABLE IF NOT EXISTS radcheck (
    id SERIAL PRIMARY KEY,
    username VARCHAR(64) NOT NULL,
    attribute VARCHAR(64) NOT NULL,
    op VARCHAR(2) NOT NULL DEFAULT ':=',
    value VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS radreply (
    id SERIAL PRIMARY KEY,
    username VARCHAR(64) NOT NULL,
    attribute VARCHAR(64) NOT NULL,
    op VARCHAR(2) NOT NULL DEFAULT '=',
    value VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS radusergroup (
    id SERIAL PRIMARY KEY,
    username VARCHAR(64) NOT NULL,
    groupname VARCHAR(64) NOT NULL,
    priority INTEGER NOT NULL DEFAULT 1
);

CREATE TABLE IF NOT EXISTS radgroupreply (
    id SERIAL PRIMARY KEY,
    groupname VARCHAR(64) NOT NULL,
    attribute VARCHAR(64) NOT NULL,
    op VARCHAR(2) NOT NULL DEFAULT '=',
    value VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS radacct (
    radacctid BIGSERIAL PRIMARY KEY,
    username VARCHAR(64),
    nasipaddress INET,
    acctstarttime TIMESTAMP NULL,
    acctupdatetime TIMESTAMP NULL,
    acctstoptime TIMESTAMP NULL,
    acctsessiontime BIGINT,
    acctinputoctets BIGINT,
    acctoutputoctets BIGINT,
    callingstationid VARCHAR(64),
    framedipaddress INET
);

INSERT INTO radcheck (username, attribute, op, value)
VALUES ('testuser', 'Cleartext-Password', ':=', 'test123');

INSERT INTO radusergroup (username, groupname, priority)
VALUES ('testuser', 'employee', 1);

INSERT INTO radgroupreply (groupname, attribute, op, value)
VALUES
('employee', 'Tunnel-Type', '=', 'VLAN'),
('employee', 'Tunnel-Medium-Type', '=', 'IEEE-802'),
('employee', 'Tunnel-Private-Group-Id', '=', '20');
