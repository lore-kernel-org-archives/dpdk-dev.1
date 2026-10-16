Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37515CCA46C
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 14:16:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 460F640A6F;
	Fri, 16 Oct 2026 16:16:08 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011033.outbound.protection.outlook.com [52.101.65.33])
 by mails.dpdk.org (Postfix) with ESMTP id 2343340291;
 Fri, 16 Oct 2026 16:16:04 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H52wlEL9b3MBatv7E811/B3NiOh5e9zbuVOqIi71kEgItRMuDbK+9NK6EDYvDJK0id1bovm++vVJbSxqWN8RULC0GL4GvHWvPwHdqJodkLhMAIYXbGWCEKSB2tceqYmR2kIdZ2lWlSyl9s7smnC2gM24LVSw+KwB3wF9pKIw8CbRa/Vcz0FyvFOs8UNxnlRLj24din69SQD3P74yUA3vZ9jcwLZs05Ly+mIelqJLacHJJYQlnDqbOw5UAReZs1RSP+f35jk+HETGWxPjs1yrhIfBTc9tqSvwm7zV27EuoWJGFWxe/IFOwMtJ8nz1f3QHsoS+nIz0BUrRag1S1R5cXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ZZbbMTOY1ddRXaWcrHqCQ5viZRndlRvMt/Yc2mLE9k=;
 b=LhafkY/gB2t4EqfEpBNoTn8SztFUK+jw62g3aMcwgEyIPZcpTIe5xyOFfm82MhuTGXCkVu+dwqYXSG9GZ5i/JFYWyWMr1QFnmPbFy4LIFXKToT5tMQM4nXg+6VnmOozQZdTSIFH6hhIjicCDplVSK2jM+Twl0QdYh4yyL1DbJ7rHIT7bODqKbltXykZO6OR+PnWmlOCazfUyxHa9iLX7khXDFoiAOZ0r+tBIX5vwUNNqb0HFQ8t6rneG/Cvf7Y1ss29GeVRrurZuNH7/GgvSJHTEIJZskXz6F3NA+1pnpec+eH8FW6HO2BN3M2DAU8UuqwKgozGlzWvR8gWcJxdGSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=cisco.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ZZbbMTOY1ddRXaWcrHqCQ5viZRndlRvMt/Yc2mLE9k=;
 b=R5H9uP5POXmfVwZlzidMpr+mIm4xO4qNRkQGfG2REYjEGbdk4tbW37FQkCQpNY9kiOAoMpCNil61XVgl6pZzDE+9Bloorx2JVLDZMNDMpbjr8zP+HV2ij3vd8X7OvedOc2ycEt7IY2F/DQoszaZSgNJl2dCNShyBZFCV5nzFUihxlnWmhkAJNmrXBNQo4zZ9YuOpyQsa2bu2xAbNeaF6gyOGdW4iARHvxcO95ejNqOTIgBYHkTKtGq1iguxYf8g93vH0Gxb0zTtZFAVqTYEyH2T9vZQbYbxWCDvo51Fdir9g4ZG8kEtpnIpnmliXkDnN44Izvf6PX2gzY2jbrj/SfA==
