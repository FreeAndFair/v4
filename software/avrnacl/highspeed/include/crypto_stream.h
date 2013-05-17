/*
 * File:   avrnacl-20130415/highspeed/include/crypto_stream.h
 * Author: Michael Hutter, Peter Schwabe
 * Public Domain
 */

#ifndef CRYPTO_STREAM_H
#define CRYPTO_STREAM_H

#include "crypto_uint16.h"

int crypto_stream( unsigned char *c,crypto_uint16 clen, const unsigned char *n, const unsigned char *k);

int crypto_stream_xor(unsigned char *c, const unsigned char *m,crypto_uint16 mlen, const unsigned char *n, const unsigned char *k);

#endif
