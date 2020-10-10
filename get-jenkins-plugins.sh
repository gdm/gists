# Generates list of jenkins plugins compatible with /usr/local/bin/install-plugins.sh (distributed in jenkins Docker)
# The output of this command (colon-separated list of items like 'htmlpublisher:1.23') should be 
# passed as an input for /usr/local/bin/install-plugins.sh script

curl -u $JENKINS_USER:$JENKINS_PASSWORD \
 "http://localhost:8080/pluginManager/api/xml?depth=1&xpath=/*/*/shortName|/*/*/version&wrapper=plugins" | \
  perl -pe 's/.*?<shortName>([\w-]+).*?<version>([^<]+)(<\/\w+>)+/\1 \2\n/g' | \
  sed 's/ /:/' | sort

