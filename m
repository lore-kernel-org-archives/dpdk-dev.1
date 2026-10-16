Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A89CCF2C4
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 19:59:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9066B40671;
	Fri, 16 Oct 2026 21:59:06 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013061.outbound.protection.outlook.com [40.107.159.61])
 by mails.dpdk.org (Postfix) with ESMTP id 0400940298;
 Fri, 16 Oct 2026 21:59:03 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KuIAcZZT0tzo4efn+8i/5O1YM/SGmM45yYFtXjg22j9I5LKUhp4U4IzoaNZRiaBESQouyHZDGe5coNsC5cudRXcLJQrb5bHfErzSrfBDq8q5SJv2uZ6B1XrvUj04A3bkB6p3lqksQ3VIYQzPw6/SQDhThY4HdZ0oYovE1tuY1GdQHStN6ZAXjyJHzjAnAW4jW5TXOAeMwsdaPkKRQ32YeQOyLuKMBauH5L0VOkplGLVz9ATtpdAYqgbrIw7mskeg5afWnabiaotSYih3ruCWNzHsEOl1JFD86EkUcGJuPwNCL926HC0WCSZ/T97H6/UDMMPxYH9BFs6n3PTkTSOTZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKOnzvcjJU8V7/PmVW9fgTcZxf4HEGBsFh4Ov8dcS+o=;
 b=hKnrVGqPqrn9dsIUjCoZetlGS667mJe1GYNvw0YdvTk+H3vAf56if/Ye4xVH/86rd9a56GrtBnOK3K3uDoRrysEcxshU2u5eJ85scVKDhDAHoPmn4g2R5W2A3jocD5VmtQTQYYNMB9XFtqoLyXPpbTbeWW/084bpZwc44xUpUzm1tsFFqIwH6c0ZfjAEbMaKWUyFI4YbxYhLL+44OazRcU3hQ/2IqzDpzEOSUv+CFeC1hin9SJoV4R6C7WsfqsP2J8EOQluYNAoQOOLVnapaVBDq/zMZurLrM2CzIfKJJ3HNl9nfQvxVLB52rnPzSWdeVZJ3vF/giU4swiBmGSWIcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=cisco.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKOnzvcjJU8V7/PmVW9fgTcZxf4HEGBsFh4Ov8dcS+o=;
 b=HZWrS+1AHGEvzA4EJqWppfuoC0zyY1sOmvWfinmrrUAt7LvedAdkSDzY3phNOYtW8MZGiG4zJa2Z1kgj9StzU+ypL0NLVAgiDKUXRhe1Ex3pIjw/wHFoqdJ+GKTSuAS2Yb6HTpGwh5WsoEqVaWCvTDlChDYc4f1RvTwZWSHyG2vU5ALS+dl5GlPi468qt51YSAmHK3PWrccYASu9psFyGT7o8hzvkI7F53+ydN+JFqX3Mo164+4+2vR4nkBP2A2rhqqBrad9gRilwrCrceZrV6i/JLcmW8qYx1nCU2yyph6OJZaezE3G9aWsqBqpT9f/Rf6fnT2nyaXqd7/3L8Ju7Q==
