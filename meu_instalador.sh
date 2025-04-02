#!/bin/bash

# // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##
# ##                                     SCRIPT JAPYNHA                                      ##
# ##                             Setup com Verificações Aprimoradas                         ##
# // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##

## Cores
amarelo="\e[33m"
verde="\e[32m"
branco="\e[97m"
bege="\e[93m"
vermelho="\e[91m"
azul="\e[34m"
roxo="\e[35m"
reset="\e[0m"

#------------------------------------------------------------------------------
# FUNÇÕES DE INSTALAÇÃO DE PRÉ-REQUISITOS (Docker e Docker Compose)
#------------------------------------------------------------------------------

install_docker() {
    echo -e "<span class="math-inline">\{amarelo\}   Docker não encontrado\. Tentando instalar\.\.\.</span>{reset}"
    # Verifica se curl está disponível para baixar o script
    if ! command -v curl &> /dev/null; then
        echo -e "<span class="math-inline">\{amarelo\}   Comando 'curl' não encontrado\. Tentando instalar curl\.\.\.</span>{reset}"
        sudo apt update -y > /dev/null 2>&1
        sudo apt install -y curl > /dev/null 2>&1
        if ! command -v curl &> /dev/null; then
             echo -e "<span class="math-inline">\{vermelho\}   ERRO\: Falha ao instalar 'curl'\. Não é possível baixar o instalador do Docker\.</span>{reset}"
             return 1
        fi
         echo -e "<span class="math-inline">\{verde\}   'curl' instalado\.</span>{reset}"
    fi

    echo -e "<span class="math-inline">\{branco\}   Baixando script de instalação oficial do Docker\.\.\.</span>{reset}"
    curl -fsSL https://get.docker.com -o get-docker.sh
    if [ <span class="math-inline">? \-ne 0 \]; then
echo \-e "</span>{vermelho}   ERRO: Falha ao baixar o script get-docker.sh.<span class="math-inline">\{reset\}"
\# Tenta remover o arquivo baixado parcialmente, se existir
rm \-f get\-docker\.sh
return 1
fi
echo \-e "</span>{branco}   Executando script de instalação do Docker (pode demorar um pouco)...<span class="math-inline">\{reset\}"
sudo sh get\-docker\.sh
local install\_status\=</span>?
    rm -f get-docker.sh # Remove o script baixado

    if [ <span class="math-inline">install\_status \-eq 0 \]; then
echo \-e "</span>{verde}   Docker instalado com sucesso (aparentemente).<span class="math-inline">\{reset\}"
\# Ativa e inicia o serviço Docker
sudo systemctl enable docker \> /dev/null 2\>&1
sudo systemctl start docker \> /dev/null 2\>&1
return 0 \# Sucesso
else
echo \-e "</span>{vermelho}   ERRO: Falha ao executar o script de instalação do Docker (Status: <span class="math-inline">\{install\_status\}\)\.</span>{reset}"
        return 1 # Falha
    fi
}

install_docker_compose() {
    echo -e "<span class="math-inline">\{amarelo\}   Docker Compose \(V1 ou V2\) não encontrado\. Tentando instalar V2 \(plugin\)\.\.\.</span>{reset}"
    sudo apt update -y > /dev/null 2>&1
    sudo apt install -y docker-compose-plugin
    if command -v docker compose &> /dev/null; then
        echo -e "<span class="math-inline">\{verde\}   Docker Compose V2 \(plugin\) instalado com sucesso\.</span>{reset}"
        return 0 # Sucesso
    else
        echo -e "<span class="math-inline">\{vermelho\}   ERRO\: Falha ao instalar Docker Compose V2 \(plugin\)\.</span>{reset}"
        echo -e "<span class="math-inline">\{amarelo\}   Verifique se o Docker foi instalado corretamente ou tente instalar o Docker Compose manualmente\.</span>{reset}"
        # Não vamos tentar instalar V1 automaticamente para evitar mais complexidade
        return 1 # Falha
    fi
}

#------------------------------------------------------------------------------
# Banners e Menus
#------------------------------------------------------------------------------

nome_verificando(){
    # Banner de Verificação/Aviso Inicial (Largura Ajustada)
    clear
    echo ""
    # Ajustado para largura ~70
    echo -e "<span class="math-inline">amarelo\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=</span>{reset}"
    echo -e "$amarelo= <span class="math-inline">\{branco\}Verificando Pré\-requisitos\.\.\.</span>{reset}"
    echo -e "<span class="math-inline">amarelo\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=</span>{reset}"
    echo ""
}

