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


#check_common_input $amount $interest_rate $month_amount $callback
check_common_input () {
 if [ $1 -gt 0 ]
 then
  if [[ $2 == ?(+|-)+([0-9]) ]] 
  then
   typeoF_interest_rate $2
   if [ $3 -ge 0 ]
   then
    echo "$INFO Realizando os calculos..."
   else
    echo "$ERROR Depósito mensal inválido!"
    $4
   fi
  else
   echo "$ERROR Juro mensal inválido!"
   $4
  fi
 else
  echo "$ERROR Quantia inicial inválida, o programa
       apenas quantia inicial inteira!"
  $4
 fi   
}


#check_month_input $month $callback
check_month_input () {
 if [ $1 -lt 1 ]
 then
     echo "$ERROR Quantidade de meses inválida!"
     $2
 fi
}

#typeoF_interest_rate $interest_rate $callback
typeoF_interest_rate() {
interest_rate=`bc<<EOF
scale=5
$1/100
EOF`
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
			information;;
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
read -p 'Rendimento mensal[%]: ' interest_rate
read -p 'Depósitos mensais[R$]: ' month_amount
read -p 'Período aplicado[meses]: ' month

check_common_input $amount $interest_rate $month_amount option_A
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


menu
