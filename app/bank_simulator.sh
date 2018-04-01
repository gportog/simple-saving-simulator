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

txtund=$(tput sgr 0 1)          # Underline
txtbld=$(tput bold)             # Bold
bldred=${txtbld}$(tput setaf 1) #  red
bldylw=${txtbld}$(tput setaf 3) #  yellow
bldgrn=${txtbld}$(tput setaf 2) #  green
txtrst=$(tput sgr0)             # Reset
INFO=${bldgrn}INFO:${txtrst}
ERROR=${bldred}ERROR:${txtrst}
WARN=${bldylw}WARNING:${txtrst}
MESSAGE="Check if this file exists, if it is not 
empty or with executable rights."

if [ ! -x "handlers/handlers.sh" ] || [ ! -s handlers/handlers.sh ]; 
then echo "$ERROR handlers/handlers.sh. $MESSAGE"; exit -1; fi
if [ ! -x "handlers/menus.sh" ] || [ ! -s handlers/menus.sh ];
then echo "$ERROR handlers/menus.sh. $MESSAGE";  exit -1; fi 
if [ ! -x "handlers/calcs.sh" ] || [ ! -s handlers/calcs.sh ];
then echo "$ERROR handlers/calcs.sh. $MESSAGE";  exit -1; fi                            

source "handlers/handlers.sh" # secondary functions
source "handlers/menus.sh" # main menu and the script info
source "handlers/calcs.sh" # functions called by the main menu

menu