
./obj/genarray.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <ga_assign_user>:
# 
# // For my sanity, I'll use the smallest available datatype as our "byte".
# typedef unsigned char byte;
# 
# static void ga_assign_user(generic_array *self, void *p_dst, const void *p_src)
# {
   0:	55                   	push   rbp
   1:	48 89 e5             	mov    rbp,rsp
   4:	48 83 ec 20          	sub    rsp,0x20
   8:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
   c:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
  10:	48 89 55 e8          	mov    QWORD PTR [rbp-0x18],rdx
#     self->fns.assign(p_dst, p_src);
  14:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
  18:	48 8b 48 20          	mov    rcx,QWORD PTR [rax+0x20]
  1c:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
  20:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
  24:	48 89 d6             	mov    rsi,rdx
  27:	48 89 c7             	mov    rdi,rax
  2a:	ff d1                	call   rcx
# }
  2c:	90                   	nop
  2d:	c9                   	leave
  2e:	c3                   	ret

000000000000002f <ga_assign_default>:
# 
# static void ga_assign_default(generic_array *self, void *p_dst, const void *p_src)
# {
  2f:	55                   	push   rbp
  30:	48 89 e5             	mov    rbp,rsp
  33:	48 83 ec 20          	sub    rsp,0x20
  37:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
  3b:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
  3f:	48 89 55 e8          	mov    QWORD PTR [rbp-0x18],rdx
#     memcpy(p_dst, p_src, self->m_nsizeof);
  43:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
  47:	48 8b 50 18          	mov    rdx,QWORD PTR [rax+0x18]
  4b:	48 8b 4d e8          	mov    rcx,QWORD PTR [rbp-0x18]
  4f:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
  53:	48 89 ce             	mov    rsi,rcx
  56:	48 89 c7             	mov    rdi,rax
  59:	e8 00 00 00 00       	call   5e <ga_assign_default+0x2f>
# }
  5e:	90                   	nop
  5f:	c9                   	leave
  60:	c3                   	ret

0000000000000061 <ga_delete_user>:
# 
# static void ga_delete_user(generic_array *self, void *p_src)
# {
  61:	55                   	push   rbp
  62:	48 89 e5             	mov    rbp,rsp
  65:	48 83 ec 10          	sub    rsp,0x10
  69:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
  6d:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
#     self->fns.erase(p_src);
  71:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
  75:	48 8b 50 28          	mov    rdx,QWORD PTR [rax+0x28]
  79:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
  7d:	48 89 c7             	mov    rdi,rax
  80:	ff d2                	call   rdx
# }
  82:	90                   	nop
  83:	c9                   	leave
  84:	c3                   	ret

0000000000000085 <ga_delete_default>:
# 
# static void ga_delete_default(generic_array *self, void *p_src)
# {
  85:	55                   	push   rbp
  86:	48 89 e5             	mov    rbp,rsp
  89:	48 83 ec 10          	sub    rsp,0x10
  8d:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
  91:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
#     memset(p_src, 0, self->m_nsizeof);
  95:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
  99:	48 8b 50 18          	mov    rdx,QWORD PTR [rax+0x18]
  9d:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
  a1:	be 00 00 00 00       	mov    esi,0x0
  a6:	48 89 c7             	mov    rdi,rax
  a9:	e8 00 00 00 00       	call   ae <ga_delete_default+0x29>
# }
  ae:	90                   	nop
  af:	c9                   	leave
  b0:	c3                   	ret

00000000000000b1 <ga_init>:
# 
# void ga_init(generic_array *self, size_t n_sizeof, ga_assign_fn assign, ga_erase_fn erase)
# {
  b1:	55                   	push   rbp
  b2:	48 89 e5             	mov    rbp,rsp
  b5:	48 83 ec 20          	sub    rsp,0x20
  b9:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
  bd:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
  c1:	48 89 55 e8          	mov    QWORD PTR [rbp-0x18],rdx
  c5:	48 89 4d e0          	mov    QWORD PTR [rbp-0x20],rcx
