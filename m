Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D98C5DF74
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 02:16:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC5FF40B99;
	Tue, 18 Aug 2026 04:15:43 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id AB94940695
 for <dev@dpdk.org>; Tue, 18 Aug 2026 04:15:36 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-05 (Coremail) with SMTP id zQCowADHNUA8wINq+acKBg--.60494S6;
 Tue, 18 Aug 2026 10:15:26 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v1 04/13] net/sxe2: enhance device cap and res management
Date: Tue, 18 Aug 2026 10:15:09 +0800
Message-ID: <20260818021518.2922515-5-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260818021518.2922515-1-liujie5@linkdatatechnology.com>
References: <20260818021518.2922515-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowADHNUA8wINq+acKBg--.60494S6
X-Coremail-Antispam: 1UD129KBjvAXoW3Kw1kXFWUKFW5KrW7Gw1fCrg_yoW8Ww15Ao
 WxWr9xXr1fXw1Ik39YqFn7CFW7Aw48uwsYka1Svrn8uanxJFyUJa43JwnxZ3WDKanYkFy2
 gw1vvryvyF9xJ3yxn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUYK7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
 Ia0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
 84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F
 4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4U
 JwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
 IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
 M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24l42
 xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
 GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI4
 8JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4U
 MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I
 8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU17KsUUUUU
X-Originating-IP: [118.112.177.181]
X-CM-SenderInfo: xolxyxrhv6zxpqngt3pdwhux5qro0w31of0z/
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

From: Jie Liu <liujie5@linkdatatechnology.com>

This patch improves the SXE2 PMD with several key enhancements:

- Enhance device info reporting:
  * Add NULL check for main VSI in dev_infos_get
  * Add max_mac_addrs field support
  * Add RSS_HASH offload capability
  * Conditionally enable QINQ_STRIP/QINQ_INSERT based on port VLAN check
  * Fill nb_rx_queues and nb_tx_queues fields
  * Set no_of_elements in buffer_split_supported_hdr_ptypes_get

- Unify PCI register operations:
  * Move SXE2_PCI_REG_WRITE and SXE2_PCI_REG_READ to common header
  * Replace write-combined write with regular write in pci_map_write_reg
  * Add resource type validation in dev_pci_res_seg_map

- Improve VF representor matching logic:
  * Remove kernel_repr_id encoding approach
  * Match PF number and VF ID directly against representor info
  * Add proper error handling for mismatched representor types

- Support multi-port probing:
  * Loop through nb_ports in eth_pmd_probe
  * Handle probe failure with proper cleanup

- Update resource cleanup order in dev_close:
  * Adjust uninit sequence to prevent use-after-free
  * Add NULL check for dev_ops before calling dev_close

- Add device type checks in UDP tunnel operations:
  * Restrict tunnel operations to PF only
  * Reject operations on VF representors

- Store additional device capabilities:
  * Save port_idx and pf_idx from device capabilities

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_ethdev.c | 178 +++++++++++++++++++--------------
 drivers/net/sxe2/sxe2_ethdev.h |   6 +-
 drivers/net/sxe2/sxe2_queue.h  |   2 -
 3 files changed, 107 insertions(+), 79 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_ethdev.c b/drivers/net/sxe2/sxe2_ethdev.c