nome_instalando(){
    # Banner exibido DURANTE a instalação de dependências (Larguras Ajustadas)
    clear
    echo ""
    # Separador Superior (Largura Padrão ~95) - Ajuste se o banner for mais largo
    echo -e "<span class="math-inline">azul\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=</span>{reset}"
    # SEU BANNER ASCII ART (Exibido durante a instalação):
    echo -e "${branco}                        ██╗  ██╗██╗████████╗    ██╗   ██╗██████╗ ███████╗                      <span class="math-inline">\{reset\}"
echo \-e "</span>{branco}                        ██║ ██╔╝██║╚══██╔══╝    ██║   ██║██╔══██╗██╔════╝                      <span class="math-inline">\{reset\}"
echo \-e "</span>{branco}                        █████╔╝ ██║   ██║       ██║   ██║██████╔╝███████╗                      <span class="math-inline">\{reset\}"
echo \-e "</span>{branco}                        ██╔═██╗ ██║   ██║       ╚██╗ ██╔╝██╔═══╝ ╚════██║                      <span class="math-inline">\{reset\}"
echo \-e "</span>{branco}                        ██║  ██╗██║   ██║        ╚████╔╝ ██║     ███████║                      <span class="math-inline">\{reset\}"
echo \-e "</span>{branco}                        ╚═╝  ╚═╝╚═╝   ╚═╝         ╚═══╝  ╚═╝     ╚══════╝                      <span class="math-inline">\{reset\}"
echo \-e "</span>{branco}                                                                                               <span class="math-inline">\{reset\}"
echo \-e "</span>{branco}███████╗██████╗ ██╗███████╗ ██████╗ ███╗   ██╗     ██████╗  ██████╗ ███╗   ██╗██████╗  ██████╗ <span class="math-inline">\{reset\}"
echo \-e "</span>{branco}██╔════╝██╔══██╗██║██╔════╝██╔═══██╗████╗  ██║    ██╔════╝ ██╔═══██╗████╗  ██║██╔══██╗██╔═══██╗<span class="math-inline">\{reset\}"
echo \-e "</span>{branco}█████╗  ██║  ██║██║███████╗██║   ██║██╔██╗ ██║    ██║  ███╗██║   ██║██╔██╗ ██║██║  ██║██║   ██║<span class="math-inline">\{reset\}"
echo \-e "</span>{branco}██╔══╝  ██║  ██║██║╚════██║██║   ██║██║╚██╗██║    ██║   ██║██║   ██║██║╚██╗██║██║  ██║██║   ██║<span class="math-inline">\{reset\}"
echo \-e "</span>{branco}███████╗██████╔╝██║███████║╚██████╔╝██║ ╚████║    ╚██████╔╝╚██████╔╝██║ ╚████║██████╔╝╚██████╔╝<span class="math-inline">\{reset\}"
echo \-e "</span>{branco}╚══════╝╚═════╝ ╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═══╝     ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝╚═════╝  ╚═════╝ <span class="math-inline">\{reset\}"
echo \-e "</span>{branco}                                                                                               <span class="math-inline">\{reset\}"
\# FIM DO BANNER ASCII ART
echo ""
\# Linha de texto centralizada
echo \-e "</span>{branco}                          Setup do Japa${reset}"
    # Separador Inferior (Largura Ajustada para o texto acima, ~60)
    echo -e "<span class="math-inline">azul\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=</span>{reset}"
    echo ""
}

