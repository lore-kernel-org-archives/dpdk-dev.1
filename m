Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9C0CC6B34
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 14:40:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C71E40DD6;
	Thu, 15 Oct 2026 16:40:02 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011066.outbound.protection.outlook.com
 [40.107.130.66])
 by mails.dpdk.org (Postfix) with ESMTP id F2EAC40DCD;
 Thu, 15 Oct 2026 16:39:58 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2SrtXYmUEKw44NtOMysq+p0uorU/XuZObfB3jJByJm7gW9fG3A0/Sb9WkuMKAqITCUco4Jv0nE7U9EoxGMKttS+4O0Y0XDyCxGcnNV7FriVKwXUEJ4JFgcP5hjAfSEl6lU5CNx/k2rz3uqoJ0XjmJ6U2KJf4RilbpGIucHMfLi+tJsTl6bzXyi37XD8f90tsYECjcqvAyaEVtAXVjOan3PxJ0qNFHLiVAxiDAwg8rlDJCbmNLPM7Pw9v5JnNupapV0NgaE1JsN/+LmdcXgtiY36VKlPLWoBDjBM2Jq0cuJ2CKpr8y29V97rmD8rrqqAaHVQYZvwnbXpzSb/F2zKtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yB/hq53uGxDXQ3F+6l1H3C/qh+NEz4M0Cymf8s8uPzY=;
 b=Acmx4KTBYRiXsbiBS1R7/coYlzsfB45Atzc+IX7L6QRe99X0XjoSZnDzUvd1+5WnPef1wZBHjtZANU7R2WkgbtNXNPdA8lIleiocADOvI4Vl/XdVNN4djwLa0JPkzoprYNFuqW0auxTNAxPXBD+CrAnqbtxjSM9Wk3VxK77sMOLXMe3FjCJMr7pgq8MYWoT3wR+Fi/1nWFFdX6OTkq8gniK4/2UDkXkPxYRy3+7CHRM+eZCLO05Fa/gtLnqL+ocHvHOx+TF6golJ1uPyzzUucyfnywzEOYeXTu2mso3SZQ8WFGU5zkhvRyyyzolNyMqYcAMFndi9qgLIb5SFTBrp5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=cisco.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yB/hq53uGxDXQ3F+6l1H3C/qh+NEz4M0Cymf8s8uPzY=;
 b=YIj0VOm0bt1Y4fcPEVzgMCfMYRawUHtWGHmuHYMOkwO/WLktr73Fgr1M8i+sELFd1w+O+w8lxpOgfOclUsQa/L2hrwHBt0tBeiOjHBdE6AYYFp2YYioRpMeceTzXCLKVc7pp/bWrxoc4Mw5vmZPN/Lbpx3l2cgGqW6QD6TPcg7nPyWURVrYfFHU3vs+M6jhZn9Cd8fxS1I6rQarhCQ0A3NLfePjGJJwmWdf/qS0wov5fzxUg+pP9PqwIm6VctgJwvFu22ZrKeH3heniMPIkYZ6nd8cgTlYpvQDYF4SW9y9IPVPdIbHy6W5BiLuvxYa/BOPSsKlsQ21e7sUpCSdAilw==
