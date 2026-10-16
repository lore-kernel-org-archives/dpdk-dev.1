Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984D7CCF2C4
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 19:59:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B50C40BA0;
	Fri, 16 Oct 2026 21:59:14 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011047.outbound.protection.outlook.com
 [40.107.130.47])
 by mails.dpdk.org (Postfix) with ESMTP id D502640682;
 Fri, 16 Oct 2026 21:59:06 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V2Bf/IduU2EoCW9yxCG0fp1JCp+3s9NocojWIGylMnv13OH/qwVWYXpp6vzgq9T4+Z6gZwAjKBVS3b6hY0fXUBW/vGhZAzeNIEPvun3Fg/ZtxWhOf/mw8ZEMew4j9/sGXbIOjcNe5lzAE2AFbQAKFoUwEs3tARTYmtzIrv1N+HokH/MOrJs0ELBQXZxjooMYsBFTC/FRU7EQOwu1jK3FzNPRrGQVUxPoane3pglkD6BfzIwkqdu4CDSvXMwLSWHoQL+LKO0A3sCEnOdNgE2YT9LRVNHWA1kPtMN4ri62h2YnzaDEZ6IwgkhJaZlkNSqvsRMsh3bx3zNRsQUXfoSi2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydQr+XQIYgDks7hDJ/nCkqpFdZuF/za3jLb2j7fF2TM=;
 b=ur/TaoDYZyUbaM/ME3PgzjhUxR9B/3/ofMy/U0H4Y5RqFAczEs/pcWdy5kE9Ab5UHFdVuVrMYBJPKzWF/i23x+eRvc535PNHGKQxzunj07DcBVHvmzaPUjVmaVcEkPsXgyVByMWgb+Bq9BfUw7IfHF3lvcAVHFzOnFnCzaoZScnIXK9et3a+bqKjDR44/CgeD0wB+TwkhOZCXeCUI2gc18ukkHBxgL3nU7udwfkFbnD7jRvj7j16W++eGhPwPORdBIjYQrBIe7qJ+Ub3T8wnDi6st6plVhgc2Np1tYiHQhgWrQVKJXAcWlrFx9wldQty1+U5k3XNWn+gSVxC5aIxNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=cisco.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydQr+XQIYgDks7hDJ/nCkqpFdZuF/za3jLb2j7fF2TM=;
 b=EWpoirfuXAMHhY2unSINLxeuF70Jrte4VEn78FKiqTova3/CYUcP/7mhykgNf0XBXEtbSX8K1/dQmk9BZc4Q6+2bsGuC5B4orzo3cMBpztpYi1E9ATTwMB52Kahz79zmnT0m506rOYspeId493axtGvfF8VGP5+pJMzsyu/VstP2L8FOuF0cTMm6o7uDnoKHMWTkwR2EHFzLsWZE1bfx3Ac6lLtMLrYhiqg45FyXTqFauQa8EDgCUXmLS77Y13bJnN9SbHVyqdoxV6nejB+MTwG2kubNSog+TfKgf1pSmAnci+ToaRTDowEfxI6VMpWLCrj3iEq6/nBUboICbiIq9g==
