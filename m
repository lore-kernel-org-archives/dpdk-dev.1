Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFCB1091929
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Mar 2026 22:43:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45146402AC;
	Thu, 19 Mar 2026 23:43:40 +0100 (CET)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mails.dpdk.org (Postfix) with ESMTP id 5D99C4013F
 for <dev@dpdk.org>; Thu, 19 Mar 2026 23:43:39 +0100 (CET)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-829ac4670c4so908964b3a.0
 for <dev@dpdk.org>; Thu, 19 Mar 2026 15:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773960218;
 x=1774565018; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WOhyvVSvqV+25/R2rsDpe52ycZd4shTJNSC8I9fuIus=;
 b=Ky1KAPiMIBymOJkxXbTtPoBOaRUMN53Dh5bktZjtboXHqUseploKdotF8HFIQ/B6QQ
 JHqwPo0c5dAWbFfKJjsxIC7rWQwHuQy5Ds3FNAGfV5J16oqC9T6i7J+ovshaJfXDMemv
 pXnY20C0Q2EZFuIz5+P2WCCsG4Xs+LkOuuKwFx+TneHpWK9XTRGm2m/iZS56W4rFRJmH
 6CakulXnl1TCXxNc18GKSvkoJPULD9CEx6eH5POPYeiaZee40e6bA0I901kPuwYQJR+V
 O0eK05Qg50gOkRmNLxR7zne6Vt6ByIw8Jmjxx7QL3FnMMj6s+FZ/iR5rye/wC5j/HOXm
 o28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773960218; x=1774565018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WOhyvVSvqV+25/R2rsDpe52ycZd4shTJNSC8I9fuIus=;
 b=aQK5asCPLnCvuaDxM/gvtGVuBpGlnngnX2psntmMbNLe/pVYrQrm6X7fHP4kwQ9kwO
 owkt2+QxdudoLN+sglNlppps2HxKsCtWgwyyAMwHcBZWNL83nTgnFVC475v4FpdyjuCe
 t7OCIlBV92QncETMPnNew1EkKlevGvCAcCDZxQzAU2lOU3npexXR+aOFKpqZMXacGilO
 W+8WLgv4OobiHVJOVL+iCODCFUgj6CrN5qi1r0Q6ga9rWqu0RoBs5cwp0FvZNPCWgM6L
 g1KCm/5zUGTxLPB7LopkUUrARAceIHIpBNCTnL6YgOu/QDIpoUm2lUpKRP6K+bMM8brD
 aBrw==
X-Gm-Message-State: AOJu0YzAhUK7lw30olcL+qE5BzXosI96M1et3Dpd4UQNJ6bYo6pC7Lvx
 H2TpUSDLQUr3aPSFsLGk8IqX4mEkHzSWWmRIItxLnHbXh68Fooedcv5/DEVc/IcjAX8=
X-Gm-Gg: ATEYQzy6RimcW5BF5S27l3wOIV0NYynoHcVc+U6ICSk4qtHx2cfJMJ03zybaATpnjIX
 V79NkgorVj/ATiaMmibgfoGR4IA9uzbQwkpnKf/W4ENc9yAiEk2GpnAZEt0FH+4Y5hOdmuZotG5
 74FqbjY8Ui4xedx6ZaiRAZSbbSJBITgOGPSSUcwu3fRphHCTTt4J1/XSaQ3ItfWq+/G5WWH2xxb
 SKYFRjuQusqAWuBmxy731WkPBLYUk5syuGYVC97Jh+qIL33BgIGOmlv2/wro1WymElBl46A78st
 besiT01hFwUInp9/fBbx/MgIu34vJOeJoFF9AS0kSsO1n0PYCq+oUiEhmcMfCdn4Ozkx3Iaec2g
 cCQIxgi0rsHdocgRbfXam3E1JiHR+upENmVB9Hm2FwHgauEQbEnDqSLa1gDeYMLmDTvEEdijyiQ
 Q2mQaP4ko9QYgKUocEXYwK5WSdDuMRDclhFGSoGwOUUVr3q+ARS78g77qQbTPWcP2b61Gsm2i+x
 ZlhbSCUIWLjO+eTc0oHow==
