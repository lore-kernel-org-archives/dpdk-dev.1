Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0EEC43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Jul 2026 10:18:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57E1140E0A;
	Mon, 13 Jul 2026 12:18:00 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id D470940A87;
 Mon, 13 Jul 2026 12:17:58 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B66E5200026;
 Mon, 13 Jul 2026 12:17:58 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 80AB0200015;
 Mon, 13 Jul 2026 12:17:58 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id C587618000B5;
 Mon, 13 Jul 2026 18:17:56 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: stable@dpdk.org,
	Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v5 06/18] bus/dpaa: fix BMI RX stats register offset
Date: Mon, 13 Jul 2026 15:47:35 +0530
Message-Id: <20260713101747.2947405-7-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260713101747.2947405-1-hemant.agrawal@nxp.com>
References: <20260713092616.2902828-1-hemant.agrawal@nxp.com>
 <20260713101747.2947405-1-hemant.agrawal@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

From: Jun Yang <jun.yang@nxp.com>

Fix incorrect register offset for BMI RX statistics counters
in the fman.h header. The wrong offset caused incorrect stats
values to be reported.

Fixes: 0095306cdbda ("bus/dpaa: add FMan node")
Cc: stable@dpdk.org

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/dpaa/include/fman.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/dpaa/include/fman.h b/drivers/bus/dpaa/include/fman.h
index c33fe81516..6e3abf1b50 100644
--- a/drivers/bus/dpaa/include/fman.h
+++ b/drivers/bus/dpaa/include/fman.h
@@ -2,7 +2,7 @@
  *
  * Copyright 2010-2012 Freescale Semiconductor, Inc.
  * All rights reserved.
- * Copyright 2019-2024 NXP
+ * Copyright 2019-2026 NXP
  *
  */
 
@@ -263,8 +263,8 @@ struct rx_bmi_regs {
 					/**< Buffer Manager pool Information-*/
 	uint32_t fmbm_acnt[FMAN_PORT_MAX_EXT_POOLS_NUM];
 					/**< Allocate Counter-*/
-	uint32_t reserved0120[16];
-					/**< 0x130/0x140 - 0x15F reserved -*/
+	uint32_t reserved0140[8];
+					/**< 0x140 - 0x15F reserved -*/
 	uint32_t fmbm_rcgm[FMAN_PORT_CG_MAP_NUM];
 					/**< Congestion Group Map*/
 	uint32_t fmbm_mpd;		/**< BM Pool Depletion  */
-- 
2.25.1

