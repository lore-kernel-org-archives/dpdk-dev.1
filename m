Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AC2CD4F2F
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 04:38:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D67540E0B;
	Thu, 13 Nov 2025 05:38:56 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id CC0CB40E2E
 for <dev@dpdk.org>; Thu, 13 Nov 2025 05:38:54 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5ACNRov94031198 for <dev@dpdk.org>; Wed, 12 Nov 2025 20:38:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=u
 USn0cH9HS6WHXpbNIL0CT5JwfENpitZkRRJOYxSJzQ=; b=AWgcOjPi4N0obVHhO
 eEK7qlQd6lTerjjNiC7Zgv2007aFMOnA6Czd7JqoyeazqFoXsbP1AfalGeYSKtV6
 92alfYdf3OBvPY9i5LVrBVAwQCUX21U9mE2VJ6h2JTHND3HM3/AjaW381O7bdwDA
 f1Qa8ZRPyt6zKjqnCxQEtZeRZn09Ijig4jhWHpjWoHjQts+Oy3LCYqyOHPENoSc3
 zI/5gdYjZzDrvhzbBtrMzcvnGJDYOgrlUFc+9Btu94kz8TakUf53eydnXYSbuvcn
 VwUhgr1BKhiE9SoELaeCRBrsYsCssQaGKcpFnnx6I5YSssfQdbA0gDu8nLVLqQNK
 dm/fQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ad3xbgkf4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 12 Nov 2025 20:38:53 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 12 Nov 2025 20:38:52 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 12 Nov 2025 20:38:52 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 133003F7076;
 Wed, 12 Nov 2025 20:38:46 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v5 06/23] common/cnxk: add new mailbox to configure LSO alt
 flags
Date: Thu, 13 Nov 2025 10:07:51 +0530
Message-ID: <20251113043808.1180851-6-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113043808.1180851-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251113043808.1180851-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: pEiKVhGj5rzvhvsd_nc_UiXjdJx847-0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDAyOCBTYWx0ZWRfX1bEPN5OYhynu
 1Hmde8o6jpTZh6efKjaPCgZlVFzKO+9xGxWIvD1BNZqJyFDyk3FJFrz9jkuvLbZcMIK3QOoEehU
 zgStvP3qF4/1l0uwq8r8Vv8wPBNZe4JbOH6wxvNYbo0rsIcu6KWqaScVP+v9odxTtCGggeUxVbQ
 XiP+hw5Zj1e/qWXx0FueNlBVl+PCvnAVny25IjDk6E4k9s9JhOxOvHU8z20rCqHF/vIfQlGvd14
 3mGAZfdg5zTAhGq/aB00/URtGxmEV9HX+1kSkvDKSTh1TnymuIJI7aUnkRgoDIIJJDgD0/egCKX
 IU/K5lLDFDGeOm/dc1rZ+soMXpOykvKFLEfLYk+6em+MNT9NtZ0Pfm0cdv5ghY2jSON5nilEIpr
 9qKWo1G7vR3a3DEk+fTlzN5RpJ4aRw==
X-Authority-Analysis: v=2.4 cv=Qq9THFyd c=1 sm=1 tr=0 ts=691560dd cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=CU7E9oUV1pDfIwHBpYMA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: pEiKVhGj5rzvhvsd_nc_UiXjdJx847-0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
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
index c438f18145..3aed2c7d54 100644
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