mostrar_menu_ferramentas() {
    # Banner e Menu de Ferramentas principal (Opção 01 agora ativa)
    clear
    echo ""
    # NOVO ASCII ART BANNER ("MENU FERRAMENTAS V2"):
    echo -e "${branco}            ███╗   ███╗███████╗███╗   ██╗██╗   ██╗    ██████╗ ███████╗                        <span class="math-inline">\{reset\}"
echo \-e "</span>{branco}            ████╗ ████║██╔════╝████╗  ██║██║   ██║    ██╔══██╗██╔════╝                        <span class="math-inline">\{reset\}"
echo \-e "</span>{branco}            ██╔████╔██║█████╗  ██╔██╗ ██║██║   ██║    ██║  ██║█████╗                          <span class="math-inline">\{reset\}"
echo \-e "</span>{branco}            ██║╚██╔╝██║██╔══╝  ██║╚██╗██║██║   ██║    ██║  ██║██╔══╝                          <span class="math-inline">\{reset\}"
echo \-e "</span>{branco}            ██║ ╚═╝ ██║███████╗██║ ╚████║╚██████╔╝    ██████╔╝███████╗                        <span class="math-inline">\{reset\}"
echo \-e "</span>{branco}            ╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝ ╚═════╝     ╚═════╝ ╚══════╝                        <span class="math-inline">\{reset\}"
echo \-e "</span>{branco}                                                                                              <span class="math-inline">\{reset\}"
echo \-e "</span>{branco}███████╗███████╗██████╗ ██████╗  █████╗ ███╗   ███╗███████╗███╗   ██╗████████╗ █████╗ ███████╗<span class="math-inline">\{reset\}"
echo \-e "</span>{branco}██╔════╝██╔════╝██╔══██╗██╔══██╗██╔══██╗████╗ ████║██╔════╝████╗  ██║╚══██╔══╝██╔══██╗██╔════╝<span class="math-inline">\{reset\}"
echo \-e "</span>{branco}█████╗  █████╗  ██████╔╝██████╔╝███████║██╔████╔██║█████╗  ██╔██╗ ██║   ██║   ███████║███████╗<span class="math-inline">\{reset\}"
echo \-e "</span>{branco}██╔══╝  ██╔══╝  ██╔══██╗██╔══██╗██╔══██║██║╚██╔╝██║██╔══╝  ██║╚██╗██║   ██║   ██╔══██║╚════██║<span class="math-inline">\{reset\}"
echo \-e "</span>{branco}██║     ███████╗██║  ██║██║  ██║██║  ██║██║ ╚═╝ ██║███████╗██║ ╚████║   ██║   ██║  ██║███████║<span class="math-inline">\{reset\}"
echo \-e "</span>{branco}╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚═╝  ╚═╝╚══════╝<span class="math-inline">\{reset\}"
echo \-e "</span>{branco}                                                                                              <span class="math-inline">\{reset\}"
\# FIM DO NOVO BANNER
echo ""
echo \-e "</span>{branco}                                         Versão do Setup: <span class="math-inline">\{verde\}1\.0\.0</span>{reset}" # Exemplo
    # Separador Superior do Menu (Largura ~95)
    echo -e "<span class="math-inline">\{amarelo\}\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=</span>{reset}"
    echo ""
    # Opções do Menu - Lista Inicial (Cores Ativo/Inativo)
    echo -e " <span class="math-inline">\{verde\}\[ 01 \] Traefik & Portainer</span>{reset}"           # <<< MUDOU PARA VERDE (Ativo)
    echo -e " <span class="math-inline">\{vermelho\}\[ 02 \] Chatwoot</span>{reset}"
    echo -e " <span class="math-inline">\{vermelho\}\[ 03 \] Evolution API</span>{reset}"
    echo -e " <span class="math-inline">\{vermelho\}\[ 04 \] MinIO</span>{reset}"
    echo -e " <span class="math-inline">\{vermelho\}\[ 05 \] Typebot</span>{reset}"
    echo -e " <span class="math-inline">\{vermelho\}\[ 06 \] N8N</span>{reset}"
    echo -e " <span class="math-inline">\{vermelho\}\[ 07 \] Flowise</span>{reset}"
    echo -e " <span class="math-inline">\{vermelho\}\[ 08 \] Wordpress</span>{reset}"
    echo -e " <span class="math-inline">\{vermelho\}\[ 09 \] Chatwoot Nestor</span>{reset}"
    # Adicione mais ferramentas aqui conforme for implementando (lembre de mudar a cor para verde)
    echo ""
    echo -e " <span class="math-inline">\{vermelho\}\[ 99 \] Sair</span>{reset}"
    echo ""
    # Separador Inferior do Menu (Largura ~95)
    echo -e "<span class="math-inline">\{amarelo\}\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=</span>{reset}"
    echo ""
}

#------------------------------------------------------------------------------
# FUNÇÕES DE INSTALAÇÃO DAS FERRAMENTAS
#------------------------------------------------------------------------------

