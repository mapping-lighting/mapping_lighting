Feature: User Logins
  Background:
    Given I am on the homepage
    And there is a user "foo@bar.com" with password "mapping.cool"

  Scenario: Login with valid credentials
    When I login as "foo@bar.com" using password "mapping.cool"
    Then I should be signed in

  Scenario: Login with invalid credentials
    When I login as "foo@bar.com" using password "invalid_password"
    Then I should not be signed in

  Scenario: Sign out
    Given I am signed in
    When I sign out
    Then I should be signed out
