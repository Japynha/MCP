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
## Banners (Adaptados do seu script original)
## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##

nome_verificando(){
    # Banner de Verificação/Aviso Inicial
    clear
    echo ""
    echo -e "$amarelo=========================================================================================${reset}"
    echo -e "$amarelo= ${branco}Verificando Pré-requisitos...${reset}"
    echo -e "$amarelo=========================================================================================${reset}"
    echo ""
}

nome_instalando(){
    # Banner para a fase de instalação
    clear
    echo ""
    echo -e "$azul=========================================================================================${reset}"
    # Seu banner principal aqui
    echo -e "${azul}██╗  ██╗██╗████████╗    ██╗  ██╗██████╗ ███████╗${reset}"
    echo -e "${azul}██║ ██╔╝██║╚══██╔══╝    ██║  ██║██╔══██╗██╔════╝${reset}"
    echo -e "${azul}█████╔╝ ██║   ██║       ██║  ██║██████╔╝███████╗${reset}"
    echo -e "${azul}██╔═██╗ ██║   ██║       ╚██╗ ██╔╝██╔═══╝ ╚════██║${reset}"
    echo -e "${azul}██║  ██╗██║   ██║        ╚████╔╝ ██║     ███████║${reset}"
    echo -e "${azul}╚═╝  ╚═╝╚═╝   ╚═╝         ╚═══╝  ╚═╝     ╚══════╝${reset}"
    echo ""
    echo -e "${azul}███████╗██████╗ ██╗███████╗ ██████╗ ███╗   ██╗    ██████╗  ██████╗ ███╗   ██╗██████╗  ██████╗${reset}"
    echo -e "${azul}██╔════╝██╔══██╗██║██╔════╝██╔═══██╗████╗  ██║   ██╔════╝ ██╔═══██╗████╗  ██║██╔══██╗██╔═══██╗${reset}"
    echo -e "${azul}█████╗  ██║  ██║██║███████╗██║   ██║██╔██╗ ██║   ██║  ███╗██║   ██║██╔██╗ ██║██║  ██║██║   ██║${reset}"
    echo -e "${azul}██╔══╝  ██║  ██║██║╚════██║██║   ██║██║╚██╗██║   ██║   ██║██║   ██║██║╚██╗██║██║  ██║██║   ██║${reset}"
    echo -e "${azul}███████╗██████╔╝██║███████╗╚██████╔╝██║ ╚████║   ╚██████╔╝╚██████╔╝██║ ╚████║██████╔╝╚██████╔╝${reset}"
    echo -e "${azul}╚══════╝╚═════╝ ╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═══╝    ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝╚═════╝  ╚═════╝${reset}"
    echo ""
    echo -e "${branco}                          Setup do Japa${reset}"
    echo -e "$azul=========================================================================================${reset}"
    echo ""
}

## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##
## Verificações Iniciais
## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##

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

# 2. Verifica Sistema Operacional (Exemplo - ajuste se necessário)
if [ -f /etc/os-release ]; then
    . /etc/os-release
    if [[ "$ID" != "ubuntu" && "$ID" != "debian" ]]; then # Exemplo: Aceita Ubuntu ou Debian
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

## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##
## Instalação de Dependências (com Verificação $?)
## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##

nome_instalando

TOTAL_STEPS=11 # Ajuste conforme o número total de passos nesta seção
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
        # Considere adicionar 'exit 1' aqui se a falha for crítica
    fi
    echo "" # Linha em branco para espaçamento
    sleep 0.5 # Pequena pausa
}

echo -e "${branco}Iniciando atualização e instalação de dependências...${reset}"
echo ""

# 1. Update Inicial
apt update -y > /dev/null 2>&1
check_status "Fazendo Update Inicial"

# 2. Upgrade Inicial
apt upgrade -y > /dev/null 2>&1
check_status "Fazendo Upgrade Inicial"

# 3. Instalando sudo
apt install -y sudo > /dev/null 2>&1
check_status "Verificando/Instalando sudo"

# 4. Instalando apt-utils
apt install -y apt-utils > /dev/null 2>&1
check_status "Verificando/Instalando apt-utils"

# 5. Instalando dialog
apt install -y dialog > /dev/null 2>&1
check_status "Verificando/Instalando dialog"

# 6. Instalando jq
apt install -y jq > /dev/null 2>&1
check_status "Verificando/Instalando jq"

# 7. Instalando apache2-utils
apt install -y apache2-utils > /dev/null 2>&1
check_status "Verificando/Instalando apache2-utils"

# 8. Instalando git
apt install -y git > /dev/null 2>&1
check_status "Verificando/Instalando Git"

# 9. Instalando python3
apt install -y python3 > /dev/null 2>&1
check_status "Verificando/Instalando python3"

# 10. Instalando neofetch
apt install -y neofetch > /dev/null 2>&1
check_status "Verificando/Instalando neofetch"

# 11. Update Final (antes do menu/próximo passo)
apt update -y > /dev/null 2>&1
check_status "Fazendo Update Final"

