#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "symtab.h"
#include "randomString.h"
 
void init_hash_table(){
    int i;
    hash_table = malloc(SIZE * sizeof(list_t*));
    for(i = 0; i < SIZE; i++) hash_table[i] = NULL;
}
 
unsigned int hash(char *key){
    unsigned int hashval = 0;
    for(;*key!='\0';key++) hashval += *key;
    hashval += key[0] % 11 + (key[0] << 3) - key[0];
    return hashval % SIZE;
}
 
void insert(char *name, int len){
    unsigned int hashval = hash(name);
    list_t *l = hash_table[hashval];
   
    while ((l != NULL) && (strcmp(name,l->st_name) != 0)) l = l->next;
   
    // NIE ZNALEZIONO dodajemy
    if (l == NULL){
        l = (list_t*) malloc(sizeof(list_t));
        strcpy(l->st_name, name);  
        /* add to hashtable */
        char* new_name = randstring(6);
        strcpy(l->new_name, new_name);
        l->next = hash_table[hashval];
        hash_table[hashval] = l;
    }
}
 
list_t *lookup(char *name){
    unsigned int hashval = hash(name);
    list_t *l = hash_table[hashval];
    while ((l != NULL) && (strcmp(name,l->st_name) != 0)) l = l->next;
    return l; // NULLABLE
}

void clear_hash_table(){
    free(hash_table);
}
