Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEF0CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 11:16:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BCEC44026A;
	Tue, 11 Nov 2025 12:16:51 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 4D6AD40144
 for <dev@dpdk.org>; Tue, 11 Nov 2025 12:16:50 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AB6VgAA2487129 for <dev@dpdk.org>; Tue, 11 Nov 2025 03:16:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=qLymL/T6bt3nAOviF+tMuo3
 lFsP7TMmTLK9GrgWLGw0=; b=ScUprJS65Xyq6K4rr/+e5aJXATUQD+FK7AjA8mB
 taXXL8rKaKqkv0F47KFd3M3kRBuqYz+2DZvdVPd4MCttB8jmrgHoyX7Sxu1je6gx
 pEqXvT6g99pbuDQer6bvX+skFgmNbbc/aZmScV11Xq4Gy4FCPD7gsDe6rGOaYdGu
 /vRmLBoJlXt75SOMZ6LUaqdWFfxWIvF/Qfb1Q1/yKr3EkSrsXgi+JhTvRyT1Y6KS
 zns7B/m44t4MmC52ZdW7ls7xWPJ4KID0EWj50ywg5ysX32J6/FebGizPeDQJGiUw
 ICTM4gxXwCK2Qrkp4gOsLkpaIKN6MOn9GWUONZFgdsVL4hw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4abg8naqnu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 11 Nov 2025 03:16:49 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 11 Nov 2025 03:16:57 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 11 Nov 2025 03:16:57 -0800
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 0EC393F705F;
 Tue, 11 Nov 2025 03:16:44 -0800 (PST)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Nithinsen Kaithakadan
 <nkaithakadan@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Rakesh Kudurumalla <rkudurumalla@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH] crypto/cnxk: add CPT CQ support for cn20k
Date: Tue, 11 Nov 2025 16:46:43 +0530
Message-ID: <20251111111643.2279586-1-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDA4OCBTYWx0ZWRfX/Kta0I6ZUqFL
 Atr34iUQ4phMcxCN0ssCrreAoGHY+4THs6AgiEdVdBhNZbx0KLVP4I5YMRk6ccYHoh8gAArTwu7
 S4/cJ5WaxVYx4ixAnSMOyiJKoyzX8u8DZexsbkIWwWECaLIzQQIQ6ikN3B9GZC3G8LxSQnLTlm/
 AyeN6AKSzivul59aO7eNbLNq7fDO854t6jvVd6PXvRuzJo/3qPqoft2GEcIUFtzpKvPl5R4i0TQ
 HEQ+pdZ1JuM7OIZkHDX5ww/CAjDNHgr23jhFMehQA2rCZkoIheYfP0G9Col0/UP2zXkPMyOj6wQ
 58+vHdQ15wdxva1NNpPrX6/N7HIj3IyamHO7FulYt1qUtTuXHsUN3qmsywuU59si98Nzi8rL93w
 h1eTPhFLJSbRW1GRFj9AAipueIXWyQ==
X-Authority-Analysis: v=2.4 cv=eKEeTXp1 c=1 sm=1 tr=0 ts=69131b21 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=NOewblBfP-ooOcYVEFUA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: ZIcoYvZXv_fBDMAh2ceel592s3Mj7P7Z
X-Proofpoint-ORIG-GUID: ZIcoYvZXv_fBDMAh2ceel592s3Mj7P7Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
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

Adding CPT CQ support for cn20k.

Signed-off-by: Tejasree Kondoj <ktejasree@marvell.com>
---
 drivers/common/cnxk/roc_cpt.c             |  3 +-
 drivers/common/cnxk/roc_cpt.h             |  2 +
 drivers/crypto/cnxk/cn20k_cryptodev_ops.c |  5 +-
 drivers/crypto/cnxk/cnxk_cryptodev_ops.c  | 83 ++++++++++++++++-------
 drivers/crypto/cnxk/cnxk_cryptodev_ops.h  |  5 +-
 5 files changed, 67 insertions(+), 31 deletions(-)

