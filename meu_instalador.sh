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
                        ██╗  ██╗██╗████████╗    ██╗   ██╗██████╗ ███████╗
                        ██║ ██╔╝██║╚══██╔══╝    ██║   ██║██╔══██╗██╔════╝
                        █████╔╝ ██║   ██║       ██║   ██║██████╔╝███████╗
                        ██╔═██╗ ██║   ██║       ╚██╗ ██╔╝██╔═══╝ ╚════██║
                        ██║  ██╗██║   ██║        ╚████╔╝ ██║     ███████║
                        ╚═╝  ╚═╝╚═╝   ╚═╝         ╚═══╝  ╚═╝     ╚══════╝
"
echo -e ""
echo -e "███████╗██████╗ ██╗███████╗ ██████╗ ███╗   ██╗     ██████╗  ██████╗ ███╗   ██╗██████╗  ██████╗"
echo -e "██╔════╝██╔══██╗██║██╔════╝██╔═══██╗████╗  ██║    ██╔════╝ ██╔═══██╗████╗  ██║██╔══██╗██╔═══██╗"
echo -e "█████╗  ██║  ██║██║███████╗██║   ██║██╔██╗ ██║    ██║  ███╗██║   ██║██╔██╗ ██║██║  ██║██║   ██║"
echo -e "██╔══╝  ██║  ██║██║╚════██║██║   ██║██║╚██╗██║    ██║   ██║██║   ██║██║╚██╗██║██║  ██║██║   ██║"
echo -e "███████╗██████╔╝██║███████╗╚██████╔╝██║ ╚████║    ╚██████╔╝╚██████╔╝██║ ╚████║██████╔╝╚██████╔╝"
echo -e "╚══════╝╚═════╝ ╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═══╝     ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝╚═════╝  ╚═════╝"
echo -e ""
echo -e "                 Setup do Japa"
echo -e ""

# Atualizar e fazer upgrade
echo -e "${azul}Atualizando listas de pacotes...${reset}"
sudo apt update
echo -e "${azul}Fazendo upgrade dos pacotes...${reset}"
sudo apt upgrade -y

# Instalar dependências comuns (seguindo a ordem do Orion Design)
declare -a dependencias=("sudo" "apt-utils" "dialog" "jq" "apache2-utils" "git" "python3" "neofetch")
total_dependencias=${#dependencias[@]}
echo -e "${azul}Verificando/Instalando dependências comuns...${reset}"
contador=1
for dependencia in "${dependencias[@]}"; do
    echo -e "${azul}${contador}/${total_dependencias} [ OK ] Verificando/Instalando ${dependencia}${reset}"
    dpkg -s "$dependencia" >/dev/null 2>&1 || sudo apt install -y "$dependencia"
    contador=$((contador + 1))
done

echo ""
echo -e "${amarelo}Aguarde enquanto verificamos algumas informações...${reset}"
echo ""

# Exibir uma licença básica (você pode personalizar isso)
echo -e "${azul}===================================================================================================${reset}"
echo -e "${azul}=                                                                                                 =${reset}"
echo -e "${azul}=   Este auto instalador foi desenvolvido para auxiliar na instalação de algumas ferramentas.   =${reset}"
echo -e "${azul}=   Use com responsabilidade e esteja ciente dos riscos de executar scripts como root.   =${reset}"
echo -e "${azul}===================================================================================================${reset}"
echo ""

read -p "Ao digitar Y você concorda com as orientações acima (Y/N): " aceitar_termos
if [[ "$aceitar_termos" != "Y" && "$aceitar_termos" != "y" ]]; then
    echo -e "${vermelho}Você não aceitou os termos. Saindo...${reset}"
    exit 1
fi

echo ""

# 1. Mostra as opções disponíveis
echo -e "${azul}Opções disponíveis:${reset}"
echo -e "${amarelo}1${reset} - Instalar Evolution API MCP"
echo -e "${amarelo}2${reset} - Sair"
echo ""

# 2. Faz a pausa e aguarda a escolha do usuário
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
        EVOLUTION_SCRIPT_URL="https://raw.githubusercontent.com/Japynha/MCP/main/install_evolution.sh"
        curl -fsSL "$EVOLUTION_SCRIPT_URL" -o install_evolution.sh

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
