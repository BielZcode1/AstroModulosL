#!/bin/bash

# Recebendo os parâmetros
username="$1"
password="$2"
dias="$3"
sshlimiter="$4"

# Criptografando a senha
pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)

# Definindo a data de expiração para o usuário (2 dias)
final=$(date "+%Y-%m-%d" -d "+$dias days")

# Criando o usuário no sistema
useradd -e $final -M -s /bin/false -p $pass $username

# Salvando a senha em arquivo
if [ ! -d "/etc/SSHPlus/senha" ]; then
    mkdir -p /etc/SSHPlus/senha
    chmod 700 /etc/SSHPlus/senha
fi
echo "$password" > /etc/SSHPlus/senha/$username

# Adicionando o usuário ao banco de dados
echo "$username $sshlimiter" >> /root/usuarios.db

# Criando o script para exclusão do usuário
if [ ! -d "/etc/SSHPlus/userteste" ]; then
    mkdir -p /etc/SSHPlus/userteste
    chmod 700 /etc/SSHPlus/userteste
fi
echo "#!/bin/bash
pkill -f \"$username\"
userdel --force $username
grep -v ^$username[[:space:]] /root/usuarios.db > /tmp/ph ; cat /tmp/ph > /root/usuarios.db
rm /etc/SSHPlus/senha/$username > /dev/null 2>&1
rm -rf /etc/SSHPlus/userteste/$username.sh
exit" > /etc/SSHPlus/userteste/$username.sh

# Tornando o script de exclusão executável
chmod +x /etc/SSHPlus/userteste/$username.sh

# Agendando a execução do script para exclusão após o número de minutos especificado
at -f /etc/SSHPlus/userteste/$username.sh now + $dias min > /dev/null 2>&1
