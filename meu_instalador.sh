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

## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##
## Banners e Menus
## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##

nome_verificando(){
    # Banner de Verificação/Aviso Inicial (Largura Ajustada)
    clear
    echo ""
    # Ajustado para largura ~70
    echo -e "$amarelo======================================================================${reset}"
    echo -e "$amarelo= ${branco}Verificando Pré-requisitos...${reset}"
    echo -e "$amarelo======================================================================${reset}"
    echo ""
}

nome_instalando(){
    # Banner exibido DURANTE a instalação de dependências (Larguras Ajustadas)
    clear
    echo ""
    # Separador Superior (Largura Padrão ~95) - Ajuste se o banner for mais largo
    echo -e "$azul===============================================================================================${reset}"
    # SEU BANNER ASCII ART (Exibido durante a instalação):
    echo -e "${branco}                        ██╗  ██╗██╗████████╗    ██╗   ██╗██████╗ ███████╗                      ${reset}"
    echo -e "${branco}                        ██║ ██╔╝██║╚══██╔══╝    ██║   ██║██╔══██╗██╔════╝                      ${reset}"
    echo -e "${branco}                        █████╔╝ ██║   ██║       ██║   ██║██████╔╝███████╗                      ${reset}"
    echo -e "${branco}                        ██╔═██╗ ██║   ██║       ╚██╗ ██╔╝██╔═══╝ ╚════██║                      ${reset}"
    echo -e "${branco}                        ██║  ██╗██║   ██║        ╚████╔╝ ██║     ███████║                      ${reset}"
    echo -e "${branco}                        ╚═╝  ╚═╝╚═╝   ╚═╝         ╚═══╝  ╚═╝     ╚══════╝                      ${reset}"
    echo -e "${branco}                                                                                               ${reset}"
    echo -e "${branco}███████╗██████╗ ██╗███████╗ ██████╗ ███╗   ██╗     ██████╗  ██████╗ ███╗   ██╗██████╗  ██████╗ ${reset}"
    echo -e "${branco}██╔════╝██╔══██╗██║██╔════╝██╔═══██╗████╗  ██║    ██╔════╝ ██╔═══██╗████╗  ██║██╔══██╗██╔═══██╗${reset}"
    echo -e "${branco}█████╗  ██║  ██║██║███████╗██║   ██║██╔██╗ ██║    ██║  ███╗██║   ██║██╔██╗ ██║██║  ██║██║   ██║${reset}"
    echo -e "${branco}██╔══╝  ██║  ██║██║╚════██║██║   ██║██║╚██╗██║    ██║   ██║██║   ██║██║╚██╗██║██║  ██║██║   ██║${reset}"
    echo -e "${branco}███████╗██████╔╝██║███████║╚██████╔╝██║ ╚████║    ╚██████╔╝╚██████╔╝██║ ╚████║██████╔╝╚██████╔╝${reset}"
    echo -e "${branco}╚══════╝╚═════╝ ╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═══╝     ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝╚═════╝  ╚═════╝ ${reset}"
    echo -e "${branco}                                                                                               ${reset}"
    # FIM DO BANNER ASCII ART
    echo ""
    # Linha de texto centralizada
    echo -e "${branco}                          Setup do Japa${reset}"
    # Separador Inferior (Largura Ajustada para o texto acima, ~60)
    echo -e "$azul============================================================${reset}"
    echo ""
}