Received: from AS4P189CA0056.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:659::26)
 by DB8PR07MB6393.eurprd07.prod.outlook.com (2603:10a6:10:13f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 14:39:55 +0000
Received: from DB1PEPF000509F9.eurprd02.prod.outlook.com
 (2603:10a6:20b:659:cafe::91) by AS4P189CA0056.outlook.office365.com
 (2603:10a6:20b:659::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Thu,
 15 Oct 2026 14:39:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DB1PEPF000509F9.mail.protection.outlook.com (10.167.242.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 14:39:55 +0000
Received: from seliius19697.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 15 Oct 2026 16:39:47 +0200
Received: from seliiuvd10563.seli.gic.ericsson.se
 (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
 by seliius19697.seli.gic.ericsson.se (Postfix) with ESMTP id 241654020A86;
 Thu, 15 Oct 2026 16:39:46 +0200 (CEST)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
 id 5F9F860B034F; Thu, 15 Oct 2026 16:39:45 +0200 (CEST)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: <dev@dpdk.org>
CC: Stephen Hemminger <stephen@networkplumber.org>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>, Jakub Grajciar <jgrajcia@cisco.com>,
 <stable@dpdk.org>
Subject: [PATCH v2 5/8] net/memif: unwind partial device on create failure
Date: Thu, 15 Oct 2026 16:39:42 +0200
Message-ID: <20261015143945.2150772-6-sriram.yagnaraman@ericsson.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261015143945.2150772-1-sriram.yagnaraman@ericsson.com>
References: <20261015143945.2150772-1-sriram.yagnaraman@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F9:EE_|DB8PR07MB6393:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cddd649-9c6a-442a-ce84-08df2aca2e33
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|56012099006|11063799006|261009223027099003|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: 6eMvclPxt0fNL8UIvogqg1PtYBQYoUuhcst9+MpbFkl8PovdW3mebHIAWGULhEkoNb8uWlp+eYXErWn9gA4SscMtxk55EtUdcj+yqH539lnVTXreGkcQ54z1h2ddQ8s4SsWy8f+mXPn3DPhF5NbxSOlv/+0lkDH/IaCPQ3aw/W7GBUveGfklj+67/81ocDkb93BL8v8o+etPB7EjKeutxXek+KeeOHgnWI8u408XVzQ9vXDU/BFM1UWfXevNocEXBa4/Akv6QhoVMaIFs7tSPR9xb+0xFJjRrG+E8IxbMr8QLF1vJxAB2X/Cbz1SWAmevoVI0d6qo8/oBTHutorquGSiehik1IekGAOUp5TVsiHOQVYxE8456n9mj2OqXah6feXiCsITf2Bkc/SvKxy/ps5yqPPmE5JPuVD5ooxwuBYZ7KwnNPrdHJj5AUJ+s/4MJ4pUWn/PFqOtAqZTf518pZqI3nyxJbfYzdKcrTLtdVm7BdNMnP87XhZwQ9Tln1Xhj5dzaUJLFrnk7QkGPctTj8an7OcVZxicRq42b11KHEl+1VtekKFA6kUEj84rNKiPADjccDHCNb5C0FzFihmicaxzh41uMG+ockR91V5esadqjLceTy8dhX8hMbVSddKG97Rqu0E3p6hCAi0UQFoMARZIPNBnHzo7AaQd6tRO+KWXg1tiNUBIdq2AgFgAV0q5DnirI+XZiT7ksB/uwoLXhQ==
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(56012099006)(11063799006)(261009223027099003)(22082099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZD8I710UIyuRKnxbrX35TrCJlNeDLT02K3qiQ7SQ349bnhmuBYTt2aBOqo2fUwlwDrYVdiHQHVW7U8UJhv41JjK7PmCUvnbLNIX+NwWt2PAuCwnLL1Tr7/tGhp2bjjg31ZC5+rARwpGR0On2Hwqtv01ApP5RdpRPhVmCz+sW+YKz/HTWl6BDbTLR93SMaiP9njXqW3GI2u2+NE9dgXI6xKUQtZv2emc0BipczS3eDBns2GCjxA3wYHMeu1K1r1k3a9sb19kT3W6i8DBkwytrWmnSKMxB1cePOhG+Mu2PP+fEao6lLj/inwk4oi3a2ZcYXgIVK/SKhFSwjYPhQLqT65ahQMinGpI/2oRWJBr0Lfd8ur6/z0WerUAkylKcgEs3TkCfOSRprskDJCOKBU3HJsZw/XhWymVxvmxMGdSw+TwW+62hjBPkROKqfDH7530/
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 14:39:55.5965 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cddd649-9c6a-442a-ce84-08df2aca2e33
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F9.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR07MB6393
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
Fixes: c41a04958b09 ("net/memif: support multi-process")
Cc: stable@dpdk.org

Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
---
 drivers/net/memif/rte_eth_memif.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/net/memif/rte_eth_memif.c b/drivers/net/memif/rte_eth_memif.c
index 6a82c597de..fa9847de06 100644
--- a/drivers/net/memif/rte_eth_memif.c
+++ b/drivers/net/memif/rte_eth_memif.c
@@ -1963,18 +1963,18 @@ memif_create(struct rte_vdev_device *vdev, enum memif_role_t role,
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
@@ -1994,7 +1994,7 @@ memif_create(struct rte_vdev_device *vdev, enum memif_role_t role,
 
 	ret = memif_socket_init(eth_dev, socket_filename);
 	if (ret < 0)
-		return ret;
+		goto error;
 
 	memset(pmd->secret, 0, sizeof(char) * ETH_MEMIF_SECRET_SIZE);
 	if (secret != NULL)
@@ -2029,6 +2029,13 @@ memif_create(struct rte_vdev_device *vdev, enum memif_role_t role,
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