install_traefik_portainer() {
    echo -e "<span class="math-inline">\{verde\}\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-</span>{reset}"
    echo -e "<span class="math-inline">\{verde\} Iniciando Instalação\: Traefik & Portainer</span>{reset}"
    echo -e "<span class="math-inline">\{verde\}\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-</span>{reset}"
    sleep 1

    # --- Variáveis ---
    local INSTALL_DIR="/opt/setup-edisongondo/traefik"
    local GITHUB_RAW_URL="https://raw.githubusercontent.com/Japynha/Setup_EdisonGondo/main/traefik" # *** CONFIRME BRANCH 'main' ***

    # --- 1. Criar Diretórios ---
    echo -e "${branco}=> Criando diretórios em <span class="math-inline">\{INSTALL\_DIR\}\.\.\.</span>{reset}"
    sudo mkdir -p "${INSTALL_DIR}/data/logs"
    if [ <span class="math-inline">? \-ne 0 \]; then echo \-e "</span>{vermelho}   ERRO: Falha ao criar diretório de logs. Abortando.<span class="math-inline">\{reset\}"; return 1; fi
sudo mkdir \-p "</span>{INSTALL_DIR}/data/certs"
    if [ <span class="math-inline">? \-ne 0 \]; then echo \-e "</span>{vermelho}   ERRO: Falha ao criar diretório de certificados. Abortando.<span class="math-inline">\{reset\}"; return 1; fi
echo \-e "</span>{verde}   Diretórios criados.<span class="math-inline">\{reset\}"
sleep 1
\# \-\-\- 2\. Criar Rede Docker \-\-\-
echo \-e "</span>{branco}=> Verificando/Criando rede Docker [traefik_proxy]...<span class="math-inline">\{reset\}"
if \! docker network inspect traefik\_proxy \> /dev/null 2\>&1; then
echo \-e "</span>{amarelo}   Rede não encontrada. Criando...<span class="math-inline">\{reset\}"
if sudo docker network create traefik\_proxy \> /dev/null; then
echo \-e "</span>{verde}   Rede [traefik_proxy] criada.<span class="math-inline">\{reset\}"
else
echo \-e "</span>{vermelho}   ERRO: Falha ao criar rede Docker [traefik_proxy]. Abortando.<span class="math-inline">\{reset\}"
return 1
fi
else
echo \-e "</span>{verde}   Rede [traefik_proxy] já existe.<span class="math-inline">\{reset\}"
fi
sleep 1
\# \-\-\- 3\. Baixar Arquivos de Configuração do SEU GitHub \-\-\-
echo \-e "</span>{branco}=> Baixando arquivos de configuração de <span class="math-inline">\{GITHUB\_RAW\_URL\}\.\.\.</span>{reset}"
    sudo rm -f "<span class="math-inline">\{INSTALL\_DIR\}/docker\-compose\.yml" "</span>{INSTALL_DIR}/data/traefik.yml" # Limpa arquivos antigos

    sudo curl -sSL "<span class="math-inline">\{GITHUB\_RAW\_URL\}/docker\-compose\.yml" \-o "</span>{INSTALL_DIR}/docker-compose.yml"
    if [ <span class="math-inline">? \-ne 0 \] \|\| \[ \! \-s "</span>{INSTALL_DIR}/docker-compose.yml" ]; then echo -e "<span class="math-inline">\{vermelho\}   ERRO\: Falha ao baixar ou arquivo vazio\: docker\-compose\.yml\. Verifique a URL e o arquivo no GitHub\. Abortando\.</span>{reset}"; return 1; fi

    sudo curl -sSL "<span class="math-inline">\{GITHUB\_RAW\_URL\}/traefik\.yml" \-o "</span>{INSTALL_DIR}/data/traefik.yml"
    if [ <span class="math-inline">? \-ne 0 \] \|\| \[ \! \-s "</span>{INSTALL_DIR}/data/traefik.yml" ]; then echo -e "<span class="math-inline">\{vermelho\}   ERRO\: Falha ao baixar ou arquivo vazio\: traefik\.yml\. Verifique a URL e o arquivo no GitHub\. Abortando\.</span>{reset}"; return 1; fi
    echo -e "<span class="math-inline">\{verde\}   Arquivos baixados com sucesso\.</span>{reset}"
    sleep 1

    # --- 4. Obter Informações do Usuário ---
    echo -e "<span class="math-inline">\{branco\}\=\> Coletando informações para o arquivo \.env\.\.\.</span>{reset}"
    local DOMAINNAME=""
    local CLOUDFLARE_EMAIL=""
    local CLOUDFLARE_DNS_API_TOKEN=""
    local TIMEZONE="America/Sao_Paulo"
    local PUID="1000"
    local PGID="1000"

    while [[ -z "$DOMAINNAME" ]]; do read -p "   - Digite seu domínio principal (ex: seusite.com): " DOMAINNAME; if [[ -z "<span class="math-inline">DOMAINNAME" \]\]; then echo \-e "</span>{vermelho}     O domínio não pode ser vazio!${reset}"; fi; done
    while [[ -z "$CLOUDFLARE_EMAIL" ]]; do read -p "   - Digite seu email da conta Cloudflare: " CLOUDFLARE_EMAIL; if [[ -z "<span class="math-inline">CLOUDFLARE\_EMAIL" \]\]; then echo \-e "</span>{vermelho}     O email não pode ser vazio!${reset}"; fi; done
    while [[ -z "$CLOUDFLARE_DNS_API_TOKEN" ]]; do read -p "   - Digite seu Token de API Cloudflare (Permissão: Edit Zone DNS): " CLOUDFLARE_DNS_API_TOKEN; if [[ -z "<span class="math-inline">CLOUDFLARE\_DNS\_API\_TOKEN" \]\]; then echo \-e "</span>{vermelho}     O Token API não pode ser vazio!${reset}"; fi; done
    read -p "   - Fuso Horário [Padrão: <span class="math-inline">\{TIMEZONE\}\]\: " user\_timezone; TIMEZONE\=</span>{user_timezone:-$TIMEZONE}
    # read -p "   - PUID [Padrão: <span class="math-inline">\{PUID\}\]\: " user\_puid; PUID\=</span>{user_puid:-$PUID} # Opcional
    # read -p "   - PGID [Padrão: <span class="math-inline">\{PGID\}\]\: " user\_pgid; PGID\=</span>{user_pgid:-<span class="math-inline">PGID\} \# Opcional
echo \-e "</span>{verde}   Informações coletadas.<span class="math-inline">\{reset\}"
sleep 1
\# \-\-\- 5\. Criar Arquivo \.env REAL \-\-\-
echo \-e "</span>{branco}=> Criando arquivo .env em <span class="math-inline">\{INSTALL\_DIR\}\.\.\.</span>{reset}"
    sudo rm -f "<span class="math-inline">\{INSTALL\_DIR\}/\.env" \# Remove o \.env antigo se existir
sudo tee "</span>{INSTALL_DIR}/.env" > /dev/null << EOF
# Arquivo gerado pelo script de setup
DOMAINNAME=<span class="math-inline">\{DOMAINNAME\}
CLOUDFLARE\_EMAIL\=</span>{CLOUDFLARE_EMAIL}
CLOUDFLARE_DNS_API_TOKEN=<span class="math-inline">\{CLOUDFLARE\_DNS\_API\_TOKEN\}
TIMEZONE\=</span>{TIMEZONE}
PUID=<span class="math-inline">\{PUID\}
PGID\=</span>{PGID}
EOF
    if [ <span class="math-inline">? \-eq 0 \] && \[ \-f "</span>{INSTALL_DIR}/.env" ]; then
        echo -e "<span class="math-inline">\{verde\}   Arquivo \.env criado com sucesso\.</span>{reset}"
    else
        echo -e "<span class="math-inline">\{vermelho\}   ERRO\: Falha ao criar arquivo \.env\. Abortando\.</span>{reset}"
        return 1
    fi
    sleep 1

    # --- 6. Criar acme.json ---
    echo -e "${branco}=> Criando e configurando <span class="math-inline">\{INSTALL\_DIR\}/data/certs/acme\.json\.\.\.</span>{reset}"
    sudo touch "<span class="math-inline">\{INSTALL\_DIR\}/data/certs/acme\.json"
sudo chmod 600 "</span>{INSTALL_DIR}/data/certs/acme.json"
    if [ <span class="math-inline">? \-ne 0 \]; then echo \-e "</span>{vermelho}   ERRO: Falha ao criar ou definir permissões para acme.json. Abortando.<span class="math-inline">\{reset\}"; return 1; fi
echo \-e "</span>{verde}   Arquivo acme.json pronto.<span class="math-inline">\{reset\}"
sleep 1
\# \-\-\- 7\. Iniciar os Containers \-\-\-
echo \-e "</span>{branco}=> Executando 'docker compose up -d' em <span class="math-inline">\{INSTALL\_DIR\}\.\.\. \(Isso pode levar um tempo\)</span>{reset}"
    cd "<span class="math-inline">\{INSTALL\_DIR\}" \|\| \{ echo \-e "</span>{vermelho}ERRO: Não foi possível acessar o diretório <span class="math-inline">\{INSTALL\_DIR\}\. Abortando\.</span>{reset}"; return 1; }
    # Verifica qual comando docker compose usar (v2 ou v1)
    local DOCKER_COMPOSE_CMD=""
    if command -v docker &> /dev/null && command -v docker compose &> /dev/null; then
        DOCKER_COMPOSE_CMD="docker compose"
    elif command -v docker-compose &> /dev/null; then
        DOCKER_COMPOSE_CMD="docker-compose"
    else
        # Esta verificação já acontece antes, mas é bom ter redundância
        echo -e "<span class="math-inline">\{vermelho\}ERRO CRÍTICO\: Comando docker compose não encontrado nesta função\. Abortando\.</span>{reset}"
        return 1
    fi

    sudo <span class="math-inline">\{DOCKER\_COMPOSE\_CMD\} up \-d
DOCKER\_COMPOSE\_STATUS\=</span>?
    echo ""

    if [ <span class="math-inline">DOCKER\_COMPOSE\_STATUS \-eq 0 \]; then
echo \-e "</span>{verde}   Comando '<span class="math-inline">\{DOCKER\_COMPOSE\_CMD\} up \-d' executado\. Aguardando inicialização\.\.\.</span>{reset}"
        sleep 15 # Espera um pouco mais

        # --- 8. Verificar e Mostrar Feedback ---
        echo ""
        echo -e "<span class="math-inline">\{branco\}\=\> Verificando status dos containers\.\.\.</span>{reset}"
        local traefik_ok=false
        local portainer_ok=false
        if sudo docker ps --filter name=traefik_proxy --format '{{.Names}}' | grep -q 'traefik_proxy'; then echo -e "<span class="math-inline">\{verde\}   \[ OK \] Container Traefik \(traefik\_proxy\) está rodando\.</span>{reset}"; traefik_ok=true; else echo -e "<span class="math-inline">\{vermelho\}   \[ OFF \] Container Traefik \(traefik\_proxy\) NÃO está rodando\.</span>{reset}"; echo -e "${amarelo}          Verifique os logs com: cd ${INSTALL_DIR} && sudo <span class="math-inline">\{DOCKER\_COMPOSE\_CMD\} logs traefik</span>{reset}"; fi
        if sudo docker ps --filter name=portainer_manager --format '{{.Names}}' | grep -q 'portainer_manager'; then echo -e "<span class="math-inline">\{verde\}   \[ OK \] Container Portainer \(portainer\_manager\) está rodando\.</span>{reset}"; portainer_ok=true; else echo -e "<span class="math-inline">\{vermelho\}   \[ OFF \] Container Portainer \(portainer\_manager\) NÃO está rodando\.</span>{reset}"; echo -e "${amarelo}          Verifique os logs com: cd ${INSTALL_DIR} && sudo <span class="math-inline">\{DOCKER\_COMPOSE\_CMD\} logs portainer</span>{reset}"; fi

        echo ""
        echo -e "<span class="math-inline">\{verde\}\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-</span>{reset}"
        if $traefik_ok && <span class="math-inline">portainer\_ok; then
echo \-e "</span>{verde} Instalação de Traefik & Portainer CONCLUÍDA com Sucesso!<span class="math-inline">\{reset\}"
local portainer\_subdomain\="portainer" \# Subdomínios padrão
local traefik\_subdomain\="traefik"
echo \-e "</span>{branco}   Acesse o Portainer em:  <span class="math-inline">\{verde\}https\://</span>{portainer_subdomain}.<span class="math-inline">\{DOMAINNAME\}</span>{reset}"
            echo -e "<span class="math-inline">\{branco\}   \(Crie o usuário administrador no primeiro acesso ao Portainer\)</span>{reset}"
            echo -e "${branco}   Dashboard Traefik em: <span class="math-inline">\{verde\}https\://</span>{traefik_subdomain}.<span class="math-inline">\{DOMAINNAME\}</span>{reset}"
            echo -e "<span class="math-inline">\{branco\}   \(Acesso ao dashboard depende da config de labels/auth no compose\)</span>{reset}"
            echo -e "<span class="math-inline">\{verde\}\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-</span>{reset}"
            return 0 # Sucesso
        else
            echo -e "<span class="math-inline">\{vermelho\} Instalação de Traefik & Portainer CONCLUÍDA com ERROS\.</span>{reset}"
            echo -e "<span class="math-inline">\{vermelho\}   Verifique os logs dos containers que falharam\.</span>{reset}"
            echo -e "<span class="math-inline">\{vermelho\}\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-</span>{reset}"
            return 1 # Falha
        fi
    else
        echo -e "<span class="math-inline">\{vermelho\}   ERRO\: Falha ao executar '</span>{DOCKER_COMPOSE_CMD} up -d' (Status: <span class="math-inline">\{DOCKER\_COMPOSE\_STATUS\}\)\.</span>{reset}"
        echo -e "${amarelo}          Verifique a saída do Docker Compose acima ou os logs no diretório <span class="math-inline">\{INSTALL\_DIR\}</span>{reset}"
        echo -e "<span class="math-inline">\{vermelho\}\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-</span>{reset}"
        return 1 # Falha
    fi
}