Received: from AS4P189CA0044.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5dd::13)
 by DB9PR07MB7130.eurprd07.prod.outlook.com (2603:10a6:10:21c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Fri, 16 Oct
 2026 19:59:03 +0000
Received: from AMS1EPF0000009C.eurprd02.prod.outlook.com
 (2603:10a6:20b:5dd:cafe::95) by AS4P189CA0044.outlook.office365.com
 (2603:10a6:20b:5dd::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 16
 Oct 2026 19:59:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AMS1EPF0000009C.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 19:59:03 +0000
Received: from seliius19697.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 16 Oct 2026 21:58:59 +0200
Received: from seliiuvd10563.seli.gic.ericsson.se
 (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
 by seliius19697.seli.gic.ericsson.se (Postfix) with ESMTP id 90E644020A9E;
 Fri, 16 Oct 2026 21:58:58 +0200 (CEST)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
 id C8CD2628589D; Fri, 16 Oct 2026 21:58:57 +0200 (CEST)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: <dev@dpdk.org>
CC: Stephen Hemminger <stephen@networkplumber.org>, Jakub Grajciar
 <jgrajcia@cisco.com>, <stable@dpdk.org>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>
Subject: [PATCH v4 5/9] net/memif: unwind partial device on create failure
Date: Fri, 16 Oct 2026 21:58:53 +0200
Message-ID: <20261016195857.3258796-6-sriram.yagnaraman@ericsson.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261016195857.3258796-1-sriram.yagnaraman@ericsson.com>
References: <20261016195857.3258796-1-sriram.yagnaraman@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000009C:EE_|DB9PR07MB7130:EE_
X-MS-Office365-Filtering-Correlation-Id: 467e9c07-54a9-4f41-8fed-08df2bbfeda7
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|23010399003|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: LXA9n69nsmMwMdaFuj7GtTFssaNjfA3DqzssQAFSxi8B41r953EnhnVxYUKIwlhaPRuQLeAKTfoQzDmtj+X5i52Es72Ug3pcMZ+QSZtQibazHfjr6pFs5cOWoWC4xONEcFSs/FimJ6oGtBpdKJ3iuUdqBUmj/HW+S0gKIjCKmz2cisJMWoKFUTFxgRFenBBRabCaE2/+thktFGW8JxOZqduWUgl88T8z+ZD+uiG6JuItUdbWz6NjQ17eHerrdtvL/NxgN3qjM7JWzLmGeSP1NqMOMqDMIWW/d2s2zhr9ABnjh7gpawdQgnOCfLH0AJ8uBm3yszC58rmSEVNwtejnEhuxxIYxGExc67LyEfzbbXIkFremZcQhb+FL/o5+kbgkFepNDj8kGGVyl7wfl2xEbh2L/6xvCFSHCKKdmd0Jl9o4JcHdJKRLch0hzGJ2Px9yQ5bMdLxxGuaJBqhMc821n8wft89kpp4I9ynUodvd9EGoSYncBlkqJPDk+2VKUi78AxoEF83JHvgbA3f6kEJnZrpxSztCd1r/bppxgDIzH9D+AQ4r8lq5zGXocSpVtFjh9OleiLxIS2Gpci5puFJ9qlPxHQ2FtXYwLBoA0/l30Px57bRlNw1f57ba3DoRczfJi9jliYiqGJ2xmanpOtjJoj24cWdqO/6VYHE0bo2h88rZnxN3Xbt7qejU67wQB/CxMQI5hOwHdsfCtN3F4cfqpA==
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(23010399003)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: w3ujMTIkZAERU/Yso/54FwiG0zAiAp9jOFZQiBHeBq8XA9fZMjMnRxfhNfxeCsb078qsuVMpCqfLLkz4yw6zlL9ai+3oy1BgxzQ5lztcFkF7Ggfco8Fks6yN7xpEu1ayrew2OAv1bMgTNilq04g1LeC/CYbE+unms3/okqU1DssIBQSaErpNa4qe8a8qt/W6fETRnea4bOFPkvKKmAF1VL3T0AyUjud+S0f/1BF2YShSHWzHtTUhJ/DBVnZ31qmswDHycUxsYmCbhHh0SrexZDIlMhbCqE52iAECrDcrOWYhr44h7AZctFr7ckKHNiCgZgSmSMhHvxBGWdxVI74wanN+5N1pnkBI/Q3VewiTbz70J3IfO1j7HVyM+Bu50ryq2d1G2AJtgZreJ4bk2esiOigXkpZby89hetFsKSPRxmN+61guLnt5GhDFlv/gKSXk
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 19:59:03.5045 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 467e9c07-54a9-4f41-8fed-08df2bbfeda7
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF0000009C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7130
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
index 70359554e6..e70443976d 100644
--- a/drivers/net/memif/rte_eth_memif.c
+++ b/drivers/net/memif/rte_eth_memif.c
@@ -1957,18 +1957,18 @@ memif_create(struct rte_vdev_device *vdev, enum memif_role_t role,
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
@@ -1988,7 +1988,7 @@ memif_create(struct rte_vdev_device *vdev, enum memif_role_t role,
 
 	ret = memif_socket_init(eth_dev, socket_filename);
 	if (ret < 0)
-		return ret;
+		goto error;
 
 	memset(pmd->secret, 0, sizeof(char) * ETH_MEMIF_SECRET_SIZE);
 	if (secret != NULL)
@@ -2023,6 +2023,13 @@ memif_create(struct rte_vdev_device *vdev, enum memif_role_t role,
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

