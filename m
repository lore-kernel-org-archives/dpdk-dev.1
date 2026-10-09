Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7F4CA6015
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 03:24:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 38D994027A;
	Fri,  9 Oct 2026 05:24:46 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id EFA1C4026D
 for <dev@dpdk.org>; Fri,  9 Oct 2026 05:24:44 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B02221692;
 Thu,  8 Oct 2026 20:24:40 -0700 (PDT)
Received: from [10.122.30.109] (unknown [10.122.30.109])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 821AA3F8C6;
 Thu,  8 Oct 2026 20:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1791516284; bh=mZsBsxmMBqyd+M9q6GcdKpMkyavBFH1bVhm+lWL+3O0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=LGAgSiQcHRzZ8xox7YWBFYh7Iq5giNfJSQ8nNLibFNJDqZ3KIzKdVlhlIRlivTaow
 UmiBy+jhTxY7Wi5tz5zaFt2nj4NIt2jHKMEdczslu0Vg0vO7Rqa0ZQDbgik562Bau+
 53a1Wj9C5lgCPYU3K3J0uSp6uPeZhpArvnygfZJk=
Message-ID: <2b8df94c-8ca3-4022-b9c4-d95970581b80@arm.com>
Date: Thu, 8 Oct 2026 22:24:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/crc: make NEON CRC folding logic similar to x86 SSE
To: Shreesh Adiga <16567adigashreesh@gmail.com>
Cc: dev@dpdk.org
References: <20261006151833.347561-1-16567adigashreesh@gmail.com>
Content-Language: en-US
From: Wathsala Vithanage <wathsala.vithanage@arm.com>
In-Reply-To: <20261006151833.347561-1-16567adigashreesh@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Shreesh,

Looks correct. Can you share before and after performance data in the
commit message covering short inputs below 16 bytes, lengths exercising
the different nonzero remainders modulo 16, and larger buffers to show
the effect on the folding loop?

Thanks

--wathsala

