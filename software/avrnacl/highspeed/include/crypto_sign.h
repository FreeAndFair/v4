/*
 * File:   avrnacl-20130415/highspeed/include/crypto_sign.h
 * Author: Michael Hutter, Peter Schwabe
 * Public Domain
 */

#ifndef CRYPTO_SIGN_H
#define CRYPTO_SIGN_H

#include "crypto_uint16.h"

int crypto_sign_keypair(
    unsigned char *pk,
    unsigned char *sk
    );

int crypto_sign(
    unsigned char *sm,crypto_uint16 *smlen,
    const unsigned char *m,crypto_uint16 mlen,
    const unsigned char *sk
    );

int crypto_sign_open(
    unsigned char *m,crypto_uint16 *mlen,
    const unsigned char *sm,crypto_uint16 smlen,
    const unsigned char *pk
    );

int crypto_sign_open_batch(
    unsigned char* const m[],crypto_uint16 mlen[],
    unsigned char* const sm[],const crypto_uint16 smlen[],
    unsigned char* const pk[], 
    crypto_uint16 batchsize
    );

#define crypto_sign_SECRETKEYBYTES 64
#define crypto_sign_PUBLICKEYBYTES 32
#define crypto_sign_BYTES 64

#endif
