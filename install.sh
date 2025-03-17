#!/bin/bash

echo "Iniciando a instalação e download dos arquivos..."
    
# URL do repositório do GitHub (substitua pelo correto)
GITHUB_URL="https://raw.githubusercontent.com/BielZcode1/AstroModulosL/refs/heads/main"

# Lista de arquivos a serem baixados
FILES=("modulcreate.sh" "createteste.sh" "deleteuser.sh" "moduldelete.sh")

# Criar banco de dados local se não existir
if [ ! -f "usuarios.db" ]; then
    echo "Criando banco de dados usuarios.db..."
    touch usuarios.db
else
    echo "Banco de dados usuarios.db já existe."
fi

# Baixar e dar permissão aos arquivos
for file in "${FILES[@]}"; do
    echo "Baixando $file..."
    wget -O "$file" "$GITHUB_URL/$file"
    chmod +x "$file"
done

echo "Todos os arquivos foram baixados e configurados com sucesso!"
