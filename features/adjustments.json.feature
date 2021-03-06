Feature: Adjustments via JSON
  In order to modify and report on karma
  As a client
  I want to be able to read and manipulate user's karma via the JSON API

  Background:
    Given a typical set of adjustments, tags, and users
    And a client with hostname "jimjim", api key "123456789ABCDEFG", and website "plants"
    And I log in as "" with password "123456789ABCDEFG"
    
  Scenario: Read list of adjustments
    When I GET "/users/harry/tags/animals/adjustments.json"
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """    
      [
        {
          adjustment: {
            id: 104,
            value: 4,
            path: "/users/harry/tags/animals/adjustments/104.json",
            user_permalink: harry,
            tag_permalink: animals,
            created_at: "2009-09-10T15:06:32Z",
            updated_at: "2009-09-10T15:06:32Z"
          }
        },
        {
          adjustment: {
            id: 105,
            value: -1,
            path: "/users/harry/tags/animals/adjustments/105.json",
            user_permalink: harry,
            tag_permalink: animals,
            created_at: "2009-09-10T15:06:32Z",
            updated_at: "2009-09-10T15:06:32Z"
          }
        }
      ]
    """
  
  Scenario: Read list of adjustments when there are none
    And there are no adjustments
    When I GET "/users/harry/tags/animals/adjustments.json"
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """
      []
    """
  
  Scenario: Read adjustment
    When I GET "/users/harry/tags/animals/adjustments/104.json"
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """
      adjustment: {
        id: 104,
        value: 4,
        path: "/users/harry/tags/animals/adjustments/104.json",
        user_permalink: harry,
        tag_permalink: animals,
        created_at: "2009-09-10T15:06:32Z",
        updated_at: "2009-09-10T15:06:32Z"
      }
    """
  
  Scenario: Read a non-existent adjustment
    When I GET "/users/harry/tags/animals/adjustments/500.json"
    Then I should get a 404 Not Found response
    And I should get an empty response body
  
  Scenario: Read a non-existing adjustment
    When I GET "/users/harry/tags/animals/adjustments/300.json"
    Then I should get a 404 Not Found response
    And I should get an empty response body
  
  Scenario: Read an adjustment with a non-existing tag
    When I GET "/users/harry/tags/doesnt-exist/adjustments/300.json"
    Then I should get a 404 Not Found response
    And I should get an empty response body
  
  Scenario: Read an adjustment with a non-existing user
    When I GET "/users/doesnt-exist/tags/animals/adjustments/300.json"
    Then I should get a 404 Not Found response
    And I should get an empty response body
  
  Scenario: Read an adjustment with a non-existing user and tag
    When I GET "/users/doesnt-exist/tags/doesnt-exist/adjustments/300.json"
    Then I should get a 404 Not Found response
    And I should get an empty response body
  
  Scenario: Request a new adjustment
    When I GET "/users/harry/tags/animals/adjustments/new.json"
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """
      {
        "adjustment":{
          id: null,
          value: null,
          path: null,
          user_permalink: harry,
          tag_permalink: animals,
          created_at: null,
          updated_at: null
        }
      }
    """
  
  Scenario: Request a new adjustment with a non-existing tag
    When I GET "/users/harry/tags/doesnt-exist/adjustments/300.json"
    Then I should get a 404 Not Found response
    And I should get an empty response body
  
  Scenario: Request a new adjustment with a non-existing user
    When I GET "/users/doesnt-exist/tags/animals/adjustments/300.json"
    Then I should get a 404 Not Found response
    And I should get an empty response body
  
  Scenario: Request a new adjustment with a non-existing user and tag
    When I GET "/users/doesnt-exist/tags/doesnt-exist/adjustments/300.json"
    Then I should get a 404 Not Found response
    And I should get an empty response body
    
  Scenario: Create an adjustment
    When I POST "/users/harry/tags/animals/adjustments.json" with body "adjustment[value]=2"
    Then I should get a 201 Created response
    And I should get a JSON response body like:
    """
      adjustment: {
        id: 2,
        value: 2,
        path: "/users/harry/tags/animals/adjustments/2.json",
        user_permalink: harry,
        tag_permalink: animals,
        created_at: "2009-09-09T12:00:00Z",
        updated_at: "2009-09-09T12:00:00Z"
      }
    """
    
  Scenario: Attempt to create an adjustment with a new tag
    When I POST "/users/harry/tags/new-tag/adjustments.json" with body "adjustment[value]=2"
    Then I should get a 201 Created response
    And I should get a JSON response body like:
    """
      adjustment: {
        id: 2,
        value: 2,
        path: "/users/harry/tags/new-tag/adjustments/2.json",
        user_permalink: harry,
        tag_permalink: new-tag,
        created_at: "2009-09-09T12:00:00Z",
        updated_at: "2009-09-09T12:00:00Z"
      }
    """
    Then I GET "/tags/new-tag.json"
    And I should get a 200 OK response
    And I should get a JSON response body like:
    """
      {
        tag: {
          permalink: new-tag,
          path: "/tags/new-tag.json",
          created_at: "2009-09-09T12:00:00Z",
          updated_at: "2009-09-09T12:00:00Z"
        }
      }
    """
    
  Scenario: Attempt to create an adjustment with no value
    When I POST "/users/harry/tags/animals/adjustments.json" with body ""
    Then I should get a 422 Unprocessable Entity response
    And I should get a JSON response body like:
    """
      [
        ["value","can't be blank"],
        ["value","is not a number"]
      ]
    """
  
  Scenario: Destroy an adjustment
    When I DELETE "/users/harry/tags/animals/adjustments/104.json"
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """
      "adjustment": {
        id: 104,
        value: 4,
        path: "/users/harry/tags/animals/adjustments/104.json",
        user_permalink: harry,
        tag_permalink: animals,
        created_at: "2009-09-10T15:06:32Z",
        updated_at: "2009-09-10T15:06:32Z"
      }
    """
  
  Scenario: Attempt to destroy a non-existing adjustment
    When I DELETE "/users/harry/tags/animals/adjustments/300.json"
    Then I should get a 404 Not Found response
  
  Scenario: Attempt to destroy an adjustment with a non-existing tag
    When I DELETE "/users/harry/tags/doesnt-exist/adjustments/300.json"
    Then I should get a 404 Not Found response
  
  Scenario: Attempt to destroy an adjustment with a non-existing user
    When I DELETE "/users/doesnt-exist/tags/animals/adjustments/300.json"
    Then I should get a 404 Not Found response
  
  Scenario: Attempt to destroy an adjustment with a non-existing user and tag
    When I DELETE "/users/doesnt-exist/tags/doesnt-exist/adjustments/300.json"
    Then I should get a 404 Not Found response
  