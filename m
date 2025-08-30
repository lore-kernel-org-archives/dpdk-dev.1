Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E53CA0EFF
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 Aug 2025 19:52:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B4724029E;
	Sat, 30 Aug 2025 21:52:48 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 4488B40276
 for <dev@dpdk.org>; Sat, 30 Aug 2025 21:52:47 +0200 (CEST)
Received: from debian (unknown [78.109.76.115])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 209AFE027F;
 Sat, 30 Aug 2025 23:52:46 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 209AFE027F
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1756583566;
 bh=Wv+hKuv8Jd1l63P1oCzN/94ze45h7ujnYfg22qKCNO8=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=b0AlVOo/TvdOtPcC+UmTafBAH8Wn2kmbzr92sT48PAw5I2WfiVf8KCo9mNGjRVh/J
 UXeLyzXirvb39e1gQkeMt+DjhK4D7//qO07Rl8+3LeU3KYpc4lKbU9cGbOnKg6rLzW
 kQu4C+5PFkZ7UZ4gPr4EeN1nPivFUouyFKBeSw+FgHIGg6Eat+Ygdm5IzrDePN/CzX
 GvKKrx2C2LyGC6tXbRkOb+4Em8fS4mQjLizDdgyqSUre/2KMeYS9HDQyKaQ3sq9nw6
 s1C2WWnFkNuLhMDy9HWQblqe2PPybJbU10hMW1xuZo4apFAv51IrS3X1gG1xh0ydW+
 MBs0dDYNU1dPA==
Date: Sat, 30 Aug 2025 23:52:38 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
cc: dev@dpdk.org, bruce.richardson@intel.com, anatoly.burakov@intel.com, 
 thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru, 
 stephen@networkplumber.org
Subject: Re: [RFC PATCH 1/6] ethdev: extend and refactor DCB configuration
In-Reply-To: <20250830171706.428977-2-vladimir.medvedkin@intel.com>
Message-ID: <5ace1139-ed01-dfe5-91ef-d96f1626b7f6@arknetworks.am>
References: <20250830171706.428977-1-vladimir.medvedkin@intel.com>
 <20250830171706.428977-2-vladimir.medvedkin@intel.com>
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

> Currently there are two structutes defined for DCB configuration, one for

Typo: structuRes.

