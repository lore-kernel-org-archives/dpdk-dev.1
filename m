Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1ACCA0EFF
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 Aug 2025 20:46:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C103140276;
	Sat, 30 Aug 2025 22:46:15 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 8F8F040262
 for <dev@dpdk.org>; Sat, 30 Aug 2025 22:46:14 +0200 (CEST)
Received: from debian (unknown [78.109.76.115])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 51EDFE0689;
 Sun, 31 Aug 2025 00:46:13 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 51EDFE0689
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1756586774;
 bh=Ma38dBwPXWgZb9UudsIiT3XioAn0j4K2vzxGVwEuDQ4=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=GXf1kzEgzLN5TWYCeMNIabU9lJAqE0m4YursaBsdoNW0DQbktOka/dmIhTqzap68P
 5Clz3c9z0miwu5m9Su7JtgvAhPkN216O5g1eJ4DWd9VfK4umfjLzxsGTkaBEB3ila6
 IjaL+9sRWUewV5ijLpgUh+msYi4Iqk/UlGdwZKKdFiYMWFmNozhvVcPfO9iHZ2bkyY
 pIl31yUMvDgfDXQNift1G5LnczOpnaJcOszxoiBFQ7Y8a/l2p3TDLcQoqJj/wm2YMd
 3rDoVXEqQAsuQIylPGOkkM5LoOTmKVwerMbZuuJX2ZuSDvUzwv+EO9Jzx0g5lNDyWg
 V4eUv5Y6KW/ww==
Date: Sun, 31 Aug 2025 00:46:11 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
cc: dev@dpdk.org, bruce.richardson@intel.com, anatoly.burakov@intel.com, 
 thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru, 
 stephen@networkplumber.org
Subject: Re: [RFC PATCH 5/6] ethdev: remove dcb_capability_en from rte_eth_conf
In-Reply-To: <20250830171706.428977-6-vladimir.medvedkin@intel.com>
Message-ID: <28ac3aa1-bf43-e21f-5433-1c2ecbdc01f7@arknetworks.am>
References: <20250830171706.428977-1-vladimir.medvedkin@intel.com>
 <20250830171706.428977-6-vladimir.medvedkin@intel.com>
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

> Currently there are DCB configuration capability flags that are suppose

Typo: supposeD.

> to enable DCB Priority Groups (aka Traffic Classes), and Priority Flow
> Control. The former is not used anywhere at all, while the latter us used

Typo: Is used.

