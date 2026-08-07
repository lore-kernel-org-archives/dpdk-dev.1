Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377B3C5AC7A
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Aug 2026 03:49:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3BD91406FF;
	Fri,  7 Aug 2026 05:48:42 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 8AC3D402AC
 for <dev@dpdk.org>; Fri,  7 Aug 2026 05:48:35 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6C29F20010D;
 Fri,  7 Aug 2026 05:48:35 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 31E00200112;
 Fri,  7 Aug 2026 05:48:35 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id B10AE18000B5;
 Fri,  7 Aug 2026 11:48:34 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com,
	Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v2 06/14] net/enetc: support registers dump
Date: Fri,  7 Aug 2026 09:18:21 +0530
Message-Id: <20260807034829.1030307-7-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260807034829.1030307-1-g.singh@nxp.com>
References: <20260806112836.707921-1-g.singh@nxp.com>
 <20260807034829.1030307-1-g.singh@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

Implement the .get_reg operation for the ENETC4 PF and VF PMDs to dump
the device registers via rte_eth_dev_get_reg_info.

The VF dumps the registers reachable by a virtual station interface
(VSI): the station interface and per-ring BD ring registers. Port
registers are not accessible by a VF.

The PF additionally dumps the port registers, which are only
accessible by the physical station interface (PSI).

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 doc/guides/nics/enetc4.rst             |  1 +
 doc/guides/nics/features/enetc4.ini    |  1 +
 doc/guides/rel_notes/release_26_11.rst |  1 +
 drivers/net/enetc/enetc.h              | 13 +++++
 drivers/net/enetc/enetc4_ethdev.c      | 70 ++++++++++++++++++++++++++
 drivers/net/enetc/enetc4_vf.c          | 62 +++++++++++++++++++++++
 6 files changed, 148 insertions(+)

diff --git a/doc/guides/nics/enetc4.rst b/doc/guides/nics/enetc4.rst
index ea0e37896d..cd757be12f 100644
--- a/doc/guides/nics/enetc4.rst
+++ b/doc/guides/nics/enetc4.rst
@@ -60,6 +60,7 @@ Key functionality includes:
   requested. RSC requires the FCS to be stripped, so it cannot be combined
   with the KEEP_CRC Rx offload.
 - Firmware version: The NETC IP version is reported via ``rte_eth_dev_fw_version_get``.
+- Registers dump: The station interface, port (PF only) and BD ring registers are dumped via ``rte_eth_dev_get_reg_info``.
 
 
 Prerequisites
diff --git a/doc/guides/nics/features/enetc4.ini b/doc/guides/nics/features/enetc4.ini
index eaf474e7ba..6540a43909 100644
--- a/doc/guides/nics/features/enetc4.ini
+++ b/doc/guides/nics/features/enetc4.ini
@@ -17,6 +17,7 @@ RSS hash             = Y
 Packet type parsing  = Y
 Basic stats          = Y
 FW version           = Y
+Registers dump       = Y
 L3 checksum offload  = Y
 L4 checksum offload  = Y
 CRC offload          = Y
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 5ac2bb4de0..deb3bc5d52 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -65,6 +65,7 @@ New Features
   * Added Receive Segment Coalesce (RSC / hardware LRO) support for ENETC4 PF and VF.
   * Extended the PF-to-VF link speed code field from 4-bit to 8-bit in ENETC4.
   * Added firmware version reporting for the ENETC4 VF.
+  * Added register dump support for ENETC4 PF and VF.
 
 Removed Items
 -------------
diff --git a/drivers/net/enetc/enetc.h b/drivers/net/enetc/enetc.h
index b1428f1bca..73404308fe 100644
--- a/drivers/net/enetc/enetc.h
+++ b/drivers/net/enetc/enetc.h
@@ -397,6 +397,19 @@ enetc_bd_unused(struct enetc_bdr *bdr)
 	return bdr->bd_count + bdr->next_to_clean - bdr->next_to_use - 1;
 }
 
+/* Per-ring Tx BDR registers dumped by .get_reg (shared by PF and VF) */
+static const uint32_t enetc4_txbdr_regs[] = {
+	ENETC_TBMR, ENETC_TBSR, ENETC_TBBAR0, ENETC_TBBAR1,
+	ENETC_TBCIR, ENETC_TBLENR,
+};
+
+/* Per-ring Rx BDR registers dumped by .get_reg (shared by PF and VF) */
+static const uint32_t enetc4_rxbdr_regs[] = {
+	ENETC_RBMR, ENETC_RBSR, ENETC_RBBSR, ENETC_RBCIR,
+	ENETC_RBBAR0, ENETC_RBBAR1, ENETC_RBPIR, ENETC_RBLENR,
+};
+
+
 /* CBDR prototypes */
 int enetc4_setup_cbdr(struct rte_eth_dev *dev, struct enetc_hw *hw,
 			int bd_count, struct netc_cbdr *cbdr);