# --- Adicione outras funções de instalação aqui depois ---
# install_chatwoot() { ... }
# install_n8n() { ... }

#------------------------------------------------------------------------------
# FIM DAS FUNÇÕES DE INSTALAÇÃO
#------------------------------------------------------------------------------


## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##
## Verificações Iniciais e Instalação de Dependências
## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##

# --- (Seção de Verificação Inicial) ---
nome_verificando
echo -e "<span class="math-inline">\{branco\}Aguarde enquanto verificamos algumas informações\.\.\.</span>{reset}"
sleep 1
if [ "<span class="math-inline">\(id \-u\)" \-ne 0 \]; then echo \-e "</span>{vermelho}ERRO: Execute como root.<span class="math-inline">\{reset\}"; exit 1; fi
echo \-e "</span>{verde}INFO:<span class="math-inline">\{branco\} Verificação de usuário root \[ OK \]</span>{reset}"; sleep 1
if [ -f /etc/os-release ]; then . /etc/os-release; if [[ "$ID" != "ubuntu" && "<span class="math-inline">ID" \!\= "debian" \]\]; then echo \-e "</span>{amarelo}AVISO: Testado em Debian/Ubuntu. Você usa <span class="math-inline">PRETTY\_NAME\.</span>{reset}"; sleep 3; else echo -e "<span class="math-inline">\{verde\}INFO\:</span>{branco} Verificação OS (<span class="math-inline">PRETTY\_NAME\) \[ OK \]</span>{reset}"; sleep 1; fi; else echo -e "<span class="math-inline">\{amarelo\}AVISO\: Distro não verificada\.</span>{reset}"; sleep 2; fi

