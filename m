Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CC9C98314
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 06:39:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57CCB42F39;
	Thu, 24 Sep 2026 08:39:07 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id C692C42F41
 for <dev@dpdk.org>; Thu, 24 Sep 2026 08:39:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790231944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gQGRkWcd3a12Uk98YT3v62C3znn4BEMmudbGtrFBlKU=;
 b=SSEwKMZjNR4hMc+p9IVJzNkBleQ6zHfPoUFFZqDJdy20Tp4Di/Otl50V3scwOsG3I53u2j
 ozjR2O/PZ2xGLdUAAcvvVYEziPLoa7ORHRnlH1T1Wudi4gT9OwA3wXnHoz5o4i8Zf6RW+N
 DvV6OSN0bTzR+TlSezU6iRvfdjykdJU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-zC5LnxUmPLiy9KIqEFcazg-1; Thu,
 24 Sep 2026 02:39:02 -0400
X-MC-Unique: zC5LnxUmPLiy9KIqEFcazg-1
X-Mimecast-MFC-AGG-ID: zC5LnxUmPLiy9KIqEFcazg_1790231941
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 38EF1180065F; Thu, 24 Sep 2026 06:39:01 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C6E4B18005B3; Thu, 24 Sep 2026 06:38:58 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: rjarry@redhat.com, cfontain@redhat.com,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v9 5/5] net/mlx5: accept more unicast MAC addresses
Date: Thu, 24 Sep 2026 08:38:35 +0200
Message-ID: <20260924063836.355745-5-david.marchand@redhat.com>
In-Reply-To: <20260924063836.355745-1-david.marchand@redhat.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260924063836.355745-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: y_W0bFohB_HfcU5PAm_32CcOP5Nt-H-TUdGzP3WmVsE_1790231941
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Starting firmware version 22.49.1014, the number of mac addresses
per VF is not capped to 128 anymore.

The value can be increased via devlink:
$ devlink dev param set pci/0000:3b:00.2 name max_macs value 4096 \
	cmode driverinit
$ devlink dev reload pci/0000:3b:00.2

On the DPDK side, we must retrieve the maximum number of unicast
and multicast addresses supported with a query to the firmware.

Then, dynamically allocate the mac addresses arrays and report the
limit instead of the previous hardcoded value.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v8:
- fixed (hopefully...) last thing in HWS stuff,

Changes since v7:
- updated HWS control path and removed MLX5_MAX_MAC_ADDRESSES constant,

Changes since v6:
- fixed crash in case of partial init failure in mlx5_dev_spawn,
  and cleaned mlx5_os_pci_probe_pf,
- fixed compilation without assert in mlx5_internal_mac_addr_remove,

Changes since v4:
- added RN update,
- fixed types of fields added to mlx5_hca_attr and mlx5_dev_cap,
- used RTE_BIT32,
- fixed mlx5_nl_mac_addr_sync inverted arguments,

---
 doc/guides/rel_notes/release_26_11.rst |  5 +++
 drivers/common/mlx5/mlx5_devx_cmds.c   |  4 ++
 drivers/common/mlx5/mlx5_devx_cmds.h   |  2 +
 drivers/net/mlx5/linux/mlx5_os.c       | 47 +++++++++++++++++------
 drivers/net/mlx5/mlx5.c                |  9 ++---
 drivers/net/mlx5/mlx5.h                | 11 +++---
 drivers/net/mlx5/mlx5_ethdev.c         |  2 +-
 drivers/net/mlx5/mlx5_flow_hw.c        | 53 +++++++++++++++++---------
 drivers/net/mlx5/mlx5_mac.c            | 20 ++++++----
 drivers/net/mlx5/mlx5_trigger.c        | 10 ++---
 drivers/net/mlx5/windows/mlx5_os.c     | 41 ++++++++++++++++----
 11 files changed, 140 insertions(+), 64 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 87c7e81bde..43043cd579 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -55,6 +55,11 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Updated NVIDIA mlx5 ethernet driver.**
+
+  * Increased the maximum number of secondary unicast MAC addresses from 128 to up to 4096
+    (depending on devlink configuration on the associated kernel netdevice).
+
 
 Removed Items
 -------------