mostrar_menu_ferramentas() {
    # Banner e Menu de Ferramentas principal (Opção 01 agora ativa)
    clear
    echo ""
    # NOVO ASCII ART BANNER ("MENU FERRAMENTAS V2"):
    echo -e "${branco}            ███╗   ███╗███████╗███╗   ██╗██╗   ██╗    ██████╗ ███████╗                        ${reset}"
    echo -e "${branco}            ████╗ ████║██╔════╝████╗  ██║██║   ██║    ██╔══██╗██╔════╝                        ${reset}"
    echo -e "${branco}            ██╔████╔██║█████╗  ██╔██╗ ██║██║   ██║    ██║  ██║█████╗                          ${reset}"
    echo -e "${branco}            ██║╚██╔╝██║██╔══╝  ██║╚██╗██║██║   ██║    ██║  ██║██╔══╝                          ${reset}"
    echo -e "${branco}            ██║ ╚═╝ ██║███████╗██║ ╚████║╚██████╔╝    ██████╔╝███████╗                        ${reset}"
    echo -e "${branco}            ╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝ ╚═════╝     ╚═════╝ ╚══════╝                        ${reset}"
    echo -e "${branco}                                                                                              ${reset}"
    echo -e "${branco}███████╗███████╗██████╗ ██████╗  █████╗ ███╗   ███╗███████╗███╗   ██╗████████╗ █████╗ ███████╗${reset}"
    echo -e "${branco}██╔════╝██╔════╝██╔══██╗██╔══██╗██╔══██╗████╗ ████║██╔════╝████╗  ██║╚══██╔══╝██╔══██╗██╔════╝${reset}"
    echo -e "${branco}█████╗  █████╗  ██████╔╝██████╔╝███████║██╔████╔██║█████╗  ██╔██╗ ██║   ██║   ███████║███████╗${reset}"
    echo -e "${branco}██╔══╝  ██╔══╝  ██╔══██╗██╔══██╗██╔══██║██║╚██╔╝██║██╔══╝  ██║╚██╗██║   ██║   ██╔══██║╚════██║${reset}"
    echo -e "${branco}██║     ███████╗██║  ██║██║  ██║██║  ██║██║ ╚═╝ ██║███████╗██║ ╚████║   ██║   ██║  ██║███████║${reset}"
    echo -e "${branco}╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚═╝  ╚═╝╚══════╝${reset}"
    echo -e "${branco}                                                                                              ${reset}"
    # FIM DO NOVO BANNER
    echo ""
    echo -e "${branco}                                         Versão do Setup: ${verde}1.0.0${reset}" # Exemplo
    # Separador Superior do Menu (Largura ~95)
    echo -e "${amarelo}===============================================================================================${reset}"
    echo ""
    # Opções do Menu - Lista Inicial (Cores Ativo/Inativo)
    echo -e " ${verde}[ 01 ] Traefik & Portainer${reset}"           # <<< MUDOU PARA VERDE (Ativo)
    echo -e " ${vermelho}[ 02 ] Chatwoot${reset}"
    echo -e " ${vermelho}[ 03 ] Evolution API${reset}"
    echo -e " ${vermelho}[ 04 ] MinIO${reset}"
    echo -e " ${vermelho}[ 05 ] Typebot${reset}"
    echo -e " ${vermelho}[ 06 ] N8N${reset}"
    echo -e " ${vermelho}[ 07 ] Flowise${reset}"
    echo -e " ${vermelho}[ 08 ] Wordpress${reset}"
    echo -e " ${vermelho}[ 09 ] Chatwoot Nestor${reset}"
    # Adicione mais ferramentas aqui conforme for implementando (lembre de mudar a cor para verde)
    echo ""
    echo -e " ${vermelho}[ 99 ] Sair${reset}"
    echo ""
    # Separador Inferior do Menu (Largura ~95)
    echo -e "${amarelo}===============================================================================================${reset}"
    echo ""
}

#------------------------------------------------------------------------------
# FUNÇÕES DE INSTALAÇÃO DAS FERRAMENTAS
#------------------------------------------------------------------------------

