/*
 * File:   avrnacl-20130415/smallrom/include/crypto_onetimeauth.h
 * Author: Michael Hutter, Peter Schwabe
 * Public Domain
 */

#ifndef CRYPTO_ONETIMEAUTH_H
#define CRYPTO_ONETIMEAUTH_H

#define crypto_onetimeauth_BYTES 16
#define crypto_onetimeauth_KEYBYTES 32

#include "crypto_uint16.h"

int crypto_onetimeauth(unsigned char *out,const unsigned char *in,crypto_uint16 inlen,const unsigned char *k);

#endif
