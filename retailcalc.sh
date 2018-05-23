!/bin/bash
items="$1"
price=$(echo "$2" | bc)
state="$3"
echo "Number of items: $items"
echo "Price per item: $price"
echo "State code: $state"
ordervalue=$(echo "$items*$price" | bc)
echo "Order value: ${ordervalue}"
echo "-"

discounter () {
  echo "Your discount value is $1%"
  discountvalue=$(echo "$ordervalue -($ordervalue / 100 * $1)" | bc)
}

if (( $(echo "${ordervalue} > 50000" | bc -l) )) ; then discounter 15
elif (( $(echo "${ordervalue} > 10000" | bc -l) )) ; then discounter 10
elif (( $(echo "${ordervalue} > 7000" | bc -l) )) ; then discounter 7
elif (( $(echo "${ordervalue} > 5000" | bc -l) )) ; then discounter 5
elif (( $(echo "${ordervalue} > 1000" | bc -l) )) ; then discounter 3
else echo "No discount applicable!"
  discountvalue=$ordervalue
fi

echo "Order value after discounts: ${discountvalue}"
echo "-"

tax () {
  echo "$state tax applied: $1%"
  taxedvalue=$(echo "scale=2; $discountvalue +($discountvalue / 100 * $1)" | bc)
}

case $state in
  UT)
    tax 6.85
    ;;
  NV)
    tax 8
    ;;
  TX)
    tax 6.25
    ;;
  AL)
    tax 4
    ;;
  CA)
    tax 8.25
    ;;
   *)
    echo "State not known - no tax applied"
    taxedvalue=$discountvalue
 esac
echo "Order value after tax: ${taxedvalue}"
