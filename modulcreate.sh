#!/bin/bash
username=$1
password=$2
dias=$3
sshlimiter=$4
dias=$(($dias+1))
final=$(date "+%Y-%m-%d" -d "+$dias days")
gui=$(date "+%d/%m/%Y" -d "+$dias days")
pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)

# Criando o usuário com a data de expiração
useradd -e $final -M -s /bin/false -p $pass $username

# Verificando se o diretório /etc/SSHPlus/senha existe
if [ ! -d "/etc/SSHPlus/senha" ]; then
    # Criando o diretório se não existir
    mkdir -p /etc/SSHPlus/senha
    # Definindo permissões apropriadas para o diretório (opcional, dependendo do seu caso)
    chmod 700 /etc/SSHPlus/senha
fi

# Salvando a senha em um arquivo
echo "$password" > /etc/SSHPlus/senha/$username

# Adicionando o usuário no banco de dados
echo "$username $sshlimiter" >> usuarios.db
