Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C388C369DC
	for <dpdk-dev@archiver.kernel.org>; Sun,  4 May 2025 21:21:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A8114025D;
	Sun,  4 May 2025 23:21:54 +0200 (CEST)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id E0BCD40156
 for <dev@dpdk.org>; Sun,  4 May 2025 23:21:52 +0200 (CEST)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-224341bbc1dso47101215ad.3
 for <dev@dpdk.org>; Sun, 04 May 2025 14:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1746393712; x=1746998512; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uLAmwolTKcCViBMnhqZCmDGhE0HizVQumKqTmq2Ygao=;
 b=Wr58VAEGUdvUO6bV3uZNzOlTea3lYYBqsKedDHn6d1C/ive3epSB/1CbjDps+VJ2LK
 sEODGZEc4Ue7fzO4pvGwVScAERYmA9onUAcyefCCiB1uSyoGM9KmUxPBpxlTU0QG2+0G
 t5mHdCxxfeXUTnG7qnPpvuHPY2JZVkSM16Ylc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746393712; x=1746998512;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uLAmwolTKcCViBMnhqZCmDGhE0HizVQumKqTmq2Ygao=;
 b=lR9ITG/nqJEAbc8TCejGsxV9SCl9JOr1y6x04ofgjV1l0kCM8ALC20V8IPy/AGHT7R
 MDRqA9muCGwZcUYBoaft0SikyauNcd+QpK4Oj2AoxfKS+aILRxswgc/0Ghg+uau5g7r+
 uau6OqemGTdCUxWRGu0XcewgLvV5Fv7VTCwJ223/oXwpgQAHq/xc5wIWH48ufBerTDfF
 tRbybcG6N8jz2ZSHEvSxPEsz8+HdUpV375xi1ZjfVdoPMhBelpGhfnMxViS8F+FmjNHH
 x8V5eIU1t7fHQEcfssKy1ifivLkJLTib3GjLeCqEws/TdmRODdU8PdrEHakQ3X7FlR09
 jmwQ==
X-Gm-Message-State: AOJu0Yz+gevsvMzr4q08xy20luY7gxTkvNwCI0QFm65YmBcTMA275Z2c
 yMj3JLKorz53zr+SaaT3i7qPzdva5Cawscm7y+A8ZQJltWog16gMHCOe2/WK480khK6NpU5KH8e
 qiBzaY2Nqqck7+/KN+LtCX0PHmQQCN8LORT690w==
X-Gm-Gg: ASbGncsX7LLLpztccCtSXLvOA1HoJ4YZSM0ARJoK+J9pk+S//+WVYGyUKCRUARlt0gp
 bAE5jBAeomg/VnDBc4PgbYz6QrRKyoCEty8SaJZNBbJzdvfy6e8pRimxylDA3srG169ACNbkl6r
 5Xejd4TQMlhHgVYuKaVV/iAEXMZFXfCMPpJuvMK1hm1UKNTQnISTPXkXQ=
X-Google-Smtp-Source: AGHT+IGOMmkkDGjGj/+eRdh3kuyzjT7/DmXXp8i48iQV4IHnRPer3zTGz/dx+QYjXhaee/t2GZVfScrMMoNtX1GAXKY=
X-Received: by 2002:a17:902:d2c7:b0:220:ff3f:6cc0 with SMTP id
 d9443c01a7336-22e18c377c5mr110564465ad.38.1746393711910; Sun, 04 May 2025
 14:21:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250502101226.1405274-1-kai.ji@intel.com>
In-Reply-To: <20250502101226.1405274-1-kai.ji@intel.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Sun, 4 May 2025 17:17:18 -0400
X-Gm-Features: ATxdqUG_MWC4QPAVFs7lx3fmIGKW6kXGpmi52FS2ODPU6TPwNQTPOPGvXGWgVSo
Message-ID: <CAJvnSUACcmKUhZZSa_AZkn0kGChb-wbbbpiqT9m2qPOCmqnLcg@mail.gmail.com>
Subject: Re: [dpdk-dev v1] app/test-crypto-perf: remove decrypt test case from
 perf
To: Kai Ji <kai.ji@intel.com>
Cc: dev@dpdk.org, gakhil@marvell.com
Content-Type: multipart/alternative; boundary="000000000000d63791063455f88c"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

--000000000000d63791063455f88c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please disregard the Community Lab DTS failure just reported on this
patchseries. I need to reconfigure the testbed and rerun the test.

