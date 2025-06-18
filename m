Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAF9C71157
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 08:37:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B865427E7;
	Wed, 18 Jun 2025 10:37:03 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 64593427E5
 for <dev@dpdk.org>; Wed, 18 Jun 2025 10:37:02 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55I7qn1S023246
 for <dev@dpdk.org>; Wed, 18 Jun 2025 01:37:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=c
 EshsJB+N/knKAiHlgTGX3hjTuWO5sPKjS3HBX6dV6I=; b=Wa1YHSvlCAgq4zC/6
 MbgjLqMdUiexADTa6CHxmmsxFyyXPHsN+aId0+yjO8cEiDoI5l19zxtTIBFCCc6C
 NUH/uQruj0G5AjJ2FB5p96WirQszn5ucYfW7tf7M13fkV1BlQq6KnTNIdr1Koh9z
 0j3dbYnoGHIXbg/JP6fz0Z/+xxQL5hzDlSmGe7fMcTpgeXy6ZKpWDC4cnBCmEcJW
 gUI9n/pRCHWD6qFcfxHC4KODhY1vZaBAbZuMuylIeqI97Jltw7xZa+QF/U1vauQX
 dqjZa6UnH9ZQGOyeTeplLn+pQD0DcINet38MiZzheM1JTRv8Gh0Vt8/wEflVJWd9
 M3AKw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47bsf2r2h2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 18 Jun 2025 01:37:01 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 18 Jun 2025 01:37:00 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 18 Jun 2025 01:37:00 -0700
Received: from nkaithakadan-dkr.marvell.com (unknown [10.29.45.70])
 by maili.marvell.com (Postfix) with ESMTP id 326103F7043;
 Wed, 18 Jun 2025 01:36:57 -0700 (PDT)
From: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
To: <dev@dpdk.org>
CC: <adwivedi@marvell.com>, <anoobj@marvell.com>, <ktejasree@marvell.com>,
 <gakhil@marvell.com>, <pbhagavatula@marvell.com>
Subject: [PATCH v3 2/2] crypto/cnxk: add sessionless asym cn20k support
Date: Wed, 18 Jun 2025 08:36:50 +0000
Message-ID: <20250618083651.637234-3-nkaithakadan@marvell.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250618083651.637234-1-nkaithakadan@marvell.com>
References: <20250618083651.637234-1-nkaithakadan@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: rxdcT6Em_cUMMgE4B7vbLjrxRqwqLlyc
X-Proofpoint-GUID: rxdcT6Em_cUMMgE4B7vbLjrxRqwqLlyc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA3NCBTYWx0ZWRfXzvXNpOqGkQ5r
 2RP3NKHVM9rgj3SSoupCNSGHlLlksuyUumj5ZA3pVfmDsNTe63Vfk3IiFj+4s9EVCjZhEzrBO5b
 nifcvmz+OG3Yk8MicyyJ6dARG3q/zeCEcdLcrKuLoGN0FuDZlxSt3F84U7DURd6Wz46gy3fUqZ7
 PKh5jcfE7+tZ57amUlP5q4Cu4W6iCt3doZvrlg5iUl64Fv29uv1zZu2kLIA5+SbtZs8scOML7lG
 ty839wwfisQXm75mcbIKWG1Fm3adYpcVBYDV99Qtm30pz2jR6hZjHZPi77vK5bH5eKlPok5YJx+
 6vP6T55Og0pWgzG5/nyiLddNXRzc8VfKqkmyvf3/qUQ2mMBLY6froamfz30q7ix4vhYurBbCSl2
 m6n5Vd/ykSUbd0Ml8ozarbFhfqct9RI9s+qTqavdUeiL0Vt/f9/OBTkHETqyfqe/6vY4ZzTR
X-Authority-Analysis: v=2.4 cv=Yu4PR5YX c=1 sm=1 tr=0 ts=68527aad cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=b53FG8YMO_0E9cW673wA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_03,2025-06-18_02,2025-03-28_01
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

Add support for sessionless asymmetric operations for cn20k.

Signed-off-by: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
---
 doc/guides/cryptodevs/features/cn20k.ini  |  1 +
 drivers/crypto/cnxk/cn20k_cryptodev_ops.c | 91 +++++++++++++++++++++--
 2 files changed, 87 insertions(+), 5 deletions(-)

diff --git a/doc/guides/cryptodevs/features/cn20k.ini b/doc/guides/cryptodevs/features/cn20k.ini
index 76553d190e..ff00a8a107 100644
--- a/doc/guides/cryptodevs/features/cn20k.ini
+++ b/doc/guides/cryptodevs/features/cn20k.ini
@@ -17,6 +17,7 @@ Symmetric sessionless  = Y
 RSA PRIV OP KEY EXP    = Y
 RSA PRIV OP KEY QT     = Y
 Digest encrypted       = Y
+Asymmetric sessionless = Y
 Sym raw data path API  = Y
 Inner checksum         = Y
 Rx inject              = Y
diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
index f94ab3750c..6ef7c5bb22 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
@@ -79,6 +79,55 @@ cn20k_cpt_sym_temp_sess_create(struct cnxk_cpt_qp *qp, struct rte_crypto_op *op)
 	return NULL;
 }
 
+static inline struct cnxk_ae_sess *
+cn20k_cpt_asym_temp_sess_create(struct cnxk_cpt_qp *qp, struct rte_crypto_op *op)
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
 			struct cn20k_sec_session *sess, struct cpt_inst_s *inst,
@@ -178,7 +227,6 @@ cn20k_cpt_fill_inst(struct cnxk_cpt_qp *qp, struct rte_crypto_op *ops[], struct
 			w7 = sess->cpt_inst_w7;
 		}
 	} else if (op->type == RTE_CRYPTO_OP_TYPE_ASYMMETRIC) {
-
 		if (op->sess_type == RTE_CRYPTO_OP_WITH_SESSION) {
 			asym_op = op->asym;
 			ae_sess = (struct cnxk_ae_sess *)asym_op->session;
@@ -187,9 +235,22 @@ cn20k_cpt_fill_inst(struct cnxk_cpt_qp *qp, struct rte_crypto_op *ops[], struct
 				return 0;
 			w7 = ae_sess->cpt_inst_w7;
 		} else {
-			plt_dp_err("Not supported Asym op without session");
-			return 0;
+			ae_sess = cn20k_cpt_asym_temp_sess_create(qp, op);
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
@@ -395,8 +456,23 @@ cn20k_ca_meta_info_extract(struct rte_crypto_op *op, struct cnxk_cpt_qp **qp, ui
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
 
@@ -1083,6 +1159,11 @@ cn20k_cpt_dequeue_post_process(struct cnxk_cpt_qp *qp, struct rte_crypto_op *cop
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
 
-- 
2.48.1

