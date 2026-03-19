Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F50B109022A
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Mar 2026 13:54:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F62740674;
	Thu, 19 Mar 2026 14:53:13 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.2])
 by mails.dpdk.org (Postfix) with ESMTP id AC35A40649
 for <dev@dpdk.org>; Thu, 19 Mar 2026 14:53:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=+zeYEQl0LoHbpSH1o1Ju+abbJAiax72brwytK0iySvM=;
 b=Fc0jyd+DIG9BrDI7nRS1cOINSnUA/MEh19YfU2UwcQ9Wkh8DFx+DdyCGCis92e
 vB9Pcaq0YNYZO1+I4QEEEbRIJPK/Ft7C5W1h9Q5DZ1Rj3oYhMFrZtVivXhp5gRKa
 nPyjyKQ+DpUjKVyygDIR8xXGIWQzuMg9lvziq/cjRiqdY=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp1 (Coremail) with SMTP id Ac8vCgAX3Gek_7tpacAQAw--.19162S10;
 Thu, 19 Mar 2026 21:53:03 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>
Subject: [V6 6/7] net/hinic3: add tx ops to support Compact CQE
Date: Thu, 19 Mar 2026 21:52:12 +0800
Message-ID: <20260319135220.2390-7-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20260319135220.2390-1-wff_light@vip.163.com>
References: <20260316134335.1640-1-wff_light@vip.163.com>
 <20260319135220.2390-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: Ac8vCgAX3Gek_7tpacAQAw--.19162S10
X-Coremail-Antispam: 1Uf129KBjvAXoWfuw4fAFW3Ar1rZw4DCry8Zrb_yoW5ZFy8Wo
 WSqr15twn2vryxCFWj9w4DuF4Dtrs0yF45Jw4jyrWxZa17Xr1UG3y3Aw1Sga48W34qk3W7
 A3Z3KwnFkrsrJ39xn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUwa9aDUUUU
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNB94gmm7-7-EIQAA3m
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

In pkt send path, use different func callback to configure=0D
compact wqe and normal wqe offload.=0D
=0D
Signed-off-by: Feifei Wang <wangfeifei40@huawei.com>=0D
---=0D
 drivers/net/hinic3/hinic3_tx.c | 452 +++++++++++++++++----------------=0D
 drivers/net/hinic3/hinic3_tx.h | 146 +++++++++--=0D
 2 files changed, 360 insertions(+), 238 deletions(-)=0D
=0D
diff --git a/drivers/net/hinic3/hinic3_tx.c b/drivers/net/hinic3/hinic3_tx.=
c=0D
index c896fcc76b..e0ff095c04 100644=0D
--- a/drivers/net/hinic3/hinic3_tx.c=0D
+++ b/drivers/net/hinic3/hinic3_tx.c=0D
@@ -21,6 +21,7 @@=0D
 =0D
 #define HINIC3_TX_OUTER_CHECKSUM_FLAG_SET    1=0D
 #define HINIC3_TX_OUTER_CHECKSUM_FLAG_NO_SET 0=0D
+#define MAX_TSO_NUM_FRAG 1024=0D
 =0D
 #define HINIC3_TX_OFFLOAD_MASK \=0D
 	(HINIC3_TX_CKSUM_OFFLOAD_MASK | HINIC3_PKT_TX_VLAN_PKT)=0D
@@ -28,7 +29,8 @@=0D
 #define HINIC3_TX_CKSUM_OFFLOAD_MASK                          \=0D
 	(HINIC3_PKT_TX_IP_CKSUM | HINIC3_PKT_TX_TCP_CKSUM |   \=0D
 	 HINIC3_PKT_TX_UDP_CKSUM | HINIC3_PKT_TX_SCTP_CKSUM | \=0D
-	 HINIC3_PKT_TX_OUTER_IP_CKSUM | HINIC3_PKT_TX_TCP_SEG)=0D
+	 HINIC3_PKT_TX_OUTER_IP_CKSUM | HINIC3_PKT_TX_OUTER_UDP_CKSUM | \=0D
+	 HINIC3_PKT_TX_TCP_SEG)=0D
 =0D
 static inline uint16_t=0D
 hinic3_get_sq_free_wqebbs(struct hinic3_txq *sq)=0D
@@ -56,26 +58,23 @@ hinic3_get_sq_hw_ci(struct hinic3_txq *sq)=0D
 }=0D
 =0D
 static void *=0D
-hinic3_get_sq_wqe(struct hinic3_txq *sq, struct hinic3_wqe_info *wqe_info)=
=0D
+hinic3_sq_get_wqebbs(struct hinic3_txq *sq, uint16_t num_wqebbs, uint16_t =
*prod_idx)=0D
 {=0D
-	uint16_t cur_pi =3D MASKED_QUEUE_IDX(sq, sq->prod_idx);=0D
-	uint32_t end_pi;=0D
+	*prod_idx =3D MASKED_QUEUE_IDX(sq, sq->prod_idx);=0D
+	sq->prod_idx +=3D num_wqebbs;=0D
 =0D
-	end_pi =3D cur_pi + wqe_info->wqebb_cnt;=0D
-	sq->prod_idx +=3D wqe_info->wqebb_cnt;=0D
+	return NIC_WQE_ADDR(sq, *prod_idx);=0D
+}=0D
 =0D
-	wqe_info->owner =3D (uint8_t)(sq->owner);=0D
-	wqe_info->pi =3D cur_pi;=0D
-	wqe_info->wrapped =3D 0;=0D
+static inline uint16_t=0D
+hinic3_get_and_update_sq_owner(struct hinic3_txq *sq, uint16_t curr_pi, ui=
nt16_t wqebb_cnt)=0D
+{=0D
+	uint16_t owner =3D sq->owner;=0D
 =0D
-	if (unlikely(end_pi >=3D sq->q_depth)) {=0D
+	if (unlikely(curr_pi + wqebb_cnt >=3D sq->q_depth))=0D
 		sq->owner =3D !sq->owner;=0D
 =0D
-		if (likely(end_pi > sq->q_depth))=0D
-			wqe_info->wrapped =3D (uint8_t)(sq->q_depth - cur_pi);=0D
-	}=0D
-=0D
-	return NIC_WQE_ADDR(sq, cur_pi);=0D
+	return owner;=0D
 }=0D
 =0D
 static inline void=0D
@@ -90,61 +89,39 @@ hinic3_put_sq_wqe(struct hinic3_txq *sq, struct hinic3_=
wqe_info *wqe_info)=0D
 /**=0D
  * Sets the WQE combination information in the transmit queue (SQ).=0D
  *=0D
- * @param[in] txq=0D
+ * @param[in] sq=0D
  * Point to send queue.=0D
  * @param[out] wqe_combo=0D
  * Point to wqe_combo of send queue(SQ).=0D
- * @param[in] wqe=0D
- * Point to wqe of send queue(SQ).=0D
  * @param[in] wqe_info=0D
  * Point to wqe_info of send queue(SQ).=0D
  */=0D
 static void=0D
