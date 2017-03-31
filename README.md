# Postmen example app.

## Synopsis

This is an example app, which uses <a href="https://github.com/postmen/postmen-sdk-ruby">Postmen SDK</a>.

It aims to quickly demonstrate how to build an app which uses <a href="https://postmen.com">Postmen</a>.

## Quick start guide

Currently the app is able to:

### 1. List your shipper accounts.

We're fetching Shipper accounts in the `app/controllers/shipper_accounts_controller.rb` file.

`@shipper_accounts = Postmen::ShipperAccount.all(slug: @slug)`

We're filtering here our shipper accounts by its slug. By default, SDK removes
empty conditions, so if no slug were passed, we'll return all shipper accounts.
You can combine your conditions, so you can simply pass `Postmen::ShipperAccount.all(slug: @slug, limit: 5)` to return only 5 shipper accounts.

Shipper accounts are being passed to `app/views/shipper_accounts/index.html.erb` view, where we're displaying them in a simple table.

### 2. List Rates

Similarly to shipper account listing, we're listing all rates. We're not passing
any optional parameters, so all rates are being returned by default.
We could narrow the number of results by passing search criteria like:
```ruby
  @rates = Postmen::Rate.all(status: :failed) # returns only failed Rates
  @rates = Postmen::Rate.all(limit: 5, created_at_min: Date.parse('2016-05-02')) # returns only 5 results created after 2016-05-02
```

### 3. List Labels

Same as in shipper accounts.

### 4. Creating new label

In `app/views/labels/new.html.erb` we're creating a form. This data is being passed to
`app/controllers/labels_controller`, to `create` method.
Because we can't directly map the form data into the `Postmen::Label.create` hash,
we're building a hash with desired structure in the `data` method.
This is most likely a method, which you'd like to implement by yourself in your real application.

Once you pass your hash into the `Postmen::Label.create` method, the SDK does some
basic validation of the data - it checks if all fields are in correct type, if all the
required fields are filled etc. If not, it will fail early, without even making an API call.

If the data seems to have correct structure, we're making an API call, which should return an instance of `Postmen::Label` (or raise an error otherwise).

## Installation

1. Clone/download respository from `https://github.com/krzyzak/postmen-example-app.git`
2. Bundle it: `bundle install`
3. Copy `config/secrets.yml.example` to `config/secrets.yml`, fill in your API key and region

## Running

1. Run your server with `bundle exec rails s`
2. Visit your example page at http://localhost:3000


## Resources

- <a href="https://docs.postmen.com">Postmen API Documentation</a>
- <a href="https://github.com/postmen/postmen-sdk-ruby">Postmen Ruby SDK</a>
- <a href="http://www.rubydoc.info/github/postmen/postmen-sdk-ruby">SDK Documentation</a>
- <a href="https://gitter.im/postmen">Postmen Chat</a>
