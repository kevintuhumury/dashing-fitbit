# Dashing widget for FITBIT®

Fitbit widget for [Dashing](http://shopify.github.com/dashing), which uses the [Fitgem](https://github.com/whazzmaster/fitgem) gem to retrieve information from the [Fitbit API](https://dev.fitbit.com/). It displays today's steps (with the percentage of today's goal), the lifetime (total) steps, today's distance (with the percentage of today's goal), the lifetime (total) distance, today's calories burned (with the percentage of today's goal) and the active minutes (with the percentage of today's goal) of the day.

Each view which has a goal and thus a percentage, shows the progress in a graph. These graphs and it's icon will change color depending on which percentage you've reached.

Instead of the animated (rotating) views, there also is a non-animated feature, which shows all statistics nicely fitted into a single view. To use it, you'll need to configure the widget correctly. For more information about the configuration of this widget, see [below](https://github.com/kevintuhumury/dashing-fitbit#configuration). For an explanation about the colors, see the [color legend](https://github.com/kevintuhumury/dashing-fitbit#color-legend). An example of all the variations (views) can also be viewed [below](https://github.com/kevintuhumury/dashing-fitbit#preview).

### Fitbit leaderboard

If you want to show your leaderboard on your dashboard, you might want to try out the [Fitbit Leaderboard](https://github.com/kevintuhumury/dashing-fitbit-leaderboard) widget.

## Dependencies

[Fitgem](https://github.com/whazzmaster/fitgem) is a dependency of the Fitbit widget. So, add `fitgem` to the Gemfile of your Dashing dashboard:

```ruby
gem "fitgem"
```

This widget has been [Haml](http://haml.info/)ified (we're using a HAML template in the `/widgets/fitbit` directory instead of an HTML template), so besides the above you'll also need to add `haml` to the Gemfile (if you haven't already):

```ruby
gem "haml"
```

and require it in your `config.ru` file right below the require of dashing itself. So the first few lines of your `config.ru` should look something like the following:

```ruby
require 'dashing'
require 'haml'

configure do
...
```

Now run `bundle install`.

## Authorization

If you're already using the [Fitbit Leaderboard](https://github.com/kevintuhumury/dashing-fitbit-leaderboard) widget, you've already authenticated with the Fitbit API. Therefor you can skip this part of the README and continue with the '[Usage](https://github.com/kevintuhumury/dashing-fitbit#usage)' section. If not, keep on reading.

To actually use the widget on your own Dashboard, you'll have to [request](https://dev.fitbit.com/apps/new) an API key and shared secret from Fitbit. The steps below will take you through the entire process.

1. Create a file called `.fitbit.yml` in the root of your Dashboard with the content below and add the `consumer_key` and `consumer_secret` you've received from the [Fitbit site](https://dev.fitbit.com/apps/new).

  ```yaml
  oauth:
      consumer_key: "YOUR_KEY"
      consumer_secret: "YOUR_SECRET"
  ```

2. Copy the `/lib/fitbit_authorizer.rb` file into the root of your Dashboard and enable it for execution by running the following on the command line:

  ```bash
  chmod +x fitbit_authorizer.rb
  ```

3. Now call that script by entering the following on the command line:

  ```bash
  ./fitbit_authorizer.rb
  ```

  The script will ask you to copy and paste the shown URL into your browser. You'll have to login to Fitbit.com and authorize this widget to access your data. Once you've done that, you'll receive a PIN code from Fitbit which needs to be copied and pasted back on the command line.

  After pasting that code and hitting `<Enter>` the script will add a `token`, `secret` and `user_id` to the `.fitbit.yml` file.

  The above should only be done once, so basically you could now remove the `fitbit_authorizer.rb` file and move on to the next section (Usage). Just make sure the `.fitbit.yml` file looks something like the following:

  ```yaml
  oauth:
      consumer_key: "YOUR_KEY"
      consumer_secret: "YOUR_SECRET"
      token: "TOKEN"
      secret: "SECRET"
      user_id: "USER_ID"
  ```

## Usage

To use this widget, copy `fitbit.coffee`, `fitbit.haml` and `fitbit.sass` into the `/widgets/fitbit` directory of your dashboard. Copy the `fitbit.png`, `fitbit-icons.png`, `active.png`, `distance.png`, `calories.png` and `steps.png` images to the `/assets/images/fitbit` directory. Put the `/jobs/fitbit.rb` file in the `/jobs` folder and the `lib/fitbit.rb` file into the `lib` directory. If there isn't one yet, create it.

When you've already added the [Fitbit Leaderboard](https://github.com/kevintuhumury/dashing-fitbit-leaderboard) widget, you already have the `/lib/fitbit.rb` and `/assets/images/fitbit/fitbit.png` file. Don't worry about that, just replace them. They should be exactly the same.

To include the widget on your dashboard, add the following snippet to the dashboard layout file:

```ruby
<li data-row="1" data-col="1" data-sizex="1" data-sizey="1">
  <div data-id="fitbit" data-view="Fitbit"></div>
</li>
```
When you're using a Hamlified dashboard layout (hey, you're already using a Hamlified widget, so why not Hamlify your dashboard layout?), you could also do the following:

```ruby
%li(data-row="1" data-col="1" data-sizex="1" data-sizey="1")
  %div(data-id="fitbit" data-view="Fitbit")
```

Now, if you haven't already, authorize the widget over at the Fitbit website as described above. Once that's done, you should be able to start using it!

## Configuration

By default the Fitbit widget will use the Metric system and displays the last sync time as hh:mm. You're able to adjust those settings though.

```ruby
# widget configuration

unit_system   = "METRIC"
date_format   = "%H:%M"
animate_views = true
```

The `unit_system` in the above configuration can be changed to `en_US`, `en_GB` or can be removed. The fitgem will then start using the default, which is `en_US`. The `date_format` can be changed to something of your liking. It's a `DateTime`, so you could include the date also.

As you can see there also is a third configuration option, namely `animate_views`. When this option is set to `true`, the widget will animate (rotate) through the available statistics and will show each statistic in a separate view. When it's set to `false` it will show a single view with a list of all the available statistics. For an example of these views, see [below](https://github.com/kevintuhumury/dashing-fitbit#preview)

## Color legend

This widget currently has the views as shown below. Depending on your own data, the daily goal percentage (in the graph views) and thus the color of the graph (and it's icon) will vary. They'll change depending on the intensity of your activities.

![legend](https://f.cloud.github.com/assets/412952/1143117/8e50ffdc-1d1f-11e3-867a-baa6b50636e4.png)

## Preview

![fitbit-views](https://f.cloud.github.com/assets/412952/1143107/24563db0-1d1d-11e3-8e0c-d2ece6312a00.png)

The above views are shown when the `animate_views` configuration option has been set to `true`. When it's set to `false`, the below (the left view) will be shown. The right view will be shown when the API call limit (currently 150 calls per hour) has been reached.

![fitbit-views-more](https://f.cloud.github.com/assets/412952/1204958/64830cda-2572-11e3-9852-a36da1451944.png)

## Copyright

Copyright 2013 Kevin Tuhumury. Released under the MIT License. Fitbit is a registered trademark and service mark of Fitbit, Inc. The Dashing widget is designed for use with the Fitbit platform. This product is not put out by Fitbit, and Fitbit does not service or warrant the functionality of this product.
