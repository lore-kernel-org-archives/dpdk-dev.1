Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F958606A321
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 11:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0D0mQtqg
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8689F4060C;
	Mon,  9 Nov 2026 12:30:37 +0100 (CET)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53])
 by mails.dpdk.org (Postfix) with ESMTPS id C18134026E
 for <dev@dpdk.org>; Mon,  9 Nov 2026 12:30:35 +0100 (CET)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-c4d30639709so84505566b.0
 for <dev@dpdk.org>; Mon, 09 Nov 2026 03:30:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794223835; cv=none;
 d=google.com; s=arc-20260327;
 b=o2GkYOMJzCTLtjQVLg/Kbm9TsILpD+ICAO+6FRLYYS/Gnn9K6PU1cjMlf/4SjKwoCv
 L2wAd8F0dUuhy4U7ZsoGLTeslPhx/yVbl/9nEvqJOzLgru8h6/W6bf2kDaWbZBSf9xzD
 ji46q+BJd58NZNa6tE2077StcMzQlgZr2lxe6vSeAXFXViQYdqS3scHiL+qPt7JKn4Zt
 WUDgwy+abj9HW9HJk7jmsGGbg/5PCb9kjjlUzNGwgEMxo4nqUICf3RXahl3idv2Fu9dq
 ryor4akYzQFIjOwgTuJxqHoy3aYs/VVKHytlj5EOxt7GAd7SKTCLhQPdNyGJmJaD/abD
 iNVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xDnxbq0H4C2WD6JU4Lc8zRHgRM3KpHJ58zapSZMXr8g=;
 fh=bGVAofP4FC01qK+u5OEyDpNTDnC4HExYtYWQOQStGkg=;
 b=nPhChbfehe2zk49qX/+vEX1erfofxIxYk886XrXLZ0M7e7jQttvUEUy//V0yyFQaPX
 DTVdBiuTFG0SKiMPjHeTQgqo919vk56iWl6TnaPldV9voBVNQC8vNLE2saEYvmWh3POj
 sQWoETeS0TQkyqjo7PsSMYeB9wwGblsIa7X9FHbgFdaJVK0Um04b7lAayQ6XmkBUNEP9
 aFrVdUCS7fBByi6796ftJ6kCmVf0vJ+zbskKtY4hDXa3m2sZqKCjnSUS3lHCfgxuHvl9
 2TUXOehCdYlyx2e8RxEKzjagj8829h8QsUvQvElNfUjY14PVbSFCacU1RySrBf5gpvIF
 bPzw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794223835; x=1794828635; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xDnxbq0H4C2WD6JU4Lc8zRHgRM3KpHJ58zapSZMXr8g=;
 b=0D0mQtqgIxgzp75Prn3l4CiYdP6Ci6ttTBhiIrN6xt3zNeDFrZZ05M909y2dPr73lP
 83Vj1e3DzRL8pChO5wUhYYTN6YFbUqI7sbP9yNpQ8K+iuIiYlNVgRHA1Xb6Q6tqcS09s
 F1ztTnEtvgMALOlIIIOuPsOHe4P5szra5lCmqXD+f5Mj2x/+5bO+0WIPnQ46CJkf3Rpo
 nCmSYMBOdyMD8oD7gkWAiR9HIpO4mNT6UqzSiSlwoNWD9Uudr1U/xqts8y1mIHelmJ6R
 f/XrzbUMmhV5dTr4ZEdsO4Dq8nMOg2f2fevrJUjaYwt7SJ+5AoX4j9DpXlSQ96zR7fqF
 7rHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794223835; x=1794828635;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xDnxbq0H4C2WD6JU4Lc8zRHgRM3KpHJ58zapSZMXr8g=;
 b=TXcfrxUBIRZYNq02kgF3nOG3eznUUwdRn2rtgO0vDM1MEO2QIQzSm1kkaq9c+IszA7
 9x1fRGpK76SoQjO3+N8sjfxs7HeO+XsRDz3WK2xmVP6DehaqDNwP3KAE3iYtt9C1bXxU
 MhTTvgwhXPULbhTN8Dnj3sPn3shKxNz3faxgXM0/FSuXDsUPD0zhjxlPHT+IksTJlx17
 U2EYNohsspsW3JMiuYdDdNq3ry4WjlY1sAdBfAacNj2jjOgQuzEkCTi39fIv1MyiXDFF
 nI7gLR51dAw4dhAWfpW5UTzzhwW8VU5selhec/Mp5Vp795B6klPClJ0SVvAfsjVHAfO0
 Vgig==
