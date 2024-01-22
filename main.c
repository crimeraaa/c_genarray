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

int main(void)
{
    genarray ga; 
    genarray *inst = &ga;
    ga_init(inst, sizeof(int), NULL, NULL);
    int arr[] = {2, 3, 5, 7, 11, 13, 17, 19, 23};
    const size_t len = sizeof(arr) / sizeof(*arr);
    for (size_t i = 0; i < len; i++) {
        ga_push_back(inst, &arr[i]);
    }
    ga_foreach_rd(item, inst, int) {
        printf("%i\n", *item);
    }
    for (size_t i = 0; i < inst->m_ncount; i++) {
        const int *item = ga_retrieve_rd(inst, i);
        printf("ga[%zu] = %i (%p)\n", i, *item, (void*)item);
    }
    printf("end = %p\n", ga_end_rd(inst));
    ga_deinit(inst);
    return 0;
}
