Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00A7CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 10:48:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A37F406B8;
	Fri,  7 Nov 2025 11:48:23 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id C46C24069F
 for <dev@dpdk.org>; Fri,  7 Nov 2025 11:48:21 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A79Bx7g2744836 for <dev@dpdk.org>; Fri, 7 Nov 2025 02:48:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=x
 U/BFdSzmD+W3YBH8hUMSzMrRSWVUWDhq8jby1NhDEY=; b=ioFzyrTLB85zF5cQ6
 bZJZ8slXGsUnPj6k9QghVLKivbilP09egiDf6pwyQXWGp3BV3u71ULnDUkVVraIA
 5b5YR9sctwCtGtk34qIyMhnaEze6kTwqXVV0AA67B5lmL5sUHJI33TiQxp5RMznu
 C275H8x2VVi7S9bslfYq/97nvAdbRhaDgKh9oukLv+wjYfTKgfVAofNqX+8Rn53C
 8vLgj+TXE+NsaaYdlyaqcm7BxTZS9BmR5gdTQOhAvmYz9iTpRLBSawlcxDAt3R41
 W1xIRWXO0rKuFPGW4QoSJmYcauGL3BzpHo/16mXbmTBNm6eYY6Q91UTkOxBKtyVe
 Pw2bA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4a8pk65snw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 07 Nov 2025 02:48:21 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 7 Nov 2025 02:48:31 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 7 Nov 2025 02:48:31 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id A03623F70C7;
 Fri,  7 Nov 2025 02:48:17 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v4 09/23] common/cnxk: add support for per packet SQ count
 update
Date: Fri, 7 Nov 2025 16:17:33 +0530
Message-ID: <20251107104747.1131008-9-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251107104747.1131008-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251107104747.1131008-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=IqYTsb/g c=1 sm=1 tr=0 ts=690dce75 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=5OEz-aZnzPt5HFAdlcMA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: sGfVkyXBBKCasVG2EXrL58lxrXAlBDyq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA4NyBTYWx0ZWRfX2D0GgbU5SXLv
 z3L+EKvEH5XRXH5DVje9ZjJ+fbpTLQ8Iq4kzWZ2+JDDv9NWEHfHgPdFWOeQ327s29Ni4JRr4BhN
 xtdT9EvW8mP6QVzMBZVHmSsRhMzHe9G7X03EzeWbBneS9LN0g9h08HeQPTOdy86vqLDq9q+n6tM
 YQbxmXQ9V4+NeCB2hwGv+kJdOO+Tdwjz4vltlpyyKyTzHNjOW8/xMXrg9W/9chJFbRPK1skdJ4f
 lLQjiLDqN24fbKzl1egVp3Igfb8t5tPjMAwNad1FFg0H3+dFBW3vMqZ/laU2wJoLN2hG99z/r3p
 6eIfB0YplK5WU7ZO5BhOdw82gtgpLg4/ccozEfwNCqfsuKonIpQHqnEKmxGIrqN/Li1FgpapilB
 W6e847pSLIkUQt37XF6piorlg+KNCw==
X-Proofpoint-ORIG-GUID: sGfVkyXBBKCasVG2EXrL58lxrXAlBDyq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
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

From: Satha Rao <skoteshwar@marvell.com>

SQ context extended with new feature, if enabled the counter is updated
when a packet if processed, whether it is transmitted or dropped.

Signed-off-by: Satha Rao <skoteshwar@marvell.com>
---
 drivers/common/cnxk/hw/nix.h                  | 47 +++++++------
 drivers/common/cnxk/roc_features.h            |  7 ++
 drivers/common/cnxk/roc_nix.h                 |  3 +
 drivers/common/cnxk/roc_nix_queue.c           | 70 ++++++++++++++++++-
 drivers/common/cnxk/roc_nix_tm.c              |  2 +-
 drivers/common/cnxk/roc_nix_tm_ops.c          |  8 ++-
 drivers/common/cnxk/roc_platform.h            |  6 ++
 .../common/cnxk/roc_platform_base_symbols.c   |  1 +
 8 files changed, 119 insertions(+), 25 deletions(-)

