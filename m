Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363ACC54ED1
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 May 2025 15:54:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0C9C40DDE;
	Fri, 23 May 2025 17:54:49 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id D8ABE40DCF
 for <dev@dpdk.org>; Fri, 23 May 2025 17:54:48 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NB9k4G030039
 for <dev@dpdk.org>; Fri, 23 May 2025 08:54:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=b
 C2uw8xGVXvrOSjVg2WV1eciV+qr/9ofQ8z1m00cD8s=; b=f+ercG9XHlI+rCqgd
 3128Tl20IkNqcw7mrRDpktnbHqmWVk+Ln1yCArVzMieHESADyQ1q9ZVqz2df+Gpl
 kgheZAsbLgSc02+i99tu2u4ADMSB8sEDj3mmP7MfQ8LWgWph2oxMh49U3mviDnCx
 PUhR2ZneN2v9pAUE6WiwTiu0VRhs60+Vsex7Cgz+4Z6sI7HMhRz19YI2rSiIM+Om
 ow18EhyZ3XZ74KTRsb6r51xuKmD88d4i2hhPTtNOuPbQ+3SusD8Bw7uQfJqs4iEk
 vi+ui69DwrPGDrxnKlcSRnj/HvUocx1IivBbqOnVVKOEzl0K10C76TIZeCbldg9h
 pvUrA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46tqw58hkw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 23 May 2025 08:54:47 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 23 May 2025 08:54:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 23 May 2025 08:54:36 -0700
Received: from localhost.localdomain (unknown [10.28.36.158])
 by maili.marvell.com (Postfix) with ESMTP id 649563F7078;
 Fri, 23 May 2025 08:54:33 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, Rahul Bhansali
 <rbhansali@marvell.com>
CC: <jerinj@marvell.com>
Subject: [PATCH v2 4/6] common/cnxk: fix inbound CPT LF ID
Date: Fri, 23 May 2025 21:23:45 +0530
Message-ID: <20250523155347.1156891-4-rbhansali@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250523155347.1156891-1-rbhansali@marvell.com>
References: <20250519125424.1435140-1-rbhansali@marvell.com>
 <20250523155347.1156891-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=F8xXdrhN c=1 sm=1 tr=0 ts=68309a47 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=hmcnP8TJ9tC2gO9EGf4A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDE0NCBTYWx0ZWRfX5XG78DE1vhe3
 1aQON4phP51KtC8JUOMpuJkM+utu8uZCac2Rwak+RZcgUvJPChvQ9sxZYuS3iBITkViDgJbdnAq
 MeR132VGbMNcEwitbpBRz005sI1eEeUUdS2vw+4OSr12WKqjbz2JlDniBC9Hj60ss3UJJ3E/QJM
 TuwkVJ2tMvWonWJAH77T/f317vbxZb3u+Rz+cY7HyHK2ChXLxJRvNsU1mJ4Ihp4IAnkszrx6aGn
 kNRNZ6fksTyK8tVHOaCF1IBfyCRMTm88YvC89ty+lVfPz3it+tkYkypm2hrSu+7ToKifSz0VQdn
 6U92BuPwEZwOCY+RRmvBMHIOahwKsdBdrNshABnwNi/2YIe7Tliiw08RteywyQdhRfWiosMN5m5
 4NYixYnYpfZuQOUJSk8jXbAnc1emO0mUeYU5FaBIQyKaERdsfUPpYvGIKD5rwroGkDhgLoKg
X-Proofpoint-GUID: -h6aTpT8p1UxR-sO-Ta2BielT2Ka6KGw
X-Proofpoint-ORIG-GUID: -h6aTpT8p1UxR-sO-Ta2BielT2Ka6KGw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_05,2025-05-22_01,2025-03-28_01
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

Inbound CPT LF ID was fixed to 0th index,
It fixes to update relative LF ID for Rx inline
config.

Fixes: fc9a711b5c8f ("common/cnxk: add NIX inline reassembly profile config")

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
Changes in v2: updated the commit message.

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

