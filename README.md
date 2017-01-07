# OpenCov

OpenCov is an self-hosted opensource test coverage history viewer.
It is compatible with [coveralls](https://coveralls.io/), so most
coverage tools will work easily.

## Starting the server

```
$ mix deps.get
$ mix ecto.create && mix ecto.migrate
$ mix phoenix.server
```

This should start OpenCov at port 4000.

You should also be able to deploy to Heroku by simply git pushing this repository.

## Sending test metrics

A few languages are documented in [the wiki](https://github.com/tuvistavie/opencov/wiki).
For other languages, coveralls instructions should work out of the box,
you just need to set the URL to your OpenCov server and to explicitly set
the token, even when using Travis.

## Demo and screenshots

A demo is available at https://opencov.herokuapp.com

### Projects list

![projects](https://cloud.githubusercontent.com/assets/1436271/21740030/45ce95d6-d4ef-11e6-8d09-fac4aa7d5f00.png)

### Project page

![project page](https://cloud.githubusercontent.com/assets/1436271/21740031/45d0bafa-d4ef-11e6-93dc-0decbbd1d973.png)

### Build page

![build page](https://cloud.githubusercontent.com/assets/1436271/21740029/45cd825e-d4ef-11e6-9a55-ab19be6a3690.png)

### Coverage page

![coverage page](https://cloud.githubusercontent.com/assets/1436271/21740028/45cca55a-d4ef-11e6-9515-6b8672549dbd.png)
