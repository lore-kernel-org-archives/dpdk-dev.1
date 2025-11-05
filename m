Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218E9CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 07:09:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B1AC40649;
	Wed,  5 Nov 2025 08:09:44 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 942BA40615
 for <dev@dpdk.org>; Wed,  5 Nov 2025 08:09:42 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A4JNVmW004813 for <dev@dpdk.org>; Tue, 4 Nov 2025 23:09:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=B
 cMQwfYLBh8M6HgNI7nyxmvsD3V5403b3kQ4cle5gwk=; b=I1YHhfYnAQktMwPMb
 iAJX4YYsi35H5v9GU83bw8US9uxbHwGqTkVy1Qh14toeVnrUzOtN7eHiqHzYlc5Z
 HEqHNVQuZMT0PRCEmmFqFsOpwNSgtNYdOpycDSzzIgsLdvsy0ApJjRGNKu+agag+
 RH8hc8/3cpE5TVNdcsFhjL4nenUrFGxgjrO7oE0/K21MKg27ySur0GcNfxLAOx18
 GkaZc6/Z8MQgq/WERxrAh5kKMDycYG6lUehXhQLNEkD4X123t9cQrkCk/NNDbEQz
 GLAq6uvtRKII0BAiBs7vV/aGbT0sbVq9ILd4pLJQMph0TbjfmkeVV09ypcG202OC
 rX2Cg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4a70ec6tmy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 04 Nov 2025 23:09:41 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 4 Nov 2025 23:09:41 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 4 Nov 2025 23:09:41 -0800
Received: from localhost.localdomain (unknown [10.28.36.154])
 by maili.marvell.com (Postfix) with ESMTP id A8A4A5E6865;
 Tue,  4 Nov 2025 23:09:38 -0800 (PST)
From: Rakesh Kudurumalla <rkudurumalla@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, Rakesh Kudurumalla
 <rkudurumalla@marvell.com>
Subject: [PATCH v3 2/5] common/cnxk: add params to register IRQ handler
Date: Wed, 5 Nov 2025 12:39:29 +0530
Message-ID: <20251105070932.3569572-2-rkudurumalla@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251105070932.3569572-1-rkudurumalla@marvell.com>
References: <20251029130023.1637177-1-rkudurumalla@marvell.com>
 <20251105070932.3569572-1-rkudurumalla@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDA1MSBTYWx0ZWRfXygu6/ZLThIMn
 5j/+x6RkSbubRL9t85jywfKo7LO443HRwKzVLX6tsAb2XvePwGvA7jJPqEqEmOPha9N88zuIUvF
 OJKazToBCvtdcZ14DXWC7mkZCmvD/Ks+cQzOBI3QcLBkeBbCkUOYr5ERIVENH5aJKjHepgwpkPp
 Jh6jRWRlIJRmEBKH3l11X8nywz+ZAAiZTlp83ij6atyeBgjmmyn0tKzPDcloJO8ibvWh8ev10I/
 Y14J0pnP4thMQtd5pXsrAHxtrGzmTxTuvUpYR6AZ7oqFd0QumSWqttRDYrKqZIfhu9OEMgxCIXB
 QikIc0NoVwL6T1SBg/WOOJCFjwoqbWAgO5bdE5ko9VGYCuvTZ0MvI5FqhKZmsheq5YGc8GiwLDI
 8y2mPoszRKC7tKM4d0aI+gCCXCnUJw==
X-Proofpoint-GUID: dcQ1eJJr5Qa0BhFUwB6ARXrvpT8vokP6
X-Authority-Analysis: v=2.4 cv=SomdKfO0 c=1 sm=1 tr=0 ts=690af835 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=qOT6uCCeAQiegN0jZ0YA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: dcQ1eJJr5Qa0BhFUwB6ARXrvpT8vokP6
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

modified cpt_lf_unregister_irqs cpt_lf_register_irqs()
parameters to register and unregister call back handlers.

Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
---
 drivers/common/cnxk/roc_cpt.c         | 53 ++++++++++++++-------------
 drivers/common/cnxk/roc_cpt_priv.h    | 10 ++++-
 drivers/common/cnxk/roc_nix_inl.c     |  6 +--
 drivers/common/cnxk/roc_nix_inl_dev.c |  6 +--
 4 files changed, 42 insertions(+), 33 deletions(-)

