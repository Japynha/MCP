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

total_steps=14
contador=1

# 1/14 - [ OK ] Fazendo Upgrade
echo -e "${azul}${contador}/${total_steps} [ OK ] Fazendo Upgrade${reset}"
contador=$((contador + 1))
sudo apt update -y

# 2/14 - [ OK ] Verificando / Instalando sudo
echo -e "${azul}${contador}/${total_steps} [ OK ] Verificando / Instalando sudo${reset}"
dpkg -s "sudo" >/dev/null 2>&1 || sudo apt install -y "sudo"
contador=$((contador + 1))

# 3/14 - [ OK ] Verificando / Instalando apt - utils
echo -e "${azul}${contador}/${total_steps} [ OK ] Verificando / Instalando apt - utils${reset}"
dpkg -s "apt-utils" >/dev/null 2>&1 || sudo apt install -y "apt-utils"
contador=$((contador + 1))

# 4/14 - [ OK ] Verificando / Instalando dialog
echo -e "${azul}${contador}/${total_steps} [ OK ] Verificando / Instalando dialog${reset}"
dpkg -s "dialog" >/dev/null 2>&1 || sudo apt install -y "dialog"
contador=$((contador + 1))

# 5/14 - [ OK ] Verificando / Instalando jq 1/2
echo -e "${azul}${contador}/${total_steps} [ OK ] Verificando / Instalando jq 1/2${reset}"
dpkg -s "jq" >/dev/null 2>&1 || sudo apt install -y "jq"
contador=$((contador + 1))

# 6/14 - [ OK ] Verificando / Instalando jq 2/2 (já instalado no passo anterior, mas para manter a ordem)
echo -e "${azul}${contador}/${total_steps} [ OK ] Verificando / Instalando jq 2/2${reset}"
contador=$((contador + 1))

# 7/14 - [ OK ] Verificando / Instalando apache2 - utils 1/2
echo -e "${azul}${contador}/${total_steps} [ OK ] Verificando / Instalando apache2 - utils 1/2${reset}"
dpkg -s "apache2-utils" >/dev/null 2>&1 || sudo apt install -y "apache2-utils"
contador=$((contador + 1))

# 8/14 - [ OK ] Verificando / Instalando apache2 - utils 2/2 (já instalado no passo anterior)
echo -e "${azul}${contador}/${total_steps} [ OK ] Verificando / Instalando apache2 - utils 2/2${reset}"
contador=$((contador + 1))

# 9/14 - [ OK ] Verificando / Instalando Git
echo -e "${azul}${contador}/${total_steps} [ OK ] Verificando / Instalando Git${reset}"
dpkg -s "git" >/dev/null 2>&1 || sudo apt install -y "git"
contador=$((contador + 1))

# 10/14 - [ OK ] Verificando / Instalando python3
echo -e "${azul}${contador}/${total_steps} [ OK ] Verificando / Instalando python3${reset}"
dpkg -s "python3" >/dev/null 2>&1 || sudo apt install -y "python3"
contador=$((contador + 1))

# 11/14 - [ OK ] Fazendo Update
echo -e "${azul}${contador}/${total_steps} [ OK ] Fazendo Update${reset}"
contador=$((contador + 1))
sudo apt update -y

# 12/14 - [ OK ] Fazendo Upgrade
echo -e "${azul}${contador}/${total_steps} [ OK ] Fazendo Upgrade${reset}"
contador=$((contador + 1))
sudo apt upgrade -y

# 13/14 - [ OK ] Verificando / Instalando neofetch
echo -e "${azul}${contador}/${total_steps} [ OK ] Verificando / Instalando neofetch${reset}"
dpkg -s "neofetch" >/dev/null 2>&1 || sudo apt install -y "neofetch"
contador=$((contador + 1))

# 14/14 - [ OK ] Baixando o script (esta etapa será a exibição do seu banner e menu)
echo -e "${azul}${contador}/${total_steps} [ OK ] Baixando o script${reset}"

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
