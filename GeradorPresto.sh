#!/bin/sh

###Script para cadastro de catálogos no Presto
###Para usar o script basta troca os caminhos e acrescentar a senha.

#Criado por Rodrigo Fonseca
#Contato: rodrigoepfonseca@gmail.com
#Site: rodrigoepfonseca.com.br


#Entrada do nome da base.
echo "Digite o nome da BASE sem o SQLSERVER-"
read ENTRADA 

#Verifica se o arquivo existe.
if [ -e "sqlserver-$ENTRADA.properties" ] ; then
echo "O arquivo sqlserver-$ENTRADA.properties já existe"
exit 0
fi

#Cria o arquivo 
>/caminho/prestoadmin/catalog/sqlserver-$ENTRADA.properties
cd /caminho/prestoadmin/catalog/
chmod 777 sqlserver-$ENTRADA.properties

#Escreve no arquivo criado.
echo "connector.name=sqlserver
connection-url=jdbc:sqlserver://sqldptprod;databaseName=$(echo $ENTRADA | tr '[:lower:]' '[:upper:]')
connection-user=qg-presto01
connection-password=code0790_!">> /caminho/prestoadmin/catalog/sqlserver-$ENTRADA.properties

#Adiciona ao catálogo
/caminho/presto-admin catalog add sqlserver-$ENTRADA -p <senha/password>

#Reinicia o serviço
/caminho/presto-admin server restart -p <senha/password>

#Caso precise remover um catálogo use o comando a baixo:
#/caminho/prestoadmin/presto-admin catalog remove <nome do catálogo> -p <senha/password>
 
echo "Script Finalizado com sucesso"