diff --git a/drivers/common/cnxk/roc_cpt.c b/drivers/common/cnxk/roc_cpt.c
index c467b55139..5330157dda 100644
--- a/drivers/common/cnxk/roc_cpt.c
+++ b/drivers/common/cnxk/roc_cpt.c
@@ -44,7 +44,7 @@ cpt_lf_misc_intr_enb_dis(struct roc_cpt_lf *lf, bool enb)
 			    lf->rbase + CPT_LF_MISC_INT_ENA_W1C);
 }
 
-static void
+void
 cpt_lf_misc_irq(void *param)
 {
 	struct roc_cpt_lf *lf = (struct roc_cpt_lf *)param;
@@ -70,7 +70,7 @@ cpt_lf_misc_irq(void *param)
 }
 
 static int
-cpt_lf_register_misc_irq(struct roc_cpt_lf *lf)
+cpt_lf_register_misc_irq(struct roc_cpt_lf *lf, misc_irq_cb_t misc_cb)
 {
 	struct plt_pci_device *pci_dev = lf->pci_dev;
 	struct plt_intr_handle *handle;
@@ -82,7 +82,7 @@ cpt_lf_register_misc_irq(struct roc_cpt_lf *lf)
 	/* Clear err interrupt */
 	cpt_lf_misc_intr_enb_dis(lf, false);
 	/* Set used interrupt vectors */
-	rc = dev_irq_register(handle, cpt_lf_misc_irq, lf, vec);
+	rc = dev_irq_register(handle, misc_cb, lf, vec);
 	/* Enable all dev interrupt except for RQ_DISABLED */
 	cpt_lf_misc_intr_enb_dis(lf, true);
 
@@ -90,7 +90,7 @@ cpt_lf_register_misc_irq(struct roc_cpt_lf *lf)
 }
 
 static void
-cpt_lf_unregister_misc_irq(struct roc_cpt_lf *lf)
+cpt_lf_unregister_misc_irq(struct roc_cpt_lf *lf, misc_irq_cb_t misc_cb)
 {
 	struct plt_pci_device *pci_dev = lf->pci_dev;
 	struct plt_intr_handle *handle;
@@ -101,7 +101,7 @@ cpt_lf_unregister_misc_irq(struct roc_cpt_lf *lf)
 	vec = lf->msixoff + CPT_LF_INT_VEC_MISC;
 	/* Clear err interrupt */
 	cpt_lf_misc_intr_enb_dis(lf, false);
-	dev_irq_unregister(handle, cpt_lf_misc_irq, lf, vec);
+	dev_irq_unregister(handle, misc_cb, lf, vec);
 }
 
 static void
@@ -134,7 +134,7 @@ cpt_lf_done_irq(void *param)
 }
 
 static int
-cpt_lf_register_done_irq(struct roc_cpt_lf *lf)
+cpt_lf_register_done_irq(struct roc_cpt_lf *lf, done_irq_cb_t done_cb)
 {
 	struct plt_pci_device *pci_dev = lf->pci_dev;
 	struct plt_intr_handle *handle;
@@ -148,7 +148,7 @@ cpt_lf_register_done_irq(struct roc_cpt_lf *lf)
 	cpt_lf_done_intr_enb_dis(lf, false);
 
 	/* Set used interrupt vectors */
-	rc = dev_irq_register(handle, cpt_lf_done_irq, lf, vec);
+	rc = dev_irq_register(handle, done_cb, lf, vec);
 
 	/* Enable done interrupt */
 	cpt_lf_done_intr_enb_dis(lf, true);
@@ -157,7 +157,7 @@ cpt_lf_register_done_irq(struct roc_cpt_lf *lf)
 }
 
 static void
-cpt_lf_unregister_done_irq(struct roc_cpt_lf *lf)
+cpt_lf_unregister_done_irq(struct roc_cpt_lf *lf, done_irq_cb_t done_cb)
 {
 	struct plt_pci_device *pci_dev = lf->pci_dev;
 	struct plt_intr_handle *handle;
@@ -169,11 +169,11 @@ cpt_lf_unregister_done_irq(struct roc_cpt_lf *lf)
 
 	/* Clear done interrupt */
 	cpt_lf_done_intr_enb_dis(lf, false);
-	dev_irq_unregister(handle, cpt_lf_done_irq, lf, vec);
+	dev_irq_unregister(handle, done_cb, lf, vec);
 }
 
-static int
-cpt_lf_register_irqs(struct roc_cpt_lf *lf)
+int
+cpt_lf_register_irqs(struct roc_cpt_lf *lf, misc_irq_cb_t misc_cb, done_irq_cb_t done_cb)
 {
 	int rc;
 
@@ -184,22 +184,22 @@ cpt_lf_register_irqs(struct roc_cpt_lf *lf)
 	}
 
 	/* Register lf err interrupt */
