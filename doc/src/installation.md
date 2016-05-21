---
title: Mapping Lighting Installation Guide
subtitle: Installation, Administration and User and Observation Management
author:
  - mapping-lighting.org Capstone Project 2016
---

# Introduction

This guide details how to install the Mapping Lighting application, how to configure the services the application needs.

The application is built on the Ruby on Rails web framework, uses a PostGIS (PostgreSQL) database, and stores uploaded observation images on Amazon's S3 file storage service.

As such, the application needs;

 - a server upon which to run,
 - access to a running PostGIS database,
 - configured access to an Amazon S3 "bucket".

The application as delivered is configured with the following services;

| Service                | Provider                                 |
|------------------------|------------------------------------------|
| Web/Application Server | Heroku (free tier)                       |
| Database               | Amazon Relational Database Service (RDS) |
| File Storage           | Amazon Simple Storage Service (S3)       |

At the time of writing Heroku provides a free account with some restrictions on time and performance.

> Heroku **does** provide free PostgreSQL database access on its free plan, that database does not include PostGIS, which is a requirement for our storage of location data.


# Configuration

The application configuration is managed according to the Twelve-Factor principle -  <http://12factor.net/config> "Store config in the environment".

As such the following environment variables are used to provide the application access to the resources it needs, and *must* be configured for the application to work correctly.

```shell
DATABASE_URL
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
AWS_S3_BUCKET_NAME
```

`DATABASE_URL`

  : PostgreSQL connection URL including host, username, database and password. \
    **e.g.** `postgis://username:password@example.com/database_name`

`AWS_S3_BUCKET_NAME`

  : Amazon S3 bucket for storing uploaded images

  <!-- : **e.g.** `mapping_lighting_2016` -->

`AWS_ACCESS_KEY_ID`

  : Access ID for Amazon User with permissions to the S3 Bucket
  <!-- : **e.g.** `AKF9023LKJSDF90DSLFF` -->


`AWS_SECRET_ACCESS_KEY` 
  : Access Key for the Amazon User                                           
  <!-- : **e.g.** `66819a95fed1aaf5445a0792c328e124` -->

We recommend the use of [AWS Identity and Access Management (IAM)](https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html)[^iam] users on Amazon, these are restricted user accounts which are given access to only the resources they need.

[^iam]: AWS Identity and Access Management (IAM) - <https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html>


## Example Configuration Values

| Configuration Key       | Example Value                                           |
|-------------------------|---------------------------------------------------------|
| `DATABASE_URL`          | `postgis://username:password@example.com/database_name` |
| `AWS_S3_BUCKET_NAME`    | `mapping-lighting-bucket-name`                          |
| `AWS_ACCESS_KEY_ID`     | `AKF9023LKJSDF90DSLFF`                                  |
| `AWS_SECRET_ACCESS_KEY` | `66819a95fed1aaf5445a0792c328e124`                      |


<!-- > Note that these are example values only and **will not** work. -->



# Amazon RDS - Database

