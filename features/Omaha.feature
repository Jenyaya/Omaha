Feature: Omaha

  Scenario: Check header links
    Given opened Omaha page
    Then I should see following header items:
      | Home             |
      | Run Query        |
      | Get Entitlements |
    When I click "Home" link
    Then I should see "Home" page opened
    When I click "Run Query" link
    Then I should see "Run Query" page opened
    When I click "Get Entitlements" link
    Then I should see "Get Entitlements" page opened


  Scenario: Search users
    Given opened Omaha page
   # When I press "Run Query" button
    Then I should see "Home" page opened
    When I fill search fields:
      | Select database | SAM E04     |
      | Username like   | yn04        |
      | Date created    | 01-MAR-2012 |
      | Entitlement     | appSkyGo    |
    When I press "Run Query" button
    Then I should see "Users found" page opened