diff --git a/drivers/common/cnxk/hw/nix.h b/drivers/common/cnxk/hw/nix.h
index 8956b95040..314beb9e0b 100644
--- a/drivers/common/cnxk/hw/nix.h
+++ b/drivers/common/cnxk/hw/nix.h
@@ -2092,21 +2092,25 @@ struct nix_cn20k_sq_ctx_hw_s {
 	uint64_t default_chan : 12;
 	uint64_t sdp_mcast : 1;
 	uint64_t sso_ena : 1;
-	uint64_t dse_rsvd1 : 28;
+	uint64_t dse_rsvd1 : 10;
+	uint64_t update_sq_count : 2;
+	uint64_t seb_count : 16;
 	uint64_t sqb_enqueue_count : 16; /* W4 */
 	uint64_t tail_offset : 6;
 	uint64_t lmt_dis : 1;
 	uint64_t smq_rr_weight : 14;
-	uint64_t dnq_rsvd1 : 27;
+	uint64_t dnq_rsvd1 : 4;
+	uint64_t sq_count_iova_lo : 23;
 	uint64_t tail_sqb : 64; /* W5 */
 	uint64_t next_sqb : 64; /* W6 */
-	uint64_t smq : 11; /* W7 */
+	uint64_t smq : 11;	/* W7 */
 	uint64_t smq_pend : 1;
 	uint64_t smq_next_sq : 20;
 	uint64_t smq_next_sq_vld : 1;
 	uint64_t mnq_dis : 1;
-	uint64_t scm1_rsvd2 : 30;
-	uint64_t smenq_sqb : 64; /* W8 */
+	uint64_t scm1_rsvd2 : 7;
+	uint64_t sq_count_iova_hi : 23;
+	uint64_t smenq_sqb : 64;   /* W8 */
 	uint64_t smenq_offset : 6; /* W9 */
 	uint64_t cq_limit : 8;
 	uint64_t smq_rr_count : 32;
@@ -2122,7 +2126,7 @@ struct nix_cn20k_sq_ctx_hw_s {
 	uint64_t smenq_next_sqb_vld : 1;
 	uint64_t scm_dq_rsvd1 : 9;
 	uint64_t smenq_next_sqb : 64; /* W11 */
-	uint64_t age_drop_octs : 32; /* W12 */
+	uint64_t age_drop_octs : 32;  /* W12 */
 	uint64_t age_drop_pkts : 32;
 	uint64_t drop_pkts : 48; /* W13 */
 	uint64_t drop_octs_lsw : 16;
@@ -2160,19 +2164,20 @@ struct nix_cn20k_sq_ctx_s {
 	uint64_t lmt_dis : 1;
 	uint64_t mnq_dis : 1;
 	uint64_t smq_next_sq : 20;
-	uint64_t smq_lso_segnum :  8;
-	uint64_t tail_offset :  6;
-	uint64_t smenq_offset :  6;
-	uint64_t head_offset :  6;
-	uint64_t smenq_next_sqb_vld :  1;
-	uint64_t smq_pend :  1;
-	uint64_t smq_next_sq_vld :  1;
-	uint64_t reserved_253_255 :  3;
-	uint64_t next_sqb : 64; /* W4 */
-	uint64_t tail_sqb : 64; /* W5 */
-	uint64_t smenq_sqb : 64; /* W6 */
-	uint64_t smenq_next_sqb : 64; /* W7 */
-	uint64_t head_sqb : 64; /* W8 */
+	uint64_t smq_lso_segnum : 8;
+	uint64_t tail_offset : 6;
+	uint64_t smenq_offset : 6;
+	uint64_t head_offset : 6;
+	uint64_t smenq_next_sqb_vld : 1;
+	uint64_t smq_pend : 1;
+	uint64_t smq_next_sq_vld : 1;
+	uint64_t update_sq_count : 2;
+	uint64_t reserved_255_255 : 1;
+	uint64_t next_sqb : 64;	       /* W4 */
+	uint64_t tail_sqb : 64;	       /* W5 */
+	uint64_t smenq_sqb : 64;       /* W6 */
+	uint64_t smenq_next_sqb : 64;  /* W7 */
+	uint64_t head_sqb : 64;	       /* W8 */
 	uint64_t reserved_576_583 : 8; /* W9 */
 	uint64_t vfi_lso_total : 18;
 	uint64_t vfi_lso_sizem1 : 3;
@@ -2183,7 +2188,7 @@ struct nix_cn20k_sq_ctx_s {
 	uint64_t vfi_lso_vld : 1;
 	uint64_t reserved_630_639 : 10;
 	uint64_t scm_lso_rem : 18; /* W10 */
-	uint64_t reserved_658_703 : 46;
+	uint64_t sq_count_iova : 46;
 	uint64_t octs : 48; /* W11 */
 	uint64_t reserved_752_767 : 16;
 	uint64_t pkts : 48; /* W12 */
@@ -2193,7 +2198,7 @@ struct nix_cn20k_sq_ctx_s {
 	uint64_t drop_octs : 48; /* W14 */
 	uint64_t reserved_944_959 : 16;
 	uint64_t drop_pkts : 48; /* W15 */
-	uint64_t reserved_1008_1023 : 16;
+	uint64_t seb_count : 16;
 };
 
 /* [CN10K, .) NIX sq context hardware structure */
diff --git a/drivers/common/cnxk/roc_features.h b/drivers/common/cnxk/roc_features.h
index 00e8b180f0..c7d2a73d99 100644
--- a/drivers/common/cnxk/roc_features.h
+++ b/drivers/common/cnxk/roc_features.h
@@ -125,4 +125,11 @@ roc_feature_nix_has_cpt_cq_support(void)
 {
 	return roc_model_is_cn20k();
 }
+
+static inline bool
+roc_feature_nix_has_sq_cnt_update(void)
+{
+	return roc_model_is_cn20k();
+}
+
 #endif
diff --git a/drivers/common/cnxk/roc_nix.h b/drivers/common/cnxk/roc_nix.h
index 35eb855986..e070db1baa 100644
--- a/drivers/common/cnxk/roc_nix.h
+++ b/drivers/common/cnxk/roc_nix.h
@@ -409,6 +409,8 @@ struct roc_nix_sq {
 	void *lmt_addr;
 	void *sqe_mem;
 	void *fc;
+	void *sq_cnt_ptr;
+	uint8_t update_sq_cnt;
 	uint8_t tc;
 	bool enable;
 };
@@ -989,6 +991,7 @@ int __roc_api roc_nix_sq_fini(struct roc_nix_sq *sq);
 int __roc_api roc_nix_sq_ena_dis(struct roc_nix_sq *sq, bool enable);
 void __roc_api roc_nix_sq_head_tail_get(struct roc_nix *roc_nix, uint16_t qid,
 					uint32_t *head, uint32_t *tail);
+int __roc_api roc_nix_sq_cnt_update(struct roc_nix_sq *sq, bool enable);
 
 /* PTP */
 int __roc_api roc_nix_ptp_rx_ena_dis(struct roc_nix *roc_nix, int enable);
diff --git a/drivers/common/cnxk/roc_nix_queue.c b/drivers/common/cnxk/roc_nix_queue.c
index e19a6877e6..e59cd77538 100644
--- a/drivers/common/cnxk/roc_nix_queue.c
+++ b/drivers/common/cnxk/roc_nix_queue.c
@@ -1464,7 +1464,7 @@ sqb_pool_populate(struct roc_nix *roc_nix, struct roc_nix_sq *sq)
 
 	if (roc_nix->sqb_slack)
 		nb_sqb_bufs += roc_nix->sqb_slack;
-	else
+	else if (!sq->sq_cnt_ptr)
 		nb_sqb_bufs += PLT_MAX((int)thr, (int)ROC_NIX_SQB_SLACK_DFLT);
 	/* Explicitly set nat_align alone as by default pool is with both
 	 * nat_align and buf_offset = 1 which we don't want for SQB.
@@ -1473,7 +1473,9 @@ sqb_pool_populate(struct roc_nix *roc_nix, struct roc_nix_sq *sq)
 	pool.nat_align = 1;
 
 	memset(&aura, 0, sizeof(aura));
-	aura.fc_ena = 1;
+	/* Disable SQ pool FC updates when SQ count updates are used */
+	if (!sq->sq_cnt_ptr)
+		aura.fc_ena = 1;
 	if (roc_model_is_cn9k() || roc_errata_npa_has_no_fc_stype_ststp())
 		aura.fc_stype = 0x0; /* STF */
 	else
@@ -1827,6 +1829,11 @@ sq_init(struct nix *nix, struct roc_nix_sq *sq, uint32_t rr_quantum, uint16_t sm
 	aq->sq.sq_int_ena |= BIT(NIX_SQINT_SEND_ERR);
 	aq->sq.sq_int_ena |= BIT(NIX_SQINT_MNQ_ERR);
 
+	/* HW atomic update of SQ count */
+	if (sq->sq_cnt_ptr) {
+		aq->sq.sq_count_iova = ((uintptr_t)sq->sq_cnt_ptr) >> 3;
+		aq->sq.update_sq_count = sq->update_sq_cnt;
+	}
 	/* Many to one reduction */
 	aq->sq.qint_idx = sq->qid % nix->qints;
 	if (roc_errata_nix_assign_incorrect_qint()) {
@@ -2133,3 +2140,62 @@ roc_nix_q_err_cb_unregister(struct roc_nix *roc_nix)
 
 	dev->ops->q_err_cb = NULL;
 }
+
+int
+roc_nix_sq_cnt_update(struct roc_nix_sq *sq, bool enable)
+{
+	struct nix *nix = roc_nix_to_nix_priv(sq->roc_nix);
+	struct mbox *mbox = mbox_get((&nix->dev)->mbox);
+	int64_t __plt_atomic *sq_cntm = (int64_t __plt_atomic *)sq->sq_cnt_ptr;
+	struct nix_cn20k_aq_enq_rsp *rsp;
+	struct nix_cn20k_aq_enq_req *aq;
+	int rc;
+
+	aq = mbox_alloc_msg_nix_cn20k_aq_enq(mbox);
+	if (!aq) {
+		mbox_put(mbox);
+		return -ENOSPC;
+	}
+
+	aq->qidx = sq->qid;
+	aq->ctype = NIX_AQ_CTYPE_SQ;
+	aq->op = NIX_AQ_INSTOP_READ;
+	rc = mbox_process_msg(mbox, (void *)&rsp);
+	if (rc) {
+		mbox_put(mbox);
+		return rc;
+	}
+
+	/* Check if sq is already in same state */
+	if ((enable && rsp->sq.update_sq_count) || (!enable && !rsp->sq.update_sq_count)) {
+		mbox_put(mbox);
+		return 0;
+	}
+
+	/* Disable sq */
+	aq = mbox_alloc_msg_nix_cn20k_aq_enq(mbox);
+	if (!aq) {
+		mbox_put(mbox);
+		return -ENOSPC;
+	}
+
+	aq->qidx = sq->qid;
+	aq->ctype = NIX_AQ_CTYPE_SQ;
+	aq->op = NIX_AQ_INSTOP_WRITE;
+	aq->sq_mask.update_sq_count = ~aq->sq_mask.update_sq_count;
+	aq->sq.update_sq_count = enable;
+	if (enable)
+		aq->sq.update_sq_count = sq->update_sq_cnt;
+	rc = mbox_process(mbox);
+	if (rc) {
+		mbox_put(mbox);
+		return rc;
+	}
+	if (enable)
+		plt_atomic_store_explicit(sq_cntm, sq->nb_desc, plt_memory_order_relaxed);
+	else
+		plt_atomic_store_explicit(sq_cntm, 0, plt_memory_order_relaxed);
+
+	mbox_put(mbox);
+	return 0;
+}
diff --git a/drivers/common/cnxk/roc_nix_tm.c b/drivers/common/cnxk/roc_nix_tm.c
index 2771fd8fc4..76c0f01884 100644
--- a/drivers/common/cnxk/roc_nix_tm.c
+++ b/drivers/common/cnxk/roc_nix_tm.c
@@ -601,7 +601,7 @@ roc_nix_tm_sq_flush_spin(struct roc_nix_sq *sq)
 
 		/* SQ reached quiescent state */
 		if (sqb_cnt <= 1 && head_off == tail_off &&
-		    (*(volatile uint64_t *)sq->fc == sq->aura_sqb_bufs)) {
+		    (sq->sq_cnt_ptr || (*(volatile uint64_t *)sq->fc == sq->aura_sqb_bufs))) {
 			break;
 		}
 
diff --git a/drivers/common/cnxk/roc_nix_tm_ops.c b/drivers/common/cnxk/roc_nix_tm_ops.c
index 951c310a56..09d014a276 100644
--- a/drivers/common/cnxk/roc_nix_tm_ops.c
+++ b/drivers/common/cnxk/roc_nix_tm_ops.c
@@ -19,6 +19,12 @@ roc_nix_tm_sq_aura_fc(struct roc_nix_sq *sq, bool enable)
 	plt_tm_dbg("Setting SQ %u SQB aura FC to %s", sq->qid,
 		   enable ? "enable" : "disable");
 
+	/* For cn20K, enable/disable SQ count updates if the SQ count pointer
+	 * was allocated based on the enable field.
+	 */
+	if (sq->sq_cnt_ptr)
+		return roc_nix_sq_cnt_update(sq, enable);
+
 	lf = idev_npa_obj_get();
 	if (!lf)
 		return NPA_ERR_DEVICE_NOT_BOUNDED;
@@ -554,7 +560,7 @@ roc_nix_tm_hierarchy_disable(struct roc_nix *roc_nix)
 		tail_off = (val >> 28) & 0x3F;
 
 		if (sqb_cnt > 1 || head_off != tail_off ||
-		    (*(uint64_t *)sq->fc != sq->aura_sqb_bufs))
+		    (!sq->sq_cnt_ptr && (*(uint64_t *)sq->fc != sq->aura_sqb_bufs)))
 			plt_err("Failed to gracefully flush sq %u", sq->qid);
 	}
 
diff --git a/drivers/common/cnxk/roc_platform.h b/drivers/common/cnxk/roc_platform.h
index ff3a25e57f..e22a50d47a 100644
--- a/drivers/common/cnxk/roc_platform.h
+++ b/drivers/common/cnxk/roc_platform.h
@@ -212,6 +212,12 @@ plt_thread_is_valid(plt_thread_t thr)
 #define plt_io_rmb()		rte_io_rmb()
 #define plt_atomic_thread_fence rte_atomic_thread_fence
 
+#define plt_atomic_store_explicit rte_atomic_store_explicit
+#define plt_atomic_load_explicit  rte_atomic_load_explicit
+#define plt_memory_order_release  rte_memory_order_release
+#define plt_memory_order_acquire  rte_memory_order_acquire
+#define plt_memory_order_relaxed  rte_memory_order_relaxed
+
 #define plt_bit_relaxed_get32   rte_bit_relaxed_get32
 #define plt_bit_relaxed_set32   rte_bit_relaxed_set32
 #define plt_bit_relaxed_clear32 rte_bit_relaxed_clear32
diff --git a/drivers/common/cnxk/roc_platform_base_symbols.c b/drivers/common/cnxk/roc_platform_base_symbols.c
index 5488825bda..c34a4d7bc2 100644
--- a/drivers/common/cnxk/roc_platform_base_symbols.c
+++ b/drivers/common/cnxk/roc_platform_base_symbols.c
@@ -364,6 +364,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rss_reta_get)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rss_flowkey_set)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rss_default_setup)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_num_xstats_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_sq_cnt_update)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_stats_get)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_stats_reset)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_stats_queue_get)
-- 
2.34.1

