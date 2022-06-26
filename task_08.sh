#!/bin/bash
vs_currency=$1
per_page=$2
spacing="          "
padding="0"


which curl &> /dev/null || apt install curl -y
which jq &> /dev/null || apt install jq -y &&{
curl -s coins.json -X 'GET' \
'https://api.coingecko.com/api/v3/coins/markets?vs_currency=pkr&order=market_cap_desc&per_page
=10&page=1&sparkline=false' \
-H 'accept: application/json' | jq . > coins.json

 printf "%-20s | %s | %s | %s | %s | %s | %s | %s\n" "Rank" "${spacing:${'Rank'}}" "Name" "${spacing:${'Name'}}" "Symbol" "${spacing:${'Symbol'}}" "Current Price($(vs_currency))"
}
readarray -t coins < <(jq -c '.[]' coins.json)

for coin in "${coins[@]}"
 do 
  rank=0
  name=$(jq .name <<< "$coin")
  Symbol=$(jq .symbol <<< "$coin")
  CurrentPrice=$(jq .current_price <<< "$coin")

  printf "%-10s | %s | %s | %s | %s | %s | %s | %s\n" "Rank" "${(spacing:'Rank'}}" "Name" "${(spacing:'Name'}}" "Symbol" "${(spacing:'Symbol'}}" "Current Price($(vs_currency))"




if [[$vs_currency == ""]]
then 
echo "Please give currency parameter"
fi 
 
if [[$per_page == ""]]
then 
echo "Please give per page parameter"
fi 





done
