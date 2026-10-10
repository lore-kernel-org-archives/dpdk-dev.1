Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A1DCA9EC1
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 14:46:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59A9340B90;
	Sat, 10 Oct 2026 16:45:31 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.223])
 by mails.dpdk.org (Postfix) with ESMTP id 51D5140671
 for <dev@dpdk.org>; Sat, 10 Oct 2026 16:45:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=pzUPhdX1KSsj7JpQ5DLbAyovOjb7iL7lYcsLGkegJRs=;
 b=TsC32Qbrzrm+7bEmxDpaaWiXHMVGSNvBop8ymJsoz5TbXrDltZXLq5VkjKl1zY
 5OB1H2x/VtGfKXktIebFNYFZIusza5pCt3a9EG8RbrSYweR9Bh3psWcWcYLLnY8s
 8A43ZkrTRrK2kpewxRddBa7Qnw4fynOKOuw45fyKwQ8BQ=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v1 16/17] net/hinic3: add per-tile prefetch/drop/CEQ cmdq ops
Date: Sat, 10 Oct 2026 22:45:07 +0800
Message-ID: <20261010144509.2731-17-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261010144509.2731-1-yejiacheng4@h-partners.com>
References: <20261010144509.2731-1-yejiacheng4@h-partners.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: As8vCgDX70B4T8pqMdk9Aw--.440S18
X-Coremail-Antispam: 1Uf129KBjvAXoWfWF1fCFWkZF4xur4DJw1xGrg_yoW5Gw4xWo
 WftF1avw1xJr1IkF9IgF1kK3yDAw1DXan8Ja93WF9FqFy7G34UG3Z8Aw1F93WagayrA3W3
 AFnxKr1DZ3yDu3y5n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUw_-PDUUUU
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiMx9ASmrKT38qxwAA3b
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

Move prefetch, packet-drop, and CEQ context setup into per-tile cmdq ops so=
=0D
each tile can apply its own policy and runtime coalescing parameters.=0D
=0D
Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>=0D
---=0D
 drivers/net/hinic3/hinic3_nic_io.c            | 135 ++-------------=0D
 drivers/net/hinic3/hinic3_nic_io.h            | 159 ++++++++++++------=0D
 .../net/hinic3/htn_adapt/hinic3_htn_cmdq.c    |  54 +++++-=0D
 .../net/hinic3/htn_adapt/hinic3_htn_cmdq.h    |   2 +-=0D
 .../net/hinic3/stn_adapt/hinic3_stn_cmdq.c    |  56 ++++++=0D
 5 files changed, 232 insertions(+), 174 deletions(-)=0D
=0D
diff --git a/drivers/net/hinic3/hinic3_nic_io.c b/drivers/net/hinic3/hinic3=
_nic_io.c=0D
index 5b905f203e..12afc3a068 100644=0D
--- a/drivers/net/hinic3/hinic3_nic_io.c=0D
+++ b/drivers/net/hinic3/hinic3_nic_io.c=0D
@@ -11,15 +11,6 @@=0D
 #include "hinic3_rx.h"=0D
 #include "hinic3_tx.h"=0D
 =0D
-#define HINIC3_DEAULT_TX_CI_PENDING_LIMIT	3=0D
-#define HINIC3_DEAULT_TX_CI_COALESCING_TIME	16=0D
-#define HINIC3_DEAULT_DROP_THD_ON		0xFFFF=0D
-#define HINIC3_DEAULT_DROP_THD_OFF		0=0D
-=0D
-#define WQ_PREFETCH_MAX				6=0D
-#define WQ_PREFETCH_MIN				1=0D
-#define WQ_PREFETCH_THRESHOLD			256=0D
-=0D
 #define CI_IDX_HIGH_SHIFH			12=0D
 =0D
 #define CI_HIGN_IDX(val) ((val) >> CI_IDX_HIGH_SHIFH)=0D
