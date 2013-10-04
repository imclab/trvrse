trvrse
======

Trvrse is a sample app that uses the TripIt API. It was built in two weeks by our intern Robert, so please excuse the terrible hackish code.

Getting It Set Up
-----------------

1. Clone the app to your computer
1. `cd trvrse`
1. Generate your own secret token: `echo "Tripit::Application.config.secret_token = '$(rake secret)'" > config/initializers/secret_token.rb`
1. Set your TripIt key and secret in `config/initializers/tripit.rb`. You can get an API key at <http://tripit.com/developer>
1. Get a Google API token, enable it for Maps APIv2, and put it in the bottom of config/application.rb (This step is optional - it allows static mini-maps in the image view page to be shown)
1. Run it: `rails server`
1. Check it out: <http://localhost:3000>

What Does it Do?
----------------

Check out all these shmancy features:

- You can log in with your TripIt account, and see all your trips plotted on a map.
- You can review locations you've been to, complete with a slider to rank how much you liked or hated the place. You can also see other people's reviews (complete with gravatar profiles), and see an aggregate score for various locations around the globe.
- When viewing a location, a background image and a short description of the location is pulled from Wikipedia.
- You can upload photos from one of your trips to share it. If there is EXIF geolocation data, trvrse will plot it on the map, too!
- You can search through other people's reviews to find locations that match the types of things you want to do! For instance, if somebody reviews Paris as "Awesome! It had great food!" then you can search for "great food" and Paris will be one of the locations that shows up.