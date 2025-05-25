# Makefile para um projeto C simples em Linux Embarcado

# --- Configurações do Compilador ---
# Use 'arm-linux-gnueabihf-' como exemplo para cross-compilação.
# Altere para o prefixo do seu toolchain específico (ex: aarch64-linux-gnu-)
# Se CROSS_COMPILE não for definido, usará o compilador nativo (gcc).
CROSS_COMPILE ?=
CC = $(CROSS_COMPILE)gcc

# Flags de Compilação
# -Wall: Habilita a maioria dos avisos do compilador
# -Wextra: Habilita alguns avisos extras
# -O2: Nível de otimização comum
# -g: Inclui informações de debug (útil para gdb)
CFLAGS = -Wall -Wextra -O2 -g

# Flags do Linker (se necessário, para bibliotecas adicionais)
LDFLAGS =

# --- Configurações do Projeto ---
# Nome do executável final
TARGET = meu_app

# Diretório dos fontes
SRC_DIR = src

# Arquivos fonte (encontra todos os .c no SRC_DIR)
SRCS = $(wildcard $(SRC_DIR)/*.c)

# Arquivos objeto (substitui .c por .o)
OBJS = $(SRCS:.c=.o)


## Como rodar este projeto no Windows usando WSL

Se você está usando Windows, este programa só funcionará corretamente em um ambiente Linux, pois depende do arquivo `/proc/uptime`.  
Você pode usar o **WSL (Windows Subsystem for Linux)** para rodar o código sem problemas.

### Passos para rodar no WSL

1. **Abra o terminal do WSL**  
   Procure por "Ubuntu" ou sua distribuição Linux no menu iniciar do Windows.

2. **Acesse a pasta do projeto**  
   No terminal do WSL, navegue até a pasta do projeto. Por exemplo:
   ```bash
   cd /mnt/c/Users/Diego/Downloads/meu_projeto_linux_embarcado/src
   ```

3. **Instale o GCC (caso ainda não tenha)**  
   ```bash
   sudo apt update && sudo apt install gcc -y
   ```

4. **Compile o programa**  
   ```bash
   gcc main.c -o main
   ```

5. **Execute o programa**  
   ```bash
   ./main
   ```

Assim, o programa conseguirá acessar `/proc/uptime` normalmente e mostrar as informações do sistema.

# --- Regras do Makefile ---

# Regra padrão: compila tudo
all: $(TARGET)

# Regra para criar o executável final
$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -o $(TARGET) $(LDFLAGS)
	@echo "Executável '$(TARGET)' criado com sucesso."

# Regra para compilar arquivos .c para .o
# $< é o primeiro pré-requisito (o arquivo .c)
# $@ é o nome do alvo (o arquivo .o)
$(SRC_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@

# Regra para limpar arquivos compilados e o executável
clean:
	rm -f $(OBJS) $(TARGET)
	@echo "Arquivos compilados e executável removidos."

# Phony targets não são nomes de arquivos reais
.PHONY: all clean

