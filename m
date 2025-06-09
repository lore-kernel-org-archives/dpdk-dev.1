Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DC9C5B552
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 10:41:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A54C40E78;
	Mon,  9 Jun 2025 12:41:02 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 3E65540E2E
 for <dev@dpdk.org>; Mon,  9 Jun 2025 12:41:00 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5597oNLH022070
 for <dev@dpdk.org>; Mon, 9 Jun 2025 03:40:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=3
 LEy7bwmngiJerKUeQIWDn3/JCVY333nMKmgBVqDJOg=; b=HIr74w3j3j96Csj1q
 lKQTLrWjgpv3ioiYPGB7nwlXj9U8tL21zP94wPuQ8U+JEL87uvsYC+un55Rdno7D
 itZcfmRe42Q3W8nO1kT3HY4aGIpyz6zNtL1C2rqyOLhY+5M4Vfrkv3tlBCjQ7VEw
 jYVaWgQb99BOheEJrQvuFzEDAWt69GlBf+98N9Y1TjcgBC2DAB34QQA2tz7GJWgF
 brl5YPBhZu6x0DkUaEYgC94Wgo4FOAIIOPsEh6kFxrnNCShuWYvQIHmAG/cJZNxU
 cJmirpETPGA03YjkG7iNtVnviDRXag6JY+7zA+QqAA3Ljw1OLF9EfRDDpsLA6afu
 GDRZg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 475ujxr99e-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 09 Jun 2025 03:40:59 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 9 Jun 2025 03:40:56 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 9 Jun 2025 03:40:56 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 923ED3F708C;
 Mon,  9 Jun 2025 03:40:54 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Rupesh Chiluka <rchiluka@marvell.com>, Anoob Joseph <anoobj@marvell.com>, 
 Nithinsen Kaithakadan <nkaithakadan@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 5/7] crypto/cnxk: support asymmetric sessionless mode
Date: Mon, 9 Jun 2025 16:10:36 +0530
Message-ID: <20250609104038.3102767-6-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250609104038.3102767-1-ktejasree@marvell.com>
References: <20250609104038.3102767-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: p2RBVvmO3os-IT6F49BbQ4EH3M_2nePZ
X-Proofpoint-ORIG-GUID: p2RBVvmO3os-IT6F49BbQ4EH3M_2nePZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDA4MSBTYWx0ZWRfX2PUo89AtHxDZ
 buWeg2Id+oaymcgZX2Ks8N34l+A06LByKq3wl1AhPsLLHQvOpc26eQUUVhfN8cGoEhforYvdrZ7
 06HXmMJsdECoDZqNJ4YK7XLEoObmFp6Orkm2vtv1wyVe1dZ4WzJuR7un0wQu3v5g7dILrpoZtEl
 Bu1J7cAr8KNwYVU75UeHXZrdqfktSSEfsMWS6Xcw47cUsy+8QoJT2QCb6HSJsNbJej3dutP0+14
 KBkzmsQXrU3ZrJSdHpHqHywzpZmfx1wA1CBlRwzlHM63vJaHQ99TjLOM9mcc8zmYXDpeJuU2PBG
 /FCgd2ESHQ+vJ59oH4Izl5l16m72DV29YZE9crQWZVE/SgYQq9VpHwrybiQHw/SKhV2R1eZTLat
 pVlOvR9Bba1HmUnkO1W+Ob5qyF5jUJ3m6UfQRkVNYvd5D6tyO5ItHmm0Hy6CPJX55Bolvz9g
X-Authority-Analysis: v=2.4 cv=LuKSymdc c=1 sm=1 tr=0 ts=6846ba3b cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=Kk9yNb_DVH9civN7RtYA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_04,2025-06-05_01,2025-03-28_01
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

From: Rupesh Chiluka <rchiluka@marvell.com>

Add support for sessionless asymmetric operations
in cnxk CPT PMD.

Signed-off-by: Rupesh Chiluka <rchiluka@marvell.com>
Signed-off-by: Tejasree Kondoj <ktejasree@marvell.com>
Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
---
 doc/guides/cryptodevs/features/cn10k.ini  |  1 +
 doc/guides/cryptodevs/features/cn9k.ini   |  1 +
 doc/guides/rel_notes/release_25_07.rst    |  1 +
 drivers/crypto/cnxk/cn10k_cryptodev_ops.c | 91 +++++++++++++++++++++--
 drivers/crypto/cnxk/cn9k_cryptodev_ops.c  | 77 ++++++++++++++++++-
 drivers/crypto/cnxk/cnxk_cryptodev.c      |  3 +-
 drivers/crypto/cnxk/cnxk_cryptodev_ops.c  |  5 +-
 7 files changed, 168 insertions(+), 11 deletions(-)