#     memset(self, 0, sizeof(*self));
  c9:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
  cd:	ba 40 00 00 00       	mov    edx,0x40
  d2:	be 00 00 00 00       	mov    esi,0x0
  d7:	48 89 c7             	mov    rdi,rax
  da:	e8 00 00 00 00       	call   df <ga_init+0x2e>
#     self->m_nsizeof = n_sizeof;
  df:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
  e3:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
  e7:	48 89 50 18          	mov    QWORD PTR [rax+0x18],rdx
#     // @warning Likely to be very very very error prone!!
#     if (assign != NULL) {        
  eb:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
  f0:	74 1d                	je     10f <ga_init+0x5e>
#         self->fns.assign = assign;
  f2:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
  f6:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
  fa:	48 89 50 20          	mov    QWORD PTR [rax+0x20],rdx
#         self->methods.assign = ga_assign_user;
  fe:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 102:	48 8d 15 f7 fe ff ff 	lea    rdx,[rip+0xfffffffffffffef7]        # 0 <ga_assign_user>
 109:	48 89 50 30          	mov    QWORD PTR [rax+0x30],rdx
 10d:	eb 0f                	jmp    11e <ga_init+0x6d>
#     } else {
#         self->methods.assign = ga_assign_default;
 10f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 113:	48 8d 15 15 ff ff ff 	lea    rdx,[rip+0xffffffffffffff15]        # 2f <ga_assign_default>
 11a:	48 89 50 30          	mov    QWORD PTR [rax+0x30],rdx
#     }
#     
#     if (erase != NULL) {
 11e:	48 83 7d e0 00       	cmp    QWORD PTR [rbp-0x20],0x0
 123:	74 1d                	je     142 <ga_init+0x91>
#         self->fns.erase = erase;
 125:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 129:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
 12d:	48 89 50 28          	mov    QWORD PTR [rax+0x28],rdx
#         self->methods.erase = ga_delete_user;
 131:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 135:	48 8d 15 25 ff ff ff 	lea    rdx,[rip+0xffffffffffffff25]        # 61 <ga_delete_user>
 13c:	48 89 50 38          	mov    QWORD PTR [rax+0x38],rdx
#     } else {
#         self->methods.erase = ga_delete_default;
#     }
# }
 140:	eb 0f                	jmp    151 <ga_init+0xa0>
#         self->methods.erase = ga_delete_default;
 142:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 146:	48 8d 15 38 ff ff ff 	lea    rdx,[rip+0xffffffffffffff38]        # 85 <ga_delete_default>
 14d:	48 89 50 38          	mov    QWORD PTR [rax+0x38],rdx
# }
 151:	90                   	nop
 152:	c9                   	leave
 153:	c3                   	ret

0000000000000154 <ga_deinit>:
# 
# void ga_deinit(generic_array *self)
# {
 154:	55                   	push   rbp
 155:	48 89 e5             	mov    rbp,rsp
 158:	48 83 ec 20          	sub    rsp,0x20
 15c:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
#     for (size_t i = 0; i < self->m_ncount; i++) {
 160:	48 c7 45 f8 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
 167:	00 
 168:	eb 3b                	jmp    1a5 <ga_deinit+0x51>
#         size_t n_index = self->m_nsizeof * i;
 16a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 16e:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
 172:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
 176:	48 0f af c2          	imul   rax,rdx
 17a:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
#         self->methods.erase(self, &self->m_pbuffer[n_index]);
 17e:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 182:	48 8b 50 38          	mov    rdx,QWORD PTR [rax+0x38]
 186:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 18a:	48 8b 08             	mov    rcx,QWORD PTR [rax]
 18d:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 191:	48 01 c1             	add    rcx,rax
 194:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 198:	48 89 ce             	mov    rsi,rcx
 19b:	48 89 c7             	mov    rdi,rax
 19e:	ff d2                	call   rdx
