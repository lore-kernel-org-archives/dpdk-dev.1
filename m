Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41784606A337
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 12:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XcqhF9Um
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A00040285;
	Tue, 10 Nov 2026 13:24:15 +0100 (CET)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by mails.dpdk.org (Postfix) with ESMTPS id D400B40281
 for <dev@dpdk.org>; Tue, 10 Nov 2026 13:24:13 +0100 (CET)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-6b633ddfad6so2560595a12.3
 for <dev@dpdk.org>; Tue, 10 Nov 2026 04:24:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794313453; cv=none;
 d=google.com; s=arc-20260327;
 b=A2l3svms49anjBuQXb85dDqX5uOLVtbjHPv0emO0ujQVw5wMqArZA2TLtZNoSoLd58
 A6At89OB11cGv5/nXt7fh5k49wfk2XczuwTHrTG6O3+tWtFbdDDsOKPlMKT97gevOD2X
 cGrQ8AUUTs3TBcfjDKBongbtm0HZ03qxY3uJMZG3lH9/8HGMKjcJHEm1JFRSsZ9gHLMk
 gMJNyJ6lpUbK/b3gCj/4IoLV68EtdTmtP/vm3ypCMPdQtZ4lBvcYcUsMhCyr6OsNb9BH
 6Xu1wSZ8QXWrCk95ofjqD8JSs99U2J6UACU/dY8ogzDY7bhYKJ5RyRYRbXLp0lCySgV2
 xjBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=N+19k/YQsCMFflDCaTC1GEHZ3gL7CxQkb/GeGCt+9Pk=;
 fh=Evaosve4p6w9yx2dcC/Z8jJLlUk4jJj3yibZiAuIxyk=;
 b=Nxov3zeDEiFaKsTE82+l088ZeW3ji6iYuJ452XuUr0ihjSaN04P+rHvWkIet4xP6ZK
 ORbFWZasz4o9BseadCiuH0fAPMZKuztjKL+EDbvHSab1AGxhv6D+JF7B0MiNO0jMrbP9
 2+PED+ZO+9XQ77L4RKulqAxnFtzr+y/Cu0JJtP1nxbhCcYkBXFgz62JrwDB/eJ4CC9Em
 OiOMm++w+4zDDIXoYTI3PJU0vd2YXv0yC+B2x3VOAebQlghwiSvxL7xge4K+/kSnj6wd
 4i7veAeot8f2eZ1PXxd5HJ9Jp7ChxeZ7L7HvJfn/yedZ8W8+/+Xq8J6At8qbz4Z9QTji
 cq6Q==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794313453; x=1794918253; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=N+19k/YQsCMFflDCaTC1GEHZ3gL7CxQkb/GeGCt+9Pk=;
 b=XcqhF9Umd9jaF7FcYjbFQWPikHRLESMal/hrtzY/4JhAAXqwKY7aZX8JCdKvkjql9c
 7znK5YGkaKMZLR5WV7wt6awjL5niswuIkGqZfADl7zPd03YIHSPk8RzA7L4KlWXQW2cY
 mNkrw/IdYUekCz3qRj9XLtLcTgiObwJDNYqmmehYE/NS6qevFx/HpOJGQpNFSY8oYadw
 oTamiv6XWGl/6q/NU98ci0E0pitaUJ/A4EcESi5HgqCVBhL0qV52Nm1P91hi+KM4/TGt
 zZbBUUXgqt85LpEEVdAYP3fNV5qt8qoxPChvjN1JUa0Stn/9uddI1icw7dyk9GOALylx
 qVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794313453; x=1794918253;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=N+19k/YQsCMFflDCaTC1GEHZ3gL7CxQkb/GeGCt+9Pk=;
 b=TPr9d/5N8153AINS0gqrAg8riUhra2LmO1MoCKaiVqfaIDTvHUiYoIsGpSRw2gJbal
 C3TOud5phh0MZQUHYWJbCBe4r5L855vISFu+0+QHLZPrGAtXYfafJBB/0npX5Srb7ct4
 gZ6kGMgqHZ5B+3xXrQQDH2TqlHPYCRf+nb6DRMpVmmSsbZFopOPsQHNhwS3ZDLjJbVCv
 ltQcqLCQGQxlKc5NrfRUQ2imhC9lgvs2S/gyr1LDrNFbkO16OvtJOERFWsLJIXm30fOU
 RyU7fnc/Lt0BaPU0bZYVELbRAOpTojoFGBqJB9Gt+aDVDYd/ivmoK6XI2CotM3uz9Fh6
 abOw==
