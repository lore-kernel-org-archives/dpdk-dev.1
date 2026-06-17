Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07569CD98E2
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 05:49:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C49640276;
	Wed, 17 Jun 2026 07:49:53 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id CF6124026A
 for <dev@dpdk.org>; Wed, 17 Jun 2026 07:49:50 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65H1mwit4174953 for <dev@dpdk.org>; Tue, 16 Jun 2026 22:49:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=qtCZWYQWPa7+MKsl9MAaGVu
 WB1C/au6VZxJ0c9+2BB0=; b=WuCM7wywmIPaxZc/IcEYjyZbghKQFf0QTL+r1Pu
 P8P0QYSYP6GdTnBlvoaPUe6jA9uXPHRh1iDOnVmsXrH+YfvR/g8JJUeWoQoUF8X1
 lch8sMgg0OnILYOrvUoYMJb9nTzo/JEe1VxKuRfefHZKgCFaVocMQd/7sQwmZGsb
 xN8lhTnmJXGoHqcjQhRycrH0HhUEiizJMA43zGnIaqBmYBaNQD3QXReh+BEiYWuk
 0nF+mBzWGOyqmntXNJ8EaHp16gXfdE/cxdMzJNSBa9VX6LiE6wEdZvdMwF2y8r2m
 +Lw4w7yUP0HG26/PcH94nIUG7bZ1TDPkyPhkv36Z+Ztatew==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4euefyhbrk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 16 Jun 2026 22:49:49 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 16 Jun 2026 22:49:48 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 16 Jun 2026 22:49:48 -0700
Received: from localhost.localdomain (unknown [10.28.36.154])
 by maili.marvell.com (Postfix) with ESMTP id A02CA3F704B;
 Tue, 16 Jun 2026 22:49:45 -0700 (PDT)
From: Rakesh Kudurumalla <rkudurumalla@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, Rakesh Kudurumalla
 <rkudurumalla@marvell.com>
Subject: [PATCH] common/cnxk: add bulk Rx queue enable/disable
Date: Wed, 17 Jun 2026 11:19:43 +0530
Message-ID: <20260617054943.287815-1-rkudurumalla@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: uFPXcnsDWjqChoXSfHxMdEmnGH0TKgff
X-Authority-Analysis: v=2.4 cv=Zf0t8MVA c=1 sm=1 tr=0 ts=6a32357d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=Gf0DblXfq_GWlY6mU-YA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA1MSBTYWx0ZWRfXwmfRElGQ0nFV
 9fMD4NQAfqtGV9zpMNAOJvKbkZu2nrHgkvims9GVxmv4zFQ48s/Lq1dS6C2fXZDGa330/GadlZR
 l8hR/GODxsw8ydzfKMDfr57hNV1GODA=
X-Proofpoint-ORIG-GUID: uFPXcnsDWjqChoXSfHxMdEmnGH0TKgff
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA1MSBTYWx0ZWRfXxNfe8xBqcGUV
 jvFASioAlQ8pL+IREKXYgfelKqfboKk0yiXh8TWVK4X3baf5bsi8T9BFJtG8No+A7DhS47NAd1n
 Rl7aP3T1Ci4lc1/WQYoSScpB3RNeVfqUSIHZz3zDrQEMTZ6WXvdgQKXf9H6+jX+IwTImASfV9Lb
 9L6EVCQ4btryGaRSC8AAc7FP4b15DEuwAoyAYtC1gRGBOj2DoU6o1IgH+WuvZblKODSJdYVmJ5I
 K9qz375CUVieHrtWmMjhIrt19VeY3iUSQ30dYWXdVWbGJ6LNhavl8/JZm/32gR5htTIJhbfisqV
 nLQuAlZPj/Q/cJLL24M/Qiuqki51ijexxxxbMA8F6ro5hut94bQTCOCHJWyu3ai6X0jBFjYhtbA
 D9QrEa2xEhezXezxdm2LyjgAHMFblEr4V9XNjOcjPwUlYHWQvWOTFPnw8gh+xlmEKFG6ITb60vb
 4elGHUJYIveqgrtqUcA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
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

