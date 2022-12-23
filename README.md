<h1>
<br>
<a href="https://gitlab.com/github4touchdouble/versuchundirrtum/"><img src="https://gitlab.com/github4touchdouble/versuchundirrtum/-/raw/dev/versuch_und_irrtum.png" alt="V&I" width="500"></a>
</h1>

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

The system is able to manage application (supporting
basic [CRUD-Operations](https://www.javatpoint.com/crud-operations-in-sql)) and notifies the employer when a new
application is submitted as well as the applicant when his application is accepted.

All notifications are sent using [SMTP](https://en.wikipedia.org/wiki/Simple_Mail_Transfer_Protocol).

### Filtering of available jobs

The system receives a set of available jobs and filters them returning a sorted feed according to the user's parameters.

## How it works

## Config

## Sources

---
> Carlo Bortolan &nbsp;&middot;&nbsp;
> GitHub [@carlobortolan](https://github.com/carlobortolan) &nbsp;&middot;&nbsp;
> e-mail [@carlo.bortolan@tum.de](carlo.bortolan@tum.de)
>
> Jan Hummel &nbsp;&middot;&nbsp;
> GitHub [@github4touchdouble](https://github.com/github4touchdouble) &nbsp;&middot;&nbsp;
> e-mail [@jan.hummel@tum.de](jan.hummel@tum.de)