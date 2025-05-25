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