Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B16E9A04C
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 09:09:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5216740663;
	Thu, 19 Feb 2026 10:09:32 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 00F1D4060C
 for <dev@dpdk.org>; Thu, 19 Feb 2026 10:09:30 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61IGhpmc4122487 for <dev@dpdk.org>; Thu, 19 Feb 2026 01:09:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=l
 89YutTvfDM4vZWqoT8/Lkf4xkznvEMO+dWqrT7QF+I=; b=M5tUtvXn9Wk0y8gK+
 wkv8WqUHG+LbyjkmR8QiXihkaTYFoaepHH3kTQZmTwFQIaMRxtEoOJv3mQYCUAbR
 cajnVCMU5b+puLf8UFCfCzwwE+cU69kVY2yeWgC5y/ZImE3SQej+J0lm/X3C9JAF
 ea2cDDOJsG/0EHlO65/dqfBgU3dLjf/qxvTyI5FOglqkd1UADIZD2yiSnabe9YQo
 +/+wK5tLgZP8cGZ692Tq5JgpjZMNw0c0fPpM4iuAe4A7HH/YiZtaufjwsOaFLlAM
 FGo60r723rks71oYA7DAhg/tMINo2whklnxYEbl6k4S1PrHShWxw8A06zyLdQKMq
 Ls4lQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cd218kp67-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 19 Feb 2026 01:09:29 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 19 Feb 2026 01:09:45 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 19 Feb 2026 01:09:45 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id AD7C73F708A;
 Thu, 19 Feb 2026 01:09:26 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rakesh Kudurumalla <rkudurumalla@marvell.com>
Subject: [PATCH 8/8] common/cnxk: enable CPT CQ for inline IPSec inbound
Date: Thu, 19 Feb 2026 14:38:47 +0530
Message-ID: <20260219090847.3257753-8-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260219090847.3257753-1-rbhansali@marvell.com>
References: <20260219090847.3257753-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDA4MyBTYWx0ZWRfX9VA1xFJdLvl0
 YEpmrydJEhuZt+5r4pp3woR2NPTDpVZ/yTGJTpwQuyRdI3okq4PUH/gpA4XkWQ0Kvy5cbhOnKV6
 LsDRBnK69rrD1FuW+qKOz441bfpqsThn/TJsMdNb708f5ZX8eGB95BRj+F3kfgZ9mAI8ybEPgyl
 EamlPhckHQt1M1gGvmhbNxSO5mR0MJfJTX5nQiMIuM5eDBf/VCF2dxRivJJk1YFs/n/zC2bqKDO
 q+dE6qzK4m3dsKC21MKInEykTmZRroYIjJDYstuzC1WIzbIVIFY36av6OqNDw/x4KjZJgWMJufA
 9kMhboWAwLpP1uSVbp0qQMgq7gydmmp7lI2rdgKOqsJXfVZ3e/KzD9OErFiu97iH79JS+lRf/uH
 ud/TiK5LlBstgoADyPuUMENXaU2wBKxFG1KZgL4DhN6WdYeyZU0Afe4bwj3UT1lEhMAN8HmRSkZ
 GsMNVw+ubjOAouAZUgw==
X-Proofpoint-ORIG-GUID: rmpPQHvCM4AOs8s5oRFR4ZcrNH5Uwuzm
X-Proofpoint-GUID: rmpPQHvCM4AOs8s5oRFR4ZcrNH5Uwuzm
X-Authority-Analysis: v=2.4 cv=H7zWAuYi c=1 sm=1 tr=0 ts=6996d349 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=M5GUcnROAAAA:8 a=yeOJ3BYTbHhQgrTJAmMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_02,2026-02-18_01,2025-10-01_01
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

Added support of CPT CQ configurations for inline inbound IPsec.

Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
---
 drivers/common/cnxk/roc_nix_inl.c         |  8 ++-
 drivers/common/cnxk/roc_nix_inl.h         |  3 +-
 drivers/common/cnxk/roc_nix_inl_dev.c     | 86 ++++++++++++++++++++---
 drivers/common/cnxk/roc_nix_inl_dev_irq.c | 19 +++--
 drivers/net/cnxk/cn20k_ethdev_sec.c       | 54 ++++++++------
 5 files changed, 132 insertions(+), 38 deletions(-)