diff --git a/drivers/net/enetc/enetc4_ethdev.c b/drivers/net/enetc/enetc4_ethdev.c
index 7f95171b6d..681bac3ecc 100644
--- a/drivers/net/enetc/enetc4_ethdev.c
+++ b/drivers/net/enetc/enetc4_ethdev.c
@@ -1176,6 +1176,75 @@ enetc4_supported_ptypes_get(struct rte_eth_dev *dev __rte_unused,
 	return ptypes;
 }
 
+/* Station interface registers dumped by .get_reg */
+static const uint32_t enetc4_pf_si_regs[] = {
+	ENETC_SIMR, ENETC_SICAPR0, ENETC_SIPMAR0, ENETC_SIPMAR1,
+	ENETC4_SIROCT0, ENETC4_SIRFRM0, ENETC4_SITOCT0, ENETC4_SITFRM0,
+	ENETC4_SITDFCR,
+};
+
+/* Port registers dumped by .get_reg (accessible only by the PF) */
+static const uint32_t enetc4_pf_port_regs[] = {
+	ENETC4_PMR, ENETC4_PSIPMMR, ENETC4_PMAR0, ENETC4_PMAR1,
+	ENETC4_PM_CMD_CFG(0), ENETC4_PM_MAXFRM(0), ENETC4_PM_IF_MODE(0),
+	ENETC4_PM_IF_STATUS(0),
+};
+
+/*
+ * Dump the PF-accessible registers: station interface, port and per-ring
+ * BD ring registers. When info->data is NULL, only the register count and
+ * width are reported so the caller can size its buffer.
+ */
+static int
+enetc4_get_regs(struct rte_eth_dev *dev, struct rte_dev_reg_info *regs)
+{
+	struct enetc_eth_hw *hw = ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct enetc_hw *enetc_hw = &hw->hw;
+	uint32_t count, addr;
+	uint32_t *buf;
+	uint16_t i, j;
+
+	count = RTE_DIM(enetc4_pf_si_regs);
+	count += RTE_DIM(enetc4_pf_port_regs);
+	count += RTE_DIM(enetc4_txbdr_regs) * dev->data->nb_tx_queues;
+	count += RTE_DIM(enetc4_rxbdr_regs) * dev->data->nb_rx_queues;
+
+	if (regs->data == NULL) {
+		regs->length = count;
+		regs->width = sizeof(uint32_t);
+		return 0;
+	}
+
+	if (regs->length && regs->length < count)
+		return -ENOTSUP;
+
+	buf = regs->data;
+
+	for (i = 0; i < RTE_DIM(enetc4_pf_si_regs); i++)
+		*buf++ = enetc4_rd(enetc_hw, enetc4_pf_si_regs[i]);
+
+	for (i = 0; i < RTE_DIM(enetc4_pf_port_regs); i++)
+		*buf++ = enetc4_port_rd(enetc_hw, enetc4_pf_port_regs[i]);
+
+	for (i = 0; i < dev->data->nb_tx_queues; i++) {
+		for (j = 0; j < RTE_DIM(enetc4_txbdr_regs); j++) {
+			addr = ENETC_BDR(TX, i, enetc4_txbdr_regs[j]);
+			*buf++ = enetc4_rd(enetc_hw, addr);
+		}
+	}
+
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
+		for (j = 0; j < RTE_DIM(enetc4_rxbdr_regs); j++) {
+			addr = ENETC_BDR(RX, i, enetc4_rxbdr_regs[j]);
+			*buf++ = enetc4_rd(enetc_hw, addr);
+		}
+	}
+
+	regs->version = hw->device_id << 16 | hw->revision_id;
+
+	return 0;
+}
+
 /*
  * The set of PCI devices this driver supports
  */