#     for (size_t i = 0; i < self->m_ncount; i++) {
 1a0:	48 83 45 f8 01       	add    QWORD PTR [rbp-0x8],0x1
 1a5:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 1a9:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
 1ad:	48 39 45 f8          	cmp    QWORD PTR [rbp-0x8],rax
 1b1:	72 b7                	jb     16a <ga_deinit+0x16>
#     }
#     free(self->m_pbuffer);
 1b3:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 1b7:	48 8b 00             	mov    rax,QWORD PTR [rax]
 1ba:	48 89 c7             	mov    rdi,rax
 1bd:	e8 00 00 00 00       	call   1c2 <ga_deinit+0x6e>
#     self->m_pbuffer = NULL;
 1c2:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 1c6:	48 c7 00 00 00 00 00 	mov    QWORD PTR [rax],0x0
#     self->m_ncount = 0;
 1cd:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 1d1:	48 c7 40 08 00 00 00 	mov    QWORD PTR [rax+0x8],0x0
 1d8:	00 
#     self->m_ncapacity = 0;
 1d9:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 1dd:	48 c7 40 10 00 00 00 	mov    QWORD PTR [rax+0x10],0x0
 1e4:	00 
# }
 1e5:	90                   	nop
 1e6:	c9                   	leave
 1e7:	c3                   	ret

00000000000001e8 <ga_resize>:
# 
# bool ga_resize(generic_array *self, size_t n_newsize)
# {
 1e8:	55                   	push   rbp
 1e9:	48 89 e5             	mov    rbp,rsp
 1ec:	48 83 ec 30          	sub    rsp,0x30
 1f0:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
 1f4:	48 89 75 d0          	mov    QWORD PTR [rbp-0x30],rsi
#     // Since `sizeof(unsigned char) == 1`, should be OK to omit it.
#     size_t n_allocsize = self->m_nsizeof * n_newsize;
 1f8:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 1fc:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
 200:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
 204:	48 0f af c2          	imul   rax,rdx
 208:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
#     ga_byte *p_dummy = realloc(self->m_pbuffer, n_allocsize);
 20c:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 210:	48 8b 00             	mov    rax,QWORD PTR [rax]
 213:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
 217:	48 89 d6             	mov    rsi,rdx
 21a:	48 89 c7             	mov    rdi,rax
 21d:	e8 00 00 00 00       	call   222 <ga_resize+0x3a>
 222:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
#     if (p_dummy == NULL) {
 226:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
 22b:	75 19                	jne    246 <ga_resize+0x5e>
#         perror("ga_resize- failed to resize buffer:");
 22d:	48 8d 05 00 00 00 00 	lea    rax,[rip+0x0]        # 234 <ga_resize+0x4c>
 234:	48 89 c7             	mov    rdi,rax
 237:	e8 00 00 00 00       	call   23c <ga_resize+0x54>
#         return false;
 23c:	b8 00 00 00 00       	mov    eax,0x0
 241:	e9 a0 00 00 00       	jmp    2e6 <ga_resize+0xfe>
#     }
#     // When shortening the buffer, we copy only up to `n_newsize` elements.
#     if (n_newsize < self->m_ncount) {
 246:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 24a:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
 24e:	48 39 45 d0          	cmp    QWORD PTR [rbp-0x30],rax
 252:	73 0c                	jae    260 <ga_resize+0x78>
#         self->m_ncount = n_newsize;
 254:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 258:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
 25c:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
#     }
#     // Deep copy so we can get rid of the old buffer.
#     for (size_t i = 0; i < self->m_ncount; i++) {
 260:	48 c7 45 f8 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
 267:	00 
 268:	eb 43                	jmp    2ad <ga_resize+0xc5>
#         size_t n_index = self->m_nsizeof * i;
 26a:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 26e:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
 272:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
 276:	48 0f af c2          	imul   rax,rdx
 27a:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
