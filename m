Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277C7CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:11:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8BF1E40E2A;
	Wed, 14 Oct 2026 17:10:08 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.5])
 by mails.dpdk.org (Postfix) with ESMTP id BAABC406FF
 for <dev@dpdk.org>; Wed, 14 Oct 2026 17:09:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=v6LMpLAx6ZqHbvPlDz/5dSrKz4V62mUCb8NBI2uEMXI=;
 b=DNNrr+w47bAtCa6g/YDj07UQ+pbno+Vo0GDWENpJQOaZg1PBXzQzX8dsAgFcO0
 qUJXrTSlslXdKhQg5DePOXauB4U0O9B6FBwyGqLlpY22X+T5B1mneLPGvYMM21A9
 xL+qYFoI3TeIbqTUyYEZw1w9oAn3nQOg40XHxIEUE1Aj4=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v2 18/26] net/hinic3: add compact CQE Rx path and ptype table
Date: Wed, 14 Oct 2026 23:09:14 +0800
Message-ID: <20261014150923.838-19-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261014150923.838-1-yejiacheng4@h-partners.com>
References: <20261010144509.2731-1-yejiacheng4@h-partners.com>
 <20261014150923.838-1-yejiacheng4@h-partners.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgAXMEEym89qB_SFAw--.62919S20
X-Coremail-Antispam: 1Uf129KBjvAXoWDGFW7KFW3tr47tr48WF1rWFg_yoWrZF47Zo
 WfXr1ayrn3tr1xCrWjgrn7uFWDArWDZwsYy3909a92q3W7Xry5tF9xJw1rJFy0qa93CFnr
 AF93t39rKwsrX34Dn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUzgAwUUUUU
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNBuDjWrPmzscnwAA3n
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

Add a precomputed ptype table and a compact CQE Rx burst function, and
select the Rx path from the rx_cqe_compact_en runtime parameter.

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 doc/guides/rel_notes/release_26_11.rst   |   1 +
 drivers/net/hinic3/base/hinic3_nic_cfg.h |   2 +
 drivers/net/hinic3/hinic3_ethdev.c       | 124 +++--
 drivers/net/hinic3/hinic3_ethdev.h       |   8 +-
 drivers/net/hinic3/hinic3_rx.c           | 571 +++++++++++++++++++----
 drivers/net/hinic3/hinic3_rx.h           | 216 ++++-----
 6 files changed, 676 insertions(+), 246 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 9155cb2d4c..cda505cb37 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -123,6 +123,7 @@ New Features
   * Added mailbox message counter reporting through the device private dump API.
   * Added support for the SP560 NIC.
   * Added device parameters for runtime configuration.
+  * Added a compact CQE receive data path.
 
 * **Updated Intel iavf driver.**
 
diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.h b/drivers/net/hinic3/base/hinic3_nic_cfg.h
index 79375bbf91..b7c00a56c6 100644
--- a/drivers/net/hinic3/base/hinic3_nic_cfg.h
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.h
@@ -63,6 +63,8 @@
 	((hinic3_get_driver_feature(dev) & NIC_F_##feature) != 0)
 #define HINIC3_SUPPORT_RX_HW_COMPACT_CQE(dev) \
 	HINIC3_SUPPORT_FEATURE(dev, RX_HW_COMPACT_CQE)
+#define HINIC3_SUPPORT_RX_SW_COMPACT_CQE(dev) \
+	HINIC3_SUPPORT_FEATURE(dev, RX_SW_COMPACT_CQE)
 #define HINIC3_SUPPORT_TX_WQE_COMPACT_TASK(dev) \
 	HINIC3_SUPPORT_FEATURE(dev, TX_WQE_COMPACT_TASK)
 #define HINIC3_SUPPORT_VXLAN_OFFLOAD(dev) \
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index 08f4e7443b..6007b5fb8d 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -1086,11 +1086,13 @@ hinic3_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 
 	nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
 
-	/* Queue depth must be equal to queue 0 */
-	if (qid != 0 && nb_desc != nic_dev->rxqs[0]->q_depth) {
-		PMD_DRV_LOG(WARNING, "rxq%u depth:%u is not equal to queue0 depth:%u.",
-			    qid, nb_desc, nic_dev->rxqs[0]->q_depth);
-		nb_desc = nic_dev->rxqs[0]->q_depth;
+	/* Queue depth must be equal to first queue */
+	if (nic_dev->rxq_depth == 0) {
+		nic_dev->rxq_depth = nb_desc;
+	} else if (nb_desc != nic_dev->rxq_depth) {
+		PMD_DRV_LOG(WARNING, "rxq%u depth:%u is not equal to first queue depth:%u.",
+			    qid, nb_desc, nic_dev->rxq_depth);
+		nb_desc = nic_dev->rxq_depth;
 	}
 
 	/* Queue depth must be power of 2, otherwise will be aligned up. */
@@ -1163,7 +1165,7 @@ hinic3_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 	}
 
 	/* If NIC support compact CQE, use compact wqe as default. */
-	if (HINIC3_SUPPORT_RX_HW_COMPACT_CQE(nic_dev)) {
+	if (nic_dev->config.rx_cqe_compact_en) {
 		rxq->wqe_type = HINIC3_COMPACT_RQ_WQE;
 	} else {
 		if (buf_size >= HINIC3_RX_BUF_SIZE_4K &&
@@ -1223,7 +1225,7 @@ hinic3_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 		goto alloc_rx_info_fail;
 	}
 
-	if (HINIC3_SUPPORT_RX_HW_COMPACT_CQE(nic_dev)) {
+	if (nic_dev->config.rx_cqe_compact_en) {
 		ci_mz = hinic3_dma_zone_reserve(dev, "hinic3_ci_mz", qid,
 						sizeof(*rxq->rq_ci),
 						RTE_CACHE_LINE_SIZE, (int)socket_id);
@@ -1275,6 +1277,7 @@ hinic3_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 	hinic3_memzone_free(rxq->rq_mz);
 
 alloc_rq_mz_fail:
+	rxq->db_addr = NULL;
 alloc_db_err_fail:
 	hinic3_memzone_free(rxq->pi_mz);
 
@@ -1462,7 +1465,7 @@ hinic3_rx_queue_release(struct rte_eth_dev *dev, uint16_t queue_id)
 
 	hinic3_free_rxq_mbufs(rxq);
 
-	if (HINIC3_SUPPORT_RX_HW_COMPACT_CQE(nic_dev))
+	if (nic_dev->config.rx_cqe_compact_en)
 		hinic3_memzone_free(rxq->ci_mz);
 	else
 		hinic3_memzone_free(rxq->cqe_mz);
@@ -1625,6 +1628,9 @@ hinic3_dev_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id)
 	if (!rte_intr_dp_is_en(intr_handle) || !intr_handle->intr_vec)
 		return 0;
 
+	if (HINIC3_IS_SP230_NIC(nic_dev) && !dev->data->dev_conf.intr_conf.rxq)
+		return 0;
+
 	msix_intr = (uint16_t)intr_handle->intr_vec[queue_id];
 	hinic3_set_msix_auto_mask_state(nic_dev->hwdev, msix_intr,
 					HINIC3_SET_MSIX_AUTO_MASK);
@@ -1929,7 +1935,13 @@ hinic3_init_rxq_intr(struct rte_eth_dev *dev)
 
 	intr_handle = dev->intr_handle;
 	nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
-	if (!dev->data->dev_conf.intr_conf.rxq)
+
+	/*
+	 * SP230 asserts the Rx MSI-X vector during aggregation; configure the
+	 * vectors' coalescing/auto-mask at init so those assertions are masked
+	 * instead of preempting a core.
+	 */
+	if (!HINIC3_IS_SP230_NIC(nic_dev) && !dev->data->dev_conf.intr_conf.rxq)
 		return 0;
 
 	if (!rte_intr_cap_multiple(intr_handle)) {
@@ -2215,6 +2227,8 @@ hinic3_dev_stop(struct rte_eth_dev *dev)
 
 	/* Free mempool. */
 	hinic3_copy_mempool_uninit(nic_dev);
+
+	nic_dev->rxq_depth = 0;
 	return 0;
 }
 
@@ -2252,6 +2266,8 @@ hinic3_dev_release(struct rte_eth_dev *eth_dev)
 
 	rte_free(nic_dev->hwdev);
 	nic_dev->hwdev = NULL;
+	rte_free(nic_dev->ptype_tbl);
+	nic_dev->ptype_tbl = NULL;
 }
 
 /**
@@ -3230,6 +3246,40 @@ hinic3_dev_xstats_get_names(struct rte_eth_dev *dev,
 	return count;
 }
 
+static const uint32_t *
+hinic3_dev_supported_ptypes_get(__rte_unused struct rte_eth_dev *dev, size_t *no_of_elements)
+{
+	static const uint32_t ptypes[] = {
+		RTE_PTYPE_L2_ETHER,
+		RTE_PTYPE_L2_ETHER_FCOE,
+		RTE_PTYPE_L2_ETHER_NSH,
+		RTE_PTYPE_L3_IPV4_EXT_UNKNOWN,
+		RTE_PTYPE_L3_IPV6_EXT_UNKNOWN,
+		RTE_PTYPE_L4_TCP,
+		RTE_PTYPE_L4_UDP,
+		RTE_PTYPE_L4_SCTP,
+		RTE_PTYPE_L4_NONFRAG,
+		RTE_PTYPE_L4_FRAG,
+		RTE_PTYPE_L4_ICMP,
+		RTE_PTYPE_L4_IGMP,
+		RTE_PTYPE_L4_ESP,
+		RTE_PTYPE_TUNNEL_IP,
+		RTE_PTYPE_TUNNEL_GRE,
+		RTE_PTYPE_TUNNEL_VXLAN,
+		RTE_PTYPE_TUNNEL_VXLAN_GPE,
+		RTE_PTYPE_TUNNEL_GENEVE,
+		RTE_PTYPE_INNER_L2_ETHER,
+		RTE_PTYPE_INNER_L3_IPV4_EXT_UNKNOWN,
+		RTE_PTYPE_INNER_L3_IPV6_EXT_UNKNOWN,
+		RTE_PTYPE_INNER_L4_TCP,
+		RTE_PTYPE_INNER_L4_UDP,
+		RTE_PTYPE_INNER_L4_SCTP,
+		RTE_PTYPE_INNER_L4_NONFRAG,
+	};
+	*no_of_elements = RTE_DIM(ptypes);
+	return ptypes;
+}
+
 static void
 hinic3_rxq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
 		    struct rte_eth_rxq_info *qinfo)
@@ -3563,6 +3613,7 @@ hinic3_eth_dev_priv_dump(struct rte_eth_dev *dev, FILE *file)
 static const struct eth_dev_ops hinic3_pmd_ops = {
 	.dev_configure                 = hinic3_dev_configure,
 	.dev_infos_get                 = hinic3_dev_infos_get,
+	.dev_supported_ptypes_get      = hinic3_dev_supported_ptypes_get,
 	.fw_version_get                = hinic3_fw_version_get,
 	.dev_set_link_up               = hinic3_dev_set_link_up,
 	.dev_set_link_down             = hinic3_dev_set_link_down,
@@ -3615,6 +3666,7 @@ static const struct eth_dev_ops hinic3_pmd_ops = {
 static const struct eth_dev_ops hinic3_pmd_vf_ops = {
 	.dev_configure                 = hinic3_dev_configure,
 	.dev_infos_get                 = hinic3_dev_infos_get,
+	.dev_supported_ptypes_get      = hinic3_dev_supported_ptypes_get,
 	.fw_version_get                = hinic3_fw_version_get,
 	.dev_set_link_up               = hinic3_dev_set_link_up,
 	.dev_set_link_down             = hinic3_dev_set_link_down,
@@ -3667,16 +3719,6 @@ static void hinic3_nic_tx_rx_ops_init(struct hinic3_nic_dev *nic_dev)
 		nic_dev->tx_ops->nic_tx_set_wqe_offload = hinic3_tx_set_compact_task_offload;
 	else
 		nic_dev->tx_ops->nic_tx_set_wqe_offload = hinic3_tx_set_normal_task_offload;
-
-	if (HINIC3_SUPPORT_RX_HW_COMPACT_CQE(nic_dev)) {
-		nic_dev->rx_ops->nic_rx_get_cqe_info = hinic3_rx_get_compact_cqe_info;
-		nic_dev->rx_ops->nic_rx_cqe_done = hinic3_rx_integrated_cqe_done;
-		nic_dev->rx_ops->nic_rx_poll_rq_empty = hinic3_poll_integrated_cqe_rq_empty;
-	} else {
-		nic_dev->rx_ops->nic_rx_get_cqe_info = hinic3_rx_get_cqe_info;
-		nic_dev->rx_ops->nic_rx_cqe_done = hinic3_rx_separate_cqe_done;
-		nic_dev->rx_ops->nic_rx_poll_rq_empty = hinic3_poll_rq_empty;
-	}
 }
 
 /**
@@ -3739,13 +3781,6 @@ hinic3_func_init(struct rte_eth_dev *eth_dev)
 		goto alloc_eth_addr_fail;
 	}
 
-	nic_dev->rx_ops = rte_zmalloc("rx_ops", sizeof(struct hinic3_nic_rx_ops), 0);
-	if (!nic_dev->rx_ops) {
-		PMD_DRV_LOG(ERR, "Allocate rx_ops memory failed");
-		err = -ENOMEM;
-		goto alloc_rx_ops_fail;
-	}
-
 	nic_dev->tx_ops = rte_zmalloc("tx_ops", sizeof(struct hinic3_nic_tx_ops), 0);
 	if (!nic_dev->tx_ops) {
 		PMD_DRV_LOG(ERR, "Allocate tx_ops memory failed");
@@ -3847,6 +3882,7 @@ hinic3_func_init(struct rte_eth_dev *eth_dev)
 			    eth_dev->data->name);
 		goto enable_intr_fail;
 	}
+
 	tcam_info = &nic_dev->tcam;
 	memset(tcam_info, 0, sizeof(struct hinic3_tcam_info));
 	TAILQ_INIT(&tcam_info->tcam_list);
@@ -3900,10 +3936,6 @@ hinic3_func_init(struct rte_eth_dev *eth_dev)
 	nic_dev->tx_ops = NULL;
 
 alloc_tx_ops_fail:
-	rte_free(nic_dev->rx_ops);
-	nic_dev->rx_ops = NULL;
-
-alloc_rx_ops_fail:
 	rte_free(eth_dev->data->mac_addrs);
 	eth_dev->data->mac_addrs = NULL;
 
@@ -3989,6 +4021,21 @@ hinic3_nic_common_config_get(struct rte_pci_device *pci_dev,
 	return ret;
 }
 
+static void hinic3_nic_feature_init(struct hinic3_nic_dev *nic_dev)
+{
+	if ((HINIC3_SUPPORT_RX_HW_COMPACT_CQE(nic_dev) ||
+	     HINIC3_SUPPORT_RX_SW_COMPACT_CQE(nic_dev)) &&
+	    nic_dev->config.rx_cqe_compact_en == HINIC3_RX_CQE_COMPACT_EN) {
+		nic_dev->config.rx_cqe_compact_en = HINIC3_RX_CQE_COMPACT_EN;
+		PMD_DRV_LOG(INFO, "nic compact_cqe is on.");
+	} else {
+		nic_dev->config.rx_cqe_compact_en = 0;
+		PMD_DRV_LOG(INFO, "nic compact_cqe is off.");
+	}
+}
+
+static int hinic3_dev_uninit(struct rte_eth_dev *dev);
+
 static int
 hinic3_dev_init(struct rte_eth_dev *eth_dev)
 {
@@ -4027,10 +4074,23 @@ hinic3_dev_init(struct rte_eth_dev *eth_dev)
 	if (err)
 		return err;
 
-	if (rte_eal_process_type() == RTE_PROC_PRIMARY)
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 		nic_dev->config = config;
+		hinic3_nic_feature_init(nic_dev);
+
+		err = hinic3_init_rx_ptype_table(eth_dev);
+		if (err) {
+			PMD_DRV_LOG(ERR, "Failed to create ptype_table.");
+			hinic3_dev_uninit(eth_dev);
+			return err;
+		}
+
+		if (nic_dev->config.rx_cqe_compact_en != HINIC3_RX_CQE_COMPACT_EN)
+			eth_dev->rx_pkt_burst = hinic3_recv_pkts;
+		else
+			eth_dev->rx_pkt_burst = hinic3_recv_pkts_compact_cqe;
+	}
 
-	eth_dev->rx_pkt_burst = hinic3_recv_pkts;
 	eth_dev->tx_pkt_burst = hinic3_xmit_pkts;
 
 	return 0;
diff --git a/drivers/net/hinic3/hinic3_ethdev.h b/drivers/net/hinic3/hinic3_ethdev.h
index c91a820e45..281953a8eb 100644
--- a/drivers/net/hinic3/hinic3_ethdev.h
+++ b/drivers/net/hinic3/hinic3_ethdev.h
@@ -117,6 +117,11 @@ enum nic_feature_cap {
 TAILQ_HEAD(hinic3_ethertype_filter_list, rte_flow);
 TAILQ_HEAD(hinic3_fdir_rule_filter_list, rte_flow);
 
+#define HINIC3_PTYPE_NUM 4096
+struct hinic3_ptype_table {
+	alignas(RTE_CACHE_LINE_SIZE) uint32_t ptype[HINIC3_PTYPE_NUM];
+};
+
 struct hinic3_nic_common_dev_config {
 	unsigned int tx_pending_limit; /**< TX CI coalescing parameter pending_limit. */
 	unsigned int tx_coalescing_time; /**< TX CI coalescing parameter coalescing_time. */
@@ -143,6 +148,7 @@ struct hinic3_nic_dev {
 	uint16_t max_sqs;
 	uint16_t max_rqs;
 
+	uint16_t rxq_depth;
 	uint16_t rx_buff_len;
 	uint16_t mtu_size;
 
@@ -179,7 +185,7 @@ struct hinic3_nic_dev {
 	struct hinic3_ethertype_filter_list filter_ethertype_list;
 	struct hinic3_fdir_rule_filter_list filter_fdir_rule_list;
 	uint8_t cos_map[HINIC3_COS_NUM_MAX];
-	struct hinic3_nic_rx_ops *rx_ops;
+	struct hinic3_ptype_table *ptype_tbl;
 	struct hinic3_nic_tx_ops *tx_ops;
 	enum nic_type nic_type; /**< NIC type. */
 
diff --git a/drivers/net/hinic3/hinic3_rx.c b/drivers/net/hinic3/hinic3_rx.c
index 9627b608f4..6fc3f775c6 100644
--- a/drivers/net/hinic3/hinic3_rx.c
+++ b/drivers/net/hinic3/hinic3_rx.c
@@ -1,16 +1,250 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2025 Huawei Technologies Co., Ltd
  */
+#include <rte_ether.h>
+#include <rte_mbuf.h>
 
 #include "base/hinic3_compat.h"
 #include "base/hinic3_hwif.h"
 #include "base/hinic3_hwdev.h"
 #include "base/hinic3_wq.h"
+#include "base/hinic3_mgmt.h"
 #include "base/hinic3_nic_cfg.h"
 #include "hinic3_nic_io.h"
 #include "hinic3_ethdev.h"
+#include "hinic3_tx.h"
 #include "hinic3_rx.h"
 
+#define HINIC3_RX_EMPTY_THRESHOLD 3
+
+static uint32_t
+hinic3_get_l3_ptype(uint32_t ip_type)
+{
+	uint32_t ptype = 0;
+	if (ip_type == IPSU_METADATA_L3_TP_IPV4)
+		ptype |= RTE_PTYPE_L3_IPV4_EXT_UNKNOWN;
+	else if (ip_type == IPSU_METADATA_L3_TP_IPV6)
+		ptype |= RTE_PTYPE_L3_IPV6_EXT_UNKNOWN;
+	return ptype;
+}
+static uint32_t
+hinic3_get_l4_ptype(uint32_t packet_type)
+{
+	int ptype = 0;
+	switch (packet_type) {
+	case IPSU_PKT_TYPE_NULL:
+		break;
+	case IPSU_PKT_TYPE_TCP:
+		ptype |= RTE_PTYPE_L4_TCP;
+		break;
+	case IPSU_PKT_TYPE_UDP:
+		ptype |= RTE_PTYPE_L4_UDP;
+		break;
+	case IPSU_PKT_TYPE_IPV4_FRAG:
+		ptype |= RTE_PTYPE_L4_FRAG;
+		break;
+	case IPSU_PKT_TYPE_SCTP:
+		ptype |= RTE_PTYPE_L4_SCTP;
+		break;
+	case IPSU_PKT_TYPE_ICMP:
+		ptype |= RTE_PTYPE_L4_ICMP;
+		break;
+	case IPSU_PKT_TYPE_IGMP:
+		ptype |= RTE_PTYPE_L4_IGMP;
+		break;
+	case IPSU_PKT_TYPE_ESP_OVER_IP:
+		ptype |= RTE_PTYPE_L4_ESP;
+		break;
+	default:
+		ptype |= RTE_PTYPE_L4_NONFRAG;
+	}
+	return ptype;
+}
+
+/**
+ * Calculate the ptype value of given offload type.
+ *
+ * @param[in] offload_type
+ *   The offload of Packet
+ * @return
+ *   Ptype value
+ */
+static uint32_t
+hinic3_calc_rx_ptype_table(uint32_t offload_type, struct hinic3_nic_dev *nic_dev)
+{
+	uint32_t packet_type, ip_type, enc_l3_type, pkt_fmt;
+	uint32_t ptype = RTE_PTYPE_UNKNOWN;
+
+	packet_type = HINIC3_GET_RX_PKT_TYPE(offload_type);
+	ip_type = HINIC3_GET_RX_IP_TYPE(offload_type);
+	enc_l3_type = HINIC3_GET_RX_ENC_L3_TYPE(offload_type);
+	pkt_fmt = HINIC3_GET_RX_PKT_FORMAT(offload_type);
+
+	switch (pkt_fmt) {
+	case IPSU_METADATA_FMT_NO_ENC:
+		ptype |= RTE_PTYPE_L2_ETHER;
+		ptype |= hinic3_get_l3_ptype(ip_type);
+		ptype |= hinic3_get_l4_ptype(packet_type);
+		break;
+	case IPSU_METADATA_FMT_FC:
+		ptype |= RTE_PTYPE_L2_ETHER_FCOE;
+		break;
+	case IPSU_METADATA_FMT_NSH:
+		ptype |= RTE_PTYPE_L2_ETHER_NSH;
+		break;
+	/* IPinIP */
+	case IPSU_METADATA_FMT_IPIP:
+		ptype |= RTE_PTYPE_L2_ETHER;
+		ptype |= RTE_PTYPE_TUNNEL_IP;
+		if (!(nic_dev->feature_cap & NIC_F_TX_WQE_COMPACT_TASK)) {
+			ptype |= hinic3_get_l3_ptype(ip_type);
+		} else {
+			ptype |= hinic3_get_l3_ptype(enc_l3_type);
+			ptype |= hinic3_get_l4_ptype(packet_type) << HINIC3_L4_PYTPE_SHIFT;
+			if (ip_type == IPSU_METADATA_L3_TP_IPV4)
+				ptype |= RTE_PTYPE_INNER_L3_IPV4_EXT_UNKNOWN;
+			else if (ip_type == IPSU_METADATA_L3_TP_IPV6)
+				ptype |= RTE_PTYPE_INNER_L3_IPV6_EXT_UNKNOWN;
+		}
+		break;
+	default:
+	/* VXLAN, NVGRE, VXLAN_GPE, GENEVE */
+		ptype |= RTE_PTYPE_L2_ETHER;
+		ptype |= hinic3_get_l3_ptype(enc_l3_type);
+
+		switch (pkt_fmt) {
+		case IPSU_METADATA_FMT_VXLAN:
+			ptype |= RTE_PTYPE_L4_UDP;
+			ptype |= RTE_PTYPE_TUNNEL_VXLAN;
+			ptype |= RTE_PTYPE_INNER_L2_ETHER;
+			break;
+		case IPSU_METADATA_FMT_NVGRE:
+			ptype |= RTE_PTYPE_TUNNEL_GRE;
+			if (!HINIC3_IS_SP560_NIC(nic_dev))
+				return ptype;
+			break;
+		case IPSU_METADATA_FMT_GPE:
+			ptype |= RTE_PTYPE_L4_UDP;
+			ptype |= RTE_PTYPE_TUNNEL_VXLAN_GPE;
+			break;
+		case IPSU_METADATA_FMT_GENEVE:
+			ptype |= RTE_PTYPE_L4_UDP;
+			ptype |= RTE_PTYPE_TUNNEL_GENEVE;
+			ptype |= RTE_PTYPE_INNER_L2_ETHER;
+			break;
+		default:
+			ptype |= RTE_PTYPE_L4_NONFRAG;
+			break;
+		}
+		if (ip_type == IPSU_METADATA_L3_TP_IPV4)
+			ptype |= RTE_PTYPE_INNER_L3_IPV4_EXT_UNKNOWN;
+		else if (ip_type == IPSU_METADATA_L3_TP_IPV6)
+			ptype |= RTE_PTYPE_INNER_L3_IPV6_EXT_UNKNOWN;
+		else
+			return ptype;
+		/* shift ptype to inner*/
+		ptype |= hinic3_get_l4_ptype(packet_type) << HINIC3_L4_PYTPE_SHIFT;
+	}
+	return ptype;
+}
+
+static uint32_t
+hinic3_calc_rx_ptype_compact_table(uint32_t offload_type)
+{
+	uint32_t packet_type, ip_type, pkt_fmt;
+	uint32_t ptype = RTE_PTYPE_UNKNOWN;
+
+	pkt_fmt = HINIC3_RQ_COMPACT_CQE_STATUS_GET(offload_type << HINIC3_COMPACT_CQE_PTYPE_SHIFT,
+						   PKT_FORMAT);
+	ip_type = HINIC3_RQ_COMPACT_CQE_STATUS_GET(offload_type << HINIC3_COMPACT_CQE_PTYPE_SHIFT,
+						   IP_TYPE);
+	packet_type = HINIC3_RQ_COMPACT_CQE_STATUS_GET(offload_type <<
+							HINIC3_COMPACT_CQE_PTYPE_SHIFT,
+							PKT_TYPE);
+
+	switch (pkt_fmt) {
+	case IPSU_METADATA_FMT_NO_ENC:
+		ptype |= RTE_PTYPE_L2_ETHER;
+		ptype |= hinic3_get_l3_ptype(ip_type);
+		ptype |= hinic3_get_l4_ptype(packet_type);
+		break;
+	case IPSU_METADATA_FMT_FC:
+		ptype |= RTE_PTYPE_L2_ETHER_FCOE;
+		break;
+	case IPSU_METADATA_FMT_NSH:
+		ptype |= RTE_PTYPE_L2_ETHER_NSH;
+		break;
+	default:
+	/* VXLAN, NVGRE, VXLAN_GPE, GENEVE, IPinIP */
+		ptype |= RTE_PTYPE_L2_ETHER;
+
+		switch (pkt_fmt) {
+		case IPSU_METADATA_FMT_VXLAN:
+			ptype |= RTE_PTYPE_L4_UDP;
+			ptype |= RTE_PTYPE_TUNNEL_VXLAN;
+			ptype |= RTE_PTYPE_INNER_L2_ETHER;
+			break;
+		case IPSU_METADATA_FMT_NVGRE:
+			ptype |= RTE_PTYPE_TUNNEL_GRE;
+			return ptype;
+		case IPSU_METADATA_FMT_GENEVE:
+			ptype |= RTE_PTYPE_L4_UDP;
+			ptype |= RTE_PTYPE_TUNNEL_GENEVE;
+			ptype |= RTE_PTYPE_INNER_L2_ETHER;
+			break;
+
+		case IPSU_METADATA_FMT_IPIP:
+			ptype |= RTE_PTYPE_TUNNEL_IP;
+			break;
+		default:
+			ptype |= RTE_PTYPE_L4_NONFRAG;
+			break;
+		}
+		if (ip_type == IPSU_METADATA_L3_TP_IPV4)
+			ptype |= RTE_PTYPE_INNER_L3_IPV4_EXT_UNKNOWN;
+		else if (ip_type == IPSU_METADATA_L3_TP_IPV6)
+			ptype |= RTE_PTYPE_INNER_L3_IPV6_EXT_UNKNOWN;
+		else
+			return ptype;
+		/* shift ptype to inner*/
+		ptype |= hinic3_get_l4_ptype(packet_type) << HINIC3_L4_PYTPE_SHIFT;
+	}
+	return ptype;
+}
+
+/**
+ * Get receive queue local ci
+ *
+ * @param[in] rxq
+ *   Receive queue
+ * @return
+ *   Receive queue local ci
+ */
+static inline uint16_t hinic3_get_rq_local_ci(struct hinic3_rxq *rxq)
+{
+	return MASKED_QUEUE_IDX(rxq, rxq->cons_idx);
+}
+
+static inline uint16_t hinic3_get_rq_free_wqebb(struct hinic3_rxq *rxq)
+{
+	return rxq->delta - 1;
+}
+
+/**
+ * Update receive queue local ci
+ *
+ * @param[in] rxq
+ *   Receive queue
+ * @param[in] wqe_cnt
+ *   Wqebb counters
+ */
+static inline void hinic3_update_rq_local_ci(struct hinic3_rxq *rxq,
+					     uint16_t wqe_cnt)
+{
+	rxq->cons_idx += wqe_cnt;
+	rxq->delta += wqe_cnt;
+}
+
 /**
  * Get wqe from receive queue.
  *
@@ -62,6 +296,13 @@ hinic3_get_rq_local_pi(struct hinic3_rxq *rxq)
 	return MASKED_QUEUE_IDX(rxq, rxq->prod_idx);
 }
 
+static inline uint16_t hinic3_get_rq_hw_ci(struct hinic3_rxq *rxq)
+{
+	struct hinic3_rq_ci_wb rq_ci;
+	rq_ci.dw1.value = hinic3_hw_cpu32(rte_read32(&rxq->rq_ci->dw1.value));
+	return rq_ci.dw1.bs.hw_ci;
+}
+
 uint16_t
 hinic3_rx_fill_wqe(struct hinic3_rxq *rxq)
 {
@@ -434,11 +675,11 @@ hinic3_init_rss_type(struct hinic3_nic_dev *nic_dev,
 	rss_type.ipv4 = (rss_hf & (RTE_ETH_RSS_IPV4 | RTE_ETH_RSS_FRAG_IPV4)) ? 1 : 0;
 	rss_type.tcp_ipv4 = (rss_hf & RTE_ETH_RSS_NONFRAG_IPV4_TCP) ? 1 : 0;
 	rss_type.ipv6 = (rss_hf & (RTE_ETH_RSS_IPV6 | RTE_ETH_RSS_FRAG_IPV6)) ? 1 : 0;
+	rss_type.ipv6_ext = (rss_hf & RTE_ETH_RSS_IPV6_EX) ? 1 : 0;
 	rss_type.tcp_ipv6 = (rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_TCP) ? 1 : 0;
+	rss_type.tcp_ipv6_ext = (rss_hf & RTE_ETH_RSS_IPV6_TCP_EX) ? 1 : 0;
 	rss_type.udp_ipv4 = (rss_hf & RTE_ETH_RSS_NONFRAG_IPV4_UDP) ? 1 : 0;
 	rss_type.udp_ipv6 = (rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_UDP) ? 1 : 0;
-	rss_type.ipv6_ext = (rss_hf & RTE_ETH_RSS_IPV6_EX) ? 1 : 0;
-	rss_type.tcp_ipv6_ext = (rss_hf & RTE_ETH_RSS_IPV6_TCP_EX) ? 1 : 0;
 
 	err = hinic3_set_rss_type(nic_dev->hwdev, rss_type);
 	if (err)
@@ -506,6 +747,36 @@ hinic3_update_rss_config(struct rte_eth_dev *dev,
 	return err;
 }
 
+/**
+ * Initialize the receive packet type table
+ * @param[in] dev
+ *   Pointer to ethernet device structure.
+ */
+
+int
+hinic3_init_rx_ptype_table(struct rte_eth_dev *dev)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	struct hinic3_ptype_table *tbl =
+		rte_zmalloc("ptype_tbl", sizeof(struct hinic3_ptype_table), 0);
+
+	if (tbl == NULL)
+		return -ENOMEM;
+
+	uint32_t *ptype = tbl->ptype;
+	uint32_t i;
+
+	if (nic_dev->config.rx_cqe_compact_en) {
+		for (i = 0; i < HINIC3_PTYPE_NUM; i++)
+			ptype[i] = hinic3_calc_rx_ptype_compact_table(i);
+	} else {
+		for (i = 0; i < HINIC3_PTYPE_NUM; i++)
+			ptype[i] = hinic3_calc_rx_ptype_table(i, nic_dev);
+	}
+	nic_dev->ptype_tbl = tbl;
+	return 0;
+}
+
 /**
  * Search given queue array to find position of given id.
  * Return queue pos or queue_count if not found.
@@ -602,7 +873,7 @@ hinic3_rx_queue_release_mbufs(struct hinic3_rxq *rxq)
 	hinic3_update_rq_local_ci(rxq, nr_released);
 }
 
-int
+static int
 hinic3_poll_rq_empty(struct hinic3_rxq *rxq)
 {
 	uint64_t end;
@@ -623,29 +894,21 @@ hinic3_poll_rq_empty(struct hinic3_rxq *rxq)
 	return err;
 }
 
-int
+static int
 hinic3_poll_integrated_cqe_rq_empty(struct hinic3_rxq *rxq)
 {
 	struct hinic3_rx_info *rx_info;
-	struct hinic3_rq_ci_wb rq_ci;
-	uint16_t sw_ci;
-	uint16_t hw_ci;
-	uint32_t val;
+	uint16_t sw_ci, sw_pi, hw_ci;
+	uint64_t end;
 
 	sw_ci = hinic3_get_rq_local_ci(rxq);
-	val = rte_read32(&rxq->rq_ci->dw1.value);
-	rq_ci.dw1.value = hinic3_hw_cpu32(val);
-	hw_ci = rq_ci.dw1.bs.hw_ci;
+	sw_pi = hinic3_get_rq_local_pi(rxq);
+	hw_ci = hinic3_get_rq_hw_ci(rxq);
 
 	if (HINIC3_IS_SP560_NIC(rxq->nic_dev)) {
-		uint16_t sw_pi = hinic3_get_rq_local_pi(rxq);
-		uint64_t end;
-
 		end = cycles + msecs_to_cycles(HINIC3_FLUSH_QUEUE_TIMEOUT);
 		do {
-			val = rte_read32(&rxq->rq_ci->dw1.value);
-			rq_ci.dw1.value = hinic3_hw_cpu32(val);
-			hw_ci = rq_ci.dw1.bs.hw_ci;
+			hw_ci = hinic3_get_rq_hw_ci(rxq);
 			if (sw_pi == hw_ci)
 				break;
 
@@ -669,22 +932,34 @@ hinic3_poll_integrated_cqe_rq_empty(struct hinic3_rxq *rxq)
 	return 0;
 }
 
-void
-hinic3_dump_cqe_status(struct hinic3_rxq *rxq, uint32_t *cqe_done_cnt,
-		       uint32_t *cqe_hole_cnt, uint32_t *head_ci, uint32_t *head_done)
+static void
+hinic3_dump_cqe_status(struct hinic3_rxq *rxq)
 {
-	uint16_t sw_ci;
+	volatile struct hinic3_rq_cqe *rx_cqe;
+	uint16_t sw_ci, sw_pi, hw_ci;
+	uint32_t head_ci, head_done;
 	uint16_t avail_pkts = 0;
 	uint16_t hit_done = 0;
 	uint16_t cqe_hole = 0;
-	RTE_ATOMIC(uint32_t)status;
-	volatile struct hinic3_rq_cqe *rx_cqe;
+	uint32_t status;
+
+	if (rxq->wqe_type == HINIC3_COMPACT_RQ_WQE) {
+		sw_ci = hinic3_get_rq_local_ci(rxq);
+		sw_pi = hinic3_get_rq_local_pi(rxq);
+		hw_ci = hinic3_get_rq_hw_ci(rxq);
+		PMD_DRV_LOG(ERR,
+			"Poll rq empty timeout, eth_dev:%s, queue_idx:%d, mbuf_left:%d, sw_pi:%d, sw_ci:%d, hw_ci:%d",
+			rxq->nic_dev->dev_name, rxq->q_id,
+			rxq->q_depth - hinic3_get_rq_free_wqebb(rxq),
+			sw_pi, sw_ci, hw_ci);
+		return;
+	}
 
 	sw_ci = hinic3_get_rq_local_ci(rxq);
 	rx_cqe = &rxq->rx_cqe[sw_ci];
 	status = rx_cqe->status;
-	*head_done = HINIC3_GET_RX_DONE(status);
-	*head_ci = sw_ci;
+	head_done = HINIC3_GET_RX_DONE(status);
+	head_ci = sw_ci;
 
 	for (sw_ci = 0; sw_ci < rxq->q_depth; sw_ci++) {
 		rx_cqe = &rxq->rx_cqe[sw_ci];
@@ -705,17 +980,17 @@ hinic3_dump_cqe_status(struct hinic3_rxq *rxq, uint32_t *cqe_done_cnt,
 		hit_done = 1;
 	}
 
-	*cqe_done_cnt = avail_pkts;
-	*cqe_hole_cnt = cqe_hole;
+	PMD_DRV_LOG(ERR, "Poll rq empty timeout, eth_dev:%s, queue_idx:%d, "
+		"mbuf_left:%d, cqe_done:%d, cqe_hole:%d, cqe[%d].done=%d",
+		rxq->nic_dev->dev_name, rxq->q_id,
+		rxq->q_depth - hinic3_get_rq_free_wqebb(rxq),
+		avail_pkts, cqe_hole, head_ci, head_done);
 }
 
 int
 hinic3_stop_rq(struct rte_eth_dev *eth_dev, struct hinic3_rxq *rxq)
 {
 	struct hinic3_nic_dev *nic_dev = rxq->nic_dev;
-	uint32_t cqe_done_cnt = 0;
-	uint32_t cqe_hole_cnt = 0;
-	uint32_t head_ci, head_done;
 	int err;
 
 	/* Disable rxq intr. */
@@ -762,23 +1037,21 @@ hinic3_stop_rq(struct rte_eth_dev *eth_dev, struct hinic3_rxq *rxq)
 		goto rq_flush_failed;
 	}
 
-	err = nic_dev->rx_ops->nic_rx_poll_rq_empty(rxq);
+	if (nic_dev->config.rx_cqe_compact_en)
+		err = hinic3_poll_integrated_cqe_rq_empty(rxq);
+	else
+		err = hinic3_poll_rq_empty(rxq);
+
 	if (err) {
-		hinic3_dump_cqe_status(rxq, &cqe_done_cnt, &cqe_hole_cnt,
-				       &head_ci, &head_done);
-		PMD_DRV_LOG(ERR, "Poll rq empty timeout");
-		PMD_DRV_LOG(ERR,
-			    "eth_dev:%s, queue_idx:%d, mbuf_left:%d, cqe_done:%d, cqe_hole:%d, cqe[%d].done=%d",
-			    nic_dev->dev_name, rxq->q_id,
-			    rxq->q_depth - hinic3_get_rq_free_wqebb(rxq),
-			    cqe_done_cnt, cqe_hole_cnt, head_ci, head_done);
+		hinic3_dump_cqe_status(rxq);
 		goto poll_rq_failed;
 	}
 
 	return 0;
 
 poll_rq_failed:
-	hinic3_set_rq_enable(nic_dev, rxq->q_id, true);
+	if ((hinic3_get_driver_feature(nic_dev) & NIC_F_HTN_FDIR) != 0)
+		(void)hinic3_set_rq_enable(nic_dev, rxq->q_id, true);
 rq_flush_failed:
 	rte_spinlock_lock(&nic_dev->queue_list_lock);
 set_indir_failed:
@@ -950,6 +1223,8 @@ hinic3_start_all_rqs(struct rte_eth_dev *eth_dev)
 
 	for (i = 0; i < nic_dev->num_rqs; i++) {
 		rxq = eth_dev->data->rx_queues[i];
+		if (rxq == NULL)
+			break;
 		hinic3_add_rq_to_rx_queue_list(nic_dev, rxq->q_id);
 		err = hinic3_rearm_rxq_mbuf(rxq);
 		if (err) {
@@ -978,6 +1253,8 @@ hinic3_start_all_rqs(struct rte_eth_dev *eth_dev)
 out:
 	for (i = 0; i < nic_dev->num_rqs; i++) {
 		rxq = eth_dev->data->rx_queues[i];
+		if (rxq == NULL)
+			continue;
 		hinic3_remove_rq_from_rx_queue_list(nic_dev, rxq->q_id);
 		hinic3_free_rxq_mbufs(rxq);
 		hinic3_dev_rx_queue_intr_disable(eth_dev, rxq->q_id);
@@ -985,38 +1262,14 @@ hinic3_start_all_rqs(struct rte_eth_dev *eth_dev)
 	}
 	return err;
 }
-
-bool
-hinic3_rx_separate_cqe_done(struct hinic3_rxq *rxq, volatile struct hinic3_rq_cqe **rx_cqe)
-{
-	volatile struct hinic3_rq_cqe *cqe = NULL;
-	uint16_t sw_ci;
-	uint32_t status;
-
-	sw_ci = hinic3_get_rq_local_ci(rxq);
-	*rx_cqe = &rxq->rx_cqe[sw_ci];
-	cqe = *rx_cqe;
-
-	status = hinic3_hw_cpu32((uint32_t)(rte_atomic_load_explicit(&cqe->status,
-								     rte_memory_order_acquire)));
-	if (!HINIC3_GET_RX_DONE(status))
-		return false;
-
-	return true;
-}
-
-bool
+static bool
 hinic3_rx_integrated_cqe_done(struct hinic3_rxq *rxq, volatile struct hinic3_rq_cqe **rx_cqe)
 {
-	struct hinic3_rq_ci_wb rq_ci;
 	struct rte_mbuf *rxm = NULL;
 	uint16_t sw_ci, hw_ci;
-	uint32_t val;
 
 	sw_ci = hinic3_get_rq_local_ci(rxq);
-	val = rte_read32(&rxq->rq_ci->dw1.value);
-	rq_ci.dw1.value = hinic3_hw_cpu32(val);
-	hw_ci = rq_ci.dw1.bs.hw_ci;
+	hw_ci = hinic3_get_rq_hw_ci(rxq);
 
 	if (hw_ci == sw_ci)
 		return false;
@@ -1028,28 +1281,7 @@ hinic3_rx_integrated_cqe_done(struct hinic3_rxq *rxq, volatile struct hinic3_rq_
 	return true;
 }
 
-void
-hinic3_rx_get_cqe_info(struct hinic3_rxq *rxq __rte_unused, volatile struct hinic3_rq_cqe *rx_cqe,
-		       struct hinic3_cqe_info *cqe_info)
-{
-	uint32_t dw0 = hinic3_hw_cpu32(rx_cqe->status);
-	uint32_t dw1 = hinic3_hw_cpu32(rx_cqe->vlan_len);
-	uint32_t dw2 = hinic3_hw_cpu32(rx_cqe->offload_type);
-	uint32_t dw3 = hinic3_hw_cpu32(rx_cqe->hash_val);
-
-	cqe_info->lro_num = RQ_CQE_STATUS_GET(dw0, NUM_LRO);
-	cqe_info->csum_err = RQ_CQE_STATUS_GET(dw0, CSUM_ERR);
-
-	cqe_info->pkt_len = RQ_CQE_SGE_GET(dw1, LEN);
-	cqe_info->vlan_tag = RQ_CQE_SGE_GET(dw1, VLAN);
-
-	cqe_info->ptype = HINIC3_GET_RX_PTYPE_OFFLOAD(dw0);
-	cqe_info->vlan_offload = RQ_CQE_OFFOLAD_TYPE_GET(dw2, VLAN_EN);
-	cqe_info->rss_type = RQ_CQE_OFFOLAD_TYPE_GET(dw2, RSS_TYPE);
-	cqe_info->rss_hash_value = dw3;
-}
-
-void
+static void
 hinic3_rx_get_compact_cqe_info(struct hinic3_rxq *rxq, volatile struct hinic3_rq_cqe *rx_cqe,
 			       struct hinic3_cqe_info *cqe_info)
 {
@@ -1075,7 +1307,16 @@ hinic3_rx_get_compact_cqe_info(struct hinic3_rxq *rxq, volatile struct hinic3_rq
 	cqe_info->ptype = HINIC3_RQ_COMPACT_CQE_STATUS_GET(dw0, PTYPE);
 	cqe_info->rss_type = (rxq->nic_dev->rss_type.val != 0) ? 1 : 0;
 	cqe_info->rss_hash_value = dw1;
-
+	switch (cqe_info->csum_err) {
+	case HINIC3_RX_COMPACT_CSUM_OTHER_ERROR:
+		cqe_info->csum_err = HINIC3_RX_CSUM_IPSU_OTHER_ERR;
+		break;
+	case HINIC3_RX_COMPACT_HW_BYPASS_ERROR:
+		cqe_info->csum_err = HINIC3_RX_CSUM_HW_CHECK_NONE;
+		break;
+	default:
+		break;
+	}
 	if (cqe_info->cqe_len == HINIC3_RQ_COMPACT_CQE_16BYTE) {
 		cqe_info->lro_num = HINIC3_RQ_COMPACT_CQE_OFFLOAD_GET(dw2, NUM_LRO);
 		cqe_info->vlan_tag = HINIC3_RQ_COMPACT_CQE_OFFLOAD_GET(dw2, VLAN);
@@ -1086,12 +1327,12 @@ hinic3_rx_get_compact_cqe_info(struct hinic3_rxq *rxq, volatile struct hinic3_rq
 				(cqe_info->cqe_len == HINIC3_RQ_COMPACT_CQE_16BYTE) ? 16 : 8;
 }
 
-#define HINIC3_RX_EMPTY_THRESHOLD 3
 uint16_t
-hinic3_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
+hinic3_recv_pkts_compact_cqe(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 {
 	struct hinic3_rxq *rxq = rx_queue;
 	struct hinic3_nic_dev *nic_dev = rxq->nic_dev;
+	const struct hinic3_ptype_table * const ptype_tbl = nic_dev->ptype_tbl;
 	struct hinic3_rx_info *rx_info = NULL;
 	volatile struct hinic3_rq_cqe *rx_cqe = NULL;
 	struct hinic3_cqe_info cqe_info = {0};
@@ -1111,13 +1352,12 @@ hinic3_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 	sw_ci = hinic3_get_rq_local_ci(rxq);
 
 	while (pkts < nb_pkts) {
-		rx_cqe = &rxq->rx_cqe[sw_ci];
-		if (!nic_dev->rx_ops->nic_rx_cqe_done(rxq, &rx_cqe)) {
+		if (!hinic3_rx_integrated_cqe_done(rxq, &rx_cqe)) {
 			rxq->rxq_stats.empty++;
 			break;
 		}
 
-		nic_dev->rx_ops->nic_rx_get_cqe_info(rxq, rx_cqe, &cqe_info);
+		hinic3_rx_get_compact_cqe_info(rxq, rx_cqe, &cqe_info);
 
 		pkt_len = cqe_info.pkt_len;
 		/*
@@ -1163,8 +1403,9 @@ hinic3_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 		/* 5. Vlan offload. */
 		rxm->ol_flags |= hinic3_rx_vlan(cqe_info.vlan_offload, cqe_info.vlan_tag,
 						&rxm->vlan_tci);
-
-		/* 6. RSS. */
+		/* 6. Packet ptype */
+		rxm->packet_type = ptype_tbl->ptype[cqe_info.ptype];
+		/* 7. RSS. */
 		rxm->ol_flags |= hinic3_rx_rss_hash(cqe_info.rss_type, cqe_info.rss_hash_value,
 						    &rxm->hash.rss);
 		/* 8. LRO. */
@@ -1204,3 +1445,141 @@ hinic3_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 
 	return pkts;
 }
+
+uint16_t hinic3_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
+{
+	struct hinic3_rxq *rxq = rx_queue;
+	struct hinic3_nic_dev *nic_dev = rxq->nic_dev;
+	struct hinic3_rx_info *rx_info = NULL;
+	volatile struct hinic3_rq_cqe *rx_cqe = NULL;
+	struct rte_mbuf *rxm = NULL;
+	uint16_t sw_ci, rx_buf_len, wqebb_cnt = 0, pkts = 0;
+	uint32_t status, pkt_len, vlan_len, offload_type, pkt_type, lro_num;
+	uint64_t rx_bytes = 0;
+	uint32_t hash_value = 0;
+	const struct hinic3_ptype_table * const ptype_tbl = nic_dev->ptype_tbl;
+
+#ifdef HINIC3_XSTAT_PROF_RX
+	uint64_t t1 = rte_get_tsc_cycles();
+	uint64_t t2;
+#endif
+	if (((rte_get_timer_cycles() - rxq->rxq_stats.tsc) < rxq->wait_time_cycle) &&
+	    rxq->rxq_stats.empty >= HINIC3_RX_EMPTY_THRESHOLD)
+		goto out;
+
+	sw_ci = hinic3_get_rq_local_ci(rxq);
+	rx_buf_len = rxq->buf_len;
+
+	while (pkts < nb_pkts) {
+		rx_cqe = &rxq->rx_cqe[sw_ci];
+		status = hinic3_hw_cpu32((uint32_t)(rte_atomic_load_explicit(&rx_cqe->status,
+								     rte_memory_order_acquire)));
+		if (!HINIC3_GET_RX_DONE(status)) {
+			rxq->rxq_stats.empty++;
+			break;
+		}
+
+		vlan_len = hinic3_hw_cpu32(rx_cqe->vlan_len);
+
+		pkt_len = HINIC3_GET_RX_PKT_LEN(vlan_len);
+
+		rx_info = &rxq->rx_info[sw_ci];
+		rxm = rx_info->mbuf;
+
+		/* 1. Next ci point and prefetch */
+		sw_ci++;
+		sw_ci &= rxq->q_mask;
+
+		/* 2. Prefetch next mbuf first 64B */
+		rte_prefetch0(rxq->rx_info[sw_ci].mbuf);
+
+		/* 3. Jumbo frame process */
+
+		if (likely(pkt_len <= (uint32_t)rx_buf_len)) {
+			rxm->data_len = (uint16_t)pkt_len;
+			rxm->pkt_len = pkt_len;
+			wqebb_cnt++;
+		} else {
+			rxm->data_len = rx_buf_len;
+			rxm->pkt_len = rx_buf_len;
+
+			/* If receive jumbo, updating ci will be done by
+			 * hinic3_recv_jumbo_pkt function.
+			 */
+			hinic3_update_rq_local_ci(rxq, wqebb_cnt + 1);
+			wqebb_cnt = 0;
+			hinic3_recv_jumbo_pkt(rxq, rxm, pkt_len - rx_buf_len);
+			sw_ci = hinic3_get_rq_local_ci(rxq);
+		}
+
+
+		/*
+		 * data_off was already set by rearm to the offset of the DMA
+		 * start address relative to buf (HEADROOM + alignment offset
+		 * when alignment is enabled, HEADROOM when disabled). The packet
+		 * data starts at buf + data_off, so no further adjustment is
+		 * needed.
+		 */
+		rxm->port = rxq->port_id;
+
+		/* 4. Rx checksum offload */
+		rxm->ol_flags |= hinic3_rx_csum(HINIC3_GET_RX_CSUM_ERR(status), rxq);
+
+		/* 5. Vlan offload */
+		offload_type = hinic3_hw_cpu32(rx_cqe->offload_type);
+
+		rxm->ol_flags |= hinic3_rx_vlan(HINIC3_GET_RX_VLAN_OFFLOAD_EN(offload_type),
+						HINIC3_GET_RX_VLAN_TAG(vlan_len),
+						&rxm->vlan_tci);
+
+		/* 6. Packet ptype */
+		pkt_type = HINIC3_GET_RX_PTYPE_OFFLOAD(offload_type);
+		rxm->packet_type = ptype_tbl->ptype[pkt_type];
+
+		/* 7. RSS */
+		hash_value = hinic3_hw_cpu32(rx_cqe->hash_val);
+		rxm->ol_flags |= hinic3_rx_rss_hash(HINIC3_GET_RSS_TYPES(offload_type),
+						    hash_value,
+						    &rxm->hash.rss);
+
+		/* 8. LRO */
+		lro_num = HINIC3_GET_RX_NUM_LRO(status);
+		if (unlikely(lro_num != 0)) {
+			rxm->ol_flags |= HINIC3_PKT_RX_LRO;
+			rxm->tso_segsz = pkt_len / lro_num;
+		}
+
+		rx_cqe->status = 0;
+
+		rx_bytes += pkt_len;
+		rx_pkts[pkts++] = rxm;
+	}
+
+	if (pkts) {
+		/* 9. Update local ci */
+		hinic3_update_rq_local_ci(rxq, wqebb_cnt);
+
+		/* Update packet stats */
+		rxq->rxq_stats.packets += pkts;
+		rxq->rxq_stats.bytes += rx_bytes;
+		rxq->rxq_stats.empty = 0;
+#ifdef HINIC3_XSTAT_MBUF_USE
+		rxq->rxq_stats.free_mbuf += pkts;
+#endif
+	}
+	rxq->rxq_stats.burst_pkts = pkts;
+	rxq->rxq_stats.tsc = rte_get_timer_cycles();
+out:
+	/* 10. Rearm mbuf to rxq */
+	hinic3_rearm_rxq_mbuf(rxq);
+
+#ifdef HINIC3_XSTAT_PROF_RX
+	/* do profiling stats */
+	t2 = rte_get_tsc_cycles();
+	rxq->rxq_stats.app_tsc = t1 - rxq->prof_rx_end_tsc;
+	rxq->prof_rx_end_tsc = t2;
+	rxq->rxq_stats.pmd_tsc = t2 - t1;
+#endif
+
+	return pkts;
+}
diff --git a/drivers/net/hinic3/hinic3_rx.h b/drivers/net/hinic3/hinic3_rx.h
index 129c2b4a59..e9551fab3b 100644
--- a/drivers/net/hinic3/hinic3_rx.h
+++ b/drivers/net/hinic3/hinic3_rx.h
@@ -5,11 +5,23 @@
 #ifndef _HINIC3_RX_H_
 #define _HINIC3_RX_H_
 
+#include "hinic3_wq.h"
+
 #define RQ_CQE_OFFOLAD_TYPE_PTYPE_OFFLOAD_SHIFT	0
+#define RQ_CQE_OFFOLAD_TYPE_PKT_TYPE_SHIFT	0
+#define RQ_CQE_OFFOLAD_TYPE_IP_TYPE_SHIFT	5
+#define RQ_CQE_OFFOLAD_TYPE_ENC_L3_TYPE_SHIFT	7
+#define RQ_CQE_OFFOLAD_TYPE_PKT_FORMAT_SHIFT	8
+#define RQ_CQE_OFFOLAD_TYPE_PKT_UMBCAST_SHIFT	19
 #define RQ_CQE_OFFOLAD_TYPE_VLAN_EN_SHIFT	21
 #define RQ_CQE_OFFOLAD_TYPE_RSS_TYPE_SHIFT	24
 
 #define RQ_CQE_OFFOLAD_TYPE_PTYPE_OFFLOAD_MASK	0xFFFU
+#define RQ_CQE_OFFOLAD_TYPE_PKT_TYPE_MASK	0x1FU
+#define RQ_CQE_OFFOLAD_TYPE_IP_TYPE_MASK	0x3U
+#define RQ_CQE_OFFOLAD_TYPE_ENC_L3_TYPE_MASK	0X1U
+#define RQ_CQE_OFFOLAD_TYPE_PKT_FORMAT_MASK	0xFU
+#define RQ_CQE_OFFOLAD_TYPE_PKT_UMBCAST_MASK	0x3U
 #define RQ_CQE_OFFOLAD_TYPE_VLAN_EN_MASK	0x1U
 #define RQ_CQE_OFFOLAD_TYPE_RSS_TYPE_MASK	0xFFU
 
@@ -25,6 +37,15 @@
 #define HINIC3_GET_RX_PKT_TYPE(offload_type) \
 	RQ_CQE_OFFOLAD_TYPE_GET(offload_type, PKT_TYPE)
 
+#define HINIC3_GET_RX_IP_TYPE(offload_type) \
+	RQ_CQE_OFFOLAD_TYPE_GET(offload_type, IP_TYPE)
+
+#define HINIC3_GET_RX_ENC_L3_TYPE(offload_type) \
+	RQ_CQE_OFFOLAD_TYPE_GET(offload_type, ENC_L3_TYPE)
+
+#define HINIC3_GET_RX_PKT_FORMAT(offload_type) \
+	RQ_CQE_OFFOLAD_TYPE_GET(offload_type, PKT_FORMAT)
+
 #define HINIC3_GET_RX_PKT_UMBCAST(offload_type) \
 	RQ_CQE_OFFOLAD_TYPE_GET(offload_type, PKT_UMBCAST)
 
@@ -142,10 +163,10 @@
 #define RQ_COMPACT_CQE_STATUS_CQE_TYPE_MASK		0x1U
 #define RQ_COMPACT_CQE_STATUS_TS_FLAG_MASK		0x1U
 #define RQ_COMPACT_CQE_STATUS_VLAN_EN_MASK		0x1U
-#define RQ_COMPACT_CQE_STATUS_PKT_FORMAT_MASK	0x7U
+#define RQ_COMPACT_CQE_STATUS_PKT_FORMAT_MASK		0x7U
 #define RQ_COMPACT_CQE_STATUS_IP_TYPE_MASK		0x1U
 #define RQ_COMPACT_CQE_STATUS_CQE_LEN_MASK		0x1U
-#define RQ_COMPACT_CQE_STATUS_PKT_MC_MASK		0x1U
+#define RQ_COMPACT_CQE_STATUS_PKT_MC_MASK		0x3U
 #define RQ_COMPACT_CQE_STATUS_CSUM_ERR_MASK		0x3U
 #define RQ_COMPACT_CQE_STATUS_PKT_TYPE_MASK		0x7U
 #define RQ_COMPACT_CQE_STATUS_PTYPE_MASK		0xFFFU
@@ -182,6 +203,13 @@
 #define HINIC3_RX_CSUM_HW_CHECK_NONE    RTE_BIT32(7)
 #define HINIC3_RX_CSUM_IPSU_OTHER_ERR   RTE_BIT32(8)
 
+enum hinic3_compact_cqe_csum_err_type {
+	HINIC3_RX_COMPACT_CSUM_NO_ERROR = 0,
+	HINIC3_RX_COMPACT_L3_L4_CSUM_ERROR,
+	HINIC3_RX_COMPACT_CSUM_OTHER_ERROR,
+	HINIC3_RX_COMPACT_HW_BYPASS_ERROR
+};
+
 #define HINIC3_DEFAULT_RX_CSUM_OFFLOAD 0xFFF
 #define HINIC3_CQE_LEN		       32
 
@@ -200,6 +228,72 @@
 	RTE_ETH_RSS_IPV6_TCP_EX |        \
 	RTE_ETH_RSS_IPV6_UDP_EX)
 
+#define HINIC3_L4_PYTPE_SHIFT	16
+#define HINIC3_COMPACT_CQE_PTYPE_SHIFT 16
+
+/* keep same with IPSU_METADATA_L3_TP_E */
+enum HINIC3_RX_CQE_PT_L3 {
+	HINIC3_RX_CQE_L3_IPV4 = 0u,
+	HINIC3_RX_CQE_L3_IPV6 = 1u,
+};
+
+/* keep same with IPSU_PKT_TYPE_L45FINAL_E */
+enum HINIC3_RX_CQE_PT_L4 {
+	HINIC3_RX_CQE_L4_TCP = 3,
+	HINIC3_RX_CQE_L4_UDP = 4,
+};
+
+enum IPSU_METADATA_L3_TP_E {
+	IPSU_METADATA_L3_TP_IPV4 = 0u,
+	IPSU_METADATA_L3_TP_IPV6 = 1u,
+};
+
+enum IPSU_PKT_TYPE_L45FINAL_E {
+	IPSU_PKT_TYPE_NULL = 0,
+	IPSU_PKT_TYPE_ROCEV2,
+	IPSU_PKT_TYPE_TCPCOCO,
+	IPSU_PKT_TYPE_TCP,
+	IPSU_PKT_TYPE_UDP,
+	IPSU_PKT_TYPE_ICMP,
+	IPSU_PKT_TYPE_IGMP,
+	IPSU_PKT_TYPE_SCTP,
+	IPSU_PKT_TYPE_DHCP,
+	IPSU_PKT_TYPE_IPV4_FRAG,
+	IPSU_PKT_TYPE_IPV6_MC,
+	IPSU_PKT_TYPE_1588,
+	IPSU_PKT_TYPE_AH_OVER_IP,
+	IPSU_PKT_TYPE_ESP_OVER_IP,
+	IPSU_PKT_TYPE_NATT,
+	IPSU_PKT_TYPE_AH_OVER_VXLAN_GPE,
+	IPSU_PKT_TYPE_ESP_OVER_VXLAN_GPE,
+	IPSU_PKT_TYPE_TSO,
+	IPSU_PKT_TYPE_UFO,
+	IPSU_PKT_TYPE_INT,
+	IPSU_PKT_TYPE_IOAM,
+	IPSU_PKT_TYPE_VXLAN_GPE,
+	IPSU_PKT_TYPE_GENEVE,
+	IPSU_PKT_TYPE_NSH_OVER_GENEVE,
+	IPSU_PKT_TYPE_NSH_OVER_VXLAN_GPE,
+	IPSU_PKT_TYPE_ESP_OVER_GENEVE,
+	IPSU_PKT_TYPE_PPOP_OVER_GENEVE,
+	IPSU_PKT_TYPE_OSPF,
+	IPSU_PKT_TYPE_VRRP,
+	IPSU_PKT_TYPE_BGP,
+	IPSU_PKT_TYPE_GRE,
+	IPSU_ERR_RSVD,
+};
+
+enum IPSU_METADATA_FMT_E {
+	IPSU_METADATA_FMT_NO_ENC	= 0u,
+	IPSU_METADATA_FMT_VXLAN		= 1u,
+	IPSU_METADATA_FMT_NVGRE		= 2u,
+	IPSU_METADATA_FMT_FC		= 3u,
+	IPSU_METADATA_FMT_GPE		= 4u,
+	IPSU_METADATA_FMT_GENEVE	= 5u,
+	IPSU_METADATA_FMT_NSH		= 6u,
+	IPSU_METADATA_FMT_IPIP		= 7U,
+};
+
 struct hinic3_rxq_stats {
 	uint64_t packets;
 	uint64_t bytes;
@@ -313,7 +407,6 @@ struct hinic3_rq_ci_wb {
 	uint32_t rsvd[3];
 };
 
-
 struct __rte_cache_aligned hinic3_rxq {
 	struct hinic3_nic_dev *nic_dev;
 
@@ -370,24 +463,6 @@ struct __rte_cache_aligned hinic3_rxq {
 #endif
 };
 
-/* Rx CQE info get callback function */
-typedef void  (*nic_rx_get_cqe_info_t)(struct hinic3_rxq *rxq,
-				       volatile struct hinic3_rq_cqe *rx_cqe,
-				       struct hinic3_cqe_info *cqe_info);
-
-/* Rx CQE check status callback function */
-typedef bool  (*nic_rx_cqe_done_t)(struct hinic3_rxq *rxq,
-				   volatile struct hinic3_rq_cqe **rx_cqe);
-
-/* Rx CQE empty poll callback function */
-typedef int   (*nic_rx_poll_rq_empty_t)(struct hinic3_rxq *rxq);
-
-struct hinic3_nic_rx_ops {
-	nic_rx_get_cqe_info_t		nic_rx_get_cqe_info;
-	nic_rx_cqe_done_t		nic_rx_cqe_done;
-	nic_rx_poll_rq_empty_t		nic_rx_poll_rq_empty;
-};
-
 uint16_t hinic3_rx_fill_wqe(struct hinic3_rxq *rxq);
 
 uint16_t hinic3_rx_fill_buffers(struct hinic3_rxq *rxq);
@@ -399,16 +474,14 @@ void hinic3_free_all_rxq_mbufs(struct hinic3_nic_dev *nic_dev);
 int hinic3_update_rss_config(struct rte_eth_dev *dev,
 			     struct rte_eth_rss_conf *rss_conf);
 
-int hinic3_poll_integrated_cqe_rq_empty(struct hinic3_rxq *rxq);
-int hinic3_poll_rq_empty(struct hinic3_rxq *rxq);
-
-void hinic3_dump_cqe_status(struct hinic3_rxq *rxq, uint32_t *cqe_done_cnt,
-			    uint32_t *cqe_hole_cnt, uint32_t *head_ci, uint32_t *head_done);
+int hinic3_init_rx_ptype_table(struct rte_eth_dev *dev);
 
 int hinic3_stop_rq(struct rte_eth_dev *eth_dev, struct hinic3_rxq *rxq);
 
 int hinic3_start_rq(struct rte_eth_dev *eth_dev, struct hinic3_rxq *rxq);
 
+uint16_t hinic3_recv_pkts_compact_cqe(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts);
+
 uint16_t hinic3_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts);
 
 void hinic3_add_rq_to_rx_queue_list(struct hinic3_nic_dev *nic_dev,
@@ -426,95 +499,4 @@ int hinic3_start_all_rqs(struct rte_eth_dev *eth_dev);
 void hinic3_get_stats(struct hinic3_rxq *rxq);
 #endif
 
-/**
- * Get receive queue local ci.
- *
- * @param[in] rxq
- * Pointer to receive queue structure.
- * @return
- * Receive queue local ci.
- */
-static inline uint16_t
-hinic3_get_rq_local_ci(struct hinic3_rxq *rxq)
-{
-	return MASKED_QUEUE_IDX(rxq, rxq->cons_idx);
-}
-
-static inline uint16_t
-hinic3_get_rq_free_wqebb(struct hinic3_rxq *rxq)
-{
-	return rxq->delta - 1;
-}
-
-/**
- * Update receive queue local ci.
- *
- * @param[in] rxq
- * Pointer to receive queue structure.
- * @param[out] wqe_cnt
- * Wqebb counters.
- */
-static inline void
-hinic3_update_rq_local_ci(struct hinic3_rxq *rxq, uint16_t wqe_cnt)
-{
-	rxq->cons_idx += wqe_cnt;
-	rxq->delta += wqe_cnt;
-}
-
-/**
- * Get receive cqe information
- *
- * @param[in] rxq
- *   Receive queue
- * @param[in] rx_cqe
- *   Receive cqe
- * @param[in] cqe_info
- *   Packet information parsed from cqe
- */
-void
-hinic3_rx_get_cqe_info(struct hinic3_rxq *rxq, volatile struct hinic3_rq_cqe *rx_cqe,
-		       struct hinic3_cqe_info *cqe_info);
-
-/**
- * Get receive compact cqe information
- *
- * @param[in] rx_queue
- *   Receive queue
- * @param[in] rx_cqe
- *   Receive compact cqe
- * @param[in] cqe_info
- *   Packet information parsed from cqe
- */
-void
-hinic3_rx_get_compact_cqe_info(struct hinic3_rxq *rxq, volatile struct hinic3_rq_cqe *rx_cqe,
-			       struct hinic3_cqe_info *cqe_info);
-
-/**
- * Check whether pkt is received when CQE is separated
- *
- * @param[in] rxq
- *   Receive queue
- * @param[in] rx_cqe
- *   The CQE written by hw
- * @return
- *   True: Packet is received
- *   False: Packet is not received
- */
-bool
-hinic3_rx_separate_cqe_done(struct hinic3_rxq *rxq, volatile struct hinic3_rq_cqe **rx_cqe);
-
-/**
- * Check whether pkt is received when CQE is integrated
- *
- * @param[in] rxq
- *   Receive queue
- * @param[in] rx_cqe
- *   The CQE written by hw
- * @return
- *   True: Packet is received
- *   False: Packet is not received
- */
-bool
-hinic3_rx_integrated_cqe_done(struct hinic3_rxq *rxq, volatile struct hinic3_rq_cqe **rx_cqe);
-
 #endif /* _HINIC3_RX_H_ */
-- 
2.33.0

