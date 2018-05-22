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

discount_value () {
  echo "Your discount value is $1%"
  discountvalue=$(echo "$ordervalue -($ordervalue / 100 * $1)" | bc)
}

if [ "${ordervalue}" -gt 50000 ]
  then
    discount_value 15
elif [ "${ordervalue}" -gt 10000 ]
  then
    discount_value 10
elif [ "${ordervalue}" -gt 7000 ]
  then
    discount_value 7
elif [ "${ordervalue}" -gt 5000 ]
  then
    discount_value 5
elif [ "${ordervalue}" -gt 1000 ]
  then
    discount_value 3
else
  echo "No discount applicable!"
    discountvalue=$(echo "$ordervalue *1" | bc)
fi
echo "Order value after discounts: ${discountvalue}"
echo "-"


 case $state in
   UT)
    echo "Your tax rate value is 6.85%"
    taxedvalue=$(echo "$discountvalue *1.0685" | bc)
    ;;
   NV)
    echo "Your tax rate value is 8.00%"
    taxedvalue=$(echo "$discountvalue *1.08" | bc)
    ;;
   TX)
    echo "Your tax rate value is 6.25%"
    taxedvalue=$(echo "$discountvalue *1.0625" | bc)
    ;;
   AL)
    echo "Your tax rate value is 4.00%"
    taxedvalue=$(echo "$discountvalue *1.04" | bc)
    ;;
   CA)
    echo "Your tax rate value is 8.25%"
    taxedvalue=$(echo "$discountvalue *1.0825" | bc)
    ;;
   *)
    echo "State not known - no tax applied"
    taxedvalue=$(echo "$discountvalue *1" | bc)
 esac
echo "Order value after tax: ${taxedvalue}"
