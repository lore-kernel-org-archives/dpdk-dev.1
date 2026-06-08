Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BDCCD6E79
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 20:56:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC8EC402DD;
	Mon,  8 Jun 2026 22:56:36 +0200 (CEST)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com
 [209.85.128.177])
 by mails.dpdk.org (Postfix) with ESMTP id 3B65E402D6
 for <dev@dpdk.org>; Mon,  8 Jun 2026 22:56:35 +0200 (CEST)
Received: by mail-yw1-f177.google.com with SMTP id
 00721157ae682-7efd49373c0so21425187b3.1
 for <dev@dpdk.org>; Mon, 08 Jun 2026 13:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780952194;
 x=1781556994; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pNa+WKpx78KwJNGkPANJ+MrhDluJeuc629ghRBRL+UU=;
 b=xol+UhHnXmSRhzn6XBPhLcpIpLd9VvQIuasIUEC+G0mztK7uK1RxhayDhjgkPh5/IK
 elelIPfmZSbwfRihu6dKsbpN1GV2tP+r0UN+AVf2EBOXxPujpcQ7G2peXoAF+WOvzg1k
 oBDfDiopCsG0BQFgRBFu8dreF2W9a1cOBr2QpnDEPEEjWno01un1s6kyB5GHN9guvrZ4
 YvrJII9B+QoABjls0NbOkyLPP/pqolWr8B2/p94TQtdN2csjH3g1V7B6vmmFSN7NEIEk
 uy9KLwUggwjw4P/O8tp500MAHb434YbVZR0aiBHJV9K2QxMSMQ1Oy4xd0n0PIylKt/go
 yRtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780952194; x=1781556994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pNa+WKpx78KwJNGkPANJ+MrhDluJeuc629ghRBRL+UU=;
 b=pYA9f8eXsz4siz5tbyxzW53VFoRMsO0jUhcM9xSa6mZx72aN94VwP4O26bnCWedGvn
 1aNcsF4CYcaC0Re4eJLgqf+STnKwDnb1n2TscXV4OvDxmkX0lJlZaZSYhjPnpHHIB8o6
 K22e5MOcu8kFpM6WjkQNcI0DhU4bQqQfMb4Z9EfVAvxZOp/0F6iuD5sJODtMfsA22AFy
 HLFi6BKe8e5jEV96TG+BbBF3HX0aHQl4SrcZejHI608aaA8uqH5Qnz9SmZ6uWeMu2bqH
 +5VuIx42dgs9xke4Xb99Q2BPqCHBAQFch9FJ4kqcX8KkQJLkZuKkJyEt/90X9PEr6OnY
 r08g==
X-Gm-Message-State: AOJu0YwYi6ADiEn8+cJYIuGIkkd4a/ct2QarOiZkaTKc82/YGdJoeKGi
 2HarxkNd7G7r13Yn2k3O4y7xGghMZA4BulnmXdR+tv/zVkGXpmTvFW4e7rHe07BtG/zagBVAHkh
 Qop1K
X-Gm-Gg: Acq92OE1k++WCJQSjp2IlM3WjsoWWpRT7A0A8lAQROsr6z9M08Sh4MqjztlNnLZEYIE
 mxOQoDT+ADzpkJe1vEiyIusj38vQdZIn+mHcZ4RhDuMrMqeM/LlS4nnkkyPZPe+1smS9s3QQfA/
 4mxlXTKh4Rm7QgzBWj2dhBmAx3nuw3+4773sWWZdWAU3Ld+rFf1NbwKAt/ieX/vs5SOf/bmH2Iu
 D2vRDGpZM4g7dZ9PHCguJXkxK45C/VWM0UQcNzow6Ya4vETnATt8qfjvy3pq+bu1ZL6X/Idydv+
 AM1gL9nGmxQWBnyYSKnOGrActFNKsWXR2fJEqHcvppK1JjXHEOSiBfjE+iSb8Ksvohoh0eFB4KO
 zk7yyXKkB8uEgM36acaKNhjmJNRHafwx1B3/Xgu9pkgRYNVr86pJxwhw/6MDOYMD70ZHGNea7B5
 XJLAeD+6AgtA4KqF52OR18vu5ldRr2/VFgbOzjXAy1zpwAcCxM2zQyCfNUnk7xc8Q6f6XnKiD4i
 wE=