# --- (Seção de Instalação de Dependências - COM INSTALAÇÃO AUTOMÁTICA DE DOCKER/COMPOSE) ---
nome_instalando
TOTAL_STEPS=11 # Manter 11 por enquanto, docker/compose são pré-requisitos
CURRENT_STEP=0
update_step() { CURRENT_STEP=$((CURRENT_STEP + 1)); }
check_status() { local step_description=$1; update_step; if [ <span class="math-inline">? \-eq 0 \]; then echo \-e "</span>{verde}<span class="math-inline">\{CURRENT\_STEP\}/</span>{TOTAL_STEPS} - [ OK ] - <span class="math-inline">\{step\_description\}</span>{reset}"; else echo -e "<span class="math-inline">\{vermelho\}</span>{CURRENT_STEP}/${TOTAL_STEPS} - [ OFF ] - <span class="math-inline">\{step\_description\}</span>{reset}"; fi; echo ""; sleep 0.5; }
echo -e "<span class="math-inline">\{branco\}Iniciando atualização e instalação de dependências\.\.\.</span>{reset}"; echo ""
apt update -y > /dev/null 2>&1; check_status "Fazendo Update Inicial"
apt upgrade -y > /dev/null 2>&1; check_status "Fazendo Upgrade Inicial"
apt install -y sudo > /dev/null 2>&1; check_status "Verificando/Instalando sudo"
apt install -y apt-utils > /dev/null 2>&1; check_status "Verificando/Instalando apt-utils"

