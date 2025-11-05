Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C2FCCFA04
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 07:09:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53DBE40657;
	Wed,  5 Nov 2025 08:09:48 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 12E234060B
 for <dev@dpdk.org>; Wed,  5 Nov 2025 08:09:46 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A4JNUx1077210 for <dev@dpdk.org>; Tue, 4 Nov 2025 23:09:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=g
 RZ+eayllJ7q+GdV07+lQc8jcLoaq8Fzx/vJ6ihq/80=; b=HOddc/onCTjfip+e0
 QufWarqLXUNUr78WwAAdiu0GZWMZMokulT2L8aEfKXVVar03wKfERad+52vqUHVv
 SBEo7M+C7KVUYkN4Mk+RGnmCfcJ2WMCarhGKtggSu2T2F77oRJHW3F0tnkS1STuL
 AtitNi4SBfAIcRMJuujIgRqd9j0EYjwVmDE8G4AQ9yCkPSbEWx5ZQyGJtHPyms70
 fgFLktRiwU148jncGMb7539uwo7mEihanwrDsftPJ7kdBWrEL2aHTOhIYtitEMn8
 pq3E5vRGJ9YDBpIfcO8gE5UuPtSkqUapqqNudKNg38pwmWlXJAe8RgwRXrEIAmfO
 puBkw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4a7nv9th5n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 04 Nov 2025 23:09:46 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 4 Nov 2025 23:09:44 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 4 Nov 2025 23:09:44 -0800
Received: from localhost.localdomain (unknown [10.28.36.154])
 by maili.marvell.com (Postfix) with ESMTP id 430995E686D;
 Tue,  4 Nov 2025 23:09:42 -0800 (PST)
From: Rakesh Kudurumalla <rkudurumalla@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, Rakesh Kudurumalla
 <rkudurumalla@marvell.com>
Subject: [PATCH v3 3/5] common/cnxk: add routines to operate CPT CQ
Date: Wed, 5 Nov 2025 12:39:30 +0530
Message-ID: <20251105070932.3569572-3-rkudurumalla@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251105070932.3569572-1-rkudurumalla@marvell.com>
References: <20251029130023.1637177-1-rkudurumalla@marvell.com>
 <20251105070932.3569572-1-rkudurumalla@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDA1MSBTYWx0ZWRfX+fT+o7U/w55h
 Ua+sZ5gBJ+QM6+lF/2tll766km3l2Ag94N0It1KjoFi3Mg3RLHTp+OlGt8VI7o0FTqxZDH4my4X
 /0qK36ohX3YlgKxE5QtxdMP8V5pSdZioN1s7YT/NGBag8dw9dN8dqJBk5f10b46mUj/PLNA4cPF
 8Ng56DOWTopXHPvVEBSIST0WUsQBIR4S+SYDR6nJ1ZwLjm4troZUtzxAjSP3Otb0iNNE/9ddo3W
 Z+kjlVDAO4GihosITURSVT45OsWQIRIjnYdWhvqTlAn4vN8zhmolJV6oH1qrK7ehkYWFcqioerx
 QtL0rgDtQdvDJBZNKLrXjE0ugbeY0rbIE5uowwI8dhunohvIm5A0t26yfvNai2GfFONGkW973aX
 vTnAAGokErvosHz+hMt3tmNElZoQDg==
X-Authority-Analysis: v=2.4 cv=aZVsXBot c=1 sm=1 tr=0 ts=690af83a cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=5GL6ALX4OmV6CRTjG_YA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 5biDQ0eE3dMJv4ryHuluSC_UQ7DdGv6N
X-Proofpoint-ORIG-GUID: 5biDQ0eE3dMJv4ryHuluSC_UQ7DdGv6N
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
index 5330157dda..4e610109b4 100644
--- a/drivers/common/cnxk/roc_cpt.c
+++ b/drivers/common/cnxk/roc_cpt.c
@@ -24,6 +24,7 @@
 #define CPT_LF_MAX_NB_DESC	128000
 #define CPT_LF_DEFAULT_NB_DESC	1024
 #define CPT_LF_FC_MIN_THRESHOLD 32
+#define CQ_ENTRY_SIZE_UNIT	32
 
 static struct cpt_int_cb {
 	roc_cpt_int_misc_cb_t cb;
@@ -687,6 +688,37 @@ cpt_get_blkaddr(struct dev *dev)
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
@@ -713,14 +745,22 @@ cpt_lf_init(struct roc_cpt_lf *lf, bool skip_register_irq)
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
@@ -954,6 +994,7 @@ cpt_lf_fini(struct roc_cpt_lf *lf, bool skip_register_irq)
 	if (!skip_register_irq)
 		cpt_lf_unregister_irqs(lf, cpt_lf_misc_irq, cpt_lf_done_irq);
 
+	cpt_lf_cq_fini(lf);
 	/* Disable IQ */
 	roc_cpt_iq_disable(lf);
 	roc_cpt_iq_reset(lf);
@@ -963,6 +1004,17 @@ cpt_lf_fini(struct roc_cpt_lf *lf, bool skip_register_irq)
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
@@ -1074,6 +1126,26 @@ roc_cpt_eng_grp_add(struct roc_cpt *roc_cpt, enum cpt_eng_type eng_type)
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
index 37bca8d183..41a681e2a5 100644
--- a/drivers/common/cnxk/roc_cpt.h
+++ b/drivers/common/cnxk/roc_cpt.h
@@ -152,10 +152,16 @@ struct roc_cpt_lf {
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
@@ -231,6 +237,8 @@ int __roc_api roc_cpt_afs_print(struct roc_cpt *roc_cpt);
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

