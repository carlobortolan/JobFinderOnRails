<h1>Versuch und Irrtum on RAILS</h1>

## License

### Licensed under either of

> Apache License, Version 2.0, ([LICENSE-APACHE](http://www.apache.org/licenses/LICENSE-2.0))

> MIT license ([LICENSE-MIT](http://opensource.org/licenses/MIT))

## Contribution

Unless you explicitly state otherwise, any contribution intentionally submitted for inclusion in the work by anyone, as
defined in the Apache-2.0 license, shall be dual licensed as above, without any additional terms or conditions.
<details><summary><b>Contribute to the documentation</b></summary>

1. Install the necessary gem using `$ gem install yard`
2. Write new code/comments
3. Update the documentation
   using `$ yardoc 'app/views/*.html.erb' 'app/controllers/*.rb' 'app/models/*.rb' 'app/helpers/*.rb' 'app/repository/*.rb' 'app/service/*.rb' 'app/controllers/*.rb' 'lib/**/*.rb'`
4. View the documentation under: http://localhost:63342/insert-here-project-name/doc/

</details>

## Functionality

### Managing of applications for available jobs

The system is able to manage jobs and application (supporting
basic [CRUD-Operations](https://www.javatpoint.com/crud-operations-in-sql)) and notifies the employer when a new
application is submitted as well as the applicant when his application is accepted.

All notifications are sent using [SMTP](https://en.wikipedia.org/wiki/Simple_Mail_Transfer_Protocol).

### Filtering of available jobs

The system receives a set of available jobs and filters them returning a sorted feed according to the user's parameters.
_Default values for search_:

- coordinates *0.0*, *0.0*
- radius: *50.0*
- timeslot: *Time.now*
- limit (=maximum number of jobs shown): *100*

### User authentication

Users can set up an account with their email address and a password.
The password is instantaneously encrypted using  [bcryt](https://en.wikipedia.org/wiki/Bcrypt) and stored in form of a
encrypted hash in the database. In case the user forgets this password, it can be reset via standard email
authentication.

## How it works

Simply start the server and go to http://localhost:3000/ and create a new account or log in with an existing account

## Config

**EITHER** (*recommended*)

- create a new schema called `jobdata` in your MySql database
- add a new user called `rm_user` with full access to all administrative roles and the
  password ``` hô[ÕiÚéjÚ¢X*t/t¢ÕeR/ü¾nõ'g'ñ¢ß«Tíwàx²"¡jÛß´*PZÏmõ}ßX¨º*¤àÙ7ü'ÌJÌ=´Lh#M[NöèD`¿üåvã^àði®$4¦{·d3ZE~üMêr.7>þSrÖô(òúHÒDÊ]!Ä-¯.ï!òHúã¡```
- run `$ rails db:migrate` to create all necessary
  tables
- run `$ rails server` to start the server

**OR**

- modify the values for
    - `default: username`, ` default: password`,
    - `production: database`,
    - `production: database`, `deployment: username`
- run `$ rails db:migrate` to create all necessary
- run `$ rails server` to start the server

> **Optional:(ignore for now)** ~~Add example data by importing ``/db/importdata.sql`` into the schema jobdata.~~

## Sources

*(TODO)*

## TODO

- Fix seed / importdata
- Add remaining **job-attributes** in ``job_create`` and ``job_show``
- Implement **location system** (+ function from address to coordinates)
- Add appropriate **HTML/CSS** to improve look of views

---
> Carlo Bortolan &nbsp;&middot;&nbsp;
> GitHub [@carlobortolan](https://github.com/carlobortolan) &nbsp;&middot;&nbsp;
> e-mail [@carlo.bortolan@tum.de](carlo.bortolan@tum.de)
>
> Jan Hummel &nbsp;&middot;&nbsp;
> GitHub [@github4touchdouble](https://github.com/github4touchdouble) &nbsp;&middot;&nbsp;
> e-mail [@jan.hummel@tum.de](jan.hummel@tum.de)