X-Forwarded-Encrypted: i=1;
 AL+hErEcT+Q6viB//gdxge4rQc5DBZlmSEYG02rQO5lBMB8kJvsQH5CUm7gkfU8MZ6Vogtjdovw=@dpdk.org
X-Gm-Message-State: APuU4Z+HvozJIYEUvAji1EIsAWeGTZ/EOw5LCIFxQWHOrmSp6oU2zqBm
 p0X5bRfO+JUde6v39ADbojiEVgiMw2U4T2a2E8B8zJu/Gtk0Ttq88q3J19wcvVp99CGqhF7SUNB
 /vb2LThAAVWTjCJgQXOS5HytNm7p8DMA=
X-Gm-Gg: AYBFou2UqRBZ1QJRiND8dTceZ3zkVA/9noyojCKyehWXCRZo0emlmDINMRHux1L5STh
 GU9hfYiLYxfi/i8H9kH8PnMUokWgSkPPyf4HcqTOY2eqt/WwQXWA2OBchl0WWVf3pKBGnDnlwNA
 O5VrPlKA7ok5huo2LDcsksPLghWAD+Qkpvwm6IkvkPprb2rEKHiuT5XiVUbvW8XNn0/dajbdueT
 nJ8mNvG92dZ0coOgdRTC/oejz2JvgQy6DvBvkPn7GOhBejesE2M8pOgwbzV7zA63QngEklh4uXY
 IimNM+oS7w+Ni44cb0+z+dDhKrQRgshQwy+GJDgly2eTtgY3PI2RYlnzOCVi2fOCUMjZvvuvyAq
 9vHbMtUhHRKZWb/+FPwjtrKcy4UMCI67FJIE=
X-Received: by 2002:a17:906:d54b:b0:c26:1649:47ad with SMTP id
 a640c23a62f3a-c4d6db77906mr237607766b.35.1794223835090; Mon, 09 Nov 2026
 03:30:35 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261108120358.1408920-1-16567adigashreesh@gmail.com>
 <663fa8ff-4bd2-4782-be7e-c03311ca639d@yandex.ru>
In-Reply-To: <663fa8ff-4bd2-4782-be7e-c03311ca639d@yandex.ru>
From: Shreesh Adiga <16567adigashreesh@gmail.com>
Date: Mon, 9 Nov 2026 17:00:22 +0530
X-Gm-Features: AclHuK-DgS-rfcDEVGwpQkXcYVT1olY7mA7OnwzyrO_rb84zsSzpuIoboQ_g9Ro
Message-ID: <CA+-x59bP6e7vwd9tVcVoha9yCbrqLKFN6nd9KDFFh8V9ixQ99A@mail.gmail.com>
Subject: Re: [PATCH] net/crc: use static constants for SSE42 PCLMULQDQ
 parameters
To: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
Cc: Bruce Richardson <bruce.richardson@intel.com>, 
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Jasvinder Singh <jasvinder.singh@intel.com>, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000569a03065fd64adc"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_STARTS_WITH_NUMS,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000569a03065fd64adc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 3:40=E2=80=AFPM Konstantin Ananyev <
konstantin.v.ananyev@yandex.ru> wrote:

