Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4504EC87FCA
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Jul 2025 15:26:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4EDA7402A8;
	Fri, 25 Jul 2025 17:26:43 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 84B4540144
 for <dev@dpdk.org>; Fri, 25 Jul 2025 17:26:41 +0200 (CEST)
Received: from debian (unknown [78.109.66.179])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 1E8B4E03AE;
 Fri, 25 Jul 2025 19:26:40 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 1E8B4E03AE
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1753457200;
 bh=LTjb0l3/yrk6o3HA7Dmqcs3uWITcRLkJvFik7tufJyQ=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=7g5jEt+MZIDWwKwzWzTtnG+wdm+oLvssMH/erdRQTiM1gElxvEFBm7KMcl5i6oAM5
 ZS5h3SSvL26drDRxwSPXg3BjSGiv8EbZTjufd1MobDo6e60z8EH1rqs9pH+4uhqOaE
 d4oitIyOt/pfrJb2mXQCD3tEK7MKigUCSQdJU6XXFny91DOnzybRJ838NnKKFMShL0
 kxih05cyw/zirlGSJ5vPByiNWaZVT8CMcMOd7JS71GYy9cWo54Tvy8lqu7Qrfyrikr
 cIyTBLGuEF/ZJser9HacFVaK1wDaxprc1IZlMwTgPUz2LMxlkBjvoB4wuzMG0ON/hA
 aPZe1elag3uKw==
Date: Fri, 25 Jul 2025 19:26:31 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: Jie Liu <liujie5@linkdatatechnology.com>
cc: stephen@networkplumber.org, dev@dpdk.org
Subject: Re: [PATCH v11 07/13] net/sxe: support rss offload
In-Reply-To: <20250725104855.73326-7-liujie5@linkdatatechnology.com>
Message-ID: <f6ac4e9d-617f-8968-6332-52f435bdc2ea@arknetworks.am>
References: <20250719090537.699357-14-liujie5@linkdatatechnology.com>
 <20250725104855.73326-1-liujie5@linkdatatechnology.com>
 <20250725104855.73326-7-liujie5@linkdatatechnology.com>
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

Hi,

(please see below)

On Fri, 25 Jul 2025, Jie Liu wrote:

> Support rss offload.
>
> Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
> ---
> drivers/net/sxe/base/sxe_offload_common.c |  11 +-
> drivers/net/sxe/pf/sxe_offload.c          | 299 ++++++++++++++++++++++
> drivers/net/sxe/pf/sxe_offload.h          |  33 +++
> 3 files changed, 338 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/sxe/base/sxe_offload_common.c b/drivers/net/sxe/base/sxe_offload_common.c
> index 9c4ffd3b86..780681a994 100644
> --- a/drivers/net/sxe/base/sxe_offload_common.c
> +++ b/drivers/net/sxe/base/sxe_offload_common.c
> @@ -22,15 +22,16 @@ u64 __sxe_rx_port_offload_capa_get(struct rte_eth_dev *dev)
> 	u64 rx_offload_capa;
>
> 	rx_offload_capa = RTE_ETH_RX_OFFLOAD_IPV4_CKSUM  |
> -		   RTE_ETH_RX_OFFLOAD_UDP_CKSUM   |
> -		   RTE_ETH_RX_OFFLOAD_TCP_CKSUM   |
> -		   RTE_ETH_RX_OFFLOAD_KEEP_CRC	|

Why not fix the indentation in one of the original/previous patch, to avoid
these changes?

