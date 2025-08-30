Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73FECA0FFD
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 Aug 2025 20:36:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BCB5840276;
	Sat, 30 Aug 2025 22:36:14 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id E36BF40262
 for <dev@dpdk.org>; Sat, 30 Aug 2025 22:36:12 +0200 (CEST)
Received: from debian (unknown [78.109.76.115])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 23EFBE0689;
 Sun, 31 Aug 2025 00:36:11 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 23EFBE0689
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1756586171;
 bh=jogNClwungZMGtfyZFOjiXmU7uqLiDYAXBjBjZI5kbg=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=NRtAZ5iIiQ+IclGmxCNPjvKJY5MaoqDiaAiw2hsug2pEwCO6mMIaZwUFjcqYWvxVe
 F7PYAlbBcqRPHAwLygS/VvKI9Aa9Kvad6I2tOHCIfQF7tK8tRPT0YQWGmN2+xGqfOH
 +JOxWkXF6nsjqItOAPhxy75UKM8NHL7jZYymAXAcaakC0LHxu/5jgFR3tucmbxCMbi
 JHevMqoyoLWKHXEcfdyAgqowNRS0pnEeI/TQhs8Z+Xk0EwOJaHWOFqjIQZuE0xRS00
 wK+AbOqrHqZ6TYRWXLbDWHl8TjajXoBd4zw72oi8tdrpNoJtQ3jbZQD2npje8V7Nhg
 fJsXnoziPKb/w==
Date: Sun, 31 Aug 2025 00:36:09 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
cc: dev@dpdk.org, bruce.richardson@intel.com, anatoly.burakov@intel.com, 
 thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru, 
 stephen@networkplumber.org
Subject: Re: [RFC PATCH 4/6] ethdev: extend VMDq/DCB configuration with queue
 mapping
In-Reply-To: <20250830171706.428977-5-vladimir.medvedkin@intel.com>
Message-ID: <e9910cf9-ebc7-861a-2f30-791309416011@arknetworks.am>
References: <20250830171706.428977-1-vladimir.medvedkin@intel.com>
 <20250830171706.428977-5-vladimir.medvedkin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

Hi Vladimir,

On Sat, 30 Aug 2025, Vladimir Medvedkin wrote:

