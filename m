Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7A6CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 07:10:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 699344066B;
	Wed,  5 Nov 2025 08:09:51 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 47D4140668
 for <dev@dpdk.org>; Wed,  5 Nov 2025 08:09:50 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A4JNVme004813 for <dev@dpdk.org>; Tue, 4 Nov 2025 23:09:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=p
 mTs9VelFVspMqr8sXF9280QkIW2HmVtpIqZvynDrVU=; b=IzYmkwhkTmHghb1bd
 ESweDP3733rx9GcSx2Qrzo8mLQ3grOGHAtBzPyC0rsMXm3tGhW2ELaqBtn5a+vrK
 QuzCXAQcUpFZ+qxyPWN4tgAdw4K0WTfl1bIhARvWtc6Ev/rcPrT/Ma8KnlWD7XB8
 139J60R2iTmrEgVRu37jkUF1wh4130xCllJw8Qglxiw5aC+bB3GeqTaZUl835shk
 nfhp6MxsK439zcn729vaBsqBZu/J/n+oCJ0w6CHWEANtz+c6zfHa6irZLUHysaJV
 N40Io25xwmMuzKO1bXyMUyhq+vRupRXlEbp1TqMd9AdA2BGZseGcfTjrAq0KVGO7
 fFEaA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4a70ec6tpb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 04 Nov 2025 23:09:49 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 4 Nov 2025 23:09:59 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 4 Nov 2025 23:09:59 -0800
Received: from localhost.localdomain (unknown [10.28.36.154])
 by maili.marvell.com (Postfix) with ESMTP id 094555E6865;
 Tue,  4 Nov 2025 23:09:45 -0800 (PST)
From: Rakesh Kudurumalla <rkudurumalla@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, Rakesh Kudurumalla
 <rkudurumalla@marvell.com>
Subject: [PATCH v3 4/5] drivers: net/cnxk: handle soft expiry support
Date: Wed, 5 Nov 2025 12:39:31 +0530
Message-ID: <20251105070932.3569572-4-rkudurumalla@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251105070932.3569572-1-rkudurumalla@marvell.com>
References: <20251029130023.1637177-1-rkudurumalla@marvell.com>
 <20251105070932.3569572-1-rkudurumalla@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDA1MSBTYWx0ZWRfX16k3l3ubBZjj
 DR54mymyws2/GGq3bNo8XNPgS4w49Y+vcxMmSgexRWjOhJ8KvhKMiKahcext5iVG6RhksllxMOv
 k4gSZ3I1fgfQD4WA/18H00RFyvzD65pePyI5WxVVFmJQTnSzEilkze3nEkX7ub0eD086iqeyDci
 nAo8iQzYGrhiw6rsbnvZiY5sQRhKrlR+eH5Zh1rNXL6v9FtLSETNmoi7hYz5QUJKxsi/vjyRYUQ
 CqUyhGECYwlEZOt02/Txsm68m60T/F1AWi9oxIJeAkLWpyb9eNCfw/xBCiBeLpcaYtP3JvjL4Dj
 Gnb/5lN7zVwTH95RtbXGR+z4iFC+jGLcLF3fJrU7TREf3SGaFqpboLEHHZc2ydqZlybonSzQf7n
 DKGd58QRF9CiBFZDk9E0HruBapHv3Q==
X-Proofpoint-GUID: 70NKpLO6ZWHZDuESL0u_xxlAAirAtPVN
X-Authority-Analysis: v=2.4 cv=SomdKfO0 c=1 sm=1 tr=0 ts=690af83d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=g4fYqsmfQnOU8kan5AcA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 70NKpLO6ZWHZDuESL0u_xxlAAirAtPVN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_03,2025-11-03_03,2025-10-01_01
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

Add routines to handle soft expiry for outbound packets
using CPT CQ mechanism. Added devargs support to inline device
to use CPT CQ.

Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
---
 drivers/common/cnxk/roc_features.h        |   5 +
 drivers/common/cnxk/roc_nix_inl.h         |  18 ++-
 drivers/common/cnxk/roc_nix_inl_dev.c     |  29 +++--
 drivers/common/cnxk/roc_nix_inl_dev_irq.c |  75 +++++++++++-
 drivers/common/cnxk/roc_nix_inl_priv.h    |   2 +
 drivers/net/cnxk/cn10k_ethdev.h           |   4 +-
 drivers/net/cnxk/cn10k_ethdev_sec.c       |   8 +-
 drivers/net/cnxk/cn20k_ethdev.h           |   3 +-
 drivers/net/cnxk/cn20k_ethdev_sec.c       | 132 +++++++++++++++-------
 drivers/net/cnxk/cnxk_ethdev_sec.c        |   4 +
 10 files changed, 221 insertions(+), 59 deletions(-)

