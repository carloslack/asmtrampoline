#include <stdio.h>
#include <stdlib.h>

struct st1
{
    int x;
};
struct st2
{
    int y;
    int w;
};

/**
 * asm.S
 */
extern int show_value(struct st1 *s1, struct st2 *s2);

/**
 * hook function
 */
int h_show_value(struct st1 *s1, struct st2 *s2)
{
    //change values :)
    s1->x = s1->x *= 2;
    s2->y = s2->y *= 2;
    s2->w = s2->w *= 2;

    return 0;
}

int main(int argc, char **argv)
{
    struct st1 *s1;
    struct st2 *s2;
    int ret;

    s1 = calloc(1, sizeof(struct st1));
    s2 = calloc(1, sizeof(struct st2));
    s1->x = 10;
    s2->y = 20;
    s2->w = 30;

    printf("sending[%p(val1=%d):%p(val1=%d, val2=%d)] \n", s1, s1->x, s2, s2->y, s2->w);
    ret = show_value(s1, s2);
    printf("got[%p(val1=%d):%p(val1=%d, val2=%d)] \n", s1, s1->x, s2, s2->y, s2->w);
    printf("ret=%d\n", ret);
    free(s1);
    free(s2);

    return 0;
}
