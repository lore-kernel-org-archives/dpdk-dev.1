Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22D1CCF9E9
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 13:00:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D16740431;
	Wed, 29 Oct 2025 14:00:42 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 032A740431
 for <dev@dpdk.org>; Wed, 29 Oct 2025 14:00:37 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59TCfkrv3601309 for <dev@dpdk.org>; Wed, 29 Oct 2025 06:00:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=a
 Z0HEoX8FBKpEpI1L+lK/S81sJiZjcs+lSFZNFgfJko=; b=TeMBmhlfDY3Uf1Rqz
 fHKtvcCUzOU7pUVeTIG1C0Jx0oJWCFJJ1tgZ4FQqImFq1DamGjyzFwZcnboSo0M+
 BAjWSuiLt86F2mY2l55IaGv59iRhf2hWjH9VKWHdOD6mqclUCTrtuAIoEOTCCG/e
 ypGGFp9ATknY3ivGZkSItZuPwOi6wS9FZi0AHPU77pA5LV3LYXejzqn8shAyO/Q8
 ZYa4dnsbvE49csP1i17E91ATc8kLS+8Fvm8aamVsuJwivjyLNYh4WCtZzgOoaY3y
 6Wyh4KKZN4gd92ncIU6BXZXsD4i26lmcwjlaAL1nFcdDsigegPsQqEyjq8heGrz/
 G2jug==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4a3has8e81-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 29 Oct 2025 06:00:37 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 29 Oct 2025 06:00:35 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 29 Oct 2025 06:00:35 -0700
Received: from localhost.localdomain (unknown [10.28.36.154])
 by maili.marvell.com (Postfix) with ESMTP id B742D3F70CB;
 Wed, 29 Oct 2025 06:00:33 -0700 (PDT)
From: Rakesh Kudurumalla <rkudurumalla@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, Rakesh Kudurumalla
 <rkudurumalla@marvell.com>
Subject: [PATCH v2 3/5] common/cnxk: add routines to operate CPT CQ
Date: Wed, 29 Oct 2025 18:30:21 +0530
Message-ID: <20251029130023.1637177-3-rkudurumalla@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251029130023.1637177-1-rkudurumalla@marvell.com>
References: <20251006051402.1387576-1-rkudurumalla@marvell.com>
 <20251029130023.1637177-1-rkudurumalla@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Fz6l5XMwjnvz_QG3Ueh7VCThCbND7ocX
X-Authority-Analysis: v=2.4 cv=LJ5rgZW9 c=1 sm=1 tr=0 ts=69020ff5 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=5GL6ALX4OmV6CRTjG_YA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: Fz6l5XMwjnvz_QG3Ueh7VCThCbND7ocX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA5OSBTYWx0ZWRfX7Wi2+W0S5olk
 qX1fmstB6C7W3LF1In0gaIX+FBy0aS321jzEzhyonyXP2RGM1vEsRl9AsK4U7Q9ru9G1vFQHt6t
 itAMwJHIsxmg1hym15VFUMFkruIQs7GL5ggMTDK9IKQGbNVNqrVCfGp04GC9rFfEU+as77arVcy
 /qIecuKJs7cwByXWC2fo2MNvAu2+mtiCIPhv7mPlmZlAFqcLbK3nhsIkxeLGi++9Zu6m0zjZt/0
 lrC89UY0qEdpnXKlUsqDiQdP/mzdVWI665iuwbUQX3i40SMhE/3GnulmfB2Jena8XyHbcED0sTi
 2QSZw+6Qbl1zDfpWPP6TfGZ6Lc5TJDbA/ce9CUHOsYqxPIWzY8ABZpnNeRHGWq2CeE6aALS6BX8
 clG5xfSA4VboIjxQFikeYj/Zi5NM5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_05,2025-10-29_01,2025-10-01_01
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

Added routines to enable, disable and initialize
CPT CQ if cpt_cq_ena is set

Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
---
 drivers/common/cnxk/roc_cpt.c                 | 74 ++++++++++++++++++-
 drivers/common/cnxk/roc_cpt.h                 |  8 ++
 drivers/common/cnxk/roc_cpt_priv.h            |  3 +-
 .../common/cnxk/roc_platform_base_symbols.c   |  2 +
 4 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/drivers/common/cnxk/roc_cpt.c b/drivers/common/cnxk/roc_cpt.c
