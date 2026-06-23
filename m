Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DDACD98F0
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 05:44:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56E59402ED;
	Tue, 23 Jun 2026 07:44:33 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 1AD774014F
 for <dev@dpdk.org>; Tue, 23 Jun 2026 07:44:30 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65N0gVmI4058895 for <dev@dpdk.org>; Mon, 22 Jun 2026 22:44:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=p
 7JSzS4bXHZ8+lRU+LoyuukjANbFnDozJDKWKDP9ky0=; b=i2jb4vnYcmyrMtGFP
 MFMx0foWRllnJK/flMDht8O4CFqZ8qa4nKr5foW3zS7+s2BB84GdwcH6SJ1qaN/w
 3Uwi/5B8oaHe0KodJJy8Bzje5Q4i6cRnbuWYWz+QOEEUthfJWG+lHNlQE/87GbcC
 b3b4HJMMbFCeZWlr9rDG/NJ8Rgza0ZWCzRZuzn6TS4QDl97PA7WYvW6eUEK/dpW0
 crG4tvAobUtMHJP3sA68ztxG+ZU35yKr8yrrxznwr+HCkbb0mCPabeWvqIgnYVsy
 OG7wzQQKUqaNJcW6rAV6InEFaL2zASudsPzWm633H2kcVRyXLUEAguFLVlfq6YwV
 bUm6A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ewr7hgbsv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 22 Jun 2026 22:44:29 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 22 Jun 2026 22:44:29 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 22 Jun 2026 22:44:29 -0700
Received: from localhost.localdomain (unknown [10.28.36.154])
 by maili.marvell.com (Postfix) with ESMTP id 220853F7058;
 Mon, 22 Jun 2026 22:44:26 -0700 (PDT)
From: rkudurumalla <rkudurumalla@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, Rakesh Kudurumalla
 <rkudurumalla@marvell.com>
Subject: [PATCH v2 1/1] common/cnxk: add bulk Rx queue enable/disable
Date: Tue, 23 Jun 2026 11:14:24 +0530
Message-ID: <20260623054424.1943810-1-rkudurumalla@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260617054943.287815-1-rkudurumalla@marvell.com>
References: <20260617054943.287815-1-rkudurumalla@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA0MyBTYWx0ZWRfX876GeAkyEDR/
 wRCWeNTzuv5VIKjSeptnDrSl2Q5oWC+tPneFcUGU13PAAjj4yLmAjtGDdA/JsVHNueVZXPnVAzF
 8rNpvE0amCWjOzYGLH5NdJo0hOB9qVgiXEzHTZEFxTsNvOZjtAvasrdtS19z6OHFUX1A/gWB8T9
 Ye9D+2GwOw4E/UZ/tueynPreTamA8i3ND9kBGK21VO2yakuFo6upqjwjbM3gkP1SlWfjG8vLARM
 9e/EGDfrztmGyffjg5xGwe0Gc/KwJ/XCvJWD3eKoimW/LfOBd8pbMrUpXhsvyWFacb69/Bxc5Nh
 YROqCvSCvPav5VZoavV8mucvKDiX4cKSf7BMo0ijtpRU4goWIqiKEMmjuoaqH5zWbsdqVM70Vbd
 hu/yWdclJhyB84zSi+gdwZJCevY56nrsVEz2Mt1iRAm3OeUiVjFWyJ+87V9LR5ebkCt+lqbfOK0
 UOSCQqAmn7MYL5yuz6Q==
X-Proofpoint-ORIG-GUID: b2CidFBatFPsREf_Ci44XSaSDTchXETj
X-Authority-Analysis: v=2.4 cv=aJTAb79m c=1 sm=1 tr=0 ts=6a3a1d3e cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=0KHpr4MkXcJsmS5pXjEA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA0MyBTYWx0ZWRfX5gMx6E9jHxE7
 crtbEZ/r+PD9eea/LMbXXtyIRFMVx06VQn/1+iBP6vAARTiuhrdFpmfcjyGzO8BZ+Dv0S0EkP1v
 HYR0BHpjJ+6ZM0fRMfk0XvtIDfDKSyA=
