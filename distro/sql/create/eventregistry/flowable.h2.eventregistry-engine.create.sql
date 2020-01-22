
CREATE TABLE FLW_EV_DATABASECHANGELOGLOCK (ID INT NOT NULL, LOCKED BOOLEAN NOT NULL, LOCKGRANTED TIMESTAMP, LOCKEDBY VARCHAR(255), CONSTRAINT PK_FLW_EV_DATABASECHANGELOGLOCK PRIMARY KEY (ID));

DELETE FROM FLW_EV_DATABASECHANGELOGLOCK;

INSERT INTO FLW_EV_DATABASECHANGELOGLOCK (ID, LOCKED) VALUES (1, FALSE);

UPDATE FLW_EV_DATABASECHANGELOGLOCK SET LOCKED = TRUE, LOCKEDBY = '192.168.10.1 (192.168.10.1)', LOCKGRANTED = '2020-01-19 20:34:30.176' WHERE ID = 1 AND LOCKED = FALSE;

CREATE TABLE FLW_EV_DATABASECHANGELOG (ID VARCHAR(255) NOT NULL, AUTHOR VARCHAR(255) NOT NULL, FILENAME VARCHAR(255) NOT NULL, DATEEXECUTED TIMESTAMP NOT NULL, ORDEREXECUTED INT NOT NULL, EXECTYPE VARCHAR(10) NOT NULL, MD5SUM VARCHAR(35), DESCRIPTION VARCHAR(255), COMMENTS VARCHAR(255), TAG VARCHAR(255), LIQUIBASE VARCHAR(20), CONTEXTS VARCHAR(255), LABELS VARCHAR(255), DEPLOYMENT_ID VARCHAR(10));

CREATE TABLE FLW_EVENT_DEPLOYMENT (ID_ VARCHAR(255) NOT NULL, NAME_ VARCHAR(255), CATEGORY_ VARCHAR(255), DEPLOY_TIME_ TIMESTAMP, TENANT_ID_ VARCHAR(255), PARENT_DEPLOYMENT_ID_ VARCHAR(255), CONSTRAINT PK_FLW_EVENT_DEPLOYMENT PRIMARY KEY (ID_));

CREATE TABLE FLW_EVENT_RESOURCE (ID_ VARCHAR(255) NOT NULL, NAME_ VARCHAR(255), DEPLOYMENT_ID_ VARCHAR(255), RESOURCE_BYTES_ BLOB, CONSTRAINT PK_FLW_EVENT_RESOURCE PRIMARY KEY (ID_));

CREATE TABLE FLW_EVENT_DEFINITION (ID_ VARCHAR(255) NOT NULL, NAME_ VARCHAR(255), VERSION_ INT, KEY_ VARCHAR(255), CATEGORY_ VARCHAR(255), DEPLOYMENT_ID_ VARCHAR(255), TENANT_ID_ VARCHAR(255), RESOURCE_NAME_ VARCHAR(255), DESCRIPTION_ VARCHAR(255), CONSTRAINT PK_FLW_EVENT_DEFINITION PRIMARY KEY (ID_));

CREATE UNIQUE INDEX ACT_IDX_EVENT_DEF_UNIQ ON FLW_EVENT_DEFINITION(KEY_, VERSION_, TENANT_ID_);

CREATE TABLE FLW_CHANNEL_DEFINITION (ID_ VARCHAR(255) NOT NULL, NAME_ VARCHAR(255), VERSION_ INT, KEY_ VARCHAR(255), CATEGORY_ VARCHAR(255), DEPLOYMENT_ID_ VARCHAR(255), CREATE_TIME_ TIMESTAMP, TENANT_ID_ VARCHAR(255), RESOURCE_NAME_ VARCHAR(255), DESCRIPTION_ VARCHAR(255), CONSTRAINT PK_FLW_CHANNEL_DEFINITION PRIMARY KEY (ID_));

CREATE UNIQUE INDEX ACT_IDX_CHANNEL_DEF_UNIQ ON FLW_CHANNEL_DEFINITION(KEY_, VERSION_, TENANT_ID_);

INSERT INTO FLW_EV_DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('1', 'flowable', 'org/flowable/eventregistry/db/liquibase/flowable-eventregistry-db-changelog.xml', NOW(), 1, '7:0aaa7b01343f4cdaf1019cd2de3f98f3', 'createTable tableName=FLW_EVENT_DEPLOYMENT; createTable tableName=FLW_EVENT_RESOURCE; createTable tableName=FLW_EVENT_DEFINITION; createIndex indexName=ACT_IDX_EVENT_DEF_UNIQ, tableName=FLW_EVENT_DEFINITION; createTable tableName=FLW_CHANNEL_DEFIN...', '', 'EXECUTED', NULL, NULL, '3.5.3', '9462470201');

UPDATE FLW_EV_DATABASECHANGELOGLOCK SET LOCKED = FALSE, LOCKEDBY = NULL, LOCKGRANTED = NULL WHERE ID = 1;
