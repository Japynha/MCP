#!/bin/bash

# Cores para output
amarelo="\e[33m"
verde="\e[32m"
branco="\e[97m"
bege="\e[93m"
vermelho="\e[91m"
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

nome_verificando(){
    clear
    echo ""
    echo -e "$amarelo=========================================================================================>"
    echo -e "$amarelo=                                                                                        >"
    echo -e "$amarelo=       $branco ██╗   ██╗███████╗██████╗ ██╗███████╗██╗ ██████╗ █████╗ ███╗   ██╗██████╗ >"
    echo -e "$amarelo=       $branco ██║   ██║██╔════╝██╔══██╗██║██╔════╝██║██╔════╝██╔══██╗████╗  ██║██╔══██╗>"
    echo -e "$amarelo=       $branco ██║   ██║█████╗  ██████╔╝██║█████╗  ██║██║     ███████║██╔██╗ ██║██║  ██║>"
    echo -e "$amarelo=       $branco ╚██╗ ██╔╝██╔══╝  ██╔══██╗██║██╔══╝  ██║██║     ██╔══██║██║╚██╗██║██║  ██║>"
    echo -e "$amarelo=       $branco  ╚████╔╝ ███████╗██║  ██║██║██║     ██║╚██████╗██║  ██║██║ ╚████║██████╔╝>"
    echo -e "$amarelo=       $branco   ╚═══╝  ╚══════╝╚═╝  ╚═╝╚═╝╚═╝     ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝ >"
    echo -e "$amarelo=                                                                                        >"
    echo -e "$amarelo=========================================================================================>"
    echo ""
    echo ""
}

nome_verificando
echo "Aguarde enquanto verificamos algumas informações."
sleep 1

# Atualizar e fazer upgrade
echo -e "${azul}1/14 [ OK ] Fazendo Upgrade${reset}"
sudo apt update -y > /dev/null 2>&1
echo -e "${azul}2/14 [ OK ] Fazendo Upgrade${reset}"
sudo apt upgrade -y > /dev/null 2>&1

# Instalar dependências comuns
echo -e "${azul}3/14 [ OK ] Verificando / Instalando sudo${reset}"
sudo apt install -y sudo > /dev/null 2>&1
echo -e "${azul}4/14 [ OK ] Verificando / Instalando apt - utils${reset}"
sudo apt install -y apt-utils > /dev/null 2>&1
echo -e "${azul}5/14 [ OK ] Verificando / Instalando dialog${reset}"
sudo apt install -y dialog > /dev/null 2>&1
echo -e "${azul}6/14 [ OK ] Verificando / Instalando jq 1/2${reset}"
sudo apt install -y jq > /dev/null 2>&1
echo -e "${azul}7/14 [ OK ] Verificando / Instalando jq 2/2${reset}"
sudo apt install -y jq > /dev/null 2>&1
echo -e "${azul}8/14 [ OK ] Verificando / Instalando apache2 - utils 1/2${reset}"
sudo apt install -y apache2-utils > /dev/null 2>&1
echo -e "${azul}9/14 [ OK ] Verificando / Instalando apache2 - utils 2/2${reset}"
sudo apt install -y apache2-utils > /dev/null 2>&1
echo -e "${azul}10/14 [ OK ] Verificando / Instalando Git${reset}"
sudo apt install -y git > /dev/null 2>&1
echo -e "${azul}11/14 [ OK ] Verificando / Instalando python3${reset}"
sudo apt install -y python3 > /dev/null 2>&1
echo -e "${azul}12/14 [ OK ] Verificando / Instalando neofetch${reset}"
sudo apt install -y neofetch > /dev/null 2>&1

echo -e "${azul}13/14 [ OK ] Fazendo Update${reset}"
sudo apt update -y > /dev/null 2>&1

echo -e "${azul}14/14 [ OK ] Fazendo Upgrade${reset}"
sudo apt upgrade -y > /dev/null 2>&1

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
