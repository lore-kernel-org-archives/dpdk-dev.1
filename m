Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A71CD4F2F
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 04:40:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E9FF40E41;
	Thu, 13 Nov 2025 05:40:08 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id E65F440EDF
 for <dev@dpdk.org>; Thu, 13 Nov 2025 05:40:05 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5ACNSMfn4032197 for <dev@dpdk.org>; Wed, 12 Nov 2025 20:40:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=w
 xJWs8URC+e5GcRccWLcjRnhwDVT0Vx8LNgsQPTX7Vo=; b=MfnTY+GMcMsbzthXU
 3R31rfWkC+vHlT3pEBVJiQU6SFpk6fc3QZwbjEql485L/9NV84FrFTMB8aKkpEY9
 q4Tu0AVcRcCYzhBKsrBEPwjpw4IdqHFmA0g8D36kFIlcxFmPuN+srDvYKzYHLrtg
 Nct8ZeyxZTC203opdGCDRgUCk22qmM/XqjgT9Z4tSqgV/kBDNsWmrjkz9zexvgE0
 na4rjDcIVnhNH7Fr/m2C1umQtPrKX41Ie3QWo1h8jddLfg5prYMK7TiMDNxpzwDP
 wNUzPM3bxyz7L9Xs4Wn/Rs0zgQ0MQRax1SqskhTqOHvAdHUjWsEbRrhM/fRRA/Sg
 Q8esQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ad3xbgkk0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 12 Nov 2025 20:40:03 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 12 Nov 2025 20:40:02 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 12 Nov 2025 20:40:02 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 5D41B3F7076;
 Wed, 12 Nov 2025 20:39:59 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>, Aarnav JP <ajp@marvell.com>
Subject: [PATCH v5 20/23] common/cnxk: fix CPT res address config for inline
Date: Thu, 13 Nov 2025 10:08:05 +0530
Message-ID: <20251113043808.1180851-20-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113043808.1180851-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251113043808.1180851-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 5cVFgHcz39YW_k4dMmlgGs9G2d6V7yg2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDAyOCBTYWx0ZWRfX+lnlPlueAmMR
 ilbZAOhZxB11uOKE+c6KSVYFnUGKJVWq3EVJ9yvESH7UEm2vJ+rryhUG+/kymHjyfbLKJduwX7b
 NLAnpduScm8pVLecZHQXXQpl8SHulVMxr6F2dP6U96/P70NxfyxvThME2mYRWgNn3uj+a2JG2Gl
 fqeZUFCRIOzZ6UcvelFmylxX+Z3WzrjTTZYivIwMTfZfQGMCLwRec+PXlZyGksA/ZtXgbqBrRED
 dXeESB0sI4OYDJHL0Miq8rIVO/YR7nLqIWV58y5b7PCSXPXiLSkiGvqiih0CgtfDUgoQ18L8yxI
 WJ0v/GPxCgHsXJvUbbqhmBt3lFkuEmshoZtS9u268P4BZodznllRrrUUd09nIdixip73S2o8rZB
 tAn5rsLZGLutIiaqrdfr8ZS+rDnvAw==
X-Authority-Analysis: v=2.4 cv=Qq9THFyd c=1 sm=1 tr=0 ts=69156123 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=qZSRG9XKnlCErq4bdN8A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 5cVFgHcz39YW_k4dMmlgGs9G2d6V7yg2
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

From: Aarnav JP <ajp@marvell.com>

Fix CPT res address config logic to avoid garbage values
and trigger only when inline dev is present.

Fixes: 3c31a7485172 ("common/cnxk: config CPT result address for CN20K")
Signed-off-by: Aarnav JP <ajp@marvell.com>
---
 drivers/common/cnxk/roc_nix_inl.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/common/cnxk/roc_nix_inl.c b/drivers/common/cnxk/roc_nix_inl.c
index 6700f556a0..780f4cbbfc 100644
--- a/drivers/common/cnxk/roc_nix_inl.c
+++ b/drivers/common/cnxk/roc_nix_inl.c
@@ -581,7 +581,7 @@ nix_inl_reass_inb_sa_tbl_setup(struct roc_nix *roc_nix)
 	struct nix_inl_dev *inl_dev = NULL;
 	uint64_t max_sa = 1, sa_pow2_sz;
 	uint64_t sa_idx_w, lenm1_max;
-	uint64_t res_addr_offset;
+	uint64_t res_addr_offset = 0;
 	uint64_t def_cptq = 0;
 	size_t inb_sa_sz = 1;
 	uint8_t profile_id;
@@ -626,12 +626,11 @@ nix_inl_reass_inb_sa_tbl_setup(struct roc_nix *roc_nix)
 		inl_dev = idev->nix_inl_dev;
 		if (inl_dev->nb_inb_cptlfs)
 			def_cptq = inl_dev->nix_inb_qids[inl_dev->inb_cpt_lf_id];
+		res_addr_offset = (uint64_t)(inl_dev->res_addr_offset & 0xFF) << 48;
+		if (res_addr_offset)
+			res_addr_offset |= (1UL << 56);
 	}
 
-	res_addr_offset = (uint64_t)(inl_dev->res_addr_offset & 0xFF) << 48;
-	if (res_addr_offset)
-		res_addr_offset |= (1UL << 56);
-
 	lf_cfg->enable = 1;
 	lf_cfg->profile_id = profile_id;
 	lf_cfg->rx_inline_sa_base = (uintptr_t)nix->inb_sa_base[profile_id];
-- 
2.34.1