diff --git a/drivers/common/cnxk/roc_nix_inl.c b/drivers/common/cnxk/roc_nix_inl.c
index 911c349604..26be1adac9 100644
--- a/drivers/common/cnxk/roc_nix_inl.c
+++ b/drivers/common/cnxk/roc_nix_inl.c
@@ -486,6 +486,7 @@ nix_inl_inb_ipsec_sa_tbl_setup(struct roc_nix *roc_nix)
 	} else {
 		struct nix_rx_inl_lf_cfg_req *lf_cfg;
 		uint64_t def_cptq = 0;
+		uint64_t cpt_cq_ena = 0;
 
 		/* Setup device specific inb SA table */
 		lf_cfg = mbox_alloc_msg_nix_rx_inl_lf_cfg(mbox);
@@ -508,9 +509,10 @@ nix_inl_inb_ipsec_sa_tbl_setup(struct roc_nix *roc_nix)
 		if (res_addr_offset)
 			res_addr_offset |= (1UL << 56);
 
+		cpt_cq_ena = (uint64_t)inl_dev->cpt_cq_ena << 63;
 		lf_cfg->enable = 1;
 		lf_cfg->profile_id = profile_id; /* IPsec profile is 0th one */
-		lf_cfg->rx_inline_sa_base = (uintptr_t)nix->inb_sa_base[profile_id];
+		lf_cfg->rx_inline_sa_base = (uintptr_t)nix->inb_sa_base[profile_id] | cpt_cq_ena;
 		lf_cfg->rx_inline_cfg0 =
 			((def_cptq << 57) | res_addr_offset | ((uint64_t)SSO_TT_ORDERED << 44) |
 			 (sa_pow2_sz << 16) | lenm1_max);
@@ -588,6 +590,7 @@ nix_inl_reass_inb_sa_tbl_setup(struct roc_nix *roc_nix)
 	uint64_t max_sa = 1, sa_pow2_sz;
 	uint64_t sa_idx_w, lenm1_max;
 	uint64_t res_addr_offset = 0;
+	uint64_t cpt_cq_ena = 0;
 	uint64_t def_cptq = 0;
 	size_t inb_sa_sz = 1;
 	uint8_t profile_id;
@@ -637,9 +640,10 @@ nix_inl_reass_inb_sa_tbl_setup(struct roc_nix *roc_nix)
 			res_addr_offset |= (1UL << 56);
 	}
 
+	cpt_cq_ena = (uint64_t)inl_dev->cpt_cq_ena << 63;
 	lf_cfg->enable = 1;
 	lf_cfg->profile_id = profile_id;
-	lf_cfg->rx_inline_sa_base = (uintptr_t)nix->inb_sa_base[profile_id];
+	lf_cfg->rx_inline_sa_base = (uintptr_t)nix->inb_sa_base[profile_id] | cpt_cq_ena;
 	lf_cfg->rx_inline_cfg0 =
 		((def_cptq << 57) | res_addr_offset | ((uint64_t)SSO_TT_ORDERED << 44) |
 		 (sa_pow2_sz << 16) | lenm1_max);
diff --git a/drivers/common/cnxk/roc_nix_inl.h b/drivers/common/cnxk/roc_nix_inl.h
index 596f12d1c7..d1a08a4495 100644
--- a/drivers/common/cnxk/roc_nix_inl.h
+++ b/drivers/common/cnxk/roc_nix_inl.h
@@ -44,7 +44,8 @@
 #define ROC_NIX_INL_RXC_QUE_BLK_THR 0x40UL
 
 enum nix_inl_event_type {
-	NIX_INL_CPT_CQ = 1,
+	NIX_INL_INB_CPT_CQ = 1,
+	NIX_INL_OUTB_CPT_CQ,
 	NIX_INL_SSO,
 	NIX_INL_SOFT_EXPIRY_THRD,
 };
diff --git a/drivers/common/cnxk/roc_nix_inl_dev.c b/drivers/common/cnxk/roc_nix_inl_dev.c
index 35528efa46..0f97952af3 100644
--- a/drivers/common/cnxk/roc_nix_inl_dev.c
+++ b/drivers/common/cnxk/roc_nix_inl_dev.c
@@ -382,6 +382,7 @@ nix_inl_nix_ipsec_cfg(struct nix_inl_dev *inl_dev, bool ena)
 		struct nix_rx_inl_lf_cfg_req *lf_cfg;
 		uint64_t res_addr_offset;
 		uint64_t def_cptq;
