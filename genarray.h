#ifndef CRIM_GENARRAY_H
#define CRIM_GENARRAY_H

#ifdef __cplusplus
extern "C" {
#endif

#include <stdbool.h>
#include <stdlib.h> /* malloc, realloc, free */
#include <stdio.h> /* perror */
#include <string.h> /* memcpy, memset */

// For my sanity, I'll use the smallest available datatype as our "byte".
typedef unsigned char ga_byte;

/**
 * NOTE:    Forward declaration allows us to alias the name `genarray`
 *          to `struct genarray` even if the struct definition isn't present.
 */

/**
 * @brief   A C++ style container that poorly attempts to be a one-size-fits-all
 *          implementation of an array for literally any datatype.
 * 
 * @warning This is a very stupid idea, especially in C. You have been warned!
 */
typedef struct genarray genarray;

/**
 * @brief   Your custom callback function for assignment.
 *
 * @param   p_dst   Address of the destination element, from `m_pbuffer`.
 * @param   p_src   Address of the source element passed into `ga_push_back`.
 */
typedef void (*ga_writefn)(void *p_dst, const void *p_src);

/**
 * @brief   Custom callback function for element erasure. 
 * 
 * @param   p_src   Address of the desired element to be destroyed.
 */
typedef void (*ga_erasefn)(void *p_src);

/**
 * @brief   Container for callback functions to be called by function pointers
 *          in the main struct: `.write` and `.erase` respectively.
 */
typedef struct ga_callbacks {
    ga_writefn write;
    ga_erasefn erase;
} ga_callbacks;

struct genarray {
    ga_byte *m_pbuffer; // Malloc'd pointer to raw bytes.
    size_t m_ncount; // Number elements currently written to buffer.
    size_t m_ncapacity; // Number of elements buffer is allocated for.
    size_t m_nsizeof; // Size of each element, very important!!!
    /**
     * @brief   Copy the value of `p_src` to `p_dst`. 
     * 
     * @param   self    Pointer to the `genarray` instance.
     * @param   p_dst   Pointer to the element to be copied to. Actually, this is
     *                  the poitner to the first byte of it.
     * @param   p_src   Value to be copied to `p_dst`.
     *
     * @note    If you passed a callback function to `ga_init`, this will call 
     *          said callback function. Otherwise, we just use `memcpy` and 
     *          `self->m_nsizeof`. Think carefully about this!
     */
    void (*write)(genarray *self, void *p_dst, const void *p_src);
    
    /**
     * @brief   Similar to `.write`, but to delete/destroy/erase an element.
     *     
     * @param   self    Pointer to the `genarray` instance.
     * @param   p_src   Pointer to the element to be removed. Actually, this is 
     *                  more accurately the pointer to the first byte of it.
     */
    void (*erase)(genarray *self, void *p_src);
    ga_callbacks callback;
};

/**
 * @brief   Give the appropriate element size and callback functions (or `NULL`).
 * 
 * @note    We actually populate the internal structures with the correct
 *          function pointers. It gets quite ugly!
 * 
 * @warning From this point on, YOU are responsible for type safety!
 */
void ga_init(genarray *self, size_t n_sizeof, ga_writefn write, ga_erasefn erase);

/**
 * @brief   Erases all elements in the internal array and frees the array itself.
 * 
 * @note    By default, all the array elements are shallow copies, so the 
 *          `self->erase` function pointer is kinda... pointless!
 */
void ga_deinit(genarray *self);

/**
 * @brief   Read-only pointer to the first element.
 */
const void *ga_begin_rd(const genarray *self);

/**
 * @brief   Read-only pointer to 1 past the last element.
 * 
 * @warning Do not reference this, it's uninitialized/unallocated memory!
 */
const void *ga_end_rd(const genarray *self);

/**
 * @brief   Retrieve a read-only pointer to the `n_index`'th element.
 * 
 * @return  The address of said element, or `NULL` if requested invalid index.
 */
const void *ga_retrieve_rd(const genarray *self, size_t n_index);

/**
 * @brief   Read-write pointer to the first element.
 */
void *ga_begin_wr(genarray *self);

/**
 * @brief   Read-write pointer to 1 past the last element.
 * 
 * @warning Do not reference this, it's uninitialized/unallocated memory!
*/
void *ga_end_wr(genarray *self);

/**
 * @brief   Retrieve a read-write pointer to the `n_index`'th element.
 * 
 * @return  Address of said element in the buffer, or `NULL` if out of bounds.
*/
void *ga_retrieve_wr(genarray *self, size_t n_index);

/**
 * @brief   Append the value of `p_item` to the end of the internal buffer.
 *          If we need to resize, we will.
 * 
 * @return  On error, `false`. Whoever calls this (YOU!) must handle the error.
 *
 * @warning No type safety is guaranteed so it's up to you to ensure `p_item`
 *          is originally the correct type that the array is meant to hold.
 */
bool ga_push_back(genarray *self, void *p_item);

/**
 * @brief   Resizes the internal buffer according to the given size as well as
 *          the element's size you passed to `ga_init`.
 *          
 * @return  On error, `false`. Whoever calls this must handle the error.
 *
 * @warning This really relies on you to get `ga_init` down correctly!
 */
bool ga_resize(genarray *self, size_t n_newsize);

#define ga_impl_foreach(var, self, T, beginfn, endfn) \
    for (T *var = beginfn(self), *end = endfn(self); var < end; var++)

#define ga_foreach_rd(varname, self, T) \
    ga_impl_foreach(varname, self, const T, ga_begin_rd, ga_end_rd)

#define ga_foreach_wr(varname, self, T) \
    ga_impl_foreach(varname, self, T, ga_begin_wr, ga_end_wr)

#ifdef __cplusplus
}
#endif /* 1st extern "C" */

#endif /* CRIM_GENARRAY_H */
