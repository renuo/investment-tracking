[![Dependency Status](https://gemnasium.com/ADD_GEMNASIUM_TOKEN.svg)](https://gemnasium.com/renuo/<appname>) [![Build Status](https://travis-ci.com/renuo/<appname>.svg?token=ADD_TRAVIS_TOKEN&branch=master)](https://travis-ci.com/renuo/<appname>) [![Build Status](https://travis-ci.com/renuo/<appname>.svg?token=ADD_TRAVIS_TOKEN&branch=develop)](https://travis-ci.com/renuo/<appname>) [![Build Status](https://travis-ci.com/renuo/<appname>.svg?token=ADD_TRAVIS_TOKEN&branch=testing)](https://travis-ci.com/renuo/<appname>)

# <appname>

## Important Links

* TODO: link to issue tracker, wiki, important resources, etc.
* https://github.com/renuo/investment-tracking
* https://investment-tracking-master.renuoapp.ch
* https://investment-tracking-develop.renuoapp.ch
* https://investment-tracking-testing.renuoapp.ch

## Installation

```sh
git clone git@github.com:renuo/investment-tracking.git
cd investment-tracking
bin/setup
```

### Configuration

```sh
bin/setup
```

* config/application.yml

## Tests / Code Linting / Vulnerability Check

### Everything

```sh
bin/check
```

This runs

* keyword check (console.log, T0D0, puts, ...)
* mdl
* rubocop
* scsslint
* tslint
* coffeelint
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

Copyright 2016 [Renuo AG](https://www.renuo.ch/).