Add roc_nix_rq_multi_ena_dis() to batch RQ enable/disable mailbox
AQ operations and process them in a single mbox_process() call.

Skip mbox_process() when no messages were queued (e.g. all qid are
UINT16_MAX) by checking num_msgs and msg_size via mbox_nonempty_nolock().

Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
---
 drivers/common/cnxk/roc_mbox_priv.h           |  6 +-
 drivers/common/cnxk/roc_nix.h                 |  2 +
 drivers/common/cnxk/roc_nix_queue.c           | 87 +++++++++++++++++++
 .../common/cnxk/roc_platform_base_symbols.c   |  1 +
 4 files changed, 92 insertions(+), 4 deletions(-)

diff --git a/drivers/common/cnxk/roc_mbox_priv.h b/drivers/common/cnxk/roc_mbox_priv.h
index 354c8fa52a..e9da1959b6 100644
--- a/drivers/common/cnxk/roc_mbox_priv.h
+++ b/drivers/common/cnxk/roc_mbox_priv.h
@@ -113,14 +113,12 @@ mbox_rsp_init(uint16_t mbox_id, void *msghdr)
 }
 
 static inline bool
-mbox_nonempty(struct mbox *mbox, int devid)
+mbox_nonempty_nolock(struct mbox *mbox, int devid)
 {
 	struct mbox_dev *mdev = &mbox->dev[devid];
 	bool ret;
 
-	plt_spinlock_lock(&mdev->mbox_lock);
-	ret = mdev->num_msgs != 0;
-	plt_spinlock_unlock(&mdev->mbox_lock);
+	ret = mdev->num_msgs != 0 && mdev->msg_size != 0;
 
 	return ret;
 }
diff --git a/drivers/common/cnxk/roc_nix.h b/drivers/common/cnxk/roc_nix.h
index 8ba8b3e0b6..f495e2a5ad 100644
--- a/drivers/common/cnxk/roc_nix.h
+++ b/drivers/common/cnxk/roc_nix.h
@@ -1094,6 +1094,8 @@ int __roc_api roc_nix_rq_modify(struct roc_nix *roc_nix, struct roc_nix_rq *rq,
 				bool ena);
 int __roc_api roc_nix_rq_cman_config(struct roc_nix *roc_nix, struct roc_nix_rq *rq);
 int __roc_api roc_nix_rq_ena_dis(struct roc_nix_rq *rq, bool enable);
+int __roc_api roc_nix_rq_multi_ena_dis(struct roc_nix *roc_nix, struct roc_nix_rq *rqs,
+				       int nb_rx_queues, bool enable);
 int __roc_api roc_nix_rq_is_sso_enable(struct roc_nix *roc_nix, uint32_t qid);
 int __roc_api roc_nix_rq_fini(struct roc_nix_rq *rq);
 int __roc_api roc_nix_cq_init(struct roc_nix *roc_nix, struct roc_nix_cq *cq);
diff --git a/drivers/common/cnxk/roc_nix_queue.c b/drivers/common/cnxk/roc_nix_queue.c
index ef9b651022..331e503e09 100644
--- a/drivers/common/cnxk/roc_nix_queue.c
+++ b/drivers/common/cnxk/roc_nix_queue.c
@@ -10,6 +10,32 @@
 /* Default SQB slack per SQ */
 #define ROC_NIX_SQB_SLACK_DFLT 24
 
+#define NIX_RQ_BULK_ENA_DIS_LOOP(REQ_TYPE, ALLOC_FN)                                               \
+	do {                                                                                       \
+		for (i = 0; i < nb_rx_queues; i++) {                                               \
+			REQ_TYPE *aq;                                                              \
+			if (rqs[i].qid == UINT16_MAX)                                              \
+				continue;                                                          \
+			struct roc_nix_rq *rq = &rqs[i];                                           \
+			aq = ALLOC_FN(mbox);                                                       \
+			if (!aq) {                                                                 \
+				rc = mbox_process(mbox);                                           \
+				if (rc)                                                            \
+					goto exit;                                                 \
+				aq = ALLOC_FN(mbox);                                               \
+				if (!aq) {                                                         \
+					rc = -ENOSPC;                                              \
+					goto exit;                                                 \
+				}                                                                  \
+			}                                                                          \
+			aq->qidx = rq->qid;                                                        \
+			aq->ctype = NIX_AQ_CTYPE_RQ;                                               \
+			aq->op = NIX_AQ_INSTOP_WRITE;                                              \
+			aq->rq.ena = enable;                                                       \
+			aq->rq_mask.ena = ~(aq->rq_mask.ena);                                      \
+		}                                                                                  \
+	} while (0)
+
 static inline uint32_t
 nix_qsize_to_val(enum nix_q_size qsize)
 {
@@ -47,6 +73,30 @@ nix_rq_vwqe_flush(struct roc_nix_rq *rq, uint16_t vwqe_interval)
 	}
 }
 