# --- Verificação e Instalação Automática de Docker ---
echo -e "<span class="math-inline">\{branco\}\=\> Verificando Docker\.\.\.</span>{reset}"
if ! command -v docker &> /dev/null; then
    install_docker # Chama a função para instalar
    if [ <span class="math-inline">? \-ne 0 \]; then echo \-e "</span>{vermelho}ERRO FATAL: Falha na instalação automática do Docker. Abortando.<span class="math-inline">\{reset\}"; exit 1; fi
if \! command \-v docker &\> /dev/null; then echo \-e "</span>{vermelho}ERRO FATAL: Docker ainda não encontrado após tentativa de instalação. Abortando.<span class="math-inline">\{reset\}"; exit 1; fi
else
echo \-e "</span>{verde}   Docker já está instalado.<span class="math-inline">\{reset\}"
fi
sleep 1
\# \-\-\- Verificação e Instalação Automática de Docker Compose \-\-\-
echo \-e "</span>{branco}=> Verificando Docker Compose...${reset}"
if ! command -v docker compose &> /dev/null && ! command -v docker-compose &> /dev/null; then
    install_docker_compose # Chama a função para instalar
    if [ <span class="math-inline">? \-ne 0 \]; then echo \-e "</span>{vermelho}ERRO FATAL: Falha na instalação automática do Docker Compose. Abortando.<span class="math-inline">\{reset\}"; exit 1; fi