>
> > Replace the __m128i members in the PCLMULQDQ CRC context with aligned
> > uint64_t arrays to allow portable compile-time initialization.
> >
> > Move CRC16-CCITT and CRC32-ETH folding constants into static const
> context
> > structures in their respective handlers, removing the runtime
> > initialization previously performed by rte_net_crc_sse42_init and avoid=
s
> > the extra data segment static variables which were being populated.
> >
> > Load the constants into SIMD registers using aligned loads when
> performing
> > CRC calculations. This was done transparently previously when the
> > __m128i values were assigned, now there is explicit SIMD load done.
>
> It is not clear why(how) new code is better then what we have right now.
> Can you probably provide a bit more details?
>
>
Previously this file was maintaining static variables in data segment
namely:
static alignas(16) struct crc_pclmulqdq_ctx crc32_eth_pclmulqdq;
static alignas(16) struct crc_pclmulqdq_ctx crc16_ccitt_pclmulqdq;

These were populated in the init function with the same calculated fold
constants.
The constants already are present in the rodata section in the binary.
Hence the init is doing extra work in copying it over to the
static crc_pclmulqdq_ctx
structures which is redundant.

This patch avoids this extra copy during init and modifies the SIMD routine=
s
to directly read the constants from rodata memory. Thus the data segment
memory usage is
reduced by getting rid of the static variables (128 bytes). There should be
no
performance impact by this change (minus the init work done previously).



