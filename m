Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52124FD9E37
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 04:37:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B17F4066E;
	Fri, 27 Feb 2026 05:37:56 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id D5FE740670
 for <dev@dpdk.org>; Fri, 27 Feb 2026 05:37:54 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61QHW65H1536398 for <dev@dpdk.org>; Thu, 26 Feb 2026 20:37:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=w
 dgV1++y2UdQ/XyWSwoxex49UlTBCAdMHS0AH8E6qFc=; b=eNvgm+lm0xlx1NdU/
 S6YPmwUQy9EQ8QiiKrIN/NCEDUa6qrqqMufGw2f5tNdobca1SdLNCGAxWRS6aqpM
 miHHFXrAgObygK6tO7NF/TdHbqpc2ySPy7f0vG8Nk0u1zp1gVz50HR0eNrswBF4z
 oOoU2xeuXp8aZFGcYGJhZJQjchshsaDmvVekIfBZUO7xmz3KHMBJqdZYY4c/yqLz
 wJ2aHwzh5VmpfL+GGywVccXHvuTdZzmgkljkKMQlnQDkuZS5diJrIG/e2rynorcp
 4kDpo/U9Kjp4S9OJSrjmXyawUhx5iJ4c+SCScIH6v0LxR82Ozdcfl38PjkFUVEnE
 HRA1w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cjtnd9g4d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 26 Feb 2026 20:37:54 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Feb 2026 20:37:53 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 26 Feb 2026 20:37:53 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id B1F4C3F70CE;
 Thu, 26 Feb 2026 20:37:50 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH v3 4/8] common/cnxk: add RQ PB and WQE cache config
Date: Fri, 27 Feb 2026 10:07:19 +0530
Message-ID: <20260227043723.1986183-4-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227043723.1986183-1-rbhansali@marvell.com>
References: <20260219090847.3257753-1-rbhansali@marvell.com>
 <20260227043723.1986183-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: nwnxlb-gja4c0j8sML-X0VeJweWWajJs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDAzMSBTYWx0ZWRfX9TKdVEY1JZ/l
 AtuLgEA2hgrzCHoNsa72WtGTKZnDzuUuhq0SVdDN2aAF6hTI0yQYkCC04dF5xpOuvCIGonU16zE
 KN6YCk39Q5Ho4A6zRxYxaUexKyqM8eI6MMC3O8fNRq8sGLoj6AUejH2pm1OJXvaKGY37oRkzUKF
 zqJwRkD59as3cLowOR+AsLJL+GfR8prgMFskBDf3jmxf4FU1mFju0nN7tiiQBnbIbE9G6n9RnHw
 CW/pRVbv+KTCW9VKnrmAlqSSGyDSF5k+z5ntfDWi5z+Jk2KndrCFGNRDsshdlF+EbwzB5fKQM1g
 B8d4w39AucgTyKfRBS9TslQiyL3x6qH+KAcYA3Nn/lL6HKUIPcRdumkGsWQrQ2YbCbm8oM4UwxN
 QK07njK3Kiy6R42akCll1dgn1JnV2KvCWh3LbeeIA7oLlBGMEuM4MT1Q6UBFfplpLXHb0RTRGfz
 AJYPtJgUQ5mHo2fAMqA==
X-Proofpoint-ORIG-GUID: nwnxlb-gja4c0j8sML-X0VeJweWWajJs
X-Authority-Analysis: v=2.4 cv=WYMBqkhX c=1 sm=1 tr=0 ts=69a11fa2 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=QR93-xR_87IXRqM-4vsA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
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

Adds RQ's PB (Packet buffer) and WQE cache configuration
options.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
Changes in v2: No changes.
Changes in v3: No changes.

 drivers/common/cnxk/roc_nix.h       | 14 ++++++++++++++
 drivers/common/cnxk/roc_nix_inl.c   |  2 ++
 drivers/common/cnxk/roc_nix_queue.c | 16 ++++++++--------
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/common/cnxk/roc_nix.h b/drivers/common/cnxk/roc_nix.h
index ffa1a706f9..7bc3e1f5c6 100644
--- a/drivers/common/cnxk/roc_nix.h
+++ b/drivers/common/cnxk/roc_nix.h
@@ -34,6 +34,16 @@
 #define ROC_NIX_LSO_FORMAT_IDX_TSOV6 1
 #define ROC_NIX_LSO_FORMAT_IDX_IPV4  2

