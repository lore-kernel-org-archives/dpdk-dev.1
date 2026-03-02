Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9696DEA4E04
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 13:53:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B67F4025F;
	Mon,  2 Mar 2026 14:53:28 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 1F182400D7
 for <dev@dpdk.org>; Mon,  2 Mar 2026 14:53:26 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 621Mv1sv1475925 for <dev@dpdk.org>; Mon, 2 Mar 2026 05:53:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=1F2An7A4u0igi2x+e5kFt8O
 VEPFlJMdTb+SNTWwJilE=; b=TA4nRUKwWL7x+gjVUDUKKive8Gc+JX17Nz536d8
 mcUCH9bmvMlvULfmxI7VIUs3pV/ZxdvjjjemnyFQ+23+B831J09wEDFO6x1V+vAY
 MEDsIQ4x/+X6U+SFzMgdu2w6YxQlvFMW/UfOIwDIWUz9dCltrFG1CToq0W0kavN1
 p6gGlfoaI9/KuiC82zr6ej2OXgz4g/U5jFAvEzPUSrkqYEQBa14yi4fDptFHVXC9
 gT7cgR2t2bSacieeexdjumCQ8eHnx01fmSaQPPILFLCxUK3ZfRLwNgeG6ecBBcTD
 sJXRrtRELhIkUjKIfmSOQ6h8vSTJ+2jE0EpVqF6pTgIiMuw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ckxkp3fuk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 02 Mar 2026 05:53:26 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 2 Mar 2026 05:53:25 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 2 Mar 2026 05:53:25 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id BB3523F70CF;
 Mon,  2 Mar 2026 05:53:22 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH 1/2] common/cnxk: update RXC time config
Date: Mon, 2 Mar 2026 19:23:18 +0530
Message-ID: <20260302135319.1971488-1-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 9aevYCFr3aosHVqXc5Vw4NtWx9YP9679
X-Authority-Analysis: v=2.4 cv=eYUwvrEH c=1 sm=1 tr=0 ts=69a59656 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=dagZlYKSuQ3BrJktfyAA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 9aevYCFr3aosHVqXc5Vw4NtWx9YP9679
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDExNyBTYWx0ZWRfX4IUjOqtK+0z3
 xx+aV9o43ra5koFoU+Xq25p0CM9SbUPfxD+E1vX1BV+DMM3gdk47V+lLblAipmaj+NfqAMV0LBL
 5rduFvAHD+C+ydK1bBxDoR5U+7LtQPZ/PVmzcbxh8Bo6S2g526uBBDfrUwWsngV9BKt2Vd8qakp
 1sSSUQKX3ala2fDiyE181AE3jGNww8Z8VVupuJiGvk/yLDzMCesZ3BwMrYZlcdCOn1x7Uqlv3PZ
 e8MHBYIWmo1qg4W+Ah2aEI4VE22n0Ps2H7kRJvwd0aine8sFFH83psAFspHHCTw6EblJcqcOq2o
 IbdoK7FYDpAAclTDd//4kaxoY037amHEpGAtwb7iguXXfxeBU+8gkTo76ngdFSkauAGlOtuys7o
 uaxOTehH3yi+rijXa0r7nqXLP4RWz/xf1S5rmkpizDNhAB61xuFyBQm+7TJGlBU0jq3sDGpRzD1
 FMx4uNdfRwvcJHyFzow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-03-02_01,2025-10-01_01
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

