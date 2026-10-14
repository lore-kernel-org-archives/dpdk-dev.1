Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF60FCC6B27
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 09:13:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C07740684;
	Wed, 14 Oct 2026 11:13:08 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011013.outbound.protection.outlook.com [52.101.70.13])
 by mails.dpdk.org (Postfix) with ESMTP id BA2ED4042F;
 Wed, 14 Oct 2026 11:13:04 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MJ6ioSNKUN26z9P7uBvyFKVGQb8i+XK649ymfhh3x6voxPEEuDGovkhCni/6rtppeCcYY1gGfINVW2ZNZjculZQ0Z9JNsg6YoM+HENFqrKAqNkzYGMRIc68yvBMAjXpJl36396mj80HQE5ZL97uTr4lQEfy+/XpE3p4YBuZ7gWLrOK0egBGqRN/xlmqYGHBvZ5gzKg2EM+YlWZRyNbpJBPKMMb9cSXShhr3fd1gdO6LMZZe6YDrRoGaxSs4Kq5wLD2sVQRb89ywGXT59Z55HE8OfN2Em5izWlIPcfk0iRhHzuhbJtO72fB5BlEzlJuY5nGWhQHKQ1GpGKga4urPJyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9fnuCDaNlA7NIu3vJgxi7M1eBYU0y8aZ6UNa18QibxU=;
 b=sepF8GnTUxK8AgTPzIirDP5Qn326TsZx5TcytjWw2GpDsR54jzYv4zmwbEeOjFlvu4bb3gya+loYn4DJ/uQUEiMxiNXBxWfnIwbRjzBOHr9dmor2QPJMnCiHCjofA00DKxXXINV5CinWIXmSCdOeapXqUYMRZdYNxlpGP6W0aYl7UJ3gEkQq7lrBwfXZNPWonRiMDBBGTxAlUfMmSEDAQI6zaI/lCfhXvq616aGV2+8Tj7KaWHXXRVYGgPZBj3SJNey/SnesHWRUq8tunqkVY+LBmVA35MClNUTHahFnHcrdPJzJC250+Hpt0yzHSL7zC87kb1aZ1mGBXC4S4cAu6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=cisco.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fnuCDaNlA7NIu3vJgxi7M1eBYU0y8aZ6UNa18QibxU=;
 b=ZbcEnwuncOz7oqtuxnOI2GHR87VWY6+vweW8gKXVrkk8E1gw8iSFL2sNTyYGBNeDGbOU3nMxerXSf9n2HT/PgYFLmUHpp97Xk3kdZVbN8uS78Nz93WX3zZwCKPjdW231rK+Jums+mLPasDtGX3MBwZmNWWxTheQVLKXb4oX86WiLPaF/JddFCwuKur4sSLffuGzf2mVyFlRG+o3NUFnErTrL574fBkAD4opG7YRQiKt2NK4WZ0cAnXhk+CZpr8gIpnSgKRQRQheKS24T8PscXsirM6fq4fGo7wOPEinrjcO/MwH4BLWr9zT8RztRycBkZ45zbJnUvJdoNopICsbwtg==
