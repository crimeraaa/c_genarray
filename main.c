#include <stdio.h> /* printf */
#include "genarray.h"

/**
 * Disassembly options:
 * ```txt
 * -M                           Determine the assembly syntax to use.
 *      Intel                   -Mintel
 *      AT&T                    -Matt
 * --disassemble                Display assembler contents of executable sections.
 * --source                     Intermix source code with disassembly.
 * --source-comment[=<pat>]     Prefix comments with <pat> (default: '#')
 * --wide                       Format output for more than 80 columns.
 * --visualize-jumps=<opt>      Visualize jumps by drawing ASCII art lines.
 *      off                     Disable jump visualization.
 *      color                   Use basic colors: 
 *      extended-color          Use extended 8-bit color codes.
 * --disassembler-color=<opt>   Enable, disable or use 8-bit color in output.
 *      on                      Enable color output. 
 *      off                     Disable color output. 
 *      terminal                Enable on terminal. 
 *      extended                Use 8-bit colors. 
 * ```
 * 
 * My current preference is:
 * ```txt
 * objdump -Mintel --disassemble --source --source-comment --wide --visualize-jumps=extended-color --disassembler-color=terminal
 * ```
 */

void test_write(genarray *self)
{
    int arr[] = {2, 3, 5, 7, 11, 13, 17, 19, 23};
    const size_t len = sizeof(arr) / sizeof(*arr);
    for (size_t i = 0; i < len; i++) {
        ga_push_back(self, &arr[i]);
    }
}

void test_foreach(const genarray *self)
{
    printf("test_foreach():\n");
    ga_foreach(int, item, self) {
        printf("%i\n", *item);
    }
    printf("\n");
}

void test_forloop(const genarray *self)
{
    printf("test_forloop():\n");
    for (size_t i = 0; i < ga_length(self); i++) {
        const int *item = ga_retrieve_rd(self, i);
        printf("ga[%zu] = %i (%p)\n", i, *item, (void*)item);
    }
    printf("ga[%zu] = end = %p\n", ga_length(self), ga_end_rd(self));
}

void test_invalid(const genarray *self)
{
    const int *pi = ga_retrieve_rd(self, ga_length(self));
    (void)pi;
}

int main(void)
{
    genarray ga = ga_create(sizeof(int), NULL, NULL); 
    genarray *inst = &ga;
    {
        test_write(inst);
        test_foreach(inst);
        test_forloop(inst);
        test_invalid(inst);
    }
    ga_deinit(inst);
    return 0;
}
