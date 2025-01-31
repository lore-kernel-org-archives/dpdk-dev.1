Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE18C0218F
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 15:28:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C031840695;
	Fri, 31 Jan 2025 16:28:54 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 55524402EE
 for <dev@dpdk.org>; Fri, 31 Jan 2025 16:28:53 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id A3EEB210C31D; Fri, 31 Jan 2025 07:28:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A3EEB210C31D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738337332;
 bh=U/kANlJ20e+8TBMy3D54qSAnZ8xB67ayvxOmzasTW/s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VRT3sD9jwtVav0NMMVV/1tUyFsmTJv+Pie307KghEs43O7LJiLvPaBwovuiEy0KP/
 acdmELt5BTWYWXjN+RfSfOtt2re7myBVcej2Mhia8cQJOBPHoR7ztwO9DUCeVg3GdR
 gq8DFZurLpPTk/WtSFYTN0/kG1T5DiHHfYlLqGNk=
Date: Fri, 31 Jan 2025 07:28:52 -0800
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org, anatoly.burakov@intel.com, bruce.richardson@intel.com
Subject: Re: [PATCH] net/ice: fix segmentation fault Rx function
Message-ID: <20250131152852.GB6944@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250130192617.2744705-1-vladimir.medvedkin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130192617.2744705-1-vladimir.medvedkin@intel.com>
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

On Thu, Jan 30, 2025 at 07:26:17PM +0000, Vladimir Medvedkin wrote:
> Fix a typo in avx512 rx function, where accidentally the _mm_load_si128
> argument was passed by value instead of a pointer.
> 
> Fixes: 43fd3624fdfe ("drivers: replace GCC pragma with cast")
> Cc: andremue@linux.microsoft.com
> 
> Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> ---
>  drivers/net/intel/ice/ice_rxtx_vec_avx512.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/intel/ice/ice_rxtx_vec_avx512.c b/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
> index 681b31f61f..bd49be07c9 100644
> --- a/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
> +++ b/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
> @@ -474,7 +474,7 @@ _ice_recv_raw_pkts_vec_avx512(struct ice_rx_queue *rxq,
>  					(RTE_CAST_PTR(const __m128i *, &rxdp[7].wb.status_error1));
>  				rte_compiler_barrier();
>  				const __m128i raw_desc_bh6 = _mm_load_si128
> -					(RTE_CAST_PTR(const __m128i *, rxdp[6].wb.status_error1));
> +					(RTE_CAST_PTR(const __m128i *, &rxdp[6].wb.status_error1));
>  				rte_compiler_barrier();
>  				const __m128i raw_desc_bh5 = _mm_load_si128
>  					(RTE_CAST_PTR(const __m128i *, &rxdp[5].wb.status_error1));
> -- 
> 2.43.0

Thanks for catching and fixing this.
