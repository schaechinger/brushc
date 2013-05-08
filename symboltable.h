#ifndef SYMBOLTABLE_H
#define SYMBOLTABLE_H 

typedef struct node
{
	struct node *next;
	char *symbol;
	int level;
	int isDeclared;
}  node;

extern node *insert(char *s);
extern node *lookup(char *s);
extern node *delete(char *s);
extern void scope_open(void);
extern void scope_close(void);

#endif