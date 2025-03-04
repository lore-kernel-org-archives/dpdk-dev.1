Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE69C021B8
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Mar 2025 05:25:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A0C6140156;
	Tue,  4 Mar 2025 06:25:36 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id C475140041
 for <dev@dpdk.org>; Tue,  4 Mar 2025 06:25:35 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523NUEGZ020220
 for <dev@dpdk.org>; Mon, 3 Mar 2025 21:25:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=iPOCiFKDQt+uOhPr+yXz2WF
 KdR8jDI0SCvk//t5ucg8=; b=cCPDSzwGNKGJaGsVwCskmBMV+KJEZmX6Wfd6dJ+
 rsjs8cfrBqtPYnlm8Ondnt0jR/eERvoJPQ0SIAGE5rRJvAm3ZLG6hjM1vCRJjdUj
 aywvaZpAANUACnrBG+QIF6GEDoQoWL/H0NpgfzBSc+FvVYvlPUt946SHBUzb0cdG
 p0sZfO+mAGkcFTxJ8jfIP4Ahi7VAqFrGJMnRqup1rHYH/EEylocs2tOc9fO6hx3i
 Dvx2STH4M+CS2TeSvqBd/C2muPR94MtRKZo0qm91ghk/P9pz0a8T1vt+9fW73sKb
 YIB4XBSg0gEhzZsof+Pc5H3T7FhVvtQA9EfSA5LcfzoiV6w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 455p5c8m27-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 03 Mar 2025 21:25:34 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 3 Mar 2025 21:25:33 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 3 Mar 2025 21:25:33 -0800
Received: from cavium-DT-30.. (unknown [10.28.36.108])
 by maili.marvell.com (Postfix) with ESMTP id 922083F707A;
 Mon,  3 Mar 2025 21:25:30 -0800 (PST)
From: Nawal Kishor <nkishor@marvell.com>
To: <dev@dpdk.org>, Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>, "Kiran
 Kumar K" <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <asekhar@marvell.com>, Nawal Kishor
 <nkishor@marvell.com>
Subject: [PATCH] common/cnxk: add flag for enabling opaque mode
Date: Tue, 4 Mar 2025 10:55:25 +0530
Message-ID: <20250304052525.796933-1-nkishor@marvell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: OmP70LqdoKv5ay7xmp9RkESxY02H6kOi
X-Proofpoint-GUID: OmP70LqdoKv5ay7xmp9RkESxY02H6kOi
X-Authority-Analysis: v=2.4 cv=fqQmZE4f c=1 sm=1 tr=0 ts=67c68ece cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Vs1iUdzkB0EA:10 a=M5GUcnROAAAA:8 a=o__PfNfa7gbrGdmppZwA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_02,2025-03-03_04,2024-11-22_01
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

Added flag that overrides the default natural alignment mode and uses
opaque mode.

Signed-off-by: Nawal Kishor <nkishor@marvell.com>
---
 drivers/common/cnxk/roc_npa.c | 3 +++
 drivers/common/cnxk/roc_npa.h | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/common/cnxk/roc_npa.c b/drivers/common/cnxk/roc_npa.c
index a33f9a8499..d5ebfbfc11 100644
--- a/drivers/common/cnxk/roc_npa.c
+++ b/drivers/common/cnxk/roc_npa.c
@@ -669,6 +669,9 @@ roc_npa_pool_create(uint64_t *aura_handle, uint32_t block_size,
 		pool = &defpool;
 	}
 
+	if (flags & ROC_NPA_FORCE_OPAQUE_MODE_F)
+		pool->nat_align = 0;
+
 	rc = npa_aura_pool_pair_alloc(lf, block_size, block_count, aura, pool,
 				      aura_handle, flags);
 	if (rc) {
diff --git a/drivers/common/cnxk/roc_npa.h b/drivers/common/cnxk/roc_npa.h
index 8525038810..853c0fed43 100644
--- a/drivers/common/cnxk/roc_npa.h
+++ b/drivers/common/cnxk/roc_npa.h
@@ -767,7 +767,8 @@ int __roc_api roc_npa_dev_init(struct roc_npa *roc_npa);
 int __roc_api roc_npa_dev_fini(struct roc_npa *roc_npa);
 
 /* Flags to pool create */
-#define ROC_NPA_ZERO_AURA_F BIT(0)
+#define ROC_NPA_ZERO_AURA_F	    BIT(0)
+#define ROC_NPA_FORCE_OPAQUE_MODE_F BIT(1)
 
 /* Enumerations */
 enum roc_npa_buf_type {
-- 
2.34.1

