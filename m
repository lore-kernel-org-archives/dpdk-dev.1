Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB73E83855
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 05:45:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50ACF40A89;
	Tue, 17 Feb 2026 06:45:12 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id E9C53406BB;
 Tue, 17 Feb 2026 06:45:10 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61H1NYAp1442388; Mon, 16 Feb 2026 21:45:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=A
 jBIQouvollcWpB68O5JQbvGmmBlLBLI8W0NLpsrriA=; b=ApjtyGiIVNqRSqFn0
 zCYMg5fcJVwQZf7wA5pNXnt5XvCxCSjXRvJZKrC5XPAR13bBEkN9ugHSJpU/2kWH
 96yY7SrX42gh3gVWnJE7oI88svaPbRAe4tKInFFcg9oPzWTzMyIY8f+fR3Q9s1Rr
 +fZS1DHDIIIeJqaBnmZ4In6StaGbe+2/sXK8+3RAPPce8gG/y2VAm4Ov0K2yFGQs
 zf6FbxMnZQYbmqZWgkyoE8i6z05VVN+hoa27paALzI1liptL62R+cMGvLu4/DV6d
 RvKsh8bM+SQ9ctWOZ2FXrPDko/uPprDv7PRzFL6MTNuKRFoSjsyBc1B0+UEjhTfl
 XVl6Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cbe6ck1n2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Feb 2026 21:45:10 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Feb 2026 21:45:25 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 16 Feb 2026 21:45:25 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 6F9995B696D;
 Mon, 16 Feb 2026 21:45:05 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, "Rakesh
 Kudurumalla" <rkudurumalla@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>,
 <stable@dpdk.org>
Subject: [PATCH v2 17/18] common/cnxk: fix CPT CQ roll over handling
Date: Tue, 17 Feb 2026 11:13:44 +0530
Message-ID: <20260217054345.2759687-17-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260217054345.2759687-1-rbhansali@marvell.com>
References: <20260128060316.3967610-1-rbhansali@marvell.com>
 <20260217054345.2759687-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=KO9XzVFo c=1 sm=1 tr=0 ts=69940066 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=wgwno-ROHo_tnHe101QA:9 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: QfpLkvIwBQgFUAznSCj2jFnHQmPS1fWj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA0NSBTYWx0ZWRfX15zbZOXAzXzq
 QZW7V530umJKnVon0bZFXhOdzCV3fn9bVSuX0g2KcVOKwWA7Uat1OZPeXCOc1XikHZSGhTuIAId
 WsE2RTPhaTyKUcjnjPI4+1idKtwDPHsIr8/CJz9UJEQd7BM3Cbe5r4WFY4Z3xf1zf3uCV7nhBiS
 22NogLdPwiHDuR+ZZC93mH5swvwkkXmnmPgC7HmdWnII9ueMgh8hOo9dY2vTf6vd3xzQvfMei8l
 IJgELPgIyJQZmTvZXpkuOmb3+C3ROj5O1XYodEdUUAUjneB14gecvxIEot3GHptvVpLwsEatYAd
 5H04rHizc/R3xRjSdKU4ebhFwa1oKe0bR9QzFUj/Y4Rvpe2nweHo+OZlAT/9UA1Slcp8GNPeh/q
 yo/SDdWD5ddO5UA1fCjK7WHztAMPXVftZYrJnsTsO12mVj4jeKOJB99+fYfdAdQTmTm2MrPjjlS
 QjSPDZSV6srcz7nZvxQ==
X-Proofpoint-GUID: QfpLkvIwBQgFUAznSCj2jFnHQmPS1fWj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_08,2026-02-16_04,2025-10-01_01
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

This fixes the handling of CPT CQ ring roll over case.

Fixes: a7d64a7740e0 ("net/cnxk: handle soft expiry")
Cc: stable@dpdk.org

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
Changes in v2: Updated commit message.

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