If using [Amazon RDS PostgreSQL](https://aws.amazon.com/rds/postgresql/)[^aws_rds] for the PostGIS database, the following documentation will guide you through the process of setting up an RDS instance of the appropriate type.

> Make note of the database password during instance creation.

1. [Setting Up for Amazon RDS](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_SettingUp.html) [^aws_gs_rds]

2. [Creating a PostgreSQL DB Instance and Connecting to a Database on a PostgreSQL DB Instance](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_GettingStarted.CreatingConnecting.PostgreSQL.html)[^aws_gs_postgres]

Once the RDS instance is configured and up and running, the `DATABASE_URL` configuration parameter can be constructed, it is structured like so,

```
postgis://username:password@endpoint.amazonaws.com/database_name
```

For example, given the values in the following table, the `DATABASE_URL` would be,

```
postgis://mapping_user:hunter2@mapping.xyz.ap-southeast-2.rds.amazonaws.com/mapping_lighting
```

| Component     | Value                                          |
|---------------|------------------------------------------------|
| Username      | `mapping_user`                                 |
| Password      | `hunter2`                                      |
| Endpoint      | `mapping.xyz.ap-southeast-2.rds.amazonaws.com` |
| Database Name | `mapping_lighting`                             |

These details - **except the password** - are available within the Amazon RDS web interface.

![RDS instance details](doc/src/installation/aws_rds_instance.png)

[^aws_rds]: PostgreSQL PostgreSQL - https://aws.amazon.com/rds/postgresql/
[^aws_gs_postgres]: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_GettingStarted.CreatingConnecting.PostgreSQL.html
[^aws_gs_rds]: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_SettingUp.html




# Amazon S3 - File Storage

To use S3, you will need to;

1. Create an S3 bucket, essentially a directory/folder inside Amazon S3. \
   *Bucket names must be globally unique.*
2. Create an IAM user which will have access to the bucket. \
    See the [Amazon IAM Guide](https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html)[^aws_iam_guide] for detailed instructions.
3. Assign the `AmazonS3FullAccess` access rights to the created user.



![Creating an S3 bucket](doc/src/installation/s3_bucket_create.png)

![IAM User created](doc/src/installation/aws_iam_created.png)

![IAM User granted `AmazonS3FullAccess` rights](doc/src/installation/iam_example_user_access.png)

Once the S3 bucket and the IAM user are created, they can be used, along with the RDS database URL to configure the application.


[^aws_iam_guide]: Amazon Identity Access Management Guide - https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html


# Heroku

This section will walk-through how the system is configured on Heroku with associated services as deployed on delivery.


A full step by step setup guide is available from Heroku - See [Getting Started with Ruby](https://devcenter.heroku.com/articles/getting-started-with-ruby#introduction) [^gswr]. This section is a supplement to that guide, with values appropriate for the Mapping Lighting project filled in.

> Note that this guide assumes some familiarity with a command line terminal, and having prerequisites installed for development. Please see the Development guide, or the project README for full instructions.

The Mapping Lighting application source code is available at <https://github.com/mapping-lighting/mapping_lighting>.

```shell
$ git clone https://github.com/mapping-lighting/mapping_lighting.git
$ cd mapping_lighting
```

Follow the steps in the guide setup the application with the following exceptions;

* The `Procfile` is already configured.
* The example local changes to the example app do **not** need to be made to the MappingLighting application.
* The configuration values needed are detailed in the section below.
* The Heroku Database addon will not be used, this will be configured using Amazon RDS services in the configuration section.


## Configure Application

The configuration values defined above need to be set for the application to access the required resources.

You can view the existing configuration with the `heroku config` command, and set values with the `heroku config:set CONFIG_KEY=value`.

**Set config values**

```shell
$ heroku config:set AWS_S3_BUCKET_NAME=example-bucket-name
```

**View config values**

Example configuration values.

> Configuration values are redacted in the following examples.


```shell
$ heroku config
=== polar-fortress-14912 Config Vars
AWS_ACCESS_KEY_ID:        <<REDACTED>>
AWS_S3_BUCKET_NAME:       mapping-lighting-bucket
AWS_SECRET_ACCESS_KEY:    <<REDACTED>>
DATABASE_URL:             postgis://username:password@example.com/database_name
...
```

The only values you will need to define are these first four listed, others are automatically defined by the heroku platform and do not need to be changed.

**Web based configuration**

It is also possible to configure the application using the Heroku web based dashboard. <https://dashboard.heroku.com>

![Heroku Application Configuration Dashboard](doc/src/installation/heroku_config_vars.png) 

More information is available on the Heroku [Getting Started with Ruby - Define Config Vars](https://devcenter.heroku.com/articles/getting-started-with-ruby#define-config-vars) [^gswh_config] section


[^gswr]: Getting Started with Ruby - <https://devcenter.heroku.com/articles/getting-started-with-ruby#introduction>
[^gswh_config]: Getting Started with Ruby - Define Config Vars - <https://devcenter.heroku.com/articles/getting-started-with-ruby#define-config-vars>


## Domain Names

Heroku allows the use of custom domains with the platform, and these need to be configured if you wish to use a custom domain.

The following figure shows the setup for the `mapping-lighting.org` domain pointing to `polar-fortress-14912.herokuapp.com`.

![Heroku Domain Configuration](doc/src/installation/heroku_domains.png)


