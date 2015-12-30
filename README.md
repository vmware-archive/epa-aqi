
# Setup

## Create Your config/local_env.yml

In order to access AirNow, you need an API key.  Go get one and then configure the app with it:

```
AIRNOW_API_KEY: 'ASDF11643-XXXX-9999-WWWW-32367H3AB666'
```
(use *your* API key, that's not a real one).


## Zip code to City Hash Generator

To facilitate looking up the name of a city, given its zip code, we're using a CSV download from:

    http://federalgovernmentzipcodes.us/

using the "Just one "Primary" location for each Zip code" dataset.


If you download an updated copy of this file, place it in the `db/` direction and re-run the converter:

```
$ convert_csv_database_to_zipcode2city_hash.sh
```

# Deploy

```
cf push epa-aqi-acceptance
cf set-env epa-aqi-acceptance RAILS_SERVE_STATIC_FILES "true"
cf set-env epa-aqi-acceptance AIRNOW_API_KEY "*your 'acceptance' AirNow API key*"
cf restage epa-aqi-acceptance
```
