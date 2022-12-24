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
4. View the documentation under: http://localhost:63342/<your-project-name>/doc/

</details>

## Functionality

### Managing of applications for available jobs

The system is able to manage jobs and application (supporting
basic [CRUD-Operations](https://www.javatpoint.com/crud-operations-in-sql)) and notifies the employer when a new
application is submitted as well as the applicant when his application is accepted.

All notifications are sent using [SMTP](https://en.wikipedia.org/wiki/Simple_Mail_Transfer_Protocol).

### Filtering of available jobs

The system receives a set of available jobs and filters them returning a sorted feed according to the user's parameters.

## How it works

Simply start the server and go to http://localhost:3000
Authentication:
> user: cb
>
> password: 1

## Config

**EITHER** (*recommended*)

- create a new schema called `jobdata` in your MySql database
- add a new user called `rm_user` with full access rights and the
  password ``` hô[ÕiÚéjÚ¢X*t/t¢ÕeR/ü¾nõ'g'ñ¢ß«Tíwàx²"¡jÛß´*PZÏmõ}ßX¨º*¤àÙ7ü'ÌJÌ=´Lh#M[NöèD`¿üåvã^àði®$4¦{·d3ZE~üMêr.7>þSrÖô(òúHÒDÊ]!Ä-¯.ï!òHúã¡```
- run `$ ruby bin\rails db:migrate` or `$ bin/rails db:migrate` (depending on your OS)
- run `$ ruby bin\rails server` or `$ bin/rails server` (depending on your OS)

**OR**

- modify the values for
    - `default: username`, ` default: password`,
    - `production: database`,
    - `production: database`, `deployment: username`
- run `$ ruby bin\rails db:migrate` or `$ bin/rails db:migrate` (depending on your OS)
- run `$ ruby bin\rails server` or `$ bin/rails server` (depending on your OS)

> **Optional:** Add example data by importing ``/db/importdata.sql`` into the schema jobdata.

## Sources

*(not yet added)*

---
> Carlo Bortolan &nbsp;&middot;&nbsp;
> GitHub [@carlobortolan](https://github.com/carlobortolan) &nbsp;&middot;&nbsp;
> e-mail [@carlo.bortolan@tum.de](carlo.bortolan@tum.de)
>
> Jan Hummel &nbsp;&middot;&nbsp;
> GitHub [@github4touchdouble](https://github.com/github4touchdouble) &nbsp;&middot;&nbsp;
> e-mail [@jan.hummel@tum.de](jan.hummel@tum.de)