Received: from DUZPR01CA0001.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::10) by DU0PR07MB9363.eurprd07.prod.outlook.com
 (2603:10a6:10:449::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 19:59:00 +0000
Received: from DU6PEPF0000A7DE.eurprd02.prod.outlook.com
 (2603:10a6:10:3c3:cafe::62) by DUZPR01CA0001.outlook.office365.com
 (2603:10a6:10:3c3::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 19:59:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DU6PEPF0000A7DE.mail.protection.outlook.com (10.167.8.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 19:59:00 +0000
Received: from seliius19697.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 16 Oct 2026 21:59:00 +0200
Received: from seliiuvd10563.seli.gic.ericsson.se
 (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
 by seliius19697.seli.gic.ericsson.se (Postfix) with ESMTP id 9F9684020AA6;
 Fri, 16 Oct 2026 21:58:58 +0200 (CEST)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
 id D3BB9628589F; Fri, 16 Oct 2026 21:58:57 +0200 (CEST)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: <dev@dpdk.org>
CC: Stephen Hemminger <stephen@networkplumber.org>, Jakub Grajciar
 <jgrajcia@cisco.com>, <stable@dpdk.org>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>
Subject: [PATCH v4 7/9] net/memif: disconnect on device close
Date: Fri, 16 Oct 2026 21:58:55 +0200
Message-ID: <20261016195857.3258796-8-sriram.yagnaraman@ericsson.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261016195857.3258796-1-sriram.yagnaraman@ericsson.com>
References: <20261016195857.3258796-1-sriram.yagnaraman@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7DE:EE_|DU0PR07MB9363:EE_
X-MS-Office365-Filtering-Correlation-Id: 83884d5f-dae9-4242-8f42-08df2bbfebfa
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|6133799003|18002099003|10067099003|22082099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: nbXoxt2J3GddPiPciJqOap3WhbzVc0/wzijjjlR04I3tc8XZLamoG2aNcLWGnF/OSOWR30Fl+hK6PCP7Q7X7TwRR7rLqeDP2EmBQZJAmasXSvUzJ/NSJy/jUVKm/uE0a4Lk9Zn4H/BghBZ4u5/2XExWro67RzjtJaYeZzrD087mm1fex3pYvKuXUsSLuCnuzgx7kdP0VFVdtDnCCQrTcQbXkLXQoA8cwLmIvZKz3FSApvyhXNxXJd+wx/kpHAQSR4xhia2HLfbm2wjLWMMrEHHsnjzNjrXcoDkbRG4crVYQsRKbHivtmuqt1PLdwPESlOC19xxmrTTYNHiIGMq2/cfGCIHm65t3dIwVXYqPvVDMKRzQG4ats0peOkcXBpGDc02bsspWPMEK7ijSp9K6NT/OBqF+Id3klcgKvnm4c4szJUos99Feyeqwe//JLPBfYoFuywm4NDKbmnN6ZFJAoOVBVQ8jJ0yL9jMkLOxfP7mpzoDuz+2MyunY+/9wy4kxa8DndH6XKFB/oIwwCbJkIc87+2ccUoO+exoxUZNkkUI811UoXxiPJRjIfT73yTuGxN5Cd9CZDkt+NZfYRCoP7QgGgI70Fl9orCIEnO7Q0IN9Lf/kSkGx6HI7AG73SkeMrYc9cM+M9ZlVt9rirWNG+Te7MW2vGUoEe38+9lo/mWP8PcB9dfGXzxXgdJnlrsOGiiGDf9y6mxGw9I6T88SC89Q==
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(6133799003)(18002099003)(10067099003)(22082099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dFeB+TBXFez/9fkTOMAGjg5dtJPXZKjsa4tXVHnIRwQwk1lS2vIe9DOockZYfoAszSIAbohEZR7MJqLG0X1dwwh14I8i7v7PDwVri2zW0iAA2WYtdPj1yYTJCqA2QFBuwKFZF5pKjKVrePRDrhHImWVd2dmZJSm2jaeh9xjUipUrIeNCAIjECQhgIc+1TEVUZlx34Mfmu4pKOCmcDUjlLVGa/OJsRozG+hOPh6dk6Pg7eZwxEKOf0O6q8YA1CkND8g8DXGOfHhS7pUyii4jBFbKS/41LxwLDzEzFss8w2zKWu1jDoNeD252FWehGutmhoQgaXEjQMn7exWmA9AtT9vZkTmcqEhSLhGFGh1Xak0uSOOSbByxcaDXZgpSwKxNFxdS6E9e4gbZgwSQgrQYRycE0B4QYarZTJj/aqa7NoHTCsTEe+SZsSOLL6owFUk+6
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 19:59:00.6777 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83884d5f-dae9-4242-8f42-08df2bbfebfa
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000A7DE.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB9363
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
never tore down the control channel, leaking the control-channel
interrupt callback, its file descriptor and the pmd->cc allocation.

A server that was started and then stopped could still accept a peer and
hold a live pmd->cc at close. Call memif_disconnect() from close to flush
the queued disconnect and release the control channel; it is guarded on
pmd->cc and clears it, so it is safe when dev_stop already ran, and it is
a backstop for an init that races with stop. The companion fix that makes
dev_stop refuse peers removes the common trigger.

memif_disconnect() also walked the per-queue interrupt handles indexed
by the configured ring count without checking that the queue pointer was
set. Closing a device that was configured but never started (so queues
were never allocated) then dereferenced a NULL queue; skip NULL queue
entries.

Fixes: 09c7e63a71f9 ("net/memif: introduce memory interface PMD")
Cc: stable@dpdk.org

Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
---
 drivers/net/memif/memif_socket.c  | 6 ++++++
 drivers/net/memif/rte_eth_memif.c | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/memif/memif_socket.c b/drivers/net/memif/memif_socket.c
index 550e2e468a..cdf85e09a1 100644
--- a/drivers/net/memif/memif_socket.c
+++ b/drivers/net/memif/memif_socket.c
@@ -663,6 +663,9 @@ memif_disconnect(struct rte_eth_dev *dev)
 				continue;
 		}
 
+		if (mq == NULL)
+			continue;
+
 		rte_intr_fd_close(mq->intr_handle);
 	}
 	for (i = 0; i < pmd->cfg.num_s2c_rings; i++) {
@@ -678,6 +681,9 @@ memif_disconnect(struct rte_eth_dev *dev)
 				continue;
 		}
 
+		if (mq == NULL)
+			continue;
+
 		rte_intr_fd_close(mq->intr_handle);
 	}
 
diff --git a/drivers/net/memif/rte_eth_memif.c b/drivers/net/memif/rte_eth_memif.c
index 852a7e2e8e..cdf77d77b0 100644
--- a/drivers/net/memif/rte_eth_memif.c
+++ b/drivers/net/memif/rte_eth_memif.c
@@ -1723,6 +1723,10 @@ memif_dev_close(struct rte_eth_dev *dev)
 
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

