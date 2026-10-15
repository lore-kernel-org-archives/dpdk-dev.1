Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D9ACC6B34
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 14:40:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE95940B8D;
	Thu, 15 Oct 2026 16:39:52 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013028.outbound.protection.outlook.com
 [52.101.83.28]) by mails.dpdk.org (Postfix) with ESMTP id E43494027C;
 Thu, 15 Oct 2026 16:39:49 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YMXOyCG8v5BNfDOVV7/g9iJjIpnp4jiblIYvGaQaFrEASnOpHXxl6vHdPpkiR6kCQKuIAbr++NCKxq8ztnYoTrmfIrkbCYgYNxivKyFb+cQwFy1VzGvo1zaXo53enVyqR/aMm5ZkU1kp2be7GxdIx7EAy8xn9xd939IUPoQpz5AUDfHHWn0YvW3Cdc8rcsb5sPRod+p2jcGIfS6T/W9RYxa8fmwfvNBl30CB2zgFzXYIslI9qwxcjph/VUeWDtmOjQLYxy7X/8y00Uum6NW9iB7/c6TOZyBDwRft4K8rDmngDrT8QGOabb/XmW4Tmik3+hTw+9k76X1m3NIo0BToNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGQRGSAjkNsteNG+n+GdRmRsYHErM1Sxjf5vu4JxxdA=;
 b=ngbHrwIlwXvuSRNjiY7PTs1ae4DTMjdKM/W9NNFokDXCesCNa8BUwC5vE7Dobt/wqWtGvoreBDx0wBF0zRj1apqoNYx9DAJFfMZ6qiQNQAE9PlMDduVteJPgrIFNOAU2qzqulgw9qiHdIkfXMZx0alsBIh27JL+Ls8/TE06o/KpUbprOvROkIyK0a34O8g1EEBLyzJiGy2QcnRXLEvX5utLzbqUs6ryGXRmbxOxr1jbh7D4vgQfntg0yMApF3X5cZ+BskCE0BUyNVM1Jm+aRCEtucO+4Apx9DOpzNYCMwiIY+A4qU/ssj2VO6aJT9jZI3yJO+4BUtO8JZVjEjpGQXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=cisco.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGQRGSAjkNsteNG+n+GdRmRsYHErM1Sxjf5vu4JxxdA=;
 b=mBtXUUmFl9dpVeQi2NmTImqnXBcsdHYNg6ynAoo6d7uf+c901nl9ynSfs59N4PXnCl/xdqKc3bQV60XPqVUKGfeGZX9EGccQJ/msSGYKw3TLMgITsGSpauz4Z65H3xzR6dyTne6SlE82ouXtOD0TqaGLVMpxxMcOjhfkLnYD8EZapnVJtSQlnbhTeTwiiQbBTYR9xYuLUtHgr7we9VbgH9a1pSPAIGQHxYwvvYUTKkG5zHCft9u0pdNhO0dp7lvFvEZOIus+WzL/DBAj5sZpA9iXgCCqBmyto1zjS+7zGzvJ51iygQsAPl2do6DaJPT2OK0QgnCMKishAZfwi6ZXwQ==
