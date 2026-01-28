Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA329D3567B
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 06:05:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A223D40608;
	Wed, 28 Jan 2026 07:05:08 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 903EC40608
 for <dev@dpdk.org>; Wed, 28 Jan 2026 07:05:04 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60S1N3hA3583494 for <dev@dpdk.org>; Tue, 27 Jan 2026 22:05:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=p
 RTwYqVgThHn+EbmJJrEc4CGhHnGkVmAtmK1KaI9KZc=; b=IckyAtHkryg1Ap60X
 xxTAzUHRSBp/05iP8T4zO8B7CdZX495AiHNjAyHZZjRMQPsURQUCR3MUvsfgy1il
 bZI1cngEFIqOTywOcz9cpzcJy5giLpUFfPz0/VG/PtZZ5USNnmwitdE7F79NTTyS
 Ti7R1UeFCInYo2hPcSii/x3Fcz832dgpJKroe5fgFjus/TTbcQjcHbe5VGfK3YNS
 vvp20N2f3PTfK/9LXREM8cUXn1Z5S3agRJZ+0G5QDg88OEtSvXa/rHcBoGCJoLrT
 DXWTVyl3A9IK11331N5mFuavl5G5lJnB7tqmeG9f8wWreyafSF38blZjGNi9lIqh
 penJQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4by8r68f63-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 27 Jan 2026 22:05:03 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 Jan 2026 22:05:02 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 27 Jan 2026 22:05:02 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 906783F7072;
 Tue, 27 Jan 2026 22:04:58 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, Rahul Bhansali
 <rbhansali@marvell.com>, Archana Muniganti <marchana@marvell.com>, "Akhil
 Goyal" <gakhil@marvell.com>, Anoob Joseph <anoobj@marvell.com>,
 "Vidya Sagar Velumuri" <vvelumuri@marvell.com>
CC: <jerinj@marvell.com>
Subject: [PATCH 18/18] common/cnxk: fix duplicate branch compiler warning
Date: Wed, 28 Jan 2026 11:33:16 +0530
Message-ID: <20260128060316.3967610-18-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260128060316.3967610-1-rbhansali@marvell.com>
References: <20260128060316.3967610-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Ka/fcAYD c=1 sm=1 tr=0 ts=6979a70f cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=DUEc-3SzhJHA_FY6JqIA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDA0NyBTYWx0ZWRfX3P9EOb9H+J68
 zeytfN94owT1x4RTnrmY3VME+613bQ6iWiUZtaOL3hh0RjBPCAWwbI7veA7c/I7ilv1VdWUG8Ww
 7E4qEAR8Ulwa418+mrvN8kkTDrXDGmawCLiQ2FxKQSXET9W3WsDbz3S4RSDVsMaFQbJIcQI98D+
 e99wamY0hfRdTEZImyD9rtN1Q7bE0UxkbASKQt+XCJTrrNuIwaX8Pc6FeWiYtPoeXM3ydvjGWIn
 tZyvHOPDNO5xZ05Vg3ZiMpNlfsKYTU2LYKF3hp2pLqtiZuBC94S/dQcdAqUAkbolVb0AwKQeDpT
 GQp0DspLR7kO7Lv7i0j7J7sEg0xCW0uvg4juiA/l84PXYTD9u7I8AHaw7px7K8nskfqcqhYh2j3
 /g5dWxQTHuyq1zSsD88TVX8b/xlxxfUbErF4V4P7aH4ncRnjMghlsVPS/h/xeg9ViIDk0lvhbSl
 ArZhNp/FV6Pyuw4VQFQ==
X-Proofpoint-GUID: Y7fD42Nt2-sTSFfsVTL0u_hSVReMZuoL
X-Proofpoint-ORIG-GUID: Y7fD42Nt2-sTSFfsVTL0u_hSVReMZuoL
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

With compiler option '-Wduplicated-branches', getting few
warnings such as "this condition has identical branches".

Macros are updated to address these warnings.

Bugzilla ID: 1811
Fixes: 0d9e323bacf0 ("common/cnxk: support for CN20K inline IPsec")
Fixes: c045d2e5cbbc ("common/cnxk: add CPT configuration")

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 drivers/common/cnxk/hw/rvu.h          |  2 ++
 drivers/common/cnxk/roc_cpt.c         |  7 +++----
 drivers/common/cnxk/roc_nix_inl.c     | 25 +++++++++----------------
 drivers/common/cnxk/roc_nix_inl_dev.c |  6 +-----
 drivers/common/cnxk/roc_nix_inl_dp.h  |  3 +++
 drivers/common/cnxk/roc_nix_priv.h    |  4 ++--
 6 files changed, 20 insertions(+), 27 deletions(-)

diff --git a/drivers/common/cnxk/hw/rvu.h b/drivers/common/cnxk/hw/rvu.h
index ed2ba996e0..6f02d1e3d2 100644
--- a/drivers/common/cnxk/hw/rvu.h
+++ b/drivers/common/cnxk/hw/rvu.h
@@ -105,6 +105,8 @@
 #define RVU_VF_MBOX_REGION		 (0xc0000ull) /* [CN10K, .) */
 #define RVU_VF_MSIX_PBAX(a)		 (0xf0000ull | (uint64_t)(a) << 3)
 
