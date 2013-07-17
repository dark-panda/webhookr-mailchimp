# Webhookr::Mailchimp
[![Build Status](https://travis-ci.org/zoocasa/webhookr-mailchimp.png?branch=master)](https://travis-ci.org/zoocasa/webhookr-mailchimp)
[![Dependency Status](https://gemnasium.com/zoocasa/webhookr-mailchimp.png)](https://gemnasium.com/zoocasa/webhookr-mailchimp)
[![Code Climate](https://codeclimate.com/github/zoocasa/webhookr-mailchimp.png)](https://codeclimate.com/github/zoocasa/webhookr-mailchimp)

This gem is a plugin for [Webhookr](https://github.com/zoocasa/webhookr) that enables
your application to accept [webhooks from Mailchimp](http://apidocs.mailchimp.com/webhooks/).

## Installation

Add this line to your application's Gemfile:

    gem 'webhookr-mailchimp'

Or install it yourself:

    $ gem install webhookr-mailchimp

## Usage

Once you have the gem installed run the generator to add the code to your initializer.
An initializer will be created if you do not have one.

```console
rails g webhookr:mailchimp:init *initializer_name* -s
```

Run the generator to create an example file to handle MailChimp webhooks.

```console
rails g webhookr:mailchimp:example_hooks
```

Or create a MailChimp handler class for any event that you want to handle. For example
to handle unsubscribes you would create a class as follows:

```ruby
class MailChimpHooks
  def on_unsubscribe(incoming)
    # Your custom logic goes here.
    User.unsubscribe_newletter(incoming.payload.data.email)
  end
end
```

For a complete list of events, and the payload format, see below.

Edit config/initializers/*initializer_name* and change the commented line to point to
your custom Mailchimp event handling class. If your class was called *MailChimpHooks*
the configuration line would look like this:

```ruby
  Webhookr::Mailchimp::Adapter.config.callback = MailChimpHooks
```

To see the list of MailChimp URLs for your application can use when you [configure
MailChimp](http://apidocs.mailchimp.com/webhooks/#configuring-webhooks) webhooks,
run the provided webhookr rake task:

```console
rake webhookr:services
```

Example output:

```console
mailchimp:
  GET	/webhookr/events/mailchimp/19xl64emxvn
  POST	/webhookr/events/mailchimp/19xl64emxvn
```

## MailChimp Events & Payload

### Events

All webhook events are supported. For further information on these events, see the
[MailChimp documentation](http://apidocs.mailchimp.com/webhooks/#event-data).

<table>
  <tr>
    <th>MailChimp Event</th>
    <th>Event Handler</th>
  </tr>
  <tr>
    <td>subscribe</td>
    <td>on_subscribe(incoming)</td>
  </tr>
  <tr>
    <td>unsubscribe</td>
    <td>on_unsubscribe(incoming)</td>
  </tr>
  <tr>
    <td>profile</td>
    <td>on_profile(incoming)</td>
  </tr>
  <tr>
    <td>upemail</td>
    <td>on_upemail(incoming)</td>
  </tr>
  <tr>
    <td>cleaned</td>
    <td>on_cleaned(incoming)</td>
  </tr>
  <tr>
    <td>campaign</td>
    <td>on_campaign(incoming)</td>
  </tr>
</table>

### Payload

The payload is the full payload data from as per the
[MailChimp documentation](http://apidocs.mailchimp.com/webhooks/#event-data), converted to an OpenStruct
for ease of access. Examples for the method call unsubscribe:

```ruby
  incoming.payload.fired_at
  incoming.payload.data.action
  incoming.payload.data.reason
  incoming.payload.data.id
  incoming.payload.data.list_id
  incoming.payload.data.email
  incoming.payload.data.email_type
  incoming.payload.data.merges.EMAIL
  incoming.payload.data.merges.FNAME
  incoming.payload.data.merges.LNAME
  incoming.payload.data.merges.INTERESTS
  incoming.payload.data.ip_opt
  incoming.payload.data.campaign_id
  incoming.payload.data.reason

```

### <a name="supported_services"></a>Supported Service - MailChimp

* [http://apidocs.mailchimp.com/webhooks/](MailChimp - v1.3)

## <a name="works_with"></a>Works with:

webhookr-mailchimp works with Rails 3.1, 3.2 and 4.0, and has been tested on the following Ruby
implementations:

* 1.9.3
* 2.0.0
* jruby-19mode

### Versioning
This library aims to adhere to [Semantic Versioning 2.0.0](http://semver.org/). Violations of this scheme should be reported as
bugs. Specifically, if a minor or patch version is released that breaks backward compatibility, that
version should be immediately yanked and/or a new version should be immediately released that restores
compatibility. Breaking changes to the public API will only be introduced with new major versions. As a
result of this policy, once this gem reaches a 1.0 release, you can (and should) specify a dependency on
this gem using the [Pessimistic Version Constraint](http://docs.rubygems.org/read/chapter/16#page74) with
two digits of precision. For example:

    spec.add_dependency 'webhookr-mailchimp', '~> 1.0'

While this gem is currently a 0.x release, suggestion is to require the exact version that works for your code:

    spec.add_dependency 'webhookr-mailchimp', '0.0.1'

## License

webhookr-mailchimp is released under the [MIT license](http://www.opensource.org/licenses/MIT).

## Author

* [Gerry Power](https://github.com/gerrypower)