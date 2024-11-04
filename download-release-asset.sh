GITHUB_API_BASE_URL="https://api.github.com"
org=Hitham07
repo=source

response_file=/tmp/releases-latest.json
response=$(curl -sH "Authorization: Bearer ${GITHUB_TOKEN}" ${GITHUB_API_BASE_URL}/repos/${org}/${repo}/releases/latest > ${response_file} )

asset_id=$(cat ${response_file} | jq -r '.assets[0] .id')
asset_name=$(cat ${response_file} | jq -r '.assets[0] .name')

curl ${curl_custom_flags} \
     -L \
     -H "Accept: application/octet-stream" \
     -H "Authorization: Bearer ${GITHUB_TOKEN}" \
        "${GITHUB_API_BASE_URL}/repos/${org}/${repo}/releases/assets/${asset_id}" -o "/tmp/${asset_name}"


mkdir -p server1
run: tar -xzvf /tmp/${asset_name} -C server1