+#define RVU_BLOCK_ADDRX_DISC(a) RVU_PF_BLOCK_ADDRX_DISC(a)
+
 /* CN20k RVU mbox registers */
 #define RVU_MBOX_AF_AFPFX_TRIGX(a)    (0x9000 | (a) << 3)
 #define RVU_MBOX_PF_PFAF_TRIGX(a)     RVU_PF_PFAF_MBOXX(a)
diff --git a/drivers/common/cnxk/roc_cpt.c b/drivers/common/cnxk/roc_cpt.c
index 63419884ac..13eb9d3767 100644
--- a/drivers/common/cnxk/roc_cpt.c
+++ b/drivers/common/cnxk/roc_cpt.c
@@ -677,10 +677,9 @@ cpt_get_blkaddr(struct dev *dev)
 	 * attached to. Assume CPT LF's of only one block are attached
 	 * to a pffunc.
 	 */
-	if (dev_is_vf(dev))
-		off = RVU_VF_BLOCK_ADDRX_DISC(RVU_BLOCK_ADDR_CPT1);
-	else
-		off = RVU_PF_BLOCK_ADDRX_DISC(RVU_BLOCK_ADDR_CPT1);
+
+	/* PF and VF block address offset is same, hence using common offset */
+	off = RVU_BLOCK_ADDRX_DISC(RVU_BLOCK_ADDR_CPT1);
 
 	reg = plt_read64(dev->bar2 + off);
 
