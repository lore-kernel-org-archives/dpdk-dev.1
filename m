Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2B1C021B3
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 09:56:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AEEA940ED3;
	Mon, 24 Feb 2025 10:55:03 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 8ACD640B90
 for <dev@dpdk.org>; Mon, 24 Feb 2025 10:54:52 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O51DKY001315
 for <dev@dpdk.org>; Mon, 24 Feb 2025 01:54:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=c
 YXx4JaZAJZ2ekz2bXTJKqHTanCHDJrQQB1gVPx3jr8=; b=PEcRiO7SXYGOQW2BN
 TWY7Dv/BH8CRwWSJkCcLvPSDgMVmHNGiF/8JlhUqbcIjnFYx245eFrk1CvialGj8
 zKDn+OjaXFHqFkl8mSh7xS0Nx9lnIeQD/Z+8fos3gMfOGZNO6kaBoEpAI4YZh8/3
 zQRoJo2/RPbg0Hsjp5za/YWOtKWgICjyyYqQbnlzX41uyoFPU3uY/si7whssx7VB
 R8mbkF0s8yU8Y8BGsHYzbGe+gIyWUD0dbHObPOKyrBL94jWYk1/BEXmaeppUil+C
 5rS01eqHvlegF8ylVFL1NMjrm3SIvgI8aysIpiOK6HSc20cV16djMleb/Le+o014
 55lCA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44ys85jh2x-13
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 24 Feb 2025 01:54:51 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Feb 2025 01:54:42 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 24 Feb 2025 01:54:42 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 3A0473F7062;
 Mon, 24 Feb 2025 01:54:38 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: <jerinj@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>, "Kiran
 Kumar K" <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, Srujana Challa <schalla@marvell.com>
Subject: [PATCH v3 31/33] common/cnxk: change the error log to a debug log
Date: Mon, 24 Feb 2025 15:22:39 +0530
Message-ID: <20250224095241.1263700-31-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224095241.1263700-1-ndabilpuram@marvell.com>
References: <20250131080530.3224977-1-ndabilpuram@marvell.com>
 <20250224095241.1263700-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: IMsfws5Z3Yc2LqNtQAH2_qeBi41qbgCU
X-Proofpoint-ORIG-GUID: IMsfws5Z3Yc2LqNtQAH2_qeBi41qbgCU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_04,2025-02-24_01,2024-11-22_01
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

From: Srujana Challa <schalla@marvell.com>

This patch updates the error log to a debug log since
it is not needed.

Signed-off-by: Srujana Challa <schalla@marvell.com>
---
 drivers/common/cnxk/roc_nix_inl_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/common/cnxk/roc_nix_inl_dev.c b/drivers/common/cnxk/roc_nix_inl_dev.c
index 2e753440b7..376582f5db 100644
--- a/drivers/common/cnxk/roc_nix_inl_dev.c
+++ b/drivers/common/cnxk/roc_nix_inl_dev.c
@@ -1250,7 +1250,7 @@ roc_nix_inl_dev_qptr_get(uint8_t qid)
 		inl_dev = idev->nix_inl_dev;
 
 	if (!inl_dev) {
-		plt_err("Inline Device could not be detected");
+		plt_nix_dbg("Inline Device could not be detected");
 		return NULL;
 	}
 	if (!inl_dev->attach_cptlf) {
-- 
2.34.1

