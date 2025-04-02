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
    # Não é o menu principal de ferramentas
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
    # Banner e Menu de Ferramentas principal (Com lista inicial e cores Ativo/Inativo)
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
    echo -e " ${vermelho}[ 01 ] Traefik & Portainer${reset}"         # Inativo -> Vermelho
    echo -e " ${vermelho}[ 02 ] Chatwoot${reset}"                  # Inativo -> Vermelho
    echo -e " ${verde}[ 03 ] Evolution API${reset}"                # ATIVO -> Verde
    echo -e " ${vermelho}[ 04 ] MinIO${reset}"                     # Inativo -> Vermelho
    echo -e " ${vermelho}[ 05 ] Typebot${reset}"                   # Inativo -> Vermelho
    echo -e " ${vermelho}[ 06 ] N8N${reset}"                       # Inativo -> Vermelho
    echo -e " ${vermelho}[ 07 ] Flowise${reset}"                   # Inativo -> Vermelho
    echo -e " ${vermelho}[ 08 ] Wordpress${reset}"                 # Inativo -> Vermelho
    echo -e " ${vermelho}[ 09 ] Chatwoot Nestor${reset}"           # Inativo -> Vermelho
    # Adicione mais ferramentas aqui conforme for implementando (lembre de mudar a cor para verde)
    echo ""
    echo -e " ${vermelho}[ 99 ] Sair${reset}"                      # Sair -> Vermelho
    echo ""
    # Separador Inferior do Menu (Largura ~95)
    echo -e "${amarelo}===============================================================================================${reset}"
    echo ""
}


## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##
## Verificações Iniciais e Instalação de Dependências
## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##

# --- (Seção de Verificação Inicial - Sem alterações, apenas indentação corrigida) ---
nome_verificando
echo -e "${branco}Aguarde enquanto verificamos algumas informações...${reset}"
sleep 1

# 1. Verifica se o usuário é root
if [ "$(id -u)" -ne 0 ]; then
    echo -e "${vermelho}ERRO:${branco} Este script precisa ser executado como root.${reset}"
    echo -e "${branco}Use: sudo bash <(curl -sSL URL_DO_SEU_SCRIPT)${reset}"
    exit 1
fi
echo -e "${verde}INFO:${branco} Verificação de usuário root [ OK ]${reset}"
sleep 1

# 2. Verifica Sistema Operacional (Exemplo)
if [ -f /etc/os-release ]; then
    . /etc/os-release
    if [[ "$ID" != "ubuntu" && "$ID" != "debian" ]]; then
        echo -e "${amarelo}AVISO:${branco} Este script foi testado principalmente em Debian/Ubuntu.${reset}"
        echo -e "${branco}       Você está usando $PRETTY_NAME. Continue por sua conta e risco.${reset}"
        sleep 3
    else
        echo -e "${verde}INFO:${branco} Verificação do Sistema Operacional ($PRETTY_NAME) [ OK ]${reset}"
        sleep 1
    fi
else
    echo -e "${amarelo}AVISO:${branco} Não foi possível verificar a distribuição Linux.${reset}"
    sleep 2
fi

# --- (Seção de Instalação de Dependências - Sem alterações, apenas indentação corrigida) ---
nome_instalando # Chama o banner de instalação

TOTAL_STEPS=11
CURRENT_STEP=0

update_step() {
    CURRENT_STEP=$((CURRENT_STEP + 1))
}

check_status() {
    local step_description=$1
    update_step
    if [ $? -eq 0 ]; then
        echo -e "${verde}${CURRENT_STEP}/${TOTAL_STEPS} - [ OK ] - ${step_description}${reset}"
    else
        echo -e "${vermelho}${CURRENT_STEP}/${TOTAL_STEPS} - [ OFF ] - ${step_description}${reset}"
    fi
    echo ""
    sleep 0.5
}

echo -e "${branco}Iniciando atualização e instalação de dependências...${reset}"
echo ""

apt update -y > /dev/null 2>&1; check_status "Fazendo Update Inicial"
apt upgrade -y > /dev/null 2>&1; check_status "Fazendo Upgrade Inicial"
apt install -y sudo > /dev/null 2>&1; check_status "Verificando/Instalando sudo"
apt install -y apt-utils > /dev/null 2>&1; check_status "Verificando/Instalando apt-utils"
apt install -y dialog > /dev/null 2>&1; check_status "Verificando/Instalando dialog"
apt install -y jq > /dev/null 2>&1; check_status "Verificando/Instalando jq"
apt install -y apache2-utils > /dev/null 2>&1; check_status "Verificando/Instalando apache2-utils"
apt install -y git > /dev/null 2>&1; check_status "Verificando/Instalando Git"
apt install -y python3 > /dev/null 2>&1; check_status "Verificando/Instalando python3"
apt install -y neofetch > /dev/null 2>&1; check_status "Verificando/Instalando neofetch"
apt update -y > /dev/null 2>&1; check_status "Fazendo Update Final (pré-menu)"

echo -e "${verde}Verificação e instalação de dependências concluídas.${reset}"
sleep 2

## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##
## Termos e Menu Principal <<-- SEÇÃO MODIFICADA ABAIXO
## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##

