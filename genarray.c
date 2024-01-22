#include "genarray.h"

/**
 * BEGIN:   CORRECT ASSIGN/DELETE METHODS
 *
 *          Rather than constantly check if `self->m_assign` is `NULL`, we can 
 *          instead write the function pointers in `self->methods` so that we 
 *          can immediately use the correct callback function. 
 *          
 *          This also has the benefit of the user not needing their callback 
 *          functions to have the same signature as `memcpy` and `memset`, which 
 *          require a size.
 *
 * NOTE:    All these functions are internal, hence the use of `static`.
*/

static void ga_write_user(genarray *self, void *p_dst, const void *p_src)
{
    self->callback.write(p_dst, p_src);
}

static void ga_erase_user(genarray *self, void *p_src)
{
    self->callback.erase(p_src);
}

static void ga_write_default(genarray *self, void *p_dst, const void *p_src)
{
    memcpy(p_dst, p_src, self->m_nsizeof);
}

static void ga_erase_default(genarray *self, void *p_src)
{
    memset(p_src, 0, self->m_nsizeof);
}

/**
 * END: CORRECT ASSIGN/ERASE FUNCTIONS
 */

void ga_init(genarray *self, size_t n_sizeof, ga_writefn write, ga_erasefn erase)
{
    if (self == NULL) {
        perror("ga_init- self is NULL");
        return;
    }
    memset(self, 0, sizeof(*self));
    self->m_nsizeof = n_sizeof;
    // @warning Likely to be very very very error prone!!
    if (write != NULL) {        
        self->callback.write = write;
        self->write = ga_write_user;
    } else {
        self->write = ga_write_default;
    }
    
    if (erase != NULL) {
        self->callback.erase = erase;
        self->erase = ga_erase_user;
    } else {
        self->erase = ga_erase_default;
    }
}

void ga_deinit(genarray *self)
{
    for (size_t i = 0; i < self->m_ncount; i++) {
        size_t n_index = self->m_nsizeof * i;
        self->erase(self, &self->m_pbuffer[n_index]);
    }
    free(self->m_pbuffer);
    self->m_pbuffer = NULL;
    self->m_ncount = 0;
    self->m_ncapacity = 0;
}

/**
 * BEGIN:   DATA ACCESS METHODS
*/

const void *ga_begin_rd(const genarray *self)
{
    return &self->m_pbuffer[0];
}

const void *ga_end_rd(const genarray *self)
{
    // Last valid index.
    size_t n_index = self->m_nsizeof * (self->m_ncount - 1);
    return &self->m_pbuffer[n_index] + self->m_nsizeof;
}

void *ga_begin_wr(genarray *self)
{
    return (void*)ga_begin_rd(self); // BAD
}

void *ga_end_wr(genarray *self)
{
    return (void*)ga_end_rd(self); // BAD
}

const void *ga_retrieve_rd(const genarray *self, size_t n_index)
{
    size_t n_limit = self->m_nsizeof * self->m_ncount;
    // Actual index since it's a byte array
    n_index = self->m_nsizeof * n_index;
    if (n_index >= n_limit) {
        perror("ga_retrieve_rd- out of bounds index");
        return NULL;
    }
    return &self->m_pbuffer[n_index];
}

void *ga_retrieve_wr(genarray *self, size_t n_index)
{
    // BAD!!!!
    return (void*)ga_retrieve_rd(self, n_index);
}

/**
 * END:     DATA ACCESS METHODS
*/

/** 
 * @brief   Start the capacity at 16 as headstart, then grow by multiples of 2. 
 *
 * @note    Not inlined at `-O0`, but might be at `-O1` and above or `-Os`.
 */
static inline size_t ga_newsize(size_t n_capacity)
{
    return (n_capacity > 0) ? n_capacity * 2 : 16;
}

bool ga_push_back(genarray *self, void *p_item)
{
    if (self->m_ncount + 1 > self->m_ncapacity) {
        size_t n_newsize = ga_newsize(self->m_ncapacity);
        if (ga_resize(self, n_newsize) == false) {
            perror("ga_push_back- failed to resize buffer");
            return false;
        }
    }
    // Actual index in terms of accessing contiguous elements in raw bytes.
    size_t n_index = self->m_ncount * self->m_nsizeof;
    self->write(self, &self->m_pbuffer[n_index], p_item);
    self->m_ncount++;
    return true;
}

bool ga_resize(genarray *self, size_t n_newsize)
{
    if (n_newsize == self->m_ncapacity) {
        return true;
    }
    // Since `sizeof(unsigned char) == 1`, should be OK to omit it.
    size_t n_alloc = self->m_nsizeof * n_newsize;

    // Remember: realloc copies and frees the original memory on success!
    ga_byte *p_dummy = realloc(self->m_pbuffer, n_alloc);
    if (p_dummy == NULL) {
        perror("ga_resize- failed to allocate memory for new buffer");
        return false;
    }

    // When shortening the buffer, we copy only up to `n_newsize` elements.
    if (n_newsize < self->m_ncount) {
        self->m_ncount = n_newsize;
    }
    self->m_pbuffer = p_dummy;
    self->m_ncapacity = n_newsize;
    return true;
}
