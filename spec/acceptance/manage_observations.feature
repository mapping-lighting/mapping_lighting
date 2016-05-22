Feature: Manage Observations
  Background:
    When I am signed in
     And I visit the manage observations page

  Scenario: No observations
    Then there should be no observations

  Scenario: Viewing observations
    Given there is a "advertising_general" observation
      And I visit the manage observations page
     Then there should be an "advertising_general" observation

  Scenario: Deleting an observation
    Given there is a "advertising_general" observation
      And I am on the manage observations page
     When I delete an "advertising_general" observation
     Then there should be no observations