@@ -1194,6 +1263,7 @@ static const struct eth_dev_ops enetc4_ops = {
 	.link_update          = enetc4_link_update,
 	.stats_get            = enetc4_stats_get,
 	.stats_reset          = enetc4_stats_reset,
+	.get_reg              = enetc4_get_regs,
 	.promiscuous_enable   = enetc4_promiscuous_enable,
 	.promiscuous_disable  = enetc4_promiscuous_disable,
 	.rx_queue_setup       = enetc4_rx_queue_setup,
diff --git a/drivers/net/enetc/enetc4_vf.c b/drivers/net/enetc/enetc4_vf.c
index 4b84a90cc9..77bec0425a 100644
--- a/drivers/net/enetc/enetc4_vf.c
+++ b/drivers/net/enetc/enetc4_vf.c
@@ -931,6 +931,66 @@ enetc4_vf_fw_version_get(struct rte_eth_dev *dev, char *fw_version, size_t fw_si
 	return 0;
 }
 
+/* VF station interface registers dumped by .get_reg */
+static const uint32_t enetc4_vf_si_regs[] = {
+	ENETC_SIMR, ENETC_SICAPR0, ENETC_SIPMAR0, ENETC_SIPMAR1,
+	ENETC4_SIROCT0, ENETC4_SIRFRM0, ENETC4_SITOCT0, ENETC4_SITFRM0,
+	ENETC4_SITDFCR, ENETC4_SIMSIVR, ENETC4_VSIIER, ENETC4_VSIIDR,
+	ENETC4_VSIMSGSR, ENETC4_VSIMSGRR,
+};
+
+/*
+ * Dump the VF-accessible registers. Only station interface and per-ring
+ * BD ring registers are reachable by a VF; port registers are not.
+ * When info->data is NULL, only the register count and width are
+ * reported so the caller can size its buffer.
+ */
+static int
+enetc4_vf_get_regs(struct rte_eth_dev *dev, struct rte_dev_reg_info *regs)
+{
+	struct enetc_eth_hw *hw = ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct enetc_hw *enetc_hw = &hw->hw;
+	uint32_t count, addr;
+	uint32_t *buf;
+	uint16_t i, j;
+
+	count = RTE_DIM(enetc4_vf_si_regs);
+	count += RTE_DIM(enetc4_txbdr_regs) * dev->data->nb_tx_queues;
+	count += RTE_DIM(enetc4_rxbdr_regs) * dev->data->nb_rx_queues;
+
+	if (regs->data == NULL) {
+		regs->length = count;
+		regs->width = sizeof(uint32_t);
+		return 0;
+	}
+
+	if (regs->length && regs->length < count)
+		return -ENOTSUP;
+
+	buf = regs->data;
+
+	for (i = 0; i < RTE_DIM(enetc4_vf_si_regs); i++)
+		*buf++ = enetc_rd(enetc_hw, enetc4_vf_si_regs[i]);
+
+	for (i = 0; i < dev->data->nb_tx_queues; i++) {
+		for (j = 0; j < RTE_DIM(enetc4_txbdr_regs); j++) {
+			addr = ENETC_BDR(TX, i, enetc4_txbdr_regs[j]);
+			*buf++ = enetc_rd(enetc_hw, addr);
+		}
+	}
+
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
+		for (j = 0; j < RTE_DIM(enetc4_rxbdr_regs); j++) {
+			addr = ENETC_BDR(RX, i, enetc4_rxbdr_regs[j]);
+			*buf++ = enetc_rd(enetc_hw, addr);
+		}
+	}
+
+	regs->version = hw->device_id << 16 | hw->revision_id;
+
+	return 0;
+}
+
 static int
 enetc4_vf_link_update_dummy(struct rte_eth_dev *dev __rte_unused,
 			    int wait_to_complete __rte_unused)
@@ -1441,6 +1501,7 @@ static const struct eth_dev_ops enetc4_vf_ops_no_vsi_m = {
 	.stats_get            = enetc4_vf_stats_get,
 	.dev_infos_get        = enetc4_vf_dev_infos_get,
 	.fw_version_get       = enetc4_vf_fw_version_get,
+	.get_reg              = enetc4_vf_get_regs,
 	.mtu_set              = enetc4_vf_mtu_set,
 	.link_update	      = enetc4_vf_link_update_dummy,
 	.rx_queue_setup       = enetc4_rx_queue_setup,
@@ -1461,6 +1522,7 @@ static const struct eth_dev_ops enetc4_vf_ops = {
 	.dev_close            = enetc4_dev_close,
 	.stats_get            = enetc4_vf_stats_get,
 	.dev_infos_get        = enetc4_vf_dev_infos_get,
+	.get_reg              = enetc4_vf_get_regs,
 	.mtu_set              = enetc4_vf_mtu_set,
 	.mac_addr_set         = enetc4_vf_set_mac_addr,
 	.mac_addr_add	      = enetc4_vf_mac_addr_add,
-- 
2.25.1

