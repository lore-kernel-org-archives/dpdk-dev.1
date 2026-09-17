Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC988C982CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 07:14:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 945AA427C7;
	Thu, 17 Sep 2026 09:14:38 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 1D822427B3
 for <dev@dpdk.org>; Thu, 17 Sep 2026 09:14:37 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H60UmD2243063 for <dev@dpdk.org>; Thu, 17 Sep 2026 00:14:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=d
 B1HALpPnhUTVxm8pTrRdHDRMOQ0H8TNVFkjgZMjlec=; b=U4tgXm2OPv4/zoBcd
 fv6P8zrW9aSTxILggGnWgc3tcO0llZh6A5me7ZCCJYjzIHy4Se5BVcjHmpO1blnu
 mH8ApN84mMROpKCBAX7G1IMV/SlAJ8je6wwnjEOLMxmvLTOZpQUHOVF3nXEn7zzn
 jewI1gRpj4pb2pIGVqWct35/juLzyo4Ejji2eMuelvlmWRwEFMlP71VL/TjYXKrL
 8XeupEYrKw0cGpL0A36F/o0UZscet4DEnfy1QNMD9urg0NpbeeWA8PTPHjkoGiY+
 Q+pqMh4jerG64SvqK5nDOR5XrUOXsT6q7Kb2h7YEJ3jQE0a6KdFFBkaELL8aZXCH
 7GMPQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gr46023kv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 17 Sep 2026 00:14:36 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 17 Sep 2026 00:14:35 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 17 Sep 2026 00:14:35 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 064FB5C68E2;
 Thu, 17 Sep 2026 00:14:31 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rakesh Kudurumalla <rkudurumalla@marvell.com>,
 "Rahul Bhansali" <rbhansali@marvell.com>
Subject: [PATCH 07/14] common/cnxk: derive mbuf from CPT CQ in inline IRQ path
Date: Thu, 17 Sep 2026 12:40:09 +0530
Message-ID: <20260917071016.2366467-7-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260917071016.2366467-1-rbhansali@marvell.com>
References: <20260917071016.2366467-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: bfEMBs8wt6pgg_u8hUrUnTvUoW1LOBP_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA5NiBTYWx0ZWRfX6mlfBc4WfTE5
 in1EtQR9d2jnfcp9yMQOpURgoOnqOixnT1/tmLJly2UsGs3SNF1Woo3/8A6rmrEMOHYIAW3hJN3
 NCxZ72r6BniAFTVGUkR2ddBDVDIuNwE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA5NiBTYWx0ZWRfX4DraFnxxPhZw
 I0a3nV6owPKFw9uAfcMm0VOl7/zWN6DpwdfU7C7tPaVNRJDipUA6/L6Hni6nKIrW4B8LoklK6Wv
 5dnhwAoZkGP2spoCwo/QL9Vgaj0zQwTElQ/ZvBj9A7N9JNSL/87q6geoUTB4URfz7k5+jK+ps4t
 GyuV4fESvJc23TUUijRt/eZ89nHshiko6vQVZ+XYDZ1TXZA6y9GxWyl4QlgQcRYihioza+KmhOw
 r2NNNXPMvcdHzDeRQ3XmnvRFQCoUcTTxZHeCmQInxLygH4fkTX8eensOlyPc/q59jbMDZoCu86J
 c469cmHTzRnh3qP7GjPBgr5FlBWwueTSLAxDPWpdl8F3cnlzFnSTZnorz1xOK0AcfxA80Yy/VmS
 pDSxVlSbMmZ+ec5XE80Q8BMZ05bBewkZjbrhTrknHj4F46TJPdaH1eqokuvi3BZsuIPOIig1tEm
 g28aQjgtEvEqHPFTOBA==
X-Authority-Analysis: v=2.4 cv=VIJIDNPX c=1 sm=1 tr=0 ts=6aab935c cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=cz0cYkezwovTZ_AzRZQA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: bfEMBs8wt6pgg_u8hUrUnTvUoW1LOBP_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
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

Populate mbuf from WQE_PTR_CPTR and CPTR_WQE_PTR completions, handle
WQE_PTR_ANTI_REPLAY and CPTR_ANTI_REPLAY, and pass the mbuf pointer
into the inline device work callback instead of a fixed non-NULL
sentinel.

Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 drivers/common/cnxk/roc_nix_inl_dev_irq.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/common/cnxk/roc_nix_inl_dev_irq.c b/drivers/common/cnxk/roc_nix_inl_dev_irq.c
index f99c32f30b..dcf77a29a5 100644
--- a/drivers/common/cnxk/roc_nix_inl_dev_irq.c
+++ b/drivers/common/cnxk/roc_nix_inl_dev_irq.c
@@ -51,13 +51,15 @@ nix_inl_cpt_cq_cb(struct roc_cpt_lf *lf)
 	struct idev_cfg *idev = idev_get_cfg();
 	struct nix_inl_dev *inl_dev = NULL;
 	enum nix_inl_event_type cq_type;
+	uint32_t port_id = UINT32_MAX;
 	union cpt_lf_cq_base cq_base;
 	union cpt_lf_cq_ptr cq_ptr;
+	uint64_t gw[2] = {~0ULL, 0};
 	struct roc_nix *roc_nix;
 	struct cpt_cq_s *cq_s;
 	uint8_t fmt_msk = 0x3;
 	uint32_t count, head;
-	uint32_t port_id = UINT32_MAX;
+	void *wqe = NULL;
 	uint32_t nq_ptr;
 	struct nix *nix;
 	uint64_t i;
@@ -107,16 +109,26 @@ nix_inl_cpt_cq_cb(struct roc_cpt_lf *lf)
 			switch (cq_s->w2.s.fmt & fmt_msk) {
 			case WQE_PTR_CPTR:
 				sa = (void *)cq_s->w1.esn;
+				wqe = (void *)((uintptr_t)cq_s->w3.comp_ptr & ~0x7ULL);
 				break;
 			case CPTR_WQE_PTR:
 				sa = (void *)cq_s->w3.comp_ptr;
+				wqe = (void *)((uintptr_t)cq_s->w1.esn & ~0x7ULL);
+				break;
+			case WQE_PTR_ANTI_REPLAY:
+				sa = NULL;
+				wqe = (void *)((uintptr_t)cq_s->w3.comp_ptr & ~0x7ULL);
+				break;
+			case CPTR_ANTI_REPLAY:
+				sa = (void *)cq_s->w3.comp_ptr;
+				wqe = NULL;
 				break;
 			default:
 				plt_err("Invalid event Received ");
 				goto done;
 			}
-			uint64_t tmp = ~(uint32_t)0x0;
-			inl_dev->work_cb(&tmp, sa, cq_type, (void *)cq_s, port_id);
+			gw[1] = (uint64_t)(uintptr_t)wqe;
+			inl_dev->work_cb(gw, sa, cq_type, (void *)cq_s, port_id);
 		}
 done:
 		head = (head + 1) % lf->cq_size;
-- 
2.34.1