diff --git a/drivers/common/mlx5/mlx5_devx_cmds.c b/drivers/common/mlx5/mlx5_devx_cmds.c
index 140b057ab4..e5d9c92779 100644
--- a/drivers/common/mlx5/mlx5_devx_cmds.c
+++ b/drivers/common/mlx5/mlx5_devx_cmds.c
@@ -1110,6 +1110,10 @@ mlx5_devx_cmd_query_hca_attr(void *ctx,
 	attr->log_max_pd = MLX5_GET(cmd_hca_cap, hcattr, log_max_pd);
 	attr->log_max_srq = MLX5_GET(cmd_hca_cap, hcattr, log_max_srq);
 	attr->log_max_srq_sz = MLX5_GET(cmd_hca_cap, hcattr, log_max_srq_sz);
+	attr->log_max_current_uc_list = MLX5_GET(cmd_hca_cap, hcattr,
+						 log_max_current_uc_list);
+	attr->log_max_current_mc_list = MLX5_GET(cmd_hca_cap, hcattr,
+						 log_max_current_mc_list);
 	attr->reg_c_preserve =
 		MLX5_GET(cmd_hca_cap, hcattr, reg_c_preserve);
 	attr->mmo_regex_qp_en = MLX5_GET(cmd_hca_cap, hcattr, regexp_mmo_qp);
diff --git a/drivers/common/mlx5/mlx5_devx_cmds.h b/drivers/common/mlx5/mlx5_devx_cmds.h
index 90beb2e9e6..504b4a4f64 100644
--- a/drivers/common/mlx5/mlx5_devx_cmds.h
+++ b/drivers/common/mlx5/mlx5_devx_cmds.h
@@ -356,6 +356,8 @@ struct mlx5_hca_attr {
 	uint8_t tx_sw_owner_v2:1;
 	uint8_t esw_sw_owner:1;
 	uint8_t esw_sw_owner_v2:1;
+	uint8_t log_max_current_uc_list:5;
+	uint8_t log_max_current_mc_list:5;
 };
 
 /* LAG Context. */
diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index 7d8ea4acba..9180e9aa20 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -389,6 +389,16 @@ mlx5_os_capabilities_prepare(struct mlx5_dev_ctx_shared *sh)
 	sh->dev_cap.esw_info.regc_mask = 0;
 #endif
 	sh->dev_cap.esw_info.is_set = 1;
+	if (hca_attr->log_max_current_uc_list > 0)
+		sh->dev_cap.max_uc_mac_addrs = RTE_BIT32(hca_attr->log_max_current_uc_list);
+	else
+		sh->dev_cap.max_uc_mac_addrs = MLX5_MAX_UC_MAC_ADDRESSES;
+	if (hca_attr->log_max_current_mc_list > 0)
+		sh->dev_cap.max_mc_mac_addrs = RTE_BIT32(hca_attr->log_max_current_mc_list);
+	else
+		sh->dev_cap.max_mc_mac_addrs = MLX5_MAX_MC_MAC_ADDRESSES;
+	sh->dev_cap.max_mac_addrs =
+		sh->dev_cap.max_uc_mac_addrs + sh->dev_cap.max_mc_mac_addrs;
 	return 0;
 }
 
@@ -1464,6 +1474,22 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 	priv->sh = sh;
 	priv->dev_port = spawn->phys_port;
 	priv->pci_dev = spawn->pci_dev;
