#include<stdio.h>
#include<string.h>
#include<stdlib.h>

struct symbol_table
{
	char type[10];
	char sym[10];
	int value;
	//int lno[10];
	struct symbol_table *next;
};
typedef struct symbol_table symtab;
symtab st[1000];
int symbols = 0;
void insert(char *typ,char *var,int val);
void display();
int search(char *var);
void modify(char *var,int val);

void insert(char *typ,char *var,int val)
{
	strcpy(st[symbols].type,typ);
	strcpy(st[symbols].sym,var);
	if(isalpha(val))
		strcpy(st[symbols].value,val);
	else
		st[symbols].value = val;
	symbols++;
}

void display()
{
	int i = 0;
	while(i<symbols)
	{
		printf("%s,%s,%d\n",st[i].type,st[i].sym,st[i].value);
		i++;
	}
	printf("Done\n");
}

int search(char *var)
{
	int i = 0;
	while(i<symbols)
	{
		if(strcmp(st[i].sym,var)==0)
			return i;
		
		i++; 
	}
	return -1;
}

void modify(char *var,int val)
{
	int i = 0;
	while(i<symbols)
	{
		if(strcmp(st[i].sym,var)==0)
		{
			st[i].value = val;
			return ;
		}
		i++;
	}
	printf("Symbol not found\n");
	return ;
}
/*
int main()
{
	insert("int","a",10);
	insert("int","b",20);
	insert("char","c",11);
	display();
	printf("a is at %d\n",search("a"));
	printf("d is at %d\n",search("d"));
	modify("a",100);
	modify("d",200);
	display();
	return 0;
}
*/