+		uint64_t cpt_cq_ena;
 
 		lf_cfg = mbox_alloc_msg_nix_rx_inl_lf_cfg(mbox);
 		if (lf_cfg == NULL) {
@@ -401,7 +402,9 @@ nix_inl_nix_ipsec_cfg(struct nix_inl_dev *inl_dev, bool ena)
 		lf_cfg->profile_id = inl_dev->ipsec_prof_id;
 		if (ena) {
 			lf_cfg->enable = 1;
-			lf_cfg->rx_inline_sa_base = (uintptr_t)inl_dev->inb_sa_base[profile_id];
+			cpt_cq_ena = (uint64_t)inl_dev->cpt_cq_ena << 63;
+			lf_cfg->rx_inline_sa_base =
+				(uintptr_t)inl_dev->inb_sa_base[profile_id] | (cpt_cq_ena);
 			lf_cfg->rx_inline_cfg0 =
 				((def_cptq << 57) | res_addr_offset |
 				 ((uint64_t)SSO_TT_ORDERED << 44) | (sa_pow2_sz << 16) | lenm1_max);
@@ -482,13 +485,33 @@ nix_inl_cpt_setup(struct nix_inl_dev *inl_dev, bool inl_dev_sso)
 lf_fini:
 	for (i = 0; i < inl_dev->nb_cptlf; i++) {
 		struct roc_cpt_lf *lf = &inl_dev->cpt_lf[i];
-		cpt_lf_fini(lf, lf->cpt_cq_ena);
+		cpt_lf_fini(lf, false);
 	}
 lf_free:
 	rc |= cpt_lfs_free(dev);
 	return rc;
 }
 
+static int
+nix_inl_cpt_cq_inb_release(struct nix_inl_dev *inl_dev)
+{
+	int i;
+
+	if (!inl_dev || !inl_dev->cpt_cq_ena)
+		return 0;
+	for (i = 0; i < inl_dev->nb_inb_cptlfs; i++) {
+		uint8_t slot_id = inl_dev->inb_cpt_lf_id + i;
+		struct roc_cpt_lf *lf = &inl_dev->cpt_lf[slot_id];
+
+		if (lf->cpt_cq_ena) {
+			cpt_lf_cq_fini(lf);
+			cpt_lf_unregister_irqs(lf, cpt_lf_misc_irq, nix_inl_cpt_done_irq);
+		}
+	}
+
+	return 0;
+}
+
 static int
 nix_inl_cpt_release(struct nix_inl_dev *inl_dev)
 {
@@ -625,6 +648,7 @@ nix_inl_nix_profile_config(struct nix_inl_dev *inl_dev, uint8_t profile_id)
 	uint64_t max_sa, sa_w, sa_pow2_sz, lenm1_max;
 	struct nix_rx_inl_lf_cfg_req *lf_cfg;
 	uint64_t res_addr_offset;
+	uint64_t cpt_cq_ena;
 	uint64_t def_cptq;
 	size_t inb_sa_sz;
 	void *sa;
@@ -665,7 +689,8 @@ nix_inl_nix_profile_config(struct nix_inl_dev *inl_dev, uint8_t profile_id)
 
 	lf_cfg->enable = 1;
 	lf_cfg->profile_id = profile_id;
-	lf_cfg->rx_inline_sa_base = (uintptr_t)inl_dev->inb_sa_base[profile_id];
+	cpt_cq_ena = (uint64_t)inl_dev->cpt_cq_ena << 63;
+	lf_cfg->rx_inline_sa_base = (uintptr_t)inl_dev->inb_sa_base[profile_id] | cpt_cq_ena;
 	lf_cfg->rx_inline_cfg0 =
 		((def_cptq << 57) | res_addr_offset | ((uint64_t)SSO_TT_ORDERED << 44) |
 		 (sa_pow2_sz << 16) | lenm1_max);
@@ -716,6 +741,38 @@ nix_inl_nix_profile_release(struct nix_inl_dev *inl_dev, uint8_t profile_id)
 	return rc;
 }
 
+static int
+nix_inl_cpt_cq_inb_setup(struct nix_inl_dev *inl_dev)
+{
+	int i, rc;
+
+	if (!inl_dev->cpt_cq_ena)
+		return 0;
+	for (i = 0; i < inl_dev->nb_inb_cptlfs; i++) {
+		uint8_t slot_id = inl_dev->inb_cpt_lf_id + i;
+		struct roc_cpt_lf *lf = &inl_dev->cpt_lf[slot_id];
+
+		lf->dq_ack_ena = true;
+		lf->cpt_cq_ena = true;
+		lf->cq_entry_size = 0;
+		lf->cq_all = 0;
+		lf->cq_size = lf->nb_desc;
+		lf->dev = &inl_dev->dev;
+		lf->cq_head = 1;
+
+		rc = cpt_lf_cq_init(lf);
+		if (rc)
+			return rc;
+
+		rc = cpt_lf_register_irqs(lf, cpt_lf_misc_irq, nix_inl_cpt_done_irq);
+		if (rc)
+			return rc;
+		roc_cpt_cq_enable(lf);
+	}
+
+	return 0;
+}
+
 static int
 nix_inl_nix_reass_setup(struct nix_inl_dev *inl_dev)
 {
@@ -1451,11 +1508,17 @@ roc_nix_inl_dev_init(struct roc_nix_inl_dev *roc_inl_dev)
 	if (rc)
 		goto sso_release;
 
+	if (roc_feature_nix_has_cpt_cq_support()) {
+		rc = nix_inl_cpt_cq_inb_setup(inl_dev);
+		if (rc)
+			goto cpt_release;
+	}
+
 	/* Setup device specific inb SA table */
 	rc = nix_inl_nix_ipsec_cfg(inl_dev, true);
 	if (rc) {
 		plt_err("Failed to setup NIX Inbound SA conf, rc=%d", rc);
-		goto cpt_release;
+		goto cpt_cq_inb_release;
 	}
 
 	/* Setup Reassembly */
@@ -1464,20 +1527,20 @@ roc_nix_inl_dev_init(struct roc_nix_inl_dev *roc_inl_dev)
 
 		rc = nix_inl_nix_reass_setup(inl_dev);
 		if (rc)
-			goto cpt_release;
+			goto cpt_cq_inb_release;
 	}
 
 	if (inl_dev->set_soft_exp_poll) {
 		rc = nix_inl_outb_poll_thread_setup(inl_dev);
 		if (rc)
-			goto cpt_release;
+			goto cpt_cq_inb_release;
 	}
 
 	/* Perform selftest if asked for */
 	if (inl_dev->selftest) {
 		rc = nix_inl_selftest();
 		if (rc)
-			goto cpt_release;
+			goto cpt_cq_inb_release;
 	}
 	inl_dev->max_ipsec_rules = roc_inl_dev->max_ipsec_rules;
 
@@ -1486,14 +1549,14 @@ roc_nix_inl_dev_init(struct roc_nix_inl_dev *roc_inl_dev)
 			plt_zmalloc(sizeof(int) * inl_dev->max_ipsec_rules, PLT_CACHE_LINE_SIZE);
 		if (inl_dev->ipsec_index == NULL) {
 			rc = NPC_ERR_NO_MEM;
-			goto cpt_release;
+			goto cpt_cq_inb_release;
 		}
 		rc = npc_mcam_alloc_entries(inl_dev->dev.mbox, inl_dev->max_ipsec_rules,
 					    inl_dev->ipsec_index, inl_dev->max_ipsec_rules,
 					    NPC_MCAM_HIGHER_PRIO, &resp_count, 1);
 		if (rc) {
 			plt_free(inl_dev->ipsec_index);
-			goto cpt_release;
+			goto cpt_cq_inb_release;
 		}
 
 		start_index = inl_dev->ipsec_index[0];
@@ -1507,6 +1570,8 @@ roc_nix_inl_dev_init(struct roc_nix_inl_dev *roc_inl_dev)
 	idev->nix_inl_dev = inl_dev;
 
 	return 0;
+cpt_cq_inb_release:
+	rc |= nix_inl_cpt_cq_inb_release(inl_dev);
 cpt_release:
 	rc |= nix_inl_cpt_release(inl_dev);
 sso_release:
@@ -1558,8 +1623,9 @@ roc_nix_inl_dev_fini(struct roc_nix_inl_dev *roc_inl_dev)
 	/* Flush Inbound CTX cache entries */
 	nix_inl_cpt_ctx_cache_sync(inl_dev);
 
+	rc = nix_inl_cpt_cq_inb_release(inl_dev);
 	/* Release CPT */
-	rc = nix_inl_cpt_release(inl_dev);
+	rc |= nix_inl_cpt_release(inl_dev);
 
 	/* Release SSO */
 	rc |= nix_inl_sso_release(inl_dev);
diff --git a/drivers/common/cnxk/roc_nix_inl_dev_irq.c b/drivers/common/cnxk/roc_nix_inl_dev_irq.c
index 89155a1f7d..30986e780a 100644
--- a/drivers/common/cnxk/roc_nix_inl_dev_irq.c
+++ b/drivers/common/cnxk/roc_nix_inl_dev_irq.c
@@ -49,10 +49,11 @@ static void
 nix_inl_cpt_cq_cb(struct roc_cpt_lf *lf)
 {
 	struct roc_nix *roc_nix = (struct roc_nix *)lf->dev->roc_nix;
+	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
 	struct idev_cfg *idev = idev_get_cfg();
 	uint32_t port_id = roc_nix->port_id;
 	struct nix_inl_dev *inl_dev = NULL;
-	struct roc_ow_ipsec_outb_sa *sa;
+	enum nix_inl_event_type cq_type;
 	union cpt_lf_cq_base cq_base;
 	union cpt_lf_cq_ptr cq_ptr;
 	struct cpt_cq_s *cq_s;
@@ -60,6 +61,7 @@ nix_inl_cpt_cq_cb(struct roc_cpt_lf *lf)
 	uint32_t count, head;
 	uint32_t nq_ptr;
 	uint64_t i;
+	void *sa;
 
 	if (idev)
 		inl_dev = idev->nix_inl_dev;
@@ -75,23 +77,30 @@ nix_inl_cpt_cq_cb(struct roc_cpt_lf *lf)
 	count = cq_ptr.s.count;
 	nq_ptr = cq_ptr.s.nq_ptr;
 
+	if (lf->dev == &inl_dev->dev)
+		cq_type = NIX_INL_INB_CPT_CQ;
+	else if (lf->dev == &nix->dev)
+		cq_type = NIX_INL_OUTB_CPT_CQ;
+	else
+		return;
+
 	for (i = 0; i < count; i++) {
 		cq_s = (struct cpt_cq_s *)(uintptr_t)(((cq_base.s.addr << 7)) + (head << 5));
 
 		if (cq_s->w0.s.uc_compcode && cq_s->w0.s.compcode) {
 			switch (cq_s->w2.s.fmt & fmt_msk) {
 			case WQE_PTR_CPTR:
-				sa = (struct roc_ow_ipsec_outb_sa *)cq_s->w1.esn;
+				sa = (void *)cq_s->w1.esn;
 				break;
 			case CPTR_WQE_PTR:
-				sa = (struct roc_ow_ipsec_outb_sa *)cq_s->w3.comp_ptr;
+				sa = (void *)cq_s->w3.comp_ptr;
 				break;
 			default:
 				plt_err("Invalid event Received ");
 				goto done;
 			}
 			uint64_t tmp = ~(uint32_t)0x0;
-			inl_dev->work_cb(&tmp, sa, NIX_INL_CPT_CQ, (void *)cq_s, port_id);
+			inl_dev->work_cb(&tmp, sa, cq_type, (void *)cq_s, port_id);
 		}
 done:
 		head = (head + 1) % lf->cq_size;
@@ -165,7 +174,7 @@ nix_inl_sso_hws_irq(void *param)
 void
 nix_inl_cpt_done_irq(void *param)
 {
-	struct roc_cpt_lf *lf = param;
+	struct roc_cpt_lf *lf = (struct roc_cpt_lf *)param;
 	uint64_t done_wait;
 	uint64_t intr;
 
diff --git a/drivers/net/cnxk/cn20k_ethdev_sec.c b/drivers/net/cnxk/cn20k_ethdev_sec.c
index 5553aed1b1..5e9212948b 100644
--- a/drivers/net/cnxk/cn20k_ethdev_sec.c
+++ b/drivers/net/cnxk/cn20k_ethdev_sec.c
@@ -439,18 +439,31 @@ cnxk_pktmbuf_free_no_cache(struct rte_mbuf *mbuf)
 }
 
 static void
-cn20k_eth_sec_post_event(struct rte_eth_dev *eth_dev, struct roc_ow_ipsec_outb_sa *sa,
+cn20k_eth_sec_post_event(struct rte_eth_dev *eth_dev, void *sa, enum nix_inl_event_type type,
 			 uint16_t uc_compcode, uint16_t compcode, struct rte_mbuf *mbuf)
 {
 	struct rte_eth_event_ipsec_desc desc;
 	struct cn20k_sec_sess_priv sess_priv;
-	struct cn20k_outb_priv_data *priv;
+	struct cn20k_outb_priv_data *outb_priv;
+	struct cn20k_inb_priv_data *inb_priv;
 	static uint64_t warn_cnt;
+	uint64_t life_unit;
 
 	memset(&desc, 0, sizeof(desc));
-	priv = roc_nix_inl_ow_ipsec_outb_sa_sw_rsvd(sa);
 	sess_priv.u64 = 0;
 
+	if (type == NIX_INL_INB_CPT_CQ) {
+		struct roc_ow_ipsec_inb_sa *inb_sa = (struct roc_ow_ipsec_inb_sa *)sa;
+		inb_priv = roc_nix_inl_ow_ipsec_inb_sa_sw_rsvd(sa);
+		desc.metadata = (uint64_t)inb_priv->userdata;
+		life_unit = inb_sa->w2.s.life_unit;
+	} else {
+		struct roc_ow_ipsec_outb_sa *outb_sa = (struct roc_ow_ipsec_outb_sa *)sa;
+		outb_priv = roc_nix_inl_ow_ipsec_outb_sa_sw_rsvd(sa);
+		desc.metadata = (uint64_t)outb_priv->userdata;
+		life_unit = outb_sa->w2.s.life_unit;
+	}
+
 	if (mbuf)
 		sess_priv.u64 = *rte_security_dynfield(mbuf);
 
@@ -459,14 +472,14 @@ cn20k_eth_sec_post_event(struct rte_eth_dev *eth_dev, struct roc_ow_ipsec_outb_s
 		desc.subtype = RTE_ETH_EVENT_IPSEC_ESN_OVERFLOW;
 		break;
 	case ROC_IE_OW_UCC_ERR_SA_EXPIRED:
-		if (sa->w2.s.life_unit == ROC_IE_OW_SA_LIFE_UNIT_PKTS)
+		if (life_unit == ROC_IE_OW_SA_LIFE_UNIT_PKTS)
 			desc.subtype = RTE_ETH_EVENT_IPSEC_SA_PKT_HARD_EXPIRY;
 		else
 			desc.subtype = RTE_ETH_EVENT_IPSEC_SA_BYTE_HARD_EXPIRY;
 		break;
 	case ROC_IE_OW_UCC_SUCCESS_SA_SOFTEXP_FIRST:
 	case ROC_IE_OW_UCC_SUCCESS_SA_SOFTEXP_AGAIN:
-		if (sa->w2.s.life_unit == ROC_IE_OW_SA_LIFE_UNIT_PKTS)
+		if (life_unit == ROC_IE_OW_SA_LIFE_UNIT_PKTS)
 			desc.subtype = RTE_ETH_EVENT_IPSEC_SA_PKT_EXPIRY;
 		else
 			desc.subtype = RTE_ETH_EVENT_IPSEC_SA_BYTE_EXPIRY;
@@ -490,7 +503,6 @@ cn20k_eth_sec_post_event(struct rte_eth_dev *eth_dev, struct roc_ow_ipsec_outb_s
 		break;
 	}
 
-	desc.metadata = (uint64_t)priv->userdata;
 	rte_eth_dev_callback_process(eth_dev, RTE_ETH_EVENT_IPSEC, &desc);
 }
 
@@ -498,12 +510,15 @@ static const char *
 get_inl_event_type(enum nix_inl_event_type type)
 {
 	switch (type) {
-	case NIX_INL_CPT_CQ:
-		return "NIX_INL_CPT_CQ";
+	case NIX_INL_OUTB_CPT_CQ:
+		return "NIX_INL_OUTB_CPT_CQ";
+	case NIX_INL_INB_CPT_CQ:
+		return "NIX_INL_INB_CPT_CQ";
 	case NIX_INL_SSO:
 		return "NIX_INL_SSO";
 	case NIX_INL_SOFT_EXPIRY_THRD:
 		return "NIX_INL_SOFT_EXPIRY_THRD";
+
 	default:
 		return "Unknown event";
 	}
@@ -515,8 +530,8 @@ cn20k_eth_sec_sso_work_cb(uint64_t *gw, void *args, enum nix_inl_event_type type
 {
 	struct rte_eth_event_ipsec_desc desc;
 	struct cn20k_sec_sess_priv sess_priv;
-	struct cn20k_outb_priv_data *priv;
-	struct roc_ow_ipsec_outb_sa *sa;
+	struct cn20k_outb_priv_data *outb_priv;
+	struct roc_ow_ipsec_outb_sa *outb_sa;
 	struct cpt_cn20k_res_s *res;
 	struct rte_eth_dev *eth_dev;
 	struct cnxk_eth_dev *dev;
@@ -546,20 +561,19 @@ cn20k_eth_sec_sso_work_cb(uint64_t *gw, void *args, enum nix_inl_event_type type
 		/* Fall through */
 	default:
 		if (type) {
-			sa = (struct roc_ow_ipsec_outb_sa *)args;
-			priv = roc_nix_inl_ow_ipsec_outb_sa_sw_rsvd(sa);
-			desc.metadata = (uint64_t)priv->userdata;
 			eth_dev = &rte_eth_devices[port_id];
-			if (type == NIX_INL_CPT_CQ) {
-				struct cpt_cq_s *cqs = (struct cpt_cq_s *)cq_s;
-
-				cn20k_eth_sec_post_event(eth_dev, sa,
+			struct cpt_cq_s *cqs = (struct cpt_cq_s *)cq_s;
+			if (type < NIX_INL_SSO) {
+				cn20k_eth_sec_post_event(eth_dev, args, type,
 							 (uint16_t)cqs->w0.s.uc_compcode,
 							 (uint16_t)cqs->w0.s.compcode, NULL);
 				return;
 			}
 			if (type == NIX_INL_SOFT_EXPIRY_THRD) {
-				if (sa->w2.s.life_unit == ROC_IE_OW_SA_LIFE_UNIT_PKTS)
+				outb_sa = (struct roc_ow_ipsec_outb_sa *)args;
+				outb_priv = roc_nix_inl_ow_ipsec_outb_sa_sw_rsvd(outb_sa);
+				desc.metadata = (uint64_t)outb_priv->userdata;
+				if (outb_sa->w2.s.life_unit == ROC_IE_OW_SA_LIFE_UNIT_PKTS)
 					desc.subtype = RTE_ETH_EVENT_IPSEC_SA_PKT_EXPIRY;
 				else
 					desc.subtype = RTE_ETH_EVENT_IPSEC_SA_BYTE_EXPIRY;
@@ -596,9 +610,9 @@ cn20k_eth_sec_sso_work_cb(uint64_t *gw, void *args, enum nix_inl_event_type type
 	sess_priv.u64 = *rte_security_dynfield(mbuf);
 
 	sa_base = dev->outb.sa_base;
-	sa = roc_nix_inl_ow_ipsec_outb_sa(sa_base, sess_priv.sa_idx);
+	outb_sa = roc_nix_inl_ow_ipsec_outb_sa(sa_base, sess_priv.sa_idx);
 
-	cn20k_eth_sec_post_event(eth_dev, sa, res->uc_compcode, res->compcode, mbuf);
+	cn20k_eth_sec_post_event(eth_dev, outb_sa, type, res->uc_compcode, res->compcode, mbuf);
 
 	cnxk_pktmbuf_free_no_cache(mbuf);
 }
-- 
2.34.1

