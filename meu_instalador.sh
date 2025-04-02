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
    # Garante que curl está instalado antes de usar
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
rm \-f get\-docker\.sh \# Limpa arquivo parcial
return 1
fi
echo \-e "</span>{branco}   Executando script de instalação do Docker (pode demorar um pouco)...<span class="math-inline">\{reset\}"
sudo sh get\-docker\.sh
local install\_status\=</span>?
    rm -f get-docker.sh # Remove o script baixado

    if [ <span class="math-inline">install\_status \-eq 0 \]; then
echo \-e "</span>{verde}   Docker instalado com sucesso (aparentemente).<span class="math-inline">\{reset\}"
\# Garante que o serviço Docker está ativo e habilitado para iniciar com o sistema
sudo systemctl enable docker \> /dev/null 2\>&1
sudo systemctl start docker \> /dev/null 2\>&1
\# Pequena pausa para garantir que o serviço suba
sleep 5
return 0 \# Sucesso
else
echo \-e "</span>{vermelho}   ERRO: Falha ao executar o script de instalação do Docker (Status: <span class="math-inline">\{install\_status\}\)\.</span>{reset}"
        return 1 # Falha
    fi
}

install_docker_compose() {
    echo -e "<span class="math-inline">\{amarelo\}   Docker Compose \(V1 ou V2\) não encontrado\. Tentando instalar V2 \(plugin\)\.\.\.</span>{reset}"
    sudo apt update -y > /dev/null 2>&1
    # Tenta instalar o plugin (funciona na maioria dos sistemas baseados em Debian/Ubuntu recentes)
    sudo apt install -y docker-compose-plugin
    if command -v docker compose &> /dev/null; then
        echo -e "<span class="math-inline">\{verde\}   Docker Compose V2 \(plugin\) instalado com sucesso\.</span>{reset}"
        return 0 # Sucesso
    else
        # Se V2 falhou, tenta instalar V1 como fallback (comum em sistemas mais antigos)
        echo -e "<span class="math-inline">\{amarelo\}   Falha ao instalar V2 \(plugin\)\. Tentando instalar V1 \(standalone\)\.\.\.</span>{reset}"
        local compose_version="1.29.2" # Use uma versão V1 estável conhecida
        sudo curl -L "https://github.com/docker/compose/releases/download/<span class="math-inline">\{compose\_version\}/docker\-compose\-</span>(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        if [ <span class="math-inline">? \-eq 0 \]; then
sudo chmod \+x /usr/local/bin/docker\-compose
if command \-v docker\-compose &\> /dev/null; then
echo \-e "</span>{verde}   Docker Compose V1 (standalone <span class="math-inline">\{compose\_version\}\) instalado com sucesso\.</span>{reset}"
                 return 0 # Sucesso com V1
            else
                 echo -e "<span class="math-inline">\{vermelho\}   ERRO\: Falha ao tornar docker\-compose V1 executável ou encontrá\-lo após download\.</span>{reset}"
                 return 1 # Falha
            fi
        else
             echo -e "<span class="math-inline">\{vermelho\}   ERRO\: Falha ao baixar Docker Compose V1 \(</span>{compose_version}).${reset}"
             return 1 # Falha
        fi
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
    echo -e " <span class="math-inline">\{verde\}\[ 01 \] Traefik & Portainer</span>{reset}"           # <<< VERDE (Ativo)
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
if \! sudo docker network inspect traefik\_proxy \> /dev/null 2\>&1; then \# Adicionado sudo aqui também
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

    sudo curl -sSL "${GITHUB_RAW_URL}/traefik.yml" -o