+	priv->mac = mlx5_malloc(MLX5_MEM_ZERO | MLX5_MEM_RTE,
+				sizeof(*priv->mac) * sh->dev_cap.max_mac_addrs,
+				RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+	if (priv->mac == NULL) {
+		DRV_LOG(ERR, "Failed to allocate MAC address array.");
+		err = ENOMEM;
+		goto error;
+	}
+	priv->mac_own = mlx5_malloc(MLX5_MEM_ZERO | MLX5_MEM_RTE,
+				    RTE_BITSET_SIZE(sh->dev_cap.max_mac_addrs),
+				    RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+	if (priv->mac_own == NULL) {
+		DRV_LOG(ERR, "Failed to allocate MAC ownership bitmap.");
+		err = ENOMEM;
+		goto error;
+	}
 	/* Some internal functions rely on Netlink sockets, open them now. */
 	priv->nl_socket_rdma = nl_rdma;
 	priv->nl_socket_route =	mlx5_nl_init(NETLINK_ROUTE, 0);
@@ -1762,8 +1788,8 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 		mlx5_nl_mac_addr_sync(priv->nl_socket_route,
 				      mlx5_ifindex(eth_dev),
 				      eth_dev->data->mac_addrs,
-				      MLX5_MAX_UC_MAC_ADDRESSES,
-				      MLX5_MAX_MAC_ADDRESSES);
+				      sh->dev_cap.max_uc_mac_addrs,
+				      sh->dev_cap.max_mac_addrs);
 	priv->ctrl_flows = 0;
 	rte_spinlock_init(&priv->flow_list_lock);
 	TAILQ_INIT(&priv->flow_meters);
@@ -1963,17 +1989,16 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 			mlx5_flex_item_port_cleanup(eth_dev);
 		mlx5_free(priv->ext_rxqs);
 		mlx5_free(priv->ext_txqs);
+		mlx5_free(priv->mac);
+		mlx5_free(priv->mac_own);
 		mlx5_free(priv);
-		if (eth_dev != NULL)
+		if (eth_dev != NULL) {
+			eth_dev->data->mac_addrs = NULL;
 			eth_dev->data->dev_private = NULL;
+		}
 	}
-	if (eth_dev != NULL) {
-		/* mac_addrs must not be freed alone because part of
-		 * dev_private
-		 **/
-		eth_dev->data->mac_addrs = NULL;
+	if (eth_dev != NULL)
 		rte_eth_dev_release_port(eth_dev);
-	}
 	if (sh)
 		mlx5_free_shared_dev_ctx(sh);
 	if (nl_rdma >= 0)
@@ -2979,8 +3004,6 @@ mlx5_os_pci_probe_pf(struct mlx5_common_device *cdev,
 			if (!list[i].eth_dev)
 				continue;
 			mlx5_dev_close(list[i].eth_dev);
-			/* mac_addrs must not be freed because in dev_private */
-			list[i].eth_dev->data->mac_addrs = NULL;
 			claim_zero(rte_eth_dev_release_port(list[i].eth_dev));
 		}
 		/* Restore original error. */
@@ -3531,7 +3554,7 @@ mlx5_os_mac_addr_flush(struct rte_eth_dev *dev)
 	const int vf = priv->sh->dev_cap.vf;
 	int i;
 