X-Received: by 2002:a05:6a00:23c6:b0:824:374a:1407 with SMTP id
 d2e1a72fcca58-82a8c234e03mr678061b3a.16.1773960218184; 
 Thu, 19 Mar 2026 15:43:38 -0700 (PDT)
Received: from stephen-xps.local
 (h216-87-238-89.thvror.broadband.dynamic.tds.net. [216.87.238.89])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b040db2a6sm236118b3a.50.2026.03.19.15.43.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 15:43:37 -0700 (PDT)
Date: Thu, 19 Mar 2026 15:43:35 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH dpdk] net/tap: add software MAC address filtering
Message-ID: <20260319154335.60e6406a@stephen-xps.local>
In-Reply-To: <20260319221034.703656-2-rjarry@redhat.com>
References: <20260319221034.703656-2-rjarry@redhat.com>
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

On Thu, 19 Mar 2026 23:10:35 +0100
Robin Jarry <rjarry@redhat.com> wrote:

> Linux TAP devices deliver all packets to userspace regardless of the
> PROMISC/ALLMULTI flags on the interface. Add an opt-in "macfilter"
> devarg that, when enabled, drops received packets whose destination MAC
> does not match any configured unicast or multicast address.
> 
> When macfilter is active the receive path checks the destination MAC
> against the device's unicast address table (managed by the ethdev
> layer), the multicast address list (stored by the driver since the
> ethdev layer does not keep a copy), and accepts broadcast
> unconditionally. Promiscuous and all-multicast modes bypass the
> respective checks.
> 
> To support multiple unicast addresses via rte_eth_dev_mac_addr_add(),
> allocate mac_addrs with rte_zmalloc (TAP_MAX_MAC_ADDRS=16) instead of
> pointing into dev_private, and advertise the new limit in dev_infos_get.
> 
> Dropped packets are reported via per-queue xstats
> (rx_q<N>_mac_filter_drops).
> 
> Signed-off-by: Robin Jarry <rjarry@redhat.com>
> ---
>  drivers/net/tap/rte_eth_tap.c | 178 ++++++++++++++++++++++++++++++----
>  drivers/net/tap/rte_eth_tap.h |   7 ++
>  2 files changed, 167 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
> index 13e0a23c34a1..f4ea3bc5d160 100644
> --- a/drivers/net/tap/rte_eth_tap.c
> +++ b/drivers/net/tap/rte_eth_tap.c
> @@ -53,11 +53,14 @@
>  #define ETH_TAP_MAC_ARG         "mac"
>  #define ETH_TAP_MAC_FIXED       "fixed"
>  #define ETH_TAP_PERSIST_ARG     "persist"
> +#define ETH_TAP_MAC_FILTER_ARG  "macfilter"
>  
>  #define ETH_TAP_USR_MAC_FMT     "xx:xx:xx:xx:xx:xx"
>  #define ETH_TAP_CMP_MAC_FMT     "0123456789ABCDEFabcdef"
>  #define ETH_TAP_MAC_ARG_FMT     ETH_TAP_MAC_FIXED "|" ETH_TAP_USR_MAC_FMT
>  
> +#define TAP_MAX_MAC_ADDRS	16
> +
>  #define TAP_GSO_MBUFS_PER_CORE	128
>  #define TAP_GSO_MBUF_SEG_SIZE	128
>  #define TAP_GSO_MBUF_CACHE_SIZE	4
> @@ -110,6 +113,7 @@ static const char *valid_arguments[] = {
>  	ETH_TAP_REMOTE_ARG,
>  	ETH_TAP_MAC_ARG,
>  	ETH_TAP_PERSIST_ARG,
> +	ETH_TAP_MAC_FILTER_ARG,
>  	NULL
>  };
>  
> @@ -437,6 +441,45 @@ tap_rxq_pool_free(struct rte_mbuf *pool)
>  	rte_pktmbuf_free(pool);
>  }
>  
> +static inline bool
> +tap_mac_filter_match(struct rx_queue *rxq, struct rte_mbuf *mbuf)
> +{
> +	struct pmd_internals *pmd = rxq->pmd;
> +	struct rte_eth_dev_data *data;
> +	struct rte_ether_addr *dst;
> +	uint32_t i;
> +
> +	if (!pmd->macfilter)
> +		return true;
> +
> +	data = pmd->dev->data;
> +	if (data->promiscuous)
> +		return true;
> +
> +	dst = rte_pktmbuf_mtod(mbuf, struct rte_ether_addr *);
> +
> +	if (rte_is_broadcast_ether_addr(dst))
> +		return true;
> +
> +	if (rte_is_multicast_ether_addr(dst)) {
> +		if (data->all_multicast)
> +			return true;
> +		for (i = 0; i < pmd->nb_mc_addrs; i++) {
> +			if (rte_is_same_ether_addr(dst, &pmd->mc_addrs[i]))
> +				return true;
> +		}
> +		return false;
> +	}
> +
> +	for (i = 0; i < TAP_MAX_MAC_ADDRS; i++) {
> +		if (rte_is_zero_ether_addr(&data->mac_addrs[i]))
> +			continue;
> +		if (rte_is_same_ether_addr(dst, &data->mac_addrs[i]))
> +			return true;
> +	}
> +	return false;
> +}
> +
>  /* Callback to handle the rx burst of packets to the correct interface and
>   * file descriptor(s) in a multi-queue setup.
>   */
> @@ -515,6 +558,13 @@ pmd_rx_burst(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
>  			data_off = 0;
>  		}
>  		seg->next = NULL;
> +
> +		if (!tap_mac_filter_match(rxq, mbuf)) {
> +			rxq->stats.mac_drops++;
> +			rte_pktmbuf_free(mbuf);
> +			continue;
> +		}
> +
>  		mbuf->packet_type = rte_net_get_ptype(mbuf, NULL,
>  						      RTE_PTYPE_ALL_MASK);
>  		if (rxq->rxmode->offloads & RTE_ETH_RX_OFFLOAD_CHECKSUM)
> @@ -933,7 +983,7 @@ tap_dev_info(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
>  	struct pmd_internals *internals = dev->data->dev_private;
>  
>  	dev_info->if_index = internals->if_index;
> -	dev_info->max_mac_addrs = 1;
> +	dev_info->max_mac_addrs = TAP_MAX_MAC_ADDRS;
>  	dev_info->max_rx_pktlen = RTE_ETHER_MAX_JUMBO_FRAME_LEN;
>  	dev_info->max_rx_queues = RTE_PMD_TAP_MAX_QUEUES;
>  	dev_info->max_tx_queues = RTE_PMD_TAP_MAX_QUEUES;
> @@ -1025,6 +1075,43 @@ tap_stats_reset(struct rte_eth_dev *dev)
>  	return 0;
>  }
>  
> +static int
> +tap_xstats_get_names(struct rte_eth_dev *dev,
> +		     struct rte_eth_xstat_name *names,
> +		     unsigned int limit __rte_unused)
> +{
> +	unsigned int i;
> +
> +	if (names == NULL)
> +		return dev->data->nb_rx_queues;
> +
> +	for (i = 0; i < dev->data->nb_rx_queues; i++)
> +		snprintf(names[i].name, sizeof(names[i].name),
> +			 "rx_q%u_mac_filter_drops", i);
> +
> +	return dev->data->nb_rx_queues;
> +}
> +
> +static int
> +tap_xstats_get(struct rte_eth_dev *dev, struct rte_eth_xstat *xstats,
> +	       unsigned int n)
> +{
> +	struct rte_eth_dev_data *data = dev->data;
> +	struct rx_queue *rxq;
> +	unsigned int i;
> +
> +	if (n < dev->data->nb_rx_queues)
> +		return dev->data->nb_rx_queues;
> +
> +	for (i = 0; i < dev->data->nb_rx_queues; i++) {
> +		rxq = data->rx_queues[i];
> +		xstats[i].id = i;
> +		xstats[i].value = rxq->stats.mac_drops;
> +	}
> +
> +	return dev->data->nb_rx_queues;
> +}
> +
>  static void
>  tap_queue_close(struct pmd_process_private *process_private, uint16_t qid)
>  {
> @@ -1089,14 +1176,15 @@ tap_dev_close(struct rte_eth_dev *dev)
>  	rte_mempool_free(internals->gso_ctx_mp);
>  	internals->gso_ctx_mp = NULL;
>  
> +	rte_free(internals->mc_addrs);
> +	internals->mc_addrs = NULL;
> +	internals->nb_mc_addrs = 0;
> +
>  	if (internals->ka_fd != -1) {
>  		close(internals->ka_fd);
>  		internals->ka_fd = -1;
>  	}
>  
> -	/* mac_addrs must not be freed alone because part of dev_private */
> -	dev->data->mac_addrs = NULL;
> -
>  	internals = dev->data->dev_private;
>  	TAP_LOG(DEBUG, "Closing %s Ethernet device on numa %u",
>  		tuntap_types[internals->type], rte_socket_id());
> @@ -1574,6 +1662,7 @@ tap_rx_queue_setup(struct rte_eth_dev *dev,
>  	}
>  	tmp = &rxq->pool;
>  
> +	rxq->pmd = internals;
>  	rxq->mp = mp;
>  	rxq->trigger_seen = 1; /* force initial burst */
>  	rxq->in_port = dev->data->port_id;
> @@ -1692,17 +1781,50 @@ tap_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
>  }
>  
>  static int
> -tap_set_mc_addr_list(struct rte_eth_dev *dev __rte_unused,
> -		     struct rte_ether_addr *mc_addr_set __rte_unused,
> -		     uint32_t nb_mc_addr __rte_unused)
> +tap_set_mc_addr_list(struct rte_eth_dev *dev,
> +		     struct rte_ether_addr *mc_addr_set,
> +		     uint32_t nb_mc_addr)
>  {
> -	/*
> -	 * Nothing to do actually: the tap has no filtering whatsoever, every
> -	 * packet is received.
> -	 */
> +	struct pmd_internals *pmd = dev->data->dev_private;
> +
> +	if (nb_mc_addr == 0) {
> +		rte_free(pmd->mc_addrs);
> +		pmd->mc_addrs = NULL;
> +		pmd->nb_mc_addrs = 0;
> +		return 0;
> +	}
> +
> +	pmd->mc_addrs = rte_realloc(pmd->mc_addrs,
> +				    nb_mc_addr * sizeof(*pmd->mc_addrs), 0);
> +	if (pmd->mc_addrs == NULL) {
> +		pmd->nb_mc_addrs = 0;
> +		return -ENOMEM;
> +	}
> +
> +	memcpy(pmd->mc_addrs, mc_addr_set,
> +	       nb_mc_addr * sizeof(*pmd->mc_addrs));
> +	pmd->nb_mc_addrs = nb_mc_addr;
> +
>  	return 0;
>  }
>  
> +static int
> +tap_mac_addr_add(struct rte_eth_dev *dev __rte_unused,
> +		 struct rte_ether_addr *mac_addr __rte_unused,
> +		 uint32_t index __rte_unused,
> +		 uint32_t vmdq __rte_unused)
> +{
> +	/* ethdev layer already stores the address in mac_addrs[] */
> +	return 0;
> +}
> +
> +static void
> +tap_mac_addr_remove(struct rte_eth_dev *dev __rte_unused,
> +		    uint32_t index __rte_unused)
> +{
> +	/* ethdev layer already zeroes the slot in mac_addrs[] */
> +}
> +
>  static void tap_dev_intr_handler(void *cb_arg);
>  static int tap_lsc_intr_handle_set(struct rte_eth_dev *dev, int set);
>  
> @@ -2038,10 +2160,15 @@ static const struct eth_dev_ops ops = {
>  	.allmulticast_enable    = tap_allmulti_enable,
>  	.allmulticast_disable   = tap_allmulti_disable,
>  	.mac_addr_set           = tap_mac_set,
> +	.mac_addr_add           = tap_mac_addr_add,
> +	.mac_addr_remove        = tap_mac_addr_remove,
>  	.mtu_set                = tap_mtu_set,
>  	.set_mc_addr_list       = tap_set_mc_addr_list,
>  	.stats_get              = tap_stats_get,
>  	.stats_reset            = tap_stats_reset,
> +	.xstats_get             = tap_xstats_get,
> +	.xstats_get_names       = tap_xstats_get_names,
> +	.xstats_reset           = tap_stats_reset,
>  	.dev_supported_ptypes_get = tap_dev_supported_ptypes_get,
>  	.rss_hash_update        = tap_rss_hash_update,
>  #ifdef HAVE_TCA_FLOWER
> @@ -2052,7 +2179,7 @@ static const struct eth_dev_ops ops = {
>  static int
>  eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
>  		   const char *remote_iface, struct rte_ether_addr *mac_addr,
> -		   enum rte_tuntap_type type, int persist)
> +		   enum rte_tuntap_type type, int persist, int macfilter)
>  {
>  	int numa_node = rte_socket_id();
>  	struct rte_eth_dev *dev;
> @@ -2102,7 +2229,14 @@ eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
>  	data->numa_node = numa_node;
>  
>  	data->dev_link = pmd_link;
> -	data->mac_addrs = &pmd->eth_addr;
> +	data->mac_addrs = rte_zmalloc_socket(rte_vdev_device_name(vdev),
> +					     TAP_MAX_MAC_ADDRS *
> +					     sizeof(struct rte_ether_addr),
> +					     0, numa_node);
> +	if (data->mac_addrs == NULL) {
> +		TAP_LOG(ERR, "Failed to allocate mac_addrs");
> +		goto error_exit;
> +	}
>  	/* Set the number of RX and TX queues */
>  	data->nb_rx_queues = 0;
>  	data->nb_tx_queues = 0;
> @@ -2120,6 +2254,8 @@ eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
>  		process_private->fds[i] = -1;
>  
>  
> +	pmd->macfilter = macfilter;
> +
>  	if (pmd->type == ETH_TUNTAP_TYPE_TAP) {
>  		if (rte_is_zero_ether_addr(mac_addr))
>  			rte_eth_random_addr((uint8_t *)&pmd->eth_addr);
> @@ -2227,6 +2363,9 @@ eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
>  	}
>  #endif
>  
> +	/* Copy final MAC to slot 0 (remote path may have overwritten it) */
> +	data->mac_addrs[0] = pmd->eth_addr;
> +
>  	rte_eth_dev_probing_finish(dev);
>  	return 0;
>  
> @@ -2246,8 +2385,6 @@ eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
>  	free(dev->process_private);
>  
>  error_exit_nodev_release:
> -	/* mac_addrs must not be freed alone because part of dev_private */
> -	dev->data->mac_addrs = NULL;
>  	rte_eth_dev_release_port(dev);
>  
>  error_exit_nodev:
> @@ -2405,7 +2542,7 @@ rte_pmd_tun_probe(struct rte_vdev_device *dev)
>  	TAP_LOG(DEBUG, "Initializing pmd_tun for %s", name);
>  
>  	ret = eth_dev_tap_create(dev, tun_name, remote_iface, 0,
> -				 ETH_TUNTAP_TYPE_TUN, 0);
> +				 ETH_TUNTAP_TYPE_TUN, 0, 0);
>  
>  leave:
>  	if (ret == -1) {
> @@ -2529,6 +2666,7 @@ rte_pmd_tap_probe(struct rte_vdev_device *dev)
>  	struct rte_eth_dev *eth_dev;
>  	int tap_devices_count_increased = 0;
>  	int persist = 0;
> +	int macfilter = 0;
>  
>  	name = rte_vdev_device_name(dev);
>  	params = rte_vdev_device_args(dev);
> @@ -2617,6 +2755,9 @@ rte_pmd_tap_probe(struct rte_vdev_device *dev)
>  
>  			if (rte_kvargs_count(kvlist, ETH_TAP_PERSIST_ARG) == 1)
>  				persist = 1;
> +
> +			if (rte_kvargs_count(kvlist, ETH_TAP_MAC_FILTER_ARG) == 1)
> +				macfilter = 1;
>  		}
>  	}
>  
> @@ -2634,7 +2775,7 @@ rte_pmd_tap_probe(struct rte_vdev_device *dev)
>  	tap_devices_count++;
>  	tap_devices_count_increased = 1;
>  	ret = eth_dev_tap_create(dev, tap_name, remote_iface, &user_mac,
> -				 ETH_TUNTAP_TYPE_TAP, persist);
> +				 ETH_TUNTAP_TYPE_TAP, persist, macfilter);
>  
>  leave:
>  	if (ret == -1) {
> @@ -2687,5 +2828,6 @@ RTE_PMD_REGISTER_PARAM_STRING(net_tun,
>  RTE_PMD_REGISTER_PARAM_STRING(net_tap,
>  			      ETH_TAP_IFACE_ARG "=<string> "
>  			      ETH_TAP_MAC_ARG "=" ETH_TAP_MAC_ARG_FMT " "
> -			      ETH_TAP_REMOTE_ARG "=<string>");
> +			      ETH_TAP_REMOTE_ARG "=<string> "
> +			      ETH_TAP_MAC_FILTER_ARG "=<int>");
>  RTE_LOG_REGISTER_DEFAULT(tap_logtype, NOTICE);
> diff --git a/drivers/net/tap/rte_eth_tap.h b/drivers/net/tap/rte_eth_tap.h
> index b44eaf9a1bdb..dd65b33bf351 100644
> --- a/drivers/net/tap/rte_eth_tap.h
> +++ b/drivers/net/tap/rte_eth_tap.h
> @@ -38,9 +38,13 @@ struct queue_stats {
>  	uint64_t packets;
>  	uint64_t bytes;
>  	uint64_t errors;
> +	uint64_t mac_drops;             /* Packets dropped by MAC filter */
>  };
>  
> +struct pmd_internals;
> +
>  struct rx_queue {
> +	struct pmd_internals *pmd;      /* back-pointer to driver state */
>  	struct rte_mempool *mp;         /* Mempool for RX packets */
>  	uint32_t trigger_seen;          /* Last seen Rx trigger value */
>  	uint16_t in_port;               /* Port ID */
> @@ -69,7 +73,10 @@ struct pmd_internals {
>  	char name[IFNAMSIZ];		  /* Internal Tap device name */
>  	int type;                         /* Type field - TUN|TAP */
>  	int persist;			  /* 1 if keep link up, else 0 */
> +	int macfilter;                    /* SW MAC filtering enabled */
>  	struct rte_ether_addr eth_addr;   /* Mac address of the device port */
> +	struct rte_ether_addr *mc_addrs;  /* multicast address list */
> +	uint32_t nb_mc_addrs;             /* multicast address count */
>  	unsigned int remote_initial_flags;/* Remote netdevice flags on init */
>  	int remote_if_index;              /* remote netdevice IF_INDEX */
>  	int if_index;                     /* IF_INDEX for the port */

TAP should just always do it. TAP should behave like a real NIC.
Flags should be uint8_t of bool not int.