diff --git a/doc/guides/cryptodevs/features/cn10k.ini b/doc/guides/cryptodevs/features/cn10k.ini
index bfd35489a0..31e8061df9 100644
--- a/doc/guides/cryptodevs/features/cn10k.ini
+++ b/doc/guides/cryptodevs/features/cn10k.ini
@@ -17,6 +17,7 @@ Symmetric sessionless  = Y
 RSA PRIV OP KEY EXP    = Y
 RSA PRIV OP KEY QT     = Y
 Digest encrypted       = Y
+Asymmetric sessionless = Y
 Sym raw data path API  = Y
 Inner checksum         = Y
 Rx inject              = Y
diff --git a/doc/guides/cryptodevs/features/cn9k.ini b/doc/guides/cryptodevs/features/cn9k.ini
index d70771d9bd..1f0f48bfce 100644
--- a/doc/guides/cryptodevs/features/cn9k.ini
+++ b/doc/guides/cryptodevs/features/cn9k.ini
@@ -17,6 +17,7 @@ Symmetric sessionless  = Y
 RSA PRIV OP KEY EXP    = Y
 RSA PRIV OP KEY QT     = Y
 Digest encrypted       = Y
+Asymmetric sessionless = Y
 
 ;
 ; Supported crypto algorithms of 'cn9k' crypto driver.
diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
index 9673bb3c62..8f02fe8023 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -95,6 +95,7 @@ New Features
 * **Updated Marvell cnxk crypto driver.**
 
   * Added support for CN20K SoC in cnxk CPT driver.
+  * Added support for sessionless asymmetric operations.
 
 * **Added eventdev vector adapter.**
 
diff --git a/drivers/crypto/cnxk/cn10k_cryptodev_ops.c b/drivers/crypto/cnxk/cn10k_cryptodev_ops.c
index 6777b0b377..31ec88c7d6 100644
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
@@ -418,8 +479,23 @@ cn10k_ca_meta_info_extract(struct rte_crypto_op *op, struct cnxk_cpt_qp **qp, ui
 			priv = (struct cnxk_ae_sess *)op->asym->session;
 			*qp = priv->qp;
 			*w2 = priv->cpt_inst_w2;
-		} else
-			return -EINVAL;
+		} else {
+			union rte_event_crypto_metadata *ec_mdata;
+			struct rte_event *rsp_info;
+			uint8_t cdev_id;
+			uint16_t qp_id;
+
+			if (unlikely(op->private_data_offset == 0))
+				return -EINVAL;
+			ec_mdata = (union rte_event_crypto_metadata *)((uint8_t *)op +
+								       op->private_data_offset);
+			rsp_info = &ec_mdata->response_info;
+			cdev_id = ec_mdata->request_info.cdev_id;
+			qp_id = ec_mdata->request_info.queue_pair_id;
+			*qp = rte_cryptodevs[cdev_id].data->queue_pairs[qp_id];
+			*w2 = CNXK_CPT_INST_W2((RTE_EVENT_TYPE_CRYPTODEV << 28) | rsp_info->flow_id,
+					       rsp_info->sched_type, rsp_info->queue_id, 0);
+		}
 	} else
 		return -EINVAL;
 
@@ -1132,6 +1208,11 @@ cn10k_cpt_dequeue_post_process(struct cnxk_cpt_qp *qp, struct rte_crypto_op *cop
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
index 69e15a862f..c94e9e0f92 100644
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
@@ -333,8 +383,24 @@ cn9k_ca_meta_info_extract(struct rte_crypto_op *op,
 			priv = (struct cnxk_ae_sess *)op->asym->session;
 			*qp = priv->qp;
 			inst->w2.u64 = priv->cpt_inst_w2;
-		} else
-			return -EINVAL;
+		} else {
+			union rte_event_crypto_metadata *ec_mdata;
+			struct rte_event *rsp_info;
+			uint8_t cdev_id;
+			uint16_t qp_id;
+
+			if (unlikely(op->private_data_offset == 0))
+				return -EINVAL;
+			ec_mdata = (union rte_event_crypto_metadata *)((uint8_t *)op +
+								       op->private_data_offset);
+			rsp_info = &ec_mdata->response_info;
+			cdev_id = ec_mdata->request_info.cdev_id;
+			qp_id = ec_mdata->request_info.queue_pair_id;
+			*qp = rte_cryptodevs[cdev_id].data->queue_pairs[qp_id];
+			inst->w2.u64 = CNXK_CPT_INST_W2(
+				(RTE_EVENT_TYPE_CRYPTODEV << 28) | rsp_info->flow_id,
+				rsp_info->sched_type, rsp_info->queue_id, 0);
+		}
 	} else
 		return -EINVAL;
 
@@ -591,6 +657,11 @@ cn9k_cpt_dequeue_post_process(struct cnxk_cpt_qp *qp, struct rte_crypto_op *cop,
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