X-Forwarded-Encrypted: i=1;
 AL+hErEI/oajhcUKUWICHO6iQ95MgRAK3DayYErw9DLSf+qbqiK1F1/WjHHZVepqo95CXiQTh4c=@dpdk.org
X-Gm-Message-State: APuU4Z/oftRBa43OQtEl88TSMqu0N71Xmn14CVIcT2I2Nvs2yXHJByi4
 aSyO+IwK1FbOj9O2Q4Rhu67zLGoBUM9ggzIC21G41NPN8rQ4XlKn0Uy638MpM3siIHHvG3HjgJh
 wUOGHi7UbhYzdo4QEntwTV/2OOfdzCeE=
X-Gm-Gg: AYBFou0wxo6I/Z0ZNjn5EqUEnHp/Kxu/gVKW/eQRtVKGRg7IVIU4BI44iLCS867pCBE
 yS+SkHiUszwIfQTEuYZUB0rx+q8sGBx6o/DYDdXxWdlncX3Vxn6d4fb6Egn/sLgoCd++jVpzBg1
 28rvEDxeWhif66Nlh1BkBou1ZjNwMrSAqRkK6wZwsmKYuKt/Mu2NM0v6yfvAIwOqIgAlKe9/087
 BishZdfFLbMhLqtnkQWCSAJZ3fp9wd12v96XGQ83IdvugqsPz3Zb2Ja0Y3lf9jnqIjNykPLDt7v
 OI3o18DEGpkXSN4sUpqR/hxuft1G6zzPoju8aCwn/JMP/vf3d287zBhVNVjqQV4EP8v0HCk+hQZ
 OOKB+ApttyT7YFjn7wjKkIaEDbrtSvjVr+ak=
X-Received: by 2002:a05:6402:4501:b0:6b4:9919:b54 with SMTP id
 4fb4d7f45d1cf-6b756afb94cmr2356005a12.42.1794313453064; Tue, 10 Nov 2026
 04:24:13 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261108120358.1408920-1-16567adigashreesh@gmail.com>
 <663fa8ff-4bd2-4782-be7e-c03311ca639d@yandex.ru>
 <CA+-x59bP6e7vwd9tVcVoha9yCbrqLKFN6nd9KDFFh8V9ixQ99A@mail.gmail.com>
 <d848d658-2acf-4b11-b356-3826bc261def@yandex.ru>
In-Reply-To: <d848d658-2acf-4b11-b356-3826bc261def@yandex.ru>
From: Shreesh Adiga <16567adigashreesh@gmail.com>
Date: Tue, 10 Nov 2026 17:54:01 +0530
X-Gm-Features: AclHuK_f9nQmhdQX7yBtXmqRc1eEiu16lL95o0TD72GCrd6gidmzWicYing6Wcs
Message-ID: <CA+-x59Z_uHou1fUKMGV7x+nLqM_10K9xkEWr40Q=HwtzTCfG5A@mail.gmail.com>
Subject: Re: [PATCH] net/crc: use static constants for SSE42 PCLMULQDQ
 parameters
To: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
Cc: Bruce Richardson <bruce.richardson@intel.com>, 
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Jasvinder Singh <jasvinder.singh@intel.com>, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000fc552e065feb2750"
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

--000000000000fc552e065feb2750
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 3:21=E2=80=AFPM Konstantin Ananyev <
konstantin.v.ananyev@yandex.ru> wrote:

