# Webhookr::Mailchimp
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/zoocasa/webhookr-mailchimp)

This gem is a plugin for the [Webhookr gem](https://github.com/zoocasa/webhookr) that enables
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

Create a MailChimp handler class for any event that you want to handle. For example
to handle unsubscribes you would create a class as follows:

```ruby
class MailChimpHooks
  def on_unsubscribe(payload)
    # Your custom logic goes here.
    User.unsubscribe_newletter(payload.data.email)
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

To see the list of MailChimp URLs for your application, that you can use to [configure
MailChimp](http://apidocs.mailchimp.com/webhooks/#configuring-webhooks) for posting webhooks to:

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
    <td>on_subscribe(payload)</td>
  </tr>
  <tr>
    <td>unsubscribe</td>
    <td>on_unsubscribe(payload)</td>
  </tr>
  <tr>
    <td>profile</td>
    <td>on_profile(payload)</td>
  </tr>
  <tr>
    <td>upemail</td>
    <td>on_upemail(payload)</td>
  </tr>
  <tr>
    <td>cleaned</td>
    <td>on_cleaned(payload)</td>
  </tr>
  <tr>
    <td>campaign</td>
    <td>on_campaign(payload)</td>
  </tr>
</table>

### Payload

The payload is the full payload data from as per the
[MailChimp documentation](http://apidocs.mailchimp.com/webhooks/#event-data), converted to an OpenStruct
for ease of access. Examples for the method call unsubscribe:

```ruby
  payload.fired_at
  payload.data.action
  payload.data.reason
  payload.data.id
  payload.data.list_id
  payload.data.email
  payload.data.email_type
  payload.data.merges.EMAIL
  payload.data.merges.FNAME
  payload.data.merges.LNAME
  payload.data.merges.INTERESTS
  payload.data.ip_opt
  payload.data.campaign_id
  payload.data.reason

```




### <a name="supported_services"></a>Supported Service - MailChimp

* [http://apidocs.mailchimp.com/webhooks/](MailChimp - v1.3)

## <a name="works_with"></a>Works with:

webhookr-mailchimp works with Rails 3.1 and 3.2, and has been tested on the following Ruby
implementations:

* JRuby 1.7.1
* MRI 1.8.7
* MRI 1.9.2
* MRI 1.9.3
* Rubinius 1.2.4
* Ruby EE 1.8.7

Pending:

* MRI 2.0

## License

webhookr-mailchimp is released under the [MIT license](http://www.opensource.org/licenses/MIT).

## Author

* [Gerry Power](https://github.com/gerrypower)