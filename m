Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42705CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 10:48:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4468A40650;
	Fri,  7 Nov 2025 11:48:20 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id D60C440678
 for <dev@dpdk.org>; Fri,  7 Nov 2025 11:48:17 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A79CHFI2746472 for <dev@dpdk.org>; Fri, 7 Nov 2025 02:48:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=b
 R3McQJCpyX4j3ySHhooD4161/T+zeLx/67SQ4r67dc=; b=WpmqGZ4MtPXA1xESt
 reg/8oUFtevNehbJx9EPYUIlNDtLEhMSj0bjstliwKR0l8Zs5RuD70zmIuoIzAYg
 P/8zEumIszHXTQdW5DplttRzsZMFa1u4ZeRPOubj3aLJt7ycX4FfZjiwF08FJGjr
 ufNUJJQQGfI1WO0ynr2WEBWpDWVWLSVLI9hksqXBb7udhiokw38RD0UhNanOXHcO
 fkbfGx9+xY3TX9XEN/OOakz1uVFv2WMVz51liHIO79jArAmBDg5stKtpWvtg7X7z
 m1pN7mwcyDp8BOJDQ5V82rJM+vqmRLLRg+bWjfNWhRuwt2r9VAOhw57T2QmP3zsv
 wrZkw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4a8pk65snq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 07 Nov 2025 02:48:17 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 7 Nov 2025 02:48:16 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 7 Nov 2025 02:48:16 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id CA7A23F70C9;
 Fri,  7 Nov 2025 02:48:08 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v4 06/23] common/cnxk: add new mailbox to configure LSO alt
 flags
Date: Fri, 7 Nov 2025 16:17:30 +0530
Message-ID: <20251107104747.1131008-6-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251107104747.1131008-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251107104747.1131008-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=IqYTsb/g c=1 sm=1 tr=0 ts=690dce71 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=CU7E9oUV1pDfIwHBpYMA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: BomUsbP8DTnK0bEM2Z96Kvo-ARhw6dB9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA4NyBTYWx0ZWRfX0H6SbzRTl5Ze
 RRYbHb9NTzmDn7sWuf15310quWNDlRBxFvYsOduIuJH6i50pTcq1VWaTIx9MBbw3pzMmQKy9dyI
 7SEdwQ6b0AOMtP+dxVPKUhF8SXbXNXeCQodeBq2qPsJjNznB1lrguTMsS62NUe5NUO/8kaNkyO1
 S0ncf67afNlPAjgSXUEb+fUo/rNRiIRWEcZqjU0mzRy4ahYS0LAvEaS7bYJTsGbJihSGH5Je6ei
 qyQ/tfHU5vEq9QSieBy0eSfLwxfNvsGaMqA4kMJt61idt1YHa7GoMUBpIKeC5Jy4I50PJtqq+0e
 Mun+nCLML7n/nzGIaI6z5jWgNY05iVI1P93kGFEbfTj1nI1J2G3vp2itzKT+/9JMI/LQJXew+rF
 L2Lnu+ZJA11+xUHlx3R1Rq+bkdk+cQ==
X-Proofpoint-ORIG-GUID: BomUsbP8DTnK0bEM2Z96Kvo-ARhw6dB9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
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

From: Satha Rao <skoteshwar@marvell.com>

LSO enahanced to support flags modification. Added new mbox to enable
this feature.

Signed-off-by: Satha Rao <skoteshwar@marvell.com>
---
 drivers/common/cnxk/hw/nix.h | 46 ++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/drivers/common/cnxk/hw/nix.h b/drivers/common/cnxk/hw/nix.h
index d16fa3b3ec..f5811ee1ab 100644
--- a/drivers/common/cnxk/hw/nix.h
+++ b/drivers/common/cnxk/hw/nix.h
@@ -2508,18 +2508,44 @@ struct nix_lso_format {
 	uint64_t sizem1 : 2;
 	uint64_t rsvd_14_15 : 2;
 	uint64_t alg : 3;
-	uint64_t rsvd_19_63 : 45;
+	uint64_t alt_flags : 1;
+	uint64_t alt_flags_index : 2;
+	uint64_t shift : 3;
+	uint64_t rsvd_25_63 : 39;
 };
 
-#define NIX_LSO_FIELD_MAX      (8)
-#define NIX_LSO_FIELD_ALG_MASK GENMASK(18, 16)
-#define NIX_LSO_FIELD_SZ_MASK  GENMASK(13, 12)
-#define NIX_LSO_FIELD_LY_MASK  GENMASK(9, 8)
-#define NIX_LSO_FIELD_OFF_MASK GENMASK(7, 0)
-
-#define NIX_LSO_FIELD_MASK                                                     \
-	(NIX_LSO_FIELD_OFF_MASK | NIX_LSO_FIELD_LY_MASK |                      \
-	 NIX_LSO_FIELD_SZ_MASK | NIX_LSO_FIELD_ALG_MASK)
+/* NIX LSO ALT_FLAGS field structure */
+typedef union nix_lso_alt_flg_format {
+	uint64_t u[2];
+
+	struct nix_lso_alt_flg_cfg {
+		/* NIX_AF_LSO_ALT_FLAGS_CFG */
+		uint64_t alt_msf_set : 16;
+		uint64_t alt_msf_mask : 16;
+		uint64_t alt_fsf_set : 16;
+		uint64_t alt_fsf_mask : 16;
+
+		/* NIX_AF_LSO_ALT_FLAGS_CFG1 */
+		uint64_t alt_lsf_set : 16;
+		uint64_t alt_lsf_mask : 16;
+		uint64_t alt_ssf_set : 16;
+		uint64_t alt_ssf_mask : 16;
+	} s;
+} nix_lso_alt_flg_format_t;
+
+#define NIX_LSO_FIELD_MAX	       (8)
+#define NIX_LSO_FIELD_SHIFT_MASK       GENMASK(24, 22)
+#define NIX_LSO_FIELD_ALT_FLG_IDX_MASK GENMASK(21, 20)
+#define NIX_LSO_FIELD_ALT_FLG_MASK     BIT_ULL(19)
+#define NIX_LSO_FIELD_ALG_MASK	       GENMASK(18, 16)
+#define NIX_LSO_FIELD_SZ_MASK	       GENMASK(13, 12)
+#define NIX_LSO_FIELD_LY_MASK	       GENMASK(9, 8)
+#define NIX_LSO_FIELD_OFF_MASK	       GENMASK(7, 0)
+
+#define NIX_LSO_FIELD_MASK                                                                         \
+	(NIX_LSO_FIELD_OFF_MASK | NIX_LSO_FIELD_LY_MASK | NIX_LSO_FIELD_SZ_MASK |                  \
+	 NIX_LSO_FIELD_ALG_MASK | NIX_LSO_FIELD_ALT_FLG_MASK | NIX_LSO_FIELD_ALT_FLG_IDX_MASK |    \
+	 NIX_LSO_FIELD_SHIFT_MASK)
 
 #define NIX_CN9K_MAX_HW_FRS 9212UL
 #define NIX_LBK_MAX_HW_FRS  65535UL
-- 
2.34.1

