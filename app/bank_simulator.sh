#!/bin/bash

###############################################################################
#                                                                             #
#									                                          #
#                       bank_simulator.sh - Version 1.1.0                     # 
# --------------------------------------------------------------------------- #
#                                                                             #
#                                                                             #
# AUTHOR: Gustavo Porto Guedes (gportog)  									  #
# CONTACT: gustavo.guedes@fatec.sp.gov.br                                     #
# DATE: Jan, 28 2017                                                          #
# OBJECTIVES: The objective of this script is to make provisions of amount in #
#  a saving account after movimentations in the account.                      #
# FUNCTIONS OF THE SCRIPT: menu(initial screen) information(details about     #
#  options of the menu) option_A(ideal calc) option_B(calc with imprevists)   #
#                                                                             #
###############################################################################

source "handlers.sh"
source "menus.sh"

# ========================= APP ========================== #
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

menu