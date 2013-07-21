# Dashing widget for FITBIT®

Fitbit widget for [Dashing](http://shopify.github.com/dashing), which uses the [Fitgem](https://github.com/whazzmaster/fitgem) gem to retrieve information from the [Fitbit API](https://dev.fitbit.com/). It displays today's steps (with the percentage of today's goal), the lifetime (total) steps, today's distance (with the percentage of today's goal), the lifetime (total) distance, today's calories burned (with the percentage of today's goal) and the very active minutes of the day. An example of some of these can be viewed [below](https://github.com/kevintuhumury/dashing-fitbit#preview)

## Dependencies

[Fitgem](https://github.com/whazzmaster/fitgem) is a dependency of the Fitbit widget. So, add `fitgem` to the Gemfile of your Dashing dashboard:

```ruby
gem "fitgem"
```

and run `bundle install`.

## Authorization

To actually use the widget on your own Dashboard, you'll have to [request](https://dev.fitbit.com/apps/new) an API key and shared secret from Fitbit. The steps below will take you through the entire process.

1. Create a file called `.fitbit.yml` in the root of your Dashboard with the content below and add the `consumer_key` and `consumer_secret` you've received from the [Fitbit site](https://dev.fitbit.com/apps/new).

  ```yaml
  oauth:
      consumer_key: "YOUR_KEY"
      consumer_secret: "YOUR_SECRET"
  ```

2. Copy the `/lib/fitbit_credentials.rb` file into the root of your Dashboard and enable it for execution by running the following on the command line:

  ```bash
  chmod +x fitbit_credentials.rb
  ```

3. Now call that script by entering the following on the command line:

  ```bash
  ./fitbit_credentials.rb
  ```

  The script will ask you to copy and paste the shown URL into your browser. You'll have to login to Fitbit.com and allow this widget to access your data. Once you've done that, you'll receive a verifier code from Fitbit which needs to be copied and pasted back on the command line.

  After pasting that code and hitting `<Enter>` the script will add a `token`, `secret` and `user_id` to the `.fitbit.yml` file.

  The above should only be done once, so basically you could now remove the `fitbit_credentials.rb` file and move on to the next section (Usage). Just make sure the `.fitbit.yml` file looks something like the following:

  ```yaml
  oauth:
      consumer_key: "YOUR_KEY"
      consumer_secret: "YOUR_SECRET"
      token: "TOKEN"
      secret: "SECRET"
      user_id: "USER_ID"
  ```

## Usage

To use this widget, copy `fitbit.coffee`, `fitbit.html` and `fitbit.sass` into the `/widgets/fitbit` directory of your dashboard. Copy both `fitbit.png` and `fitbit-icons.png` to the `/assets/images` directory, put the `/jobs/fitbit.rb` file in the `/jobs` folder and the `lib/fitbit.rb` file into the `lib` directory. If there isn't one yet, create it.

To include the widget on your dashboard, add the following snippet to the dashboard layout file:

```ruby
<li data-row="1" data-col="1" data-sizex="1" data-sizey="1">
  <div data-id="fitbit" data-view="Fitbit"></div>
</li>
```

Now, if you haven't already, authorize the widget over at the Fitbit website as described above. Once that's done, you should be able to start using it!

## Configuration

By default the Fitbit widget will use the Metric system and displays the last sync time as hh:mm. You're able to adjust those settings though.

```ruby
# widget configuration

unit_system = "METRIC"
date_format = "%H:%M"
```

The `unit_system` in the above configuration can be changed to `en_US`, `en_GB` or can be removed. The fitgem will then start using the default, which is `en_US`. The `date_format` can be changed to something of your liking. It's a `DateTime`, so you could include the date also.

## Preview

![image](https://f.cloud.github.com/assets/412952/830986/889c6f7c-f191-11e2-8fa9-e114681b5f6a.png)

## Copyright

Copyright 2013 Kevin Tuhumury. Released under the MIT License. Fitbit is a registered trademark and service mark of Fitbit, Inc. The Dashing widget is designed for use with the Fitbit platform. This product is not put out by Fitbit, and Fitbit does not service or warrant the functionality of this product.