diff --git a/drivers/common/cnxk/roc_features.h b/drivers/common/cnxk/roc_features.h
index 48ba2fade7..00e8b180f0 100644
--- a/drivers/common/cnxk/roc_features.h
+++ b/drivers/common/cnxk/roc_features.h
@@ -120,4 +120,9 @@ roc_feature_nix_has_plain_pkt_reassembly(void)
 	return roc_model_is_cn20k();
 }
 
+static inline bool
+roc_feature_nix_has_cpt_cq_support(void)
+{
+	return roc_model_is_cn20k();
+}
 #endif
diff --git a/drivers/common/cnxk/roc_nix_inl.h b/drivers/common/cnxk/roc_nix_inl.h
index 4ef1908696..4bae261848 100644
--- a/drivers/common/cnxk/roc_nix_inl.h
+++ b/drivers/common/cnxk/roc_nix_inl.h
@@ -41,6 +41,19 @@
 #define ROC_NIX_INL_REAS_ZOMBIE_LIMIT	  0xFFF
 #define ROC_NIX_INL_REAS_ZOMBIE_THRESHOLD 10
 
+enum nix_inl_event_type {
+	NIX_INL_CPT_CQ = 1,
+	NIX_INL_SSO,
+	NIX_INL_SOFT_EXPIRY_THRD,
+};
+
+enum comp_ptr {
+	WQE_PTR_CPTR,
+	CPTR_WQE_PTR,
+	WQE_PTR_ANTI_REPLAY,
+	CPTR_ANTI_REPLAY,
+};
+
 static inline struct roc_ie_on_inb_sa *
 roc_nix_inl_on_ipsec_inb_sa(uintptr_t base, uint64_t idx)
 {
@@ -70,8 +83,8 @@ roc_nix_inl_on_ipsec_outb_sa_sw_rsvd(void *sa)
 }
 
 /* Inline device SSO Work callback */