>
>
>
> >
> >
> > On Mon, Nov 9, 2026 at 3:40=E2=80=AFPM Konstantin Ananyev
> > <konstantin.v.ananyev@yandex.ru> wrote:
> >
> >
> >     > Replace the __m128i members in the PCLMULQDQ CRC context with
> >     aligned
> >     > uint64_t arrays to allow portable compile-time initialization.
> >     >
> >     > Move CRC16-CCITT and CRC32-ETH folding constants into static
> >     const context
> >     > structures in their respective handlers, removing the runtime
> >     > initialization previously performed by rte_net_crc_sse42_init
> >     and avoids
> >     > the extra data segment static variables which were being populate=
d.
> >     >
> >     > Load the constants into SIMD registers using aligned loads when
> >     performing
> >     > CRC calculations. This was done transparently previously when the
> >     > __m128i values were assigned, now there is explicit SIMD load don=
e.
> >
> >     It is not clear why(how) new code is better then what we have
> >     right now.
> >     Can you probably provide a bit more details?
> >
> >
> > Previously this file was maintaining static variables in data segment
> > namely:
> > static alignas(16) struct crc_pclmulqdq_ctx crc32_eth_pclmulqdq;
> > static alignas(16) struct crc_pclmulqdq_ctx crc16_ccitt_pclmulqdq;
> >
> > These were populated in the init function with the same calculated
> > fold constants.
> > The constants already are present in the rodata section in the binary.
> > Hence the init is doing extra work in copying it over to the
> > static crc_pclmulqdq_ctx
> > structures which is redundant.
> >
> > This patch avoids this extra copy during init and modifies the SIMD
> > routines
> > to directly read the constants from rodata memory. Thus the data
> > segment memory usage is
> > reduced by getting rid of the static variables (128 bytes). There
> > should be no
> > performance impact by this change (minus the init work done previously)=
.
>
> TBH, it looks to me like a nitpicking: yes we move 128B from .data to
> .rodata, but in terms
> of functionality or perfomance - does it really matter?
>

It is not moving from .data to .rodata, same data was already there in
.rodata,
hence it is removal from .data.

Well this was mainly motivated from the rewrite for improving barrett
reduction.
I've combined this in the other patch and we can drop this patch from
review.
Kindly review the newer submission which includes this refactory change as
well:
https://patches.dpdk.org/project/dpdk/patch/20261110121048.831330-1-16567ad=
igashreesh@gmail.com/

Thanks,
Shreesh


