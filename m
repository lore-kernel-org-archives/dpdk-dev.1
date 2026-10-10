Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FC5CA9EC1
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 14:46:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFC5240A70;
	Sat, 10 Oct 2026 16:45:29 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.223])
 by mails.dpdk.org (Postfix) with ESMTP id 0AEB340663
 for <dev@dpdk.org>; Sat, 10 Oct 2026 16:45:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=BEeyfYqq+h8I2MlWhhnt6P6oNUVYwOmqMOQlxWD5J2o=;
 b=aZFDCFJWdH8PEMaLHYysU52b0lVbP+sxWWST16HLRGZ3KTA5d0W5SXsprGN0dv
 GYKtA9Bqt6/IpJGaawOY7LnyXQvMLQGkCjllWdgAXS7j1c333ZHgVLNJU36dS00+
 4WfiMjvNTbk8c21SPcz9ROsHUwcixFiRf1O7335hVAaMY=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v1 14/17] net/hinic3: split Tx burst function for compact CQE
 support
Date: Sat, 10 Oct 2026 22:45:05 +0800
Message-ID: <20261010144509.2731-15-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261010144509.2731-1-yejiacheng4@h-partners.com>
References: <20261010144509.2731-1-yejiacheng4@h-partners.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: As8vCgDX70B4T8pqMdk9Aw--.440S16
X-Coremail-Antispam: 1Uf129KBjvAXoWfXw1kXF4kZF45GF4rGrW3ZFb_yoWrJr1xKo
 WSqrsxtrnayryxCrWj9w4kuFyqqrWvqa98Jws0krs7Xa17ZryUtayayw1Fy3W0qrZ5u3W7
 A3WrGwnFywsxJ3y5n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU2SdgDUUUU
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNB9ASmrKT38stwAA3q
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

The combined Tx burst path suffers from severe cache misses because the=0D
compact CQE and normal paths are interleaved. Split out a dedicated compact=
=0D
CQE entry point and select it directly from the runtime flag instead of the=
=0D
dynamic tx_ops indirection.=0D
=0D
Add a tx_burst_mode_get callback so applications can query the active Tx=0D
burst mode and its offloads for each queue.=0D
=0D
Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>=0D
---=0D
 doc/guides/rel_notes/release_26_11.rst |   1 +=0D
 drivers/net/hinic3/hinic3_ethdev.c     | 109 +++--=0D
 drivers/net/hinic3/hinic3_ethdev.h     |  10 +-=0D
 drivers/net/hinic3/hinic3_tx.c         | 528 +++++++++++++++++++++----=0D
 drivers/net/hinic3/hinic3_tx.h         |  58 ++-=0D
 5 files changed, 574 insertions(+), 132 deletions(-)=0D
=0D
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/=
release_26_11.rst=0D
index 19ecce010f..216f2b297e 100644=0D
--- a/doc/guides/rel_notes/release_26_11.rst=0D
+++ b/doc/guides/rel_notes/release_26_11.rst=0D
@@ -102,6 +102,7 @@ New Features=0D
   * Added device parameters for runtime configuration.=0D
   * Added a compact CQE receive data path.=0D
   * Extended TCP segmentation offload (TSO) to 255 segments.=0D
