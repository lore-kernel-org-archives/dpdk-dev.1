Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2875BC5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 17:02:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91DA440DCA;
	Mon, 26 May 2025 19:00:27 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 2E97F40A7D
 for <dev@dpdk.org>; Mon, 26 May 2025 19:00:26 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QEwlVh006991
 for <dev@dpdk.org>; Mon, 26 May 2025 10:00:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=H
 PZ7sOzYDMPkRPz+e0g1kz0MR8qsA+uGOiYcUQnPUvA=; b=H2Wq97bBKdYz7On5g
 ZkkEQwnjM2SbyUcxVxKowbUHHxj+qBsKh/QO+oaORowa02/RHB/AydNMKYsLiKns
 ddRfVnMevYM7YHlxwG/lzsH0WRJ2SB9C/pwk3S5GVmmG5bgcWzr9Z+G+EDZ4Htsl
 ArAd50M6Iyv0BRhz3/+85ivH70azG7vyrqqaUhMz5pBxP9dlSMj51NMnEMBz/mSu
 f+3Aoqd5H1NvPy4LfXU0H/su9tP4sRuoGqbel4hHuzDGAP5ffGaT4ljY1wSJrElw
 p8vTS5YVHMwnf2KSip+Ry+DUEizBGWlGUx9xZ+ucRnjh9DG80XWFfquDxnS/A/tC
 7jhWg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46vthfr724-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 26 May 2025 10:00:25 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 26 May 2025 10:00:23 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 26 May 2025 10:00:23 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 05FF03F7064;
 Mon, 26 May 2025 10:00:20 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Aakash Sasidharan <asasidharan@marvell.com>,
 "Nithinsen Kaithakadan" <nkaithakadan@marvell.com>, Rupesh Chiluka
 <rchiluka@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 37/40] crypto/cnxk: add support for sessionless asym
Date: Mon, 26 May 2025 22:28:16 +0530
Message-ID: <20250526165819.2197892-38-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250526165819.2197892-1-ktejasree@marvell.com>
References: <20250526165819.2197892-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDE0NCBTYWx0ZWRfX5m1bz88Pmu06
 sqaKjSDbG9Z+zZTwhijuajUx+5QvWxpi88Xz0EYjXDuqYfTIZQMn49G+Ujws3T5jcNJVhncE/Uq
 tLekdK4vq10XeHcIDV8CpD0G5gio56y4Bv1ExBl77t82c8pkQ5Zr1FOCiyzX1ZnJTHnXdAOCTZj
 0hl20Ne+jrt9Mv1FjBYqVZ9l7Dj4QbtM1qR1gIBMM8VseFYvh0qafqMoI7cUv7BxAyKcCBDpH0P
 gIyZf5YhtlmQznRSdRnSG4OAkzllGz9tYwHqQighlYAKtnGhkrdkSuWYfv9w/RB8lqGJe+fvJk/
 YwP9Vmx9qy12uw7/ZqXaN5W7fiDWf3PDgU+ZBQMjLRsjPY9JFp0GWlrvUZZYjjfS38bCieqJWzW
 FUBapqpd/nsDTk+piJo3BduRuhs7hIVBUlgL6ZY0u4MFhLgzt0u1KMGJ5MXNyh8da+nPtkli
X-Proofpoint-ORIG-GUID: wWvSf6RnnwXnwGLvAyalUMdcfYlBfpjd
X-Proofpoint-GUID: wWvSf6RnnwXnwGLvAyalUMdcfYlBfpjd
X-Authority-Analysis: v=2.4 cv=FfA3xI+6 c=1 sm=1 tr=0 ts=68349e29 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=V96RGjsnX57IfUnXaCcA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-26_08,2025-05-26_02,2025-03-28_01
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

From: Vidya Sagar Velumuri <vvelumuri@marvell.com>