index 3c3e78125d..ccf04fe1d9 100644
--- a/drivers/net/sxe2/sxe2_ethdev.c
+++ b/drivers/net/sxe2/sxe2_ethdev.c
@@ -95,7 +95,7 @@ static struct sxe2_pci_map_addr_info sxe2_net_map_addr_info_pf[SXE2_PCI_MAP_RES_
 				      .reg_width = 4},
 	[SXE2_PCI_MAP_RES_IRQ_MSIX] = {.addr_base = SXE2_BAR4_MSIX_CTL(0),
 				      .bar_idx = 4,
-				      .reg_width = 10},
+				      .reg_width = 0x10},
 };
 
 static struct sxe2_pci_map_addr_info sxe2_net_map_addr_info_vf[SXE2_PCI_MAP_RES_MAX_COUNT] = {
@@ -630,6 +630,10 @@ int32_t sxe2_udp_tunnel_port_add_common(struct sxe2_adapter *ad,
 	struct sxe2_udp_tunnel_cfg *tunnel_config;
 	int32_t ret = -1;
 
+	if (ad->dev_type != SXE2_DEV_T_PF || ad->is_dev_repr) {
+		ret = -ENOTSUP;
+		goto l_end;
+	}
 	rte_spinlock_lock(&ad->udp_tunnel_ctx.lock);
 
 	tunnel_config = &ad->udp_tunnel_ctx.tunnel_conf[tunnel_proto];
@@ -659,6 +663,7 @@ int32_t sxe2_udp_tunnel_port_add_common(struct sxe2_adapter *ad,
 
 l_unlock_end:
 	rte_spinlock_unlock(&ad->udp_tunnel_ctx.lock);
+l_end:
 	return ret;
 }
 
@@ -782,6 +787,10 @@ static int32_t sxe2_dev_infos_get(struct rte_eth_dev *dev,
 	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
 	struct sxe2_vsi *vsi = adapter->vsi_ctxt.main_vsi;
 
+	if (unlikely(vsi == NULL)) {
+		PMD_LOG_ERR(INIT, "main vsi is NULL");
+		return -EINVAL;
+	}
 	dev_info->max_rx_queues = vsi->rxqs.q_cnt;
 	dev_info->max_tx_queues = vsi->txqs.q_cnt;
 	dev_info->min_rx_bufsize = SXE2_MIN_BUF_SIZE;
@@ -789,6 +798,7 @@ static int32_t sxe2_dev_infos_get(struct rte_eth_dev *dev,
 	dev_info->max_lro_pkt_size = SXE2_FRAME_SIZE_MAX * SXE2_RX_LRO_DESC_MAX_NUM;
 	dev_info->max_mtu = dev_info->max_rx_pktlen - SXE2_ETH_OVERHEAD;
 	dev_info->min_mtu = RTE_ETHER_MIN_MTU;
+	dev_info->max_mac_addrs = SXE2_NUM_MACADDR_MAX;
 
 	dev_info->rx_offload_capa =
 		RTE_ETH_RX_OFFLOAD_VLAN_STRIP |
@@ -800,11 +810,9 @@ static int32_t sxe2_dev_infos_get(struct rte_eth_dev *dev,
 		RTE_ETH_RX_OFFLOAD_SCTP_CKSUM |
 		RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM |
 		RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT |
-#ifndef RTE_LIBRTE_SXE2_16BYTE_RX_DESC
-		RTE_ETH_RX_OFFLOAD_QINQ_STRIP |
-#endif
 		RTE_ETH_RX_OFFLOAD_VLAN_EXTEND |
-		RTE_ETH_RX_OFFLOAD_TCP_LRO;
+		RTE_ETH_RX_OFFLOAD_TCP_LRO |
+		RTE_ETH_RX_OFFLOAD_RSS_HASH;
 
 	dev_info->tx_offload_capa =
 		RTE_ETH_TX_OFFLOAD_VLAN_INSERT |
@@ -850,13 +858,20 @@ static int32_t sxe2_dev_infos_get(struct rte_eth_dev *dev,
 		RTE_ETH_TX_OFFLOAD_IPIP_TNL_TSO |
 		RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO;
 
+	if (sxe2_ipsec_supported(adapter)) {
+		dev_info->rx_offload_capa |= RTE_ETH_RX_OFFLOAD_SECURITY;
+		dev_info->tx_offload_capa |= RTE_ETH_TX_OFFLOAD_SECURITY;
+	}
 
 	if (adapter->cap_flags & SXE2_DEV_CAPS_OFFLOAD_PTP)
 		dev_info->rx_offload_capa |= RTE_ETH_RX_OFFLOAD_TIMESTAMP;
 
-	if (sxe2_ipsec_supported(adapter)) {
-		dev_info->rx_offload_capa |= RTE_ETH_RX_OFFLOAD_SECURITY;
-		dev_info->tx_offload_capa |= RTE_ETH_TX_OFFLOAD_SECURITY;
+	if (!sxe2_dev_port_vlan_check(dev)) {
+		dev_info->tx_offload_capa |= RTE_ETH_TX_OFFLOAD_QINQ_INSERT;
+#ifndef RTE_LIBRTE_SXE2_16BYTE_RX_DESC
+		dev_info->rx_offload_capa |= RTE_ETH_RX_OFFLOAD_QINQ_STRIP;
+#endif
+		dev_info->rx_offload_capa |= RTE_ETH_RX_OFFLOAD_VLAN_FILTER;
 	}
 
 	if (adapter->cap_flags & SXE2_DEV_CAPS_OFFLOAD_RSS) {
@@ -909,7 +924,8 @@ static int32_t sxe2_dev_infos_get(struct rte_eth_dev *dev,
 
 	dev_info->speed_capa = RTE_ETH_LINK_SPEED_10G | RTE_ETH_LINK_SPEED_25G |
 				RTE_ETH_LINK_SPEED_50G | RTE_ETH_LINK_SPEED_100G;
-
+	dev_info->nb_rx_queues = dev->data->nb_rx_queues;
+	dev_info->nb_tx_queues = dev->data->nb_tx_queues;
 	dev_info->default_rxportconf.burst_size = SXE2_RX_MAX_BURST;
 	dev_info->default_txportconf.burst_size = SXE2_TX_MAX_BURST;
 	dev_info->default_rxportconf.nb_queues = 1;
@@ -918,11 +934,8 @@ static int32_t sxe2_dev_infos_get(struct rte_eth_dev *dev,
 	dev_info->default_txportconf.ring_size = SXE2_RING_SIZE_MIN;
 
 	dev_info->rx_seg_capa.max_nseg = SXE2_RX_MAX_NSEG;
-
 	dev_info->rx_seg_capa.multi_pools = true;
-
 	dev_info->rx_seg_capa.offset_allowed = false;
-
 	dev_info->rx_seg_capa.offset_align_log2 = false;
 
 	return 0;
@@ -930,7 +943,7 @@ static int32_t sxe2_dev_infos_get(struct rte_eth_dev *dev,
 
 static const uint32_t *
 sxe2_buffer_split_supported_hdr_ptypes_get(struct rte_eth_dev *dev __rte_unused,
-					   size_t *no_of_elements __rte_unused)
+					   size_t *no_of_elements)
 {
 	static const uint32_t ptypes[] = {
 		RTE_PTYPE_L2_ETHER,
@@ -968,6 +981,7 @@ sxe2_buffer_split_supported_hdr_ptypes_get(struct rte_eth_dev *dev __rte_unused,
 
 		RTE_PTYPE_UNKNOWN
 	};
+	*no_of_elements = RTE_DIM(ptypes);
 
 	return ptypes;
 }
@@ -1352,6 +1366,8 @@ static int32_t sxe2_func_caps_get(struct sxe2_adapter *adapter)
 		goto l_end;
 
 	adapter->dev_type = dev_caps.dev_type;
+	adapter->port_idx = dev_caps.port_idx;
+	adapter->pf_idx = dev_caps.pf_idx;
 
 	sxe2_drv_dev_caps_set(adapter,  &dev_caps);
 
@@ -1437,7 +1453,7 @@ void sxe2_pci_map_write_reg(struct sxe2_adapter *adapter,
 		goto l_ret;
 	}
 
-	SXE2_PCI_REG_WRITE_WC(reg_addr, value);
+	SXE2_PCI_REG_WRITE(reg_addr, value);
 l_ret:
 	return;
 }
@@ -1550,6 +1566,12 @@ int32_t sxe2_dev_pci_res_seg_map(struct sxe2_adapter *adapter,
 	struct sxe2_pci_map_addr_info *addr_info = NULL;
 	int32_t ret = 0;
 
+	if (unlikely(res_type >= SXE2_PCI_MAP_RES_MAX_COUNT)) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Invalid resource type %u", res_type);
+		ret = -EINVAL;
+		goto l_end;
+	}
+
 	addr_info = &adapter->map_ctxt.addr_info[res_type];
 	if (!addr_info || addr_info->bar_idx == SXE2_PCI_MAP_BAR_INVALID) {
 		PMD_DEV_LOG_ERR(adapter, INIT, "Invalid bar index with resource type %d", res_type);
@@ -1765,14 +1787,13 @@ void sxe2_dev_pci_map_uinit(struct rte_eth_dev *dev)
 	uint8_t i = 0;
 
 	PMD_INIT_FUNC_TRACE();
+	if (map_ctxt->bar_info != NULL) {
+		(void)sxe2_dev_pci_seg_unmap(adapter, SXE2_PCI_MAP_RES_DOORBELL_RX_TAIL);
+		(void)sxe2_dev_pci_seg_unmap(adapter, SXE2_PCI_MAP_RES_DOORBELL_TX);
+		(void)sxe2_dev_pci_seg_unmap(adapter, SXE2_PCI_MAP_RES_IRQ_DYN);
+		(void)sxe2_dev_pci_seg_unmap(adapter, SXE2_PCI_MAP_RES_IRQ_ITR);
+		(void)sxe2_dev_pci_seg_unmap(adapter, SXE2_PCI_MAP_RES_IRQ_MSIX);
 
-	(void)sxe2_dev_pci_seg_unmap(adapter, SXE2_PCI_MAP_RES_DOORBELL_RX_TAIL);
-	(void)sxe2_dev_pci_seg_unmap(adapter, SXE2_PCI_MAP_RES_DOORBELL_TX);
-	(void)sxe2_dev_pci_seg_unmap(adapter, SXE2_PCI_MAP_RES_IRQ_DYN);
-	(void)sxe2_dev_pci_seg_unmap(adapter, SXE2_PCI_MAP_RES_IRQ_ITR);
-	(void)sxe2_dev_pci_seg_unmap(adapter, SXE2_PCI_MAP_RES_IRQ_MSIX);
-
-	if (map_ctxt != NULL && map_ctxt->bar_info != NULL) {
 		for (i = 0; i < map_ctxt->bar_cnt; i++) {
 			bar_info = &map_ctxt->bar_info[i];
 			if (bar_info != NULL && bar_info->seg_info != NULL) {
@@ -1783,7 +1804,6 @@ void sxe2_dev_pci_map_uinit(struct rte_eth_dev *dev)
 		rte_free(map_ctxt->bar_info);
 		map_ctxt->bar_info = NULL;
 	}
-
 	adapter->dev_info.dev_data = NULL;
 }
 
@@ -1936,6 +1956,12 @@ static int32_t sxe2_dev_init(struct rte_eth_dev *dev,
 		goto init_switchdev_err;
 	}
 
+	ret = sxe2_eth_init(dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to initialize eth parameters, ret=%d", ret);
+		goto init_eth_err;
+	}
+
 	ret = sxe2_sw_init(dev);
 	if (ret) {
 		PMD_LOG_ERR(INIT, "Failed to initialize sw parameters, ret=[%d]", ret);
@@ -1948,12 +1974,6 @@ static int32_t sxe2_dev_init(struct rte_eth_dev *dev,
 		goto init_irq_err;
 	}
 
-	ret = sxe2_eth_init(dev);
-	if (ret) {
-		PMD_LOG_ERR(INIT, "Failed to initialize eth parameters, ret=%d", ret);
-		goto init_eth_err;
-	}
-
 	ret = sxe2_security_init(dev);
 	if (ret) {
 		PMD_LOG_ERR(INIT, "Failed to initialize security, ret=%d", ret);
@@ -2005,15 +2025,15 @@ static int32_t sxe2_dev_init(struct rte_eth_dev *dev,
 init_fc_state_err:
 	(void)sxe2_flow_uninit(dev);
 init_flow_err:
-init_rss_err:
 	sxe2_security_uinit(dev);
+init_rss_err:
 init_security_err:
-	sxe2_eth_uinit(dev);
-init_eth_err:
 	sxe2_intr_uninit(dev);
 init_irq_err:
 	sxe2_sw_uninit(dev);
 init_sw_err:
+	sxe2_eth_uinit(dev);
+init_eth_err:
 	(void)sxe2_switchdev_uninit(dev);
 init_switchdev_err:
 init_dev_info_err:
@@ -2035,17 +2055,15 @@ static int32_t sxe2_dev_close(struct rte_eth_dev *dev)
 	(void)sxe2_queues_release(dev);
 	sxe2_mp_uninit(dev);
 	(void)sxe2_sched_uinit(dev);
-	(void)sxe2_rss_disable(dev);
 	(void)sxe2_flow_uninit(dev);
+	(void)sxe2_rss_disable(dev);
 	(void)sxe2_udp_tunnel_port_clear(dev);
-	sxe2_vsi_uninit(dev);
 	sxe2_security_uinit(dev);
 	sxe2_intr_uninit(dev);
 	(void)sxe2_switchdev_uninit(dev);
 	sxe2_sw_uninit(dev);
-	(void)sxe2_switchdev_uninit(dev);
-	sxe2_dev_pci_map_uinit(dev);
 	sxe2_eth_uinit(dev);
+	sxe2_vsi_uninit(dev);
 	sxe2_dev_pci_map_uinit(dev);
 	sxe2_free_repr_info(dev);
 	sxe2_fc_state_uinit(dev);
@@ -2068,9 +2086,11 @@ static int32_t sxe2_dev_uninit(struct rte_eth_dev *dev)
 	for (i = 0; i < adapter->repr_ctxt.nb_repr_vf; i++) {
 		rep_dev = adapter->repr_ctxt.vf_rep_eth_dev[i];
 		if (rep_dev) {
-			ret = rep_dev->dev_ops->dev_close(rep_dev);
-			if (ret)
-				goto l_end;
+			if (rep_dev->dev_ops && rep_dev->dev_ops->dev_close) {
+				ret = rep_dev->dev_ops->dev_close(rep_dev);
+				if (ret)
+					goto l_end;
+			}
 			if (rep_dev->intr_handle)
 				rte_intr_instance_free(rep_dev->intr_handle);
 			ret = rte_eth_dev_release_port(rep_dev);
@@ -2143,42 +2163,25 @@ static int32_t sxe2_fw_version_string_get(struct rte_eth_dev *dev, char *fw_vers
 	return ret;
 }
 
-static uint16_t sxe2_switchdev_repr_id_encode_get(struct sxe2_switchdev_info *switchdev_info)
-{
-	enum rte_eth_representor_type type;
-	uint16_t repr = switchdev_info->vf_num;
-	uint32_t pf = switchdev_info->pf_num;
-
-	switch (switchdev_info->port_name_type) {
-	case SXE2_PHYS_PORT_NAME_TYPE_UPLINK:
-		if (!switchdev_info->representor)
-			return UINT16_MAX;
-		type = RTE_ETH_REPRESENTOR_PF;
-		pf = switchdev_info->mpesw_owner;
-		break;
-	case SXE2_PHYS_PORT_NAME_TYPE_PFVF:
-	default:
-		type = RTE_ETH_REPRESENTOR_VF;
-		break;
-	}
-
-	return SXE2_REPRESENTOR_ID(pf, type, repr);
-}
-
 static bool sxe2_switchdev_repr_match(struct sxe2_adapter *adapter,
 				   struct rte_eth_devargs *req_eth_da)
 {
-	uint32_t port_idx = 0;
-	uint32_t repr_idx;
-	uint16_t kernel_repr_id = sxe2_switchdev_repr_id_encode_get(&adapter->switchdev_info);
-	uint16_t repr_id;
+	uint16_t port_idx = UINT16_MAX;
+	uint16_t repr_idx;
+	uint16_t vf_id;
+	uint16_t i;
 
 	switch (req_eth_da->type) {
 	case RTE_ETH_REPRESENTOR_PF:
+		if (adapter->switchdev_info.port_name_type !=
+			SXE2_PHYS_PORT_NAME_TYPE_UPLINK) {
+			rte_errno = EBUSY;
+			return false;
+		}
 		break;
 	case RTE_ETH_REPRESENTOR_VF:
 		if (adapter->switchdev_info.port_name_type !=
-		SXE2_PHYS_PORT_NAME_TYPE_PFVF) {
+			SXE2_PHYS_PORT_NAME_TYPE_PFVF) {
 			rte_errno = EBUSY;
 			return false;
 		}
@@ -2191,15 +2194,30 @@ static bool sxe2_switchdev_repr_match(struct sxe2_adapter *adapter,
 		return false;
 	}
 
+	for (port_idx = 0; port_idx < req_eth_da->nb_ports; ++port_idx) {
+		if (adapter->switchdev_info.pf_num != req_eth_da->ports[port_idx]) {
+			PMD_DEV_LOG_DEBUG(adapter, DRV, "switchdev pf %u not match req pf %u",
+				adapter->switchdev_info.pf_num, req_eth_da->ports[port_idx]);
+			rte_errno = EBUSY;
+			return false;
+		}
+	}
+
 	for (repr_idx = 0; repr_idx < req_eth_da->nb_representor_ports; ++repr_idx) {
-		repr_id = SXE2_REPRESENTOR_ID(req_eth_da->ports[port_idx],
-					      req_eth_da->type,
-					      req_eth_da->representor_ports[repr_idx]);
-		if (repr_id == kernel_repr_id)
-			return true;
-	}
-	rte_errno = EBUSY;
-	return false;
+		for (i = 0; i < adapter->repr_ctxt.nb_vf; ++i) {
+			vf_id = rte_le_to_cpu_16(adapter->repr_ctxt.repr_vf_id[i].func_id);
+			if (vf_id == req_eth_da->representor_ports[repr_idx])
+				break;
+		}
+		if (i == adapter->repr_ctxt.nb_vf) {
+			PMD_DEV_LOG_DEBUG(adapter, DRV, "switchdev vf %u not match req vf(cnt:%u)",
+				req_eth_da->representor_ports[repr_idx], adapter->repr_ctxt.nb_vf);
+			rte_errno = EBUSY;
+			return false;
+		}
+	}
+
+	return true;
 }
 
 static int32_t sxe2_eth_pmd_probe_pf(struct sxe2_common_device *cdev,
@@ -2317,6 +2335,7 @@ static int32_t sxe2_eth_pmd_probe(struct sxe2_common_device *cdev,
 {
 	struct rte_eth_devargs eth_da = { .nb_ports = 0 };
 	int32_t ret = 0;
+	uint16_t port;
 
 	ret = sxe2_parse_eth_devargs(cdev->dev, &eth_da);
 	if (ret != 0) {
@@ -2324,7 +2343,18 @@ static int32_t sxe2_eth_pmd_probe(struct sxe2_common_device *cdev,
 		goto l_end;
 	}
 
-	ret = sxe2_eth_pmd_probe_pf(cdev, &eth_da, 0, kvargs);
+	if (eth_da.nb_ports > 0) {
+		for (port = 0; port < eth_da.nb_ports; port++) {
+			ret = sxe2_eth_pmd_probe_pf(cdev, &eth_da, port, kvargs);
+			if (ret != 0) {
+				PMD_LOG_ERR(INIT, "sxe2 eth pmd probe failed, ret=%d", ret);
+				(void)sxe2_eth_pmd_remove(cdev);
+				goto l_end;
+			}
+		}
+	} else {
+		ret = sxe2_eth_pmd_probe_pf(cdev, &eth_da, 0, kvargs);
+	}
 
 l_end:
 	return ret;
diff --git a/drivers/net/sxe2/sxe2_ethdev.h b/drivers/net/sxe2/sxe2_ethdev.h
index 7e495e5cb9..cfcb7fcf00 100644
--- a/drivers/net/sxe2/sxe2_ethdev.h
+++ b/drivers/net/sxe2/sxe2_ethdev.h
@@ -65,9 +65,6 @@ enum sxe2_fnav_tunnel_flag_type {
 #define upper_32_bits(n) ((uint32_t)(((n) >> 16) >> 16))
 #define lower_32_bits(n) ((uint32_t)((n) & 0xffffffff))
 
-#define SXE2_REPRESENTOR_ID(pf, type, repr) \
-		(((pf) << 14) + ((type) << 12) + ((repr) & 0xfff))
-
 #define SXE2_I2C_EEPROM_DEV_ADDR	0xA0
 #define SXE2_I2C_EEPROM_DEV_ADDR2	0xA2
 #define SXE2_MODULE_TYPE_SFP		0x03
@@ -356,6 +353,9 @@ struct sxe2_adapter {
 #define SXE2_DEV_PRIVATE_TO_ADAPTER(dev) \
 	((struct sxe2_adapter *)(dev)->data->dev_private)
 
+#define SXE2_PCI_REG_WRITE(reg, value) rte_write32((rte_cpu_to_le_32(value)), (reg))
+#define SXE2_PCI_REG_READ(reg)         rte_read32(reg)
+
 void *sxe2_pci_map_addr_get(struct sxe2_adapter *adapter,
 			    enum sxe2_pci_map_resource res_type,
 			    uint16_t idx_in_func);
diff --git a/drivers/net/sxe2/sxe2_queue.h b/drivers/net/sxe2/sxe2_queue.h
index a300b66771..10bdaf5b8d 100644
--- a/drivers/net/sxe2/sxe2_queue.h
+++ b/drivers/net/sxe2/sxe2_queue.h
@@ -12,8 +12,6 @@
 #include "sxe2_drv_cmd.h"
 #include "sxe2_txrx_common.h"
 
-#define SXE2_PCI_REG_READ(reg)			\
-		rte_read32(reg)
 #define SXE2_PCI_REG_WRITE_WC(reg, value)			\
 		rte_write32_wc((rte_cpu_to_le_32(value)), reg)
 #define SXE2_PCI_REG_WRITE_WC_RELAXED(reg, value)		\
-- 
2.52.0

