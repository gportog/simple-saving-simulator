#!/bin/bash

###############################################################################
#                                                                             #
#									                                          #
#                       bank_simulator.sh - Version 1.1.0                     # 
# --------------------------------------------------------------------------- #
#                                                                             #
#                                                                             #
# AUTHOR:Gustavo Porto Guedes (gportog)                                       #
# DATE:Jan, 28 2017                                                           #
# OBJECTIVES:The objective of this script is to make provisions of amount in  #
#  a saving account after movimentations in the account.                      #
# FUNCTIONS OF THE SCRIPT: menu(initial screen) information(details about     #
#  options of the menu) option_A(ideal calc) option_B(calc with imprevists)   #
#                                                                             #
###############################################################################


# ======================= Handlers ======================= #

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
 # checks if the temp_file.txt starts with a number of 1 to 9 that could be follow by 1 
 # until 9 digits. Optionaly this number could be decimal:
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

# ========================= APP ========================== #

menu ()
{
 clear
 echo ''
 echo '###############################################################################'
 echo '#                                                                             #'
 echo '#                                                                             #'
 echo '#                      BANK.sh: Simulação de Poupança                         #'
 echo '# --------------------------------------------------------------------------- #'
 echo '#                                               Author:gportog  Version 1.1.0 #'
 echo '#                                                                             #'
 echo '#                                                                             #'
 echo '# A)Calculo sem imprevistos                                                   #'
 echo '# B)Calculo com imprevistos                                                   #'
 echo '# i)Info sobre opções A e B                                                   #'
 echo '# s)Sair do programa                                                          #'
 echo '#                                                                             #'
 echo '#                                                                             #'
 echo '###############################################################################' 
	echo ''
	echo 'Opção: '
	read -n1 option
	case $option in
		a | A )
			option_A;;
		b | B )
			option_B;;
		i | I )
			doc;;
		s | S )
			echo''
			echo 'Saindo...'
			sleep 3
			exit ;;
		* )
			echo''
			echo 'Opção inválida!'
			echo ''
			menu ;;
	esac
}


option_A() {

echo ''

read -p 'Quantidade inicial na poupança[R$]: ' amount
check_decimal_input $amount option_A

read -p 'Rendimento mensal[%]: ' interest_rate
check_interest_rate_input $interest_rate option_A

read -p 'Depósitos mensais[R$]: ' month_amount
check_decimal_input $amount option_A

read -p 'Período aplicado[meses]: ' month
check_month_input $month option_A

for ((i=1; i<=$month; i++))
do
profitability=`bc<<EOF
scale=5
$amount * $interest_rate
EOF`
 
amount=`bc<<EOF
scale=5
$amount + $profitability + $month_amount
EOF`
done

echo $amount

}

option_B() {

echo ''

if [ -z $amount ] || [ -z $interest_rate ]
then 
 read -p 'Quantidade inicial na poupança[R$]: ' amount
 check_decimal_input $amount option_B
 read -p 'Rendimento mensal[%]: ' interest_rate
 check_interest_rate_input $interest_rate option_B
fi

amount_month option_B

profitability=`bc<<EOF
scale=5
$amount * $interest_rate
EOF`
 
amount=`bc<<EOF
scale=5
$amount + $profitability + $month_amount
EOF`

echo "Você terá disponível no próximo mês R$ $amount"
continue_function option_B

}

doc() {
	
 echo -e "
  \n
  ' ----------------------------------------------------------------------- '
  '                              Documentation                              '
  ' ----------------------------------------------------------------------- '
  '                                                                         '
  ' A Calculo sem imprevistos:                                              '
  ' 	Você irá definir uma quantia inicial, juros iniciais em %,          '
  '		e uma quantidade a depositar mensalmente na poupança, sem           '
  '		considerar depósitos irregulares ou retirada da poupança.           '
  ' B Calculo com imprevistos:                                              '
  '		Você irá definir uma quantia inicial, juros iniciais em %,          '
  '     porém dessa vez você irá considerar imprevistos, tais como:         ' 
  '     depósitos irregulares ou retiradas mês à mês.                       '
  '                                                                         '
  ' ----------------------------------------------------------------------- '
  \n"
 continue_function doc

}

menu