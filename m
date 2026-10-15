Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F64CC6B33
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 14:40:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1DCEC40DCF;
	Thu, 15 Oct 2026 16:40:00 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010024.outbound.protection.outlook.com [52.101.84.24])
 by mails.dpdk.org (Postfix) with ESMTP id D17B640BA3;
 Thu, 15 Oct 2026 16:39:57 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CdGEez8eypVOGSyOBNZVEfxnVPtJ1IuvNVPNWl26tJ48bqtzMTdBgKdb1im17u56fgEjBFcL+aJ4otqQLz08sb+3+zHv/LFlQWNX57ivCMfqxo5Wyqho62zBRcNGFynHfGtxHx0Z947c8FmgVqs3fxLmhGx5OR3VBKCHVfLEjYNs+BxkDIqqsjr3gPIQLAp508YIvr0lqf71TTB1wGg1N/hDwlQ/ZEidRNGrxFCEyiMxN/qS/EE7d4Exv6iha0hvXcA/KH46F+ICU/yuJVv/Up2d831nq4gUxOlVjPtbt7g3PlDcTvAaNxvkFbWCj+Z7dJWl70D4lUqmEJEqICnCLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRhNNLUoxxO9g0rc9J03lX1Xh1duZFF/soIPaWwSLdc=;
 b=eX5gFPQuv3jI5bifWj9dqCX4jrm7ZZRBJJN0utNO4qL0eBdausWG+/gucSiNe38QOuEBLql1EqFQmE9qv6FOVKrLU5izDX/u4HBTZPLKuseTF2cZKT8yYvqRwsYZfgoPX40EF/p1b0BX3vCfo/rN9tIcVM4+iDpJT42v7nUCx3OYHU/3yArCvl2q+W/choNF1A88rbT1qEO32Skk2M5qGFJi/LtxYJd7iSvcNTgU6Wi5SVEhtSRdC55dC8SLXPeNSa96Q+77DGIc2UBKELvEBPkwWnHv2m7d7t79/97zhPX3kdkMmZVHNLsdYyMOcrppop1KRQmew0f4rbD6A/HvSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=cisco.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRhNNLUoxxO9g0rc9J03lX1Xh1duZFF/soIPaWwSLdc=;
 b=GySQSZDrOV+vQI/wyNZEGprhzuWN8fG6wReFbSGj4bnndOuFtgrEPk2rwpRjZ6IcWqCgPycCrRtaSIiqmIitecHIRn4zEN7wF7Wkp6eMMB80/kdthadCSesAuAZnIBMdRPCWqoSDCPy0F8ilXETEGDMoDA4tGHj48Z0ZNumOl2shtYyRAgvKfq68URS6csw0Exko3tKOAGFJ5ixAmdKoUS88fW/gGdd91x/bgeHmJTN2ZqFJqg0j57I2vUV4GPOC0RE0GcunyIiPzTogNeW4Pbws94MultZVXL06i6mCIhEXujvtwyLNhcF0udovLHY46oEJL2wKJz9RcWvbQU3xcA==
