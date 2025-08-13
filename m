Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AE6CA0EE0
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 12:06:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 032F240E27;
	Wed, 13 Aug 2025 14:06:55 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id EA276402F1
 for <dev@dpdk.org>; Wed, 13 Aug 2025 14:06:53 +0200 (CEST)
Received: from debian (unknown [78.109.79.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 3B2A4E04CB;
 Wed, 13 Aug 2025 16:06:53 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 3B2A4E04CB
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1755086813;
 bh=E0RP9R7wSb6Smsn44e5sAssU2vLd5p6qqePVpdK5WZY=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=P8bwnPnxQ93rzQhYCMDnGCuUOr1bHLQQLBv4wqvUczlpmYsDAfOWT60zhwAZyi7zS
 UpsPkfqmz3GA+euTfVemTX+dyxlI9DwtJ+GczbQYvINj/B5sIKcrGRlZvTYkgVMNRP
 aH1IHBO6TaBtQAn7K2goWKGqzj1pvDWtIMTdE2wL4CjGciTPzfiVJKiImHdnQ6c8LQ
 qz+3J3ytX+SPQumem2050giao6v+fAfXRj88dbHVJ3x47MEfTkfUPi6FnFA5g5pztX
 4NDUQayddVnF7eHEIMzaHMmUpGHmagvOp5YogFR1dPflECJ9hQ78qzYqZoDEMom7tV
 xSa3rK3467CAg==
Date: Wed, 13 Aug 2025 16:06:51 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
cc: dev@dpdk.org, Kyo Liu <kyo.liu@nebula-matrix.com>, 
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v4 16/16] net/nbl: nbl device support set MTU and promisc
In-Reply-To: <20250813064410.3894506-17-dimon.zhao@nebula-matrix.com>
Message-ID: <10f6f54e-76c8-4037-e3b9-80f170d9546f@arknetworks.am>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20250813064410.3894506-1-dimon.zhao@nebula-matrix.com>
 <20250813064410.3894506-17-dimon.zhao@nebula-matrix.com>
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

> Implement NBL device set MTU and promisc functions
>
> Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
> ---
> drivers/net/nbl/nbl_core.h                    |  2 +
> drivers/net/nbl/nbl_dev/nbl_dev.c             | 57 ++++++++++++++
> drivers/net/nbl/nbl_dev/nbl_dev.h             |  7 +-
> drivers/net/nbl/nbl_dispatch.c                | 77 +++++++++++++++++++
> drivers/net/nbl/nbl_dispatch.h                |  2 +
> drivers/net/nbl/nbl_ethdev.c                  |  3 +
> drivers/net/nbl/nbl_include/nbl_def_channel.h | 10 +++
> .../net/nbl/nbl_include/nbl_def_dispatch.h    |  1 +
> .../net/nbl/nbl_include/nbl_def_resource.h    |  2 +
> 9 files changed, 160 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/nbl/nbl_core.h b/drivers/net/nbl/nbl_core.h
> index 997544b112..d3fe1d02d2 100644
> --- a/drivers/net/nbl/nbl_core.h
> +++ b/drivers/net/nbl/nbl_core.h
> @@ -51,6 +51,8 @@
> #define NBL_IS_NOT_COEXISTENCE(common)		({ typeof(common) _common = (common);	\
> 						_common->nl_socket_route < 0 ||		\
> 						_common->ifindex < 0; })
> +#define NBL_IS_COEXISTENCE(common)		((common)->devfd != -1)
> +
> struct nbl_core {
> 	void *phy_mgt;
> 	void *res_mgt;
> diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.c b/drivers/net/nbl/nbl_dev/nbl_dev.c
> index bab89c707f..8d1423bc14 100644
> --- a/drivers/net/nbl/nbl_dev/nbl_dev.c
> +++ b/drivers/net/nbl/nbl_dev/nbl_dev.c
> @@ -501,6 +501,63 @@ int nbl_xstats_reset(struct rte_eth_dev *eth_dev)
> 	return 0;
> }
>
> +int nbl_mtu_set(struct rte_eth_dev *eth_dev, uint16_t mtu)
> +{
> +	struct rte_eth_dev_data *dev_data = eth_dev->data;
> +	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
> +	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
> +	struct nbl_dispatch_ops *disp_ops = NBL_DEV_MGT_TO_DISP_OPS(dev_mgt);
> +	uint32_t frame_size = mtu + NBL_ETH_OVERHEAD;
> +	int ret;
> +
> +	/* check if mtu is within the allowed range */
> +	if (mtu < RTE_ETHER_MIN_MTU || frame_size > NBL_FRAME_SIZE_MAX)
> +		return -EINVAL;
> +
> +	/* mtu setting is forbidden if port is start */
> +	if (dev_data->dev_started) {
> +		NBL_LOG(ERR, "port %d must be stopped before configuration", dev_data->port_id);
> +		return -EBUSY;
> +	}
> +
> +	dev_data->dev_conf.rxmode.mtu = frame_size;
> +	ret = disp_ops->set_mtu(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), dev_mgt->net_dev->vsi_id, mtu);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +int nbl_promiscuous_enable(struct rte_eth_dev *eth_dev)
> +{
> +	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
> +	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
> +	struct nbl_dispatch_ops *disp_ops = NBL_DEV_MGT_TO_DISP_OPS(dev_mgt);
> +	struct nbl_common_info *common = &adapter->common;
> +
> +	if (!common->is_vf)
> +		disp_ops->set_promisc_mode(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt),
> +					   dev_mgt->net_dev->vsi_id, 1);

