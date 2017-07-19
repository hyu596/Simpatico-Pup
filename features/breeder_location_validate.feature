
Feature: Validate user entered city and state when creating breeder
  As a user, when I enter a location to create or search for a breeder
  I want the location to be validated 
  So that I can submit a valid location
  
Background: User already login, filled out pup name, how long the user owned the dog, and breed
  Given I am on the RateMyPup home page
  Given I am logged in
  And I finished previous steps
  
  And the following breeds exist:
      | name            |
      | Affenpinscher   |
  
  And the following breeders exist:
      | name            | city     | state |
      | Carl            | Berkeley | CA    |
      | Alex            | Berkeley | CA    |
      | Alexander       | Austin   | TX    |
  
  Scenario: User enter a city that doesn't exist when creating breeder
    Given I am on the "Add breeder" page
    When I fill in the new breeder form with following: breeder, fake city, CA
    And I press "Add_Breeder"
    Then I should be on the "Add breeder" page
    And I should see "The city you entered is not a valid city in the selected state"
    
  Scenario: User enter a existing city but selected state doesn't have that city when creating breeder
    Given I am on the "Add breeder" page
    When I fill in the new breeder form with following: breeder, Berkeley, NV
    And I press "Add_Breeder"
    Then I should be on the "Add breeder" page
    And I should see "The city you entered is not a valid city in the selected state"
    
  Scenario: User enter valid location and prcoess to rate dog page
    And I am on the "Add breeder" page
    When I fill in the new breeder form with following: breeder, Oakland, CA
    And I press "Add_Breeder"
    Then I should be on the "Create New Pup" page
    
  Scenario: User enter a city that doesn't exist when searching breeder
    Given I am on the "Search Breeder" page
    When I fill in the search breeder form with following: Any, fake city, AL, 250
    And I press "Search_Breeder"
    Then I should see "The city you entered is not a valid city in the selected state"
    
  Scenario: User enter a existing city but selected state doesn't have that city when searching breeder
    Given I am on the "Search Breeder" page
    When I fill in the search breeder form with following: Any, San Francisco, TX, 250
    And I press "Search_Breeder"
    Then I should see "The city you entered is not a valid city in the selected state"
    
  Scenario: User enter a valid location when searching breeder
    Given I am on the "Search Breeder" page
    When I fill in the search breeder form with following: Any, Oakland, CA, 100
    And I press "Search_Breeder"
    Then I should see "Carl"
    And I should not see "Alexander"
    