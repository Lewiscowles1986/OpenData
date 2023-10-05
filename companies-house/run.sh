#!/bin/bash

if [ -z "$ARCHIVEFILE" ]; then
    # curl -s https://download.companieshouse.gov.uk/en_output.html | \
    # pup '#mainContent > div.grid_7.push_1.omega > ul:nth-child(4) > li > a attr{href}'
    ARCHIVEFILE="BasicCompanyDataAsOneFile-2023-10-04.zip"
fi

if [ -z "$INNERFILE" ]; then
    INNERFILE="BasicCompanyDataAsOneFile-2023-10-04.csv"
fi

if [ -z "$DBFILE" ]; then
    DBFILE="companies.db"
fi

if [ -z "$WORKDIR" ]; then
    WORKDIR=/tmp
fi

SCRIPT=$(readlink -f "$0")
BASEDIR=$(dirname "$SCRIPT")

#apt-get install -yqq unzip sqlite3

checkArchiveFileExistsOrDownload() {
    if [ ! -f "$WORKDIR/$ARCHIVEFILE" ]; then
        echo "$WORKDIR/$ARCHIVEFILE does not exist. Downloading..."
        wget http://download.companieshouse.gov.uk/$ARCHIVEFILE || (echo "something went wrong with download" && exit 1)
    else
        echo "archive '$ARCHIVEFILE' exists"
    fi
}

unpackArchiveFile() {
    if [ ! -f "$WORKDIR/$INNERFILE" ]; then
        unzip $ARCHIVEFILE -d ./ || (echo "something went wrong with extraction of zip" && exit 1)
    else
        echo "data extracted to '$INNERFILE' already"
    fi
}

importDB() {
    echo "Importing CSV to SQLite '$DBFILE'"
    echo "
.mode csv
.import $WORKDIR/$INNERFILE companies_raw
.read $BASEDIR/transform.sql
.read $BASEDIR/cleanup.sql
    " | sqlite3 $WORKDIR/$DBFILE
}

importDBIfNeeded() {
    if [ ! -f "$WORKDIR/$DBFILE" ]; then
        importDB
    else
        echo "Looks like companies.db exists. If it's no good, delete it ;-)"
    fi
}

main() {
    pushd "$WORKDIR"
    checkArchiveFileExistsOrDownload
    unpackArchiveFile

    importDBIfNeeded
    popd
}

main