> +			RTE_ETH_RX_OFFLOAD_UDP_CKSUM   |
> +			RTE_ETH_RX_OFFLOAD_TCP_CKSUM   |
> +			RTE_ETH_RX_OFFLOAD_KEEP_CRC	|
> #ifdef DEV_RX_JUMBO_FRAME
> -		   DEV_RX_OFFLOAD_JUMBO_FRAME |
> +			DEV_RX_OFFLOAD_JUMBO_FRAME |
> #endif
> 			RTE_ETH_RX_OFFLOAD_VLAN_FILTER |
> 			RTE_ETH_RX_OFFLOAD_VLAN_EXTEND |
> -		   RTE_ETH_RX_OFFLOAD_SCATTER;
> +			RTE_ETH_RX_OFFLOAD_SCATTER |
> +			RTE_ETH_RX_OFFLOAD_RSS_HASH;
>
> 	if (!RTE_ETH_DEV_SRIOV(dev).active)
> 		rx_offload_capa |= RTE_ETH_RX_OFFLOAD_TCP_LRO;
> diff --git a/drivers/net/sxe/pf/sxe_offload.c b/drivers/net/sxe/pf/sxe_offload.c
> index 0fa3f4822a..d34cf7ecc8 100644
> --- a/drivers/net/sxe/pf/sxe_offload.c
> +++ b/drivers/net/sxe/pf/sxe_offload.c
> @@ -9,11 +9,26 @@
> #include "sxe_queue_common.h"
> #include "sxe_offload_common.h"
>
> +static u8 rss_sxe_key[40] = {

Const?

> +	0x6D, 0x5A, 0x56, 0xDA, 0x25, 0x5B, 0x0E, 0xC2,
> +	0x41, 0x67, 0x25, 0x3D, 0x43, 0xA3, 0x8F, 0xB0,
> +	0xD0, 0xCA, 0x2B, 0xCB, 0xAE, 0x7B, 0x30, 0xB4,
> +	0x77, 0xCB, 0x2D, 0xA3, 0x80, 0x30, 0xF2, 0x0C,
> +	0x6A, 0x42, 0xB7, 0x3B, 0xBE, 0xAC, 0x01, 0xFA,
> +};
> +
> #define SXE_4_BIT_WIDTH  (CHAR_BIT / 2)
> #define SXE_4_BIT_MASK   RTE_LEN2MASK(SXE_4_BIT_WIDTH, u8)
> #define SXE_8_BIT_WIDTH  CHAR_BIT
> #define SXE_8_BIT_MASK   UINT8_MAX
>
> +#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_FILTER_CTRL
> +u8 *sxe_rss_hash_key_get(void)

Is this unused in the driver?

