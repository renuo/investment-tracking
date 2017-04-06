# Investment tracking

## Project description

This Project fetches the time entries from Redmine, aggregates and calculates them and displays
the unused investment time.

## Motivation

As our company gives us investment time (20% of our total worked hours) we have time to educate ourselves. 
Since we don't use this time regularly we have the opportunity to accumulate it. Therefore we wanted to have a tool 
which keeps track of our open investment time.

## Edge Cases

* Start date of accumulation is fixed
* Accumulation over 80h of open investment time
* Tickets which are invisible to the investment tracker (e.g. new ones)
* Excluded tickets (e.g. sickness)

## Installation

```sh
git clone git@github.com:renuo/investment-tracking.git
cd investment-tracking
bin/setup
```

config/application.yml

* Define Redmine Api-Key
* Rename all configuration that are surrounded by < > or containing the word yourname.

db/seeds.rb

* Set the start date from which on you want to start fetching the time entries

## Tests / Code Linting / Vulnerability Check

### Everything

```sh
bin/check
```

This runs

* keyword check (console.log, T0D0, puts, ...)
* rubocop
* scsslint
* brakeman
* rspec

### Rspec Only

```sh
rspec
```

## Run

```sh
bin/run
```

## Copyright

Coypright 2017 [Renuo AG](https://www.renuo.ch/).