-	rc = cpt_lf_register_misc_irq(lf);
+	rc = cpt_lf_register_misc_irq(lf, misc_cb);
 	if (rc)
 		plt_err("Error registering IRQs");
 
-	rc = cpt_lf_register_done_irq(lf);
+	rc = cpt_lf_register_done_irq(lf, done_cb);
 	if (rc)
 		plt_err("Error registering IRQs");
 
 	return rc;
 }
 
-static void
-cpt_lf_unregister_irqs(struct roc_cpt_lf *lf)
+void
+cpt_lf_unregister_irqs(struct roc_cpt_lf *lf, misc_irq_cb_t misc_cb, done_irq_cb_t done_cb)
 {
-	cpt_lf_unregister_misc_irq(lf);
-	cpt_lf_unregister_done_irq(lf);
+	cpt_lf_unregister_misc_irq(lf, misc_cb);
+	cpt_lf_unregister_done_irq(lf, done_cb);
 }
 
 static void
@@ -688,7 +688,7 @@ cpt_get_blkaddr(struct dev *dev)
 }
 
 int
-cpt_lf_init(struct roc_cpt_lf *lf)
+cpt_lf_init(struct roc_cpt_lf *lf, bool skip_register_irq)
 {
 	struct dev *dev = lf->dev;
 	uint64_t blkaddr;
@@ -713,9 +713,11 @@ cpt_lf_init(struct roc_cpt_lf *lf)
 	/* Initialize instruction queue */
 	cpt_iq_init(lf);
 
-	rc = cpt_lf_register_irqs(lf);
-	if (rc)
-		goto disable_iq;
+	if (!skip_register_irq) {
+		rc = cpt_lf_register_irqs(lf, cpt_lf_misc_irq, cpt_lf_done_irq);
+		if (rc)
+			goto disable_iq;
+	}
 
 	return 0;
 
@@ -736,7 +738,7 @@ roc_cpt_lf_init(struct roc_cpt *roc_cpt, struct roc_cpt_lf *lf)
 	lf->msixoff = cpt->lf_msix_off[lf->lf_id];
 	lf->pci_dev = cpt->pci_dev;
 
-	rc = cpt_lf_init(lf);
+	rc = cpt_lf_init(lf, false);
 	if (rc)
 		return rc;
 
@@ -946,10 +948,11 @@ roc_cpt_iq_reset(struct roc_cpt_lf *lf)
 }
 
 void
-cpt_lf_fini(struct roc_cpt_lf *lf)
+cpt_lf_fini(struct roc_cpt_lf *lf, bool skip_register_irq)
 {
 	/* Unregister IRQ's */
-	cpt_lf_unregister_irqs(lf);
+	if (!skip_register_irq)
+		cpt_lf_unregister_irqs(lf, cpt_lf_misc_irq, cpt_lf_done_irq);
 
 	/* Disable IQ */
 	roc_cpt_iq_disable(lf);
@@ -980,7 +983,7 @@ roc_cpt_lf_fini(struct roc_cpt_lf *lf)
 	if (lf == NULL)
 		return;
 	lf->roc_cpt->lf[lf->lf_id] = NULL;
-	cpt_lf_fini(lf);
+	cpt_lf_fini(lf, false);
 }
 
 int
diff --git a/drivers/common/cnxk/roc_cpt_priv.h b/drivers/common/cnxk/roc_cpt_priv.h
index 0bd956e373..c46ef143ab 100644
--- a/drivers/common/cnxk/roc_cpt_priv.h
+++ b/drivers/common/cnxk/roc_cpt_priv.h
@@ -18,14 +18,20 @@ roc_cpt_to_cpt_priv(struct roc_cpt *roc_cpt)
 	return (struct cpt *)&roc_cpt->reserved[0];
 }
 
+typedef void (*misc_irq_cb_t)(void *params);
+typedef void (*done_irq_cb_t)(void *params);
 int cpt_lfs_attach(struct dev *dev, uint8_t blkaddr, bool modify,
 		   uint16_t nb_lf);
 int cpt_lfs_detach(struct dev *dev);
 int cpt_lfs_alloc(struct dev *dev, uint8_t eng_grpmsk, uint8_t blk, bool inl_dev_sso,
 		  bool ctx_ilen_valid, uint8_t ctx_ilen, bool rxc_ena, uint16_t rx_inject_qp);
 int cpt_lfs_free(struct dev *dev);