On Fri, May 2, 2025 at 6:12=E2=80=AFAM Kai Ji <kai.ji@intel.com> wrote:

> Remove all decrypt test cases in aesni-mb throughput perf as the
> decrypt throughput testing only support OOP by dpdk-test-crypto-perf
>
> Signed-off-by: Kai Ji <kai.ji@intel.com>
> ---
>  .../configs/crypto-perf-aesni-mb.json         | 24 -------------------
>  1 file changed, 24 deletions(-)
>
> diff --git a/app/test-crypto-perf/configs/crypto-perf-aesni-mb.json
> b/app/test-crypto-perf/configs/crypto-perf-aesni-mb.json
> index d50e4af36c..91fbc9cfcd 100644
> --- a/app/test-crypto-perf/configs/crypto-perf-aesni-mb.json
> +++ b/app/test-crypto-perf/configs/crypto-perf-aesni-mb.json
> @@ -13,13 +13,6 @@
>                                 "devtype": "crypto_aesni_mb"
>                         }
>                 },
> -               "AES-CBC-128 SHA1-HMAC auth-then-cipher decrypt": {
> -                       "cipher-algo": "aes-cbc",
> -                       "cipher-key-sz": "16",
> -                       "auth-algo": "sha1-hmac",
> -                       "optype": "auth-then-cipher",
> -                       "cipher-op": "decrypt"
> -               },
>                 "AES-CBC-128 SHA1-HMAC cipher-then-auth encrypt": {
>                         "cipher-algo": "aes-cbc",
>                         "cipher-key-sz": "16",
> @@ -30,13 +23,6 @@
>                         "optype": "cipher-then-auth",
>                         "cipher-op": "encrypt"
>                 },
> -               "AES-CBC-256 SHA2-256-HMAC auth-then-cipher decrypt": {
> -                       "cipher-algo": "aes-cbc",
> -                       "cipher-key-sz": "32",
> -                       "auth-algo": "sha2-256-hmac",
> -                       "optype": "auth-then-cipher",
> -                       "cipher-op": "decrypt"
> -               },
>                 "AES-CBC-256 SHA2-256-HMAC cipher-then-auth encrypt": {
>                         "cipher-algo": "aes-cbc",
>                         "cipher-key-sz": "32",
> @@ -53,21 +39,11 @@
>                         "optype": "aead",
>                         "total-ops": "10000000"
>                 },
> -               "AES-GCM-128 aead-op decrypt": {
> -                       "aead-algo": "aes-gcm",
> -                       "aead-key-sz": "16",
> -                       "aead-op": "decrypt"
> -               },
>                 "AES-GCM-256 aead-op encrypt": {
>                         "aead-algo": "aes-gcm",
>                         "aead-key-sz": "32",
>                         "aead-op": "encrypt"
>                 },
> -               "AES-GCM-256 aead-op decrypt": {
> -                       "aead-algo": "aes-gcm",
> -                       "aead-key-sz": "32",
> -                       "aead-op": "decrypt"
> -               },
>                 "AES-GMAC 128 auth-only generate": {
>                         "auth-algo": "aes-gmac",
>                         "auth-key-sz": "16",
> --
> 2.34.1
>
>

--000000000000d63791063455f88c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+UGxlYXNlIGRpc3JlZ2FyZCB0aGUgQ29tbXVuaXR5IExhYiBEVFMgZmFp
bHVyZSBqdXN0wqByZXBvcnRlZCBvbiB0aGlzIHBhdGNoc2VyaWVzLiBJIG5lZWQgdG8gcmVjb25m
aWd1cmUgdGhlIHRlc3RiZWQgYW5kIHJlcnVuIHRoZSB0ZXN0LjwvZGl2Pjxicj48ZGl2IGNsYXNz
PSJnbWFpbF9xdW90ZSBnbWFpbF9xdW90ZV9jb250YWluZXIiPjxkaXYgZGlyPSJsdHIiIGNsYXNz
PSJnbWFpbF9hdHRyIj5PbiBGcmksIE1heSAyLCAyMDI1IGF0IDY6MTLigK9BTSBLYWkgSmkgJmx0
OzxhIGhyZWY9Im1haWx0bzprYWkuamlAaW50ZWwuY29tIj5rYWkuamlAaW50ZWwuY29tPC9hPiZn
dDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9
Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwy
MDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij5SZW1vdmUgYWxsIGRlY3J5cHQgdGVzdCBjYXNlcyBp
biBhZXNuaS1tYiB0aHJvdWdocHV0IHBlcmYgYXMgdGhlPGJyPg0KZGVjcnlwdCB0aHJvdWdocHV0
IHRlc3Rpbmcgb25seSBzdXBwb3J0IE9PUCBieSBkcGRrLXRlc3QtY3J5cHRvLXBlcmY8YnI+DQo8
YnI+DQpTaWduZWQtb2ZmLWJ5OiBLYWkgSmkgJmx0OzxhIGhyZWY9Im1haWx0bzprYWkuamlAaW50
ZWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+a2FpLmppQGludGVsLmNvbTwvYT4mZ3Q7PGJyPg0KLS0t
PGJyPg0KwqAuLi4vY29uZmlncy9jcnlwdG8tcGVyZi1hZXNuaS1tYi5qc29uwqAgwqAgwqAgwqAg
wqB8IDI0IC0tLS0tLS0tLS0tLS0tLS0tLS08YnI+DQrCoDEgZmlsZSBjaGFuZ2VkLCAyNCBkZWxl
dGlvbnMoLSk8YnI+DQo8YnI+DQpkaWZmIC0tZ2l0IGEvYXBwL3Rlc3QtY3J5cHRvLXBlcmYvY29u
Zmlncy9jcnlwdG8tcGVyZi1hZXNuaS1tYi5qc29uIGIvYXBwL3Rlc3QtY3J5cHRvLXBlcmYvY29u
Zmlncy9jcnlwdG8tcGVyZi1hZXNuaS1tYi5qc29uPGJyPg0KaW5kZXggZDUwZTRhZjM2Yy4uOTFm
YmM5Y2ZjZCAxMDA2NDQ8YnI+DQotLS0gYS9hcHAvdGVzdC1jcnlwdG8tcGVyZi9jb25maWdzL2Ny
eXB0by1wZXJmLWFlc25pLW1iLmpzb248YnI+DQorKysgYi9hcHAvdGVzdC1jcnlwdG8tcGVyZi9j
b25maWdzL2NyeXB0by1wZXJmLWFlc25pLW1iLmpzb248YnI+DQpAQCAtMTMsMTMgKzEzLDYgQEA8
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmcXVv
dDtkZXZ0eXBlJnF1b3Q7OiAmcXVvdDtjcnlwdG9fYWVzbmlfbWImcXVvdDs8YnI+DQrCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgfSw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmcXVvdDtBRVMtQ0JDLTEyOCBTSEEx
LUhNQUMgYXV0aC10aGVuLWNpcGhlciBkZWNyeXB0JnF1b3Q7OiB7PGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7Y2lwaGVyLWFsZ28mcXVvdDs6ICZxdW90O2Fl
cy1jYmMmcXVvdDssPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJnF1
b3Q7Y2lwaGVyLWtleS1zeiZxdW90OzogJnF1b3Q7MTYmcXVvdDssPGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7YXV0aC1hbGdvJnF1b3Q7OiAmcXVvdDtzaGEx
LWhtYWMmcXVvdDssPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJnF1
b3Q7b3B0eXBlJnF1b3Q7OiAmcXVvdDthdXRoLXRoZW4tY2lwaGVyJnF1b3Q7LDxicj4NCi3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZxdW90O2NpcGhlci1vcCZxdW90OzogJnF1
b3Q7ZGVjcnlwdCZxdW90Ozxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH0sPGJyPg0KwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgJnF1b3Q7QUVTLUNCQy0xMjggU0hBMS1ITUFDIGNpcGhlci10
aGVuLWF1dGggZW5jcnlwdCZxdW90Ozogezxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgICZxdW90O2NpcGhlci1hbGdvJnF1b3Q7OiAmcXVvdDthZXMtY2JjJnF1b3Q7LDxi
cj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZxdW90O2NpcGhlci1rZXkt
c3omcXVvdDs6ICZxdW90OzE2JnF1b3Q7LDxicj4NCkBAIC0zMCwxMyArMjMsNiBAQDxicj4NCsKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZxdW90O29wdHlwZSZxdW90OzogJnF1
b3Q7Y2lwaGVyLXRoZW4tYXV0aCZxdW90Oyw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCAmcXVvdDtjaXBoZXItb3AmcXVvdDs6ICZxdW90O2VuY3J5cHQmcXVvdDs8YnI+
DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCZxdW90O0FFUy1DQkMtMjU2IFNIQTItMjU2LUhNQUMgYXV0aC10aGVuLWNpcGhlciBkZWNyeXB0
JnF1b3Q7OiB7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7
Y2lwaGVyLWFsZ28mcXVvdDs6ICZxdW90O2Flcy1jYmMmcXVvdDssPGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7Y2lwaGVyLWtleS1zeiZxdW90OzogJnF1b3Q7
MzImcXVvdDssPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7
YXV0aC1hbGdvJnF1b3Q7OiAmcXVvdDtzaGEyLTI1Ni1obWFjJnF1b3Q7LDxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZxdW90O29wdHlwZSZxdW90OzogJnF1b3Q7YXV0
aC10aGVuLWNpcGhlciZxdW90Oyw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAmcXVvdDtjaXBoZXItb3AmcXVvdDs6ICZxdW90O2RlY3J5cHQmcXVvdDs8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqB9LDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZxdW90
O0FFUy1DQkMtMjU2IFNIQTItMjU2LUhNQUMgY2lwaGVyLXRoZW4tYXV0aCBlbmNyeXB0JnF1b3Q7
OiB7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJnF1b3Q7Y2lwaGVy
LWFsZ28mcXVvdDs6ICZxdW90O2Flcy1jYmMmcXVvdDssPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgJnF1b3Q7Y2lwaGVyLWtleS1zeiZxdW90OzogJnF1b3Q7MzImcXVv
dDssPGJyPg0KQEAgLTUzLDIxICszOSwxMSBAQDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgICZxdW90O29wdHlwZSZxdW90OzogJnF1b3Q7YWVhZCZxdW90Oyw8YnI+DQrC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmcXVvdDt0b3RhbC1vcHMmcXVvdDs6
ICZxdW90OzEwMDAwMDAwJnF1b3Q7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfSw8YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmcXVvdDtBRVMtR0NNLTEyOCBhZWFkLW9wIGRlY3J5
cHQmcXVvdDs6IHs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmcXVv
dDthZWFkLWFsZ28mcXVvdDs6ICZxdW90O2Flcy1nY20mcXVvdDssPGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7YWVhZC1rZXktc3omcXVvdDs6ICZxdW90OzE2
JnF1b3Q7LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZxdW90O2Fl
YWQtb3AmcXVvdDs6ICZxdW90O2RlY3J5cHQmcXVvdDs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqB9LDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZxdW90O0FFUy1HQ00tMjU2IGFl
YWQtb3AgZW5jcnlwdCZxdW90Ozogezxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgICZxdW90O2FlYWQtYWxnbyZxdW90OzogJnF1b3Q7YWVzLWdjbSZxdW90Oyw8YnI+DQrC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmcXVvdDthZWFkLWtleS1zeiZxdW90
OzogJnF1b3Q7MzImcXVvdDssPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgJnF1b3Q7YWVhZC1vcCZxdW90OzogJnF1b3Q7ZW5jcnlwdCZxdW90Ozxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIH0sPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7QUVT
LUdDTS0yNTYgYWVhZC1vcCBkZWNyeXB0JnF1b3Q7OiB7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7YWVhZC1hbGdvJnF1b3Q7OiAmcXVvdDthZXMtZ2NtJnF1
b3Q7LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZxdW90O2FlYWQt
a2V5LXN6JnF1b3Q7OiAmcXVvdDszMiZxdW90Oyw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAmcXVvdDthZWFkLW9wJnF1b3Q7OiAmcXVvdDtkZWNyeXB0JnF1b3Q7PGJy
Pg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfSw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCAmcXVvdDtBRVMtR01BQyAxMjggYXV0aC1vbmx5IGdlbmVyYXRlJnF1b3Q7OiB7PGJyPg0KwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJnF1b3Q7YXV0aC1hbGdvJnF1b3Q7OiAm
cXVvdDthZXMtZ21hYyZxdW90Oyw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCAmcXVvdDthdXRoLWtleS1zeiZxdW90OzogJnF1b3Q7MTYmcXVvdDssPGJyPg0KLS0gPGJy
Pg0KMi4zNC4xPGJyPg0KPGJyPg0KPC9ibG9ja3F1b3RlPjwvZGl2Pg0K
--000000000000d63791063455f88c--
