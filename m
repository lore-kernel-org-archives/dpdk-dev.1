Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7838C43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Jul 2026 16:04:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C94F740DF6;
	Thu,  9 Jul 2026 18:03:53 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3116840DD6
 for <dev@dpdk.org>; Thu,  9 Jul 2026 18:03:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783613031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6lwDr3sskgeZE6PY+WC1+Gnt6D/cCR2jbLv4Ej4l9yU=;
 b=ZZr44mbfE0m6crjQk6xUd5CUIETQniDAgepO1qPusSxMnF6vMxQbkdwxir84koChiZqjvC
 8ogp3zhtLlg5HAfgpa9zJGQF1ECT9iHF96AACzu2mS+Yxbaiiko/MmEEHP9LSFq4Oi+F8l
 LvRGk3GI6iTa6lzsrGxsqb5ZXty8LLE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-t33nZ1GuOOaVglIPmMXNcA-1; Thu,
 09 Jul 2026 12:03:47 -0400
X-MC-Unique: t33nZ1GuOOaVglIPmMXNcA-1
X-Mimecast-MFC-AGG-ID: t33nZ1GuOOaVglIPmMXNcA_1783613025
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D24AC18003FC; Thu,  9 Jul 2026 16:03:45 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2B4FD1956053; Thu,  9 Jul 2026 16:03:42 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: rjarry@redhat.com, cfontain@redhat.com,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v4 10/10] net/mlx5: accept more unicast MAC addresses
Date: Thu,  9 Jul 2026 18:02:46 +0200
Message-ID: <20260709160247.1798575-11-david.marchand@redhat.com>
In-Reply-To: <20260709160247.1798575-1-david.marchand@redhat.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260709160247.1798575-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jsqTubXrjO1v1Nl9GNVBPUj3W7AVTT-KJGca4enCZjI_1783613025
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
 drivers/common/mlx5/mlx5_devx_cmds.c |  4 +++
 drivers/common/mlx5/mlx5_devx_cmds.h |  2 ++
 drivers/net/mlx5/linux/mlx5_os.c     | 42 ++++++++++++++++++++++------
 drivers/net/mlx5/mlx5.c              |  9 ++----
 drivers/net/mlx5/mlx5.h              |  8 ++++--
 drivers/net/mlx5/mlx5_ethdev.c       |  2 +-
 drivers/net/mlx5/mlx5_mac.c          | 22 +++++++++------
 drivers/net/mlx5/mlx5_trigger.c      | 10 +++----
 drivers/net/mlx5/windows/mlx5_os.c   | 40 ++++++++++++++++++++------
 9 files changed, 99 insertions(+), 40 deletions(-)

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
index 90beb2e9e6..7fe89bc6a4 100644
--- a/drivers/common/mlx5/mlx5_devx_cmds.h
+++ b/drivers/common/mlx5/mlx5_devx_cmds.h
@@ -356,6 +356,8 @@ struct mlx5_hca_attr {
 	uint8_t tx_sw_owner_v2:1;
 	uint8_t esw_sw_owner:1;
 	uint8_t esw_sw_owner_v2:1;
+	uint32_t log_max_current_uc_list:5;
+	uint32_t log_max_current_mc_list:5;
 };
 
 /* LAG Context. */
diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index 1cad6e1091..23632f55af 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -389,6 +389,16 @@ mlx5_os_capabilities_prepare(struct mlx5_dev_ctx_shared *sh)
 	sh->dev_cap.esw_info.regc_mask = 0;
 #endif
 	sh->dev_cap.esw_info.is_set = 1;
+	if (hca_attr->log_max_current_uc_list > 0)
+		sh->dev_cap.max_uc_mac_addrs = 1u << hca_attr->log_max_current_uc_list;
+	else
+		sh->dev_cap.max_uc_mac_addrs = MLX5_MAX_UC_MAC_ADDRESSES;
+	if (hca_attr->log_max_current_mc_list > 0)
+		sh->dev_cap.max_mc_mac_addrs = 1u << hca_attr->log_max_current_mc_list;
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
+				      sh->dev_cap.max_mac_addrs,
+				      sh->dev_cap.max_uc_mac_addrs);
 	priv->ctrl_flows = 0;
 	rte_spinlock_init(&priv->flow_list_lock);
 	TAILQ_INIT(&priv->flow_meters);
@@ -1963,17 +1989,15 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 			mlx5_flex_item_port_cleanup(eth_dev);
 		mlx5_free(priv->ext_rxqs);
 		mlx5_free(priv->ext_txqs);