diff --git a/drivers/common/cnxk/roc_nix_inl.c b/drivers/common/cnxk/roc_nix_inl.c
index aad2631673..a21c40acf1 100644
--- a/drivers/common/cnxk/roc_nix_inl.c
+++ b/drivers/common/cnxk/roc_nix_inl.c
@@ -19,6 +19,10 @@ PLT_STATIC_ASSERT(ROC_NIX_INL_OT_IPSEC_INB_SA_SZ ==
 PLT_STATIC_ASSERT(ROC_NIX_INL_OT_IPSEC_INB_SA_SZ == 1024);
 PLT_STATIC_ASSERT(ROC_NIX_INL_OT_IPSEC_OUTB_SA_SZ ==
 		  1UL << ROC_NIX_INL_OT_IPSEC_OUTB_SA_SZ_LOG2);
+PLT_STATIC_ASSERT(ROC_NIX_INL_OT_IPSEC_INB_SA_SZ == ROC_NIX_INL_OW_IPSEC_INB_SA_SZ);
+PLT_STATIC_ASSERT(ROC_NIX_INL_OT_IPSEC_INB_SA_SZ == ROC_NIX_INL_ON_IPSEC_INB_SA_SZ);
+PLT_STATIC_ASSERT(ROC_NIX_INL_OT_IPSEC_OUTB_SA_SZ == ROC_NIX_INL_OW_IPSEC_OUTB_SA_SZ);
+PLT_STATIC_ASSERT(ROC_NIX_INL_OT_IPSEC_OUTB_SA_SZ == ROC_NIX_INL_ON_IPSEC_OUTB_SA_SZ);
 
 static int
 nix_inl_meta_aura_destroy(struct roc_nix *roc_nix)
@@ -427,12 +431,8 @@ nix_inl_inb_ipsec_sa_tbl_setup(struct roc_nix *roc_nix)
 	/* CN9K SA size is different */
 	if (roc_nix->custom_inb_sa)
 		inb_sa_sz = ROC_NIX_INL_INB_CUSTOM_SA_SZ;
-	else if (roc_model_is_cn9k())
-		inb_sa_sz = ROC_NIX_INL_ON_IPSEC_INB_SA_SZ;
-	else if (roc_model_is_cn10k())
-		inb_sa_sz = ROC_NIX_INL_OT_IPSEC_INB_SA_SZ;
 	else
-		inb_sa_sz = ROC_NIX_INL_OW_IPSEC_INB_SA_SZ;
+		inb_sa_sz = ROC_NIX_INL_IPSEC_INB_SA_SZ;
 
 	/* Alloc contiguous memory for Inbound SA's */
 	nix->inb_sa_sz[profile_id] = inb_sa_sz;
@@ -1198,10 +1198,9 @@ nix_inl_eng_caps_get(struct nix *nix)
 	inst.rptr = (uint64_t)rptr;
 	inst.w4.s.opcode_major = ROC_LOADFVC_MAJOR_OP;
 	inst.w4.s.opcode_minor = ROC_LOADFVC_MINOR_OP;
-	if (roc_model_is_cn9k() || roc_model_is_cn10k())
-		inst.w7.s.egrp = ROC_LEGACY_CPT_DFLT_ENG_GRP_SE;
-	else
-		inst.w7.s.egrp = ROC_CPT_DFLT_ENG_GRP_SE;
+
+	/* SE engine group ID is same for all platform */
+	inst.w7.s.egrp = ROC_CPT_DFLT_ENG_GRP_SE;
 
 	/* Use 1 min timeout for the poll */
 	const uint64_t timeout = plt_tsc_cycles() + 60 * plt_tsc_hz();
@@ -1614,13 +1613,7 @@ roc_nix_inl_outb_init(struct roc_nix *roc_nix)
 	if (!roc_nix->ipsec_out_max_sa)
 		goto skip_sa_alloc;
 
-	/* CN9K SA size is different */
-	if (roc_model_is_cn9k())
-		sa_sz = ROC_NIX_INL_ON_IPSEC_OUTB_SA_SZ;
-	else if (roc_model_is_cn10k())
-		sa_sz = ROC_NIX_INL_OT_IPSEC_OUTB_SA_SZ;
-	else
-		sa_sz = ROC_NIX_INL_OW_IPSEC_OUTB_SA_SZ;
+	sa_sz = ROC_NIX_INL_IPSEC_OUTB_SA_SZ;
 
 	/* Alloc contiguous memory of outbound SA */
 	sa_base = plt_zmalloc(sa_sz * roc_nix->ipsec_out_max_sa,
diff --git a/drivers/common/cnxk/roc_nix_inl_dev.c b/drivers/common/cnxk/roc_nix_inl_dev.c
index fcbe9314a1..8414b9edc6 100644
--- a/drivers/common/cnxk/roc_nix_inl_dev.c
+++ b/drivers/common/cnxk/roc_nix_inl_dev.c
@@ -837,12 +837,8 @@ nix_inl_nix_setup(struct nix_inl_dev *inl_dev)
 	/* CN9K SA is different */
 	if (inl_dev->custom_inb_sa)
 		inb_sa_sz = ROC_NIX_INL_INB_CUSTOM_SA_SZ;
-	else if (roc_model_is_cn9k())
-		inb_sa_sz = ROC_NIX_INL_ON_IPSEC_INB_SA_SZ;
-	else if (roc_model_is_cn10k())
-		inb_sa_sz = ROC_NIX_INL_OT_IPSEC_INB_SA_SZ;
 	else
-		inb_sa_sz = ROC_NIX_INL_OW_IPSEC_INB_SA_SZ;
+		inb_sa_sz = ROC_NIX_INL_OT_IPSEC_INB_SA_SZ;
 
 	/* Alloc contiguous memory for Inbound SA's */
 	inl_dev->inb_sa_sz[profile_id] = inb_sa_sz;
diff --git a/drivers/common/cnxk/roc_nix_inl_dp.h b/drivers/common/cnxk/roc_nix_inl_dp.h
index eb101db179..6443770871 100644
--- a/drivers/common/cnxk/roc_nix_inl_dp.h
+++ b/drivers/common/cnxk/roc_nix_inl_dp.h
@@ -41,6 +41,9 @@
 	(ROC_NIX_INL_OW_IPSEC_OUTB_HW_SZ + ROC_NIX_INL_OW_IPSEC_OUTB_SW_RSVD)
 #define ROC_NIX_INL_OW_IPSEC_OUTB_SA_SZ_LOG2 9
 
+#define ROC_NIX_INL_IPSEC_INB_SA_SZ  ROC_NIX_INL_OT_IPSEC_INB_SA_SZ
+#define ROC_NIX_INL_IPSEC_OUTB_SA_SZ ROC_NIX_INL_OT_IPSEC_OUTB_SA_SZ
+
 /* Alignment of SA Base */
 #define ROC_NIX_INL_SA_BASE_ALIGN BIT_ULL(16)
 
diff --git a/drivers/common/cnxk/roc_nix_priv.h b/drivers/common/cnxk/roc_nix_priv.h
index 308a62a70e..d4b3c7c1af 100644
--- a/drivers/common/cnxk/roc_nix_priv.h
+++ b/drivers/common/cnxk/roc_nix_priv.h
@@ -23,10 +23,10 @@
 #define NIX_CQ_SEC_THRESH_LEVEL_REF1	(20 * 256 / 100)
 #define NIX_CQ_BP_THRESH_LEVEL_REF1	(60 * 256 / 100)
 #define NIX_CQ_SEC_BP_THRESH_LEVEL_REF1 (50 * 256 / 100)
-#define NIX_CQ_LBP_THRESH_FRAC_REF1	(80 * 16 / 100)
+#define NIX_CQ_LBP_THRESH_FRAC_REF1	(80 * 16 / 100.0)
 
 /* Apply LBP at 75% of actual BP */
-#define NIX_CQ_LBP_THRESH_FRAC	(75 * 16 / 100)
+#define NIX_CQ_LBP_THRESH_FRAC	(75 * 16 / 100.0)
 #define NIX_CQ_FULL_ERRATA_SKID (1024ull * 256)
 #define NIX_RQ_AURA_BP_THRESH(percent, limit, shift) ((((limit) * (percent)) / 100) >> (shift))
 
-- 
2.34.1

