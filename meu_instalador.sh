nzoravi87.
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
    echo -e "${amarelo}   Docker não encontrado. Tentando instalar...${reset}"
    # Garante que curl está instalado antes de usar
    if ! command -v curl &> /dev/null; then
        echo -e "${amarelo}   Comando 'curl' não encontrado. Tentando instalar curl...${reset}"
        sudo apt update -y > /dev/null 2>&1
        sudo apt install -y curl > /dev/null 2>&1
        if ! command -v curl &> /dev/null; then
             echo -e "${vermelho}   ERRO: Falha ao instalar 'curl'. Não é possível baixar o instalador do Docker.${reset}"
             return 1
        fi
         echo -e "${verde}   'curl' instalado.${reset}"
    fi

    echo -e "${branco}   Baixando script de instalação oficial do Docker...${reset}"
    curl -fsSL https://get.docker.com -o get-docker.sh
    if [ $? -ne 0 ]; then
         echo -e "${vermelho}   ERRO: Falha ao baixar o script get-docker.sh.${reset}"
         rm -f get-docker.sh # Limpa arquivo parcial
         return 1
    fi

    echo -e "${branco}   Executando script de instalação do Docker (pode demorar um pouco)...${reset}"
    # Redireciona a saída detalhada do script para /dev/null para limpar o visual
    sudo sh get-docker.sh > /dev/null 2>&1
    local install_status=$?
    rm -f get-docker.sh # Remove o script baixado

    if [ $install_status -eq 0 ]; then
        echo -e "${verde}   Docker instalado com sucesso (aparentemente).${reset}"
        # Garante que o serviço Docker está ativo e habilitado para iniciar com o sistema
        sudo systemctl enable docker > /dev/null 2>&1
        sudo systemctl start docker > /dev/null 2>&1
        # Pequena pausa para garantir que o serviço suba
        sleep 5
        # Verifica se o comando docker agora existe
        if command -v docker &> /dev/null; then
            echo -e "${verde}   Verificação do comando Docker pós-instalação [ OK ]${reset}"
            return 0 # Sucesso
        else
            echo -e "${vermelho}   ERRO: Docker foi instalado, mas comando 'docker' ainda não encontrado no PATH?${reset}"
            return 1
        fi
    else
        echo -e "${vermelho}   ERRO: Falha ao executar o script de instalação do Docker (Status: ${install_status}).${reset}"
        return 1 # Falha
    fi
}