-	for (i = MLX5_MAX_MAC_ADDRESSES - 1; i >= 0; --i) {
+	for (i = priv->sh->dev_cap.max_mac_addrs - 1; i >= 0; --i) {
 		if (rte_bitset_test(priv->mac_own, i)) {
 			if (vf)
 				mlx5_nl_mac_addr_remove(priv->nl_socket_route,
diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index c7b0d3ef8b..4bd1c6d1c0 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -2556,6 +2556,9 @@ mlx5_dev_close(struct rte_eth_dev *dev)
 		mlx5_list_destroy(priv->hrxqs);
 	mlx5_free(priv->ext_rxqs);
 	mlx5_free(priv->ext_txqs);
+	mlx5_free(priv->mac);
+	dev->data->mac_addrs = NULL;
+	mlx5_free(priv->mac_own);
 	sh->port[priv->dev_port - 1].nl_ih_port_id = RTE_MAX_ETHPORTS;
 	/*
 	 * The interrupt handler port id must be reset before priv is reset
@@ -2590,12 +2593,6 @@ mlx5_dev_close(struct rte_eth_dev *dev)
 	mlx5_flow_pools_destroy(priv);
 	memset(priv, 0, sizeof(*priv));
 	priv->domain_id = RTE_ETH_DEV_SWITCH_DOMAIN_ID_INVALID;
-	/*
-	 * Reset mac_addrs to NULL such that it is not freed as part of
-	 * rte_eth_dev_release_port(). mac_addrs is part of dev_private so
-	 * it is freed when dev_private is freed.
-	 */
-	dev->data->mac_addrs = NULL;
 	return 0;
 }
 
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index 7f20c811f3..e3df458915 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -87,9 +87,6 @@
 #define MLX5_MAX_UC_MAC_ADDRESSES 128
 /* Maximum number of simultaneous Multicast MAC addresses. */
 #define MLX5_MAX_MC_MAC_ADDRESSES 128
-/* Maximum number of simultaneous MAC addresses. */
-#define MLX5_MAX_MAC_ADDRESSES \
-	(MLX5_MAX_UC_MAC_ADDRESSES + MLX5_MAX_MC_MAC_ADDRESSES)
 
 enum mlx5_ipool_index {
 #if defined(HAVE_IBV_FLOW_DV_SUPPORT) || !defined(HAVE_INFINIBAND_VERBS_H)
@@ -217,6 +214,9 @@ struct mlx5_dev_cap {
 	} mprq; /* Capability for Multi-Packet RQ. */
 	char fw_ver[64]; /* Firmware version of this device. */
 	struct flow_hw_port_info esw_info; /* E-switch manager reg_c0. */
+	uint32_t max_uc_mac_addrs; /* Maximum unicast MAC addresses. */
+	uint32_t max_mc_mac_addrs; /* Maximum multicast MAC addresses. */
+	uint32_t max_mac_addrs; /* Total maximum MAC addresses. */
 };
 
 #define MLX5_MPESW_PORT_INVALID (-1)
@@ -2018,9 +2018,8 @@ struct mlx5_priv {
 	struct mlx5_dev_ctx_shared *sh; /* Shared device context. */
 	uint32_t dev_port; /* Device port number. */
 	struct rte_pci_device *pci_dev; /* Backend PCI device. */
-	struct rte_ether_addr mac[MLX5_MAX_MAC_ADDRESSES]; /* MAC addresses. */
-	RTE_BITSET_DECLARE(mac_own, MLX5_MAX_MAC_ADDRESSES);
-	/* Bit-field of MAC addresses owned by the PMD. */
+	struct rte_ether_addr *mac; /* MAC addresses. */
+	uint64_t *mac_own; /* Bit-field of MAC addresses owned by the PMD. */
 	uint16_t vlan_filter[MLX5_MAX_VLAN_IDS]; /* VLAN filters table. */
 	unsigned int vlan_filter_n; /* Number of configured VLAN filters. */
 	/* Device properties. */
diff --git a/drivers/net/mlx5/mlx5_ethdev.c b/drivers/net/mlx5/mlx5_ethdev.c
index 8160d10e7e..306c1cd734 100644
--- a/drivers/net/mlx5/mlx5_ethdev.c
+++ b/drivers/net/mlx5/mlx5_ethdev.c
@@ -392,7 +392,7 @@ mlx5_dev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *info)
 	max = RTE_MIN(max, (unsigned int)UINT16_MAX);
 	info->max_rx_queues = max;
 	info->max_tx_queues = max;
-	info->max_mac_addrs = MLX5_MAX_UC_MAC_ADDRESSES;
+	info->max_mac_addrs = priv->sh->dev_cap.max_uc_mac_addrs;
 	info->rx_queue_offload_capa = mlx5_get_rx_queue_offloads(dev);
 	info->rx_seg_capa.max_nseg = MLX5_MAX_RXQ_NSEG;
 	info->rx_seg_capa.multi_pools = !priv->config.mprq.enabled;
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 30ef2f1c2d..8dabf21b76 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -11576,22 +11576,37 @@ static uint32_t ctrl_rx_rss_priority_map[MLX5_FLOW_HW_CTRL_RX_EXPANDED_RSS_MAX]
 	[MLX5_FLOW_HW_CTRL_RX_EXPANDED_RSS_IPV6_TCP] = MLX5_HW_CTRL_RX_PRIO_L4,
 };
 
-static uint32_t ctrl_rx_nb_flows_map[MLX5_FLOW_HW_CTRL_RX_ETH_PATTERN_MAX] = {
-	[MLX5_FLOW_HW_CTRL_RX_ETH_PATTERN_ALL] = 1,
-	[MLX5_FLOW_HW_CTRL_RX_ETH_PATTERN_ALL_MCAST] = 1,
-	[MLX5_FLOW_HW_CTRL_RX_ETH_PATTERN_BCAST] = 1,
-	[MLX5_FLOW_HW_CTRL_RX_ETH_PATTERN_BCAST_VLAN] = MLX5_MAX_VLAN_IDS,
-	[MLX5_FLOW_HW_CTRL_RX_ETH_PATTERN_IPV4_MCAST] = 1,
-	[MLX5_FLOW_HW_CTRL_RX_ETH_PATTERN_IPV4_MCAST_VLAN] = MLX5_MAX_VLAN_IDS,
-	[MLX5_FLOW_HW_CTRL_RX_ETH_PATTERN_IPV6_MCAST] = 1,
-	[MLX5_FLOW_HW_CTRL_RX_ETH_PATTERN_IPV6_MCAST_VLAN] = MLX5_MAX_VLAN_IDS,
-	[MLX5_FLOW_HW_CTRL_RX_ETH_PATTERN_DMAC] = MLX5_MAX_UC_MAC_ADDRESSES,
-	[MLX5_FLOW_HW_CTRL_RX_ETH_PATTERN_DMAC_VLAN] =
-			MLX5_MAX_UC_MAC_ADDRESSES * MLX5_MAX_VLAN_IDS,
-};
+static uint32_t
+flow_hw_get_ctrl_rx_nb_flows(struct rte_eth_dev *dev,
+			     enum mlx5_flow_ctrl_rx_eth_pattern_type eth_pattern_type)
+{
+	struct mlx5_priv *priv = dev->data->dev_private;
+	uint32_t max_uc_mac_addrs = priv->sh->dev_cap.max_uc_mac_addrs;
+
+	switch (eth_pattern_type) {
+	case MLX5_FLOW_HW_CTRL_RX_ETH_PATTERN_ALL:
+	case MLX5_FLOW_HW_CTRL_RX_ETH_PATTERN_ALL_MCAST:
+	case MLX5_FLOW_HW_CTRL_RX_ETH_PATTERN_BCAST:
+	case MLX5_FLOW_HW_CTRL_RX_ETH_PATTERN_IPV4_MCAST:
+	case MLX5_FLOW_HW_CTRL_RX_ETH_PATTERN_IPV6_MCAST:
+		return 1;
+	case MLX5_FLOW_HW_CTRL_RX_ETH_PATTERN_BCAST_VLAN:
+	case MLX5_FLOW_HW_CTRL_RX_ETH_PATTERN_IPV4_MCAST_VLAN:
+	case MLX5_FLOW_HW_CTRL_RX_ETH_PATTERN_IPV6_MCAST_VLAN:
+		return MLX5_MAX_VLAN_IDS;
+	case MLX5_FLOW_HW_CTRL_RX_ETH_PATTERN_DMAC:
+		return max_uc_mac_addrs;
+	case MLX5_FLOW_HW_CTRL_RX_ETH_PATTERN_DMAC_VLAN:
+		return max_uc_mac_addrs * MLX5_MAX_VLAN_IDS;
+	default:
+		MLX5_ASSERT(false);
+		return 0;
+	}
+}
 
 static struct rte_flow_template_table_attr
-flow_hw_get_ctrl_rx_table_attr(enum mlx5_flow_ctrl_rx_eth_pattern_type eth_pattern_type,
+flow_hw_get_ctrl_rx_table_attr(struct rte_eth_dev *dev,
+			       enum mlx5_flow_ctrl_rx_eth_pattern_type eth_pattern_type,
 			       const enum mlx5_flow_ctrl_rx_expanded_rss_type rss_type)
 {
 	return (struct rte_flow_template_table_attr){
@@ -11600,7 +11615,7 @@ flow_hw_get_ctrl_rx_table_attr(enum mlx5_flow_ctrl_rx_eth_pattern_type eth_patte
 			.priority = ctrl_rx_rss_priority_map[rss_type],
 			.ingress = 1,
 		},
-		.nb_flows = ctrl_rx_nb_flows_map[eth_pattern_type],
+		.nb_flows = flow_hw_get_ctrl_rx_nb_flows(dev, eth_pattern_type),
 	};
 }
 
@@ -11763,7 +11778,8 @@ mlx5_flow_hw_create_ctrl_rx_tables(struct rte_eth_dev *dev)
 			struct rte_flow_template_table_attr attr;
 			struct rte_flow_pattern_template *pt;
 
-			attr = flow_hw_get_ctrl_rx_table_attr(eth_pattern_type, rss_type);
+			attr = flow_hw_get_ctrl_rx_table_attr(dev, eth_pattern_type,
+							      rss_type);
 			pt = flow_hw_create_ctrl_rx_pattern_template(dev, eth_pattern_type,
 								     rss_type);
 			if (!pt)
@@ -16697,10 +16713,11 @@ __flow_hw_ctrl_flows_unicast(struct rte_eth_dev *dev,
 			     struct rte_flow_template_table *tbl,
 			     const enum mlx5_flow_ctrl_rx_expanded_rss_type rss_type)
 {
+	struct mlx5_priv *priv = dev->data->dev_private;
 	unsigned int i;
 	int ret;
 
-	for (i = 0; i < MLX5_MAX_MAC_ADDRESSES; ++i) {
+	for (i = 0; i < priv->sh->dev_cap.max_mac_addrs; ++i) {
 		struct rte_ether_addr *mac = &dev->data->mac_addrs[i];
 
 		if (rte_is_zero_ether_addr(mac))
@@ -16767,7 +16784,7 @@ __flow_hw_ctrl_flows_unicast_vlan(struct rte_eth_dev *dev,
 	unsigned int i;
 	unsigned int j;
 
-	for (i = 0; i < MLX5_MAX_MAC_ADDRESSES; ++i) {
+	for (i = 0; i < priv->sh->dev_cap.max_mac_addrs; ++i) {
 		struct rte_ether_addr *mac = &dev->data->mac_addrs[i];
 
 		if (rte_is_zero_ether_addr(mac))
diff --git a/drivers/net/mlx5/mlx5_mac.c b/drivers/net/mlx5/mlx5_mac.c
index 0e5d2be530..9e7bf7f2ec 100644
--- a/drivers/net/mlx5/mlx5_mac.c
+++ b/drivers/net/mlx5/mlx5_mac.c
@@ -36,7 +36,7 @@ mlx5_internal_mac_addr_remove(struct rte_eth_dev *dev,
 			      uint32_t index,
 			      struct rte_ether_addr *addr)
 {
-	MLX5_ASSERT(index < MLX5_MAX_MAC_ADDRESSES);
+	MLX5_ASSERT(index < MLX5_SH(dev)->dev_cap.max_mac_addrs);
 	if (rte_is_zero_ether_addr(&dev->data->mac_addrs[index]))
 		return false;
 	mlx5_os_mac_addr_remove(dev, index);
@@ -63,16 +63,17 @@ static int
 mlx5_internal_mac_addr_add(struct rte_eth_dev *dev, struct rte_ether_addr *mac,
 			   uint32_t index)
 {
+	struct mlx5_priv *priv = dev->data->dev_private;
 	unsigned int i;
 	int ret;
 
-	MLX5_ASSERT(index < MLX5_MAX_MAC_ADDRESSES);
+	MLX5_ASSERT(index < priv->sh->dev_cap.max_mac_addrs);
 	if (rte_is_zero_ether_addr(mac)) {
 		rte_errno = EINVAL;
 		return -rte_errno;
 	}
 	/* First, make sure this address isn't already configured. */
-	for (i = 0; (i != MLX5_MAX_MAC_ADDRESSES); ++i) {
+	for (i = 0; i != priv->sh->dev_cap.max_mac_addrs; ++i) {
 		/* Skip this index, it's going to be reconfigured. */
 		if (i == index)
 			continue;
@@ -101,10 +102,11 @@ mlx5_internal_mac_addr_add(struct rte_eth_dev *dev, struct rte_ether_addr *mac,
 void
 mlx5_mac_addr_remove(struct rte_eth_dev *dev, uint32_t index)
 {
+	struct mlx5_priv *priv = dev->data->dev_private;
 	struct rte_ether_addr addr = { 0 };
 	int ret;
 
-	if (index >= MLX5_MAX_UC_MAC_ADDRESSES)
+	if (index >= priv->sh->dev_cap.max_uc_mac_addrs)
 		return;
 	if (mlx5_internal_mac_addr_remove(dev, index, &addr)) {
 		ret = mlx5_traffic_mac_remove(dev, &addr);
@@ -133,9 +135,10 @@ int
 mlx5_mac_addr_add(struct rte_eth_dev *dev, struct rte_ether_addr *mac,
 		  uint32_t index, uint32_t vmdq __rte_unused)
 {
+	struct mlx5_priv *priv = dev->data->dev_private;
 	int ret;
 
-	if (index >= MLX5_MAX_UC_MAC_ADDRESSES) {
+	if (index >= priv->sh->dev_cap.max_uc_mac_addrs) {
 		rte_errno = EINVAL;
 		return -rte_errno;
 	}
@@ -217,16 +220,17 @@ int
 mlx5_set_mc_addr_list(struct rte_eth_dev *dev,
 		      struct rte_ether_addr *mc_addr_set, uint32_t nb_mc_addr)
 {
+	struct mlx5_priv *priv = dev->data->dev_private;
 	uint32_t i;
 	int ret;
 
-	if (nb_mc_addr >= MLX5_MAX_MC_MAC_ADDRESSES) {
+	if (nb_mc_addr >= priv->sh->dev_cap.max_mc_mac_addrs) {
 		rte_errno = ENOSPC;
 		return -rte_errno;
 	}
-	for (i = MLX5_MAX_UC_MAC_ADDRESSES; i != MLX5_MAX_MAC_ADDRESSES; ++i)
+	for (i = priv->sh->dev_cap.max_uc_mac_addrs; i != priv->sh->dev_cap.max_mac_addrs; ++i)
 		mlx5_internal_mac_addr_remove(dev, i, NULL);
-	i = MLX5_MAX_UC_MAC_ADDRESSES;
+	i = priv->sh->dev_cap.max_uc_mac_addrs;
 	while (nb_mc_addr--) {
 		ret = mlx5_internal_mac_addr_add(dev, mc_addr_set++, i++);
 		if (ret)
diff --git a/drivers/net/mlx5/mlx5_trigger.c b/drivers/net/mlx5/mlx5_trigger.c
index 7f6148f4e1..c5f493117b 100644
--- a/drivers/net/mlx5/mlx5_trigger.c
+++ b/drivers/net/mlx5/mlx5_trigger.c
@@ -1916,7 +1916,7 @@ mlx5_traffic_enable(struct rte_eth_dev *dev)
 		}
 	}
 	/* Add MAC address flows. */
-	for (i = 0; i != MLX5_MAX_MAC_ADDRESSES; ++i) {
+	for (i = 0; i != priv->sh->dev_cap.max_mac_addrs; ++i) {
 		struct rte_ether_addr *mac = &dev->data->mac_addrs[i];
 
 		/* Add flows for unicast and multicast mac addresses added by API. */
@@ -2186,7 +2186,7 @@ mlx5_traffic_vlan_add(struct rte_eth_dev *dev, const uint16_t vid)
 		return 0;
 
 	/* Add all unicast DMAC flow rules with new VLAN attached. */
-	for (i = 0; i != MLX5_MAX_MAC_ADDRESSES; ++i) {
+	for (i = 0; i != priv->sh->dev_cap.max_mac_addrs; ++i) {
 		struct rte_ether_addr *mac = &dev->data->mac_addrs[i];
 
 		if (rte_is_zero_ether_addr(mac))
@@ -2203,7 +2203,7 @@ mlx5_traffic_vlan_add(struct rte_eth_dev *dev, const uint16_t vid)
 		 * Removing after creating VLAN rules so that traffic "gap" is not introduced.
 		 */
 
-		for (i = 0; i != MLX5_MAX_MAC_ADDRESSES; ++i) {
+		for (i = 0; i != priv->sh->dev_cap.max_mac_addrs; ++i) {
 			struct rte_ether_addr *mac = &dev->data->mac_addrs[i];
 
 			if (rte_is_zero_ether_addr(mac))
@@ -2241,7 +2241,7 @@ mlx5_traffic_vlan_remove(struct rte_eth_dev *dev, const uint16_t vid)
 		 * Recreating first to ensure no traffic "gap".
 		 */
 
-		for (i = 0; i != MLX5_MAX_MAC_ADDRESSES; ++i) {
+		for (i = 0; i != priv->sh->dev_cap.max_mac_addrs; ++i) {
 			struct rte_ether_addr *mac = &dev->data->mac_addrs[i];
 
 			if (rte_is_zero_ether_addr(mac))
@@ -2254,7 +2254,7 @@ mlx5_traffic_vlan_remove(struct rte_eth_dev *dev, const uint16_t vid)
 	}
 
 	/* Remove all unicast DMAC flow rules with this VLAN. */
-	for (i = 0; i != MLX5_MAX_MAC_ADDRESSES; ++i) {
+	for (i = 0; i != priv->sh->dev_cap.max_mac_addrs; ++i) {
 		struct rte_ether_addr *mac = &dev->data->mac_addrs[i];
 
 		if (rte_is_zero_ether_addr(mac))
diff --git a/drivers/net/mlx5/windows/mlx5_os.c b/drivers/net/mlx5/windows/mlx5_os.c
index 0aaed36ace..cc60f07e17 100644
--- a/drivers/net/mlx5/windows/mlx5_os.c
+++ b/drivers/net/mlx5/windows/mlx5_os.c
@@ -261,6 +261,16 @@ mlx5_os_capabilities_prepare(struct mlx5_dev_ctx_shared *sh)
 		 MLX5_GET(initial_seg, pv_iseg, fw_rev_subminor));
 	DRV_LOG(DEBUG, "Packet pacing is not supported.");
 	mlx5_rt_timestamp_config(sh, hca_attr);
+	if (hca_attr->log_max_current_uc_list > 0)
+		sh->dev_cap.max_uc_mac_addrs = RTE_BIT32(hca_attr->log_max_current_uc_list);
+	else
+		sh->dev_cap.max_uc_mac_addrs = MLX5_MAX_UC_MAC_ADDRESSES;
+	if (hca_attr->log_max_current_mc_list > 0)
+		sh->dev_cap.max_mc_mac_addrs = RTE_BIT32(hca_attr->log_max_current_mc_list);
+	else
+		sh->dev_cap.max_mc_mac_addrs = MLX5_MAX_MC_MAC_ADDRESSES;
+	sh->dev_cap.max_mac_addrs =
+		sh->dev_cap.max_uc_mac_addrs + sh->dev_cap.max_mc_mac_addrs;
 	return 0;
 }
 
@@ -396,6 +406,22 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 	priv->sh = sh;
 	priv->dev_port = spawn->phys_port;
 	priv->pci_dev = spawn->pci_dev;
+	priv->mac = mlx5_malloc(MLX5_MEM_ZERO | MLX5_MEM_RTE,
+				sizeof(*priv->mac) * sh->dev_cap.max_mac_addrs,
+				RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+	if (priv->mac == NULL) {
+		DRV_LOG(ERR, "Failed to allocate MAC address array.");
+		err = ENOMEM;
+		goto error;
+	}
+	priv->mac_own = mlx5_malloc(MLX5_MEM_ZERO | MLX5_MEM_RTE,
+				    RTE_BITSET_SIZE(sh->dev_cap.max_mac_addrs),
+				    RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+	if (priv->mac_own == NULL) {
+		DRV_LOG(ERR, "Failed to allocate MAC ownership bitmap.");
+		err = ENOMEM;
+		goto error;
+	}
 	priv->mp_id.port_id = port_id;
 	strlcpy(priv->mp_id.name, MLX5_MP_NAME, RTE_MP_MAX_NAME_LEN);
 	priv->representor = !!switch_info->representor;
@@ -612,17 +638,16 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 			mlx5_l3t_destroy(priv->mtr_profile_tbl);
 		if (own_domain_id)
 			claim_zero(rte_eth_switch_domain_free(priv->domain_id));
+		mlx5_free(priv->mac);
+		mlx5_free(priv->mac_own);
 		mlx5_free(priv);
-		if (eth_dev != NULL)
+		if (eth_dev != NULL) {
+			eth_dev->data->mac_addrs = NULL;
 			eth_dev->data->dev_private = NULL;
+		}
 	}
-	if (eth_dev != NULL) {
-		/* mac_addrs must not be freed alone because part of
-		 * dev_private
-		 **/
-		eth_dev->data->mac_addrs = NULL;
+	if (eth_dev != NULL)
 		rte_eth_dev_release_port(eth_dev);
-	}
 	if (sh)
 		mlx5_free_shared_dev_ctx(sh);
 	MLX5_ASSERT(err > 0);
@@ -698,7 +723,7 @@ mlx5_os_mac_addr_flush(struct rte_eth_dev *dev)
 	struct mlx5_priv *priv = dev->data->dev_private;
 	int i;
 
-	for (i = MLX5_MAX_MAC_ADDRESSES - 1; i >= 0; --i) {
+	for (i = priv->sh->dev_cap.max_mac_addrs - 1; i >= 0; --i) {
 		if (rte_bitset_test(priv->mac_own, i))
 			rte_bitset_clear(priv->mac_own, i);
 	}
-- 
2.54.0

