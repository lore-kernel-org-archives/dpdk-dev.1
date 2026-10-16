Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0795CCA46C
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 14:16:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44B6140B95;
	Fri, 16 Oct 2026 16:16:11 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013053.outbound.protection.outlook.com
 [40.107.162.53])
 by mails.dpdk.org (Postfix) with ESMTP id 662D9402DA;
 Fri, 16 Oct 2026 16:16:05 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dpTEGIqKg3Y/TKEDSQImJedY2HM+FobM87PGCc8/1tZL30/lG7YTAZVYXypUaY0f6QpWAhGWY412YZawoDu3wwTnwR/vIoiOeN1kNWy3wbVIQvscqOK5bGrBW0wKzPDn/qGzYWWCuYigM171hd5Imzny+lhNyyuferWtoHp6QYySoREyJFGqS1UT0Y36zBLOy4roq3xlHfVSTdStjJjFrZjyPHHndBpX70fvTkU1jhRyLkr5u9wLKLaiSqC3oZZWSlpRVJib5hkqUQSsdIFAkZolhrGIpGHtR4zkcSY6VE9AEAjfKR2vT63T42FryppYW4KGxUK+bBgLpDrvMCA3nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydQr+XQIYgDks7hDJ/nCkqpFdZuF/za3jLb2j7fF2TM=;
 b=sFpZludMmilne5Mogbfmgz+5/jKs876YWG1XVJnyjHFkqfk5o+k4c2LqS95s5tAyqOfKKT/w/u5vg9TD4f+YASUjHGZEVhwQ6sTBl/htNE+TxknFprL2OOi1cl8qZpX2KF7TQ0Z6v/RwnL529C3O9j+zB/nZ18L86rR03aXfK9vo8MYv9h9jcuyFGsN1w3Zp+iYSG8brPiWIFxJCHEurHwfcGoLZ7XHNAb1xDIsQTXv6zm3P8Upw9FM8mzU+UkeIjkUdrJzLCCZ3IWK1H8yNv6j7BH1V7yK3DRWu6C538yzUQoIxDUV+ydItAH5HuqHnPRR3isW6NMfhnOPUyL7sLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=cisco.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydQr+XQIYgDks7hDJ/nCkqpFdZuF/za3jLb2j7fF2TM=;
 b=gDUQb1ZT4EsSMaKUeHutMTjqN8ODPyNHVhXP+S72R9iKZcWCDCkLWZBAxwZSTTPphjJq6pa67imlXVRCdpVjYlPEszQkuBvHeHXmrS7ayPreWCZ01uypjd+WHbR/39B4rx71UCpjptoKOAoLG1mjUo5nq/xdpVD8WVkkNZuFmmBHboxwzsFme8v75x+Rk1H/TcuPqu5Yv1odhbUgdRPF62sVUjj3B2vwvf5ZcTfhOKwta1bh5OKR44RK3yuTE11c1+kqT9W7ZX1rX4RmhpBceflomwRFcqDtSdAn3Ztpqnyk2blpgZtpbZMI7nmWo+DjQEDJ7CS0NfvnYREbi5uXsA==
