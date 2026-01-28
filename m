Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D68CD3567F
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 06:05:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C98064066A;
	Wed, 28 Jan 2026 07:05:22 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id D857B40659
 for <dev@dpdk.org>; Wed, 28 Jan 2026 07:05:20 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60RGPxkk1390280 for <dev@dpdk.org>; Tue, 27 Jan 2026 22:05:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=G
 /VhHPnvBammGEVADKa8cWJ5a/AXrgEgS6ofYiswe7U=; b=PsiTD35UPUQG343Sx
 M5Qh0G4j2u11ShOw64AUhCYLH8B8mC2+NE4VV5DBX5WFVoE+hBF0utJxSoJHkikp
 U0njXlsSd7zZmFckgYvjq3hvL8oiQrBhLNxZalCPFP3G2sRHrE0VNR6Za8Z3sBDi
 mNc0P7VkjrkXtMJFA9mDTwRGrMWz2yhRLBYWTlPwCeoX99To+VxGn8AIU9YnT4VK
 khpQKTvim+z7yjtU7uZEMR1odKLdRyhnTftxbHb0iIOdzaAZpbLea8KZsf/GY2N2
 xqExcKz9xNvwGivUiCaGwywAorZLnEMPp3dRk/ZeBQv2r6h4HdVNCnB0HTv6f2tk
 BMfEA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bx0qsws60-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 27 Jan 2026 22:05:18 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 Jan 2026 22:05:12 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 27 Jan 2026 22:05:12 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 1CA333F706F;
 Tue, 27 Jan 2026 22:04:53 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, "Rakesh
 Kudurumalla" <rkudurumalla@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH 17/18] common/cnxk: fix CPT CQ roll over handling
Date: Wed, 28 Jan 2026 11:33:15 +0530
Message-ID: <20260128060316.3967610-17-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260128060316.3967610-1-rbhansali@marvell.com>
References: <20260128060316.3967610-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDA0NiBTYWx0ZWRfXwvEKlJRzd60t
 8MhhCzjxVlsE4XUQEvg/vTsN0/EFoJ878milnYlibDztuJ+JRV+5ZtL4+r5VbGw6TA4UlaTfjN3
 gwAcivNKuxkY8zgtQmUCVzbE9gle4wxy0AzWMHyJLEJ35pGWTgMbEqiL4fnYZcGZI8cDx23Nwk+
 RJ5FPDQnm2YVgN1Zhrjd8dHBGuo62jJiOJM3oLLLjjvxfWQ1WY0zxpDxn+zgbo5LAvtQP01Xdc8
 w6FrAu9CpCqLVQU8fvlnSmXBfjJus59yuU7kQNkn9mZz0ItX5Fp/ds5mdIV+uasiL+YPmTcJobx
 VxNM0d7VkfcyqO7BZ3XhEDRI79TKbZIM8pWDkXBl2/heHCrFCrW7/gr9kPMdOIZu5lJPzoRUTio
 af9K0TR1LvLbA7QoBLzACfmSyRvkymHWFQGf8CYY0fCzfO6nvulf5m1IUvecO33Gy9EOUAwbBD8
 nkhYLesZYGm2oVagkvw==
X-Authority-Analysis: v=2.4 cv=P9E3RyAu c=1 sm=1 tr=0 ts=6979a71e cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=wgwno-ROHo_tnHe101QA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: -n8X29HqvThL3aLSk9viKoAosgCMTQ14
X-Proofpoint-GUID: -n8X29HqvThL3aLSk9viKoAosgCMTQ14
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

This fixes handling of CPT CQ ring roll over case.

Fixes: a7d64a7740e0 ("net/cnxk: handle soft expiry")

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 drivers/common/cnxk/roc_cpt.c             |  2 +-
 drivers/common/cnxk/roc_cpt.h             |  1 +
 drivers/common/cnxk/roc_nix_inl.c         |  1 +
 drivers/common/cnxk/roc_nix_inl_dev_irq.c | 18 ++++++++++++------
 4 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/common/cnxk/roc_cpt.c b/drivers/common/cnxk/roc_cpt.c
index 83e0c9896b..63419884ac 100644
--- a/drivers/common/cnxk/roc_cpt.c
+++ b/drivers/common/cnxk/roc_cpt.c
@@ -712,7 +712,7 @@ cpt_lf_cq_init(struct roc_cpt_lf *lf)
 
 	lf_cq_base.s.addr = addr >> 7;
 	plt_write64(lf_cq_base.u, lf->rbase + CPT_LF_CQ_BASE);
