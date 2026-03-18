Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4196C10854CE
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Mar 2026 02:20:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A76640652;
	Wed, 18 Mar 2026 03:19:51 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.220])
 by mails.dpdk.org (Postfix) with ESMTP id 71A944026F
 for <dev@dpdk.org>; Wed, 18 Mar 2026 03:19:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=pAmfORZ2G5VTBGn7Mhwc91SqvPMq4lqCESAgLJVolZI=;
 b=jcr0dC3lVNwGrznwJOyI+7e6KjY88+g7Roi3R+DpCY+Zcd4NB+Gt3XJiGk+pQn
 wZx2et6pCIKIuLQRFVpQ0G7Ocn11qalDb7/qURZRJZ85IwX6sQq8hwKr/hZhGgWY
 IASoRwVvxwFML9SG6/4KITOUjeRaLpV6oWMQpYLLHXHw0=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgDH7y+zC7ppBxnpAg--.15041S9;
 Wed, 18 Mar 2026 10:19:46 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>
Subject: [V3 5/7] net/hinic3: add rx ops to support Compact CQE
Date: Wed, 18 Mar 2026 10:19:05 +0800
Message-ID: <20260318021914.1807-6-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20260318021914.1807-1-wff_light@vip.163.com>
References: <20260131100608.12429-2-wff_light@vip.163.com>
 <20260318021914.1807-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: As8vCgDH7y+zC7ppBxnpAg--.15041S9
X-Coremail-Antispam: 1Uf129KBjvAXoWfZw1rWr4fCFWkGr4fuFyfZwb_yoW8Kry5Wo
 WfXr1ayrn3tr1xKrWqgFs7uFWDArWqyws5J3yq93Z7ZFyxWFyUKF9xJw1Fqa40q3s8CF17
 AasxK3Zrtw1xJa45n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUwQ6pDUUUU
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNQL7Bmm6C8JELwAA37
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

In pkt receive path, use different func callback to separate normal CQE=0D
process and Compact CQE process.=0D
=0D
Signed-off-by: Feifei Wang <wangfeifei40@huawei.com>=0D
---=0D
 drivers/net/hinic3/hinic3_ethdev.h |   3 +-=0D
 drivers/net/hinic3/hinic3_rx.c     | 240 ++++++++++++++++++++++-------=0D
 drivers/net/hinic3/hinic3_rx.h     | 164 +++++++++++++++++++-=0D
 3 files changed, 341 insertions(+), 66 deletions(-)=0D