Received: from AS4P189CA0059.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:659::29)
 by AM7PR07MB6580.eurprd07.prod.outlook.com (2603:10a6:20b:1a3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 14:39:55 +0000
Received: from DB1PEPF000509F9.eurprd02.prod.outlook.com
 (2603:10a6:20b:659:cafe::3f) by AS4P189CA0059.outlook.office365.com
 (2603:10a6:20b:659::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.21 via Frontend Transport; Thu,
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
Received: from seliius19819.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 15 Oct 2026 16:39:47 +0200
Received: from seliiuvd10563.seli.gic.ericsson.se
 (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
 by seliius19819.seli.gic.ericsson.se (Postfix) with ESMTP id 1DBC14020B7C;
 Thu, 15 Oct 2026 16:39:46 +0200 (CEST)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
 id 6743E60B0350; Thu, 15 Oct 2026 16:39:45 +0200 (CEST)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: <dev@dpdk.org>
CC: Stephen Hemminger <stephen@networkplumber.org>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>, Jakub Grajciar <jgrajcia@cisco.com>,
 <stable@dpdk.org>
Subject: [PATCH v2 6/8] net/memif: disconnect on device close
Date: Thu, 15 Oct 2026 16:39:43 +0200
Message-ID: <20261015143945.2150772-7-sriram.yagnaraman@ericsson.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261015143945.2150772-1-sriram.yagnaraman@ericsson.com>
References: <20261015143945.2150772-1-sriram.yagnaraman@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F9:EE_|AM7PR07MB6580:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b1bd1e9-f56b-486e-ef63-08df2aca2df9
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|22082099003|260925021911599003|260925022911599003|18002099003|260925021311599003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: +fwr63yzukf3BSdFWAfoVipsgfpi+Xj/e2Pasr5H2oBOa6lEWHuYucXrQ5DDZnE+NRJwlgeTrdz58yOi2ar0RyIPBfGu0ZiIraHC8EhVz5l0P3Neypox5N532Q3UovRiL+zB3jr1CO+j1RfNizYscTmFrmwGHndyH1BCZ11atXkoCzD9LHT2kEfy6EYS4b20b5Qp3svV1dgeZxcBUkL/U6a0zXnO1V5ea3/1xKr8YDUD41spKyj6MMOdHIDTNRghhvhd/LOvYjglnmTEJt2F85RP2AdjZkvS/9vPgKTGfuVaaRr89+0qcQE0c3L62rGobVGIesxsSarC4TYiT5uDw3+pZnzFISEDsEiXFY/09IkXzG1GKfFvVRQW+HGKzjWnglhNTq7FH4t24YdaO2D9nxZT8kXBj0fC6UMbtL5Io3+HbrLU9svNoPw5TqOXERSwvTLiuGm/XnEwwpwkTSBQyPILjJ+BcfEmHGnOE3ZfcNN7UreYP6VMAWN6x+aVUni8XrylrCCwt5m9luBzHF39G2bRuHZKmhK83Ej2i6VaGKlXAtea2m8MBD/tnyfsjp1SRtVeo3Tw/yR4t41zVzIJDEl4R5iYsGh8JHWmS4Zu/0qshYXSEM46CoIpCK057WqpqyVkS8DBa/1FLpgjFhFGzajY48cUEGt/sX0eUKD3KYztexYxYl/P2sJGa0AICZuOlmMEP6u3r4UjQMSpowc+NQ==
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(22082099003)(260925021911599003)(260925022911599003)(18002099003)(260925021311599003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ata8+TfhDgzr4rdjeozf4ILTXTUuzl5QS7fkOAHnETlq9M7tUH6Whfhw1Zp0VS5nts1uZ63Fjxlte4reJHGXHp7gDvV2pR1woqXW8b9H5BiU0wjmccwFMfuVZTh5k+qmmxN2B3tF/LDxYM8msUEi2eNGV+Rxqfx6yufNS31ob4rlgk0emGD1EduGFeYWEaeM4qju8PGKMWR1XmCntbkfXu/azEUzEv55rxr0wHqCUl4kJT2uDYOOOzyoFqs7WblAl3arjB1BgEpP2LAFCc/L/d8VmekoeE3Opupy4UqQrwpgb8FRKeqzFA+66J8DT7niZN+9RwaD6ZZCaTg5qnKieh3ZtNVgEE/GzRoPEvQx5TtJa7+ojvNI8o6jZo4KXvCmF/uz3uWiMShVAnxx5ZCCpm4gc6D63fhhiL9eGaYO8aMoT6XIyiyQtNxKR2qT1kf5
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 14:39:55.2150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b1bd1e9-f56b-486e-ef63-08df2aca2df9
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F9.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6580
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

The leak is reachable on a server that is stopped or was never started:
memif_msg_receive_init() binds pmd->cc to the device without checking
dev_started, so such a server still accepts a peer and holds a live cc
at close time. (rte_eth_dev_close() rejects a started port, so a started
device is always stopped first.) Call memif_disconnect() from close,
which flushes the queued disconnect and releases the control channel;
it is guarded on pmd->cc and clears it, so it is safe when dev_stop
already ran.

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
index fa9847de06..3174d21dc0 100644
--- a/drivers/net/memif/rte_eth_memif.c
+++ b/drivers/net/memif/rte_eth_memif.c
@@ -1717,6 +1717,10 @@ memif_dev_close(struct rte_eth_dev *dev)
 
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