-	lf_cq_size.s.size = PLT_ALIGN(len, ROC_ALIGN);
+	lf_cq_size.s.size = lf->cq_size;
 	plt_write64(lf_cq_size.u, lf->rbase + CPT_LF_CQ_SIZE);
 
 	return 0;
diff --git a/drivers/common/cnxk/roc_cpt.h b/drivers/common/cnxk/roc_cpt.h
index 67956758be..7547d0b020 100644
--- a/drivers/common/cnxk/roc_cpt.h
+++ b/drivers/common/cnxk/roc_cpt.h
@@ -159,6 +159,7 @@ struct roc_cpt_lf {
 	bool cpt_cq_ena;
 	uint8_t cq_entry_size;
 	uint32_t cq_size;
+	uint32_t cq_head;
 	/* End of Input parameters */
 	struct plt_pci_device *pci_dev;
 	struct dev *dev;
diff --git a/drivers/common/cnxk/roc_nix_inl.c b/drivers/common/cnxk/roc_nix_inl.c
index 86d571c6e2..aad2631673 100644
--- a/drivers/common/cnxk/roc_nix_inl.c
+++ b/drivers/common/cnxk/roc_nix_inl.c
@@ -1580,6 +1580,7 @@ roc_nix_inl_outb_init(struct roc_nix *roc_nix)
 				lf->cq_entry_size = 0;
 				lf->cq_all = 0;
 				lf->cq_size = lf->nb_desc;
+				lf->cq_head = 1;
 			}
 		}
 
diff --git a/drivers/common/cnxk/roc_nix_inl_dev_irq.c b/drivers/common/cnxk/roc_nix_inl_dev_irq.c
index 1c4822925c..89155a1f7d 100644
--- a/drivers/common/cnxk/roc_nix_inl_dev_irq.c
+++ b/drivers/common/cnxk/roc_nix_inl_dev_irq.c
@@ -57,8 +57,8 @@ nix_inl_cpt_cq_cb(struct roc_cpt_lf *lf)
 	union cpt_lf_cq_ptr cq_ptr;
 	struct cpt_cq_s *cq_s;
 	uint8_t fmt_msk = 0x3;
-	uint64_t nq_ptr;
-	uint32_t count;
+	uint32_t count, head;
+	uint32_t nq_ptr;
 	uint64_t i;
 
 	if (idev)
@@ -69,14 +69,15 @@ nix_inl_cpt_cq_cb(struct roc_cpt_lf *lf)
 		return;
 	}
 
+	head = lf->cq_head;
 	cq_base.u = plt_read64(lf->rbase + CPT_LF_CQ_BASE);
 	cq_ptr.u = plt_read64(lf->rbase + CPT_LF_CQ_PTR);
 	count = cq_ptr.s.count;
-
-	nq_ptr = (((cq_base.s.addr << 7)) + ((cq_ptr.s.nq_ptr - count) << 5));
-	cq_s = (struct cpt_cq_s *)nq_ptr;
+	nq_ptr = cq_ptr.s.nq_ptr;
 
 	for (i = 0; i < count; i++) {
+		cq_s = (struct cpt_cq_s *)(uintptr_t)(((cq_base.s.addr << 7)) + (head << 5));
+
 		if (cq_s->w0.s.uc_compcode && cq_s->w0.s.compcode) {
 			switch (cq_s->w2.s.fmt & fmt_msk) {
 			case WQE_PTR_CPTR:
@@ -93,8 +94,13 @@ nix_inl_cpt_cq_cb(struct roc_cpt_lf *lf)
 			inl_dev->work_cb(&tmp, sa, NIX_INL_CPT_CQ, (void *)cq_s, port_id);
 		}
 done:
-		cq_s = cq_s + 1;
+		head = (head + 1) % lf->cq_size;
 	}
+
+	lf->cq_head = head;
+	if (unlikely(nq_ptr != head))
+		plt_err("CPT LF[%d] CQ head %d != NQ ptr %d", lf->lf_id, head, nq_ptr);
+
 	/* Acknowledge the number of completed requests */
 	plt_write64(count, lf->rbase + CPT_LF_DONE_ACK);
 }
-- 
2.34.1

