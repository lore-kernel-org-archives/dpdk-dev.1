Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28116FCE078
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 13:18:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 309DE4065A;
	Thu, 26 Feb 2026 14:18:23 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 7C5E0402CE
 for <dev@dpdk.org>; Thu, 26 Feb 2026 14:18:21 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61Q6NBaO3056423 for <dev@dpdk.org>; Thu, 26 Feb 2026 05:18:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=t
 k9cs2s84f+JyrYTBoEZ5GtlpBGS8gl9bD+o9gayf8o=; b=Jn0najWaSrQuUsMdO
 d++1mTtc2U1qGhMdtKgMmUUbHpkqpyM7yMm0o13k2QN2pAlv4A1X9JFmoDW1Sjt/
 0Fwwe9DmNauL9SWPvXRWDe76jsG+fv6rlOQ4+avtUGGMaXJAI3a4eRnJ2qDQnIn5
 ahj1EYAefwsQPDGdfChfGjE5b2xu0t91Ljptgdab0Tn5rejaVYh5XTShrBqOs35E
 DFlQnG7uPsjrhRToKJ9qiXAHmEiXt3edoeeiTWOvGEhzmFacWrYc6MI44giMtrzW
 7+syRHBCDd9n2+oFrgpsHo6g59UREmyP0uiBtQd2ImuF+ALE+zJV++Grqs/+lpit
 fwvRQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4chnp8vpgj-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 26 Feb 2026 05:18:20 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Feb 2026 05:18:19 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 26 Feb 2026 05:18:19 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 1F3B73F70D4;
 Thu, 26 Feb 2026 05:18:16 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH v2 3/8] common/cnxk: update platform features
Date: Thu, 26 Feb 2026 18:47:10 +0530
Message-ID: <20260226131715.2851091-3-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260226131715.2851091-1-rbhansali@marvell.com>
References: <20260219090847.3257753-1-rbhansali@marvell.com>
 <20260226131715.2851091-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: CxJQrG6PPK0fi7xwMr57qW9TVuOxdrXr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDEyMCBTYWx0ZWRfX+gahzmsQPoxr
 acUOZtbUmlOfHsYDEjrDBcJOlhXw3/6ORShzv9WspO0XX00oRNxsXGCk7fp+P4T6gBKJK6OphT6
 jyqSzeESIHWFwVPoBRHjkM+dVygM0D8hHJEC0GwPa57L2qQrFrC61oxSxgUN3OLUQYeOg0P7CyY
 1fA5pQAwB93a4ky7dLyddP631PZz6N1DYC1O+QSe19U7eKb6WYv3uSOcZrASQtvp3eXmKjRwfZj
 PL6GAv1tyHIclFq6EqMAlX93zrk7Hzd+YloIYLbfruLQx9Wvvo/xoSrpMczCBpmSY2VVrGQkLC6
 3+mIewyB1arvJpvSZ2Iq4xhAgnIHktbEh+ky9WyepBOgad7y2juQON7x1UqAo0Da9FfcWgBKRev
 RlX0mg3+tuaHIGDgSxjx52+mqLahkNetF8mNau2Wz2bnA/at/WUZA+LkuaR56WNE7QKZhi4hf+T
 vFJ3oIB+gmHukCRPuBQ==
X-Authority-Analysis: v=2.4 cv=bNYb4f+Z c=1 sm=1 tr=0 ts=69a0481c cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=v69dt79VaSGfBV6H58AA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: CxJQrG6PPK0fi7xwMr57qW9TVuOxdrXr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-26_01,2025-10-01_01
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

Adds cnf20ka platform check for plain packet reassembly
features.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
Changes in v2: No changes.

 drivers/common/cnxk/roc_features.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/common/cnxk/roc_features.h b/drivers/common/cnxk/roc_features.h
index 3c34041d76..57a51c4db3 100644
--- a/drivers/common/cnxk/roc_features.h
+++ b/drivers/common/cnxk/roc_features.h
@@ -117,7 +117,7 @@ roc_feature_nix_has_inl_profile(void)
 static inline bool
 roc_feature_nix_has_plain_pkt_reassembly(void)
 {
-	return roc_model_is_cn20k();
+	return roc_model_is_cn20k() && !roc_model_is_cnf20ka();
 }

 static inline bool
--
2.34.1

