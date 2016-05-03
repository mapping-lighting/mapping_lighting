# Mapping Lighting Application

# Setup

## Ruby version

Ruby version should be `2.2`, matching the AWS ElasticBeanstalk version (2.2 with Puma)

## System dependencies

- PostgreSQL
- PostGIS
- ImageMagick / GraphicsMagick

You can install the required system packages on OSX using [Homebrew](http://brew.sh/), with the following command.

```shell
brew install postgis imagemagick
```

> **Note:** PostgreSQL is a dependency of PostGIS, so will be installed automatically.

## Configuration

Development database credentials can be overridden with environment variables.

In your `.env` file put the following lines to configure the connection, set the values appropriately for your system.
The `.env` file is **not** committed to source control.

You can run the rake task `.env` to create this file automatically with useful default values.

```shell
export MAPPING_LIGHTING_DATABASE_HOSTNAME=localhost
export MAPPING_LIGHTING_DATABASE_USERNAME=postgres
export MAPPING_LIGHTING_DATABASE_PASSWORD=
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