install_docker_compose() {
    echo -e "${amarelo}   Docker Compose (V1 ou V2) não encontrado. Tentando instalar V2 (plugin)...${reset}"
    sudo apt update -y > /dev/null 2>&1
    # Tenta instalar o plugin (funciona na maioria dos sistemas baseados em Debian/Ubuntu recentes)
    sudo apt install -y docker-compose-plugin > /dev/null 2>&1 # Redireciona saída
    if command -v docker compose &> /dev/null; then
        echo -e "${verde}   Docker Compose V2 (plugin) instalado com sucesso.${reset}"
        return 0 # Sucesso
    else
        # Se V2 falhou, tenta instalar V1 como fallback (comum em sistemas mais antigos)
        echo -e "${amarelo}   Falha ao instalar V2 (plugin). Tentando instalar V1 (standalone)...${reset}"
        local compose_version="1.29.2" # Use uma versão V1 estável conhecida
        sudo curl -L "https://github.com/docker/compose/releases/download/${compose_version}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        local curl_status=$?
        # Verifica se o curl foi bem sucedido ANTES de tentar o chmod
        if [ $curl_status -eq 0 ]; then
            sudo chmod +x /usr/local/bin/docker-compose
            if command -v docker-compose &> /dev/null; then
                 echo -e "${verde}   Docker Compose V1 (standalone ${compose_version}) instalado com sucesso.${reset}"
                 return 0 # Sucesso com V1
            else
                 echo -e "${vermelho}   ERRO: Falha ao tornar docker-compose V1 executável ou encontrá-lo após download.${reset}"
                 return 1 # Falha
            fi
        else
             echo -e "${vermelho}   ERRO: Falha ao baixar Docker Compose V1 (${compose_version}) (Status Curl: ${curl_status}).${reset}"
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
    echo -e "${branco}                               Setup do Japa${reset}"
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
    echo -e " ${verde}[ 01 ] Traefik & Portainer${reset}"           # <<< VERDE (Ativo)
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

#------------------------------------------------------------------------------
# FUNÇÕES DE INSTALAÇÃO DAS FERRAMENTAS
#------------------------------------------------------------------------------

install_traefik_portainer() {
    # --- Variáveis Locais e Contadores ---
    local traefik_step=0
    local traefik_total_steps=8 # Total de fases principais nesta função
    local INSTALL_DIR="/opt/setup-edisongondo/traefik"
    local GITHUB_RAW_URL="https://raw.githubusercontent.com/Japynha/Setup_EdisonGondo/main/traefik" # *** CONFIRME BRANCH 'main' ***
    local DOMAINNAME=""
    local PORTAINER_SUBDOMAIN="portainer" # Padrão
    local TRAEFIK_SUBDOMAIN="traefik"     # Padrão
    local CLOUDFLARE_EMAIL=""             # Mantido por enquanto
    local CLOUDFLARE_DNS_API_TOKEN=""     # Mantido por enquanto
    local TIMEZONE="America/Sao_Paulo"    # Padrão
    local PUID="1000"                     # Padrão
    local PGID="1000"                     # Padrão
    local INPUT_CONFIRMED=false
    local DOCKER_COMPOSE_CMD=""
    local traefik_ok=false
    local portainer_ok=false

    # Helper para atualizar e mostrar passo
    _update_traefik_step() {
        traefik_step=$((traefik_step + 1))
        echo -e "${branco} ${reset}" # Linha em branco antes do passo
        echo -e "${branco}• ${1} [${traefik_step}/${traefik_total_steps}]${reset}" # Título da Fase
        sleep 1
    }

    # --- Banner de Início da Instalação Específica ---
    clear # Limpa a tela antes de iniciar esta instalação
    echo -e "${verde}-----------------------------------------------------------------------${reset}"
    echo -e "${verde} Iniciando Instalação: Traefik & Portainer${reset}"
    echo -e "${verde}-----------------------------------------------------------------------${reset}"
    sleep 1

    # --- 1. Criar Diretórios ---
    _update_traefik_step "CRIANDO DIRETÓRIOS"
    echo -e "${branco}   Diretório base: ${INSTALL_DIR}${reset}"
    sudo mkdir -p "${INSTALL_DIR}/data/logs"; if [ $? -ne 0 ]; then echo -e "${vermelho}   ERRO: Falha ao criar diretório de logs. Abortando.${reset}"; return 1; fi
    sudo mkdir -p "${INSTALL_DIR}/data/certs"; if [ $? -ne 0 ]; then echo -e "${vermelho}   ERRO: Falha ao criar diretório de certificados. Abortando.${reset}"; return 1; fi
    echo -e "${verde}   Diretórios criados com sucesso.${reset}"

    # --- 2. Criar Rede Docker ---
    _update_traefik_step "CONFIGURANDO REDE DOCKER"
    echo -e "${branco}   Verificando/Criando rede [traefik_proxy]...${reset}"
    if ! sudo docker network inspect traefik_proxy > /dev/null 2>&1; then
        echo -e "${amarelo}   Rede não encontrada. Criando...${reset}"
        if sudo docker network create traefik_proxy > /dev/null; then echo -e "${verde}   Rede [traefik_proxy] criada.${reset}"; else echo -e "${vermelho}   ERRO: Falha ao criar rede Docker [traefik_proxy]. Abortando.${reset}"; return 1; fi
    else echo -e "${verde}   Rede [traefik_proxy] já existe.${reset}"; fi

    # --- 3. Baixar Arquivos de Configuração do SEU GitHub ---
     _update_traefik_step "BAIXANDO ARQUIVOS DE CONFIGURAÇÃO"
    echo -e "${branco}   Baixando de ${GITHUB_RAW_URL}...${reset}"
    sudo rm -f "${INSTALL_DIR}/docker-compose.yml" "${INSTALL_DIR}/data/traefik.yml" # Limpa arquivos antigos
    sudo curl -sSL "${GITHUB_RAW_URL}/docker-compose.yml" -o "${INSTALL_DIR}/docker-compose.yml"; if [ $? -ne 0 ] || [ ! -s "${INSTALL_DIR}/docker-compose.yml" ]; then echo -e "${vermelho}   ERRO: Falha download docker-compose.yml. Verifique URL/arquivo no GitHub. Abortando.${reset}"; return 1; fi
    sudo curl -sSL "${GITHUB_RAW_URL}/traefik.yml" -o "${INSTALL_DIR}/data/traefik.yml"; if [ $? -ne 0 ] || [ ! -s "${INSTALL_DIR}/data/traefik.yml" ]; then echo -e "${vermelho}   ERRO: Falha download traefik.yml. Verifique URL/arquivo no GitHub. Abortando.${reset}"; return 1; fi
    echo -e "${verde}   Arquivos baixados com sucesso.${reset}"

    # --- 4. Obter Informações do Usuário (SEM CLOUDFLARE TOKEN) ---
echo -e "${branco}=> Coletando informações de configuração...${reset}"
# ... (Variáveis locais DOMAINNAME, PORTAINER_SUBDOMAIN, etc. continuam aqui) ...
local LETSENCRYPT_EMAIL="" # Mudou nome da variável

while [[ -z "$DOMAINNAME" ]]; do read -p "   - Digite seu domínio principal (ex: seusite.com): " DOMAINNAME; if [[ -z "$DOMAINNAME" ]]; then echo -e "${vermelho}     O domínio não pode ser vazio!${reset}"; fi; done
read -p "   - Subdomínio Portainer [Padrão: ${PORTAINER_SUBDOMAIN}]: " user_portainer_subdomain; PORTAINER_SUBDOMAIN=${user_portainer_subdomain:-$PORTAINER_SUBDOMAIN}
read -p "   - Subdomínio Dashboard Traefik [Padrão: ${TRAEFIK_SUBDOMAIN}]: " user_traefik_subdomain; TRAEFIK_SUBDOMAIN=${user_traefik_subdomain:-$TRAEFIK_SUBDOMAIN}
# Pergunta apenas pelo Email para Let's Encrypt
while [[ -z "$LETSENCRYPT_EMAIL" ]]; do
    read -p "   - Digite um email válido (para notificações Let's Encrypt): " LETSENCRYPT_EMAIL
     if [[ -z "$LETSENCRYPT_EMAIL" ]]; then
         echo -e "${vermelho}     O email não pode ser vazio!${reset}"
    fi
done
read -p "   - Fuso Horário [Padrão: ${TIMEZONE}]: " user_timezone; TIMEZONE=${user_timezone:-$TIMEZONE}
echo -e "${verde}   Informações preliminares coletadas.${reset}"
sleep 1

# --- Confirmação (ajustada) ---
echo ""; echo -e "${amarelo}--- Por favor, confirme os dados ---${reset}"
echo -e "${branco}  Dominio Principal:       ${verde}${DOMAINNAME}${reset}"
echo -e "${branco}  URL Portainer:           ${verde}https://${PORTAINER_SUBDOMAIN}.${DOMAINNAME}${reset}"
echo -e "${branco}  URL Dashboard Traefik:   ${verde}https://${TRAEFIK_SUBDOMAIN}.${DOMAINNAME}${reset}"
echo -e "${branco}  Email Let's Encrypt:     ${verde}${LETSENCRYPT_EMAIL}${reset}" # Variável mudou
echo -e "${branco}  Fuso Horário:            ${verde}${TIMEZONE}${reset}"
echo ""
local confirmation=""; INPUT_CONFIRMED=false
while true; do read -r -p "As informações estão corretas? (Y/N): " confirmation; case $confirmation in [Yy]*) INPUT_CONFIRMED=true; break ;; [Nn]*) echo -e "${amarelo}Ok, pedindo infos novamente.${reset}"; sleep 1; clear; _update_traefik_step "COLETANDO DADOS DE CONFIGURAÇÃO"; DOMAINNAME=""; LETSENCRYPT_EMAIL=""; break ;; *) echo -e "${vermelho}Inválido.${reset}";; esac; done
if ! $INPUT_CONFIRMED; then continue; fi # Volta a pedir se N
echo -e "${verde}   Informações confirmadas.${reset}"
sleep 1

