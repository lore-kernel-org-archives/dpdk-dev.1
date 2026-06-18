Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD99CD98F8
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 14:13:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E32A040E42;
	Thu, 18 Jun 2026 16:12:06 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 760D940E2D;
 Thu, 18 Jun 2026 16:12:04 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 530831A0019;
 Thu, 18 Jun 2026 16:12:04 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1D0021A004A;
 Thu, 18 Jun 2026 16:12:04 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id B79DA180004C;
 Thu, 18 Jun 2026 22:12:02 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	david.marchand@redhat.com,
	dev@dpdk.org
Cc: stable@dpdk.org,
	Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v1 08/17] bus/dpaa: fix device probe issue
Date: Thu, 18 Jun 2026 19:41:42 +0530
Message-Id: <20260618141151.3990283-9-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260618141151.3990283-1-hemant.agrawal@nxp.com>
References: <20260618141151.3990283-1-hemant.agrawal@nxp.com>
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

Remove an unintended early return in the LS1043 SoC version
check that was preventing device probing from completing
successfully on LS1043 platforms.

Fixes: 164e9e13e5 ("bus/dpaa: enhance SoC version")
Cc: stable@dpdk.org

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/bus/dpaa/dpaa_bus.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index ee467b94d5..0ed617c72f 100644
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
@@ -725,10 +725,8 @@ rte_dpaa_bus_scan(void)
 	}
 
 	/* Disabling the default push mode for LS1043A */
-	if (dpaa_bus.svr_ver == SVR_LS1043A_FAMILY) {
+	if (dpaa_bus.svr_ver == SVR_LS1043A_FAMILY)
 		dpaa_bus.max_push_rxq_num = 0;
-		return 0;
-	}
 
 	penv = getenv("DPAA_PUSH_QUEUES_NUMBER");
 	if (penv)
-- 
2.43.0

