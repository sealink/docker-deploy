# docker-eb-deploy

docker-eb-deploy is a gem for facilitating Elastic Beanstalk deployment of
Docker images built automatically by Docker Hub or another third party service.

Currently it allows you to create a release and trigger the build automation in
Docker Hub.

1. Update the version in `public/version.txt`

1. Update the version tag of the image name in `Dockerrun.aws.json`

1. Push to the updated branch and the tag as the version to origin

## Installation

For multiple application usage, install the gem directly (in the global gem
space if you're using rbenv or rvm):

```shell
gem install docker-eb-deploy
```

## Usage

Execute `docker-release` in your project directory
that contains the Dockerrun.aws.json file.

## Development

Bundler is recommended for managing the development dependencies.

Rspec tests are located in the `spec` directory.  Just run `rspec` in the root
directory of the project to run all the bundled specs.

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/sealink/docker-deploy. This project is intended to be a safe,
welcoming space for collaboration, and contributors are expected to adhere to
the [Contributor Covenant](contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT
License](http://opensource.org/licenses/MIT).
