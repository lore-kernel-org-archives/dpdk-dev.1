Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51021C021B5
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 09:53:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15E22406BA;
	Mon, 24 Feb 2025 10:53:47 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 5BDD2402F0
 for <dev@dpdk.org>; Mon, 24 Feb 2025 10:53:44 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O9ZHmN016163
 for <dev@dpdk.org>; Mon, 24 Feb 2025 01:53:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=l
 HioFiN0FN9vBZh8UPXjunVFRiJyAtR4fA4HVVwpgHM=; b=dDSjSbNkr5BZ6Earc
 x/J99oqh80wP8JAUf7ObJn3Bdwdp8AgXTfJXeuyQXj3vpYqxWuFF35m3RimceOZM
 f3TgKtCW6tuipfzT9RPugH/B+/DzLEl1SJBxt7+OI1rLEVawp0p5irHUHS5v42yQ
 tJBa01Eo9VegxbO6Zrn7BmRsA0hb1cGNVtPs3QfeCK4SI7nvwS4ZcQE+bRUHMRUr
 LfB8S8qO+p7XDAokPSNd5vulUTFX1aTkVmVxXR/9iiPylfRdjpMiw6dp1iw3TujN
 P7PRCdP1f31dRLHekI/+wUX0pkhuCDr6S/P0cavJkiZLisLOhJkbRK5V+ZpoTnSV
 aS66A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 450p9301ab-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 24 Feb 2025 01:53:43 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Feb 2025 01:53:28 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 24 Feb 2025 01:53:28 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 71C2D3F705D;
 Mon, 24 Feb 2025 01:53:25 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: <jerinj@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>, "Kiran
 Kumar K" <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, Anoob Joseph <anoobj@marvell.com>
Subject: [PATCH v3 08/33] common/cnxk: add CPT cn20k device enumeration
Date: Mon, 24 Feb 2025 15:22:16 +0530
Message-ID: <20250224095241.1263700-8-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224095241.1263700-1-ndabilpuram@marvell.com>
References: <20250131080530.3224977-1-ndabilpuram@marvell.com>
 <20250224095241.1263700-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ZYBv5YAHItQT7lym_SUI1OT2wvpL9Qki
X-Proofpoint-GUID: ZYBv5YAHItQT7lym_SUI1OT2wvpL9Qki
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

From: Anoob Joseph <anoobj@marvell.com>

Add CPT cn20k device enumeration.

Signed-off-by: Anoob Joseph <anoobj@marvell.com>
---
 drivers/common/cnxk/roc_constants.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/common/cnxk/roc_constants.h b/drivers/common/cnxk/roc_constants.h
index 67cd74b28a..ac492651de 100644
--- a/drivers/common/cnxk/roc_constants.h
+++ b/drivers/common/cnxk/roc_constants.h
@@ -55,6 +55,8 @@
 #define PCI_DEVID_CN9K_RVU_CPT_VF  0xA0FE
 #define PCI_DEVID_CN10K_RVU_CPT_PF 0xA0F2
 #define PCI_DEVID_CN10K_RVU_CPT_VF 0xA0F3
+#define PCI_DEVID_CN20K_RVU_CPT_PF 0xA0F2
+#define PCI_DEVID_CN20K_RVU_CPT_VF 0xA0F3
 
 #define PCI_DEVID_CN10K_ML_PF 0xA092
 
-- 
2.34.1

