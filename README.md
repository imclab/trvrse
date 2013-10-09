trvrse
======

Trvrse is a sample app that uses the TripIt API. It was built in two weeks by our intern Robert, so please excuse the hackish code.

Getting It Set Up
-----------------

1. Get Trvrse installed and set up:
  ```sh
  # Clone the app to your computer
  git clone git@github.com:tripit/trvrse.git

  # Enter the directory and install dependencies
  cd trvrse
  bundle install

  # Set up the database
  bundle exec rake db:schema:load

  # Generate your own secret token: 
  echo "Tripit::Application.config.secret_token = '$(bundle exec rake secret)'" > config/initializers/secret_token.rb
  ```

1. Set your TripIt key and secret in `config/initializers/tripit.rb`. You can get an API key at <http://tripit.com/developer>

1. *Optional —* Get a Google API token, enable it for the Google Static Maps API, and set it at the bottom of `config/application.rb`. This is used to put little mini-maps next to geotagged images. You can get your API key in the [Google API Console](https://code.google.com/apis/console), under API Access -> Simple API Access -> API Key.

1. Start the server: `bundle exec rails server`

1. Check it out: <http://localhost:3000>

What Does it Do?
----------------

Check out all these shmancy features:

- You can log in with your TripIt account, and see all your trips plotted on a map. You can also see locations other people have gone to.
- You can review locations you've been to, complete with a slider to rank how much you liked or hated the place. You can also see other people's reviews (complete with gravatar profiles), and see an aggregate score for various locations around the globe. Additionally, on the map, the aggregate score is represented by the markers filling up. The more full a marker is, the higher the rating!
- See your current location marked by a blue dot on the map.
- When viewing a location, a background image and a short description of the location is pulled from Wikipedia.
- You can upload photos from one of your trips to share it. If there is EXIF geolocation data, trvrse will plot it on the map, too!
- You can search through other people's reviews to find locations that match the types of things you want to do! For instance, if somebody reviews Paris as "Awesome! It had great food!" then you can search for "great food" and Paris will be one of the locations that shows up.
