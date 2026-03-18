Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36F1FCD0BF
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Mar 2026 06:22:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0931540664;
	Wed, 18 Mar 2026 07:22:13 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.4])
 by mails.dpdk.org (Postfix) with ESMTP id 77D2940612
 for <dev@dpdk.org>; Wed, 18 Mar 2026 07:22:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=iFH5tWIu3km39HErwAmimI36AGvQ9wODOooipzUCGAE=;
 b=qMtrWhAbsmVjo9ksSewbwON3bqw+Y9FbzltgKrr5lBA5fV+oPiJbsUF9E0If+u
 k22R7UxZ881o0Ts2etK/bdTKfX02v9SV55u1qNrx/zjhtZDP16oJApYlNzcOKaV7
 WKqCBkChef1pVEI4v8Vti4LYtJpeaCy/Za0CeBf0knHb0=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgAn2mxjRLpp3_HsAg--.63347S8;
 Wed, 18 Mar 2026 14:22:05 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>
Subject: [V4 4/7] net/hinic3: add fun init ops to support Compact CQE
Date: Wed, 18 Mar 2026 14:20:56 +0800
Message-ID: <20260318062105.1972-5-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20260318062105.1972-1-wff_light@vip.163.com>
References: <20260131100608.12429-2-wff_light@vip.163.com>
 <20260318062105.1972-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: As8vCgAn2mxjRLpp3_HsAg--.63347S8
X-Coremail-Antispam: 1Uf129KBjvAXoWDCr1DGF1fXw1kWw4rAFW5Jrb_yoW7KFWUXo
 W3Jr13tw1fJr1IkrZIgw4kWayDAwn8Z3Z8Ga9xW3sFqFy7G34UKasxAw1rX3WFg39YyF17
 AF9xK3WDt3yqv3s8n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUrD73DUUUU
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiMw09R2m6RI2W2wAA3T
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

From: Feifei Wang <wangfeifei40@huawei.com>=0D

For new SPx NIC, use compact CQE to achieve better performance.=0D
In this mode, CQE is uploaded together with packet.=0D
=0D
When doing fun init, replace CQE's dma memory mapping with CI index,=0D
hinic3 driver will loop CI to check if packet arrive.=0D
=0D
Signed-off-by: Feifei Wang <wangfeifei40@huawei.com>=0D
---=0D
 drivers/net/hinic3/hinic3_ethdev.c            | 212 +++++--=0D
 drivers/net/hinic3/hinic3_ethdev.h            | 117 ++--=0D
 drivers/net/hinic3/hinic3_nic_io.c            | 525 ++++++++----------=0D
 drivers/net/hinic3/hinic3_nic_io.h            |  61 +-=0D
 drivers/net/hinic3/hinic3_rx.h                |  18 +=0D
 drivers/net/hinic3/hinic3_tx.h                |   8 +=0D
 .../net/hinic3/htn_adapt/hinic3_htn_cmdq.c    |  24 +-=0D
 .../net/hinic3/htn_adapt/hinic3_htn_cmdq.h    |  12 +-=0D
 .../net/hinic3/stn_adapt/hinic3_stn_cmdq.c    |  24 +-=0D
 .../net/hinic3/stn_adapt/hinic3_stn_cmdq.h    |  12 +-=0D
 10 files changed, 577 insertions(+), 436 deletions(-)=0D
=0D
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3=
_ethdev.c=0D
index 780b17414a..1010773ac1 100644=0D
--- a/drivers/net/hinic3/hinic3_ethdev.c=0D
+++ b/drivers/net/hinic3/hinic3_ethdev.c=0D
@@ -32,7 +32,7 @@=0D
 #define HINIC3_DEFAULT_RX_FREE_THRESH 32u=0D
 #define HINIC3_DEFAULT_TX_FREE_THRESH 32u=0D
 =0D
-#define HINIC3_RX_WAIT_CYCLE_THRESH 500=0D
+#define HINIC3_RX_WAIT_CYCLE_THRESH 150=0D
 =0D
 /**=0D
  * Get the 32-bit VFTA bit mask for the lower 5 bits of the VLAN ID.=0D
@@ -431,8 +431,10 @@ hinic3_deinit_mac_addr(struct rte_eth_dev *eth_dev)=0D
 static int=0D
 hinic3_pf_get_default_cos(struct hinic3_hwdev *hwdev, uint8_t *cos_id)=0D
 {=0D
+	struct hinic3_nic_dev *nic_dev =3D hwdev->dev_handle;=0D
 	uint8_t default_cos =3D 0;=0D
 	uint8_t valid_cos_bitmap;=0D
+	uint8_t cos_num_max;=0D
 	uint8_t i;=0D
 =0D
 	valid_cos_bitmap =3D hwdev->cfg_mgmt->svc_cap.cos_valid_bitmap;=0D
@@ -441,7 +443,10 @@ hinic3_pf_get_default_cos(struct hinic3_hwdev *hwdev, =
uint8_t *cos_id)=0D
 		return -EFAULT;=0D
 	}=0D
 =0D
-	for (i =3D 0; i < HINIC3_COS_NUM_MAX; i++) {=0D
+	cos_num_max =3D nic_dev->feature_cap & NIC_F_HTN_CMDQ ?=0D
+		      HINIC3_COS_NUM_MAX_HTN : HINIC3_COS_NUM_MAX;=0D
+=0D
+	for (i =3D 0; i < cos_num_max; i++) {=0D
 		if (valid_cos_bitmap & RTE_BIT32(i))=0D
 			/* Find max cos id as default cos. */=0D
 			default_cos =3D i;=0D
@@ -644,6 +649,15 @@ hinic3_dev_configure(struct rte_eth_dev *dev)=0D
 	return 0;=0D
 }=0D
 =0D
+static void=0D
+hinic3_dev_tnl_tso_support(struct rte_eth_dev_info *info, struct hinic3_ni=
c_dev *nic_dev)=0D
+{=0D
+	if (HINIC3_SUPPORT_GENEVE_OFFLOAD(nic_dev))=0D
+		info->tx_offload_capa |=3D RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO;=0D
+	if (HINIC3_SUPPORT_IPXIP_OFFLOAD(nic_dev))=0D
+		info->tx_offload_capa |=3D RTE_ETH_TX_OFFLOAD_IPIP_TNL_TSO;=0D
+}=0D
+=0D
 /**=0D
  * Get information about the device.=0D
  *=0D
@@ -684,6 +698,8 @@ hinic3_dev_infos_get(struct rte_eth_dev *dev, struct rt=
e_eth_dev_info *info)=0D
 		RTE_ETH_TX_OFFLOAD_SCTP_CKSUM |=0D
 		RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |=0D
 		RTE_ETH_TX_OFFLOAD_TCP_TSO | RTE_ETH_TX_OFFLOAD_MULTI_SEGS;=0D
+	if (nic_dev->feature_cap & NIC_F_HTN_CMDQ)=0D
+		hinic3_dev_tnl_tso_support(info, nic_dev);=0D
 =0D
 	info->hash_key_size =3D HINIC3_RSS_KEY_SIZE;=0D
 	info->reta_size =3D HINIC3_RSS_INDIR_SIZE;=0D
@@ -926,16 +942,25 @@ hinic3_rx_queue_setup(struct rte_eth_dev *dev, uint16=
_t qid, uint16_t nb_desc,=0D
 	struct hinic3_rxq *rxq =3D NULL;=0D
 	const struct rte_memzone *rq_mz =3D NULL;=0D
 	const struct rte_memzone *cqe_mz =3D NULL;=0D
+	const struct rte_memzone *ci_mz =3D NULL;=0D
 	const struct rte_memzone *pi_mz =3D NULL;=0D
 	uint16_t rq_depth, rx_free_thresh;=0D
 	uint32_t queue_buf_size;=0D
 	void *db_addr =3D NULL;=0D
 	int wqe_count;=0D
 	uint32_t buf_size;=0D
+	uint32_t rx_buf_size;=0D
 	int err;=0D
 =0D
 	nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);=0D
 =0D
+	/* Queue depth must be equal to queue 0 */=0D
+	if (qid !=3D 0 && nb_desc !=3D nic_dev->rxqs[0]->q_depth) {=0D
+		PMD_DRV_LOG(WARNING, "rxq%u depth:%u is not equal to queue0 depth:%u.",=
=0D
+			    qid, nb_desc, nic_dev->rxqs[0]->q_depth);=0D
+		nb_desc =3D nic_dev->rxqs[0]->q_depth;=0D
+	}=0D
+=0D
 	/* Queue depth must be power of 2, otherwise will be aligned up. */=0D
 	rq_depth =3D (nb_desc & (nb_desc - 1))=0D
 			? ((uint16_t)(1U << (rte_log2_u32(nb_desc) + 1))) : nb_desc;=0D
