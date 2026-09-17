Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03278C982C1
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 07:14:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8FA0A4279C;
	Thu, 17 Sep 2026 09:14:47 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id BC5A8427D8
 for <dev@dpdk.org>; Thu, 17 Sep 2026 09:14:45 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H60NQ12203204 for <dev@dpdk.org>; Thu, 17 Sep 2026 00:14:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=q
 4XIOiQQHCXIMfhq8oRxjkW/djJwXRO6AX46wx7Tq1o=; b=KHQdqu1+57ThlgOAP
 MxdjckrjHo3ZaEziK/UwJp7DbdODhi8dI21sikwvAGOWdeIoJDfk24rR7xDuUgjJ
 InZgZ59Gyg+0tOzQwahIjhi2iu7CnS04aIwvV7O5LYCZi+HUE9rXkvnnvrzP4UzT
 1Ta1bGim7AnWGqMIgVI8GLaDTCyOHXmyeSDrDDE0In8fGmyCZwk7gET6bYP1sJM9
 eAv0o4oJRABv8vukvl1kB6a1QgX843Rt1XM6TPeGXK1ySeLNXjp6jcyDpNRCIk3N
 V99/1TR6YCS/rxpMaYVaj8+g2Jx2KCezKfiQATtKHdhzKtket9P4iatKQBQ8DZ6V
 mSHPQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gra5yge2x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 17 Sep 2026 00:14:44 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 17 Sep 2026 00:14:43 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 17 Sep 2026 00:14:43 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 1EBF95C68E1;
 Thu, 17 Sep 2026 00:14:39 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH 09/14] common/cnxk: update bpid config for cn20k
Date: Thu, 17 Sep 2026 12:40:11 +0530
Message-ID: <20260917071016.2366467-9-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260917071016.2366467-1-rbhansali@marvell.com>
References: <20260917071016.2366467-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA5NiBTYWx0ZWRfX5hWb3VAzGueo
 c9lWvQWSZ/8zq30ZqTD2vl+zQUozyTJv9zAnaAIjuShHGLJnyTh7aEJ2N2H54ab/Ut4SmkRHsos
 ilnfBwA+Vm+Jrd09b5zIXsrvBR5anm8=
X-Proofpoint-GUID: Mq_TYT8nTfSKEqjsIX8-oLo5F2Rs1bY2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA5NiBTYWx0ZWRfX2h7UOH1Iq2c5
 SleodibDzMHV1DdeTgw/m4z7YG1C0UpotJBECBeQOtNIgA4DAtTGw2rFJ/x49/nEmgtaf5PlZiS
 F9cj4iIUuX3GokA3B9vfbBaffLG+3dKxtmxYKphfDKdJU6y9xRjK3+sUy2BDBS0HBO9AAHeMEf3
 U1PNNehXCPhVnPq21PHceNZNe1pS6wxbvXRLYPc1CvMO9QiuHe0j9MY2y95+CDtjGATAdA34609
 1rNrZ/55AlbWI+cEGaogE0S5jJAMfwzyx8aEYgw06w80XMLZc0Z5qjfQS7r2BfrjEGMsJc9MOeZ
 6dOTUfb98eMe23KfOw0I74aY1HSyS3tvqVqZ/ZT++zYWgdfRHzq1nX7vrdVvUPFHX6mlPrc0acw
 3YzCFKyWwceQrwcEMimKBD43rKRIValQUV7Arpf/JmxujnmK2/KcEpbIiasqu+roGXje3MuQpTn
 3/TYLlTt6EeJUZMMxvw==
X-Proofpoint-ORIG-GUID: Mq_TYT8nTfSKEqjsIX8-oLo5F2Rs1bY2
X-Authority-Analysis: v=2.4 cv=TekDJhQh c=1 sm=1 tr=0 ts=6aab9364 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=_dCiKOUHqU3D7TJxBCAA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
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

