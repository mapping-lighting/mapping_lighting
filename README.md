# Mapping Lighting Application

[![CircleCI](https://circleci.com/gh/mapping-lighting/mapping_lighting/tree/master.svg?style=svg)](https://circleci.com/gh/mapping-lighting/mapping_lighting/tree/master)

# Setup

## Ruby version

Ruby version should be `2.2`, matching the AWS ElasticBeanstalk version (2.2 with Puma)

## System dependencies

- PostgreSQL - <http://www.postgresql.org>
- PostGIS    - <http://postgis.net>
- ImageMagick **OR** GraphicsMagick
    - <https://www.imagemagick.org>
    - <http://www.graphicsmagick.org>

### Development Dependencies

For development and testing you will need PhantomJS.

- PhantomJS - <http://phantomjs.org/>

To build the documentation and user manuals you will also need;

- Pandoc - <http://pandoc.org/>
- PDFTex <https://www.tug.org/applications/pdftex/> \
       On MacOSX PDFTex is available in MacTex - <https://tug.org/mactex/>

You can install all the required system packages on OSX using [Homebrew](http://brew.sh/), with the following command.

```shell
brew install postgis imagemagick pandoc phantomjs
```



> **Note:** PostgreSQL is a dependency of PostGIS, so will be installed automatically.

### User Manuals Dependencies

The additional dependencies can be installed on OSX with the Homebrew Cask plugin. <https://caskroom.github.io/>

```shell
brew cask install basictex
```

## Configuration

Development database credentials can be overridden with environment variables.

In your `.env` file put the following lines to configure the connection, set the values appropriately for your system.
The `.env` file is **not** committed to source control.

You can run the rake task `.env` to create this file automatically with useful default values.

```shell
export MAPPING_LIGHTING_DATABASE_HOSTNAME=localhost
export MAPPING_LIGHTING_DATABASE_USERNAME=postgres
export MAPPING_LIGHTING_DATABASE_PASSWORD=

export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=
export AWS_S3_BUCKET_NAME=
```

Database creation
-------------------

bundle exec rake db:create

## Database initialization

To initialize the database, the following steps must be completed.

  1. Create the database user.
  2. Enable the PostGIS extension.

### Create the database user

Running the following command will create a local database user named `postgres` with which the application can connect to the database.

```shell
createuser postgres --superuser --login
```

To enable PostGIS, connect to the database and run the following SQL command.

```SQL
CREATE EXTENSION "postgis";
```


How to run the test suite
---------------------------

Services (job queues, cache servers, search engines, etc.)
------------------------------------------------------------

Deployment instructions
-------------------------

