Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AFBC3ABD8
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 May 2025 12:55:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8FB2B4065B;
	Mon, 19 May 2025 14:54:59 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id C223240276
 for <dev@dpdk.org>; Mon, 19 May 2025 14:54:58 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J0xMxV014535
 for <dev@dpdk.org>; Mon, 19 May 2025 05:54:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=j
 iYTeFDHCcA7fUkC/Zmi/NSklPyp49KGrOVVLUox4rU=; b=TbcSDxJ1hLgCb5Ea7
 9D5SWT6FPqqOzeIKAEGxOpgBMky9q7Gp9maLxK4dfgke98kPAmpsmLB9dbCWkLyP
 4E1WBK2IbPaswfVaRjvi24C3bE7fG1kvXYyYmY/h7jWK1Ep2vJosrMR3BOiyuwc3
 +61aVczZjDyKMdYjSQMK4w3C2cb9wbsbaAz7u2BbC4buCBL1OsOae57dGK0bLcCB
 fMI30HZRST5UXXkWm5yxSNjDVhwR3yFw52KmOQkc/07GjhmngcF7ED3d8o98P3+F
 +WhZhWkhmOr4Xp4gos0wsbVAFo1k5bQIhrC70DEUZiHdn2OIQNDOXpNEW315N8na
 eYqQw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46q46fad74-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 19 May 2025 05:54:57 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 19 May 2025 05:54:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 19 May 2025 05:54:57 -0700
Received: from localhost.localdomain (unknown [10.28.36.158])
 by maili.marvell.com (Postfix) with ESMTP id 20CB03F7055;
 Mon, 19 May 2025 05:54:53 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH 4/6] common/cnxk: update inbound CPT LF ID
Date: Mon, 19 May 2025 18:24:22 +0530
Message-ID: <20250519125424.1435140-4-rbhansali@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250519125424.1435140-1-rbhansali@marvell.com>
References: <20250519125424.1435140-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=b8uy4sGx c=1 sm=1 tr=0 ts=682b2a21 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=c-GMVqsASlz92QvtOfEA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: zvrl3E6A7hno_evH8bARRYfTJ6d-7OjE
X-Proofpoint-ORIG-GUID: zvrl3E6A7hno_evH8bARRYfTJ6d-7OjE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDEyMCBTYWx0ZWRfX8wzPVLi5FZvc
 lubQ/RlDbv/FfNESz+PJ7xZAqG9q4xFCyEvyF/Y/8pNwAOUxM1COOSL1dBTZHt4EWUca1yya9Tj
 wwPWTofZTokpB3UyGs1XIOGT6ZFcSU9Hub2vo/pjtCJM/3//ntmeh0uA2KhY37bLYZeBK+jRqmx
 niAJMVyj3q0esK2VVUHZpJNxJfX7ipsvm/VTmWB64JYzoqFxA2O1Uoqh93g5uW7eEvZyOXXTJv+
 8Hg5eZ99LMydnZ678c9lmsNJ7y/g6YuEwR5MaQhKy4il29RR8haMRmP3dkKzjRzmT6QfIGKhOn1
 eskaWk9MF8Z3kSITZyddWxjna7r+OtBHstHvUbiyPXDEwvgT7gUMHBff1kjGOtyI486G73xtv98
 lnWyNtTTQNkdp8D9WGn3vOKQRbBdOaUGYSIcutONKtYLEcQdvBSAZj/VDfy4ICK36ziAW2Uv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_05,2025-05-16_03,2025-03-28_01
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

Inbound CPT LF ID update for Rx inline config.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 drivers/common/cnxk/roc_nix_inl.c      | 10 +++++++++-
 drivers/common/cnxk/roc_nix_inl_dev.c  |  4 +---
 drivers/common/cnxk/roc_nix_inl_priv.h |  2 +-
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/common/cnxk/roc_nix_inl.c b/drivers/common/cnxk/roc_nix_inl.c
index 7e47151eee..bee8e25c7c 100644
--- a/drivers/common/cnxk/roc_nix_inl.c
+++ b/drivers/common/cnxk/roc_nix_inl.c
@@ -495,7 +495,7 @@ nix_inl_inb_ipsec_sa_tbl_setup(struct roc_nix *roc_nix)
 			if (!inl_dev->nb_inb_cptlfs)
 				def_cptq = 0;
 			else