And what if this is a VF? Silently ignore / do nothing? Or give an error?

> +	dev_mgt->net_dev->promisc = 1;
> +
> +	return 0;
> +}
> +
> +int nbl_promiscuous_disable(struct rte_eth_dev *eth_dev)
> +{
> +	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
> +	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
> +	struct nbl_dispatch_ops *disp_ops = NBL_DEV_MGT_TO_DISP_OPS(dev_mgt);
> +	struct nbl_common_info *common = &adapter->common;
> +
> +	if (!common->is_vf)
> +		disp_ops->set_promisc_mode(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt),
> +					   dev_mgt->net_dev->vsi_id, 0);

Same question here.

Thank you.

> +	dev_mgt->net_dev->promisc = 0;
> +
> +	return 0;
> +}
> +
> struct nbl_dev_ops dev_ops = {
> };
>
> diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.h b/drivers/net/nbl/nbl_dev/nbl_dev.h
> index 1500a782a5..e3a7a098a5 100644
> --- a/drivers/net/nbl/nbl_dev/nbl_dev.h
> +++ b/drivers/net/nbl/nbl_dev/nbl_dev.h
> @@ -47,7 +47,9 @@ struct nbl_dev_net_mgt {
> 	u8 eth_mode;
> 	u8 eth_id;
> 	u16 max_mac_num;
> -	bool trust;
> +	u8 trust:1;
> +	u8 promisc:1;
> +	u8 rsv:6;
> };
>
> struct nbl_dev_mgt {
> @@ -79,5 +81,8 @@ int nbl_xstats_get_names(struct rte_eth_dev *eth_dev,
> 			 struct rte_eth_xstat_name *xstats_names,
> 			 __rte_unused unsigned int limit);
> int nbl_xstats_reset(struct rte_eth_dev *eth_dev);
> +int nbl_mtu_set(struct rte_eth_dev *eth_dev, uint16_t mtu);
> +int nbl_promiscuous_enable(struct rte_eth_dev *eth_dev);
> +int nbl_promiscuous_disable(struct rte_eth_dev *eth_dev);
>
> #endif
> diff --git a/drivers/net/nbl/nbl_dispatch.c b/drivers/net/nbl/nbl_dispatch.c
> index 15ea61d8e4..8d805e2ee6 100644
> --- a/drivers/net/nbl/nbl_dispatch.c
> +++ b/drivers/net/nbl/nbl_dispatch.c
> @@ -897,6 +897,74 @@ static void nbl_disp_get_private_stat_data_req(void *priv, u32 eth_id, u64 *data
> 	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
> }
>
> +static int nbl_disp_set_mtu(void *priv, u16 vsi_id, u16 mtu)
> +{
> +	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
> +	struct nbl_resource_ops *res_ops;
> +	int ret = 0;
> +
> +	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
> +	ret = NBL_OPS_CALL(res_ops->set_mtu, (NBL_DISP_MGT_TO_RES_PRIV(disp_mgt), vsi_id, mtu));
> +	return ret;
> +}
> +
> +static int nbl_disp_chan_set_mtu_req(void *priv, u16 vsi_id, u16 mtu)
> +{
> +	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
> +	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
> +	struct nbl_chan_send_info chan_send = {0};
> +	struct nbl_chan_param_set_mtu param = {0};
> +
> +	param.mtu = mtu;
> +	param.vsi_id = vsi_id;
> +
> +	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_MTU_SET,
> +		      &param, sizeof(param), NULL, 0, 1);
> +	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
> +				  &chan_send);
> +}
> +
> +static int nbl_disp_set_promisc_mode(void *priv, u16 vsi_id, u16 mode)
> +{
> +	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
> +	struct nbl_resource_ops *res_ops;
> +	int ret = 0;
> +
> +	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
> +	ret = NBL_OPS_CALL(res_ops->set_promisc_mode,
> +			   (NBL_DISP_MGT_TO_RES_PRIV(disp_mgt), vsi_id, mode));
> +	return ret;
> +}
> +
> +static int nbl_disp_chan_set_promisc_mode_req(void *priv, u16 vsi_id, u16 mode)
> +{
> +	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
> +	struct nbl_common_info *common;
> +	struct nbl_channel_ops *chan_ops;
> +	struct nbl_chan_param_set_promisc_mode param = {0};
> +	struct nbl_chan_send_info chan_send = {0};
> +	int ret = 0;
> +
> +	common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
> +	if (NBL_IS_COEXISTENCE(common)) {
> +		ret = ioctl(common->devfd, NBL_DEV_USER_SET_PROMISC_MODE, &mode);
> +		if (ret) {
> +			NBL_LOG(ERR, "userspace send set_promisc_mode ioctl msg failed ret %d",
> +				ret);
> +			return ret;
> +		}
> +		return 0;
> +	}
> +
> +	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
> +	param.vsi_id = vsi_id;
> +	param.mode = mode;
> +	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_SET_PROSISC_MODE,
> +		      &param, sizeof(param), NULL, 0, 1);
> +	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
> +				  &chan_send);
> +}
> +
> #define NBL_DISP_OPS_TBL						\
> do {									\
> 	NBL_DISP_SET_OPS(configure_msix_map, nbl_disp_configure_msix_map,			\
> @@ -1067,6 +1135,14 @@ do {									\
> 			 NBL_DISP_CTRL_LVL_MGT,				\
> 			 NBL_CHAN_MSG_GET_ETH_STATS,			\
> 			 nbl_disp_get_private_stat_data_req, NULL);	\
> +	NBL_DISP_SET_OPS(set_promisc_mode, nbl_disp_set_promisc_mode,	\
> +			 NBL_DISP_CTRL_LVL_MGT,				\
> +			 NBL_CHAN_MSG_SET_PROSISC_MODE,			\
> +			 nbl_disp_chan_set_promisc_mode_req, NULL);	\
> +	NBL_DISP_SET_OPS(set_mtu, nbl_disp_set_mtu,			\
> +			 NBL_DISP_CTRL_LVL_MGT,	NBL_CHAN_MSG_MTU_SET,	\
> +			 nbl_disp_chan_set_mtu_req,			\
> +			 NULL);						\
> } while (0)
>
> /* Structure starts here, adding an op should not modify anything below */
> @@ -1182,6 +1258,7 @@ int nbl_disp_init(void *p)
> 	NBL_DISP_MGT_TO_RES_OPS_TBL(*disp_mgt) = res_ops_tbl;
> 	NBL_DISP_MGT_TO_CHAN_OPS_TBL(*disp_mgt) = chan_ops_tbl;
> 	NBL_DISP_MGT_TO_DISP_OPS_TBL(*disp_mgt) = *disp_ops_tbl;
> +	NBL_DISP_MGT_TO_COMMON(*disp_mgt) = NBL_ADAPTER_TO_COMMON(adapter);
>
> 	if (disp_product_ops->dispatch_init) {
> 		ret = disp_product_ops->dispatch_init(*disp_mgt);
> diff --git a/drivers/net/nbl/nbl_dispatch.h b/drivers/net/nbl/nbl_dispatch.h
> index dcdf87576a..d1572769fe 100644
> --- a/drivers/net/nbl/nbl_dispatch.h
> +++ b/drivers/net/nbl/nbl_dispatch.h
> @@ -16,11 +16,13 @@
> #define NBL_DISP_MGT_TO_DISP_OPS_TBL(disp_mgt)	((disp_mgt)->disp_ops_tbl)
> #define NBL_DISP_MGT_TO_DISP_OPS(disp_mgt)	(NBL_DISP_MGT_TO_DISP_OPS_TBL(disp_mgt)->ops)
> #define NBL_DISP_MGT_TO_DISP_PRIV(disp_mgt)	(NBL_DISP_MGT_TO_DISP_OPS_TBL(disp_mgt)->priv)
> +#define NBL_DISP_MGT_TO_COMMON(disp_mgt)	((disp_mgt)->common)
>
> struct nbl_dispatch_mgt {
> 	struct nbl_resource_ops_tbl *res_ops_tbl;
> 	struct nbl_channel_ops_tbl *chan_ops_tbl;
> 	struct nbl_dispatch_ops_tbl *disp_ops_tbl;
> +	struct nbl_common_info *common;
> 	uint32_t ctrl_lvl;
> };
>
> diff --git a/drivers/net/nbl/nbl_ethdev.c b/drivers/net/nbl/nbl_ethdev.c
> index 81b8946acc..d1c5f898b7 100644
> --- a/drivers/net/nbl/nbl_ethdev.c
> +++ b/drivers/net/nbl/nbl_ethdev.c
> @@ -45,6 +45,9 @@ const struct eth_dev_ops nbl_eth_dev_ops = {
> 	.xstats_get = nbl_xstats_get,
> 	.xstats_get_names = nbl_xstats_get_names,
> 	.xstats_reset = nbl_xstats_reset,
> +	.mtu_set = nbl_mtu_set,
> +	.promiscuous_enable = nbl_promiscuous_enable,
> +	.promiscuous_disable = nbl_promiscuous_disable,
> };
>
> static int nbl_eth_dev_init(struct rte_eth_dev *eth_dev)
> diff --git a/drivers/net/nbl/nbl_include/nbl_def_channel.h b/drivers/net/nbl/nbl_include/nbl_def_channel.h
> index 39050a3999..86726177ed 100644
> --- a/drivers/net/nbl/nbl_include/nbl_def_channel.h
> +++ b/drivers/net/nbl/nbl_include/nbl_def_channel.h
> @@ -422,6 +422,16 @@ enum nbl_chan_queue_state {
> 	NBL_CHAN_STATE_NBITS
> };
>
> +struct nbl_chan_param_set_promisc_mode {
> +	u16 vsi_id;
> +	u16 mode;
> +};
> +
> +struct nbl_chan_param_set_mtu {
> +	u16 vsi_id;
> +	u16 mtu;
> +};
> +
> struct nbl_channel_ops {
> 	int (*send_msg)(void *priv, struct nbl_chan_send_info *chan_send);
> 	int (*send_ack)(void *priv, struct nbl_chan_ack_info *chan_ack);
> diff --git a/drivers/net/nbl/nbl_include/nbl_def_dispatch.h b/drivers/net/nbl/nbl_include/nbl_def_dispatch.h
> index f38a10e5f4..717b92ac8f 100644
> --- a/drivers/net/nbl/nbl_include/nbl_def_dispatch.h
> +++ b/drivers/net/nbl/nbl_include/nbl_def_dispatch.h
> @@ -37,6 +37,7 @@ struct nbl_dispatch_ops {
> 	void (*clear_flow)(void *priv, u16 vsi_id);
> 	void (*get_firmware_version)(void *priv, char *firmware_version, u8 max_len);
> 	int (*set_promisc_mode)(void *priv, u16 vsi_id, u16 mode);
> +	int (*set_mtu)(void *priv, u16 vsi_id, u16 mtu);
> 	int (*alloc_txrx_queues)(void *priv, u16 vsi_id, u16 queue_num);
> 	void (*free_txrx_queues)(void *priv, u16 vsi_id);
> 	u16 (*get_vsi_id)(void *priv);
> diff --git a/drivers/net/nbl/nbl_include/nbl_def_resource.h b/drivers/net/nbl/nbl_include/nbl_def_resource.h
> index 5b32506be1..a7794f314c 100644
> --- a/drivers/net/nbl/nbl_include/nbl_def_resource.h
> +++ b/drivers/net/nbl/nbl_include/nbl_def_resource.h
> @@ -76,6 +76,8 @@ struct nbl_resource_ops {
> 	int (*setup_cqs)(void *priv, u16 vsi_id, u16 real_qps, bool rss_indir_set);
> 	void (*remove_cqs)(void *priv, u16 vsi_id);
> 	void (*get_link_state)(void *priv, u8 eth_id, struct nbl_eth_link_info *eth_link_info);
> +	int (*set_promisc_mode)(void *priv, u16 vsi_id, u16 mode);
> +	int (*set_mtu)(void *priv, u16 vsi_id, u16 mtu);
> };
>
> struct nbl_resource_ops_tbl {
> -- 
> 2.34.1
>
>
