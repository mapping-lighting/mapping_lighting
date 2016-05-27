---
title: Mapping Lighting Test Manual
subtitle: Test planning and execution
author:
  - mapping-lighting.org Professional Project 2016
---

# Introduction

This document describes the testing processes used in the Mapping Lighting project, detailing the goals and restrictions the testing is made under and the tooling and processes used.

# Background

The Mapping Lighting application is a web based application, serving both desktop and mobile users from the same codebase.
The application is written in Ruby on Rails, a web application framework and integrates with Amazon Relational Database Service (RDS), and Simple Storage Service (S3).

The application was built to modern software development practices and automated regression and acceptance testing was used to ensure that code changes did not adversely affect existing built features.

Due to limits on team resources, extensive manual testing was unfeasible, and automated testing serves as an excellent multiplier for the team's efforts.

# Test & Deployment Process

  Testing has been conducted in two main ways;
    * automated testing using automatic tools
    * manual exploratory testing

  Ad-hoc User testing has also been conducted, please see the **Mapping Lighting Usability Report** for further details.

  The application is deployed to the domain `mapping-lighting.org`, which is hosted on (Heroku)[https://heroku.com/].
  The application code is managed within Github[^github] [github.com/mapping-lighting/mapping_lighting](https://github.com/mapping-lighting/mapping_lighting), a collaborative code hosting platform
  Automated test builds are managed within (CircleCI)[https://circleci.com/gh/mapping-lighting/mapping_lighting].

  This deployment occurs *automatically*

  The process occurs like so;

  1. Code is merged to pushed to the `master` branch.
  2. CircleCI will run the test suite against the latest version of the code. (`master` branch)
  3. Once the build is complete, Github pushes a notification to Heroku.
  4. If the build was a **success** Heroku will fetch the commit that passed the tests, and automatically deploy that directly to production.
  5. If the build was a **failure**, Heroku takes no action.

  This means that once code is approved by the development team, **and** has passed the test suite, it takes no effort to deploy the code to production.

[^github]: Github - <https://github.com/mapping-lighting/mapping_lighting>

# Automated Tests

The system is tested with a suite of user acceptance tests, which exercise the application running in an automatically created test environment.

The test suite uses the [Capybara](https://github.com/jnicklas/capybara) gem to run tests against a headless web browser, exercising the application as if an end user was using it directly.

The acceptance tests are written in the [Gherkin specification language](https://github.com/cucumber/cucumber/wiki/Gherkin) and executed by the [rspec](http://rspec.info/) framework, using the [Turnip](https://github.com/jnicklas/turnip) test runner.


## Separation of Intent from Implementation.

Gherkin is designed to be a human readable format for specifying behaviour, but that is still machine executable.
This allows the writing of tests which define the business or domain goal, without specifying the low level implementation.

The following example uses user facing language in the specification, and detail oriented code in the definition of *how* the tests will be run.

A test scenario might look like this.

```gherkin
Feature: User Logins
  Background:
    Given there is a user "foo@bar.com" with password "mapping.cool"

  Scenario: Login with valid credentials
    When I am on the homepage
     And I login as "foo@bar.com" using password "mapping.cool"
    Then I should be signed in
```

A steps of the specification might be defined something like this;

```ruby
  step('I login as :email using password :password') do |email, password|
    visit(new_user_session_path)
    fill_in('Email', with: email)
    fill_in('Password', with: password)
    click_on('Log in')
  end
```

In this example, the step takes two parameters, the email and password, and then simulates the user;

1. Visiting the login page
2. Entering their email address in the "Email" form field
3. Entering their password in the "Password" form field
4. Clicking the "Log in" button.

This system allows the testing to be completed automatically by the computer, rather than manually by a person.

For full details of the automated tests, see the acceptance specs on github: [MappingLighting /spec/acceptance](https://github.com/mapping-lighting/mapping_lighting/tree/master/spec/acceptance).

# Use of Manual Testing

An important aspect of automated testing is test coverage, and unfortunately the team did not acheive full test coverage of the application code with automated tests.

In these cases, we have relied upon both the original user story specifications from the design doument to drive manual testing, as well as ad-hoc and exploratory testing.

Please refer to **Mapping Lighting Design Document, p13** for a full listing of stories.


# Software Libraries (References)

Baker, S, Astels, D, Hellesøy, A, Chelimsky, D, Humphries, C, Marston, M & Lindeman, A 2016, "RSpec: Behaviour Driven Development for Ruby", *Rspec.info*, viewed 26 May, 2016, <http://rspec.info/>.

Cresswell, J 2016, "Gherkin", *GitHub/cucumber*, viewed 26 May, 2016, <https://github.com/cucumber/cucumber/wiki/Gherkin>.

Nicklas, J 2016, "jnicklas/capybara", GitHub, viewed 26 May, 2016, <https://github.com/jnicklas/capybara>.

Nicklas, J 2016, "jnicklas/turnip", *GitHub/turnip*, viewed 26 May, 2016, <https://github.com/jnicklas/turnip>.