Received: from PR1P264CA0130.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2ce::15)
 by BR0PR07MB744632.eurprd07.prod.outlook.com (2603:10a6:2c8:2c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 14:39:47 +0000
Received: from ZR1PEPF0000E6BA.eurprd07.prod.outlook.com
 (2603:10a6:102:2ce:cafe::76) by PR1P264CA0130.outlook.office365.com
 (2603:10a6:102:2ce::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Thu, 15
 Oct 2026 14:39:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 ZR1PEPF0000E6BA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 14:39:47 +0000
Received: from seliius19819.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 15 Oct 2026 16:39:46 +0200
Received: from seliiuvd10563.seli.gic.ericsson.se
 (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
 by seliius19819.seli.gic.ericsson.se (Postfix) with ESMTP id 914FD4020B75;
 Thu, 15 Oct 2026 16:39:45 +0200 (CEST)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
 id 5329E60B034E; Thu, 15 Oct 2026 16:39:45 +0200 (CEST)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: <dev@dpdk.org>
CC: Stephen Hemminger <stephen@networkplumber.org>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>, Jakub Grajciar <jgrajcia@cisco.com>,
 <stable@dpdk.org>
Subject: [PATCH v2 4/8] net/memif: fix MAC address leak on probe failure
Date: Thu, 15 Oct 2026 16:39:41 +0200
Message-ID: <20261015143945.2150772-5-sriram.yagnaraman@ericsson.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261015143945.2150772-1-sriram.yagnaraman@ericsson.com>
References: <20261015143945.2150772-1-sriram.yagnaraman@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1PEPF0000E6BA:EE_|BR0PR07MB744632:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fc9f641-fc4e-4428-6e39-08df2aca2955
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|22082099003|18002099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: BG8IzSyuwyG2rUQdoSZ3wBpTVlCE9nlJOyI/SGzcGqzm6KEo/XI3ALuOgXiaCvWHJEuiACq816p6Au0a1cuiYfoo37c1Uw6tqjz9ZPW7wF6XOjRjRgGjBvGw8LCM/eA6QR4ib6YnOZ3ENOsmEpsi1eXfSGEosMGV4H1WXoXj5MXSaHZv0/dJEL6eblSP0rVZuEZvqw/uizmNLy97jkotycU+oZ7Iz0lXK8tmy7FM9yZYFyXIx+YeOIssKbjBNS4j65zJFW5OUQ1QnqT/ewB+/T/dMheYP45xwfV/nY37nKBzSMDvogfjT2Ys6V+rB3fxpMdFbovso3IOWtRlXAIn1V2nbt1uHVlvhzZrmdQPvM7Pd61vO5vR4DM3Nw3gm4PrKvYSS6tC3XPuPT1kSBDWW0duswU1TvpeGuc8+lYAgpYUgWNOO0b07mQVW3wiigta/cu3GcY13Z55Q+7jMRyzUms8XLP+w87HpH3YAYxYLPOnYIUI7CtPKdAfA2Zkot/FS85K1U65q1JzlxXIJxqrpnK0Mw+IgTggnL+U53GB5VnTFb4bczc5qJPmRYA1312AwGbDce7Zr6EoJeGJFsInAsPTBKae9pato/usbldGpIKCPU1Fbs7JFRW30iALKZapwzrhMQB3uXkkWEEOgNbmExynFmrStymdhtBTQuNulaiSzoC4z+7th+vPAzN7I2mPtHH8RE5VP2JbAne9H0smjg==
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(22082099003)(18002099003)(10067099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 67ODTv0N0QCZCeskprb4O8NRDLC5jzZqIkffqUTAyfXZQVWO4xx6D8D+hzci9UwtqcSQwgr0kZfl/4/21hxDXqNsdiPNFrAsdoJcgyx+mKAfZW04cK2Vmj6v1A6RO00pVibQWd1uFC7puZnaowsqWirffMeGG5ZzkKLCy5DB+ndt/aSqRGlCZadNxPUgGtr+4epk6Aq6uzVmhkuAra/Q7BikA1tVYDm9ylClqWYE3XRxfrdx10G5PvUrl0xOwN3tLcoAsUoeDa1T8YtGM++jQntJH+tFGdUyzVQw04VgT3s+6iJ6zjWF3nsVJceae8I1G4Ix4x9OHh1EPHnG3nYf3WAmHbpaa9fLGSKyXqWpJs9sn9o2eJtemh0R/dDyMCJlpGMMNPBgUjI4ImvlsEc84UGGFyCF5BSmk04xVtrZHBWLs9JjI6oqp+Odr8dhz+Hf
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 14:39:47.4406 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fc9f641-fc4e-4428-6e39-08df2aca2955
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: ZR1PEPF0000E6BA.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR07MB744632
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

rte_pmd_memif_probe() allocates the default MAC address up front and
only hands ownership to the device in memif_create() on success. Every
argument-parsing error jumps to the exit label, which freed the kvargs
but not the MAC address, leaking it. The allocation was also dereferenced
by rte_eth_random_addr() with no check that rte_zmalloc() succeeded, and
was done even in the secondary process which never uses it.

Allocate the MAC address only in the primary process after the secondary
path has returned, check it for NULL, and free it at the exit label on
any failure (on success memif_create() owns it via data->mac_addrs).
While here, return -ENOMEM instead of -1 on the secondary-process
process-private allocation failure, matching the primary path.

Fixes: 09c7e63a71f9 ("net/memif: introduce memory interface PMD")
Cc: stable@dpdk.org

Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
---
 drivers/net/memif/rte_eth_memif.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/memif/rte_eth_memif.c b/drivers/net/memif/rte_eth_memif.c
index fb82117d9a..6a82c597de 100644
--- a/drivers/net/memif/rte_eth_memif.c
+++ b/drivers/net/memif/rte_eth_memif.c
@@ -2238,12 +2238,9 @@ rte_pmd_memif_probe(struct rte_vdev_device *vdev)
 	gid_t owner_gid = -1;
 	uint32_t flags = 0;
 	const char *secret = NULL;
-	struct rte_ether_addr *ether_addr = rte_zmalloc("",
-		sizeof(struct rte_ether_addr), 0);
+	struct rte_ether_addr *ether_addr = NULL;
 	struct rte_eth_dev *eth_dev;
 
-	rte_eth_random_addr(ether_addr->addr_bytes);
-
 	MIF_LOG(INFO, "Initialize MEMIF: %s.", name);
 
 	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
@@ -2270,7 +2267,7 @@ rte_pmd_memif_probe(struct rte_vdev_device *vdev)
 		if (eth_dev->process_private == NULL) {
 			MIF_LOG(ERR,
 				"Failed to alloc memory for process private");
-			return -1;
+			return -ENOMEM;
 		}
 
 		rte_eth_dev_probing_finish(eth_dev);
@@ -2278,6 +2275,13 @@ rte_pmd_memif_probe(struct rte_vdev_device *vdev)
 		return 0;
 	}
 
+	ether_addr = rte_zmalloc("", sizeof(struct rte_ether_addr), 0);
+	if (ether_addr == NULL) {
+		MIF_LOG(ERR, "Failed to alloc MAC address");
+		return -ENOMEM;
+	}
+	rte_eth_random_addr(ether_addr->addr_bytes);
+
 	ret = rte_mp_action_register(MEMIF_MP_SEND_REGION, memif_mp_send_region);
 	/*
 	 * Primary process can continue probing, but secondary process won't
@@ -2352,6 +2356,12 @@ rte_pmd_memif_probe(struct rte_vdev_device *vdev)
 			   log2_ring_size, pkt_buffer_size, secret, ether_addr);
 
 exit:
+	/*
+	 * On success memif_create() takes ownership of ether_addr
+	 * (data->mac_addrs); free it on any failure or early exit.
+	 */
+	if (ret != 0)
+		rte_free(ether_addr);
 	rte_kvargs_free(kvlist);
 	return ret;
 }
-- 
2.43.7