> in some drivers, but is used to enable PFC on all existing Traffic
> Classes, which feels like a questionable design choice.
>
> It is recommended to use existing API to enable PFC on specific Traffic
> Class.
>
> Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> ---
> app/test-pmd/cmdline.c  | 19 +++----------------
> app/test-pmd/testpmd.c  | 12 ++----------
> app/test-pmd/testpmd.h  |  1 -
> lib/ethdev/rte_ethdev.h |  8 --------
> 4 files changed, 5 insertions(+), 35 deletions(-)
>
> diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
> index 82322f3456..346dd7c133 100644
> --- a/app/test-pmd/cmdline.c
> +++ b/app/test-pmd/cmdline.c
> @@ -3526,7 +3526,6 @@ parse_dcb_token_find(char *split_str[], int split_num, int *param_num)
>
> static int
> parse_dcb_token_value(char *token_str,
> -		      uint8_t *pfc_en,
> 		      uint8_t prio_tc[RTE_ETH_DCB_NUM_USER_PRIORITIES],
> 		      uint8_t *prio_tc_en,
> 		      uint8_t *keep_qnum)
> @@ -3549,17 +3548,6 @@ parse_dcb_token_value(char *token_str,
> 		split_str[split_num++] = token;
> 	} while (1);
>
> -	/* parse fixed parameter "pfc-en" first. */
> -	token = split_str[0];
> -	if (strcmp(token, "on") == 0)
> -		*pfc_en = 1;
> -	else if (strcmp(token, "off") == 0)
> -		*pfc_en = 0;
> -	else {
> -		fprintf(stderr, "Bad Argument: pfc-en must be on or off\n");
> -		return -EINVAL;
> -	}
> -
> 	if (split_num == 1)
> 		return 0;
>
> @@ -3612,7 +3600,6 @@ cmd_config_dcb_parsed(void *parsed_result,
> 	uint8_t prio_tc_en = 0;
> 	uint8_t keep_qnum = 0;
> 	struct rte_port *port;
> -	uint8_t pfc_en = 0;
> 	int ret;
>
> 	if (port_id_is_invalid(port_id, ENABLED_WARN))
> @@ -3644,7 +3631,7 @@ cmd_config_dcb_parsed(void *parsed_result,
> 		return;
> 	}
>
> -	ret = parse_dcb_token_value(res->token_str, &pfc_en, prio_tc, &prio_tc_en, &keep_qnum);
> +	ret = parse_dcb_token_value(res->token_str, prio_tc, &prio_tc_en, &keep_qnum);
> 	if (ret != 0)
> 		return;
>
> @@ -3652,11 +3639,11 @@ cmd_config_dcb_parsed(void *parsed_result,
> 	if (!strncmp(res->vt_en, "on", 2))
> 		ret = init_port_dcb_config(port_id, DCB_VT_ENABLED,
> 				(int)res->num_tcs,
> -				pfc_en, prio_tc, prio_tc_en, keep_qnum);
> +				prio_tc, prio_tc_en, keep_qnum);
> 	else
> 		ret = init_port_dcb_config(port_id, DCB_ENABLED,
> 				(int)res->num_tcs,
> -				pfc_en, prio_tc, prio_tc_en, keep_qnum);
> +				prio_tc, prio_tc_en, keep_qnum);
> 	if (ret != 0) {
> 		fprintf(stderr, "Cannot initialize network ports.\n");
> 		return;
> diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
> index 3a55434d44..8602781aac 100644
> --- a/app/test-pmd/testpmd.c
> +++ b/app/test-pmd/testpmd.c
> @@ -4093,8 +4093,7 @@ const uint16_t vlan_tags[] = {
>
> static void
> get_eth_dcb_conf(struct rte_eth_conf *eth_conf, enum dcb_mode_enable dcb_mode,
> -		 int num_tcs, uint8_t pfc_en,
> -		 uint8_t prio_tc[RTE_ETH_DCB_NUM_USER_PRIORITIES], uint8_t prio_tc_en)
> +		 int num_tcs, uint8_t prio_tc[RTE_ETH_DCB_NUM_USER_PRIORITIES], uint8_t prio_tc_en)
> {
> 	uint8_t dcb_tc_val, i;
>
> @@ -4195,11 +4194,6 @@ get_eth_dcb_conf(struct rte_eth_conf *eth_conf, enum dcb_mode_enable dcb_mode,
> 		eth_conf->txmode.mq_mode = RTE_ETH_MQ_TX_DCB;
> 	}
>
> -	if (pfc_en)
> -		eth_conf->dcb_capability_en =
> -				RTE_ETH_DCB_PG_SUPPORT | RTE_ETH_DCB_PFC_SUPPORT;
> -	else
> -		eth_conf->dcb_capability_en = RTE_ETH_DCB_PG_SUPPORT;
> }
>
> static void
> @@ -4209,7 +4203,6 @@ clear_eth_dcb_conf(portid_t pid, struct rte_eth_conf *eth_conf)
>
> 	eth_conf->rxmode.mq_mode &= ~(RTE_ETH_MQ_RX_DCB | RTE_ETH_MQ_RX_VMDQ_DCB);
> 	eth_conf->txmode.mq_mode = RTE_ETH_MQ_TX_NONE;
> -	eth_conf->dcb_capability_en = 0;
> 	if (dcb_config) {
> 		/* Unset VLAN filter configuration if already config DCB. */
> 		eth_conf->rxmode.offloads &= ~RTE_ETH_RX_OFFLOAD_VLAN_FILTER;
> @@ -4222,7 +4215,6 @@ int
> init_port_dcb_config(portid_t pid,
> 		     enum dcb_mode_enable dcb_mode,
> 		     int num_tcs,
> -		     uint8_t pfc_en,
> 		     uint8_t prio_tc[RTE_ETH_DCB_NUM_USER_PRIORITIES],
> 		     uint8_t prio_tc_en,
> 		     uint8_t keep_qnum)
> @@ -4267,7 +4259,7 @@ init_port_dcb_config(portid_t pid,
>
> 	if (num_tcs > 1) {
> 		/* set configuration of DCB in vt mode and DCB in non-vt mode */
> -		get_eth_dcb_conf(&port_conf, dcb_mode, num_tcs, pfc_en, prio_tc, prio_tc_en);
> +		get_eth_dcb_conf(&port_conf, dcb_mode, num_tcs, prio_tc, prio_tc_en);
> 		port_conf.rxmode.offloads |= RTE_ETH_RX_OFFLOAD_VLAN_FILTER;
> 		/* remove RSS HASH offload for DCB in vt mode */
> 		if (port_conf.rxmode.mq_mode == RTE_ETH_MQ_RX_VMDQ_DCB) {
> diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
> index 4ff982ed3f..bb1aaec918 100644
> --- a/app/test-pmd/testpmd.h
> +++ b/app/test-pmd/testpmd.h
> @@ -1151,7 +1151,6 @@ uint8_t port_is_bonding_member(portid_t member_pid);
>
> int init_port_dcb_config(portid_t pid, enum dcb_mode_enable dcb_mode,
> 		     int num_tcs,
> -		     uint8_t pfc_en,
> 		     uint8_t prio_tc[RTE_ETH_DCB_NUM_USER_PRIORITIES],
> 		     uint8_t prio_tc_en,
> 		     uint8_t keep_qnum);
> diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
> index 0bd86e1e7d..60532e0155 100644
> --- a/lib/ethdev/rte_ethdev.h
> +++ b/lib/ethdev/rte_ethdev.h
> @@ -858,11 +858,6 @@ rte_eth_rss_hf_refine(uint64_t rss_hf)
> #define RTE_ETH_DCB_NUM_QUEUES          128 /**< Maximum nb. of DCB queues. */
> /**@}*/
>
> -/**@{@name DCB capabilities */
> -#define RTE_ETH_DCB_PG_SUPPORT      RTE_BIT32(0) /**< Priority Group(ETS) support. */
> -#define RTE_ETH_DCB_PFC_SUPPORT     RTE_BIT32(1) /**< Priority Flow Control support. */

I apologise in case I misunderstand something, but this seems to be used in
https://github.com/DPDK/dpdk/blob/b222395561638f89562e4ef42e1eabf2d6db43dd/drivers/net/txgbe/txgbe_rxtx.c#L3830
https://github.com/DPDK/dpdk/blob/b222395561638f89562e4ef42e1eabf2d6db43dd/drivers/net/intel/ixgbe/ixgbe_rxtx.c#L4475
https://github.com/DPDK/dpdk/blob/b222395561638f89562e4ef42e1eabf2d6db43dd/drivers/net/intel/i40e/i40e_ethdev.c#L10715
https://github.com/DPDK/dpdk/blob/b222395561638f89562e4ef42e1eabf2d6db43dd/drivers/net/hns3/hns3_ethdev_vf.c#L525
https://github.com/DPDK/dpdk/blob/b222395561638f89562e4ef42e1eabf2d6db43dd/drivers/net/hns3/hns3_dcb.c#L1510

Or is this applied on top of something that has already removed those?

Thank you.

> -/**@}*/
> -
> /**@{@name VLAN offload bits */
> #define RTE_ETH_VLAN_STRIP_OFFLOAD   0x0001 /**< VLAN Strip  On/Off */
> #define RTE_ETH_VLAN_FILTER_OFFLOAD  0x0002 /**< VLAN Filter On/Off */
> @@ -1528,9 +1523,6 @@ struct rte_eth_conf {
> 		struct rte_eth_vmdq_tx_conf vmdq_tx_conf;
> 		/* VMDQ and DCB Tx queue mapping configuration. */
> 	} tx_adv_conf; /**< Port Tx DCB configuration (union). */
> -	/** Currently,Priority Flow Control(PFC) are supported,if DCB with PFC
> -	    is needed,and the variable must be set RTE_ETH_DCB_PFC_SUPPORT. */
> -	uint32_t dcb_capability_en;
> 	struct rte_eth_intr_conf intr_conf; /**< Interrupt mode configuration. */
> };
>
> -- 
> 2.43.0
>
>