Received: from AS9PR04CA0044.eurprd04.prod.outlook.com (2603:10a6:20b:46a::22)
 by AMBPR07MB10686.eurprd07.prod.outlook.com (2603:10a6:20b:6aa::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Fri, 16 Oct
 2026 14:16:01 +0000
Received: from AM1PEPF000C1AD7.eurprd02.prod.outlook.com
 (2603:10a6:20b:46a:cafe::26) by AS9PR04CA0044.outlook.office365.com
 (2603:10a6:20b:46a::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 14:16:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AM1PEPF000C1AD7.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 14:16:01 +0000
Received: from seliius19819.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 16 Oct 2026 16:15:58 +0200
Received: from seliiuvd10563.seli.gic.ericsson.se
 (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
 by seliius19819.seli.gic.ericsson.se (Postfix) with ESMTP id AB8E84020B67;
 Fri, 16 Oct 2026 16:15:57 +0200 (CEST)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
 id 73D216254BAA; Fri, 16 Oct 2026 16:15:57 +0200 (CEST)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: <dev@dpdk.org>
CC: Stephen Hemminger <stephen@networkplumber.org>, Jakub Grajciar
 <jgrajcia@cisco.com>, <stable@dpdk.org>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>
Subject: [PATCH v3 1/9] net/memif: guard against empty Tx burst
Date: Fri, 16 Oct 2026 16:15:49 +0200
Message-ID: <20261016141557.3081522-2-sriram.yagnaraman@ericsson.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261016141557.3081522-1-sriram.yagnaraman@ericsson.com>
References: <20261016141557.3081522-1-sriram.yagnaraman@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000C1AD7:EE_|AMBPR07MB10686:EE_
X-MS-Office365-Filtering-Correlation-Id: d60d0c31-2be4-423f-e2d6-08df2b9001a0
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|22082099003|10067099003|18002099003|11063799006|261009223027099003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: mYCJUi9zZa85iKHJyCwQtVTYX77ZRPDYNcLbd1uag3O2dUCvtLX7ilah1zizfxKbMZK3f0Ag+2fn6qWo1p/yPQNx4uaNWeSqsQd//QnOHeFbCrzbn4tadrJFP/mk396lSCFn/Rqp6nNX8COEUhjL6elK7u+R+VqfJrbnvSk7SOmZZeX3Z22QFte6vYlKJHHw+duQK0omOpSSrHuFf99XvxhN7gXwhfLa8eHk3EPkIF4SLJQ7iqEWLuIv4pVLyIRklDOTZOtcRJa1wC8DN/kYxUzrH+/8VrHY0TKnErkhOt854s4Vx8JG3/Fjmk5S3jEJphV+qgkLFPlR/b33vCcnI5snjJIiNmAf97JId5WL/wI/lkNSkl9+AO61AgNPqEVNYIRW3XaWLtnDzQqou40aDWjKhj1YowzAFqf61Vd7v9FQ2cv2wvRQeAOsqzYaHUYXX8y5e5p6YGn41UdqdxW5q7Dv9TdlTQkSXvwMnmz0OA+ojuejWp8oluf8mCYZRp5zMblfLP+jDqNn/ql04uRg2MYIGLvZ2RrBShDSQK27JdhzLLWBEevUzYcxvMYA/+TU7M9Mz0NXMeZUKoRnUvU6zAfjd/A8EjCUc4aghwttdFZmHdZ/8CaUT4Oc9hyxd5S6eWNFQ9eO2SKxFyCWQJte2jeELrnsVtJNXBTT9CSwfDZmlcMfLtKJ5CozsK87/ZYILSj2UPX/lSjizYEvIhM89g==
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(22082099003)(10067099003)(18002099003)(11063799006)(261009223027099003)(5023799004)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LlE34K8VxYmgnCOTiDm4ry5/KRuFobgDrOr62uQC2y1lI2jtu//V+NFcL+mg3igF4AKW3kHUg1FOjNwOFm4pbQ0KLyqqUjwGkppKnkiCfYWcU7jrB/PithomlclPCTqC3zVirHfEn+SDxaKYB61Pbf2Su9yesQAAP2crdVP9dhvhUWuMYNwEH9/fOTgnyB3ZnIet5tU79VMcgKv2wzqj7z9cuANKT6rtxH64Rm46AJSskb1n8qE3dhLIHQ8Pf8ckPJtXfanDA1NrgTSf09ftb3qvFbM86lKUQLMmBeSmk7eb6a5GQBtWj4gcfNvwUw/Po8uhVxrGEHKIAzimlEaofXI8a/Lg70gmjdZffB1cU4N2fH8OVP5BPdPCYw6Z6FxEcWqmBLVdyi3cKxCiZufdGtEo+iClfM0HfaCC6K3fKewk+dQNcsRA949C3Jj0uuHW
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 14:16:01.1929 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d60d0c31-2be4-423f-e2d6-08df2b9001a0
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: AM1PEPF000C1AD7.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR07MB10686
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

eth_memif_tx() reads bufs[0]->pool to pick the mempool for its
single-pool fast-path test, before any check on nb_pkts. A caller that
passes nb_pkts == 0 therefore dereferences bufs[0], out of bounds for an
empty burst. Return early when there is nothing to transmit, after the
ring == NULL check so a secondary process still requests regions.

Fixes: b5613c8f9d0a ("net/memif: add a Tx fast path")
Cc: stable@dpdk.org

Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
---
 drivers/net/memif/rte_eth_memif.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/memif/rte_eth_memif.c b/drivers/net/memif/rte_eth_memif.c
index 3ed177ffb2..36db03a268 100644
--- a/drivers/net/memif/rte_eth_memif.c
+++ b/drivers/net/memif/rte_eth_memif.c
@@ -904,6 +904,8 @@ eth_memif_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 				mq->in_port, rte_strerror(-ret));
 		return 0;
 	}
+	if (unlikely(nb_pkts == 0))
+		return 0;
 
 	ring_size = 1 << mq->log2_ring_size;
 	mask = ring_size - 1;
-- 
2.43.7