diff --git a/drivers/common/cnxk/roc_cpt.c b/drivers/common/cnxk/roc_cpt.c
index 4e610109b4..83e0c9896b 100644
--- a/drivers/common/cnxk/roc_cpt.c
+++ b/drivers/common/cnxk/roc_cpt.c
@@ -24,7 +24,6 @@
 #define CPT_LF_MAX_NB_DESC	128000
 #define CPT_LF_DEFAULT_NB_DESC	1024
 #define CPT_LF_FC_MIN_THRESHOLD 32
-#define CQ_ENTRY_SIZE_UNIT	32
 
 static struct cpt_int_cb {
 	roc_cpt_int_misc_cb_t cb;
@@ -704,7 +703,7 @@ cpt_lf_cq_init(struct roc_cpt_lf *lf)
 	roc_cpt_cq_disable(lf);
 
 	/* Set command queue base address */
-	len = PLT_ALIGN(lf->cq_size * (CQ_ENTRY_SIZE_UNIT << lf->cq_entry_size), ROC_ALIGN);
+	len = PLT_ALIGN(lf->cq_size * (ROC_CPT_CQ_ENTRY_SIZE_UNIT << lf->cq_entry_size), ROC_ALIGN);
 	lf->cq_vaddr = plt_zmalloc(len, ROC_ALIGN);
 	if (lf->cq_vaddr == NULL)
 		return -ENOMEM;
diff --git a/drivers/common/cnxk/roc_cpt.h b/drivers/common/cnxk/roc_cpt.h
index 41a681e2a5..67956758be 100644
--- a/drivers/common/cnxk/roc_cpt.h
+++ b/drivers/common/cnxk/roc_cpt.h
@@ -133,6 +133,8 @@
 #define ROC_CPTR_CACHE_LINE_SZ 256
 #define ROC_CPTR_ALIGN	       ROC_CPTR_CACHE_LINE_SZ
 
+#define ROC_CPT_CQ_ENTRY_SIZE_UNIT 32
+
 enum {
 	ROC_CPT_REVISION_ID_83XX = 0,
 	ROC_CPT_REVISION_ID_96XX_B0 = 1,
diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
index d56f6b9d63..18100ff1f8 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
@@ -261,8 +261,9 @@ cn20k_cpt_fill_inst(struct cnxk_cpt_qp *qp, struct rte_crypto_op *ops[], struct
 	}
 
 	inst[0].res_addr = (uint64_t)&infl_req->res;
-	rte_atomic_store_explicit((RTE_ATOMIC(uint64_t) *)(&infl_req->res.u64[0]),
-				res.u64[0], rte_memory_order_relaxed);
+	inst[0].cq_ena = 1;
+	rte_atomic_store_explicit((RTE_ATOMIC(uint64_t) *)(&infl_req->res.u64[0]), res.u64[0],
+				  rte_memory_order_relaxed);
 	infl_req->cop = op;
 
 	inst[0].w7.u64 = w7;
diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
index 7dc4c684cc..370f311dd3 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
@@ -199,14 +199,19 @@ cnxk_cpt_dev_start(struct rte_cryptodev *dev)
 	struct cnxk_cpt_vf *vf = dev->data->dev_private;
 	struct roc_cpt *roc_cpt = &vf->cpt;
 	uint16_t nb_lf = roc_cpt->nb_lf;
+	struct roc_cpt_lf *lf;
 	uint16_t qp_id;
 
 	for (qp_id = 0; qp_id < nb_lf; qp_id++) {
+		lf = vf->cpt.lf[qp_id];
+
 		/* Application may not setup all queue pair */
-		if (roc_cpt->lf[qp_id] == NULL)
+		if (lf == NULL)
 			continue;
 
-		roc_cpt_iq_enable(roc_cpt->lf[qp_id]);
+		roc_cpt_iq_enable(lf);
+		if (lf->cpt_cq_ena)
+			roc_cpt_cq_enable(lf);
 	}
 
 	return 0;
@@ -218,13 +223,17 @@ cnxk_cpt_dev_stop(struct rte_cryptodev *dev)
 	struct cnxk_cpt_vf *vf = dev->data->dev_private;
 	struct roc_cpt *roc_cpt = &vf->cpt;
 	uint16_t nb_lf = roc_cpt->nb_lf;
+	struct roc_cpt_lf *lf;
 	uint16_t qp_id;
 
 	for (qp_id = 0; qp_id < nb_lf; qp_id++) {
-		if (roc_cpt->lf[qp_id] == NULL)
+		lf = vf->cpt.lf[qp_id];
+		if (lf == NULL)
 			continue;
 
 		roc_cpt_iq_disable(roc_cpt->lf[qp_id]);
+		if (lf->cpt_cq_ena)
+			roc_cpt_cq_disable(lf);
 	}
 }
 
@@ -347,7 +356,7 @@ static struct cnxk_cpt_qp *
 cnxk_cpt_qp_create(const struct rte_cryptodev *dev, uint16_t qp_id,
 		   uint32_t iq_len)
 {
-	const struct rte_memzone *pq_mem;
+	const struct rte_memzone *pq_mem = NULL;
 	char name[RTE_MEMZONE_NAMESIZE];
 	struct cnxk_cpt_qp *qp;
 	uint32_t len;
@@ -363,23 +372,25 @@ cnxk_cpt_qp_create(const struct rte_cryptodev *dev, uint16_t qp_id,
 	}
 
 	/* For pending queue */
-	len = iq_len * sizeof(struct cpt_inflight_req);
+	if (!roc_model_is_cn20k()) {
+		len = iq_len * sizeof(struct cpt_inflight_req);
 
-	qp_memzone_name_get(name, RTE_MEMZONE_NAMESIZE, dev->data->dev_id,
-			    qp_id);
+		qp_memzone_name_get(name, RTE_MEMZONE_NAMESIZE, dev->data->dev_id, qp_id);
 
-	pq_mem = rte_memzone_reserve_aligned(name, len, rte_socket_id(),
-					     RTE_MEMZONE_SIZE_HINT_ONLY |
-						     RTE_MEMZONE_256MB,
-					     RTE_CACHE_LINE_SIZE);
-	if (pq_mem == NULL) {
-		plt_err("Could not allocate reserved memzone");
-		goto qp_free;
-	}
+		pq_mem = rte_memzone_reserve_aligned(name, len, rte_socket_id(),
+						     RTE_MEMZONE_SIZE_HINT_ONLY | RTE_MEMZONE_256MB,
+						     RTE_CACHE_LINE_SIZE);
+		if (pq_mem == NULL) {
+			plt_err("Could not allocate reserved memzone");
+			goto qp_free;
+		}
 
-	va = pq_mem->addr;
+		va = pq_mem->addr;
 
-	memset(va, 0, len);
+		memset(va, 0, len);
+
+		qp->pend_q.req_queue = pq_mem->addr;
+	}
 
 	ret = cnxk_cpt_metabuf_mempool_create(dev, qp, qp_id, iq_len);
 	if (ret) {
@@ -388,14 +399,14 @@ cnxk_cpt_qp_create(const struct rte_cryptodev *dev, uint16_t qp_id,
 	}
 
 	/* Initialize pending queue */
-	qp->pend_q.req_queue = pq_mem->addr;
 	qp->pend_q.head = 0;
 	qp->pend_q.tail = 0;
 
 	return qp;
 
 pq_mem_free:
-	rte_memzone_free(pq_mem);
+	if (!roc_model_is_cn20k())
+		rte_memzone_free(pq_mem);
 qp_free:
 	rte_free(qp);
 	return NULL;
@@ -410,14 +421,15 @@ cnxk_cpt_qp_destroy(const struct rte_cryptodev *dev, struct cnxk_cpt_qp *qp)
 
 	cnxk_cpt_metabuf_mempool_destroy(qp);
 
-	qp_memzone_name_get(name, RTE_MEMZONE_NAMESIZE, dev->data->dev_id,
-			    qp->lf.lf_id);
+	if (!roc_model_is_cn20k()) {
+		qp_memzone_name_get(name, RTE_MEMZONE_NAMESIZE, dev->data->dev_id, qp->lf.lf_id);
 
-	pq_mem = rte_memzone_lookup(name);
+		pq_mem = rte_memzone_lookup(name);
 
-	ret = rte_memzone_free(pq_mem);
-	if (ret)
-		return ret;
+		ret = rte_memzone_free(pq_mem);
+		if (ret)
+			return ret;
+	}
 
 	rte_free(qp);
 
@@ -487,6 +499,13 @@ cnxk_cpt_queue_pair_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 
 	qp->lf.lf_id = qp_id;
 	qp->lf.nb_desc = nb_desc;
+	if (roc_model_is_cn20k()) {
+		qp->lf.cpt_cq_ena = true;
+		qp->lf.dq_ack_ena = false;
+		/* CQ entry size is 128B(32 << 2) */
+		qp->lf.cq_entry_size = 2;
+		qp->lf.cq_size = nb_desc;
+	}
 
 	ret = roc_cpt_lf_init(roc_cpt, &qp->lf);
 	if (ret < 0) {
@@ -497,6 +516,17 @@ cnxk_cpt_queue_pair_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 
 	qp->pend_q.pq_mask = qp->lf.nb_desc - 1;
 
+	if (roc_model_is_cn20k()) {
+		if (qp->lf.cq_vaddr == NULL) {
+			plt_err("Could not initialize completion queue");
+			ret = -EINVAL;
+			goto exit;
+		}
+
+		qp->pend_q.req_queue = PLT_PTR_ADD(
+			qp->lf.cq_vaddr, ROC_CPT_CQ_ENTRY_SIZE_UNIT << qp->lf.cq_entry_size);
+	}
+
 	roc_cpt->lf[qp_id] = &qp->lf;
 
 	ret = roc_cpt_lmtline_init(roc_cpt, &qp->lmtline, qp_id, true);
@@ -544,6 +574,9 @@ cnxk_cpt_queue_pair_reset(struct rte_cryptodev *dev, uint16_t qp_id,
 		roc_cpt_lf_reset(lf);
 		roc_cpt_iq_enable(lf);
 
+		if (lf->cpt_cq_ena)
+			roc_cpt_cq_enable(lf);
+
 		return 0;
 	}
 
diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_ops.h b/drivers/crypto/cnxk/cnxk_cryptodev_ops.h
index 03af1029ce..32fc7a26fc 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_ops.h
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_ops.h
@@ -54,13 +54,15 @@ struct cpt_qp_meta_info {
 
 struct __rte_aligned(ROC_ALIGN) cpt_inflight_req {
 	union cpt_res_s res;
+	uint8_t rsvd[16];
+	uint8_t meta[META_LEN];
 	union {
 		void *opaque;
 		struct rte_crypto_op *cop;
 		struct rte_event_vector *vec;
 	};
+	void *qp;
 	void *mdata;
-	uint8_t meta[META_LEN];
 	uint8_t op_flags;
 #ifdef CPT_INST_DEBUG_ENABLE
 	uint8_t scatter_sz;
@@ -69,7 +71,6 @@ struct __rte_aligned(ROC_ALIGN) cpt_inflight_req {
 	uint8_t *dptr;
 	uint8_t *rptr;
 #endif
-	void *qp;
 };
 
 PLT_STATIC_ASSERT(sizeof(struct cpt_inflight_req) == ROC_CACHE_LINE_SZ);
-- 
2.25.1