-				def_cptq = inl_dev->nix_inb_qids[0];
+				def_cptq = inl_dev->nix_inb_qids[inl_dev->inb_cpt_lf_id];
 		}
 
 		res_addr_offset = (uint64_t)(inl_dev->res_addr_offset & 0xFF) << 48;
@@ -1997,6 +1997,14 @@ roc_nix_inl_rq_ena_dis(struct roc_nix *roc_nix, bool enable)
 
 		inl_dev = idev->nix_inl_dev;
 
+		if (!roc_model_is_cn10k()) {
+			if (inl_rq->spb_ena) {
+				rc = -EINVAL;
+				plt_err("inline RQ enable is not supported rc=%d", rc);
+				return rc;
+			}
+		}
+
 		rc = nix_rq_ena_dis(&inl_dev->dev, inl_rq, enable);
 		if (rc)
 			return rc;
diff --git a/drivers/common/cnxk/roc_nix_inl_dev.c b/drivers/common/cnxk/roc_nix_inl_dev.c
index 1f071df8ea..75d03c1077 100644
--- a/drivers/common/cnxk/roc_nix_inl_dev.c
+++ b/drivers/common/cnxk/roc_nix_inl_dev.c
@@ -385,7 +385,6 @@ nix_inl_nix_ipsec_cfg(struct nix_inl_dev *inl_dev, bool ena)
 			goto exit;
 		}
 
-		/*TODO default cptq */
 		if (!inl_dev->nb_inb_cptlfs)
 			def_cptq = 0;
 		else
@@ -646,11 +645,10 @@ nix_inl_nix_profile_config(struct nix_inl_dev *inl_dev, uint8_t profile_id)
 	sa_w = plt_log2_u32(max_sa);
 	sa_pow2_sz = plt_log2_u32(inb_sa_sz);
 
-	/*TODO default cptq, Assuming Reassembly cpt lf ID at inl_dev->inb_cpt_lf_id + 1 */
 	if (!inl_dev->nb_inb_cptlfs)
 		def_cptq = 0;
 	else
-		def_cptq = inl_dev->nix_inb_qids[inl_dev->inb_cpt_lf_id + 1];
+		def_cptq = inl_dev->nix_inb_qids[inl_dev->inb_cpt_lf_id];
 
 	res_addr_offset = (uint64_t)(inl_dev->res_addr_offset & 0xFF) << 48;
 	if (res_addr_offset)
diff --git a/drivers/common/cnxk/roc_nix_inl_priv.h b/drivers/common/cnxk/roc_nix_inl_priv.h
index 33073b2f34..5c12fb1160 100644
--- a/drivers/common/cnxk/roc_nix_inl_priv.h
+++ b/drivers/common/cnxk/roc_nix_inl_priv.h
@@ -134,7 +134,7 @@ struct nix_inl_dev {
 
 #define NIX_INL_REASS_GEN_CFG                                                                      \
 	(BIT_ULL(51) | (ROC_CPT_DFLT_ENG_GRP_SE << 48) |                                           \
-	 (ROC_IE_OW_MAJOR_OP_PROCESS_INBOUND_REASS << 32))
+	 (ROC_IE_OW_MAJOR_OP_PROCESS_INBOUND_REASS << 32 | ROC_IE_OW_INPLACE_BIT << 32))
 
 int nix_inl_sso_register_irqs(struct nix_inl_dev *inl_dev);
 void nix_inl_sso_unregister_irqs(struct nix_inl_dev *inl_dev);
-- 
2.25.1

