#!/bin/bash

# Recebe o nome do usuário como parâmetro
USR_EX=$1

# Função para verificar se o usuário existe
_getUserEx() {
    user_count=$(grep "^$1:x:" /etc/passwd | cut -d ':' -f 1 | wc -c)
    echo $user_count | tr -dc '0-9'
}

# Verifica se o usuário foi fornecido como argumento
if [ -z "${USR_EX}" ]; then
    echo "Você deve especificar um usuário."
    exit 1
else
    # Verifica se o usuário existe no sistema
    USER_COUNT=$(_getUserEx $USR_EX)

    # Se o usuário existir e tiver mais de 3 processos, prossegue com a exclusão
    if [ "$USER_COUNT" -gt 0 ]; then
        USER_PROCESSES=$(ps -fu $USR_EX | awk '{print $2}' | grep -v "^PID" | wc -l)

        # Se o usuário tem mais de 3 processos, exclui o usuário
        if [ "$USER_PROCESSES" -gt 3 ]; then
            # Mata os processos do usuário
            kill -9 $(ps -fu $USR_EX | awk '{print $2}' | grep -v "^PID")

            # Remove o usuário do sistema
            userdel --force $USR_EX

            # Limpa as entradas no banco de dados e outros arquivos
            grep -v "^$USR_EX[[:space:]]" /root/usuarios.db > /tmp/ph
            cat /tmp/ph > /root/usuarios.db
            rm -f /etc/SSHPlus/senha/$USR_EX
            rm -f /etc/usuarios/$USR_EX

            # Sucesso
            echo "Usuário $USR_EX removido com sucesso."
            exit 0
        else
            # Se o usuário tem menos de 3 processos, não pode ser removido
            echo "Erro: O usuário $USR_EX tem menos de 3 processos em execução."
            exit 2
        fi
    else
        # Usuário não encontrado
        echo "Erro: Usuário $USR_EX não encontrado no sistema."
        exit 3
    fi
fi
