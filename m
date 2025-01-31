Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F9FC0218D
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 08:07:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 015D34279F;
	Fri, 31 Jan 2025 09:06:28 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 67F1F4279F
 for <dev@dpdk.org>; Fri, 31 Jan 2025 09:06:26 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50V7pHbN014754
 for <dev@dpdk.org>; Fri, 31 Jan 2025 00:06:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=n
 rtGN3CXa82xWqchOn6cip7OOuOcLnxusmIFPYF9pXU=; b=M3vEZZMZ6uCG+5JSS
 ZTTIXR6+kKfd6wxBLvIIiI8h8bMLUNwG1jXdYzril+6naLc128W9HNOd8c6GxwHR
 9vEM07nhvhAWS2B/MEjHh6E4BC7lc02WRtR+mRWsbNJAUo4GNQmvJ4YLVsXtVrzW
 3RW8Xndw71kEE9L0kVC2XcdAh5KVPiC8SQ5axQiZdjfjIZOnGhXp5ckpdIPqJKZf
 EwktYCf8EC1/pQ/ZeG1XO7oyz/VvUt5qm2rLMtdeiV01U6F/Jp1zE7s9/sR2aDQy
 z0/+xGaCze7el0fvVQZhsf+1Dxo5E3jU50hjeODmklShzlbmwnlQrOxA1aMPjjLE
 LY0sA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44gsr3g32q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 31 Jan 2025 00:06:25 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 31 Jan 2025 00:06:24 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 31 Jan 2025 00:06:24 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id D5D553F7045;
 Fri, 31 Jan 2025 00:06:21 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: <jerinj@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>, "Kiran
 Kumar K" <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH 16/34] common/cnxk: update feature flags for cn20k
Date: Fri, 31 Jan 2025 13:35:11 +0530
Message-ID: <20250131080530.3224977-16-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250131080530.3224977-1-ndabilpuram@marvell.com>
References: <20250131080530.3224977-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: G6093HSvA0h7kaXDBhY-tn2ncWVVxd43
X-Proofpoint-GUID: G6093HSvA0h7kaXDBhY-tn2ncWVVxd43
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_03,2025-01-30_01,2024-11-22_01
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

From: Rahul Bhansali <rbhansali@marvell.com>

Features updated for cn20k platform.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 drivers/common/cnxk/roc_features.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/common/cnxk/roc_features.h b/drivers/common/cnxk/roc_features.h
index 0002a7b5c3..59c09fbc85 100644
--- a/drivers/common/cnxk/roc_features.h
+++ b/drivers/common/cnxk/roc_features.h
@@ -13,49 +13,49 @@ roc_feature_sso_has_stash(void)
 static inline bool
 roc_feature_nix_has_inl_ipsec_mseg(void)
 {
-	return (roc_model_is_cn10kb() || roc_model_is_cn10ka_b0());
+	return (roc_model_is_cn20k() || roc_model_is_cn10kb() || roc_model_is_cn10ka_b0());
 }
 
 static inline bool
 roc_feature_nix_has_drop_re_mask(void)
 {
-	return (roc_model_is_cn10kb() || roc_model_is_cn10ka_b0());
+	return (roc_model_is_cn20k() || roc_model_is_cn10kb() || roc_model_is_cn10ka_b0());
 }
 
 static inline bool
 roc_feature_nix_has_inl_rq_mask(void)
 {
-	return (roc_model_is_cn10kb() || roc_model_is_cn10ka_b0());
+	return (roc_model_is_cn20k() || roc_model_is_cn10kb() || roc_model_is_cn10ka_b0());
 }
 
 static inline bool
 roc_feature_nix_has_own_meta_aura(void)
 {
-	return (roc_model_is_cn10kb() || roc_model_is_cn10ka_b0());
+	return (roc_model_is_cn20k() || roc_model_is_cn10kb() || roc_model_is_cn10ka_b0());
 }
 
 static inline bool
 roc_feature_nix_has_late_bp(void)
 {
-	return (roc_model_is_cn10kb() || roc_model_is_cn10ka_b0());
+	return (roc_model_is_cn20k() || roc_model_is_cn10kb() || roc_model_is_cn10ka_b0());
 }
 
 static inline bool
 roc_feature_nix_has_reass(void)
 {
-	return roc_model_is_cn10ka();
+	return (roc_model_is_cn20k() || roc_model_is_cn10ka());
 }
 
 static inline bool
 roc_feature_nix_has_cqe_stash(void)
 {
-	return roc_model_is_cn10ka_b0();
+	return (roc_model_is_cn20k() || roc_model_is_cn10ka_b0());
 }
 
 static inline bool
 roc_feature_nix_has_rxchan_multi_bpid(void)
 {
-	if (roc_model_is_cn10kb() || roc_model_is_cn10ka_b0())
+	if (roc_model_is_cn20k() || roc_model_is_cn10kb() || roc_model_is_cn10ka_b0())
 		return true;
 	return false;
 }
@@ -63,7 +63,7 @@ roc_feature_nix_has_rxchan_multi_bpid(void)
 static inline bool
 roc_feature_nix_has_age_drop_stats(void)
 {
-	return (roc_model_is_cn10kb() || roc_model_is_cn10ka_b0());
+	return (roc_model_is_cn20k() || roc_model_is_cn10kb() || roc_model_is_cn10ka_b0());
 }
 
 static inline bool
@@ -87,13 +87,13 @@ roc_feature_nix_has_inl_ipsec(void)
 static inline bool
 roc_feature_nix_has_rx_inject(void)
 {
-	return (roc_model_is_cn10ka_b0() || roc_model_is_cn10kb());
+	return (roc_model_is_cn20k() || roc_model_is_cn10ka_b0() || roc_model_is_cn10kb());
 }
 
 static inline bool
 roc_feature_nix_has_second_pass_drop(void)
 {
-	return 0;
+	return roc_model_is_cn20k();
 }
 
 static inline bool
-- 
2.34.1