> Though yes, the code looks a bit simpler and  nicer.
> If we decided to improve the init code, then my preference would be to
> use  rte_xmm_t?
> Then we can do something like that:
> struct crc_pclmulqdq_ctx {
>          rte_xmm_t rk1_rk2;
>         ...
> };
> ...
>   static const struct crc_pclmulqdq_ctx crc32_eth_pclmulqdq =3D {
>               .rk1_rk2 =3D { .u64 =3D {0x1c6e41596LLU, 0x154442bd4LLU }},
>               ...
> };
> ...
> __m128i k =3D params->rk3_rk4.x;
>
> >
> >     >
> >     > Signed-off-by: Shreesh Adiga <16567adigashreesh@gmail.com>
> >     > ---
> >     >   lib/net/net_crc_sse.c | 68
> >     ++++++++++++++-----------------------------
> >     >   1 file changed, 22 insertions(+), 46 deletions(-)
> >     >
> >     > diff --git a/lib/net/net_crc_sse.c b/lib/net/net_crc_sse.c
> >     > index e30f8544fc..4361e35e39 100644
> >     > --- a/lib/net/net_crc_sse.c
> >     > +++ b/lib/net/net_crc_sse.c
> >     > @@ -12,15 +12,13 @@
> >     >   #include "net_crc.h"
> >     >
> >     >   /** PCLMULQDQ CRC computation context structure */
> >     > -struct crc_pclmulqdq_ctx {
> >     > -     __m128i rk1_rk2;
> >     > -     __m128i rk3_rk4;
> >     > -     __m128i rk5_rk6;
> >     > -     __m128i rk7_rk8;
> >     > +struct __rte_aligned(XMM_SIZE) crc_pclmulqdq_ctx {
> >     > +     uint64_t rk1_rk2[2];
> >     > +     uint64_t rk3_rk4[2];
> >     > +     uint64_t rk5_rk6[2];
> >     > +     uint64_t rk7_rk8[2];
> >     >   };
> >     >
> >     > -static alignas(16) struct crc_pclmulqdq_ctx crc32_eth_pclmulqdq;
> >     > -static alignas(16) struct crc_pclmulqdq_ctx crc16_ccitt_pclmulqd=
q;
> >     >   /**
> >     >    * @brief Performs one folding round
> >     >    *
> >     > @@ -162,7 +160,7 @@ crc32_eth_calc_pclmulqdq(
> >     >               fold3 =3D _mm_loadu_si128((const __m128i *)(data +
> 32));
> >     >               fold4 =3D _mm_loadu_si128((const __m128i *)(data +
> 48));
> >     >               fold1 =3D _mm_xor_si128(fold1, temp);
> >     > -             k =3D params->rk1_rk2;
> >     > +             k =3D _mm_load_si128((const __m128i *)params->rk1_r=
k2);
> >     >
> >     >               for (n =3D 64; (n + 64) <=3D data_len; n +=3D 64) {
> >     >                       temp1 =3D _mm_loadu_si128((const __m128i
> >     *)&data[n]);
> >     > @@ -175,7 +173,7 @@ crc32_eth_calc_pclmulqdq(
> >     >                       fold4 =3D crcr32_folding_round(temp4, k,
> fold4);
> >     >               }
> >     >
> >     > -             k =3D params->rk3_rk4;
> >     > +             k =3D _mm_load_si128((const __m128i *)params->rk3_r=
k4);
> >     >               fold1 =3D crcr32_folding_round(fold2, k, fold1);
> >     >               fold1 =3D crcr32_folding_round(fold3, k, fold1);
> >     >               fold =3D crcr32_folding_round(fold4, k, fold1);
> >     > @@ -205,7 +203,7 @@ crc32_eth_calc_pclmulqdq(
> >     >       fold =3D _mm_xor_si128(fold, temp);
> >     >
> >     >       /** Single folding loop - the last 16 bytes is processed
> >     separately */
> >     > -     k =3D params->rk3_rk4;
> >     > +     k =3D _mm_load_si128((const __m128i *)params->rk3_rk4);
> >     >       n =3D 16;
> >     >
> >     >   single_fold_loop:
> >     > @@ -235,11 +233,11 @@ crc32_eth_calc_pclmulqdq(
> >     >
> >     >       /** Reduction 128 -> 32 Assumes: fold holds 128bit folded
> >     data */
> >     >   reduction_128_64:
> >     > -     k =3D params->rk5_rk6;
> >     > +     k =3D _mm_load_si128((const __m128i *)params->rk5_rk6);
> >     >       fold =3D crcr32_reduce_128_to_64(fold, k);
> >     >
> >     >   barret_reduction:
> >     > -     k =3D params->rk7_rk8;
> >     > +     k =3D _mm_load_si128((const __m128i *)params->rk7_rk8);
> >     >       n =3D crcr32_reduce_64_to_32(fold, k);
> >     >
> >     >       return n;
> >     > @@ -248,45 +246,17 @@ crc32_eth_calc_pclmulqdq(
> >     >   void
> >     >   rte_net_crc_sse42_init(void)
> >     >   {
> >     > -     uint64_t k1, k2, k3, k4, k5, k6;
> >     > -     uint64_t p =3D 0, q =3D 0;
> >     > -
> >     > -     /** Initialize CRC16 data */
> >     > -     k1 =3D 0x14ff2LLU;
> >     > -     k2 =3D 0x19a3cLLU;
> >     > -     k3 =3D 0x189aeLLU;
> >     > -     k4 =3D 0x8e10LLU;
> >     > -     k5 =3D 0x189aeLLU;
> >     > -     k6 =3D 0x114aaLLU;
> >     > -     q =3D  0x11c581910LLU;
> >     > -     p =3D  0x10811LLU;
> >     > -
> >     > -     /** Save the params in context structure */
> >     > -     crc16_ccitt_pclmulqdq.rk1_rk2 =3D _mm_set_epi64x(k2, k1);
> >     > -     crc16_ccitt_pclmulqdq.rk3_rk4 =3D _mm_set_epi64x(k4, k3);
> >     > -     crc16_ccitt_pclmulqdq.rk5_rk6 =3D _mm_set_epi64x(k6, k5);
> >     > -     crc16_ccitt_pclmulqdq.rk7_rk8 =3D _mm_set_epi64x(p, q);
> >     > -
> >     > -     /** Initialize CRC32 data */
> >     > -     k1 =3D 0x1c6e41596LLU;
> >     > -     k2 =3D 0x154442bd4LLU;
> >     > -     k3 =3D 0xccaa009eLLU;
> >     > -     k4 =3D 0x1751997d0LLU;
> >     > -     k5 =3D 0xccaa009eLLU;
> >     > -     k6 =3D 0x163cd6124LLU;
> >     > -     q =3D  0x1f7011640LLU;
> >     > -     p =3D  0x1db710641LLU;
> >     > -
> >     > -     /** Save the params in context structure */
> >     > -     crc32_eth_pclmulqdq.rk1_rk2 =3D _mm_set_epi64x(k2, k1);
> >     > -     crc32_eth_pclmulqdq.rk3_rk4 =3D _mm_set_epi64x(k4, k3);
> >     > -     crc32_eth_pclmulqdq.rk5_rk6 =3D _mm_set_epi64x(k6, k5);
> >     > -     crc32_eth_pclmulqdq.rk7_rk8 =3D _mm_set_epi64x(p, q);
> >     >   }
> >     >
> >     >   uint32_t
> >     >   rte_crc16_ccitt_sse42_handler(const uint8_t *data, uint32_t
> >     data_len)
> >     >   {
> >     > +     static const struct crc_pclmulqdq_ctx
> >     crc16_ccitt_pclmulqdq =3D {
> >     > +             .rk1_rk2 =3D { 0x14ff2LLU, 0x19a3cLLU },
> >     > +             .rk3_rk4 =3D { 0x189aeLLU, 0x8e10LLU },
> >     > +             .rk5_rk6 =3D { 0x189aeLLU, 0x114aaLLU },
> >     > +             .rk7_rk8 =3D { 0x11c581910LLU, 0x10811LLU },
> >     > +     };
> >     >       /** return 16-bit CRC value */
> >     >       return (uint16_t)~crc32_eth_calc_pclmulqdq(data,
> >     >               data_len,
> >     > @@ -297,6 +267,12 @@ rte_crc16_ccitt_sse42_handler(const uint8_t
> >     *data, uint32_t data_len)
> >     >   uint32_t
> >     >   rte_crc32_eth_sse42_handler(const uint8_t *data, uint32_t
> >     data_len)
> >     >   {
> >     > +     static const struct crc_pclmulqdq_ctx crc32_eth_pclmulqdq =
=3D {
> >     > +             .rk1_rk2 =3D { 0x1c6e41596LLU, 0x154442bd4LLU },
> >     > +             .rk3_rk4 =3D { 0xccaa009eLLU, 0x1751997d0LLU },
> >     > +             .rk5_rk6 =3D { 0xccaa009eLLU, 0x163cd6124LLU },
> >     > +             .rk7_rk8 =3D { 0x1f7011640LLU, 0x1db710641LLU },
> >     > +     };
> >     >       return ~crc32_eth_calc_pclmulqdq(data,
> >     >               data_len,
> >     >               0xffffffffUL,
> >
>
>

--000000000000fc552e065feb2750
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Nov 10,=
 2026 at 3:21=E2=80=AFPM Konstantin Ananyev &lt;<a href=3D"mailto:konstanti=
n.v.ananyev@yandex.ru">konstantin.v.ananyev@yandex.ru</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
<br>
&gt;<br>
&gt;<br>
&gt; On Mon, Nov 9, 2026 at 3:40=E2=80=AFPM Konstantin Ananyev <br>
&gt; &lt;<a href=3D"mailto:konstantin.v.ananyev@yandex.ru" target=3D"_blank=
">konstantin.v.ananyev@yandex.ru</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Replace the __m128i members in the PCLMULQDQ C=
RC context with<br>
&gt;=C2=A0 =C2=A0 =C2=A0aligned<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; uint64_t arrays to allow portable compile-time=
 initialization.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Move CRC16-CCITT and CRC32-ETH folding constan=
ts into static<br>
&gt;=C2=A0 =C2=A0 =C2=A0const context<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; structures in their respective handlers, remov=
ing the runtime<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; initialization previously performed by rte_net=
_crc_sse42_init<br>
&gt;=C2=A0 =C2=A0 =C2=A0and avoids<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; the extra data segment static variables which =
were being populated.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Load the constants into SIMD registers using a=
ligned loads when<br>
&gt;=C2=A0 =C2=A0 =C2=A0performing<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; CRC calculations. This was done transparently =
previously when the<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; __m128i values were assigned, now there is exp=
licit SIMD load done.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0It is not clear why(how) new code is better then wh=
at we have<br>
&gt;=C2=A0 =C2=A0 =C2=A0right now.<br>
&gt;=C2=A0 =C2=A0 =C2=A0Can you probably provide a bit more details?<br>
&gt;<br>
&gt;<br>
&gt; Previously this file was maintaining static variables in data segment =
<br>
&gt; namely:<br>
&gt; static alignas(16) struct crc_pclmulqdq_ctx crc32_eth_pclmulqdq;<br>
&gt; static alignas(16) struct crc_pclmulqdq_ctx crc16_ccitt_pclmulqdq;<br>
&gt;<br>
&gt; These were populated in the init function with the same calculated <br=
>
&gt; fold constants.<br>
&gt; The constants already are present in the rodata section in the binary.=
<br>
&gt; Hence the init is doing extra work in copying it over to the <br>
&gt; static=C2=A0crc_pclmulqdq_ctx<br>
&gt; structures which is=C2=A0redundant.<br>
&gt;<br>
&gt; This patch avoids this extra copy during init and modifies the SIMD <b=
r>
&gt; routines<br>
&gt; to directly read the constants from rodata memory. Thus the data <br>
&gt; segment memory usage is<br>
&gt; reduced by getting rid of the static variables (128 bytes). There <br>
&gt; should be no<br>
&gt; performance impact by this change (minus the init work done previously=
).<br>
<br>
TBH, it looks to me like a nitpicking: yes we move 128B from .data to <br>
.rodata, but in terms<br>
of functionality or perfomance - does it really matter?<br></blockquote><di=
v><br></div><div>It is not moving from .data to .rodata, same data was alre=
ady there in .rodata,</div><div>hence it is removal from .data.</div><div><=
br></div><div>Well this was mainly motivated from the rewrite for improving=
 barrett reduction.</div><div>I&#39;ve combined this in the other patch and=
 we can drop this patch from review.</div><div>Kindly review the newer subm=
ission which includes this refactory=C2=A0change as well:</div><div><a href=
=3D"https://patches.dpdk.org/project/dpdk/patch/20261110121048.831330-1-165=
67adigashreesh@gmail.com/">https://patches.dpdk.org/project/dpdk/patch/2026=
1110121048.831330-1-16567adigashreesh@gmail.com/</a></div><div><br></div><d=
iv>Thanks,</div><div>Shreesh</div><div>=C2=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
Though yes, the code looks a bit simpler and=C2=A0 nicer.<br>
If we decided to improve the init code, then my preference would be to <br>
use=C2=A0 rte_xmm_t?<br>
Then we can do something like that:<br>
struct crc_pclmulqdq_ctx {<br>
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 rte_xmm_t rk1_rk2;<br>
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0...<br>
};<br>
...<br>
=C2=A0=C2=A0static const struct crc_pclmulqdq_ctx crc32_eth_pclmulqdq =3D {=
<br>
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.rk1_rk2 =3D { .u64 =
=3D {0x1c6e41596LLU, 0x154442bd4LLU }},<br>
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0...<br>
};<br>
...<br>
__m128i k =3D params-&gt;rk3_rk4.x;<br>
<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Signed-off-by: Shreesh Adiga &lt;<a href=3D"ma=
ilto:16567adigashreesh@gmail.com" target=3D"_blank">16567adigashreesh@gmail=
.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0lib/net/net_crc_sse.c | 68<br>
&gt;=C2=A0 =C2=A0 =C2=A0++++++++++++++-----------------------------<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A01 file changed, 22 insertions(+), =
46 deletions(-)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; diff --git a/lib/net/net_crc_sse.c b/lib/net/n=
et_crc_sse.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; index e30f8544fc..4361e35e39 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; --- a/lib/net/net_crc_sse.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +++ b/lib/net/net_crc_sse.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -12,15 +12,13 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0#include &quot;net_crc.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0/** PCLMULQDQ CRC computation cont=
ext structure */<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -struct crc_pclmulqdq_ctx {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0__m128i rk1_rk2;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0__m128i rk3_rk4;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0__m128i rk5_rk6;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0__m128i rk7_rk8;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +struct __rte_aligned(XMM_SIZE) crc_pclmulqdq_=
ctx {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0uint64_t rk1_rk2[2];<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0uint64_t rk3_rk4[2];<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0uint64_t rk5_rk6[2];<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0uint64_t rk7_rk8[2];<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -static alignas(16) struct crc_pclmulqdq_ctx c=
rc32_eth_pclmulqdq;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -static alignas(16) struct crc_pclmulqdq_ctx c=
rc16_ccitt_pclmulqdq;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0/**<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 * @brief Performs one folding rou=
nd<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 *<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -162,7 +160,7 @@ crc32_eth_calc_pclmulqdq(<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0fold3 =3D _mm_loadu_si128((const __m128i *)(data + 32));<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0fold4 =3D _mm_loadu_si128((const __m128i *)(data + 48));<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0fold1 =3D _mm_xor_si128(fold1, temp);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0k =3D params-&gt;rk1_rk2;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0k =3D _mm_load_si128((const __m128i *)params-&gt;rk1_rk2);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0for (n =3D 64; (n + 64) &lt;=3D data_len; n +=3D 64) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0temp1 =3D _mm_loadu_si128((const __m1=
28i<br>
&gt;=C2=A0 =C2=A0 =C2=A0*)&amp;data[n]);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -175,7 +173,7 @@ crc32_eth_calc_pclmulqdq(<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fold4 =3D crcr32_folding_round(temp4,=
 k, fold4);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0k =3D params-&gt;rk3_rk4;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0k =3D _mm_load_si128((const __m128i *)params-&gt;rk3_rk4);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0fold1 =3D crcr32_folding_round(fold2, k, fold1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0fold1 =3D crcr32_folding_round(fold3, k, fold1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0fold =3D crcr32_folding_round(fold4, k, fold1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -205,7 +203,7 @@ crc32_eth_calc_pclmulqdq(<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0fold =3D _mm_xor_si1=
28(fold, temp);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/** Single folding l=
oop - the last 16 bytes is processed<br>
&gt;=C2=A0 =C2=A0 =C2=A0separately */<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0k =3D params-&gt;rk3_rk4;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0k =3D _mm_load_si128((con=
st __m128i *)params-&gt;rk3_rk4);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0n =3D 16;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0single_fold_loop:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -235,11 +233,11 @@ crc32_eth_calc_pclmulqdq=
(<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/** Reduction 128 -&=
gt; 32 Assumes: fold holds 128bit folded<br>
&gt;=C2=A0 =C2=A0 =C2=A0data */<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0reduction_128_64:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0k =3D params-&gt;rk5_rk6;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0k =3D _mm_load_si128((con=
st __m128i *)params-&gt;rk5_rk6);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0fold =3D crcr32_redu=
ce_128_to_64(fold, k);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0barret_reduction:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0k =3D params-&gt;rk7_rk8;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0k =3D _mm_load_si128((con=
st __m128i *)params-&gt;rk7_rk8);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0n =3D crcr32_reduce_=
64_to_32(fold, k);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return n;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -248,45 +246,17 @@ crc32_eth_calc_pclmulqdq=
(<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0void<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0rte_net_crc_sse42_init(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0uint64_t k1, k2, k3, k4, =
k5, k6;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0uint64_t p =3D 0, q =3D 0=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0/** Initialize CRC16 data=
 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0k1 =3D 0x14ff2LLU;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0k2 =3D 0x19a3cLLU;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0k3 =3D 0x189aeLLU;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0k4 =3D 0x8e10LLU;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0k5 =3D 0x189aeLLU;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0k6 =3D 0x114aaLLU;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0q =3D=C2=A0 0x11c581910LL=
U;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0p =3D=C2=A0 0x10811LLU;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0/** Save the params in co=
ntext structure */<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0crc16_ccitt_pclmulqdq.rk1=
_rk2 =3D _mm_set_epi64x(k2, k1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0crc16_ccitt_pclmulqdq.rk3=
_rk4 =3D _mm_set_epi64x(k4, k3);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0crc16_ccitt_pclmulqdq.rk5=
_rk6 =3D _mm_set_epi64x(k6, k5);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0crc16_ccitt_pclmulqdq.rk7=
_rk8 =3D _mm_set_epi64x(p, q);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0/** Initialize CRC32 data=
 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0k1 =3D 0x1c6e41596LLU;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0k2 =3D 0x154442bd4LLU;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0k3 =3D 0xccaa009eLLU;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0k4 =3D 0x1751997d0LLU;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0k5 =3D 0xccaa009eLLU;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0k6 =3D 0x163cd6124LLU;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0q =3D=C2=A0 0x1f7011640LL=
U;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0p =3D=C2=A0 0x1db710641LL=
U;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0/** Save the params in co=
ntext structure */<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0crc32_eth_pclmulqdq.rk1_r=
k2 =3D _mm_set_epi64x(k2, k1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0crc32_eth_pclmulqdq.rk3_r=
k4 =3D _mm_set_epi64x(k4, k3);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0crc32_eth_pclmulqdq.rk5_r=
k6 =3D _mm_set_epi64x(k6, k5);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0crc32_eth_pclmulqdq.rk7_r=
k8 =3D _mm_set_epi64x(p, q);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0uint32_t<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0rte_crc16_ccitt_sse42_handler(cons=
t uint8_t *data, uint32_t<br>
&gt;=C2=A0 =C2=A0 =C2=A0data_len)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0static const struct crc_p=
clmulqdq_ctx<br>
&gt;=C2=A0 =C2=A0 =C2=A0crc16_ccitt_pclmulqdq =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0.rk1_rk2 =3D { 0x14ff2LLU, 0x19a3cLLU },<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0.rk3_rk4 =3D { 0x189aeLLU, 0x8e10LLU },<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0.rk5_rk6 =3D { 0x189aeLLU, 0x114aaLLU },<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0.rk7_rk8 =3D { 0x11c581910LLU, 0x10811LLU },<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/** return 16-bit CR=
C value */<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return (uint16_t)~cr=
c32_eth_calc_pclmulqdq(data,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0data_len,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -297,6 +267,12 @@ rte_crc16_ccitt_sse42_han=
dler(const uint8_t<br>
&gt;=C2=A0 =C2=A0 =C2=A0*data, uint32_t data_len)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0uint32_t<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0rte_crc32_eth_sse42_handler(const =
uint8_t *data, uint32_t<br>
&gt;=C2=A0 =C2=A0 =C2=A0data_len)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0static const struct crc_p=
clmulqdq_ctx crc32_eth_pclmulqdq =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0.rk1_rk2 =3D { 0x1c6e41596LLU, 0x154442bd4LLU },<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0.rk3_rk4 =3D { 0xccaa009eLLU, 0x1751997d0LLU },<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0.rk5_rk6 =3D { 0xccaa009eLLU, 0x163cd6124LLU },<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0.rk7_rk8 =3D { 0x1f7011640LLU, 0x1db710641LLU },<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return ~crc32_eth_ca=
lc_pclmulqdq(data,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0data_len,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A00xffffffffUL,<br>
&gt;<br>
<br>
</blockquote></div></div>

--000000000000fc552e065feb2750--
