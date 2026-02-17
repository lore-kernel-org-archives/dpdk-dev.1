Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4E1E83856
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 05:40:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70BA74064E;
	Tue, 17 Feb 2026 06:40:18 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 99E8A4064E
 for <dev@dpdk.org>; Tue, 17 Feb 2026 06:40:16 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61H1up4K860861 for <dev@dpdk.org>; Mon, 16 Feb 2026 21:40:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=s
 0D3A6oWVUDYr4PkGm6tD7DSh5DtSmVcNovYZtKVnxE=; b=lE3QtOjWJkWSRL2gM
 tLqaTpgyGzXsM9O+me0EpA9jc8TSIAZI1vh3Bc981HpnXbD/2RXGPIcVUR6Xip5k
 SP8b/Ro4SMm8ApU5STrG6A5bA/D8pi2AHmunjMbqoRYO4+ZU57nh4YAH/ALBgxn8
 BvnIIPref5OGgkgavTyOfGVjLuJaKY9XhL8pUY/0rr/yTM3sJ5x4h5TtJLYBqxza
 gQDobYX3qbr3TO+5fkDeXsPLNzqi1Aahw7CQfFNbT4ILbnYqAfCRQrL5huaTndaI
 OvLcp53ECotqW1cI3DuUeBqQAv7U5kV20A87Mk5itC+I5ftsCYdwAtYsCm+S7rfx
 9M5Kg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cccxf8cqw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 16 Feb 2026 21:40:15 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Feb 2026 21:40:32 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 16 Feb 2026 21:40:31 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 6AC185B6971;
 Mon, 16 Feb 2026 21:40:12 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH v2 04/18] common/cnxk: update CPT RXC structures
Date: Tue, 17 Feb 2026 11:09:29 +0530
Message-ID: <20260217053943.2748100-4-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260217053943.2748100-1-rbhansali@marvell.com>
References: <20260217053943.2748100-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=cdbfb3DM c=1 sm=1 tr=0 ts=6993ff3f cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=M5GUcnROAAAA:8 a=HTPbQNxuPlRTMc1jNHkA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA0NSBTYWx0ZWRfX2cRLluGCYowG
 vboV9omNKAHqc0Ha5CuiWch+uTyDBM5dCy80BHCFke33cO3Y/gV0aU8aGH2qXxNFAnPeJDT0QHz
 71vL/FoAQ2Vkb5m2/7SidGcJwUlQnZHfjbGfFAfo3PsWrDFYrZnj7TmrO6q3T7/ksMdIp5kaz9k
 PeDyouuR5KuW8fzuFOBGAcXrAR00iUyrC74XVsNIrCulCaCqARfqhdnf+7b5wkrOGL2NO/3JiUE
 y+Rgl7HO3GSbY+5SdznF2+W+eZGcoA0e1nRe6fc7TT7me482a0eVw9Ww2nDLqknUogql9kytIZL
 9hNV4ppTTTbNq613NxyMeDnekMm1SUwRyspxiNBCQZFG335srJtsoptZKKPVeNMVsacan32WXMR
 2H4v/GS5eUVxvwkW8Q4w2l4qeKnqv/YaxKoxP1p8RvRk+gueaura+eJWXkl0zDwVsEl1Mt5hOFz
 Fb4HIsFSJOoD8wMhbTA==
X-Proofpoint-ORIG-GUID: z7ccyQdBY-vxD0w9-Talrk_ufpe5RZEY
X-Proofpoint-GUID: z7ccyQdBY-vxD0w9-Talrk_ufpe5RZEY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_08,2026-02-16_04,2025-10-01_01
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

Updates CPT RXC SGs and frag info structures as per
CN20k and CN10k platforms.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
Changes in v2: Updated commit message.

 drivers/common/cnxk/hw/cpt.h        | 143 +++++++++++++++++++---------
 drivers/common/cnxk/roc_cpt_debug.c |   2 +-
 2 files changed, 101 insertions(+), 44 deletions(-)

diff --git a/drivers/common/cnxk/hw/cpt.h b/drivers/common/cnxk/hw/cpt.h
index 727cee07b4..6e577b6277 100644
--- a/drivers/common/cnxk/hw/cpt.h
+++ b/drivers/common/cnxk/hw/cpt.h
@@ -549,30 +549,60 @@ union cpt_frag_info {
 	};
 };