> >
> > Signed-off-by: Shreesh Adiga <16567adigashreesh@gmail.com>
> > ---
> >   lib/net/net_crc_sse.c | 68 ++++++++++++++----------------------------=
-
> >   1 file changed, 22 insertions(+), 46 deletions(-)
> >
> > diff --git a/lib/net/net_crc_sse.c b/lib/net/net_crc_sse.c
> > index e30f8544fc..4361e35e39 100644
> > --- a/lib/net/net_crc_sse.c
> > +++ b/lib/net/net_crc_sse.c
> > @@ -12,15 +12,13 @@
> >   #include "net_crc.h"
> >
> >   /** PCLMULQDQ CRC computation context structure */
> > -struct crc_pclmulqdq_ctx {
> > -     __m128i rk1_rk2;
> > -     __m128i rk3_rk4;
> > -     __m128i rk5_rk6;
> > -     __m128i rk7_rk8;
> > +struct __rte_aligned(XMM_SIZE) crc_pclmulqdq_ctx {
> > +     uint64_t rk1_rk2[2];
> > +     uint64_t rk3_rk4[2];
> > +     uint64_t rk5_rk6[2];
> > +     uint64_t rk7_rk8[2];
> >   };
> >
> > -static alignas(16) struct crc_pclmulqdq_ctx crc32_eth_pclmulqdq;
> > -static alignas(16) struct crc_pclmulqdq_ctx crc16_ccitt_pclmulqdq;
> >   /**
> >    * @brief Performs one folding round
> >    *
> > @@ -162,7 +160,7 @@ crc32_eth_calc_pclmulqdq(
> >               fold3 =3D _mm_loadu_si128((const __m128i *)(data + 32));
> >               fold4 =3D _mm_loadu_si128((const __m128i *)(data + 48));
> >               fold1 =3D _mm_xor_si128(fold1, temp);
> > -             k =3D params->rk1_rk2;
> > +             k =3D _mm_load_si128((const __m128i *)params->rk1_rk2);
> >
> >               for (n =3D 64; (n + 64) <=3D data_len; n +=3D 64) {
> >                       temp1 =3D _mm_loadu_si128((const __m128i *)&data[=
n]);
> > @@ -175,7 +173,7 @@ crc32_eth_calc_pclmulqdq(
> >                       fold4 =3D crcr32_folding_round(temp4, k, fold4);
> >               }
> >
> > -             k =3D params->rk3_rk4;
> > +             k =3D _mm_load_si128((const __m128i *)params->rk3_rk4);
> >               fold1 =3D crcr32_folding_round(fold2, k, fold1);
> >               fold1 =3D crcr32_folding_round(fold3, k, fold1);
> >               fold =3D crcr32_folding_round(fold4, k, fold1);
> > @@ -205,7 +203,7 @@ crc32_eth_calc_pclmulqdq(
> >       fold =3D _mm_xor_si128(fold, temp);
> >
> >       /** Single folding loop - the last 16 bytes is processed
> separately */
> > -     k =3D params->rk3_rk4;
> > +     k =3D _mm_load_si128((const __m128i *)params->rk3_rk4);
> >       n =3D 16;
> >
> >   single_fold_loop:
> > @@ -235,11 +233,11 @@ crc32_eth_calc_pclmulqdq(
> >
> >       /** Reduction 128 -> 32 Assumes: fold holds 128bit folded data */
> >   reduction_128_64:
> > -     k =3D params->rk5_rk6;
> > +     k =3D _mm_load_si128((const __m128i *)params->rk5_rk6);
> >       fold =3D crcr32_reduce_128_to_64(fold, k);
> >
> >   barret_reduction:
> > -     k =3D params->rk7_rk8;
> > +     k =3D _mm_load_si128((const __m128i *)params->rk7_rk8);
> >       n =3D crcr32_reduce_64_to_32(fold, k);
> >
> >       return n;
> > @@ -248,45 +246,17 @@ crc32_eth_calc_pclmulqdq(
> >   void
> >   rte_net_crc_sse42_init(void)
> >   {
> > -     uint64_t k1, k2, k3, k4, k5, k6;
> > -     uint64_t p =3D 0, q =3D 0;
> > -
> > -     /** Initialize CRC16 data */
> > -     k1 =3D 0x14ff2LLU;
> > -     k2 =3D 0x19a3cLLU;
> > -     k3 =3D 0x189aeLLU;
> > -     k4 =3D 0x8e10LLU;
> > -     k5 =3D 0x189aeLLU;
> > -     k6 =3D 0x114aaLLU;
> > -     q =3D  0x11c581910LLU;
> > -     p =3D  0x10811LLU;
> > -
> > -     /** Save the params in context structure */
> > -     crc16_ccitt_pclmulqdq.rk1_rk2 =3D _mm_set_epi64x(k2, k1);
> > -     crc16_ccitt_pclmulqdq.rk3_rk4 =3D _mm_set_epi64x(k4, k3);
> > -     crc16_ccitt_pclmulqdq.rk5_rk6 =3D _mm_set_epi64x(k6, k5);
> > -     crc16_ccitt_pclmulqdq.rk7_rk8 =3D _mm_set_epi64x(p, q);
> > -
> > -     /** Initialize CRC32 data */
> > -     k1 =3D 0x1c6e41596LLU;
> > -     k2 =3D 0x154442bd4LLU;
> > -     k3 =3D 0xccaa009eLLU;
> > -     k4 =3D 0x1751997d0LLU;
> > -     k5 =3D 0xccaa009eLLU;
> > -     k6 =3D 0x163cd6124LLU;
> > -     q =3D  0x1f7011640LLU;
> > -     p =3D  0x1db710641LLU;
> > -
> > -     /** Save the params in context structure */
> > -     crc32_eth_pclmulqdq.rk1_rk2 =3D _mm_set_epi64x(k2, k1);
> > -     crc32_eth_pclmulqdq.rk3_rk4 =3D _mm_set_epi64x(k4, k3);
> > -     crc32_eth_pclmulqdq.rk5_rk6 =3D _mm_set_epi64x(k6, k5);
> > -     crc32_eth_pclmulqdq.rk7_rk8 =3D _mm_set_epi64x(p, q);
> >   }
> >
> >   uint32_t
> >   rte_crc16_ccitt_sse42_handler(const uint8_t *data, uint32_t data_len)
> >   {
> > +     static const struct crc_pclmulqdq_ctx crc16_ccitt_pclmulqdq =3D {
> > +             .rk1_rk2 =3D { 0x14ff2LLU, 0x19a3cLLU },
> > +             .rk3_rk4 =3D { 0x189aeLLU, 0x8e10LLU },
> > +             .rk5_rk6 =3D { 0x189aeLLU, 0x114aaLLU },
> > +             .rk7_rk8 =3D { 0x11c581910LLU, 0x10811LLU },
> > +     };
> >       /** return 16-bit CRC value */
> >       return (uint16_t)~crc32_eth_calc_pclmulqdq(data,
> >               data_len,
> > @@ -297,6 +267,12 @@ rte_crc16_ccitt_sse42_handler(const uint8_t *data,
> uint32_t data_len)
> >   uint32_t
> >   rte_crc32_eth_sse42_handler(const uint8_t *data, uint32_t data_len)
> >   {
> > +     static const struct crc_pclmulqdq_ctx crc32_eth_pclmulqdq =3D {
> > +             .rk1_rk2 =3D { 0x1c6e41596LLU, 0x154442bd4LLU },
> > +             .rk3_rk4 =3D { 0xccaa009eLLU, 0x1751997d0LLU },
> > +             .rk5_rk6 =3D { 0xccaa009eLLU, 0x163cd6124LLU },
> > +             .rk7_rk8 =3D { 0x1f7011640LLU, 0x1db710641LLU },
> > +     };
> >       return ~crc32_eth_calc_pclmulqdq(data,
> >               data_len,
> >               0xffffffffUL,
>
>

--000000000000569a03065fd64adc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Nov 9, 2026 =
at 3:40=E2=80=AFPM Konstantin Ananyev &lt;<a href=3D"mailto:konstantin.v.an=
anyev@yandex.ru" target=3D"_blank">konstantin.v.ananyev@yandex.ru</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
&gt; Replace the __m128i members in the PCLMULQDQ CRC context with aligned<=
br>
&gt; uint64_t arrays to allow portable compile-time initialization.<br>
&gt;<br>
&gt; Move CRC16-CCITT and CRC32-ETH folding constants into static const con=
text<br>
&gt; structures in their respective handlers, removing the runtime<br>
&gt; initialization previously performed by rte_net_crc_sse42_init and avoi=
ds<br>
&gt; the extra data segment static variables which were being populated.<br=
>
&gt;<br>
&gt; Load the constants into SIMD registers using aligned loads when perfor=
ming<br>
&gt; CRC calculations. This was done transparently previously when the<br>
&gt; __m128i values were assigned, now there is explicit SIMD load done.<br=
>
<br>
It is not clear why(how) new code is better then what we have right now.<br=
>
Can you probably provide a bit more details?<br>
<br></blockquote><div><br></div><div>Previously this file was maintaining s=
tatic variables in data segment namely:</div><div>static alignas(16) struct=
 crc_pclmulqdq_ctx crc32_eth_pclmulqdq;</div><div>static alignas(16) struct=
 crc_pclmulqdq_ctx crc16_ccitt_pclmulqdq;</div><div><br></div><div>These we=
re populated in the init function with the same calculated fold constants.<=
/div><div>The constants already are present in the rodata section in the bi=
nary.</div><div>Hence the init is doing extra work in copying it over to th=
e static=C2=A0crc_pclmulqdq_ctx</div><div>structures which is=C2=A0redundan=
t.</div><div><br></div><div>This patch avoids this extra copy during init a=
nd modifies the SIMD routines</div><div>to directly read the constants from=
 rodata memory. Thus the data segment memory usage is=C2=A0</div><div>reduc=
ed by getting rid of the static variables (128 bytes). There should be no</=
div><div>performance impact by this change (minus the init work done previo=
usly).</div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
&gt;<br>
&gt; Signed-off-by: Shreesh Adiga &lt;<a href=3D"mailto:16567adigashreesh@g=
mail.com" target=3D"_blank">16567adigashreesh@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0lib/net/net_crc_sse.c | 68 ++++++++++++++-----------------=
------------<br>
&gt;=C2=A0 =C2=A01 file changed, 22 insertions(+), 46 deletions(-)<br>
&gt;<br>
&gt; diff --git a/lib/net/net_crc_sse.c b/lib/net/net_crc_sse.c<br>
&gt; index e30f8544fc..4361e35e39 100644<br>
&gt; --- a/lib/net/net_crc_sse.c<br>
&gt; +++ b/lib/net/net_crc_sse.c<br>
&gt; @@ -12,15 +12,13 @@<br>
&gt;=C2=A0 =C2=A0#include &quot;net_crc.h&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0/** PCLMULQDQ CRC computation context structure */<br>
&gt; -struct crc_pclmulqdq_ctx {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0__m128i rk1_rk2;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0__m128i rk3_rk4;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0__m128i rk5_rk6;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0__m128i rk7_rk8;<br>
&gt; +struct __rte_aligned(XMM_SIZE) crc_pclmulqdq_ctx {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0uint64_t rk1_rk2[2];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0uint64_t rk3_rk4[2];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0uint64_t rk5_rk6[2];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0uint64_t rk7_rk8[2];<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -static alignas(16) struct crc_pclmulqdq_ctx crc32_eth_pclmulqdq;<br>
&gt; -static alignas(16) struct crc_pclmulqdq_ctx crc16_ccitt_pclmulqdq;<br=
>
&gt;=C2=A0 =C2=A0/**<br>
&gt;=C2=A0 =C2=A0 * @brief Performs one folding round<br>
&gt;=C2=A0 =C2=A0 *<br>
&gt; @@ -162,7 +160,7 @@ crc32_eth_calc_pclmulqdq(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fold3 =3D _mm_lo=
adu_si128((const __m128i *)(data + 32));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fold4 =3D _mm_lo=
adu_si128((const __m128i *)(data + 48));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fold1 =3D _mm_xo=
r_si128(fold1, temp);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0k =3D params-&gt;rk1_=
rk2;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0k =3D _mm_load_si128(=
(const __m128i *)params-&gt;rk1_rk2);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (n =3D 64; (=
n + 64) &lt;=3D data_len; n +=3D 64) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0temp1 =3D _mm_loadu_si128((const __m128i *)&amp;data[n]);<br>
&gt; @@ -175,7 +173,7 @@ crc32_eth_calc_pclmulqdq(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0fold4 =3D crcr32_folding_round(temp4, k, fold4);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0k =3D params-&gt;rk3_=
rk4;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0k =3D _mm_load_si128(=
(const __m128i *)params-&gt;rk3_rk4);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fold1 =3D crcr32=
_folding_round(fold2, k, fold1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fold1 =3D crcr32=
_folding_round(fold3, k, fold1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fold =3D crcr32_=
folding_round(fold4, k, fold1);<br>
&gt; @@ -205,7 +203,7 @@ crc32_eth_calc_pclmulqdq(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0fold =3D _mm_xor_si128(fold, temp);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/** Single folding loop - the last 16 bytes =
is processed separately */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0k =3D params-&gt;rk3_rk4;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0k =3D _mm_load_si128((const __m128i *)params-&gt;=
rk3_rk4);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0n =3D 16;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0single_fold_loop:<br>
&gt; @@ -235,11 +233,11 @@ crc32_eth_calc_pclmulqdq(<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/** Reduction 128 -&gt; 32 Assumes: fold hol=
ds 128bit folded data */<br>
&gt;=C2=A0 =C2=A0reduction_128_64:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0k =3D params-&gt;rk5_rk6;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0k =3D _mm_load_si128((const __m128i *)params-&gt;=
rk5_rk6);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0fold =3D crcr32_reduce_128_to_64(fold, k);<b=
r>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0barret_reduction:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0k =3D params-&gt;rk7_rk8;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0k =3D _mm_load_si128((const __m128i *)params-&gt;=
rk7_rk8);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0n =3D crcr32_reduce_64_to_32(fold, k);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return n;<br>
&gt; @@ -248,45 +246,17 @@ crc32_eth_calc_pclmulqdq(<br>
&gt;=C2=A0 =C2=A0void<br>
&gt;=C2=A0 =C2=A0rte_net_crc_sse42_init(void)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; -=C2=A0 =C2=A0 =C2=A0uint64_t k1, k2, k3, k4, k5, k6;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0uint64_t p =3D 0, q =3D 0;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0/** Initialize CRC16 data */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0k1 =3D 0x14ff2LLU;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0k2 =3D 0x19a3cLLU;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0k3 =3D 0x189aeLLU;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0k4 =3D 0x8e10LLU;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0k5 =3D 0x189aeLLU;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0k6 =3D 0x114aaLLU;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0q =3D=C2=A0 0x11c581910LLU;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0p =3D=C2=A0 0x10811LLU;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0/** Save the params in context structure */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0crc16_ccitt_pclmulqdq.rk1_rk2 =3D _mm_set_epi64x(=
k2, k1);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0crc16_ccitt_pclmulqdq.rk3_rk4 =3D _mm_set_epi64x(=
k4, k3);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0crc16_ccitt_pclmulqdq.rk5_rk6 =3D _mm_set_epi64x(=
k6, k5);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0crc16_ccitt_pclmulqdq.rk7_rk8 =3D _mm_set_epi64x(=
p, q);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0/** Initialize CRC32 data */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0k1 =3D 0x1c6e41596LLU;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0k2 =3D 0x154442bd4LLU;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0k3 =3D 0xccaa009eLLU;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0k4 =3D 0x1751997d0LLU;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0k5 =3D 0xccaa009eLLU;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0k6 =3D 0x163cd6124LLU;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0q =3D=C2=A0 0x1f7011640LLU;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0p =3D=C2=A0 0x1db710641LLU;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0/** Save the params in context structure */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0crc32_eth_pclmulqdq.rk1_rk2 =3D _mm_set_epi64x(k2=
, k1);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0crc32_eth_pclmulqdq.rk3_rk4 =3D _mm_set_epi64x(k4=
, k3);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0crc32_eth_pclmulqdq.rk5_rk6 =3D _mm_set_epi64x(k6=
, k5);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0crc32_eth_pclmulqdq.rk7_rk8 =3D _mm_set_epi64x(p,=
 q);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0uint32_t<br>
&gt;=C2=A0 =C2=A0rte_crc16_ccitt_sse42_handler(const uint8_t *data, uint32_=
t data_len)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0static const struct crc_pclmulqdq_ctx crc16_ccitt=
_pclmulqdq =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.rk1_rk2 =3D { 0x14ff=
2LLU, 0x19a3cLLU },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.rk3_rk4 =3D { 0x189a=
eLLU, 0x8e10LLU },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.rk5_rk6 =3D { 0x189a=
eLLU, 0x114aaLLU },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.rk7_rk8 =3D { 0x11c5=
81910LLU, 0x10811LLU },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/** return 16-bit CRC value */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return (uint16_t)~crc32_eth_calc_pclmulqdq(d=
ata,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data_len,<br>
&gt; @@ -297,6 +267,12 @@ rte_crc16_ccitt_sse42_handler(const uint8_t *data=
, uint32_t data_len)<br>
&gt;=C2=A0 =C2=A0uint32_t<br>
&gt;=C2=A0 =C2=A0rte_crc32_eth_sse42_handler(const uint8_t *data, uint32_t =
data_len)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0static const struct crc_pclmulqdq_ctx crc32_eth_p=
clmulqdq =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.rk1_rk2 =3D { 0x1c6e=
41596LLU, 0x154442bd4LLU },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.rk3_rk4 =3D { 0xccaa=
009eLLU, 0x1751997d0LLU },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.rk5_rk6 =3D { 0xccaa=
009eLLU, 0x163cd6124LLU },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.rk7_rk8 =3D { 0x1f70=
11640LLU, 0x1db710641LLU },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return ~crc32_eth_calc_pclmulqdq(data,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data_len,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00xffffffffUL,<br=
>
<br>
</blockquote></div></div>
</div>

--000000000000569a03065fd64adc--