-typedef void (*roc_nix_inl_sso_work_cb_t)(uint64_t *gw, void *args,
-					  uint32_t soft_exp_event);
+typedef void (*roc_nix_inl_sso_work_cb_t)(uint64_t *gw, void *args, enum nix_inl_event_type type,
+					  void *cq_s, uint32_t port_id);
 
 typedef int (*roc_nix_inl_meta_pool_cb_t)(uint64_t *aura_handle,  uintptr_t *mpool,
 					  uint32_t blk_sz, uint32_t nb_bufs, bool destroy,
@@ -93,6 +106,7 @@ struct roc_nix_inl_dev {
 	uint8_t spb_drop_pc;
 	uint8_t lpb_drop_pc;
 	uint32_t soft_exp_poll_freq; /* Polling disabled if 0 */
+	uint8_t cpt_cq_enable;
 	uint32_t nb_meta_bufs;
 	uint32_t meta_buf_sz;
 	uint32_t max_ipsec_rules;
diff --git a/drivers/common/cnxk/roc_nix_inl_dev.c b/drivers/common/cnxk/roc_nix_inl_dev.c
index dcfb893215..bc3aa60ab9 100644
--- a/drivers/common/cnxk/roc_nix_inl_dev.c
+++ b/drivers/common/cnxk/roc_nix_inl_dev.c
@@ -37,11 +37,14 @@ nix_inl_dev_pffunc_get(void)
 }
 
 static void
-nix_inl_selftest_work_cb(uint64_t *gw, void *args, uint32_t soft_exp_event)
+nix_inl_selftest_work_cb(uint64_t *gw, void *args, enum nix_inl_event_type type, void *cq_s,
+			 uint32_t port_id)
 {
 	uintptr_t work = gw[1];
 
-	(void)soft_exp_event;
+	(void)type;
+	(void)cq_s;
+	(void)port_id;
 	*((uintptr_t *)args + (gw[0] & 0x1)) = work;
 
 	plt_atomic_thread_fence(__ATOMIC_ACQ_REL);
@@ -476,8 +479,10 @@ nix_inl_cpt_setup(struct nix_inl_dev *inl_dev, bool inl_dev_sso)
 
 	return 0;
 lf_fini:
-	for (i = 0; i < inl_dev->nb_cptlf; i++)
-		cpt_lf_fini(&inl_dev->cpt_lf[i], false);
+	for (i = 0; i < inl_dev->nb_cptlf; i++) {
+		struct roc_cpt_lf *lf = &inl_dev->cpt_lf[i];
+		cpt_lf_fini(lf, lf->cpt_cq_ena);
+	}
 lf_free:
 	rc |= cpt_lfs_free(dev);
 	return rc;
@@ -500,9 +505,12 @@ nix_inl_cpt_release(struct nix_inl_dev *inl_dev)
 	/* TODO: Wait for CPT/RXC queue to drain */
 
 	/* Cleanup CPT LF queue */
-	for (i = 0; i < inl_dev->nb_cptlf; i++)
-		cpt_lf_fini(&inl_dev->cpt_lf[i], false);
-
+	for (i = 0; i < inl_dev->nb_cptlf; i++) {
+		struct roc_cpt_lf *lf = &inl_dev->cpt_lf[i];
+		cpt_lf_fini(lf, lf->cpt_cq_ena);
+		if (lf->cpt_cq_ena)
+			cpt_lf_unregister_irqs(lf, cpt_lf_misc_irq, nix_inl_cpt_done_irq);
+	}
 	/* Free LF resources */
 	rc = cpt_lfs_free(dev);
 	if (!rc) {
@@ -1162,7 +1170,7 @@ inl_outb_soft_exp_poll(struct nix_inl_dev *inl_dev, uint32_t ring_idx)
 
 		if (sa != NULL) {
 			uint64_t tmp = ~(uint32_t)0x0;
-			inl_dev->work_cb(&tmp, sa, (port_id << 8) | 0x1);
+			inl_dev->work_cb(&tmp, sa, NIX_INL_SOFT_EXPIRY_THRD, NULL, port_id);
 			__atomic_store_n(ring_base + tail_l + 1, 0ULL,
 					 __ATOMIC_RELAXED);
 			__atomic_fetch_add((uint32_t *)ring_base, 1,
@@ -1381,6 +1389,7 @@ roc_nix_inl_dev_init(struct roc_nix_inl_dev *roc_inl_dev)
 	inl_dev->nb_meta_bufs = roc_inl_dev->nb_meta_bufs;
 	inl_dev->meta_buf_sz = roc_inl_dev->meta_buf_sz;
 	inl_dev->soft_exp_poll_freq = roc_inl_dev->soft_exp_poll_freq;
+	inl_dev->cpt_cq_ena = roc_inl_dev->cpt_cq_enable;
 	inl_dev->custom_inb_sa = roc_inl_dev->custom_inb_sa;
 	inl_dev->nix_inb_q_bpid = -1;
 	inl_dev->nb_cptlf = 1;
@@ -1401,6 +1410,10 @@ roc_nix_inl_dev_init(struct roc_nix_inl_dev *roc_inl_dev)
 		inl_dev->nb_cptlf++;
 	}
 
+	if (roc_feature_nix_has_cpt_cq_support() && inl_dev->cpt_cq_ena) {
+		inl_dev->soft_exp_poll_freq = 0;
+		inl_dev->set_soft_exp_poll = 0;
+	}
 	/* Attach inline inbound CPT LF to NIX has multi queue support */
 	if (roc_feature_nix_has_inl_multi_queue() && roc_inl_dev->nb_inb_cptlfs) {
 		inl_dev->nb_inb_cptlfs = roc_inl_dev->nb_inb_cptlfs;
diff --git a/drivers/common/cnxk/roc_nix_inl_dev_irq.c b/drivers/common/cnxk/roc_nix_inl_dev_irq.c
index becd7907f2..1c4822925c 100644
--- a/drivers/common/cnxk/roc_nix_inl_dev_irq.c
+++ b/drivers/common/cnxk/roc_nix_inl_dev_irq.c
@@ -32,7 +32,7 @@ nix_inl_sso_work_cb(struct nix_inl_dev *inl_dev)
 	/* Do we have any work? */
 	if (work) {
 		if (inl_dev->work_cb)
-			inl_dev->work_cb(gw.u64, inl_dev->cb_args, false);
+			inl_dev->work_cb(gw.u64, inl_dev->cb_args, NIX_INL_SSO, NULL, false);
 		else
 			plt_warn("Undelivered inl dev work gw0: %p gw1: %p",
 				 (void *)gw.u64[0], (void *)gw.u64[1]);
@@ -45,6 +45,60 @@ nix_inl_sso_work_cb(struct nix_inl_dev *inl_dev)
 	plt_atomic_thread_fence(__ATOMIC_ACQ_REL);
 }
 
+static void
+nix_inl_cpt_cq_cb(struct roc_cpt_lf *lf)
+{
+	struct roc_nix *roc_nix = (struct roc_nix *)lf->dev->roc_nix;
+	struct idev_cfg *idev = idev_get_cfg();
+	uint32_t port_id = roc_nix->port_id;
+	struct nix_inl_dev *inl_dev = NULL;
+	struct roc_ow_ipsec_outb_sa *sa;
+	union cpt_lf_cq_base cq_base;
+	union cpt_lf_cq_ptr cq_ptr;
+	struct cpt_cq_s *cq_s;
+	uint8_t fmt_msk = 0x3;
+	uint64_t nq_ptr;
+	uint32_t count;
+	uint64_t i;
+
+	if (idev)
+		inl_dev = idev->nix_inl_dev;
+
+	if (!inl_dev) {
+		plt_nix_dbg("Inline Device could not be detected");
+		return;
+	}
+
+	cq_base.u = plt_read64(lf->rbase + CPT_LF_CQ_BASE);
+	cq_ptr.u = plt_read64(lf->rbase + CPT_LF_CQ_PTR);
+	count = cq_ptr.s.count;
+
+	nq_ptr = (((cq_base.s.addr << 7)) + ((cq_ptr.s.nq_ptr - count) << 5));
+	cq_s = (struct cpt_cq_s *)nq_ptr;
+
+	for (i = 0; i < count; i++) {
+		if (cq_s->w0.s.uc_compcode && cq_s->w0.s.compcode) {
+			switch (cq_s->w2.s.fmt & fmt_msk) {
+			case WQE_PTR_CPTR:
+				sa = (struct roc_ow_ipsec_outb_sa *)cq_s->w1.esn;
+				break;
+			case CPTR_WQE_PTR:
+				sa = (struct roc_ow_ipsec_outb_sa *)cq_s->w3.comp_ptr;
+				break;
+			default:
+				plt_err("Invalid event Received ");
+				goto done;
+			}
+			uint64_t tmp = ~(uint32_t)0x0;
+			inl_dev->work_cb(&tmp, sa, NIX_INL_CPT_CQ, (void *)cq_s, port_id);
+		}
+done:
+		cq_s = cq_s + 1;
+	}
+	/* Acknowledge the number of completed requests */
+	plt_write64(count, lf->rbase + CPT_LF_DONE_ACK);
+}
+
 static int
 nix_inl_nix_reg_dump(struct nix_inl_dev *inl_dev)
 {
@@ -102,6 +156,25 @@ nix_inl_sso_hws_irq(void *param)
 	plt_write64(intr, ssow_base + SSOW_LF_GWS_INT);
 }
 
+void
+nix_inl_cpt_done_irq(void *param)
+{
+	struct roc_cpt_lf *lf = param;
+	uint64_t done_wait;
+	uint64_t intr;
+
+	/* Read the number of completed requests */
+	intr = plt_read64(lf->rbase + CPT_LF_DONE);
+	if (intr == 0)
+		return;
+
+	done_wait = plt_read64(lf->rbase + CPT_LF_DONE_WAIT);
+
+	nix_inl_cpt_cq_cb(lf);
+
+	plt_write64(done_wait, lf->rbase + CPT_LF_DONE_WAIT);
+}
+
 int
 nix_inl_sso_register_irqs(struct nix_inl_dev *inl_dev)
 {
diff --git a/drivers/common/cnxk/roc_nix_inl_priv.h b/drivers/common/cnxk/roc_nix_inl_priv.h
index 5c12fb1160..402b1514e7 100644
--- a/drivers/common/cnxk/roc_nix_inl_priv.h
+++ b/drivers/common/cnxk/roc_nix_inl_priv.h
@@ -78,6 +78,7 @@ struct nix_inl_dev {
 	uint32_t soft_exp_poll_freq;
 	uint64_t *sa_soft_exp_ring;
 	bool set_soft_exp_poll;
+	uint8_t cpt_cq_ena;
 
 	/* Soft expiry ring bitmap */
 	struct plt_bitmap *soft_exp_ring_bmap;
@@ -136,6 +137,7 @@ struct nix_inl_dev {
 	(BIT_ULL(51) | (ROC_CPT_DFLT_ENG_GRP_SE << 48) |                                           \
 	 (ROC_IE_OW_MAJOR_OP_PROCESS_INBOUND_REASS << 32 | ROC_IE_OW_INPLACE_BIT << 32))
 
+void nix_inl_cpt_done_irq(void *params);
 int nix_inl_sso_register_irqs(struct nix_inl_dev *inl_dev);
 void nix_inl_sso_unregister_irqs(struct nix_inl_dev *inl_dev);
 
diff --git a/drivers/net/cnxk/cn10k_ethdev.h b/drivers/net/cnxk/cn10k_ethdev.h
index 55d7f88716..5542217ddd 100644
--- a/drivers/net/cnxk/cn10k_ethdev.h
+++ b/drivers/net/cnxk/cn10k_ethdev.h
@@ -27,7 +27,7 @@ void cn10k_eth_set_tx_function(struct rte_eth_dev *eth_dev);
 void cn10k_eth_sec_ops_override(void);
 
 /* SSO Work callback */
-void cn10k_eth_sec_sso_work_cb(uint64_t *gw, void *args,
-			       uint32_t soft_exp_event);
+void cn10k_eth_sec_sso_work_cb(uint64_t *gw, void *args, enum nix_inl_event_type type, void *cq_s,
+			       uint32_t port_id);
 
 #endif /* __CN10K_ETHDEV_H__ */
diff --git a/drivers/net/cnxk/cn10k_ethdev_sec.c b/drivers/net/cnxk/cn10k_ethdev_sec.c
index c477b12a30..f26830637f 100644
--- a/drivers/net/cnxk/cn10k_ethdev_sec.c
+++ b/drivers/net/cnxk/cn10k_ethdev_sec.c
@@ -528,7 +528,8 @@ cnxk_pktmbuf_free_no_cache(struct rte_mbuf *mbuf)
 }
 
 void
-cn10k_eth_sec_sso_work_cb(uint64_t *gw, void *args, uint32_t soft_exp_event)
+cn10k_eth_sec_sso_work_cb(uint64_t *gw, void *args, enum nix_inl_event_type type, void *cq_s,
+			  uint32_t port_id)
 {
 	struct rte_eth_event_ipsec_desc desc;
 	struct cn10k_sec_sess_priv sess_priv;
@@ -545,6 +546,7 @@ cn10k_eth_sec_sso_work_cb(uint64_t *gw, void *args, uint32_t soft_exp_event)
 	uint8_t port;
 
 	RTE_SET_USED(args);
+	RTE_SET_USED(cq_s);
 
 	switch ((gw[0] >> 28) & 0xF) {
 	case RTE_EVENT_TYPE_ETHDEV:
@@ -562,7 +564,7 @@ cn10k_eth_sec_sso_work_cb(uint64_t *gw, void *args, uint32_t soft_exp_event)
 		}
 		/* Fall through */
 	default:
-		if (soft_exp_event & 0x1) {
+		if (type == NIX_INL_SOFT_EXPIRY_THRD) {
 			sa = (struct roc_ot_ipsec_outb_sa *)args;
 			priv = roc_nix_inl_ot_ipsec_outb_sa_sw_rsvd(sa);
 			desc.metadata = (uint64_t)priv->userdata;
@@ -572,7 +574,7 @@ cn10k_eth_sec_sso_work_cb(uint64_t *gw, void *args, uint32_t soft_exp_event)
 			else
 				desc.subtype =
 					RTE_ETH_EVENT_IPSEC_SA_BYTE_EXPIRY;
-			eth_dev = &rte_eth_devices[soft_exp_event >> 8];
+			eth_dev = &rte_eth_devices[port_id];
 			rte_eth_dev_callback_process(eth_dev,
 				RTE_ETH_EVENT_IPSEC, &desc);
 		} else {
diff --git a/drivers/net/cnxk/cn20k_ethdev.h b/drivers/net/cnxk/cn20k_ethdev.h
index 74b03b23d2..d247064964 100644
--- a/drivers/net/cnxk/cn20k_ethdev.h
+++ b/drivers/net/cnxk/cn20k_ethdev.h
@@ -27,6 +27,7 @@ void cn20k_eth_set_tx_function(struct rte_eth_dev *eth_dev);
 void cn20k_eth_sec_ops_override(void);
 
 /* SSO Work callback */
-void cn20k_eth_sec_sso_work_cb(uint64_t *gw, void *args, uint32_t soft_exp_event);
+void cn20k_eth_sec_sso_work_cb(uint64_t *gw, void *args, enum nix_inl_event_type type, void *cq_s,
+			       uint32_t port_id);
 
 #endif /* __CN20K_ETHDEV_H__ */
diff --git a/drivers/net/cnxk/cn20k_ethdev_sec.c b/drivers/net/cnxk/cn20k_ethdev_sec.c
index 5bf7917345..03cc088900 100644
--- a/drivers/net/cnxk/cn20k_ethdev_sec.c
+++ b/drivers/net/cnxk/cn20k_ethdev_sec.c
@@ -437,8 +437,79 @@ cnxk_pktmbuf_free_no_cache(struct rte_mbuf *mbuf)
 	} while (mbuf != NULL);
 }
 
+static void
+cn20k_eth_sec_post_event(struct rte_eth_dev *eth_dev, struct roc_ow_ipsec_outb_sa *sa,
+			 uint16_t uc_compcode, uint16_t compcode, struct rte_mbuf *mbuf)
+{
+	struct rte_eth_event_ipsec_desc desc;
+	struct cn20k_sec_sess_priv sess_priv;
+	struct cn20k_outb_priv_data *priv;
+	static uint64_t warn_cnt;
+
+	memset(&desc, 0, sizeof(desc));
+	priv = roc_nix_inl_ow_ipsec_outb_sa_sw_rsvd(sa);
+	sess_priv.u64 = 0;
+
+	if (mbuf)
+		sess_priv.u64 = *rte_security_dynfield(mbuf);
+
+	switch (uc_compcode) {
+	case ROC_IE_OW_UCC_ERR_SA_OVERFLOW:
+		desc.subtype = RTE_ETH_EVENT_IPSEC_ESN_OVERFLOW;
+		break;
+	case ROC_IE_OW_UCC_ERR_SA_EXPIRED:
+		if (sa->w2.s.life_unit == ROC_IE_OW_SA_LIFE_UNIT_PKTS)
+			desc.subtype = RTE_ETH_EVENT_IPSEC_SA_PKT_HARD_EXPIRY;
+		else
+			desc.subtype = RTE_ETH_EVENT_IPSEC_SA_BYTE_HARD_EXPIRY;
+		break;
+	case ROC_IE_OW_UCC_SUCCESS_SA_SOFTEXP_FIRST:
+		if (sa->w2.s.life_unit == ROC_IE_OW_SA_LIFE_UNIT_PKTS)
+			desc.subtype = RTE_ETH_EVENT_IPSEC_SA_PKT_EXPIRY;
+		else
+			desc.subtype = RTE_ETH_EVENT_IPSEC_SA_BYTE_EXPIRY;
+		break;
+	case ROC_IE_OW_UCC_ERR_PKT_IP:
+		warn_cnt++;
+		if (warn_cnt % 10000 == 0)
+			plt_warn("Outbound error, bad ip pkt, mbuf %p,"
+				 "sa_index %u (total warnings %" PRIu64 ")",
+				 mbuf, sess_priv.sa_idx, warn_cnt);
+		desc.subtype = -uc_compcode;
+		break;
+	default:
+		warn_cnt++;
+		if (warn_cnt % 10000 == 0)
+			plt_warn("Outbound error, mbuf %p, sa_index %u,"
+				 " compcode %x uc %x,"
+				 " (total warnings %" PRIu64 ")",
+				 mbuf, sess_priv.sa_idx, compcode, uc_compcode, warn_cnt);
+		desc.subtype = -uc_compcode;
+		break;
+	}
+
+	desc.metadata = (uint64_t)priv->userdata;
+	rte_eth_dev_callback_process(eth_dev, RTE_ETH_EVENT_IPSEC, &desc);
+}
+
+static const char *
+get_inl_event_type(enum nix_inl_event_type type)
+{
+	switch (type) {
+	case NIX_INL_CPT_CQ:
+		return "NIX_INL_CPT_CQ";
+	case NIX_INL_SSO:
+		return "NIX_INL_SSO";
+	case NIX_INL_SOFT_EXPIRY_THRD:
+		return "NIX_INL_SOFT_EXPIRY_THRD";
+	default:
+		return "Unknown event";
+	}
+}
+
 void
-cn20k_eth_sec_sso_work_cb(uint64_t *gw, void *args, uint32_t soft_exp_event)
+cn20k_eth_sec_sso_work_cb(uint64_t *gw, void *args, enum nix_inl_event_type type, void *cq_s,
+			  uint32_t port_id)
 {
 	struct rte_eth_event_ipsec_desc desc;
 	struct cn20k_sec_sess_priv sess_priv;
@@ -447,7 +518,6 @@ cn20k_eth_sec_sso_work_cb(uint64_t *gw, void *args, uint32_t soft_exp_event)
 	struct cpt_cn20k_res_s *res;
 	struct rte_eth_dev *eth_dev;
 	struct cnxk_eth_dev *dev;
-	static uint64_t warn_cnt;
 	uint16_t dlen_adj, rlen;
 	struct rte_mbuf *mbuf;
 	uintptr_t sa_base;
@@ -455,6 +525,7 @@ cn20k_eth_sec_sso_work_cb(uint64_t *gw, void *args, uint32_t soft_exp_event)
 	uint8_t port;
 
 	RTE_SET_USED(args);
+	plt_nix_dbg("Received %s event", get_inl_event_type(type));
 
 	switch ((gw[0] >> 28) & 0xF) {
 	case RTE_EVENT_TYPE_ETHDEV:
@@ -472,15 +543,25 @@ cn20k_eth_sec_sso_work_cb(uint64_t *gw, void *args, uint32_t soft_exp_event)
 		}
 		/* Fall through */
 	default:
-		if (soft_exp_event & 0x1) {
+		if (type) {
 			sa = (struct roc_ow_ipsec_outb_sa *)args;
 			priv = roc_nix_inl_ow_ipsec_outb_sa_sw_rsvd(sa);
 			desc.metadata = (uint64_t)priv->userdata;
-			if (sa->w2.s.life_unit == ROC_IE_OT_SA_LIFE_UNIT_PKTS)
-				desc.subtype = RTE_ETH_EVENT_IPSEC_SA_PKT_EXPIRY;
-			else
-				desc.subtype = RTE_ETH_EVENT_IPSEC_SA_BYTE_EXPIRY;
-			eth_dev = &rte_eth_devices[soft_exp_event >> 8];
+			eth_dev = &rte_eth_devices[port_id];
+			if (type == NIX_INL_CPT_CQ) {
+				struct cpt_cq_s *cqs = (struct cpt_cq_s *)cq_s;
+
+				cn20k_eth_sec_post_event(eth_dev, sa,
+							 (uint16_t)cqs->w0.s.uc_compcode,
+							 (uint16_t)cqs->w0.s.compcode, NULL);
+				return;
+			}
+			if (type == NIX_INL_SOFT_EXPIRY_THRD) {
+				if (sa->w2.s.life_unit == ROC_IE_OW_SA_LIFE_UNIT_PKTS)
+					desc.subtype = RTE_ETH_EVENT_IPSEC_SA_PKT_EXPIRY;
+				else
+					desc.subtype = RTE_ETH_EVENT_IPSEC_SA_BYTE_EXPIRY;
+			}
 			rte_eth_dev_callback_process(eth_dev, RTE_ETH_EVENT_IPSEC, &desc);
 		} else {
 			plt_err("Unknown event gw[0] = 0x%016lx, gw[1] = 0x%016lx", gw[0], gw[1]);
@@ -514,41 +595,9 @@ cn20k_eth_sec_sso_work_cb(uint64_t *gw, void *args, uint32_t soft_exp_event)
 
 	sa_base = dev->outb.sa_base;
 	sa = roc_nix_inl_ow_ipsec_outb_sa(sa_base, sess_priv.sa_idx);
-	priv = roc_nix_inl_ow_ipsec_outb_sa_sw_rsvd(sa);
-
-	memset(&desc, 0, sizeof(desc));
 
-	switch (res->uc_compcode) {
-	case ROC_IE_OT_UCC_ERR_SA_OVERFLOW:
-		desc.subtype = RTE_ETH_EVENT_IPSEC_ESN_OVERFLOW;
-		break;
-	case ROC_IE_OT_UCC_ERR_SA_EXPIRED:
-		if (sa->w2.s.life_unit == ROC_IE_OT_SA_LIFE_UNIT_PKTS)
-			desc.subtype = RTE_ETH_EVENT_IPSEC_SA_PKT_HARD_EXPIRY;
-		else
-			desc.subtype = RTE_ETH_EVENT_IPSEC_SA_BYTE_HARD_EXPIRY;
-		break;
-	case ROC_IE_OT_UCC_ERR_PKT_IP:
-		warn_cnt++;
-		if (warn_cnt % 10000 == 0)
-			plt_warn("Outbound error, bad ip pkt, mbuf %p,"
-				 " sa_index %u (total warnings %" PRIu64 ")",
-				 mbuf, sess_priv.sa_idx, warn_cnt);
-		desc.subtype = -res->uc_compcode;
-		break;
-	default:
-		warn_cnt++;
-		if (warn_cnt % 10000 == 0)
-			plt_warn("Outbound error, mbuf %p, sa_index %u,"
-				 " compcode %x uc %x,"
-				 " (total warnings %" PRIu64 ")",
-				 mbuf, sess_priv.sa_idx, res->compcode, res->uc_compcode, warn_cnt);
-		desc.subtype = -res->uc_compcode;
-		break;
-	}
+	cn20k_eth_sec_post_event(eth_dev, sa, res->uc_compcode, res->compcode, mbuf);
 
-	desc.metadata = (uint64_t)priv->userdata;
-	rte_eth_dev_callback_process(eth_dev, RTE_ETH_EVENT_IPSEC, &desc);
 	cnxk_pktmbuf_free_no_cache(mbuf);
 }
 
@@ -625,7 +674,6 @@ cn20k_eth_sec_outb_sa_misc_fill(struct roc_nix *roc_nix, struct roc_ow_ipsec_out
 		sa->ctx.err_ctl.s.address = ring_addr >> 3;
 		sa->w0.s.ctx_id = ((uintptr_t)sa_cptr >> 51) & 0x1ff;
 	}
-
 	return 0;
 }
 
diff --git a/drivers/net/cnxk/cnxk_ethdev_sec.c b/drivers/net/cnxk/cnxk_ethdev_sec.c
index ac6ee79f78..59a00408ad 100644
--- a/drivers/net/cnxk/cnxk_ethdev_sec.c
+++ b/drivers/net/cnxk/cnxk_ethdev_sec.c
@@ -22,6 +22,7 @@
 #define CNXK_NIX_INL_RX_INJ_ENABLE	"rx_inj_ena"
 #define CNXK_NIX_CUSTOM_INB_SA	      "custom_inb_sa"
 #define CNXK_NIX_NB_INL_INB_QS        "nb_inl_inb_qs"
+#define CNXK_NIX_INL_CPT_CQ_ENABLE    "cpt_cq_enable"
 
 /* Default soft expiry poll freq in usec */
 #define CNXK_NIX_SOFT_EXP_POLL_FREQ_DFLT 100
@@ -567,6 +568,7 @@ nix_inl_parse_devargs(struct rte_devargs *devargs,
 	uint32_t meta_buf_sz = 0;
 	uint8_t rx_inj_ena = 0;
 	uint8_t selftest = 0;
+	uint8_t cpt_cq_enable = 0;
 
 	memset(&cpt_channel, 0, sizeof(cpt_channel));
 
@@ -595,6 +597,7 @@ nix_inl_parse_devargs(struct rte_devargs *devargs,
 	rte_kvargs_process(kvlist, CNXK_NIX_INL_RX_INJ_ENABLE, &parse_val_u8, &rx_inj_ena);
 	rte_kvargs_process(kvlist, CNXK_NIX_CUSTOM_INB_SA, &parse_val_u8, &custom_inb_sa);
 	rte_kvargs_process(kvlist, CNXK_NIX_NB_INL_INB_QS, &parse_val_u8, &nb_inl_inb_qs);
+	rte_kvargs_process(kvlist, CNXK_NIX_INL_CPT_CQ_ENABLE, &parse_val_u8, &cpt_cq_enable);
 	rte_kvargs_free(kvlist);
 
 null_devargs:
@@ -607,6 +610,7 @@ nix_inl_parse_devargs(struct rte_devargs *devargs,
 	inl_dev->nb_meta_bufs = nb_meta_bufs;
 	inl_dev->meta_buf_sz = meta_buf_sz;
 	inl_dev->soft_exp_poll_freq = soft_exp_poll_freq;
+	inl_dev->cpt_cq_enable = cpt_cq_enable;
 	inl_dev->max_ipsec_rules = max_ipsec_rules;
 	if (roc_feature_nix_has_rx_inject())
 		inl_dev->rx_inj_ena = rx_inj_ena;
-- 
2.25.1