+#define ROC_NIX_RQ_MAX_PB_CACHING_VAL 3
+
+/* First aligned cache block is allocated into the LLC.
+ * All remaining cache blocks are not allocated.
+ */
+#define ROC_NIX_RQ_DEFAULT_PB_CACHING 2
+
+/* Writes of WQE data are allocated into LLC. */
+#define ROC_NIX_RQ_DEFAULT_WQE_CACHING 1
+
 enum roc_nix_rss_reta_sz {
 	ROC_NIX_RSS_RETA_SZ_64 = 64,
 	ROC_NIX_RSS_RETA_SZ_128 = 128,
@@ -448,6 +458,10 @@ struct roc_nix_rq {
 	bool spb_drop_ena;
 	/* XQE drop enable */
 	bool xqe_drop_ena;
+	/* RQ PB caching */
+	uint8_t pb_caching;
+	/* RQ WQE caching */
+	uint8_t wqe_caching;
 	/* End of Input parameters */
 	struct roc_nix *roc_nix;
 	uint64_t meta_aura_handle;
diff --git a/drivers/common/cnxk/roc_nix_inl.c b/drivers/common/cnxk/roc_nix_inl.c
index a21c40acf1..911c349604 100644
--- a/drivers/common/cnxk/roc_nix_inl.c
+++ b/drivers/common/cnxk/roc_nix_inl.c
@@ -1838,6 +1838,8 @@ roc_nix_inl_dev_rq_get(struct roc_nix_rq *rq, bool enable)
 	inl_rq->spb_ena = rq->spb_ena;
 	inl_rq->spb_aura_handle = rq->spb_aura_handle;
 	inl_rq->spb_size = rq->spb_size;
+	inl_rq->pb_caching = rq->pb_caching;
+	inl_rq->wqe_caching = rq->wqe_caching;

 	if (roc_errata_nix_no_meta_aura()) {
 		uint64_t aura_limit =
diff --git a/drivers/common/cnxk/roc_nix_queue.c b/drivers/common/cnxk/roc_nix_queue.c
index ab3a71ec60..ef9b651022 100644
--- a/drivers/common/cnxk/roc_nix_queue.c
+++ b/drivers/common/cnxk/roc_nix_queue.c
@@ -499,7 +499,7 @@ nix_rq_cn9k_cfg(struct dev *dev, struct roc_nix_rq *rq, uint16_t qints,
 		aq->rq.sso_grp = rq->hwgrp;
 		aq->rq.ena_wqwd = 1;
 		aq->rq.wqe_skip = rq->wqe_skip;
-		aq->rq.wqe_caching = 1;
+		aq->rq.wqe_caching = rq->wqe_caching;

 		aq->rq.good_utag = rq->tag_mask >> 24;
 		aq->rq.bad_utag = rq->tag_mask >> 24;
@@ -530,7 +530,7 @@ nix_rq_cn9k_cfg(struct dev *dev, struct roc_nix_rq *rq, uint16_t qints,
 	aq->rq.lpb_sizem1 = rq->lpb_size / 8;
 	aq->rq.lpb_sizem1 -= 1; /* Expressed in size minus one */
 	aq->rq.ena = ena;
-	aq->rq.pb_caching = 0x2; /* First cache aligned block to LLC */
+	aq->rq.pb_caching = rq->pb_caching;
 	aq->rq.xqe_imm_size = 0; /* No pkt data copy to CQE */
 	aq->rq.rq_int_ena = 0;
 	/* Many to one reduction */
@@ -616,7 +616,7 @@ nix_rq_cn10k_cfg(struct dev *dev, struct roc_nix_rq *rq, uint16_t qints, bool cf
 		aq->rq.sso_grp = rq->hwgrp;
 		aq->rq.ena_wqwd = 1;
 		aq->rq.wqe_skip = rq->wqe_skip;
-		aq->rq.wqe_caching = 1;
+		aq->rq.wqe_caching = rq->wqe_caching;

 		aq->rq.xqe_drop_ena = 0;
 		aq->rq.good_utag = rq->tag_mask >> 24;
@@ -647,7 +647,7 @@ nix_rq_cn10k_cfg(struct dev *dev, struct roc_nix_rq *rq, uint16_t qints, bool cf
 		aq->rq.ipsecd_drop_en = 1;
 		aq->rq.ena_wqwd = 1;
 		aq->rq.wqe_skip = rq->wqe_skip;
-		aq->rq.wqe_caching = 1;
+		aq->rq.wqe_caching = rq->wqe_caching;
 	}

 	aq->rq.lpb_aura = roc_npa_aura_handle_to_aura(rq->aura_handle);
@@ -683,7 +683,7 @@ nix_rq_cn10k_cfg(struct dev *dev, struct roc_nix_rq *rq, uint16_t qints, bool cf
 		aq->rq.spb_ena = 0;
 	}

-	aq->rq.pb_caching = 0x2; /* First cache aligned block to LLC */
+	aq->rq.pb_caching = rq->pb_caching;
 	aq->rq.xqe_imm_size = 0; /* No pkt data copy to CQE */
 	aq->rq.rq_int_ena = 0;
 	/* Many to one reduction */
@@ -797,7 +797,7 @@ nix_rq_cfg(struct dev *dev, struct roc_nix_rq *rq, uint16_t qints, bool cfg, boo
 		aq->rq.sso_grp = rq->hwgrp;
 		aq->rq.ena_wqwd = 1;
 		aq->rq.wqe_skip = rq->wqe_skip;
-		aq->rq.wqe_caching = 1;
+		aq->rq.wqe_caching = rq->wqe_caching;

 		aq->rq.good_utag = rq->tag_mask >> 24;
 		aq->rq.bad_utag = rq->tag_mask >> 24;
@@ -816,7 +816,7 @@ nix_rq_cfg(struct dev *dev, struct roc_nix_rq *rq, uint16_t qints, bool cfg, boo
 		aq->rq.ipsecd_drop_en = 1;
 		aq->rq.ena_wqwd = 1;
 		aq->rq.wqe_skip = rq->wqe_skip;
-		aq->rq.wqe_caching = 1;
+		aq->rq.wqe_caching = rq->wqe_caching;
 	}

 	aq->rq.lpb_aura = roc_npa_aura_handle_to_aura(rq->aura_handle);
@@ -852,7 +852,7 @@ nix_rq_cfg(struct dev *dev, struct roc_nix_rq *rq, uint16_t qints, bool cfg, boo
 		aq->rq.spb_ena = 0;
 	}

-	aq->rq.pb_caching = 0x2; /* First cache aligned block to LLC */
+	aq->rq.pb_caching = rq->pb_caching;
 	aq->rq.xqe_imm_size = 0; /* No pkt data copy to CQE */
 	aq->rq.rq_int_ena = 0;
 	/* Many to one reduction */
--
2.34.1

