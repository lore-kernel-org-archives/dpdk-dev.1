Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A285C282CD
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Mar 2025 22:27:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 38E3C40156;
	Mon,  3 Mar 2025 23:27:37 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id B477F40041
 for <dev@dpdk.org>; Mon,  3 Mar 2025 23:27:35 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 165E12110488; Mon,  3 Mar 2025 14:27:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 165E12110488
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741040855;
 bh=Yz3POLjQtdNH/EifP7P6DYMbu5yRb6nFW/Xa38xcZRY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UGXpE6aUxyons5xSEpqDUDo6s2hWMWHRQL16bDa63jgafQ8fnFbpd4zcD/mwO1r/f
 uE7Qw0eYHJq2YVJbksvifgUDHxI0HAANm4IY3uN5PanjWmAftwXuocdDJfr6VeAcDI
 S6VocLuGxeykwhsBmXlysLMFWVdRVHxC2a1eRSWQ=
Date: Mon, 3 Mar 2025 14:27:35 -0800
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 1/2] lib/hash: initialize __m128i data type in a portable
 way
Message-ID: <20250303222735.GA30522@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1732748278-14796-1-git-send-email-andremue@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1732748278-14796-1-git-send-email-andremue@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
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

On Wed, Nov 27, 2024 at 02:57:57PM -0800, Andre Muezerie wrote:
> The mechanism used to initialize an __m128i data type in rte_thash.h is
> non-portable and MSVC does not like it. It clearly is not doing what
> is desired:
> 
> ..\lib\hash\rte_thash.h(38): warning C4305: 'initializing':
>     truncation from 'unsigned __int64' to 'char'
> ..\lib\hash\rte_thash.h(38): warning C4305: 'initializing':
>     truncation from 'unsigned __int64' to 'char'
> 
> A more portable approach is to use compiler intrinsics to perform the
> initialization. This patch uses a single compiler intrinsic to
> initialize the data type using a sequence of 16 bytes stored in
> memory.
> 
> There should be no perf degradation due to this change.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
>  lib/hash/rte_thash.h | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/hash/rte_thash.h b/lib/hash/rte_thash.h
> index c0af5968df..3512639792 100644
> --- a/lib/hash/rte_thash.h
> +++ b/lib/hash/rte_thash.h
> @@ -34,8 +34,9 @@ extern "C" {
>  /* Byte swap mask used for converting IPv6 address
>   * 4-byte chunks to CPU byte order
>   */
> -static const __m128i rte_thash_ipv6_bswap_mask = {
> -		0x0405060700010203ULL, 0x0C0D0E0F08090A0BULL};
> +static const uint8_t rte_thash_ipv6_bswap_mask[] = {
> +		0x03, 0x02, 0x01, 0x00, 0x07, 0x06, 0x05, 0x04,
> +		0x0B, 0x0A, 0x09, 0x08, 0x0F, 0x0E, 0x0D, 0x0C};
>  #endif
>  
>  /**
> @@ -152,12 +153,14 @@ rte_thash_load_v6_addrs(const struct rte_ipv6_hdr *orig,
>  			union rte_thash_tuple *targ)
>  {
>  #ifdef RTE_ARCH_X86
> +	const __m128i ipv6_bswap_mask =
> +			_mm_loadu_si128((const __m128i*)&rte_thash_ipv6_bswap_mask);
>  	__m128i ipv6 = _mm_loadu_si128((const __m128i *)&orig->src_addr);
>  	*(__m128i *)&targ->v6.src_addr =
> -			_mm_shuffle_epi8(ipv6, rte_thash_ipv6_bswap_mask);
> +			_mm_shuffle_epi8(ipv6, ipv6_bswap_mask);
>  	ipv6 = _mm_loadu_si128((const __m128i *)&orig->dst_addr);
>  	*(__m128i *)&targ->v6.dst_addr =
> -			_mm_shuffle_epi8(ipv6, rte_thash_ipv6_bswap_mask);
> +			_mm_shuffle_epi8(ipv6, ipv6_bswap_mask);
>  #elif defined(__ARM_NEON)
>  	uint8x16_t ipv6 = vld1q_u8(orig->src_addr.a);
>  	vst1q_u8(targ->v6.src_addr.a, vrev32q_u8(ipv6));
> -- 
> 2.34.1

Could someone please review this patch and let me know if there are changes to be made?
I have other patches depending on this.

Thanks,
Andre Muezerie
