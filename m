Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E554D3567F
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 06:05:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE1FC402C1;
	Wed, 28 Jan 2026 07:05:21 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id AD7FD402C1
 for <dev@dpdk.org>; Wed, 28 Jan 2026 07:05:18 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60RGPxkh1390280 for <dev@dpdk.org>; Tue, 27 Jan 2026 22:05:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=A
 fdYSuZqPPnFZUPLg7GYfxHU+aQ6VMDDNuWdyCirJUo=; b=JPmtPb5iS75gjZTvO
 /aDFbjGKyPDFWipyhXJreCIM+ZvAoDc0xOKz5Yy8kYAXqoNQN4cqp5bw5tC4BDsz
 kM7IuHxovjm6e6qbWd2qxcKlm0yO2UTN/W4kE7E/AHZX5+Yso4YOlU8/hq5WGqCn
 chtw5O5XK6JZAPCWMLyFk6Yl6d2Fioh09ti3uL7GC2qQiuDSN8LyWFcJ9QvYAaHH
 8YBbyKrhTYmVi4YWKbK1K6n8c8lVgo1DpJm3EUYmUZsLvy8I1i6aT1qGmRLkbWL1
 EwzkR27NhjdjCMZk1OXbVnMkQQ8TxmT05CYkxOdY+V+sJwOlvF9iwsc9ojWDNwRd
 n4uqQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bx0qsws60-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 27 Jan 2026 22:05:17 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 Jan 2026 22:05:08 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 27 Jan 2026 22:05:08 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id F0F6D3F706F;
 Tue, 27 Jan 2026 22:04:49 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rakesh Kudurumalla <rkudurumalla@marvell.com>
Subject: [PATCH 16/18] common/cnxk: initialize CPT LF for CQ config
Date: Wed, 28 Jan 2026 11:33:14 +0530
Message-ID: <20260128060316.3967610-16-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260128060316.3967610-1-rbhansali@marvell.com>
References: <20260128060316.3967610-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDA0NiBTYWx0ZWRfXyCBrES6Gp+eR
 y4Fcl2GamFMnY07VbAmeUaDY4bqQnqePnaOmig9x0WfiPPZCIV0aFIlzXXOKnRs53R2SBM6cfIK
 IC0jE5zusmo97eVptofXjg79RrvrjUNZsbNHNZ1sF8utjGibbbWWJ6nYGB7qr6BbRisslGsVeax
 oNh0/npCX3mLp0qNDHrN5oiHa50rSLrlCkhASrF4big90HyHUwmGfONroFuGSX4Jr79HnzPR+o+
 oCOA8f1eyZu1wvWJrdTbI+sYSTQ+QQopqUHIAuOHNK1WQsjYRhVXCQZy9sYXMehBUhnEuZxNI8j
 VWIHWAAxEjpt1NSZE5En2ksPmjDs29sQFBls72dhekJtQ5OLX/GqHwq7dveHFB/Uk4dceMiGbcv
 Gz5se1rDrddpJu1CfL9PNws7SqX2n9lAmaorqiqEdaGCUqc4jXco6KqG3IJXLBoMvQ3uKkGFyPl
 HKuEPj5jOVTAr5bImig==
X-Authority-Analysis: v=2.4 cv=P9E3RyAu c=1 sm=1 tr=0 ts=6979a71d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=fIBLxK7v8L62XoywYooA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: fPUFOwfB-Lni0D1lR8X6el_jUTJk4ELv
X-Proofpoint-GUID: fPUFOwfB-Lni0D1lR8X6el_jUTJk4ELv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_05,2026-01-27_03,2025-10-01_01
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

Initialize inline outbound CPT LF for CPT CQ
configurations.

Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
---
 drivers/common/cnxk/roc_nix_inl.c | 42 +++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/common/cnxk/roc_nix_inl.c b/drivers/common/cnxk/roc_nix_inl.c