Add support for sessionless asymmetric operations for cnxk

Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
---
 drivers/crypto/cnxk/cn10k_cryptodev_ops.c | 72 ++++++++++++++++++++++-
 drivers/crypto/cnxk/cn9k_cryptodev_ops.c  | 57 +++++++++++++++++-
 drivers/crypto/cnxk/cnxk_cryptodev.c      |  3 +-
 drivers/crypto/cnxk/cnxk_cryptodev_ops.c  |  5 +-
 4 files changed, 130 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/cnxk/cn10k_cryptodev_ops.c b/drivers/crypto/cnxk/cn10k_cryptodev_ops.c
index 813a2deb66..4f7b34cc21 100644
--- a/drivers/crypto/cnxk/cn10k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn10k_cryptodev_ops.c
@@ -76,6 +76,55 @@ cn10k_cpt_sym_temp_sess_create(struct cnxk_cpt_qp *qp, struct rte_crypto_op *op)
 	return NULL;
 }
 
+static inline struct cnxk_ae_sess *
+cn10k_cpt_asym_temp_sess_create(struct cnxk_cpt_qp *qp, struct rte_crypto_op *op)
+{
+	struct rte_crypto_asym_op *asym_op = op->asym;
+	struct roc_cpt *roc_cpt = qp->lf.roc_cpt;
+	struct rte_cryptodev_asym_session *sess;
+	struct cnxk_ae_sess *priv;
+	struct cnxk_cpt_vf *vf;
+	union cpt_inst_w7 w7;
+	struct hw_ctx_s *hwc;
+
+	/* Create temporary session */
+	if (rte_mempool_get(qp->sess_mp, (void **)&sess) < 0)
+		return NULL;
+
+	priv = (struct cnxk_ae_sess *)sess;
+	if (cnxk_ae_fill_session_parameters(priv, asym_op->xform))
+		goto sess_put;
+
+	priv->lf = &qp->lf;
+
+	if (roc_errata_cpt_hang_on_mixed_ctx_val()) {
+		hwc = &priv->hw_ctx;
+		hwc->w0.s.aop_valid = 1;
+		hwc->w0.s.ctx_hdr_size = 0;
+		hwc->w0.s.ctx_size = 1;
+		hwc->w0.s.ctx_push_size = 1;
+
+		w7.s.ctx_val = 1;
+		w7.s.cptr = (uint64_t)hwc;
+	}
+
+	w7.u64 = 0;
+	w7.s.egrp = roc_cpt->eng_grp[CPT_ENG_TYPE_AE];
+
+	vf = container_of(roc_cpt, struct cnxk_cpt_vf, cpt);
+	priv->cpt_inst_w7 = w7.u64;
+	priv->cnxk_fpm_iova = vf->cnxk_fpm_iova;
+	priv->ec_grp = vf->ec_grp;
+
+	asym_op->session = sess;
+
+	return priv;
+
+sess_put:
+	rte_mempool_put(qp->sess_mp, sess);
+	return NULL;
+}
+
 static __rte_always_inline int __rte_hot
 cpt_sec_ipsec_inst_fill(struct cnxk_cpt_qp *qp, struct rte_crypto_op *op,
 			struct cn10k_sec_session *sess, struct cpt_inst_s *inst,
@@ -177,7 +226,6 @@ cn10k_cpt_fill_inst(struct cnxk_cpt_qp *qp, struct rte_crypto_op *ops[], struct
 			w7 = sess->cpt_inst_w7;
 		}
 	} else if (op->type == RTE_CRYPTO_OP_TYPE_ASYMMETRIC) {
-
 		if (op->sess_type == RTE_CRYPTO_OP_WITH_SESSION) {
 			asym_op = op->asym;
 			ae_sess = (struct cnxk_ae_sess *)asym_op->session;
@@ -186,9 +234,22 @@ cn10k_cpt_fill_inst(struct cnxk_cpt_qp *qp, struct rte_crypto_op *ops[], struct
 				return 0;
 			w7 = ae_sess->cpt_inst_w7;
 		} else {
-			plt_dp_err("Not supported Asym op without session");
-			return 0;
+			ae_sess = cn10k_cpt_asym_temp_sess_create(qp, op);
+			if (unlikely(ae_sess == NULL)) {
+				plt_dp_err("Could not create temp session");
+				return 0;
+			}
+
+			ret = cnxk_ae_enqueue(qp, op, infl_req, &inst[0], ae_sess);
+			if (unlikely(ret)) {
+				cnxk_ae_session_clear(NULL,
+						      (struct rte_cryptodev_asym_session *)ae_sess);
+				rte_mempool_put(qp->sess_mp, ae_sess);
+				return 0;
+			}
+			w7 = ae_sess->cpt_inst_w7;
 		}
+
 	} else {
 		plt_dp_err("Unsupported op type");
 		return 0;
@@ -1145,6 +1206,11 @@ cn10k_cpt_dequeue_post_process(struct cnxk_cpt_qp *qp, struct rte_crypto_op *cop
 			rte_mempool_put(qp->sess_mp, cop->sym->session);
 			cop->sym->session = NULL;
 		}
+		if (cop->type == RTE_CRYPTO_OP_TYPE_ASYMMETRIC) {
+			cnxk_ae_session_clear(NULL, cop->asym->session);
+			rte_mempool_put(qp->sess_mp, cop->asym->session);
+			cop->asym->session = NULL;
+		}
 	}
 }
 