X-Received: by 2002:a05:690c:6991:b0:7db:ccda:a40c with SMTP id
 00721157ae682-7ed0e6710c9mr165291727b3.18.1780952194391; 
 Mon, 08 Jun 2026 13:56:34 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7ea2399ab1fsm89376637b3.33.2026.06.08.13.56.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 13:56:34 -0700 (PDT)
Date: Mon, 8 Jun 2026 13:56:30 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v13 01/20] net/sxe2: support AVX512 vectorized path for
 Rx and Tx
Message-ID: <20260608135630.2326351a@phoenix.local>
In-Reply-To: <20260608074257.3043531-2-liujie5@linkdatatechnology.com>
References: <20260608054219.3000719-21-liujie5@linkdatatechnology.com>
 <20260608074257.3043531-1-liujie5@linkdatatechnology.com>
 <20260608074257.3043531-2-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Mon,  8 Jun 2026 15:42:38 +0800
liujie5@linkdatatechnology.com wrote:

>  
> -struct sxe2_drv_queue_caps {
> +struct __rte_aligned(4) __rte_packed_begin sxe2_drv_queue_caps {
>  	uint16_t queues_cnt;
>  	uint16_t base_idx_in_pf;
> -};
> +} __rte_packed_end;

I don't see the point of packed and aligned. This structure is already embedded
in other struct. The alignment will be right.
Packed should be reserved for where you are avoiding padding.

Bottom line: drivers should not use packed except for hardware registers,
network headers.  You probably could just use existing structures here
and elsewhere; with static_assert() added in the vector code to make
sure future changes don't break assumptions.