#         self->methods.assign(self, &p_dummy[n_index], &self->m_pbuffer[n_index]);
 27e:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 282:	48 8b 48 30          	mov    rcx,QWORD PTR [rax+0x30]
 286:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 28a:	48 8b 10             	mov    rdx,QWORD PTR [rax]
 28d:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 291:	48 01 c2             	add    rdx,rax
 294:	48 8b 75 e8          	mov    rsi,QWORD PTR [rbp-0x18]
 298:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 29c:	48 01 c6             	add    rsi,rax
 29f:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 2a3:	48 89 c7             	mov    rdi,rax
 2a6:	ff d1                	call   rcx
#     for (size_t i = 0; i < self->m_ncount; i++) {
 2a8:	48 83 45 f8 01       	add    QWORD PTR [rbp-0x8],0x1
 2ad:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 2b1:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
 2b5:	48 39 45 f8          	cmp    QWORD PTR [rbp-0x8],rax
 2b9:	72 af                	jb     26a <ga_resize+0x82>
#     }
#     free(self->m_pbuffer);
 2bb:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 2bf:	48 8b 00             	mov    rax,QWORD PTR [rax]
 2c2:	48 89 c7             	mov    rdi,rax
 2c5:	e8 00 00 00 00       	call   2ca <ga_resize+0xe2>
#     self->m_pbuffer = p_dummy;
 2ca:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 2ce:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
 2d2:	48 89 10             	mov    QWORD PTR [rax],rdx
#     self->m_ncapacity = n_newsize;
 2d5:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 2d9:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
 2dd:	48 89 50 10          	mov    QWORD PTR [rax+0x10],rdx
#     return true;
 2e1:	b8 01 00 00 00       	mov    eax,0x1
# }
 2e6:	c9                   	leave
 2e7:	c3                   	ret

00000000000002e8 <ga_push_back>:
# 
# void ga_push_back(generic_array *self, void *p_item)
# {
 2e8:	55                   	push   rbp
 2e9:	48 89 e5             	mov    rbp,rsp
 2ec:	48 83 ec 20          	sub    rsp,0x20
 2f0:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
 2f4:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
#     if (self->m_ncount + 1 > self->m_ncapacity) {
 2f8:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 2fc:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
 300:	48 8d 50 01          	lea    rdx,[rax+0x1]
 304:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 308:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
 30c:	48 39 d0             	cmp    rax,rdx
 30f:	73 36                	jae    347 <ga_push_back+0x5f>
#         // Start cap w/ 1 then grow by multiples of 2
#         size_t n_newsize = (self->m_ncapacity > 0) ? self->m_ncapacity * 2 : 1;
 311:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 315:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
 319:	48 85 c0             	test   rax,rax
 31c:	74 0d                	je     32b <ga_push_back+0x43>
 31e:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 322:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
 326:	48 01 c0             	add    rax,rax
 329:	eb 05                	jmp    330 <ga_push_back+0x48>
 32b:	b8 01 00 00 00       	mov    eax,0x1
 330:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
#         ga_resize(self, n_newsize); 
 334:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
 338:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 33c:	48 89 d6             	mov    rsi,rdx
 33f:	48 89 c7             	mov    rdi,rax
 342:	e8 00 00 00 00       	call   347 <ga_push_back+0x5f>
#     }
#     // Actual index in terms of accessing contiguous elements in raw bytes.
#     size_t n_index = self->m_ncount * self->m_nsizeof;
 347:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 34b:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
 34f:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 353:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
 357:	48 0f af c2          	imul   rax,rdx
 35b:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
#     self->methods.assign(self, &self->m_pbuffer[n_index], p_item);
 35f:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 363:	48 8b 48 30          	mov    rcx,QWORD PTR [rax+0x30]
 367:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 36b:	48 8b 10             	mov    rdx,QWORD PTR [rax]
 36e:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 372:	48 8d 34 02          	lea    rsi,[rdx+rax*1]
 376:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
 37a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 37e:	48 89 c7             	mov    rdi,rax
 381:	ff d1                	call   rcx
#     self->m_ncount++;
 383:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 387:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
 38b:	48 8d 50 01          	lea    rdx,[rax+0x1]
 38f:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 393:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
# }
 397:	90                   	nop
 398:	c9                   	leave
 399:	c3                   	ret
