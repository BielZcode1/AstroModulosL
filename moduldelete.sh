#!/bin/bash

# Definindo os arquivos a serem removidos
arquivos=(
    "modulcreate.sh"
    "createteste.sh"
    "deleteuser.sh"
    "moduldelete.sh"
    "install.sh"
    "usuarios.db"
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
