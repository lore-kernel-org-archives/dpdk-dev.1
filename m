Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB33D3567B
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 06:03:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 936C6402C4;
	Wed, 28 Jan 2026 07:03:45 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 443F5402C1
 for <dev@dpdk.org>; Wed, 28 Jan 2026 07:03:44 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60S1N3gq3583494 for <dev@dpdk.org>; Tue, 27 Jan 2026 22:03:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=/
 uAJRroHAinuTIz/ndGMnCnYa4E2wOheO4k+uEQwf50=; b=RoVBXPUA8EirrcYil
 mpmvsQhR9/834tg2K0CVEZPTv1Yf+6pDIJc+SoLppMxqtjGJWEMdrvi55C+fvmb6
 hb6Kgd593VYF7NYyPobUFKmWPZIW2+QuMKBBmlPMLMzT27sLUzV+yW1c1kaxTrJS
 K4ft/xJn/J4ptQDBckT7WGH2d62DffKRIgtNuV7LDRhzhlXtJWYV+pEOVMOeYdpL
 mBqeW9oTbTLhEq4eUemF8RyWsVxWBLNJQBjrq5+4ngzH21/bxVH+zaSTjWZcU1Ls
 V90vVci7T1jBrdDW8iCfKTagZEFBHGTP1P3BeHBNhkybm1zS6UZWBQPVchMHMDwG
 8zxnA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4by8r68ey7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 27 Jan 2026 22:03:43 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 Jan 2026 22:03:42 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 27 Jan 2026 22:03:42 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 391603F706F;
 Tue, 27 Jan 2026 22:03:39 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH 02/18] common/cnxk: remove dependency on cryptodev for RXC
Date: Wed, 28 Jan 2026 11:33:00 +0530
Message-ID: <20260128060316.3967610-2-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260128060316.3967610-1-rbhansali@marvell.com>
References: <20260128060316.3967610-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Ka/fcAYD c=1 sm=1 tr=0 ts=6979a6bf cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=9npsj7kXmYjgGsbYTpYA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDA0NiBTYWx0ZWRfX1ur2+54tXDAD
 q3PgDdbCxUqNAD+AKN56NOSSxMoIlctiZnZw9EZISEfuBWZmKUIQQs0VzjY77PmyKmOscOFu+Hx
 /WNNL+IgmUlT7Aorxdhlji8+U4UqUUxhzdnXXtKbJ+wk/kzlQovYV14NivP32m/JOtV09U/3oWb
 i5KiaSmuG4AuVuwbQUyFC5oTQW7hOw7W8w9vNUyPaBJjYI7/KTejedRj63JIpWsG6VRrz+Fh6Gu
 QTFeuYNKG/wK9SOLF8ZruC/YWflbIPaU1c0HIwZIsN64H/U+woaIG9W40u76HfnVKA56flvv5Wt
 5Uth9Y+AkxWKmRt0IKeM2mJpfzYl15pu9Pv+yVbBsyl35s3NieZWpFQu+gMD4GA8kq9kAnhg9E0
 el7b/Z4qRRq2YBIf7I41l6BRJ/InhmcNmGB0XM+FaBINV9wIBtREtd2bviZyHsrUEfewYs9OH14
 PfHXXGREOZ1cMjX/MAg==
X-Proofpoint-GUID: A08ZZJJJmPW2lHw2oUCTwd6-JOEY4vhV
X-Proofpoint-ORIG-GUID: A08ZZJJJmPW2lHw2oUCTwd6-JOEY4vhV
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

Removes dependency on probe of cryptodev for reassembly
configuration and included RXC queue config for cn20k
platform.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 drivers/common/cnxk/roc_nix_inl.c | 15 ++++++++-------
 drivers/common/cnxk/roc_nix_inl.h |  2 ++
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/common/cnxk/roc_nix_inl.c b/drivers/common/cnxk/roc_nix_inl.c
index 683a9cc7ce..86bafd5c33 100644
--- a/drivers/common/cnxk/roc_nix_inl.c
+++ b/drivers/common/cnxk/roc_nix_inl.c
@@ -968,12 +968,6 @@ roc_nix_reassembly_configure(struct roc_cpt_rxc_time_cfg *req_cfg, uint32_t max_
 	if (!idev)
 		return -EFAULT;
 
-	roc_cpt = idev->cpt;
-	if (!roc_cpt) {
-		plt_err("Cannot support inline inbound, cryptodev not probed");
-		return -ENOTSUP;
-	}
-
 	cfg.step = req_cfg->step ? req_cfg->step :
 				   (max_wait_time * 1000 / ROC_NIX_INL_REAS_ACTIVE_LIMIT);
 	cfg.zombie_limit =
@@ -985,8 +979,14 @@ roc_nix_reassembly_configure(struct roc_cpt_rxc_time_cfg *req_cfg, uint32_t max_
 	cfg.active_thres =
 		req_cfg->active_thres ? req_cfg->active_thres : ROC_NIX_INL_REAS_ACTIVE_THRESHOLD;
 
-	if (roc_model_is_cn10k())
+	if (roc_model_is_cn10k()) {
+		roc_cpt = idev->cpt;
+		if (!roc_cpt) {
+			plt_err("Cryptodev not probed");
+			return -ENOTSUP;
+		}
 		return roc_cpt_rxc_time_cfg(roc_cpt, &cfg);
+	}
 
 	inl_dev = idev->nix_inl_dev;
 	if (!inl_dev) {
@@ -1009,6 +1009,7 @@ roc_nix_reassembly_configure(struct roc_cpt_rxc_time_cfg *req_cfg, uint32_t max_
 	req->zombie_thres = cfg.zombie_thres;
 	req->active_limit = cfg.active_limit;
 	req->active_thres = cfg.active_thres;
+	req->cpt_af_rxc_que_cfg = ROC_NIX_INL_RXC_QUE_BLK_THR << 32;
 
 	rc = mbox_process(mbox);
 exit:
diff --git a/drivers/common/cnxk/roc_nix_inl.h b/drivers/common/cnxk/roc_nix_inl.h
index 7970ac2258..68f395438c 100644
--- a/drivers/common/cnxk/roc_nix_inl.h
+++ b/drivers/common/cnxk/roc_nix_inl.h
@@ -41,6 +41,8 @@
 #define ROC_NIX_INL_REAS_ZOMBIE_LIMIT	  0xFFF
 #define ROC_NIX_INL_REAS_ZOMBIE_THRESHOLD 10
 
+#define ROC_NIX_INL_RXC_QUE_BLK_THR 0x40UL
+
 enum nix_inl_event_type {
 	NIX_INL_CPT_CQ = 1,
 	NIX_INL_SSO,
-- 
2.34.1