@@ -997,8 +1022,7 @@ hinic3_rx_queue_setup(struct rte_eth_dev *dev, uint16_=
t qid, uint16_t nb_desc,=0D
 	rxq->wait_time_cycle =3D HINIC3_RX_WAIT_CYCLE_THRESH;=0D
 	rxq->rx_deferred_start =3D rx_conf->rx_deferred_start;=0D
 	/* If buf_len used for function table, need to translated. */=0D
-	uint16_t rx_buf_size =3D=0D
-		rte_pktmbuf_data_room_size(rxq->mb_pool) - RTE_PKTMBUF_HEADROOM;=0D
+	rx_buf_size =3D rte_pktmbuf_data_room_size(rxq->mb_pool) - RTE_PKTMBUF_HE=
ADROOM;=0D
 	err =3D hinic3_convert_rx_buf_size(rx_buf_size, &buf_size);=0D
 	if (err) {=0D
 		PMD_DRV_LOG(ERR, "Adjust buf size failed, dev_name: %s",=0D
@@ -1006,11 +1030,16 @@ hinic3_rx_queue_setup(struct rte_eth_dev *dev, uint=
16_t qid, uint16_t nb_desc,=0D
 		goto adjust_bufsize_fail;=0D
 	}=0D
 =0D
-	if (buf_size >=3D HINIC3_RX_BUF_SIZE_4K &&=0D
-	    buf_size < HINIC3_RX_BUF_SIZE_16K)=0D
-		rxq->wqe_type =3D HINIC3_EXTEND_RQ_WQE;=0D
-	else=0D
-		rxq->wqe_type =3D HINIC3_NORMAL_RQ_WQE;=0D
+	/* If NIC support compact CQE, use compact wqe as default. */=0D
+	if (HINIC3_SUPPORT_RX_HW_COMPACT_CQE(nic_dev)) {=0D
+		rxq->wqe_type =3D HINIC3_COMPACT_RQ_WQE;=0D
+	} else {=0D
+		if (buf_size >=3D HINIC3_RX_BUF_SIZE_4K &&=0D
+			buf_size < HINIC3_RX_BUF_SIZE_16K)=0D
+			rxq->wqe_type =3D HINIC3_EXTEND_RQ_WQE;=0D
+		else=0D
+			rxq->wqe_type =3D HINIC3_NORMAL_RQ_WQE;=0D
+	}=0D
 =0D
 	rxq->wqebb_shift =3D HINIC3_RQ_WQEBB_SHIFT + rxq->wqe_type;=0D
 	rxq->wqebb_size =3D (uint16_t)RTE_BIT32(rxq->wqebb_shift);=0D
@@ -1062,36 +1091,52 @@ hinic3_rx_queue_setup(struct rte_eth_dev *dev, uint=
16_t qid, uint16_t nb_desc,=0D
 		goto alloc_rx_info_fail;=0D
 	}=0D
 =0D
-	cqe_mz =3D hinic3_dma_zone_reserve(dev, "hinic3_cqe_mz", qid,=0D
-					 rq_depth * sizeof(*rxq->rx_cqe),=0D
-					 RTE_CACHE_LINE_SIZE, socket_id);=0D
-	if (!cqe_mz) {=0D
-		PMD_DRV_LOG(ERR, "Allocate cqe mem zone failed, dev_name: %s",=0D
-			    dev->data->name);=0D
-		err =3D -ENOMEM;=0D
-		goto alloc_cqe_mz_fail;=0D
-	}=0D
-	memset(cqe_mz->addr, 0, rq_depth * sizeof(*rxq->rx_cqe));=0D
-	rxq->cqe_mz =3D cqe_mz;=0D
-	rxq->cqe_start_paddr =3D cqe_mz->iova;=0D
-	rxq->cqe_start_vaddr =3D cqe_mz->addr;=0D
-	rxq->rx_cqe =3D (struct hinic3_rq_cqe *)rxq->cqe_start_vaddr;=0D
-=0D
-	wqe_count =3D hinic3_rx_fill_wqe(rxq);=0D
-	if (wqe_count !=3D rq_depth) {=0D
-		PMD_DRV_LOG(ERR, "Fill rx wqe failed, wqe_count: %d, dev_name: %s",=0D
-				wqe_count, dev->data->name);=0D
-		err =3D -ENOMEM;=0D
-		goto fill_rx_wqe_fail;=0D
+	if (HINIC3_SUPPORT_RX_HW_COMPACT_CQE(nic_dev)) {=0D
+		ci_mz =3D hinic3_dma_zone_reserve(dev, "hinic3_ci_mz", qid,=0D
+						sizeof(*rxq->rq_ci),=0D
+						RTE_CACHE_LINE_SIZE, (int)socket_id);=0D
+=0D
+		if (!ci_mz) {=0D
+			PMD_DRV_LOG(ERR, "Allocate ci mem zone failed, dev_name: %s",=0D
+				    dev->data->name);=0D
+			err =3D -ENOMEM;=0D
+			goto alloc_cqe_ci_mz_fail;=0D
+		}=0D
+=0D
+		memset(ci_mz->addr, 0, sizeof(*rxq->rq_ci));=0D
+		rxq->ci_mz =3D ci_mz;=0D
+		rxq->rq_ci =3D (struct hinic3_rq_ci_wb *)ci_mz->addr;=0D
+		rxq->rq_ci_paddr =3D ci_mz->iova;=0D
+	} else {=0D
+		cqe_mz =3D hinic3_dma_zone_reserve(dev, "hinic3_cqe_mz", qid,=0D
+						 rq_depth * sizeof(*rxq->rx_cqe),=0D
+						 RTE_CACHE_LINE_SIZE, socket_id);=0D
+		if (!cqe_mz) {=0D
+			PMD_DRV_LOG(ERR, "Allocate cqe mem zone failed, dev_name: %s",=0D
+			dev->data->name);=0D
+			err =3D -ENOMEM;=0D
+			goto alloc_cqe_ci_mz_fail;=0D
+		}=0D
+		memset(cqe_mz->addr, 0, rq_depth * sizeof(*rxq->rx_cqe));=0D
+		rxq->cqe_mz =3D cqe_mz;=0D
+		rxq->cqe_start_paddr =3D cqe_mz->iova;=0D
+		rxq->cqe_start_vaddr =3D cqe_mz->addr;=0D
+		rxq->rx_cqe =3D (struct hinic3_rq_cqe *)rxq->cqe_start_vaddr;=0D
+=0D
+		wqe_count =3D hinic3_rx_fill_wqe(rxq);=0D
+		if (wqe_count !=3D rq_depth) {=0D
+			PMD_DRV_LOG(ERR, "Fill rx wqe failed, wqe_count: %d, dev_name: %s",=0D
+					wqe_count, dev->data->name);=0D
+			err =3D -ENOMEM;=0D
+			hinic3_memzone_free(cqe_mz);=0D
+			goto alloc_cqe_ci_mz_fail;=0D
+		}=0D
 	}=0D
-	/* Record rxq pointer in rte_eth rx_queues. */=0D
 	dev->data->rx_queues[qid] =3D rxq;=0D
 =0D
 	return 0;=0D
 =0D
-fill_rx_wqe_fail:=0D
-	hinic3_memzone_free(rxq->cqe_mz);=0D
-alloc_cqe_mz_fail:=0D
+alloc_cqe_ci_mz_fail:=0D
 	rte_free(rxq->rx_info);=0D
 =0D
 alloc_rx_info_fail:=0D
@@ -1199,6 +1244,7 @@ hinic3_tx_queue_setup(struct rte_eth_dev *dev, uint16=
_t qid, uint16_t nb_desc,=0D
 	txq->owner =3D 1;=0D
 	txq->cos =3D nic_dev->default_cos;=0D
 	txq->tx_deferred_start =3D tx_conf->tx_deferred_start;=0D
+	txq->tx_wqe_compact_task =3D HINIC3_SUPPORT_TX_WQE_COMPACT_TASK(nic_dev);=
=0D
 =0D
 	ci_mz =3D hinic3_dma_zone_reserve(dev, "hinic3_sq_ci", qid,=0D
 					HINIC3_CI_Q_ADDR_SIZE,=0D
@@ -1246,7 +1292,6 @@ hinic3_tx_queue_setup(struct rte_eth_dev *dev, uint16=
_t qid, uint16_t nb_desc,=0D
 		goto alloc_tx_info_fail;=0D
 	}=0D
 =0D
-	/* Record txq pointer in rte_eth tx_queues. */=0D
 	dev->data->tx_queues[qid] =3D txq;=0D
 =0D
 	return 0;=0D
@@ -1274,7 +1319,10 @@ hinic3_rx_queue_release(struct rte_eth_dev *dev, uin=
t16_t queue_id)=0D
 =0D
 	hinic3_free_rxq_mbufs(rxq);=0D
 =0D
-	hinic3_memzone_free(rxq->cqe_mz);=0D
+	if (HINIC3_SUPPORT_RX_HW_COMPACT_CQE(nic_dev))=0D
+		hinic3_memzone_free(rxq->ci_mz);=0D
+	else=0D
+		hinic3_memzone_free(rxq->cqe_mz);=0D
 =0D
 	rte_free(rxq->rx_info);=0D
 	rxq->rx_info =3D NULL;=0D
@@ -1323,9 +1371,12 @@ hinic3_tx_queue_release(struct rte_eth_dev *dev, uin=
t16_t queue_id)=0D
 static int=0D
 hinic3_dev_rx_queue_start(struct rte_eth_dev *dev, uint16_t rq_id)=0D
 {=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
 	struct hinic3_rxq *rxq =3D dev->data->rx_queues[rq_id];=0D
 	int rc;=0D
 =0D
+	rxq =3D dev->data->rx_queues[rq_id];=0D
+=0D
 	rc =3D hinic3_start_rq(dev, rxq);=0D
 	if (rc) {=0D
 		PMD_DRV_LOG(ERR,=0D
@@ -1333,14 +1384,17 @@ hinic3_dev_rx_queue_start(struct rte_eth_dev *dev, =
uint16_t rq_id)=0D
 			    dev->data->name, rq_id);=0D
 		return rc;=0D
 	}=0D
-	dev->data->rx_queue_state[rq_id] =3D RTE_ETH_QUEUE_STATE_STARTED;=0D
 =0D
-	rc =3D hinic3_enable_rxq_fdir_filter(dev, rq_id, true);=0D
-	if (rc) {=0D
-		PMD_DRV_LOG(ERR, "Failed to enable rq : %d fdir filter.",=0D
-			    rq_id);=0D
-		return rc;=0D
+	if ((hinic3_get_driver_feature(nic_dev) & NIC_F_HTN_FDIR) =3D=3D 0) {=0D
+		rc =3D hinic3_enable_rxq_fdir_filter(dev, rq_id, true);=0D
+		if (rc) {=0D
+			PMD_DRV_LOG(ERR, "Failed to enable rq : %d fdir filter.", rq_id);=0D
+			return rc;=0D
+		}=0D
 	}=0D
+=0D
+	dev->data->rx_queue_state[rq_id] =3D RTE_ETH_QUEUE_STATE_STARTED;=0D
+=0D
 	return 0;=0D
 }=0D
 =0D
@@ -1358,14 +1412,10 @@ hinic3_dev_rx_queue_start(struct rte_eth_dev *dev, =
uint16_t rq_id)=0D
 static int=0D
 hinic3_dev_rx_queue_stop(struct rte_eth_dev *dev, uint16_t rq_id)=0D
 {=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
 	struct hinic3_rxq *rxq =3D dev->data->rx_queues[rq_id];=0D
 	int rc;=0D
 =0D
-	rc =3D hinic3_enable_rxq_fdir_filter(dev, rq_id, false);=0D
-	if (rc) {=0D
-		PMD_DRV_LOG(ERR, "Failed to disable rq : %d fdir filter.", rq_id);=0D
-		return rc;=0D
-	}=0D
 	rc =3D hinic3_stop_rq(dev, rxq);=0D
 	if (rc) {=0D
 		PMD_DRV_LOG(ERR,=0D
@@ -1373,6 +1423,15 @@ hinic3_dev_rx_queue_stop(struct rte_eth_dev *dev, ui=
nt16_t rq_id)=0D
 			    dev->data->name, rq_id);=0D
 		return rc;=0D
 	}=0D
+=0D
+	if ((hinic3_get_driver_feature(nic_dev) & NIC_F_HTN_FDIR) =3D=3D 0) {=0D
+		rc =3D hinic3_enable_rxq_fdir_filter(dev, rq_id, false);=0D
+		if (rc) {=0D
+			PMD_DRV_LOG(ERR, "Failed to disable rq : %d fdir filter.", rq_id);=0D
+			return rc;=0D
+		}=0D
+	}=0D
+=0D
 	dev->data->rx_queue_state[rq_id] =3D RTE_ETH_QUEUE_STATE_STOPPED;=0D
 =0D
 	return 0;=0D
@@ -1388,6 +1447,7 @@ hinic3_dev_tx_queue_start(struct rte_eth_dev *dev, ui=
nt16_t sq_id)=0D
 =0D
 	HINIC3_SET_TXQ_STARTED(txq);=0D
 	dev->data->tx_queue_state[sq_id] =3D RTE_ETH_QUEUE_STATE_STARTED;=0D
+=0D
 	return 0;=0D
 }=0D
 =0D
@@ -1404,6 +1464,7 @@ hinic3_dev_tx_queue_stop(struct rte_eth_dev *dev, uin=
t16_t sq_id)=0D
 			    dev->data->name, sq_id);=0D
 		return rc;=0D
 	}=0D
+=0D
 	HINIC3_SET_TXQ_STOPPED(txq);=0D
 	dev->data->tx_queue_state[sq_id] =3D RTE_ETH_QUEUE_STATE_STOPPED;=0D
 =0D
@@ -3286,6 +3347,24 @@ static const struct eth_dev_ops hinic3_pmd_vf_ops =
=3D {=0D
 	.flow_ops_get                  =3D hinic3_dev_filter_ctrl,=0D
 };=0D
 =0D
+static void hinic3_nic_tx_rx_ops_init(struct hinic3_nic_dev *nic_dev)=0D
+{=0D
+	if (HINIC3_SUPPORT_TX_WQE_COMPACT_TASK(nic_dev))=0D
+		nic_dev->tx_ops->nic_tx_set_wqe_offload =3D hinic3_tx_set_compact_task_o=
ffload;=0D
+	else=0D
+		nic_dev->tx_ops->nic_tx_set_wqe_offload =3D hinic3_tx_set_normal_task_of=
fload;=0D
+=0D
+	if (HINIC3_SUPPORT_RX_HW_COMPACT_CQE(nic_dev)) {=0D
+		nic_dev->rx_ops->nic_rx_get_cqe_info =3D hinic3_rx_get_compact_cqe_info;=
=0D
+		nic_dev->rx_ops->nic_rx_cqe_done =3D hinic3_rx_integrated_cqe_done;=0D
+		nic_dev->rx_ops->nic_rx_poll_rq_empty =3D hinic3_poll_integrated_cqe_rq_=
empty;=0D
+	} else {=0D
+		nic_dev->rx_ops->nic_rx_get_cqe_info =3D hinic3_rx_get_cqe_info;=0D
+		nic_dev->rx_ops->nic_rx_cqe_done =3D hinic3_rx_separate_cqe_done;=0D
+		nic_dev->rx_ops->nic_rx_poll_rq_empty =3D hinic3_poll_rq_empty;=0D
+	}=0D
+}=0D
+=0D
 /**=0D
  * Initialize the network function, including hardware configuration, memo=
ry=0D
  * allocation for data structures, MAC address setup, and interrupt enabli=
ng.=0D
@@ -3333,6 +3412,27 @@ hinic3_func_init(struct rte_eth_dev *eth_dev)=0D
 		goto alloc_eth_addr_fail;=0D
 	}=0D
 =0D
+	nic_dev->cmdq_ops =3D rte_zmalloc("cmdq_ops", sizeof(struct hinic3_nic_cm=
dq_ops), 0);=0D
+	if (!nic_dev->cmdq_ops) {=0D
+		PMD_DRV_LOG(ERR, "Allocate cmdq_ops memory failed");=0D
+		err =3D -ENOMEM;=0D
+		goto alloc_cmdq_ops_fail;=0D
+	}=0D
+=0D
+	nic_dev->rx_ops =3D rte_zmalloc("rx_ops", sizeof(struct hinic3_nic_rx_ops=
), 0);=0D
+	if (!nic_dev->rx_ops) {=0D
+		PMD_DRV_LOG(ERR, "Allocate rx_ops memory failed");=0D
+		err =3D -ENOMEM;=0D
+		goto alloc_rx_ops_fail;=0D
+	}=0D
+=0D
+	nic_dev->tx_ops =3D rte_zmalloc("tx_ops", sizeof(struct hinic3_nic_tx_ops=
), 0);=0D
+	if (!nic_dev->tx_ops) {=0D
+		PMD_DRV_LOG(ERR, "Allocate tx_ops memory failed");=0D
+		err =3D -ENOMEM;=0D
+		goto alloc_tx_ops_fail;=0D
+	}=0D
+=0D
 	nic_dev->mc_list =3D rte_zmalloc("hinic3_mc",=0D
 		HINIC3_MAX_MC_MAC_ADDRS * sizeof(struct rte_ether_addr), 0);=0D
 	if (!nic_dev->mc_list) {=0D
@@ -3387,9 +3487,11 @@ hinic3_func_init(struct rte_eth_dev *eth_dev)=0D
 	}=0D
 =0D
 	if (!(nic_dev->feature_cap & NIC_F_HTN_CMDQ))=0D
-		nic_dev->cmdq_ops =3D hinic3_cmdq_get_stn_ops();=0D
+		nic_dev->cmdq_ops =3D hinic3_nic_cmdq_get_stn_ops();=0D
 	else=0D
-		nic_dev->cmdq_ops =3D hinic3_cmdq_get_htn_ops();=0D
+		nic_dev->cmdq_ops =3D hinic3_nic_cmdq_get_htn_ops();=0D
+=0D
+	hinic3_nic_tx_rx_ops_init(nic_dev);=0D
 =0D
 	err =3D hinic3_init_sw_rxtxqs(nic_dev);=0D
 	if (err) {=0D
@@ -3479,6 +3581,18 @@ hinic3_func_init(struct rte_eth_dev *eth_dev)=0D
 	nic_dev->mc_list =3D NULL;=0D
 =0D
 alloc_mc_list_fail:=0D
+	rte_free(nic_dev->tx_ops);=0D
+	nic_dev->tx_ops =3D NULL;=0D
+=0D
+alloc_tx_ops_fail:=0D
+	rte_free(nic_dev->rx_ops);=0D
+	nic_dev->rx_ops =3D NULL;=0D
+=0D
+alloc_rx_ops_fail:=0D
+	rte_free(nic_dev->cmdq_ops);=0D
+	nic_dev->cmdq_ops =3D NULL;=0D
+=0D
+alloc_cmdq_ops_fail:=0D
 	rte_free(eth_dev->data->mac_addrs);=0D
 	eth_dev->data->mac_addrs =3D NULL;=0D
 =0D
diff --git a/drivers/net/hinic3/hinic3_ethdev.h b/drivers/net/hinic3/hinic3=
_ethdev.h=0D
index 4a5dbb0844..3898edd076 100644=0D
--- a/drivers/net/hinic3/hinic3_ethdev.h=0D
+++ b/drivers/net/hinic3/hinic3_ethdev.h=0D
@@ -14,44 +14,50 @@=0D
 =0D
 #define PCI_DEV_TO_INTR_HANDLE(pci_dev) ((pci_dev)->intr_handle)=0D
 =0D
-#define HINIC3_PKT_RX_L4_CKSUM_BAD     RTE_MBUF_F_RX_L4_CKSUM_BAD=0D
-#define HINIC3_PKT_RX_IP_CKSUM_BAD     RTE_MBUF_F_RX_IP_CKSUM_BAD=0D
-#define HINIC3_PKT_RX_IP_CKSUM_UNKNOWN RTE_MBUF_F_RX_IP_CKSUM_UNKNOWN=0D
-#define HINIC3_PKT_RX_L4_CKSUM_GOOD    RTE_MBUF_F_RX_L4_CKSUM_GOOD=0D
-#define HINIC3_PKT_RX_IP_CKSUM_GOOD    RTE_MBUF_F_RX_IP_CKSUM_GOOD=0D
-#define HINIC3_PKT_TX_TCP_SEG	       RTE_MBUF_F_TX_TCP_SEG=0D
-#define HINIC3_PKT_TX_UDP_CKSUM	       RTE_MBUF_F_TX_UDP_CKSUM=0D
-#define HINIC3_PKT_TX_TCP_CKSUM	       RTE_MBUF_F_TX_TCP_CKSUM=0D
-#define HINIC3_PKT_TX_IP_CKSUM	       RTE_MBUF_F_TX_IP_CKSUM=0D
-#define HINIC3_PKT_TX_VLAN_PKT	       RTE_MBUF_F_TX_VLAN=0D
-#define HINIC3_PKT_TX_L4_MASK	       RTE_MBUF_F_TX_L4_MASK=0D
-#define HINIC3_PKT_TX_SCTP_CKSUM       RTE_MBUF_F_TX_SCTP_CKSUM=0D
-#define HINIC3_PKT_TX_IPV6	       RTE_MBUF_F_TX_IPV6=0D
-#define HINIC3_PKT_TX_IPV4	       RTE_MBUF_F_TX_IPV4=0D
-#define HINIC3_PKT_RX_VLAN	       RTE_MBUF_F_RX_VLAN=0D
-#define HINIC3_PKT_RX_VLAN_STRIPPED    RTE_MBUF_F_RX_VLAN_STRIPPED=0D
-#define HINIC3_PKT_RX_RSS_HASH	       RTE_MBUF_F_RX_RSS_HASH=0D
-#define HINIC3_PKT_TX_TUNNEL_MASK      RTE_MBUF_F_TX_TUNNEL_MASK=0D
-#define HINIC3_PKT_TX_TUNNEL_VXLAN     RTE_MBUF_F_TX_TUNNEL_VXLAN=0D
-#define HINIC3_PKT_TX_OUTER_IP_CKSUM   RTE_MBUF_F_TX_OUTER_IP_CKSUM=0D
-#define HINIC3_PKT_TX_OUTER_IPV6       RTE_MBUF_F_TX_OUTER_IPV6=0D
-#define HINIC3_PKT_RX_LRO	       RTE_MBUF_F_RX_LRO=0D
-#define HINIC3_PKT_TX_L4_NO_CKSUM      RTE_MBUF_F_TX_L4_NO_CKSUM=0D
+#define HINIC3_PKT_RX_L4_CKSUM_BAD	RTE_MBUF_F_RX_L4_CKSUM_BAD=0D
+#define HINIC3_PKT_RX_IP_CKSUM_BAD	RTE_MBUF_F_RX_IP_CKSUM_BAD=0D
+#define HINIC3_PKT_RX_IP_CKSUM_UNKNOWN	RTE_MBUF_F_RX_IP_CKSUM_UNKNOWN=0D
+#define HINIC3_PKT_RX_L4_CKSUM_GOOD	RTE_MBUF_F_RX_L4_CKSUM_GOOD=0D
+#define HINIC3_PKT_RX_IP_CKSUM_GOOD	RTE_MBUF_F_RX_IP_CKSUM_GOOD=0D
+#define HINIC3_PKT_TX_TCP_SEG		RTE_MBUF_F_TX_TCP_SEG=0D
+#define HINIC3_PKT_TX_UDP_CKSUM		RTE_MBUF_F_TX_UDP_CKSUM=0D
+#define HINIC3_PKT_TX_TCP_CKSUM		RTE_MBUF_F_TX_TCP_CKSUM=0D
+#define HINIC3_PKT_TX_IP_CKSUM		RTE_MBUF_F_TX_IP_CKSUM=0D
+#define HINIC3_PKT_TX_VLAN_PKT		RTE_MBUF_F_TX_VLAN=0D
+#define HINIC3_PKT_TX_QINQ_PKT		RTE_MBUF_F_TX_QINQ=0D
+#define HINIC3_PKT_TX_L4_MASK		RTE_MBUF_F_TX_L4_MASK=0D
+#define HINIC3_PKT_TX_SCTP_CKSUM	RTE_MBUF_F_TX_SCTP_CKSUM=0D
+#define HINIC3_PKT_TX_IPV6		RTE_MBUF_F_TX_IPV6=0D
+#define HINIC3_PKT_TX_IPV4		RTE_MBUF_F_TX_IPV4=0D
+#define HINIC3_PKT_RX_VLAN		RTE_MBUF_F_RX_VLAN=0D
+#define HINIC3_PKT_RX_VLAN_STRIPPED	RTE_MBUF_F_RX_VLAN_STRIPPED=0D
+#define HINIC3_PKT_RX_RSS_HASH	RTE_MBUF_F_RX_RSS_HASH=0D
+#define HINIC3_PKT_TX_TUNNEL_MASK	RTE_MBUF_F_TX_TUNNEL_MASK=0D
+#define HINIC3_PKT_TX_TUNNEL_GRE	RTE_MBUF_F_TX_TUNNEL_GRE=0D
+#define HINIC3_PKT_TX_TUNNEL_VXLAN	RTE_MBUF_F_TX_TUNNEL_VXLAN=0D
+#define HINIC3_PKT_TX_TUNNEL_VXLAN_GPE	RTE_MBUF_F_TX_TUNNEL_VXLAN_GPE=0D
+#define HINIC3_PKT_TX_TUNNEL_GENEVE	RTE_MBUF_F_TX_TUNNEL_GENEVE=0D
+#define HINIC3_PKT_TX_TUNNEL_IPIP	RTE_MBUF_F_TX_TUNNEL_IPIP=0D
+#define HINIC3_PKT_TX_OUTER_IP_CKSUM	RTE_MBUF_F_TX_OUTER_IP_CKSUM=0D
+#define HINIC3_PKT_TX_OUTER_UDP_CKSUM	RTE_MBUF_F_TX_OUTER_UDP_CKSUM=0D
+#define HINIC3_PKT_TX_OUTER_IPV6	RTE_MBUF_F_TX_OUTER_IPV6=0D
+#define HINIC3_PKT_RX_LRO		RTE_MBUF_F_RX_LRO=0D
+#define HINIC3_PKT_TX_L4_NO_CKSUM	RTE_MBUF_F_TX_L4_NO_CKSUM=0D
 =0D
 #define HINCI3_CPY_MEMPOOL_NAME "cpy_mempool"=0D
 /* Mbuf pool for copy invalid mbuf segs. */=0D
-#define HINIC3_COPY_MEMPOOL_DEPTH 1024=0D
-#define HINIC3_COPY_MEMPOOL_CACHE 128=0D
-#define HINIC3_COPY_MBUF_SIZE	  4096=0D
+#define HINIC3_COPY_MEMPOOL_DEPTH	1024=0D
+#define HINIC3_COPY_MEMPOOL_CACHE	128=0D
+#define HINIC3_COPY_MBUF_SIZE		4096=0D
 =0D
-#define HINIC3_DEV_NAME_LEN 32=0D
-#define DEV_STOP_DELAY_MS   100=0D
-#define DEV_START_DELAY_MS  100=0D
-#define HINIC3_FLUSH_QUEUE_TIMEOUT 3000=0D
+#define HINIC3_DEV_NAME_LEN		32=0D
+#define DEV_STOP_DELAY_MS		100=0D
+#define DEV_START_DELAY_MS		100=0D
+#define HINIC3_FLUSH_QUEUE_TIMEOUT	3000=0D
 =0D
-#define HINIC3_UINT32_BIT_SIZE (CHAR_BIT * sizeof(uint32_t))=0D
-#define HINIC3_VFTA_SIZE       (4096 / HINIC3_UINT32_BIT_SIZE)=0D
-#define HINIC3_MAX_QUEUE_NUM   64=0D
+#define HINIC3_UINT32_BIT_SIZE		(CHAR_BIT * sizeof(uint32_t))=0D
+#define HINIC3_VFTA_SIZE		(4096 / HINIC3_UINT32_BIT_SIZE)=0D
+#define HINIC3_MAX_QUEUE_NUM		256=0D
 =0D
 #define HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev) \=0D
 	((struct hinic3_nic_dev *)(dev)->data->dev_private)=0D
@@ -68,23 +74,34 @@ enum hinic3_tx_cvlan_type {=0D
 };=0D
 =0D
 enum nic_feature_cap {=0D
-	NIC_F_CSUM		=3D RTE_BIT32(0),=0D
-	NIC_F_SCTP_CRC		=3D RTE_BIT32(1),=0D
-	NIC_F_TSO		=3D RTE_BIT32(2),=0D
-	NIC_F_LRO		=3D RTE_BIT32(3),=0D
-	NIC_F_UFO		=3D RTE_BIT32(4),=0D
-	NIC_F_RSS		=3D RTE_BIT32(5),=0D
-	NIC_F_RX_VLAN_FILTER	=3D RTE_BIT32(6),=0D
-	NIC_F_RX_VLAN_STRIP	=3D RTE_BIT32(7),=0D
-	NIC_F_TX_VLAN_INSERT	=3D RTE_BIT32(8),=0D
-	NIC_F_VXLAN_OFFLOAD	=3D RTE_BIT32(9),=0D
-	NIC_F_IPSEC_OFFLOAD	=3D RTE_BIT32(10),=0D
-	NIC_F_FDIR		=3D RTE_BIT32(11),=0D
-	NIC_F_PROMISC		=3D RTE_BIT32(12),=0D
-	NIC_F_ALLMULTI		=3D RTE_BIT32(13),=0D
+	NIC_F_CSUM			=3D RTE_BIT32(0),=0D
+	NIC_F_SCTP_CRC			=3D RTE_BIT32(1),=0D
+	NIC_F_TSO			=3D RTE_BIT32(2),=0D
+	NIC_F_LRO			=3D RTE_BIT32(3),=0D
+	NIC_F_UFO			=3D RTE_BIT32(4),=0D
+	NIC_F_RSS			=3D RTE_BIT32(5),=0D
+	NIC_F_RX_VLAN_FILTER		=3D RTE_BIT32(6),=0D
+	NIC_F_RX_VLAN_STRIP		=3D RTE_BIT32(7),=0D
+	NIC_F_TX_VLAN_INSERT		=3D RTE_BIT32(8),=0D
+	NIC_F_VXLAN_OFFLOAD		=3D RTE_BIT32(9),=0D
+	NIC_F_IPSEC_OFFLOAD		=3D RTE_BIT32(10),=0D
+	NIC_F_FDIR			=3D RTE_BIT32(11),=0D
+	NIC_F_PROMISC			=3D RTE_BIT32(12),=0D
+	NIC_F_ALLMULTI			=3D RTE_BIT32(13),=0D
+	NIC_F_PTP_1588_V2		=3D RTE_BIT32(18),=0D
+	NIC_F_TX_WQE_COMPACT_TASK	=3D RTE_BIT32(19),=0D
+	NIC_F_RX_HW_COMPACT_CQE		=3D RTE_BIT32(20),=0D
+	NIC_F_HTN_CMDQ			=3D RTE_BIT32(21),=0D
+	NIC_F_GENEVE_OFFLOAD		=3D RTE_BIT32(22),=0D
+	NIC_F_IPXIP_OFFLOAD		=3D RTE_BIT32(23),=0D
+	NIC_F_TC_FLOWER_OFFLOAD		=3D RTE_BIT32(24),=0D
+	NIC_F_HTN_FDIR			=3D RTE_BIT32(25),=0D
+	NIC_F_SQ_RQ_CI_COALESCE		=3D RTE_BIT32(26),=0D
+	NIC_F_RX_SW_COMPACT_CQE		=3D RTE_BIT32(27),=0D
+=0D
 };=0D
 =0D
-#define DEFAULT_DRV_FEATURE 0x3FFF=0D
+#define DEFAULT_DRV_FEATURE		0x3FC3FFF=0D
 =0D
 TAILQ_HEAD(hinic3_ethertype_filter_list, rte_flow);=0D
 TAILQ_HEAD(hinic3_fdir_rule_filter_list, rte_flow);=0D
@@ -133,6 +150,10 @@ struct hinic3_nic_dev {=0D
 	struct hinic3_tcam_info tcam;=0D
 	struct hinic3_ethertype_filter_list filter_ethertype_list;=0D
 	struct hinic3_fdir_rule_filter_list filter_fdir_rule_list;=0D
+	struct hinic3_nic_cmdq_ops *cmdq_ops;=0D
+	struct hinic3_nic_rx_ops *rx_ops;=0D
+	struct hinic3_nic_tx_ops *tx_ops;=0D
+=0D
 };=0D
 =0D
 extern const struct rte_flow_ops hinic3_flow_ops;=0D
diff --git a/drivers/net/hinic3/hinic3_nic_io.c b/drivers/net/hinic3/hinic3=
_nic_io.c=0D
index 7f2972f1d1..9203dcce40 100644=0D
--- a/drivers/net/hinic3/hinic3_nic_io.c=0D
+++ b/drivers/net/hinic3/hinic3_nic_io.c=0D
@@ -11,310 +11,194 @@=0D
 #include "hinic3_rx.h"=0D
 #include "hinic3_tx.h"=0D
 =0D
-#define HINIC3_DEAULT_TX_CI_PENDING_LIMIT   3=0D
-#define HINIC3_DEAULT_TX_CI_COALESCING_TIME 16=0D
-#define HINIC3_DEAULT_DROP_THD_ON	    0xFFFF=0D
-#define HINIC3_DEAULT_DROP_THD_OFF	    0=0D
-=0D
-#define WQ_PREFETCH_MAX	      6=0D
-#define WQ_PREFETCH_MIN	      1=0D
-#define WQ_PREFETCH_THRESHOLD 256=0D
-=0D
-#define HINIC3_Q_CTXT_MAX \=0D
-	((uint16_t)(((HINIC3_CMDQ_BUF_SIZE - 8) - RTE_PKTMBUF_HEADROOM) / 64))=0D
-=0D
-enum hinic3_qp_ctxt_type {=0D
-	HINIC3_QP_CTXT_TYPE_SQ,=0D
-	HINIC3_QP_CTXT_TYPE_RQ,=0D
-};=0D
-=0D
-struct hinic3_qp_ctxt_header {=0D
-	uint16_t num_queues;=0D
-	uint16_t queue_type;=0D
-	uint16_t start_qid;=0D
-	uint16_t rsvd;=0D
-};=0D
-=0D
-struct hinic3_sq_ctxt {=0D
-	uint32_t ci_pi;=0D
-	uint32_t drop_mode_sp;    /**< Packet drop mode and special flags. */=0D
-	uint32_t wq_pfn_hi_owner; /**< High PFN and ownership flag. */=0D
-	uint32_t wq_pfn_lo;	     /**< Low bits of work queue PFN. */=0D
-=0D
-	uint32_t rsvd0;	  /**< Reserved field 0. */=0D
-	uint32_t pkt_drop_thd; /**< Packet drop threshold. */=0D
-	uint32_t global_sq_id;=0D
-	uint32_t vlan_ceq_attr; /**< VLAN and CEQ attributes. */=0D
-=0D
-	uint32_t pref_cache;	       /**< Cache prefetch settings for the queue. *=
/=0D
-	uint32_t pref_ci_owner;     /**< Prefetch settings for CI and ownership. =
*/=0D
-	uint32_t pref_wq_pfn_hi_ci; /**< Prefetch settings for high PFN and CI. *=
/=0D
-	uint32_t pref_wq_pfn_lo;    /**< Prefetch settings for low PFN. */=0D
-=0D
-	uint32_t rsvd8;	     /**< Reserved field 8. */=0D
-	uint32_t rsvd9;	     /**< Reserved field 9. */=0D
-	uint32_t wq_block_pfn_hi; /**< High bits of work queue block PFN. */=0D
-	uint32_t wq_block_pfn_lo; /**< Low bits of work queue block PFN. */=0D
-};=0D
-=0D
-struct hinic3_rq_ctxt {=0D
-	uint32_t ci_pi;=0D
-	uint32_t ceq_attr;		  /**< Completion event queue attributes. */=0D
-	uint32_t wq_pfn_hi_type_owner; /**< High PFN, WQE type and ownership flag=
. */=0D
-	uint32_t wq_pfn_lo;		  /**< Low bits of work queue PFN. */=0D
-=0D
-	uint32_t rsvd[3];	 /**< Reserved field. */=0D
-	uint32_t cqe_sge_len; /**< CQE scatter/gather element length. */=0D
-=0D
-	uint32_t pref_cache;	       /**< Cache prefetch settings for the queue. *=
/=0D
-	uint32_t pref_ci_owner;     /**< Prefetch settings for CI and ownership. =
*/=0D
-	uint32_t pref_wq_pfn_hi_ci; /**< Prefetch settings for high PFN and CI. *=
/=0D
-	uint32_t pref_wq_pfn_lo;    /**< Prefetch settings for low PFN. */=0D
-=0D
-	uint32_t pi_paddr_hi;     /**< High 32-bits of PI DMA address. */=0D
-	uint32_t pi_paddr_lo;     /**< Low 32-bits of PI DMA address. */=0D
-	uint32_t wq_block_pfn_hi; /**< High bits of work queue block PFN. */=0D
-	uint32_t wq_block_pfn_lo; /**< Low bits of work queue block PFN. */=0D
-};=0D
-=0D
-struct hinic3_sq_ctxt_block {=0D
-	struct hinic3_qp_ctxt_header cmdq_hdr;=0D
-	struct hinic3_sq_ctxt sq_ctxt[HINIC3_Q_CTXT_MAX];=0D
-};=0D
-=0D
-struct hinic3_rq_ctxt_block {=0D
-	struct hinic3_qp_ctxt_header cmdq_hdr;=0D
-	struct hinic3_rq_ctxt rq_ctxt[HINIC3_Q_CTXT_MAX];=0D
-};=0D
-=0D
-struct hinic3_clean_queue_ctxt {=0D
-	struct hinic3_qp_ctxt_header cmdq_hdr;=0D
-	uint32_t rsvd;=0D
-};=0D
-=0D
-#define SQ_CTXT_SIZE(num_sqs)                         \=0D
-	((uint16_t)(sizeof(struct hinic3_qp_ctxt_header) + \=0D
-	       (num_sqs) * sizeof(struct hinic3_sq_ctxt)))=0D
-=0D
-#define RQ_CTXT_SIZE(num_rqs)                         \=0D
-	((uint16_t)(sizeof(struct hinic3_qp_ctxt_header) + \=0D
-	       (num_rqs) * sizeof(struct hinic3_rq_ctxt)))=0D
-=0D
-#define CI_IDX_HIGH_SHIFH 12=0D
+#define HINIC3_DEAULT_TX_CI_PENDING_LIMIT	3=0D
+#define HINIC3_DEAULT_TX_CI_COALESCING_TIME	16=0D
+#define HINIC3_DEAULT_DROP_THD_ON		0xFFFF=0D
+#define HINIC3_DEAULT_DROP_THD_OFF		0=0D
+=0D
+#define WQ_PREFETCH_MAX				6=0D
+#define WQ_PREFETCH_MIN				1=0D
+#define WQ_PREFETCH_THRESHOLD			256=0D
+=0D
+#define CI_IDX_HIGH_SHIFH			12=0D
 =0D
 #define CI_HIGN_IDX(val) ((val) >> CI_IDX_HIGH_SHIFH)=0D
 =0D
-#define SQ_CTXT_PI_IDX_SHIFT 0=0D
-#define SQ_CTXT_CI_IDX_SHIFT 16=0D
+#define SQ_CTXT_PI_IDX_SHIFT			0=0D
+#define SQ_CTXT_CI_IDX_SHIFT			16=0D
 =0D
-#define SQ_CTXT_PI_IDX_MASK 0xFFFFU=0D
-#define SQ_CTXT_CI_IDX_MASK 0xFFFFU=0D
+#define SQ_CTXT_PI_IDX_MASK			0xFFFFU=0D
+#define SQ_CTXT_CI_IDX_MASK			0xFFFFU=0D
 =0D
-#define SQ_CTXT_CI_PI_SET(val, member) \=0D
+#define SQ_CTXT_CI_PI_SET(val, member)			\=0D
 	(((val) & SQ_CTXT_##member##_MASK) << SQ_CTXT_##member##_SHIFT)=0D
 =0D
-#define SQ_CTXT_MODE_SP_FLAG_SHIFT  0=0D
-#define SQ_CTXT_MODE_PKT_DROP_SHIFT 1=0D
+#define SQ_CTXT_MODE_SP_FLAG_SHIFT		0=0D
+#define SQ_CTXT_MODE_PKT_DROP_SHIFT		1=0D
 =0D
-#define SQ_CTXT_MODE_SP_FLAG_MASK  0x1U=0D
-#define SQ_CTXT_MODE_PKT_DROP_MASK 0x1U=0D
+#define SQ_CTXT_MODE_SP_FLAG_MASK		0x1U=0D
+#define SQ_CTXT_MODE_PKT_DROP_MASK		0x1U=0D
 =0D
-#define SQ_CTXT_MODE_SET(val, member)           \=0D
-	(((val) & SQ_CTXT_MODE_##member##_MASK) \=0D
+#define SQ_CTXT_MODE_SET(val, member)			\=0D
+	(((val) & SQ_CTXT_MODE_##member##_MASK)		\=0D
 	 << SQ_CTXT_MODE_##member##_SHIFT)=0D
 =0D
-#define SQ_CTXT_WQ_PAGE_HI_PFN_SHIFT 0=0D
-#define SQ_CTXT_WQ_PAGE_OWNER_SHIFT  23=0D
+#define SQ_CTXT_WQ_PAGE_HI_PFN_SHIFT		0=0D
+#define SQ_CTXT_WQ_PAGE_OWNER_SHIFT		23=0D
 =0D
-#define SQ_CTXT_WQ_PAGE_HI_PFN_MASK 0xFFFFFU=0D
-#define SQ_CTXT_WQ_PAGE_OWNER_MASK  0x1U=0D
+#define SQ_CTXT_WQ_PAGE_HI_PFN_MASK		0xFFFFFU=0D
+#define SQ_CTXT_WQ_PAGE_OWNER_MASK		0x1U=0D
 =0D
-#define SQ_CTXT_WQ_PAGE_SET(val, member)           \=0D
-	(((val) & SQ_CTXT_WQ_PAGE_##member##_MASK) \=0D
+#define SQ_CTXT_WQ_PAGE_SET(val, member)		\=0D
+	(((val) & SQ_CTXT_WQ_PAGE_##member##_MASK)	\=0D
 	 << SQ_CTXT_WQ_PAGE_##member##_SHIFT)=0D
 =0D
-#define SQ_CTXT_PKT_DROP_THD_ON_SHIFT  0=0D
-#define SQ_CTXT_PKT_DROP_THD_OFF_SHIFT 16=0D
+#define SQ_CTXT_PKT_DROP_THD_ON_SHIFT		0=0D
+#define SQ_CTXT_PKT_DROP_THD_OFF_SHIFT		16=0D
 =0D
-#define SQ_CTXT_PKT_DROP_THD_ON_MASK  0xFFFFU=0D
-#define SQ_CTXT_PKT_DROP_THD_OFF_MASK 0xFFFFU=0D
+#define SQ_CTXT_PKT_DROP_THD_ON_MASK		0xFFFFU=0D
+#define SQ_CTXT_PKT_DROP_THD_OFF_MASK		0xFFFFU=0D
 =0D
-#define SQ_CTXT_PKT_DROP_THD_SET(val, member)       \=0D
-	(((val) & SQ_CTXT_PKT_DROP_##member##_MASK) \=0D
+#define SQ_CTXT_PKT_DROP_THD_SET(val, member)		\=0D
+	(((val) & SQ_CTXT_PKT_DROP_##member##_MASK)	\=0D
 	 << SQ_CTXT_PKT_DROP_##member##_SHIFT)=0D
 =0D
-#define SQ_CTXT_GLOBAL_SQ_ID_SHIFT 0=0D
+#define SQ_CTXT_GLOBAL_SQ_ID_SHIFT		0=0D
 =0D
-#define SQ_CTXT_GLOBAL_SQ_ID_MASK 0x1FFFU=0D
+#define SQ_CTXT_GLOBAL_SQ_ID_MASK		0x1FFFU=0D
 =0D
 #define SQ_CTXT_GLOBAL_QUEUE_ID_SET(val, member) \=0D
 	(((val) & SQ_CTXT_##member##_MASK) << SQ_CTXT_##member##_SHIFT)=0D
 =0D
-#define SQ_CTXT_VLAN_TAG_SHIFT	       0=0D
-#define SQ_CTXT_VLAN_TYPE_SEL_SHIFT    16=0D
-#define SQ_CTXT_VLAN_INSERT_MODE_SHIFT 19=0D
-#define SQ_CTXT_VLAN_CEQ_EN_SHIFT      23=0D
+#define SQ_CTXT_VLAN_TAG_SHIFT			0=0D
+#define SQ_CTXT_VLAN_TYPE_SEL_SHIFT		16=0D
+#define SQ_CTXT_VLAN_INSERT_MODE_SHIFT		19=0D
+#define SQ_CTXT_VLAN_CEQ_EN_SHIFT		23=0D
 =0D
-#define SQ_CTXT_VLAN_TAG_MASK	      0xFFFFU=0D
-#define SQ_CTXT_VLAN_TYPE_SEL_MASK    0x7U=0D
-#define SQ_CTXT_VLAN_INSERT_MODE_MASK 0x3U=0D
-#define SQ_CTXT_VLAN_CEQ_EN_MASK      0x1U=0D
+#define SQ_CTXT_VLAN_TAG_MASK			0xFFFFU=0D
+#define SQ_CTXT_VLAN_TYPE_SEL_MASK		0x7U=0D
+#define SQ_CTXT_VLAN_INSERT_MODE_MASK		0x3U=0D
+#define SQ_CTXT_VLAN_CEQ_EN_MASK		0x1U=0D
 =0D
-#define SQ_CTXT_VLAN_CEQ_SET(val, member)       \=0D
-	(((val) & SQ_CTXT_VLAN_##member##_MASK) \=0D
+#define SQ_CTXT_VLAN_CEQ_SET(val, member)		\=0D
+	(((val) & SQ_CTXT_VLAN_##member##_MASK)		\=0D
 	 << SQ_CTXT_VLAN_##member##_SHIFT)=0D
 =0D
-#define SQ_CTXT_PREF_CACHE_THRESHOLD_SHIFT 0=0D
-#define SQ_CTXT_PREF_CACHE_MAX_SHIFT	   14=0D
-#define SQ_CTXT_PREF_CACHE_MIN_SHIFT	   25=0D
+#define SQ_CTXT_PREF_CACHE_THRESHOLD_SHIFT	0=0D
+#define SQ_CTXT_PREF_CACHE_MAX_SHIFT		14=0D
+#define SQ_CTXT_PREF_CACHE_MIN_SHIFT		25=0D
 =0D
-#define SQ_CTXT_PREF_CACHE_THRESHOLD_MASK 0x3FFFU=0D
-#define SQ_CTXT_PREF_CACHE_MAX_MASK	  0x7FFU=0D
-#define SQ_CTXT_PREF_CACHE_MIN_MASK	  0x7FU=0D
+#define SQ_CTXT_PREF_CACHE_THRESHOLD_MASK	0x3FFFU=0D
+#define SQ_CTXT_PREF_CACHE_MAX_MASK		0x7FFU=0D
+#define SQ_CTXT_PREF_CACHE_MIN_MASK		0x7FU=0D
 =0D
-#define SQ_CTXT_PREF_CI_HI_SHIFT 0=0D
-#define SQ_CTXT_PREF_OWNER_SHIFT 4=0D
+#define SQ_CTXT_PREF_CI_HI_SHIFT		0=0D
+#define SQ_CTXT_PREF_OWNER_SHIFT		4=0D
 =0D
-#define SQ_CTXT_PREF_CI_HI_MASK 0xFU=0D
-#define SQ_CTXT_PREF_OWNER_MASK 0x1U=0D
+#define SQ_CTXT_PREF_CI_HI_MASK			0xFU=0D
+#define SQ_CTXT_PREF_OWNER_MASK			0x1U=0D
 =0D
-#define SQ_CTXT_PREF_WQ_PFN_HI_SHIFT 0=0D
-#define SQ_CTXT_PREF_CI_LOW_SHIFT    20=0D
+#define SQ_CTXT_PREF_WQ_PFN_HI_SHIFT		0=0D
+#define SQ_CTXT_PREF_CI_LOW_SHIFT		20=0D
 =0D
-#define SQ_CTXT_PREF_WQ_PFN_HI_MASK 0xFFFFFU=0D
-#define SQ_CTXT_PREF_CI_LOW_MASK    0xFFFU=0D
+#define SQ_CTXT_PREF_WQ_PFN_HI_MASK		0xFFFFFU=0D
+#define SQ_CTXT_PREF_CI_LOW_MASK		0xFFFU=0D
 =0D
-#define SQ_CTXT_PREF_SET(val, member)           \=0D
-	(((val) & SQ_CTXT_PREF_##member##_MASK) \=0D
+#define SQ_CTXT_PREF_SET(val, member)			\=0D
+	(((val) & SQ_CTXT_PREF_##member##_MASK)		\=0D
 	 << SQ_CTXT_PREF_##member##_SHIFT)=0D
 =0D
-#define SQ_CTXT_WQ_BLOCK_PFN_HI_SHIFT 0=0D
+#define SQ_CTXT_WQ_BLOCK_PFN_HI_SHIFT		0=0D
 =0D
-#define SQ_CTXT_WQ_BLOCK_PFN_HI_MASK 0x7FFFFFU=0D
+#define SQ_CTXT_WQ_BLOCK_PFN_HI_MASK		0x7FFFFFU=0D
 =0D
-#define SQ_CTXT_WQ_BLOCK_SET(val, member)           \=0D
-	(((val) & SQ_CTXT_WQ_BLOCK_##member##_MASK) \=0D
+#define SQ_CTXT_WQ_BLOCK_SET(val, member)		\=0D
+	(((val) & SQ_CTXT_WQ_BLOCK_##member##_MASK)	\=0D
 	 << SQ_CTXT_WQ_BLOCK_##member##_SHIFT)=0D
 =0D
-#define RQ_CTXT_PI_IDX_SHIFT 0=0D
-#define RQ_CTXT_CI_IDX_SHIFT 16=0D
+#define RQ_CTXT_PI_IDX_SHIFT			0=0D
+#define RQ_CTXT_CI_IDX_SHIFT			16=0D
 =0D
-#define RQ_CTXT_PI_IDX_MASK 0xFFFFU=0D
-#define RQ_CTXT_CI_IDX_MASK 0xFFFFU=0D
+#define RQ_CTXT_PI_IDX_MASK			0xFFFFU=0D
+#define RQ_CTXT_CI_IDX_MASK			0xFFFFU=0D
 =0D
-#define RQ_CTXT_CI_PI_SET(val, member) \=0D
+#define RQ_CTXT_CI_PI_SET(val, member)			\=0D
 	(((val) & RQ_CTXT_##member##_MASK) << RQ_CTXT_##member##_SHIFT)=0D
 =0D
-#define RQ_CTXT_CEQ_ATTR_INTR_SHIFT	21=0D
-#define RQ_CTXT_CEQ_ATTR_INTR_ARM_SHIFT 30=0D
-#define RQ_CTXT_CEQ_ATTR_EN_SHIFT	31=0D
+#define RQ_CTXT_CEQ_ATTR_INTR_SHIFT		21=0D
+#define RQ_CTXT_CEQ_ATTR_INTR_ARM_SHIFT		30=0D
+#define RQ_CTXT_CEQ_ATTR_EN_SHIFT		31=0D
 =0D
-#define RQ_CTXT_CEQ_ATTR_INTR_MASK     0x3FFU=0D
-#define RQ_CTXT_CEQ_ATTR_INTR_ARM_MASK 0x1U=0D
-#define RQ_CTXT_CEQ_ATTR_EN_MASK       0x1U=0D
+#define RQ_CTXT_CEQ_ATTR_INTR_MASK		0x3FFU=0D
+#define RQ_CTXT_CEQ_ATTR_INTR_ARM_MASK		0x1U=0D
+#define RQ_CTXT_CEQ_ATTR_EN_MASK		0x1U=0D
 =0D
-#define RQ_CTXT_CEQ_ATTR_SET(val, member)           \=0D
-	(((val) & RQ_CTXT_CEQ_ATTR_##member##_MASK) \=0D
+#define RQ_CTXT_CEQ_ATTR_SET(val, member)		\=0D
+	(((val) & RQ_CTXT_CEQ_ATTR_##member##_MASK)	\=0D
 	 << RQ_CTXT_CEQ_ATTR_##member##_SHIFT)=0D
 =0D
-#define RQ_CTXT_WQ_PAGE_HI_PFN_SHIFT   0=0D
-#define RQ_CTXT_WQ_PAGE_WQE_TYPE_SHIFT 28=0D
-#define RQ_CTXT_WQ_PAGE_OWNER_SHIFT    31=0D
+#define RQ_CTXT_WQ_PAGE_HI_PFN_SHIFT		0=0D
+#define RQ_CTXT_WQ_PAGE_WQE_TYPE_SHIFT		28=0D
+#define RQ_CTXT_WQ_PAGE_OWNER_SHIFT		31=0D
 =0D
-#define RQ_CTXT_WQ_PAGE_HI_PFN_MASK   0xFFFFFU=0D
-#define RQ_CTXT_WQ_PAGE_WQE_TYPE_MASK 0x3U=0D
-#define RQ_CTXT_WQ_PAGE_OWNER_MASK    0x1U=0D
+#define RQ_CTXT_WQ_PAGE_HI_PFN_MASK		0xFFFFFU=0D
+#define RQ_CTXT_WQ_PAGE_WQE_TYPE_MASK		0x3U=0D
+#define RQ_CTXT_WQ_PAGE_OWNER_MASK		0x1U=0D
 =0D
-#define RQ_CTXT_WQ_PAGE_SET(val, member)           \=0D
-	(((val) & RQ_CTXT_WQ_PAGE_##member##_MASK) \=0D
+#define RQ_CTXT_WQ_PAGE_SET(val, member)		\=0D
+	(((val) & RQ_CTXT_WQ_PAGE_##member##_MASK)	\=0D
 	 << RQ_CTXT_WQ_PAGE_##member##_SHIFT)=0D
 =0D
-#define RQ_CTXT_CQE_LEN_SHIFT 28=0D
+#define RQ_CTXT_CQE_LEN_SHIFT			28=0D
 =0D
-#define RQ_CTXT_CQE_LEN_MASK 0x3U=0D
+#define RQ_CTXT_CQE_LEN_MASK			0x3U=0D
 =0D
-#define RQ_CTXT_CQE_LEN_SET(val, member) \=0D
+#define RQ_CTXT_CQE_LEN_SET(val, member)		\=0D
 	(((val) & RQ_CTXT_##member##_MASK) << RQ_CTXT_##member##_SHIFT)=0D
 =0D
-#define RQ_CTXT_PREF_CACHE_THRESHOLD_SHIFT 0=0D
-#define RQ_CTXT_PREF_CACHE_MAX_SHIFT	   14=0D
-#define RQ_CTXT_PREF_CACHE_MIN_SHIFT	   25=0D
+#define RQ_CTXT_PREF_CACHE_THRESHOLD_SHIFT	0=0D
+#define RQ_CTXT_PREF_CACHE_MAX_SHIFT		14=0D
+#define RQ_CTXT_PREF_CACHE_MIN_SHIFT		25=0D
 =0D
-#define RQ_CTXT_PREF_CACHE_THRESHOLD_MASK 0x3FFFU=0D
-#define RQ_CTXT_PREF_CACHE_MAX_MASK	  0x7FFU=0D
-#define RQ_CTXT_PREF_CACHE_MIN_MASK	  0x7FU=0D
+#define RQ_CTXT_PREF_CACHE_THRESHOLD_MASK	0x3FFFU=0D
+#define RQ_CTXT_PREF_CACHE_MAX_MASK		0x7FFU=0D
+#define RQ_CTXT_PREF_CACHE_MIN_MASK		0x7FU=0D
 =0D
-#define RQ_CTXT_PREF_CI_HI_SHIFT 0=0D
-#define RQ_CTXT_PREF_OWNER_SHIFT 4=0D
+#define RQ_CTXT_PREF_CI_HI_SHIFT		0=0D
+#define RQ_CTXT_PREF_OWNER_SHIFT		4=0D
 =0D
-#define RQ_CTXT_PREF_CI_HI_MASK 0xFU=0D
-#define RQ_CTXT_PREF_OWNER_MASK 0x1U=0D
+#define RQ_CTXT_PREF_CI_HI_MASK			0xFU=0D
+#define RQ_CTXT_PREF_OWNER_MASK			0x1U=0D
 =0D
-#define RQ_CTXT_PREF_WQ_PFN_HI_SHIFT 0=0D
-#define RQ_CTXT_PREF_CI_LOW_SHIFT    20=0D
+#define RQ_CTXT_PREF_WQ_PFN_HI_SHIFT		0=0D
+#define RQ_CTXT_PREF_CI_LOW_SHIFT		20=0D
 =0D
-#define RQ_CTXT_PREF_WQ_PFN_HI_MASK 0xFFFFFU=0D
-#define RQ_CTXT_PREF_CI_LOW_MASK    0xFFFU=0D
+#define RQ_CTXT_PREF_WQ_PFN_HI_MASK		0xFFFFFU=0D
+#define RQ_CTXT_PREF_CI_LOW_MASK		0xFFFU=0D
 =0D
-#define RQ_CTXT_PREF_SET(val, member)           \=0D
-	(((val) & RQ_CTXT_PREF_##member##_MASK) \=0D
+#define RQ_CTXT_PREF_SET(val, member)			\=0D
+	(((val) & RQ_CTXT_PREF_##member##_MASK)		\=0D
 	 << RQ_CTXT_PREF_##member##_SHIFT)=0D
 =0D
-#define RQ_CTXT_WQ_BLOCK_PFN_HI_SHIFT 0=0D
+#define RQ_CTXT_WQ_BLOCK_PFN_HI_SHIFT		0=0D
 =0D
-#define RQ_CTXT_WQ_BLOCK_PFN_HI_MASK 0x7FFFFFU=0D
+#define RQ_CTXT_WQ_BLOCK_PFN_HI_MASK		0x7FFFFFU=0D
 =0D
-#define RQ_CTXT_WQ_BLOCK_SET(val, member)           \=0D
-	(((val) & RQ_CTXT_WQ_BLOCK_##member##_MASK) \=0D
+#define RQ_CTXT_WQ_BLOCK_SET(val, member)		\=0D
+	(((val) & RQ_CTXT_WQ_BLOCK_##member##_MASK)	\=0D
 	 << RQ_CTXT_WQ_BLOCK_##member##_SHIFT)=0D
 =0D
 #define SIZE_16BYTES(size) (RTE_ALIGN((size), 16) >> 4)=0D
 =0D
-#define WQ_PAGE_PFN_SHIFT  12=0D
-#define WQ_BLOCK_PFN_SHIFT 9=0D
+#define WQ_PAGE_PFN_SHIFT			12=0D
+#define WQ_BLOCK_PFN_SHIFT			9=0D
 =0D
 #define WQ_PAGE_PFN(page_addr)	((page_addr) >> WQ_PAGE_PFN_SHIFT)=0D
 #define WQ_BLOCK_PFN(page_addr) ((page_addr) >> WQ_BLOCK_PFN_SHIFT)=0D
 =0D
-/**=0D
- * Prepare the command queue header and converted it to big-endian format.=
=0D
- *=0D
- * @param[out] qp_ctxt_hdr=0D
- * Pointer to command queue context header structure to be initialized.=0D
- * @param[in] ctxt_type=0D
- * Type of context (SQ/RQ) to be set in header.=0D
- * @param[in] num_queues=0D
- * Number of queues.=0D
- * @param[in] q_id=0D
- * Starting queue ID for this context.=0D
- */=0D
-static void=0D
-hinic3_qp_prepare_cmdq_header(struct hinic3_qp_ctxt_header *qp_ctxt_hdr,=0D
-			      enum hinic3_qp_ctxt_type ctxt_type,=0D
-			      uint16_t num_queues, uint16_t q_id)=0D
-{=0D
-	qp_ctxt_hdr->queue_type =3D ctxt_type;=0D
-	qp_ctxt_hdr->num_queues =3D num_queues;=0D
-	qp_ctxt_hdr->start_qid =3D q_id;=0D
-	qp_ctxt_hdr->rsvd =3D 0;=0D
-=0D
-	rte_atomic_thread_fence(rte_memory_order_seq_cst);=0D
+#define CQE_CTX_CI_ADDR_SHIFT			4=0D
 =0D
-	hinic3_cpu_to_be32(qp_ctxt_hdr, sizeof(*qp_ctxt_hdr));=0D
-}=0D
-=0D
-/**=0D
- * Initialize context structure for specified TXQ by configuring various q=
ueue=0D
- * parameters (e.g., ci, pi, work queue page addresses).=0D
- *=0D
- * @param[in] sq=0D
- * Pointer to TXQ structure.=0D
- * @param[in] sq_id=0D
- * ID of TXQ being configured.=0D
- * @param[out] sq_ctxt=0D
- * Pointer to structure that will hold TXQ context.=0D
- */=0D
-static void=0D
+void=0D
 hinic3_sq_prepare_ctxt(struct hinic3_txq *sq, uint16_t sq_id,=0D
 		       struct hinic3_sq_ctxt *sq_ctxt)=0D
 {=0D
@@ -386,22 +270,13 @@ hinic3_sq_prepare_ctxt(struct hinic3_txq *sq, uint16_=
t sq_id,=0D
 	hinic3_cpu_to_be32(sq_ctxt, sizeof(*sq_ctxt));=0D
 }=0D
 =0D
-/**=0D
- * Initialize context structure for specified RXQ by configuring various q=
ueue=0D
- * parameters (e.g., ci, pi, work queue page addresses).=0D
- *=0D
- * @param[in] rq=0D
- * Pointer to RXQ structure.=0D
- * @param[out] rq_ctxt=0D
- * Pointer to structure that will hold RXQ context.=0D
- */=0D
-static void=0D
+void=0D
 hinic3_rq_prepare_ctxt(struct hinic3_rxq *rq, struct hinic3_rq_ctxt *rq_ct=
xt)=0D
 {=0D
 	uint64_t wq_page_addr, wq_page_pfn, wq_block_pfn;=0D
 	uint32_t wq_page_pfn_hi, wq_page_pfn_lo, wq_block_pfn_hi, wq_block_pfn_lo=
;=0D
 	uint16_t pi_start, ci_start;=0D
-	uint16_t wqe_type =3D rq->wqebb_shift - HINIC3_RQ_WQEBB_SHIFT;=0D
+	uint16_t wqe_type =3D rq->wqe_type;=0D
 	uint8_t intr_disable;=0D
 =0D
 	/* RQ depth is in unit of 8 Bytes. */=0D
@@ -446,6 +321,10 @@ hinic3_rq_prepare_ctxt(struct hinic3_rxq *rq, struct h=
inic3_rq_ctxt *rq_ctxt)=0D
 			RQ_CTXT_WQ_PAGE_SET(2, WQE_TYPE);=0D
 		rq_ctxt->cqe_sge_len =3D RQ_CTXT_CQE_LEN_SET(1, CQE_LEN);=0D
 		break;=0D
+	case HINIC3_COMPACT_RQ_WQE:=0D
+		/* Use 8Byte WQE without SGE for CQE. */=0D
+		rq_ctxt->wq_pfn_hi_type_owner |=3D RQ_CTXT_WQ_PAGE_SET(3, WQE_TYPE);=0D
+		break;=0D
 	default:=0D
 		PMD_DRV_LOG(INFO, "Invalid rq wqe type: %u", wqe_type);=0D
 	}=0D
@@ -495,12 +374,10 @@ hinic3_rq_prepare_ctxt(struct hinic3_rxq *rq, struct =
hinic3_rq_ctxt *rq_ctxt)=0D
 static int=0D
 init_sq_ctxts(struct hinic3_nic_dev *nic_dev)=0D
 {=0D
-	struct hinic3_sq_ctxt_block *sq_ctxt_block =3D NULL;=0D
-	struct hinic3_sq_ctxt *sq_ctxt =3D NULL;=0D
 	struct hinic3_cmd_buf *cmd_buf =3D NULL;=0D
-	struct hinic3_txq *sq =3D NULL;=0D
 	uint64_t out_param =3D 0;=0D
-	uint16_t q_id, curr_id, max_ctxts, i;=0D
+	uint16_t q_id, max_ctxts;=0D
+	uint8_t cmd;=0D
 	int err =3D 0;=0D
 =0D
 	cmd_buf =3D hinic3_alloc_cmd_buf(nic_dev->hwdev);=0D
@@ -511,28 +388,14 @@ init_sq_ctxts(struct hinic3_nic_dev *nic_dev)=0D
 =0D
 	q_id =3D 0;=0D
 	while (q_id < nic_dev->num_sqs) {=0D
-		sq_ctxt_block =3D cmd_buf->buf;=0D
-		sq_ctxt =3D sq_ctxt_block->sq_ctxt;=0D
-=0D
 		max_ctxts =3D (nic_dev->num_sqs - q_id) > HINIC3_Q_CTXT_MAX=0D
 				    ? HINIC3_Q_CTXT_MAX=0D
 				    : (nic_dev->num_sqs - q_id);=0D
-=0D
-		hinic3_qp_prepare_cmdq_header(&sq_ctxt_block->cmdq_hdr,=0D
-					      HINIC3_QP_CTXT_TYPE_SQ,=0D
-					      max_ctxts, q_id);=0D
-=0D
-		for (i =3D 0; i < max_ctxts; i++) {=0D
-			curr_id =3D q_id + i;=0D
-			sq =3D nic_dev->txqs[curr_id];=0D
-			hinic3_sq_prepare_ctxt(sq, curr_id, &sq_ctxt[i]);=0D
-		}=0D
-=0D
-		cmd_buf->size =3D SQ_CTXT_SIZE(max_ctxts);=0D
+		cmd =3D nic_dev->cmdq_ops->prepare_cmd_buf_qp_context_multi_store(nic_de=
v, cmd_buf,=0D
+			HINIC3_QP_CTXT_TYPE_SQ, q_id, max_ctxts);=0D
 		rte_atomic_thread_fence(rte_memory_order_seq_cst);=0D
 		err =3D hinic3_cmdq_direct_resp(nic_dev->hwdev, HINIC3_MOD_L2NIC,=0D
-					      HINIC3_UCODE_CMD_MODIFY_QUEUE_CTX,=0D
-					      cmd_buf, &out_param, 0);=0D
+					      cmd, cmd_buf, &out_param, 0);=0D
 		if (err || out_param !=3D 0) {=0D
 			PMD_DRV_LOG(ERR,=0D
 				    "Set SQ ctxts failed, err: %d, out_param: %" PRIu64,=0D
@@ -563,12 +426,10 @@ init_sq_ctxts(struct hinic3_nic_dev *nic_dev)=0D
 static int=0D
 init_rq_ctxts(struct hinic3_nic_dev *nic_dev)=0D
 {=0D
-	struct hinic3_rq_ctxt_block *rq_ctxt_block =3D NULL;=0D
-	struct hinic3_rq_ctxt *rq_ctxt =3D NULL;=0D
 	struct hinic3_cmd_buf *cmd_buf =3D NULL;=0D
-	struct hinic3_rxq *rq =3D NULL;=0D
 	uint64_t out_param =3D 0;=0D
-	uint16_t q_id, curr_id, max_ctxts, i;=0D
+	uint16_t q_id, max_ctxts;=0D
+	uint8_t cmd;=0D
 	int err =3D 0;=0D
 =0D
 	cmd_buf =3D hinic3_alloc_cmd_buf(nic_dev->hwdev);=0D
@@ -579,28 +440,14 @@ init_rq_ctxts(struct hinic3_nic_dev *nic_dev)=0D
 =0D
 	q_id =3D 0;=0D
 	while (q_id < nic_dev->num_rqs) {=0D
-		rq_ctxt_block =3D cmd_buf->buf;=0D
-		rq_ctxt =3D rq_ctxt_block->rq_ctxt;=0D
-=0D
 		max_ctxts =3D (nic_dev->num_rqs - q_id) > HINIC3_Q_CTXT_MAX=0D
 				    ? HINIC3_Q_CTXT_MAX=0D
 				    : (nic_dev->num_rqs - q_id);=0D
-=0D
-		hinic3_qp_prepare_cmdq_header(&rq_ctxt_block->cmdq_hdr,=0D
-					      HINIC3_QP_CTXT_TYPE_RQ,=0D
-					      max_ctxts, q_id);=0D
-=0D
-		for (i =3D 0; i < max_ctxts; i++) {=0D
-			curr_id =3D q_id + i;=0D
-			rq =3D nic_dev->rxqs[curr_id];=0D
-			hinic3_rq_prepare_ctxt(rq, &rq_ctxt[i]);=0D
-		}=0D
-=0D
-		cmd_buf->size =3D RQ_CTXT_SIZE(max_ctxts);=0D
+		cmd =3D nic_dev->cmdq_ops->prepare_cmd_buf_qp_context_multi_store(nic_de=
v, cmd_buf,=0D
+			HINIC3_QP_CTXT_TYPE_RQ, q_id, max_ctxts);=0D
 		rte_atomic_thread_fence(rte_memory_order_seq_cst);=0D
 		err =3D hinic3_cmdq_direct_resp(nic_dev->hwdev, HINIC3_MOD_L2NIC,=0D
-					      HINIC3_UCODE_CMD_MODIFY_QUEUE_CTX,=0D
-					      cmd_buf, &out_param, 0);=0D
+					      cmd, cmd_buf, &out_param, 0);=0D
 		if (err || out_param !=3D 0) {=0D
 			PMD_DRV_LOG(ERR,=0D
 				    "Set RQ ctxts failed, err: %d, out_param: %" PRIu64,=0D
@@ -633,9 +480,9 @@ static int=0D
 clean_queue_offload_ctxt(struct hinic3_nic_dev *nic_dev,=0D
 			 enum hinic3_qp_ctxt_type ctxt_type)=0D
 {=0D
-	struct hinic3_clean_queue_ctxt *ctxt_block =3D NULL;=0D
 	struct hinic3_cmd_buf *cmd_buf;=0D
 	uint64_t out_param =3D 0;=0D
+	uint8_t cmd;=0D
 	int err;=0D
 =0D
 	cmd_buf =3D hinic3_alloc_cmd_buf(nic_dev->hwdev);=0D
@@ -644,26 +491,11 @@ clean_queue_offload_ctxt(struct hinic3_nic_dev *nic_d=
ev,=0D
 		return -ENOMEM;=0D
 	}=0D
 =0D
-	/* Construct related command request. */=0D
-	ctxt_block =3D cmd_buf->buf;=0D
-	/* Assumed max_rqs must be equal to max_sqs. */=0D
-	ctxt_block->cmdq_hdr.num_queues =3D nic_dev->max_sqs;=0D
-	ctxt_block->cmdq_hdr.queue_type =3D ctxt_type;=0D
-	ctxt_block->cmdq_hdr.start_qid =3D 0;=0D
-	/*=0D
-	 * Add a memory barrier to ensure that instructions are not out of order=
=0D
-	 * due to compilation optimization.=0D
-	 */=0D
-	rte_atomic_thread_fence(rte_memory_order_seq_cst);=0D
-=0D
-	hinic3_cpu_to_be32(ctxt_block, sizeof(*ctxt_block));=0D
-=0D
-	cmd_buf->size =3D sizeof(*ctxt_block);=0D
+	cmd =3D nic_dev->cmdq_ops->prepare_cmd_buf_clean_tso_lro_space(nic_dev, c=
md_buf, ctxt_type);=0D
 =0D
 	/* Send a command to hardware to clean up queue offload context. */=0D
 	err =3D hinic3_cmdq_direct_resp(nic_dev->hwdev, HINIC3_MOD_L2NIC,=0D
-				      HINIC3_UCODE_CMD_CLEAN_QUEUE_CONTEXT,=0D
-				      cmd_buf, &out_param, 0);=0D
+				      cmd, cmd_buf, &out_param, 0);=0D
 	if ((err) || (out_param)) {=0D
 		PMD_DRV_LOG(ERR,=0D
 			    "Clean queue offload ctxts failed, err: %d, out_param: %" PRIu64,=0D
@@ -705,6 +537,62 @@ hinic3_get_func_rx_buf_size(struct hinic3_nic_dev *nic=
_dev)=0D
 	nic_dev->rx_buff_len =3D buf_size;=0D
 }=0D
 =0D
+#define HINIC3_RX_CQE_TIMER_LOOP		15=0D
+#define HINIC3_RX_CQE_COALESCE_NUM		63=0D
+=0D
+int=0D
+hinic3_init_rq_cqe_ctxts(struct hinic3_nic_dev *nic_dev)=0D
+{=0D
+	struct hinic3_hwdev *hwdev =3D NULL;=0D
+	struct hinic3_rxq *rxq =3D NULL;=0D
+	struct hinic3_rq_cqe_ctx cqe_ctx =3D { 0 };=0D
+	rte_iova_t rq_ci_paddr;=0D
+	uint16_t out_size =3D sizeof(cqe_ctx);=0D
+	uint16_t q_id =3D 0;=0D
+	uint16_t cmd;=0D
+	int err;=0D
+=0D
+	if (!nic_dev)=0D
+		return -EINVAL;=0D
+=0D
+	hwdev =3D nic_dev->hwdev;=0D
+=0D
+	if (hinic3_get_driver_feature(nic_dev) & NIC_F_HTN_CMDQ)=0D
+		cmd =3D HINIC3_NIC_CMD_SET_RQ_CI_CTX_HTN;=0D
+	else=0D
+		cmd =3D HINIC3_NIC_CMD_SET_RQ_CI_CTX;=0D
+=0D
+	while (q_id < nic_dev->num_rqs) {=0D
+		rxq =3D nic_dev->rxqs[q_id];=0D
+		if (rxq->wqe_type =3D=3D HINIC3_COMPACT_RQ_WQE) {=0D
+			rq_ci_paddr =3D rxq->rq_ci_paddr >> CQE_CTX_CI_ADDR_SHIFT;=0D
+			cqe_ctx.ci_addr_hi =3D upper_32_bits(rq_ci_paddr);=0D
+			cqe_ctx.ci_addr_lo =3D lower_32_bits(rq_ci_paddr);=0D
+			cqe_ctx.threshold_cqe_num =3D HINIC3_RX_CQE_COALESCE_NUM;=0D
+			cqe_ctx.timer_loop =3D HINIC3_RX_CQE_TIMER_LOOP;=0D
+		} else {=0D
+			cqe_ctx.threshold_cqe_num =3D 0;=0D
+			cqe_ctx.timer_loop =3D 0;=0D
+		}=0D
+=0D
+		cqe_ctx.cqe_type =3D (rxq->wqe_type =3D=3D HINIC3_COMPACT_RQ_WQE);=0D
+		cqe_ctx.msix_entry_idx =3D rxq->msix_entry_idx;=0D
+		cqe_ctx.rq_id =3D q_id;=0D
+=0D
+		err =3D hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC, cmd,=0D
+					      &cqe_ctx, sizeof(cqe_ctx),=0D
+					      &cqe_ctx, &out_size);=0D
+		if (err || !out_size || cqe_ctx.msg_head.status) {=0D
+			PMD_DRV_LOG(ERR, "Set rq cqe context failed, qid: %d, err: %d, status: =
0x%x, out_size: 0x%x",=0D
+				    q_id, err, cqe_ctx.msg_head.status, out_size);=0D
+			return -EFAULT;=0D
+		}=0D
+		q_id++;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
 int=0D
 hinic3_init_qp_ctxts(struct hinic3_nic_dev *nic_dev)=0D
 {=0D
@@ -768,13 +656,50 @@ hinic3_init_qp_ctxts(struct hinic3_nic_dev *nic_dev)=
=0D
 		}=0D
 	}=0D
 =0D
+	if (HINIC3_SUPPORT_RX_HW_COMPACT_CQE(nic_dev)) {=0D
+		/* Init Rxq CQE context. */=0D
+		err =3D hinic3_init_rq_cqe_ctxts(nic_dev);=0D
+		if (err) {=0D
+			PMD_DRV_LOG(ERR, "Set rq cqe context failed");=0D
+			goto set_cqe_ctx_fail;=0D
+		}=0D
+	}=0D
+=0D
 	return 0;=0D
 =0D
+set_cqe_ctx_fail:=0D
 set_cons_idx_table_err:=0D
 	hinic3_clean_root_ctxt(hwdev);=0D
 	return err;=0D
 }=0D
 =0D
+int=0D
+hinic3_set_rq_enable(struct hinic3_nic_dev *nic_dev, uint16_t q_id, bool e=
nable)=0D
+{=0D
+	struct hinic3_hwdev *hwdev =3D NULL;=0D
+	struct hinic3_rq_enable msg;=0D
+	uint16_t out_size =3D sizeof(msg);=0D
+	int err;=0D
+=0D
+	if (!nic_dev)=0D
+		return -EINVAL;=0D
+=0D
+	hwdev =3D nic_dev->hwdev;=0D
+=0D
+	memset(&msg, 0, sizeof(msg));=0D
+	msg.rq_enable =3D enable;=0D
+	msg.rq_id =3D q_id;=0D
+	err =3D hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC, HINIC3_NIC_CMD_S=
ET_RQ_ENABLE_HTN,=0D
+				      &msg, sizeof(msg), &msg, &out_size);=0D
+	if (err || !out_size || msg.msg_head.status) {=0D
+		PMD_DRV_LOG(ERR, "Set rq enable failed, qid: %u, enable: %d, err: %d, st=
atus: 0x%x, out_size: 0x%x",=0D
+			    q_id, enable, err, msg.msg_head.status, out_size);=0D
+		return -EFAULT;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
 void=0D
 hinic3_free_qp_ctxts(struct hinic3_hwdev *hwdev)=0D
 {=0D
diff --git a/drivers/net/hinic3/hinic3_nic_io.h b/drivers/net/hinic3/hinic3=
_nic_io.h=0D
index c8e690981b..d0acba4cf4 100644=0D
--- a/drivers/net/hinic3/hinic3_nic_io.h=0D
+++ b/drivers/net/hinic3/hinic3_nic_io.h=0D
@@ -28,11 +28,6 @@=0D
 =0D
 #define HINIC3_Q_CTXT_MAX ((uint16_t)(((HINIC3_CMDQ_BUF_SIZE - 8) - RTE_PK=
TMBUF_HEADROOM) / 64))=0D
 =0D
-#define SQ_CTXT_SIZE(num_sqs) ((uint16_t)(sizeof(struct hinic3_qp_ctxt_hea=
der) \=0D
-					  + (num_sqs) * sizeof(struct hinic3_sq_ctxt)))=0D
-#define RQ_CTXT_SIZE(num_rqs) ((uint16_t)(sizeof(struct hinic3_qp_ctxt_hea=
der) \=0D
-					  + (num_rqs) * sizeof(struct hinic3_rq_ctxt)))=0D
-=0D
 enum hinic3_rq_wqe_type {=0D
 	HINIC3_COMPACT_RQ_WQE,=0D
 	HINIC3_NORMAL_RQ_WQE,=0D
@@ -231,6 +226,31 @@ hinic3_write_db(void *db_addr, uint16_t q_id, int cos,=
 uint8_t cflag, uint16_t p=0D
  */=0D
 void hinic3_get_func_rx_buf_size(struct hinic3_nic_dev *nic_dev);=0D
 =0D
+/**=0D
+ * Initialize RQ integrated CQE context=0D
+ *=0D
+ * @param[in] nic_dev=0D
+ * Pointer to ethernet device structure.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_init_rq_cqe_ctxts(struct hinic3_nic_dev *nic_dev);=0D
+=0D
+/**=0D
+ * Set RQ disable or enable=0D
+ *=0D
+ * @param[in] nic_dev=0D
+ * Pointer to ethernet device structure.=0D
+ * @param[in] q_id=0D
+ * Receive queue id.=0D
+ * @param[in] enable=0D
+ *   1: enable  0: disable=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_set_rq_enable(struct hinic3_nic_dev *nic_dev, uint16_t q_id, bo=
ol enable);=0D
+=0D
 /**=0D
  * Initialize qps contexts, set SQ ci attributes, arm all SQ.=0D
  *=0D
@@ -268,7 +288,8 @@ struct hinic3_nic_cmdq_ops *hinic3_cmdq_get_stn_ops(voi=
d);=0D
 /**=0D
  * Get cmdq ops hardware tile NIC(htn) supported.=0D
  *=0D
- * @retval Pointer to ops.=0D
+ * @return=0D
+ * Pointer to ops.=0D
  */=0D
 struct hinic3_nic_cmdq_ops *hinic3_cmdq_get_htn_ops(void);=0D
 =0D
@@ -279,9 +300,6 @@ struct hinic3_nic_cmdq_ops *hinic3_cmdq_get_htn_ops(voi=
d);=0D
  * Pointer to ethernet device structure.=0D
  * @param[out] s_feature=0D
  * s_feature driver supported.=0D
- *=0D
- * @return=0D
- * 0 on success, non-zero on failure.=0D
  */=0D
 void hinic3_update_driver_feature(struct hinic3_nic_dev *nic_dev, uint64_t=
 s_feature);=0D
 =0D
@@ -296,4 +314,29 @@ void hinic3_update_driver_feature(struct hinic3_nic_de=
v *nic_dev, uint64_t s_fea=0D
  */=0D
 uint64_t hinic3_get_driver_feature(struct hinic3_nic_dev *nic_dev);=0D
 =0D
+/**=0D
+ * Initialize context structure for specified TXQ by configuring various q=
ueue=0D
+ * parameters (e.g., ci, pi, work queue page addresses).=0D
+ *=0D
+ * @param[in] sq=0D
+ * Pointer to TXQ structure.=0D
+ * @param[in] sq_id=0D
+ * ID of TXQ being configured.=0D
+ * @param[out] sq_ctxt=0D
+ * Pointer to structure that will hold TXQ context.=0D
+ */=0D
+void hinic3_sq_prepare_ctxt(struct hinic3_txq *sq, uint16_t sq_id,=0D
+			    struct hinic3_sq_ctxt *sq_ctxt);=0D
+=0D
+/**=0D
+ * Initialize context structure for specified RXQ by configuring various q=
ueue=0D
+ * parameters (e.g., ci, pi, work queue page addresses).=0D
+ *=0D
+ * @param[in] rq=0D
+ * Pointer to RXQ structure.=0D
+ * @param[out] rq_ctxt=0D
+ * Pointer to structure that will hold RXQ context.=0D
+ */=0D
+void hinic3_rq_prepare_ctxt(struct hinic3_rxq *rq, struct hinic3_rq_ctxt *=
rq_ctxt);=0D
+=0D
 #endif /* _HINIC3_NIC_IO_H_ */=0D
diff --git a/drivers/net/hinic3/hinic3_rx.h b/drivers/net/hinic3/hinic3_rx.=
h=0D
index 1a92df59b7..7ae39e3e91 100644=0D
--- a/drivers/net/hinic3/hinic3_rx.h=0D
+++ b/drivers/net/hinic3/hinic3_rx.h=0D
@@ -279,6 +279,24 @@ struct __rte_cache_aligned hinic3_rxq {=0D
 #endif=0D
 };=0D
 =0D
+/* Rx CQE info get callback function */=0D
+typedef void  (*nic_rx_get_cqe_info_t)(struct hinic3_rxq *rxq,=0D
+				       volatile struct hinic3_rq_cqe *rx_cqe,=0D
+				       struct hinic3_cqe_info *cqe_info);=0D
+=0D
+/* Rx CQE check status callback function */=0D
+typedef bool  (*nic_rx_cqe_done_t)(struct hinic3_rxq *rxq,=0D
+				   volatile struct hinic3_rq_cqe **rx_cqe);=0D
+=0D
+/* Rx CQE empty poll callback function */=0D
+typedef int   (*nic_rx_poll_rq_empty_t)(struct hinic3_rxq *rxq);=0D
+=0D
+struct hinic3_nic_rx_ops {=0D
+	nic_rx_get_cqe_info_t		nic_rx_get_cqe_info;=0D
+	nic_rx_cqe_done_t		nic_rx_cqe_done;=0D
+	nic_rx_poll_rq_empty_t		nic_rx_poll_rq_empty;=0D
+};=0D
+=0D
 uint16_t hinic3_rx_fill_wqe(struct hinic3_rxq *rxq);=0D
 =0D
 uint16_t hinic3_rx_fill_buffers(struct hinic3_rxq *rxq);=0D
diff --git a/drivers/net/hinic3/hinic3_tx.h b/drivers/net/hinic3/hinic3_tx.=
h=0D
index d150f7c6a4..21958a00cc 100644=0D
--- a/drivers/net/hinic3/hinic3_tx.h=0D
+++ b/drivers/net/hinic3/hinic3_tx.h=0D
@@ -304,6 +304,14 @@ struct __rte_cache_aligned hinic3_txq {=0D
 #endif=0D
 };=0D
 =0D
+/* Tx WQE offload set callback function */=0D
+typedef void  (*nic_tx_set_wqe_offload_t)(struct hinic3_wqe_info *wqe_info=
,=0D
+					  struct hinic3_sq_wqe_combo *wqe_combo);=0D
+=0D
+struct hinic3_nic_tx_ops {=0D
+	nic_tx_set_wqe_offload_t	nic_tx_set_wqe_offload;=0D
+};=0D
+=0D
 void hinic3_flush_txqs(struct hinic3_nic_dev *nic_dev);=0D
 void hinic3_free_txq_mbufs(struct hinic3_txq *txq);=0D
 void hinic3_free_all_txq_mbufs(struct hinic3_nic_dev *nic_dev);=0D
diff --git a/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.c b/drivers/net/h=
inic3/htn_adapt/hinic3_htn_cmdq.c=0D
index d997647f48..634dfe7239 100644=0D
--- a/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.c=0D
+++ b/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.c=0D
@@ -8,11 +8,16 @@=0D
 #include "hinic3_hwif.h"=0D
 #include "hinic3_htn_cmdq.h"=0D
 =0D
+#define HTN_SQ_CTXT_SIZE(num_sqs)	((uint16_t)(sizeof(struct hinic3_htn_qp_=
ctxt_header) \=0D
+						    + (num_sqs) * sizeof(struct hinic3_sq_ctxt)))=0D
+#define HTN_RQ_CTXT_SIZE(num_rqs)	((uint16_t)(sizeof(struct hinic3_htn_qp_=
ctxt_header) \=0D
+						    + (num_rqs) * sizeof(struct hinic3_rq_ctxt)))=0D
+=0D
 static uint8_t prepare_cmd_buf_clean_tso_lro_space(struct hinic3_nic_dev *=
nic_dev,=0D
 						   struct hinic3_cmd_buf *cmd_buf,=0D
 						   enum hinic3_qp_ctxt_type ctxt_type)=0D
 {=0D
-	struct hinic3_clean_queue_ctxt *ctxt_block =3D NULL;=0D
+	struct hinic3_htn_clean_queue_ctxt *ctxt_block =3D NULL;=0D
 =0D
 	ctxt_block =3D cmd_buf->buf;=0D
 	ctxt_block->cmdq_hdr.num_queues =3D nic_dev->max_sqs;=0D
@@ -27,7 +32,7 @@ static uint8_t prepare_cmd_buf_clean_tso_lro_space(struct=
 hinic3_nic_dev *nic_de=0D
 	return HINIC3_HTN_CMD_TSO_LRO_SPACE_CLEAN;=0D
 }=0D
 =0D
-static void qp_prepare_cmdq_header(struct hinic3_qp_ctxt_header *qp_ctxt_h=
dr,=0D
+static void qp_prepare_cmdq_header(struct hinic3_htn_qp_ctxt_header *qp_ct=
xt_hdr,=0D
 				   enum hinic3_qp_ctxt_type ctxt_type, uint16_t num_queues,=0D
 				   uint16_t q_id, uint16_t func_id)=0D
 {=0D
@@ -45,7 +50,7 @@ static uint8_t prepare_cmd_buf_qp_context_multi_store(str=
uct hinic3_nic_dev *nic=0D
 						      enum hinic3_qp_ctxt_type ctxt_type,=0D
 						      uint16_t start_qid, uint16_t max_ctxts)=0D
 {=0D
-	struct hinic3_qp_ctxt_block *qp_ctxt_block =3D NULL;=0D
+	struct hinic3_htn_qp_ctxt_block *qp_ctxt_block =3D NULL;=0D
 	uint16_t func_id;=0D
 	uint16_t i;=0D
 =0D
@@ -65,9 +70,9 @@ static uint8_t prepare_cmd_buf_qp_context_multi_store(str=
uct hinic3_nic_dev *nic=0D
 	}=0D
 =0D
 	if (ctxt_type =3D=3D HINIC3_QP_CTXT_TYPE_RQ)=0D
-		cmd_buf->size =3D RQ_CTXT_SIZE(max_ctxts);=0D
+		cmd_buf->size =3D HTN_RQ_CTXT_SIZE(max_ctxts);=0D
 	else=0D
-		cmd_buf->size =3D SQ_CTXT_SIZE(max_ctxts);=0D
+		cmd_buf->size =3D HTN_SQ_CTXT_SIZE(max_ctxts);=0D
 =0D
 	return HINIC3_HTN_CMD_SQ_RQ_CONTEXT_MULTI_ST;=0D
 }=0D
@@ -75,10 +80,10 @@ static uint8_t prepare_cmd_buf_qp_context_multi_store(s=
truct hinic3_nic_dev *nic=0D
 static uint8_t prepare_cmd_buf_modify_svlan(struct hinic3_cmd_buf *cmd_buf=
,=0D
 			uint16_t func_id, uint16_t vlan_tag, uint16_t q_id, uint8_t vlan_mode)=
=0D
 {=0D
-	struct hinic3_vlan_ctx *vlan_ctx =3D NULL;=0D
+	struct hinic3_htn_vlan_ctx *vlan_ctx =3D NULL;=0D
 =0D
-	cmd_buf->size =3D sizeof(struct hinic3_vlan_ctx);=0D
-	vlan_ctx =3D (struct hinic3_vlan_ctx *)cmd_buf->buf;=0D
+	cmd_buf->size =3D sizeof(struct hinic3_htn_vlan_ctx);=0D
+	vlan_ctx =3D (struct hinic3_htn_vlan_ctx *)cmd_buf->buf;=0D
 =0D
 	vlan_ctx->dest_func_id =3D func_id;=0D
 	vlan_ctx->start_qid =3D q_id;=0D
@@ -87,7 +92,8 @@ static uint8_t prepare_cmd_buf_modify_svlan(struct hinic3=
_cmd_buf *cmd_buf,=0D
 	vlan_ctx->vlan_mode =3D vlan_mode;=0D
 =0D
 	rte_atomic_thread_fence(rte_memory_order_seq_cst);=0D
-	hinic3_cpu_to_be32(vlan_ctx, sizeof(struct hinic3_vlan_ctx));=0D
+=0D
+	hinic3_cpu_to_be32(vlan_ctx, sizeof(struct hinic3_htn_vlan_ctx));=0D
 	return HINIC3_HTN_CMD_SVLAN_MODIFY;=0D
 }=0D
 =0D
diff --git a/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.h b/drivers/net/h=
inic3/htn_adapt/hinic3_htn_cmdq.h=0D
index 1245b9c8d8..ffafe39fb5 100644=0D
--- a/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.h=0D
+++ b/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.h=0D
@@ -7,7 +7,7 @@=0D
 =0D
 #include "hinic3_nic_io.h"=0D
 =0D
-struct hinic3_qp_ctxt_header {=0D
+struct hinic3_htn_qp_ctxt_header {=0D
 	uint32_t rsvd[2];=0D
 	uint16_t num_queues;=0D
 	uint16_t queue_type;=0D
@@ -15,12 +15,12 @@ struct hinic3_qp_ctxt_header {=0D
 	uint16_t dest_func_id;=0D
 };=0D
 =0D
-struct hinic3_clean_queue_ctxt {=0D
-	struct hinic3_qp_ctxt_header cmdq_hdr;=0D
+struct hinic3_htn_clean_queue_ctxt {=0D
+	struct hinic3_htn_qp_ctxt_header cmdq_hdr;=0D
 };=0D
 =0D
-struct hinic3_qp_ctxt_block {=0D
-	struct hinic3_qp_ctxt_header   cmdq_hdr;=0D
+struct hinic3_htn_qp_ctxt_block {=0D
+	struct hinic3_htn_qp_ctxt_header cmdq_hdr;=0D
 	union {=0D
 		struct hinic3_sq_ctxt  sq_ctxt[HINIC3_Q_CTXT_MAX];=0D
 		struct hinic3_rq_ctxt  rq_ctxt[HINIC3_Q_CTXT_MAX];=0D
@@ -43,7 +43,7 @@ enum hinic3_htn_cmd {=0D
 	HINIC3_HTN_CMD_GET_RSS_INDIR_TABLE=0D
 };=0D
 =0D
-struct hinic3_vlan_ctx {=0D
+struct hinic3_htn_vlan_ctx {=0D
 	uint32_t rsv[2];=0D
 	uint16_t vlan_tag;=0D
 	uint8_t vlan_sel;=0D
diff --git a/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.c b/drivers/net/h=
inic3/stn_adapt/hinic3_stn_cmdq.c=0D
index 3d4becf07c..dfe8598f78 100644=0D
--- a/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.c=0D
+++ b/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.c=0D
@@ -8,11 +8,16 @@=0D
 #include "hinic3_hwif.h"=0D
 #include "hinic3_stn_cmdq.h"=0D
 =0D
+#define STN_SQ_CTXT_SIZE(num_sqs)	((uint16_t)(sizeof(struct hinic3_stn_qp_=
ctxt_header) \=0D
+						    + (num_sqs) * sizeof(struct hinic3_sq_ctxt)))=0D
+#define STN_RQ_CTXT_SIZE(num_rqs)	((uint16_t)(sizeof(struct hinic3_stn_qp_=
ctxt_header) \=0D
+						    + (num_rqs) * sizeof(struct hinic3_rq_ctxt)))=0D
+=0D
 static uint8_t prepare_cmd_buf_clean_tso_lro_space(struct hinic3_nic_dev *=
nic_dev,=0D
 						   struct hinic3_cmd_buf *cmd_buf,=0D
 						   enum hinic3_qp_ctxt_type ctxt_type)=0D
 {=0D
-	struct hinic3_clean_queue_ctxt *ctxt_block =3D NULL;=0D
+	struct hinic3_stn_clean_queue_ctxt *ctxt_block =3D NULL;=0D
 =0D
 	ctxt_block =3D cmd_buf->buf;=0D
 	ctxt_block->cmdq_hdr.num_queues =3D nic_dev->max_sqs;=0D
@@ -26,7 +31,7 @@ static uint8_t prepare_cmd_buf_clean_tso_lro_space(struct=
 hinic3_nic_dev *nic_de=0D
 	return HINIC3_UCODE_CMD_CLEAN_QUEUE_CONTEXT;=0D
 }=0D
 =0D
-static void qp_prepare_cmdq_header(struct hinic3_qp_ctxt_header *qp_ctxt_h=
dr,=0D
+static void qp_prepare_cmdq_header(struct hinic3_stn_qp_ctxt_header *qp_ct=
xt_hdr,=0D
 				   enum hinic3_qp_ctxt_type ctxt_type, uint16_t num_queues,=0D
 				   uint16_t q_id)=0D
 {=0D
@@ -44,7 +49,7 @@ static uint8_t prepare_cmd_buf_qp_context_multi_store(str=
uct hinic3_nic_dev *nic=0D
 						 enum hinic3_qp_ctxt_type ctxt_type,=0D
 						 uint16_t start_qid, uint16_t max_ctxts)=0D
 {=0D
-	struct hinic3_qp_ctxt_block *qp_ctxt_block =3D NULL;=0D
+	struct hinic3_stn_qp_ctxt_block *qp_ctxt_block =3D NULL;=0D
 	uint16_t i;=0D
 =0D
 	qp_ctxt_block =3D cmd_buf->buf;=0D
@@ -62,9 +67,9 @@ static uint8_t prepare_cmd_buf_qp_context_multi_store(str=
uct hinic3_nic_dev *nic=0D
 	}=0D
 =0D
 	if (ctxt_type =3D=3D HINIC3_QP_CTXT_TYPE_RQ)=0D
-		cmd_buf->size =3D RQ_CTXT_SIZE(max_ctxts);=0D
+		cmd_buf->size =3D STN_RQ_CTXT_SIZE(max_ctxts);=0D
 	else=0D
-		cmd_buf->size =3D SQ_CTXT_SIZE(max_ctxts);=0D
+		cmd_buf->size =3D STN_SQ_CTXT_SIZE(max_ctxts);=0D
 =0D
 	return HINIC3_UCODE_CMD_MODIFY_QUEUE_CTX;=0D
 }=0D
@@ -72,10 +77,10 @@ static uint8_t prepare_cmd_buf_qp_context_multi_store(s=
truct hinic3_nic_dev *nic=0D
 static uint8_t prepare_cmd_buf_modify_svlan(struct hinic3_cmd_buf *cmd_buf=
, uint16_t func_id,=0D
 					    uint16_t vlan_tag, uint16_t q_id, uint8_t vlan_mode)=0D
 {=0D
-	struct hinic3_vlan_ctx *vlan_ctx =3D NULL;=0D
+	struct hinic3_stn_vlan_ctx *vlan_ctx =3D NULL;=0D
 =0D
-	cmd_buf->size =3D sizeof(struct hinic3_vlan_ctx);=0D
-	vlan_ctx =3D (struct hinic3_vlan_ctx *)cmd_buf->buf;=0D
+	cmd_buf->size =3D sizeof(struct hinic3_stn_vlan_ctx);=0D
+	vlan_ctx =3D (struct hinic3_stn_vlan_ctx *)cmd_buf->buf;=0D
 =0D
 	vlan_ctx->func_id =3D func_id;=0D
 	vlan_ctx->qid =3D q_id;=0D
@@ -84,7 +89,8 @@ static uint8_t prepare_cmd_buf_modify_svlan(struct hinic3=
_cmd_buf *cmd_buf, uint=0D
 	vlan_ctx->vlan_mode =3D vlan_mode;=0D
 =0D
 	rte_atomic_thread_fence(rte_memory_order_seq_cst);=0D
-	hinic3_cpu_to_be32(vlan_ctx, sizeof(struct hinic3_vlan_ctx));=0D
+=0D
+	hinic3_cpu_to_be32(vlan_ctx, sizeof(struct hinic3_stn_vlan_ctx));=0D
 	return HINIC3_UCODE_CMD_MODIFY_VLAN_CTX;=0D
 }=0D
 =0D
diff --git a/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.h b/drivers/net/h=
inic3/stn_adapt/hinic3_stn_cmdq.h=0D
index f8d26e9397..a40c4faa89 100644=0D
--- a/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.h=0D
+++ b/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.h=0D
@@ -7,27 +7,27 @@=0D
 =0D
 #include "hinic3_nic_io.h"=0D
 =0D
-struct hinic3_qp_ctxt_header {=0D
+struct hinic3_stn_qp_ctxt_header {=0D
 	uint16_t num_queues;=0D
 	uint16_t queue_type;=0D
 	uint16_t start_qid;=0D
 	uint16_t rsvd;=0D
 };=0D
 =0D
-struct hinic3_clean_queue_ctxt {=0D
-	struct hinic3_qp_ctxt_header cmdq_hdr;=0D
+struct hinic3_stn_clean_queue_ctxt {=0D
+	struct hinic3_stn_qp_ctxt_header cmdq_hdr;=0D
 	uint32_t rsvd;=0D
 };=0D
 =0D
-struct hinic3_qp_ctxt_block {=0D
-	struct hinic3_qp_ctxt_header   cmdq_hdr;=0D
+struct hinic3_stn_qp_ctxt_block {=0D
+	struct hinic3_stn_qp_ctxt_header   cmdq_hdr;=0D
 	union {=0D
 		struct hinic3_sq_ctxt  sq_ctxt[HINIC3_Q_CTXT_MAX];=0D
 		struct hinic3_rq_ctxt  rq_ctxt[HINIC3_Q_CTXT_MAX];=0D
 	};=0D
 };=0D
 =0D
-struct hinic3_vlan_ctx {=0D
+struct hinic3_stn_vlan_ctx {=0D
 	uint32_t func_id;=0D
 	uint32_t qid; /* if qid =3D 0xFFFF, config for all queues */=0D
 	uint32_t vlan_id;=0D
-- =0D
2.45.1.windows.1=0D
=0D

