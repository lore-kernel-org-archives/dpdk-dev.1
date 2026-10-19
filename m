Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7138BCCF2DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 13:08:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 949494068E;
	Mon, 19 Oct 2026 15:08:14 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id D8187406FF
 for <dev@dpdk.org>; Mon, 19 Oct 2026 15:08:12 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8OdN6110851 for <dev@dpdk.org>; Mon, 19 Oct 2026 06:08:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=C
 AlgEo/SqtQSIo31iFB8j5T2iYrf53/9pwzN+C+6eJ4=; b=Y0R1bfbVdy4WPlhnA
 2A3zzj/TCmZ2DqcI/YEJYGy0pfUhepsyDlxPj80M53K228x+h6i7OEgj3DkFDuV0
 zlErTly6ykdFx4Lze2fSfWht/7G8myUB1sgG7atyT4BmcfbjEZMcUGNqA96ICE93
 WKFWhUxMUTF5R98XYpwAOra8dQcIWiy5EEFRowYyinbV6yUzpman8vdLsVCO6tOZ
 eVwwa4fDz/niv8RCK1yAnthgijrPV1B4OT1FSncifHyVmlexR2A+aeTy4fzU483E
 +1PsaaXMUsyTGdO1aq17dRK5kEDvRSkews86iAVYXjho8LS/4rDSgEDwg7BV5Mov
 0cfYw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4hc8hh4ymu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 19 Oct 2026 06:08:11 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 19 Oct 2026 06:08:11 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 19 Oct 2026 06:08:11 -0700
Received: from cavium-System-Product-Name.. (unknown [10.28.38.254])
 by maili.marvell.com (Postfix) with ESMTP id CA5803F704D;
 Mon, 19 Oct 2026 06:08:08 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, Ankur Dwivedi <adwivedi@marvell.com>,
 Rupesh Chiluka <rchiluka@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 03/16] crypto/cnxk: enable cq_all and allocate extra CQ line
Date: Mon, 19 Oct 2026 18:37:44 +0530
Message-ID: <20261019130759.2181566-4-ktejasree@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019130759.2181566-1-ktejasree@marvell.com>
References: <20261019130759.2181566-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: PbqFYfnSGrpTqxBU5IXHRV8AvFNooso0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfXxprhPjwaPf0u
 z2PLA02+p1P+83Au8jK97e0gmMfWzzjOTMNIm3xpZqUFA7VW5Zx8OAsADy3hrepzbajsPG2gzy3
 ReWEaA7A1bGKfRFyFQQgvkqsBou1YtKGn5mCGch+HUF5tHPttZmtNJsp6oZA1LsC1D98g8JWP0J
 gXCOCtGbXY3p/HyOYu0nPdsuXr53vxtSb/lVS4K8c/9YFyW9djIl7A1OFaPly4m+2IbIpaHHIWf
 iiJT34vH4p/j18a0bi8MY1Ab6QfqnouafJMNoZZYJFwXQXoOYnLu4lfEzwzVRSYNFAdCfOywj32
 OLKvVvoAm5EsIoHASP5MaeJFRDvT/W//OZ99TK7v+L+rwUAwXSGPJY3gkEa0fEaZ7pGw/Vauj+Z
 IFy+xqXqfdHI0+nA+EHUjD7eSpKFqaVMymd0fSJxQr75KsJ6vhozK9XoeE7J3cpddxVr5MMPmYZ
 U62IouvNKw5wFLxw+6w==
X-Proofpoint-GUID: PbqFYfnSGrpTqxBU5IXHRV8AvFNooso0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfX/sMrDe7KQm8y
 xbLSaAXC0swCfLgY9xalhuiZSX08VKSVo+hhCHH5s7wRhWkpazPZd8qQ8+F9AOEedHArHiX/TLD
 Pk1PJO8DAGleon2DPrsTWPx/OaLGsK8=
X-Authority-Analysis: v=2.4 cv=LfupeTfi c=1 sm=1 tr=0 ts=6ad6163b cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=kWswNmY4Dw_AnLsXgSkA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
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

With cq_all enabled, allocate one extra CQ line beyond the HW ring size
as HW is writing to Nth slot also and update the pending tail after
sym raw dequeue completes a request.

Signed-off-by: Tejasree Kondoj <ktejasree@marvell.com>
---
 drivers/common/cnxk/roc_cpt.c             | 7 +++++--
 drivers/crypto/cnxk/cn20k_cryptodev_ops.c | 1 +
 drivers/crypto/cnxk/cnxk_cryptodev_ops.c  | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/common/cnxk/roc_cpt.c b/drivers/common/cnxk/roc_cpt.c
index 9ba591d724..8c60a28fff 100644
--- a/drivers/common/cnxk/roc_cpt.c
+++ b/drivers/common/cnxk/roc_cpt.c
@@ -704,8 +704,11 @@ cpt_lf_cq_init(struct roc_cpt_lf *lf)
 	/* Disable CPT completion queue */
 	roc_cpt_cq_disable(lf);
 
-	/* Set command queue base address */
-	len = PLT_ALIGN(lf->cq_size * (ROC_CPT_CQ_ENTRY_SIZE_UNIT << lf->cq_entry_size), ROC_ALIGN);
+	/* Set completion queue (CQ) base address */
+	len = lf->cq_size;
+	if (roc_model_is_cn20k() && lf->cq_all)
+		len++;
+	len = PLT_ALIGN(len * (ROC_CPT_CQ_ENTRY_SIZE_UNIT << lf->cq_entry_size), ROC_ALIGN);
 	lf->cq_vaddr = plt_zmalloc(len, ROC_ALIGN);
 	if (lf->cq_vaddr == NULL)
 		return -ENOMEM;
diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
index 18100ff1f8..a63b97654b 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
@@ -1429,6 +1429,7 @@ cn20k_cpt_sym_raw_dequeue(void *qptr, uint8_t *drv_ctx, int *dequeue_status,
 	if (unlikely(infl_req->op_flags & CPT_OP_FLAGS_METABUF))
 		rte_mempool_put(qp->meta_info.pool, infl_req->mdata);
 
+	pend_q->tail = pq_tail;
 	*dequeue_status = 1;
 exit:
 	return opaque;
diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
index 6553ac90a1..1e0ea9d358 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
@@ -535,6 +535,7 @@ cnxk_cpt_queue_pair_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 		/* CQ entry size is 128B(32 << 2) */
 		qp->lf.cq_entry_size = 2;
 		qp->lf.cq_size = nb_desc;
+		qp->lf.cq_all = true;
 	}
 
 	ret = roc_cpt_lf_init(roc_cpt, &qp->lf);
-- 
2.43.0