+  * Added a compact CQE transmit data path.=0D
 =0D
 * **Updated Intel iavf driver.**=0D
 =0D
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3=
_ethdev.c=0D
index c472b8fae1..ffbd080ede 100644=0D
--- a/drivers/net/hinic3/hinic3_ethdev.c=0D
+++ b/drivers/net/hinic3/hinic3_ethdev.c=0D
@@ -288,6 +288,8 @@ static const struct hinic3_xstats_name_off hinic3_txq_s=
tats_strings[] =3D {=0D
 	HINIC3_TXQ_STAT(burst_pkts),=0D
 	HINIC3_TXQ_STAT(sge_len0),=0D
 	HINIC3_TXQ_STAT(mbuf_null),=0D
+	HINIC3_TXQ_STAT(cpy_pkts),=0D
+	HINIC3_TXQ_STAT(sge_len_too_large),=0D
 =0D
 #ifdef HINIC3_XSTAT_PROF_TX=0D
 	HINIC3_TXQ_STAT(app_tsc),=0D
@@ -1399,6 +1401,14 @@ hinic3_tx_queue_setup(struct rte_eth_dev *dev, uint1=
6_t qid, uint16_t nb_desc,=0D
 =0D
 	nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);=0D
 	hwdev =3D nic_dev->hwdev;=0D
+	/* Queue depth must be equal to first queue */=0D
+	if (nic_dev->txq_depth =3D=3D 0) {=0D
+		nic_dev->txq_depth =3D nb_desc;=0D
+	} else if (nb_desc !=3D nic_dev->txq_depth) {=0D
+		PMD_DRV_LOG(WARNING, "txq%u depth:%u is not equal to first queue depth:%=
u.",=0D
+			qid, nb_desc, nic_dev->txq_depth);=0D
+		nb_desc =3D nic_dev->txq_depth;=0D
+	}=0D
 =0D
 	/* Queue depth must be power of 2, otherwise will be aligned up. */=0D
 	sq_depth =3D (nb_desc & (nb_desc - 1))=0D
@@ -1456,6 +1466,7 @@ hinic3_tx_queue_setup(struct rte_eth_dev *dev, uint16=
_t qid, uint16_t nb_desc,=0D
 	txq->owner =3D 1;=0D
 	txq->non_tso_max_pkt_len =3D=0D
 		HINIC3_IS_SP230_NIC(nic_dev) ? MAX_SINGLE_SGE_SIZE : HINIC3_MAX_JUMBO_FR=
AME_SIZE;=0D
+	txq->tx_free_loop =3D nic_dev->config.tx_free_loop;=0D
 =0D
 	if (!ODD_NUMBER_QUEUE_ID(qid) &&=0D
 		hinic3_cmd_vf_lag(nic_dev->hwdev, hinic3_global_func_id(nic_dev->hwdev),=
=0D
@@ -1464,9 +1475,11 @@ hinic3_tx_queue_setup(struct rte_eth_dev *dev, uint1=
6_t qid, uint16_t nb_desc,=0D
 	else=0D
 		txq->cos =3D nic_dev->default_cos;=0D
 =0D
-	txq->cos =3D nic_dev->cos_map[(int)(txq->cos) & nic_dev->cos_mask];=0D
+	if (HINIC3_IS_SP230_NIC(nic_dev))=0D
+		txq->cos =3D nic_dev->cos_map[(int)(txq->cos) & nic_dev->cos_mask];=0D
 =0D
 	txq->tx_deferred_start =3D tx_conf->tx_deferred_start;=0D
+=0D
 	txq->tx_wqe_compact_task =3D HINIC3_SUPPORT_TX_WQE_COMPACT_TASK(nic_dev);=
=0D
 =0D
 	ci_mz =3D hinic3_dma_zone_reserve(dev, "hinic3_sq_ci", qid,=0D
@@ -2300,7 +2313,13 @@ hinic3_dev_stop(struct rte_eth_dev *dev)=0D
 	/* Free mempool. */=0D
 	hinic3_copy_mempool_uninit(nic_dev);=0D
 =0D
+	for (uint16_t i =3D 0; i < dev->data->nb_rx_queues; i++)=0D
+		dev->data->rx_queue_state[i] =3D RTE_ETH_QUEUE_STATE_STOPPED;=0D
+	for (uint16_t i =3D 0; i < dev->data->nb_tx_queues; i++)=0D
+		dev->data->tx_queue_state[i] =3D RTE_ETH_QUEUE_STATE_STOPPED;=0D
+=0D
 	nic_dev->rxq_depth =3D 0;=0D
+	nic_dev->txq_depth =3D 0;=0D
 	return 0;=0D
 }=0D
 =0D
@@ -2356,6 +2375,9 @@ hinic3_dev_close(struct rte_eth_dev *eth_dev)=0D
 {=0D
 	struct hinic3_nic_dev *nic_dev =3D=0D
 		HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(eth_dev);=0D
+=0D
+	if (rte_eal_process_type() !=3D RTE_PROC_PRIMARY)=0D
+		return 0;=0D
 	int ret;=0D
 =0D
 	if (hinic3_test_and_set_bit(HINIC3_DEV_CLOSE, &nic_dev->dev_status)) {=0D
@@ -3012,6 +3034,26 @@ hinic3_dev_stats_get(struct rte_eth_dev *dev, struct=
 rte_eth_stats *stats,=0D
 		}=0D
 	}=0D
 =0D
+	if (HINIC3_IS_VF(nic_dev->hwdev) && HINIC3_IS_SP230_NIC(nic_dev)) {=0D
+		for (uint32_t i =3D 0; i < nic_dev->num_rqs; i++) {=0D
+			struct hinic3_rxq *rxq =3D nic_dev->rxqs[i];=0D
+			if (rxq =3D=3D NULL)=0D
+				continue;=0D
+			stats->ipackets +=3D rxq->rxq_stats.packets;=0D
+			stats->ibytes +=3D rxq->rxq_stats.bytes;=0D
+			stats->imissed +=3D rxq->rxq_stats.dropped;=0D
+		}=0D
+=0D
+		for (uint32_t i =3D 0; i < nic_dev->num_sqs; i++) {=0D
+			struct hinic3_txq *txq =3D nic_dev->txqs[i];=0D
+			if (txq =3D=3D NULL)=0D
+				continue;=0D
+			stats->opackets +=3D txq->txq_stats.packets;=0D
+			stats->obytes +=3D txq->txq_stats.bytes;=0D
+		}=0D
+		return 0;=0D
+	}=0D
+=0D
 	/* Vport stats. */=0D
 	stats->oerrors +=3D vport_stats.tx_discard_vport;=0D
 =0D
@@ -3082,14 +3124,16 @@ get_port_cir_drop(struct hinic3_nic_dev *nic_dev,=0D
 =0D
 	memset(&port_stats, 0, sizeof(port_stats));=0D
 =0D
-	err =3D hinic3_get_cir_drop(nic_dev->hwdev, &port_stats);=0D
-	if (err) {=0D
-		PMD_DRV_LOG(ERR, "Failed to get CPB cir drops from fw.");=0D
+	if (HINIC3_IS_SP620_NIC(nic_dev)) {=0D
+		err =3D hinic3_get_cir_drop(nic_dev->hwdev, &port_stats);=0D
+		if (err) {=0D
+			PMD_DRV_LOG(ERR, "Failed to get CPB cir drops from fw.");=0D
 =0D
-		for (i =3D 0; i < RTE_DIM(hinic3_cir_drop_stats_strings); i++)=0D
-			xstats[i].value =3D 0;=0D
+			for (i =3D 0; i < RTE_DIM(hinic3_cir_drop_stats_strings); i++)=0D
+				xstats[i].value =3D 0;=0D
 =0D
-		return RTE_DIM(hinic3_cir_drop_stats_strings);=0D
+			return RTE_DIM(hinic3_cir_drop_stats_strings);=0D
+		}=0D
 	}=0D
 =0D
 	for (i =3D 0; i < RTE_DIM(hinic3_cir_drop_stats_strings); i++) {=0D
@@ -3695,6 +3739,7 @@ static const struct eth_dev_ops hinic3_pmd_ops =3D {=
=0D
 	.mac_addr_add                  =3D hinic3_mac_addr_add,=0D
 	.set_mc_addr_list              =3D hinic3_set_mc_addr_list,=0D
 	.flow_ops_get                  =3D hinic3_dev_filter_ctrl,=0D
+	.tx_burst_mode_get             =3D hinic3_tx_burst_mode_get,=0D
 	.fec_get_capability            =3D hinic3_fec_capability_get,=0D
 	.fec_get                       =3D hinic3_fec_get,=0D
 	.fec_set                       =3D hinic3_fec_set,=0D
@@ -3747,16 +3792,9 @@ static const struct eth_dev_ops hinic3_pmd_vf_ops =
=3D {=0D
 	.mac_addr_add                  =3D hinic3_mac_addr_add,=0D
 	.set_mc_addr_list              =3D hinic3_set_mc_addr_list,=0D
 	.flow_ops_get                  =3D hinic3_dev_filter_ctrl,=0D
+	.tx_burst_mode_get             =3D hinic3_tx_burst_mode_get,=0D
 };=0D
 =0D
-static void hinic3_nic_tx_rx_ops_init(struct hinic3_nic_dev *nic_dev)=0D
-{=0D
-	if (HINIC3_SUPPORT_TX_WQE_COMPACT_TASK(nic_dev))=0D
-		nic_dev->tx_ops->nic_tx_set_wqe_offload =3D hinic3_tx_set_compact_task_o=
ffload;=0D
-	else=0D
-		nic_dev->tx_ops->nic_tx_set_wqe_offload =3D hinic3_tx_set_normal_task_of=
fload;=0D
-}=0D
-=0D
 /**=0D
  * Initialize the network function, including hardware configuration, memo=
ry=0D
  * allocation for data structures, MAC address setup, and interrupt enabli=
ng.=0D
@@ -3785,6 +3823,25 @@ hinic3_func_init(struct rte_eth_dev *eth_dev)=0D
 		PMD_DRV_LOG(INFO, "Initialize %s in secondary process",=0D
 			    eth_dev->data->name);=0D
 =0D
+		char name[RTE_ETH_NAME_MAX_LEN];=0D
+		snprintf(name, sizeof(name), "%s", eth_dev->data->name);=0D
+		eth_dev =3D rte_eth_dev_attach_secondary(name);=0D
+		if (eth_dev =3D=3D NULL) {=0D
+			PMD_DRV_LOG(ERR, "can not attach rte ethdev, dev_name: %s", name);=0D
+			return -ENOMEM;=0D
+		}=0D
+=0D
+		nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(eth_dev);=0D
+		if (nic_dev =3D=3D NULL) {=0D
+			PMD_DRV_LOG(ERR, "nic_dev hwdev is NULL, dev_name: %s", name);=0D
+			return -ENOMEM;=0D
+		}=0D
+=0D
+		if (HINIC3_FUNC_TYPE(nic_dev->hwdev) =3D=3D TYPE_VF)=0D
+			eth_dev->dev_ops =3D &hinic3_pmd_vf_ops;=0D
+		else=0D
+			eth_dev->dev_ops =3D &hinic3_pmd_ops;=0D
+=0D
 		return 0;=0D
 	}=0D
 =0D
@@ -3806,13 +3863,6 @@ hinic3_func_init(struct rte_eth_dev *eth_dev)=0D
 		goto alloc_eth_addr_fail;=0D
 	}=0D
 =0D
-	nic_dev->tx_ops =3D rte_zmalloc("tx_ops", sizeof(struct hinic3_nic_tx_ops=
), 0);=0D
-	if (!nic_dev->tx_ops) {=0D
-		PMD_DRV_LOG(ERR, "Allocate tx_ops memory failed");=0D
-		err =3D -ENOMEM;=0D
-		goto alloc_tx_ops_fail;=0D
-	}=0D
-=0D
 	nic_dev->mc_list =3D rte_zmalloc("hinic3_mc",=0D
 		HINIC3_MAX_MC_MAC_ADDRS * sizeof(struct rte_ether_addr), 0);=0D
 	if (!nic_dev->mc_list) {=0D
@@ -3866,8 +3916,6 @@ hinic3_func_init(struct rte_eth_dev *eth_dev)=0D
 		goto get_cap_fail;=0D
 	}=0D
 =0D
-	hinic3_nic_tx_rx_ops_init(nic_dev);=0D
-=0D
 	/* Read wqe type from kernel parameter. */=0D
 	if (hinic3_read_module_param(nic_dev, "rq_wqe_type", &compact_cqe) !=3D 0=
) {=0D
 		err =3D -EINVAL;=0D
@@ -3970,10 +4018,6 @@ hinic3_func_init(struct rte_eth_dev *eth_dev)=0D
 	nic_dev->mc_list =3D NULL;=0D
 =0D
 alloc_mc_list_fail:=0D
-	rte_free(nic_dev->tx_ops);=0D
-	nic_dev->tx_ops =3D NULL;=0D
-=0D
-alloc_tx_ops_fail:=0D
 	rte_free(eth_dev->data->mac_addrs);=0D
 	eth_dev->data->mac_addrs =3D NULL;=0D
 =0D
@@ -4113,12 +4157,13 @@ hinic3_dev_init(struct rte_eth_dev *eth_dev)=0D
 =0D
 	hinic3_nic_feature_init(nic_dev);=0D
 =0D
-	if (nic_dev->config.rx_cqe_compact_en !=3D HINIC3_RX_CQE_COMPACT_EN)=0D
+	if (nic_dev->config.rx_cqe_compact_en !=3D HINIC3_RX_CQE_COMPACT_EN) {=0D
 		eth_dev->rx_pkt_burst =3D hinic3_recv_pkts;=0D
-	else=0D
+		eth_dev->tx_pkt_burst =3D hinic3_xmit_pkts;=0D
+	} else {=0D
 		eth_dev->rx_pkt_burst =3D hinic3_recv_pkts_compact_cqe;=0D
-=0D
-	eth_dev->tx_pkt_burst =3D hinic3_xmit_pkts;=0D
+		eth_dev->tx_pkt_burst =3D hinic3_xmit_pkts_compact_cqe;=0D
+	}=0D
 =0D
 	return err;=0D
 }=0D
diff --git a/drivers/net/hinic3/hinic3_ethdev.h b/drivers/net/hinic3/hinic3=
_ethdev.h=0D
index 41f6738645..399c9c9342 100644=0D
--- a/drivers/net/hinic3/hinic3_ethdev.h=0D
+++ b/drivers/net/hinic3/hinic3_ethdev.h=0D
@@ -15,6 +15,11 @@=0D
 =0D
 #define HINIC3_PMD_DRV_VERSION "B106"=0D
 =0D
+#define HINIC3_MAX_QUEUE_DEPTH         16384=0D
+#define HINIC3_MIN_QUEUE_DEPTH         128=0D
+=0D
+#define HINIC3_QUEUE_STAT_CNTRS        256=0D
+=0D
 #define PCI_DEV_TO_INTR_HANDLE(pci_dev) ((pci_dev)->intr_handle)=0D
 =0D
 #define HINIC3_PKT_RX_L4_CKSUM_BAD	RTE_MBUF_F_RX_L4_CKSUM_BAD=0D
@@ -112,7 +117,7 @@ enum nic_feature_cap {=0D
 =0D
 };=0D
 =0D
-#define DEFAULT_DRV_FEATURE		0x3FC3FFF=0D
+#define DEFAULT_DRV_FEATURE		0x0BFC3FFF=0D
 =0D
 TAILQ_HEAD(hinic3_ethertype_filter_list, rte_flow);=0D
 TAILQ_HEAD(hinic3_fdir_rule_filter_list, rte_flow);=0D
@@ -152,6 +157,7 @@ struct hinic3_nic_dev {=0D
 	uint16_t max_rqs;=0D
 =0D
 	uint16_t rxq_depth;=0D
+	uint16_t txq_depth;=0D
 	uint16_t rx_buff_len;=0D
 	uint16_t mtu_size;=0D
 =0D
@@ -189,7 +195,6 @@ struct hinic3_nic_dev {=0D
 	struct hinic3_fdir_rule_filter_list filter_fdir_rule_list;=0D
 	uint8_t cos_map[HINIC3_COS_NUM_MAX];=0D
 	struct hinic3_ptype_table *ptype_tbl;=0D
-	struct hinic3_nic_tx_ops *tx_ops;=0D
 	uint32_t fec_mode;  /**< Current FEC mode for ethdev. */=0D
 	enum nic_type nic_type; /**< NIC type. */=0D
 =0D
@@ -204,6 +209,7 @@ struct hinic3_nic_dev {=0D
 =0D
 extern const struct rte_flow_ops hinic3_flow_ops;=0D
 =0D
+bool is_sp230_pci_dev(struct rte_pci_device *pci_dev);=0D
 /**=0D
  * Enable interrupt for the specified RX queue.=0D
  *=0D
diff --git a/drivers/net/hinic3/hinic3_tx.c b/drivers/net/hinic3/hinic3_tx.=
c=0D
index 566e22315d..c3f053f869 100644=0D
--- a/drivers/net/hinic3/hinic3_tx.c=0D
+++ b/drivers/net/hinic3/hinic3_tx.c=0D
@@ -78,6 +78,30 @@ hinic3_get_and_update_sq_owner(struct hinic3_txq *sq, ui=
nt16_t curr_pi, uint16_t=0D
 	return owner;=0D
 }=0D
 =0D
+static void *=0D
+hinic3_get_sq_wqe(struct hinic3_txq *sq,=0D
+			       struct hinic3_wqe_info *wqe_info)=0D
+{=0D
+	uint16_t cur_pi =3D MASKED_QUEUE_IDX(sq, sq->prod_idx);=0D
+	uint32_t end_pi;=0D
+=0D
+	end_pi =3D cur_pi + wqe_info->wqebb_cnt;=0D
+	sq->prod_idx +=3D wqe_info->wqebb_cnt;=0D
+=0D
+	wqe_info->owner =3D (uint8_t)(sq->owner);=0D
+	wqe_info->pi =3D cur_pi;=0D
+	wqe_info->wrapped =3D 0;=0D
+=0D
+	if (unlikely(end_pi >=3D sq->q_depth)) {=0D
+		sq->owner =3D !sq->owner;=0D
+=0D
+		if (likely(end_pi > sq->q_depth))=0D
+			wqe_info->wrapped =3D (uint8_t)(sq->q_depth - cur_pi);=0D
+	}=0D
+=0D
+	return NIC_WQE_ADDR(sq, cur_pi);=0D
+}=0D
+=0D
 static inline void=0D
 hinic3_put_sq_wqe(struct hinic3_txq *sq, struct hinic3_wqe_info *wqe_info)=
=0D
 {=0D
@@ -98,9 +122,9 @@ hinic3_put_sq_wqe(struct hinic3_txq *sq, struct hinic3_w=
qe_info *wqe_info)=0D
  * Point to wqe_info of send queue(SQ).=0D
  */=0D
 static void=0D
-hinic3_set_wqe_combo(struct hinic3_txq *sq,=0D
-		     struct hinic3_sq_wqe_combo *wqe_combo,=0D
-		     struct hinic3_wqe_info *wqe_info)=0D
+hinic3_set_wqe_combo_compact_cqe(struct hinic3_txq *sq,=0D
+				 struct hinic3_sq_wqe_combo *wqe_combo,=0D
+				 struct hinic3_wqe_info *wqe_info)=0D
 {=0D
 	uint16_t tmp_pi;=0D
 =0D
@@ -125,6 +149,62 @@ hinic3_set_wqe_combo(struct hinic3_txq *sq,=0D
 	wqe_info->owner =3D hinic3_get_and_update_sq_owner(sq, wqe_info->pi, wqe_=
info->wqebb_cnt);=0D
 }=0D
 =0D
+/**=0D
+ * Sets the WQE combination information in the transmit queue (SQ).=0D
+ *=0D
+ * @param[in] sq=0D
+ * Point to send queue.=0D
+ * @param[out] wqe_combo=0D
+ * Point to wqe_combo of send queue(SQ).=0D
+ * @param[in] wqe_info=0D
+ * Point to wqe_info of send queue(SQ).=0D
+ */=0D
+static void=0D
+hinic3_set_wqe_combo(struct hinic3_txq *sq,=0D
+		     struct hinic3_sq_wqe_combo *wqe_combo,=0D
+		     struct hinic3_sq_wqe *wqe,=0D
+		     struct hinic3_wqe_info *wqe_info)=0D
+{=0D
+	wqe_combo->hdr =3D &wqe->compact_wqe.wqe_desc;=0D
+=0D
+	if (wqe_info->offload) {=0D
+		if (wqe_info->wrapped =3D=3D HINIC3_TX_TASK_WRAPPED) {=0D
+			wqe_combo->task =3D (struct hinic3_sq_task *)=0D
+				(void *)sq->sq_head_addr;=0D
+			wqe_combo->bds_head =3D (struct hinic3_sq_bufdesc *)=0D
+				(void *)(sq->sq_head_addr + sq->wqebb_size);=0D
+		} else if (wqe_info->wrapped =3D=3D HINIC3_TX_BD_DESC_WRAPPED) {=0D
+			wqe_combo->task =3D &wqe->extend_wqe.task;=0D
+			wqe_combo->bds_head =3D (struct hinic3_sq_bufdesc *)=0D
+				(void *)(sq->sq_head_addr);=0D
+		} else {=0D
+			wqe_combo->task =3D &wqe->extend_wqe.task;=0D
+			wqe_combo->bds_head =3D wqe->extend_wqe.buf_desc;=0D
+		}=0D
+=0D
+		wqe_combo->wqe_type =3D SQ_WQE_EXTENDED_TYPE;=0D
+		wqe_combo->task_type =3D SQ_WQE_TASKSECT_16BYTES;=0D
+		return;=0D
+	}=0D
+=0D
+	if (wqe_info->wrapped =3D=3D HINIC3_TX_TASK_WRAPPED) {=0D
+		wqe_combo->bds_head =3D (struct hinic3_sq_bufdesc *)=0D
+				(void *)(sq->sq_head_addr);=0D
+	} else {=0D
+		wqe_combo->bds_head =3D=0D
+			(struct hinic3_sq_bufdesc *)(&wqe->extend_wqe.task);=0D
+	}=0D
+=0D
+	if (wqe_info->wqebb_cnt > 1) {=0D
+		wqe_combo->wqe_type =3D SQ_WQE_EXTENDED_TYPE;=0D
+		wqe_combo->task_type =3D SQ_WQE_TASKSECT_4BYTES;=0D
+		/* This section used as vlan insert, needs to clear */=0D
+		wqe_combo->bds_head->rsvd =3D 0;=0D
+	} else {=0D
+		wqe_combo->wqe_type =3D SQ_WQE_COMPACT_TYPE;=0D
+	}=0D
+}=0D
+=0D
 int=0D
 hinic3_start_all_sqs(struct rte_eth_dev *eth_dev)=0D
 {=0D
@@ -344,33 +424,15 @@ hinic3_tx_offload_pkt_prepare(struct hinic3_nic_dev *=
nic_dev, struct rte_mbuf *m=0D
 	return 0;=0D
 }=0D
 =0D
-void=0D
-hinic3_tx_set_normal_task_offload(struct hinic3_wqe_info *wqe_info,=0D
-				  struct hinic3_sq_wqe_combo *wqe_combo)=0D
+static inline void hinic3_set_vlan_tx_offload(struct hinic3_sq_task *task,=
=0D
+					      uint16_t vlan_tag, uint8_t vlan_type)=0D
 {=0D
-	struct hinic3_sq_task *task =3D wqe_combo->task;=0D
-	struct hinic3_offload_info *offload_info =3D &wqe_info->offload_info;=0D
-=0D
-	task->pkt_info0 =3D 0;=0D
-	task->pkt_info0 |=3D SQ_TASK_INFO0_SET(offload_info->inner_l4_en, INNER_L=
4_EN);=0D
-	task->pkt_info0 |=3D SQ_TASK_INFO0_SET(offload_info->inner_l3_en, INNER_L=
3_EN);=0D
-	task->pkt_info0 |=3D SQ_TASK_INFO0_SET(offload_info->encapsulation, TUNNE=
L_FLAG);=0D
-	task->pkt_info0 |=3D SQ_TASK_INFO0_SET(offload_info->out_l3_en, OUT_L3_EN=
);=0D
-	task->pkt_info0 |=3D SQ_TASK_INFO0_SET(offload_info->out_l4_en, OUT_L4_EN=
);=0D
-	task->pkt_info0 =3D hinic3_hw_be32(task->pkt_info0);=0D
-=0D
-	if (wqe_combo->task_type =3D=3D SQ_WQE_TASKSECT_16BYTES) {=0D
-		task->ip_identify =3D 0;=0D
-		task->pkt_info2 =3D 0;=0D
-		task->vlan_offload =3D 0;=0D
-		task->vlan_offload =3D SQ_TASK_INFO3_SET(offload_info->vlan_tag, VLAN_TA=
G) |=0D
-				     SQ_TASK_INFO3_SET(offload_info->vlan_sel, VLAN_TYPE) |=0D
-				     SQ_TASK_INFO3_SET(offload_info->vlan_valid, VLAN_TAG_VALID);=0D
-		task->vlan_offload =3D hinic3_hw_be32(task->vlan_offload);=0D
-	}=0D
+	task->vlan_offload =3D SQ_TASK_INFO3_SET(vlan_tag, VLAN_TAG) |=0D
+			     SQ_TASK_INFO3_SET(vlan_type, VLAN_TYPE) |=0D
+			     SQ_TASK_INFO3_SET(1U, VLAN_TAG_VALID);=0D
 }=0D
 =0D
-void=0D
+static void=0D
 hinic3_tx_set_compact_task_offload(struct hinic3_wqe_info *wqe_info,=0D
 				   struct hinic3_sq_wqe_combo *wqe_combo)=0D
 {=0D
@@ -391,10 +453,9 @@ hinic3_tx_set_compact_task_offload(struct hinic3_wqe_i=
nfo *wqe_info,=0D
 }=0D
 =0D
 static int=0D
-hinic3_set_tx_offload(struct hinic3_nic_dev *nic_dev,=0D
-		      struct rte_mbuf *mbuf,=0D
-		      struct hinic3_sq_wqe_combo *wqe_combo,=0D
-		      struct hinic3_wqe_info *wqe_info)=0D
+hinic3_set_tx_offload_compact_cqe(struct rte_mbuf *mbuf,=0D
+				  struct hinic3_sq_wqe_combo *wqe_combo,=0D
+				  struct hinic3_wqe_info *wqe_info)=0D
 {=0D
 	uint64_t ol_flags =3D mbuf->ol_flags;=0D
 	struct hinic3_offload_info *offload_info =3D &wqe_info->offload_info;=0D
@@ -443,6 +504,9 @@ hinic3_set_tx_offload(struct hinic3_nic_dev *nic_dev,=0D
 		offload_info->encapsulation =3D 1;=0D
 		wqe_info->queue_info.udp_dp_en =3D 1;=0D
 		break;=0D
+	case HINIC3_PKT_TX_TUNNEL_IPIP:=0D
+		offload_info->encapsulation =3D 1;=0D
+		break;=0D
 	case 0:=0D
 		break;=0D
 =0D
@@ -458,8 +522,110 @@ hinic3_set_tx_offload(struct hinic3_nic_dev *nic_dev,=
=0D
 		offload_info->out_l4_en =3D 1;=0D
 =0D
 set_tx_wqe_offload:=0D
-	nic_dev->tx_ops->nic_tx_set_wqe_offload(wqe_info, wqe_combo);=0D
+	hinic3_tx_set_compact_task_offload(wqe_info, wqe_combo);=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static int=0D
+hinic3_set_tx_offload(struct rte_mbuf *mbuf,=0D
+		      struct hinic3_sq_task *task,=0D
+		      struct hinic3_wqe_info *wqe_info,=0D
+		      enum nic_type nic_type)=0D
+{=0D
+	uint64_t ol_flags =3D mbuf->ol_flags;=0D
+	uint16_t pld_offset =3D 0;=0D
+	uint32_t queue_info =3D 0;=0D
+	uint16_t vlan_tag;=0D
+=0D
+	task->pkt_info0 =3D 0;=0D
+	task->ip_identify =3D 0;=0D
+	task->pkt_info2 =3D 0;=0D
+	task->vlan_offload =3D 0;=0D
+=0D
+	/* Vlan offload */=0D
+	if (unlikely(ol_flags & HINIC3_PKT_TX_VLAN_PKT)) {=0D
+		vlan_tag =3D mbuf->vlan_tci;=0D
+		hinic3_set_vlan_tx_offload(task, vlan_tag, HINIC3_TX_TPID0);=0D
+		task->vlan_offload =3D hinic3_hw_be32(task->vlan_offload);=0D
+	}=0D
+=0D
+	if (!(ol_flags & HINIC3_TX_CKSUM_OFFLOAD_MASK))=0D
+		return 0;=0D
+=0D
+	/* Tso offload */=0D
+	if (ol_flags & HINIC3_PKT_TX_TCP_SEG) {=0D
+		if (((ol_flags & HINIC3_PKT_TX_TUNNEL_IPIP) =3D=3D HINIC3_PKT_TX_TUNNEL_=
IPIP) &&=0D
+		     nic_type =3D=3D NIC_SP620) {=0D
+			PMD_DRV_LOG(ERR, "IPinIP not support TSO");=0D
+			return -EINVAL;=0D
+		}=0D
+		if ((ol_flags & HINIC3_PKT_TX_TUNNEL_MASK) =3D=3D HINIC3_PKT_TX_TUNNEL_V=
XLAN_GPE) {=0D
+			PMD_DRV_LOG(ERR, "VXLAN_GPE not support TSO");=0D
+			return -EINVAL;=0D
+		}=0D
+		pld_offset =3D wqe_info->payload_offset;=0D
+		if ((pld_offset >> 1) > MAX_PAYLOAD_OFFSET)=0D
+			return -EINVAL;=0D
+=0D
+		task->pkt_info0 |=3D SQ_TASK_INFO0_SET(1U, INNER_L4_EN);=0D
+		task->pkt_info0 |=3D SQ_TASK_INFO0_SET(1U, INNER_L3_EN);=0D
+=0D
+		queue_info |=3D SQ_CTRL_QUEUE_INFO_SET(1U, TSO);=0D
+		queue_info |=3D SQ_CTRL_QUEUE_INFO_SET(pld_offset >> 1, PLDOFF);=0D
+=0D
+		/* Set MSS value */=0D
+		queue_info =3D SQ_CTRL_QUEUE_INFO_CLEAR(queue_info, MSS);=0D
+		queue_info |=3D SQ_CTRL_QUEUE_INFO_SET(mbuf->tso_segsz, MSS);=0D
+	} else {=0D
+		if (ol_flags & HINIC3_PKT_TX_IP_CKSUM)=0D
+			task->pkt_info0 |=3D SQ_TASK_INFO0_SET(1U, INNER_L3_EN);=0D
+=0D
+		switch (ol_flags & HINIC3_PKT_TX_L4_MASK) {=0D
+		case HINIC3_PKT_TX_TCP_CKSUM:=0D
+		case HINIC3_PKT_TX_UDP_CKSUM:=0D
+		case HINIC3_PKT_TX_SCTP_CKSUM:=0D
+			task->pkt_info0 |=3D SQ_TASK_INFO0_SET(1U, INNER_L4_EN);=0D
+			break;=0D
+		case HINIC3_PKT_TX_L4_NO_CKSUM:=0D
+			break;=0D
+		default:=0D
+			PMD_DRV_LOG(INFO, "not support pkt type");=0D
+			return -EINVAL;=0D
+		}=0D
+	}=0D
+=0D
+	/* For vxlan, also can support PKT_TX_TUNNEL_GENEVE/GRE, etc */=0D
+	switch (ol_flags & HINIC3_PKT_TX_TUNNEL_MASK) {=0D
+	case HINIC3_PKT_TX_TUNNEL_VXLAN:=0D
+		task->pkt_info0 |=3D SQ_TASK_INFO0_SET(1U, TUNNEL_FLAG);=0D
+		break;=0D
+	case HINIC3_PKT_TX_TUNNEL_VXLAN_GPE:=0D
+		task->pkt_info0 |=3D SQ_TASK_INFO0_SET(1U, TUNNEL_FLAG);=0D
+		break;=0D
+	case HINIC3_PKT_TX_TUNNEL_GENEVE:=0D
+		task->pkt_info0 |=3D SQ_TASK_INFO0_SET(1U, TUNNEL_FLAG);=0D
+		break;=0D
+	case HINIC3_PKT_TX_TUNNEL_IPIP:=0D
+		task->pkt_info0 |=3D SQ_TASK_INFO0_SET(1U, TUNNEL_FLAG);=0D
+		break;=0D
+	case 0:=0D
+		break;=0D
+	default:=0D
+		/* For non UDP/GRE tunneling, drop the tunnel packet */=0D
+		PMD_DRV_LOG(INFO, "not support tunnel pkt type");=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	if (ol_flags & HINIC3_PKT_TX_OUTER_IP_CKSUM)=0D
+		task->pkt_info0 |=3D SQ_TASK_INFO0_SET(1U, OUT_L3_EN);=0D
+=0D
+	if (ol_flags & HINIC3_PKT_TX_OUTER_UDP_CKSUM)=0D
+		task->pkt_info0 |=3D SQ_TASK_INFO0_SET(1U, OUT_L4_EN);=0D
 =0D
+	task->pkt_info0 =3D hinic3_hw_be32(task->pkt_info0);=0D
+	task->pkt_info2 =3D hinic3_hw_be32(task->pkt_info2);=0D
+	wqe_info->queue_info_sp600 =3D queue_info;=0D
 	return 0;=0D
 }=0D
 =0D
@@ -602,6 +768,8 @@ hinic3_non_tso_pkt_pre_process(struct rte_mbuf *mbuf, s=
truct hinic3_wqe_info *wq=0D
  * Point to the mbuf to send.=0D
  * @param[in] wqe_info=0D
  * Point to wqe_info of send queue(SQ).=0D
+ * @param[in] non_tso_max_pkt_len=0D
+ *  Number of non_tso_max_pkt_len(SP230 is 9600, SP560/620 is 4K)=0D
  * @return=0D
  * 0 as success, -EINVAL as failure.=0D
  */=0D
@@ -806,6 +974,14 @@ hinic3_mbuf_dma_map_sge(struct hinic3_txq *txq, struct=
 rte_mbuf *mbuf,=0D
 			hinic3_set_buf_desc(buf_desc, dma_addr, mbuf->data_len);=0D
 			buf_desc++;=0D
 		}=0D
+=0D
+		/*=0D
+		 * SP620: For wqe compact type, no need to prepare=0D
+		 * sq ctrl info. Need set queue_info =3D 0.=0D
+		 */=0D
+		if (txq->nic_dev->nic_type =3D=3D NIC_SP620)=0D
+			wqe_desc->queue_info =3D 0;=0D
+=0D
 		mbuf =3D mbuf->next;=0D
 	}=0D
 =0D
@@ -853,8 +1029,8 @@ hinic3_mbuf_dma_map_sge(struct hinic3_txq *txq, struct=
 rte_mbuf *mbuf,=0D
  * Point to wqe_info of send queue.=0D
  */=0D
 static void=0D
-hinic3_prepare_sq_ctrl(struct hinic3_sq_wqe_combo *wqe_combo,=0D
-		       struct hinic3_wqe_info *wqe_info)=0D
+hinic3_prepare_sq_ctrl_compact_cqe(struct hinic3_sq_wqe_combo *wqe_combo,=
=0D
+				   struct hinic3_wqe_info *wqe_info)=0D
 {=0D
 	struct hinic3_queue_info *queue_info =3D &wqe_info->queue_info;=0D
 	struct hinic3_sq_wqe_desc *wqe_desc =3D wqe_combo->hdr;=0D
@@ -867,7 +1043,7 @@ hinic3_prepare_sq_ctrl(struct hinic3_sq_wqe_combo *wqe=
_combo,=0D
 	if (wqe_combo->wqe_type =3D=3D SQ_WQE_EXTENDED_TYPE) {=0D
 		wqe_desc->ctrl_len |=3D SQ_CTRL_SET(wqe_info->sge_cnt, BUFDESC_NUM) |=0D
 				      SQ_CTRL_SET(wqe_combo->task_type, TASKSECT_LEN) |=0D
-				      SQ_CTRL_SET(SQ_NORMAL_WQE, DATA_FORMAT);=0D
+				      SQ_CTRL_SET(SQ_WQE_SGL, DATA_FORMAT);=0D
 =0D
 		*qsf =3D SQ_CTRL_QUEUE_INFO_SET(1, UC) |=0D
 		       SQ_CTRL_QUEUE_INFO_SET(queue_info->sctp, SCTP) |=0D
@@ -888,14 +1064,56 @@ hinic3_prepare_sq_ctrl(struct hinic3_sq_wqe_combo *w=
qe_combo,=0D
 		*qsf =3D hinic3_hw_be32(*qsf);=0D
 	} else {=0D
 		wqe_desc->ctrl_len |=3D SQ_CTRL_COMPACT_QUEUE_INFO_SET(queue_info->sctp,=
 SCTP) |=0D
-				SQ_CTRL_COMPACT_QUEUE_INFO_SET(queue_info->udp_dp_en, UDP_DP_EN) |=0D
-				SQ_CTRL_COMPACT_QUEUE_INFO_SET(queue_info->ufo, UFO) |=0D
-				SQ_CTRL_COMPACT_QUEUE_INFO_SET(queue_info->pkt_type, PKT_TYPE);=0D
+				      SQ_CTRL_COMPACT_QUEUE_INFO_SET(queue_info->udp_dp_en,=0D
+								     UDP_DP_EN) |=0D
+				      SQ_CTRL_COMPACT_QUEUE_INFO_SET(queue_info->ufo, UFO) |=0D
+				      SQ_CTRL_COMPACT_QUEUE_INFO_SET(queue_info->pkt_type,=0D
+								     PKT_TYPE);=0D
 	}=0D
 =0D
 	wqe_desc->ctrl_len =3D hinic3_hw_be32(wqe_desc->ctrl_len);=0D
 }=0D
 =0D
+/**=0D
+ * Sets and configures fields in the transmit queue control descriptor bas=
ed on=0D
+ * the WQE type.=0D
+ *=0D
+ * @param[out] wqe_combo=0D
+ * Point to wqe_combo of send queue.=0D
+ * @param[in] wqe_info=0D
+ * Point to wqe_info of send queue.=0D
+ */=0D
+static void=0D
+hinic3_prepare_sq_ctrl(struct hinic3_sq_wqe_combo *wqe_combo,=0D
+		       struct hinic3_wqe_info *wqe_info)=0D
+{=0D
+	struct hinic3_sq_wqe_desc *wqe_desc =3D wqe_combo->hdr;=0D
+=0D
+	wqe_desc->ctrl_len |=3D SQ_CTRL_SET(wqe_info->sge_cnt, BUFDESC_NUM) |=0D
+			      SQ_CTRL_SET(wqe_combo->task_type, TASKSECT_LEN) |=0D
+			      SQ_CTRL_SET(SQ_NORMAL_WQE, DATA_FORMAT) |=0D
+			      SQ_CTRL_SET(wqe_combo->wqe_type, EXTENDED) |=0D
+			      SQ_CTRL_SET(wqe_info->owner, OWNER);=0D
+=0D
+	wqe_desc->ctrl_len =3D hinic3_hw_be32(wqe_desc->ctrl_len);=0D
+=0D
+	wqe_desc->queue_info =3D wqe_info->queue_info_sp600;=0D
+	wqe_desc->queue_info |=3D SQ_CTRL_QUEUE_INFO_SET(1U, UC);=0D
+=0D
+	if (!SQ_CTRL_QUEUE_INFO_GET(wqe_desc->queue_info, MSS)) {=0D
+		wqe_desc->queue_info |=3D=0D
+			SQ_CTRL_QUEUE_INFO_SET(TX_MSS_DEFAULT, MSS);=0D
+	} else if (SQ_CTRL_QUEUE_INFO_GET(wqe_desc->queue_info, MSS) <=0D
+		   TX_MSS_MIN) {=0D
+		/* Mss should not less than 80 */=0D
+		wqe_desc->queue_info =3D=0D
+			SQ_CTRL_QUEUE_INFO_CLEAR(wqe_desc->queue_info, MSS);=0D
+		wqe_desc->queue_info |=3D SQ_CTRL_QUEUE_INFO_SET(TX_MSS_MIN, MSS);=0D
+	}=0D
+=0D
+	wqe_desc->queue_info =3D hinic3_hw_be32(wqe_desc->queue_info);=0D
+}=0D
+=0D
 /**=0D
  * It is responsible for sending data packets.=0D
  *=0D
@@ -912,13 +1130,16 @@ uint16_t=0D
 hinic3_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pk=
ts)=0D
 {=0D
 	struct hinic3_txq *txq =3D tx_queue;=0D
+	struct hinic3_nic_dev *nic_dev =3D txq->nic_dev;=0D
 	struct hinic3_tx_info *tx_info =3D NULL;=0D
 	struct rte_mbuf *mbuf_pkt =3D NULL;=0D
 	struct hinic3_sq_wqe_combo wqe_combo =3D {0};=0D
+	struct hinic3_sq_wqe *sq_wqe =3D NULL;=0D
 	struct hinic3_wqe_info wqe_info =3D {0};=0D
 	uint32_t offload_err, free_cnt;=0D
 	uint64_t tx_bytes =3D 0;=0D
 	uint16_t free_wqebb_cnt, nb_tx;=0D
+	uint64_t tx_free_loop =3D 0;=0D
 	int err;=0D
 =0D
 #ifdef HINIC3_XSTAT_PROF_TX=0D
@@ -929,6 +1150,7 @@ hinic3_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_=
pkts, uint16_t nb_pkts)=0D
 	if (unlikely(!HINIC3_TXQ_IS_STARTED(txq)))=0D
 		return 0;=0D
 =0D
+	rte_prefetch0(tx_pkts[0]);=0D
 	free_cnt =3D txq->tx_free_thresh;=0D
 	/* Reclaim tx mbuf before xmit new packets. */=0D
 	if (hinic3_get_sq_free_wqebbs(txq) < txq->tx_free_thresh)=0D
@@ -936,53 +1158,64 @@ hinic3_xmit_pkts(void *tx_queue, struct rte_mbuf **t=
x_pkts, uint16_t nb_pkts)=0D
 =0D
 	/* Tx loop routine. */=0D
 	for (nb_tx =3D 0; nb_tx < nb_pkts; nb_tx++) {=0D
-		mbuf_pkt =3D *tx_pkts++;=0D
+		mbuf_pkt =3D *tx_pkts;=0D
+		rte_prefetch0(++tx_pkts);=0D
 		if (unlikely(hinic3_get_tx_offload(txq->nic_dev, mbuf_pkt, &wqe_info,=0D
 						   txq->non_tso_max_pkt_len))) {=0D
 			txq->txq_stats.offload_errors++;=0D
 			break;=0D
 		}=0D
 =0D
-		wqe_info.wqebb_cnt =3D wqe_info.sge_cnt;=0D
-		if (likely(wqe_info.offload || wqe_info.wqebb_cnt > 1)) {=0D
-			if (txq->tx_wqe_compact_task) {=0D
-				/**=0D
-				 * One more wqebb is needed for compact task under two situations:=0D
-				 * 1. TSO: MSS field is needed, no available space for=0D
-				 *    compact task in compact wqe.=0D
-				 * 2. SGE number > 1: wqe is handlerd as extended wqe by nic.=0D
-				 */=0D
-				if (mbuf_pkt->ol_flags & HINIC3_PKT_TX_TCP_SEG ||=0D
-				    wqe_info.wqebb_cnt > 1)=0D
-					wqe_info.wqebb_cnt++;=0D
-			} else {=0D
-				/* Use extended sq wqe with normal TS */=0D
-				wqe_info.wqebb_cnt++;=0D
-			}=0D
-		}=0D
+		if (!wqe_info.offload)=0D
+			/*=0D
+			 * Use extended sq wqe with small TS, which can include=0D
+			 * multi sges, or compact sq normal wqe, which just=0D
+			 * supports one sge=0D
+			 */=0D
+			wqe_info.wqebb_cnt =3D wqe_info.sge_cnt;=0D
+		else=0D
+			/* Use extended sq wqe with normal TS */=0D
+			wqe_info.wqebb_cnt =3D wqe_info.sge_cnt + 1;=0D
 =0D
 		free_wqebb_cnt =3D hinic3_get_sq_free_wqebbs(txq);=0D
-		if (unlikely(wqe_info.wqebb_cnt > free_wqebb_cnt)) {=0D
-			/* Reclaim again. */=0D
+		while (wqe_info.wqebb_cnt > free_wqebb_cnt) {=0D
+			/*=0D
+			 * Try to reclaim completed Tx WQEs when SQ space is=0D
+			 * insufficient. This gives hardware a chance to free=0D
+			 * descriptors and helps prevent packet drops caused=0D
+			 * by transient SQ congestion.=0D
+			 */=0D
 			hinic3_xmit_mbuf_cleanup(txq, free_cnt);=0D
 			free_wqebb_cnt =3D hinic3_get_sq_free_wqebbs(txq);=0D
-			if (unlikely(wqe_info.wqebb_cnt > free_wqebb_cnt)) {=0D
+			if ((tx_free_loop++) > nic_dev->config.tx_free_loop) {=0D
 				txq->txq_stats.tx_busy +=3D (nb_pkts - nb_tx);=0D
-				break;=0D
+				goto end;=0D
 			}=0D
 		}=0D
 =0D
-		/* Task or bd section maybe wrapped for one wqe. */=0D
-		hinic3_set_wqe_combo(txq, &wqe_combo, &wqe_info);=0D
+		/* Get sq wqe address from wqe_page */=0D
+		sq_wqe =3D hinic3_get_sq_wqe(txq, &wqe_info);=0D
+		if (unlikely(!sq_wqe)) {=0D
+			txq->txq_stats.tx_busy++;=0D
+			break;=0D
+		}=0D
 =0D
-		/* Fill tx packet offload into qsf and task field. */=0D
-		offload_err =3D hinic3_set_tx_offload(txq->nic_dev, mbuf_pkt, &wqe_combo=
, &wqe_info);=0D
+		/* Task or bd section maybe wrapped for one wqe */=0D
+		hinic3_set_wqe_combo(txq, &wqe_combo, sq_wqe, &wqe_info);=0D
+=0D
+		wqe_info.queue_info_sp600 =3D 0;=0D
+		/* Fill tx packet offload into qsf and task field */=0D
+		if (wqe_info.offload) {=0D
+			offload_err =3D hinic3_set_tx_offload(mbuf_pkt,=0D
+							    wqe_combo.task,=0D
+							    &wqe_info,=0D
+							    txq->nic_dev->nic_type);=0D
 			if (unlikely(offload_err)) {=0D
 				hinic3_put_sq_wqe(txq, &wqe_info);=0D
 				txq->txq_stats.offload_errors++;=0D
 				break;=0D
 			}=0D
-=0D
+		}=0D
 		/* Fill sq_wqe buf_desc and bd_desc. */=0D
 		err =3D hinic3_mbuf_dma_map_sge(txq, mbuf_pkt, &wqe_combo,=0D
 					      &wqe_info);=0D
@@ -1006,7 +1239,7 @@ hinic3_xmit_pkts(void *tx_queue, struct rte_mbuf **tx=
_pkts, uint16_t nb_pkts)=0D
 =0D
 		tx_bytes +=3D mbuf_pkt->pkt_len;=0D
 	}=0D
-=0D
+end:=0D
 	/* Update txq stats. */=0D
 	if (nb_tx) {=0D
 		hinic3_write_db(txq->db_addr, txq->q_id, (int)(txq->cos),=0D
@@ -1081,3 +1314,166 @@ hinic3_flush_txqs(struct hinic3_nic_dev *nic_dev)=0D
 			PMD_DRV_LOG(ERR, "Stop sq%d failed", qid);=0D
 	}=0D
 }=0D
+=0D
+int=0D
+hinic3_tx_burst_mode_get(struct rte_eth_dev *dev,=0D
+						 uint16_t tx_queue_id,=0D
+						 struct rte_eth_burst_mode *mode)=0D
+{=0D
+	uint16_t tx_offloads =3D dev->data->dev_conf.txmode.offloads;=0D
+	struct hinic3_nic_dev *nic_dev;=0D
+	struct hinic3_txq *txq =3D NULL;=0D
+=0D
+	nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);=0D
+	txq =3D nic_dev->txqs[tx_queue_id];=0D
+	if (!txq)=0D
+		return -EINVAL;=0D
+=0D
+	snprintf(mode->info, sizeof(mode->info),=0D
+		"Scalar%s%s%s%s%s",=0D
+		(tx_offloads & RTE_ETH_TX_OFFLOAD_MULTI_SEGS) ? " + MULTI" : "",=0D
+		(tx_offloads & (RTE_ETH_TX_OFFLOAD_TCP_TSO |=0D
+				RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO)) ? " + TSO" : "",=0D
+		(tx_offloads & (RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |=0D
+				RTE_ETH_TX_OFFLOAD_UDP_CKSUM |=0D
+				RTE_ETH_TX_OFFLOAD_TCP_CKSUM |=0D
+				RTE_ETH_TX_OFFLOAD_SCTP_CKSUM |=0D
+				RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM)) ? " + CKSUM" : "",=0D
+		(tx_offloads & RTE_ETH_TX_OFFLOAD_VLAN_INSERT) ? " + VLAN" : "",=0D
+		(tx_offloads & RTE_ETH_TX_OFFLOAD_QINQ_INSERT) ? " + QINQ" : "");=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+/**=0D
+ * It is responsible for sending data packets.=0D
+ *=0D
+ * @param[in] tx_queue=0D
+ * Point to send queue.=0D
+ * @param[in] tx_pkts=0D
+ * Pointer to the array of data packets to be sent.=0D
+ * @param[in] nb_pkts=0D
+ * Number of sent packets.=0D
+ * @return=0D
+ * Number of actually sent packets.=0D
+ */=0D
+uint16_t=0D
+hinic3_xmit_pkts_compact_cqe(void *tx_queue, struct rte_mbuf **tx_pkts, ui=
nt16_t nb_pkts)=0D
+{=0D
+	struct hinic3_txq *txq =3D tx_queue;=0D
+	struct hinic3_nic_dev *nic_dev =3D txq->nic_dev;=0D
+	struct hinic3_tx_info *tx_info =3D NULL;=0D
+	struct rte_mbuf *mbuf_pkt =3D NULL;=0D
+	struct hinic3_sq_wqe_combo wqe_combo =3D {0};=0D
+	struct hinic3_wqe_info wqe_info =3D {0};=0D
+	uint32_t offload_err, free_cnt;=0D
+	uint64_t tx_bytes =3D 0;=0D
+	uint16_t free_wqebb_cnt, nb_tx;=0D
+	uint64_t tx_free_loop =3D 0;=0D
+	int err;=0D
+=0D
+#ifdef HINIC3_XSTAT_PROF_TX=0D
+	uint64_t t1, t2;=0D
+	t1 =3D rte_get_tsc_cycles();=0D
+#endif=0D
+=0D
+	if (unlikely(!HINIC3_TXQ_IS_STARTED(txq)))=0D
+		return 0;=0D
+=0D
+	free_cnt =3D txq->tx_free_thresh;=0D
+	/* Reclaim tx mbuf before xmit new packets. */=0D
+	if (hinic3_get_sq_free_wqebbs(txq) < txq->tx_free_thresh)=0D
+		hinic3_xmit_mbuf_cleanup(txq, free_cnt);=0D
+=0D
+	/* Tx loop routine. */=0D
+	for (nb_tx =3D 0; nb_tx < nb_pkts; nb_tx++) {=0D
+		mbuf_pkt =3D *tx_pkts++;=0D
+		if (unlikely(hinic3_get_tx_offload(nic_dev, mbuf_pkt, &wqe_info,=0D
+						   txq->non_tso_max_pkt_len))) {=0D
+			txq->txq_stats.offload_errors++;=0D
+			break;=0D
+		}=0D
+=0D
+		wqe_info.wqebb_cnt =3D wqe_info.sge_cnt;=0D
+		if (likely(wqe_info.offload || wqe_info.wqebb_cnt > 1)) {=0D
+			if (txq->tx_wqe_compact_task) {=0D
+				/**=0D
+				 * One more wqebb is needed for compact task under two situations:=0D
+				 * 1. TSO: MSS field is needed, no available space for=0D
+				 *    compact task in compact wqe.=0D
+				 * 2. SGE number > 1: wqe is handlerd as extended wqe by nic.=0D
+				 */=0D
+				if (mbuf_pkt->ol_flags & HINIC3_PKT_TX_TCP_SEG ||=0D
+				    wqe_info.wqebb_cnt > 1)=0D
+					wqe_info.wqebb_cnt++;=0D
+			} else {=0D
+				/* Use extended sq wqe with normal TS */=0D
+				wqe_info.wqebb_cnt++;=0D
+			}=0D
+		}=0D
+=0D
+		free_wqebb_cnt =3D hinic3_get_sq_free_wqebbs(txq);=0D
+		while (wqe_info.wqebb_cnt > free_wqebb_cnt) {=0D
+			/* Reclaim again */=0D
+			hinic3_xmit_mbuf_cleanup(txq, free_cnt);=0D
+			free_wqebb_cnt =3D hinic3_get_sq_free_wqebbs(txq);=0D
+			if ((tx_free_loop++) > nic_dev->config.tx_free_loop) {=0D
+				txq->txq_stats.tx_busy +=3D (nb_pkts - nb_tx);=0D
+				goto end;=0D
+			}=0D
+		}=0D
+=0D
+		/* Task or bd section maybe wrapped for one wqe. */=0D
+		hinic3_set_wqe_combo_compact_cqe(txq, &wqe_combo, &wqe_info);=0D
+=0D
+		/* Fill tx packet offload into qsf and task field. */=0D
+		offload_err =3D hinic3_set_tx_offload_compact_cqe(mbuf_pkt, &wqe_combo, =
&wqe_info);=0D
+		if (unlikely(offload_err)) {=0D
+			hinic3_put_sq_wqe(txq, &wqe_info);=0D
+			txq->txq_stats.offload_errors++;=0D
+			break;=0D
+		}=0D
+=0D
+		/* Fill sq_wqe buf_desc and bd_desc. */=0D
+		err =3D hinic3_mbuf_dma_map_sge(txq, mbuf_pkt, &wqe_combo, &wqe_info);=0D
+=0D
+		if (err) {=0D
+			hinic3_put_sq_wqe(txq, &wqe_info);=0D
+			txq->txq_stats.offload_errors++;=0D
+			break;=0D
+		}=0D
+=0D
+		/* Record tx info. */=0D
+		tx_info =3D &txq->tx_info[wqe_info.pi];=0D
+		tx_info->mbuf =3D mbuf_pkt;=0D
+		tx_info->wqebb_cnt =3D wqe_info.wqebb_cnt;=0D
+=0D
+		/*=0D
+		 * For wqe compact type, no need to prepare=0D
+		 * sq ctrl info.=0D
+		 */=0D
+		hinic3_prepare_sq_ctrl_compact_cqe(&wqe_combo, &wqe_info);=0D
+=0D
+		tx_bytes +=3D mbuf_pkt->pkt_len;=0D
+	}=0D
+end:=0D
+	/* Update txq stats. */=0D
+	if (nb_tx) {=0D
+		hinic3_write_db(txq->db_addr, txq->q_id, (int)(txq->cos),=0D
+				SQ_CFLAG_DP,=0D
+				MASKED_QUEUE_IDX(txq, txq->prod_idx));=0D
+		txq->txq_stats.packets +=3D nb_tx;=0D
+		txq->txq_stats.bytes +=3D tx_bytes;=0D
+	}=0D
+	txq->txq_stats.burst_pkts =3D nb_tx;=0D
+=0D
+#ifdef HINIC3_XSTAT_PROF_TX=0D
+	t2 =3D rte_get_tsc_cycles();=0D
+	txq->txq_stats.app_tsc =3D t1 - txq->prof_tx_end_tsc;=0D
+	txq->prof_tx_end_tsc =3D t2;=0D
+	txq->txq_stats.pmd_tsc =3D t2 - t1;=0D
+	txq->txq_stats.burst_pkts =3D nb_tx;=0D
+#endif=0D
+=0D
+	return nb_tx;=0D
+}=0D
diff --git a/drivers/net/hinic3/hinic3_tx.h b/drivers/net/hinic3/hinic3_tx.=
h=0D
index 5d4101630e..10ea174ea2 100644=0D
--- a/drivers/net/hinic3/hinic3_tx.h=0D
+++ b/drivers/net/hinic3/hinic3_tx.h=0D
@@ -18,6 +18,26 @@=0D
 	(HINIC3_NONTSO_PKT_MAX_SGE - HINIC3_NON_COPY_SGE_NUM)=0D
 #define HINIC3_TSO_MBUF_NUM_MAX			(HINIC3_TSO_PKT_MAX_SGE - HINIC3_NON_COP=
Y_SGE_NUM)=0D
 =0D
+/* Tx offload info */=0D
+struct hinic3_tx_offload_info {=0D
+	uint8_t outer_l2_len;=0D
+	uint8_t outer_l3_type;=0D
+	uint16_t outer_l3_len;=0D
+=0D
+	uint8_t inner_l2_len;=0D
+	uint8_t inner_l3_type;=0D
+	uint16_t inner_l3_len;=0D
+=0D
+	uint8_t tunnel_length;=0D
+	uint8_t tunnel_type;=0D
+	uint8_t inner_l4_type;=0D
+	uint8_t inner_l4_len;=0D
+=0D
+	uint16_t payload_offset;=0D
+	uint8_t inner_l4_tcp_udp;=0D
+	uint8_t rsvd0;=0D
+};=0D
+=0D
 /* Tx wqe queue info */=0D
 struct hinic3_queue_info {=0D
 	uint8_t pri;=0D
@@ -55,10 +75,10 @@ struct hinic3_wqe_info {=0D
 	uint16_t sge_cnt;=0D
 =0D
 	uint8_t offload;=0D
-	uint8_t rsvd0; /**< Reserved field 0. */=0D
+	uint8_t wrapped;=0D
 	uint16_t payload_offset;=0D
 =0D
-	uint8_t rsvd1; /**< Reserved field 1. */=0D
+	uint32_t queue_info_sp600;=0D
 	uint8_t owner;=0D
 	uint16_t pi;=0D
 =0D
@@ -381,6 +401,7 @@ struct __rte_cache_aligned hinic3_txq {=0D
 	uint64_t sq_bot_sge_addr;=0D
 	uint32_t cos;=0D
 	uint8_t tx_wqe_compact_task;=0D
+	uint16_t tx_free_loop;=0D
 	uint32_t non_tso_max_pkt_len;=0D
 	struct hinic3_txq_stats txq_stats;=0D
 #ifdef HINIC3_XSTAT_PROF_TX=0D
@@ -388,41 +409,14 @@ struct __rte_cache_aligned hinic3_txq {=0D
 #endif=0D
 };=0D
 =0D
-/* Tx WQE offload set callback function */=0D
-typedef void  (*nic_tx_set_wqe_offload_t)(struct hinic3_wqe_info *wqe_info=
,=0D
-					  struct hinic3_sq_wqe_combo *wqe_combo);=0D
-=0D
-struct hinic3_nic_tx_ops {=0D
-	nic_tx_set_wqe_offload_t	nic_tx_set_wqe_offload;=0D
-};=0D
-=0D
 void hinic3_flush_txqs(struct hinic3_nic_dev *nic_dev);=0D
 void hinic3_free_txq_mbufs(struct hinic3_txq *txq);=0D
 void hinic3_free_all_txq_mbufs(struct hinic3_nic_dev *nic_dev);=0D
+uint16_t hinic3_xmit_pkts_compact_cqe(void *tx_queue, struct rte_mbuf **tx=
_pkts, uint16_t nb_pkts);=0D
 uint16_t hinic3_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint1=
6_t nb_pkts);=0D
 int hinic3_stop_sq(struct hinic3_txq *txq);=0D
 int hinic3_start_all_sqs(struct rte_eth_dev *eth_dev);=0D
 int hinic3_tx_done_cleanup(void *txq, uint32_t free_cnt);=0D
-=0D
-/**=0D
- * Set wqe task section=0D
- *=0D
- * @param[in] wqe_info=0D
- * Packet info parsed according to mbuf=0D
- * @param[in] wqe_combo=0D
- * Wqe need to format=0D
- */=0D
-void hinic3_tx_set_normal_task_offload(struct hinic3_wqe_info *wqe_info,=0D
-				       struct hinic3_sq_wqe_combo *wqe_combo);=0D
-=0D
-/**=0D
- * Set compact wqe task section=0D
- *=0D
- * @param[in] wqe_info=0D
- * Packet info parsed according to mbuf=0D
- * @param[in] wqe_combo=0D
- * Wqe need to format=0D
- */=0D
-void hinic3_tx_set_compact_task_offload(struct hinic3_wqe_info *wqe_info,=
=0D
-					struct hinic3_sq_wqe_combo *wqe_combo);=0D
+int hinic3_tx_burst_mode_get(struct rte_eth_dev *dev, uint16_t tx_queue_id=
,=0D
+			     struct rte_eth_burst_mode *mode);=0D
 #endif /**< _HINIC3_TX_H_ */=0D
-- =0D
2.33.0=0D
=0D