For cn20k, Rx chan bpid config range increased to 10 bit from 8
bits. These extra bits are reserved in cn10k platform so separate
platform specific bpid range mask is not required.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 drivers/common/cnxk/roc_nix_fc.c    | 30 +++++++++++++++--------------
 drivers/common/cnxk/roc_nix_queue.c |  1 +
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/common/cnxk/roc_nix_fc.c b/drivers/common/cnxk/roc_nix_fc.c
index ddabd15a5d..abf923b722 100644
--- a/drivers/common/cnxk/roc_nix_fc.c
+++ b/drivers/common/cnxk/roc_nix_fc.c
@@ -51,7 +51,7 @@ nix_fc_rxchan_bpid_set(struct roc_nix *roc_nix, bool enable)
 
 		nix->chan_cnt = rsp->chan_cnt;
 		for (i = 0; i < rsp->chan_cnt; i++)
-			nix->bpid[i] = rsp->chan_bpid[i] & 0x1FF;
+			nix->bpid[i] = rsp->chan_bpid[i] & 0x7FF;
 	} else {
 		req = mbox_alloc_msg_nix_bp_disable(mbox);
 		if (req == NULL)
@@ -86,7 +86,7 @@ nix_fc_rxchan_bpid_set(struct roc_nix *roc_nix, bool enable)
 		rc = mbox_process_msg(mbox, (void *)&rsp);
 		if (rc)
 			goto exit;
-		nix->cpt_lbpid = rsp->chan_bpid[0] & 0x1FF;
+		nix->cpt_lbpid = rsp->chan_bpid[0] & 0x7FF;
 	}
 
 	/* CPT to NIX BP on all channels */
@@ -333,6 +333,8 @@ nix_fc_cq_config_set(struct roc_nix *roc_nix, struct roc_nix_fc_cfg *fc_cfg)
 		if (fc_cfg->cq_cfg.enable) {
 			aq->cq.bpid = nix->bpid[fc_cfg->cq_cfg.tc];
 			aq->cq_mask.bpid = ~(aq->cq_mask.bpid);
+			aq->cq.bpid_ext = (nix->bpid[fc_cfg->cq_cfg.tc] >> 9) & 0x3;
+			aq->cq_mask.bpid_ext = ~(aq->cq_mask.bpid_ext);
 			aq->cq.bp = fc_cfg->cq_cfg.cq_bp;
 			aq->cq_mask.bp = ~(aq->cq_mask.bp);
 		}
