Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C76BE83855
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 05:46:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90659406BB;
	Tue, 17 Feb 2026 06:45:17 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id EF2F9406BB;
 Tue, 17 Feb 2026 06:45:15 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61GKJ4Ar3055578; Mon, 16 Feb 2026 21:45:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=5
 sG0Z1aR4gsqpx/4jiUW/9KY0VU+t+KYOLht8VvE+i8=; b=hLGO7o8DflguPXGS1
 am6gTy9i90nrjZSapAuNfooWxYoslhyHMS+NOiM6qQJLjujtUszqZ3w3YEDnxZfK
 9DHtcwbxwoIVVXKb3EpWHUSprBLbSVg8E4nMCLpbPXpTBjGWTzGxnd6ulZQsjBgs
 AKI6TtCORvhlODnGIKhTpmAebEXhWxAyCtE5FMR9hvKzykwZ/gHRNr2IgBxAzLoI
 UV4Sw2+S7PyhfVC7GD3EMaf2D/pGuoZjG+Kn833AaFu7ODGLPkDAipDRgzDyFkp3
 IkYT1bRaO9PjpeuYYzdxxxAPozi2HGP8I/Pwaf4rl4418Kyn58FuACoBWiNICAjM
 I9TJA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cbe6ck1n5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Feb 2026 21:45:15 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Feb 2026 21:45:31 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 16 Feb 2026 21:45:31 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 728155B696D;
 Mon, 16 Feb 2026 21:45:10 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, Rahul Bhansali
 <rbhansali@marvell.com>, Anoob Joseph <anoobj@marvell.com>, "Vidya Sagar
 Velumuri" <vvelumuri@marvell.com>, Akhil Goyal <gakhil@marvell.com>,
 "Archana Muniganti" <marchana@marvell.com>
CC: <jerinj@marvell.com>, <stable@dpdk.org>
Subject: [PATCH v2 18/18] common/cnxk: fix duplicate branch compiler warning
Date: Tue, 17 Feb 2026 11:13:45 +0530
Message-ID: <20260217054345.2759687-18-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260217054345.2759687-1-rbhansali@marvell.com>
References: <20260128060316.3967610-1-rbhansali@marvell.com>
 <20260217054345.2759687-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=KO9XzVFo c=1 sm=1 tr=0 ts=6994006b cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=DUEc-3SzhJHA_FY6JqIA:9 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: _klAMjU7L1cmIuRrHErbrAalXaC3418z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA0NSBTYWx0ZWRfX23iut2BeDvr6
 uOauIHd7W6cxIOGkA3f9x5pTydn5nA/1dZdrE2RcqEmZf6PvZ8ZSPiNZaPyWln0EfYHcQP9/aHW
 vtOjLAc8OVzEMHEzgxfN9X2kOz7CjkdlWTP5sNQBwsLOUIOfxCF1S8D39VR15kNeZgpEP1TCQEG
 pC6ZHBD53ElKg/YfxzCe6xwl7hsFoZLNWeg7nPdZMrPYDM0pcA9cnN9Rm3oRXkcA9w5BhAP1riL
 QruOYvizTEtRS64w5jdZN+Z4N/k/Yz0IJhiFUOTduqC8Iu6IyKKmEtGPyxYzPWQqp+90YC23cZG
 FMSrl6criuEUZx36PnH24XoEyQBopheASN/o0SJf71SUB+LTd5lxrjLxtsGHb5Z+9Tr/JDoQHvF
 P6WwUP4ckGS5CfTaHnkKfY+USdVyZWMrmOO52tcHrG0iV3t5zzlmx5+V5KjYNZqJlvH+czG92yQ
 hQMXwWDKfHip4ewriQw==
X-Proofpoint-GUID: _klAMjU7L1cmIuRrHErbrAalXaC3418z
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

With compiler option '-Wduplicated-branches', getting few
warnings such as "this condition has identical branches".

Macros are updated to address these warnings.

Bugzilla ID: 1811
Fixes: 0d9e323bacf0 ("common/cnxk: support for CN20K inline IPsec")
Fixes: c045d2e5cbbc ("common/cnxk: add CPT configuration")
Cc: stable@dpdk.org

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
Changes in v2: Updated commit message.

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
index 727a2e2a81..35528efa46 100644
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