Received: from DUZPR01CA0057.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::6) by VI1PR0701MB7054.eurprd07.prod.outlook.com
 (2603:10a6:800:199::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 09:13:00 +0000
Received: from DB1PEPF000509F1.eurprd03.prod.outlook.com
 (2603:10a6:10:469:cafe::4b) by DUZPR01CA0057.outlook.office365.com
 (2603:10a6:10:469::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.21 via Frontend Transport; Wed,
 14 Oct 2026 09:13:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DB1PEPF000509F1.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 09:13:00 +0000
Received: from seliius19697.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 14 Oct 2026 11:12:59 +0200
Received: from seliiuvd10563.seli.gic.ericsson.se
 (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
 by seliius19697.seli.gic.ericsson.se (Postfix) with ESMTP id 70AC44020A86;
 Wed, 14 Oct 2026 11:12:58 +0200 (CEST)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
 id BC54A617B8BE; Wed, 14 Oct 2026 11:12:57 +0200 (CEST)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: <dev@dpdk.org>
CC: Stephen Hemminger <stephen@networkplumber.org>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>, Jakub Grajciar <jgrajcia@cisco.com>,
 <stable@dpdk.org>
Subject: [PATCH 5/6] net/memif: disconnect on device close
Date: Wed, 14 Oct 2026 11:12:56 +0200
Message-ID: <20261014091257.1051190-6-sriram.yagnaraman@ericsson.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261014091257.1051190-1-sriram.yagnaraman@ericsson.com>
References: <20261014091257.1051190-1-sriram.yagnaraman@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F1:EE_|VI1PR0701MB7054:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b7ef694-abe8-477a-0d74-08df29d35812
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|376014|82310400026|261009223027099003|260925022911599003|260925021911599003|260925021311599003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 6GuXNiOhj5lQNkShJsqIwcPUcFKL/NVPvqkQzkuJgdh8/hdlR9PqfkXc2VH9altNeNOBCTUa38dI3Or2Yj56CMMid+wWvjrDPscTCJkL1iHX7jo5BW5gvJOrrUEaQg/PvOhZrn4alm8RJdjtKHWAq4GZsW2BUjRatBWbkFkgZ2eGJOA+FM7tPj27BDcP//qQiIznLBrDWgeIhSLsxpXw1oSbanDyH37Bq5xGAWZoPAohOecTiS07o2DHiRU6Fx/z01VdGke0zvcoo0Uee+s4jr+ovlJlmwGhkmtr+HqLX5wZH7BBUAfxrPb9CNKaqcu3fivxSJKUP2J75NtKfkIwuiFJvyG1yA4HjKBjunQm5oTzyc16kQF7Fb9lTP6ZZc7m4KKLUjuMkYnCrSz+JV8CIlbHECiB5hV0eRHxOAeYDOt74F/J6YYHtXiWT9wGB3QqW8CPd08cUqqSNfupywH2XcQ2TxJzzGXt4lYLfu0D0a3goIQ/CfxTnh8Cxehv62GZs+lj7UVA9E+mV151PQMaUvkrCq85E5Z0pOmgXjgEL4Lb686lLbX8SK1agiLv2EFDOyvOEp7lhoV4d0KamcZ/LBYK29LFhLESZXW1DwZ+7UxeQWiqB85DFK80ebdgShLqPR4yGZe5E3m0g92pOWntAg675C/HIKZvqwUS03O9Qsk6NE8bsvDLjZyjUeZXR3sJS7kSW8bcJmmNRr0FgJgukw==
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(376014)(82310400026)(261009223027099003)(260925022911599003)(260925021911599003)(260925021311599003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qvK69VY9cU7uirPnls/tWrZz2IDcRYl1dNpogvs4geheTUrwoorSTfIDi12dy9ZAoX8LqrIirPOWg6N/LaE5BbtE5aQvtIqbg1UoeVhTkUoKP9091oB/FpTJfe/gaBcrIt4PcA9Rs1I9SKoPqzeHSKBQippp3lIbrHn2PbYvqyEFlzTt4iKz7LiYuCSEVtU5axlBGOqo3fZ9InmxKZ8xuGtjX/u1E2zA7xpuDfASdluGMZaRnBUWCwdmxSyDtcb16hIX23f/fzZQEkOy2kNpfGY64JzcnZLkvMUPaqTAW8/sji52jogN5CGo3rUyTNzsEGZopAxGsSur/SF0RP+XAHfD75LaCfE5NFlhEFXOxBhUXw+gfFs08/vNGL2ZtOcADVKMeGfjepJmTOMTRKZ7uF0nMrDpk+HSWGhK6XIGwn/8Mu/DvNDTSIUEPUOvBiZp
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 09:13:00.1487 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b7ef694-abe8-477a-0d74-08df29d35812
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB7054
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

memif_dev_close() enqueued a disconnect message but never flushed it and
never tore down the control channel, so when a port is closed without a
preceding dev_stop the control-channel interrupt callback, its file
descriptor and the pmd->cc allocation were leaked. Call memif_disconnect()
from close, which flushes the queued disconnect and releases the control
channel. memif_disconnect() is guarded on pmd->cc and clears it, so it is
safe when dev_stop already ran.

memif_disconnect() also walked the per-queue interrupt handles indexed by
the configured ring count without checking that the queue pointer itself
was set. Closing a device that was configured but never started (so the
queues were never allocated) then dereferenced a NULL queue; skip NULL
queue entries.

Fixes: 09c7e63a71f9 ("net/memif: introduce memory interface PMD")
Cc: stable@dpdk.org

Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
---
 drivers/net/memif/memif_socket.c  | 6 ++++++
 drivers/net/memif/rte_eth_memif.c | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/memif/memif_socket.c b/drivers/net/memif/memif_socket.c
index 5918406271..6f10e8d970 100644
--- a/drivers/net/memif/memif_socket.c
+++ b/drivers/net/memif/memif_socket.c
@@ -664,6 +664,9 @@ memif_disconnect(struct rte_eth_dev *dev)
 				continue;
 		}
 
+		if (mq == NULL)
+			continue;
+
 		if (rte_intr_fd_get(mq->intr_handle) >= 0) {
 			close(rte_intr_fd_get(mq->intr_handle));
 			rte_intr_fd_set(mq->intr_handle, -1);
@@ -682,6 +685,9 @@ memif_disconnect(struct rte_eth_dev *dev)
 				continue;
 		}
 
+		if (mq == NULL)
+			continue;
+
 		if (rte_intr_fd_get(mq->intr_handle) >= 0) {
 			close(rte_intr_fd_get(mq->intr_handle));
 			rte_intr_fd_set(mq->intr_handle, -1);
diff --git a/drivers/net/memif/rte_eth_memif.c b/drivers/net/memif/rte_eth_memif.c
index d805509391..43049fddc5 100644
--- a/drivers/net/memif/rte_eth_memif.c
+++ b/drivers/net/memif/rte_eth_memif.c
@@ -1718,6 +1718,10 @@ memif_dev_close(struct rte_eth_dev *dev)
 
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 		memif_msg_enq_disconnect(pmd->cc, "Device closed", 0);
+		/* Flush the disconnect and tear down the control channel;
+		 * memif_disconnect() is idempotent if dev_stop already ran.
+		 */
+		memif_disconnect(dev);
 
 		for (i = 0; i < dev->data->nb_rx_queues; i++)
 			memif_rx_queue_release(dev, i);
-- 
2.43.7