> Currently DCB Traffic Class queue mapping is only used when calling get
> DCB info API, while setting up queue mappings is up to each individual
> driver. Use the tc queue mapping structure to enable setting up custom
> mapping explicitly.
>
> Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> ---
> app/test-pmd/testpmd.c             | 57 ++++++++++++++++++------------
> drivers/net/intel/ice/ice_ethdev.c | 39 ++++++++++----------
> drivers/net/intel/ice/ice_rxtx.c   | 27 +++++++-------
> lib/ethdev/rte_ethdev.h            | 43 +++++++++++-----------
> 4 files changed, 92 insertions(+), 74 deletions(-)
>
> diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
> index b5a7e7b3ee..3a55434d44 100644
> --- a/app/test-pmd/testpmd.c
> +++ b/app/test-pmd/testpmd.c
> @@ -4158,6 +4158,16 @@ get_eth_dcb_conf(struct rte_eth_conf *eth_conf, enum dcb_mode_enable dcb_mode,
> 		struct rte_eth_dcb_conf *tx_conf =
> 				&eth_conf->tx_adv_conf.dcb_tx_conf;
>
> +		struct rte_eth_dcb_tc_queue_mapping *q_map = &eth_conf->q_map;
> +		memset(q_map, 0, sizeof(*q_map));
> +		int queues_per_tc = nb_rxq / num_tcs;
> +		for (i = 0; i < num_tcs; i++) {
> +			q_map->tc_rxq[0][i].base = i * queues_per_tc;
> +			q_map->tc_txq[0][i].base = i * queues_per_tc;
> +			q_map->tc_rxq[0][i].nb_queue = queues_per_tc;
> +			q_map->tc_txq[0][i].nb_queue = queues_per_tc;
> +		}
> +
> 		for (i = 0; i < RTE_ETH_DCB_NUM_USER_PRIORITIES; i++) {
> 			dcb_tc_val = prio_tc_en ? prio_tc[i] : i % num_tcs;
> 			rx_conf->dcb_tc[i] = dcb_tc_val;
> @@ -4231,6 +4241,30 @@ init_port_dcb_config(portid_t pid,
> 	/* retain the original device configuration. */
> 	memcpy(&port_conf, &rte_port->dev_conf, sizeof(struct rte_eth_conf));
>
> +	if (num_tcs > 1 && keep_qnum == 0) {
> +		/* Assume the ports in testpmd have the same dcb capability
> +		 * and has the same number of rxq and txq in dcb mode
> +		 */
> +		if (dcb_mode == DCB_VT_ENABLED) {
> +			if (rte_port->dev_info.max_vfs > 0) {
> +				nb_rxq = rte_port->dev_info.nb_rx_queues;
> +				nb_txq = rte_port->dev_info.nb_tx_queues;
> +			} else {
> +				nb_rxq = rte_port->dev_info.max_rx_queues;
> +				nb_txq = rte_port->dev_info.max_tx_queues;
> +			}
> +		} else {
> +			/*if vt is disabled, use all pf queues */

Missing space between '/*' and 'if'.

> +			if (rte_port->dev_info.vmdq_pool_base == 0) {
> +				nb_rxq = rte_port->dev_info.max_rx_queues;
> +				nb_txq = rte_port->dev_info.max_tx_queues;
> +			} else {
> +				nb_rxq = (queueid_t)num_tcs;
> +				nb_txq = (queueid_t)num_tcs;
> +			}
> +		}
> +	}
> +
> 	if (num_tcs > 1) {
> 		/* set configuration of DCB in vt mode and DCB in non-vt mode */
> 		get_eth_dcb_conf(&port_conf, dcb_mode, num_tcs, pfc_en, prio_tc, prio_tc_en);
> @@ -4267,29 +4301,6 @@ init_port_dcb_config(portid_t pid,
> 		return -1;
> 	}
>
> -	if (num_tcs > 1 && keep_qnum == 0) {
> -		/* Assume the ports in testpmd have the same dcb capability
> -		 * and has the same number of rxq and txq in dcb mode
> -		 */
> -		if (dcb_mode == DCB_VT_ENABLED) {
> -			if (rte_port->dev_info.max_vfs > 0) {
> -				nb_rxq = rte_port->dev_info.nb_rx_queues;
> -				nb_txq = rte_port->dev_info.nb_tx_queues;
> -			} else {
> -				nb_rxq = rte_port->dev_info.max_rx_queues;
> -				nb_txq = rte_port->dev_info.max_tx_queues;
> -			}
> -		} else {
> -			/*if vt is disabled, use all pf queues */
> -			if (rte_port->dev_info.vmdq_pool_base == 0) {
> -				nb_rxq = rte_port->dev_info.max_rx_queues;
> -				nb_txq = rte_port->dev_info.max_tx_queues;
> -			} else {
> -				nb_rxq = (queueid_t)num_tcs;
> -				nb_txq = (queueid_t)num_tcs;
> -			}
> -		}
> -	}
> 	rx_free_thresh = 64;
>
> 	memcpy(&rte_port->dev_conf, &port_conf, sizeof(struct rte_eth_conf));
> diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
> index ecde00182f..27559bbe18 100644
> --- a/drivers/net/intel/ice/ice_ethdev.c
> +++ b/drivers/net/intel/ice/ice_ethdev.c
> @@ -3846,7 +3846,7 @@ ice_dev_configure(struct rte_eth_dev *dev)
> 		struct rte_eth_dcb_conf *tx_dcb_conf =
> 			&dev->data->dev_conf.tx_adv_conf.dcb_tx_conf;
> 		int i;
> -		int nb_tc_used_rx, nb_tc_used_tx, queues_per_tc;
> +		int nb_tc_used_rx, nb_tc_used_tx;
> 		uint16_t total_q_nb;
>
> 		nb_tc_used_rx = check_dcb_conf(ice_get_port_max_cgd(hw) == ICE_4_CGD_PER_PORT,
> @@ -3865,19 +3865,23 @@ ice_dev_configure(struct rte_eth_dev *dev)
> 		}
>
> 		total_q_nb = dev->data->nb_rx_queues;
> -		queues_per_tc = total_q_nb / nb_tc_used_rx;
> -		if (total_q_nb % nb_tc_used_rx != 0) {
> -			PMD_DRV_LOG(ERR, "For DCB, number of queues must be evenly divisble by number of used TCs");
> -			return -EINVAL;
> -		} else if (!rte_is_power_of_2(queues_per_tc)) {
> -			PMD_DRV_LOG(ERR, "For DCB, number of queues per TC must be a power of 2");
> -			return -EINVAL;
> -		}
> -
> +		struct rte_eth_dcb_tc_queue_mapping *q_map = &dev->data->dev_conf.q_map;
> 		for (i = 0; i < nb_tc_used_rx; i++) {
> +			if (q_map->tc_rxq[0][i].nb_queue != 0 &&

How is 'nb_queue == 0' case handled here and below? Should some driver-default
fill-in be used, similar to code being deleted above?

Or is '(0 << ICE_AQ_VSI_TC_Q_OFFSET_S) | (0 << ICE_AQ_VSI_TC_Q_NUM_S)' legit?

> +					!rte_is_power_of_2(q_map->tc_rxq[0][i].nb_queue)) {
> +				PMD_DRV_LOG(ERR, "For DCB, number of queues per TC must be a power of 2");
> +				return -EINVAL;
> +			}
> +			if ((q_map->tc_rxq[0][i].base + q_map->tc_rxq[0][i].nb_queue) > total_q_nb) {
> +				PMD_DRV_LOG(ERR, "Queue range for TC %d exceeds total number of queues",
> +					i);
> +				return -EINVAL;
> +			}
> 			ctxt.info.tc_mapping[i] =
> -				rte_cpu_to_le_16(((i * queues_per_tc) << ICE_AQ_VSI_TC_Q_OFFSET_S) |
> -					(rte_log2_u32(queues_per_tc) << ICE_AQ_VSI_TC_Q_NUM_S));
> +				rte_cpu_to_le_16((q_map->tc_rxq[0][i].base <<
> +					ICE_AQ_VSI_TC_Q_OFFSET_S) |
> +					(rte_log2_u32(q_map->tc_rxq[0][i].nb_queue) <<
> +					ICE_AQ_VSI_TC_Q_NUM_S));

This seems to always use pool [0] but does not seem to check if 'nb_queue' in,
say, pool [1] is non-zero, to return an error or something. Or is this unneeded?

> 		}
>
> 		memset(local_dcb_conf, 0, sizeof(*local_dcb_conf));
> @@ -3941,6 +3945,7 @@ ice_get_dcb_info(struct rte_eth_dev *dev, struct rte_eth_dcb_info *dcb_info)
> 	struct ice_dcbx_cfg *dcb_conf = &qos_cfg->local_dcbx_cfg;
> 	struct ice_vsi *vsi = pf->main_vsi;
> 	struct ice_vsi_ctx ctxt = { 0 };
> +	struct rte_eth_dcb_tc_queue_mapping *q_map = &dev->data->dev_conf.q_map;
>
> 	ctxt.info = vsi->info;
> 	if (rte_le_to_cpu_16(ctxt.info.mapping_flags) == ICE_AQ_VSI_Q_MAP_NONCONTIG) {
> @@ -3953,13 +3958,11 @@ ice_get_dcb_info(struct rte_eth_dev *dev, struct rte_eth_dcb_info *dcb_info)
> 		dcb_info->prio_tc[i] = dcb_conf->etscfg.prio_table[i];
> 		dcb_info->tc_bws[i] = dcb_conf->etscfg.tcbwtable[i];
> 		/* Using VMDQ pool zero since DCB+VMDQ is not supported */
> -		uint16_t tc_rx_q_map = rte_le_to_cpu_16(ctxt.info.tc_mapping[i]);
> -		dcb_info->tc_queue.tc_rxq[0][i].base = tc_rx_q_map & ICE_AQ_VSI_TC_Q_OFFSET_M;
> -		dcb_info->tc_queue.tc_rxq[0][i].nb_queue =
> -			1 << ((tc_rx_q_map & ICE_AQ_VSI_TC_Q_NUM_M) >> ICE_AQ_VSI_TC_Q_NUM_S);
> +		dcb_info->tc_queue.tc_rxq[0][i].base = q_map->tc_rxq[0][i].base;
> +		dcb_info->tc_queue.tc_rxq[0][i].nb_queue = q_map->tc_rxq[0][i].nb_queue;
>
> -		dcb_info->tc_queue.tc_txq[0][i].base = dcb_info->tc_queue.tc_rxq[0][i].base;
> -		dcb_info->tc_queue.tc_txq[0][i].nb_queue = dcb_info->tc_queue.tc_rxq[0][i].nb_queue;
> +		dcb_info->tc_queue.tc_txq[0][i].base = q_map->tc_txq[0][i].base;
> +		dcb_info->tc_queue.tc_txq[0][i].nb_queue = q_map->tc_txq[0][i].nb_queue;
> 	}
>
> 	return 0;
> diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
> index 451816affd..55424e7a23 100644
> --- a/drivers/net/intel/ice/ice_rxtx.c
> +++ b/drivers/net/intel/ice/ice_rxtx.c
> @@ -796,6 +796,7 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
> 	int buf_len;
> 	struct ice_adapter *ad = ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
> 	u16 q_base, q_range, cgd_idx = 0;
> +	struct rte_eth_dcb_tc_queue_mapping *q_map = &dev->data->dev_conf.q_map;
>
> 	PMD_INIT_FUNC_TRACE();
>
> @@ -840,22 +841,22 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
> 	tx_ctx.legacy_int = 1; /* Legacy or Advanced Host Interface */
> 	tx_ctx.tsyn_ena = 1;
>
> -	/* Mirror RXQ<->CGD association to TXQ<->CDG */
> -	for (int i = 0; i < ICE_MAX_TRAFFIC_CLASS; i++) {
> -		q_base = rte_le_to_cpu_16(vsi->info.tc_mapping[i]) & ICE_AQ_VSI_TC_Q_OFFSET_M;
> -		q_range = 1 << ((rte_le_to_cpu_16(vsi->info.tc_mapping[i]) &
> -			ICE_AQ_VSI_TC_Q_NUM_M) >> ICE_AQ_VSI_TC_Q_NUM_S);
> +	if (dev->data->dev_conf.txmode.mq_mode == RTE_ETH_MQ_TX_DCB) {
> +		for (int i = 0; i < ICE_MAX_TRAFFIC_CLASS; i++) {
> +			q_base = q_map->tc_txq[0][i].base;
> +			q_range = q_map->tc_txq[0][i].nb_queue;
>
> -		if (q_base <= tx_queue_id && tx_queue_id < q_base + q_range)
> -			break;
> +			if (q_base <= tx_queue_id && tx_queue_id < q_base + q_range)
> +				break;
>
> -		cgd_idx++;
> -	}
> +			cgd_idx++;
> +		}
>
> -	if (cgd_idx >= ICE_MAX_TRAFFIC_CLASS) {
> -		PMD_DRV_LOG(ERR, "Bad queue mapping configuration");
> -		rte_free(txq_elem);
> -		return -EINVAL;
> +		if (cgd_idx >= ICE_MAX_TRAFFIC_CLASS) {
> +			PMD_DRV_LOG(ERR, "Bad queue mapping configuration");
> +			rte_free(txq_elem);
> +			return -EINVAL;
> +		}
> 	}
>
> 	tx_ctx.cgd_num = cgd_idx;
> diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
> index c220760043..0bd86e1e7d 100644
> --- a/lib/ethdev/rte_ethdev.h
> +++ b/lib/ethdev/rte_ethdev.h
> @@ -1472,6 +1472,26 @@ struct rte_eth_intr_conf {
>
> #define rte_intr_conf rte_eth_intr_conf
>
> +#define RTE_ETH_DCB_NUM_TCS    8
> +#define RTE_ETH_MAX_VMDQ_POOL  64
> +
> +/**
> + * A structure used to get the information of queue and
> + * TC mapping on both Tx and Rx paths.
> + */
> +struct rte_eth_dcb_tc_queue_mapping {
> +	/** Rx queues assigned to tc per Pool */
> +	struct {
> +		uint16_t base;
> +		uint16_t nb_queue;
> +	} tc_rxq[RTE_ETH_MAX_VMDQ_POOL][RTE_ETH_DCB_NUM_TCS];
> +	/** Rx queues assigned to tc per Pool */
> +	struct {
> +		uint16_t base;
> +		uint16_t nb_queue;
> +	} tc_txq[RTE_ETH_MAX_VMDQ_POOL][RTE_ETH_DCB_NUM_TCS];
> +};
> +
> /**
>  * A structure used to configure an Ethernet port.
>  * Depending upon the Rx multi-queue mode, extra advanced
> @@ -1492,18 +1512,21 @@ struct rte_eth_conf {
> 				 Read the datasheet of given Ethernet controller
> 				 for details. The possible values of this field
> 				 are defined in implementation of each driver. */
> +	struct rte_eth_dcb_tc_queue_mapping q_map;

Is the driver supposed to tell 'q_map' is valid by looking at [0][0] 'nb_queue'?

> 	struct {
> 		struct rte_eth_rss_conf rss_conf; /**< Port RSS configuration */
> 		/** Port DCB Rx configuration. */
> 		struct rte_eth_dcb_conf dcb_rx_conf;
> 		/** Port VMDq Rx configuration. */
> 		struct rte_eth_vmdq_rx_conf vmdq_rx_conf;
> +		/* VMDQ and DCB Rx queue mapping configuration. */

Perhaps it's better to have just one such comment right before 'q_map'.

Thank you.

> 	} rx_adv_conf; /**< Port Rx filtering configuration. */
> 	struct {
> 		/** Port DCB Tx configuration. */
> 		struct rte_eth_dcb_conf dcb_tx_conf;
> 		/** Port VMDq Tx configuration. */
> 		struct rte_eth_vmdq_tx_conf vmdq_tx_conf;
> +		/* VMDQ and DCB Tx queue mapping configuration. */
> 	} tx_adv_conf; /**< Port Tx DCB configuration (union). */
> 	/** Currently,Priority Flow Control(PFC) are supported,if DCB with PFC
> 	    is needed,and the variable must be set RTE_ETH_DCB_PFC_SUPPORT. */
> @@ -1930,26 +1953,6 @@ struct rte_eth_xstat_name {
> 	char name[RTE_ETH_XSTATS_NAME_SIZE]; /**< The statistic name. */
> };
>
> -#define RTE_ETH_DCB_NUM_TCS    8
> -#define RTE_ETH_MAX_VMDQ_POOL  64
> -
> -/**
> - * A structure used to get the information of queue and
> - * TC mapping on both Tx and Rx paths.
> - */
> -struct rte_eth_dcb_tc_queue_mapping {
> -	/** Rx queues assigned to tc per Pool */
> -	struct {
> -		uint16_t base;
> -		uint16_t nb_queue;
> -	} tc_rxq[RTE_ETH_MAX_VMDQ_POOL][RTE_ETH_DCB_NUM_TCS];
> -	/** Rx queues assigned to tc per Pool */
> -	struct {
> -		uint16_t base;
> -		uint16_t nb_queue;
> -	} tc_txq[RTE_ETH_MAX_VMDQ_POOL][RTE_ETH_DCB_NUM_TCS];
> -};
> -
> /**
>  * A structure used to get the information of DCB.
>  * It includes TC UP mapping and queue TC mapping.
> -- 
> 2.43.0
>
>
