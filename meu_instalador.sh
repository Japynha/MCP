#!/bin/bash

# Verificar se está rodando como root
if [ "$EUID" -ne 0 ]; then
    echo -e "\e[31mEste script precisa ser executado como root\e[0m"
    echo -e "\e[33mUse: sudo bash meu_instalador.sh\e[0m"
    exit 1
fi

# Cores para output
verde="\e[32m"
vermelho="\e[31m"
amarelo="\e[33m"
azul="\e[34m"
roxo="\e[35m"
reset="\e[0m"

# Banner
echo -e "
                        ██╗  ██╗██╗████████╗    ██╗   ██╗██████╗ ███████╗
                        ██║ ██╔╝██║╚══██╔══╝    ██║   ██║██╔══██╗██╔════╝
                        █████╔╝ ██║   ██║       ██║   ██║██████╔╝███████╗
                        ██╔═██╗ ██║   ██║       ╚██╗ ██╔╝██╔═══╝ ╚════██║
                        ██║  ██╗██║   ██║        ╚████╔╝ ██║     ███████║
                        ╚═╝  ╚═╝╚═╝   ╚═╝         ╚═══╝  ╚═╝     ╚══════╝
"
echo -e ""
echo -e "███████╗██████╗ ██╗███████╗ ██████╗ ███╗   ██╗     ██████╗  ██████╗ ███╗   ██╗██████╗  ██████╗"
echo -e "██╔════╝██╔══██╗██║██╔════╝██╔═══██╗████╗  ██║    ██╔════╝ ██╔═══██╗████╗  ██║██╔══██╗██╔═══██╗"
echo -e "█████╗  ██║  ██║██║███████╗██║   ██║██╔██╗ ██║    ██║  ███╗██║   ██║██╔██╗ ██║██║  ██║██║   ██║"
echo -e "██╔══╝  ██║  ██║██║╚════██║██║   ██║██║╚██╗██║    ██║   ██║██║   ██║██║╚██╗██║██║  ██║██║   ██║"
echo -e "███████╗██████╔╝██║███████╗╚██████╔╝██║ ╚████║    ╚██████╔╝╚██████╔╝██║ ╚████║██████╔╝╚██████╔╝"
echo -e "╚══════╝╚═════╝ ╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═══╝     ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝╚═════╝  ╚═════╝"
echo -e ""
echo -e "          O básico para iniciar com as automações"
echo -e ""

# 1. Mostra as opções disponíveis
echo -e "${azul}Opções disponíveis:${reset}"
echo -e "${amarelo}1${reset} - Instalar Evolution API MCP"
echo -e "${amarelo}2${reset} - Sair"
echo ""

# 2. Faz a pausa e aguarda a escolha do usuário
echo -e "${amarelo}Digite a opção desejada (1 ou 2) e pressione ENTER${reset}"
echo -e "${amarelo}Se você estiver vendo esta mensagem, o script está aguardando sua entrada${reset}"

# Tentar ler a entrada do usuário
if [ -t 0 ]; then
    read -p "> " opcao
else
    if [ -e /dev/tty ]; then
        read -p "> " opcao < /dev/tty
    else
        echo -e "${amarelo}Por favor, execute o script diretamente:${reset}"
        exit 1
    fi
fi

# 3. Validação da entrada
if [[ ! "$opcao" =~ ^[1-2]$ ]]; then
    echo -e "${vermelho}Opção inválida!${reset}"
    echo -e "${amarelo}Por favor, execute o script novamente.${reset}"
    exit 1
fi

# 4. Processamento da escolha
case $opcao in
    1)
        echo -e "${azul}Iniciando instalação do Evolution API MCP...${reset}"
        echo -e "${amarelo}Baixando script de configuração...${reset}"

        # Baixar o script setup_evolution.sh do repositório do Japynha
        EVOLUTION_SCRIPT_URL="EVOLUTION_SCRIPT_URL="https://raw.githubusercontent.com/Japynha/MCP/main/install_evolution.sh""
        curl -fsSL "$EVOLUTION_SCRIPT_URL" -o setup_evolution.sh

        if [ $? -eq 0 ]; then
            echo -e "${verde}Script baixado com sucesso!${reset}"
            chmod +x setup_evolution.sh
            sudo ./setup_evolution.sh
        else
            echo -e "${vermelho}Erro ao baixar o script. Verifique sua conexão com a internet e tente novamente.${reset}"
            exit 1
        fi
        ;;
    2)
        echo -e "${amarelo}Saindo do instalador...${reset}"
        exit 0
        ;;
esac
