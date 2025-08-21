Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3EFCA0EEB
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 Aug 2025 08:22:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B70C4029D;
	Thu, 21 Aug 2025 10:22:14 +0200 (CEST)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mails.dpdk.org (Postfix) with ESMTP id 264394026C
 for <dev@dpdk.org>; Thu, 21 Aug 2025 10:22:11 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.44])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4c6x7B1BGsz2VRP8;
 Thu, 21 Aug 2025 16:19:18 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 781371401F2;
 Thu, 21 Aug 2025 16:22:08 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 21 Aug 2025 16:22:07 +0800
Message-ID: <be9dd349-3b58-4f40-b630-c2af10c85f50@huawei.com>
Date: Thu, 21 Aug 2025 16:22:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [V5 16/18] net/hinic3: add RSS promiscuous ops
To: Feifei Wang <wff_light@vip.163.com>, <dev@dpdk.org>
CC: Xin Wang <wangxin679@h-partners.com>, Feifei Wang
 <wangfeifei40@huawei.com>, Yi Chen <chenyi221@huawei.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250702020953.599-1-wff_light@vip.163.com>
 <20250702020953.599-17-wff_light@vip.163.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20250702020953.599-17-wff_light@vip.163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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



On 7/2/2025 10:09 AM, Feifei Wang wrote:
> From: Xin Wang <wangxin679@h-partners.com>
> 
> 
> Add RSS and promiscuous ops related function codes.
> 
> 
> 
> Signed-off-by: Xin Wang <wangxin679@h-partners.com>
> 
> Reviewed-by: Feifei Wang <wangfeifei40@huawei.com>
> 
> Reviewed-by: Yi Chen <chenyi221@huawei.com>
> 
> ---
> 
>  drivers/net/hinic3/hinic3_ethdev.c | 370 +++++++++++++++++++++++++++++
> 
>  drivers/net/hinic3/hinic3_ethdev.h |  31 +++
> 
>  2 files changed, 401 insertions(+)
> 
> 
> 
> diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
> 
> index ac36c49afc..0807e017c2 100644
> 
> --- a/drivers/net/hinic3/hinic3_ethdev.c
> 
> +++ b/drivers/net/hinic3/hinic3_ethdev.c
> 
> @@ -2277,6 +2277,281 @@ hinic3_dev_allmulticast_disable(struct rte_eth_dev *dev)
> 
>  	return 0;
> 
>  }
> 
>  
> 
> +/**
> 
> + * Enable promiscuous mode.
> 
> + *
> 
> + * @param[in] dev
> 
> + * Pointer to ethernet device structure.
> 
> + *
> 
> + * @return
> 
> + * 0 on success, non-zero on failure.
> 
> + */
> 
> +static int
> 
> +hinic3_dev_promiscuous_enable(struct rte_eth_dev *dev)
> 
> +{
> 
> +	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
> 
> +	u32 rx_mode;
> 
> +	int err;
> 
> +
> 
> +	err = hinic3_mutex_lock(&nic_dev->rx_mode_mutex);
> 
> +	if (err)
> 
> +		return err;
> 
> +
> 
> +	rx_mode = nic_dev->rx_mode | HINIC3_RX_MODE_PROMISC;
> 
> +
> 
> +	err = hinic3_set_rx_mode(nic_dev->hwdev, rx_mode);
> 
> +	if (err) {
> 
> +		hinic3_mutex_unlock(&nic_dev->rx_mode_mutex);
> 
> +		PMD_DRV_LOG(ERR, "Enable promiscuous failed");
> 
> +		return err;
> 
> +	}
> 
> +
> 
> +	nic_dev->rx_mode = rx_mode;
> 
> +
> 
> +	hinic3_mutex_unlock(&nic_dev->rx_mode_mutex);
> 
> +
> 
> +	PMD_DRV_LOG(INFO,
> 
> +		    "Enable promiscuous, nic_dev: %s, port_id: %d, promisc: %d",
> 
> +		    nic_dev->dev_name, dev->data->port_id,
> 
> +		    dev->data->promiscuous);
> 
> +	return 0;
> 
> +}
> 
> +
> 
> +/**
> 
> + * Disable promiscuous mode.
> 
> + *
> 
> + * @param[in] dev
> 
> + * Pointer to ethernet device structure.
> 
> + *
> 
> + * @return
> 
> + * 0 on success, non-zero on failure.
> 
> + */
> 
> +static int
> 
> +hinic3_dev_promiscuous_disable(struct rte_eth_dev *dev)
> 
> +{
> 
> +	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
> 
> +	u32 rx_mode;
> 
> +	int err;
> 
> +
> 
> +	err = hinic3_mutex_lock(&nic_dev->rx_mode_mutex);
> 
> +	if (err)
> 
> +		return err;
> 
> +
> 
> +	rx_mode = nic_dev->rx_mode & (~HINIC3_RX_MODE_PROMISC);
> 
> +
> 
> +	err = hinic3_set_rx_mode(nic_dev->hwdev, rx_mode);
> 
> +	if (err) {
> 
> +		hinic3_mutex_unlock(&nic_dev->rx_mode_mutex);
> 
> +		PMD_DRV_LOG(ERR, "Disable promiscuous failed");
> 
> +		return err;
> 
> +	}
> 
> +
> 
> +	nic_dev->rx_mode = rx_mode;
> 
> +
> 
> +	hinic3_mutex_unlock(&nic_dev->rx_mode_mutex);
> 
> +
> 
> +	PMD_DRV_LOG(INFO,
> 
> +		"Disable promiscuous, nic_dev: %s, port_id: %d, promisc: %d",
> 
> +		nic_dev->dev_name, dev->data->port_id, dev->data->promiscuous);
> 
> +	return 0;
> 
> +}
> 
> +
> 
> +/**
> 
> + * Get flow control configuration, including auto-negotiation and RX/TX pause
> 
> + * settings.
> 
> + *
> 
> + * @param[in] dev
> 
> + * Pointer to ethernet device structure.
> 
> + *
> 
> + * @param[out] fc_conf
> 
> + * The flow control configuration to be filled.
> 
> + *
> 
> + * @return
> 
> + * 0 on success, non-zero on failure.
> 
> + */
> 
> +
> 
> +/**
> 
> + * Update the RSS hash key and RSS hash type.
> 
> + *
> 
> + * @param[in] dev
> 
> + * Pointer to ethernet device structure.
> 
> + * @param[in] rss_conf
> 
> + * RSS configuration data.
> 
> + *
> 
> + * @return
> 
> + * 0 on success, non-zero on failure.
> 
> + */
> 
> +static int
> 
> +hinic3_rss_hash_update(struct rte_eth_dev *dev,
> 
> +		       struct rte_eth_rss_conf *rss_conf)
> 
> +{
> 
> +	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
> 
> +	struct hinic3_rss_type rss_type = {0};
> 
> +	u64 rss_hf = rss_conf->rss_hf;
> 
> +	int err = 0;
> 
> +
> 
> +	if (nic_dev->rss_state == HINIC3_RSS_DISABLE) {
> 
> +		if (rss_hf != 0)
> 
> +			return -EINVAL;
> 
> +
> 
> +		PMD_DRV_LOG(INFO, "RSS is not enabled");
> 
> +		return 0;
> 
> +	}
> 
> +
> 
> +	if (rss_conf->rss_key_len > HINIC3_RSS_KEY_SIZE) {
> 
> +		PMD_DRV_LOG(ERR, "Invalid RSS key, rss_key_len: %d",
> 
> +			    rss_conf->rss_key_len);
> 
> +		return -EINVAL;
> 
> +	}
> 
> +
> 
> +	if (rss_conf->rss_key) {
> 
> +		err = hinic3_rss_set_hash_key(nic_dev->hwdev, nic_dev->rss_key,
> 
> +					      HINIC3_RSS_KEY_SIZE);
> 
> +		if (err) {
> 
> +			PMD_DRV_LOG(ERR, "Set RSS hash key failed");
> 
> +			return err;
> 
> +		}
> 
> +		memcpy((void *)nic_dev->rss_key, (void *)rss_conf->rss_key,
> 
> +		       (size_t)rss_conf->rss_key_len);
> 
> +	}
> 
> +
> 
> +	rss_type.ipv4 = (rss_hf & (RTE_ETH_RSS_IPV4 | RTE_ETH_RSS_FRAG_IPV4 |
> 
> +				   RTE_ETH_RSS_NONFRAG_IPV4_OTHER))
> 
> +				? 1
> 
> +				: 0;
> 
> +	rss_type.tcp_ipv4 = (rss_hf & RTE_ETH_RSS_NONFRAG_IPV4_TCP) ? 1 : 0;
> 
> +	rss_type.ipv6 = (rss_hf & (RTE_ETH_RSS_IPV6 | RTE_ETH_RSS_FRAG_IPV6 |
> 
> +				   RTE_ETH_RSS_NONFRAG_IPV6_OTHER))
> 
> +				? 1
> 
> +				: 0;
> 
> +	rss_type.ipv6_ext = (rss_hf & RTE_ETH_RSS_IPV6_EX) ? 1 : 0;
> 
> +	rss_type.tcp_ipv6 = (rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_TCP) ? 1 : 0;
> 
> +	rss_type.tcp_ipv6_ext = (rss_hf & RTE_ETH_RSS_IPV6_TCP_EX) ? 1 : 0;
> 
> +	rss_type.udp_ipv4 = (rss_hf & RTE_ETH_RSS_NONFRAG_IPV4_UDP) ? 1 : 0;
> 
> +	rss_type.udp_ipv6 = (rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_UDP) ? 1 : 0;
> 
> +
> 
> +	err = hinic3_set_rss_type(nic_dev->hwdev, rss_type);
> 
> +	if (err)
> 
> +		PMD_DRV_LOG(ERR, "Set RSS type failed");
> 
> +
> 
> +	return err;
> 
> +}
> 
> +
> 
> +/**
> 
> + * Get the RSS hash configuration.
> 
> + *
> 
> + * @param[in] dev
> 
> + * Pointer to ethernet device structure.
> 
> + * @param[out] rss_conf
> 
> + * RSS configuration data.
> 
> + *
> 
> + * @return
> 
> + * 0 on success, non-zero on failure.
> 
> + */
> 
> +static int
> 
> +hinic3_rss_conf_get(struct rte_eth_dev *dev, struct rte_eth_rss_conf *rss_conf)
> 
> +{
> 
> +	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
> 
> +	struct hinic3_rss_type rss_type = {0};
> 
> +	int err;
> 
> +
> 
> +	if (!rss_conf)
> 
> +		return -EINVAL;
> 
> +
> 
> +	if (nic_dev->rss_state == HINIC3_RSS_DISABLE) {
> 
> +		rss_conf->rss_hf = 0;
> 
> +		PMD_DRV_LOG(INFO, "RSS is not enabled");
> 
> +		return 0;
> 
> +	}
> 
> +
> 
> +	if (rss_conf->rss_key && rss_conf->rss_key_len >= HINIC3_RSS_KEY_SIZE) {
> 
> +		/*
> 
> +		 * Get RSS key from driver to reduce the frequency of the MPU
> 
> +		 * accessing the RSS memory.
> 
> +		 */
> 
> +		rss_conf->rss_key_len = sizeof(nic_dev->rss_key);
> 
> +		memcpy((void *)rss_conf->rss_key, (void *)nic_dev->rss_key,
> 
> +		       (size_t)rss_conf->rss_key_len);
> 
> +	}
> 
> +
> 
> +	err = hinic3_get_rss_type(nic_dev->hwdev, &rss_type);
> 
> +	if (err)
> 
> +		return err;
> 
> +
> 
> +	rss_conf->rss_hf = 0;
> 
> +	rss_conf->rss_hf |=
> 
> +		rss_type.ipv4 ? (RTE_ETH_RSS_IPV4 | RTE_ETH_RSS_FRAG_IPV4 |
> 
> +				 RTE_ETH_RSS_NONFRAG_IPV4_OTHER)
> 
> +			      : 0;
> 
> +	rss_conf->rss_hf |= rss_type.tcp_ipv4 ? RTE_ETH_RSS_NONFRAG_IPV4_TCP
> 
> +					      : 0;
> 
> +	rss_conf->rss_hf |=
> 
> +		rss_type.ipv6 ? (RTE_ETH_RSS_IPV6 | RTE_ETH_RSS_FRAG_IPV6 |
> 
> +				 RTE_ETH_RSS_NONFRAG_IPV6_OTHER)
> 
> +			      : 0;
> 
> +	rss_conf->rss_hf |= rss_type.ipv6_ext ? RTE_ETH_RSS_IPV6_EX : 0;
> 
> +	rss_conf->rss_hf |= rss_type.tcp_ipv6 ? RTE_ETH_RSS_NONFRAG_IPV6_TCP
> 
> +					      : 0;
> 
> +	rss_conf->rss_hf |= rss_type.tcp_ipv6_ext ? RTE_ETH_RSS_IPV6_TCP_EX : 0;
> 
> +	rss_conf->rss_hf |= rss_type.udp_ipv4 ? RTE_ETH_RSS_NONFRAG_IPV4_UDP
> 
> +					      : 0;
> 
> +	rss_conf->rss_hf |= rss_type.udp_ipv6 ? RTE_ETH_RSS_NONFRAG_IPV6_UDP
> 
> +					      : 0;
> 
> +
> 
> +	return 0;
> 
> +}
> 
> +
> 
> +/**
> 
> + * Get the RETA indirection table.
> 
> + *
> 
> + * @param[in] dev
> 
> + * Pointer to ethernet device structure.
> 
> + * @param[out] reta_conf
> 
> + * Pointer to RETA configuration structure array.
> 
> + * @param[in] reta_size
> 
> + * Size of the RETA table.
> 
> + *
> 
> + * @return
> 
> + * 0 on success, non-zero on failure.
> 
> + */
> 
> +static int
> 
> +hinic3_rss_reta_query(struct rte_eth_dev *dev,
> 
> +		      struct rte_eth_rss_reta_entry64 *reta_conf,
> 
> +		      uint16_t reta_size)
> 
> +{
> 
> +	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
> 
> +	u32 indirtbl[HINIC3_RSS_INDIR_SIZE] = {0};
> 
> +	u16 idx, shift;
> 
> +	u16 i;
> 
> +	int err;
> 
> +
> 
> +	if (nic_dev->rss_state == HINIC3_RSS_DISABLE) {
> 
> +		PMD_DRV_LOG(INFO, "RSS is not enabled");
> 
> +		return 0;
> 
> +	}
> 
> +
> 
> +	if (reta_size != HINIC3_RSS_INDIR_SIZE) {
> 
> +		PMD_DRV_LOG(ERR, "Invalid reta size, reta_size: %d", reta_size);
> 
> +		return -EINVAL;
> 
> +	}
> 
> +
> 
> +	err = hinic3_rss_get_indir_tbl(nic_dev->hwdev, indirtbl,
> 
> +				       HINIC3_RSS_INDIR_SIZE);
> 
> +	if (err) {
> 
> +		PMD_DRV_LOG(ERR, "Get RSS retas table failed, error: %d", err);
> 
> +		return err;
> 
> +	}
> 
> +
> 
> +	for (i = 0; i < reta_size; i++) {
> 
> +		idx = i / RTE_ETH_RETA_GROUP_SIZE;
> 
> +		shift = i % RTE_ETH_RETA_GROUP_SIZE;
> 
> +		if (reta_conf[idx].mask & (1ULL << shift))
> 
> +			reta_conf[idx].reta[shift] = (uint16_t)indirtbl[i];
> 
> +	}
> 
> +
> 
> +	return 0;
> 
> +}
> 
> +
> 
>  static int
> 
>  hinic3_get_eeprom(__rte_unused struct rte_eth_dev *dev,
> 
>  		  struct rte_dev_eeprom_info *info)
> 
> @@ -2287,6 +2562,68 @@ hinic3_get_eeprom(__rte_unused struct rte_eth_dev *dev,
> 
>  				  &info->length, MAX_BUF_OUT_LEN);
> 
>  }
> 
>  
> 
> +/**
> 
> + * Update the RETA indirection table.
> 
> + *
> 
> + * @param[in] dev
> 
> + * Pointer to ethernet device structure.
> 
> + * @param[in] reta_conf
> 
> + * Pointer to RETA configuration structure array.
> 
> + * @param[in] reta_size
> 
> + * Size of the RETA table.
> 
> + *
> 
> + * @return
> 
> + * 0 on success, non-zero on failure.
> 
> + */
> 
> +static int
> 
> +hinic3_rss_reta_update(struct rte_eth_dev *dev,
> 
> +		       struct rte_eth_rss_reta_entry64 *reta_conf,
> 
> +		       uint16_t reta_size)
> 
> +{
> 
> +	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
> 
> +	u32 indirtbl[HINIC3_RSS_INDIR_SIZE] = {0};
> 
> +	u16 idx, shift;
> 
> +	u16 i;
> 
> +	int err;
> 
> +
> 
> +	if (nic_dev->rss_state == HINIC3_RSS_DISABLE)
> 
> +		return 0;
> 
> +
> 
> +	if (reta_size != HINIC3_RSS_INDIR_SIZE) {
> 
> +		PMD_DRV_LOG(ERR, "Invalid reta size, reta_size: %d", reta_size);
> 
> +		return -EINVAL;
> 
> +	}
> 
> +
> 
> +	err = hinic3_rss_get_indir_tbl(nic_dev->hwdev, indirtbl,
> 
> +				       HINIC3_RSS_INDIR_SIZE);
> 
> +	if (err)
> 
> +		return err;
> 
> +
> 
> +	/* Update RSS reta table. */
> 
> +	for (i = 0; i < reta_size; i++) {
> 
> +		idx = i / RTE_ETH_RETA_GROUP_SIZE;
> 
> +		shift = i % RTE_ETH_RETA_GROUP_SIZE;
> 
> +		if (reta_conf[idx].mask & (1ULL << shift))
> 
> +			indirtbl[i] = reta_conf[idx].reta[shift];
> 
> +	}
> 
> +
> 
> +	for (i = 0; i < reta_size; i++) {
> 
> +		if (indirtbl[i] >= nic_dev->num_rqs) {
> 
> +			PMD_DRV_LOG(ERR,
> 
> +				"Invalid reta entry, index: %d, num_rqs: %d",
> 
> +				indirtbl[i], nic_dev->num_rqs);
> 
> +			return -EFAULT;
> 
> +		}
> 
> +	}
> 
> +
> 
> +	err = hinic3_rss_set_indir_tbl(nic_dev->hwdev, indirtbl,
> 
> +				       HINIC3_RSS_INDIR_SIZE);
> 
> +	if (err)
> 
> +		PMD_DRV_LOG(ERR, "Set RSS reta table failed");
> 
> +
> 
> +	return err;
> 
> +}
> 
> +
> 
>  /**
> 
>   * Get device generic statistics.
> 
>   *
> 
> @@ -2857,6 +3194,29 @@ hinic3_set_mc_addr_list(struct rte_eth_dev *dev,
> 
>  	return 0;
> 
>  }
> 
>  
> 
> +/**
> 
> + * Manage flow director filter operations.
> 
> + *
> 
> + * @param[in] dev
> 
> + * Pointer to ethernet device structure.
> 
> + * @param[in] filter_type
> 
> + * Filter type.
> 
> + * @param[in] filter_op
> 
> + * Operation to perform.
> 
> + * @param[in] arg
> 
> + * Pointer to operation-specific structure.
> 
> + *
> 
> + * @return
> 
> + * 0 on success, non-zero on failure.
> 
> + */
> 
> +static int
> 
> +hinic3_dev_filter_ctrl(struct rte_eth_dev *dev, const struct rte_flow_ops **arg)
> 
> +{
> 
> +	RTE_SET_USED(dev);
> 
> +	*arg = &hinic3_flow_ops;
> 
> +	return 0;
> 
> +}
> 
> +
> 
>  static int
> 
>  hinic3_get_reg(__rte_unused struct rte_eth_dev *dev,
> 
>  	       __rte_unused struct rte_dev_reg_info *regs)
> 
> @@ -2890,6 +3250,12 @@ static const struct eth_dev_ops hinic3_pmd_ops = {
> 
>  	.vlan_offload_set              = hinic3_vlan_offload_set,
> 
>  	.allmulticast_enable           = hinic3_dev_allmulticast_enable,
> 
>  	.allmulticast_disable          = hinic3_dev_allmulticast_disable,
> 
> +	.promiscuous_enable            = hinic3_dev_promiscuous_enable,
> 
> +	.promiscuous_disable           = hinic3_dev_promiscuous_disable,
> 
> +	.rss_hash_update               = hinic3_rss_hash_update,
> 
> +	.rss_hash_conf_get             = hinic3_rss_conf_get,
> 
> +	.reta_update                   = hinic3_rss_reta_update,
> 
> +	.reta_query                    = hinic3_rss_reta_query,
> 
>  	.get_eeprom                    = hinic3_get_eeprom,
> 
>  	.stats_get                     = hinic3_dev_stats_get,
> 
>  	.stats_reset                   = hinic3_dev_stats_reset,
> 
> @@ -2931,6 +3297,10 @@ static const struct eth_dev_ops hinic3_pmd_vf_ops = {
> 
>  	.vlan_offload_set              = hinic3_vlan_offload_set,
> 
>  	.allmulticast_enable           = hinic3_dev_allmulticast_enable,
> 
>  	.allmulticast_disable          = hinic3_dev_allmulticast_disable,
> 
> +	.rss_hash_update               = hinic3_rss_hash_update,
> 
> +	.rss_hash_conf_get             = hinic3_rss_conf_get,
> 
> +	.reta_update                   = hinic3_rss_reta_update,
> 
> +	.reta_query                    = hinic3_rss_reta_query,
> 
>  	.get_eeprom                    = hinic3_get_eeprom,
> 
>  	.stats_get                     = hinic3_dev_stats_get,
> 
>  	.stats_reset                   = hinic3_dev_stats_reset,
> 
> diff --git a/drivers/net/hinic3/hinic3_ethdev.h b/drivers/net/hinic3/hinic3_ethdev.h
> 
> index e0d5b4602c..90ca21491f 100644
> 
> --- a/drivers/net/hinic3/hinic3_ethdev.h
> 
> +++ b/drivers/net/hinic3/hinic3_ethdev.h
> 
> @@ -97,6 +97,10 @@ struct hinic3_nic_dev {
> 
>  	u16 rx_buff_len;
> 
>  	u16 mtu_size;
> 
>  
> 
> +	u16 rss_state;
> 
> +	u8 num_rss; /**< Number of RSS queues. */
> 
> +	u8 rsvd0;   /**< Reserved field 0. */
> 
> +
> 
>  	u32 rx_mode;
> 
>  	u8 rx_queue_list[HINIC3_MAX_QUEUE_NUM];
> 
>  	rte_spinlock_t queue_list_lock;
> 
> @@ -106,6 +110,8 @@ struct hinic3_nic_dev {
> 
>  	u32 default_cos;
> 
>  	u32 rx_csum_en;
> 
>  
> 
> +	u8 rss_key[HINIC3_RSS_KEY_SIZE];
> 
> +
> 
>  	RTE_ATOMIC(u64) dev_status;
> 
>  
> 
>  	struct rte_ether_addr default_addr;
> 
> @@ -116,4 +122,29 @@ struct hinic3_nic_dev {
> 
>  	u32 vfta[HINIC3_VFTA_SIZE]; /**< VLAN bitmap. */
> 
>  };
> 
>  
> 
> +/**
> 
> + * Enable interrupt for the specified RX queue.
> 
> + *
> 
> + * @param[in] dev
> 
> + * Pointer to ethernet device structure.
> 
> + * @param[in] queue_id
> 
> + * The ID of the receive queue for which the interrupt is being enabled.
> 
> + * @return
> 
> + * 0 on success, a negative error code on failure.
> 
> + */
> 
> +int hinic3_dev_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id);
> 
> +
> 
> +/**
> 
> + * Disable interrupt for the specified RX queue.
> 
> + *
> 
> + * @param[in] dev
> 
> + * Pointer to ethernet device structure.
> 
> + * @param[in] queue_id
> 
> + * The ID of the receive queue for which the interrupt is being disabled.
> 
> + * @return
> 
> + * 0 on success, a negative error code on failure.
> 
> + */
> 
> +int hinic3_dev_rx_queue_intr_disable(struct rte_eth_dev *dev,
> 
> +				     uint16_t queue_id);

the above two function declation were not related to the subject, please remove them.

> 
> +
> 
>  #endif /* _HINIC3_ETHDEV_H_ */
> 

