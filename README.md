THELIA 2 DATABASE STRUCTURE
==================

Mysql workbench and sql files.

Thelia 2 use Propel ORM. If you want to see propel behavior configuration install [PropelUtility](https://github.com/mazenovi/PropelUtility)

How to generate Model and SQL files ?
Once the schema.xml generated via MySQL Workbench - plugin PropelUtility.
Copy/Past the schema.xml file to the folder /local/config/
Then run in command line :
$ cd local/config/

Build Models
$ ../../bin/propel build -v --output-dir=../../core/lib/
Build SQL CREATE TABLE file
$ ../../bin/propel sql:build -v --output-dir=../../install/
Insert SQL
$ ../../bin/propel insert-sql -v --output-dir=../../install/
// Not working : insert manually
install/thelia.sql
install/insert.sql

Install Fixtures
$ php ../../install/faker.php