-struct cpt_frag_info_s {
-	/* WORD 0 */
-	union {
-		uint64_t u64;
-		struct {
-			/* CPT HW swaps each 8B word implicitly */
-			union cpt_frag_info f0;
-			union cpt_frag_info f1;
-			union cpt_frag_info f2;
-			union cpt_frag_info f3;
-		};
-	} w0;
+union cpt_rxc_frag_info_u {
+	struct cpt_frag_info_s {
+		/* WORD 0 */
+		union {
+			uint64_t u64;
+			struct {
+				/* CPT HW swaps each 8B word implicitly */
+				union cpt_frag_info f3;
+				union cpt_frag_info f2;
+				union cpt_frag_info f1;
+				union cpt_frag_info f0;
+			};
+		} w0;

-	/* WORD 1 */
-	union {
-		uint64_t u64;
-		struct {
-			/* CPT HW swaps each 8B word implicitly */
-			uint16_t frag_size0;
-			uint16_t frag_size1;
-			uint16_t frag_size2;
-			uint16_t frag_size3;
-		};
-	} w1;
+		/* WORD 1 */
+		union {
+			uint64_t u64;
+			struct {
+				/* CPT HW swaps each 8B word implicitly */
+				uint16_t frag_size3;
+				uint16_t frag_size2;
+				uint16_t frag_size1;
+				uint16_t frag_size0;
+			};
+		} w1;
+	} s;
+
+	struct cpt_cn10k_frag_info_s {
+		/* WORD 0 */
+		union {
+			uint64_t u64;
+			struct {
+				/* CPT HW swaps each 8B word implicitly */
+				union cpt_frag_info f0;
+				union cpt_frag_info f1;
+				union cpt_frag_info f2;
+				union cpt_frag_info f3;
+			};
+		} w0;
+
+		/* WORD 1 */
+		union {
+			uint64_t u64;
+			struct {
+				/* CPT HW swaps each 8B word implicitly */
+				uint16_t frag_size0;
+				uint16_t frag_size1;
+				uint16_t frag_size2;
+				uint16_t frag_size3;
+			};
+		} w1;
+	} cn10k;
+
+	uint64_t u64[2];
 };

 /* CPT rxc pointer info structure */
@@ -591,29 +621,56 @@ struct cpt_rxc_ptr_info_s {
 };

 /* CPT rxc scatter/gather subdescriptor structure */
-struct cpt_rxc_sg_s {
-	/* WORD 0 */
-	union {
-		uint64_t u64;
-		struct {
-			uint16_t seg1_size;
-			uint16_t seg2_size;
-			uint16_t seg3_size;
-			uint16_t segs : 2;
-			uint16_t nxt_fst_frag : 3;
-			uint16_t blk_sz : 4;
-			uint16_t rsvd_63_57 : 7;
-		};
-	} w0;
+union cpt_rxc_sg_u {
+	struct cpt_rxc_sg_s {
+		/* WORD 0 */
+		union {
+			uint64_t u64;
+			struct {
+				uint16_t rsvd_63_57 : 7;
+				uint16_t blk_sz : 4;
+				uint16_t nxt_fst_frag : 3;
+				uint16_t segs : 2;
+				uint16_t seg3_size;
+				uint16_t seg2_size;
+				uint16_t seg1_size;
+			};
+		} w0;

-	/* WORD 1 */
-	uint64_t seg1_ptr;
+		/* WORD 1 */
+		uint64_t seg1_ptr;

-	/* WORD 2 */
-	uint64_t seg2_ptr;
+		/* WORD 2 */
+		uint64_t seg2_ptr;
+
+		/* WORD 3 */
+		uint64_t seg3_ptr;
+	} s;
+
+	struct cpt_cn10k_rxc_sg_s {
+		/* WORD 0 */
+		union {
+			uint64_t u64;
+			struct {
+				uint16_t seg1_size;
+				uint16_t seg2_size;
+				uint16_t seg3_size;
+				uint16_t segs : 2;
+				uint16_t rsvd_63_50 : 14;
+			};
+		} w0;
+
+		/* WORD 1 */
+		uint64_t seg1_ptr;
+
+		/* WORD 2 */
+		uint64_t seg2_ptr;
+
+		/* WORD 3 */
+		uint64_t seg3_ptr;
+	} cn10k;

-	/* WORD 3 */
-	uint64_t seg3_ptr;
+	uint64_t u64[4];
 };

 union cpt_fc_write_s {
diff --git a/drivers/common/cnxk/roc_cpt_debug.c b/drivers/common/cnxk/roc_cpt_debug.c
index 28aedf088e..3b3e678c20 100644
--- a/drivers/common/cnxk/roc_cpt_debug.c
+++ b/drivers/common/cnxk/roc_cpt_debug.c
@@ -125,7 +125,7 @@ cpt_cnxk_parse_hdr_dump(FILE *file, const struct cpt_parse_hdr_s *cpth)
 static inline void
 cpt_cn10k_parse_hdr_dump(FILE *file, const struct cpt_cn10k_parse_hdr_s *cpth)
 {
-	struct cpt_frag_info_s *frag_info;
+	struct cpt_cn10k_frag_info_s *frag_info;
 	uint32_t offset;
 	uint64_t *slot;

--
2.34.1