# --- 5. Criar Arquivo .env REAL ---
echo -e "${branco}=> Criando arquivo .env em ${INSTALL_DIR}...${reset}"
sudo rm -f "${INSTALL_DIR}/.env"
sudo tee "${INSTALL_DIR}/.env" > /dev/null << EOF

    # --- 6. Criar acme.json ---
    _update_traefik_step "PREPARANDO ARQUIVO ACME.JSON (SSL)"
    echo -e "${branco}   Criando e configurando ${INSTALL_DIR}/data/certs/acme.json...${reset}"
    sudo touch "${INSTALL_DIR}/data/certs/acme.json"; if [ $? -ne 0 ]; then echo -e "${vermelho}   ERRO: Falha ao criar acme.json. Abortando.${reset}"; return 1; fi
    sudo chmod 600 "${INSTALL_DIR}/data/certs/acme.json"; if [ $? -ne 0 ]; then echo -e "${vermelho}   ERRO: Falha ao definir permissões para acme.json. Abortando.${reset}"; return 1; fi
    echo -e "${verde}   Arquivo acme.json pronto.${reset}"

    # --- 7. Iniciar os Containers ---
    _update_traefik_step "INICIANDO CONTAINERS TRAEFIK E PORTAINER"
    echo -e "${branco}   Executando 'docker compose up -d' em ${INSTALL_DIR}... (Isso pode levar um tempo)${reset}"
    cd "${INSTALL_DIR}" || { echo -e "${vermelho}ERRO: Não foi possível acessar o diretório ${INSTALL_DIR}. Abortando.${reset}"; return 1; }
    if command -v docker &> /dev/null && command -v docker compose &> /dev/null; then DOCKER_COMPOSE_CMD="docker compose"; elif command -v docker-compose &> /dev/null; then DOCKER_COMPOSE_CMD="docker-compose"; else echo -e "${vermelho}ERRO CRÍTICO: docker compose não encontrado. Abortando.${reset}"; return 1; fi

    sudo ${DOCKER_COMPOSE_CMD} up -d; DOCKER_COMPOSE_STATUS=$?
    echo ""

    if [ $DOCKER_COMPOSE_STATUS -ne 0 ]; then
         echo -e "${vermelho}   ERRO: Falha ao executar '${DOCKER_COMPOSE_CMD} up -d' (Status: ${DOCKER_COMPOSE_STATUS}).${reset}"
         echo -e "${amarelo}          Verifique a saída do Docker Compose acima ou os logs.${reset}"
         echo -e "${amarelo}          Comandos úteis: cd ${INSTALL_DIR} && sudo ${DOCKER_COMPOSE_CMD} config / logs / ps${reset}"
         echo -e "${vermelho}-----------------------------------------------------------------------${reset}"; return 1
    fi

    echo -e "${verde}   Comando '${DOCKER_COMPOSE_CMD} up -d' executado. Aguardando inicialização...${reset}"; sleep 20

    # --- 8. Verificar e Mostrar Feedback ---
    _update_traefik_step "VERIFICANDO STATUS FINAL"
    echo -e "${branco}   Verificando status dos containers...${reset}"
    if sudo docker ps --filter name=traefik_proxy --format '{{.Names}}' | grep -q 'traefik_proxy'; then echo -e "${verde}   [ OK ] Container Traefik (traefik_proxy) está rodando.${reset}"; traefik_ok=true; else echo -e "${vermelho}   [ OFF ] Container Traefik (traefik_proxy) NÃO está rodando.${reset}"; echo -e "${amarelo}          Verifique logs: cd ${INSTALL_DIR} && sudo ${DOCKER_COMPOSE_CMD} logs traefik${reset}"; fi
    if sudo docker ps --filter name=portainer_manager --format '{{.Names}}' | grep -q 'portainer_manager'; then echo -e "${verde}   [ OK ] Container Portainer (portainer_manager) está rodando.${reset}"; portainer_ok=true; else echo -e "${vermelho}   [ OFF ] Container Portainer (portainer_manager) NÃO está rodando.${reset}"; echo -e "${amarelo}          Verifique logs: cd ${INSTALL_DIR} && sudo ${DOCKER_COMPOSE_CMD} logs portainer${reset}"; fi

    echo ""; echo -e "${verde}-----------------------------------------------------------------------${reset}"
    if $traefik_ok && $portainer_ok; then
        echo -e "${verde} Instalação de Traefik & Portainer CONCLUÍDA com Sucesso!${reset}"
        echo -e "${branco}   Acesse o Portainer em:  ${verde}https://${PORTAINER_SUBDOMAIN}.${DOMAINNAME}${reset}"
        echo -e "${branco}   (Crie o usuário admin no primeiro acesso)${reset}"
        echo -e "${branco}   Dashboard Traefik em: ${verde}https://${TRAEFIK_SUBDOMAIN}.${DOMAINNAME}${reset}"
        echo -e "${branco}   (Acesso ao dashboard depende das labels/auth no compose)${reset}"
        echo -e "${verde}-----------------------------------------------------------------------${reset}"; return 0
    else
        echo -e "${vermelho} Instalação de Traefik & Portainer CONCLUÍDA com ERROS.${reset}"; echo -e "${vermelho}   Verifique os logs dos containers.${reset}"; echo -e "${vermelho}-----------------------------------------------------------------------${reset}"; return 1
    fi
}