diff --git a/drivers/crypto/cnxk/cn9k_cryptodev_ops.c b/drivers/crypto/cnxk/cn9k_cryptodev_ops.c
index fa22b5ce44..570051518c 100644
--- a/drivers/crypto/cnxk/cn9k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn9k_cryptodev_ops.c
@@ -67,6 +67,43 @@ cn9k_cpt_sym_temp_sess_create(struct cnxk_cpt_qp *qp, struct rte_crypto_op *op)
 	return NULL;
 }
 
+static inline struct cnxk_ae_sess *
+cn9k_cpt_asym_temp_sess_create(struct cnxk_cpt_qp *qp, struct rte_crypto_op *op)
+{
+	struct rte_crypto_asym_op *asym_op = op->asym;
+	struct roc_cpt *roc_cpt = qp->lf.roc_cpt;
+	struct rte_cryptodev_asym_session *sess;
+	struct cnxk_ae_sess *priv;
+	struct cnxk_cpt_vf *vf;
+	union cpt_inst_w7 w7;
+
+	/* Create temporary session */
+	if (rte_mempool_get(qp->sess_mp, (void **)&sess) < 0)
+		return NULL;
+
+	priv = (struct cnxk_ae_sess *)sess;
+	if (cnxk_ae_fill_session_parameters(priv, asym_op->xform))
+		goto sess_put;
+
+	priv->lf = &qp->lf;
+
+	w7.u64 = 0;
+	w7.s.egrp = roc_cpt->eng_grp[CPT_ENG_TYPE_AE];
+
+	vf = container_of(roc_cpt, struct cnxk_cpt_vf, cpt);
+	priv->cpt_inst_w7 = w7.u64;
+	priv->cnxk_fpm_iova = vf->cnxk_fpm_iova;
+	priv->ec_grp = vf->ec_grp;
+
+	asym_op->session = sess;
+
+	return priv;
+
+sess_put:
+	rte_mempool_put(qp->sess_mp, sess);
+	return NULL;
+}
+
 static inline int
 cn9k_cpt_inst_prep(struct cnxk_cpt_qp *qp, struct rte_crypto_op *op,
 		   struct cpt_inflight_req *infl_req, struct cpt_inst_s *inst)