> +{
> +	return rss_sxe_key;
> +}
> +#endif
> +
> u64 sxe_rx_queue_offload_capa_get(struct rte_eth_dev *dev)
> {
> 	return __sxe_rx_queue_offload_capa_get(dev);
> @@ -35,3 +50,287 @@ u64 sxe_tx_port_offload_capa_get(struct rte_eth_dev *dev)
> {
> 	return __sxe_tx_port_offload_capa_get(dev);
> }
> +
> +void sxe_rss_disable(struct rte_eth_dev *dev)
> +{
> +	struct sxe_adapter *adapter = dev->data->dev_private;
> +	struct sxe_hw *hw = &adapter->hw;
> +
> +	PMD_INIT_FUNC_TRACE();
> +
> +	sxe_hw_rss_cap_switch(hw, false);
> +}
> +
> +void sxe_rss_hash_set(struct sxe_hw *hw,
> +				struct rte_eth_rss_conf *rss_conf)
> +{
> +	u8  *hash_key;
> +	u32 rss_key[SXE_MAX_RSS_KEY_ENTRIES];
> +	u16 i;
> +	u64 rss_hf;
> +	u32 rss_field = 0;
> +
> +	PMD_INIT_FUNC_TRACE();
> +
> +	hash_key = rss_conf->rss_key;
> +	if (hash_key != NULL) {
> +		for (i = 0; i < SXE_MAX_RSS_KEY_ENTRIES; i++) {
> +			rss_key[i]  = hash_key[(i * 4)];
> +			rss_key[i] |= hash_key[(i * 4) + 1] << 8;
> +			rss_key[i] |= hash_key[(i * 4) + 2] << 16;
> +			rss_key[i] |= hash_key[(i * 4) + 3] << 24;

The code does not seem to check 'rss_conf->rss_key_len' to guarantee it is at
least 'SXE_MAX_RSS_KEY_ENTRIES * 4', to avoid reading past the buffer.

> +		}
> +		sxe_hw_rss_key_set_all(hw, rss_key);
> +	}
> +
> +	rss_hf = rss_conf->rss_hf;
> +	if (rss_hf & RTE_ETH_RSS_IPV4)
> +		rss_field |= SXE_MRQC_RSS_FIELD_IPV4;
> +
> +	if (rss_hf & RTE_ETH_RSS_NONFRAG_IPV4_TCP)
> +		rss_field |= SXE_MRQC_RSS_FIELD_IPV4_TCP;
> +
> +	if (rss_hf & RTE_ETH_RSS_IPV6)
> +		rss_field |= SXE_MRQC_RSS_FIELD_IPV6;
> +
> +	if (rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_TCP)
> +		rss_field |= SXE_MRQC_RSS_FIELD_IPV6_TCP;
> +
> +	if (rss_hf & RTE_ETH_RSS_NONFRAG_IPV4_UDP)
> +		rss_field |= SXE_MRQC_RSS_FIELD_IPV4_UDP;
> +
> +	if (rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_UDP)
> +		rss_field |= SXE_MRQC_RSS_FIELD_IPV6_UDP;
> +
> +	sxe_hw_rss_field_set(hw, rss_field);
> +
> +	sxe_hw_rss_cap_switch(hw, true);
> +}
> +
> +void sxe_rss_configure(struct rte_eth_dev *dev)
> +{
> +	struct rte_eth_rss_conf *rss_conf;
> +	struct sxe_adapter *adapter = dev->data->dev_private;
> +	struct sxe_hw *hw = &adapter->hw;
> +	u16 i;
> +	u16 j;
> +	u8  rss_indir_tbl[SXE_MAX_RETA_ENTRIES];
> +
> +	PMD_INIT_FUNC_TRACE();
> +
> +	if (!adapter->rss_reta_updated) {
> +		for (i = 0, j = 0; i < SXE_MAX_RETA_ENTRIES; i++, j++) {
> +			if (j == dev->data->nb_rx_queues)
> +				j = 0;
> +
> +			rss_indir_tbl[i] = j;
> +		}

Why not just
     for (i = 0; i < SXE_MAX_RETA_ENTRIES; ++i)
         rss_indir_tbl[i] = i % dev->data->nb_rx_queues;

> +
> +		sxe_hw_rss_redir_tbl_set_all(hw, rss_indir_tbl);
> +	}
> +
> +	rss_conf = &dev->data->dev_conf.rx_adv_conf.rss_conf;
> +	if ((rss_conf->rss_hf & SXE_RSS_OFFLOAD_ALL) == 0) {
> +		PMD_LOG_INFO(INIT, "user rss config match hw supports is 0");

The info message is a little confusing.

> +		sxe_rss_disable(dev);
> +		return;
> +	}
> +
> +	if (rss_conf->rss_key == NULL)
> +		rss_conf->rss_key = rss_sxe_key;

Perhaps also set 'rss_conf->rss_key_len'?

> +
> +	sxe_rss_hash_set(hw, rss_conf);
> +}
> +
> +s32 sxe_rss_reta_update(struct rte_eth_dev *dev,
> +			struct rte_eth_rss_reta_entry64 *reta_conf,
> +			u16 reta_size)
> +{
> +	u16 i;
> +	u8 j, mask;
> +	u32 reta, r;
> +	u16 idx, shift;
> +	struct sxe_adapter *adapter = dev->data->dev_private;
> +	struct rte_eth_dev_data *dev_data = dev->data;
> +	struct sxe_hw *hw = &adapter->hw;
> +	s32 ret = 0;
> +
> +	PMD_INIT_FUNC_TRACE();
> +
> +	if (!dev_data->dev_started) {
> +		PMD_LOG_ERR(DRV,
> +			"port %d must be started before rss reta update",
> +			 dev_data->port_id);

Why not memorise the table to be applied later on port start? Why deny it?

> +		ret = -EIO;
> +		goto l_end;
> +	}
> +
> +	if (reta_size != RTE_ETH_RSS_RETA_SIZE_128) {
> +		PMD_LOG_ERR(DRV, "The size of hash lookup table configured "
> +			"(%d) doesn't match the number hardware can supported "
> +			"(%d)", reta_size, RTE_ETH_RSS_RETA_SIZE_128);
> +		ret = -EINVAL;
> +		goto l_end;
> +	}
> +
> +	for (i = 0; i < reta_size; i += SXE_4_BIT_WIDTH) {
> +		idx = i / RTE_ETH_RETA_GROUP_SIZE;
> +		shift = i % RTE_ETH_RETA_GROUP_SIZE;
> +		mask = (u8)((reta_conf[idx].mask >> shift) &
> +						SXE_4_BIT_MASK);
> +		if (!mask)
> +			continue;
> +
> +		if (mask == SXE_4_BIT_MASK)
> +			r = 0;
> +		else
> +			r = sxe_hw_rss_redir_tbl_get_by_idx(hw, i);
> +
> +		for (j = 0, reta = 0; j < SXE_4_BIT_WIDTH; j++) {
> +			if (mask & (0x1 << j)) {
> +				reta |= reta_conf[idx].reta[shift + j] <<
> +						(CHAR_BIT * j);
> +			} else {
> +				reta |= r & (SXE_8_BIT_MASK <<
> +					(CHAR_BIT * j));
> +			}
> +		}
> +
> +		sxe_hw_rss_redir_tbl_set_by_idx(hw, i, reta);
> +	}
> +	adapter->rss_reta_updated = true;
> +
> +l_end:
> +	return ret;
> +}
> +
> +s32 sxe_rss_reta_query(struct rte_eth_dev *dev,
> +			 struct rte_eth_rss_reta_entry64 *reta_conf,
> +			 u16 reta_size)
> +{
> +	u16 i;
> +	u8 j, mask;
> +	u32 reta;
> +	u16 idx, shift;
> +	struct sxe_adapter *adapter = dev->data->dev_private;
> +	struct sxe_hw *hw = &adapter->hw;
> +	s32 ret = 0;
> +
> +	PMD_INIT_FUNC_TRACE();
> +	if (reta_size != RTE_ETH_RSS_RETA_SIZE_128) {
> +		PMD_LOG_ERR(DRV, "the size of hash lookup table configured "
> +			"(%d) doesn't match the number hardware can supported "
> +			"(%d)", reta_size, RTE_ETH_RSS_RETA_SIZE_128);
> +		ret = -EINVAL;
> +		goto l_end;
> +	}
> +
> +	for (i = 0; i < reta_size; i += SXE_4_BIT_WIDTH) {
> +		idx = i / RTE_ETH_RETA_GROUP_SIZE;
> +		shift = i % RTE_ETH_RETA_GROUP_SIZE;
> +		mask = (u8)((reta_conf[idx].mask >> shift) &
> +						SXE_4_BIT_MASK);
> +		if (!mask)
> +			continue;
> +
> +		reta = sxe_hw_rss_redir_tbl_get_by_idx(hw, i);
> +		for (j = 0; j < SXE_4_BIT_WIDTH; j++) {
> +			if (mask & (0x1 << j)) {
> +				reta_conf[idx].reta[shift + j] =
> +					((reta >> (CHAR_BIT * j)) &
> +						SXE_8_BIT_MASK);
> +			}
> +		}
> +	}
> +
> +l_end:
> +	return ret;
> +}
> +
> +s32 sxe_rss_hash_update(struct rte_eth_dev *dev,
> +			struct rte_eth_rss_conf *rss_conf)
> +{
> +	struct sxe_adapter *adapter = dev->data->dev_private;
> +	struct sxe_hw *hw = &adapter->hw;
> +	u64 rss_hf;
> +	s32 ret = 0;
> +
> +	rss_hf = (rss_conf->rss_hf & SXE_RSS_OFFLOAD_ALL);

Shan't one throw an error on '(rss_conf->rss_hf & ~SXE_RSS_OFFLOAD_ALL) != 0'?

> +
> +	if (!sxe_hw_is_rss_enabled(hw)) {
> +		if (rss_hf != 0) {
> +			PMD_LOG_ERR(DRV, "rss not init but want set");
> +			ret = -EINVAL;
> +			goto l_end;
> +		}
> +
> +		goto l_end;
> +	}
> +
> +	if (rss_hf == 0) {
> +		PMD_LOG_ERR(DRV, "rss init but want disable it");
> +		ret = -EINVAL;
> +		goto l_end;
> +	}
> +
> +	sxe_rss_hash_set(hw, rss_conf);
> +
> +l_end:
> +	return ret;
> +}
> +
> +s32 sxe_rss_hash_conf_get(struct rte_eth_dev *dev,
> +				struct rte_eth_rss_conf *rss_conf)
> +{
> +	struct sxe_adapter *adapter = dev->data->dev_private;
> +	struct sxe_hw *hw = &adapter->hw;
> +	u8 *hash_key;
> +	u32 rss_field;
> +	u32 rss_key;
> +	u64 rss_hf;
> +	u16 i;
> +
> +	hash_key = rss_conf->rss_key;

No check of 'rss_conf->rss_key_len'?

Thank you.

> +	if (hash_key != NULL) {
> +		for (i = 0; i < SXE_MAX_RSS_KEY_ENTRIES; i++) {
> +			rss_key = sxe_hw_rss_key_get_by_idx(hw, i);
> +			hash_key[(i * 4)] = rss_key & 0x000000FF;
> +			hash_key[(i * 4) + 1] = (rss_key >> 8) & 0x000000FF;
> +			hash_key[(i * 4) + 2] = (rss_key >> 16) & 0x000000FF;
> +			hash_key[(i * 4) + 3] = (rss_key >> 24) & 0x000000FF;
> +		}
> +	}
> +
> +
> +	if (!sxe_hw_is_rss_enabled(hw)) {
> +		rss_conf->rss_hf = 0;
> +		PMD_LOG_INFO(DRV, "rss not enabled, return 0");
> +		goto l_end;
> +	}
> +
> +	rss_hf = 0;
> +	rss_field = sxe_hw_rss_field_get(hw);
> +	if (rss_field & SXE_MRQC_RSS_FIELD_IPV4)
> +		rss_hf |= RTE_ETH_RSS_IPV4;
> +
> +	if (rss_field & SXE_MRQC_RSS_FIELD_IPV4_TCP)
> +		rss_hf |= RTE_ETH_RSS_NONFRAG_IPV4_TCP;
> +
> +	if (rss_field & SXE_MRQC_RSS_FIELD_IPV4_UDP)
> +		rss_hf |= RTE_ETH_RSS_NONFRAG_IPV4_UDP;
> +
> +	if (rss_field & SXE_MRQC_RSS_FIELD_IPV6)
> +		rss_hf |= RTE_ETH_RSS_IPV6;
> +
> +	if (rss_field & SXE_MRQC_RSS_FIELD_IPV6_TCP)
> +		rss_hf |= RTE_ETH_RSS_NONFRAG_IPV6_TCP;
> +
> +	if (rss_field & SXE_MRQC_RSS_FIELD_IPV6_UDP)
> +		rss_hf |= RTE_ETH_RSS_NONFRAG_IPV6_UDP;
> +
> +	PMD_LOG_DEBUG(DRV, "got rss hash func=0x%" SXE_PRIX64, rss_hf);
> +	rss_conf->rss_hf = rss_hf;
> +
> +l_end:
> +	return 0;
> +}
> diff --git a/drivers/net/sxe/pf/sxe_offload.h b/drivers/net/sxe/pf/sxe_offload.h
> index a70d6bf94b..458b6464c5 100644
> --- a/drivers/net/sxe/pf/sxe_offload.h
> +++ b/drivers/net/sxe/pf/sxe_offload.h
> @@ -7,6 +7,21 @@
>
> #include "sxe_hw.h"
>
> +#define SXE_RSS_OFFLOAD_ALL ( \
> +		RTE_ETH_RSS_IPV4 | \
> +		RTE_ETH_RSS_NONFRAG_IPV4_TCP | \
> +		RTE_ETH_RSS_NONFRAG_IPV4_UDP | \
> +		RTE_ETH_RSS_IPV6 | \
> +		RTE_ETH_RSS_NONFRAG_IPV6_TCP | \
> +		RTE_ETH_RSS_NONFRAG_IPV6_UDP)
> +
> +#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_FILTER_CTRL
> +u8 *sxe_rss_hash_key_get(void);
> +#endif
> +
> +void sxe_rss_hash_set(struct sxe_hw *hw,
> +				struct rte_eth_rss_conf *rss_conf);
> +
> u64 sxe_rx_queue_offload_capa_get(struct rte_eth_dev *dev);
>
> u64 sxe_rx_port_offload_capa_get(struct rte_eth_dev *dev);
> @@ -15,4 +30,22 @@ u64 sxe_tx_queue_offload_capa_get(struct rte_eth_dev *dev);
>
> u64 sxe_tx_port_offload_capa_get(struct rte_eth_dev *dev);
>
> +void sxe_rss_disable(struct rte_eth_dev *dev);
> +
> +void sxe_rss_configure(struct rte_eth_dev *dev);
> +
> +s32 sxe_rss_reta_update(struct rte_eth_dev *dev,
> +			struct rte_eth_rss_reta_entry64 *reta_conf,
> +			u16 reta_size);
> +
> +s32 sxe_rss_reta_query(struct rte_eth_dev *dev,
> +			 struct rte_eth_rss_reta_entry64 *reta_conf,
> +			 u16 reta_size);
> +
> +s32 sxe_rss_hash_update(struct rte_eth_dev *dev,
> +			struct rte_eth_rss_conf *rss_conf);
> +
> +s32 sxe_rss_hash_conf_get(struct rte_eth_dev *dev,
> +				struct rte_eth_rss_conf *rss_conf);
> +
> #endif
> -- 
> 2.18.2
>
>