=0D
diff --git a/drivers/net/hinic3/hinic3_ethdev.h b/drivers/net/hinic3/hinic3=
_ethdev.h=0D
index 3898edd076..9061e2b217 100644=0D
--- a/drivers/net/hinic3/hinic3_ethdev.h=0D
+++ b/drivers/net/hinic3/hinic3_ethdev.h=0D
@@ -121,8 +121,7 @@ struct hinic3_nic_dev {=0D
 	uint16_t mtu_size;=0D
 =0D
 	uint16_t rss_state;=0D
-	uint8_t num_rss; /**< Number of RSS queues. */=0D
-	uint8_t rsvd0;   /**< Reserved field 0. */=0D
+	uint16_t num_rss; /**< Number of RSS queues. */=0D
 =0D
 	uint32_t rx_mode;=0D
 	uint8_t rx_queue_list[HINIC3_MAX_QUEUE_NUM];=0D
diff --git a/drivers/net/hinic3/hinic3_rx.c b/drivers/net/hinic3/hinic3_rx.=
c=0D
index 3d5f4e4524..363f3f56c8 100644=0D
--- a/drivers/net/hinic3/hinic3_rx.c=0D
+++ b/drivers/net/hinic3/hinic3_rx.c=0D
@@ -219,11 +219,11 @@ hinic3_free_rxq_mbufs(struct hinic3_rxq *rxq)=0D
 =0D
 	while (free_wqebbs++ < rxq->q_depth) {=0D
 		ci =3D hinic3_get_rq_local_ci(rxq);=0D
-=0D
-		rx_cqe =3D &rxq->rx_cqe[ci];=0D
-=0D
-		/* Clear done bit. */=0D
-		rx_cqe->status =3D 0;=0D
+		if (rxq->wqe_type !=3D HINIC3_COMPACT_RQ_WQE) {=0D
+			rx_cqe =3D &rxq->rx_cqe[ci];=0D
+			/* Clear done bit. */=0D
+			rx_cqe->status =3D 0;=0D
+		}=0D
 =0D
 		rx_info =3D &rxq->rx_info[ci];=0D
 		rte_pktmbuf_free(rx_info->mbuf);=0D
@@ -299,7 +299,7 @@ hinic3_rearm_rxq_mbuf(struct hinic3_rxq *rxq)=0D
 	for (i =3D 0; i < rearm_wqebbs; i++) {=0D
 		dma_addr =3D rte_mbuf_data_iova_default(rearm_mbufs[i]);=0D
 =0D
-		/* Fill buffer address only. */=0D
+		/* Fill packet dma address into wqe. */=0D
 		if (rxq->wqe_type =3D=3D HINIC3_EXTEND_RQ_WQE) {=0D
 			rq_wqe->extend_wqe.buf_desc.sge.hi_addr =3D=0D
 				hinic3_hw_be32(upper_32_bits(dma_addr));=0D
@@ -307,11 +307,16 @@ hinic3_rearm_rxq_mbuf(struct hinic3_rxq *rxq)=0D
 				hinic3_hw_be32(lower_32_bits(dma_addr));=0D
 			rq_wqe->extend_wqe.buf_desc.sge.len =3D=0D
 				nic_dev->rx_buff_len;=0D
-		} else {=0D
+		} else if (rxq->wqe_type =3D=3D HINIC3_NORMAL_RQ_WQE) {=0D
 			rq_wqe->normal_wqe.buf_hi_addr =3D=0D
 				hinic3_hw_be32(upper_32_bits(dma_addr));=0D
 			rq_wqe->normal_wqe.buf_lo_addr =3D=0D
 				hinic3_hw_be32(lower_32_bits(dma_addr));=0D
+		} else {=0D
+			rq_wqe->compact_wqe.buf_hi_addr =3D=0D
+				hinic3_hw_be32(upper_32_bits(dma_addr));=0D
+			rq_wqe->compact_wqe.buf_lo_addr =3D=0D
+				hinic3_hw_be32(lower_32_bits(dma_addr));=0D
 		}=0D
 =0D
 		rq_wqe =3D=0D
@@ -355,7 +360,7 @@ hinic3_init_rss_key(struct hinic3_nic_dev *nic_dev,=0D
 void=0D
 hinic3_add_rq_to_rx_queue_list(struct hinic3_nic_dev *nic_dev, uint16_t qu=
eue_id)=0D
 {=0D
-	uint8_t rss_queue_count =3D nic_dev->num_rss;=0D
+	uint16_t rss_queue_count =3D nic_dev->num_rss;=0D
 =0D
 	RTE_ASSERT(rss_queue_count <=3D (RTE_DIM(nic_dev->rx_queue_list) - 1));=0D
 =0D
@@ -372,7 +377,7 @@ hinic3_init_rx_queue_list(struct hinic3_nic_dev *nic_de=
v)=0D
 static void=0D
 hinic3_fill_indir_tbl(struct hinic3_nic_dev *nic_dev, uint32_t *indir_tbl)=
=0D
 {=0D
-	uint8_t rss_queue_count =3D nic_dev->num_rss;=0D
+	uint16_t rss_queue_count =3D nic_dev->num_rss;=0D
 	int i =3D 0;=0D
 	int j;=0D
 =0D
@@ -522,7 +527,7 @@ hinic3_remove_rq_from_rx_queue_list(struct hinic3_nic_d=
ev *nic_dev,=0D
 				    uint16_t queue_id)=0D
 {=0D
 	uint8_t queue_pos;=0D
-	uint8_t rss_queue_count =3D nic_dev->num_rss;=0D
+	uint16_t rss_queue_count =3D nic_dev->num_rss;=0D
 =0D
 	queue_pos =3D hinic3_find_queue_pos_by_rq_id(nic_dev->rx_queue_list,=0D
 						   rss_queue_count, queue_id);=0D
@@ -534,8 +539,7 @@ hinic3_remove_rq_from_rx_queue_list(struct hinic3_nic_d=
ev *nic_dev,=0D
 		rss_queue_count--;=0D
 		memmove(nic_dev->rx_queue_list + queue_pos,=0D
 			nic_dev->rx_queue_list + queue_pos + 1,=0D
-			(rss_queue_count - queue_pos) *=0D
-				sizeof(nic_dev->rx_queue_list[0]));=0D
+			(rss_queue_count - queue_pos) * sizeof(nic_dev->rx_queue_list[0]));=0D
 	}=0D
 =0D
 	RTE_ASSERT(rss_queue_count < RTE_DIM(nic_dev->rx_queue_list));=0D
@@ -618,6 +622,32 @@ hinic3_poll_rq_empty(struct hinic3_rxq *rxq)=0D
 	return err;=0D
 }=0D
 =0D
+int=0D
+hinic3_poll_integrated_cqe_rq_empty(struct hinic3_rxq *rxq)=0D
+{=0D
+	struct hinic3_rx_info *rx_info;=0D
+	struct hinic3_rq_ci_wb rq_ci;=0D
+	uint16_t sw_ci;=0D
+	uint16_t hw_ci;=0D
+=0D
+	sw_ci =3D hinic3_get_rq_local_ci(rxq);=0D
+	rq_ci.dw1.value =3D hinic3_hw_cpu32(rte_atomic_load_explicit(&rxq->rq_ci-=
>dw1.value,=0D
+				rte_memory_order_acquire));=0D
+	hw_ci =3D rq_ci.dw1.bs.hw_ci;=0D
+=0D
+	while (sw_ci !=3D hw_ci) {=0D
+		rx_info =3D &rxq->rx_info[sw_ci];=0D
+		rte_pktmbuf_free(rx_info->mbuf);=0D
+		rx_info->mbuf =3D NULL;=0D
+=0D
+		sw_ci++;=0D
+		sw_ci &=3D rxq->q_mask;=0D
+		hinic3_update_rq_local_ci(rxq, 1);=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
 void=0D
 hinic3_dump_cqe_status(struct hinic3_rxq *rxq, uint32_t *cqe_done_cnt,=0D
 		       uint32_t *cqe_hole_cnt, uint32_t *head_ci, uint32_t *head_done)=0D
@@ -701,14 +731,17 @@ hinic3_stop_rq(struct rte_eth_dev *eth_dev, struct hi=
nic3_rxq *rxq)=0D
 	rte_spinlock_unlock(&nic_dev->queue_list_lock);=0D
 =0D
 	/* Send flush rxq cmd to device. */=0D
-	err =3D hinic3_set_rq_flush(nic_dev->hwdev, rxq->q_id);=0D
+	if ((hinic3_get_driver_feature(nic_dev) & NIC_F_HTN_FDIR) =3D=3D 0)=0D
+		err =3D hinic3_set_rq_flush(nic_dev->hwdev, rxq->q_id);=0D
+	else=0D
+		err =3D hinic3_set_rq_enable(nic_dev, rxq->q_id, false);=0D
 	if (err) {=0D
 		PMD_DRV_LOG(ERR, "Flush rq failed, eth_dev:%s, queue_idx:%d",=0D
 			    nic_dev->dev_name, rxq->q_id);=0D
 		goto rq_flush_failed;=0D
 	}=0D
 =0D
-	err =3D hinic3_poll_rq_empty(rxq);=0D
+	err =3D nic_dev->rx_ops->nic_rx_poll_rq_empty(rxq);=0D
 	if (err) {=0D
 		hinic3_dump_cqe_status(rxq, &cqe_done_cnt, &cqe_hole_cnt,=0D
 				       &head_ci, &head_done);=0D
@@ -724,6 +757,7 @@ hinic3_stop_rq(struct rte_eth_dev *eth_dev, struct hini=
c3_rxq *rxq)=0D
 	return 0;=0D
 =0D
 poll_rq_failed:=0D
+	hinic3_set_rq_enable(nic_dev, rxq->q_id, true);=0D
 rq_flush_failed:=0D
 	rte_spinlock_lock(&nic_dev->queue_list_lock);=0D
 set_indir_failed:=0D
@@ -746,14 +780,22 @@ hinic3_start_rq(struct rte_eth_dev *eth_dev, struct h=
inic3_rxq *rxq)=0D
 	hinic3_add_rq_to_rx_queue_list(nic_dev, rxq->q_id);=0D
 =0D
 	if (nic_dev->rss_state =3D=3D HINIC3_RSS_ENABLE) {=0D
-		err =3D hinic3_refill_indir_rqid(rxq);=0D
+		if ((hinic3_get_driver_feature(nic_dev) & NIC_F_FDIR) !=3D 0)=0D
+			err =3D hinic3_set_rq_enable(nic_dev, rxq->q_id, true);=0D
 		if (err) {=0D
-			PMD_DRV_LOG(ERR,=0D
-				    "Refill rq to indirect table failed, eth_dev:%s, queue_idx:%d err:=
%d",=0D
-				    nic_dev->dev_name, rxq->q_id, err);=0D
-			hinic3_remove_rq_from_rx_queue_list(nic_dev, rxq->q_id);=0D
+			PMD_DRV_LOG(ERR, "Flush rq failed, eth_dev:%s, queue_idx:%d",=0D
+					 nic_dev->dev_name, rxq->q_id);=0D
+		} else {=0D
+			err =3D hinic3_refill_indir_rqid(rxq);=0D
+			if (err) {=0D
+				PMD_DRV_LOG(ERR, "Refill rq to indirect table failed,"=0D
+						 "eth_dev:%s, queue_idx:%d err:%d",=0D
+						 nic_dev->dev_name, rxq->q_id, err);=0D
+				hinic3_remove_rq_from_rx_queue_list(nic_dev, rxq->q_id);=0D
+			}=0D
 		}=0D
 	}=0D
+=0D
 	hinic3_rearm_rxq_mbuf(rxq);=0D
 	if (rxq->nic_dev->num_rss =3D=3D 1) {=0D
 		err =3D hinic3_set_vport_enable(nic_dev->hwdev, true);=0D
@@ -772,12 +814,9 @@ hinic3_start_rq(struct rte_eth_dev *eth_dev, struct hi=
nic3_rxq *rxq)=0D
 =0D
 =0D
 static inline uint64_t=0D
-hinic3_rx_vlan(uint32_t offload_type, uint32_t vlan_len, uint16_t *vlan_tc=
i)=0D
+hinic3_rx_vlan(uint8_t vlan_offload, uint16_t vlan_tag, uint16_t *vlan_tci=
)=0D
 {=0D
-	uint16_t vlan_tag;=0D
-=0D
-	vlan_tag =3D HINIC3_GET_RX_VLAN_TAG(vlan_len);=0D
-	if (!HINIC3_GET_RX_VLAN_OFFLOAD_EN(offload_type) || vlan_tag =3D=3D 0) {=
=0D
+	if (!vlan_offload || vlan_tag =3D=3D 0) {=0D
 		*vlan_tci =3D 0;=0D
 		return 0;=0D
 	}=0D
@@ -788,16 +827,14 @@ hinic3_rx_vlan(uint32_t offload_type, uint32_t vlan_l=
en, uint16_t *vlan_tci)=0D
 }=0D
 =0D
 static inline uint64_t=0D
-hinic3_rx_csum(uint32_t status, struct hinic3_rxq *rxq)=0D
+hinic3_rx_csum(uint16_t csum_err, struct hinic3_rxq *rxq)=0D
 {=0D
 	struct hinic3_nic_dev *nic_dev =3D rxq->nic_dev;=0D
-	uint32_t csum_err;=0D
 	uint64_t flags;=0D
 =0D
 	if (unlikely(!(nic_dev->rx_csum_en & HINIC3_DEFAULT_RX_CSUM_OFFLOAD)))=0D
 		return HINIC3_PKT_RX_IP_CKSUM_UNKNOWN;=0D
 =0D
-	csum_err =3D HINIC3_GET_RX_CSUM_ERR(status);=0D
 	if (likely(csum_err =3D=3D 0))=0D
 		return (HINIC3_PKT_RX_IP_CKSUM_GOOD |=0D
 			HINIC3_PKT_RX_L4_CKSUM_GOOD);=0D
@@ -832,11 +869,9 @@ hinic3_rx_csum(uint32_t status, struct hinic3_rxq *rxq=
)=0D
 }=0D
 =0D
 static inline uint64_t=0D
-hinic3_rx_rss_hash(uint32_t offload_type, uint32_t rss_hash_value, uint32_=
t *rss_hash)=0D
+hinic3_rx_rss_hash(uint32_t rss_type, uint32_t rss_hash_value, uint32_t *r=
ss_hash)=0D
 {=0D
-	uint32_t rss_type;=0D
 =0D
-	rss_type =3D HINIC3_GET_RSS_TYPES(offload_type);=0D
 	if (likely(rss_type !=3D 0)) {=0D
 		*rss_hash =3D rss_hash_value;=0D
 		return HINIC3_PKT_RX_RSS_HASH;=0D
@@ -931,18 +966,117 @@ hinic3_start_all_rqs(struct rte_eth_dev *eth_dev)=0D
 	return err;=0D
 }=0D
 =0D
+bool=0D
+hinic3_rx_separate_cqe_done(struct hinic3_rxq *rxq, volatile struct hinic3=
_rq_cqe **rx_cqe)=0D
+{=0D
+	volatile struct hinic3_rq_cqe *cqe =3D NULL;=0D
+	uint16_t sw_ci;=0D
+	uint32_t status;=0D
+=0D
+	sw_ci =3D hinic3_get_rq_local_ci(rxq);=0D
+	*rx_cqe =3D &rxq->rx_cqe[sw_ci];=0D
+	cqe =3D *rx_cqe;=0D
+=0D
+	status =3D hinic3_hw_cpu32((uint32_t)(rte_atomic_load_explicit(&cqe->stat=
us,=0D
+								     rte_memory_order_acquire)));=0D
+	if (!HINIC3_GET_RX_DONE(status))=0D
+		return false;=0D
+=0D
+	return true;=0D
+}=0D
+=0D
+bool=0D
+hinic3_rx_integrated_cqe_done(struct hinic3_rxq *rxq, volatile struct hini=
c3_rq_cqe **rx_cqe)=0D
+{=0D
+	struct hinic3_rq_ci_wb rq_ci;=0D
+	struct rte_mbuf *rxm =3D NULL;=0D
+	uint16_t sw_ci, hw_ci;=0D
+=0D
+	sw_ci =3D hinic3_get_rq_local_ci(rxq);=0D
+	rq_ci.dw1.value =3D hinic3_hw_cpu32(rte_atomic_load_explicit(&rxq->rq_ci-=
>dw1.value,=0D
+								   rte_memory_order_acquire));=0D
+	hw_ci =3D rq_ci.dw1.bs.hw_ci;=0D
+=0D
+	if (hw_ci =3D=3D sw_ci)=0D
+		return false;=0D
+=0D
+	rxm =3D rxq->rx_info[sw_ci].mbuf;=0D
+=0D
+	*rx_cqe =3D (volatile struct hinic3_rq_cqe *)rte_mbuf_data_addr_default(r=
xm);=0D
+=0D
+	return true;=0D
+}=0D
+=0D
+void=0D
+hinic3_rx_get_cqe_info(struct hinic3_rxq *rxq __rte_unused, volatile struc=
t hinic3_rq_cqe *rx_cqe,=0D
+		       struct hinic3_cqe_info *cqe_info)=0D
+{=0D
+	uint32_t dw0 =3D hinic3_hw_cpu32(rx_cqe->status);=0D
+	uint32_t dw1 =3D hinic3_hw_cpu32(rx_cqe->vlan_len);=0D
+	uint32_t dw2 =3D hinic3_hw_cpu32(rx_cqe->offload_type);=0D
+	uint32_t dw3 =3D hinic3_hw_cpu32(rx_cqe->hash_val);=0D
+=0D
+	cqe_info->lro_num =3D  RQ_CQE_STATUS_GET(dw0, NUM_LRO);=0D
+	cqe_info->csum_err =3D  RQ_CQE_STATUS_GET(dw0, CSUM_ERR);=0D
+=0D
+	cqe_info->pkt_len =3D RQ_CQE_SGE_GET(dw1, LEN);=0D
+	cqe_info->vlan_tag =3D RQ_CQE_SGE_GET(dw1, VLAN);=0D
+=0D
+	cqe_info->ptype =3D HINIC3_GET_RX_PTYPE_OFFLOAD(dw0);=0D
+	cqe_info->vlan_offload =3D RQ_CQE_OFFOLAD_TYPE_GET(dw2, VLAN_EN);=0D
+	cqe_info->rss_type =3D RQ_CQE_OFFOLAD_TYPE_GET(dw2, RSS_TYPE);=0D
+	cqe_info->rss_hash_value =3D dw3;=0D
+}=0D
+=0D
+void=0D
+hinic3_rx_get_compact_cqe_info(struct hinic3_rxq *rxq, volatile struct hin=
ic3_rq_cqe *rx_cqe,=0D
+			       struct hinic3_cqe_info *cqe_info)=0D
+{=0D
+	uint32_t dw0, dw1, dw2;=0D
+=0D
+	if (rxq->wqe_type !=3D HINIC3_COMPACT_RQ_WQE) {=0D
+		dw0 =3D hinic3_hw_cpu32(rx_cqe->status);=0D
+		dw1 =3D hinic3_hw_cpu32(rx_cqe->vlan_len);=0D
+		dw2 =3D hinic3_hw_cpu32(rx_cqe->offload_type);=0D
+	} else {=0D
+		/* Compact Rx CQE mode integrates cqe with packet in big endian way. */=
=0D
+		dw0 =3D rte_be_to_cpu_32(rx_cqe->status);=0D
+		dw1 =3D rte_be_to_cpu_32(rx_cqe->vlan_len);=0D
+		dw2 =3D rte_be_to_cpu_32(rx_cqe->offload_type);=0D
+	}=0D
+=0D
+	cqe_info->cqe_type =3D HINIC3_RQ_COMPACT_CQE_STATUS_GET(dw0, CQE_TYPE);=0D
+	cqe_info->csum_err =3D HINIC3_RQ_COMPACT_CQE_STATUS_GET(dw0, CSUM_ERR);=0D
+	cqe_info->vlan_offload =3D HINIC3_RQ_COMPACT_CQE_STATUS_GET(dw0, VLAN_EN)=
;=0D
+	cqe_info->cqe_len =3D HINIC3_RQ_COMPACT_CQE_STATUS_GET(dw0, CQE_LEN);=0D
+	cqe_info->pkt_len =3D HINIC3_RQ_COMPACT_CQE_STATUS_GET(dw0, PKT_LEN);=0D
+	cqe_info->ts_flag =3D HINIC3_RQ_COMPACT_CQE_STATUS_GET(dw0, TS_FLAG);=0D
+	cqe_info->ptype =3D HINIC3_RQ_COMPACT_CQE_STATUS_GET(dw0, PTYPE);=0D
+	cqe_info->rss_hash_value =3D dw1;=0D
+=0D
+	if (cqe_info->cqe_len =3D=3D HINIC3_RQ_COMPACT_CQE_16BYTE) {=0D
+		cqe_info->lro_num =3D HINIC3_RQ_COMPACT_CQE_OFFLOAD_GET(dw2, NUM_LRO);=0D
+		cqe_info->vlan_tag =3D HINIC3_RQ_COMPACT_CQE_OFFLOAD_GET(dw2, VLAN);=0D
+	}=0D
+=0D
+	if (cqe_info->cqe_type =3D=3D HINIC3_RQ_CQE_INTEGRATE)=0D
+		cqe_info->data_offset =3D=0D
+				(cqe_info->cqe_len =3D=3D HINIC3_RQ_COMPACT_CQE_16BYTE) ? 16 : 8;=0D
+}=0D
+=0D
 #define HINIC3_RX_EMPTY_THRESHOLD 3=0D
 uint16_t=0D
 hinic3_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pk=
ts)=0D
 {=0D
 	struct hinic3_rxq *rxq =3D rx_queue;=0D
+	struct hinic3_nic_dev *nic_dev =3D rxq->nic_dev;=0D
 	struct hinic3_rx_info *rx_info =3D NULL;=0D
 	volatile struct hinic3_rq_cqe *rx_cqe =3D NULL;=0D
+	struct hinic3_cqe_info cqe_info =3D {0};=0D
 	struct rte_mbuf *rxm =3D NULL;=0D
-	uint16_t sw_ci, rx_buf_len, wqebb_cnt =3D 0, pkts =3D 0;=0D
-	uint32_t status, pkt_len, vlan_len, offload_type, lro_num;=0D
+	uint16_t sw_ci, rx_buf_len, pkts =3D 0;=0D
+	uint32_t pkt_len;=0D
 	uint64_t rx_bytes =3D 0;=0D
-	uint32_t hash_value;=0D
 =0D
 #ifdef HINIC3_XSTAT_PROF_RX=0D
 	uint64_t t1 =3D rte_get_tsc_cycles();=0D
@@ -953,20 +1087,22 @@ hinic3_recv_pkts(void *rx_queue, struct rte_mbuf **r=
x_pkts, uint16_t nb_pkts)=0D
 		goto out;=0D
 =0D
 	sw_ci =3D hinic3_get_rq_local_ci(rxq);=0D
-	rx_buf_len =3D rxq->buf_len;=0D
 =0D
 	while (pkts < nb_pkts) {=0D
 		rx_cqe =3D &rxq->rx_cqe[sw_ci];=0D
-		status =3D hinic3_hw_cpu32((uint32_t)(rte_atomic_load_explicit(&rx_cqe->=
status,=0D
-			rte_memory_order_acquire)));=0D
-		if (!HINIC3_GET_RX_DONE(status)) {=0D
+		if (!nic_dev->rx_ops->nic_rx_cqe_done(rxq, &rx_cqe)) {=0D
 			rxq->rxq_stats.empty++;=0D
 			break;=0D
 		}=0D
 =0D
-		vlan_len =3D hinic3_hw_cpu32(rx_cqe->vlan_len);=0D
+		nic_dev->rx_ops->nic_rx_get_cqe_info(rxq, rx_cqe, &cqe_info);=0D
 =0D
-		pkt_len =3D HINIC3_GET_RX_PKT_LEN(vlan_len);=0D
+		pkt_len =3D cqe_info.pkt_len;=0D
+		/*=0D
+		 * Compact Rx CQE mode integrates cqe with packet,=0D
+		 * so mbuf length needs to remove the length of cqe.=0D
+		 */=0D
+		rx_buf_len =3D rxq->buf_len - cqe_info.data_offset;=0D
 =0D
 		rx_info =3D &rxq->rx_info[sw_ci];=0D
 		rxm =3D rx_info->mbuf;=0D
@@ -982,7 +1118,7 @@ hinic3_recv_pkts(void *rx_queue, struct rte_mbuf **rx_=
pkts, uint16_t nb_pkts)=0D
 		if (likely(pkt_len <=3D rx_buf_len)) {=0D
 			rxm->data_len =3D (uint16_t)pkt_len;=0D
 			rxm->pkt_len =3D pkt_len;=0D
-			wqebb_cnt++;=0D
+			hinic3_update_rq_local_ci(rxq, 1);=0D
 		} else {=0D
 			rxm->data_len =3D rx_buf_len;=0D
 			rxm->pkt_len =3D rx_buf_len;=0D
@@ -991,33 +1127,28 @@ hinic3_recv_pkts(void *rx_queue, struct rte_mbuf **r=
x_pkts, uint16_t nb_pkts)=0D
 			 * If receive jumbo, updating ci will be done by=0D
 			 * hinic3_recv_jumbo_pkt function.=0D
 			 */=0D
-			hinic3_update_rq_local_ci(rxq, wqebb_cnt + 1);=0D
-			wqebb_cnt =3D 0;=0D
+			hinic3_update_rq_local_ci(rxq, 1);=0D
 			hinic3_recv_jumbo_pkt(rxq, rxm, pkt_len - rx_buf_len);=0D
 			sw_ci =3D hinic3_get_rq_local_ci(rxq);=0D
 		}=0D
 =0D
-		rxm->data_off =3D RTE_PKTMBUF_HEADROOM;=0D
+		rxm->data_off =3D RTE_PKTMBUF_HEADROOM + cqe_info.data_offset;=0D
 		rxm->port =3D rxq->port_id;=0D
 =0D
 		/* 4. Rx checksum offload. */=0D
-		rxm->ol_flags |=3D hinic3_rx_csum(status, rxq);=0D
+		rxm->ol_flags |=3D hinic3_rx_csum(cqe_info.csum_err, rxq);=0D
 =0D
 		/* 5. Vlan offload. */=0D
-		offload_type =3D hinic3_hw_cpu32(rx_cqe->offload_type);=0D
-=0D
-		rxm->ol_flags |=3D=0D
-			hinic3_rx_vlan(offload_type, vlan_len, &rxm->vlan_tci);=0D
+		rxm->ol_flags |=3D hinic3_rx_vlan(cqe_info.vlan_offload, cqe_info.vlan_t=
ag,=0D
+						&rxm->vlan_tci);=0D
 =0D
 		/* 6. RSS. */=0D
-		hash_value =3D hinic3_hw_cpu32(rx_cqe->hash_val);=0D
-		rxm->ol_flags |=3D hinic3_rx_rss_hash(offload_type, hash_value,=0D
+		rxm->ol_flags |=3D hinic3_rx_rss_hash(cqe_info.rss_type, cqe_info.rss_ha=
sh_value,=0D
 						    &rxm->hash.rss);=0D
 		/* 8. LRO. */=0D
-		lro_num =3D HINIC3_GET_RX_NUM_LRO(status);=0D
-		if (unlikely(lro_num !=3D 0)) {=0D
+		if (unlikely(cqe_info.lro_num !=3D 0)) {=0D
 			rxm->ol_flags |=3D HINIC3_PKT_RX_LRO;=0D
-			rxm->tso_segsz =3D pkt_len / lro_num;=0D
+			rxm->tso_segsz =3D pkt_len / cqe_info.lro_num;=0D
 		}=0D
 =0D
 		rx_cqe->status =3D 0;=0D
@@ -1027,9 +1158,6 @@ hinic3_recv_pkts(void *rx_queue, struct rte_mbuf **rx=
_pkts, uint16_t nb_pkts)=0D
 	}=0D
 =0D
 	if (pkts) {=0D
-		/* 9. Update local ci. */=0D
-		hinic3_update_rq_local_ci(rxq, wqebb_cnt);=0D
-=0D
 		/* Update packet stats. */=0D
 		rxq->rxq_stats.packets +=3D pkts;=0D
 		rxq->rxq_stats.bytes +=3D rx_bytes;=0D
diff --git a/drivers/net/hinic3/hinic3_rx.h b/drivers/net/hinic3/hinic3_rx.=
h=0D
index 7ae39e3e91..2655802467 100644=0D
--- a/drivers/net/hinic3/hinic3_rx.h=0D
+++ b/drivers/net/hinic3/hinic3_rx.h=0D
@@ -5,15 +5,13 @@=0D
 #ifndef _HINIC3_RX_H_=0D
 #define _HINIC3_RX_H_=0D
 =0D
-#define RQ_CQE_OFFOLAD_TYPE_PKT_TYPE_SHIFT    0=0D
-#define RQ_CQE_OFFOLAD_TYPE_PKT_UMBCAST_SHIFT 19=0D
-#define RQ_CQE_OFFOLAD_TYPE_VLAN_EN_SHIFT     21=0D
-#define RQ_CQE_OFFOLAD_TYPE_RSS_TYPE_SHIFT    24=0D
+#define RQ_CQE_OFFOLAD_TYPE_PTYPE_OFFLOAD_SHIFT	0=0D
+#define RQ_CQE_OFFOLAD_TYPE_VLAN_EN_SHIFT	21=0D
+#define RQ_CQE_OFFOLAD_TYPE_RSS_TYPE_SHIFT	24=0D
 =0D
-#define RQ_CQE_OFFOLAD_TYPE_PKT_TYPE_MASK    0xFFFU=0D
-#define RQ_CQE_OFFOLAD_TYPE_PKT_UMBCAST_MASK 0x3U=0D
-#define RQ_CQE_OFFOLAD_TYPE_VLAN_EN_MASK     0x1U=0D
-#define RQ_CQE_OFFOLAD_TYPE_RSS_TYPE_MASK    0xFFU=0D
+#define RQ_CQE_OFFOLAD_TYPE_PTYPE_OFFLOAD_MASK	0xFFFU=0D
+#define RQ_CQE_OFFOLAD_TYPE_VLAN_EN_MASK	0x1U=0D
+#define RQ_CQE_OFFOLAD_TYPE_RSS_TYPE_MASK	0xFFU=0D
 =0D
 #define DPI_EXT_ACTION_FILED (1ULL << 32)=0D
 =0D
@@ -21,6 +19,9 @@=0D
 	(((val) >> RQ_CQE_OFFOLAD_TYPE_##member##_SHIFT) & \=0D
 	 RQ_CQE_OFFOLAD_TYPE_##member##_MASK)=0D
 =0D
+#define HINIC3_GET_RX_PTYPE_OFFLOAD(offload_type) \=0D
+	RQ_CQE_OFFOLAD_TYPE_GET(offload_type, PTYPE_OFFLOAD)=0D
+=0D
 #define HINIC3_GET_RX_PKT_TYPE(offload_type) \=0D
 	RQ_CQE_OFFOLAD_TYPE_GET(offload_type, PKT_TYPE)=0D
 =0D
@@ -122,6 +123,54 @@=0D
 #define HINIC3_GET_ESP_NEXT_HEAD(decry_info) \=0D
 	RQ_CQE_DECRY_INFO_GET(decry_info, ESP_NEXT_HEAD)=0D
 =0D
+/* Compact CQE Field */=0D
+/* cqe dw0 */=0D
+#define RQ_COMPACT_CQE_STATUS_RXDONE_SHIFT		31=0D
+#define RQ_COMPACT_CQE_STATUS_CQE_TYPE_SHIFT		30=0D
+#define RQ_COMPACT_CQE_STATUS_TS_FLAG_SHIFT		29=0D
+#define RQ_COMPACT_CQE_STATUS_VLAN_EN_SHIFT		28=0D
+#define RQ_COMPACT_CQE_STATUS_PKT_FORMAT_SHIFT		25=0D
+#define RQ_COMPACT_CQE_STATUS_IP_TYPE_SHIFT		24=0D
+#define RQ_COMPACT_CQE_STATUS_CQE_LEN_SHIFT		23=0D
+#define RQ_COMPACT_CQE_STATUS_PKT_MC_SHIFT		21=0D
+#define RQ_COMPACT_CQE_STATUS_CSUM_ERR_SHIFT		19=0D
+#define RQ_COMPACT_CQE_STATUS_PKT_TYPE_SHIFT		16=0D
+#define RQ_COMPACT_CQE_STATUS_PTYPE_SHIFT		16=0D
+#define RQ_COMPACT_CQE_STATUS_PKT_LEN_SHIFT		0=0D
+=0D
+#define RQ_COMPACT_CQE_STATUS_RXDONE_MASK		0x1U=0D
+#define RQ_COMPACT_CQE_STATUS_CQE_TYPE_MASK		0x1U=0D
+#define RQ_COMPACT_CQE_STATUS_TS_FLAG_MASK		0x1U=0D
+#define RQ_COMPACT_CQE_STATUS_VLAN_EN_MASK		0x1U=0D
+#define RQ_COMPACT_CQE_STATUS_PKT_FORMAT_MASK	0x7U=0D
+#define RQ_COMPACT_CQE_STATUS_IP_TYPE_MASK		0x1U=0D
+#define RQ_COMPACT_CQE_STATUS_CQE_LEN_MASK		0x1U=0D
+#define RQ_COMPACT_CQE_STATUS_PKT_MC_MASK		0x1U=0D
+#define RQ_COMPACT_CQE_STATUS_CSUM_ERR_MASK		0x3U=0D
+#define RQ_COMPACT_CQE_STATUS_PKT_TYPE_MASK		0x7U=0D
+#define RQ_COMPACT_CQE_STATUS_PTYPE_MASK		0xFFFU=0D
+#define RQ_COMPACT_CQE_STATUS_PKT_LEN_MASK		0xFFFFU=0D
+=0D
+#define HINIC3_RQ_COMPACT_CQE_STATUS_GET(val, member) \=0D
+	((((val) >> RQ_COMPACT_CQE_STATUS_##member##_SHIFT) & \=0D
+		RQ_COMPACT_CQE_STATUS_##member##_MASK))=0D
+=0D
+#define HINIC3_RQ_CQE_SEPARATE	0=0D
+#define HINIC3_RQ_CQE_INTEGRATE 1=0D
+=0D
+/* cqe dw2 */=0D
+#define RQ_COMPACT_CQE_OFFLOAD_NUM_LRO_SHIFT		24=0D
+#define RQ_COMPACT_CQE_OFFLOAD_VLAN_SHIFT		8=0D
+=0D
+#define RQ_COMPACT_CQE_OFFLOAD_NUM_LRO_MASK		0xFFU=0D
+#define RQ_COMPACT_CQE_OFFLOAD_VLAN_MASK		0xFFFFU=0D
+=0D
+#define HINIC3_RQ_COMPACT_CQE_OFFLOAD_GET(val, member) \=0D
+	(((val) >> RQ_COMPACT_CQE_OFFLOAD_##member##_SHIFT) & \=0D
+	RQ_COMPACT_CQE_OFFLOAD_##member##_MASK)=0D
+=0D
+#define HINIC3_RQ_COMPACT_CQE_16BYTE	0=0D
+#define HINIC3_RQ_COMPACT_CQE_8BYTE	1=0D
 /* Rx cqe checksum err */=0D
 #define HINIC3_RX_CSUM_IP_CSUM_ERR      RTE_BIT32(0)=0D
 #define HINIC3_RX_CSUM_TCP_CSUM_ERR     RTE_BIT32(1)=0D
@@ -195,6 +244,25 @@ struct __rte_cache_aligned hinic3_rq_cqe {=0D
 	uint32_t pkt_info;=0D
 };=0D
 =0D
+struct hinic3_cqe_info {=0D
+	uint8_t data_offset;=0D
+	uint8_t lro_num;=0D
+	uint8_t vlan_offload;=0D
+	uint8_t cqe_len;=0D
+=0D
+	uint8_t cqe_type;=0D
+	uint8_t ts_flag;=0D
+	uint16_t csum_err;=0D
+=0D
+	uint16_t vlan_tag;=0D
+	uint16_t ptype;=0D
+=0D
+	uint16_t pkt_len;=0D
+	uint16_t rss_type;=0D
+=0D
+	uint32_t rss_hash_value;=0D
+};=0D
+=0D
 /**=0D
  * Attention: please do not add any member in hinic3_rx_info=0D
  * because rxq bulk rearm mode will write mbuf in rx_info.=0D
@@ -220,13 +288,32 @@ struct hinic3_rq_normal_wqe {=0D
 	uint32_t cqe_lo_addr;=0D
 };=0D
 =0D
+struct hinic3_rq_compact_wqe {=0D
+	uint32_t buf_hi_addr;=0D
+	uint32_t buf_lo_addr;=0D
+};=0D
+=0D
 struct hinic3_rq_wqe {=0D
 	union {=0D
+		struct hinic3_rq_compact_wqe compact_wqe;=0D
 		struct hinic3_rq_normal_wqe normal_wqe;=0D
 		struct hinic3_rq_extend_wqe extend_wqe;=0D
 	};=0D
 };=0D
 =0D
+struct hinic3_rq_ci_wb {=0D
+	union {=0D
+		struct {=0D
+			uint16_t cqe_num;=0D
+			uint16_t hw_ci;=0D
+		} bs;=0D
+		uint32_t value;=0D
+	} dw1;=0D
+=0D
+	uint32_t rsvd[3];=0D
+};=0D
+=0D
+=0D
 struct __rte_cache_aligned hinic3_rxq {=0D
 	struct hinic3_nic_dev *nic_dev;=0D
 =0D
@@ -263,6 +350,10 @@ struct __rte_cache_aligned hinic3_rxq {=0D
 	struct hinic3_rq_cqe *rx_cqe;=0D
 	struct rte_mempool *mb_pool;=0D
 =0D
+	const struct rte_memzone *ci_mz;=0D
+	struct hinic3_rq_ci_wb *rq_ci;=0D
+	rte_iova_t rq_ci_paddr;=0D
+=0D
 	const struct rte_memzone *cqe_mz;=0D
 	rte_iova_t cqe_start_paddr;=0D
 	void *cqe_start_vaddr;=0D
@@ -308,6 +399,7 @@ void hinic3_free_all_rxq_mbufs(struct hinic3_nic_dev *n=
ic_dev);=0D
 int hinic3_update_rss_config(struct rte_eth_dev *dev,=0D
 			     struct rte_eth_rss_conf *rss_conf);=0D
 =0D
+int hinic3_poll_integrated_cqe_rq_empty(struct hinic3_rxq *rxq);=0D
 int hinic3_poll_rq_empty(struct hinic3_rxq *rxq);=0D
 =0D
 void hinic3_dump_cqe_status(struct hinic3_rxq *rxq, uint32_t *cqe_done_cnt=
,=0D
@@ -369,4 +461,60 @@ hinic3_update_rq_local_ci(struct hinic3_rxq *rxq, uint=
16_t wqe_cnt)=0D
 	rxq->delta +=3D wqe_cnt;=0D
 }=0D
 =0D
+/**=0D
+ * Get receive cqe information=0D
+ *=0D
+ * @param[in] rxq=0D
+ *   Receive queue=0D
+ * @param[in] rx_cqe=0D
+ *   Receive cqe=0D
+ * @param[in] cqe_info=0D
+ *   Packet information parsed from cqe=0D
+ */=0D
+void=0D
+hinic3_rx_get_cqe_info(struct hinic3_rxq *rxq, volatile struct hinic3_rq_c=
qe *rx_cqe,=0D
+		       struct hinic3_cqe_info *cqe_info);=0D
+=0D
+/**=0D
+ * Get receive compact cqe information=0D
+ *=0D
+ * @param[in] rx_queue=0D
+ *   Receive queue=0D
+ * @param[in] rx_cqe=0D
+ *   Receive compact cqe=0D
+ * @param[in] cqe_info=0D
+ *   Packet information parsed from cqe=0D
+ */=0D
+void=0D
+hinic3_rx_get_compact_cqe_info(struct hinic3_rxq *rxq, volatile struct hin=
ic3_rq_cqe *rx_cqe,=0D
+			       struct hinic3_cqe_info *cqe_info);=0D
+=0D
+/**=0D
+ * Check whether pkt is received when CQE is separated=0D
+ *=0D
+ * @param[in] rxq=0D
+ *   Receive queue=0D
+ * @param[in] rx_cqe=0D
+ *   The CQE written by hw=0D
+ * @return=0D
+ *   True: Packet is received=0D
+ *   False: Packet is not received=0D
+ */=0D
+bool=0D
+hinic3_rx_separate_cqe_done(struct hinic3_rxq *rxq, volatile struct hinic3=
_rq_cqe **rx_cqe);=0D
+=0D
+/**=0D
+ * Check whether pkt is received when CQE is integrated=0D
+ *=0D
+ * @param[in] rxq=0D
+ *   Receive queue=0D
+ * @param[in] rx_cqe=0D
+ *   The CQE written by hw=0D
+ * @return=0D
+ *   True: Packet is received=0D
+ *   False: Packet is not received=0D
+ */=0D
+bool=0D
+hinic3_rx_integrated_cqe_done(struct hinic3_rxq *rxq, volatile struct hini=
c3_rq_cqe **rx_cqe);=0D
+=0D
 #endif /* _HINIC3_RX_H_ */=0D
-- =0D
2.45.1.windows.1=0D
=0D