For CN20k platform, CPT RXC time config is common across
all RXC queues. Reassembly configurations are updated to
have fix granularity and variable active limit time for
reassembly entries.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 drivers/common/cnxk/roc_nix.h     |  1 +
 drivers/common/cnxk/roc_nix_inl.c | 21 +++++++++++++++++----
 drivers/common/cnxk/roc_nix_inl.h |  2 ++
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/common/cnxk/roc_nix.h b/drivers/common/cnxk/roc_nix.h
index 7bc3e1f5c6..8ba8b3e0b6 100644
--- a/drivers/common/cnxk/roc_nix.h
+++ b/drivers/common/cnxk/roc_nix.h
@@ -605,6 +605,7 @@ struct roc_nix {
 	bool dis_xqe_drop;
 	bool sq_resize_ena;
 	uint8_t def_first_skip;
+	uint32_t rxc_step;
 	/* End of input parameters */
 	/* LMT line base for "Per Core Tx LMT line" mode*/
 	uintptr_t lmt_base;
diff --git a/drivers/common/cnxk/roc_nix_inl.c b/drivers/common/cnxk/roc_nix_inl.c
index 26be1adac9..0c6211e68e 100644
--- a/drivers/common/cnxk/roc_nix_inl.c
+++ b/drivers/common/cnxk/roc_nix_inl.c
@@ -973,19 +973,16 @@ roc_nix_reassembly_configure(struct roc_cpt_rxc_time_cfg *req_cfg, uint32_t max_
 	struct roc_cpt_rxc_time_cfg cfg;
 	struct roc_cpt *roc_cpt;
 	struct mbox *mbox;
+	uint32_t val;
 	int rc;
 
 	if (!idev)
 		return -EFAULT;
 
-	cfg.step = req_cfg->step ? req_cfg->step :
-				   (max_wait_time * 1000 / ROC_NIX_INL_REAS_ACTIVE_LIMIT);
 	cfg.zombie_limit =
 		req_cfg->zombie_limit ? req_cfg->zombie_limit : ROC_NIX_INL_REAS_ZOMBIE_LIMIT;
 	cfg.zombie_thres =
 		req_cfg->zombie_thres ? req_cfg->zombie_thres : ROC_NIX_INL_REAS_ZOMBIE_THRESHOLD;
-	cfg.active_limit =
-		req_cfg->active_limit ? req_cfg->active_limit : ROC_NIX_INL_REAS_ACTIVE_LIMIT;
 	cfg.active_thres =
 		req_cfg->active_thres ? req_cfg->active_thres : ROC_NIX_INL_REAS_ACTIVE_THRESHOLD;
 
@@ -995,6 +992,12 @@ roc_nix_reassembly_configure(struct roc_cpt_rxc_time_cfg *req_cfg, uint32_t max_
 			plt_err("Cryptodev not probed");
 			return -ENOTSUP;
 		}
+
+		val = max_wait_time ? (max_wait_time * 1000 / ROC_NIX_INL_REAS_ACTIVE_LIMIT) : 0;
+		cfg.step = req_cfg->step ? req_cfg->step : val;
+		cfg.active_limit = req_cfg->active_limit ? req_cfg->active_limit :
+							   ROC_NIX_INL_REAS_ACTIVE_LIMIT;
+
 		return roc_cpt_rxc_time_cfg(roc_cpt, &cfg);
 	}
 
@@ -1012,6 +1015,16 @@ roc_nix_reassembly_configure(struct roc_cpt_rxc_time_cfg *req_cfg, uint32_t max_
 		goto exit;
 	}
 
+	/* For CN20K, Configure step size fix and active limit per RXC queue,
+	 * Default CPT_AF_RXC_TIME_CFG::AGE_STEP will be 1ms, so max reassembly
+	 * timeout can be up to 4095 ms.
+	 */
+	cfg.step = req_cfg->step ? req_cfg->step : ROC_NIX_INL_REAS_STEP_DFLT;
+	val = max_wait_time ? (max_wait_time * 1000 / cfg.step) : 0;
+	cfg.active_limit = req_cfg->active_limit ? req_cfg->active_limit : val;
+	if (cfg.active_limit > ROC_NIX_INL_REAS_ACTIVE_LIMIT)
+		cfg.active_limit = ROC_NIX_INL_REAS_ACTIVE_LIMIT;
+
 	req->blkaddr = 0;
 	req->queue_id = inl_dev->nix_inb_qids[inl_dev->inb_cpt_lf_id];
 	req->step = cfg.step;
diff --git a/drivers/common/cnxk/roc_nix_inl.h b/drivers/common/cnxk/roc_nix_inl.h
index d1a08a4495..82dae4b1ba 100644
--- a/drivers/common/cnxk/roc_nix_inl.h
+++ b/drivers/common/cnxk/roc_nix_inl.h
@@ -36,6 +36,8 @@
 #define ROC_NIX_INL_INB_CUSTOM_SA_SZ 512
 
 /* Reassembly configuration */
+#define ROC_NIX_INL_REAS_STEP_MAX	  0xFFFFF
+#define ROC_NIX_INL_REAS_STEP_DFLT	  0x3E8 /* 1 ms */
 #define ROC_NIX_INL_REAS_ACTIVE_LIMIT	  0xFFF
 #define ROC_NIX_INL_REAS_ACTIVE_THRESHOLD 10
 #define ROC_NIX_INL_REAS_ZOMBIE_LIMIT	  0xFFF
-- 
2.34.1

