Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071D9C43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Jul 2026 10:18:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A0A740E17;
	Mon, 13 Jul 2026 12:18:04 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 4606640E01;
 Mon, 13 Jul 2026 12:18:01 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2B6D31A000C;
 Mon, 13 Jul 2026 12:18:01 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E91AA1A001D;
 Mon, 13 Jul 2026 12:18:00 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 96067180022C;
 Mon, 13 Jul 2026 18:17:59 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: stable@dpdk.org,
	Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v5 08/18] bus/dpaa: fix device probe issue
Date: Mon, 13 Jul 2026 15:47:37 +0530
Message-Id: <20260713101747.2947405-9-hemant.agrawal@nxp.com>
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

From: Gagandeep Singh <g.singh@nxp.com>

Remove an unintended early return in the LS1043 SoC version check
that was preventing device probing from completing successfully on
LS1043A platforms.

The early return did two things: set max_push_rxq_num = 0 and skip
the DPAA_PUSH_QUEUES_NUMBER env-var override. With the return gone,
the env-var could inadvertently re-enable push mode on LS1043A, which
must remain disabled due to the FMAN push-mode errata handled in
dpaa_rxtx.c. Guard the env-var override so it only applies to
non-LS1043A SoCs.

Fixes: 164e9e13e50f ("bus/dpaa: enhance SoC version")
Cc: stable@dpdk.org

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/bus/dpaa/dpaa_bus.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index 54779f82f7..368c8eeb98 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
- * Copyright 2017-2025 NXP
+ * Copyright 2017-2026 NXP
  *
  */
 /* System headers */
@@ -724,18 +724,17 @@ rte_dpaa_bus_scan(void)
 			dpaa_bus.svr_ver);
 	}
 
-	/* Disabling the default push mode for LS1043A */
+	/* Disabling the default push mode for LS1043A due to errata */
 	if (dpaa_bus.svr_ver == SVR_LS1043A_FAMILY) {
 		dpaa_bus.max_push_rxq_num = 0;
-		return 0;
+	} else {
+		penv = getenv("DPAA_PUSH_QUEUES_NUMBER");
+		if (penv)
+			dpaa_bus.max_push_rxq_num = atoi(penv);
+		if (dpaa_bus.max_push_rxq_num > DPAA_MAX_PUSH_MODE_QUEUE)
+			dpaa_bus.max_push_rxq_num = DPAA_MAX_PUSH_MODE_QUEUE;
 	}
 
-	penv = getenv("DPAA_PUSH_QUEUES_NUMBER");
-	if (penv)
-		dpaa_bus.max_push_rxq_num = atoi(penv);
-	if (dpaa_bus.max_push_rxq_num > DPAA_MAX_PUSH_MODE_QUEUE)
-		dpaa_bus.max_push_rxq_num = DPAA_MAX_PUSH_MODE_QUEUE;
-
 	/* Device list creation is only done once */
 	if (!process_once) {
 		rte_dpaa_bus_dev_build();
-- 
2.25.1

