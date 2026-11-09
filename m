Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA04B606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 16:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=lPgVceLb
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2ABF4278D;
	Mon,  9 Nov 2026 17:21:24 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.3])
 by mails.dpdk.org (Postfix) with ESMTPS id 1968640B92
 for <dev@dpdk.org>; Mon,  9 Nov 2026 17:21:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=H1JLS6q4Mn3wqCotWGeUIXJCDF8r0jTv1u1GlfCPETg=;
 b=lPgVceLbK0UqU9Idn6L+Zo6jeJRZVidALnZVlZ0g9Vw76sJ107Jx7w5z1RgGK6
 Cx27yc03I+4OJZWLwwimWfuBV9OpZWjnikx2Spz1Ke5XeM1XX5mql1eD6Mmkz9PZ
 6uEAHbb/Ky+nNuCQ/kwBZqVAa6hAW+fF05x0wb4CmZDr0=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v6 25/28] net/hinic3: split Tx burst function for compact CQE
 support
Date: Tue, 10 Nov 2026 00:20:29 +0800
Message-ID: <20261109162033.1144-26-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261109162033.1144-1-yejiacheng4@h-partners.com>
References: <20261030144733.2120-1-yejiacheng4@h-partners.com>
 <20261109162033.1144-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgDHX3Hg8vFqjqUoBQ--.4058S27
X-Coremail-Antispam: 1Uf129KBjvAXoWfCFyfKryrAw4DKr45ZF4fKrg_yoW5uF48Co
 WSqrn8trn2yryxCayj9w4DuF1DtrZYgFZ8Jws0yr4Iq3WUZr1jqayayw1fX3W0qrZ8u3Zr
 A3Z5GwnFywsxJw45n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU2UDGUUUUU
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiMwsOGGrx8usInwAA37
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The combined Tx burst path suffers from severe cache misses because the
compact CQE and normal paths are interleaved. Split out a dedicated
compact CQE entry point and select it by the
NIC_F_TX_WQE_COMPACT_TASK feature bit, so the Tx WQE task format always
matches the hardware capability rather than the NIC model.

Clear the per-packet offload state before the next packet fills it, guard
the initial prefetch against an empty burst, and drop the per-packet logs
from the data path.

Clear queue_info in the scalar burst for SQ_WQE_COMPACT_TYPE, once per
packet, like hinic3_master: a compact WQE has no SQ control section and
the scalar burst does not fill its 4-byte task, while a NIC that uses
compact-task WQEs keeps the task in queue_info.

Tunneled Tx packets are accepted by tunnel type instead of by feature
bit; VXLAN_GPE TSO and IPIP TSO on SP620 stay rejected with a whole-enum
comparison and a DEBUG log. The unused nic_dev argument of
hinic3_get_inner_l3_offset() and hinic3_get_tx_offload() is dropped.

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 doc/guides/rel_notes/release_26_11.rst |   1 +
 drivers/net/hinic3/hinic3_ethdev.c     |  28 +-
 drivers/net/hinic3/hinic3_ethdev.h     |   1 -
 drivers/net/hinic3/hinic3_tx.c         | 562 ++++++++++++++++++++-----
 drivers/net/hinic3/hinic3_tx.h         |  35 +-
 5 files changed, 478 insertions(+), 149 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 841f2c4f9d..66d41cfd66 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -174,6 +174,7 @@ New Features
   * Added device parameters for runtime configuration.
   * Added a compact CQE receive data path.
   * Extended TCP segmentation offload (TSO) to 255 segments.
+  * Added a compact CQE transmit data path.
 
 * **Updated Intel iavf driver.**
 
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index 49d74d1420..85346dcfca 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -1462,6 +1462,7 @@ hinic3_tx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 			(HINIC3_COS_NUM_MAX - 1) & nic_dev->cos_mask];
 
 	txq->tx_deferred_start = tx_conf->tx_deferred_start;
+
 	txq->tx_wqe_compact_task = HINIC3_SUPPORT_TX_WQE_COMPACT_TASK(nic_dev);
 
 	ci_mz = hinic3_dma_zone_reserve(dev, "hinic3_sq_ci", qid,
@@ -3873,14 +3874,6 @@ static const struct eth_dev_ops hinic3_pmd_vf_ops = {
 	.eth_dev_priv_dump             = hinic3_eth_dev_priv_dump,
 };
 
-static void hinic3_nic_tx_rx_ops_init(struct hinic3_nic_dev *nic_dev)
-{
-	if (HINIC3_SUPPORT_TX_WQE_COMPACT_TASK(nic_dev))
-		nic_dev->tx_ops->nic_tx_set_wqe_offload = hinic3_tx_set_compact_task_offload;
-	else
-		nic_dev->tx_ops->nic_tx_set_wqe_offload = hinic3_tx_set_normal_task_offload;
-}
-
 /**
  * Initialize the network function, including hardware configuration, memory
  * allocation for data structures, MAC address setup, and interrupt enabling.
@@ -3941,13 +3934,6 @@ hinic3_func_init(struct rte_eth_dev *eth_dev)
 		goto alloc_eth_addr_fail;
 	}
 
-	nic_dev->tx_ops = rte_zmalloc("tx_ops", sizeof(struct hinic3_nic_tx_ops), 0);
-	if (!nic_dev->tx_ops) {
-		PMD_DRV_LOG(ERR, "Allocate tx_ops memory failed");
-		err = -ENOMEM;
-		goto alloc_tx_ops_fail;
-	}
-
 	nic_dev->mc_list = rte_zmalloc("hinic3_mc",
 		HINIC3_MAX_MC_MAC_ADDRS * sizeof(struct rte_ether_addr), 0);
 	if (!nic_dev->mc_list) {
@@ -4001,8 +3987,6 @@ hinic3_func_init(struct rte_eth_dev *eth_dev)
 		goto get_cap_fail;
 	}
 
-	hinic3_nic_tx_rx_ops_init(nic_dev);
-
 	err = hinic3_init_sw_rxtxqs(nic_dev);
 	if (err) {
 		PMD_DRV_LOG(ERR, "Init sw rxqs or txqs failed, dev_name: %s",
@@ -4092,10 +4076,6 @@ hinic3_func_init(struct rte_eth_dev *eth_dev)
 	nic_dev->mc_list = NULL;
 
 alloc_mc_list_fail:
-	rte_free(nic_dev->tx_ops);
-	nic_dev->tx_ops = NULL;
-
-alloc_tx_ops_fail:
 	rte_free(eth_dev->data->mac_addrs);
 	eth_dev->data->mac_addrs = NULL;
 
@@ -4268,13 +4248,17 @@ hinic3_dev_init(struct rte_eth_dev *eth_dev)
 	}
 
 	eth_dev->tx_pkt_prepare = hinic3_prep_pkts;
-	eth_dev->tx_pkt_burst = hinic3_xmit_pkts;
 
 	if (nic_dev->config.rx_cqe_compact_en != HINIC3_RX_CQE_COMPACT_EN)
 		eth_dev->rx_pkt_burst = hinic3_recv_pkts;
 	else
 		eth_dev->rx_pkt_burst = hinic3_recv_pkts_compact_cqe;
 
+	if (HINIC3_SUPPORT_TX_WQE_COMPACT_TASK(nic_dev))
+		eth_dev->tx_pkt_burst = hinic3_xmit_pkts_compact_cqe;
+	else
+		eth_dev->tx_pkt_burst = hinic3_xmit_pkts;
+
 	return 0;
 }
 
diff --git a/drivers/net/hinic3/hinic3_ethdev.h b/drivers/net/hinic3/hinic3_ethdev.h
index dfa5bf8b8f..4600e37f0b 100644
--- a/drivers/net/hinic3/hinic3_ethdev.h
+++ b/drivers/net/hinic3/hinic3_ethdev.h
@@ -190,7 +190,6 @@ struct hinic3_nic_dev {
 	struct hinic3_fdir_rule_filter_list filter_fdir_rule_list;
 	uint8_t cos_map[HINIC3_COS_NUM_MAX];
 	struct hinic3_ptype_table *ptype_tbl;
-	struct hinic3_nic_tx_ops *tx_ops;
 	enum nic_type nic_type; /**< NIC type. */
 
 };