index 9f67a3c78c..5e19832b11 100644
--- a/drivers/common/cnxk/roc_cpt.c
+++ b/drivers/common/cnxk/roc_cpt.c
@@ -24,6 +24,7 @@
 #define CPT_LF_MAX_NB_DESC	128000
 #define CPT_LF_DEFAULT_NB_DESC	1024
 #define CPT_LF_FC_MIN_THRESHOLD 32
+#define CQ_ENTRY_SIZE_UNIT	32
 
 static struct cpt_int_cb {
 	roc_cpt_int_misc_cb_t cb;
@@ -684,6 +685,37 @@ cpt_get_blkaddr(struct dev *dev)
 	return reg & 0x1FFULL ? RVU_BLOCK_ADDR_CPT1 : RVU_BLOCK_ADDR_CPT0;
 }
 
+int
+cpt_lf_cq_init(struct roc_cpt_lf *lf)
+{
+	union cpt_lf_cq_size lf_cq_size = {.u = 0x0};
+	union cpt_lf_cq_base lf_cq_base = {.u = 0x0};
+	uint8_t max_cq_entry_size = 0x3;
+	uintptr_t addr;
+	uint32_t len;
+
+	if (!lf->cq_size || lf->cq_entry_size > max_cq_entry_size)
+		return -EINVAL;
+
+	/* Disable CPT completion queue */
+	roc_cpt_cq_disable(lf);
+
+	/* Set command queue base address */
+	len = PLT_ALIGN(lf->cq_size * (CQ_ENTRY_SIZE_UNIT << lf->cq_entry_size), ROC_ALIGN);
+	lf->cq_vaddr = plt_zmalloc(len, ROC_ALIGN);
+	if (lf->cq_vaddr == NULL)
+		return -ENOMEM;
+
+	addr = (uintptr_t)lf->cq_vaddr;
+
+	lf_cq_base.s.addr = addr >> 7;
+	plt_write64(lf_cq_base.u, lf->rbase + CPT_LF_CQ_BASE);
+	lf_cq_size.s.size = PLT_ALIGN(len, ROC_ALIGN);
+	plt_write64(lf_cq_size.u, lf->rbase + CPT_LF_CQ_SIZE);
+
+	return 0;
+}
+
 int
 cpt_lf_init(struct roc_cpt_lf *lf, bool skip_register_irq)
 {
@@ -710,14 +742,22 @@ cpt_lf_init(struct roc_cpt_lf *lf, bool skip_register_irq)
 	/* Initialize instruction queue */
 	cpt_iq_init(lf);
 
+	if (lf->cpt_cq_ena) {
+		rc = cpt_lf_cq_init(lf);
+		if (rc)
+			goto disable_iq;
+	}
+
 	if (!skip_register_irq) {
 		rc = cpt_lf_register_irqs(lf, cpt_lf_misc_irq, cpt_lf_done_irq);
 		if (rc)
-			goto disable_iq;
+			goto disable_cq;
 	}
 
 	return 0;
 
+disable_cq:
+	cpt_lf_cq_fini(lf);
 disable_iq:
 	roc_cpt_iq_disable(lf);
 	plt_free(iq_mem);
@@ -951,6 +991,7 @@ cpt_lf_fini(struct roc_cpt_lf *lf, bool skip_register_irq)
 	if (!skip_register_irq)
 		cpt_lf_unregister_irqs(lf, cpt_lf_misc_irq, cpt_lf_done_irq);
 
+	cpt_lf_cq_fini(lf);
 	/* Disable IQ */
 	roc_cpt_iq_disable(lf);
 	roc_cpt_iq_reset(lf);
@@ -960,6 +1001,17 @@ cpt_lf_fini(struct roc_cpt_lf *lf, bool skip_register_irq)
 	lf->iq_vaddr = NULL;
 }
 
+void
+cpt_lf_cq_fini(struct roc_cpt_lf *lf)
+{
+	if (!lf->cpt_cq_ena)
+		return;
+
+	roc_cpt_cq_disable(lf);
+	plt_free(lf->cq_vaddr);
+	lf->cq_vaddr = NULL;
+}
+
 void
 roc_cpt_lf_reset(struct roc_cpt_lf *lf)
 {
@@ -1071,6 +1123,26 @@ roc_cpt_eng_grp_add(struct roc_cpt *roc_cpt, enum cpt_eng_type eng_type)
 	return ret;
 }
 