# Exibir termos (Caixa ajustada para ~95 caracteres de largura, incluindo padding interno)
echo -e "${azul}===============================================================================================${reset}" # 95 '='
echo -e "${azul}= ${branco}                                                                                           ${azul} =${reset}" # 91 espaços internos
echo -e "${azul}= ${branco} Este auto instalador foi desenvolvido para auxiliar na instalação de algumas ferramentas.             ${azul} =${reset}" # Texto + 13 espaços
echo -e "${azul}= ${branco} Use com responsabilidade e esteja ciente dos riscos de executar scripts como root.              ${azul} =${reset}" # Texto + 14 espaços
echo -e "${azul}= ${branco}                                                                                           ${azul} =${reset}" # 91 espaços internos
echo -e "${azul}===============================================================================================${reset}" # 95 '='
echo ""

# Aceite dos Termos (Mantida a lógica original do seu script)
read -p "Ao digitar Y você concorda com as orientações acima (Y/N): " aceitar_termos
if [[ "$aceitar_termos" != "Y" && "$aceitar_termos" != "y" ]]; then
    echo -e "${vermelho}Você não aceitou os termos. Saindo...${reset}"
    exit 1
fi
echo ""

# ----- INÍCIO DA SEÇÃO DO MENU MODIFICADA -----

# Chama a nova função para mostrar o menu de ferramentas completo
mostrar_menu_ferramentas

# Leitura da opção do novo menu
if [ -t 0 ]; then
    read -p "Digite o número da opção desejada: " opcao_ferramenta
else
    if [ -e /dev/tty ]; then
        read -p "Digite o número da opção desejada: " opcao_ferramenta < /dev/tty
    else
        echo -e "${vermelho}ERRO: Não é possível ler a entrada. Execute o script em um terminal interativo.${reset}"
        exit 1
    fi
fi
echo "" # Adiciona uma linha em branco após a leitura

## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##
## Processamento da Escolha (Menu de Ferramentas)
## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##

case $opcao_ferramenta in
    3 | 03 ) # Opção para Instalar Evolution API
        echo -e "${azul}Iniciando instalação do Evolution API MCP...${reset}"
        echo -e "${amarelo}Baixando script de configuração...${reset}"
        echo ""

        EVOLUTION_SCRIPT_URL="https://raw.githubusercontent.com/Japynha/MCP/main/install_evolution.sh"
        EVOLUTION_SCRIPT_NAME="install_evolution.sh"

        if [ -e "$EVOLUTION_SCRIPT_NAME" ]; then
            echo -e "${amarelo}AVISO: Removendo versão anterior de $EVOLUTION_SCRIPT_NAME...${reset}"
            rm -f "$EVOLUTION_SCRIPT_NAME"
        fi

        curl -fsSL "$EVOLUTION_SCRIPT_URL" -o "$EVOLUTION_SCRIPT_NAME"
        CURL_STATUS=$?
        if [ $CURL_STATUS -eq 0 ]; then
            echo -e "${verde}[ OK ] - Download do script $EVOLUTION_SCRIPT_NAME concluído.${reset}"
            echo ""
            chmod +x "$EVOLUTION_SCRIPT_NAME"

            echo -e "${branco}Executando $EVOLUTION_SCRIPT_NAME...${reset}"
            echo -e "${amarelo}-------------------- Log do Script $EVOLUTION_SCRIPT_NAME --------------------${reset}"
            "./$EVOLUTION_SCRIPT_NAME"
            EXEC_STATUS=$?
            echo -e "${amarelo}------------------ Fim do Log do Script $EVOLUTION_SCRIPT_NAME ------------------${reset}"
            echo ""

            if [ $EXEC_STATUS -eq 0 ]; then
                echo -e "${verde}[ OK ] - Script $EVOLUTION_SCRIPT_NAME executado com sucesso.${reset}"
            else
                echo -e "${vermelho}[ OFF ] - Script $EVOLUTION_SCRIPT_NAME finalizado com erro (Status: $EXEC_STATUS).${reset}"
                echo -e "${amarelo}       Verifique o log acima para mais detalhes.${reset}"
            fi

            echo -e "${branco}Removendo script baixado ($EVOLUTION_SCRIPT_NAME)...${reset}"
            rm -f "$EVOLUTION_SCRIPT_NAME"
            echo ""
        else
            echo -e "${vermelho}[ OFF ] - Erro ao baixar o script $EVOLUTION_SCRIPT_NAME (Status Curl: $CURL_STATUS).${reset}"
            echo -e "${vermelho}        Verifique sua conexão com a internet ou a URL e tente novamente.${reset}"
            exit 1
        fi
        ;; # Fim da opção 3

    99 ) # Opção para Sair
        echo -e "${amarelo}Saindo do instalador...${reset}"
        exit 0
        ;;

    # Placeholders para outras opções (01, 02, 04-09)
    1 | 01 | 2 | 02 | 4 | 04 | 5 | 05 | 6 | 06 | 7 | 07 | 8 | 08 | 9 | 09 )
        echo -e "${amarelo}AVISO: Opção [ $opcao_ferramenta ] ainda não implementada.${reset}"
        sleep 3 # Pausa para o usuário ver a mensagem
        # Considere adicionar 'exit 0' ou chamar o menu novamente aqui
        ;;

    * ) # Qualquer outra entrada inválida
        echo -e "${vermelho}Opção inválida! Saindo...${reset}"
        exit 1
        ;;
esac

# ----- FIM DA SEÇÃO DO MENU MODIFICADA -----


## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##
## Finalização (Sem alterações, apenas indentação corrigida)
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