-int cpt_lf_init(struct roc_cpt_lf *lf);
-void cpt_lf_fini(struct roc_cpt_lf *lf);
+int cpt_lf_init(struct roc_cpt_lf *lf, bool skip_register_irq);
+void cpt_lf_fini(struct roc_cpt_lf *lf, bool skip_register_irq);
+int cpt_lf_register_irqs(struct roc_cpt_lf *lf, misc_irq_cb_t misc_cb, done_irq_cb_t done_cb);
+void cpt_lf_unregister_irqs(struct roc_cpt_lf *lf, misc_irq_cb_t misc_cb, done_irq_cb_t done_cb);
+void cpt_lf_cq_init(struct roc_cpt_lf *lf);
+void cpt_lf_misc_irq(void *params);
 
 int cpt_lf_outb_cfg(struct dev *dev, uint16_t sso_pf_func, uint16_t nix_pf_func,
 		    uint8_t lf_id, bool ena);
diff --git a/drivers/common/cnxk/roc_nix_inl.c b/drivers/common/cnxk/roc_nix_inl.c
index c7637ddbdc..bc63f4ee62 100644
--- a/drivers/common/cnxk/roc_nix_inl.c
+++ b/drivers/common/cnxk/roc_nix_inl.c
@@ -1588,7 +1588,7 @@ roc_nix_inl_outb_init(struct roc_nix *roc_nix)
 		lf->pci_dev = nix->pci_dev;
 
 		/* Setup CPT LF instruction queue */
-		rc = cpt_lf_init(lf);
+		rc = cpt_lf_init(lf, false);
 		if (rc) {
 			plt_err("Failed to initialize CPT LF, rc=%d", rc);
 			goto lf_fini;
@@ -1678,7 +1678,7 @@ roc_nix_inl_outb_init(struct roc_nix *roc_nix)
 
 lf_fini:
 	for (j = i - 1; j >= 0; j--)
-		cpt_lf_fini(&lf_base[j]);
+		cpt_lf_fini(&lf_base[j], false);
 	plt_free(lf_base);
 lf_free:
 	rc |= cpt_lfs_free(dev);
@@ -1705,7 +1705,7 @@ roc_nix_inl_outb_fini(struct roc_nix *roc_nix)
 
 	/* Cleanup CPT LF instruction queue */
 	for (i = 0; i < nix->nb_cpt_lf; i++)
-		cpt_lf_fini(&lf_base[i]);
+		cpt_lf_fini(&lf_base[i], false);
 
 	/* Free LF resources */
 	rc = cpt_lfs_free(dev);
diff --git a/drivers/common/cnxk/roc_nix_inl_dev.c b/drivers/common/cnxk/roc_nix_inl_dev.c
index 75d03c1077..dcfb893215 100644
--- a/drivers/common/cnxk/roc_nix_inl_dev.c
+++ b/drivers/common/cnxk/roc_nix_inl_dev.c
@@ -451,7 +451,7 @@ nix_inl_cpt_setup(struct nix_inl_dev *inl_dev, bool inl_dev_sso)
 		lf->msixoff = inl_dev->cpt_msixoff[i];
 		lf->pci_dev = inl_dev->pci_dev;
 
-		rc = cpt_lf_init(lf);
+		rc = cpt_lf_init(lf, false);
 		if (rc) {
 			plt_err("Failed to initialize CPT LF, rc=%d", rc);
 			goto lf_free;
@@ -477,7 +477,7 @@ nix_inl_cpt_setup(struct nix_inl_dev *inl_dev, bool inl_dev_sso)
 	return 0;
 lf_fini:
 	for (i = 0; i < inl_dev->nb_cptlf; i++)
-		cpt_lf_fini(&inl_dev->cpt_lf[i]);
+		cpt_lf_fini(&inl_dev->cpt_lf[i], false);
 lf_free:
 	rc |= cpt_lfs_free(dev);
 	return rc;
@@ -501,7 +501,7 @@ nix_inl_cpt_release(struct nix_inl_dev *inl_dev)
 
 	/* Cleanup CPT LF queue */
 	for (i = 0; i < inl_dev->nb_cptlf; i++)
-		cpt_lf_fini(&inl_dev->cpt_lf[i]);
+		cpt_lf_fini(&inl_dev->cpt_lf[i], false);
 
 	/* Free LF resources */
 	rc = cpt_lfs_free(dev);
-- 
2.25.1

