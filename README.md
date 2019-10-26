# JSON Seeker test-app for Teamvoy

## Getting started

To get started with the app, install rails first:

```
$ gem install rails
$ rails -v
```

Then create a new rails app:

```
$ rails new json_seeker
```

Add rspec support to the Gemfile. Place gem 'rspec-rails', gem 'rails-controller-testing' into the Test group. Then install the needed gems.

```
$ bundle install
$ rspec -v
```

Unpack the archive and move the files to these directories:

```
$ mv routes.rb ~/json_seeker/config/
$ mv json_seeker_controller.rb ~/json_seeker/app/controllers/
$ mv json_seeker_controller_spec.rb ~/json_seeker/spec/controllers/
$ mv seek.html.erb ~/json_seeker/app/views/json_seeker/
$ mv _seeker.html.erb ~/json_seeker/app/views/json_seeker/
$ mv _result_table.html.erb ~/json_seeker/app/views/json_seeker/
$ mv json_seeker.scss ~/json_seeker/app/assets/stylesheets/
```

Download the search data from https://gist.github.com/g3d/d0b84a045dd6900ca4cb, unpack it and move to:

```
$ mv data.json ~/json_seeker/public/
```
Run the specs to make sure everything works fine

```
$ rspec -fdoc
```

Finally start the rails server and visit http://localhost:3000/

```
$ rails s
```
