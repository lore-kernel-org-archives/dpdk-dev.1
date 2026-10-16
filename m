Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F5CCCF2C4
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 19:59:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89F6940659;
	Fri, 16 Oct 2026 21:59:05 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013012.outbound.protection.outlook.com [52.101.72.12])
 by mails.dpdk.org (Postfix) with ESMTP id C8C1440291;
 Fri, 16 Oct 2026 21:59:02 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G0ld6tEYqSupH2sXG1Tn5+REvmrfF+PKVbYixyakqzz3XOZweV3m1lYB5r+v1Q8LTEx1KqjuLkwT70TgIlqV6V/F1FW5PlxgT7lQbG+T0CpU2k/6eqNjX6OfG0tNyIGdHuj7JQFUUD0TPLW036Ntxl2DQ1GVmA1Ab4QmkYJRwpEGa5jbfp52XhDwew/wejHwDkAxJ0vzyLcnj0eTKYCBaVdQglm2rZFFafICzIBkA0xtLHi1M5eogJcoVI+wOBCbdDVu7nipM47z7PrGAkZpKIGw0AwTqdDmt6DMnqkFfKPZpB7sYxzHzL+kW1nXXRazxckVDpaeAwzAVaEpHnZSPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9eGwPV0lXJ98ZrMutRRREYE5oUCziWWcacpeIPzm4I=;
 b=InwMsbw72EGL17BN0eH/wap08i9X0nPPdzncFWY5AhNtNHkmttQK5Cxm3qfD7joksQmTr8+CpnrQOzfQ4YDlW0Nmvr8eA91XUgMFJ3wAHp8NRGou0kPwigvy+hZyXfF6SSiR/bY7NhRl+vxGVGXfp3r1KZfjbKQyDQ0eM92gXMpBiIT1i1rFQKrQVhzUTh1jmlFlRNNV7W8jGNUesGYHMQuSzdv77LEFsgujZ9WAqpN1JbN+eYVofyZMNm0egRU18cvzaJXQJJHuw4BgAT1OIkEg3E8bGnDT4TWHymhsu687RJoh2+TmWNU7Ez4oQi3YpFXOee3/qMq1KDBi6worjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=cisco.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9eGwPV0lXJ98ZrMutRRREYE5oUCziWWcacpeIPzm4I=;
 b=REognul5IYTSDdJvRraKukT+mSVIb1vprW9fMPxXtJHUjAl/WsDWwCeW8U0eHXymKZFb2bZlsLs3j13D3JzuGwrCxhkAJYoJfkhlGbpYFQUUIfn9FjvH7L5JPOKGAAm40yHaQj7bMuXqP6ZQEVIoBbdT7iHQNg3tpX7CRqD3VFXTJSfokgUQnax9u3TYTp90ZPMAEPoWuASsGC98sAmV4CxaXqf/Su/rK3lagd0QOXj2Xtk4j+J7/7uAyj12w6ISrpZg8kKtxZ4jKFYlq5H9dVzpgWFWq2EHVS58MtJxrVeF6sxWDgpHEMr8nKz31HqO59qAIMZ5gBCU8P4hgX4OaQ==
