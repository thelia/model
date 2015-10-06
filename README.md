# Thelia 2 MySQL Workbench database model

The `thelia2_model.mwb` file contains the complete Thelia 2 database model.

If you want to generate the Propel `schema.xml` file, please install MySQL Workbench PropelUtility plugin from the PropelUtility folder, which contains a fixed version of [PropelUtility](https://github.com/mazenovi/PropelUtility). You can then use the Export tab to generate the `schema.xml` file. 

Please note that you **have to** add the following lines in the generated file, just after the `<database defaultIdMethod="native" name="thelia">` line :

```xml
  <vendor type="mysql">
    <parameter name="Engine" value="InnoDB"/>
    <parameter name="Charset" value="utf8"/>
  </vendor>
```

From this `schema.xml` file, Thelia will generate the database schema SQL initialization files, and the Propel ORM classes and tools

## Initializing database and classes

Be sure that your already have a configured database, if not, run:
```bash
$ php Thelia thelia:install
```

If the database access is configured, your can use the `reset_install` script that will do all the work for you, and generate data using the Thelia faker.

If you're using Linux or Mac OS:
```bash
$ ./reset_install.sh
```
If you're using Windows:
```batch
C:\path-to-thelia> reset_install.bat
```

Please note thant all your database content will be erased and replaced with test fake data.