install_traefik_portainer() {
    echo -e "${verde}-----------------------------------------------------------------------${reset}"
    echo -e "${verde} Iniciando Instalação: Traefik & Portainer${reset}"
    echo -e "${verde}-----------------------------------------------------------------------${reset}"
    sleep 1

    # --- Variáveis ---
    local INSTALL_DIR="/opt/setup-edisongondo/traefik"
    local GITHUB_RAW_URL="https://raw.githubusercontent.com/Japynha/Setup_EdisonGondo/main/traefik" # *** CONFIRME BRANCH 'main' ***

    # --- 1. Criar Diretórios ---
    echo -e "${branco}=> Criando diretórios em ${INSTALL_DIR}...${reset}"
    sudo mkdir -p "${INSTALL_DIR}/data/logs"
    if [ $? -ne 0 ]; then echo -e "${vermelho}   ERRO: Falha ao criar diretório de logs. Abortando.${reset}"; return 1; fi
    sudo mkdir -p "${INSTALL_DIR}/data/certs"
    if [ $? -ne 0 ]; then echo -e "${vermelho}   ERRO: Falha ao criar diretório de certificados. Abortando.${reset}"; return 1; fi
    echo -e "${verde}   Diretórios criados.${reset}"
    sleep 1

    # --- 2. Criar Rede Docker ---
    echo -e "${branco}=> Verificando/Criando rede Docker [traefik_proxy]...${reset}"
    if ! docker network inspect traefik_proxy > /dev/null 2>&1; then
        echo -e "${amarelo}   Rede não encontrada. Criando...${reset}"
        if sudo docker network create traefik_proxy > /dev/null; then
            echo -e "${verde}   Rede [traefik_proxy] criada.${reset}"
        else
            echo -e "${vermelho}   ERRO: Falha ao criar rede Docker [traefik_proxy]. Abortando.${reset}"
            return 1
        fi
    else
        echo -e "${verde}   Rede [traefik_proxy] já existe.${reset}"
    fi
    sleep 1

    # --- 3. Baixar Arquivos de Configuração do SEU GitHub ---
    echo -e "${branco}=> Baixando arquivos de configuração de ${GITHUB_RAW_URL}...${reset}"
    sudo rm -f "${INSTALL_DIR}/docker-compose.yml" "${INSTALL_DIR}/data/traefik.yml" # Limpa arquivos antigos

    sudo curl -sSL "${GITHUB_RAW_URL}/docker-compose.yml" -o "${INSTALL_DIR}/docker-compose.yml"
    if [ $? -ne 0 ] || [ ! -s "${INSTALL_DIR}/docker-compose.yml" ]; then echo -e "${vermelho}   ERRO: Falha ao baixar ou arquivo vazio: docker-compose.yml. Verifique a URL e o arquivo no GitHub. Abortando.${reset}"; return 1; fi

    sudo curl -sSL "${GITHUB_RAW_URL}/traefik.yml" -o "${INSTALL_DIR}/data/traefik.yml"
    if [ $? -ne 0 ] || [ ! -s "${INSTALL_DIR}/data/traefik.yml" ]; then echo -e "${vermelho}   ERRO: Falha ao baixar ou arquivo vazio: traefik.yml. Verifique a URL e o arquivo no GitHub. Abortando.${reset}"; return 1; fi
    echo -e "${verde}   Arquivos baixados com sucesso.${reset}"
    sleep 1

    # --- 4. Obter Informações do Usuário ---
    echo -e "${branco}=> Coletando informações para o arquivo .env...${reset}"
    local DOMAINNAME=""
    local CLOUDFLARE_EMAIL=""
    local CLOUDFLARE_DNS_API_TOKEN=""
    local TIMEZONE="America/Sao_Paulo"
    local PUID="1000"
    local PGID="1000"

    while [[ -z "$DOMAINNAME" ]]; do read -p "   - Digite seu domínio principal (ex: seusite.com): " DOMAINNAME; if [[ -z "$DOMAINNAME" ]]; then echo -e "${vermelho}     O domínio não pode ser vazio!${reset}"; fi; done
    while [[ -z "$CLOUDFLARE_EMAIL" ]]; do read -p "   - Digite seu email da conta Cloudflare: " CLOUDFLARE_EMAIL; if [[ -z "$CLOUDFLARE_EMAIL" ]]; then echo -e "${vermelho}     O email não pode ser vazio!${reset}"; fi; done
    while [[ -z "$CLOUDFLARE_DNS_API_TOKEN" ]]; do read -p "   - Digite seu Token de API Cloudflare (Permissão: Edit Zone DNS): " CLOUDFLARE_DNS_API_TOKEN; if [[ -z "$CLOUDFLARE_DNS_API_TOKEN" ]]; then echo -e "${vermelho}     O Token API não pode ser vazio!${reset}"; fi; done
    read -p "   - Fuso Horário [Padrão: ${TIMEZONE}]: " user_timezone; TIMEZONE=${user_timezone:-$TIMEZONE}
    # read -p "   - PUID [Padrão: ${PUID}]: " user_puid; PUID=${user_puid:-$PUID} # Opcional
    # read -p "   - PGID [Padrão: ${PGID}]: " user_pgid; PGID=${user_pgid:-$PGID} # Opcional
    echo -e "${verde}   Informações coletadas.${reset}"
    sleep 1

    # --- 5. Criar Arquivo .env REAL ---
    echo -e "${branco}=> Criando arquivo .env em ${INSTALL_DIR}...${reset}"
    sudo rm -f "${INSTALL_DIR}/.env" # Remove o .env antigo se existir
    sudo tee "${INSTALL_DIR}/.env" > /dev/null << EOF
# Arquivo gerado pelo script de setup
DOMAINNAME=${DOMAINNAME}
CLOUDFLARE_EMAIL=${CLOUDFLARE_EMAIL}
CLOUDFLARE_DNS_API_TOKEN=${CLOUDFLARE_DNS_API_TOKEN}
TIMEZONE=${TIMEZONE}
PUID=${PUID}
PGID=${PGID}
EOF
    if [ $? -eq 0 ] && [ -f "${INSTALL_DIR}/.env" ]; then
        echo -e "${verde}   Arquivo .env criado com sucesso.${reset}"
    else
        echo -e "${vermelho}   ERRO: Falha ao criar arquivo .env. Abortando.${reset}"
        return 1
    fi
    sleep 1

    # --- 6. Criar acme.json ---
    echo -e "${branco}=> Criando e configurando ${INSTALL_DIR}/data/certs/acme.json...${reset}"
    sudo touch "${INSTALL_DIR}/data/certs/acme.json"
    sudo chmod 600 "${INSTALL_DIR}/data/certs/acme.json"
    if [ $? -ne 0 ]; then echo -e "${vermelho}   ERRO: Falha ao criar ou definir permissões para acme.json. Abortando.${reset}"; return 1; fi
    echo -e "${verde}   Arquivo acme.json pronto.${reset}"
    sleep 1

    # --- 7. Iniciar os Containers ---
    echo -e "${branco}=> Executando 'docker compose up -d' em ${INSTALL_DIR}... (Isso pode levar um tempo)${reset}"
    cd "${INSTALL_DIR}" || { echo -e "${vermelho}ERRO: Não foi possível acessar o diretório ${INSTALL_DIR}. Abortando.${reset}"; return 1; }
    # Verifica qual comando docker compose usar (v2 ou v1)
    if command -v docker &> /dev/null && command -v docker compose &> /dev/null; then
        sudo docker compose up -d
        DOCKER_COMPOSE_CMD="docker compose"
    elif command -v docker-compose &> /dev/null; then
        sudo docker-compose up -d
        DOCKER_COMPOSE_CMD="docker-compose"
    else
        echo -e "${vermelho}ERRO: Comando 'docker compose' ou 'docker-compose' não encontrado. Docker Compose é necessário.${reset}"
        return 1
    fi
    DOCKER_COMPOSE_STATUS=$?
    echo ""

    if [ $DOCKER_COMPOSE_STATUS -eq 0 ]; then
        echo -e "${verde}   Comando '${DOCKER_COMPOSE_CMD} up -d' executado. Aguardando inicialização...${reset}"
        sleep 15 # Espera um pouco mais

        # --- 8. Verificar e Mostrar Feedback ---
        echo ""
        echo -e "${branco}=> Verificando status dos containers...${reset}"
        local traefik_ok=false
        local portainer_ok=false
        # Verifica usando o nome do container definido no docker-compose.yml
        if sudo docker ps --filter name=traefik_proxy --format '{{.Names}}' | grep -q 'traefik_proxy'; then
            echo -e "${verde}   [ OK ] Container Traefik (traefik_proxy) está rodando.${reset}"
            traefik_ok=true
        else
            echo -e "${vermelho}   [ OFF ] Container Traefik (traefik_proxy) NÃO está rodando.${reset}"
            echo -e "${amarelo}          Verifique os logs com: cd ${INSTALL_DIR} && sudo ${DOCKER_COMPOSE_CMD} logs traefik${reset}"
        fi
        if sudo docker ps --filter name=portainer_manager --format '{{.Names}}' | grep -q 'portainer_manager'; then
             echo -e "${verde}   [ OK ] Container Portainer (portainer_manager) está rodando.${reset}"
             portainer_ok=true
        else
            echo -e "${vermelho}   [ OFF ] Container Portainer (portainer_manager) NÃO está rodando.${reset}"
             echo -e "${amarelo}          Verifique os logs com: cd ${INSTALL_DIR} && sudo ${DOCKER_COMPOSE_CMD} logs portainer${reset}"
        fi

        echo ""
        echo -e "${verde}-----------------------------------------------------------------------${reset}"
        if $traefik_ok && $portainer_ok; then
            echo -e "${verde} Instalação de Traefik & Portainer CONCLUÍDA com Sucesso!${reset}"
            # Define subdomínios padrão (pode tornar isso configurável depois)
            local portainer_subdomain="portainer"
            local traefik_subdomain="traefik"
            echo -e "${branco}   Acesse o Portainer em:  ${verde}https://${portainer_subdomain}.${DOMAINNAME}${reset}"
            echo -e "${branco}   (Crie o usuário administrador no primeiro acesso ao Portainer)${reset}"
            echo -e "${branco}   Dashboard Traefik em: ${verde}https://${traefik_subdomain}.${DOMAINNAME}${reset}"
            echo -e "${branco}   (Acesso ao dashboard depende da configuração de labels/autenticação no compose)${reset}"
            echo -e "${verde}-----------------------------------------------------------------------${reset}"
            return 0 # Sucesso
        else
            echo -e "${vermelho} Instalação de Traefik & Portainer CONCLUÍDA com ERROS.${reset}"
            echo -e "${vermelho}   Verifique os logs dos containers que falharam.${reset}"
            echo -e "${vermelho}-----------------------------------------------------------------------${reset}"
            return 1 # Falha
        fi

    else
        echo -e "${vermelho}   ERRO: Falha ao executar '${DOCKER_COMPOSE_CMD} up -d' (Status: ${DOCKER_COMPOSE_STATUS}).${reset}"
        echo -e "${amarelo}          Verifique a saída do Docker Compose acima ou os logs no diretório ${INSTALL_DIR}${reset}"
        echo -e "${vermelho}-----------------------------------------------------------------------${reset}"
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
echo -e "${branco}Aguarde enquanto verificamos algumas informações...${reset}"
sleep 1
if [ "$(id -u)" -ne 0 ]; then echo -e "${vermelho}ERRO: Execute como root.${reset}"; exit 1; fi
echo -e "${verde}INFO:${branco} Verificação de usuário root [ OK ]${reset}"; sleep 1
if [ -f /etc/os-release ]; then . /etc/os-release; if [[ "$ID" != "ubuntu" && "$ID" != "debian" ]]; then echo -e "${amarelo}AVISO: Testado em Debian/Ubuntu. Você usa $PRETTY_NAME.${reset}"; sleep 3; else echo -e "${verde}INFO:${branco} Verificação OS ($PRETTY_NAME) [ OK ]${reset}"; sleep 1; fi; else echo -e "${amarelo}AVISO: Distro não verificada.${reset}"; sleep 2; fi

# --- (Seção de Instalação de Dependências) ---
nome_instalando
TOTAL_STEPS=11; CURRENT_STEP=0
update_step() { CURRENT_STEP=$((CURRENT_STEP + 1)); }
check_status() { local step_description=$1; update_step; if [ $? -eq 0 ]; then echo -e "${verde}${CURRENT_STEP}/${TOTAL_STEPS} - [ OK ] - ${step_description}${reset}"; else echo -e "${vermelho}${CURRENT_STEP}/${TOTAL_STEPS} - [ OFF ] - ${step_description}${reset}"; fi; echo ""; sleep 0.5; }
echo -e "${branco}Iniciando atualização e instalação de dependências...${reset}"; echo ""
apt update -y > /dev/null 2>&1; check_status "Fazendo Update Inicial"
apt upgrade -y > /dev/null 2>&1; check_status "Fazendo Upgrade Inicial"
apt install -y sudo > /dev/null 2>&1; check_status "Verificando/Instalando sudo"
apt install -y apt-utils > /dev/null 2>&1; check_status "Verificando/Instalando apt-utils"
# Verifica se docker e docker compose/docker-compose estão instalados (ADICIONADO)
if ! command -v docker &> /dev/null; then echo -e "${vermelho}ERRO: Docker não está instalado. Instale o Docker antes de continuar.${reset}"; exit 1; fi
if ! command -v docker compose &> /dev/null && ! command -v docker-compose &> /dev/null; then echo -e "${vermelho}ERRO: Docker Compose (V1 ou V2) não está instalado. Instale antes de continuar.${reset}"; exit 1; fi
apt install -y dialog > /dev/null 2>&1; check_status "Verificando/Instalando dialog"
apt install -y jq > /dev/null 2>&1; check_status "Verificando/Instalando jq"
apt install -y apache2-utils > /dev/null 2>&1; check_status "Verificando/Instalando apache2-utils" # Para gerar senhas basic auth se necessário
apt install -y git > /dev/null 2>&1; check_status "Verificando/Instalando Git"
apt install -y python3 > /dev/null 2>&1; check_status "Verificando/Instalando python3"
apt install -y neofetch > /dev/null 2>&1; check_status "Verificando/Instalando neofetch"
apt update -y > /dev/null 2>&1; check_status "Fazendo Update Final (pré-menu)"
echo -e "${verde}Verificação e instalação de dependências concluídas.${reset}"; sleep 2

## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##
## Termos e Menu Principal
## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##

# Exibir termos (Caixa ajustada)
echo -e "${azul}===============================================================================================${reset}"
echo -e "${azul}= ${branco}                                                                                           ${azul} =${reset}"
echo -e "${azul}= ${branco} Este auto instalador foi desenvolvido para auxiliar na instalação de algumas ferramentas.             ${azul} =${reset}"
echo -e "${azul}= ${branco} Use com responsabilidade e esteja ciente dos riscos de executar scripts como root.              ${azul} =${reset}"
echo -e "${azul}= ${branco}                                                                                           ${azul} =${reset}"
echo -e "${azul}===============================================================================================${reset}"
echo ""

# Aceite dos Termos (Mantida a lógica original do seu script)
read -p "Ao digitar Y você concorda com as orientações acima (Y/N): " aceitar_termos
if [[ "$aceitar_termos" != "Y" && "$aceitar_termos" != "y" ]]; then
    echo -e "${vermelho}Você não aceitou os termos. Saindo...${reset}"
    exit 1
fi
echo ""

# ----- LOOP PRINCIPAL DO MENU (ADICIONADO) -----
while true; do
    # Chama a função para mostrar o menu de ferramentas completo
    mostrar_menu_ferramentas

    # Leitura da opção do novo menu
    if [ -t 0 ]; then
        read -p "Digite o número da opção desejada: " opcao_ferramenta
    else
        if [ -e /dev/tty ]; then
            read -p "Digite o número da opção desejada: " opcao_ferramenta < /dev/tty
        else
            echo -e "${vermelho}ERRO: Não é possível ler a entrada. Execute o script em um terminal interativo.${reset}"
            exit 1 # Sai se não conseguir ler a opção
        fi
    fi
    echo ""

    ## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##
    ## Processamento da Escolha (Menu de Ferramentas - DENTRO DO LOOP)
    ## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##

    case $opcao_ferramenta in
        1 | 01 ) # Traefik & Portainer
            install_traefik_portainer # Chama a função
            echo -e "${branco}Pressione Enter para voltar ao menu...${reset}"
            read -r # Espera o usuário pressionar Enter antes de mostrar o menu de novo
            ;;

        99 ) # Opção para Sair
            echo -e "${amarelo}Saindo do instalador...${reset}"
            break # Sai do loop while
            ;;

        # Opções Inativas (02 a 09)
        2 | 02 | 3 | 03 | 4 | 04 | 5 | 05 | 6 | 06 | 7 | 07 | 8 | 08 | 9 | 09 )
            echo -e "${amarelo}AVISO: Opção [ ${opcao_ferramenta} ] ainda não implementada.${reset}"
            echo -e "${branco}       Pressione Enter para voltar ao menu...${reset}"
            read -r # Espera o usuário pressionar Enter antes de mostrar o menu de novo
            ;;

        * ) # Qualquer outra entrada inválida
            echo -e "${vermelho}Opção inválida! Tente novamente.${reset}"
            sleep 2 # Pausa para ler a mensagem
            # O loop continua e mostrará o menu novamente
            ;;
    esac
done
# ----- FIM DO LOOP PRINCIPAL DO MENU -----


## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##
## Finalização (Só chega aqui se sair do loop com 'break' ou 'exit')
## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##

echo -e "${verde}Setup principal concluído.${reset}"
echo -e "${branco}Realizando uma última atualização do sistema...${reset}"

apt update -y > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo -e "${verde}[ OK ] - Update final.${reset}"
else
    echo -e "${vermelho}[ OFF ] - Update final.${reset}"
fi

apt upgrade -y > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo -e "${verde}[ OK ] - Upgrade final.${reset}"
else
    echo -e "${vermelho}[ OFF ] - Upgrade final.${reset}"
fi

echo ""
echo -e "${verde}Processo finalizado!${reset}"

exit 0
