/*
 * File:   avrnacl-20130415/smallrom/include/crypto_hash_sha512.h
 * Author: Michael Hutter, Peter Schwabe
 * Public Domain
 */

#ifndef HASH_H
#define HASH_H

#include "crypto_uint16.h"

#define crypto_hash_sha512_BYTES 64

int crypto_hashblocks_sha512(unsigned char *statebytes,const unsigned char *in,crypto_uint16 inlen);

int crypto_hash_sha512(unsigned char *out,const unsigned char *in,crypto_uint16 inlen);

#endif
