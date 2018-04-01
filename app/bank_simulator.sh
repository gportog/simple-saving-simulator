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

source "handlers.sh" # secondary functions
source "menus.sh" # main menu and the script info
source "calcs.sh" # functions called by the main menu

menu