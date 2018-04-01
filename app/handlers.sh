# AUTHOR: Gustavo Porto Guedes (gportog)
# CONTACT: gustavo.guedes@fatec.sp.gov.br

txtund=$(tput sgr 0 1)          # Underline
txtbld=$(tput bold)             # Bold
bldred=${txtbld}$(tput setaf 1) #  red
bldylw=${txtbld}$(tput setaf 3) #  yellow
bldgrn=${txtbld}$(tput setaf 2) #  green
txtrst=$(tput sgr0)             # Reset
INFO=${bldgrn}INFO:${txtrst}
ERROR=${bldred}ERROR:${txtrst}
WARN=${bldylw}WARNING:${txtrst}

# check_amount_input $number $callback
check_decimal_input () {
 echo $1 > temp_file.txt
 # checks if the temp_file.txt starts with a number of 1 to 9 that could 
 # be follow by 1 until 9 digits. Optionaly this number could be decimal:
 match=`cat temp_file.txt | grep -P "^[1-9]{1,9}[\.[0-9]{1,4}]?$|^[1-9]{1,9}$"`
 if [ -z $match ]
 then
  echo "$ERROR Quantia deve ser positiva!"
	   $2
 fi
}

# check_interest_rate_input $interest_rate $callback
check_interest_rate_input () {
 echo $1 > temp_file.txt
 match=`cat temp_file.txt | grep -P "^[1-9]{1,2}$|^[0-9]{1,2}\.[0-9]{1,2}$"`
 if [ -z $match ]
 then
  echo "$ERROR Valor inválido!"
	   $2
 fi
 if [ $match = "0.0" ] || [ $match = "0.00" ]
 then
  echo "$ERROR Valor inválido!"
       $2
 fi
 calc_interest_rate $1
}

# check_month_input $month $callback
check_month_input () {
 if [ $1 -lt 1 ]
 then
  echo "$ERROR Quantidade de meses deve ser inteira e positiva!"
  $2
 fi
}

# typeoF_interest_rate $interest_rate $callback
calc_interest_rate() {
interest_rate=`bc<<EOF
scale=5
$1/100
EOF`
}

# amount_month $callback
amount_month() {
  read -p 'Depósito desse mês[R$]: ' month_amount
  check_decimal_input $month_amount $1
}

# continue_function $callback
continue_function() {
 echo 'Deseja continuar a operação[Y/N]: '
 read -n1 option
 case $option in
	 y | Y )
	       $1 ;;
	 n | N )
	 	   menu ;;
	 * )
		   echo''
		   echo 'Opção inválida!'
		   echo ''
		   continue_function $1 ;;
 esac	 
}