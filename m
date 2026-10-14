Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C058BCC6B27
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 09:13:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED71D4069F;
	Wed, 14 Oct 2026 11:13:08 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012045.outbound.protection.outlook.com [52.101.66.45])
 by mails.dpdk.org (Postfix) with ESMTP id 13C3C4042F;
 Wed, 14 Oct 2026 11:13:05 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OG2Dmn0RSk8lMKZcK0VGsuMGP678ejKso7oeLFxYrUXiV0nNHdwRNk8UjXngurPGYht6HdgtMc3UrnFAb454IGyjTupSIWFym47EekCBVt7aTzd4iwXNPN6NiWkUIIny18XStmnxIB8o4k1fRwVx1rXpvSfECo6x1OdViFriF1bjB0Ly/FYASCqUASb5rW1LU0ttRk/u6PBL6wOnRsFj1ezrJqM0Hc/9ugVzc1v5RgqD4t0FBmXBjExYms/hHX4u/quwcX22GwIJR3EBROa0KsBfkSpKpNr+/w+f/wGNi6bBw5GySaPZEuvccVWmbPvKJp3G6EJ3Zklhfk7uBNig8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1JXtKWTSvF2czEs614izF5+DCfkHpGKEO/C1ucKnGk=;
 b=BV/dKO458W5gclbkZaZz3RB45uLin5zGq9vdHc1TaA7fbcJTjeUyShkECNKMYBNRsfZxSGin9OVoJecUsf/tYnlCQ31eNHfs3OMUCqVBgEAVKqzJ5RxiB6bBEPRUWQ6lBEcEbTWQDTWe/N4YW02rrW6y29vp0OxaNs3FgcIbL/8Z2pviyX5LYVw2OFznsTm6kQtoXzPJEBQfu2XpgR9txBjvEm8xm2O3Js5TlH8tBaUF/lL8wkxQo3xBFoS+miGr/f7JFTgwOH10RjESqcGZNAsRMgSNZ7HtsVuMsipEVbJnwuFrCnauOayJNH8M8L/p+K89oB4DZnaQqdzt49vfrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=cisco.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1JXtKWTSvF2czEs614izF5+DCfkHpGKEO/C1ucKnGk=;
 b=Myr4DRv95akEFEUA/hXwm9mFRrqU8RpUbCdydZrT2LrotOhmOdMzVyfEQ3Jhu034nyIxE2H4lv2ODQ9IGCXM+6UmWL1naHQftjWUo6ByUPdossIcVKLp+DPUMwuldrcZZprgCMNmAGhan8/DxlZWrg+qui8WIsd4u2LMfXn/USsyph4EkBhrU1tPQB/dBnm02i6wkxh6W3nMNj93hQpmJ6f/FDz/NFBk1xyeiHYl+zIjuvJ8U61E/bx9+dKs+Qv9/+1H55kxkV8VfW7+u4AR4tdVh0gleE5QvNAFnWtRSw3OjxguaaaKW5L4FCg7iyvRuQm7aU3PUh3OmjNEI6vjHA==
