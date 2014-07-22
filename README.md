THELIA 2 DATABASE STRUCTURE
==================

Mysql workbench and sql files.

Thelia 2 use Propel ORM. If you want to see propel behavior configuration install [PropelUtility](https://github.com/mazenovi/PropelUtility)

Thelia allows you to generate your sql files, insert it install fixtures and create an admin for you.

First, edit your ```local/config/schema.xml``` file.

Then be sure that your already have a configured database, if not, run:
```bash
$ php Thelia thelia:install
```

After, your may use the reset_install script that will do the work for you.
If you work on Linux/Mac OS:
```bash
$ ./reset_install.sh
```
If you work on Windows:
```batch
C:\path-to-thelia> reset_install.bat
```

You finally have an updated database, with a new admin: thelia2 with the password: thelia2