-hinic3_set_wqe_combo(struct hinic3_txq *txq,=0D
+hinic3_set_wqe_combo(struct hinic3_txq *sq,=0D
 		     struct hinic3_sq_wqe_combo *wqe_combo,=0D
-		     struct hinic3_sq_wqe *wqe,=0D
 		     struct hinic3_wqe_info *wqe_info)=0D
 {=0D
-	wqe_combo->hdr =3D &wqe->compact_wqe.wqe_desc;=0D
-=0D
-	if (wqe_info->offload) {=0D
-		if (wqe_info->wrapped =3D=3D HINIC3_TX_TASK_WRAPPED) {=0D
-			wqe_combo->task =3D (struct hinic3_sq_task *)=0D
-				(void *)txq->sq_head_addr;=0D
-			wqe_combo->bds_head =3D (struct hinic3_sq_bufdesc *)=0D
-				(void *)(txq->sq_head_addr + txq->wqebb_size);=0D
-		} else if (wqe_info->wrapped =3D=3D HINIC3_TX_BD_DESC_WRAPPED) {=0D
-			wqe_combo->task =3D &wqe->extend_wqe.task;=0D
-			wqe_combo->bds_head =3D (struct hinic3_sq_bufdesc *)=0D
-				(void *)(txq->sq_head_addr);=0D
-		} else {=0D
-			wqe_combo->task =3D &wqe->extend_wqe.task;=0D
-			wqe_combo->bds_head =3D wqe->extend_wqe.buf_desc;=0D
-		}=0D
+	uint16_t tmp_pi;=0D
 =0D
-		wqe_combo->wqe_type =3D SQ_WQE_EXTENDED_TYPE;=0D
-		wqe_combo->task_type =3D SQ_WQE_TASKSECT_16BYTES;=0D
+	wqe_combo->hdr =3D hinic3_sq_get_wqebbs(sq, 1, &wqe_info->pi);=0D
 =0D
+	if (wqe_info->wqebb_cnt =3D=3D 1) {=0D
+		/* compact wqe */=0D
+		wqe_combo->wqe_type =3D SQ_WQE_COMPACT_TYPE;=0D
+		wqe_combo->task_type =3D SQ_WQE_TASKSECT_4BYTES;=0D
+		wqe_combo->task =3D (struct hinic3_sq_task *)&wqe_combo->hdr->queue_info=
;=0D
+		wqe_info->owner =3D hinic3_get_and_update_sq_owner(sq, wqe_info->pi, 1);=
=0D
 		return;=0D
 	}=0D
 =0D
-	if (wqe_info->wrapped =3D=3D HINIC3_TX_TASK_WRAPPED) {=0D
-		wqe_combo->bds_head =3D (struct hinic3_sq_bufdesc *)=0D
-			(void *)(txq->sq_head_addr);=0D
-	} else {=0D
-		wqe_combo->bds_head =3D=0D
-			(struct hinic3_sq_bufdesc *)(&wqe->extend_wqe.task);=0D
-	}=0D
+	/* extend normal wqe */=0D
+	wqe_combo->wqe_type =3D SQ_WQE_EXTENDED_TYPE;=0D
+	wqe_combo->task_type =3D SQ_WQE_TASKSECT_16BYTES;=0D
+	wqe_combo->task =3D hinic3_sq_get_wqebbs(sq, 1, &tmp_pi);=0D
+	if (wqe_info->sge_cnt > 1)=0D
+		wqe_combo->bds_head =3D hinic3_sq_get_wqebbs(sq, wqe_info->sge_cnt - 1, =
&tmp_pi);=0D
 =0D
-	if (wqe_info->wqebb_cnt > 1) {=0D
-		wqe_combo->wqe_type =3D SQ_WQE_EXTENDED_TYPE;=0D
-		wqe_combo->task_type =3D SQ_WQE_TASKSECT_46BITS;=0D
-=0D
-		/* This section used as vlan insert, needs to clear. */=0D
-		wqe_combo->bds_head->rsvd =3D 0;=0D
-	} else {=0D
-		wqe_combo->wqe_type =3D SQ_WQE_COMPACT_TYPE;=0D
-	}=0D
+	wqe_info->owner =3D hinic3_get_and_update_sq_owner(sq, wqe_info->pi, wqe_=
info->wqebb_cnt);=0D
 }=0D
 =0D
 int=0D
@@ -311,6 +288,8 @@ hinic3_tx_done_cleanup(void *txq, uint32_t free_cnt)=0D
 /**=0D
  * Prepare the data packet to be sent and calculate the internal L3 offset=
.=0D
  *=0D
+ * @param[in] nic_dev=0D
+ * Pointer to NIC device structure.=0D
  * @param[in] mbuf=0D
  * Point to the mbuf to be processed.=0D
  * @param[out] inner_l3_offset=0D
@@ -319,14 +298,20 @@ hinic3_tx_done_cleanup(void *txq, uint32_t free_cnt)=
=0D
  * 0 as success, -EINVAL as failure.=0D
  */=0D
 static int=0D
-hinic3_tx_offload_pkt_prepare(struct rte_mbuf *mbuf, uint16_t *inner_l3_of=
fset)=0D
+hinic3_tx_offload_pkt_prepare(struct hinic3_nic_dev *nic_dev, struct rte_m=
buf *mbuf,=0D
+			      uint16_t *inner_l3_offset)=0D
 {=0D
 	uint64_t ol_flags =3D mbuf->ol_flags;=0D
 =0D
-	/* Only support vxlan offload. */=0D
-	if ((ol_flags & HINIC3_PKT_TX_TUNNEL_MASK) &&=0D
-	    (!(ol_flags & HINIC3_PKT_TX_TUNNEL_VXLAN)))=0D
-		return -EINVAL;=0D
+	if ((ol_flags & HINIC3_PKT_TX_TUNNEL_MASK)) {=0D
+		if (!(((ol_flags & HINIC3_PKT_TX_TUNNEL_VXLAN) &&=0D
+				HINIC3_SUPPORT_VXLAN_OFFLOAD(nic_dev)) ||=0D
+		      ((ol_flags & HINIC3_PKT_TX_TUNNEL_GENEVE) &&=0D
+				HINIC3_SUPPORT_GENEVE_OFFLOAD(nic_dev)) ||=0D
+		      ((ol_flags & HINIC3_PKT_TX_TUNNEL_IPIP) &&=0D
+				HINIC3_SUPPORT_IPXIP_OFFLOAD(nic_dev))))=0D
+			return -EINVAL;=0D
+	}=0D
 =0D
 #ifdef RTE_LIBRTE_ETHDEV_DEBUG=0D
 	if (rte_validate_tx_offload(mbuf) !=3D 0)=0D
@@ -358,107 +343,121 @@ hinic3_tx_offload_pkt_prepare(struct rte_mbuf *mbuf=
, uint16_t *inner_l3_offset)=0D
 	return 0;=0D
 }=0D
 =0D
-static inline void=0D
-hinic3_set_vlan_tx_offload(struct hinic3_sq_task *task, uint16_t vlan_tag,=
=0D
-			   uint8_t vlan_type)=0D
+void=0D
+hinic3_tx_set_normal_task_offload(struct hinic3_wqe_info *wqe_info,=0D
+				  struct hinic3_sq_wqe_combo *wqe_combo)=0D
+{=0D
+	struct hinic3_sq_task *task =3D wqe_combo->task;=0D
+	struct hinic3_offload_info *offload_info =3D &wqe_info->offload_info;=0D
+=0D
+	task->pkt_info0 =3D 0;=0D
+	task->pkt_info0 |=3D SQ_TASK_INFO0_SET(offload_info->inner_l4_en, INNER_L=
4_EN);=0D
+	task->pkt_info0 |=3D SQ_TASK_INFO0_SET(offload_info->inner_l3_en, INNER_L=
3_EN);=0D
+	task->pkt_info0 |=3D SQ_TASK_INFO0_SET(offload_info->encapsulation, TUNNE=
L_FLAG);=0D
+	task->pkt_info0 |=3D SQ_TASK_INFO0_SET(offload_info->out_l3_en, OUT_L3_EN=
);=0D
+	task->pkt_info0 |=3D SQ_TASK_INFO0_SET(offload_info->out_l4_en, OUT_L4_EN=
);=0D
+	task->pkt_info0 =3D hinic3_hw_be32(task->pkt_info0);=0D
+=0D
+	if (wqe_combo->task_type =3D=3D SQ_WQE_TASKSECT_16BYTES) {=0D
+		task->ip_identify =3D 0;=0D
+		task->pkt_info2 =3D 0;=0D
+		task->vlan_offload =3D 0;=0D
+		task->vlan_offload =3D SQ_TASK_INFO3_SET(offload_info->vlan_tag, VLAN_TA=
G) |=0D
+				     SQ_TASK_INFO3_SET(offload_info->vlan_sel, VLAN_TYPE) |=0D
+				     SQ_TASK_INFO3_SET(offload_info->vlan_valid, VLAN_TAG_VALID);=0D
+		task->vlan_offload =3D hinic3_hw_be32(task->vlan_offload);=0D
+	}=0D
+}=0D
+=0D
+void=0D
+hinic3_tx_set_compact_task_offload(struct hinic3_wqe_info *wqe_info,=0D
+				   struct hinic3_sq_wqe_combo *wqe_combo)=0D
 {=0D
-	task->vlan_offload =3D SQ_TASK_INFO3_SET(vlan_tag, VLAN_TAG) |=0D
-			     SQ_TASK_INFO3_SET(vlan_type, VLAN_TYPE) |=0D
-			     SQ_TASK_INFO3_SET(1U, VLAN_TAG_VALID);=0D
+	struct hinic3_sq_task *task =3D wqe_combo->task;=0D
+	struct hinic3_offload_info *offload_info =3D &wqe_info->offload_info;=0D
+=0D
+	task->pkt_info0 =3D 0;=0D
+	wqe_combo->task->pkt_info0 =3D=0D
+			SQ_TASK_INFO_SET(offload_info->out_l3_en, OUT_L3_EN) |=0D
+			SQ_TASK_INFO_SET(offload_info->out_l4_en, OUT_L4_EN) |=0D
+			SQ_TASK_INFO_SET(offload_info->inner_l3_en, INNER_L3_EN) |=0D
+			SQ_TASK_INFO_SET(offload_info->inner_l4_en, INNER_L4_EN) |=0D
+			SQ_TASK_INFO_SET(offload_info->vlan_valid, VLAN_VALID) |=0D
+			SQ_TASK_INFO_SET(offload_info->vlan_sel, VLAN_SEL) |=0D
+			SQ_TASK_INFO_SET(offload_info->vlan_tag, VLAN_TAG);=0D
+=0D
+	task->pkt_info0 =3D hinic3_hw_be32(task->pkt_info0);=0D
 }=0D
 =0D
-/**=0D
- * Set the corresponding offload information based on ol_flags of the mbuf=
.=0D
- *=0D
- * @param[in] mbuf=0D
- * Point to the mbuf for which offload needs to be set in the sending queu=
e.=0D
- * @param[out] task=0D
- * Point to task of send queue(SQ).=0D
- * @param[out] wqe_info=0D
- * Point to wqe_info of send queue(SQ).=0D
- * @return=0D
- * 0 as success, -EINVAL as failure.=0D
- */=0D
 static int=0D
-hinic3_set_tx_offload(struct rte_mbuf *mbuf, struct hinic3_sq_task *task,=
=0D
-		      struct hinic3_wqe_info *wqe_info)=0D
+hinic3_set_tx_offload(struct hinic3_nic_dev *nic_dev,=0D
+		      struct rte_mbuf *mbuf,=0D
+		      struct hinic3_sq_wqe_combo *wqe_combo,=0D
+					  struct hinic3_wqe_info *wqe_info)=0D
 {=0D
 	uint64_t ol_flags =3D mbuf->ol_flags;=0D
-	uint16_t pld_offset =3D 0;=0D
-	uint32_t queue_info =3D 0;=0D
-	uint16_t vlan_tag;=0D
-=0D
-	task->pkt_info0 =3D 0;=0D
-	task->ip_identify =3D 0;=0D
-	task->pkt_info2 =3D 0;=0D
-	task->vlan_offload =3D 0;=0D
+	struct hinic3_offload_info *offload_info =3D &wqe_info->offload_info;=0D
 =0D
 	/* Vlan offload. */=0D
 	if (unlikely(ol_flags & HINIC3_PKT_TX_VLAN_PKT)) {=0D
-		vlan_tag =3D mbuf->vlan_tci;=0D
-		hinic3_set_vlan_tx_offload(task, vlan_tag, HINIC3_TX_TPID0);=0D
-		task->vlan_offload =3D hinic3_hw_be32(task->vlan_offload);=0D
+		offload_info->vlan_valid =3D 1;=0D
+		offload_info->vlan_tag =3D mbuf->vlan_tci;=0D
+		offload_info->vlan_sel =3D HINIC3_TX_TPID0;=0D
 	}=0D
-	/* Cksum offload. */=0D
 	if (!(ol_flags & HINIC3_TX_CKSUM_OFFLOAD_MASK))=0D
-		return 0;=0D
+		goto set_tx_wqe_offload;=0D
 =0D
 	/* Tso offload. */=0D
 	if (ol_flags & HINIC3_PKT_TX_TCP_SEG) {=0D
-		pld_offset =3D wqe_info->payload_offset;=0D
-		if ((pld_offset >> 1) > MAX_PAYLOAD_OFFSET)=0D
+		wqe_info->queue_info.payload_offset =3D wqe_info->payload_offset;=0D
+		if ((wqe_info->payload_offset >> 1) > MAX_PAYLOAD_OFFSET)=0D
 			return -EINVAL;=0D
 =0D
-		task->pkt_info0 |=3D SQ_TASK_INFO0_SET(1U, INNER_L4_EN);=0D
-		task->pkt_info0 |=3D SQ_TASK_INFO0_SET(1U, INNER_L3_EN);=0D
-=0D
-		queue_info |=3D SQ_CTRL_QUEUE_INFO_SET(1U, TSO);=0D
-		queue_info |=3D SQ_CTRL_QUEUE_INFO_SET(pld_offset >> 1, PLDOFF);=0D
-=0D
-		/* Set MSS value. */=0D
-		queue_info =3D SQ_CTRL_QUEUE_INFO_CLEAR(queue_info, MSS);=0D
-		queue_info |=3D SQ_CTRL_QUEUE_INFO_SET(mbuf->tso_segsz, MSS);=0D
+		offload_info->inner_l3_en =3D 1;=0D
+		offload_info->inner_l4_en =3D 1;=0D
+		wqe_info->queue_info.tso =3D 1;=0D
+		wqe_info->queue_info.mss =3D mbuf->tso_segsz;=0D
 	} else {=0D
 		if (ol_flags & HINIC3_PKT_TX_IP_CKSUM)=0D
-			task->pkt_info0 |=3D SQ_TASK_INFO0_SET(1U, INNER_L3_EN);=0D
+			offload_info->inner_l3_en =3D 1;=0D
 =0D
 		switch (ol_flags & HINIC3_PKT_TX_L4_MASK) {=0D
 		case HINIC3_PKT_TX_TCP_CKSUM:=0D
 		case HINIC3_PKT_TX_UDP_CKSUM:=0D
 		case HINIC3_PKT_TX_SCTP_CKSUM:=0D
-			task->pkt_info0 |=3D SQ_TASK_INFO0_SET(1U, INNER_L4_EN);=0D
+			offload_info->inner_l4_en =3D 1;=0D
 			break;=0D
-=0D
 		case HINIC3_PKT_TX_L4_NO_CKSUM:=0D
 			break;=0D
-=0D
 		default:=0D
 			PMD_DRV_LOG(INFO, "not support pkt type");=0D
 			return -EINVAL;=0D
 		}=0D
 	}=0D
 =0D
-	/* For vxlan, also can support PKT_TX_TUNNEL_GRE, etc. */=0D
 	switch (ol_flags & HINIC3_PKT_TX_TUNNEL_MASK) {=0D
 	case HINIC3_PKT_TX_TUNNEL_VXLAN:=0D
-		task->pkt_info0 |=3D SQ_TASK_INFO0_SET(1U, TUNNEL_FLAG);=0D
+	case HINIC3_PKT_TX_TUNNEL_VXLAN_GPE:=0D
+	case HINIC3_PKT_TX_TUNNEL_GENEVE:=0D
+		offload_info->encapsulation =3D 1;=0D
+		wqe_info->queue_info.udp_dp_en =3D 1;=0D
 		break;=0D
-=0D
 	case 0:=0D
 		break;=0D
 =0D
 	default:=0D
-		/* For non UDP/GRE tunneling, drop the tunnel packet. */=0D
 		PMD_DRV_LOG(INFO, "not support tunnel pkt type");=0D
 		return -EINVAL;=0D
 	}=0D
 =0D
 	if (ol_flags & HINIC3_PKT_TX_OUTER_IP_CKSUM)=0D
-		task->pkt_info0 |=3D SQ_TASK_INFO0_SET(1U, OUT_L3_EN);=0D
+		offload_info->out_l3_en =3D 1;=0D
 =0D
-	task->pkt_info0 =3D hinic3_hw_be32(task->pkt_info0);=0D
-	task->pkt_info2 =3D hinic3_hw_be32(task->pkt_info2);=0D
-	wqe_info->queue_info =3D queue_info;=0D
+	if (ol_flags & HINIC3_PKT_TX_OUTER_UDP_CKSUM)=0D
+		offload_info->out_l4_en =3D 1;=0D
+=0D
+set_tx_wqe_offload:=0D
+	nic_dev->tx_ops->tx_set_wqe_offload(wqe_info, wqe_combo);=0D
 =0D
 	return 0;=0D
 }=0D
@@ -477,7 +476,9 @@ static bool=0D
 hinic3_is_tso_sge_valid(struct rte_mbuf *mbuf, struct hinic3_wqe_info *wqe=
_info)=0D
 {=0D
 	uint32_t total_len, limit_len, checked_len, left_len, adjust_mss;=0D
-	uint32_t i, max_sges, left_sges, first_len;=0D
+	uint32_t max_sges, left_sges, first_len;=0D
+	uint32_t payload_len, frag_num;=0D
+	uint32_t i;=0D
 	struct rte_mbuf *mbuf_head, *mbuf_first;=0D
 	struct rte_mbuf *mbuf_pre =3D mbuf;=0D
 =0D
@@ -485,6 +486,17 @@ hinic3_is_tso_sge_valid(struct rte_mbuf *mbuf, struct =
hinic3_wqe_info *wqe_info)=0D
 	mbuf_head =3D mbuf;=0D
 	mbuf_first =3D mbuf;=0D
 =0D
+	/* Calculate the number of message payload frag,=0D
+	 * if it exceeds the hardware limit of 10 bits,=0D
+	 * packet will be discarded.=0D
+	 */=0D
+	payload_len =3D mbuf_head->pkt_len - wqe_info->payload_offset;=0D
+	frag_num =3D (payload_len + mbuf_head->tso_segsz - 1) / mbuf_head->tso_se=
gsz;=0D
+	if (frag_num > MAX_TSO_NUM_FRAG) {=0D
+		PMD_DRV_LOG(WARNING, "tso frag num over hw limit, frag_num:0x%x.", frag_=
num);=0D
+		return false;=0D
+	}=0D
+=0D
 	/* Tso sge number validation. */=0D
 	if (unlikely(left_sges >=3D HINIC3_NONTSO_PKT_MAX_SGE)) {=0D
 		checked_len =3D 0;=0D
@@ -544,9 +556,48 @@ hinic3_is_tso_sge_valid(struct rte_mbuf *mbuf, struct =
hinic3_wqe_info *wqe_info)=0D
 	return true;=0D
 }=0D
 =0D
+static int=0D
+hinic3_non_tso_pkt_pre_process(struct rte_mbuf *mbuf, struct hinic3_wqe_in=
fo *wqe_info)=0D
+{=0D
+	struct rte_mbuf *mbuf_pkt =3D mbuf;=0D
+	uint32_t total_len =3D 0;=0D
+	uint16_t i;=0D
+=0D
+	if (likely(HINIC3_NONTSO_SEG_NUM_VALID(mbuf->nb_segs)))=0D
+		return 0;=0D
+=0D
+	/* Non-tso packet length must less than 64KB. */=0D
+	if (unlikely(mbuf->pkt_len > MAX_SINGLE_SGE_SIZE))=0D
+		return -EINVAL;=0D
+=0D
+	/*=0D
+	 * Mbuf number of non-tso packet must less than the sge number=0D
+	 * that nic can support. The excess part will be copied to another=0D
+	 * mbuf.=0D
+	 */=0D
+	for (i =3D 0; i < (HINIC3_NONTSO_PKT_MAX_SGE - 1); i++) {=0D
+		total_len +=3D mbuf_pkt->data_len;=0D
+		mbuf_pkt =3D mbuf_pkt->next;=0D
+	}=0D
+=0D
+	/*=0D
+	 * Max copy mbuf size is 4KB, packet will be dropped directly,=0D
+	 * if total copy length is more than it.=0D
+	 */=0D
+	if ((total_len + HINIC3_COPY_MBUF_SIZE) < mbuf->pkt_len)=0D
+		return -EINVAL;=0D
+=0D
+	wqe_info->sge_cnt =3D HINIC3_NONTSO_PKT_MAX_SGE;=0D
+	wqe_info->cpy_mbuf_cnt =3D 1;=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
 /**=0D
  * Checks and processes transport offload information for data packets.=0D
  *=0D
+ * @param[in] nic_dev=0D
+ * Pointer to NIC device structure.=0D
  * @param[in] mbuf=0D
  * Point to the mbuf to send.=0D
  * @param[in] wqe_info=0D
@@ -555,56 +606,29 @@ hinic3_is_tso_sge_valid(struct rte_mbuf *mbuf, struct=
 hinic3_wqe_info *wqe_info)=0D
  * 0 as success, -EINVAL as failure.=0D
  */=0D
 static int=0D
-hinic3_get_tx_offload(struct rte_mbuf *mbuf, struct hinic3_wqe_info *wqe_i=
nfo)=0D
+hinic3_get_tx_offload(struct hinic3_nic_dev *nic_dev, struct rte_mbuf *mbu=
f,=0D
+		      struct hinic3_wqe_info *wqe_info)=0D
 {=0D
 	uint64_t ol_flags =3D mbuf->ol_flags;=0D
-	uint16_t i, total_len, inner_l3_offset =3D 0;=0D
+	uint16_t inner_l3_offset =3D 0;=0D
 	int err;=0D
-	struct rte_mbuf *mbuf_pkt =3D NULL;=0D
 =0D
 	wqe_info->sge_cnt =3D mbuf->nb_segs;=0D
+	wqe_info->cpy_mbuf_cnt =3D 0;=0D
 	/* Check if the packet set available offload flags. */=0D
 	if (!(ol_flags & HINIC3_TX_OFFLOAD_MASK)) {=0D
 		wqe_info->offload =3D 0;=0D
-		return 0;=0D
+		return hinic3_non_tso_pkt_pre_process(mbuf, wqe_info);=0D
 	}=0D
 =0D
 	wqe_info->offload =3D 1;=0D
-	err =3D hinic3_tx_offload_pkt_prepare(mbuf, &inner_l3_offset);=0D
+	err =3D hinic3_tx_offload_pkt_prepare(nic_dev, mbuf, &inner_l3_offset);=0D
 	if (err)=0D
 		return err;=0D
 =0D
-	/* Non tso mbuf only check sge num. */=0D
+	/* Non-tso mbuf only check sge num. */=0D
 	if (likely(!(mbuf->ol_flags & HINIC3_PKT_TX_TCP_SEG))) {=0D
-		if (unlikely(mbuf->pkt_len > MAX_SINGLE_SGE_SIZE))=0D
-			/* Non tso packet len must less than 64KB. */=0D
-			return -EINVAL;=0D
-=0D
-		if (likely(HINIC3_NONTSO_SEG_NUM_VALID(mbuf->nb_segs)))=0D
-			/* Valid non-tso mbuf. */=0D
-			return 0;=0D
-=0D
-		/*=0D
-		 * The number of non-tso packet fragments must be less than 38,=0D
-		 * and mbuf segs greater than 38 must be copied to other=0D
-		 * buffers.=0D
-		 */=0D
-		total_len =3D 0;=0D
-		mbuf_pkt =3D mbuf;=0D
-		for (i =3D 0; i < (HINIC3_NONTSO_PKT_MAX_SGE - 1); i++) {=0D
-			total_len +=3D mbuf_pkt->data_len;=0D
-			mbuf_pkt =3D mbuf_pkt->next;=0D
-		}=0D
-=0D
-		/* Default support copy total 4k mbuf segs. */=0D
-		if ((uint32_t)(total_len + (uint16_t)HINIC3_COPY_MBUF_SIZE) <=0D
-		    mbuf->pkt_len)=0D
-			return -EINVAL;=0D
-=0D
-		wqe_info->sge_cnt =3D HINIC3_NONTSO_PKT_MAX_SGE;=0D
-		wqe_info->cpy_mbuf_cnt =3D 1;=0D
-=0D
-		return 0;=0D
+		return hinic3_non_tso_pkt_pre_process(mbuf, wqe_info);=0D
 	}=0D
 =0D
 	/* Tso mbuf. */=0D
@@ -629,6 +653,7 @@ hinic3_set_buf_desc(struct hinic3_sq_bufdesc *buf_descs=
, rte_iova_t addr,=0D
 	buf_descs->hi_addr =3D hinic3_hw_be32(upper_32_bits(addr));=0D
 	buf_descs->lo_addr =3D hinic3_hw_be32(lower_32_bits(addr));=0D
 	buf_descs->len =3D hinic3_hw_be32(len);=0D
+	buf_descs->rsvd =3D 0;=0D
 }=0D
 =0D
 static inline struct rte_mbuf *=0D
@@ -701,7 +726,6 @@ hinic3_mbuf_dma_map_sge(struct hinic3_txq *txq, struct =
rte_mbuf *mbuf,=0D
 {=0D
 	struct hinic3_sq_wqe_desc *wqe_desc =3D wqe_combo->hdr;=0D
 	struct hinic3_sq_bufdesc *buf_desc =3D wqe_combo->bds_head;=0D
-=0D
 	uint16_t nb_segs =3D wqe_info->sge_cnt - wqe_info->cpy_mbuf_cnt;=0D
 	uint16_t real_segs =3D mbuf->nb_segs;=0D
 	rte_iova_t dma_addr;=0D
@@ -736,11 +760,8 @@ hinic3_mbuf_dma_map_sge(struct hinic3_txq *txq, struct=
 rte_mbuf *mbuf,=0D
 			 * Parts of wqe is in sq bottom while parts=0D
 			 * of wqe is in sq head.=0D
 			 */=0D
-			if (unlikely(wqe_info->wrapped &&=0D
-				     (uint64_t)buf_desc =3D=3D txq->sq_bot_sge_addr))=0D
-				buf_desc =3D (struct hinic3_sq_bufdesc *)=0D
-					   (void *)txq->sq_head_addr;=0D
-=0D
+			if (unlikely((uint64_t)buf_desc =3D=3D txq->sq_bot_sge_addr))=0D
+				buf_desc =3D (struct hinic3_sq_bufdesc *)txq->sq_head_addr;=0D
 			hinic3_set_buf_desc(buf_desc, dma_addr, mbuf->data_len);=0D
 			buf_desc++;=0D
 		}=0D
@@ -777,10 +798,8 @@ hinic3_mbuf_dma_map_sge(struct hinic3_txq *txq, struct=
 rte_mbuf *mbuf,=0D
 				hinic3_hw_be32(lower_32_bits(dma_addr));=0D
 			wqe_desc->ctrl_len =3D mbuf->data_len;=0D
 		} else {=0D
-			if (unlikely(wqe_info->wrapped &&=0D
-				     ((uint64_t)buf_desc =3D=3D txq->sq_bot_sge_addr)))=0D
-				buf_desc =3D (struct hinic3_sq_bufdesc *)=0D
-						   txq->sq_head_addr;=0D
+			if (unlikely(((uint64_t)buf_desc =3D=3D txq->sq_bot_sge_addr)))=0D
+				buf_desc =3D (struct hinic3_sq_bufdesc *)txq->sq_head_addr;=0D
 =0D
 			hinic3_set_buf_desc(buf_desc, dma_addr, mbuf->data_len);=0D
 		}=0D
@@ -802,44 +821,44 @@ static void=0D
 hinic3_prepare_sq_ctrl(struct hinic3_sq_wqe_combo *wqe_combo,=0D
 		       struct hinic3_wqe_info *wqe_info)=0D
 {=0D
+	struct hinic3_queue_info *queue_info =3D &wqe_info->queue_info;=0D
 	struct hinic3_sq_wqe_desc *wqe_desc =3D wqe_combo->hdr;=0D
+	uint32_t *qsf =3D &wqe_desc->queue_info;=0D
 =0D
-	if (wqe_combo->wqe_type =3D=3D SQ_WQE_COMPACT_TYPE) {=0D
-		wqe_desc->ctrl_len |=3D=0D
-			SQ_CTRL_SET(SQ_NORMAL_WQE, DATA_FORMAT) |=0D
-			SQ_CTRL_SET(wqe_combo->wqe_type, EXTENDED) |=0D
-			SQ_CTRL_SET(wqe_info->owner, OWNER);=0D
-		wqe_desc->ctrl_len =3D hinic3_hw_be32(wqe_desc->ctrl_len);=0D
-=0D
-		/* Compact wqe queue_info will transfer to ucode. */=0D
-		wqe_desc->queue_info =3D 0;=0D
-=0D
-		return;=0D
-	}=0D
-=0D
-	wqe_desc->ctrl_len |=3D SQ_CTRL_SET(wqe_info->sge_cnt, BUFDESC_NUM) |=0D
-			      SQ_CTRL_SET(wqe_combo->task_type, TASKSECT_LEN) |=0D
-			      SQ_CTRL_SET(SQ_NORMAL_WQE, DATA_FORMAT) |=0D
+	wqe_desc->ctrl_len |=3D SQ_CTRL_SET(SQ_NORMAL_WQE, DIRECT) |=0D
 			      SQ_CTRL_SET(wqe_combo->wqe_type, EXTENDED) |=0D
 			      SQ_CTRL_SET(wqe_info->owner, OWNER);=0D
 =0D
-	wqe_desc->ctrl_len =3D hinic3_hw_be32(wqe_desc->ctrl_len);=0D
-=0D
-	wqe_desc->queue_info =3D wqe_info->queue_info;=0D
-	wqe_desc->queue_info |=3D SQ_CTRL_QUEUE_INFO_SET(1U, UC);=0D
-=0D
-	if (!SQ_CTRL_QUEUE_INFO_GET(wqe_desc->queue_info, MSS)) {=0D
-		wqe_desc->queue_info |=3D=0D
-			SQ_CTRL_QUEUE_INFO_SET(TX_MSS_DEFAULT, MSS);=0D
-	} else if (SQ_CTRL_QUEUE_INFO_GET(wqe_desc->queue_info, MSS) <=0D
-		   TX_MSS_MIN) {=0D
-		/* Mss should not less than 80. */=0D
-		wqe_desc->queue_info =3D=0D
-			SQ_CTRL_QUEUE_INFO_CLEAR(wqe_desc->queue_info, MSS);=0D
-		wqe_desc->queue_info |=3D SQ_CTRL_QUEUE_INFO_SET(TX_MSS_MIN, MSS);=0D
+	if (wqe_combo->wqe_type =3D=3D SQ_WQE_EXTENDED_TYPE) {=0D
+		wqe_desc->ctrl_len |=3D SQ_CTRL_SET(wqe_info->sge_cnt, BUFDESC_NUM) |=0D
+				      SQ_CTRL_SET(wqe_combo->task_type, TASKSECT_LEN) |=0D
+				      SQ_CTRL_SET(SQ_WQE_SGL, DATA_FORMAT);=0D
+=0D
+		*qsf =3D SQ_CTRL_QUEUE_INFO_SET(1, UC) |=0D
+		       SQ_CTRL_QUEUE_INFO_SET(queue_info->sctp, SCTP) |=0D
+		       SQ_CTRL_QUEUE_INFO_SET(queue_info->udp_dp_en, TCPUDP_CS) |=0D
+		       SQ_CTRL_QUEUE_INFO_SET(queue_info->tso, TSO) |=0D
+		       SQ_CTRL_QUEUE_INFO_SET(queue_info->ufo, UFO) |=0D
+		       SQ_CTRL_QUEUE_INFO_SET(queue_info->payload_offset >> 1, PLDOFF) |=
=0D
+		       SQ_CTRL_QUEUE_INFO_SET(queue_info->pkt_type, PKT_TYPE) |=0D
+		       SQ_CTRL_QUEUE_INFO_SET(queue_info->mss, MSS);=0D
+=0D
+		if (!SQ_CTRL_QUEUE_INFO_GET(*qsf, MSS)) {=0D
+			*qsf |=3D SQ_CTRL_QUEUE_INFO_SET(TX_MSS_DEFAULT, MSS);=0D
+		} else if (SQ_CTRL_QUEUE_INFO_GET(*qsf, MSS) < TX_MSS_MIN) {=0D
+			/* MSS should not less than 80. */=0D
+			*qsf =3D SQ_CTRL_QUEUE_INFO_CLEAR(*qsf, MSS);=0D
+			*qsf |=3D SQ_CTRL_QUEUE_INFO_SET(TX_MSS_MIN, MSS);=0D
+		}=0D
+		*qsf =3D hinic3_hw_be32(*qsf);=0D
+	} else {=0D
+		wqe_desc->ctrl_len |=3D SQ_CTRL_COMPACT_QUEUE_INFO_SET(queue_info->sctp,=
 SCTP) |=0D
+				SQ_CTRL_COMPACT_QUEUE_INFO_SET(queue_info->udp_dp_en, UDP_DP_EN) |=0D
+				SQ_CTRL_COMPACT_QUEUE_INFO_SET(queue_info->ufo, UFO) |=0D
+				SQ_CTRL_COMPACT_QUEUE_INFO_SET(queue_info->pkt_type, PKT_TYPE);=0D
 	}=0D
 =0D
-	wqe_desc->queue_info =3D hinic3_hw_be32(wqe_desc->queue_info);=0D
+	wqe_desc->ctrl_len =3D hinic3_hw_be32(wqe_desc->ctrl_len);=0D
 }=0D
 =0D
 /**=0D
@@ -861,9 +880,7 @@ hinic3_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_p=
kts, uint16_t nb_pkts)=0D
 	struct hinic3_tx_info *tx_info =3D NULL;=0D
 	struct rte_mbuf *mbuf_pkt =3D NULL;=0D
 	struct hinic3_sq_wqe_combo wqe_combo =3D {0};=0D
-	struct hinic3_sq_wqe *sq_wqe =3D NULL;=0D
 	struct hinic3_wqe_info wqe_info =3D {0};=0D
-=0D
 	uint32_t offload_err, free_cnt;=0D
 	uint64_t tx_bytes =3D 0;=0D
 	uint16_t free_wqebb_cnt, nb_tx;=0D
@@ -885,16 +902,28 @@ hinic3_xmit_pkts(void *tx_queue, struct rte_mbuf **tx=
_pkts, uint16_t nb_pkts)=0D
 	/* Tx loop routine. */=0D
 	for (nb_tx =3D 0; nb_tx < nb_pkts; nb_tx++) {=0D
 		mbuf_pkt =3D *tx_pkts++;=0D
-		if (unlikely(hinic3_get_tx_offload(mbuf_pkt, &wqe_info))) {=0D
+		if (unlikely(hinic3_get_tx_offload(txq->nic_dev, mbuf_pkt, &wqe_info))) =
{=0D
 			txq->txq_stats.offload_errors++;=0D
 			break;=0D
 		}=0D
 =0D
-		if (!wqe_info.offload)=0D
-			wqe_info.wqebb_cnt =3D wqe_info.sge_cnt;=0D
-		else=0D
-			/* Use extended sq wqe with normal TS. */=0D
-			wqe_info.wqebb_cnt =3D wqe_info.sge_cnt + 1;=0D
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
 =0D
 		free_wqebb_cnt =3D hinic3_get_sq_free_wqebbs(txq);=0D
 		if (unlikely(wqe_info.wqebb_cnt > free_wqebb_cnt)) {=0D
@@ -907,28 +936,16 @@ hinic3_xmit_pkts(void *tx_queue, struct rte_mbuf **tx=
_pkts, uint16_t nb_pkts)=0D
 			}=0D
 		}=0D
 =0D
-		/* Get sq wqe address from wqe_page. */=0D
-		sq_wqe =3D hinic3_get_sq_wqe(txq, &wqe_info);=0D
-		if (unlikely(!sq_wqe)) {=0D
-			txq->txq_stats.tx_busy++;=0D
-			break;=0D
-		}=0D
-=0D
 		/* Task or bd section maybe wrapped for one wqe. */=0D
-		hinic3_set_wqe_combo(txq, &wqe_combo, sq_wqe, &wqe_info);=0D
+		hinic3_set_wqe_combo(txq, &wqe_combo, &wqe_info);=0D
 =0D
-		wqe_info.queue_info =3D 0;=0D
 		/* Fill tx packet offload into qsf and task field. */=0D
-		if (wqe_info.offload) {=0D
-			offload_err =3D hinic3_set_tx_offload(mbuf_pkt,=0D
-							    wqe_combo.task,=0D
-							    &wqe_info);=0D
+		offload_err =3D hinic3_set_tx_offload(txq->nic_dev, mbuf_pkt, &wqe_combo=
, &wqe_info);=0D
 			if (unlikely(offload_err)) {=0D
 				hinic3_put_sq_wqe(txq, &wqe_info);=0D
 				txq->txq_stats.offload_errors++;=0D
 				break;=0D
 			}=0D
-		}=0D
 =0D
 		/* Fill sq_wqe buf_desc and bd_desc. */=0D
 		err =3D hinic3_mbuf_dma_map_sge(txq, mbuf_pkt, &wqe_combo,=0D
@@ -944,7 +961,12 @@ hinic3_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_=
pkts, uint16_t nb_pkts)=0D
 		tx_info->mbuf =3D mbuf_pkt;=0D
 		tx_info->wqebb_cnt =3D wqe_info.wqebb_cnt;=0D
 =0D
-		hinic3_prepare_sq_ctrl(&wqe_combo, &wqe_info);=0D
+		/*=0D
+		 * For wqe compact type, no need to prepare=0D
+		 * sq ctrl info.=0D
+		 */=0D
+		if (wqe_combo.wqe_type !=3D SQ_WQE_COMPACT_TYPE)=0D
+			hinic3_prepare_sq_ctrl(&wqe_combo, &wqe_info);=0D
 =0D
 		tx_bytes +=3D mbuf_pkt->pkt_len;=0D
 	}=0D
diff --git a/drivers/net/hinic3/hinic3_tx.h b/drivers/net/hinic3/hinic3_tx.=
h=0D
index 21958a00cc..e0ed9908ad 100644=0D
--- a/drivers/net/hinic3/hinic3_tx.h=0D
+++ b/drivers/net/hinic3/hinic3_tx.h=0D
@@ -6,30 +6,40 @@=0D
 #define _HINIC3_TX_H_=0D
 =0D
 #define MAX_SINGLE_SGE_SIZE		 65536=0D
-#define HINIC3_NONTSO_PKT_MAX_SGE	 38 /**< non-tso max sge 38. */=0D
+#define HINIC3_NONTSO_PKT_MAX_SGE	 32 /**< non-tso max sge 32. */=0D
 #define HINIC3_NONTSO_SEG_NUM_VALID(num) ((num) <=3D HINIC3_NONTSO_PKT_MAX=
_SGE)=0D
 =0D
 #define HINIC3_TSO_PKT_MAX_SGE		127 /**< tso max sge 127. */=0D
 #define HINIC3_TSO_SEG_NUM_INVALID(num) ((num) > HINIC3_TSO_PKT_MAX_SGE)=0D
 =0D
-/* Tx offload info. */=0D
-struct hinic3_tx_offload_info {=0D
-	uint8_t outer_l2_len;=0D
-	uint8_t outer_l3_type;=0D
-	uint16_t outer_l3_len;=0D
-=0D
-	uint8_t inner_l2_len;=0D
-	uint8_t inner_l3_type;=0D
-	uint16_t inner_l3_len;=0D
-=0D
-	uint8_t tunnel_length;=0D
-	uint8_t tunnel_type;=0D
-	uint8_t inner_l4_type;=0D
-	uint8_t inner_l4_len;=0D
+/* Tx wqe queue info */=0D
+struct hinic3_queue_info {=0D
+	uint8_t pri;=0D
+	uint8_t uc;=0D
+	uint8_t sctp;=0D
+	uint8_t udp_dp_en;=0D
+	uint8_t tso;=0D
+	uint8_t ufo;=0D
+	uint8_t payload_offset;=0D
+	uint8_t pkt_type;=0D
+	uint16_t mss;=0D
+	uint16_t rsvd;=0D
+};=0D
 =0D
-	uint16_t payload_offset;=0D
-	uint8_t inner_l4_tcp_udp;=0D
-	uint8_t rsvd0; /**< Reserved field. */=0D
+/* Tx wqe offload info */=0D
+struct hinic3_offload_info {=0D
+	uint8_t encapsulation;=0D
+	uint8_t esp_next_proto;=0D
+	uint8_t inner_l4_en;=0D
+	uint8_t inner_l3_en;=0D
+	uint8_t out_l4_en;=0D
+	uint8_t out_l3_en;=0D
+	uint8_t ipsec_offload;=0D
+	uint8_t pkt_1588;=0D
+	uint8_t vlan_sel;=0D
+	uint8_t vlan_valid;=0D
+	uint16_t vlan_tag;=0D
+	uint32_t ip_identify;=0D
 };=0D
 =0D
 /* Tx wqe ctx. */=0D
@@ -42,14 +52,15 @@ struct hinic3_wqe_info {=0D
 	uint8_t rsvd0; /**< Reserved field 0. */=0D
 	uint16_t payload_offset;=0D
 =0D
-	uint8_t wrapped;=0D
+	uint8_t rsvd1; /**< Reserved field 1. */=0D
 	uint8_t owner;=0D
 	uint16_t pi;=0D
 =0D
 	uint16_t wqebb_cnt;=0D
-	uint16_t rsvd1; /**< Reserved field 1. */=0D
+	uint16_t rsvd2; /**< Reserved field 2. */=0D
 =0D
-	uint32_t queue_info;=0D
+	struct hinic3_queue_info queue_info;=0D
+	struct hinic3_offload_info offload_info;=0D
 };=0D
 =0D
 /* Descriptor for the send queue of wqe. */=0D
@@ -103,8 +114,15 @@ struct hinic3_sq_wqe_combo {=0D
 	uint32_t task_type;=0D
 };=0D
 =0D
-enum sq_wqe_data_format {=0D
+/* Tx queue ctrl info */=0D
+enum sq_wqe_type {=0D
 	SQ_NORMAL_WQE =3D 0,=0D
+	SQ_DIRECT_WQE =3D 1,=0D
+};=0D
+=0D
+enum sq_wqe_data_format {=0D
+	SQ_WQE_SGL =3D 0,=0D
+	SQ_WQE_INLINE_DATA =3D 1,=0D
 };=0D
 =0D
 /* Indicates the type of a WQE. */=0D
@@ -117,7 +135,7 @@ enum sq_wqe_ec_type {=0D
 =0D
 /* Indicates the type of tasks with different lengths. */=0D
 enum sq_wqe_tasksect_len_type {=0D
-	SQ_WQE_TASKSECT_46BITS =3D 0,=0D
+	SQ_WQE_TASKSECT_4BYTES =3D 0,=0D
 	SQ_WQE_TASKSECT_16BYTES =3D 1,=0D
 };=0D
 =0D
@@ -177,6 +195,33 @@ enum sq_wqe_tasksect_len_type {=0D
 	((val) & (~(SQ_CTRL_QUEUE_INFO_##member##_MASK \=0D
 		    << SQ_CTRL_QUEUE_INFO_##member##_SHIFT)))=0D
 =0D
+/* Compact queue info */=0D
+#define SQ_CTRL_COMPACT_QUEUE_INFO_PKT_TYPE_SHIFT	14=0D
+#define SQ_CTRL_COMPACT_QUEUE_INFO_PLDOFF_SHIFT		16=0D
+#define SQ_CTRL_COMPACT_QUEUE_INFO_UFO_SHIFT		24=0D
+#define SQ_CTRL_COMPACT_QUEUE_INFO_TSO_SHIFT		25=0D
+#define SQ_CTRL_COMPACT_QUEUE_INFO_UDP_DP_EN_SHIFT	26=0D
+#define SQ_CTRL_COMPACT_QUEUE_INFO_SCTP_SHIFT		27=0D
+=0D
+#define SQ_CTRL_COMPACT_QUEUE_INFO_PKT_TYPE_MASK	0x3U=0D
+#define SQ_CTRL_COMPACT_QUEUE_INFO_PLDOFF_MASK		0xFFU=0D
+#define SQ_CTRL_COMPACT_QUEUE_INFO_UFO_MASK		0x1U=0D
+#define SQ_CTRL_COMPACT_QUEUE_INFO_TSO_MASK		0x1U=0D
+#define SQ_CTRL_COMPACT_QUEUE_INFO_UDP_DP_EN_MASK	0x1U=0D
+#define SQ_CTRL_COMPACT_QUEUE_INFO_SCTP_MASK		0x1U=0D
+=0D
+#define SQ_CTRL_COMPACT_QUEUE_INFO_SET(val, member) \=0D
+	(((uint32_t)(val) & SQ_CTRL_COMPACT_QUEUE_INFO_##member##_MASK) << \=0D
+	 SQ_CTRL_COMPACT_QUEUE_INFO_##member##_SHIFT)=0D
+=0D
+#define SQ_CTRL_COMPACT_QUEUE_INFO_GET(val, member) \=0D
+	(((val) >> SQ_CTRL_COMPACT_QUEUE_INFO_##member##_SHIFT) & \=0D
+	 SQ_CTRL_COMPACT_QUEUE_INFO_##member##_MASK)=0D
+=0D
+#define SQ_CTRL_COMPACT_QUEUE_INFO_CLEAR(val, member) \=0D
+	((val) & (~(SQ_CTRL_COMPACT_QUEUE_INFO_##member##_MASK << \=0D
+		    SQ_CTRL_COMPACT_QUEUE_INFO_##member##_SHIFT)))=0D
+=0D
 /* Setting and obtaining task information */=0D
 #define SQ_TASK_INFO0_TUNNEL_FLAG_SHIFT	    19=0D
 #define SQ_TASK_INFO0_ESP_NEXT_PROTO_SHIFT  22=0D
@@ -229,6 +274,37 @@ enum sq_wqe_tasksect_len_type {=0D
 	(((val) >> SQ_TASK_INFO3_##member##_SHIFT) & \=0D
 	 SQ_TASK_INFO3_##member##_MASK)=0D
 =0D
+/* compact wqe task field */=0D
+#define SQ_TASK_INFO_PKT_1588_SHIFT		31=0D
+#define SQ_TASK_INFO_IPSEC_PROTO_SHIFT		30=0D
+#define SQ_TASK_INFO_OUT_L3_EN_SHIFT		28=0D
+#define SQ_TASK_INFO_OUT_L4_EN_SHIFT		27=0D
+#define SQ_TASK_INFO_INNER_L3_EN_SHIFT		25=0D
+#define SQ_TASK_INFO_INNER_L4_EN_SHIFT		24=0D
+#define SQ_TASK_INFO_ESP_NEXT_PROTO_SHIFT	22=0D
+#define SQ_TASK_INFO_VLAN_VALID_SHIFT		19=0D
+#define SQ_TASK_INFO_VLAN_SEL_SHIFT		16=0D
+#define SQ_TASK_INFO_VLAN_TAG_SHIFT		0=0D
+=0D
+#define SQ_TASK_INFO_PKT_1588_MASK		0x1U=0D
+#define SQ_TASK_INFO_IPSEC_PROTO_MASK		0x1U=0D
+#define SQ_TASK_INFO_OUT_L3_EN_MASK		0x1U=0D
+#define SQ_TASK_INFO_OUT_L4_EN_MASK		0x1U=0D
+#define SQ_TASK_INFO_INNER_L3_EN_MASK		0x1U=0D
+#define SQ_TASK_INFO_INNER_L4_EN_MASK		0x1U=0D
+#define SQ_TASK_INFO_ESP_NEXT_PROTO_MASK	0x3U=0D
+#define SQ_TASK_INFO_VLAN_VALID_MASK		0x1U=0D
+#define SQ_TASK_INFO_VLAN_SEL_MASK		0x7U=0D
+#define SQ_TASK_INFO_VLAN_TAG_MASK		0xFFFFU=0D
+=0D
+#define SQ_TASK_INFO_SET(val, member) \=0D
+	(((uint32_t)(val) & SQ_TASK_INFO_##member##_MASK) << \=0D
+	SQ_TASK_INFO_##member##_SHIFT)=0D
+=0D
+#define SQ_TASK_INFO_GET(val, member) \=0D
+	(((val) >> SQ_TASK_INFO_##member##_SHIFT) & \=0D
+	SQ_TASK_INFO_##member##_MASK)=0D
+=0D
 /* Defines the TX queue status. */=0D
 enum hinic3_txq_status {=0D
 	HINIC3_TXQ_STATUS_START =3D 0,=0D
@@ -298,6 +374,8 @@ struct __rte_cache_aligned hinic3_txq {=0D
 	uint64_t sq_head_addr;=0D
 	uint64_t sq_bot_sge_addr;=0D
 	uint32_t cos;=0D
+	uint8_t tx_wqe_compact_task;=0D
+	uint8_t rsvd[3];=0D
 	struct hinic3_txq_stats txq_stats;=0D
 #ifdef HINIC3_XSTAT_PROF_TX=0D
 	uint64_t prof_tx_end_tsc;=0D
@@ -319,4 +397,26 @@ uint16_t hinic3_xmit_pkts(void *tx_queue, struct rte_m=
buf **tx_pkts, uint16_t nb=0D
 int hinic3_stop_sq(struct hinic3_txq *txq);=0D
 int hinic3_start_all_sqs(struct rte_eth_dev *eth_dev);=0D
 int hinic3_tx_done_cleanup(void *txq, uint32_t free_cnt);=0D
+=0D
+/**=0D
+ * Set wqe task section=0D
+ *=0D
+ * @param[in] wqe_info=0D
+ * Packet info parsed according to mbuf=0D
+ * @param[in] wqe_combo=0D
+ * Wqe need to format=0D
+ */=0D
+void hinic3_tx_set_normal_task_offload(struct hinic3_wqe_info *wqe_info,=0D
+				       struct hinic3_sq_wqe_combo *wqe_combo);=0D
+=0D
+/**=0D
+ * Set compact wqe task section=0D
+ *=0D
+ * @param[in] wqe_info=0D
+ * Packet info parsed according to mbuf=0D
+ * @param[in] wqe_combo=0D
+ * Wqe need to format=0D
+ */=0D
+void hinic3_tx_set_compact_task_offload(struct hinic3_wqe_info *wqe_info,=
=0D
+					struct hinic3_sq_wqe_combo *wqe_combo);=0D
 #endif /**< _HINIC3_TX_H_ */=0D
-- =0D
2.45.1.windows.1=0D
=0D