diff --git a/drivers/net/hinic3/hinic3_tx.c b/drivers/net/hinic3/hinic3_tx.c
index eedada96f6..a9dcb99095 100644
--- a/drivers/net/hinic3/hinic3_tx.c
+++ b/drivers/net/hinic3/hinic3_tx.c
@@ -77,6 +77,30 @@ hinic3_get_and_update_sq_owner(struct hinic3_txq *sq, uint16_t curr_pi, uint16_t
 	return owner;
 }
 
+static void *
+hinic3_get_sq_wqe(struct hinic3_txq *sq,
+		  struct hinic3_wqe_info *wqe_info)
+{
+	uint16_t cur_pi = MASKED_QUEUE_IDX(sq, sq->prod_idx);
+	uint32_t end_pi;
+
+	end_pi = cur_pi + wqe_info->wqebb_cnt;
+	sq->prod_idx += wqe_info->wqebb_cnt;
+
+	wqe_info->owner = (uint8_t)(sq->owner);
+	wqe_info->pi = cur_pi;
+	wqe_info->wrapped = 0;
+
+	if (unlikely(end_pi >= sq->q_depth)) {
+		sq->owner = !sq->owner;
+
+		if (likely(end_pi > sq->q_depth))
+			wqe_info->wrapped = (uint8_t)(sq->q_depth - cur_pi);
+	}
+
+	return NIC_WQE_ADDR(sq, cur_pi);
+}
+
 static inline void
 hinic3_put_sq_wqe(struct hinic3_txq *sq, struct hinic3_wqe_info *wqe_info)
 {
@@ -97,9 +121,9 @@ hinic3_put_sq_wqe(struct hinic3_txq *sq, struct hinic3_wqe_info *wqe_info)
  * Point to wqe_info of send queue(SQ).
  */
 static void
-hinic3_set_wqe_combo(struct hinic3_txq *sq,
-		     struct hinic3_sq_wqe_combo *wqe_combo,
-		     struct hinic3_wqe_info *wqe_info)
+hinic3_set_wqe_combo_compact_cqe(struct hinic3_txq *sq,
+				 struct hinic3_sq_wqe_combo *wqe_combo,
+				 struct hinic3_wqe_info *wqe_info)
 {
 	uint16_t tmp_pi;
 
@@ -124,6 +148,62 @@ hinic3_set_wqe_combo(struct hinic3_txq *sq,
 	wqe_info->owner = hinic3_get_and_update_sq_owner(sq, wqe_info->pi, wqe_info->wqebb_cnt);
 }
 
+/**
+ * Sets the WQE combination information in the transmit queue (SQ).
+ *
+ * @param[in] sq
+ * Point to send queue.
+ * @param[out] wqe_combo
+ * Point to wqe_combo of send queue(SQ).
+ * @param[in] wqe_info
+ * Point to wqe_info of send queue(SQ).
+ */
+static void
+hinic3_set_wqe_combo(struct hinic3_txq *sq,
+		     struct hinic3_sq_wqe_combo *wqe_combo,
+		     struct hinic3_sq_wqe *wqe,
+		     struct hinic3_wqe_info *wqe_info)
+{
+	wqe_combo->hdr = &wqe->compact_wqe.wqe_desc;
+
+	if (wqe_info->offload) {
+		if (wqe_info->wrapped == HINIC3_TX_TASK_WRAPPED) {
+			wqe_combo->task = (struct hinic3_sq_task *)
+				(void *)sq->sq_head_addr;
+			wqe_combo->bds_head = (struct hinic3_sq_bufdesc *)
+				(void *)(sq->sq_head_addr + sq->wqebb_size);
+		} else if (wqe_info->wrapped == HINIC3_TX_BD_DESC_WRAPPED) {
+			wqe_combo->task = &wqe->extend_wqe.task;
+			wqe_combo->bds_head = (struct hinic3_sq_bufdesc *)
+				(void *)(sq->sq_head_addr);
+		} else {
+			wqe_combo->task = &wqe->extend_wqe.task;
+			wqe_combo->bds_head = wqe->extend_wqe.buf_desc;
+		}
+
+		wqe_combo->wqe_type = SQ_WQE_EXTENDED_TYPE;
+		wqe_combo->task_type = SQ_WQE_TASKSECT_16BYTES;
+		return;
+	}
+
+	if (wqe_info->wrapped == HINIC3_TX_TASK_WRAPPED) {
+		wqe_combo->bds_head = (struct hinic3_sq_bufdesc *)
+				(void *)(sq->sq_head_addr);
+	} else {
+		wqe_combo->bds_head =
+			(struct hinic3_sq_bufdesc *)(&wqe->extend_wqe.task);
+	}
+
+	if (wqe_info->wqebb_cnt > 1) {
+		wqe_combo->wqe_type = SQ_WQE_EXTENDED_TYPE;
+		wqe_combo->task_type = SQ_WQE_TASKSECT_4BYTES;
+		/* This section used as vlan insert, needs to clear */
+		wqe_combo->bds_head->rsvd = 0;
+	} else {
+		wqe_combo->wqe_type = SQ_WQE_COMPACT_TYPE;
+	}
+}
+
 int
 hinic3_start_all_sqs(struct rte_eth_dev *eth_dev)
 {
@@ -411,21 +491,17 @@ static inline void hinic3_calculate_phdr_checksum(struct rte_mbuf *mbuf,
 }
 
 static int
-hinic3_get_inner_l3_offset(struct hinic3_nic_dev *nic_dev, struct rte_mbuf *mbuf,
-			   uint16_t *inner_l3_offset)
+hinic3_get_inner_l3_offset(struct rte_mbuf *mbuf, uint16_t *inner_l3_offset)
 {
 	uint64_t ol_flags = mbuf->ol_flags;
 	uint64_t tunnel_type = ol_flags & HINIC3_PKT_TX_TUNNEL_MASK;
 
-	if (tunnel_type) {
-		if (!((tunnel_type == HINIC3_PKT_TX_TUNNEL_VXLAN &&
-		       HINIC3_SUPPORT_VXLAN_OFFLOAD(nic_dev)) ||
-		      (tunnel_type == HINIC3_PKT_TX_TUNNEL_GENEVE &&
-		       HINIC3_SUPPORT_GENEVE_OFFLOAD(nic_dev)) ||
-		      (tunnel_type == HINIC3_PKT_TX_TUNNEL_IPIP &&
-		       HINIC3_SUPPORT_IPXIP_OFFLOAD(nic_dev))))
-			return -EINVAL;
-	}
+	if (tunnel_type &&
+	    tunnel_type != HINIC3_PKT_TX_TUNNEL_VXLAN &&
+	    tunnel_type != HINIC3_PKT_TX_TUNNEL_GENEVE &&
+	    tunnel_type != HINIC3_PKT_TX_TUNNEL_VXLAN_GPE &&
+	    tunnel_type != HINIC3_PKT_TX_TUNNEL_IPIP)
+		return -EINVAL;
 
 #ifdef RTE_LIBRTE_ETHDEV_DEBUG
 	if (rte_validate_tx_offload(mbuf) != 0)
@@ -472,7 +548,6 @@ hinic3_get_inner_l3_offset(struct hinic3_nic_dev *nic_dev, struct rte_mbuf *mbuf
 	return 0;
 }
 
-
 uint16_t
 hinic3_prep_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 {
@@ -489,7 +564,7 @@ hinic3_prep_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		if (!(mbuf->ol_flags & HINIC3_TX_OFFLOAD_MASK))
 			continue;
 
-		ret = hinic3_get_inner_l3_offset(nic_dev, mbuf, &inner_l3_offset);
+		ret = hinic3_get_inner_l3_offset(mbuf, &inner_l3_offset);
 		if (unlikely(ret)) {
 			rte_errno = -ret;
 			return i;
@@ -528,33 +603,15 @@ hinic3_prep_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	return i;
 }
 
-void
-hinic3_tx_set_normal_task_offload(struct hinic3_wqe_info *wqe_info,
-				  struct hinic3_sq_wqe_combo *wqe_combo)
+static inline void hinic3_set_vlan_tx_offload(struct hinic3_sq_task *task,
+					      uint16_t vlan_tag, uint8_t vlan_type)
 {
-	struct hinic3_sq_task *task = wqe_combo->task;
-	struct hinic3_offload_info *offload_info = &wqe_info->offload_info;
-
-	task->pkt_info0 = 0;
-	task->pkt_info0 |= SQ_TASK_INFO0_SET(offload_info->inner_l4_en, INNER_L4_EN);
-	task->pkt_info0 |= SQ_TASK_INFO0_SET(offload_info->inner_l3_en, INNER_L3_EN);
-	task->pkt_info0 |= SQ_TASK_INFO0_SET(offload_info->encapsulation, TUNNEL_FLAG);
-	task->pkt_info0 |= SQ_TASK_INFO0_SET(offload_info->out_l3_en, OUT_L3_EN);
-	task->pkt_info0 |= SQ_TASK_INFO0_SET(offload_info->out_l4_en, OUT_L4_EN);
-	task->pkt_info0 = hinic3_hw_be32(task->pkt_info0);
-
-	if (wqe_combo->task_type == SQ_WQE_TASKSECT_16BYTES) {
-		task->ip_identify = 0;
-		task->pkt_info2 = 0;
-		task->vlan_offload = 0;
-		task->vlan_offload = SQ_TASK_INFO3_SET(offload_info->vlan_tag, VLAN_TAG) |
-				     SQ_TASK_INFO3_SET(offload_info->vlan_sel, VLAN_TYPE) |
-				     SQ_TASK_INFO3_SET(offload_info->vlan_valid, VLAN_TAG_VALID);
-		task->vlan_offload = hinic3_hw_be32(task->vlan_offload);
-	}
+	task->vlan_offload = SQ_TASK_INFO3_SET(vlan_tag, VLAN_TAG) |
+			     SQ_TASK_INFO3_SET(vlan_type, VLAN_TYPE) |
+			     SQ_TASK_INFO3_SET(1U, VLAN_TAG_VALID);
 }
 
-void
+static void
 hinic3_tx_set_compact_task_offload(struct hinic3_wqe_info *wqe_info,
 				   struct hinic3_sq_wqe_combo *wqe_combo)
 {
@@ -575,10 +632,9 @@ hinic3_tx_set_compact_task_offload(struct hinic3_wqe_info *wqe_info,
 }
 
 static int
-hinic3_set_tx_offload(struct hinic3_nic_dev *nic_dev,
-		      struct rte_mbuf *mbuf,
-		      struct hinic3_sq_wqe_combo *wqe_combo,
-		      struct hinic3_wqe_info *wqe_info)
+hinic3_set_tx_offload_compact_cqe(struct rte_mbuf *mbuf,
+				  struct hinic3_sq_wqe_combo *wqe_combo,
+				  struct hinic3_wqe_info *wqe_info)
 {
 	uint64_t ol_flags = mbuf->ol_flags;
 	struct hinic3_offload_info *offload_info = &wqe_info->offload_info;
@@ -615,7 +671,7 @@ hinic3_set_tx_offload(struct hinic3_nic_dev *nic_dev,
 		case HINIC3_PKT_TX_L4_NO_CKSUM:
 			break;
 		default:
-			PMD_DRV_LOG(INFO, "not support pkt type");
+			PMD_DRV_LOG(DEBUG, "not support pkt type");
 			return -EINVAL;
 		}
 	}
@@ -627,11 +683,14 @@ hinic3_set_tx_offload(struct hinic3_nic_dev *nic_dev,
 		offload_info->encapsulation = 1;
 		wqe_info->queue_info.udp_dp_en = 1;
 		break;
+	case HINIC3_PKT_TX_TUNNEL_IPIP:
+		offload_info->encapsulation = 1;
+		break;
 	case 0:
 		break;
 
 	default:
-		PMD_DRV_LOG(INFO, "not support tunnel pkt type");
+		PMD_DRV_LOG(DEBUG, "not support tunnel pkt type");
 		return -EINVAL;
 	}
 
@@ -642,8 +701,109 @@ hinic3_set_tx_offload(struct hinic3_nic_dev *nic_dev,
 		offload_info->out_l4_en = 1;
 
 set_tx_wqe_offload:
-	nic_dev->tx_ops->nic_tx_set_wqe_offload(wqe_info, wqe_combo);
+	hinic3_tx_set_compact_task_offload(wqe_info, wqe_combo);
+
+	return 0;
+}
+
+static int
+hinic3_set_tx_offload(struct rte_mbuf *mbuf,
+		      struct hinic3_sq_task *task,
+		      struct hinic3_wqe_info *wqe_info,
+		      enum nic_type nic_type)
+{
+	uint64_t ol_flags = mbuf->ol_flags;
+	uint16_t pld_offset = 0;
+	uint32_t queue_info = 0;
+	uint16_t vlan_tag;
+
+	task->pkt_info0 = 0;
+	task->ip_identify = 0;
+	task->pkt_info2 = 0;
+	task->vlan_offload = 0;
+
+	/* Vlan offload */
+	if (unlikely(ol_flags & HINIC3_PKT_TX_VLAN_PKT)) {
+		vlan_tag = mbuf->vlan_tci;
+		hinic3_set_vlan_tx_offload(task, vlan_tag, HINIC3_TX_TPID0);
+		task->vlan_offload = hinic3_hw_be32(task->vlan_offload);
+	}
 
+	if (!(ol_flags & HINIC3_TX_CKSUM_OFFLOAD_MASK))
+		return 0;
+
+	/* Tso offload */
+	if (ol_flags & HINIC3_PKT_TX_TCP_SEG) {
+		if ((ol_flags & HINIC3_PKT_TX_TUNNEL_MASK) ==
+		    HINIC3_PKT_TX_TUNNEL_VXLAN_GPE)
+			return -EINVAL;
+		if ((ol_flags & HINIC3_PKT_TX_TUNNEL_MASK) ==
+		    HINIC3_PKT_TX_TUNNEL_IPIP && nic_type == NIC_SP620) {
+			PMD_DRV_LOG(DEBUG, "IPinIP TSO is not supported on SP620");
+			return -EINVAL;
+		}
+		pld_offset = wqe_info->payload_offset;
+		if ((pld_offset >> 1) > MAX_PAYLOAD_OFFSET)
+			return -EINVAL;
+
+		task->pkt_info0 |= SQ_TASK_INFO0_SET(1U, INNER_L4_EN);
+		task->pkt_info0 |= SQ_TASK_INFO0_SET(1U, INNER_L3_EN);
+
+		queue_info |= SQ_CTRL_QUEUE_INFO_SET(1U, TSO);
+		queue_info |= SQ_CTRL_QUEUE_INFO_SET(pld_offset >> 1, PLDOFF);
+
+		/* Set MSS value */
+		queue_info = SQ_CTRL_QUEUE_INFO_CLEAR(queue_info, MSS);
+		queue_info |= SQ_CTRL_QUEUE_INFO_SET(mbuf->tso_segsz, MSS);
+	} else {
+		if (ol_flags & HINIC3_PKT_TX_IP_CKSUM)
+			task->pkt_info0 |= SQ_TASK_INFO0_SET(1U, INNER_L3_EN);
+
+		switch (ol_flags & HINIC3_PKT_TX_L4_MASK) {
+		case HINIC3_PKT_TX_TCP_CKSUM:
+		case HINIC3_PKT_TX_UDP_CKSUM:
+		case HINIC3_PKT_TX_SCTP_CKSUM:
+			task->pkt_info0 |= SQ_TASK_INFO0_SET(1U, INNER_L4_EN);
+			break;
+		case HINIC3_PKT_TX_L4_NO_CKSUM:
+			break;
+		default:
+			PMD_DRV_LOG(DEBUG, "not support pkt type");
+			return -EINVAL;
+		}
+	}
+
+	/* For vxlan, also can support PKT_TX_TUNNEL_GENEVE/GRE, etc */
+	switch (ol_flags & HINIC3_PKT_TX_TUNNEL_MASK) {
+	case HINIC3_PKT_TX_TUNNEL_VXLAN:
+		task->pkt_info0 |= SQ_TASK_INFO0_SET(1U, TUNNEL_FLAG);
+		break;
+	case HINIC3_PKT_TX_TUNNEL_VXLAN_GPE:
+		task->pkt_info0 |= SQ_TASK_INFO0_SET(1U, TUNNEL_FLAG);
+		break;
+	case HINIC3_PKT_TX_TUNNEL_GENEVE:
+		task->pkt_info0 |= SQ_TASK_INFO0_SET(1U, TUNNEL_FLAG);
+		break;
+	case HINIC3_PKT_TX_TUNNEL_IPIP:
+		task->pkt_info0 |= SQ_TASK_INFO0_SET(1U, TUNNEL_FLAG);
+		break;
+	case 0:
+		break;
+	default:
+		/* For non UDP/GRE tunneling, drop the tunnel packet */
+		PMD_DRV_LOG(DEBUG, "not support tunnel pkt type");
+		return -EINVAL;
+	}
+
+	if (ol_flags & HINIC3_PKT_TX_OUTER_IP_CKSUM)
+		task->pkt_info0 |= SQ_TASK_INFO0_SET(1U, OUT_L3_EN);
+
+	if (ol_flags & HINIC3_PKT_TX_OUTER_UDP_CKSUM)
+		task->pkt_info0 |= SQ_TASK_INFO0_SET(1U, OUT_L4_EN);
+
+	task->pkt_info0 = hinic3_hw_be32(task->pkt_info0);
+	task->pkt_info2 = hinic3_hw_be32(task->pkt_info2);
+	wqe_info->queue_info_sp600 = queue_info;
 	return 0;
 }
 
@@ -776,15 +936,16 @@ hinic3_non_tso_pkt_pre_process(struct rte_mbuf *mbuf, struct hinic3_wqe_info *wq
  * Point to the mbuf to send.
  * @param[in] wqe_info
  * Point to wqe_info of send queue(SQ).
+ * @param[in] non_tso_max_pkt_len
+ *  Number of non_tso_max_pkt_len(SP230 is 9600, SP620/SP560 is 64K)
  * @param[in] q_depth
  *  Depth of the send queue, used to reject a WQE that can never fit.
  * @return
  * 0 as success, -EINVAL as failure.
  */
 static int
-hinic3_get_tx_offload(struct hinic3_nic_dev *nic_dev, struct rte_mbuf *mbuf,
-		      struct hinic3_wqe_info *wqe_info, uint32_t non_tso_max_pkt_len,
-		      uint16_t q_depth)
+hinic3_get_tx_offload(struct rte_mbuf *mbuf, struct hinic3_wqe_info *wqe_info,
+		      uint32_t non_tso_max_pkt_len, uint16_t q_depth)
 {
 	uint64_t ol_flags = mbuf->ol_flags;
 	uint16_t inner_l3_offset = 0;
@@ -792,6 +953,13 @@ hinic3_get_tx_offload(struct hinic3_nic_dev *nic_dev, struct rte_mbuf *mbuf,
 
 	wqe_info->sge_cnt = mbuf->nb_segs;
 	wqe_info->cpy_mbuf_cnt = 0;
+	/*
+	 * These are filled in only for the offloads the packet carries.
+	 * Clear them so a previous packet's VLAN/TSO state cannot leak
+	 * into this one.
+	 */
+	wqe_info->queue_info = (struct hinic3_queue_info){ 0 };
+	wqe_info->offload_info = (struct hinic3_offload_info){ 0 };
 	/* Check if the packet set available offload flags. */
 	if (!(ol_flags & HINIC3_TX_OFFLOAD_MASK)) {
 		wqe_info->offload = 0;
@@ -801,7 +969,7 @@ hinic3_get_tx_offload(struct hinic3_nic_dev *nic_dev, struct rte_mbuf *mbuf,
 			return err;
 	} else {
 		wqe_info->offload = 1;
-		err = hinic3_get_inner_l3_offset(nic_dev, mbuf, &inner_l3_offset);
+		err = hinic3_get_inner_l3_offset(mbuf, &inner_l3_offset);
 		if (err)
 			return err;
 
@@ -992,6 +1160,7 @@ hinic3_mbuf_dma_map_sge(struct hinic3_txq *txq, struct rte_mbuf *mbuf,
 			hinic3_set_buf_desc(buf_desc, dma_addr, mbuf->data_len);
 			buf_desc++;
 		}
+
 		mbuf = mbuf->next;
 	}
 
@@ -1039,8 +1208,8 @@ hinic3_mbuf_dma_map_sge(struct hinic3_txq *txq, struct rte_mbuf *mbuf,
  * Point to wqe_info of send queue.
  */
 static void
-hinic3_prepare_sq_ctrl(struct hinic3_sq_wqe_combo *wqe_combo,
-		       struct hinic3_wqe_info *wqe_info)
+hinic3_prepare_sq_ctrl_compact_cqe(struct hinic3_sq_wqe_combo *wqe_combo,
+				   struct hinic3_wqe_info *wqe_info)
 {
 	struct hinic3_queue_info *queue_info = &wqe_info->queue_info;
 	struct hinic3_sq_wqe_desc *wqe_desc = wqe_combo->hdr;
@@ -1053,7 +1222,7 @@ hinic3_prepare_sq_ctrl(struct hinic3_sq_wqe_combo *wqe_combo,
 	if (wqe_combo->wqe_type == SQ_WQE_EXTENDED_TYPE) {
 		wqe_desc->ctrl_len |= SQ_CTRL_SET(wqe_info->sge_cnt, BUFDESC_NUM) |
 				      SQ_CTRL_SET(wqe_combo->task_type, TASKSECT_LEN) |
-				      SQ_CTRL_SET(SQ_NORMAL_WQE, DATA_FORMAT);
+				      SQ_CTRL_SET(SQ_WQE_SGL, DATA_FORMAT);
 
 		*qsf = SQ_CTRL_QUEUE_INFO_SET(1, UC) |
 		       SQ_CTRL_QUEUE_INFO_SET(queue_info->sctp, SCTP) |
@@ -1074,14 +1243,56 @@ hinic3_prepare_sq_ctrl(struct hinic3_sq_wqe_combo *wqe_combo,
 		*qsf = hinic3_hw_be32(*qsf);
 	} else {
 		wqe_desc->ctrl_len |= SQ_CTRL_COMPACT_QUEUE_INFO_SET(queue_info->sctp, SCTP) |
-				SQ_CTRL_COMPACT_QUEUE_INFO_SET(queue_info->udp_dp_en, UDP_DP_EN) |
-				SQ_CTRL_COMPACT_QUEUE_INFO_SET(queue_info->ufo, UFO) |
-				SQ_CTRL_COMPACT_QUEUE_INFO_SET(queue_info->pkt_type, PKT_TYPE);
+				      SQ_CTRL_COMPACT_QUEUE_INFO_SET(queue_info->udp_dp_en,
+								     UDP_DP_EN) |
+				      SQ_CTRL_COMPACT_QUEUE_INFO_SET(queue_info->ufo, UFO) |
+				      SQ_CTRL_COMPACT_QUEUE_INFO_SET(queue_info->pkt_type,
+								     PKT_TYPE);
 	}
 
 	wqe_desc->ctrl_len = hinic3_hw_be32(wqe_desc->ctrl_len);
 }
 
+/**
+ * Sets and configures fields in the transmit queue control descriptor based on
+ * the WQE type.
+ *
+ * @param[out] wqe_combo
+ * Point to wqe_combo of send queue.
+ * @param[in] wqe_info
+ * Point to wqe_info of send queue.
+ */
+static void
+hinic3_prepare_sq_ctrl(struct hinic3_sq_wqe_combo *wqe_combo,
+		       struct hinic3_wqe_info *wqe_info)
+{
+	struct hinic3_sq_wqe_desc *wqe_desc = wqe_combo->hdr;
+
+	wqe_desc->ctrl_len |= SQ_CTRL_SET(wqe_info->sge_cnt, BUFDESC_NUM) |
+			      SQ_CTRL_SET(wqe_combo->task_type, TASKSECT_LEN) |
+			      SQ_CTRL_SET(SQ_NORMAL_WQE, DATA_FORMAT) |
+			      SQ_CTRL_SET(wqe_combo->wqe_type, EXTENDED) |
+			      SQ_CTRL_SET(wqe_info->owner, OWNER);
+
+	wqe_desc->ctrl_len = hinic3_hw_be32(wqe_desc->ctrl_len);
+
+	wqe_desc->queue_info = wqe_info->queue_info_sp600;
+	wqe_desc->queue_info |= SQ_CTRL_QUEUE_INFO_SET(1U, UC);
+
+	if (!SQ_CTRL_QUEUE_INFO_GET(wqe_desc->queue_info, MSS)) {
+		wqe_desc->queue_info |=
+			SQ_CTRL_QUEUE_INFO_SET(TX_MSS_DEFAULT, MSS);
+	} else if (SQ_CTRL_QUEUE_INFO_GET(wqe_desc->queue_info, MSS) <
+		   TX_MSS_MIN) {
+		/* Mss should not less than 80 */
+		wqe_desc->queue_info =
+			SQ_CTRL_QUEUE_INFO_CLEAR(wqe_desc->queue_info, MSS);
+		wqe_desc->queue_info |= SQ_CTRL_QUEUE_INFO_SET(TX_MSS_MIN, MSS);
+	}
+
+	wqe_desc->queue_info = hinic3_hw_be32(wqe_desc->queue_info);
+}
+
 /**
  * It is responsible for sending data packets.
  *
@@ -1101,10 +1312,11 @@ hinic3_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	struct hinic3_tx_info *tx_info = NULL;
 	struct rte_mbuf *mbuf_pkt = NULL;
 	struct hinic3_sq_wqe_combo wqe_combo = {0};
+	struct hinic3_sq_wqe *sq_wqe = NULL;
 	struct hinic3_wqe_info wqe_info = {0};
 	uint32_t offload_err, free_cnt;
 	uint64_t tx_bytes = 0;
-	uint16_t free_wqebb_cnt, nb_tx;
+	uint16_t free_wqebb_cnt, nb_tx, nb_pkt = 0;
 	int err;
 
 #ifdef HINIC3_XSTAT_PROF_TX
@@ -1115,6 +1327,8 @@ hinic3_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	if (unlikely(!HINIC3_TXQ_IS_STARTED(txq)))
 		return 0;
 
+	if (nb_pkts)
+		rte_prefetch0(tx_pkts[0]);
 	free_cnt = txq->tx_free_thresh;
 	/* Reclaim tx mbuf before xmit new packets. */
 	if (hinic3_get_sq_free_wqebbs(txq) < txq->tx_free_thresh)
@@ -1122,61 +1336,84 @@ hinic3_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
 	/* Tx loop routine. */
 	for (nb_tx = 0; nb_tx < nb_pkts; nb_tx++) {
-		mbuf_pkt = *tx_pkts++;
-		if (unlikely(hinic3_get_tx_offload(txq->nic_dev, mbuf_pkt, &wqe_info,
+		mbuf_pkt = tx_pkts[nb_tx];
+		if (nb_tx + 1 < nb_pkts)
+			rte_prefetch0(tx_pkts[nb_tx + 1]);
+		if (unlikely(hinic3_get_tx_offload(mbuf_pkt, &wqe_info,
 						   txq->non_tso_max_pkt_len,
 						   txq->q_depth))) {
+			rte_pktmbuf_free(mbuf_pkt);
 			txq->txq_stats.offload_errors++;
-			break;
+			continue;
 		}
 
-		wqe_info.wqebb_cnt = wqe_info.sge_cnt;
-		if (likely(wqe_info.offload || wqe_info.wqebb_cnt > 1)) {
-			if (txq->tx_wqe_compact_task) {
-				/**
-				 * One more wqebb is needed for compact task under two situations:
-				 * 1. TSO: MSS field is needed, no available space for
-				 *    compact task in compact wqe.
-				 * 2. SGE number > 1: wqe is handlerd as extended wqe by nic.
-				 */
-				if (mbuf_pkt->ol_flags & HINIC3_PKT_TX_TCP_SEG ||
-				    wqe_info.wqebb_cnt > 1)
-					wqe_info.wqebb_cnt++;
-			} else {
-				/* Use extended sq wqe with normal TS */
-				wqe_info.wqebb_cnt++;
-			}
-		}
+		if (!wqe_info.offload)
+			/*
+			 * Use extended sq wqe with small TS, which can include
+			 * multi sges, or compact sq normal wqe, which just
+			 * supports one sge
+			 */
+			wqe_info.wqebb_cnt = wqe_info.sge_cnt;
+		else
+			/* Use extended sq wqe with normal TS */
+			wqe_info.wqebb_cnt = wqe_info.sge_cnt + 1;
 
 		free_wqebb_cnt = hinic3_get_sq_free_wqebbs(txq);
-		if (unlikely(wqe_info.wqebb_cnt > free_wqebb_cnt)) {
-			/* Reclaim again. */
+		if (wqe_info.wqebb_cnt > free_wqebb_cnt) {
+			/*
+			 * Try to reclaim completed Tx WQEs when SQ space is
+			 * insufficient. This gives hardware a chance to free
+			 * descriptors and helps prevent packet drops caused
+			 * by transient SQ congestion.
+			 */
 			hinic3_xmit_mbuf_cleanup(txq, free_cnt);
 			free_wqebb_cnt = hinic3_get_sq_free_wqebbs(txq);
-			if (unlikely(wqe_info.wqebb_cnt > free_wqebb_cnt)) {
+			if (wqe_info.wqebb_cnt > free_wqebb_cnt) {
 				txq->txq_stats.tx_busy += (nb_pkts - nb_tx);
-				break;
+				goto end;
 			}
 		}
 
-		/* Task or bd section maybe wrapped for one wqe. */
-		hinic3_set_wqe_combo(txq, &wqe_combo, &wqe_info);
+		/* Get sq wqe address from wqe_page */
+		sq_wqe = hinic3_get_sq_wqe(txq, &wqe_info);
+		if (unlikely(!sq_wqe)) {
+			txq->txq_stats.tx_busy++;
+			break;
+		}
 
-		/* Fill tx packet offload into qsf and task field. */
-		offload_err = hinic3_set_tx_offload(txq->nic_dev, mbuf_pkt, &wqe_combo, &wqe_info);
+		/* Task or bd section maybe wrapped for one wqe */
+		hinic3_set_wqe_combo(txq, &wqe_combo, sq_wqe, &wqe_info);
+
+		/*
+		 * A compact WQE has no SQ control section and the scalar
+		 * burst does not fill its 4-byte task, so clear queue_info
+		 * once per packet.
+		 */
+		if (wqe_combo.wqe_type == SQ_WQE_COMPACT_TYPE)
+			wqe_combo.hdr->queue_info = 0;
+
+		wqe_info.queue_info_sp600 = 0;
+		/* Fill tx packet offload into qsf and task field */
+		if (wqe_info.offload) {
+			offload_err = hinic3_set_tx_offload(mbuf_pkt,
+							    wqe_combo.task,
+							    &wqe_info,
+							    txq->nic_dev->nic_type);
 			if (unlikely(offload_err)) {
 				hinic3_put_sq_wqe(txq, &wqe_info);
+				rte_pktmbuf_free(mbuf_pkt);
 				txq->txq_stats.offload_errors++;
-				break;
+				continue;
 			}
-
+		}
 		/* Fill sq_wqe buf_desc and bd_desc. */
 		err = hinic3_mbuf_dma_map_sge(txq, mbuf_pkt, &wqe_combo,
 					      &wqe_info);
 		if (err) {
 			hinic3_put_sq_wqe(txq, &wqe_info);
+			rte_pktmbuf_free(mbuf_pkt);
 			txq->txq_stats.offload_errors++;
-			break;
+			continue;
 		}
 
 		/* Record tx info. */
@@ -1192,24 +1429,25 @@ hinic3_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 			hinic3_prepare_sq_ctrl(&wqe_combo, &wqe_info);
 
 		tx_bytes += mbuf_pkt->pkt_len;
+		nb_pkt++;
 	}
-
+end:
 	/* Update txq stats. */
-	if (nb_tx) {
+	if (nb_pkt) {
 		hinic3_write_db(txq->db_addr, txq->q_id, (int)(txq->cos),
 				SQ_CFLAG_DP,
 				MASKED_QUEUE_IDX(txq, txq->prod_idx));
-		txq->txq_stats.packets += nb_tx;
+		txq->txq_stats.packets += nb_pkt;
 		txq->txq_stats.bytes += tx_bytes;
 	}
-	txq->txq_stats.burst_pkts = nb_tx;
+	txq->txq_stats.burst_pkts = nb_pkt;
 
 #ifdef HINIC3_XSTAT_PROF_TX
 	t2 = rte_get_tsc_cycles();
 	txq->txq_stats.app_tsc = t1 - txq->prof_tx_end_tsc;
 	txq->prof_tx_end_tsc = t2;
 	txq->txq_stats.pmd_tsc = t2 - t1;
-	txq->txq_stats.burst_pkts = nb_tx;
+	txq->txq_stats.burst_pkts = nb_pkt;
 #endif
 
 	return nb_tx;
@@ -1268,3 +1506,139 @@ hinic3_flush_txqs(struct hinic3_nic_dev *nic_dev)
 			PMD_DRV_LOG(ERR, "Stop sq%d failed", qid);
 	}
 }
+
+/**
+ * It is responsible for sending data packets.
+ *
+ * @param[in] tx_queue
+ * Point to send queue.
+ * @param[in] tx_pkts
+ * Pointer to the array of data packets to be sent.
+ * @param[in] nb_pkts
+ * Number of sent packets.
+ * @return
+ * Number of actually sent packets.
+ */
+uint16_t
+hinic3_xmit_pkts_compact_cqe(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
+{
+	struct hinic3_txq *txq = tx_queue;
+	struct hinic3_tx_info *tx_info = NULL;
+	struct rte_mbuf *mbuf_pkt = NULL;
+	struct hinic3_sq_wqe_combo wqe_combo = { 0 };
+	struct hinic3_wqe_info wqe_info = { 0 };
+	uint32_t offload_err, free_cnt;
+	uint64_t tx_bytes = 0;
+	uint16_t free_wqebb_cnt, nb_tx, nb_pkt = 0;
+	int err;
+
+#ifdef HINIC3_XSTAT_PROF_TX
+	uint64_t t1, t2;
+	t1 = rte_get_tsc_cycles();
+#endif
+
+	if (unlikely(!HINIC3_TXQ_IS_STARTED(txq)))
+		return 0;
+
+	free_cnt = txq->tx_free_thresh;
+	/* Reclaim tx mbuf before xmit new packets. */
+	if (hinic3_get_sq_free_wqebbs(txq) < txq->tx_free_thresh)
+		hinic3_xmit_mbuf_cleanup(txq, free_cnt);
+
+	/* Tx loop routine. */
+	for (nb_tx = 0; nb_tx < nb_pkts; nb_tx++) {
+		mbuf_pkt = *tx_pkts++;
+		if (unlikely(hinic3_get_tx_offload(mbuf_pkt, &wqe_info,
+						   txq->non_tso_max_pkt_len,
+						   txq->q_depth))) {
+			rte_pktmbuf_free(mbuf_pkt);
+			txq->txq_stats.offload_errors++;
+			continue;
+		}
+
+		wqe_info.wqebb_cnt = wqe_info.sge_cnt;
+		if (likely(wqe_info.offload || wqe_info.wqebb_cnt > 1)) {
+			if (txq->tx_wqe_compact_task) {
+				/**
+				 * One more wqebb is needed for compact task under two situations:
+				 * 1. TSO: MSS field is needed, no available space for
+				 *    compact task in compact wqe.
+				 * 2. SGE number > 1: wqe is handlerd as extended wqe by nic.
+				 */
+				if (mbuf_pkt->ol_flags & HINIC3_PKT_TX_TCP_SEG ||
+				    wqe_info.wqebb_cnt > 1)
+					wqe_info.wqebb_cnt++;
+			} else {
+				/* Use extended sq wqe with normal TS */
+				wqe_info.wqebb_cnt++;
+			}
+		}
+
+		free_wqebb_cnt = hinic3_get_sq_free_wqebbs(txq);
+		if (wqe_info.wqebb_cnt > free_wqebb_cnt) {
+			/* Reclaim again */
+			hinic3_xmit_mbuf_cleanup(txq, free_cnt);
+			free_wqebb_cnt = hinic3_get_sq_free_wqebbs(txq);
+			if (wqe_info.wqebb_cnt > free_wqebb_cnt) {
+				txq->txq_stats.tx_busy += (nb_pkts - nb_tx);
+				goto end;
+			}
+		}
+
+		/* Task or bd section maybe wrapped for one wqe. */
+		hinic3_set_wqe_combo_compact_cqe(txq, &wqe_combo, &wqe_info);
+
+		/* Fill tx packet offload into qsf and task field. */
+		offload_err = hinic3_set_tx_offload_compact_cqe(mbuf_pkt, &wqe_combo, &wqe_info);
+		if (unlikely(offload_err)) {
+			hinic3_put_sq_wqe(txq, &wqe_info);
+			rte_pktmbuf_free(mbuf_pkt);
+			txq->txq_stats.offload_errors++;
+			continue;
+		}
+
+		/* Fill sq_wqe buf_desc and bd_desc. */
+		err = hinic3_mbuf_dma_map_sge(txq, mbuf_pkt, &wqe_combo, &wqe_info);
+
+		if (err) {
+			hinic3_put_sq_wqe(txq, &wqe_info);
+			rte_pktmbuf_free(mbuf_pkt);
+			txq->txq_stats.offload_errors++;
+			continue;
+		}
+
+		/* Record tx info. */
+		tx_info = &txq->tx_info[wqe_info.pi];
+		tx_info->mbuf = mbuf_pkt;
+		tx_info->wqebb_cnt = wqe_info.wqebb_cnt;
+
+		/*
+		 * For wqe compact type, no need to prepare
+		 * sq ctrl info.
+		 */
+		hinic3_prepare_sq_ctrl_compact_cqe(&wqe_combo, &wqe_info);
+
+		tx_bytes += mbuf_pkt->pkt_len;
+		nb_pkt++;
+	}
+end:
+	/* Update txq stats. */
+	if (nb_pkt) {
+		hinic3_write_db(txq->db_addr, txq->q_id, (int)(txq->cos),
+				SQ_CFLAG_DP,
+				MASKED_QUEUE_IDX(txq, txq->prod_idx));
+		txq->txq_stats.packets += nb_pkt;
+		txq->txq_stats.bytes += tx_bytes;
+	}
+	txq->txq_stats.burst_pkts = nb_pkt;
+
+#ifdef HINIC3_XSTAT_PROF_TX
+	t2 = rte_get_tsc_cycles();
+	txq->txq_stats.app_tsc = t1 - txq->prof_tx_end_tsc;
+	txq->prof_tx_end_tsc = t2;
+	txq->txq_stats.pmd_tsc = t2 - t1;
+	txq->txq_stats.burst_pkts = nb_pkt;
+#endif
+
+	return nb_tx;
+}
diff --git a/drivers/net/hinic3/hinic3_tx.h b/drivers/net/hinic3/hinic3_tx.h
index e5aa0a6f8e..e0a2606428 100644
--- a/drivers/net/hinic3/hinic3_tx.h
+++ b/drivers/net/hinic3/hinic3_tx.h
@@ -55,10 +55,10 @@ struct hinic3_wqe_info {
 	uint16_t sge_cnt;
 
 	uint8_t offload;
-	uint8_t rsvd0; /**< Reserved field 0. */
+	uint8_t wrapped;
 	uint16_t payload_offset;
 
-	uint8_t rsvd1; /**< Reserved field 1. */
+	uint32_t queue_info_sp600;
 	uint8_t owner;
 	uint16_t pi;
 
@@ -387,42 +387,13 @@ struct __rte_cache_aligned hinic3_txq {
 #endif
 };
 
-/* Tx WQE offload set callback function */
-typedef void  (*nic_tx_set_wqe_offload_t)(struct hinic3_wqe_info *wqe_info,
-					  struct hinic3_sq_wqe_combo *wqe_combo);
-
-struct hinic3_nic_tx_ops {
-	nic_tx_set_wqe_offload_t	nic_tx_set_wqe_offload;
-};
-
 void hinic3_flush_txqs(struct hinic3_nic_dev *nic_dev);
 void hinic3_free_txq_mbufs(struct hinic3_txq *txq);
 void hinic3_free_all_txq_mbufs(struct hinic3_nic_dev *nic_dev);
+uint16_t hinic3_xmit_pkts_compact_cqe(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts);
 uint16_t hinic3_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts);
 uint16_t hinic3_prep_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts);
 int hinic3_stop_sq(struct hinic3_txq *txq);
 int hinic3_start_all_sqs(struct rte_eth_dev *eth_dev);
 int hinic3_tx_done_cleanup(void *txq, uint32_t free_cnt);
-
-/**
- * Set wqe task section
- *
- * @param[in] wqe_info
- * Packet info parsed according to mbuf
- * @param[in] wqe_combo
- * Wqe need to format
- */
-void hinic3_tx_set_normal_task_offload(struct hinic3_wqe_info *wqe_info,
-				       struct hinic3_sq_wqe_combo *wqe_combo);
-
-/**
- * Set compact wqe task section
- *
- * @param[in] wqe_info
- * Packet info parsed according to mbuf
- * @param[in] wqe_combo
- * Wqe need to format
- */
-void hinic3_tx_set_compact_task_offload(struct hinic3_wqe_info *wqe_info,
-					struct hinic3_sq_wqe_combo *wqe_combo);
 #endif /**< _HINIC3_TX_H_ */
-- 
2.33.0

