#!/bin/bash

if [[ -z "$1" ]]; then
    echo "Please provide the archivebox password as the first argument"
    exit 1
fi

if [[ -z "$2" ]]; then
    echo "Please provide the URL to archive as the second argument"
    exit 2
fi

password="$1"
url="$2"
archive_box_host="http://49.12.106.214:8000"

csrf_token_field=$(curl -s -c cookies.txt "$archive_box_host/admin/login/?next=/admin/" | grep -o "name=['\"]csrfmiddlewaretoken['\"] value=['\"][^'\"]*" | sed -e 's/name="//' -e 's/\" value=\"/=/' -e 's/\"$//')
data="$csrf_token_field&username=archivebox&password=$password"
curl -v -b cookies.txt -c cookies.txt \
	--data "$data" \
	-H 'Content-Type: application/x-www-form-urlencoded' \
	"$archive_box_host/admin/login/?next=/admin/"

# there's a new CSRF token set when calling the add page. Parse that one from the cookies.txt file
new_csrf_token=$( cat cookies.txt | grep "csrftoken" | awk '{ print $7 }')
add_data="csrfmiddlewaretoken=$new_csrf_token&parser=auto&tag=&depth=0&archive_methods=title&archive_methods=favicon&archive_methods=headers&archive_methods=singlefile&archive_methods=archive_org"
curl -v -b cookies.txt -c cookies.txt \
	-H 'Content-Type: application/x-www-form-urlencoded' \
	--data-urlencode "url=$url" \
	--data "$add_data" \
	"$archive_box_host/add/"