Received: from DUZPR01CA0223.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::10) by AMBPR07MB11926.eurprd07.prod.outlook.com
 (2603:10a6:20b:767::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 14:16:03 +0000
Received: from MAD0EPF000008AB.eurprd04.prod.outlook.com
 (2603:10a6:10:4b4:cafe::74) by DUZPR01CA0223.outlook.office365.com
 (2603:10a6:10:4b4::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.21 via Frontend Transport; Fri,
 16 Oct 2026 14:16:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 MAD0EPF000008AB.mail.protection.outlook.com (10.167.241.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 14:16:01 +0000
Received: from seliius19819.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 16 Oct 2026 16:15:59 +0200
Received: from seliiuvd10563.seli.gic.ericsson.se
 (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
 by seliius19819.seli.gic.ericsson.se (Postfix) with ESMTP id 4FA964020B7C;
 Fri, 16 Oct 2026 16:15:58 +0200 (CEST)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
 id 93912628589F; Fri, 16 Oct 2026 16:15:57 +0200 (CEST)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: <dev@dpdk.org>
CC: Stephen Hemminger <stephen@networkplumber.org>, Jakub Grajciar
 <jgrajcia@cisco.com>, <stable@dpdk.org>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>
Subject: [PATCH v3 5/9] net/memif: unwind partial device on create failure
Date: Fri, 16 Oct 2026 16:15:53 +0200
Message-ID: <20261016141557.3081522-6-sriram.yagnaraman@ericsson.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261016141557.3081522-1-sriram.yagnaraman@ericsson.com>
References: <20261016141557.3081522-1-sriram.yagnaraman@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008AB:EE_|AMBPR07MB11926:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d670006-6175-4212-1ec9-08df2b900213
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|56012099006|261009223027099003|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: zYlSHwbhN3yVAKTp17uDMNsdwFYAvSBVNSeh+MKBLTtaIm6uMJfElT2ZXI4Kh53eucTgGfEKpbt5Ng19nYxbsChMm4CemEMRSnQX8+LLplIKGc8ethcf6r3IWyw333AB4C/cfz8YDQWRCdxQPgOWdfXuUUnm4BWcMvCzG8NqAUwyFx1zdCrf9cimYCpP6VKpXo0lCerjYNm7afIy7NJExTu7gUyNMwE3zrKH2zlpPk3kRV3kbLUa28MV003Qcj74gJU4V8mffNpIYu4V1gY59uTE7GUntt58er4IXqfbV5sM3vGUZ1zHOy/c0Yu4TRZ8AsbZh4yMdouT5OcnktntDkqh5YtNs7BUsNyeuHioVp5VmEq7ld8TvxCcx1vd8GsdLpEi4xWyRYQq48xZGL02pRbTpGvtOeIaybu2ECyBKQ9URGJi/8Mj5KHP6JvIAB9hGrGPnMkoST2i8RavwzLB/mM7jAuV6cTRND9pwTHM5MafsQHiRV+rsgnAufuNGlry7VkUuUr/hWipalLtPni7b6LVjxcYnlbPC46FxYe0mAJCBi8s0OyUDi1ayjxtAXvXbD7dxt1fqujboxk4Xxr7ngRt1RX50PLeJ9jnjmoxe6AxqFdQzxjLH+x2/db42rConxgwxd0r9NvOeD9qUYW/NxvwCXhn93s2kahyv0YFypQrPCuo91AobUen7AmaqVSknCrnP5BjRB6TYYFYJp78+g==
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(56012099006)(261009223027099003)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DrCPPU887pvLPyEIVO2fU71Yz7Oy3pHUTRAcf6aO0JdQGuHksTv8hoQKtHViBFmR6CRH2Pz3CjzgCq7D3BL+fz+MmwSnDcooxAWxKW8pBdnswKtj3Uw5h8NQghnjVU6RVO+n0zzHhOw4ooS1iQccFzQ9vFc53AzogHXTy3Dc2V+otF5VLteOpP7nJdT677MfEUIL6xrNnpfgoEZylThdfAmgY2s7EI+GhB//joK/7zLBDvvwpEFiFgj7ARPClGxvsPJaFeMdOuv1GjZSQqEIAOjKng35MJY/20QIUE0mu+tnpOww4utQBHSr72DWW5RiczCIWFWcq6N0296V60/ZxAnr5dI1D8S/U1cNCUsUJ6/0beSjhtjnHuPEgUlaO23IiO+u8cj2etVDd8JDqHoWLiCKN4nRufFzjV5SRpPqJOEjV83/3hlApX10iyyw/WtG
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 14:16:01.8777 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d670006-6175-4212-1ec9-08df2b900213
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008AB.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR07MB11926
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