@@ -903,33 +905,33 @@ roc_nix_chan_bpid_set(struct roc_nix *roc_nix, uint16_t chan, uint64_t bpid, int
 		return rc;
 
 	if (ena) {
-		if ((((cfg >> NIX_BPID1_OFF) & GENMASK_ULL(8, 0)) == bpid) ||
-		    (((cfg >> NIX_BPID2_OFF) & GENMASK_ULL(8, 0)) == bpid) ||
-		    (((cfg >> NIX_BPID3_OFF) & GENMASK_ULL(8, 0)) == bpid))
+		if ((((cfg >> NIX_BPID1_OFF) & GENMASK_ULL(10, 0)) == bpid) ||
+		    (((cfg >> NIX_BPID2_OFF) & GENMASK_ULL(10, 0)) == bpid) ||
+		    (((cfg >> NIX_BPID3_OFF) & GENMASK_ULL(10, 0)) == bpid))
 			return 0;
 
 		if (!(cfg & BIT_ULL(NIX_BPID1_ENA))) {
-			cfg &= ~GENMASK_ULL(NIX_BPID1_OFF + 8, NIX_BPID1_OFF);
+			cfg &= ~GENMASK_ULL(NIX_BPID1_OFF + 10, NIX_BPID1_OFF);
 			cfg |= (((uint64_t)bpid << NIX_BPID1_OFF) | BIT_ULL(NIX_BPID1_ENA));
 		} else if (!(cfg & BIT_ULL(NIX_BPID2_ENA))) {
-			cfg &= ~GENMASK_ULL(NIX_BPID2_OFF + 8, NIX_BPID2_OFF);
+			cfg &= ~GENMASK_ULL(NIX_BPID2_OFF + 10, NIX_BPID2_OFF);
 			cfg |= (((uint64_t)bpid << NIX_BPID2_OFF) | BIT_ULL(NIX_BPID2_ENA));
 		} else if (!(cfg & BIT_ULL(NIX_BPID3_ENA))) {
-			cfg &= ~GENMASK_ULL(NIX_BPID3_OFF + 8, NIX_BPID3_OFF);
+			cfg &= ~GENMASK_ULL(NIX_BPID3_OFF + 10, NIX_BPID3_OFF);
 			cfg |= (((uint64_t)bpid << NIX_BPID3_OFF) | BIT_ULL(NIX_BPID3_ENA));
 		} else {
 			plt_nix_dbg("Exceed maximum BPIDs");
 			return -ENOSPC;
 		}
 	} else {
-		if (((cfg >> NIX_BPID1_OFF) & GENMASK_ULL(8, 0)) == bpid) {
-			cfg &= ~(GENMASK_ULL(NIX_BPID1_OFF + 8, NIX_BPID1_OFF) |
+		if (((cfg >> NIX_BPID1_OFF) & GENMASK_ULL(10, 0)) == bpid) {
+			cfg &= ~(GENMASK_ULL(NIX_BPID1_OFF + 10, NIX_BPID1_OFF) |
 				 BIT_ULL(NIX_BPID1_ENA));
-		} else if (((cfg >> NIX_BPID2_OFF) & GENMASK_ULL(8, 0)) == bpid) {
-			cfg &= ~(GENMASK_ULL(NIX_BPID2_OFF + 8, NIX_BPID2_OFF) |
+		} else if (((cfg >> NIX_BPID2_OFF) & GENMASK_ULL(10, 0)) == bpid) {
+			cfg &= ~(GENMASK_ULL(NIX_BPID2_OFF + 10, NIX_BPID2_OFF) |
 				 BIT_ULL(NIX_BPID2_ENA));
-		} else if (((cfg >> NIX_BPID3_OFF) & GENMASK_ULL(8, 0)) == bpid) {
-			cfg &= ~(GENMASK_ULL(NIX_BPID3_OFF + 8, NIX_BPID3_OFF) |
+		} else if (((cfg >> NIX_BPID3_OFF) & GENMASK_ULL(10, 0)) == bpid) {
+			cfg &= ~(GENMASK_ULL(NIX_BPID3_OFF + 10, NIX_BPID3_OFF) |
 				 BIT_ULL(NIX_BPID3_ENA));
 		} else {
 			plt_nix_dbg("BPID not found");
diff --git a/drivers/common/cnxk/roc_nix_queue.c b/drivers/common/cnxk/roc_nix_queue.c
index ad8f62f38f..8e7e597be2 100644
--- a/drivers/common/cnxk/roc_nix_queue.c
+++ b/drivers/common/cnxk/roc_nix_queue.c
@@ -1258,6 +1258,7 @@ roc_nix_cn20k_cq_init(struct roc_nix *roc_nix, struct roc_nix_cq *cq)
 			cq_ctx->lbpid_low = cpt_lbpid & 0x7;
 			cq_ctx->lbpid_med = (cpt_lbpid >> 3) & 0x7;
 			cq_ctx->lbpid_high = (cpt_lbpid >> 6) & 0x7;
+			cq_ctx->lbpid_ext = (cpt_lbpid >> 9) & 0x3;
 			cq_ctx->lbp_frac = NIX_CQ_LBP_THRESH_FRAC;
 		}
 		drop_thresh = NIX_CQ_SEC_BP_THRESH_LEVEL;
-- 
2.34.1