+void
+roc_cpt_cq_enable(struct roc_cpt_lf *lf)
+{
+	union cpt_lf_cq_ctl lf_cq_ctl = {.u = 0x0};
+
+	lf_cq_ctl.s.ena = 1;
+	lf_cq_ctl.s.dq_ack_ena = lf->dq_ack_ena;
+	lf_cq_ctl.s.entry_size = lf->cq_entry_size;
+	lf_cq_ctl.s.cq_all = lf->cq_all;
+	plt_write64(lf_cq_ctl.u, lf->rbase + CPT_LF_CQ_CTL);
+}
+
+void
+roc_cpt_cq_disable(struct roc_cpt_lf *lf)
+{
+	union cpt_lf_cq_ctl lf_cq_ctl = {.u = 0x0};
+
+	plt_write64(lf_cq_ctl.u, lf->rbase + CPT_LF_CQ_CTL);
+}
+
 void
 roc_cpt_iq_disable(struct roc_cpt_lf *lf)
 {
diff --git a/drivers/common/cnxk/roc_cpt.h b/drivers/common/cnxk/roc_cpt.h
index 02f49c06b7..28dbcd0ef1 100644
--- a/drivers/common/cnxk/roc_cpt.h
+++ b/drivers/common/cnxk/roc_cpt.h
@@ -148,10 +148,16 @@ struct roc_cpt_lf {
 	/* Input parameters */
 	uint16_t lf_id;
 	uint32_t nb_desc;
+	bool dq_ack_ena;
+	bool cq_all;
+	bool cpt_cq_ena;
+	uint8_t cq_entry_size;
+	uint32_t cq_size;
 	/* End of Input parameters */
 	struct plt_pci_device *pci_dev;
 	struct dev *dev;
 	struct roc_cpt *roc_cpt;
+	uint16_t *cq_vaddr;
 	uintptr_t rbase;
 	uintptr_t lmt_base;
 	uint16_t msixoff;
@@ -226,6 +232,8 @@ int __roc_api roc_cpt_afs_print(struct roc_cpt *roc_cpt);
 int __roc_api roc_cpt_lfs_print(struct roc_cpt *roc_cpt);
 void __roc_api roc_cpt_iq_disable(struct roc_cpt_lf *lf);
 void __roc_api roc_cpt_iq_enable(struct roc_cpt_lf *lf);
+void __roc_api roc_cpt_cq_disable(struct roc_cpt_lf *lf);
+void __roc_api roc_cpt_cq_enable(struct roc_cpt_lf *lf);
 int __roc_api roc_cpt_lmtline_init(struct roc_cpt *roc_cpt, struct roc_cpt_lmtline *lmtline,
 				   int lf_id, bool is_dual);
 
diff --git a/drivers/common/cnxk/roc_cpt_priv.h b/drivers/common/cnxk/roc_cpt_priv.h
index c46ef143ab..39afa1c7ff 100644
--- a/drivers/common/cnxk/roc_cpt_priv.h
+++ b/drivers/common/cnxk/roc_cpt_priv.h
@@ -30,7 +30,8 @@ int cpt_lf_init(struct roc_cpt_lf *lf, bool skip_register_irq);
 void cpt_lf_fini(struct roc_cpt_lf *lf, bool skip_register_irq);
 int cpt_lf_register_irqs(struct roc_cpt_lf *lf, misc_irq_cb_t misc_cb, done_irq_cb_t done_cb);
 void cpt_lf_unregister_irqs(struct roc_cpt_lf *lf, misc_irq_cb_t misc_cb, done_irq_cb_t done_cb);
-void cpt_lf_cq_init(struct roc_cpt_lf *lf);
+int cpt_lf_cq_init(struct roc_cpt_lf *lf);
+void cpt_lf_cq_fini(struct roc_cpt_lf *lf);
 void cpt_lf_misc_irq(void *params);
 
 int cpt_lf_outb_cfg(struct dev *dev, uint16_t sso_pf_func, uint16_t nix_pf_func,
diff --git a/drivers/common/cnxk/roc_platform_base_symbols.c b/drivers/common/cnxk/roc_platform_base_symbols.c
index 7f0fe601ad..e6fa3b540b 100644
--- a/drivers/common/cnxk/roc_platform_base_symbols.c
+++ b/drivers/common/cnxk/roc_platform_base_symbols.c
@@ -50,6 +50,8 @@ RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_lf_ctx_reload)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_lf_reset)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_lf_fini)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_dev_fini)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_cq_disable)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_cq_enable)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_dev_clear)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_eng_grp_add)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_iq_disable)
-- 
2.25.1

