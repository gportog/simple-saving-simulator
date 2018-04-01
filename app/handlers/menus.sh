# AUTHOR: Gustavo Porto Guedes (gportog)
# CONTACT: gustavo.guedes@fatec.sp.gov.br

menu() {
 clear
 echo -e "
 ###############################################################################
 #                                                                             #
 #                                                                             #
 #                      BANK.sh: Simulação de Poupança                         #
 # --------------------------------------------------------------------------- #
 #                                               Author:gportog  Version 1.1.0 #
 #                                                                             #
 #                                                                             #
 # A) Calculo sem imprevistos                                                  #
 # B) Calculo com imprevistos                                                  #
 # i) Info sobre opções A e B                                                  #
 # s) Sair do programa                                                         #
 #                                                                             #
 #                                                                             #
 ############################################################################### 
 \n
 Opção: "
	read -n1 option
	case $option in
		a | A )
			option_A;;
		b | B )
			option_B;;
		i | I )
			doc;;
		s | S )
			echo ""
			echo "Saindo..."
			sleep 3
			exit;;
		* )
			echo ""
			echo "Opção inválida!"
			echo ""
			menu;;
	esac
}

doc() {
 echo -e "
 \n
 ' ----------------------------------------------------------------------- '
 '                              Documentation                              '
 ' ----------------------------------------------------------------------- '
 '                                                                         '
 ' A Calculo sem imprevistos:                                              '
 ' 	    Você irá definir uma quantia inicial, juros iniciais em %,         '
 '		e uma quantidade a depositar mensalmente na poupança, sem          '
 '		considerar depósitos irregulares ou retirada da poupança.          '
 ' B Calculo com imprevistos:                                              '
 '		Você irá definir uma quantia inicial, juros iniciais em %,         '
 '      porém dessa vez você irá considerar imprevistos, tais como:        ' 
 '      depósitos irregulares ou retiradas mês à mês.                      '
 '                                                                         '
 ' ----------------------------------------------------------------------- '
 \n"
 continue_function doc
}