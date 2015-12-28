PATH_TO_RUBY_MODULE=app/domain/city_for_zipcode.rb
PATH_TO_CSV=db/free-zipcode-database-Primary.csv

if [ -f ${PATH_TO_RUBY_MODULE} ]; then
  echo "Regenerating Ruby Module..."
  rm ${PATH_TO_RUBY_MODULE}
else
  echo "Generating Ruby Module..."
fi

echo "Converting from ${PATH_TO_CSV} to ${PATH_TO_RUBY_MODULE}..."

echo "module CityForZipcode" >> ${PATH_TO_RUBY_MODULE}
echo "  ZIP_TO_CITY = {" >> ${PATH_TO_RUBY_MODULE}

# tail -n +2 :: to strip off the header row of the CSV
# -F\" :: to indicate delimiter is quotes
# OFS="" :: to output no extra spaces

cat ${PATH_TO_CSV} | \
 tail -n +2 | \
 awk -F\" 'OFS="";{ print "    \"", $2,"\" => \"", $6, "\"," }' \
 >> ${PATH_TO_RUBY_MODULE}

echo "  }" >> ${PATH_TO_RUBY_MODULE}
echo "end" >> ${PATH_TO_RUBY_MODULE}

echo "Done."
