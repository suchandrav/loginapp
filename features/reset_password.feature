Feature: RESET PASSWORD

  Scenario: Group Reset Password with invalid msisdn
    Given I open '<service>' site for the opco '<opco>' in a logged out state
    And I go to reset password page
    When I reset password with '' as user name
    Then I see Reset empty field failure message



 # Scenario: Group Reset Password with invalid msisdn
 #   Given I open '<service>' site for the opco '<opco>' in a logged out state
 #   And I go to reset password page
 #   When I reset password with '+123456' as user name
 #   Then



