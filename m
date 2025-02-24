Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E7BC021B3
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 09:39:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8CBB940685;
	Mon, 24 Feb 2025 10:39:34 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id A5A9B40696
 for <dev@dpdk.org>; Mon, 24 Feb 2025 10:39:32 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O51MXD001463
 for <dev@dpdk.org>; Mon, 24 Feb 2025 01:39:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=+
 e3w3ZPWMfQZCoMesnS9iejTpsuDjWXh8nG0+M/uyzg=; b=a9pg3kdoN6/TFBcgb
 BALOCP9aJz3+JQJoRbgPCHG4rARU0R196OtibkExSGxON0G9I+xk5fESrLkn299m
 246Llhd0RkzPYNJ+mTttY+Qf5yn4wnP8qmXjRpKO62DokxAmktQI79LJ0uP5YnHk
 wFZKct7ymyodCBUUwWifbUpjk63UWM8wihOanVb+kxhxUkvLpUf25s5FW8iNQSrd
 9tb6f/V64sZ+DUxhqtIhtfH+dtRRxoGtBISZ+4DfxcmHROngekQk5XTXmELS1ZaX
 5h438y9/G/zwGl1w7pcwfOAxU8GpNPTixAKrqwIxcVVTJ3m65jMa4VwqYJfsVYou
 n5WIw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44ys85jfv3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 24 Feb 2025 01:39:31 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Feb 2025 01:39:30 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 24 Feb 2025 01:39:30 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 320713F705D;
 Mon, 24 Feb 2025 01:39:27 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: <jerinj@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>, "Kiran
 Kumar K" <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, Anoob Joseph <anoobj@marvell.com>
Subject: [PATCH v2 04/33] common/cnxk: move CTX defines to common
Date: Mon, 24 Feb 2025 15:08:46 +0530
Message-ID: <20250224093915.1253215-4-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224093915.1253215-1-ndabilpuram@marvell.com>
References: <20250131080530.3224977-1-ndabilpuram@marvell.com>
 <20250224093915.1253215-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: vDMIIPPYOzW7g2E0NDII12_ca82m6p49
X-Proofpoint-ORIG-GUID: vDMIIPPYOzW7g2E0NDII12_ca82m6p49
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

CTX defines are common for all cases using CPT CTX.

Signed-off-by: Anoob Joseph <anoobj@marvell.com>
---
 drivers/common/cnxk/cnxk_security.h |  1 +
 drivers/common/cnxk/roc_cpt.h       | 16 ++++++++++++++++
 drivers/common/cnxk/roc_ie_ot.h     | 16 ----------------
 drivers/net/cnxk/cn10k_rxtx.h       |  4 ++--
 drivers/net/cnxk/cn20k_rxtx.h       |  4 ++--
 5 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/common/cnxk/cnxk_security.h b/drivers/common/cnxk/cnxk_security.h
index cd78b283f0..8ede6c88a3 100644
--- a/drivers/common/cnxk/cnxk_security.h
+++ b/drivers/common/cnxk/cnxk_security.h
@@ -7,6 +7,7 @@
 #include <rte_crypto.h>
 #include <rte_security.h>
 
+#include "roc_cpt.h"
 #include "roc_ie_on.h"
 #include "roc_ie_ot.h"
 
diff --git a/drivers/common/cnxk/roc_cpt.h b/drivers/common/cnxk/roc_cpt.h
index 0b9c933925..70129531eb 100644
--- a/drivers/common/cnxk/roc_cpt.h
+++ b/drivers/common/cnxk/roc_cpt.h
@@ -104,6 +104,22 @@
 
 #define ROC_CPT_RES_ALIGN 16
 
+/* Context units in bytes */
+#define ROC_CTX_UNIT_8B		  8
+#define ROC_CTX_UNIT_128B	  128
+#define ROC_CTX_MAX_CKEY_LEN	  32
+#define ROC_CTX_MAX_OPAD_IPAD_LEN 128
+
+/* Anti reply window size supported */
+#define ROC_AR_WIN_SIZE_MIN	   64
+#define ROC_AR_WIN_SIZE_MAX	   4096
+#define ROC_LOG_MIN_AR_WIN_SIZE_M1 5
+
+/* u64 array size to fit anti replay window bits */
+#define ROC_AR_WINBITS_SZ                                                      \
+	(PLT_ALIGN_CEIL(ROC_AR_WIN_SIZE_MAX, BITS_PER_LONG_LONG) /             \
+	 BITS_PER_LONG_LONG)
+
 enum {
 	ROC_CPT_REVISION_ID_83XX = 0,
 	ROC_CPT_REVISION_ID_96XX_B0 = 1,
diff --git a/drivers/common/cnxk/roc_ie_ot.h b/drivers/common/cnxk/roc_ie_ot.h
index 26616be901..932d3b6131 100644
--- a/drivers/common/cnxk/roc_ie_ot.h
+++ b/drivers/common/cnxk/roc_ie_ot.h
@@ -155,22 +155,6 @@ roc_ie_ot_ucc_is_success(uint8_t ucc)
 	return (ucc >= uc_base);
 }
 
-/* Context units in bytes */
-#define ROC_CTX_UNIT_8B		  8
-#define ROC_CTX_UNIT_128B	  128
-#define ROC_CTX_MAX_CKEY_LEN	  32
-#define ROC_CTX_MAX_OPAD_IPAD_LEN 128
-
-/* Anti reply window size supported */
-#define ROC_AR_WIN_SIZE_MIN	   64
-#define ROC_AR_WIN_SIZE_MAX	   4096
-#define ROC_LOG_MIN_AR_WIN_SIZE_M1 5
-
-/* u64 array size to fit anti replay window bits */
-#define ROC_AR_WINBITS_SZ                                                      \
-	(PLT_ALIGN_CEIL(ROC_AR_WIN_SIZE_MAX, BITS_PER_LONG_LONG) /             \
-	 BITS_PER_LONG_LONG)
-
 #define ROC_IPSEC_ERR_RING_MAX_ENTRY 65536
 
 union roc_ot_ipsec_err_ring_head {
diff --git a/drivers/net/cnxk/cn10k_rxtx.h b/drivers/net/cnxk/cn10k_rxtx.h
index 9861aa6571..98f9e2efa3 100644
--- a/drivers/net/cnxk/cn10k_rxtx.h
+++ b/drivers/net/cnxk/cn10k_rxtx.h
@@ -27,8 +27,6 @@
 #include "hw/npc.h"
 #include "hw/ssow.h"
 
-#include "roc_ie_ot.h"
-
 /* NPA */
 #include "roc_npa_dp.h"
 
@@ -38,6 +36,8 @@
 /* CPT */
 #include "roc_cpt.h"
 
+#include "roc_ie_ot.h"
+
 /* NIX Inline dev */
 #include "roc_nix_inl_dp.h"
 
diff --git a/drivers/net/cnxk/cn20k_rxtx.h b/drivers/net/cnxk/cn20k_rxtx.h
index 4a8f194eb8..7aa06444e2 100644
--- a/drivers/net/cnxk/cn20k_rxtx.h
+++ b/drivers/net/cnxk/cn20k_rxtx.h
@@ -27,8 +27,6 @@
 #include "hw/npc.h"
 #include "hw/ssow.h"
 
-#include "roc_ie_ot.h"
-
 /* NPA */
 #include "roc_npa_dp.h"
 
@@ -38,6 +36,8 @@
 /* CPT */
 #include "roc_cpt.h"
 
+#include "roc_ie_ot.h"
+
 /* NIX Inline dev */
 #include "roc_nix_inl_dp.h"
 
-- 
2.34.1

