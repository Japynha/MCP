#!/bin/bash

# Verificar se está rodando como root
if [ "<span class="math-inline">EUID" \-ne 0 \]; then
echo \-e "\\e\[31mEste script precisa ser executado como root\\e\[0m"
echo \-e "\\e\[33mUse\: sudo bash meu\_instalador\.sh\\e\[0m"
exit 1
fi
\# Cores para output
verde\="\\e\[32m"
vermelho\="\\e\[31m"
amarelo\="\\e\[33m"
azul\="\\e\[34m"
roxo\="\\e\[35m"
reset\="\\e\[0m"
\# Banner
echo \-e "
██╗  ██╗██╗████████╗    ██╗   ██╗██████╗ ███████╗
██║ ██╔╝██║╚══██╔══╝    ██║   ██║██╔══██╗██╔════╝
█████╔╝ ██║   ██║       ██║   ██║██████╔╝███████╗
██╔═██╗ ██║   ██║       ╚██╗ ██╔╝██╔═══╝ ╚════██║
██║  ██╗██║   ██║        ╚████╔╝ ██║     ███████║
╚═╝  ╚═╝╚═╝   ╚═╝         ╚═══╝  ╚═╝     ╚══════╝
"
echo \-e ""
echo \-e "███████╗██████╗ ██╗███████╗ ██████╗ ███╗   ██╗     ██████╗  ██████╗ ███╗   ██╗██████╗  ██████╗"
echo \-e "██╔════╝██╔══██╗██║██╔════╝██╔═══██╗████╗  ██║    ██╔════╝ ██╔═══██╗████╗  ██║██╔══██╗██╔═══██╗"
echo \-e "█████╗  ██║  ██║██║███████╗██║   ██║██╔██╗ ██║    ██║  ███╗██║   ██║██╔██╗ ██║██║  ██║██║   ██║"
echo \-e "██╔══╝  ██║  ██║██║╚════██║██║   ██║██║╚██╗██║    ██║   ██║██║   ██║██║╚██╗██║██║  ██║██║   ██║"
echo \-e "███████╗██████╔╝██║███████╗╚██████╔╝██║ ╚████║    ╚██████╔╝╚██████╔╝██║ ╚████║██████╔╝╚██████╔╝"
echo \-e "╚══════╝╚═════╝ ╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═══╝     ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝╚═════╝  ╚═════╝"
echo \-e ""
echo \-e "                 Setup do Japa"
echo \-e ""
\# Atualizar e fazer upgrade
echo \-e "</span>{azul}Atualizando listas de pacotes...<span class="math-inline">\{reset\}"
sudo apt update
echo \-e "</span>{azul}Fazendo upgrade dos pacotes...<span class="math-inline">\{reset\}"
sudo apt upgrade \-y
\# Instalar dependências comuns \(seguindo a ordem do Orion Design\)
declare \-a dependencias\=\("sudo" "apt\-utils" "dialog" "jq" "apache2\-utils" "git" "python3" "neofetch"\)
total\_dependencias\=</span>{#dependencias[@]}
echo -e "<span class="math-inline">\{azul\}Verificando/Instalando dependências comuns\.\.\.</span>{reset}"
contador=1
for dependencia in "<span class="math-inline">\{dependencias\[@\]\}"; do
echo \-e "</span>{azul}<span class="math-inline">\{contador\}/</span>{total_dependencias} [ OK ] Verificando/Instalando <span class="math-inline">\{dependencia\}</span>{reset}"
    dpkg -s "$dependencia" >/dev/null 2>&1 || sudo apt install -y "<span class="math-inline">dependencia"
contador\=</span>((contador + 1))
done

echo ""
echo -e "<span class="math-inline">\{amarelo\}Aguarde enquanto verificamos algumas informações\.\.\.</span>{reset}"
echo ""

# Exibir uma licença básica (você pode personalizar isso)
echo -e "<span class="math-inline">\{azul\}\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=</span>{reset}"
echo -e "<span class="math-inline">\{azul\}\=                                                                                                 \=</span>{reset}"
echo -e "<span class="math-inline">\{azul\}\=   Este auto instalador foi desenvolvido para auxiliar na instalação de algumas ferramentas\.   \=</span>{reset}"
echo -e "<span class="math-inline">\{azul\}\=   Use com responsabilidade e esteja ciente dos riscos de executar scripts como root\.   \=</span>{reset}"
echo -e "<span class="math-inline">\{azul\}\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=</span>{reset}"
echo ""

read -p "Ao digitar Y você concorda com as orientações acima (Y/N): " aceitar_termos
if [[ "$aceitar_termos" != "Y" && "<span class="math-inline">aceitar\_termos" \!\= "y" \]\]; then
echo \-e "</span>{vermelho}Você não aceitou os termos. Saindo...<span class="math-inline">\{reset\}"
exit 1
fi
echo ""
\# 1\. Mostra as opções disponíveis
echo \-e "</span>{azul}Opções disponíveis:<span class="math-inline">\{reset\}"
echo \-e "</span>{amarelo}1${reset} - Instalar Evolution API MCP"
echo -e "<span class="math-inline">\{amarelo\}2</span>{reset} - Sair"
echo ""

# 2. Faz a pausa e aguarda a escolha do usuário
if [ -t 0 ]; then
    read -p "> " opcao
else
    if [ -e /dev/tty ]; then
        read -p "> " opcao < /dev/