index 917c2c669a..86d571c6e2 100644
--- a/drivers/common/cnxk/roc_nix_inl.c
+++ b/drivers/common/cnxk/roc_nix_inl.c
@@ -1573,8 +1573,18 @@ roc_nix_inl_outb_init(struct roc_nix *roc_nix)
 		lf->msixoff = nix->cpt_msixoff[i];
 		lf->pci_dev = nix->pci_dev;
 
+		if (roc_feature_nix_has_cpt_cq_support()) {
+			if (inl_dev && inl_dev->cpt_cq_ena) {
+				lf->dq_ack_ena = true;
+				lf->cpt_cq_ena = true;
+				lf->cq_entry_size = 0;
+				lf->cq_all = 0;
+				lf->cq_size = lf->nb_desc;
+			}
+		}
+
 		/* Setup CPT LF instruction queue */
-		rc = cpt_lf_init(lf, false);
+		rc = cpt_lf_init(lf, lf->cpt_cq_ena);
 		if (rc) {
 			plt_err("Failed to initialize CPT LF, rc=%d", rc);
 			goto lf_fini;
@@ -1591,6 +1601,13 @@ roc_nix_inl_outb_init(struct roc_nix *roc_nix)
 
 		/* Enable IQ */
 		roc_cpt_iq_enable(lf);
+		/* Enable CQ */
+		if (lf->cpt_cq_ena) {
+			rc = cpt_lf_register_irqs(lf, cpt_lf_misc_irq, nix_inl_cpt_done_irq);
+			if (rc)
+				goto lf_fini;
+			roc_cpt_cq_enable(lf);
+		}
 	}
 
 	if (!roc_nix->ipsec_out_max_sa)
@@ -1635,6 +1652,9 @@ roc_nix_inl_outb_init(struct roc_nix *roc_nix)
 	nix->outb_se_ring_base =
 		roc_nix->port_id * ROC_NIX_SOFT_EXP_PER_PORT_MAX_RINGS;
 
+	/* Fetch engine capabilities */
+	nix_inl_eng_caps_get(nix);
+
 	if (inl_dev == NULL || !inl_dev->set_soft_exp_poll) {
 		nix->outb_se_ring_cnt = 0;
 		return 0;
@@ -1658,13 +1678,15 @@ roc_nix_inl_outb_init(struct roc_nix *roc_nix)
 		}
 	}
 
-	/* Fetch engine capabilities */
-	nix_inl_eng_caps_get(nix);
 	return 0;
 
 lf_fini:
-	for (j = i - 1; j >= 0; j--)
-		cpt_lf_fini(&lf_base[j], false);
+	for (j = i - 1; j >= 0; j--) {
+		lf = &lf_base[j];
+		cpt_lf_fini(lf, lf->cpt_cq_ena);
+		if (lf->cpt_cq_ena)
+			cpt_lf_unregister_irqs(lf, cpt_lf_misc_irq, nix_inl_cpt_done_irq);
+	}
 	plt_free(lf_base);
 lf_free:
 	rc |= cpt_lfs_free(dev);
@@ -1681,6 +1703,7 @@ roc_nix_inl_outb_fini(struct roc_nix *roc_nix)
 	struct idev_cfg *idev = idev_get_cfg();
 	struct dev *dev = &nix->dev;
 	struct nix_inl_dev *inl_dev;
+	struct roc_cpt_lf *lf;
 	uint64_t *ring_base;
 	int i, rc, ret = 0;
 
@@ -1690,9 +1713,12 @@ roc_nix_inl_outb_fini(struct roc_nix *roc_nix)
 	nix->inl_outb_ena = false;
 
 	/* Cleanup CPT LF instruction queue */
-	for (i = 0; i < nix->nb_cpt_lf; i++)
-		cpt_lf_fini(&lf_base[i], false);
-
+	for (i = 0; i < nix->nb_cpt_lf; i++) {
+		lf = &lf_base[i];
+		cpt_lf_fini(lf, lf->cpt_cq_ena);
+		if (lf->cpt_cq_ena)
+			cpt_lf_unregister_irqs(lf, cpt_lf_misc_irq, nix_inl_cpt_done_irq);
+	}
 	/* Free LF resources */
 	rc = cpt_lfs_free(dev);
 	if (rc)
-- 
2.34.1

