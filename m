Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2C7CA9EC1
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 14:46:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3CF8540B9F;
	Sat, 10 Oct 2026 16:45:33 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.2])
 by mails.dpdk.org (Postfix) with ESMTP id D38AC4064F
 for <dev@dpdk.org>; Sat, 10 Oct 2026 16:45:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=RfzMBlBLu8ibgH9A+3Ptot/9+PvhbmrECi0EQpzhEVU=;
 b=M/aWuhd3o+8g3Ae/J/yW9LHgAAaDcqXC6V4pbOuAJsN3bLpoi/NB71bv9P0xYg
 7L7IoMowo5HGywkfi1+55MNmSUFFyUVt447HD6aISVMoo9miLG9+c9bL1Da4mpo/
 3cjfSlyvi9XfD5MAI9cntezGBKfmmAYtGT98MHo13GPso=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v1 12/17] net/hinic3: add compact CQE Rx path and ptype table
Date: Sat, 10 Oct 2026 22:45:03 +0800
Message-ID: <20261010144509.2731-13-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261010144509.2731-1-yejiacheng4@h-partners.com>
References: <20261010144509.2731-1-yejiacheng4@h-partners.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: As8vCgDX70B4T8pqMdk9Aw--.440S14
X-Coremail-Antispam: 1Uf129KBjvAXoWDGFyftFykJFW3uw4DJFykuFg_yoWrZw1DKo
 WfXr1ayrn3tr1xCrWjgrn7uFWDArWDZwsYy3909a92q3W7Xry5tF9xJw1rJFy0qa93CF1x
 AF93t39rKwsrX34Dn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU2SdgDUUUU
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiMh5ASmrKT34nxwAA3X
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

Add a precomputed ptype table and a compact CQE Rx burst function, and=0D
select the Rx path from the rx_cqe_compact_en runtime parameter.=0D
=0D
Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>=0D
---=0D
 doc/guides/rel_notes/release_26_11.rst   |   1 +=0D
 drivers/net/hinic3/base/hinic3_nic_cfg.h |   2 +=0D
 drivers/net/hinic3/hinic3_ethdev.c       | 105 +++--=0D
 drivers/net/hinic3/hinic3_ethdev.h       |   8 +-=0D
 drivers/net/hinic3/hinic3_rx.c           | 574 +++++++++++++++++++----=0D
 drivers/net/hinic3/hinic3_rx.h           | 217 ++++-----=0D
 6 files changed, 661 insertions(+), 246 deletions(-)=0D
=0D
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/=
release_26_11.rst=0D
index d4cc028120..a8a1641d2a 100644=0D
--- a/doc/guides/rel_notes/release_26_11.rst=0D
+++ b/doc/guides/rel_notes/release_26_11.rst=0D
@@ -100,6 +100,7 @@ New Features=0D
   * Updated RSS hash type configuration.=0D
   * Added support for the SP560 NIC.=0D
   * Added device parameters for runtime configuration.=0D
+  * Added a compact CQE receive data path.=0D
 =0D
 * **Updated Intel iavf driver.**=0D
 =0D
diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.h b/drivers/net/hinic3/=
base/hinic3_nic_cfg.h=0D
index 0de8179c19..21ea74e44d 100644=0D
--- a/drivers/net/hinic3/base/hinic3_nic_cfg.h=0D
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.h=0D
@@ -63,6 +63,8 @@=0D
 	((hinic3_get_driver_feature(dev) & NIC_F_##feature) !=3D 0)=0D
 #define HINIC3_SUPPORT_RX_HW_COMPACT_CQE(dev) \=0D
 	HINIC3_SUPPORT_FEATURE(dev, RX_HW_COMPACT_CQE)=0D
+#define HINIC3_SUPPORT_RX_SW_COMPACT_CQE(dev) \=0D
+	HINIC3_SUPPORT_FEATURE(dev, RX_SW_COMPACT_CQE)=0D
 #define HINIC3_SUPPORT_TX_WQE_COMPACT_TASK(dev) \=0D
 	HINIC3_SUPPORT_FEATURE(dev, TX_WQE_COMPACT_TASK)=0D
 #define HINIC3_SUPPORT_VXLAN_OFFLOAD(dev) \=0D
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3=
_ethdev.c=0D
index e5749ec718..b272d42007 100644=0D
--- a/drivers/net/hinic3/hinic3_ethdev.c=0D
+++ b/drivers/net/hinic3/hinic3_ethdev.c=0D
@@ -1162,11 +1162,13 @@ hinic3_rx_queue_setup(struct rte_eth_dev *dev, uint=
16_t qid, uint16_t nb_desc,=0D
 =0D
 	nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);=0D
 =0D
-	/* Queue depth must be equal to queue 0 */=0D
-	if (qid !=3D 0 && nb_desc !=3D nic_dev->rxqs[0]->q_depth) {=0D
-		PMD_DRV_LOG(WARNING, "rxq%u depth:%u is not equal to queue0 depth:%u.",=
=0D
-			    qid, nb_desc, nic_dev->rxqs[0]->q_depth);=0D
-		nb_desc =3D nic_dev->rxqs[0]->q_depth;=0D
+	/* Queue depth must be equal to first queue */=0D
+	if (nic_dev->rxq_depth =3D=3D 0) {=0D
+		nic_dev->rxq_depth =3D nb_desc;=0D
+	} else if (nb_desc !=3D nic_dev->rxq_depth) {=0D
+		PMD_DRV_LOG(WARNING, "rxq%u depth:%u is not equal to first queue depth:%=
u.",=0D
+			    qid, nb_desc, nic_dev->rxq_depth);=0D
+		nb_desc =3D nic_dev->rxq_depth;=0D
 	}=0D
 =0D
 	/* Queue depth must be power of 2, otherwise will be aligned up. */=0D
@@ -1229,6 +1231,7 @@ hinic3_rx_queue_setup(struct rte_eth_dev *dev, uint16=
_t qid, uint16_t nb_desc,=0D
 	rxq->port_id =3D dev->data->port_id;=0D
 	rxq->wait_time_cycle =3D HINIC3_RX_WAIT_CYCLE_THRESH;=0D
 	rxq->rx_deferred_start =3D rx_conf->rx_deferred_start;=0D
+	rxq->rx_empty_loop =3D nic_dev->config.rx_empty_loop;=0D
 	/* If buf_len used for function table, need to translated. */=0D
 	rx_buf_size =3D rte_pktmbuf_data_room_size(rxq->mb_pool) - RTE_PKTMBUF_HE=
ADROOM;=0D
 	err =3D hinic3_convert_rx_buf_size(rx_buf_size, &buf_size);=0D
@@ -1239,7 +1242,7 @@ hinic3_rx_queue_setup(struct rte_eth_dev *dev, uint16=
_t qid, uint16_t nb_desc,=0D
 	}=0D
 =0D
 	/* If NIC support compact CQE, use compact wqe as default. */=0D
-	if (HINIC3_SUPPORT_RX_HW_COMPACT_CQE(nic_dev)) {=0D
+	if (nic_dev->config.rx_cqe_compact_en) {=0D
 		rxq->wqe_type =3D HINIC3_COMPACT_RQ_WQE;=0D
 	} else {=0D
 		if (buf_size >=3D HINIC3_RX_BUF_SIZE_4K &&=0D
@@ -1299,7 +1302,7 @@ hinic3_rx_queue_setup(struct rte_eth_dev *dev, uint16=
_t qid, uint16_t nb_desc,=0D
 		goto alloc_rx_info_fail;=0D
 	}=0D
 =0D
-	if (HINIC3_SUPPORT_RX_HW_COMPACT_CQE(nic_dev)) {=0D
+	if (nic_dev->config.rx_cqe_compact_en) {=0D
 		ci_mz =3D hinic3_dma_zone_reserve(dev, "hinic3_ci_mz", qid,=0D
 						sizeof(*rxq->rq_ci),=0D
 						RTE_CACHE_LINE_SIZE, (int)socket_id);=0D
@@ -1351,6 +1354,7 @@ hinic3_rx_queue_setup(struct rte_eth_dev *dev, uint16=
_t qid, uint16_t nb_desc,=0D
 	hinic3_memzone_free(rxq->rq_mz);=0D
 =0D
 alloc_rq_mz_fail:=0D
+	rxq->db_addr =3D NULL;=0D
 alloc_db_err_fail:=0D
 	hinic3_memzone_free(rxq->pi_mz);=0D
 =0D
@@ -1536,7 +1540,7 @@ hinic3_rx_queue_release(struct rte_eth_dev *dev, uint=
16_t queue_id)=0D
 =0D
 	hinic3_free_rxq_mbufs(rxq);=0D
 =0D
-	if (HINIC3_SUPPORT_RX_HW_COMPACT_CQE(nic_dev))=0D
+	if (nic_dev->config.rx_cqe_compact_en)=0D
 		hinic3_memzone_free(rxq->ci_mz);=0D
 	else=0D
 		hinic3_memzone_free(rxq->cqe_mz);=0D
@@ -1699,6 +1703,9 @@ hinic3_dev_rx_queue_intr_enable(struct rte_eth_dev *d=
ev, uint16_t queue_id)=0D
 	if (!rte_intr_dp_is_en(intr_handle) || !intr_handle->intr_vec)=0D
 		return 0;=0D
 =0D
+	if (HINIC3_IS_SP230_NIC(nic_dev) && !dev->data->dev_conf.intr_conf.rxq)=0D
+		return 0;=0D
+=0D
 	msix_intr =3D (uint16_t)intr_handle->intr_vec[queue_id];=0D
 	hinic3_set_msix_auto_mask_state(nic_dev->hwdev, msix_intr,=0D
 					HINIC3_SET_MSIX_AUTO_MASK);=0D
@@ -2003,7 +2010,8 @@ hinic3_init_rxq_intr(struct rte_eth_dev *dev)=0D
 =0D
 	intr_handle =3D dev->intr_handle;=0D
 	nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);=0D
-	if (!dev->data->dev_conf.intr_conf.rxq)=0D
+=0D
+	if (!HINIC3_IS_SP230_NIC(nic_dev) && !dev->data->dev_conf.intr_conf.rxq)=
=0D
 		return 0;=0D
 =0D
 	if (!rte_intr_cap_multiple(intr_handle)) {=0D
@@ -2289,6 +2297,8 @@ hinic3_dev_stop(struct rte_eth_dev *dev)=0D
 =0D
 	/* Free mempool. */=0D
 	hinic3_copy_mempool_uninit(nic_dev);=0D
+=0D
+	nic_dev->rxq_depth =3D 0;=0D
 	return 0;=0D
 }=0D
 =0D
@@ -2326,6 +2336,8 @@ hinic3_dev_release(struct rte_eth_dev *eth_dev)=0D
 =0D
 	rte_free(nic_dev->hwdev);=0D
 	nic_dev->hwdev =3D NULL;=0D
+	rte_free(nic_dev->ptype_tbl);=0D
+	nic_dev->ptype_tbl =3D NULL;=0D
 }=0D
 =0D
 /**=0D
@@ -3300,6 +3312,32 @@ hinic3_dev_xstats_get_names(struct rte_eth_dev *dev,=
=0D
 	return count;=0D
 }=0D
 =0D
+static const uint32_t *=0D
+hinic3_dev_supported_ptypes_get(__rte_unused struct rte_eth_dev *dev, size=
_t *no_of_elements)=0D
+{=0D
+	static const uint32_t ptypes[] =3D {=0D
+		RTE_PTYPE_L3_IPV4_EXT_UNKNOWN,=0D
+		RTE_PTYPE_L3_IPV6_EXT_UNKNOWN,=0D
+		RTE_PTYPE_L4_TCP,=0D
+		RTE_PTYPE_L4_UDP,=0D
+		RTE_PTYPE_L4_SCTP,=0D
+		RTE_PTYPE_L4_NONFRAG,=0D
+		RTE_PTYPE_TUNNEL_IP,=0D
+		RTE_PTYPE_TUNNEL_GRE,=0D
+		RTE_PTYPE_TUNNEL_VXLAN,=0D
+		RTE_PTYPE_TUNNEL_VXLAN_GPE,=0D
+		RTE_PTYPE_TUNNEL_GENEVE,=0D
+		RTE_PTYPE_INNER_L3_IPV4_EXT_UNKNOWN,=0D
+		RTE_PTYPE_INNER_L3_IPV6_EXT_UNKNOWN,=0D
+		RTE_PTYPE_INNER_L4_TCP,=0D
+		RTE_PTYPE_INNER_L4_UDP,=0D
+		RTE_PTYPE_INNER_L4_SCTP,=0D
+		RTE_PTYPE_INNER_L4_NONFRAG,=0D
+	};=0D
+	*no_of_elements =3D RTE_DIM(ptypes);=0D
+	return ptypes;=0D
+}=0D
+=0D
 static void=0D
 hinic3_rxq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,=0D
 		    struct rte_eth_rxq_info *qinfo)=0D
@@ -3611,6 +3649,7 @@ hinic3_fec_capability_get(struct rte_eth_dev *dev,=0D
 static const struct eth_dev_ops hinic3_pmd_ops =3D {=0D
 	.dev_configure                 =3D hinic3_dev_configure,=0D
 	.dev_infos_get                 =3D hinic3_dev_infos_get,=0D
+	.dev_supported_ptypes_get      =3D hinic3_dev_supported_ptypes_get,=0D
 	.fw_version_get                =3D hinic3_fw_version_get,=0D
 	.dev_set_link_up               =3D hinic3_dev_set_link_up,=0D
 	.dev_set_link_down             =3D hinic3_dev_set_link_down,=0D
@@ -3662,6 +3701,7 @@ static const struct eth_dev_ops hinic3_pmd_ops =3D {=
=0D
 static const struct eth_dev_ops hinic3_pmd_vf_ops =3D {=0D
 	.dev_configure                 =3D hinic3_dev_configure,=0D
 	.dev_infos_get                 =3D hinic3_dev_infos_get,=0D
+	.dev_supported_ptypes_get      =3D hinic3_dev_supported_ptypes_get,=0D
 	.fw_version_get                =3D hinic3_fw_version_get,=0D
 	.dev_set_link_up               =3D hinic3_dev_set_link_up,=0D
 	.dev_set_link_down             =3D hinic3_dev_set_link_down,=0D
@@ -3713,16 +3753,6 @@ static void hinic3_nic_tx_rx_ops_init(struct hinic3_=
nic_dev *nic_dev)=0D
 		nic_dev->tx_ops->nic_tx_set_wqe_offload =3D hinic3_tx_set_compact_task_o=
ffload;=0D
 	else=0D
 		nic_dev->tx_ops->nic_tx_set_wqe_offload =3D hinic3_tx_set_normal_task_of=
fload;=0D
-=0D
-	if (HINIC3_SUPPORT_RX_HW_COMPACT_CQE(nic_dev)) {=0D
-		nic_dev->rx_ops->nic_rx_get_cqe_info =3D hinic3_rx_get_compact_cqe_info;=
=0D
-		nic_dev->rx_ops->nic_rx_cqe_done =3D hinic3_rx_integrated_cqe_done;=0D
-		nic_dev->rx_ops->nic_rx_poll_rq_empty =3D hinic3_poll_integrated_cqe_rq_=
empty;=0D
-	} else {=0D
-		nic_dev->rx_ops->nic_rx_get_cqe_info =3D hinic3_rx_get_cqe_info;=0D
-		nic_dev->rx_ops->nic_rx_cqe_done =3D hinic3_rx_separate_cqe_done;=0D
-		nic_dev->rx_ops->nic_rx_poll_rq_empty =3D hinic3_poll_rq_empty;=0D
-	}=0D
 }=0D
 =0D
 /**=0D
@@ -3774,13 +3804,6 @@ hinic3_func_init(struct rte_eth_dev *eth_dev)=0D
 		goto alloc_eth_addr_fail;=0D
 	}=0D
 =0D
-	nic_dev->rx_ops =3D rte_zmalloc("rx_ops", sizeof(struct hinic3_nic_rx_ops=
), 0);=0D
-	if (!nic_dev->rx_ops) {=0D
-		PMD_DRV_LOG(ERR, "Allocate rx_ops memory failed");=0D
-		err =3D -ENOMEM;=0D
-		goto alloc_rx_ops_fail;=0D
-	}=0D
-=0D
 	nic_dev->tx_ops =3D rte_zmalloc("tx_ops", sizeof(struct hinic3_nic_tx_ops=
), 0);=0D
 	if (!nic_dev->tx_ops) {=0D
 		PMD_DRV_LOG(ERR, "Allocate tx_ops memory failed");=0D
@@ -3891,6 +3914,11 @@ hinic3_func_init(struct rte_eth_dev *eth_dev)=0D
 			    eth_dev->data->name);=0D
 		goto enable_intr_fail;=0D
 	}=0D
+=0D
+	err =3D hinic3_init_rx_ptype_table(eth_dev);=0D
+	if (err)=0D
+		PMD_DRV_LOG(ERR, "Failed to create ptype_table.");=0D
+=0D
 	tcam_info =3D &nic_dev->tcam;=0D
 	memset(tcam_info, 0, sizeof(struct hinic3_tcam_info));=0D
 	TAILQ_INIT(&tcam_info->tcam_list);=0D
@@ -3944,10 +3972,6 @@ hinic3_func_init(struct rte_eth_dev *eth_dev)=0D
 	nic_dev->tx_ops =3D NULL;=0D
 =0D
 alloc_tx_ops_fail:=0D
-	rte_free(nic_dev->rx_ops);=0D
-	nic_dev->rx_ops =3D NULL;=0D
-=0D
-alloc_rx_ops_fail:=0D
 	rte_free(eth_dev->data->mac_addrs);=0D
 	eth_dev->data->mac_addrs =3D NULL;=0D
 =0D
@@ -4043,6 +4067,19 @@ hinic3_nic_common_config_get(struct rte_pci_device *=
pci_dev,=0D
 	return ret;=0D
 }=0D
 =0D
+static void hinic3_nic_feature_init(struct hinic3_nic_dev *nic_dev)=0D
+{=0D
+	if ((HINIC3_SUPPORT_RX_HW_COMPACT_CQE(nic_dev) ||=0D
+	     HINIC3_SUPPORT_RX_SW_COMPACT_CQE(nic_dev)) &&=0D
+	    nic_dev->config.rx_cqe_compact_en =3D=3D HINIC3_RX_CQE_COMPACT_EN) {=
=0D
+		nic_dev->config.rx_cqe_compact_en =3D HINIC3_RX_CQE_COMPACT_EN;=0D
+		PMD_DRV_LOG(INFO, "nic compact_cqe is on.");=0D
+	} else {=0D
+		nic_dev->config.rx_cqe_compact_en =3D 0;=0D
+		PMD_DRV_LOG(INFO, "nic compact_cqe is off.");=0D
+	}=0D
+}=0D
+=0D
 static int=0D
 hinic3_dev_init(struct rte_eth_dev *eth_dev)=0D
 {=0D
@@ -4072,7 +4109,13 @@ hinic3_dev_init(struct rte_eth_dev *eth_dev)=0D
 		return err;=0D
 	}=0D
 =0D
-	eth_dev->rx_pkt_burst =3D hinic3_recv_pkts;=0D
+	hinic3_nic_feature_init(nic_dev);=0D
+=0D
+	if (nic_dev->config.rx_cqe_compact_en !=3D HINIC3_RX_CQE_COMPACT_EN)=0D
+		eth_dev->rx_pkt_burst =3D hinic3_recv_pkts;=0D
+	else=0D
+		eth_dev->rx_pkt_burst =3D hinic3_recv_pkts_compact_cqe;=0D
+=0D
 	eth_dev->tx_pkt_burst =3D hinic3_xmit_pkts;=0D
 =0D
 	return err;=0D
diff --git a/drivers/net/hinic3/hinic3_ethdev.h b/drivers/net/hinic3/hinic3=
_ethdev.h=0D
index 8191564fb8..41f6738645 100644=0D
--- a/drivers/net/hinic3/hinic3_ethdev.h=0D
+++ b/drivers/net/hinic3/hinic3_ethdev.h=0D
@@ -117,6 +117,11 @@ enum nic_feature_cap {=0D
 TAILQ_HEAD(hinic3_ethertype_filter_list, rte_flow);=0D
 TAILQ_HEAD(hinic3_fdir_rule_filter_list, rte_flow);=0D
 =0D
+#define HINIC3_PTYPE_NUM 4096=0D
+struct hinic3_ptype_table {=0D
+	alignas(RTE_CACHE_LINE_SIZE) uint32_t ptype[HINIC3_PTYPE_NUM];=0D
+};=0D
+=0D
 struct hinic3_nic_common_dev_config {=0D
 	unsigned int rx_empty_threshold; /**< consecutive empty RX polls; skip RX=
 if exceeded */=0D
 	unsigned int rx_empty_loop; /**< max empty CQE spin count; 0 =3D no limit=
 */=0D
@@ -146,6 +151,7 @@ struct hinic3_nic_dev {=0D
 	uint16_t max_sqs;=0D
 	uint16_t max_rqs;=0D
 =0D
+	uint16_t rxq_depth;=0D
 	uint16_t rx_buff_len;=0D
 	uint16_t mtu_size;=0D
 =0D
@@ -182,7 +188,7 @@ struct hinic3_nic_dev {=0D
 	struct hinic3_ethertype_filter_list filter_ethertype_list;=0D
 	struct hinic3_fdir_rule_filter_list filter_fdir_rule_list;=0D
 	uint8_t cos_map[HINIC3_COS_NUM_MAX];=0D
-	struct hinic3_nic_rx_ops *rx_ops;=0D
+	struct hinic3_ptype_table *ptype_tbl;=0D
 	struct hinic3_nic_tx_ops *tx_ops;=0D
 	uint32_t fec_mode;  /**< Current FEC mode for ethdev. */=0D
 	enum nic_type nic_type; /**< NIC type. */=0D
diff --git a/drivers/net/hinic3/hinic3_rx.c b/drivers/net/hinic3/hinic3_rx.=
c=0D
index 493855b431..fdf41a62ea 100644=0D
--- a/drivers/net/hinic3/hinic3_rx.c=0D
+++ b/drivers/net/hinic3/hinic3_rx.c=0D
@@ -1,16 +1,248 @@=0D
 /* SPDX-License-Identifier: BSD-3-Clause=0D
  * Copyright(c) 2025 Huawei Technologies Co., Ltd=0D
  */=0D
+#include <rte_ether.h>=0D
+#include <rte_mbuf.h>=0D
 =0D
 #include "base/hinic3_compat.h"=0D
 #include "base/hinic3_hwif.h"=0D
 #include "base/hinic3_hwdev.h"=0D
 #include "base/hinic3_wq.h"=0D
+#include "base/hinic3_mgmt.h"=0D
 #include "base/hinic3_nic_cfg.h"=0D
 #include "hinic3_nic_io.h"=0D
 #include "hinic3_ethdev.h"=0D
+#include "hinic3_tx.h"=0D
 #include "hinic3_rx.h"=0D
 =0D
+static uint32_t=0D
+hinic3_get_l3_ptype(uint32_t ip_type)=0D
+{=0D
+	uint32_t ptype =3D 0;=0D
+	if (ip_type =3D=3D IPSU_METADATA_L3_TP_IPV4)=0D
+		ptype |=3D RTE_PTYPE_L3_IPV4_EXT_UNKNOWN;=0D
+	else if (ip_type =3D=3D IPSU_METADATA_L3_TP_IPV6)=0D
+		ptype |=3D RTE_PTYPE_L3_IPV6_EXT_UNKNOWN;=0D
+	return ptype;=0D
+}=0D
+static uint32_t=0D
+hinic3_get_l4_ptype(uint32_t packet_type)=0D
+{=0D
+	int ptype =3D 0;=0D
+	switch (packet_type) {=0D
+	case IPSU_PKT_TYPE_NULL:=0D
+		break;=0D
+	case IPSU_PKT_TYPE_TCP:=0D
+		ptype |=3D RTE_PTYPE_L4_TCP;=0D
+		break;=0D
+	case IPSU_PKT_TYPE_UDP:=0D
+		ptype |=3D RTE_PTYPE_L4_UDP;=0D
+		break;=0D
+	case IPSU_PKT_TYPE_IPV4_FRAG:=0D
+		ptype |=3D RTE_PTYPE_L4_FRAG;=0D
+		break;=0D
+	case IPSU_PKT_TYPE_SCTP:=0D
+		ptype |=3D RTE_PTYPE_L4_SCTP;=0D
+		break;=0D
+	case IPSU_PKT_TYPE_ICMP:=0D
+		ptype |=3D RTE_PTYPE_L4_ICMP;=0D
+		break;=0D
+	case IPSU_PKT_TYPE_IGMP:=0D
+		ptype |=3D RTE_PTYPE_L4_IGMP;=0D
+		break;=0D
+	case IPSU_PKT_TYPE_ESP_OVER_IP:=0D
+		ptype |=3D RTE_PTYPE_L4_ESP;=0D
+		break;=0D
+	default:=0D
+		ptype |=3D RTE_PTYPE_L4_NONFRAG;=0D
+	}=0D
+	return ptype;=0D
+}=0D
+=0D
+/**=0D
+ * Calculate the ptype value of given offload type.=0D
+ *=0D
+ * @param[in] offload_type=0D
+ *   The offload of Packet=0D
+ * @return=0D
+ *   Ptype value=0D
+ */=0D
+static uint32_t=0D
+hinic3_calc_rx_ptype_table(uint32_t offload_type, struct hinic3_nic_dev *n=
ic_dev)=0D
+{=0D
+	uint32_t packet_type, ip_type, enc_l3_type, pkt_fmt;=0D
+	uint32_t ptype =3D RTE_PTYPE_UNKNOWN;=0D
+=0D
+	packet_type =3D HINIC3_GET_RX_PKT_TYPE(offload_type);=0D
+	ip_type =3D HINIC3_GET_RX_IP_TYPE(offload_type);=0D
+	enc_l3_type =3D HINIC3_GET_RX_ENC_L3_TYPE(offload_type);=0D
+	pkt_fmt =3D HINIC3_GET_RX_PKT_FORMAT(offload_type);=0D
+=0D
+	switch (pkt_fmt) {=0D
+	case IPSU_METADATA_FMT_NO_ENC:=0D
+		ptype |=3D RTE_PTYPE_L2_ETHER;=0D
+		ptype |=3D hinic3_get_l3_ptype(ip_type);=0D
+		ptype |=3D hinic3_get_l4_ptype(packet_type);=0D
+		break;=0D
+	case IPSU_METADATA_FMT_FC:=0D
+		ptype |=3D RTE_PTYPE_L2_ETHER_FCOE;=0D
+		break;=0D
+	case IPSU_METADATA_FMT_NSH:=0D
+		ptype |=3D RTE_PTYPE_L2_ETHER_NSH;=0D
+		break;=0D
+	/* IPinIP */=0D
+	case IPSU_METADATA_FMT_IPIP:=0D
+		ptype |=3D RTE_PTYPE_L2_ETHER;=0D
+		ptype |=3D RTE_PTYPE_TUNNEL_IP;=0D
+		if (!(nic_dev->feature_cap & NIC_F_TX_WQE_COMPACT_TASK)) {=0D
+			ptype |=3D hinic3_get_l3_ptype(ip_type);=0D
+		} else {=0D
+			ptype |=3D hinic3_get_l3_ptype(enc_l3_type);=0D
+			ptype |=3D hinic3_get_l4_ptype(packet_type) << HINIC3_L4_PYTPE_SHIFT;=0D
+			if (ip_type =3D=3D IPSU_METADATA_L3_TP_IPV4)=0D
+				ptype |=3D RTE_PTYPE_INNER_L3_IPV4_EXT_UNKNOWN;=0D
+			else if (ip_type =3D=3D IPSU_METADATA_L3_TP_IPV6)=0D
+				ptype |=3D RTE_PTYPE_INNER_L3_IPV6_EXT_UNKNOWN;=0D
+		}=0D
+		break;=0D
+	default:=0D
+	/* VXLAN =E3=80=81NVGRE =E3=80=81VXLAN_GPE =E3=80=81GENEVE*/=0D
+		ptype |=3D RTE_PTYPE_L2_ETHER;=0D
+		ptype |=3D hinic3_get_l3_ptype(enc_l3_type);=0D
+=0D
+		switch (pkt_fmt) {=0D
+		case IPSU_METADATA_FMT_VXLAN:=0D
+			ptype |=3D RTE_PTYPE_L4_UDP;=0D
+			ptype |=3D RTE_PTYPE_TUNNEL_VXLAN;=0D
+			ptype |=3D RTE_PTYPE_INNER_L2_ETHER;=0D
+			break;=0D
+		case IPSU_METADATA_FMT_NVGRE:=0D
+			ptype |=3D RTE_PTYPE_TUNNEL_GRE;=0D
+			if (!HINIC3_IS_SP560_NIC(nic_dev))=0D
+				return ptype;=0D
+			break;=0D
+		case IPSU_METADATA_FMT_GPE:=0D
+			ptype |=3D RTE_PTYPE_L4_UDP;=0D
+			ptype |=3D RTE_PTYPE_TUNNEL_VXLAN_GPE;=0D
+			break;=0D
+		case IPSU_METADATA_FMT_GENEVE:=0D
+			ptype |=3D RTE_PTYPE_L4_UDP;=0D
+			ptype |=3D RTE_PTYPE_TUNNEL_GENEVE;=0D
+			ptype |=3D RTE_PTYPE_INNER_L2_ETHER;=0D
+			break;=0D
+		default:=0D
+			ptype |=3D RTE_PTYPE_L4_NONFRAG;=0D
+			break;=0D
+		}=0D
+		if (ip_type =3D=3D IPSU_METADATA_L3_TP_IPV4)=0D
+			ptype |=3D RTE_PTYPE_INNER_L3_IPV4_EXT_UNKNOWN;=0D
+		else if (ip_type =3D=3D IPSU_METADATA_L3_TP_IPV6)=0D
+			ptype |=3D RTE_PTYPE_INNER_L3_IPV6_EXT_UNKNOWN;=0D
+		else=0D
+			return ptype;=0D
+		/* shift ptype to inner*/=0D
+		ptype |=3D hinic3_get_l4_ptype(packet_type) << HINIC3_L4_PYTPE_SHIFT;=0D
+	}=0D
+	return ptype;=0D
+}=0D
+=0D
+static uint32_t=0D
+hinic3_calc_rx_ptype_compact_table(uint32_t offload_type)=0D
+{=0D
+	uint32_t packet_type, ip_type, pkt_fmt;=0D
+	uint32_t ptype =3D RTE_PTYPE_UNKNOWN;=0D
+=0D
+	pkt_fmt =3D HINIC3_RQ_COMPACT_CQE_STATUS_GET(offload_type << HINIC3_COMPA=
CT_CQE_PTYPE_SHIFT,=0D
+						   PKT_FORMAT);=0D
+	ip_type =3D HINIC3_RQ_COMPACT_CQE_STATUS_GET(offload_type << HINIC3_COMPA=
CT_CQE_PTYPE_SHIFT,=0D
+						   IP_TYPE);=0D
+	packet_type =3D HINIC3_RQ_COMPACT_CQE_STATUS_GET(offload_type <<=0D
+							HINIC3_COMPACT_CQE_PTYPE_SHIFT,=0D
+							PKT_TYPE);=0D
+=0D
+	switch (pkt_fmt) {=0D
+	case IPSU_METADATA_FMT_NO_ENC:=0D
+		ptype |=3D RTE_PTYPE_L2_ETHER;=0D
+		ptype |=3D hinic3_get_l3_ptype(ip_type);=0D
+		ptype |=3D hinic3_get_l4_ptype(packet_type);=0D
+		break;=0D
+	case IPSU_METADATA_FMT_FC:=0D
+		ptype |=3D RTE_PTYPE_L2_ETHER_FCOE;=0D
+		break;=0D
+	case IPSU_METADATA_FMT_NSH:=0D
+		ptype |=3D RTE_PTYPE_L2_ETHER_NSH;=0D
+		break;=0D
+	default:=0D
+	/* VXLAN =E3=80=81NVGRE =E3=80=81VXLAN_GPE =E3=80=81GENEVE =E3=80=81IPinI=
P */=0D
+		ptype |=3D RTE_PTYPE_L2_ETHER;=0D
+=0D
+		switch (pkt_fmt) {=0D
+		case IPSU_METADATA_FMT_VXLAN:=0D
+			ptype |=3D RTE_PTYPE_L4_UDP;=0D
+			ptype |=3D RTE_PTYPE_TUNNEL_VXLAN;=0D
+			ptype |=3D RTE_PTYPE_INNER_L2_ETHER;=0D
+			break;=0D
+		case IPSU_METADATA_FMT_NVGRE:=0D
+			ptype |=3D RTE_PTYPE_TUNNEL_GRE;=0D
+			return ptype;=0D
+		case IPSU_METADATA_FMT_GENEVE:=0D
+			ptype |=3D RTE_PTYPE_L4_UDP;=0D
+			ptype |=3D RTE_PTYPE_TUNNEL_GENEVE;=0D
+			ptype |=3D RTE_PTYPE_INNER_L2_ETHER;=0D
+			break;=0D
+=0D
+		case IPSU_METADATA_FMT_IPIP:=0D
+			ptype |=3D RTE_PTYPE_TUNNEL_IP;=0D
+			break;=0D
+		default:=0D
+			ptype |=3D RTE_PTYPE_L4_NONFRAG;=0D
+			break;=0D
+		}=0D
+		if (ip_type =3D=3D IPSU_METADATA_L3_TP_IPV4)=0D
+			ptype |=3D RTE_PTYPE_INNER_L3_IPV4_EXT_UNKNOWN;=0D
+		else if (ip_type =3D=3D IPSU_METADATA_L3_TP_IPV6)=0D
+			ptype |=3D RTE_PTYPE_INNER_L3_IPV6_EXT_UNKNOWN;=0D
+		else=0D
+			return ptype;=0D
+		/* shift ptype to inner*/=0D
+		ptype |=3D hinic3_get_l4_ptype(packet_type) << HINIC3_L4_PYTPE_SHIFT;=0D
+	}=0D
+	return ptype;=0D
+}=0D
+=0D
+/**=0D
+ * Get receive queue local ci=0D
+ *=0D
+ * @param[in] rxq=0D
+ *   Receive queue=0D
+ * @return=0D
+ *   Receive queue local ci=0D
+ */=0D
+static inline uint16_t hinic3_get_rq_local_ci(struct hinic3_rxq *rxq)=0D
+{=0D
+	return MASKED_QUEUE_IDX(rxq, rxq->cons_idx);=0D
+}=0D
+=0D
+static inline uint16_t hinic3_get_rq_free_wqebb(struct hinic3_rxq *rxq)=0D
+{=0D
+	return rxq->delta - 1;=0D
+}=0D
+=0D
+/**=0D
+ * Update receive queue local ci=0D
+ *=0D
+ * @param[in] rxq=0D
+ *   Receive queue=0D
+ * @param[in] wqe_cnt=0D
+ *   Wqebb counters=0D
+ */=0D
+static inline void hinic3_update_rq_local_ci(struct hinic3_rxq *rxq,=0D
+					     uint16_t wqe_cnt)=0D
+{=0D
+	rxq->cons_idx +=3D wqe_cnt;=0D
+	rxq->delta +=3D wqe_cnt;=0D
+}=0D
+=0D
 /**=0D
  * Get wqe from receive queue.=0D
  *=0D
@@ -62,6 +294,13 @@ hinic3_get_rq_local_pi(struct hinic3_rxq *rxq)=0D
 	return MASKED_QUEUE_IDX(rxq, rxq->prod_idx);=0D
 }=0D
 =0D
+static inline uint16_t hinic3_get_rq_hw_ci(struct hinic3_rxq *rxq)=0D
+{=0D
+	struct hinic3_rq_ci_wb rq_ci;=0D
+	rq_ci.dw1.value =3D hinic3_hw_cpu32(rte_read32(&rxq->rq_ci->dw1.value));=
=0D
+	return rq_ci.dw1.bs.hw_ci;=0D
+}=0D
+=0D
 uint16_t=0D
 hinic3_rx_fill_wqe(struct hinic3_rxq *rxq)=0D
 {=0D
@@ -434,11 +673,11 @@ hinic3_init_rss_type(struct hinic3_nic_dev *nic_dev,=
=0D
 	rss_type.ipv4 =3D (rss_hf & (RTE_ETH_RSS_IPV4 | RTE_ETH_RSS_FRAG_IPV4)) ?=
 1 : 0;=0D
 	rss_type.tcp_ipv4 =3D (rss_hf & RTE_ETH_RSS_NONFRAG_IPV4_TCP) ? 1 : 0;=0D
 	rss_type.ipv6 =3D (rss_hf & (RTE_ETH_RSS_IPV6 | RTE_ETH_RSS_FRAG_IPV6)) ?=
 1 : 0;=0D
+	rss_type.ipv6_ext =3D (rss_hf & RTE_ETH_RSS_IPV6_EX) ? 1 : 0;=0D
 	rss_type.tcp_ipv6 =3D (rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_TCP) ? 1 : 0;=0D
+	rss_type.tcp_ipv6_ext =3D (rss_hf & RTE_ETH_RSS_IPV6_TCP_EX) ? 1 : 0;=0D
 	rss_type.udp_ipv4 =3D (rss_hf & RTE_ETH_RSS_NONFRAG_IPV4_UDP) ? 1 : 0;=0D
 	rss_type.udp_ipv6 =3D (rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_UDP) ? 1 : 0;=0D
-	rss_type.ipv6_ext =3D (rss_hf & RTE_ETH_RSS_IPV6_EX) ? 1 : 0;=0D
-	rss_type.tcp_ipv6_ext =3D (rss_hf & RTE_ETH_RSS_IPV6_TCP_EX) ? 1 : 0;=0D
 =0D
 	err =3D hinic3_set_rss_type(nic_dev->hwdev, rss_type);=0D
 	nic_dev->rss_type =3D rss_type;=0D
@@ -503,6 +742,36 @@ hinic3_update_rss_config(struct rte_eth_dev *dev,=0D
 	return err;=0D
 }=0D
 =0D
+/**=0D
+ * Initialize the receive packet type table=0D
+ * @param[in] dev=0D
+ *   Pointer to ethernet device structure.=0D
+ */=0D
+=0D
+int=0D
+hinic3_init_rx_ptype_table(struct rte_eth_dev *dev)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	struct hinic3_ptype_table *tbl =3D=0D
+		rte_zmalloc("ptype_tbl", sizeof(struct hinic3_ptype_table), 0);=0D
+=0D
+	if (tbl =3D=3D NULL)=0D
+		return -ENOMEM;=0D
+=0D
+	uint32_t *ptype =3D tbl->ptype;=0D
+	uint32_t i;=0D
+=0D
+	if (nic_dev->config.rx_cqe_compact_en) {=0D
+		for (i =3D 0; i < HINIC3_PTYPE_NUM; i++)=0D
+			ptype[i] =3D hinic3_calc_rx_ptype_compact_table(i);=0D
+	} else {=0D
+		for (i =3D 0; i < HINIC3_PTYPE_NUM; i++)=0D
+			ptype[i] =3D hinic3_calc_rx_ptype_table(i, nic_dev);=0D
+	}=0D
+	nic_dev->ptype_tbl =3D tbl;=0D
+	return 0;=0D
+}=0D
+=0D
 /**=0D
  * Search given queue array to find position of given id.=0D
  * Return queue pos or queue_count if not found.=0D
@@ -599,7 +868,7 @@ hinic3_rx_queue_release_mbufs(struct hinic3_rxq *rxq)=0D
 	hinic3_update_rq_local_ci(rxq, nr_released);=0D
 }=0D
 =0D
-int=0D
+static int=0D
 hinic3_poll_rq_empty(struct hinic3_rxq *rxq)=0D
 {=0D
 	uint64_t end;=0D
@@ -620,29 +889,21 @@ hinic3_poll_rq_empty(struct hinic3_rxq *rxq)=0D
 	return err;=0D
 }=0D
 =0D
-int=0D
+static int=0D
 hinic3_poll_integrated_cqe_rq_empty(struct hinic3_rxq *rxq)=0D
 {=0D
 	struct hinic3_rx_info *rx_info;=0D
-	struct hinic3_rq_ci_wb rq_ci;=0D
-	uint16_t sw_ci;=0D
-	uint16_t hw_ci;=0D
-	uint32_t val;=0D
+	uint16_t sw_ci, sw_pi, hw_ci;=0D
+	uint64_t end;=0D
 =0D
 	sw_ci =3D hinic3_get_rq_local_ci(rxq);=0D
-	val =3D rte_read32(&rxq->rq_ci->dw1.value);=0D
-	rq_ci.dw1.value =3D hinic3_hw_cpu32(val);=0D
-	hw_ci =3D rq_ci.dw1.bs.hw_ci;=0D
+	sw_pi =3D hinic3_get_rq_local_pi(rxq);=0D
+	hw_ci =3D hinic3_get_rq_hw_ci(rxq);=0D
 =0D
 	if (HINIC3_IS_SP560_NIC(rxq->nic_dev)) {=0D
-		uint16_t sw_pi =3D hinic3_get_rq_local_pi(rxq);=0D
-		uint64_t end;=0D
-=0D
 		end =3D cycles + msecs_to_cycles(HINIC3_FLUSH_QUEUE_TIMEOUT);=0D
 		do {=0D
-			val =3D rte_read32(&rxq->rq_ci->dw1.value);=0D
-			rq_ci.dw1.value =3D hinic3_hw_cpu32(val);=0D
-			hw_ci =3D rq_ci.dw1.bs.hw_ci;=0D
+			hw_ci =3D hinic3_get_rq_hw_ci(rxq);=0D
 			if (sw_pi =3D=3D hw_ci)=0D
 				break;=0D
 =0D
@@ -666,22 +927,34 @@ hinic3_poll_integrated_cqe_rq_empty(struct hinic3_rxq=
 *rxq)=0D
 	return 0;=0D
 }=0D
 =0D
-void=0D
-hinic3_dump_cqe_status(struct hinic3_rxq *rxq, uint32_t *cqe_done_cnt,=0D
-		       uint32_t *cqe_hole_cnt, uint32_t *head_ci, uint32_t *head_done)=0D
+static void=0D
+hinic3_dump_cqe_status(struct hinic3_rxq *rxq)=0D
 {=0D
-	uint16_t sw_ci;=0D
+	volatile struct hinic3_rq_cqe *rx_cqe;=0D
+	uint16_t sw_ci, sw_pi, hw_ci;=0D
+	uint32_t head_ci, head_done;=0D
 	uint16_t avail_pkts =3D 0;=0D
 	uint16_t hit_done =3D 0;=0D
 	uint16_t cqe_hole =3D 0;=0D
-	RTE_ATOMIC(uint32_t)status;=0D
-	volatile struct hinic3_rq_cqe *rx_cqe;=0D
+	uint32_t status;=0D
+=0D
+	if (rxq->wqe_type =3D=3D HINIC3_COMPACT_RQ_WQE) {=0D
+		sw_ci =3D hinic3_get_rq_local_ci(rxq);=0D
+		sw_pi =3D hinic3_get_rq_local_pi(rxq);=0D
+		hw_ci =3D hinic3_get_rq_hw_ci(rxq);=0D
+		PMD_DRV_LOG(ERR,=0D
+			"Poll rq empty timeout, eth_dev:%s, queue_idx:%d, mbuf_left:%d, sw_pi:%=
d, sw_ci:%d, hw_ci:%d",=0D
+			rxq->nic_dev->dev_name, rxq->q_id,=0D
+			rxq->q_depth - hinic3_get_rq_free_wqebb(rxq),=0D
+			sw_pi, sw_ci, hw_ci);=0D
+		return;=0D
+	}=0D
 =0D
 	sw_ci =3D hinic3_get_rq_local_ci(rxq);=0D
 	rx_cqe =3D &rxq->rx_cqe[sw_ci];=0D
 	status =3D rx_cqe->status;=0D
-	*head_done =3D HINIC3_GET_RX_DONE(status);=0D
-	*head_ci =3D sw_ci;=0D
+	head_done =3D HINIC3_GET_RX_DONE(status);=0D
+	head_ci =3D sw_ci;=0D
 =0D
 	for (sw_ci =3D 0; sw_ci < rxq->q_depth; sw_ci++) {=0D
 		rx_cqe =3D &rxq->rx_cqe[sw_ci];=0D
@@ -702,17 +975,17 @@ hinic3_dump_cqe_status(struct hinic3_rxq *rxq, uint32=
_t *cqe_done_cnt,=0D
 		hit_done =3D 1;=0D
 	}=0D
 =0D
-	*cqe_done_cnt =3D avail_pkts;=0D
-	*cqe_hole_cnt =3D cqe_hole;=0D
+	PMD_DRV_LOG(ERR, "Poll rq empty timeout, eth_dev:%s, queue_idx:%d, "=0D
+		"mbuf_left:%d, cqe_done:%d, cqe_hole:%d, cqe[%d].done=3D%d",=0D
+		rxq->nic_dev->dev_name, rxq->q_id,=0D
+		rxq->q_depth - hinic3_get_rq_free_wqebb(rxq),=0D
+		avail_pkts, cqe_hole, head_ci, head_done);=0D
 }=0D
 =0D
 int=0D
 hinic3_stop_rq(struct rte_eth_dev *eth_dev, struct hinic3_rxq *rxq)=0D
 {=0D
 	struct hinic3_nic_dev *nic_dev =3D rxq->nic_dev;=0D
-	uint32_t cqe_done_cnt =3D 0;=0D
-	uint32_t cqe_hole_cnt =3D 0;=0D
-	uint32_t head_ci, head_done;=0D
 	int err;=0D
 =0D
 	/* Disable rxq intr. */=0D
@@ -759,23 +1032,21 @@ hinic3_stop_rq(struct rte_eth_dev *eth_dev, struct h=
inic3_rxq *rxq)=0D
 		goto rq_flush_failed;=0D
 	}=0D
 =0D
-	err =3D nic_dev->rx_ops->nic_rx_poll_rq_empty(rxq);=0D
+	if (nic_dev->config.rx_cqe_compact_en)=0D
+		err =3D hinic3_poll_integrated_cqe_rq_empty(rxq);=0D
+	else=0D
+		err =3D hinic3_poll_rq_empty(rxq);=0D
+=0D
 	if (err) {=0D
-		hinic3_dump_cqe_status(rxq, &cqe_done_cnt, &cqe_hole_cnt,=0D
-				       &head_ci, &head_done);=0D
-		PMD_DRV_LOG(ERR, "Poll rq empty timeout");=0D
-		PMD_DRV_LOG(ERR,=0D
-			    "eth_dev:%s, queue_idx:%d, mbuf_left:%d, cqe_done:%d, cqe_hole:%d, =
cqe[%d].done=3D%d",=0D
-			    nic_dev->dev_name, rxq->q_id,=0D
-			    rxq->q_depth - hinic3_get_rq_free_wqebb(rxq),=0D
-			    cqe_done_cnt, cqe_hole_cnt, head_ci, head_done);=0D
+		hinic3_dump_cqe_status(rxq);=0D
 		goto poll_rq_failed;=0D
 	}=0D
 =0D
 	return 0;=0D
 =0D
 poll_rq_failed:=0D
-	hinic3_set_rq_enable(nic_dev, rxq->q_id, true);=0D
+	if ((hinic3_get_driver_feature(nic_dev) & NIC_F_HTN_FDIR) !=3D 0)=0D
+		(void)hinic3_set_rq_enable(nic_dev, rxq->q_id, true);=0D
 rq_flush_failed:=0D
 	rte_spinlock_lock(&nic_dev->queue_list_lock);=0D
 set_indir_failed:=0D
@@ -947,6 +1218,8 @@ hinic3_start_all_rqs(struct rte_eth_dev *eth_dev)=0D
 =0D
 	for (i =3D 0; i < nic_dev->num_rqs; i++) {=0D
 		rxq =3D eth_dev->data->rx_queues[i];=0D
+		if (rxq =3D=3D NULL)=0D
+			break;=0D
 		hinic3_add_rq_to_rx_queue_list(nic_dev, rxq->q_id);=0D
 		err =3D hinic3_rearm_rxq_mbuf(rxq);=0D
 		if (err) {=0D
@@ -975,6 +1248,8 @@ hinic3_start_all_rqs(struct rte_eth_dev *eth_dev)=0D
 out:=0D
 	for (i =3D 0; i < nic_dev->num_rqs; i++) {=0D
 		rxq =3D eth_dev->data->rx_queues[i];=0D
+		if (rxq =3D=3D NULL)=0D
+			continue;=0D
 		hinic3_remove_rq_from_rx_queue_list(nic_dev, rxq->q_id);=0D
 		hinic3_free_rxq_mbufs(rxq);=0D
 		hinic3_dev_rx_queue_intr_disable(eth_dev, rxq->q_id);=0D
@@ -982,38 +1257,14 @@ hinic3_start_all_rqs(struct rte_eth_dev *eth_dev)=0D
 	}=0D
 	return err;=0D
 }=0D
-=0D
-bool=0D
-hinic3_rx_separate_cqe_done(struct hinic3_rxq *rxq, volatile struct hinic3=
_rq_cqe **rx_cqe)=0D
-{=0D
-	volatile struct hinic3_rq_cqe *cqe =3D NULL;=0D
-	uint16_t sw_ci;=0D
-	uint32_t status;=0D
-=0D
-	sw_ci =3D hinic3_get_rq_local_ci(rxq);=0D
-	*rx_cqe =3D &rxq->rx_cqe[sw_ci];=0D
-	cqe =3D *rx_cqe;=0D
-=0D
-	status =3D hinic3_hw_cpu32((uint32_t)(rte_atomic_load_explicit(&cqe->stat=
us,=0D
-								     rte_memory_order_acquire)));=0D
-	if (!HINIC3_GET_RX_DONE(status))=0D
-		return false;=0D
-=0D
-	return true;=0D
-}=0D
-=0D
-bool=0D
+static bool=0D
 hinic3_rx_integrated_cqe_done(struct hinic3_rxq *rxq, volatile struct hini=
c3_rq_cqe **rx_cqe)=0D
 {=0D
-	struct hinic3_rq_ci_wb rq_ci;=0D
 	struct rte_mbuf *rxm =3D NULL;=0D
 	uint16_t sw_ci, hw_ci;=0D
-	uint32_t val;=0D
 =0D
 	sw_ci =3D hinic3_get_rq_local_ci(rxq);=0D
-	val =3D rte_read32(&rxq->rq_ci->dw1.value);=0D
-	rq_ci.dw1.value =3D hinic3_hw_cpu32(val);=0D
-	hw_ci =3D rq_ci.dw1.bs.hw_ci;=0D
+	hw_ci =3D hinic3_get_rq_hw_ci(rxq);=0D
 =0D
 	if (hw_ci =3D=3D sw_ci)=0D
 		return false;=0D
@@ -1025,28 +1276,7 @@ hinic3_rx_integrated_cqe_done(struct hinic3_rxq *rxq=
, volatile struct hinic3_rq_=0D
 	return true;=0D
 }=0D
 =0D
-void=0D
-hinic3_rx_get_cqe_info(struct hinic3_rxq *rxq __rte_unused, volatile struc=
t hinic3_rq_cqe *rx_cqe,=0D
-		       struct hinic3_cqe_info *cqe_info)=0D
-{=0D
-	uint32_t dw0 =3D hinic3_hw_cpu32(rx_cqe->status);=0D
-	uint32_t dw1 =3D hinic3_hw_cpu32(rx_cqe->vlan_len);=0D
-	uint32_t dw2 =3D hinic3_hw_cpu32(rx_cqe->offload_type);=0D
-	uint32_t dw3 =3D hinic3_hw_cpu32(rx_cqe->hash_val);=0D
-=0D
-	cqe_info->lro_num =3D RQ_CQE_STATUS_GET(dw0, NUM_LRO);=0D
-	cqe_info->csum_err =3D RQ_CQE_STATUS_GET(dw0, CSUM_ERR);=0D
-=0D
-	cqe_info->pkt_len =3D RQ_CQE_SGE_GET(dw1, LEN);=0D
-	cqe_info->vlan_tag =3D RQ_CQE_SGE_GET(dw1, VLAN);=0D
-=0D
-	cqe_info->ptype =3D HINIC3_GET_RX_PTYPE_OFFLOAD(dw0);=0D
-	cqe_info->vlan_offload =3D RQ_CQE_OFFOLAD_TYPE_GET(dw2, VLAN_EN);=0D
-	cqe_info->rss_type =3D RQ_CQE_OFFOLAD_TYPE_GET(dw2, RSS_TYPE);=0D
-	cqe_info->rss_hash_value =3D dw3;=0D
-}=0D
-=0D
-void=0D
+static void=0D
 hinic3_rx_get_compact_cqe_info(struct hinic3_rxq *rxq, volatile struct hin=
ic3_rq_cqe *rx_cqe,=0D
 			       struct hinic3_cqe_info *cqe_info)=0D
 {=0D
@@ -1072,7 +1302,16 @@ hinic3_rx_get_compact_cqe_info(struct hinic3_rxq *rx=
q, volatile struct hinic3_rq=0D
 	cqe_info->ptype =3D HINIC3_RQ_COMPACT_CQE_STATUS_GET(dw0, PTYPE);=0D
 	cqe_info->rss_type =3D (rxq->nic_dev->rss_type.val !=3D 0) ? 1 : 0;=0D
 	cqe_info->rss_hash_value =3D dw1;=0D
-=0D
+	switch (cqe_info->csum_err) {=0D
+	case HINIC3_RX_COMPACT_CSUM_OTHER_ERROR:=0D
+		cqe_info->csum_err =3D HINIC3_RX_CSUM_IPSU_OTHER_ERR;=0D
+		break;=0D
+	case HINIC3_RX_COMPACT_HW_BYPASS_ERROR:=0D
+		cqe_info->csum_err =3D HINIC3_RX_CSUM_HW_CHECK_NONE;=0D
+		break;=0D
+	default:=0D
+		break;=0D
+	}=0D
 	if (cqe_info->cqe_len =3D=3D HINIC3_RQ_COMPACT_CQE_16BYTE) {=0D
 		cqe_info->lro_num =3D HINIC3_RQ_COMPACT_CQE_OFFLOAD_GET(dw2, NUM_LRO);=0D
 		cqe_info->vlan_tag =3D HINIC3_RQ_COMPACT_CQE_OFFLOAD_GET(dw2, VLAN);=0D
@@ -1083,12 +1322,12 @@ hinic3_rx_get_compact_cqe_info(struct hinic3_rxq *r=
xq, volatile struct hinic3_rq=0D
 				(cqe_info->cqe_len =3D=3D HINIC3_RQ_COMPACT_CQE_16BYTE) ? 16 : 8;=0D
 }=0D
 =0D
-#define HINIC3_RX_EMPTY_THRESHOLD 3=0D
 uint16_t=0D
-hinic3_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pk=
ts)=0D
+hinic3_recv_pkts_compact_cqe(void *rx_queue, struct rte_mbuf **rx_pkts, ui=
nt16_t nb_pkts)=0D
 {=0D
 	struct hinic3_rxq *rxq =3D rx_queue;=0D
 	struct hinic3_nic_dev *nic_dev =3D rxq->nic_dev;=0D
+	const struct hinic3_ptype_table * const ptype_tbl =3D nic_dev->ptype_tbl;=
=0D
 	struct hinic3_rx_info *rx_info =3D NULL;=0D
 	volatile struct hinic3_rq_cqe *rx_cqe =3D NULL;=0D
 	struct hinic3_cqe_info cqe_info =3D {0};=0D
@@ -1102,19 +1341,18 @@ hinic3_recv_pkts(void *rx_queue, struct rte_mbuf **=
rx_pkts, uint16_t nb_pkts)=0D
 	uint64_t t2;=0D
 #endif=0D
 	if (((rte_get_timer_cycles() - rxq->rxq_stats.tsc) < rxq->wait_time_cycle=
) &&=0D
-	    rxq->rxq_stats.empty >=3D HINIC3_RX_EMPTY_THRESHOLD)=0D
+	    rxq->rxq_stats.empty >=3D nic_dev->config.rx_empty_threshold)=0D
 		goto out;=0D
 =0D
 	sw_ci =3D hinic3_get_rq_local_ci(rxq);=0D
 =0D
 	while (pkts < nb_pkts) {=0D
-		rx_cqe =3D &rxq->rx_cqe[sw_ci];=0D
-		if (!nic_dev->rx_ops->nic_rx_cqe_done(rxq, &rx_cqe)) {=0D
+		if (!hinic3_rx_integrated_cqe_done(rxq, &rx_cqe)) {=0D
 			rxq->rxq_stats.empty++;=0D
 			break;=0D
 		}=0D
 =0D
-		nic_dev->rx_ops->nic_rx_get_cqe_info(rxq, rx_cqe, &cqe_info);=0D
+		hinic3_rx_get_compact_cqe_info(rxq, rx_cqe, &cqe_info);=0D
 =0D
 		pkt_len =3D cqe_info.pkt_len;=0D
 		/*=0D
@@ -1160,8 +1398,9 @@ hinic3_recv_pkts(void *rx_queue, struct rte_mbuf **rx=
_pkts, uint16_t nb_pkts)=0D
 		/* 5. Vlan offload. */=0D
 		rxm->ol_flags |=3D hinic3_rx_vlan(cqe_info.vlan_offload, cqe_info.vlan_t=
ag,=0D
 						&rxm->vlan_tci);=0D
-=0D
-		/* 6. RSS. */=0D
+		/* 6. Packet ptype */=0D
+		rxm->packet_type =3D ptype_tbl->ptype[cqe_info.ptype];=0D
+		/* 7. RSS. */=0D
 		rxm->ol_flags |=3D hinic3_rx_rss_hash(cqe_info.rss_type, cqe_info.rss_ha=
sh_value,=0D
 						    &rxm->hash.rss);=0D
 		/* 8. LRO. */=0D
@@ -1201,3 +1440,144 @@ hinic3_recv_pkts(void *rx_queue, struct rte_mbuf **=
rx_pkts, uint16_t nb_pkts)=0D
 =0D
 	return pkts;=0D
 }=0D
+=0D
+uint16_t hinic3_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint1=
6_t nb_pkts)=0D
+{=0D
+	struct hinic3_rxq *rxq =3D rx_queue;=0D
+	struct hinic3_nic_dev *nic_dev =3D rxq->nic_dev;=0D
+	struct hinic3_rx_info *rx_info =3D NULL;=0D
+	volatile struct hinic3_rq_cqe *rx_cqe =3D NULL;=0D
+	struct rte_mbuf *rxm =3D NULL;=0D
+	uint16_t sw_ci, rx_buf_len, wqebb_cnt =3D 0, pkts =3D 0;=0D
+	uint32_t status, pkt_len, vlan_len, offload_type, pkt_type, lro_num;=0D
+	uint64_t rx_bytes =3D 0;=0D
+	uint32_t hash_value =3D 0;=0D
+	uint32_t empty_nb =3D 0;=0D
+	const struct hinic3_ptype_table * const ptype_tbl =3D nic_dev->ptype_tbl;=
=0D
+=0D
+#ifdef HINIC3_XSTAT_PROF_RX=0D
+	uint64_t t1 =3D rte_get_tsc_cycles();=0D
+	uint64_t t2;=0D
+#endif=0D
+	if (((rte_get_timer_cycles() - rxq->rxq_stats.tsc) < rxq->wait_time_cycle=
) &&=0D
+	    rxq->rxq_stats.empty >=3D nic_dev->config.rx_empty_threshold)=0D
+		goto out;=0D
+=0D
+	sw_ci =3D hinic3_get_rq_local_ci(rxq);=0D
+	rx_buf_len =3D rxq->buf_len;=0D
+=0D
+	while (pkts < nb_pkts) {=0D
+		rx_cqe =3D &rxq->rx_cqe[sw_ci];=0D
+		status =3D hinic3_hw_cpu32((uint32_t)(rte_atomic_load_explicit(&rx_cqe->=
status,=0D
+								     rte_memory_order_acquire)));=0D
+		if (!HINIC3_GET_RX_DONE(status)) {=0D
+			rxq->rxq_stats.empty++;=0D
+			if (empty_nb++ >=3D rxq->rx_empty_loop)=0D
+				break;=0D
+			continue;=0D
+		}=0D
+=0D
+		vlan_len =3D hinic3_hw_cpu32(rx_cqe->vlan_len);=0D
+=0D
+		pkt_len =3D HINIC3_GET_RX_PKT_LEN(vlan_len);=0D
+=0D
+		rx_info =3D &rxq->rx_info[sw_ci];=0D
+		rxm =3D rx_info->mbuf;=0D
+=0D
+		/* 1. Next ci point and prefetch */=0D
+		sw_ci++;=0D
+		sw_ci &=3D rxq->q_mask;=0D
+=0D
+		/* 2. Prefetch next mbuf first 64B */=0D
+		rte_prefetch0(rxq->rx_info[sw_ci].mbuf);=0D
+=0D
+		/* 3. Jumbo frame process */=0D
+=0D
+		if (likely(pkt_len <=3D (uint32_t)rx_buf_len)) {=0D
+			rxm->data_len =3D (uint16_t)pkt_len;=0D
+			rxm->pkt_len =3D pkt_len;=0D
+			wqebb_cnt++;=0D
+		} else {=0D
+			rxm->data_len =3D rx_buf_len;=0D
+			rxm->pkt_len =3D rx_buf_len;=0D
+=0D
+			/* If receive jumbo, updating ci will be done by=0D
+			 * hinic3_recv_jumbo_pkt function.=0D
+			 */=0D
+			hinic3_update_rq_local_ci(rxq, wqebb_cnt + 1);=0D
+			wqebb_cnt =3D 0;=0D
+			hinic3_recv_jumbo_pkt(rxq, rxm, pkt_len - rx_buf_len);=0D
+			sw_ci =3D hinic3_get_rq_local_ci(rxq);=0D
+		}=0D
+=0D
+=0D
+		/*=0D
+		 * data_off was already set by rearm to the offset of the DMA=0D
+		 * start address relative to buf (HEADROOM + alignment offset=0D
+		 * when alignment is enabled, HEADROOM when disabled). The packet=0D
+		 * data starts at buf + data_off, so no further adjustment is=0D
+		 * needed.=0D
+		 */=0D
+		rxm->port =3D rxq->port_id;=0D
+=0D
+		/* 4. Rx checksum offload */=0D
+		rxm->ol_flags |=3D hinic3_rx_csum(HINIC3_GET_RX_CSUM_ERR(status), rxq);=
=0D
+=0D
+		/* 5. Vlan offload */=0D
+		offload_type =3D hinic3_hw_cpu32(rx_cqe->offload_type);=0D
+=0D
+		rxm->ol_flags |=3D hinic3_rx_vlan(HINIC3_GET_RX_VLAN_OFFLOAD_EN(offload_=
type),=0D
+						HINIC3_GET_RX_VLAN_TAG(vlan_len),=0D
+						&rxm->vlan_tci);=0D
+=0D
+		/* 6. Packet ptype */=0D
+		pkt_type =3D HINIC3_GET_RX_PTYPE_OFFLOAD(offload_type);=0D
+		rxm->packet_type =3D ptype_tbl->ptype[pkt_type];=0D
+=0D
+		/* 7. RSS */=0D
+		hash_value =3D hinic3_hw_cpu32(rx_cqe->hash_val);=0D
+		rxm->ol_flags |=3D hinic3_rx_rss_hash(HINIC3_GET_RSS_TYPES(offload_type)=
,=0D
+						    hash_value,=0D
+						    &rxm->hash.rss);=0D
+=0D
+		/* 8. LRO */=0D
+		lro_num =3D HINIC3_GET_RX_NUM_LRO(status);=0D
+		if (unlikely(lro_num !=3D 0)) {=0D
+			rxm->ol_flags |=3D HINIC3_PKT_RX_LRO;=0D
+			rxm->tso_segsz =3D pkt_len / lro_num;=0D
+		}=0D
+=0D
+		rx_cqe->status =3D 0;=0D
+=0D
+		rx_bytes +=3D pkt_len;=0D
+		rx_pkts[pkts++] =3D rxm;=0D
+	}=0D
+=0D
+	if (pkts) {=0D
+		/* 9. Update local ci */=0D
+		hinic3_update_rq_local_ci(rxq, wqebb_cnt);=0D
+=0D
+		/* Update packet stats */=0D
+		rxq->rxq_stats.packets +=3D pkts;=0D
+		rxq->rxq_stats.bytes +=3D rx_bytes;=0D
+		rxq->rxq_stats.empty =3D 0;=0D
+#ifdef HINIC3_XSTAT_MBUF_USE=0D
+		rxq->rxq_stats.free_mbuf +=3D pkts;=0D
+#endif=0D
+	}=0D
+	rxq->rxq_stats.burst_pkts =3D pkts;=0D
+	rxq->rxq_stats.tsc =3D rte_get_timer_cycles();=0D
+out:=0D
+	/* 10. Rearm mbuf to rxq */=0D
+	hinic3_rearm_rxq_mbuf(rxq);=0D
+=0D
+#ifdef HINIC3_XSTAT_PROF_RX=0D
+	/* do profiling stats */=0D
+	t2 =3D rte_get_tsc_cycles();=0D
+	rxq->rxq_stats.app_tsc =3D t1 - rxq->prof_rx_end_tsc;=0D
+	rxq->prof_rx_end_tsc =3D t2;=0D
+	rxq->rxq_stats.pmd_tsc =3D t2 - t1;=0D
+#endif=0D
+=0D
+	return pkts;=0D
+}=0D
diff --git a/drivers/net/hinic3/hinic3_rx.h b/drivers/net/hinic3/hinic3_rx.=
h=0D
index 129c2b4a59..0cdfcb6e9c 100644=0D
--- a/drivers/net/hinic3/hinic3_rx.h=0D
+++ b/drivers/net/hinic3/hinic3_rx.h=0D
@@ -5,11 +5,23 @@=0D
 #ifndef _HINIC3_RX_H_=0D
 #define _HINIC3_RX_H_=0D
 =0D
+#include "hinic3_wq.h"=0D
+=0D
 #define RQ_CQE_OFFOLAD_TYPE_PTYPE_OFFLOAD_SHIFT	0=0D
+#define RQ_CQE_OFFOLAD_TYPE_PKT_TYPE_SHIFT	0=0D
+#define RQ_CQE_OFFOLAD_TYPE_IP_TYPE_SHIFT	5=0D
+#define RQ_CQE_OFFOLAD_TYPE_ENC_L3_TYPE_SHIFT	7=0D
+#define RQ_CQE_OFFOLAD_TYPE_PKT_FORMAT_SHIFT	8=0D
+#define RQ_CQE_OFFOLAD_TYPE_PKT_UMBCAST_SHIFT	19=0D
 #define RQ_CQE_OFFOLAD_TYPE_VLAN_EN_SHIFT	21=0D
 #define RQ_CQE_OFFOLAD_TYPE_RSS_TYPE_SHIFT	24=0D
 =0D
 #define RQ_CQE_OFFOLAD_TYPE_PTYPE_OFFLOAD_MASK	0xFFFU=0D
+#define RQ_CQE_OFFOLAD_TYPE_PKT_TYPE_MASK	0x1FU=0D
+#define RQ_CQE_OFFOLAD_TYPE_IP_TYPE_MASK	0x3U=0D
+#define RQ_CQE_OFFOLAD_TYPE_ENC_L3_TYPE_MASK	0X1U=0D
+#define RQ_CQE_OFFOLAD_TYPE_PKT_FORMAT_MASK	0xFU=0D
+#define RQ_CQE_OFFOLAD_TYPE_PKT_UMBCAST_MASK	0x3U=0D
 #define RQ_CQE_OFFOLAD_TYPE_VLAN_EN_MASK	0x1U=0D
 #define RQ_CQE_OFFOLAD_TYPE_RSS_TYPE_MASK	0xFFU=0D
 =0D
@@ -25,6 +37,15 @@=0D
 #define HINIC3_GET_RX_PKT_TYPE(offload_type) \=0D
 	RQ_CQE_OFFOLAD_TYPE_GET(offload_type, PKT_TYPE)=0D
 =0D
+#define HINIC3_GET_RX_IP_TYPE(offload_type) \=0D
+	RQ_CQE_OFFOLAD_TYPE_GET(offload_type, IP_TYPE)=0D
+=0D
+#define HINIC3_GET_RX_ENC_L3_TYPE(offload_type) \=0D
+	RQ_CQE_OFFOLAD_TYPE_GET(offload_type, ENC_L3_TYPE)=0D
+=0D
+#define HINIC3_GET_RX_PKT_FORMAT(offload_type) \=0D
+	RQ_CQE_OFFOLAD_TYPE_GET(offload_type, PKT_FORMAT)=0D
+=0D
 #define HINIC3_GET_RX_PKT_UMBCAST(offload_type) \=0D
 	RQ_CQE_OFFOLAD_TYPE_GET(offload_type, PKT_UMBCAST)=0D
 =0D
@@ -142,10 +163,10 @@=0D
 #define RQ_COMPACT_CQE_STATUS_CQE_TYPE_MASK		0x1U=0D
 #define RQ_COMPACT_CQE_STATUS_TS_FLAG_MASK		0x1U=0D
 #define RQ_COMPACT_CQE_STATUS_VLAN_EN_MASK		0x1U=0D
-#define RQ_COMPACT_CQE_STATUS_PKT_FORMAT_MASK	0x7U=0D
+#define RQ_COMPACT_CQE_STATUS_PKT_FORMAT_MASK		0x7U=0D
 #define RQ_COMPACT_CQE_STATUS_IP_TYPE_MASK		0x1U=0D
 #define RQ_COMPACT_CQE_STATUS_CQE_LEN_MASK		0x1U=0D
-#define RQ_COMPACT_CQE_STATUS_PKT_MC_MASK		0x1U=0D
+#define RQ_COMPACT_CQE_STATUS_PKT_MC_MASK		0x3U=0D
 #define RQ_COMPACT_CQE_STATUS_CSUM_ERR_MASK		0x3U=0D
 #define RQ_COMPACT_CQE_STATUS_PKT_TYPE_MASK		0x7U=0D
 #define RQ_COMPACT_CQE_STATUS_PTYPE_MASK		0xFFFU=0D
@@ -182,6 +203,13 @@=0D
 #define HINIC3_RX_CSUM_HW_CHECK_NONE    RTE_BIT32(7)=0D
 #define HINIC3_RX_CSUM_IPSU_OTHER_ERR   RTE_BIT32(8)=0D
 =0D
+enum hinic3_compact_cqe_csum_err_type {=0D
+	HINIC3_RX_COMPACT_CSUM_NO_ERROR =3D 0,=0D
+	HINIC3_RX_COMPACT_L3_L4_CSUM_ERROR,=0D
+	HINIC3_RX_COMPACT_CSUM_OTHER_ERROR,=0D
+	HINIC3_RX_COMPACT_HW_BYPASS_ERROR=0D
+};=0D
+=0D
 #define HINIC3_DEFAULT_RX_CSUM_OFFLOAD 0xFFF=0D
 #define HINIC3_CQE_LEN		       32=0D
 =0D
@@ -200,6 +228,72 @@=0D
 	RTE_ETH_RSS_IPV6_TCP_EX |        \=0D
 	RTE_ETH_RSS_IPV6_UDP_EX)=0D
 =0D
+#define HINIC3_L4_PYTPE_SHIFT	16=0D
+#define HINIC3_COMPACT_CQE_PTYPE_SHIFT 16=0D
+=0D
+/* keep same with IPSU_METADATA_L3_TP_E */=0D
+enum HINIC3_RX_CQE_PT_L3 {=0D
+	HINIC3_RX_CQE_L3_IPV4 =3D 0u,=0D
+	HINIC3_RX_CQE_L3_IPV6 =3D 1u,=0D
+};=0D
+=0D
+/* keep same with IPSU_PKT_TYPE_L45FINAL_E */=0D
+enum HINIC3_RX_CQE_PT_L4 {=0D
+	HINIC3_RX_CQE_L4_TCP =3D 3,=0D
+	HINIC3_RX_CQE_L4_UDP =3D 4,=0D
+};=0D
+=0D
+enum IPSU_METADATA_L3_TP_E {=0D
+	IPSU_METADATA_L3_TP_IPV4 =3D 0u,=0D
+	IPSU_METADATA_L3_TP_IPV6 =3D 1u,=0D
+};=0D
+=0D
+enum IPSU_PKT_TYPE_L45FINAL_E {=0D
+	IPSU_PKT_TYPE_NULL =3D 0,=0D
+	IPSU_PKT_TYPE_ROCEV2,=0D
+	IPSU_PKT_TYPE_TCPCOCO,=0D
+	IPSU_PKT_TYPE_TCP,=0D
+	IPSU_PKT_TYPE_UDP,=0D
+	IPSU_PKT_TYPE_ICMP,=0D
+	IPSU_PKT_TYPE_IGMP,=0D
+	IPSU_PKT_TYPE_SCTP,=0D
+	IPSU_PKT_TYPE_DHCP,=0D
+	IPSU_PKT_TYPE_IPV4_FRAG,=0D
+	IPSU_PKT_TYPE_IPV6_MC,=0D
+	IPSU_PKT_TYPE_1588,=0D
+	IPSU_PKT_TYPE_AH_OVER_IP,=0D
+	IPSU_PKT_TYPE_ESP_OVER_IP,=0D
+	IPSU_PKT_TYPE_NATT,=0D
+	IPSU_PKT_TYPE_AH_OVER_VXLAN_GPE,=0D
+	IPSU_PKT_TYPE_ESP_OVER_VXLAN_GPE,=0D
+	IPSU_PKT_TYPE_TSO,=0D
+	IPSU_PKT_TYPE_UFO,=0D
+	IPSU_PKT_TYPE_INT,=0D
+	IPSU_PKT_TYPE_IOAM,=0D
+	IPSU_PKT_TYPE_VXLAN_GPE,=0D
+	IPSU_PKT_TYPE_GENEVE,=0D
+	IPSU_PKT_TYPE_NSH_OVER_GENEVE,=0D
+	IPSU_PKT_TYPE_NSH_OVER_VXLAN_GPE,=0D
+	IPSU_PKT_TYPE_ESP_OVER_GENEVE,=0D
+	IPSU_PKT_TYPE_PPOP_OVER_GENEVE,=0D
+	IPSU_PKT_TYPE_OSPF,=0D
+	IPSU_PKT_TYPE_VRRP,=0D
+	IPSU_PKT_TYPE_BGP,=0D
+	IPSU_PKT_TYPE_GRE,=0D
+	IPSU_ERR_RSVD,=0D
+};=0D
+=0D
+enum IPSU_METADATA_FMT_E {=0D
+	IPSU_METADATA_FMT_NO_ENC	=3D 0u,=0D
+	IPSU_METADATA_FMT_VXLAN		=3D 1u,=0D
+	IPSU_METADATA_FMT_NVGRE		=3D 2u,=0D
+	IPSU_METADATA_FMT_FC		=3D 3u,=0D
+	IPSU_METADATA_FMT_GPE		=3D 4u,=0D
+	IPSU_METADATA_FMT_GENEVE	=3D 5u,=0D
+	IPSU_METADATA_FMT_NSH		=3D 6u,=0D
+	IPSU_METADATA_FMT_IPIP		=3D 7U,=0D
+};=0D
+=0D
 struct hinic3_rxq_stats {=0D
 	uint64_t packets;=0D
 	uint64_t bytes;=0D
@@ -313,7 +407,6 @@ struct hinic3_rq_ci_wb {=0D
 	uint32_t rsvd[3];=0D
 };=0D
 =0D
-=0D
 struct __rte_cache_aligned hinic3_rxq {=0D
 	struct hinic3_nic_dev *nic_dev;=0D
 =0D
@@ -323,6 +416,7 @@ struct __rte_cache_aligned hinic3_rxq {=0D
 	uint16_t buf_len;=0D
 =0D
 	uint32_t rx_buff_shift;=0D
+	uint32_t rx_empty_loop;=0D
 =0D
 	uint16_t rx_free_thresh;=0D
 	uint16_t rxinfo_align_end;=0D
@@ -370,24 +464,6 @@ struct __rte_cache_aligned hinic3_rxq {=0D
 #endif=0D
 };=0D
 =0D
-/* Rx CQE info get callback function */=0D
-typedef void  (*nic_rx_get_cqe_info_t)(struct hinic3_rxq *rxq,=0D
-				       volatile struct hinic3_rq_cqe *rx_cqe,=0D
-				       struct hinic3_cqe_info *cqe_info);=0D
-=0D
-/* Rx CQE check status callback function */=0D
-typedef bool  (*nic_rx_cqe_done_t)(struct hinic3_rxq *rxq,=0D
-				   volatile struct hinic3_rq_cqe **rx_cqe);=0D
-=0D
-/* Rx CQE empty poll callback function */=0D
-typedef int   (*nic_rx_poll_rq_empty_t)(struct hinic3_rxq *rxq);=0D
-=0D
-struct hinic3_nic_rx_ops {=0D
-	nic_rx_get_cqe_info_t		nic_rx_get_cqe_info;=0D
-	nic_rx_cqe_done_t		nic_rx_cqe_done;=0D
-	nic_rx_poll_rq_empty_t		nic_rx_poll_rq_empty;=0D
-};=0D
-=0D
 uint16_t hinic3_rx_fill_wqe(struct hinic3_rxq *rxq);=0D
 =0D
 uint16_t hinic3_rx_fill_buffers(struct hinic3_rxq *rxq);=0D
@@ -399,16 +475,14 @@ void hinic3_free_all_rxq_mbufs(struct hinic3_nic_dev =
*nic_dev);=0D
 int hinic3_update_rss_config(struct rte_eth_dev *dev,=0D
 			     struct rte_eth_rss_conf *rss_conf);=0D
 =0D
-int hinic3_poll_integrated_cqe_rq_empty(struct hinic3_rxq *rxq);=0D
-int hinic3_poll_rq_empty(struct hinic3_rxq *rxq);=0D
-=0D
-void hinic3_dump_cqe_status(struct hinic3_rxq *rxq, uint32_t *cqe_done_cnt=
,=0D
-			    uint32_t *cqe_hole_cnt, uint32_t *head_ci, uint32_t *head_done);=0D
+int hinic3_init_rx_ptype_table(struct rte_eth_dev *dev);=0D
 =0D
 int hinic3_stop_rq(struct rte_eth_dev *eth_dev, struct hinic3_rxq *rxq);=0D
 =0D
 int hinic3_start_rq(struct rte_eth_dev *eth_dev, struct hinic3_rxq *rxq);=
=0D
 =0D
+uint16_t hinic3_recv_pkts_compact_cqe(void *rx_queue, struct rte_mbuf **rx=
_pkts, uint16_t nb_pkts);=0D
+=0D
 uint16_t hinic3_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint1=
6_t nb_pkts);=0D
 =0D
 void hinic3_add_rq_to_rx_queue_list(struct hinic3_nic_dev *nic_dev,=0D
@@ -426,95 +500,4 @@ int hinic3_start_all_rqs(struct rte_eth_dev *eth_dev);=
=0D
 void hinic3_get_stats(struct hinic3_rxq *rxq);=0D
 #endif=0D
 =0D
-/**=0D
- * Get receive queue local ci.=0D
- *=0D
- * @param[in] rxq=0D
- * Pointer to receive queue structure.=0D
- * @return=0D
- * Receive queue local ci.=0D
- */=0D
-static inline uint16_t=0D
-hinic3_get_rq_local_ci(struct hinic3_rxq *rxq)=0D
-{=0D
-	return MASKED_QUEUE_IDX(rxq, rxq->cons_idx);=0D
-}=0D
-=0D
-static inline uint16_t=0D
-hinic3_get_rq_free_wqebb(struct hinic3_rxq *rxq)=0D
-{=0D
-	return rxq->delta - 1;=0D
-}=0D
-=0D
-/**=0D
- * Update receive queue local ci.=0D
- *=0D
- * @param[in] rxq=0D
- * Pointer to receive queue structure.=0D
- * @param[out] wqe_cnt=0D
- * Wqebb counters.=0D
- */=0D
-static inline void=0D
-hinic3_update_rq_local_ci(struct hinic3_rxq *rxq, uint16_t wqe_cnt)=0D
-{=0D
-	rxq->cons_idx +=3D wqe_cnt;=0D
-	rxq->delta +=3D wqe_cnt;=0D
-}=0D
-=0D
-/**=0D
- * Get receive cqe information=0D
- *=0D
- * @param[in] rxq=0D
- *   Receive queue=0D
- * @param[in] rx_cqe=0D
- *   Receive cqe=0D
- * @param[in] cqe_info=0D
- *   Packet information parsed from cqe=0D
- */=0D
-void=0D
-hinic3_rx_get_cqe_info(struct hinic3_rxq *rxq, volatile struct hinic3_rq_c=
qe *rx_cqe,=0D
-		       struct hinic3_cqe_info *cqe_info);=0D
-=0D
-/**=0D
- * Get receive compact cqe information=0D
- *=0D
- * @param[in] rx_queue=0D
- *   Receive queue=0D
- * @param[in] rx_cqe=0D
- *   Receive compact cqe=0D
- * @param[in] cqe_info=0D
- *   Packet information parsed from cqe=0D
- */=0D
-void=0D
-hinic3_rx_get_compact_cqe_info(struct hinic3_rxq *rxq, volatile struct hin=
ic3_rq_cqe *rx_cqe,=0D
-			       struct hinic3_cqe_info *cqe_info);=0D
-=0D
-/**=0D
- * Check whether pkt is received when CQE is separated=0D
- *=0D
- * @param[in] rxq=0D
- *   Receive queue=0D
- * @param[in] rx_cqe=0D
- *   The CQE written by hw=0D
- * @return=0D
- *   True: Packet is received=0D
- *   False: Packet is not received=0D
- */=0D
-bool=0D
-hinic3_rx_separate_cqe_done(struct hinic3_rxq *rxq, volatile struct hinic3=
_rq_cqe **rx_cqe);=0D
-=0D
-/**=0D
- * Check whether pkt is received when CQE is integrated=0D
- *=0D
- * @param[in] rxq=0D
- *   Receive queue=0D
- * @param[in] rx_cqe=0D
- *   The CQE written by hw=0D
- * @return=0D
- *   True: Packet is received=0D
- *   False: Packet is not received=0D
- */=0D
-bool=0D
-hinic3_rx_integrated_cqe_done(struct hinic3_rxq *rxq, volatile struct hini=
c3_rq_cqe **rx_cqe);=0D
-=0D
 #endif /* _HINIC3_RX_H_ */=0D
-- =0D
2.33.0=0D
=0D