> RX and one for TX. They do have slight semantic difference, but in terms
> of their structure they are identical. Refactor DCB configuration API to
> use common structute for both TX and RX.
>
> Additionally, current structure do not reflect everything that is
> required by the DCB specification, such as per Traffic Class bandwidth
> allocation and Traffic Selection Algorithm (TSA). Extend rte_eth_dcb_conf
> with additional DCB settings
>
> Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> ---
> app/test-pmd/testpmd.c             | 19 ++++++-
> drivers/net/intel/ice/ice_ethdev.c | 80 ++++++++++++++++++++----------
> lib/ethdev/rte_ethdev.h            | 25 ++++++----
> 3 files changed, 85 insertions(+), 39 deletions(-)
>
> diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
> index bb88555328..d64a7dcac5 100644
> --- a/app/test-pmd/testpmd.c
> +++ b/app/test-pmd/testpmd.c
> @@ -4134,9 +4134,9 @@ get_eth_dcb_conf(struct rte_eth_conf *eth_conf, enum dcb_mode_enable dcb_mode,
> 					(rx_mq_mode & RTE_ETH_MQ_RX_VMDQ_DCB);
> 		eth_conf->txmode.mq_mode = RTE_ETH_MQ_TX_VMDQ_DCB;
> 	} else {
> -		struct rte_eth_dcb_rx_conf *rx_conf =
> +		struct rte_eth_dcb_conf *rx_conf =
> 				&eth_conf->rx_adv_conf.dcb_rx_conf;
> -		struct rte_eth_dcb_tx_conf *tx_conf =
> +		struct rte_eth_dcb_conf *tx_conf =
> 				&eth_conf->tx_adv_conf.dcb_tx_conf;
>
> 		rx_conf->nb_tcs = num_tcs;
> @@ -4148,6 +4148,21 @@ get_eth_dcb_conf(struct rte_eth_conf *eth_conf, enum dcb_mode_enable dcb_mode,
> 			tx_conf->dcb_tc[i] = dcb_tc_val;
> 		}
>
> +		const int bw_share_percent = 100 / num_tcs;
> +		const int bw_share_left = 100 - bw_share_percent * num_tcs;
> +		for (i = 0; i < num_tcs; i++) {
> +			rx_conf->dcb_tc_bw[i] = bw_share_percent;
> +			tx_conf->dcb_tc_bw[i] = bw_share_percent;
> +
> +			rx_conf->dcb_tsa[i] = RTE_ETH_DCB_TSA_ETS;
> +			tx_conf->dcb_tsa[i] = RTE_ETH_DCB_TSA_ETS;
> +		}
> +
> +		for (i = 0; i < bw_share_left; i++) {
> +			rx_conf->dcb_tc_bw[i]++;
> +			tx_conf->dcb_tc_bw[i]++;
> +		}

A brief comment would make the purpose clearer.

> +
> 		eth_conf->rxmode.mq_mode =
> 				(enum rte_eth_rx_mq_mode)
> 					(rx_mq_mode & RTE_ETH_MQ_RX_DCB_RSS);
> diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
> index 8ab0da3549..7ba25049d7 100644
> --- a/drivers/net/intel/ice/ice_ethdev.c
> +++ b/drivers/net/intel/ice/ice_ethdev.c
> @@ -3760,10 +3760,13 @@ static int ice_init_rss(struct ice_pf *pf)
> }
>
> static int
> -check_dcb_conf(int is_8_ports, struct rte_eth_dcb_rx_conf *dcb_conf)
> +check_dcb_conf(int is_8_ports, struct rte_eth_dcb_conf *dcb_conf)
> {
> 	uint32_t tc_map = 0;
> 	int i;
> +	int total_bw_allocated = 0;
> +	bool ets_seen = false;
> +	int nb_tc_used;
>
> 	enum rte_eth_nb_tcs nb_tcs = dcb_conf->nb_tcs;
> 	if (nb_tcs != RTE_ETH_4_TCS && is_8_ports) {
> @@ -3784,7 +3787,31 @@ check_dcb_conf(int is_8_ports, struct rte_eth_dcb_rx_conf *dcb_conf)
> 		return -1;
> 	}
>
> -	return rte_popcount32(tc_map);
> +	nb_tc_used = rte_popcount32(tc_map);
> +
> +	/* calculate total ETS Bandwidth allocation */
> +	for (i = 0; i < nb_tc_used; i++) {
> +		if (dcb_conf->dcb_tsa[i] == RTE_ETH_DCB_TSA_ETS) {
> +			if (dcb_conf->dcb_tc_bw[i] == 0) {
> +				PMD_DRV_LOG(ERR,
> +					"Bad ETS BW configuration, can not allocate 0%%");
> +				return -1;
> +			}
> +			total_bw_allocated += dcb_conf->dcb_tc_bw[i];
> +			ets_seen = true;
> +		} else if (dcb_conf->dcb_tsa[i] != RTE_ETH_DCB_TSA_STRICT) {
> +			PMD_DRV_LOG(ERR, "Invalid TC TSA setting - only Strict and ETS are supported");
> +			return -1;
> +		}
> +	}
> +
> +	/* total ETS BW allocation must add up to 100% */
> +	if (ets_seen && total_bw_allocated != 100) {
> +		PMD_DRV_LOG(ERR, "Invalid TC Bandwidth allocation configuration");
> +		return -1;
> +	}
> +
> +	return nb_tc_used;
> }
>
> static int
> @@ -3819,15 +3846,22 @@ ice_dev_configure(struct rte_eth_dev *dev)
> 		struct ice_qos_cfg *qos_cfg = &port_info->qos_cfg;
> 		struct ice_dcbx_cfg *local_dcb_conf = &qos_cfg->local_dcbx_cfg;
> 		struct ice_vsi_ctx ctxt;
> -		struct rte_eth_dcb_rx_conf *dcb_conf = &dev->data->dev_conf.rx_adv_conf.dcb_rx_conf;
> +		struct rte_eth_dcb_conf *rx_dcb_conf =
> +			&dev->data->dev_conf.rx_adv_conf.dcb_rx_conf;
> +		struct rte_eth_dcb_conf *tx_dcb_conf =
> +			&dev->data->dev_conf.tx_adv_conf.dcb_tx_conf;
> 		int i;
> -		enum rte_eth_nb_tcs nb_tcs = dcb_conf->nb_tcs;
> -		int nb_tc_used, queues_per_tc;
> +		enum rte_eth_nb_tcs nb_tcs = rx_dcb_conf->nb_tcs;
> +		int nb_tc_used_rx, nb_tc_used_tx, queues_per_tc;
> 		uint16_t total_q_nb;
>
> -		nb_tc_used = check_dcb_conf(ice_get_port_max_cgd(hw) == ICE_4_CGD_PER_PORT,
> -			dcb_conf);
> -		if (nb_tc_used < 0)
> +		nb_tc_used_rx = check_dcb_conf(ice_get_port_max_cgd(hw) == ICE_4_CGD_PER_PORT,
> +			rx_dcb_conf);
> +		if (nb_tc_used_rx < 0)
> +			return -EINVAL;
> +		nb_tc_used_tx = check_dcb_conf(ice_get_port_max_cgd(hw) == ICE_4_CGD_PER_PORT,
> +			tx_dcb_conf);
> +		if (nb_tc_used_tx < 0)
> 			return -EINVAL;
>
> 		ctxt.info = vsi->info;
> @@ -3837,8 +3871,8 @@ ice_dev_configure(struct rte_eth_dev *dev)
> 		}
>
> 		total_q_nb = dev->data->nb_rx_queues;
> -		queues_per_tc = total_q_nb / nb_tc_used;
> -		if (total_q_nb % nb_tc_used != 0) {
> +		queues_per_tc = total_q_nb / nb_tc_used_rx;
> +		if (total_q_nb % nb_tc_used_rx != 0) {
> 			PMD_DRV_LOG(ERR, "For DCB, number of queues must be evenly divisble by number of used TCs");
> 			return -EINVAL;
> 		} else if (!rte_is_power_of_2(queues_per_tc)) {
> @@ -3846,7 +3880,7 @@ ice_dev_configure(struct rte_eth_dev *dev)
> 			return -EINVAL;
> 		}
>
> -		for (i = 0; i < nb_tc_used; i++) {
> +		for (i = 0; i < nb_tc_used_rx; i++) {
> 			ctxt.info.tc_mapping[i] =
> 				rte_cpu_to_le_16(((i * queues_per_tc) << ICE_AQ_VSI_TC_Q_OFFSET_S) |
> 					(rte_log2_u32(queues_per_tc) << ICE_AQ_VSI_TC_Q_NUM_S));
> @@ -3858,29 +3892,21 @@ ice_dev_configure(struct rte_eth_dev *dev)
>
> 		/* Associate each VLAN UP with particular TC */
> 		for (i = 0; i < ICE_MAX_TRAFFIC_CLASS; i++) {
> -			local_dcb_conf->etscfg.prio_table[i] = dcb_conf->dcb_tc[i];
> -			local_dcb_conf->etsrec.prio_table[i] = dcb_conf->dcb_tc[i];
> +			local_dcb_conf->etscfg.prio_table[i] = rx_dcb_conf->dcb_tc[i];
> +			local_dcb_conf->etsrec.prio_table[i] = tx_dcb_conf->dcb_tc[i];
> 		}
>
> -		/*
> -		 * Since current API does not support setting ETS BW Share and Scheduler
> -		 * configure all TC as ETS and evenly share load across all existing TC
> -		 **/
> -		const int bw_share_percent = 100 / nb_tc_used;
> -		const int bw_share_left = 100 - bw_share_percent * nb_tc_used;
> -		for (i = 0; i < nb_tc_used; i++) {
> +		for (i = 0; i < nb_tc_used_rx; i++) {
> 			/* Per TC bandwidth table (all valued must add up to 100%), valid on ETS */
> -			local_dcb_conf->etscfg.tcbwtable[i] = bw_share_percent;
> -			local_dcb_conf->etsrec.tcbwtable[i] = bw_share_percent;
> +			local_dcb_conf->etscfg.tcbwtable[i] = rx_dcb_conf->dcb_tc_bw[i];
>
> 			/**< Transmission Selection Algorithm. 0 - Strict prio, 2 - ETS */
> -			local_dcb_conf->etscfg.tsatable[i] = 2;
> -			local_dcb_conf->etsrec.tsatable[i] = 2;
> +			local_dcb_conf->etscfg.tsatable[i] = rx_dcb_conf->dcb_tsa[i];
> 		}
>
> -		for (i = 0; i < bw_share_left; i++) {
> -			local_dcb_conf->etscfg.tcbwtable[i]++;
> -			local_dcb_conf->etsrec.tcbwtable[i]++;
> +		for (i = 0; i < nb_tc_used_tx; i++) {
> +			local_dcb_conf->etsrec.tcbwtable[i] = tx_dcb_conf->dcb_tc_bw[i];
> +			local_dcb_conf->etsrec.tsatable[i] = tx_dcb_conf->dcb_tsa[i];
> 		}
>
> 		local_dcb_conf->pfc.pfccap = nb_tcs;
> diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
> index f9fb6ae549..13b1a41d3b 100644
> --- a/lib/ethdev/rte_ethdev.h
> +++ b/lib/ethdev/rte_ethdev.h
> @@ -853,6 +853,7 @@ rte_eth_rss_hf_refine(uint64_t rss_hf)
> /**@{@name VMDq and DCB maximums */
> #define RTE_ETH_VMDQ_MAX_VLAN_FILTERS   64 /**< Maximum nb. of VMDq VLAN filters. */
> #define RTE_ETH_DCB_NUM_USER_PRIORITIES 8  /**< Maximum nb. of DCB priorities. */
> +#define RTE_ETH_DCB_NUM_TCS	 8 /**< Maximum nb. of DCB traffic classes. */
> #define RTE_ETH_VMDQ_DCB_NUM_QUEUES     128 /**< Maximum nb. of VMDq DCB queues. */
> #define RTE_ETH_DCB_NUM_QUEUES          128 /**< Maximum nb. of DCB queues. */
> /**@}*/
> @@ -929,11 +930,21 @@ enum rte_eth_nb_pools {
> 	RTE_ETH_64_POOLS = 64   /**< 64 VMDq pools. */
> };
>
> +#define RTE_ETH_DCB_TSA_STRICT	0
> +#define RTE_ETH_DCB_TSA_ETS	2

Why not enum?

> +
> /* This structure may be extended in future. */
> -struct rte_eth_dcb_rx_conf {
> +struct rte_eth_dcb_conf {
> 	enum rte_eth_nb_tcs nb_tcs; /**< Possible DCB TCs, 4 or 8 TCs */
> -	/** Traffic class each UP mapped to. */
> +	/** Traffic class each UP mapped to.

Perhaps keep '/**' on a separate line in a multi-line comment.

Thank you.

> +	 *  Rx packets VLAN UP for Rx configuration
> +	 *  Rx PFC Pause frames UP for Tx configuration
> +	 */
> 	uint8_t dcb_tc[RTE_ETH_DCB_NUM_USER_PRIORITIES];
> +	/** Traffic class selector algorithm */
> +	uint8_t dcb_tsa[RTE_ETH_DCB_NUM_TCS];
> +	/** Traffic class relative bandwidth in percents */
> +	uint8_t dcb_tc_bw[RTE_ETH_DCB_NUM_TCS];
> };
>
> struct rte_eth_vmdq_dcb_tx_conf {
> @@ -942,12 +953,6 @@ struct rte_eth_vmdq_dcb_tx_conf {
> 	uint8_t dcb_tc[RTE_ETH_DCB_NUM_USER_PRIORITIES];
> };
>
> -struct rte_eth_dcb_tx_conf {
> -	enum rte_eth_nb_tcs nb_tcs; /**< Possible DCB TCs, 4 or 8 TCs. */
> -	/** Traffic class each UP mapped to. */
> -	uint8_t dcb_tc[RTE_ETH_DCB_NUM_USER_PRIORITIES];
> -};
> -
> struct rte_eth_vmdq_tx_conf {
> 	enum rte_eth_nb_pools nb_queue_pools; /**< VMDq mode, 64 pools. */
> };
> @@ -1531,7 +1536,7 @@ struct rte_eth_conf {
> 		/** Port VMDq+DCB configuration. */
> 		struct rte_eth_vmdq_dcb_conf vmdq_dcb_conf;
> 		/** Port DCB Rx configuration. */
> -		struct rte_eth_dcb_rx_conf dcb_rx_conf;
> +		struct rte_eth_dcb_conf dcb_rx_conf;
> 		/** Port VMDq Rx configuration. */
> 		struct rte_eth_vmdq_rx_conf vmdq_rx_conf;
> 	} rx_adv_conf; /**< Port Rx filtering configuration. */
> @@ -1539,7 +1544,7 @@ struct rte_eth_conf {
> 		/** Port VMDq+DCB Tx configuration. */
> 		struct rte_eth_vmdq_dcb_tx_conf vmdq_dcb_tx_conf;
> 		/** Port DCB Tx configuration. */
> -		struct rte_eth_dcb_tx_conf dcb_tx_conf;
> +		struct rte_eth_dcb_conf dcb_tx_conf;
> 		/** Port VMDq Tx configuration. */
> 		struct rte_eth_vmdq_tx_conf vmdq_tx_conf;
> 	} tx_adv_conf; /**< Port Tx DCB configuration (union). */
> -- 
> 2.43.0
>
>