X-Proofpoint-GUID: b2CidFBatFPsREf_Ci44XSaSDTchXETj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
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

From: Rakesh Kudurumalla <rkudurumalla@marvell.com>

Add roc_nix_rq_multi_ena_dis() to batch RQ enable/disable mailbox
AQ operations and process them in a single mbox_process() call.

Skip mbox_process() when no messages were queued (e.g. all qid are
UINT16_MAX) by checking num_msgs and msg_size via mbox_nonempty_nolock().

Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
---
 drivers/common/cnxk/roc_mbox_priv.h           |   6 +-
 drivers/common/cnxk/roc_nix.h                 |   2 +
 drivers/common/cnxk/roc_nix_queue.c           | 102 ++++++++++++++++++
 .../common/cnxk/roc_platform_base_symbols.c   |   1 +
 4 files changed, 107 insertions(+), 4 deletions(-)

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
index ef9b651022..075c9c1591 100644
--- a/drivers/common/cnxk/roc_nix_queue.c
+++ b/drivers/common/cnxk/roc_nix_queue.c
@@ -10,6 +10,49 @@
 /* Default SQB slack per SQ */
 #define ROC_NIX_SQB_SLACK_DFLT 24
 
+typedef void *(*nix_aq_enq_alloc_t)(struct mbox *mbox);
+
+static inline void
+nix_aq_enq_write_rq_ena(void *msg, uint16_t qid, bool enable)
+{
+	struct nix_aq_enq_req *aq = msg;
+
+	aq->qidx = qid;
+	aq->ctype = NIX_AQ_CTYPE_RQ;
+	aq->op = NIX_AQ_INSTOP_WRITE;
+	aq->rq.ena = enable;
+	aq->rq_mask.ena = ~(aq->rq_mask.ena);
+}
+
+static inline int
+nix_rq_bulk_ena_dis_fill(struct mbox *mbox, struct roc_nix_rq *rqs, int nb_rx_queues,
+			 bool enable, nix_aq_enq_alloc_t alloc)
+{
+	int i;
+
+	for (i = 0; i < nb_rx_queues; i++) {
+		void *aq;
+		int rc;
+
+		if (rqs[i].qid == UINT16_MAX)
+			continue;
+
+		aq = alloc(mbox);
+		if (!aq) {
+			rc = mbox_process(mbox);
+			if (rc)
+				return rc;
+			aq = alloc(mbox);
+			if (!aq)
+				return -ENOSPC;
+		}
+
+		nix_aq_enq_write_rq_ena(aq, rqs[i].qid, enable);
+	}
+
+	return 0;
+}
+
 static inline uint32_t
 nix_qsize_to_val(enum nix_q_size qsize)
 {
@@ -47,6 +90,28 @@ nix_rq_vwqe_flush(struct roc_nix_rq *rq, uint16_t vwqe_interval)
 	}
 }
 
+static int
+nix_rq_bulk_ena_dis(struct nix *nix, struct roc_nix_rq *rqs, int nb_rx_queues, bool enable)
+{
+	struct mbox *mbox = mbox_get((&nix->dev)->mbox);
+	nix_aq_enq_alloc_t alloc;
+	int rc;
+
+	if (roc_model_is_cn9k())
+		alloc = (nix_aq_enq_alloc_t)mbox_alloc_msg_nix_aq_enq;
+	else if (roc_model_is_cn10k())
+		alloc = (nix_aq_enq_alloc_t)mbox_alloc_msg_nix_cn10k_aq_enq;
+	else /* CN20K */
+		alloc = (nix_aq_enq_alloc_t)mbox_alloc_msg_nix_cn20k_aq_enq;
+
+	rc = nix_rq_bulk_ena_dis_fill(mbox, rqs, nb_rx_queues, enable, alloc);
+	if (!rc && mbox_nonempty_nolock(mbox, 0))
+		rc = mbox_process(mbox);
+
+	mbox_put(mbox);
+	return rc;
+}
+
 int
 nix_rq_ena_dis(struct dev *dev, struct roc_nix_rq *rq, bool enable)
 {
@@ -126,6 +191,43 @@ roc_nix_sq_ena_dis(struct roc_nix_sq *sq, bool enable)
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