+static int
+nix_rq_bulk_ena_dis(struct nix *nix, struct roc_nix_rq *rqs, int nb_rx_queues, bool enable)
+{
+	struct mbox *mbox = mbox_get((&nix->dev)->mbox);
+	int rc = 0, i;
+
+	if (roc_model_is_cn9k())
+		NIX_RQ_BULK_ENA_DIS_LOOP(struct nix_aq_enq_req, mbox_alloc_msg_nix_aq_enq);
+
+	else if (roc_model_is_cn10k())
+		NIX_RQ_BULK_ENA_DIS_LOOP(struct nix_cn10k_aq_enq_req,
+					 mbox_alloc_msg_nix_cn10k_aq_enq);
+
+	else /* CN20K */
+		NIX_RQ_BULK_ENA_DIS_LOOP(struct nix_cn20k_aq_enq_req,
+					 mbox_alloc_msg_nix_cn20k_aq_enq);
+
+	if (mbox_nonempty_nolock(mbox, 0))
+		rc = mbox_process(mbox);
+exit:
+	mbox_put(mbox);
+	return rc;
+}
+
 int
 nix_rq_ena_dis(struct dev *dev, struct roc_nix_rq *rq, bool enable)
 {
@@ -126,6 +176,43 @@ roc_nix_sq_ena_dis(struct roc_nix_sq *sq, bool enable)
 	return rc;
 }
 
+int
+roc_nix_rq_multi_ena_dis(struct roc_nix *roc_nix, struct roc_nix_rq *rqs, int nb_rx_queues,
+			 bool enable)
+{
+	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
+	struct roc_nix_rq *rq;
+	int rc, i;
+
+	rc = nix_rq_bulk_ena_dis(nix, rqs, nb_rx_queues, enable);
+	if (rc) {
+		plt_err("Failed to %s Rx queues rc=%d pf=%d vf=%d nb_rx_queues=%d",
+			enable ? "enable" : "disable", rc, nix->dev.pf, nix->dev.vf,
+			nb_rx_queues);
+		return rc;
+	}
+
+	for (i = 0; i < nb_rx_queues; i++) {
+		rq = &rqs[i];
+
+		if (rq->qid == UINT16_MAX)
+			continue;
+
+		nix_rq_vwqe_flush(rq, nix->vwqe_interval);
+
+		/* Check for meta aura if RQ is enabled */
+		if (enable && nix->need_meta_aura) {
+			rc = roc_nix_inl_meta_aura_check(rq->roc_nix, rq);
+			if (rc) {
+				plt_err("Failed meta aura check for rq=%u rc=%d pf=%d vf=%d",
+					rq->qid, rc, nix->dev.pf, nix->dev.vf);
+				return rc;
+			}
+		}
+	}
+	return 0;
+}
+
 int
 roc_nix_rq_ena_dis(struct roc_nix_rq *rq, bool enable)
 {
diff --git a/drivers/common/cnxk/roc_platform_base_symbols.c b/drivers/common/cnxk/roc_platform_base_symbols.c
index ed34d4b05b..08b2f4c6f8 100644
--- a/drivers/common/cnxk/roc_platform_base_symbols.c
+++ b/drivers/common/cnxk/roc_platform_base_symbols.c
@@ -353,6 +353,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rq_ena_dis)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rq_is_sso_enable)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rq_init)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rq_modify)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rq_multi_ena_dis)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rq_cman_config)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rq_fini)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_cq_init)
-- 
2.25.1

