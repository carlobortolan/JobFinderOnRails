# Basic API documentation

***

### 1. Overview

> **URL**: http://localhost:3000/api/v0
>
***

### 2. User

1. Register an user
   >  <span style="color:lawngreen"> POST </span> /user
   This creates user and account records. The created account is unverified an needs to be confirmed by the user.
   ####
   ###### Data parameters
    1. **email** *<span style="color:crimson">REQUIRED </span>*
        + String
        + The email address to be used for login and the username for the account
    2. **first_name** *<span style="color:crimson">REQUIRED </span>*
        + String
        + The user's given names ( first name + middle name *[if any]* ) as stated on their identity card
    3. **last_name** *<span style="color:crimson">REQUIRED </span>*
        + String
        + The user's surname as stated on their identity card
    4. **password** *<span style="color:crimson">REQUIRED </span>*
        + String
        + The password to be used for login
    5. **password_confirmation** *<span style="color:crimson">REQUIRED </span>*
        + String
        + The password to be used for login (Verification point)
   ####
   ###### Response
   **200: OK**
    ```   
            {
                "message": "Account registered! Please activate your account and claim your refresh token via GET http://localhost:3000/api/v0/user/verify "
            }
    ```
   ####
   **400: Bad request**
    ```   
            {
                "error": {
                    "email": [
                        {
                            "error": "ERR_INVALID"",
                            "description": "Attribute is malformed or unknown
                        }
                    ] 
                }       
            }
    ```
   You may expect the following errors:
    + ``ERR_BLANK``: When a required attribute is blank
    + ``blank``: When the password attribute is blank
    + ``confirmation``: When password != password_confirmation
    + ``ERR_INVALID``: When a required attribute is malformed or unknown
   ####    
   **422: Unprocessable entity**
    ```   
            {
                "error": {
                    "email": [
                        {
                            "error": "ERR_TAKEN",
                            "description": "Attribute is taken"
                        }
                    ]   
                }       
            }
    ```
   ####
   **500: Internal Server Error**
    ```   
            {
                "error": "Please try again later. If this error persists, we recommend to contact our support team."
            }
    ```
   ####

***

2. Verify user credentials
   >  <span style="color:lawngreen"> GET </span> /user/verify
   Test to make sure the Registration worked and to claim the initial refresh token.
   ####
   ###### Data parameters
    1. **email** *<span style="color:crimson">REQUIRED </span>*
        + String
        + The email address used for login
    2. **password** *<span style="color:crimson">REQUIRED </span>*
        + String
        + The password used for login
   ###### Response
   **200: OK**
    ```   
            {
                "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5"
            }
    ```
   ####
   **400: Bad request**
    ```   
            {
                "email": [
                    {
                        "error": "ERR_INVALID",
                        "description": "Attribute is malformed or unknown"
                    }
                ]
            }
    ```
   You may expect the following errors:
    + ``ERR_BLANK``: When a required attribute is blank
    + ``ERR_DISABLED``: The login for the given credentials is disabled
    + ``ERR_INVALID``: When the given attribute is malformed or unknown
   ####
   **401: Unauthorized**
    ```   
            {
                    "password": [
                        {
                            "error": "ERR_INVALID",
                            "description": "Attribute is malformed or unknown"
                        }
                    ]   
                }       
            }
    ```
   ####
   **403: Forbidden**
    ```   
         {
            "user": [
                {
                    "error": "ERR_INACTIVE",
                    "description": "Attribute is blocked."
                }
            ]
                       
        }
    ```
   ####
   **500: Internal Server Error**
    ```   
            {
                "error": "Please try again later. If this error persists, we recommend to contact our support team"
            }
    ```
   ####

***




