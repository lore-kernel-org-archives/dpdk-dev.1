Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DD4E83856
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 05:44:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 929DD4065F;
	Tue, 17 Feb 2026 06:44:08 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 27A4540663
 for <dev@dpdk.org>; Tue, 17 Feb 2026 06:44:07 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61GKJ4An3055578 for <dev@dpdk.org>; Mon, 16 Feb 2026 21:44:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=6
 A8dn9ctdryEcs1KnI4eFkvnS6KSa1ztvDLkemFfiyw=; b=TxkVreJn4D31oAZQ0
 52qjNHzsnr66mz+TtGgLMVKNGl/+8V4rwU1+zfepJsL+TdkNEzSDkwxpl5+BZTrn
 yW/G/ojd79hrwJp7eRl82vee/tpNkFTWV/YXraEJq0w3Lbh0i06VGU9gJgia2bMD
 FM1IiwJnzQnNtxeKDG6DMOSEUzsREU+kgT6Z8x8my7cyaYyrMtPLDWR4s2McSaYo
 yvkqbREu63d1Cdp78z/rs989TIaGGkPy1B2UOSav2Ml+ha53LtewNHa7gWdfMpmO
 KzCADQL4SHWpIbmG2trLgkzVNkQw8+U/rUg7E6etZjE7xCq8WPegNhI4sbNDV2o4
 AT5GQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cbe6ck1js-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 16 Feb 2026 21:44:06 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Feb 2026 21:44:21 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 16 Feb 2026 21:44:21 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 1F11A5B6971;
 Mon, 16 Feb 2026 21:44:01 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH v2 03/18] common/cnxk: support inbound pdb configuration
Date: Tue, 17 Feb 2026 11:13:30 +0530
Message-ID: <20260217054345.2759687-3-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260217054345.2759687-1-rbhansali@marvell.com>
References: <20260128060316.3967610-1-rbhansali@marvell.com>
 <20260217054345.2759687-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=KO9XzVFo c=1 sm=1 tr=0 ts=69940026 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=M5GUcnROAAAA:8 a=QC7kw0MEJxuHXxlU5L0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: EXnVSpHqNsssWlDOuV4PPWJA_NL7JB6Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA0NSBTYWx0ZWRfX687U2mRo6/IJ
 +KYpVo/Za/1J04+sNVCPCUQvP48oijtIHHuFlnoXEi/xExv5AtdmtvwARasciawCsK+EiirUI9n
 FmEgOyAUE8Fx0yYcO+1TITT7RxOWRYPNyGnel3U0tJUrV76CQGEOYLABacJ+D5rjs9zf/yuYzmy
 z3HM8zB66LfiZg16jQk0YEQr9VdlrWvlnhDbOSFXd2gMq9YuWicpcQHcf44xxddA94WYw8GeJl4
 Qvxmhy79lMcJ+i5htvZQ7C+sycjBLLKLrvPSSwwMZxaM3Z9XCgV5sA6FVDQKzh0elY/AQmQC/Fn
 K7IvPh9zTyWXLpzpxBA7L6oGgPssmW6RYf5VFLAyjJIAO41W+L1WE2dVGWixUQJrBwCnXOw1AWD
 nDyla8iCZTNLd3Qe0gwSkZyW2kXurQ8ZoRGyDQOzLnkWHRz3ZhlAXJBFd568ESTDSyKqJHMCGzj
 NxD6MvqDccp2fCJn4Ig==
X-Proofpoint-GUID: EXnVSpHqNsssWlDOuV4PPWJA_NL7JB6Z
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

Mbox cpt_rx_inl_queue_cfg is extended to enable/disable PDB
for inline inbound IPsec path.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
Changes in v2: No change.

 drivers/common/cnxk/roc_mbox.h        | 4 +++-
 drivers/common/cnxk/roc_nix_inl_dev.c | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/common/cnxk/roc_mbox.h b/drivers/common/cnxk/roc_mbox.h
index 3e913fa13c..7871613d9c 100644
--- a/drivers/common/cnxk/roc_mbox.h
+++ b/drivers/common/cnxk/roc_mbox.h
@@ -2423,7 +2423,9 @@ struct cpt_rx_inline_qcfg_req {
 	uint8_t __io pf_func_ctx;
 	uint8_t __io inflight_limit;
 	uint8_t __io queue_pri;
-	uint8_t __io rsvd[32]; /* For future extensions */
+	uint8_t __io cq_remap;
+	uint8_t __io pdb_ena;
+	uint8_t __io rsvd[30]; /* For future extensions */
 };

 #define CPT_INLINE_INBOUND  0
diff --git a/drivers/common/cnxk/roc_nix_inl_dev.c b/drivers/common/cnxk/roc_nix_inl_dev.c
index 3a4f1ac1e7..727a2e2a81 100644
--- a/drivers/common/cnxk/roc_nix_inl_dev.c
+++ b/drivers/common/cnxk/roc_nix_inl_dev.c
@@ -212,6 +212,7 @@ nix_inl_inb_queue_setup(struct nix_inl_dev *inl_dev, uint8_t slot_id)
 	cpt_req->slot = slot_id;
 	cpt_req->rx_queue_id = qid;
 	cpt_req->eng_grpmsk = inl_dev->eng_grpmask;
+	cpt_req->pdb_ena = 1;
 	rc = mbox_process(mbox);
 	if (rc) {
 		plt_err("Failed to configure CPT LF for inline processing, rc=%d", rc);
--
2.34.1

