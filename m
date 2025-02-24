Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217E0C021B5
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 09:41:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC48040A73;
	Mon, 24 Feb 2025 10:40:13 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id F1597406B7
 for <dev@dpdk.org>; Mon, 24 Feb 2025 10:40:11 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O8UrJT015460
 for <dev@dpdk.org>; Mon, 24 Feb 2025 01:40:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=n
 rtGN3CXa82xWqchOn6cip7OOuOcLnxusmIFPYF9pXU=; b=ftvIzzCoM/qZtL5Xq
 O6WXcgMzWTCvSnN/CjSWUnl4l7H3lanr6iPcw+wCTzmuyTv4CQq+DdzXP7tK2mPI
 QWz47Y66v0SP/nAuYs59qi/VUR2Vh6S4BpAro56h/rqpuaPq+6PMwEVwzEVg7zBB
 8/1rRhyaw69tFX7aliFG0o9micAwpDD2MLVYv0E7nd804ABRAnQ7QpgHmK6x6FGE
 g4KiaHk542oRRFo7CL92/GzL0qF/BuKPl0SOgle4fo1QLSTjE0qwlWPldRYLHpt9
 zxAFvYmir1L3XhHyJ1yhjgmn8ac52MHakalqIDvJdz4/jA1N/PeRNMDunMwmAycp
 OJcUA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 450nasg4h8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 24 Feb 2025 01:40:11 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Feb 2025 01:40:10 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 24 Feb 2025 01:40:10 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 71D8B3F7062;
 Mon, 24 Feb 2025 01:40:07 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: <jerinj@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>, "Kiran
 Kumar K" <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH v2 16/33] common/cnxk: update feature flags for cn20k
Date: Mon, 24 Feb 2025 15:08:58 +0530
Message-ID: <20250224093915.1253215-16-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224093915.1253215-1-ndabilpuram@marvell.com>
References: <20250131080530.3224977-1-ndabilpuram@marvell.com>
 <20250224093915.1253215-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: rRA28bHaYyAVnbN5HHZ1k_PjOZAUWNIc
X-Proofpoint-GUID: rRA28bHaYyAVnbN5HHZ1k_PjOZAUWNIc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_04,2025-02-24_01,2024-11-22_01
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

