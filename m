Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3121D3567F
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 06:03:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B9F4400D7;
	Wed, 28 Jan 2026 07:03:55 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 7D943402D6
 for <dev@dpdk.org>; Wed, 28 Jan 2026 07:03:53 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60RG2E6E1389849 for <dev@dpdk.org>; Tue, 27 Jan 2026 22:03:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=p
 moQhMciOfO8nhx0tSXxqgVN0Z50Bxj12zR73FQLrMo=; b=ApLCZJx144ZUSZ3EI
 7EzxPZ8yMNI/AqfvX1AQshgtRMBtJhOTurXKm1tgtojIfrqPgqPsiBXEyjFJcGJM
 BKhU2z+kDfxSEc0zPatDIm7tH53u7B9YxyexGQ9d8gzdBI3i0zIylxSyZf7qGY9j
 OmCDeRHAji8bL3GkpEx0Sij5sLiEAHd9Lt/1tS9FDAl+qyoiAbh93r/cLpAbjicZ
 R3wwaVqgpfRcmOXiy+cYdBNDcKlMpXRJfgBma1Pu66dXk5QV/B0tAB32VAyOWcJ+
 JrG0IDx6L8VbHWiHqW/Hh12S5YfkE7fPgY62Dy7THehGjY7ngl2Qe06kdZ09eeck
 wuzow==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bx0qsws05-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 27 Jan 2026 22:03:52 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 Jan 2026 22:04:07 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 27 Jan 2026 22:04:07 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 4556A3F706F;
 Tue, 27 Jan 2026 22:03:49 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH 04/18] common/cnxk: update CPT RXC structures
Date: Wed, 28 Jan 2026 11:33:02 +0530
Message-ID: <20260128060316.3967610-4-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260128060316.3967610-1-rbhansali@marvell.com>
References: <20260128060316.3967610-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDA0NiBTYWx0ZWRfX5dFUmcCB2KrN
 AUdTdpWoPDGGvumL7brn8rJVCMPDKSlJhCqzou4DPUqyDAzu8xVYqGLmTLGIv1ndJ8Es6mu5V2z
 S4sKoiOyKHwZMG43q8hznvdnowGJVeg4Ble+pTTYOPIsD7+6Pc7fW+SkZKbgOStcYaLUbkwLfES
 QfV5uehJkHo3ybaEY7aGVJjI1skivFiyCWOQStfyHP9/mo25C9ITnnZMnKADPEQuEnLN862fI2a
 Ehi0wriCqG2314HKyYbwVF4OcUZT7aL0ci1YG4K7AcBbcEnoq1tqN4aeYSg7OiWqtEcE7IEi9L3
 xjdWltsXUOMf1VX5a82eB44ca22ZcPRy5t18uZZGKR15HKEu2dGPIw9bX5e7li3ud4OMa/P6i+b
 Qg6UIzpgudCPSd1Vt+Ckm1RLKiviEugy1nbAFMH79ezFdOnMW+0+egAlywBKILmPtPWvLoCjFVq
 /zajKDvD04esiWgZagw==
X-Authority-Analysis: v=2.4 cv=P9E3RyAu c=1 sm=1 tr=0 ts=6979a6c8 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=FglFrdzKARVPHk-XYnsA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: XEdVhCaYmaIK_rDDvxmDw2AqW-3B44qQ
X-Proofpoint-GUID: XEdVhCaYmaIK_rDDvxmDw2AqW-3B44qQ
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

Updates CPT RXC SGs and frag info structures for
cn20k platforms.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
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

