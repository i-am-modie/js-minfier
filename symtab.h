#include<stdio.h>
/* maksymalny rozmiar tablicy hashujacej */
#define SIZE 211
 
#define MAXLEN 40
 
typedef struct list_t{
    char st_name[MAXLEN];
    char new_name[MAXLEN];
    struct list_t *next;
}list_t;
 
static list_t **hash_table;

void init_hash_table(); 
unsigned int hash(char *key, int len); 
void insert(char *name, int len ); 
list_t *lookup(char *name, int len); 
void clear_hash_table();