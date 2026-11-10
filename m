Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52903606C644
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 09:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=LX+NqViA
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8D8440283;
	Tue, 10 Nov 2026 10:51:19 +0100 (CET)
Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net
 [37.230.174.40])
 by mails.dpdk.org (Postfix) with ESMTPS id E03244027C
 for <dev@dpdk.org>; Tue, 10 Nov 2026 10:51:17 +0100 (CET)
Received: from mail-nwsmtp-smtp-production-main-70
 (mail-nwsmtp-smtp-production-main-70.yp-c.yandex.net)
 by forward500a.mail.yandex.net (postfix) with ESMTPS id 7F185C014F;
 Tue, 10 Nov 2026 12:51:16 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-70 with ESMTPSA id
 EpOoFpAiWGk0-lCOjwdVK; Tue, 10 Nov 2026 12:51:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1794304275; bh=dMIzifdHxaSw1ixCFcmPPiuJU5OLwol7AqFPMi5kToI=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=LX+NqViALl/yvkEv/aRlu1BMMhlhlktTCLnFsN3kCz3vXXJh/+Cyibo1mu/OZyA6a
 WFaSNvMTiQA9bsBEjjtCHogV+KgjRC6TIPItZtEmIMGnmJ96RbfLsvowNwEPA4e3DS
 n6EWZU8zjnDRGmUC9ea3z2C+RK5btpLy+qazLNrc=
Authentication-Results: mail-nwsmtp-smtp-production-main-70;
 dkim=pass header.i=@yandex.ru
Message-ID: <d848d658-2acf-4b11-b356-3826bc261def@yandex.ru>
Date: Tue, 10 Nov 2026 09:51:13 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/crc: use static constants for SSE42 PCLMULQDQ
 parameters
To: Shreesh Adiga <16567adigashreesh@gmail.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Jasvinder Singh <jasvinder.singh@intel.com>, dev@dpdk.org
References: <20261108120358.1408920-1-16567adigashreesh@gmail.com>
 <663fa8ff-4bd2-4782-be7e-c03311ca639d@yandex.ru>
 <CA+-x59bP6e7vwd9tVcVoha9yCbrqLKFN6nd9KDFFh8V9ixQ99A@mail.gmail.com>
Content-Language: en-US, ru
From: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
In-Reply-To: <CA+-x59bP6e7vwd9tVcVoha9yCbrqLKFN6nd9KDFFh8V9ixQ99A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1




>
>
> On Mon, Nov 9, 2026 at 3:40 PM Konstantin Ananyev 
> <konstantin.v.ananyev@yandex.ru> wrote:
>
>
>     > Replace the __m128i members in the PCLMULQDQ CRC context with
>     aligned
>     > uint64_t arrays to allow portable compile-time initialization.
>     >
>     > Move CRC16-CCITT and CRC32-ETH folding constants into static
>     const context
>     > structures in their respective handlers, removing the runtime
>     > initialization previously performed by rte_net_crc_sse42_init
>     and avoids
>     > the extra data segment static variables which were being populated.
>     >
>     > Load the constants into SIMD registers using aligned loads when
>     performing
>     > CRC calculations. This was done transparently previously when the
>     > __m128i values were assigned, now there is explicit SIMD load done.
>
>     It is not clear why(how) new code is better then what we have
>     right now.
>     Can you probably provide a bit more details?
>
>
> Previously this file was maintaining static variables in data segment 
> namely:
> static alignas(16) struct crc_pclmulqdq_ctx crc32_eth_pclmulqdq;
> static alignas(16) struct crc_pclmulqdq_ctx crc16_ccitt_pclmulqdq;
>
> These were populated in the init function with the same calculated 
> fold constants.
> The constants already are present in the rodata section in the binary.
> Hence the init is doing extra work in copying it over to the 
> static crc_pclmulqdq_ctx
> structures which is redundant.
>
> This patch avoids this extra copy during init and modifies the SIMD 
> routines
> to directly read the constants from rodata memory. Thus the data 
> segment memory usage is
> reduced by getting rid of the static variables (128 bytes). There 
> should be no
> performance impact by this change (minus the init work done previously).

