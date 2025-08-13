Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6EECA0EE0
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 11:48:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2625D40E27;
	Wed, 13 Aug 2025 13:48:33 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 552ED4021F
 for <dev@dpdk.org>; Wed, 13 Aug 2025 13:48:31 +0200 (CEST)
Received: from debian (unknown [78.109.79.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id A3DA4E04CB;
 Wed, 13 Aug 2025 15:48:30 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am A3DA4E04CB
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1755085711;
 bh=cd79J9wW7EOkTfT5dNH7Kj65B+FQgb5e6/l0b47FU4U=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=I6FEOXiqoMCWZfgptHnkyV47c8jL7Zw6b/a9izhb6ESX6rA2gcQzy/zipIFz5YKfr
 bYtGHHKh6HGwU7mve8tlyzukfocapKVwZJ4zqtKhpNrv44aw7lqZZ2m4hTTAGox51H
 moEq3el8wwAb0EYjeqzcCYtXIGNvG+i8ZcVmoP82nd+aH4miSUXGiXk4Yleyg5OEN6
 2PRw/6KfVsKzxVai9mRcaq2Efs2zadn4Yldxki40ZEFcpY2HIZ833XYM3DzoO8oivn
 z+QaFzOhONd4V8c4HcOqdn35R/pFmboQa7uKlrTL+GCOS+wZaRy13lS/PimUH0EEmE
 vJEytfCkXKKww==
Date: Wed, 13 Aug 2025 15:48:29 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
cc: dev@dpdk.org, Kyo Liu <kyo.liu@nebula-matrix.com>, 
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v4 15/16] net/nbl: add nbl device xstats and stats
In-Reply-To: <20250813064410.3894506-16-dimon.zhao@nebula-matrix.com>
Message-ID: <6a088ad9-2d80-88a0-81e8-d6fec073c0c8@arknetworks.am>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20250813064410.3894506-1-dimon.zhao@nebula-matrix.com>
 <20250813064410.3894506-16-dimon.zhao@nebula-matrix.com>
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

Hi Dimon,

(please see below)

On Tue, 12 Aug 2025, Dimon Zhao wrote:

> Implement NBL device xstats and stats functions
>
> Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
> ---
> drivers/net/nbl/nbl_dev/nbl_dev.c             | 141 +++++++++++++++++-
> drivers/net/nbl/nbl_dev/nbl_dev.h             |   8 +
> drivers/net/nbl/nbl_dispatch.c                | 111 ++++++++++++++
> drivers/net/nbl/nbl_ethdev.c                  |   4 +
> .../nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c | 113 ++++++++++++++
> drivers/net/nbl/nbl_hw/nbl_txrx.c             | 113 +++++++++++++-
> drivers/net/nbl/nbl_include/nbl_def_channel.h |   5 +
> .../net/nbl/nbl_include/nbl_def_dispatch.h    |   9 ++
> .../net/nbl/nbl_include/nbl_def_resource.h    |  12 +-
> drivers/net/nbl/nbl_include/nbl_include.h     |   4 +
> 10 files changed, 514 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.c b/drivers/net/nbl/nbl_dev/nbl_dev.c
> index b32ab839d5..bab89c707f 100644
> --- a/drivers/net/nbl/nbl_dev/nbl_dev.c
> +++ b/drivers/net/nbl/nbl_dev/nbl_dev.c
> @@ -381,6 +381,126 @@ int nbl_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *rte_stats)
> 	return disp_ops->get_stats(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), rte_stats);
> }
>
> +int nbl_stats_reset(struct rte_eth_dev *eth_dev)
> +{
> +	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
> +	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
> +	struct nbl_dispatch_ops *disp_ops = NBL_DEV_MGT_TO_DISP_OPS(dev_mgt);
> +
> +	return disp_ops->reset_stats(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt));
> +}
> +
> +static int nbl_dev_update_hw_xstats(struct nbl_dev_mgt *dev_mgt, struct rte_eth_xstat *xstats,
> +				    u16 hw_xstats_cnt, u16 *xstats_cnt)
> +{
> +	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
> +	struct nbl_dispatch_ops *disp_ops = NBL_DEV_MGT_TO_DISP_OPS(dev_mgt);
> +	u64 *hw_stats;
> +	int i;
> +	u16 count = *xstats_cnt;
> +
> +	hw_stats = rte_zmalloc("nbl_xstats_cnt", hw_xstats_cnt * sizeof(u64), 0);

Do you believe it's the best course of action, to allocate and free a bounce
buffer on each invocation? This function is not strictly fast-path, but I'd say
semi-fast. Some applications may want to invoke it pretty often.

> +	if (!hw_stats)
> +		return -ENOMEM;
> +
> +	disp_ops->get_private_stat_data(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt),
> +					common->eth_id, hw_stats, hw_xstats_cnt * sizeof(u64));
> +	for (i = 0; i < hw_xstats_cnt; i++) {
> +		xstats[count].value = hw_stats[i] - dev_mgt->net_dev->hw_xstats_offset[i];
> +		xstats[count].id = count;
> +		count++;
> +	}
> +
> +	*xstats_cnt = count;
> +	rte_free(hw_stats);
> +	return 0;
> +}
> +
> +int nbl_xstats_get(struct rte_eth_dev *eth_dev, struct rte_eth_xstat *xstats, unsigned int n)
> +{
> +	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
> +	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
> +	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
> +	struct nbl_dispatch_ops *disp_ops = NBL_DEV_MGT_TO_DISP_OPS(dev_mgt);
> +	int ret = 0;
> +	u16 txrx_xstats_cnt = 0, hw_xstats_cnt = 0, xstats_cnt = 0;
> +
> +	if (!xstats)
> +		return 0;
> +
> +	ret = disp_ops->get_txrx_xstats_cnt(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), &txrx_xstats_cnt);
> +	if (!common->is_vf)
> +		ret |= disp_ops->get_hw_xstats_cnt(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt),
> +						   &hw_xstats_cnt);
> +	if (ret)
> +		return -EIO;
> +
> +	if (n < (txrx_xstats_cnt + hw_xstats_cnt))
> +		return txrx_xstats_cnt + hw_xstats_cnt;
> +
> +	if (txrx_xstats_cnt)
> +		ret = disp_ops->get_txrx_xstats(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt),
> +						xstats, &xstats_cnt);
> +	if (hw_xstats_cnt)
> +		ret |= nbl_dev_update_hw_xstats(dev_mgt, xstats, hw_xstats_cnt, &xstats_cnt);
> +
> +	if (ret)
> +		return -EIO;
> +
> +	return xstats_cnt;
> +}
> +
> +int nbl_xstats_get_names(struct rte_eth_dev *eth_dev,
> +			 struct rte_eth_xstat_name *xstats_names,
> +			 __rte_unused unsigned int limit)
> +{
> +	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
> +	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
> +	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
> +	struct nbl_dispatch_ops *disp_ops = NBL_DEV_MGT_TO_DISP_OPS(dev_mgt);
> +	u16 txrx_xstats_cnt = 0, hw_xstats_cnt = 0, xstats_cnt = 0;
> +	int ret = 0;
> +
> +	ret = disp_ops->get_txrx_xstats_cnt(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), &txrx_xstats_cnt);

