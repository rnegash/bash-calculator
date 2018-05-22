!/bin/bash
items="$1"
price="$2"
state="$3"
echo "Number of items: $items"
echo "Price per item: $price"
echo "State code: $state"
ordervalue=$((items*price))
echo "Order value: ${ordervalue}"
echo "-"

discounter () {
  echo "Your discount value is $1%"
  discountvalue=$(echo "$ordervalue -($ordervalue / 100 * $1)" | bc)
}

if [ "${ordervalue}" -gt 50000 ]
  then
    discounter 15
elif [ "${ordervalue}" -gt 10000 ]
  then
    discounter 10
elif [ "${ordervalue}" -gt 7000 ]
  then
    discounter 7
elif [ "${ordervalue}" -gt 5000 ]
  then
    discounter 5
elif [ "${ordervalue}" -gt 1000 ]
  then
    discounter 3
else
  echo "No discount applicable!"
    discountvalue=$(echo "$ordervalue *1" | bc)
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
    taxedvalue=$(echo "$discountvalue *1" | bc)
 esac
echo "Order value after tax: ${taxedvalue}"