On 10/6/26 10:18, Shreesh Adiga wrote:
> This patch includes the following minor changes:
> 1) Use TBL based shift left for variable len shift instead of using
>     vshift_bytes_left which adds a switch case for 16 len cases.
> 2) Align the fold constants to use PMULL and PMULL2 instructions
>     instead of using cross lane operands which requires additional shift.
> 3) Remove unnecessary static arrays used in crc32_reduce_64_to_32 by
>     adapting x86 SSE logic.
> 4) Use x86 SSE logic for processing partial bytes sequence to avoid
>     using multiple variable len shifts which inserts switch case.
>
> Signed-off-by: Shreesh Adiga <16567adigashreesh@gmail.com>
> ---
>   lib/net/net_crc_neon.c | 71 +++++++++++++++++++++++++++---------------
>   1 file changed, 46 insertions(+), 25 deletions(-)
>
> diff --git a/lib/net/net_crc_neon.c b/lib/net/net_crc_neon.c
> index d924aed25d..3833fcba6e 100644
> --- a/lib/net/net_crc_neon.c
> +++ b/lib/net/net_crc_neon.c
> @@ -24,6 +24,31 @@ struct crc_pmull_ctx {
>   alignas(16) struct crc_pmull_ctx crc32_eth_pmull;
>   alignas(16) struct crc_pmull_ctx crc16_ccitt_pmull;
>   
> +static const alignas(16) uint8_t crc_neon_shift_tab[32] = {
> +	0xff, 0xfe, 0xfd, 0xfc, 0xfb, 0xfa, 0xf9, 0xf8,
> +	0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0xf0,
> +	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
> +	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f
> +};
> +
> +/**
> + * Shifts left 128 bit register by specified number of bytes
> + *
> + * @param reg
> + *   128 bit value
> + * @param num
> + *   number of bytes to shift left reg by (0-16)
> + *
> + * @return
> + *   reg << (num * 8)
> + */
> +static inline uint64x2_t
> +neon_shift_left(uint64x2_t reg, const unsigned int num)
> +{
> +	uint8x16_t tbl = vld1q_u8(crc_neon_shift_tab + 16 - num);
> +	return vreinterpretq_u64_u8(vqtbl1q_u8(vreinterpretq_u8_u64(reg), tbl));
> +}
> +
>   /**
>    * @brief Performs one folding round
>    *
> @@ -46,12 +71,12 @@ crcr32_folding_round(uint64x2_t data_block, uint64x2_t precomp,
>   	uint64x2_t fold)
>   {
>   	uint64x2_t tmp0 = vreinterpretq_u64_p128(vmull_p64(
> -			vgetq_lane_p64(vreinterpretq_p64_u64(fold), 1),
> +			vgetq_lane_p64(vreinterpretq_p64_u64(fold), 0),
>   			vgetq_lane_p64(vreinterpretq_p64_u64(precomp), 0)));
>   
> -	uint64x2_t tmp1 = vreinterpretq_u64_p128(vmull_p64(
> -			vgetq_lane_p64(vreinterpretq_p64_u64(fold), 0),
> -			vgetq_lane_p64(vreinterpretq_p64_u64(precomp), 1)));
> +	uint64x2_t tmp1 = vreinterpretq_u64_p128(vmull_high_p64(
> +			vreinterpretq_p64_u64(fold),
> +			vreinterpretq_p64_u64(precomp)));
>   
>   	return veorq_u64(tmp1, veorq_u64(data_block, tmp0));
>   }
> @@ -98,26 +123,19 @@ static inline uint32_t
>   crcr32_reduce_64_to_32(uint64x2_t data64,
>   	uint64x2_t precomp)
>   {
> -	static alignas(16) uint32_t mask1[4] = {
> -		0xffffffff, 0xffffffff, 0x00000000, 0x00000000
> -	};
> -	static alignas(16) uint32_t mask2[4] = {
> -		0x00000000, 0xffffffff, 0xffffffff, 0xffffffff
> -	};
>   	uint64x2_t tmp0, tmp1, tmp2;
>   
> -	tmp0 = vandq_u64(data64, vld1q_u64((uint64_t *)mask2));
> +	tmp0 = vreinterpretq_u64_u32(
> +		vsetq_lane_u32(0, vreinterpretq_u32_u64(data64), 0));
>   
>   	tmp1 = vreinterpretq_u64_p128(vmull_p64(
>   		vgetq_lane_p64(vreinterpretq_p64_u64(tmp0), 0),
>   		vgetq_lane_p64(vreinterpretq_p64_u64(precomp), 0)));
>   	tmp1 = veorq_u64(tmp1, tmp0);
> -	tmp1 = vandq_u64(tmp1, vld1q_u64((uint64_t *)mask1));
>   
>   	tmp2 = vreinterpretq_u64_p128(vmull_p64(
>   		vgetq_lane_p64(vreinterpretq_p64_u64(tmp1), 0),
>   		vgetq_lane_p64(vreinterpretq_p64_u64(precomp), 1)));
> -	tmp2 = veorq_u64(tmp2, tmp1);
>   	tmp2 = veorq_u64(tmp2, tmp0);
>   
>   	return vgetq_lane_u32(vreinterpretq_u32_u64(tmp2), 2);
> @@ -177,10 +195,10 @@ crc32_eth_calc_pmull(
>   		fold = vld1q_u64((uint64_t *)buffer);
>   		fold = veorq_u64(fold, temp);
>   		if (unlikely(data_len < 4)) {
> -			fold = vshift_bytes_left(fold, 8 - data_len);
> +			fold = neon_shift_left(fold, 8 - data_len);
>   			goto barret_reduction;
>   		}
> -		fold = vshift_bytes_left(fold, 16 - data_len);
> +		fold = neon_shift_left(fold, 16 - data_len);
>   		goto reduction_128_64;
>   	}
>   
> @@ -201,14 +219,17 @@ crc32_eth_calc_pmull(
>   
>   	/** Partial bytes - process last <16 bytes */
>   	if (likely(n < data_len)) {
> -		uint64x2_t last16, a, b, mask;
> +		uint8x16_t last16, t1, t2;
> +		uint64x2_t a, b;
>   		uint32_t rem = data_len & 15;
>   
> -		last16 = vld1q_u64((const uint64_t *)&data[data_len - 16]);
> -		a = vshift_bytes_left(fold, 16 - rem);
> -		b = vshift_bytes_right(fold, rem);
> -		mask = vshift_bytes_left(vdupq_n_u64(-1), 16 - rem);
> -		b = vorrq_u64(b, vandq_u64(mask, last16));
> +		last16 = vld1q_u8((const uint8_t *)&data[data_len - 16]);
> +		t1 = vld1q_u8(crc_neon_shift_tab + rem);
> +		a  = vreinterpretq_u64_u8(vqtbl1q_u8(vreinterpretq_u8_u64(fold), t1));
> +		t2 = vmvnq_u8(t1);
> +		t2 = vqtbl1q_u8(vreinterpretq_u8_u64(fold), t2);
> +		t1 = vcgezq_s8(vreinterpretq_s8_u8(t1));
> +		b  = vreinterpretq_u64_u8(vbslq_u8(t1, last16, t2));
>   
>   		/* k = rk3 & rk4 */
>   		fold = crcr32_folding_round(b, k, a);
> @@ -230,14 +251,14 @@ void
>   rte_net_crc_neon_init(void)
>   {
>   	/* Initialize CRC16 data */
> -	uint64_t ccitt_k1_k2[2] = {0x14ff2LLU, 0x19a3cLLU};
> -	uint64_t ccitt_k3_k4[2] = {0x189aeLLU, 0x8e10LLU};
> +	uint64_t ccitt_k1_k2[2] = {0x19a3cLLU, 0x14ff2LLU};
> +	uint64_t ccitt_k3_k4[2] = {0x8e10LLU, 0x189aeLLU};
>   	uint64_t ccitt_k5_k6[2] = {0x189aeLLU, 0x114aaLLU};
>   	uint64_t ccitt_k7_k8[2] = {0x11c581910LLU, 0x10811LLU};
>   
>   	/* Initialize CRC32 data */
> -	uint64_t eth_k1_k2[2] = {0x1c6e41596LLU, 0x154442bd4LLU};
> -	uint64_t eth_k3_k4[2] = {0xccaa009eLLU, 0x1751997d0LLU};
> +	uint64_t eth_k1_k2[2] = {0x154442bd4LLU, 0x1c6e41596LLU};
> +	uint64_t eth_k3_k4[2] = {0x1751997d0LLU, 0xccaa009eLLU};
>   	uint64_t eth_k5_k6[2] = {0xccaa009eLLU, 0x163cd6124LLU};
>   	uint64_t eth_k7_k8[2] = {0x1f7011640LLU, 0x1db710641LLU};
>   
