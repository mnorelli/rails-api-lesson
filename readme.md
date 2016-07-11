<!--
Creator: Alex White
Market: SF
-->

![](https://ga-dash.s3.amazonaws.com/production/assets/logo-9f88ae6c9c3871690e33280fcf557f33.png)

# Rails API Mode

### Why is this important?
*This workshop is important because:*
- Rails is a powerful JSON API building tool
- API mode is now built in to Rails 5

### What are the objectives?
<!-- specific/measurable goal for students to achieve -->
*After this workshop, developers will be able to:*

- Build a Rails API to CRUD programming languages
- Use the active_model_serializer to generate JSON
- Connect this API to your Angular app for full stack Rangular goodness

### Where should we be now?
*Before this workshop, developers should already be able to:*

- Create a basic Ruby on Rails CRUD app
- Create a basic Angular CRUD app using an external API


## Getting started

`gem install rails-api`

Before Rails 5 rails-api is its own separate gem! It includes many, but not all of Rails dependencies. Only the ones you need to create a JSON API.
We also will be using active_model_serializer which will abstract away from us JSON creation from our Database Data.

`rails-api new languages-api --database=postgresql`

Lets take a look at the code and see how it differs from a basic Rails app!

In your Gemfile:
`gem 'active_model_serializers', '~> 0.10.0.rc2'`

Then in terminal:
`bundle`

## Scaffold our resource

`rails g scaffold language name description`

Let's check out what we generated!

## Let's seed our db!

We are going to do a simple POST via CURL

First:
`rake db:migrate`
Then:
`curl -H "Content-Type: application/json" -X POST -d '{"language": {"name":"ruby","answer":"A syntactically beautiful class based language"}}' http://localhost:3000/languages`

## Be Kind: Version Control your API

API's evolve, but if any part of your API is public facing, it should behave consistently.
If you haven't experienced the frustration of using an exteral API and it suddenly not functioning because it was 'updated', I hope it stays that way!

Best practices for APIs is to namespace all routs as
`/api/v1/your-resource`

This way you can leave v1 the same for ever and if you want to update your API you can go ahead and make your changes to 'api/v2'

Let's go to to our `routes.rb` file and change it up:

```ruby
scope '/api/v1' do
  resources :cards, except: [:new, :edit]
end
```

## CORS with rack-cors
As of this moment we have created a JSON API that can be hit from the browser or with Curl. However, we want to be able to hit it from another application. As of now we will get the following error:

```bash
XMLHttpRequest cannot load http://localhost:3000/api/v1/cards. No 'Access-Control-Allow-Origin' header is present on the requested resource. Origin 'http://localhost:8000' is therefore not allowed access.
```

We will get around this by using the rack-cors gem.

```ruby
# Gemfile
gem 'rack-cors', :require => 'rack/cors'
```

`bundle`

Then we need to configure our app to specify what we want to allow from where:

```ruby
# config/application.rb
config.middleware.insert_before 0, "Rack::Cors", :debug => true, :logger => (-> { Rails.logger }) do
      allow do
        origins '*'

        resource 'api/v1/languages',
          :headers => :any,
          :methods => [:get, :post]

      end
    end
```

That's it!

## Independent Practice
Refine the skills covered in this workshop with this [lab](#)

## Additional Resources
- [Rails API source code](https://github.com/rails-api/rails-api)
