echo "Please enter number of items:"
read NUMBER_OF_ITEMS
echo "Please enter the individual price per item:"
read PRICE_PER_ITEM
echo "Please enter your 2-character state code:"
read STATE_CODE
echo $NUMBER_OF_ITEMS $PRICE_PER_ITEM $STATE_CODE
let "ORDER_VALUE=$PRICE_PER_ITEM*$NUMBER_OF_ITEMS"
echo $ORDER_VALUE

if [ "$ORDER_VALUE" -gt 50000 ]
  then
    echo "Your discount value is 15%"
    DISCOUNT_VALUE=$( echo "$ORDER_VALUE*0.85" | bc )
    echo $DISCOUNT_VALUE
elif [ "$ORDER_VALUE" -gt 10000 ]
  then
    echo "Your discount value is 10%"
    DISCOUNT_VALUE=$( echo "$ORDER_VALUE*0.90" | bc )
elif [ "$ORDER_VALUE" -gt 7000 ]
  then
    echo "Your discount value is 7%"
    DISCOUNT_VALUE=$( echo "$ORDER_VALUE*0.93" | bc )
elif [ "$ORDER_VALUE" -gt 5000 ]
  then
    echo "Your discount value is 5%"
    DISCOUNT_VALUE=$( echo "$ORDER_VALUE*0.95" | bc )
elif [ "$ORDER_VALUE" -gt 1000 ]
  then
    echo "Your discount value is 3%"
    DISCOUNT_VALUE=$( echo "$ORDER_VALUE*0.97" | bc )
else
  echo "No discount applicable!"
  DISCOUNT_VALUE=$ORDER_VALUE
fi

#echo "Order is: $DISCOUNT_VALUE"
case $STATE_CODE in
  UT)
    echo "Your tax rate value is 6.85%"
    TAXED_VALUE=$( echo "$DISCOUNT_VALUE*1.0685" | bc)
    ;;
  NV)
    echo "Your tax rate value is 8.00%"
    TAXED_VALUE=$( echo "$DISCOUNT_VALUE*1.08" | bc)
    ;;
  TX)
    echo "Your tax rate value is 6.25%"
    TAXED_VALUE=$( echo "$DISCOUNT_VALUE*1.0625" | bc)
    ;;
  AL)
    echo "Your tax rate value is 4.00%"
    TAXED_VALUE=$( echo "$DISCOUNT_VALUE*1.04" | bc)
    ;;
  CA)
    echo "Your tax rate value is 8.25%"
    TAXED_VALUE=$( echo " $DISCOUNT_VALUE*1.0825" | bc)
    ;;
  *)
    echo "State not known - no tax applied"
    TAXED_VALUE=$DISCOUNT_VALUE
esac
# FINAL_ORDER_VALUE=$( echo " $TAXED_VALUE" | bc)
echo "Final order value: $TAXED_VALUE"
