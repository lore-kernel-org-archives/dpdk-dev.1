Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8F0CCD1BC
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 17:28:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 677B840668;
	Thu, 23 Oct 2025 19:27:57 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 55B7840144
 for <dev@dpdk.org>; Thu, 23 Oct 2025 19:27:53 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N3d0HC022499
 for <dev@dpdk.org>; Thu, 23 Oct 2025 10:27:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=b
 R3McQJCpyX4j3ySHhooD4161/T+zeLx/67SQ4r67dc=; b=GguUZdUdKvAwoqpTj
 btQKgxmxHmJl32N+yZUxYmzF2opKsyb0FyyhwoDpuTUOSSkRTo3kF5P1SFdWgXYN
 82eHfO3QUFo8g0/0zD0+Bn2fcHth8EMa60TIoQiSRs1cWcHgFaf/7cP6XghNGIKC
 GILo3q91vMhMf1XbgxPam1bJ4eOqWqBwvX5oZvoXuFHmAr7aCPgjmL/u3ac+sare
 JQ/CeevE7FlGYunqHXLDUefIbJ+D+Bu7WbQQwpPITfuILxtNa2L+udb2alE60pho
 YSuA+7Bbdg7P9JfacntLQ3zG2HSAAHVDsthNnR52vj7RTtpjiMVPMIQIKirkwW7U
 T+H2w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49ycmr1w5f-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 23 Oct 2025 10:27:52 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 23 Oct 2025 10:27:49 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 23 Oct 2025 10:27:49 -0700
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 31DE25C68F1;
 Thu, 23 Oct 2025 10:27:46 -0700 (PDT)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v3 06/19] common/cnxk: add new mailbox to configure LSO alt
 flags
Date: Thu, 23 Oct 2025 22:57:14 +0530
Message-ID: <20251023172728.770661-6-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251023172728.770661-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251023172728.770661-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: unnPeKD8ZjgILMg7B9v6tJ45FybasVDf
X-Proofpoint-GUID: unnPeKD8ZjgILMg7B9v6tJ45FybasVDf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDAzMCBTYWx0ZWRfX0F1td5a4Lp1m
 avHnXWpVGOozUdoJSKAwrRMa3wtIRb0fCIjtaJ/0D9iuX+RV6wbmwhSbXYaxneahSOqkh+WLFX1
 bhENuM1sRDoehbCpq6FqWPbtSiB+mrw4ZcObBMECe8/B86N7KapDe42P0bm2aGsJ3jjkRmljnFp
 Mdz9Lesx1UWh7Zh2cD8pakpHpHX3omtivOxbriqdQzXdB6h/oiq3gkAOCrGZXUwNPFnCPpyueM/
 Oxi4vxi+kavRHtnQgI2OYtkiQQy4CV9OCUymS3qF14B+tnHY4frSCEt7G30zxeIwzDO5iNrCrs5
 w0pOF97Ft1brDcIlBLicX/r0p6jadRl+AmD3OurWzdinTSDMmc3b9aJ4bK8p+7QPqFSCvvBVIlP
 2QCO/oTQBYIJ7fxFCSXm/GSshgChJA==
X-Authority-Analysis: v=2.4 cv=CtSys34D c=1 sm=1 tr=0 ts=68fa6598 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=CU7E9oUV1pDfIwHBpYMA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_01,2025-10-22_01,2025-03-28_01
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

