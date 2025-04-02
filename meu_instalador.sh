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
    # Banner e Menu de Ferramentas principal (Opção 03 agora inativa)
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
    echo -e " ${vermelho}[ 01 ] Traefik & Portainer${reset}"
    echo -e " ${vermelho}[ 02 ] Chatwoot${reset}"
    echo -e " ${vermelho}[ 03 ] Evolution API${reset}"                # <<< VERMELHO (Inativo)
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
# FUNÇÕES DE INSTALAÇÃO DAS FERRAMENTAS (Começar a adicionar aqui)
#------------------------------------------------------------------------------

# Exemplo de função vazia para Traefik (a ser preenchida depois)
install_traefik_portainer() {
    echo -e "${amarelo}--- Função install_traefik_portainer() CHAMADA ---${reset}"
    echo -e "${amarelo}   (Lógica de instalação ainda não implementada)${reset}"
    sleep 3
    # return 0 # Retornaria 0 em caso de sucesso real
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

# --- (Seção de Instalação de Dependências - Sem alterações) ---
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
# Se quiser o loop while que sugeri antes para mais robustez, substitua este bloco.
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
echo ""

## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##
## Processamento da Escolha (Menu de Ferramentas - ATUALIZADO)
## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##

case $opcao_ferramenta in
    99 ) # Opção para Sair
        echo -e "${amarelo}Saindo do instalador...${reset}"
        exit 0
        ;;

    # Opções Inativas (01 a 09) - Mostram mensagem "Não implementada"
    # A opção 03 agora está aqui também.
    1 | 01 | 2 | 02 | 3 | 03 | 4 | 04 | 5 | 05 | 6 | 06 | 7 | 07 | 8 | 08 | 9 | 09 )
        # QUANDO IMPLEMENTAR UMA OPÇÃO, EX: TRAEFIK (01):
        # 1. Mude a cor no menu 'mostrar_menu_ferramentas' para verde.
        # 2. Crie a função 'install_traefik_portainer()'.
        # 3. Mova o '1 | 01 )' daqui de baixo para um bloco próprio acima, fazendo ele chamar a função:
        #
        # 1 | 01 ) # Traefik & Portainer
        #    install_traefik_portainer # Chama a função
        #    echo -e "${branco}Pressione Enter para voltar ao menu...${reset}"; read -r
        #    ;;
        #
        # Por enquanto, todas mostram a mensagem abaixo:
        echo -e "${amarelo}AVISO: Opção [ ${opcao_ferramenta} ] ainda não implementada.${reset}"
        echo -e "${branco}       Voltando ao menu em 3 segundos...${reset}" # Esta mensagem pode não ser útil se o script sai depois
        sleep 3
        # NOTA: O script atualmente CONTINUA para a seção de Finalização após esta mensagem.
        # Para um menu que volta a aparecer, seria necessário um loop 'while' em volta
        # da chamada do menu e do 'case'. Podemos adicionar isso depois.
        ;;

    * ) # Qualquer outra entrada inválida
        echo -e "${vermelho}Opção inválida! Saindo...${reset}"
        exit 1
        ;;
esac

# ----- FIM DA SEÇÃO DO MENU MODIFICADA -----


## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##
## Finalização
## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##

echo -e "${verde}Setup principal concluído.${reset}" # Esta mensagem aparecerá após escolher uma opção inativa
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
