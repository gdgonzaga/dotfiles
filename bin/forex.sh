for i in $3
  do
    wget -qO- "http://www.google.com/finance/converter?a=$1&from=$2&to=$i&hl=es" |  sed '/res/!d;s/<[^>]*>//g';
  done
