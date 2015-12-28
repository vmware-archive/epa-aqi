
# Setup

## Zip code to City Hash Generator

To facilitate looking up the name of a city, given its zip code, we're using a CSV download from:

    http://federalgovernmentzipcodes.us/

using the "Just one "Primary" location for each Zip code" dataset.


If you download an updated copy of this file, place it in the `db/` direction and re-run the converter:

```
$ convert_csv_database_to_zipcode2city_hash.sh
```