# --- Adicione outras funções de instalação aqui depois ---
# install_chatwoot() { ... }
# install_n8n() { ... }

#------------------------------------------------------------------------------
# FIM DAS FUNÇÕES DE INSTALAÇÃO
#------------------------------------------------------------------------------

# --- O RESTO DO SCRIPT CONTINUA IGUAL (Verificações, Dependências, Termos, Loop do Menu, Case, Finalização) ---
# --- Certifique-se de que o 'case 1 | 01)' chama esta função 'install_traefik_portainer' ---
# --- Certifique-se de que '[ 01 ]' no menu 'mostrar_menu_ferramentas' está verde ---

# ... (Cole o restante do script da resposta #85 aqui) ...


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

# --- (Seção de Instalação de Dependências - COM INSTALAÇÃO AUTOMÁTICA DE DOCKER/COMPOSE) ---
nome_instalando
TOTAL_STEPS=9 # Reduzido pois update/upgrade saíram da contagem check_status
CURRENT_STEP=0
update_step() { CURRENT_STEP=$((CURRENT_STEP + 1)); }
# Função check_status para dependências que queremos mostrar o status OK/OFF
check_status() {
    local exit_code=$? # Captura o status do COMANDO ANTERIOR (o apt install)
    local step_description=$1
    update_step
    if [ $exit_code -eq 0 ]; then
        echo -e "${verde}${CURRENT_STEP}/${TOTAL_STEPS} - [ OK ] - ${step_description}${reset}"
    else
        echo -e "${vermelho}${CURRENT_STEP}/${TOTAL_STEPS} - [ OFF ] - ${step_description}${reset} (Código de erro: $exit_code)"
        # Considerar se deve sair em caso de erro aqui
    fi
    echo ""
    sleep 0.5
}
echo -e "${branco}Iniciando atualização do sistema (pode demorar)...${reset}"; echo ""
# Roda update e upgrade no início, mostrando a saída deles
sudo apt update -y
sudo apt upgrade -y

