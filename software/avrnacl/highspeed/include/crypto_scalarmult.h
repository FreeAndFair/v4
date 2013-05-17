/*
 * File:   avrnacl-20130415/highspeed/include/crypto_scalarmult.h
 * Author: Michael Hutter, Peter Schwabe
 * Public Domain
 */

extern int crypto_scalarmult(unsigned char *,
                             const unsigned char *,
                             const unsigned char *);

extern int crypto_scalarmult_base(unsigned char *,
                                  const unsigned char *);