Received: from MA3P292CA0008.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250:2c::8) by
 PAVPR07MB9189.eurprd07.prod.outlook.com (2603:10a6:102:2f9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 19:58:59 +0000
Received: from MAD0EPF000008B4.eurprd04.prod.outlook.com
 (2603:10a6:250:2c:cafe::a1) by MA3P292CA0008.outlook.office365.com
 (2603:10a6:250:2c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 19:58:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 MAD0EPF000008B4.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 19:58:59 +0000
Received: from seliius19819.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 16 Oct 2026 21:58:58 +0200
Received: from seliiuvd10563.seli.gic.ericsson.se
 (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
 by seliius19819.seli.gic.ericsson.se (Postfix) with ESMTP id EB5E34020B75;
 Fri, 16 Oct 2026 21:58:57 +0200 (CEST)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
 id BCFB6628589A; Fri, 16 Oct 2026 21:58:57 +0200 (CEST)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: <dev@dpdk.org>
CC: Stephen Hemminger <stephen@networkplumber.org>, Jakub Grajciar
 <jgrajcia@cisco.com>, <stable@dpdk.org>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>
Subject: [PATCH v4 3/9] net/memif: do not close EAL-owned memseg file
 descriptor
Date: Fri, 16 Oct 2026 21:58:51 +0200
Message-ID: <20261016195857.3258796-4-sriram.yagnaraman@ericsson.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261016195857.3258796-1-sriram.yagnaraman@ericsson.com>
References: <20261016195857.3258796-1-sriram.yagnaraman@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008B4:EE_|PAVPR07MB9189:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d082091-8a84-4c6c-45c6-08df2bbfeb36
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|56012099006|261009223027099003|11063799006|18002099003|10067099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3HOeYCxAMuDg4oTHs9d3sN0Sk/6Rh5V9rg3KYH2gM1QrjbPmulUn2PoAox5Ntn0JMf0v2O3xn8UxthigrzblfTRwLT91pIKHwRkIkDn3GFmOdWCV0ZE7xbYCD6giu6XV/5mWkKhZzFWILw+Xh6zSDwW7ZfMAmWarI4SMC5aaxyrktAHUxsIm2HDA1YZPEZZ5DG3c3Gwh0/K+GL1vk0UO8AD8KswwECC9YNKn50diwbt3Yn3LTOdG7fdifcGA3iBpM6bDT7jJMVM6gl1SAPQ7cpaXWsNam9yOvJCO3q0X1GL6L670mjdQ3AQ7z0CqpCOa6Cst/W4772/dYmFb9IyXvOVeBW78zA+NfS9tZT1KcIAHrZ6HuhfKlsD8j8hAts3sxXVJRofq72uu/3qV7SskgaULw6zibGa5/G5Yd8Lme6W3a3lXXoBeCmcECAv4MLAcJsSWdmw5j8bqFmuUvEOoKTcKfpZNKImiUToKv4gVtPG9DbJhkPvf2cmK1qe7HFAr29JPQ3CpVQcZYJQMfYQSq8t3g8U+9is4PYlyokQ0bQQ8OHqt8cQTyBvDg5TI0egVnyTU755IF/zPU611grRp7sMqvI8EVW9NZN9a2C9Ex985NzsN1uikNb+M5hRdlaFgx/0xj3v5Y2fSzdAqqwspq+KvjvCSfQIY8edtdv453Z76D5myk1G/yQZ0ZWe3jRldSLSua7MHduceYZ9d52GX/g==
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(56012099006)(261009223027099003)(11063799006)(18002099003)(10067099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2BG80OyJDw/ObFt0zPrpA0UZNFNknHEIPrYEaRZKB99w4DI56MOuJX2GCILljwX8mICKLnJDk9PXpVSMztOt19xIfrXmgNcoS5lIAiQT6Q2VEaYvwvqaZSIScpiQhYrmRGTr5TOdhqj1TSG7tvu1mm7NMUg0/O5K2/Wk9nKm7mv1p9AcEhoS9lHZPNNUhmgjsZW7wwoDAXb/N4U2w1LIu1DOGTiOeXu47e7E19isyWTtCqGtw9plLdTCp5wIz5TovUf6GdIleAi6ofCYcDJAxXKlXqHJWf45U+EYHNUKNB4a7vgVHMRcUdjl5fr2hZ2xN+yg4ohgCwIzm4lJ794iPZDzjxsKonHF8KAy948WkSl76GBtf1KIWMh0txxx2dR+uqD34HETCgblPE1+rFe4AtjMWrHWFSFBHtiu4sMMLMuY6oma66h+oZ/iM80ute3J
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 19:58:59.3714 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d082091-8a84-4c6c-45c6-08df2bbfeb36
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008B4.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR07MB9189
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

In zero-copy mode the per-memseg regions (i > 0) take their fd from
rte_memseg_get_fd(), which rte_memory.h documents as EAL-internal and
read-only. Both memif_connect() and memif_free_regions() closed that fd,
so the next connect handed the peer a stale (possibly reused)
descriptor and the PMD closed a descriptor it does not own. Stop closing
it in both paths and just clear the region fd; the fd is not ours.

Fixes: 43b815d88188 ("net/memif: support zero-copy slave")
Cc: stable@dpdk.org

Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
---
 drivers/net/memif/rte_eth_memif.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/memif/rte_eth_memif.c b/drivers/net/memif/rte_eth_memif.c
index 1d1d12e242..e753243440 100644
--- a/drivers/net/memif/rte_eth_memif.c
+++ b/drivers/net/memif/rte_eth_memif.c
@@ -1289,9 +1289,9 @@ memif_free_regions(struct rte_eth_dev *dev)
 		if (r != NULL) {
 			/* This is memzone */
 			if (i > 0 && (pmd->flags & ETH_MEMIF_FLAG_ZERO_COPY)) {
+				/* memseg fd is owned by EAL, do not close */
 				r->addr = NULL;
-				if (r->fd > 0)
-					close(r->fd);
+				r->fd = -1;
 			}
 			if (r->addr != NULL) {
 				munmap(r->addr, r->region_size);
@@ -1611,8 +1611,7 @@ memif_connect(struct rte_eth_dev *dev)
 				}
 			}
 			if (i > 0 && (pmd->flags & ETH_MEMIF_FLAG_ZERO_COPY)) {
-				/* close memseg file */
-				close(mr->fd);
+				/* memseg fd is owned by EAL, do not close */
 				mr->fd = -1;
 			}
 		}
-- 
2.43.7

