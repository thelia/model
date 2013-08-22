THELIA 2 DATABASE STRUCTURE
==================

Mysql workbench and sql files.

Thelia 2 use Propel ORM. If you want to see propel behavior configuration install [PropelUtility](https://github.com/mazenovi/PropelUtility)

How to generate Model and SQL files ?
Once the schema.xml generated via MySQL Workbench - plugin PropelUtility.
Copy/Past the schema.xml file to the folder /local/config/
Then run in command line :
$ cd local/config/
$ ../../bin/propel build --output-dir=../../core/lib/
$ ../../bin/propel sql:build --output-dir=../../install/