TBH, it looks to me like a nitpicking: yes we move 128B from .data to 
.rodata, but in terms
of functionality or perfomance - does it really matter?
Though yes, the code looks a bit simpler and  nicer.
If we decided to improve the init code, then my preference would be to 
use  rte_xmm_t?
Then we can do something like that:
struct crc_pclmulqdq_ctx {
         rte_xmm_t rk1_rk2;
        ...
};
...
  static const struct crc_pclmulqdq_ctx crc32_eth_pclmulqdq = {
              .rk1_rk2 = { .u64 = {0x1c6e41596LLU, 0x154442bd4LLU }},
              ...
};
...
__m128i k = params->rk3_rk4.x;

>
>     >
>     > Signed-off-by: Shreesh Adiga <16567adigashreesh@gmail.com>
>     > ---
>     >   lib/net/net_crc_sse.c | 68
>     ++++++++++++++-----------------------------
>     >   1 file changed, 22 insertions(+), 46 deletions(-)
>     >
>     > diff --git a/lib/net/net_crc_sse.c b/lib/net/net_crc_sse.c
>     > index e30f8544fc..4361e35e39 100644
>     > --- a/lib/net/net_crc_sse.c
>     > +++ b/lib/net/net_crc_sse.c
>     > @@ -12,15 +12,13 @@
>     >   #include "net_crc.h"
>     >
>     >   /** PCLMULQDQ CRC computation context structure */
>     > -struct crc_pclmulqdq_ctx {
>     > -     __m128i rk1_rk2;
>     > -     __m128i rk3_rk4;
>     > -     __m128i rk5_rk6;
>     > -     __m128i rk7_rk8;
>     > +struct __rte_aligned(XMM_SIZE) crc_pclmulqdq_ctx {
>     > +     uint64_t rk1_rk2[2];
>     > +     uint64_t rk3_rk4[2];
>     > +     uint64_t rk5_rk6[2];
>     > +     uint64_t rk7_rk8[2];
>     >   };
>     >
>     > -static alignas(16) struct crc_pclmulqdq_ctx crc32_eth_pclmulqdq;
>     > -static alignas(16) struct crc_pclmulqdq_ctx crc16_ccitt_pclmulqdq;
>     >   /**
>     >    * @brief Performs one folding round
>     >    *
>     > @@ -162,7 +160,7 @@ crc32_eth_calc_pclmulqdq(
>     >               fold3 = _mm_loadu_si128((const __m128i *)(data + 32));
>     >               fold4 = _mm_loadu_si128((const __m128i *)(data + 48));
>     >               fold1 = _mm_xor_si128(fold1, temp);
>     > -             k = params->rk1_rk2;
>     > +             k = _mm_load_si128((const __m128i *)params->rk1_rk2);
>     >
>     >               for (n = 64; (n + 64) <= data_len; n += 64) {
>     >                       temp1 = _mm_loadu_si128((const __m128i
>     *)&data[n]);
>     > @@ -175,7 +173,7 @@ crc32_eth_calc_pclmulqdq(
>     >                       fold4 = crcr32_folding_round(temp4, k, fold4);
>     >               }
>     >
>     > -             k = params->rk3_rk4;
>     > +             k = _mm_load_si128((const __m128i *)params->rk3_rk4);
>     >               fold1 = crcr32_folding_round(fold2, k, fold1);
>     >               fold1 = crcr32_folding_round(fold3, k, fold1);
>     >               fold = crcr32_folding_round(fold4, k, fold1);
>     > @@ -205,7 +203,7 @@ crc32_eth_calc_pclmulqdq(
>     >       fold = _mm_xor_si128(fold, temp);
>     >
>     >       /** Single folding loop - the last 16 bytes is processed
>     separately */
>     > -     k = params->rk3_rk4;
>     > +     k = _mm_load_si128((const __m128i *)params->rk3_rk4);
>     >       n = 16;
>     >
>     >   single_fold_loop:
>     > @@ -235,11 +233,11 @@ crc32_eth_calc_pclmulqdq(
>     >
>     >       /** Reduction 128 -> 32 Assumes: fold holds 128bit folded
>     data */
>     >   reduction_128_64:
>     > -     k = params->rk5_rk6;
>     > +     k = _mm_load_si128((const __m128i *)params->rk5_rk6);
>     >       fold = crcr32_reduce_128_to_64(fold, k);
>     >
>     >   barret_reduction:
>     > -     k = params->rk7_rk8;
>     > +     k = _mm_load_si128((const __m128i *)params->rk7_rk8);
>     >       n = crcr32_reduce_64_to_32(fold, k);
>     >
>     >       return n;
>     > @@ -248,45 +246,17 @@ crc32_eth_calc_pclmulqdq(
>     >   void
>     >   rte_net_crc_sse42_init(void)
>     >   {
>     > -     uint64_t k1, k2, k3, k4, k5, k6;
>     > -     uint64_t p = 0, q = 0;
>     > -
>     > -     /** Initialize CRC16 data */
>     > -     k1 = 0x14ff2LLU;
>     > -     k2 = 0x19a3cLLU;
>     > -     k3 = 0x189aeLLU;
>     > -     k4 = 0x8e10LLU;
>     > -     k5 = 0x189aeLLU;
>     > -     k6 = 0x114aaLLU;
>     > -     q =  0x11c581910LLU;
>     > -     p =  0x10811LLU;
>     > -
>     > -     /** Save the params in context structure */
>     > -     crc16_ccitt_pclmulqdq.rk1_rk2 = _mm_set_epi64x(k2, k1);
>     > -     crc16_ccitt_pclmulqdq.rk3_rk4 = _mm_set_epi64x(k4, k3);
>     > -     crc16_ccitt_pclmulqdq.rk5_rk6 = _mm_set_epi64x(k6, k5);
>     > -     crc16_ccitt_pclmulqdq.rk7_rk8 = _mm_set_epi64x(p, q);
>     > -
>     > -     /** Initialize CRC32 data */
>     > -     k1 = 0x1c6e41596LLU;
>     > -     k2 = 0x154442bd4LLU;
>     > -     k3 = 0xccaa009eLLU;
>     > -     k4 = 0x1751997d0LLU;
>     > -     k5 = 0xccaa009eLLU;
>     > -     k6 = 0x163cd6124LLU;
>     > -     q =  0x1f7011640LLU;
>     > -     p =  0x1db710641LLU;
>     > -
>     > -     /** Save the params in context structure */
>     > -     crc32_eth_pclmulqdq.rk1_rk2 = _mm_set_epi64x(k2, k1);
>     > -     crc32_eth_pclmulqdq.rk3_rk4 = _mm_set_epi64x(k4, k3);
>     > -     crc32_eth_pclmulqdq.rk5_rk6 = _mm_set_epi64x(k6, k5);
>     > -     crc32_eth_pclmulqdq.rk7_rk8 = _mm_set_epi64x(p, q);
>     >   }
>     >
>     >   uint32_t
>     >   rte_crc16_ccitt_sse42_handler(const uint8_t *data, uint32_t
>     data_len)
>     >   {
>     > +     static const struct crc_pclmulqdq_ctx
>     crc16_ccitt_pclmulqdq = {
>     > +             .rk1_rk2 = { 0x14ff2LLU, 0x19a3cLLU },
>     > +             .rk3_rk4 = { 0x189aeLLU, 0x8e10LLU },
>     > +             .rk5_rk6 = { 0x189aeLLU, 0x114aaLLU },
>     > +             .rk7_rk8 = { 0x11c581910LLU, 0x10811LLU },
>     > +     };
>     >       /** return 16-bit CRC value */
>     >       return (uint16_t)~crc32_eth_calc_pclmulqdq(data,
>     >               data_len,
>     > @@ -297,6 +267,12 @@ rte_crc16_ccitt_sse42_handler(const uint8_t
>     *data, uint32_t data_len)
>     >   uint32_t
>     >   rte_crc32_eth_sse42_handler(const uint8_t *data, uint32_t
>     data_len)
>     >   {
>     > +     static const struct crc_pclmulqdq_ctx crc32_eth_pclmulqdq = {
>     > +             .rk1_rk2 = { 0x1c6e41596LLU, 0x154442bd4LLU },
>     > +             .rk3_rk4 = { 0xccaa009eLLU, 0x1751997d0LLU },
>     > +             .rk5_rk6 = { 0xccaa009eLLU, 0x163cd6124LLU },
>     > +             .rk7_rk8 = { 0x1f7011640LLU, 0x1db710641LLU },
>     > +     };
>     >       return ~crc32_eth_calc_pclmulqdq(data,
>     >               data_len,
>     >               0xffffffffUL,
>