echo -e "${verde}Verificação e instalação de dependências concluídas.${reset}"
sleep 2

## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##
## Termos e Menu Principal
## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##

# Exibir termos
echo -e "${azul}===================================================================================================${reset}"
echo -e "${azul}= ${branco}                                                                                         ${azul} =${reset}"
echo -e "${azul}= ${branco} Este auto instalador foi desenvolvido para auxiliar na instalação de algumas ferramentas. ${azul} =${reset}"
echo -e "${azul}= ${branco} Use com responsabilidade e esteja ciente dos riscos de executar scripts como root.     ${azul} =${reset}"
echo -e "${azul}= ${branco}                                                                                         ${azul} =${reset}"
echo -e "${azul}===================================================================================================${reset}"
echo ""

# Aceite dos Termos
read -p "Ao digitar Y você concorda com as orientações acima (Y/N): " aceitar_termos
if [[ "$aceitar_termos" != "Y" && "$aceitar_termos" != "y" ]]; then
    echo -e "${vermelho}Você não aceitou os termos. Saindo...${reset}"
    exit 1
fi
echo ""

# Menu de Opções
nome_instalando # Mostra o banner principal novamente antes do menu

echo -e "${azul}Opções disponíveis:${reset}"
echo -e "${amarelo}1${reset} - Instalar Evolution API MCP"
echo -e "${amarelo}2${reset} - Sair"
echo ""

# Leitura da opção (mantendo a lógica de TTY)
if [ -t 0 ]; then
    read -p "> " opcao
else
    if [ -e /dev/tty ]; then
        read -p "> " opcao < /dev/tty
    else
        echo -e "${vermelho}ERRO: Não é possível ler a entrada. Execute o script em um terminal interativo.${reset}"
        exit 1
    fi
fi

## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##
## Processamento da Escolha e Execução
## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##

case $opcao in
    1)
        echo -e "${azul}Iniciando instalação do Evolution API MCP...${reset}"
        echo -e "${amarelo}Baixando script de configuração...${reset}"
        echo ""

        EVOLUTION_SCRIPT_URL="https://raw.githubusercontent.com/Japynha/MCP/main/install_evolution.sh"
        EVOLUTION_SCRIPT_NAME="install_evolution.sh" # Define o nome do arquivo

        # Remove o script se já existir
        if [ -e "$EVOLUTION_SCRIPT_NAME" ]; then
            echo -e "${amarelo}AVISO: Removendo versão anterior de $EVOLUTION_SCRIPT_NAME...${reset}"
            rm -f "$EVOLUTION_SCRIPT_NAME"
        fi

        # Baixa o script com verificação de erro
        curl -fsSL "$EVOLUTION_SCRIPT_URL" -o "$EVOLUTION_SCRIPT_NAME"
        if [ $? -eq 0 ]; then
            echo -e "${verde}[ OK ] - Download do script $EVOLUTION_SCRIPT_NAME concluído.${reset}"
            echo ""
            chmod +x "$EVOLUTION_SCRIPT_NAME"

            echo -e "${branco}Executando $EVOLUTION_SCRIPT_NAME...${reset}"
            echo -e "${amarelo}-------------------- Log do Script $EVOLUTION_SCRIPT_NAME --------------------${reset}"
            # Executa o script filho
            "./$EVOLUTION_SCRIPT_NAME"
            EXEC_STATUS=$? # Captura o status de saída do script filho
            echo -e "${amarelo}------------------ Fim do Log do Script $EVOLUTION_SCRIPT_NAME ------------------${reset}"
            echo ""

            if [ $EXEC_STATUS -eq 0 ]; then
                echo -e "${verde}[ OK ] - Script $EVOLUTION_SCRIPT_NAME executado com sucesso.${reset}"
            else
                echo -e "${vermelho}[ OFF ] - Script $EVOLUTION_SCRIPT_NAME finalizado com erro (Status: $EXEC_STATUS).${reset}"
                echo -e "${amarelo}       Verifique o log acima para mais detalhes.${reset}"
            fi

            # Limpeza
            echo -e "${branco}Removendo script baixado ($EVOLUTION_SCRIPT_NAME)...${reset}"
            rm -f "$EVOLUTION_SCRIPT_NAME"
            echo ""

        else
            echo -e "${vermelho}[ OFF ] - Erro ao baixar o script $EVOLUTION_SCRIPT_NAME.${reset}"
            echo -e "${vermelho}        Verifique sua conexão com a internet ou a URL e tente novamente.${reset}"
            exit 1
        fi
        ;;
    2)
        echo -e "${amarelo}Saindo do instalador...${reset}"
        exit 0
        ;;
    *)
        echo -e "${vermelho}Opção inválida! Saindo...${reset}"
        exit 1
        ;;
esac

## // ## // ## // ## // ## // ## // ## // ## //## // ## // ## // ## // ## // ## // ## // ## // ##
## Finalização
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
# Opcional: clear no final
# clear

exit 0
