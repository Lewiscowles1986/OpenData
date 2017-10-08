# Companies House OpenData

## Auto-download, unpack, ETL to SQL

### Running

`time bash run.sh`

### Requirements

* *nix shell (`bash` or fully-compatible shell recommended)
* `unzip` command or alias
* `wget` command or alias
* `sqlite3` binaries present within `PATH`
* (optional) time utility to verify runtime

### Config

The following variables can be overwritten by the environment for simple deployment within Docker, Vagrant or similar pre-packaged environment.

Sane defaults are provided and noted below:

* `ARCHIVEFILE` - the name of the zip file to download and extract from companies house
* `INNERFILE` - the name of the file within the zip file (used to generate SQL script)
* `DBFILE` - the name of the sqlite database file
* `WORKDIR` - the working directory for temporary files & the output db file to be placed in

### Cleaning up

*Assuming you use the default `/tmp` folder as working directory

```
sudo rm /tmp/companies.db
sudo rm /tmp/BasicCompanyDataAsOneFile*.csv
sudo rm /tmp/BasicCompanyDataAsOneFile*.zip

```

### Troubleshooting

Looks like someone allowed output a backslash in at least one record (line 285689) `sudo head -n 285689 companydatafixed.csv | tail -1`. This can be fixed by using `sed -re  's/\\\",\"/\",\"/ig' /tmp/BasicCompanyDataAsOneFile-2017-10-01.csv > /tmp/companydatafixed.csv` (tried `i` flag, for whatever reason I couldn't get it to work).

This was in logs of sqlite, but MySQL really threw a hissy-fit over this.
