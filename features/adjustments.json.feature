Feature: Adjustments via JSON
  In order to track and manage changes to a user's karma
  As a client
  I want to be able to read and modify user's karma via the JSON API

  Background:
    Given the following users:
      | id  | permalink      | created_at              | updated_at              |
      | 1   | bob            | 2009-09-10 19:55:35 UTC | 2009-09-10 19:55:35 UTC |
      | 2   | harry          | 2009-09-10 13:57:01 UTC | 2009-09-10 13:57:01 UTC |
    And the following buckets:
      | id | permalink  | created_at              | updated_at              |
      | 3  | plants     | 2009-09-10 13:57:14 UTC | 2009-09-10 13:57:14 UTC |
      | 4  | animals    | 2009-09-10 13:57:14 UTC | 2009-09-10 13:57:14 UTC |
    And the following adjustments:
      | id | user_id | bucket_id | value | created_at              | updated_at              |
      | 5  | 1       | 3         | 1     | 2009-09-10 15:06:25 UTC | 2009-09-10 15:06:25 UTC |
      | 6  | 1       | 4         | 2     | 2009-09-10 15:06:32 UTC | 2009-09-10 15:06:32 UTC |
      | 7  | 2       | 3         | 3     | 2009-09-10 15:06:25 UTC | 2009-09-10 15:06:25 UTC |
      | 8  | 2       | 4         | 4     | 2009-09-10 15:06:32 UTC | 2009-09-10 15:06:32 UTC |
      | 9  | 2       | 4         | -1    | 2009-09-10 15:06:32 UTC | 2009-09-10 15:06:32 UTC |

  Scenario: Read adjustments
    When I GET "/users/harry/buckets/animals/adjustments.json"
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """
      [
        {
          adjustment: {
            bucket_id: 4,
            created_at: "2009-09-10T15:06:32Z",
            updated_at: "2009-09-10T15:06:32Z",
            id: 8,
            user_id: 2,
            value: 4
          }
        },
        {
          adjustment: {
            bucket_id: 4,
            created_at: "2009-09-10T15:06:32Z",
            updated_at: "2009-09-10T15:06:32Z",
            id: 9,
            user_id: 2,
            value: -1            
          }
        }
      ]
    """