echo ""
echo -e "${branco}Iniciando instalação de dependências necessárias...${reset}"; echo ""
# Instala dependências uma por uma, mostrando o status com check_status
sudo apt install -y sudo > /dev/null 2>&1; check_status "Verificando/Instalando sudo"
sudo apt install -y apt-utils > /dev/null 2>&1; check_status "Verificando/Instalando apt-utils"

# --- Verificação e Instalação Automática de Docker ---
echo -e "${branco}=> Verificando Docker...${reset}"
if ! command -v docker &> /dev/null; then
    install_docker # Chama a função para instalar
    if [ $? -ne 0 ]; then echo -e "${vermelho}ERRO FATAL: Falha na instalação automática do Docker. Abortando.${reset}"; exit 1; fi
    if ! command -v docker &> /dev/null; then echo -e "${vermelho}ERRO FATAL: Docker ainda não encontrado após tentativa de instalação. Abortando.${reset}"; exit 1; fi
else
    echo -e "${verde}   Docker já está instalado.${reset}"
fi
sleep 1

# --- Verificação e Instalação Automática de Docker Compose ---
echo -e "${branco}=> Verificando Docker Compose...${reset}"
if ! command -v docker compose &> /dev/null && ! command -v docker-compose &> /dev/null; then
    install_docker_compose # Chama a função para instalar
    if [ $? -ne 0 ]; then echo -e "${vermelho}ERRO FATAL: Falha na instalação automática do Docker Compose. Abortando.${reset}"; exit 1; fi
    if ! command -v docker compose &> /dev/null && ! command -v docker-compose &> /dev/null; then echo -e "${vermelho}ERRO FATAL: Docker Compose ainda não encontrado após tentativa de instalação. Abortando.${reset}"; exit 1; fi