if \! command \-v docker compose &\> /dev/null && \! command \-v docker\-compose &\> /dev/null; then echo \-e "</span>{vermelho}ERRO FATAL: Docker Compose ainda não encontrado após tentativa de instalação. Abortando.<span class="math-inline">\{reset\}"; exit 1; fi
else
echo \-e "</span>{verde}   Docker Compose (V1 ou V2) já está instalado.<span class="math-inline">\{reset\}"
fi
sleep 1
\# \-\-\- Continua com as outras dependências \-\-\-
apt install \-y dialog \> /dev/null 2\>&1; check\_status "Verificando/Instalando dialog"
apt install \-y jq \> /dev/null 2\>&1; check\_status "Verificando/Instalando jq"
apt install \-y apache2\-utils \> /dev/null 2\>&1; check\_status "Verificando/Instalando apache2\-utils" \# Para gerar senhas basic auth se necessário
apt install \-y git \> /dev/null 2\>&1; check\_status "Verificando/Instalando Git"
apt install \-y python3 \> /dev/null 2\>&1; check\_status "Verificando/Instalando python3"
apt install \-y neofetch \> /dev/null 2\>&1; check\_status "Verificando/Instalando neofetch"
apt update \-y \> /dev/null 2\>&1; check\_status "Fazendo Update Final \(pré\-menu\)"
echo \-e "</span>{verde}Verificação e instalação de dependências concluídas.<span class="math-inline">\{reset\}"; sleep 2
\#\# // \#\# // \#\# // \#\# // \#\# // \#\# // \#\# // \#\# //\#\# // \#\# // \#\# // \#\# // \#\# // \#\# // \#\# // \#\# // \#\#
\#\# Termos e Menu Principal
\#\# // \#\# // \#\# // \#\# // \#\# // \#\# // \#\# // \#\# //\#\# // \#\# // \#\# // \#\# // \#\# // \#\# // \#\# // \#\# // \#\#
\# Exibir termos \(Caixa ajustada\)
echo \-e "</span>{azul}===============================================================================================<span class="math-inline">\{reset\}"
echo \-e "</span>{azul}= ${branco}                                                                                           <span class="math-inline">\{azul\} \=</span>{reset}"
echo -e "${azul}= ${branco} Este auto instalador foi desenvolvido para auxiliar na instalação de algumas ferramentas.             <span class="math-inline">\{azul\} \=</span>{reset}"
echo -e "${azul}= ${branco} Use com responsabilidade e esteja ciente dos riscos de executar scripts como root.              <span class="math-inline">\{azul\} \=</span>{reset}"
echo -e "${azul}= ${branco}                                                                                           <span class="math-inline">\{azul\} \=</span>{reset}"
echo -e "<span class="math-inline">\{azul\}\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=</span>{reset}"
echo ""

# Aceite dos Termos (Mantida a lógica original do seu script)
read -p "Ao digitar Y você concorda com as orientações acima (Y/N): " aceitar_termos
if [[ "$aceitar_termos" != "Y" && "<span class="math-inline">aceitar\_termos" \!\= "y" \]\]; then
echo \-e "</span>{vermelho}Você não aceitou os termos. Saindo...<span class="math-inline">\{reset\}"
exit 1
fi
echo ""
\# \-\-\-\-\- LOOP PRINCIPAL DO MENU \(ADICIONADO\) \-\-\-\-\-
while true; do
\# Chama a função para mostrar o menu de ferramentas completo
mostrar\_menu\_ferramentas
\# Leitura da opção do novo menu
if \[ \-t 0 \]; then
read \-p "Digite o número da opção desejada\: " opcao\_ferramenta
else
if \[ \-e /dev/tty \]; then
read \-p "Digite o número da opção desejada\: " opcao\_ferramenta < /dev/tty
else
echo \-e "</span>{vermelho}ERRO: Não é possível ler a entrada. Execute o script em um terminal interativo.${reset}"
            exit 1 # Sai se não conseguir ler a opção
        fi
    fi
    echo ""

    ## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##
    ## Processamento da Escolha (Menu de Ferramentas - DENTRO DO LOOP)
    ## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##

    case <span class="math-inline">opcao\_ferramenta in
1 \| 01 \) \# Traefik & Portainer
install\_traefik\_portainer \# Chama a função
echo \-e "</span>{branco}Pressione Enter para voltar ao menu...<span class="math-inline">\{reset\}"
read \-r \# Espera o usuário pressionar Enter antes de mostrar o menu de novo
;;
99 \) \# Opção para Sair
echo \-e "</span>{amarelo}Saindo do instalador...<span class="math-inline">\{reset\}"
break \# Sai do loop while
;;
\# Opções Inativas \(02 a 09\)
2 \| 02 \| 3 \| 03 \| 4 \| 04 \| 5 \| 05 \| 6 \| 06 \| 7 \| 07 \| 8 \| 08 \| 9 \| 09 \)
echo \-e "</span>{amarelo}AVISO: Opção [ <span class="math-inline">\{opcao\_ferramenta\} \] ainda não implementada\.</span>{reset}"
            echo -e "<span class="math-inline">\{branco\}       Pressione Enter para voltar ao menu\.\.\.</span>{reset}"
            read -r # Espera o usuário pressionar Enter antes de mostrar o menu de novo
            ;;

        * ) # Qualquer outra entrada inválida
            echo -e "<span class="math-inline">\{vermelho\}Opção inválida\! Tente novamente\.</span>{reset}"
            sleep 2 # Pausa para ler a mensagem
            # O loop continua e mostrará o menu novamente
            ;;
    esac
done
# ----- FIM DO LOOP PRINCIPAL DO MENU -----


## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##
## Finalização (Só chega aqui se sair do loop com 'break' ou 'exit')
## // ## // ## // ## // ## //