Exceeds 80-column limit.

> +	if (!common->is_vf)
> +		ret |= disp_ops->get_hw_xstats_cnt(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt),
> +							&hw_xstats_cnt);
> +	if (ret)
> +		return -EIO;
> +
> +	if (!xstats_names)
> +		return txrx_xstats_cnt + hw_xstats_cnt;
> +
> +	if (txrx_xstats_cnt)
> +		ret = disp_ops->get_txrx_xstats_names(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt),
> +						      xstats_names, &xstats_cnt);
> +	if (hw_xstats_cnt)
> +		ret |= disp_ops->get_hw_xstats_names(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt),
> +						     xstats_names, &xstats_cnt);
> +	if (ret)
> +		return -EIO;
> +
> +	return xstats_cnt;
> +}
> +
> +int nbl_xstats_reset(struct rte_eth_dev *eth_dev)
> +{
> +	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
> +	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
> +	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
> +	struct nbl_dispatch_ops *disp_ops = NBL_DEV_MGT_TO_DISP_OPS(dev_mgt);
> +	struct nbl_dev_net_mgt *net_dev = dev_mgt->net_dev;
> +
> +	if (!common->is_vf) {
> +		disp_ops->get_private_stat_data(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt),
> +						dev_mgt->common->eth_id,
> +						net_dev->hw_xstats_offset, net_dev->hw_xstats_size);
> +	}
> +
> +	nbl_stats_reset(eth_dev);
> +	return 0;
> +}
> +
> struct nbl_dev_ops dev_ops = {
> };
>
> @@ -435,6 +555,7 @@ static int nbl_dev_common_start(struct nbl_dev_mgt *dev_mgt)
> 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
> 	u8 *mac;
> 	int ret;
> +	u16 priv_cnt = 0;
>
> 	board_info = &common->board_info;
> 	disp_ops->get_board_info(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), board_info);
> @@ -477,8 +598,25 @@ static int nbl_dev_common_start(struct nbl_dev_mgt *dev_mgt)
> 			goto add_multi_rule_failed;
> 	}
>
> -	return 0;
> +	net_dev->hw_xstats_offset = NULL;
> +	if (!dev_mgt->common->is_vf)
> +		disp_ops->get_hw_xstats_cnt(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), &priv_cnt);
> +	if (priv_cnt) {
> +		net_dev->hw_xstats_offset = rte_zmalloc("nbl_xstats_cnt",
> +							priv_cnt * sizeof(u64), 0);
> +		net_dev->hw_xstats_size = priv_cnt * sizeof(u64);
> +		if (!net_dev->hw_xstats_offset) {
> +			ret = -ENOMEM;
> +			goto alloc_xstats_offset_failed;
> +		}
> +
> +		disp_ops->get_private_stat_data(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt),
> +						dev_mgt->common->eth_id,
> +						net_dev->hw_xstats_offset, net_dev->hw_xstats_size);
> +	}
>
> +	return 0;
> +alloc_xstats_offset_failed:
> add_multi_rule_failed:
> 	disp_ops->del_macvlan(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), mac, 0, net_dev->vsi_id);
> add_macvlan_failed:
> @@ -757,6 +895,7 @@ int nbl_dev_init(void *p, struct rte_eth_dev *eth_dev)
> 			       eth_dev->data->mac_addrs[0].addr_bytes);
>
> 	adapter->state = NBL_ETHDEV_INITIALIZED;
> +	eth_dev->data->dev_flags |= RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS;
> 	disp_ops->get_resource_pt_ops(NBL_DEV_MGT_TO_DISP_PRIV(*dev_mgt),
> 				      &(*dev_mgt)->pt_ops, 0);
>
> diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.h b/drivers/net/nbl/nbl_dev/nbl_dev.h
> index 577a28b32d..1500a782a5 100644
> --- a/drivers/net/nbl/nbl_dev/nbl_dev.h
> +++ b/drivers/net/nbl/nbl_dev/nbl_dev.h
> @@ -41,6 +41,8 @@ struct nbl_dev_net_mgt {
> 	struct rte_eth_dev *eth_dev;
> 	struct nbl_dev_ring_mgt ring_mgt;
> 	struct nbl_eth_link_info eth_link_info;
> +	u64 *hw_xstats_offset;
> +	u32 hw_xstats_size;
> 	u16 vsi_id;
> 	u8 eth_mode;
> 	u8 eth_id;
> @@ -71,5 +73,11 @@ void nbl_rx_queues_release(struct rte_eth_dev *eth_dev, uint16_t queue_id);
> int nbl_dev_infos_get(struct rte_eth_dev *eth_dev __rte_unused, struct rte_eth_dev_info *dev_info);
> int nbl_link_update(struct rte_eth_dev *eth_dev, int wait_to_complete __rte_unused);
> int nbl_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *rte_stats);
> +int nbl_stats_reset(struct rte_eth_dev *eth_dev);
> +int nbl_xstats_get(struct rte_eth_dev *eth_dev, struct rte_eth_xstat *xstats, unsigned int n);
> +int nbl_xstats_get_names(struct rte_eth_dev *eth_dev,
> +			 struct rte_eth_xstat_name *xstats_names,
> +			 __rte_unused unsigned int limit);
> +int nbl_xstats_reset(struct rte_eth_dev *eth_dev);
>
> #endif
> diff --git a/drivers/net/nbl/nbl_dispatch.c b/drivers/net/nbl/nbl_dispatch.c
> index 9382b76ce6..15ea61d8e4 100644
> --- a/drivers/net/nbl/nbl_dispatch.c
> +++ b/drivers/net/nbl/nbl_dispatch.c
> @@ -809,9 +809,94 @@ static int nbl_disp_get_stats(void *priv, struct rte_eth_stats *rte_stats)
> {
> 	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
> 	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
> +
> 	return res_ops->get_stats(NBL_DISP_MGT_TO_RES_PRIV(disp_mgt), rte_stats);
> }
>
> +static int nbl_disp_reset_stats(void *priv)
> +{
> +	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
> +	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
> +
> +	return res_ops->reset_stats(NBL_DISP_MGT_TO_RES_PRIV(disp_mgt));
> +}
> +
> +static int nbl_disp_get_txrx_xstats_cnt(void *priv, u16 *xstats_cnt)
> +{
> +	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
> +	struct nbl_resource_ops *res_ops;
> +
> +	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
> +	return res_ops->get_txrx_xstats_cnt(NBL_DISP_MGT_TO_RES_PRIV(disp_mgt), xstats_cnt);
> +}
> +
> +static int nbl_disp_get_txrx_xstats(void *priv, struct rte_eth_xstat *xstats, u16 *xstats_cnt)
> +{
> +	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
> +	struct nbl_resource_ops *res_ops;
> +
> +	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
> +	return res_ops->get_txrx_xstats(NBL_DISP_MGT_TO_RES_PRIV(disp_mgt), xstats, xstats_cnt);
> +}
> +
> +static int nbl_disp_get_txrx_xstats_names(void *priv, struct rte_eth_xstat_name *xstats_names,
> +					  u16 *xstats_cnt)
> +{
> +	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
> +	struct nbl_resource_ops *res_ops;
> +
> +	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
> +	return res_ops->get_txrx_xstats_names(NBL_DISP_MGT_TO_RES_PRIV(disp_mgt),
> +					 xstats_names, xstats_cnt);
> +}
> +
> +static int nbl_disp_get_hw_xstats_cnt(void *priv, u16 *xstats_cnt)
> +{
> +	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
> +	struct nbl_resource_ops *res_ops;
> +
> +	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
> +	return res_ops->get_hw_xstats_cnt(NBL_DISP_MGT_TO_RES_PRIV(disp_mgt), xstats_cnt);
> +}
> +
> +static int nbl_disp_get_hw_xstats_names(void *priv, struct rte_eth_xstat_name *xstats_names,
> +					u16 *xstats_cnt)
> +{
> +	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
> +	struct nbl_resource_ops *res_ops;
> +
> +	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
> +	return res_ops->get_hw_xstats_names(NBL_DISP_MGT_TO_RES_PRIV(disp_mgt),
> +					    xstats_names, xstats_cnt);
> +}
> +
> +static void nbl_disp_get_private_stat_data(void *priv, u32 eth_id, u64 *data,
> +					   __rte_unused u32 data_len)
> +{
> +	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
> +	struct nbl_resource_ops *res_ops;
> +
> +	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
> +	NBL_OPS_CALL(res_ops->get_private_stat_data,
> +		     (NBL_DISP_MGT_TO_RES_PRIV(disp_mgt), eth_id, data));
> +}
> +
> +static void nbl_disp_get_private_stat_data_req(void *priv, u32 eth_id, u64 *data, u32 data_len)
> +{
> +	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
> +	struct nbl_channel_ops *chan_ops;
> +	struct nbl_chan_send_info chan_send = {0};
> +	struct nbl_chan_param_get_private_stat_data param = {0};
> +
> +	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
> +
> +	param.eth_id = eth_id;
> +	param.data_len = data_len;
> +	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_GET_ETH_STATS, &param,
> +		      sizeof(param), data, data_len, 1);
> +	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
> +}
> +
> #define NBL_DISP_OPS_TBL						\
> do {									\
> 	NBL_DISP_SET_OPS(configure_msix_map, nbl_disp_configure_msix_map,			\
> @@ -956,6 +1041,32 @@ do {									\
> 	NBL_DISP_SET_OPS(get_stats, nbl_disp_get_stats,			\
> 			 NBL_DISP_CTRL_LVL_ALWAYS, -1,			\
> 			 NULL, NULL);					\
> +	NBL_DISP_SET_OPS(reset_stats, nbl_disp_reset_stats,		\
> +			 NBL_DISP_CTRL_LVL_ALWAYS, -1,			\
> +			 NULL, NULL);					\
> +	NBL_DISP_SET_OPS(get_txrx_xstats_cnt,				\
> +			 nbl_disp_get_txrx_xstats_cnt,			\
> +			 NBL_DISP_CTRL_LVL_ALWAYS, -1,			\
> +			 NULL, NULL);					\
> +	NBL_DISP_SET_OPS(get_txrx_xstats, nbl_disp_get_txrx_xstats,	\
> +			 NBL_DISP_CTRL_LVL_ALWAYS, -1,			\
> +			 NULL, NULL);					\
> +	NBL_DISP_SET_OPS(get_txrx_xstats_names,				\
> +			 nbl_disp_get_txrx_xstats_names,		\
> +			 NBL_DISP_CTRL_LVL_ALWAYS, -1,			\
> +			 NULL, NULL);					\
> +	NBL_DISP_SET_OPS(get_hw_xstats_cnt, nbl_disp_get_hw_xstats_cnt,	\
> +			 NBL_DISP_CTRL_LVL_ALWAYS, -1,			\
> +			 NULL, NULL);					\
> +	NBL_DISP_SET_OPS(get_hw_xstats_names,				\
> +			 nbl_disp_get_hw_xstats_names,			\
> +			 NBL_DISP_CTRL_LVL_ALWAYS, -1,			\
> +			 NULL, NULL);					\
> +	NBL_DISP_SET_OPS(get_private_stat_data,				\
> +			 nbl_disp_get_private_stat_data,		\
> +			 NBL_DISP_CTRL_LVL_MGT,				\
> +			 NBL_CHAN_MSG_GET_ETH_STATS,			\
> +			 nbl_disp_get_private_stat_data_req, NULL);	\
> } while (0)
>
> /* Structure starts here, adding an op should not modify anything below */
> diff --git a/drivers/net/nbl/nbl_ethdev.c b/drivers/net/nbl/nbl_ethdev.c
> index f30aca2b7f..81b8946acc 100644
> --- a/drivers/net/nbl/nbl_ethdev.c
> +++ b/drivers/net/nbl/nbl_ethdev.c
> @@ -41,6 +41,10 @@ const struct eth_dev_ops nbl_eth_dev_ops = {
> 	.dev_infos_get = nbl_dev_infos_get,
> 	.link_update = nbl_link_update,
> 	.stats_get = nbl_stats_get,
> +	.stats_reset = nbl_stats_reset,
> +	.xstats_get = nbl_xstats_get,
> +	.xstats_get_names = nbl_xstats_get_names,
> +	.xstats_reset = nbl_xstats_reset,
> };
>
> static int nbl_eth_dev_init(struct rte_eth_dev *eth_dev)
> diff --git a/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c b/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c
> index e7036373f1..41ae423ff0 100644
> --- a/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c
> +++ b/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c
> @@ -4,7 +4,120 @@
>
> #include "nbl_res_leonis.h"
>
> +/* store statistics names */
> +struct nbl_xstats_name {
> +	char name[RTE_ETH_XSTATS_NAME_SIZE];
> +};
> +
> +static const struct nbl_xstats_name nbl_stats_strings[] = {
> +	{"eth_frames_tx"},
> +	{"eth_frames_tx_ok"},
> +	{"eth_frames_tx_badfcs"},
> +	{"eth_unicast_frames_tx_ok"},
> +	{"eth_multicast_frames_tx_ok"},
> +	{"eth_broadcast_frames_tx_ok"},
> +	{"eth_macctrl_frames_tx_ok"},
> +	{"eth_fragment_frames_tx"},
> +	{"eth_fragment_frames_tx_ok"},
> +	{"eth_pause_frames_tx"},
> +	{"eth_pause_macctrl_frames_tx"},
> +	{"eth_pfc_frames_tx"},
> +	{"eth_pfc_frames_tx_prio0"},
> +	{"eth_pfc_frames_tx_prio1"},
> +	{"eth_pfc_frames_tx_prio2"},
> +	{"eth_pfc_frames_tx_prio3"},
> +	{"eth_pfc_frames_tx_prio4"},
> +	{"eth_pfc_frames_tx_prio5"},
> +	{"eth_pfc_frames_tx_prio6"},
> +	{"eth_pfc_frames_tx_prio7"},
> +	{"eth_verify_frames_tx"},
> +	{"eth_respond_frames_tx"},
> +	{"eth_frames_tx_64B"},
> +	{"eth_frames_tx_65_to_127B"},
> +	{"eth_frames_tx_128_to_255B"},
> +	{"eth_frames_tx_256_to_511B"},
> +	{"eth_frames_tx_512_to_1023B"},
> +	{"eth_frames_tx_1024_to_1535B"},
> +	{"eth_frames_tx_1536_to_2047B"},
> +	{"eth_frames_tx_2048_to_MAXB"},
> +	{"eth_undersize_frames_tx_goodfcs"},
> +	{"eth_oversize_frames_tx_goodfcs"},
> +	{"eth_undersize_frames_tx_badfcs"},
> +	{"eth_oversize_frames_tx_badfcs"},
> +	{"eth_octets_tx"},
> +	{"eth_octets_tx_ok"},
> +	{"eth_octets_tx_badfcs"},
> +	{"eth_frames_rx"},
> +	{"eth_frames_rx_ok"},
> +	{"eth_frames_rx_badfcs"},
> +	{"eth_undersize_frames_rx_goodfcs"},
> +	{"eth_undersize_frames_rx_badfcs"},
> +	{"eth_oversize_frames_rx_goodfcs"},
> +	{"eth_oversize_frames_rx_badfcs"},
> +	{"eth_frames_rx_misc_error"},
> +	{"eth_frames_rx_misc_dropped"},
> +	{"eth_unicast_frames_rx_ok"},
> +	{"eth_multicast_frames_rx_ok"},
> +	{"eth_broadcast_frames_rx_ok"},
> +	{"eth_pause_frames_rx"},
> +	{"eth_pfc_frames_rx"},
> +	{"eth_pfc_frames_rx_prio0"},
> +	{"eth_pfc_frames_rx_prio1"},
> +	{"eth_pfc_frames_rx_prio2"},
> +	{"eth_pfc_frames_rx_prio3"},
> +	{"eth_pfc_frames_rx_prio4"},
> +	{"eth_pfc_frames_rx_prio5"},
> +	{"eth_pfc_frames_rx_prio6"},
> +	{"eth_pfc_frames_rx_prio7"},
> +	{"eth_macctrl_frames_rx"},
> +	{"eth_verify_frames_rx_ok"},
> +	{"eth_respond_frames_rx_ok"},
> +	{"eth_fragment_frames_rx_ok"},
> +	{"eth_fragment_rx_smdc_nocontext"},
> +	{"eth_fragment_rx_smds_seq_error"},
> +	{"eth_fragment_rx_smdc_seq_error"},
> +	{"eth_fragment_rx_frag_cnt_error"},
> +	{"eth_frames_assembled_ok"},
> +	{"eth_frames_assembled_error"},
> +	{"eth_frames_rx_64B"},
> +	{"eth_frames_rx_65_to_127B"},
> +	{"eth_frames_rx_128_to_255B"},
> +	{"eth_frames_rx_256_to_511B"},
> +	{"eth_frames_rx_512_to_1023B"},
> +	{"eth_frames_rx_1024_to_1535B"},
> +	{"eth_frames_rx_1536_to_2047B"},
> +	{"eth_frames_rx_2048_to_MAXB"},
> +	{"eth_octets_rx"},
> +	{"eth_octets_rx_ok"},
> +	{"eth_octets_rx_badfcs"},
> +	{"eth_octets_rx_dropped"},
> +};
> +
> +static int nbl_get_xstats_cnt(__rte_unused void *priv, u16 *xstats_cnt)
> +{
> +	*xstats_cnt = ARRAY_SIZE(nbl_stats_strings);
> +	return 0;
> +}
> +
> +static int nbl_get_xstats_names(__rte_unused void *priv,
> +				struct rte_eth_xstat_name *xstats_names,
> +				u16 *xstats_cnt)
> +{
> +	u32 i = 0;
> +	u16 count = *xstats_cnt;
> +
> +	for (i = 0; i < ARRAY_SIZE(nbl_stats_strings); i++) {
> +		strlcpy(xstats_names[count].name, nbl_stats_strings[i].name,
> +			sizeof(nbl_stats_strings[count].name));
> +		count++;
> +	}
> +	*xstats_cnt = count;
> +	return 0;
> +}
> +
> static struct nbl_resource_ops res_ops = {
> +	.get_hw_xstats_cnt = nbl_get_xstats_cnt,
> +	.get_hw_xstats_names = nbl_get_xstats_names,
> };
>
> static bool is_ops_inited;
> diff --git a/drivers/net/nbl/nbl_hw/nbl_txrx.c b/drivers/net/nbl/nbl_hw/nbl_txrx.c
> index d0acbe867d..3de4eedbdb 100644
> --- a/drivers/net/nbl/nbl_hw/nbl_txrx.c
> +++ b/drivers/net/nbl/nbl_hw/nbl_txrx.c
> @@ -536,6 +536,7 @@ nbl_res_txrx_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, u16 nb_pkts, u
> 			txe->mbuf = tx_pkt;
>
> 			data_len = tx_pkt->data_len;
> +			txq->txq_stats.tx_bytes += tx_pkt->data_len;
> 			dma_addr = rte_mbuf_data_iova(tx_pkt);
> 			tx_desc->addr = NBL_DMA_ADDERSS_FULL_TRANSLATE(txq, dma_addr) + addr_offset;
> 			tx_desc->len = data_len - addr_offset;
> @@ -615,6 +616,8 @@ nbl_res_txrx_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, u16 nb_pkts)
> 			rx_ext_hdr = (union nbl_rx_extend_head *)((char *)rx_mbuf->buf_addr +
> 								  RTE_PKTMBUF_HEADROOM);
> 			num_sg = rx_ext_hdr->common.num_buffers;
> +			if (num_sg > 1)
> +				rxq->rxq_stats.rx_multi_descs++;
>
> 			rx_mbuf->nb_segs = num_sg;
> 			rx_mbuf->data_len = rx_desc->len - rxq->exthdr_len;
> @@ -642,15 +645,20 @@ nbl_res_txrx_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, u16 nb_pkts)
> 		if (--num_sg)
> 			continue;
> 		if (drop) {
> +			rxq->rxq_stats.rx_drop_proto++;
> 			rte_pktmbuf_free(rx_mbuf);
> 			continue;
> 		}
> 		rx_pkts[nb_recv_pkts++] = rx_mbuf;
> +		rxq->rxq_stats.rx_bytes += rx_mbuf->pkt_len;
> 	}
>
> 	/* BUG on duplicate pkt free */
> -	if (unlikely(num_sg))
> +	if (unlikely(num_sg)) {
> +		rxq->rxq_stats.rx_ierror++;
> 		rte_pktmbuf_free(rx_mbuf);
> +	}
> +
> 	/* clean memory */
> 	rxq->next_to_clean = desc_index;
> 	fill_num = rxq->vq_free_cnt;
> @@ -720,6 +728,105 @@ static int nbl_res_txrx_get_stats(void *priv, struct rte_eth_stats *rte_stats)
> 	return 0;
> }
>
> +static int
> +nbl_res_txrx_reset_stats(void *priv)
> +{
> +	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
> +	struct rte_eth_dev *eth_dev = res_mgt->eth_dev;
> +	struct nbl_res_rx_ring *rxq;
> +	struct nbl_rxq_stats *rxq_stats;
> +	struct nbl_res_tx_ring  *txq;
> +	struct nbl_txq_stats *txq_stats;
> +	uint32_t i;
> +
> +	/* Add software counters. */
> +	for (i = 0; i < eth_dev->data->nb_rx_queues; i++) {
> +		rxq = eth_dev->data->rx_queues[i];
> +		if (unlikely(rxq == NULL))
> +			continue;
> +
> +		rxq_stats = &rxq->rxq_stats;
> +		memset(rxq_stats, 0, sizeof(struct nbl_rxq_stats));

What if the application has dedicated lcores for datapath Rx/Tx burst calls and
uses another, admin core to query/reset statistics?

Thank you.

> +	}
> +
> +	for (i = 0; i < eth_dev->data->nb_tx_queues; i++) {
> +		txq = eth_dev->data->tx_queues[i];
> +		if (unlikely(txq == NULL))
> +			continue;
> +
> +		txq_stats = &txq->txq_stats;
> +		memset(txq_stats, 0, sizeof(struct nbl_txq_stats));
> +	}
> +
> +	return 0;
> +}
> +
> +/* store statistics names */
> +struct nbl_txrx_xstats_name {
> +	char name[RTE_ETH_XSTATS_NAME_SIZE];
> +};
> +
> +static const struct nbl_txrx_xstats_name nbl_stats_strings[] = {
> +	{"rx_multidescs_packets"},
> +	{"rx_drop_noport_packets"},
> +	{"rx_drop_proto_packets"},
> +};
> +
> +static int nbl_res_txrx_get_xstats_cnt(__rte_unused void *priv, u16 *xstats_cnt)
> +{
> +	*xstats_cnt = ARRAY_SIZE(nbl_stats_strings);
> +	return 0;
> +}
> +
> +static int nbl_res_txrx_get_xstats(void *priv, struct rte_eth_xstat *xstats, u16 *xstats_cnt)
> +{
> +	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
> +	struct nbl_txrx_mgt *txrx_mgt = NBL_RES_MGT_TO_TXRX_MGT(res_mgt);
> +	struct nbl_res_rx_ring *rxq;
> +	uint64_t rx_multi_descs = 0, rx_drop_noport = 0, rx_drop_proto = 0;
> +	unsigned int i = 0;
> +	u16 count = *xstats_cnt;
> +
> +	/* todo: get eth stats from emp */
> +	for (i = 0; i < txrx_mgt->rx_ring_num; i++) {
> +		rxq = NBL_RES_MGT_TO_RX_RING(res_mgt, i);
> +
> +		if (unlikely(rxq == NULL))
> +			return -EINVAL;
> +
> +		rx_multi_descs += rxq->rxq_stats.rx_multi_descs;
> +		rx_drop_noport += rxq->rxq_stats.rx_drop_noport;
> +		rx_drop_proto += rxq->rxq_stats.rx_drop_proto;
> +	}
> +
> +	xstats[count].value = rx_multi_descs;
> +	xstats[count].id = count;
> +	xstats[count + 1].value = rx_drop_noport;
> +	xstats[count + 1].id = count + 1;
> +	xstats[count + 2].value = rx_drop_proto;
> +	xstats[count + 2].id = count + 2;
> +
> +	*xstats_cnt = count + 3;
> +
> +	return 0;
> +}
> +
> +static int nbl_res_txrx_get_xstats_names(__rte_unused void *priv,
> +					 struct rte_eth_xstat_name *xstats_names,
> +					 u16 *xstats_cnt)
> +{
> +	unsigned int i = 0;
> +	u16 count = *xstats_cnt;
> +
> +	for (i = 0; i < ARRAY_SIZE(nbl_stats_strings); i++) {
> +		strlcpy(xstats_names[count].name, nbl_stats_strings[i].name,
> +			sizeof(nbl_stats_strings[count].name));
> +		count++;
> +	}
> +	*xstats_cnt = count;
> +	return 0;
> +}
> +
> /* NBL_TXRX_SET_OPS(ops_name, func)
>  *
>  * Use X Macros to reduce setup and remove codes.
> @@ -738,6 +845,10 @@ do {										\
> 	NBL_TXRX_SET_OPS(update_rx_ring, nbl_res_txrx_update_rx_ring);		\
> 	NBL_TXRX_SET_OPS(get_resource_pt_ops, nbl_res_get_pt_ops);		\
> 	NBL_TXRX_SET_OPS(get_stats, nbl_res_txrx_get_stats);			\
> +	NBL_TXRX_SET_OPS(reset_stats, nbl_res_txrx_reset_stats);		\
> +	NBL_TXRX_SET_OPS(get_txrx_xstats_cnt, nbl_res_txrx_get_xstats_cnt);	\
> +	NBL_TXRX_SET_OPS(get_txrx_xstats_names, nbl_res_txrx_get_xstats_names);	\
> +	NBL_TXRX_SET_OPS(get_txrx_xstats, nbl_res_txrx_get_xstats);		\
> } while (0)
>
> /* Structure starts here, adding an op should not modify anything below */
> diff --git a/drivers/net/nbl/nbl_include/nbl_def_channel.h b/drivers/net/nbl/nbl_include/nbl_def_channel.h
> index 481a725a3d..39050a3999 100644
> --- a/drivers/net/nbl/nbl_include/nbl_def_channel.h
> +++ b/drivers/net/nbl/nbl_include/nbl_def_channel.h
> @@ -385,6 +385,11 @@ struct nbl_chan_param_get_link_state {
> 	u8 eth_id;
> };
>
> +struct nbl_chan_param_get_private_stat_data {
> +	u32 eth_id;
> +	u32 data_len;
> +};
> +
> struct nbl_chan_send_info {
> 	uint16_t dstid;
> 	uint16_t msg_type;
> diff --git a/drivers/net/nbl/nbl_include/nbl_def_dispatch.h b/drivers/net/nbl/nbl_include/nbl_def_dispatch.h
> index 0139b37ad1..f38a10e5f4 100644
> --- a/drivers/net/nbl/nbl_include/nbl_def_dispatch.h
> +++ b/drivers/net/nbl/nbl_include/nbl_def_dispatch.h
> @@ -74,6 +74,15 @@ struct nbl_dispatch_ops {
> 	void (*get_board_info)(void *priv, struct nbl_board_port_info *board_info);
> 	void (*get_link_state)(void *priv, u8 eth_id, struct nbl_eth_link_info *eth_link_info);
> 	int (*get_stats)(void *priv, struct rte_eth_stats *rte_stats);
> +	int (*reset_stats)(void *priv);
> +	int (*get_txrx_xstats_cnt)(void *priv, u16 *xstats_cnt);
> +	int (*get_txrx_xstats)(void *priv, struct rte_eth_xstat *xstats, u16 *xstats_cnt);
> +	int (*get_txrx_xstats_names)(void *priv, struct rte_eth_xstat_name *xstats_names,
> +				     u16 *xstats_cnt);
> +	int (*get_hw_xstats_cnt)(void *priv, u16 *xstats_cnt);
> +	int (*get_hw_xstats_names)(void *priv, struct rte_eth_xstat_name *xstats_names,
> +				   u16 *xstats_cnt);
> +	void (*get_private_stat_data)(void *priv, u32 eth_id, u64 *data, u32 data_len);
>
> 	void (*dummy_func)(void *priv);
> };
> diff --git a/drivers/net/nbl/nbl_include/nbl_def_resource.h b/drivers/net/nbl/nbl_include/nbl_def_resource.h
> index c14fdc773e..5b32506be1 100644
> --- a/drivers/net/nbl/nbl_include/nbl_def_resource.h
> +++ b/drivers/net/nbl/nbl_include/nbl_def_resource.h
> @@ -46,6 +46,14 @@ struct nbl_resource_ops {
> 	void (*release_rx_ring)(void *priv, u16 queue_idx);
> 	int (*get_stats)(void *priv, struct rte_eth_stats *rte_stats);
> 	int (*reset_stats)(void *priv);
> +	int (*get_txrx_xstats_cnt)(void *priv, u16 *xstats_cnt);
> +	int (*get_txrx_xstats)(void *priv, struct rte_eth_xstat *xstats, u16 *xstats_cnt);
> +	int (*get_txrx_xstats_names)(void *priv, struct rte_eth_xstat_name *xstats_names,
> +				     u16 *xstats_cnt);
> +	int (*get_hw_xstats_cnt)(void *priv, u16 *xstats_cnt);
> +	int (*get_hw_xstats_names)(void *priv, struct rte_eth_xstat_name *xstats_names,
> +				   u16 *xstats_cnt);
> +	void (*get_private_stat_data)(void *priv, u32 eth_id, u64 *data);
> 	void (*update_rx_ring)(void *priv, u16 queue_idx);
> 	u16 (*get_tx_ehdr_len)(void *priv);
> 	int (*alloc_txrx_queues)(void *priv, u16 vsi_id, u16 queue_num);
> @@ -58,10 +66,6 @@ struct nbl_resource_ops {
> 	void (*cfg_txrx_vlan)(void *priv, u16 vlan_tci, u16 vlan_proto);
> 	int (*txrx_burst_mode_get)(void *priv, struct rte_eth_dev *dev,
> 				   struct rte_eth_burst_mode *mode, bool is_tx);
> -	int (*get_txrx_xstats_cnt)(void *priv, u16 *xstats_cnt);
> -	int (*get_txrx_xstats)(void *priv, struct rte_eth_xstat *xstats, u16 *xstats_cnt);
> -	int (*get_txrx_xstats_names)(void *priv, struct rte_eth_xstat_name *xstats_names,
> -				     u16 *xstats_cnt);
> 	int (*add_macvlan)(void *priv, u8 *mac, u16 vlan_id, u16 vsi_id);
> 	void (*del_macvlan)(void *priv, u8 *mac, u16 vlan_id, u16 vsi_id);
> 	int (*add_multi_rule)(void *priv, u16 vsi_id);
> diff --git a/drivers/net/nbl/nbl_include/nbl_include.h b/drivers/net/nbl/nbl_include/nbl_include.h
> index 14c41a0139..a0e18cec20 100644
> --- a/drivers/net/nbl/nbl_include/nbl_include.h
> +++ b/drivers/net/nbl/nbl_include/nbl_include.h
> @@ -50,6 +50,10 @@ typedef int32_t s32;
> typedef int16_t s16;
> typedef int8_t s8;
>
> +#ifndef ARRAY_SIZE
> +#define ARRAY_SIZE(arr) RTE_DIM(arr)
> +#endif
> +
> /* Used for macros to pass checkpatch */
> #define NBL_NAME(x)				x
> #define BIT(a)					(1UL << (a))
> -- 
> 2.34.1
>
>
