#!/bin/bash

# Remover arquivos antigos, se existirem
rm -f astrodata.sh astrocreate.sh astroteste.sh astroremove.sh delete.py sincronizar.py add.sh rem.sh addteste.sh addsinc.sh remsinc.sh

# Baixar os arquivos do repositório GitHub
wget -O astrocreate.sh "https://raw.githubusercontent.com/atlaspaineL/atlasPainel/main/atlascreate.sh"
wget -O add.sh "https://raw.githubusercontent.com/atlaspaineL/atlasPainel/main/add.sh"
wget -O remsinc.sh "https://raw.githubusercontent.com/atlaspaineL/atlasPainel/main/remsinc.sh"
wget -O addsinc.sh "https://raw.githubusercontent.com/atlaspaineL/atlasPainel/main/addsinc.sh"
wget -O rem.sh "https://raw.githubusercontent.com/atlaspaineL/atlasPainel/main/rem.sh"
wget -O astroteste.sh "https://raw.githubusercontent.com/atlaspaineL/atlasPainel/main/atlasteste.sh"
wget -O addteste.sh "https://raw.githubusercontent.com/atlaspaineL/atlasPainel/main/addteste.sh"
wget -O astroremove.sh "https://raw.githubusercontent.com/atlaspaineL/atlasPainel/main/atlasremove.sh"
wget -O delete.py "https://raw.githubusercontent.com/atlaspaineL/atlasPainel/main/delete.py"
wget -O astrodata.sh "https://raw.githubusercontent.com/atlaspaineL/atlasPainel/main/atlasdata.sh"
wget -O sincronizar.py "https://raw.githubusercontent.com/atlaspaineL/atlasPainel/main/sincronizar.py"

# Conceder permissões de execução para os arquivos
chmod 777 astrocreate.sh add.sh remsinc.sh addsinc.sh rem.sh astroteste.sh addteste.sh astroremove.sh delete.py astrodata.sh sincronizar.py

# Instalar o dos2unix para corrigir as quebras de linha no Windows
apt install dos2unix

# Corrigir quebras de linha no rem.sh
dos2unix rem.sh

# Baixar e executar o script verificador.py
wget "https://raw.githubusercontent.com/atlaspaineL/atlasPainel/main/verificador.py" -O verificador.py 
python3 verificador.py