+		mlx5_free(priv->mac);
+		eth_dev->data->mac_addrs = NULL;
+		mlx5_free(priv->mac_own);
 		mlx5_free(priv);
 		if (eth_dev != NULL)
 			eth_dev->data->dev_private = NULL;
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
@@ -3497,7 +3521,7 @@ mlx5_os_mac_addr_flush(struct rte_eth_dev *dev)
 	const int vf = priv->sh->dev_cap.vf;
 	int i;
 
-	for (i = MLX5_MAX_MAC_ADDRESSES - 1; i >= 0; --i) {
+	for (i = priv->sh->dev_cap.max_mac_addrs - 1; i >= 0; --i) {
 		if (rte_bitset_test(priv->mac_own, i)) {
 			if (vf)
 				mlx5_nl_mac_addr_remove(priv->nl_socket_route,
diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index 61c26d1206..1323ba49ac 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -2546,6 +2546,9 @@ mlx5_dev_close(struct rte_eth_dev *dev)
 		mlx5_list_destroy(priv->hrxqs);
 	mlx5_free(priv->ext_rxqs);
 	mlx5_free(priv->ext_txqs);
+	mlx5_free(priv->mac);
+	dev->data->mac_addrs = NULL;
+	mlx5_free(priv->mac_own);
 	sh->port[priv->dev_port - 1].nl_ih_port_id = RTE_MAX_ETHPORTS;
 	/*
 	 * The interrupt handler port id must be reset before priv is reset
@@ -2580,12 +2583,6 @@ mlx5_dev_close(struct rte_eth_dev *dev)
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
index f7ba8df108..1fcc40fade 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -217,6 +217,9 @@ struct mlx5_dev_cap {
 	} mprq; /* Capability for Multi-Packet RQ. */
 	char fw_ver[64]; /* Firmware version of this device. */
 	struct flow_hw_port_info esw_info; /* E-switch manager reg_c0. */
+	uint16_t max_uc_mac_addrs; /* Maximum unicast MAC addresses. */
+	uint16_t max_mc_mac_addrs; /* Maximum multicast MAC addresses. */
+	uint16_t max_mac_addrs; /* Total maximum MAC addresses. */
 };
 
 #define MLX5_MPESW_PORT_INVALID (-1)
@@ -2018,9 +2021,8 @@ struct mlx5_priv {
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
diff --git a/drivers/net/mlx5/mlx5_mac.c b/drivers/net/mlx5/mlx5_mac.c
index 0e5d2be530..2ce7cfd407 100644
--- a/drivers/net/mlx5/mlx5_mac.c
+++ b/drivers/net/mlx5/mlx5_mac.c
@@ -36,7 +36,9 @@ mlx5_internal_mac_addr_remove(struct rte_eth_dev *dev,
 			      uint32_t index,
 			      struct rte_ether_addr *addr)
 {
-	MLX5_ASSERT(index < MLX5_MAX_MAC_ADDRESSES);
+	struct mlx5_priv *priv = dev->data->dev_private;
+
+	MLX5_ASSERT(index < priv->sh->dev_cap.max_mac_addrs);
 	if (rte_is_zero_ether_addr(&dev->data->mac_addrs[index]))
 		return false;
 	mlx5_os_mac_addr_remove(dev, index);
@@ -63,16 +65,17 @@ static int
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
@@ -101,10 +104,11 @@ mlx5_internal_mac_addr_add(struct rte_eth_dev *dev, struct rte_ether_addr *mac,
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
@@ -133,9 +137,10 @@ int
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
@@ -217,16 +222,17 @@ int
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
index e41e4643e0..e535e3e5be 100644
--- a/drivers/net/mlx5/mlx5_trigger.c
+++ b/drivers/net/mlx5/mlx5_trigger.c
@@ -1902,7 +1902,7 @@ mlx5_traffic_enable(struct rte_eth_dev *dev)
 		}
 	}
 	/* Add MAC address flows. */
-	for (i = 0; i != MLX5_MAX_MAC_ADDRESSES; ++i) {
+	for (i = 0; i != priv->sh->dev_cap.max_mac_addrs; ++i) {
 		struct rte_ether_addr *mac = &dev->data->mac_addrs[i];
 
 		/* Add flows for unicast and multicast mac addresses added by API. */
@@ -2172,7 +2172,7 @@ mlx5_traffic_vlan_add(struct rte_eth_dev *dev, const uint16_t vid)
 		return 0;
 
 	/* Add all unicast DMAC flow rules with new VLAN attached. */
-	for (i = 0; i != MLX5_MAX_MAC_ADDRESSES; ++i) {
+	for (i = 0; i != priv->sh->dev_cap.max_mac_addrs; ++i) {
 		struct rte_ether_addr *mac = &dev->data->mac_addrs[i];
 
 		if (rte_is_zero_ether_addr(mac))
@@ -2189,7 +2189,7 @@ mlx5_traffic_vlan_add(struct rte_eth_dev *dev, const uint16_t vid)
 		 * Removing after creating VLAN rules so that traffic "gap" is not introduced.
 		 */
 
-		for (i = 0; i != MLX5_MAX_MAC_ADDRESSES; ++i) {
+		for (i = 0; i != priv->sh->dev_cap.max_mac_addrs; ++i) {
 			struct rte_ether_addr *mac = &dev->data->mac_addrs[i];
 
 			if (rte_is_zero_ether_addr(mac))
@@ -2227,7 +2227,7 @@ mlx5_traffic_vlan_remove(struct rte_eth_dev *dev, const uint16_t vid)
 		 * Recreating first to ensure no traffic "gap".
 		 */
 
-		for (i = 0; i != MLX5_MAX_MAC_ADDRESSES; ++i) {
+		for (i = 0; i != priv->sh->dev_cap.max_mac_addrs; ++i) {
 			struct rte_ether_addr *mac = &dev->data->mac_addrs[i];
 
 			if (rte_is_zero_ether_addr(mac))
@@ -2240,7 +2240,7 @@ mlx5_traffic_vlan_remove(struct rte_eth_dev *dev, const uint16_t vid)
 	}
 
 	/* Remove all unicast DMAC flow rules with this VLAN. */
-	for (i = 0; i != MLX5_MAX_MAC_ADDRESSES; ++i) {
+	for (i = 0; i != priv->sh->dev_cap.max_mac_addrs; ++i) {
 		struct rte_ether_addr *mac = &dev->data->mac_addrs[i];
 
 		if (rte_is_zero_ether_addr(mac))
diff --git a/drivers/net/mlx5/windows/mlx5_os.c b/drivers/net/mlx5/windows/mlx5_os.c
index 15de5c22a9..30d99b8b64 100644
--- a/drivers/net/mlx5/windows/mlx5_os.c
+++ b/drivers/net/mlx5/windows/mlx5_os.c
@@ -261,6 +261,16 @@ mlx5_os_capabilities_prepare(struct mlx5_dev_ctx_shared *sh)
 		 MLX5_GET(initial_seg, pv_iseg, fw_rev_subminor));
 	DRV_LOG(DEBUG, "Packet pacing is not supported.");
 	mlx5_rt_timestamp_config(sh, hca_attr);
+	if (hca_attr->log_max_current_uc_list > 0)
+		sh->dev_cap.max_uc_mac_addrs = 1u << hca_attr->log_max_current_uc_list;
+	else
+		sh->dev_cap.max_uc_mac_addrs = MLX5_MAX_UC_MAC_ADDRESSES;
+	if (hca_attr->log_max_current_mc_list > 0)
+		sh->dev_cap.max_mc_mac_addrs = 1u << hca_attr->log_max_current_mc_list;
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
@@ -612,17 +638,15 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 			mlx5_l3t_destroy(priv->mtr_profile_tbl);
 		if (own_domain_id)
 			claim_zero(rte_eth_switch_domain_free(priv->domain_id));
+		mlx5_free(priv->mac);
+		eth_dev->data->mac_addrs = NULL;
+		mlx5_free(priv->mac_own);
 		mlx5_free(priv);
 		if (eth_dev != NULL)
 			eth_dev->data->dev_private = NULL;
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
@@ -698,7 +722,7 @@ mlx5_os_mac_addr_flush(struct rte_eth_dev *dev)
 	struct mlx5_priv *priv = dev->data->dev_private;
 	int i;
 
-	for (i = MLX5_MAX_MAC_ADDRESSES - 1; i >= 0; --i) {
+	for (i = priv->sh->dev_cap.max_mac_addrs - 1; i >= 0; --i) {
 		if (rte_bitset_test(priv->mac_own, i))
 			rte_bitset_clear(priv->mac_own, i);
 	}
@@ -718,7 +742,7 @@ mlx5_os_mac_addr_remove(struct rte_eth_dev *dev, uint32_t index)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 
-	if (index < MLX5_MAX_MAC_ADDRESSES)
+	if (index < priv->sh->dev_cap.max_mac_addrs)
 		rte_bitset_clear(priv->mac_own, index);
 }
 
-- 
2.54.0

