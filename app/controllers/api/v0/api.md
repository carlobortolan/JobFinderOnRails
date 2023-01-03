
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
                "message": "Account registered! Please activate your account at GET http://localhost:3000/api/v0/user/verify "
            }
    ```
    ####
   **422: Unprocessable entity**
    ```   
            {
                "error": {
                    "email": [
                        {
                            "error": "ERR_INVALID",
                            "description": "Attribute is malformed"
                        }
                    ]   
                }       
            }
    ```
   You may expect the following errors:
     + ``ERR_BLANK``: When a required attribute is blank
     + ``blank``: When the password attribute is blank
     + ``confirmation``: When password != password_confirmation
     + ``ERR_TAKEN``: When an unique attribute is already taken (e.g. Email)
     + ``ERR_INVALID``: When an attribute is malformed (e.g. invalid format or wrong characters)
   ####
   **500: Internal Server Error**
    ```   
            {
                "error": "Please try again later. If this error persists, we recommend to contact our support team."
            }
    ```
    ####

***