@@ -106,7 +143,20 @@ cn9k_cpt_inst_prep(struct cnxk_cpt_qp *qp, struct rte_crypto_op *op,
 			ret = cnxk_ae_enqueue(qp, op, infl_req, inst, sess);
 			inst->w7.u64 = sess->cpt_inst_w7;
 		} else {
-			ret = -EINVAL;
+			sess = cn9k_cpt_asym_temp_sess_create(qp, op);
+			if (unlikely(sess == NULL)) {
+				plt_dp_err("Could not create temp session");
+				return 0;
+			}
+
+			ret = cnxk_ae_enqueue(qp, op, infl_req, inst, sess);
+			if (unlikely(ret)) {
+				cnxk_ae_session_clear(NULL,
+						      (struct rte_cryptodev_asym_session *)sess);
+				rte_mempool_put(qp->sess_mp, sess);
+				return 0;
+			}
+			inst->w7.u64 = sess->cpt_inst_w7;
 		}
 	} else {
 		ret = -EINVAL;
@@ -607,6 +657,11 @@ cn9k_cpt_dequeue_post_process(struct cnxk_cpt_qp *qp, struct rte_crypto_op *cop,
 			rte_mempool_put(qp->sess_mp, cop->sym->session);
 			cop->sym->session = NULL;
 		}
+		if (cop->type == RTE_CRYPTO_OP_TYPE_ASYMMETRIC) {
+			cnxk_ae_session_clear(NULL, cop->asym->session);
+			rte_mempool_put(qp->sess_mp, cop->asym->session);
+			cop->asym->session = NULL;
+		}
 	}
 }
 
diff --git a/drivers/crypto/cnxk/cnxk_cryptodev.c b/drivers/crypto/cnxk/cnxk_cryptodev.c
index 96b5121097..5828a502e4 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev.c
+++ b/drivers/crypto/cnxk/cnxk_cryptodev.c
@@ -19,7 +19,8 @@ cnxk_cpt_default_ff_get(void)
 		      RTE_CRYPTODEV_FF_SYM_OPERATION_CHAINING | RTE_CRYPTODEV_FF_IN_PLACE_SGL |
 		      RTE_CRYPTODEV_FF_OOP_LB_IN_LB_OUT | RTE_CRYPTODEV_FF_OOP_SGL_IN_LB_OUT |
 		      RTE_CRYPTODEV_FF_OOP_SGL_IN_SGL_OUT | RTE_CRYPTODEV_FF_SYM_SESSIONLESS |
-		      RTE_CRYPTODEV_FF_DIGEST_ENCRYPTED | RTE_CRYPTODEV_FF_SECURITY;
+		      RTE_CRYPTODEV_FF_DIGEST_ENCRYPTED | RTE_CRYPTODEV_FF_SECURITY |
+		      RTE_CRYPTODEV_FF_ASYM_SESSIONLESS;
 
 	if (roc_model_is_cn10k() || roc_model_is_cn20k())
 		ff |= RTE_CRYPTODEV_FF_SECURITY_INNER_CSUM | RTE_CRYPTODEV_FF_SYM_RAW_DP;
diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
index e5ca082e10..261e14b418 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
@@ -866,7 +866,8 @@ cnxk_ae_session_size_get(struct rte_cryptodev *dev __rte_unused)
 }
 
 void
-cnxk_ae_session_clear(struct rte_cryptodev *dev, struct rte_cryptodev_asym_session *sess)
+cnxk_ae_session_clear(struct rte_cryptodev *dev __rte_unused,
+		      struct rte_cryptodev_asym_session *sess)
 {
 	struct cnxk_ae_sess *priv = (struct cnxk_ae_sess *)sess;
 
@@ -878,7 +879,7 @@ cnxk_ae_session_clear(struct rte_cryptodev *dev, struct rte_cryptodev_asym_sessi
 	cnxk_ae_free_session_parameters(priv);
 
 	/* Reset and free object back to pool */
-	memset(priv, 0, cnxk_ae_session_size_get(dev));
+	memset(priv, 0, sizeof(struct cnxk_ae_sess));
 }
 
 int
-- 
2.25.1

