# Database Script
#### for "Bogreden" assignment

### Requirements

* MySQL Workbench 8.0 CE
* MySQL Shell

### How to use

This [folder](https://github.com/rgammelby/H2/tree/main/Databaser/Online%20Boghandel) contains all relevant files;
* [assignment](https://github.com/rgammelby/H2/blob/main/Databaser/Online%20Boghandel/Online%20Boghandel.pdf),
* [scripts](https://github.com/rgammelby/H2/tree/main/Databaser/Online%20Boghandel), 
* [import](https://github.com/rgammelby/H2/blob/main/Databaser/Online%20Boghandel/postnumre.csv), 
* [diagram](https://github.com/rgammelby/H2/blob/main/Databaser/Online%20Boghandel/boghandel%20revised.svg), 
* [stored procedures index](https://github.com/rgammelby/H2/blob/main/Databaser/Online%20Boghandel/stored%20procedures%20index.md).

In principle, it is only necessary to run the `database_script.sql` script. This script contains all that is contained within `storedprocedures.sql` and `triggers.sql`. It was my plan, initially, to call several other scripts from a Main script, if you will. I learned that this is impossible. 

In lieu of that, I've allowed for the user to be able to execute each script individually, as I'd've originally preferred, or you can run everything in a correctly ordered mother-script. 

### Prerequisites
The only prerequisites for running the script successfully are a database connection and correct placement of the `postnumre.csv` file.

#### Successful connection

Since creating a user on your database requires a connection, you should first connect as the root user with the shell command:

`\connect -u root -p`

When the database creation script or the complete script is run, an admin with all privileges will be created as `'admin'@'localhost'` identified by (with password): `admin`.

#### Import placement

MySQL has fairly strict import requirements - one of those being that the imported data must be placed in a specific folder located, on my machine/OS, at path: `C:/ProgramData/MySQL/MySQL Server 8.0/Uploads`.

Please note that despite running Windows, the path must be written with forward slash `/` rather than the standard for Windows backslash `\`. Otherwise, the script will not run.

### Execute order

If you choose to execute the individual scripts via shell, they should be executed in this order:
1) `databasecreation.sql`
2) `tablecreation.sql`
3) `triggers.sql`
4) `storedprocedures.sql`
5) `dummydata.sql`

Note, that if you choose to execute the `complete.sql` file instead, procedure calls to test stored procedures exist under a comment at the bottom of the page.