Received: from AM0PR02CA0192.eurprd02.prod.outlook.com (2603:10a6:20b:28e::29)
 by AMBPR07MB12024.eurprd07.prod.outlook.com (2603:10a6:20b:768::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 09:13:02 +0000
Received: from AM2PEPF00070CF4.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e:cafe::2f) by AM0PR02CA0192.outlook.office365.com
 (2603:10a6:20b:28e::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 14
 Oct 2026 09:13:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AM2PEPF00070CF4.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 09:13:02 +0000
Received: from seliius19819.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 14 Oct 2026 11:12:59 +0200
Received: from seliiuvd10563.seli.gic.ericsson.se
 (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
 by seliius19819.seli.gic.ericsson.se (Postfix) with ESMTP id E47A04020B75;
 Wed, 14 Oct 2026 11:12:57 +0200 (CEST)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
 id B62BC617B8BC; Wed, 14 Oct 2026 11:12:57 +0200 (CEST)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: <dev@dpdk.org>
CC: Stephen Hemminger <stephen@networkplumber.org>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>, Jakub Grajciar <jgrajcia@cisco.com>,
 <stable@dpdk.org>
Subject: [PATCH 4/6] net/memif: unwind partial device on create failure
Date: Wed, 14 Oct 2026 11:12:55 +0200
Message-ID: <20261014091257.1051190-5-sriram.yagnaraman@ericsson.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261014091257.1051190-1-sriram.yagnaraman@ericsson.com>
References: <20261014091257.1051190-1-sriram.yagnaraman@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF00070CF4:EE_|AMBPR07MB12024:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ab68b9a-8220-405a-3a36-08df29d35952
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|18002099003|22082099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: sgNkLDgiSS/Mo2ZDxs2BH5ZIyw8skKdT1YOauGZAx0EZcC+BFrzTgofwE+thG3u7ncS2nN7MSjqmoFrAVn0pvO+4+OGhlIpEsux17wrpZifKE21nYSwktZTOMgnrH1DgPg1aTtM8E/KhBeNoVaW712ZpCW9m2B+lGL2RZvUZ9pGrPApy22Uog5adX+BeA12WTLtsBTwnacWFoVMSH54hPN8pl2jc9mRV8Rt5g0ZsZPYd8l2nu1cn52akB9l0mX2VXVlKHq6uR/go0eW1XgIX4ijs03JSMFSiV2fPlJWd1m7OHXX52QVZKDtEhqtTp7eK2iQFUz+0LqbykJxsZzqpZ4Ul4uli2D78x09EtHxyWrUXYTg4ldE0kBNiZ5rbFh2snWs93Tbj+yKd9IPNY1JWhn95xvh9/FoJDVjc18tchw5Z82/NBSmX5k11ZJxcvj+uTkj7zQe7euCpWOEnmvGrul6+/3vwFGGyM8tbxGBEc+nPpx7+zdeVvVpt5w7TR2pzX+Z+sO3v3UOm1sGDTV1eP5mG/iGkGMIra9rv0S9/lUFQbZjil/JAJ44ayTrZqYHI7w/OmSehlc5BkmBiwg0zApwcYxWYQmU5LyjMdk1q/oY43ktoY99oYPusbo0yFoIQIRvfFoLGmhUS/AK2/xqAM8+/uqJeVKFsngEEf0RG5gGgXk2ySDNlj1XRnAe7d5izKg/wb+rbsiXgxqgMwSlPyg==
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(18002099003)(22082099003)(10067099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Df1Vb2Dmyo/HJycQTeao0QCj4w5KYQ7cit2w2QyG+uGltRdCl39rOqjC6llHSZi8TZgUjBY9jhPpj+pDxH/RqLJezaU40qIaG1Cr6ZUuNYr2UTRD013mG6kfnolExfCXMFXWqUCzu/LprNOqkJ8CxaDa2WCuc9lc1MYeCf41vZzxNHeFeXaNP1hdPQ1n8ACZLLXUTf1gbNVQHXkqzJBUMKWgGHereKmXqUsiQBe7MltUgx2rnUl+PyMPzLaNm9SMFZy5JMRpn/nlN2Iw6rt/SFl0tLdRVKz5Z68CgWsfrnuaFclmLbAMzKxRJbNLtBasXiX2qS988McqJYVJLuJjhzr9CAdnsQW0Us4oQuwq2TxMIpAG3E7m46nUGojWCjeQMeYW1HUF9oJI+xZqRsuh/Df4xXnKVLr9Bn4xVcMYVSL/E/WcyU3u2wpGmt9DW0Ca
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 09:13:02.2679 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab68b9a-8220-405a-3a36-08df29d35952
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF00070CF4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR07MB12024
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

memif_create() returned -1 directly when the process-private allocation
or memif_socket_init() failed, leaving the port allocated by
rte_eth_vdev_allocate() registered and the process-private memory
leaked. Jump to an error label that frees the process-private data and
releases the port instead.

Fixes: 09c7e63a71f9 ("net/memif: introduce memory interface PMD")
Cc: stable@dpdk.org

Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
---
 drivers/net/memif/rte_eth_memif.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/net/memif/rte_eth_memif.c b/drivers/net/memif/rte_eth_memif.c
index e8950166b2..d805509391 100644
--- a/drivers/net/memif/rte_eth_memif.c
+++ b/drivers/net/memif/rte_eth_memif.c
@@ -1964,18 +1964,18 @@ memif_create(struct rte_vdev_device *vdev, enum memif_role_t role,
 	const unsigned int numa_node = vdev->device.numa_node;
 	const char *name = rte_vdev_device_name(vdev);
 
+	/* Allocate process-private data before reserving the port. */
+	process_private = rte_zmalloc(name, sizeof(struct pmd_process_private),
+				      RTE_CACHE_LINE_SIZE);
+	if (process_private == NULL) {
+		MIF_LOG(ERR, "Failed to alloc memory for process private");
+		return -ENOMEM;
+	}
+
 	eth_dev = rte_eth_vdev_allocate(vdev, sizeof(*pmd));
 	if (eth_dev == NULL) {
 		MIF_LOG(ERR, "%s: Unable to allocate device struct.", name);
-		return -1;
-	}
-
-	process_private = (struct pmd_process_private *)
-		rte_zmalloc(name, sizeof(struct pmd_process_private),
-			    RTE_CACHE_LINE_SIZE);
-
-	if (process_private == NULL) {
-		MIF_LOG(ERR, "Failed to alloc memory for process private");
+		rte_free(process_private);
 		return -1;
 	}
 	eth_dev->process_private = process_private;
@@ -1995,7 +1995,7 @@ memif_create(struct rte_vdev_device *vdev, enum memif_role_t role,
 
 	ret = memif_socket_init(eth_dev, socket_filename);
 	if (ret < 0)
-		return ret;
+		goto error;
 
 	memset(pmd->secret, 0, sizeof(char) * ETH_MEMIF_SECRET_SIZE);
 	if (secret != NULL)
@@ -2030,6 +2030,13 @@ memif_create(struct rte_vdev_device *vdev, enum memif_role_t role,
 	rte_eth_dev_probing_finish(eth_dev);
 
 	return 0;
+
+error:
+	/* rte_eth_dev_release_port() does not free process_private. */
+	rte_free(eth_dev->process_private);
+	eth_dev->process_private = NULL;
+	rte_eth_dev_release_port(eth_dev);
+	return ret;
 }
 
 static int
-- 
2.43.7

