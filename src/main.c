#include <stdio.h>
#include <stdlib.h> // Para exit()

int main() {
    printf("Olá, Linux Embarcado!\n");

    FILE *fp;
    double uptime_seconds, idle_seconds;

    // Tenta abrir o arquivo /proc/uptime
    fp = fopen("/proc/uptime", "r");
    if (fp == NULL) {
        perror("Erro ao abrir /proc/uptime");
        return 1; // Retorna um código de erro
    }

    // Lê os dois valores do arquivo
    // O primeiro é o uptime total, o segundo é o tempo ocioso.
    if (fscanf(fp, "%lf %lf", &uptime_seconds, &idle_seconds) == 2) {
        printf("----------------------------------\n");
        printf("Informações do Sistema (de /proc/uptime):\n");
        printf("Tempo de atividade (Uptime): %.2f segundos\n", uptime_seconds);
        printf("Tempo ocioso (Idle time):  %.2f segundos\n", idle_seconds);
        printf("----------------------------------\n");
    } else {
        fprintf(stderr, "Erro ao ler dados de /proc/uptime.\n");
        fclose(fp);
        return 1; // Retorna um código de erro
    }

    // Fecha o arquivo
    fclose(fp);

    return 0; // Sucesso
}