> diff --git a/drivers/net/sxe2/sxe2_ethdev.c b/drivers/net/sxe2/sxe2_ethdev.c
> index 8d66e5d8c5..e0f7002138 100644
> --- a/drivers/net/sxe2/sxe2_ethdev.c
> +++ b/drivers/net/sxe2/sxe2_ethdev.c
> @@ -891,7 +891,7 @@ static int32_t sxe2_eth_pmd_probe_pf(struct sxe2_common_device *cdev,
>  static int32_t sxe2_parse_eth_devargs(struct rte_device *dev,
>  			  struct rte_eth_devargs *eth_da)
>  {
> -	int ret = 0;
> +	int32_t ret = 0;
>  
>  	if (dev->devargs == NULL)
>  		return 0;

Hmm. This raises the question why did sxe2 clone the model from other drivers using vdpa
but change the return to int32_t.

I think you are making things unnecessarily complex here:

$ git grep probe_t | grep int
drivers/bus/auxiliary/bus_auxiliary_driver.h:typedef int (rte_auxiliary_probe_t)(struct rte_auxiliary_driver *drv,
drivers/bus/cdx/bus_cdx_driver.h:typedef int (rte_cdx_probe_t)(struct rte_cdx_driver *, struct rte_cdx_device *);
drivers/bus/dpaa/bus_dpaa_driver.h:typedef int (*rte_dpaa_probe_t)(struct rte_dpaa_driver *dpaa_drv,
drivers/bus/fslmc/bus_fslmc_driver.h:typedef int (*rte_dpaa2_probe_t)(struct rte_dpaa2_driver *dpaa2_drv,
drivers/bus/ifpga/bus_ifpga_driver.h:typedef int (afu_probe_t)(struct rte_afu_device *);
drivers/bus/pci/bus_pci_driver.h:typedef int (rte_pci_probe_t)(struct rte_pci_driver *, struct rte_pci_device *);
drivers/bus/platform/bus_platform_driver.h:typedef int (rte_platform_probe_t)(struct rte_platform_device *pdev);
drivers/bus/uacce/bus_uacce_driver.h:typedef int (rte_uacce_probe_t)(struct rte_uacce_driver *, struct rte_uacce_device *);
drivers/bus/vdev/bus_vdev_driver.h:typedef int (rte_vdev_probe_t)(struct rte_vdev_device *dev);
drivers/bus/vmbus/bus_vmbus_driver.h:typedef int (vmbus_probe_t)(struct rte_vmbus_driver *,
drivers/common/mlx5/mlx5_common.h:typedef int (mlx5_class_driver_probe_t)(struct mlx5_common_device *cdev,
drivers/common/nfp/nfp_common_pci.h:typedef int (nfp_class_driver_probe_t)(struct rte_pci_device *dev);
drivers/common/sxe2/sxe2_common.h:typedef int32_t (sxe2_class_driver_probe_t)(struct sxe2_common_device *scdev,
lib/eal/include/bus_driver.h:typedef int (*rte_bus_probe_t)(struct rte_bus *bus);

No other driver uses int32...

> @@ -315,19 +370,30 @@ static const struct {
>  	eth_rx_burst_t rx_burst;
>  	const char *info;
>  } sxe2_rx_burst_infos[] = {
> -	{ sxe2_rx_pkts_scattered,          "Scalar Scattered" },
> -	{ sxe2_rx_pkts_scattered_split,          "Scalar Scattered split" },
> +	{ sxe2_rx_pkts_scattered,
> +	      "Scalar Scattered" },
> +	{ sxe2_rx_pkts_scattered_split,
> +	      "Scalar Scattered split" },
>  #ifdef RTE_ARCH_X86
> -	{ sxe2_rx_pkts_scattered_vec_sse_offload,      "Vector SSE Scattered" },
> +#ifdef CC_AVX512_SUPPORT
> +	{ sxe2_rx_pkts_scattered_vec_avx512,
> +	      "Vector AVX512 Scattered" },
> +	{ sxe2_rx_pkts_scattered_vec_avx512_offload,
> +	      "Offload Vector AVX512 Scattered" },
> +#endif
> +	{ sxe2_rx_pkts_scattered_vec_sse_offload,
> +	      "Vector SSE Scattered" },
>  #endif
>  };

The table looked better before with longer lines.
The DPDK coding style allows lines up to 100 characters; why not use it

>  int32_t sxe2_rx_burst_mode_get(struct rte_eth_dev *dev,
> -			__rte_unused uint16_t queue_id, struct rte_eth_burst_mode *mode)
> +			       __rte_unused uint16_t queue_id,
> +			       struct rte_eth_burst_mode *mode)
>  {
>  	eth_rx_burst_t pkt_burst = dev->rx_pkt_burst;
>  	int32_t ret = -EINVAL;
>  	uint32_t i, size;
> +
>  	size = RTE_DIM(sxe2_rx_burst_infos);
>  	for (i = 0; i < size; ++i) {
>  		if (pkt_burst == sxe2_rx_burst_infos[i].rx_burst) {

The old code was fine, no need to change this. Either indentation style is OK.
Prefer not to have non-related changes.


> +static __rte_always_inline void
> +sxe2_tx_pkts_mbuf_fill_avx512(struct sxe2_tx_buffer_vec *buffer,
> +	struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
> +{

Please only use always_inline where it is absolutely necessary.
Dont fight with the compiler.

> +static __rte_always_inline int32_t sxe2_tx_bufs_free_vec_avx512(struct sxe2_tx_queue *txq)
> +{
> +	struct sxe2_tx_buffer_vec *buffer;
> +	struct rte_mbuf *mbuf;
> +	struct rte_mbuf *mbuf_free_arr[SXE2_TX_FREE_BUFFER_SIZE_MAX_VEC];
> +	struct rte_mempool *mp;
> +	struct rte_mempool_cache *cache;
> +	void **cache_objs;
> +	uint32_t copied;
> +	uint32_t i;
> +	int32_t ret;
> +	uint16_t rs_thresh;
> +	uint16_t free_num;
> +
> +	if (rte_cpu_to_le_64(SXE2_TX_DESC_DTYPE_DESC_DONE) !=
> +		(txq->desc_ring[txq->next_dd].wb.dd &
> +			rte_cpu_to_le_64(SXE2_TX_DESC_DTYPE_MASK))) {
> +		ret = 0;
> +		goto l_end;
> +	}
> +
> +	rs_thresh = txq->rs_thresh;
> +
> +	buffer = (struct sxe2_tx_buffer_vec *)txq->buffer_ring;
> +	buffer += txq->next_dd - (rs_thresh - 1);
> +
> +	if ((txq->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) &&
> +			(rs_thresh & 31) == 0) {
> +		mp = buffer[0].mbuf->pool;
> +		cache = rte_mempool_default_cache(mp, rte_lcore_id());
> +
> +		if (cache == NULL || cache->len)
> +			goto normal;
> +
> +		if (rs_thresh > RTE_MEMPOOL_CACHE_MAX_SIZE) {
> +			(void)rte_mempool_ops_enqueue_bulk(mp, (void *)buffer, rs_thresh);
> +			goto done;
> +		}
> +		cache_objs = &cache->objs[cache->len];

Directly using cache is going to be brittle and likely get broken by other
coming changes to mempool cache.

