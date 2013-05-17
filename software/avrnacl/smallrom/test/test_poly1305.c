/*
 * File:   avrnacl-20130415/smallrom/test/test_poly1305.c
 * Author: Michael Hutter, Peter Schwabe
 * Public Domain
 */

#include "print.h"
#include "msgkey.h"
#include "crypto_verify_16.h"
#include "crypto_onetimeauth.h"

static const unsigned char mac[16] = {0x50, 0x78, 0x3e, 0xa4, 0x0d, 0x8b, 0x4f, 0x34, 0xd0, 0x8e, 0x13, 0x1c, 0x0b, 0x16, 0xbe, 0x56};

extern unsigned char msg[MLEN];
extern unsigned char key[crypto_onetimeauth_KEYBYTES];
static unsigned char out[crypto_onetimeauth_BYTES];

void test_poly1305()
{
  int r;
  crypto_onetimeauth(out,msg,MLEN,key);
  r = crypto_verify_16(out,mac);
  if(r)
    print("-1\r\n");
  else
    print("0\r\n");
}