@@ -53,16 +44,6 @@=0D
 	(((val) & SQ_CTXT_WQ_PAGE_##member##_MASK)	\=0D
 	 << SQ_CTXT_WQ_PAGE_##member##_SHIFT)=0D
 =0D
-#define SQ_CTXT_PKT_DROP_THD_ON_SHIFT		0=0D
-#define SQ_CTXT_PKT_DROP_THD_OFF_SHIFT		16=0D
-=0D
-#define SQ_CTXT_PKT_DROP_THD_ON_MASK		0xFFFFU=0D
-#define SQ_CTXT_PKT_DROP_THD_OFF_MASK		0xFFFFU=0D
-=0D
-#define SQ_CTXT_PKT_DROP_THD_SET(val, member)		\=0D
-	(((val) & SQ_CTXT_PKT_DROP_##member##_MASK)	\=0D
-	 << SQ_CTXT_PKT_DROP_##member##_SHIFT)=0D
-=0D
 #define SQ_CTXT_GLOBAL_SQ_ID_SHIFT		0=0D
 =0D
 #define SQ_CTXT_GLOBAL_SQ_ID_MASK		0x1FFFU=0D
@@ -84,30 +65,6 @@=0D
 	(((val) & SQ_CTXT_VLAN_##member##_MASK)		\=0D
 	 << SQ_CTXT_VLAN_##member##_SHIFT)=0D
 =0D
-#define SQ_CTXT_PREF_CACHE_THRESHOLD_SHIFT	0=0D
-#define SQ_CTXT_PREF_CACHE_MAX_SHIFT		14=0D
-#define SQ_CTXT_PREF_CACHE_MIN_SHIFT		25=0D
-=0D
-#define SQ_CTXT_PREF_CACHE_THRESHOLD_MASK	0x3FFFU=0D
-#define SQ_CTXT_PREF_CACHE_MAX_MASK		0x7FFU=0D
-#define SQ_CTXT_PREF_CACHE_MIN_MASK		0x7FU=0D
-=0D
-#define SQ_CTXT_PREF_CI_HI_SHIFT		0=0D
-#define SQ_CTXT_PREF_OWNER_SHIFT		4=0D
-=0D
-#define SQ_CTXT_PREF_CI_HI_MASK			0xFU=0D
-#define SQ_CTXT_PREF_OWNER_MASK			0x1U=0D
-=0D
-#define SQ_CTXT_PREF_WQ_PFN_HI_SHIFT		0=0D
-#define SQ_CTXT_PREF_CI_LOW_SHIFT		20=0D
-=0D
-#define SQ_CTXT_PREF_WQ_PFN_HI_MASK		0xFFFFFU=0D
-#define SQ_CTXT_PREF_CI_LOW_MASK		0xFFFU=0D
-=0D
-#define SQ_CTXT_PREF_SET(val, member)			\=0D
-	(((val) & SQ_CTXT_PREF_##member##_MASK)		\=0D
-	 << SQ_CTXT_PREF_##member##_SHIFT)=0D
-=0D
 #define SQ_CTXT_WQ_BLOCK_PFN_HI_SHIFT		0=0D
 =0D
 #define SQ_CTXT_WQ_BLOCK_PFN_HI_MASK		0x7FFFFFU=0D
@@ -125,18 +82,6 @@=0D
 #define RQ_CTXT_CI_PI_SET(val, member)			\=0D
 	(((val) & RQ_CTXT_##member##_MASK) << RQ_CTXT_##member##_SHIFT)=0D
 =0D
-#define RQ_CTXT_CEQ_ATTR_INTR_SHIFT		21=0D
-#define RQ_CTXT_CEQ_ATTR_INTR_ARM_SHIFT		30=0D
-#define RQ_CTXT_CEQ_ATTR_EN_SHIFT		31=0D
-=0D
-#define RQ_CTXT_CEQ_ATTR_INTR_MASK		0x3FFU=0D
-#define RQ_CTXT_CEQ_ATTR_INTR_ARM_MASK		0x1U=0D
-#define RQ_CTXT_CEQ_ATTR_EN_MASK		0x1U=0D
-=0D
-#define RQ_CTXT_CEQ_ATTR_SET(val, member)		\=0D
-	(((val) & RQ_CTXT_CEQ_ATTR_##member##_MASK)	\=0D
-	 << RQ_CTXT_CEQ_ATTR_##member##_SHIFT)=0D
-=0D
 #define RQ_CTXT_WQ_PAGE_HI_PFN_SHIFT		0=0D
 #define RQ_CTXT_WQ_PAGE_WQE_TYPE_SHIFT		28=0D
 #define RQ_CTXT_WQ_PAGE_OWNER_SHIFT		31=0D
@@ -148,38 +93,6 @@=0D
 #define RQ_CTXT_WQ_PAGE_SET(val, member)		\=0D
 	(((val) & RQ_CTXT_WQ_PAGE_##member##_MASK)	\=0D
 	 << RQ_CTXT_WQ_PAGE_##member##_SHIFT)=0D
-=0D
-#define RQ_CTXT_CQE_LEN_SHIFT			28=0D
-=0D
-#define RQ_CTXT_CQE_LEN_MASK			0x3U=0D
-=0D
-#define RQ_CTXT_CQE_LEN_SET(val, member)		\=0D
-	(((val) & RQ_CTXT_##member##_MASK) << RQ_CTXT_##member##_SHIFT)=0D
-=0D
-#define RQ_CTXT_PREF_CACHE_THRESHOLD_SHIFT	0=0D
-#define RQ_CTXT_PREF_CACHE_MAX_SHIFT		14=0D
-#define RQ_CTXT_PREF_CACHE_MIN_SHIFT		25=0D
-=0D
-#define RQ_CTXT_PREF_CACHE_THRESHOLD_MASK	0x3FFFU=0D
-#define RQ_CTXT_PREF_CACHE_MAX_MASK		0x7FFU=0D
-#define RQ_CTXT_PREF_CACHE_MIN_MASK		0x7FU=0D
-=0D
-#define RQ_CTXT_PREF_CI_HI_SHIFT		0=0D
-#define RQ_CTXT_PREF_OWNER_SHIFT		4=0D
-=0D
-#define RQ_CTXT_PREF_CI_HI_MASK			0xFU=0D
-#define RQ_CTXT_PREF_OWNER_MASK			0x1U=0D
-=0D
-#define RQ_CTXT_PREF_WQ_PFN_HI_SHIFT		0=0D
-#define RQ_CTXT_PREF_CI_LOW_SHIFT		20=0D
-=0D
-#define RQ_CTXT_PREF_WQ_PFN_HI_MASK		0xFFFFFU=0D
-#define RQ_CTXT_PREF_CI_LOW_MASK		0xFFFU=0D
-=0D
-#define RQ_CTXT_PREF_SET(val, member)			\=0D
-	(((val) & RQ_CTXT_PREF_##member##_MASK)		\=0D
-	 << RQ_CTXT_PREF_##member##_SHIFT)=0D
-=0D
 #define RQ_CTXT_WQ_BLOCK_PFN_HI_SHIFT		0=0D
 =0D
 #define RQ_CTXT_WQ_BLOCK_PFN_HI_MASK		0x7FFFFFU=0D
@@ -191,12 +104,7 @@=0D
 #define SIZE_16BYTES(size) (RTE_ALIGN((size), 16) >> 4)=0D
 =0D
 #define WQ_PAGE_PFN_SHIFT			12=0D
-#define WQ_BLOCK_PFN_SHIFT			9=0D
-=0D
 #define WQ_PAGE_PFN(page_addr)	((page_addr) >> WQ_PAGE_PFN_SHIFT)=0D
-#define WQ_BLOCK_PFN(page_addr) ((page_addr) >> WQ_BLOCK_PFN_SHIFT)=0D
-=0D
-#define CQE_CTX_CI_ADDR_SHIFT			4=0D
 =0D
 void=0D
 hinic3_sq_prepare_ctxt(struct hinic3_txq *sq, uint16_t sq_id,=0D
@@ -206,6 +114,8 @@ hinic3_sq_prepare_ctxt(struct hinic3_txq *sq, uint16_t =
sq_id,=0D
 	uint32_t wq_page_pfn_hi, wq_page_pfn_lo, wq_block_pfn_hi, wq_block_pfn_lo=
;=0D
 	uint16_t pi_start, ci_start;=0D
 =0D
+	hinic3_cmdq_get_ops(sq->nic_dev)->prepare_sq_ctxt_drop_and_prefetch(sq_ct=
xt);=0D
+=0D
 	ci_start =3D sq->cons_idx & sq->q_mask;=0D
 	pi_start =3D sq->prod_idx & sq->q_mask;=0D
 =0D
@@ -232,10 +142,6 @@ hinic3_sq_prepare_ctxt(struct hinic3_txq *sq, uint16_t=
 sq_id,=0D
 =0D
 	sq_ctxt->wq_pfn_lo =3D wq_page_pfn_lo;=0D
 =0D
-	sq_ctxt->pkt_drop_thd =3D=0D
-		SQ_CTXT_PKT_DROP_THD_SET(HINIC3_DEAULT_DROP_THD_ON, THD_ON) |=0D
-		SQ_CTXT_PKT_DROP_THD_SET(HINIC3_DEAULT_DROP_THD_OFF, THD_OFF);=0D
-=0D
 	sq_ctxt->global_sq_id =3D=0D
 		SQ_CTXT_GLOBAL_QUEUE_ID_SET(sq_id, GLOBAL_SQ_ID);=0D
 =0D
@@ -245,11 +151,6 @@ hinic3_sq_prepare_ctxt(struct hinic3_txq *sq, uint16_t=
 sq_id,=0D
 =0D
 	sq_ctxt->rsvd0 =3D 0;=0D
 =0D
-	sq_ctxt->pref_cache =3D=0D
-		SQ_CTXT_PREF_SET(WQ_PREFETCH_MIN, CACHE_MIN) |=0D
-		SQ_CTXT_PREF_SET(WQ_PREFETCH_MAX, CACHE_MAX) |=0D
-		SQ_CTXT_PREF_SET(WQ_PREFETCH_THRESHOLD, CACHE_THRESHOLD);=0D
-=0D
 	sq_ctxt->pref_ci_owner =3D=0D
 		SQ_CTXT_PREF_SET(CI_HIGN_IDX(ci_start), CI_HI) |=0D
 		SQ_CTXT_PREF_SET(1, OWNER);=0D
@@ -277,7 +178,6 @@ hinic3_rq_prepare_ctxt(struct hinic3_rxq *rq, struct hi=
nic3_rq_ctxt *rq_ctxt)=0D
 	uint32_t wq_page_pfn_hi, wq_page_pfn_lo, wq_block_pfn_hi, wq_block_pfn_lo=
;=0D
 	uint16_t pi_start, ci_start;=0D
 	uint16_t wqe_type =3D rq->wqe_type;=0D
-	uint8_t intr_disable;=0D
 =0D
 	/* RQ depth is in unit of 8 Bytes. */=0D
 	ci_start =3D (uint16_t)((rq->cons_idx & rq->q_mask) << wqe_type);=0D
@@ -298,17 +198,14 @@ hinic3_rq_prepare_ctxt(struct hinic3_rxq *rq, struct =
hinic3_rq_ctxt *rq_ctxt)=0D
 	rq_ctxt->ci_pi =3D RQ_CTXT_CI_PI_SET(ci_start, CI_IDX) |=0D
 			 RQ_CTXT_CI_PI_SET(pi_start, PI_IDX);=0D
 =0D
-	/* RQ doesn't need ceq, msix_entry_idx set 1, but mask not enable. */=0D
-	intr_disable =3D rq->dp_intr_en ? 0 : 1;=0D
-	rq_ctxt->ceq_attr =3D RQ_CTXT_CEQ_ATTR_SET(intr_disable, EN) |=0D
-			    RQ_CTXT_CEQ_ATTR_SET(0, INTR_ARM) |=0D
-			    RQ_CTXT_CEQ_ATTR_SET(rq->msix_entry_idx, INTR);=0D
-=0D
 	/* Use 32Byte WQE with SGE for CQE in default. */=0D
 	rq_ctxt->wq_pfn_hi_type_owner =3D=0D
 		RQ_CTXT_WQ_PAGE_SET(wq_page_pfn_hi, HI_PFN) |=0D
 		RQ_CTXT_WQ_PAGE_SET(1, OWNER);=0D
 =0D
+	/* RQ doesn't need ceq, msix_entry_idx set 1, but mask not enable */=0D
+	hinic3_cmdq_get_ops(rq->nic_dev)->prepare_rq_ctxt_ceq_and_prefetch(rq, rq=
_ctxt);=0D
+=0D
 	switch (wqe_type) {=0D
 	case HINIC3_EXTEND_RQ_WQE:=0D
 		/* Use 32Byte WQE with SGE for CQE. */=0D
@@ -331,11 +228,6 @@ hinic3_rq_prepare_ctxt(struct hinic3_rxq *rq, struct h=
inic3_rq_ctxt *rq_ctxt)=0D
 =0D
 	rq_ctxt->wq_pfn_lo =3D wq_page_pfn_lo;=0D
 =0D
-	rq_ctxt->pref_cache =3D=0D
-		RQ_CTXT_PREF_SET(WQ_PREFETCH_MIN, CACHE_MIN) |=0D
-		RQ_CTXT_PREF_SET(WQ_PREFETCH_MAX, CACHE_MAX) |=0D
-		RQ_CTXT_PREF_SET(WQ_PREFETCH_THRESHOLD, CACHE_THRESHOLD);=0D
-=0D
 	rq_ctxt->pref_ci_owner =3D=0D
 		RQ_CTXT_PREF_SET(CI_HIGN_IDX(ci_start), CI_HI) |=0D
 		RQ_CTXT_PREF_SET(1, OWNER);=0D
@@ -392,7 +284,7 @@ init_sq_ctxts(struct hinic3_nic_dev *nic_dev)=0D
 				    ? HINIC3_Q_CTXT_MAX=0D
 				    : (nic_dev->num_sqs - q_id);=0D
 		cmd =3D hinic3_cmdq_get_ops(nic_dev)->prepare_cmd_buf_qp_context_multi_s=
tore(nic_dev,=0D
-			cmd_buf, HINIC3_QP_CTXT_TYPE_SQ, q_id, max_ctxts);=0D
+				cmd_buf, HINIC3_QP_CTXT_TYPE_SQ, q_id, max_ctxts);=0D
 		rte_atomic_thread_fence(rte_memory_order_seq_cst);=0D
 		err =3D hinic3_cmdq_direct_resp(nic_dev->hwdev, HINIC3_MOD_L2NIC,=0D
 					      cmd, cmd_buf, &out_param, 0);=0D
@@ -444,7 +336,8 @@ init_rq_ctxts(struct hinic3_nic_dev *nic_dev)=0D
 				    ? HINIC3_Q_CTXT_MAX=0D
 				    : (nic_dev->num_rqs - q_id);=0D
 		cmd =3D hinic3_cmdq_get_ops(nic_dev)->prepare_cmd_buf_qp_context_multi_s=
tore(nic_dev,=0D
-			cmd_buf, HINIC3_QP_CTXT_TYPE_RQ, q_id, max_ctxts);=0D
+				cmd_buf, HINIC3_QP_CTXT_TYPE_RQ, q_id, max_ctxts);=0D
+=0D
 		rte_atomic_thread_fence(rte_memory_order_seq_cst);=0D
 		err =3D hinic3_cmdq_direct_resp(nic_dev->hwdev, HINIC3_MOD_L2NIC,=0D
 					      cmd, cmd_buf, &out_param, 0);=0D
@@ -490,10 +383,8 @@ clean_queue_offload_ctxt(struct hinic3_nic_dev *nic_de=
v,=0D
 		PMD_DRV_LOG(ERR, "Allocate cmd buf for LRO/TSO space failed");=0D
 		return -ENOMEM;=0D
 	}=0D
-=0D
-	cmd =3D hinic3_cmdq_get_ops(nic_dev)->prepare_cmd_buf_clean_tso_lro_space=
(nic_dev,=0D
-		cmd_buf, ctxt_type);=0D
-=0D
+	cmd =3D hinic3_cmdq_get_ops(nic_dev)->prepare_cmd_buf_clean_tso_lro_space=
(nic_dev, cmd_buf,=0D
+										ctxt_type);=0D
 	/* Send a command to hardware to clean up queue offload context. */=0D
 	err =3D hinic3_cmdq_direct_resp(nic_dev->hwdev, HINIC3_MOD_L2NIC,=0D
 				      cmd, cmd_buf, &out_param, 0);=0D
@@ -563,7 +454,7 @@ hinic3_init_rq_cqe_ctxts(struct hinic3_nic_dev *nic_dev=
)=0D
 	while (q_id < nic_dev->num_rqs) {=0D
 		rxq =3D nic_dev->rxqs[q_id];=0D
 		if (rxq->wqe_type =3D=3D HINIC3_COMPACT_RQ_WQE) {=0D
-			rq_ci_paddr =3D rxq->rq_ci_paddr >> CQE_CTX_CI_ADDR_SHIFT;=0D
+			rq_ci_paddr =3D rxq->rq_ci_paddr >> RQ_CI_ADDR_SHIFT;=0D
 			cqe_ctx.ci_addr_hi =3D upper_32_bits(rq_ci_paddr);=0D
 			cqe_ctx.ci_addr_lo =3D lower_32_bits(rq_ci_paddr);=0D
 			cqe_ctx.threshold_cqe_num =3D nic_dev->config.rx_cqe_coalesce_num;=0D
@@ -641,8 +532,8 @@ hinic3_init_qp_ctxts(struct hinic3_nic_dev *nic_dev)=0D
 	/* Configure CI tables for each SQ. */=0D
 	for (q_id =3D 0; q_id < nic_dev->num_sqs; q_id++) {=0D
 		sq_attr.ci_dma_base =3D nic_dev->txqs[q_id]->ci_dma_base >> 0x2;=0D
-		sq_attr.pending_limit =3D HINIC3_DEAULT_TX_CI_PENDING_LIMIT;=0D
-		sq_attr.coalescing_time =3D HINIC3_DEAULT_TX_CI_COALESCING_TIME;=0D
+		sq_attr.pending_limit =3D nic_dev->config.tx_pending_limit;=0D
+		sq_attr.coalescing_time =3D nic_dev->config.tx_coalescing_time;=0D
 		sq_attr.intr_en =3D 0;=0D
 		sq_attr.intr_idx =3D 0; /**< Tx doesn't need interrupt. */=0D
 		sq_attr.l2nic_sqn =3D q_id;=0D
diff --git a/drivers/net/hinic3/hinic3_nic_io.h b/drivers/net/hinic3/hinic3=
_nic_io.h=0D
index c8b33e985d..acad0ab3df 100644=0D
--- a/drivers/net/hinic3/hinic3_nic_io.h=0D
+++ b/drivers/net/hinic3/hinic3_nic_io.h=0D
@@ -28,6 +28,82 @@=0D
 =0D
 #define HINIC3_Q_CTXT_MAX ((uint16_t)(((HINIC3_CMDQ_BUF_SIZE - 8) - RTE_PK=
TMBUF_HEADROOM) / 64))=0D
 =0D
+=0D
+#define RQ_CTXT_PREF_CACHE_THRESHOLD_SHIFT		0=0D
+#define RQ_CTXT_PREF_CACHE_MAX_SHIFT			14=0D
+#define RQ_CTXT_PREF_CACHE_MIN_SHIFT			25=0D
+=0D
+#define RQ_CTXT_PREF_CACHE_THRESHOLD_MASK		0x3FFFU=0D
+#define RQ_CTXT_PREF_CACHE_MAX_MASK			0x7FFU=0D
+#define RQ_CTXT_PREF_CACHE_MIN_MASK			0x7FU=0D
+=0D
+#define RQ_CTXT_PREF_CI_HI_SHIFT			0=0D
+#define RQ_CTXT_PREF_OWNER_SHIFT			4=0D
+=0D
+#define RQ_CTXT_PREF_CI_HI_MASK				0xFU=0D
+#define RQ_CTXT_PREF_OWNER_MASK				0x1U=0D
+=0D
+#define RQ_CTXT_PREF_WQ_PFN_HI_SHIFT			0=0D
+#define RQ_CTXT_PREF_CI_LOW_SHIFT			20=0D
+=0D
+#define RQ_CTXT_PREF_WQ_PFN_HI_MASK			0xFFFFFU=0D
+#define RQ_CTXT_PREF_CI_LOW_MASK			0xFFFU=0D
+=0D
+#define RQ_CTXT_PREF_SET(val, member)			(((val) & \=0D
+					RQ_CTXT_PREF_##member##_MASK) << \=0D
+					RQ_CTXT_PREF_##member##_SHIFT)=0D
+=0D
+#define RQ_CTXT_CEQ_ATTR_SET(val, member)		(((val) & \=0D
+					RQ_CTXT_CEQ_ATTR_##member##_MASK) \=0D
+					<< RQ_CTXT_CEQ_ATTR_##member##_SHIFT)=0D
+=0D
+#define RQ_CTXT_CQE_LEN_SHIFT				28=0D
+#define RQ_CTXT_MAX_COUNT_SHIFT				18=0D
+=0D
+#define RQ_CTXT_CQE_LEN_MASK				0x3U=0D
+#define RQ_CTXT_MAX_COUNT_MASK				0x3FFU=0D
+#define RQ_CTXT_CQE_LEN_SET(val, member)		(((val) & \=0D
+					RQ_CTXT_##member##_MASK) << \=0D
+					RQ_CTXT_##member##_SHIFT)=0D
+=0D
+#define SQ_CI_ADDR_SHIFT	2=0D
+#define RQ_CI_ADDR_SHIFT	4=0D
+#define RQ_CQE_AGGREGATE_NUM		768=0D
+=0D
+#define SQ_CTXT_PREF_CACHE_THRESHOLD_SHIFT		0=0D
+#define SQ_CTXT_PREF_CACHE_MAX_SHIFT			14=0D
+#define SQ_CTXT_PREF_CACHE_MIN_SHIFT			25=0D
+=0D
+#define SQ_CTXT_PREF_CACHE_THRESHOLD_MASK		0x3FFFU=0D
+#define SQ_CTXT_PREF_CACHE_MAX_MASK			0x7FFU=0D
+#define SQ_CTXT_PREF_CACHE_MIN_MASK			0x7FU=0D
+=0D
+#define SQ_CTXT_PREF_CI_HI_SHIFT			0=0D
+#define SQ_CTXT_PREF_OWNER_SHIFT			4=0D
+=0D
+#define SQ_CTXT_PREF_CI_HI_MASK				0xFU=0D
+#define SQ_CTXT_PREF_OWNER_MASK				0x1U=0D
+=0D
+#define SQ_CTXT_PREF_WQ_PFN_HI_SHIFT			0=0D
+#define SQ_CTXT_PREF_CI_LOW_SHIFT			20=0D
+=0D
+#define SQ_CTXT_PREF_WQ_PFN_HI_MASK			0xFFFFFU=0D
+#define SQ_CTXT_PREF_CI_LOW_MASK			0xFFFU=0D
+=0D
+#define SQ_CTXT_PREF_SET(val, member)			(((val) & \=0D
+					SQ_CTXT_PREF_##member##_MASK) \=0D
+					<< SQ_CTXT_PREF_##member##_SHIFT)=0D
+=0D
+#define SQ_CTXT_PKT_DROP_THD_ON_SHIFT		0=0D
+#define SQ_CTXT_PKT_DROP_THD_OFF_SHIFT		16=0D
+=0D
+#define SQ_CTXT_PKT_DROP_THD_ON_MASK		0xFFFFU=0D
+#define SQ_CTXT_PKT_DROP_THD_OFF_MASK		0xFFFFU=0D
+=0D
+#define SQ_CTXT_PKT_DROP_THD_SET(val, member)	(((val) & \=0D
+			SQ_CTXT_PKT_DROP_##member##_MASK) \=0D
+			<< SQ_CTXT_PKT_DROP_##member##_SHIFT)=0D
+=0D
 enum hinic3_rq_wqe_type {=0D
 	HINIC3_COMPACT_RQ_WQE,=0D
 	HINIC3_NORMAL_RQ_WQE,=0D
@@ -45,54 +121,6 @@ enum hinic3_qp_ctxt_type {=0D
 	HINIC3_QP_CTXT_TYPE_RQ,=0D
 };=0D
 =0D
-/* Prepare cmd to clean tso/lro space */=0D
-typedef uint8_t  (*prepare_cmd_buf_clean_tso_lro_space_t)(struct hinic3_ni=
c_dev *nic_dev,=0D
-							  struct hinic3_cmd_buf *cmd_buf,=0D
-							  enum hinic3_qp_ctxt_type ctxt_type);=0D
-/* Prepare cmd to store RQ and TQ ctxt */=0D
-typedef uint8_t  (*prepare_cmd_buf_qp_context_multi_store_t)(struct hinic3=
_nic_dev *nic_dev,=0D
-							     struct hinic3_cmd_buf *cmd_buf,=0D
-							     enum hinic3_qp_ctxt_type ctxt_type,=0D
-							     uint16_t start_qid,=0D
-							     uint16_t max_ctxts);=0D
-/* Prepare cmd to modify vlan tag */=0D
-typedef uint8_t  (*prepare_cmd_buf_modify_svlan_t)(struct hinic3_cmd_buf *=
cmd_buf, uint16_t func_id,=0D
-						   uint16_t vlan_tag, uint16_t q_id,=0D
-						   uint8_t vlan_mode);=0D
-/* Prepare cmd to set RSS indir table */=0D
-typedef uint8_t  (*prepare_cmd_buf_set_rss_indir_table_t)(struct hinic3_ni=
c_dev *nic_dev,=0D
-							  const uint32_t *indir_table,=0D
-							  struct hinic3_cmd_buf *cmd_buf);=0D
-/* Prepare cmd to get RSS indir table */=0D
-typedef uint8_t  (*prepare_cmd_buf_get_rss_indir_table_t)(struct hinic3_ni=
c_dev *nic_dev,=0D
-							  struct hinic3_cmd_buf *cmd_buf);=0D
-/* Configure RSS indir table */=0D
-typedef void     (*cmd_buf_to_rss_indir_table_t)(const struct hinic3_cmd_b=
uf *cmd_buf,=0D
-						 uint32_t *indir_table);=0D
-=0D
-struct hinic3_nic_cmdq_ops {=0D
-	prepare_cmd_buf_clean_tso_lro_space_t		prepare_cmd_buf_clean_tso_lro_spac=
e;=0D
-	prepare_cmd_buf_qp_context_multi_store_t	prepare_cmd_buf_qp_context_multi=
_store;=0D
-	prepare_cmd_buf_modify_svlan_t			prepare_cmd_buf_modify_svlan;=0D
-	prepare_cmd_buf_set_rss_indir_table_t		prepare_cmd_buf_set_rss_indir_tabl=
e;=0D
-	prepare_cmd_buf_get_rss_indir_table_t		prepare_cmd_buf_get_rss_indir_tabl=
e;=0D
-	cmd_buf_to_rss_indir_table_t			cmd_buf_to_rss_indir_table;=0D
-};=0D
-=0D
-/* Forward declaration */=0D
-struct hinic3_nic_dev;=0D
-=0D
-/**=0D
- * Get cmdq ops for the given NIC device.=0D
- *=0D
- * @param[in] nic_dev=0D
- * Pointer to NIC device structure.=0D
- *=0D
- * @return=0D
- * Pointer to cmdq ops structure.=0D
- */=0D
-const struct hinic3_nic_cmdq_ops *hinic3_cmdq_get_ops(struct hinic3_nic_de=
v *nic_dev);=0D
-=0D
 /* Doorbell info. */=0D
 struct hinic3_db {=0D
 	uint32_t db_info;=0D
@@ -167,6 +195,41 @@ struct hinic3_rq_enable {=0D
 	uint8_t rsvd[3];=0D
 };=0D
 =0D
+typedef uint8_t (*prepare_cmd_buf_clean_tso_lro_space_t)(struct hinic3_nic=
_dev *nic_dev,=0D
+							 struct hinic3_cmd_buf *cmd_buf,=0D
+							 enum hinic3_qp_ctxt_type ctxt_type);=0D
+typedef uint8_t (*prepare_cmd_buf_qp_context_multi_store_t)(struct hinic3_=
nic_dev *nic_dev,=0D
+							   struct hinic3_cmd_buf *cmd_buf,=0D
+							   enum hinic3_qp_ctxt_type ctxt_type,=0D
+							   uint16_t start_qid,=0D
+							   uint16_t max_ctxts);=0D
+typedef uint8_t  (*prepare_cmd_buf_modify_svlan_t)(struct hinic3_cmd_buf *=
cmd_buf, uint16_t func_id,=0D
+						   uint16_t vlan_tag, uint16_t q_id,=0D
+						   uint8_t vlan_mode);=0D
+typedef uint8_t (*prepare_cmd_buf_set_rss_indir_table_t)(struct hinic3_nic=
_dev *nic_dev,=0D
+							 const uint32_t *indir_table,=0D
+							 struct hinic3_cmd_buf *cmd_buf);=0D
+typedef uint8_t (*prepare_cmd_buf_get_rss_indir_table_t)(struct hinic3_nic=
_dev *nic_dev,=0D
+							 struct hinic3_cmd_buf *cmd_buf);=0D
+typedef void (*cmd_buf_to_rss_indir_table_t)(const struct hinic3_cmd_buf *=
cmd_buf,=0D
+					     uint32_t *indir_table);=0D
+typedef void (*prepare_sq_ctxt_drop_and_prefetch_t)(struct hinic3_sq_ctxt =
*sq_ctxt);=0D
+typedef void (*prepare_rq_ctxt_ceq_and_prefetch_t)(struct hinic3_rxq *rq,=
=0D
+						   struct hinic3_rq_ctxt *rq_ctxt);=0D
+=0D
+struct hinic3_nic_cmdq_ops {=0D
+	prepare_cmd_buf_clean_tso_lro_space_t		prepare_cmd_buf_clean_tso_lro_spac=
e;=0D
+	prepare_cmd_buf_qp_context_multi_store_t	prepare_cmd_buf_qp_context_multi=
_store;=0D
+	prepare_cmd_buf_modify_svlan_t			prepare_cmd_buf_modify_svlan;=0D
+	prepare_cmd_buf_set_rss_indir_table_t		prepare_cmd_buf_set_rss_indir_tabl=
e;=0D
+	prepare_cmd_buf_get_rss_indir_table_t		prepare_cmd_buf_get_rss_indir_tabl=
e;=0D
+	cmd_buf_to_rss_indir_table_t			cmd_buf_to_rss_indir_table;=0D
+	prepare_sq_ctxt_drop_and_prefetch_t		prepare_sq_ctxt_drop_and_prefetch;=0D
+	prepare_rq_ctxt_ceq_and_prefetch_t		prepare_rq_ctxt_ceq_and_prefetch;=0D
+};=0D
+=0D
+const struct hinic3_nic_cmdq_ops *hinic3_cmdq_get_ops(struct hinic3_nic_de=
v *nic_dev);=0D
+=0D
 #define DB_INFO_QID_SHIFT	 0=0D
 #define DB_INFO_NON_FILTER_SHIFT 22=0D
 #define DB_INFO_CFLAG_SHIFT	 23=0D
diff --git a/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.c b/drivers/net/h=
inic3/htn_adapt/hinic3_htn_cmdq.c=0D
index 607fe2d0fe..1eb5ea19b4 100644=0D
--- a/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.c=0D
+++ b/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.c=0D
@@ -7,6 +7,28 @@=0D
 #include "hinic3_cmd.h"=0D
 #include "hinic3_hwif.h"=0D
 #include "hinic3_htn_cmdq.h"=0D
+#include "hinic3_rx.h"=0D
+=0D
+#define HINIC3_DEAULT_DROP_THD_OFF	0xFFFF=0D
+#define HINIC3_DEAULT_DROP_THD_ON	0xFFFF=0D
+=0D
+#define SQ_PREFETCH_MAX			5=0D
+#define SQ_PREFETCH_MIN			4=0D
+#define SQ_PREFETCH_THRESHOLD		48=0D
+=0D
+#define RQ_PREFETCH_MAX			4=0D
+#define RQ_PREFETCH_MIN			2=0D
+#define RQ_PREFETCH_THRESHOLD		32=0D
+=0D
+#define RQ_PFH_TH			7=0D
+=0D
+#define RQ_CTXT_CEQ_ATTR_PFH_TH_SHIFT			0=0D
+#define RQ_CTXT_CEQ_ATTR_INTR_SHIFT			21=0D
+#define RQ_CTXT_CEQ_ATTR_EN_SHIFT			31=0D
+=0D
+#define RQ_CTXT_CEQ_ATTR_PFH_TH_MASK			0x1FU=0D
+#define RQ_CTXT_CEQ_ATTR_EN_MASK			0x1U=0D
+#define RQ_CTXT_CEQ_ATTR_INTR_MASK			0x3FFU=0D
 =0D
 #define HTN_SQ_CTXT_SIZE(num_sqs)	((uint16_t)(sizeof(struct hinic3_htn_qp_=
ctxt_header) \=0D
 						    + (num_sqs) * sizeof(struct hinic3_sq_ctxt)))=0D
@@ -100,7 +122,7 @@ static uint8_t prepare_cmd_buf_modify_svlan(struct hini=
c3_cmd_buf *cmd_buf,=0D
 static void prepare_rss_indir_table_cmd_header(struct hinic3_nic_dev *nic_=
dev,=0D
 					       struct hinic3_cmd_buf *cmd_buf)=0D
 {=0D
-	struct hinic3_rss_cmd_header *header =3D cmd_buf->buf;=0D
+	struct hinic3_htn_rss_cmd_header *header =3D cmd_buf->buf;=0D
 =0D
 	header->dest_func_id =3D hinic3_global_func_id(nic_dev->hwdev);=0D
 =0D
@@ -115,8 +137,8 @@ static uint8_t prepare_cmd_buf_set_rss_indir_table(stru=
ct hinic3_nic_dev *nic_de=0D
 	uint32_t i;=0D
 	uint8_t *indir_tbl =3D NULL;=0D
 =0D
-	indir_tbl =3D (uint8_t *)cmd_buf->buf + sizeof(struct hinic3_rss_cmd_head=
er);=0D
-	cmd_buf->size =3D sizeof(struct hinic3_rss_cmd_header) + HINIC3_RSS_INDIR=
_SIZE;=0D
+	indir_tbl =3D (uint8_t *)cmd_buf->buf + sizeof(struct hinic3_htn_rss_cmd_=
header);=0D
+	cmd_buf->size =3D sizeof(struct hinic3_htn_rss_cmd_header) + HINIC3_RSS_I=
NDIR_SIZE;=0D
 	memset(indir_tbl, 0, HINIC3_RSS_INDIR_SIZE);=0D
 =0D
 	prepare_rss_indir_table_cmd_header(nic_dev, cmd_buf);=0D
@@ -152,6 +174,30 @@ static void cmd_buf_to_rss_indir_table(const struct hi=
nic3_cmd_buf *cmd_buf, uin=0D
 		indir_table[i] =3D *(indir_tbl + i);=0D
 }=0D
 =0D
+static void=0D
+prepare_sq_ctxt_drop_and_prefetch(struct hinic3_sq_ctxt *sq_ctxt)=0D
+{=0D
+	sq_ctxt->pkt_drop_thd =3D SQ_CTXT_PKT_DROP_THD_SET(HINIC3_DEAULT_DROP_THD=
_ON, THD_ON) |=0D
+				SQ_CTXT_PKT_DROP_THD_SET(HINIC3_DEAULT_DROP_THD_OFF, THD_OFF);=0D
+=0D
+	sq_ctxt->pref_cache =3D SQ_CTXT_PREF_SET(SQ_PREFETCH_MIN, CACHE_MIN) |=0D
+			      SQ_CTXT_PREF_SET(SQ_PREFETCH_MAX, CACHE_MAX) |=0D
+			      SQ_CTXT_PREF_SET(SQ_PREFETCH_THRESHOLD, CACHE_THRESHOLD);=0D
+}=0D
+=0D
+static void=0D
+prepare_rq_ctxt_ceq_and_prefetch(struct hinic3_rxq *rq,=0D
+				 struct hinic3_rq_ctxt *rq_ctxt)=0D
+{=0D
+	rq_ctxt->ceq_attr =3D RQ_CTXT_CEQ_ATTR_SET(rq->dp_intr_en ? 0 : 1, EN) |=
=0D
+			    RQ_CTXT_CEQ_ATTR_SET(RQ_PFH_TH, PFH_TH) |=0D
+			    RQ_CTXT_CEQ_ATTR_SET(rq->msix_entry_idx, INTR);=0D
+=0D
+	rq_ctxt->pref_cache =3D RQ_CTXT_PREF_SET(RQ_PREFETCH_MIN, CACHE_MIN) |=0D
+			      RQ_CTXT_PREF_SET(RQ_PREFETCH_MAX, CACHE_MAX) |=0D
+			      RQ_CTXT_PREF_SET(RQ_PREFETCH_THRESHOLD, CACHE_THRESHOLD);=0D
+}=0D
+=0D
 const struct hinic3_nic_cmdq_ops hinic3_htn_cmdq_ops =3D {=0D
 	.prepare_cmd_buf_clean_tso_lro_space =3D    prepare_cmd_buf_clean_tso_lro=
_space,=0D
 	.prepare_cmd_buf_qp_context_multi_store =3D prepare_cmd_buf_qp_context_mu=
lti_store,=0D
@@ -159,4 +205,6 @@ const struct hinic3_nic_cmdq_ops hinic3_htn_cmdq_ops =
=3D {=0D
 	.prepare_cmd_buf_set_rss_indir_table =3D    prepare_cmd_buf_set_rss_indir=
_table,=0D
 	.prepare_cmd_buf_get_rss_indir_table =3D    prepare_cmd_buf_get_rss_indir=
_table,=0D
 	.cmd_buf_to_rss_indir_table =3D             cmd_buf_to_rss_indir_table,=0D
+	.prepare_sq_ctxt_drop_and_prefetch =3D      prepare_sq_ctxt_drop_and_pref=
etch,=0D
+	.prepare_rq_ctxt_ceq_and_prefetch =3D       prepare_rq_ctxt_ceq_and_prefe=
tch,=0D
 };=0D
diff --git a/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.h b/drivers/net/h=
inic3/htn_adapt/hinic3_htn_cmdq.h=0D
index 158cbc5f8e..f87ea535ad 100644=0D
--- a/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.h=0D
+++ b/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.h=0D
@@ -27,7 +27,7 @@ struct hinic3_htn_qp_ctxt_block {=0D
 	};=0D
 };=0D
 =0D
-struct hinic3_rss_cmd_header {=0D
+struct hinic3_htn_rss_cmd_header {=0D
 	uint32_t rsv[3];=0D
 	uint16_t rsv1;=0D
 	uint16_t dest_func_id;=0D
diff --git a/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.c b/drivers/net/h=
inic3/stn_adapt/hinic3_stn_cmdq.c=0D
index 23adbc79f4..c05e4bc11c 100644=0D
--- a/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.c=0D
+++ b/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.c=0D
@@ -7,6 +7,25 @@=0D
 #include "hinic3_cmd.h"=0D
 #include "hinic3_hwif.h"=0D
 #include "hinic3_stn_cmdq.h"=0D
+#include "hinic3_rx.h"=0D
+=0D
+#define HINIC3_DEAULT_DROP_THD_ON			0xFFFF=0D
+#define HINIC3_DEAULT_DROP_THD_OFF			0=0D
+#define WQ_PREFETCH_MAX					6=0D
+#define WQ_PREFETCH_MIN					1=0D
+#define WQ_PREFETCH_THRESHOLD				256=0D
+=0D
+#define RQ_CTXT_CEQ_ATTR_CI_WR_SHIFT			0=0D
+#define RQ_CTXT_CEQ_ATTR_INTR_SHIFT			21=0D
+#define RQ_CTXT_CEQ_ATTR_INTR_ARM_SHIFT			30=0D
+#define RQ_CTXT_CEQ_ATTR_EN_SHIFT			31=0D
+=0D
+#define RQ_CTXT_CEQ_ATTR_CI_WR_MASK			0x1U=0D
+#define RQ_CTXT_CEQ_ATTR_INTR_MASK			0x3FFU=0D
+#define RQ_CTXT_CEQ_ATTR_INTR_ARM_MASK			0x1U=0D
+#define RQ_CTXT_CEQ_ATTR_EN_MASK			0x1U=0D
+/* Indicate ucode that this is an interrupt in the DPDK scenario. */=0D
+#define RQ_CTXT_INVALID_INTR_NUM			0x1FFU=0D
 =0D
 #define STN_SQ_CTXT_SIZE(num_sqs)	((uint16_t)(sizeof(struct hinic3_stn_qp_=
ctxt_header) \=0D
 						    + (num_sqs) * sizeof(struct hinic3_sq_ctxt)))=0D
@@ -136,6 +155,41 @@ static void cmd_buf_to_rss_indir_table(const struct hi=
nic3_cmd_buf *cmd_buf, uin=0D
 		indir_table[i] =3D *(indir_tbl + i);=0D
 }=0D
 =0D
+static void=0D
+prepare_sq_ctxt_drop_and_prefetch(struct hinic3_sq_ctxt *sq_ctxt)=0D
+{=0D
+	sq_ctxt->pkt_drop_thd =3D SQ_CTXT_PKT_DROP_THD_SET(HINIC3_DEAULT_DROP_THD=
_ON, THD_ON) |=0D
+				SQ_CTXT_PKT_DROP_THD_SET(HINIC3_DEAULT_DROP_THD_OFF, THD_OFF);=0D
+=0D
+	sq_ctxt->pref_cache =3D SQ_CTXT_PREF_SET(WQ_PREFETCH_MIN, CACHE_MIN) |=0D
+			      SQ_CTXT_PREF_SET(WQ_PREFETCH_MAX, CACHE_MAX) |=0D
+			      SQ_CTXT_PREF_SET(WQ_PREFETCH_THRESHOLD, CACHE_THRESHOLD);=0D
+}=0D
+=0D
+static void=0D
+prepare_rq_ctxt_ceq_and_prefetch(struct hinic3_rxq *rq,=0D
+				 struct hinic3_rq_ctxt *rq_ctxt)=0D
+{=0D
+	uint16_t msix_entry_idx =3D rq->dp_intr_en ? rq->msix_entry_idx : RQ_CTXT=
_INVALID_INTR_NUM;=0D
+=0D
+	rq_ctxt->ceq_attr =3D RQ_CTXT_CEQ_ATTR_SET(rq->dp_intr_en ? 0 : 1, EN) |=
=0D
+			    RQ_CTXT_CEQ_ATTR_SET(0, INTR_ARM) |=0D
+			    RQ_CTXT_CEQ_ATTR_SET(msix_entry_idx, INTR);=0D
+=0D
+	if (rq->wqe_type =3D=3D HINIC3_COMPACT_RQ_WQE && rq->nic_dev->config.rx_c=
qe_compact_en) {=0D
+		rq_ctxt->ceq_attr |=3D RQ_CTXT_CEQ_ATTR_SET(1, EN);=0D
+		rq_ctxt->ceq_attr |=3D RQ_CTXT_CEQ_ATTR_SET(1, CI_WR);=0D
+		rq_ctxt->ceq_attr |=3D RQ_CTXT_CEQ_ATTR_SET(1, INTR_ARM);=0D
+		rq_ctxt->cqe_sge_len |=3D RQ_CTXT_CQE_LEN_SET(RQ_CQE_AGGREGATE_NUM, MAX_=
COUNT);=0D
+		rq_ctxt->pi_paddr_hi =3D upper_32_bits(rq->rq_ci_paddr >> RQ_CI_ADDR_SHI=
FT);=0D
+		rq_ctxt->pi_paddr_lo =3D lower_32_bits(rq->rq_ci_paddr >> RQ_CI_ADDR_SHI=
FT);=0D
+	}=0D
+=0D
+	rq_ctxt->pref_cache =3D RQ_CTXT_PREF_SET(WQ_PREFETCH_MIN, CACHE_MIN) |=0D
+			      RQ_CTXT_PREF_SET(WQ_PREFETCH_MAX, CACHE_MAX) |=0D
+			      RQ_CTXT_PREF_SET(WQ_PREFETCH_THRESHOLD, CACHE_THRESHOLD);=0D
+}=0D
+=0D
 const struct hinic3_nic_cmdq_ops hinic3_stn_cmdq_ops =3D {=0D
 	.prepare_cmd_buf_clean_tso_lro_space =3D    prepare_cmd_buf_clean_tso_lro=
_space,=0D
 	.prepare_cmd_buf_qp_context_multi_store =3D prepare_cmd_buf_qp_context_mu=
lti_store,=0D
@@ -143,4 +197,6 @@ const struct hinic3_nic_cmdq_ops hinic3_stn_cmdq_ops =
=3D {=0D
 	.prepare_cmd_buf_set_rss_indir_table =3D    prepare_cmd_buf_set_rss_indir=
_table,=0D
 	.prepare_cmd_buf_get_rss_indir_table =3D    prepare_cmd_buf_get_rss_indir=
_table,=0D
 	.cmd_buf_to_rss_indir_table =3D             cmd_buf_to_rss_indir_table,=0D
+	.prepare_sq_ctxt_drop_and_prefetch =3D      prepare_sq_ctxt_drop_and_pref=
etch,=0D
+	.prepare_rq_ctxt_ceq_and_prefetch =3D       prepare_rq_ctxt_ceq_and_prefe=
tch,=0D
 };=0D
-- =0D
2.33.0=0D
=0D