else
    echo -e "${verde}   Docker Compose (V1 ou V2) já está instalado.${reset}"
fi
sleep 1

# --- Continua com as outras dependências ---
sudo apt install -y dialog > /dev/null 2>&1; check_status "Verificando/Instalando dialog"
sudo apt install -y jq > /dev/null 2>&1; check_status "Verificando/Instalando jq"
sudo apt install -y apache2-utils > /dev/null 2>&1; check_status "Verificando/Instalando apache2-utils" # Para gerar senhas basic auth se necessário
sudo apt install -y git > /dev/null 2>&1; check_status "Verificando/Instalando Git"
sudo apt install -y python3 > /dev/null 2>&1; check_status "Verificando/Instalando python3"
sudo apt install -y curl > /dev/null 2>&1; check_status "Verificando/Instalando curl" # Adicionado curl aqui
sudo apt install -y neofetch > /dev/null 2>&1; check_status "Verificando/Instalando neofetch"
# Removido apt update final daqui, pois fazemos no início e no fim do script

echo -e "${verde}Instalação de dependências básicas concluída.${reset}"; sleep 2


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

# Aceite dos Termos (Loop while sugerido para robustez)
while true; do
    read -r -p "Ao digitar Y você concorda com as orientações acima (Y/N): " aceitar_termos
    case $aceitar_termos in
        [Yy]* ) echo ""; break ;; # Continua o script
        [Nn]* ) echo -e "${vermelho}Você escolheu não aceitar os termos. Saindo...${reset}"; exit 1 ;; # Sai do script
        * )     echo -e "${amarelo}Resposta inválida.${branco} Por favor, digite Y para aceitar ou N para sair.${reset}" ;;
    esac
done

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
            # Decide se sai ou tenta um valor padrão? Sair é mais seguro.
            exit 1
        fi
    fi
    echo ""

    ## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##
    ## Processamento da Escolha (Menu de Ferramentas - DENTRO DO LOOP)
    ## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##

    case $opcao_ferramenta in
        1 | 01 ) # Traefik & Portainer
            install_traefik_portainer # Chama a função
            # Verifica o status de retorno da função
            if [ $? -ne 0 ]; then
                 echo -e "${vermelho}ATENÇÃO: A instalação do Traefik & Portainer retornou um erro.${reset}"
                 # Decide se quer parar o script ou apenas voltar ao menu
            fi
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
## Finalização (Só chega aqui se sair do loop com 'break')
## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##

echo -e "${verde}Setup principal concluído.${reset}"
echo -e "${branco}Realizando uma última atualização do sistema...${reset}"

# Removido o redirecionamento para mostrar a saída final
sudo apt update -y
if [ $? -ne 0 ]; then echo -e "${vermelho}[ OFF ] - Update final falhou.${reset}"; fi

sudo apt upgrade -y
if [ $? -ne 0 ]; then echo -e "${vermelho}[ OFF ] - Upgrade final falhou.${reset}"; fi

echo ""
echo -e "${verde}Processo finalizado!${reset}"

exit 0
