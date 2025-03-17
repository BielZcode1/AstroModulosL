#!/bin/bash

# Definindo os arquivos a serem removidos
arquivos=(
    "/root/modulcreate.sh"
    "/root/createteste.sh"
    "/root/deleteuser.sh"
    "/root/moduldelete.sh"
    "/root/usuarios.db"
)

# Remover os arquivos
for arquivo in "${arquivos[@]}"; do
    if [ -f "$arquivo" ]; then
        rm -f "$arquivo"
        echo "Arquivo $arquivo removido com sucesso."
    else
        echo "Arquivo $arquivo não encontrado."
    fi
done

# Mensagem final
echo "Todos os arquivos especificados foram processados."
exit 0
