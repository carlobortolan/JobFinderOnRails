#### <div style="text-align:right">C-XJH-0005 </div>
####
# <div style="text-align: center"><span style="color:crimson"> < CONFIDENTIAL >   < CONFIDENTIAL >  < CONFIDENTIAL ></span> </div>
####
# Authentication Service INTERNAL Documentation

***

### 1. Overview

> This document provides pragmatic information on the JWT based authentication approach of the project's API.
>
> 
The Authentication approach combines the benefits of long-term but weak refresh tokens with short-term, more powerful access tokens.

**Note:** The API ist still in a very early alpha version, so changes to the general approach and this document will happen.
***

### 2. Refresh token

1. Claim a refresh token
    ```   
    AuthenticationTokenService::Refresh::Encoder.call(<user_id>,[<man_interval>])
    ```
   This creates a refresh token for a given user.
   ####
   ###### Data parameters
    1. ``<user_id>`` *<span style="color:crimson">REQUIRED </span>*
        + Integer
        + The user ``id`` of the subject of the token (``sub`` claim)
        + A user to this ``id`` must exist
        + The user to this ``id`` must be verified (``activity_status`` == 1)
        + The user to this ``id`` must not be blocked (listed on ``UserBlacklist``)
    2. ``<man_interval>`` *<span style="color:grey">OPTIONAL </span>*
        + Integer
        + Validity time interval of the token in seconds after the issuing time of the token
        + (0.5 hours ==) 1800 <= ``<man_interval>`` <= 86400 (== 24 hours)
        + If ```<man_interval>``` is blank, or ```<man_interval>``` is too big/small, the token will expire after 4 hours

   ####
   ###### Return
    ```   
    <refresh_token>
    ```
   First, the inputs are checked for correct formatting. Then the token claims are populated:
   + ``sub`` - who owns the token?:``<user_id>``
   + ``iat`` - when was the token issued?: An exact timestamp in seconds after 1am of the 01 01 1970
   + ``exp`` - when does the token expire?: If ``<man_interval>`` is not given/blank => 4 hours from now; If ``<man_interval>`` is given: => (``<man_interval>`` divided by 3600) hours from now. If ``<man_interval>`` is in the required format, but ``<man_interval>`` is either smaller that 1800 or greater than 86400, ``exp`` is either set to the 0.5 hours or the 24 hours - what ever is closer to ``<man_interval>``
   + ``jti`` - a unique identifier: A MD5 encoded, unique String
   + ``iss`` - who issued the token?: The name of the machine that issues this token
   
   ####
   ###### Pipeline
   + String

   ####
   ###### Exceptions
   ```
   AuthenticationTokenService::InvalidInput
   ```
   You should only expect the following subclasses:
    + ``::SUB``: When ``<user_id>`` is malformed 
    + ``::CustomEXP``: When ``<man_interval>`` is malformed
   ####   
     ```
   AuthenticationTokenService::InvalidUser
   ```
   You should only expect the following subclasses:
    + ``::Unkown``: When there is no user for ``<user_id>`` 
    + ``::Inactive::NotVerified``: When the user for ``<user_id>`` is not verified (``activity_status`` == 0)
    + ``::Inactive::Blocked``: When the user for ``<user_id>`` has a record on ``UserBlacklist``
   ####
***
2. Decipher a refresh token
   ```   
    AuthenticationTokenService::Refresh::Decoder.call(<token>)
    ```
   This decodes a refresh token and returns its claims.
   ####
   ###### Data parameters
    1. ``<token>`` *<span style="color:crimson">REQUIRED </span>*
        + String
        + ``<refresh_token>`` must be a JWT, solely issued by the ``AuthenticationTokenService::Refresh::Encoder`` class
        + ``<refresh_token>`` must not be blocked (listed on ``AuthBlacklist``)

   ####
   ###### Return
    ```   
    <refresh_token_claims>
    ```
    + //?//

   ####
   ###### Exceptions
   ```
   AuthenticationTokenService::InvalidInput
   ```
   You should only expect the following subclasses:
    + ``::SUB``: When ``<user_id>`` is malformed
    + ``::CustomEXP``: When ``<man_interval>`` is malformed
   ####   
     ```
   AuthenticationTokenService::InvalidUser
   ```
   You should only expect the following subclasses:
    + ``::Unkown``: When there is no user for ``<user_id>``
    + ``::Inactive::NotVerified``: When the user for ``<user_id>`` is not verified (``activity_status`` == 0)
    + ``::Inactive::Blocked``: When the user for ``<user_id>`` has a record on ``UserBlacklist``
   ####
***
####



