Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A178CC6B33
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 14:39:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CBC3640A7D;
	Thu, 15 Oct 2026 16:39:51 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010052.outbound.protection.outlook.com [52.101.84.52])
 by mails.dpdk.org (Postfix) with ESMTP id 87C2D402DF;
 Thu, 15 Oct 2026 16:39:49 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b9iMvLgXfY+zAQfUsG8JQtEOFQ5x4OPdPGkuYWQZOIuTeEHXK2COQ1OKljxY0NCf5EJ3sRWdlYwevmrsvgzLRBzD8ow1PayK4Nf+50WXIvhlNeT6ofxxZlHS3d3Z04vGOiOv4+9Tsb8BUh4oW8PclJ4galvvkGPf37rSNIivqP9ntOd76Q3hIXiXfsksxOD+r01FSqIHIB5mM4Ee2t3BhOGD096pIovcUAhvl3zOSaRlFkLflWAClGEq8x9+Z76udylCBzrXHenMoo7o0aTW7d2lIbYQNiSi5emlAvJgqOfaBcy4yu/y4Xwq0eHiufwXSRD/JBv+ecNVGS1gZeyk1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NaUIFlgx8EWn0yS543g/vg8aNyLSROPlmpiQfLtgFx0=;
 b=Y8MthWmiwa5brbbA5wdRtAMqGjnwPMaMEGRW1yOA/MqU437e8VjYhUx1k59LPBBDGQ/Lk0YsxE12iHoz/6EbhJBYGwInw/ot1cyC9GSc3LgR81sccPAymGmMSD64xI/oD0Rs4383V8Wx6y0kiOpEMHeYaIDzk8ceJqPvgwdJsZc2hEJaGCpHnwrjvHGPUsovPmg5RJh08g59R2olLnu5y0Wrjx8f36TX3gaTGPmW16YnTWz9lj8R7R1DtHi1etVWmXSsQQK6XulayBmQ/6UU0sDBHV8LZj7l5MYeCy9O7dmX9R5Ykvm/v3WOvwbcIlYMIpj8F6ScdowaPUA9qcjO/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=cisco.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NaUIFlgx8EWn0yS543g/vg8aNyLSROPlmpiQfLtgFx0=;
 b=cZOEn+UyCDGUJhZ9Yj57v2YZkhsMQI8NNkDpws6OpSZQqxi3wMKGPfbybmwQ8c2F+io7EzgMxmG5vusr6DVkwgtrEfqeSQz47rE2h8Sw8cQGvi6bK+Ob2wL87EVOet5BXfKbptyNzvAxddp9kz2n8RxKVjM4xFqxQmcaEUZtwLorseHVGhP1JTmf2bQDbsFo6YGuTGoWapluu+anFfNiAlAEO2daa11S54MOGgO9p3SkQ849A7pbHyduGHOq4IIih+qFnJTQhv5h2URuzSmhEGR01A9tXjA5P/M20uYaJY3lzyHh8sHod4rSlNm26kXQI9Lj2nJvGaVc2oXvCqS4jA==
Received: from GV3PEPF0001DBA8.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6e6) by AM8PR07MB8189.eurprd07.prod.outlook.com
 (2603:10a6:20b:320::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 14:39:47 +0000
Received: from WA1PEPF00009B38.eurprd05.prod.outlook.com (2603:10a6:1d8::115)
 by GV3PEPF0001DBA8.outlook.office365.com (2603:10a6:158:401::6e6)
 with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.21.382.11 via Frontend Transport; Thu, 15 Oct 2026 14:39:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 WA1PEPF00009B38.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 14:39:46 +0000
Received: from seliius19697.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 15 Oct 2026 16:39:46 +0200
Received: from seliiuvd10563.seli.gic.ericsson.se
 (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
 by seliius19697.seli.gic.ericsson.se (Postfix) with ESMTP id 72E3A4020B41;
 Thu, 15 Oct 2026 16:39:45 +0200 (CEST)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
 id 33F6160B034A; Thu, 15 Oct 2026 16:39:45 +0200 (CEST)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: <dev@dpdk.org>
CC: Stephen Hemminger <stephen@networkplumber.org>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>, Jakub Grajciar <jgrajcia@cisco.com>,
 <stable@dpdk.org>
Subject: [PATCH v2 1/8] net/memif: guard against empty Tx burst
Date: Thu, 15 Oct 2026 16:39:38 +0200
Message-ID: <20261015143945.2150772-2-sriram.yagnaraman@ericsson.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261015143945.2150772-1-sriram.yagnaraman@ericsson.com>
References: <20261015143945.2150772-1-sriram.yagnaraman@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: WA1PEPF00009B38:EE_|AM8PR07MB8189:EE_
X-MS-Office365-Filtering-Correlation-Id: f725815b-432d-456b-eb98-08df2aca28f2
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|56012099006|5023799004|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: rY0YCJF4jDXKmV12hIUJYDNkTSNvw0RR8K+hTT7qO99QlDhZnrFkGc2yae5beELs5HRSbknJivr0h7S6+D+jtZuBKD4DovFjU8XWWhUWjROFBViwSbVLHo5bKl5NO/NIQav8EL7hdgZs0o6/HZSecJJ9HbvJk28kcmCfB1/8k8Sv7GyDDOHARYx2yZnCpFvC9XuZuddCymxkpuqCVp24J8RhWtHzQVLR41+3T+cYrbBMGBaGwH7P3R8TH/zQrjZxnqTSDSqIdN9+Af0K99lSeuv7gUKckeJ8o1NDIsWkSEhaefLRcak/x/S1iBLA52lLBiWUSScZ7wP2A5uZ04DRx/aGjM/imygSNBtrx4OOdENpwbsQgrI1KpcJ2Fk7AakRffJ3YKYoe81oDFQa1vy27Oye6Q5pDTcov4Kn1v9orJpzIP/eoOEdbWS3cQSN2jSVSXPNUkyAbeWX5goKZf5u9NiSaxfWBNstXKgcPYVhN5RUJ0cgSfp3y+7cDBH8o0Bb6ESQLwnxYCz/tAx8J4bvzpf9ta8gHxBI0WWelXp++ws6HqBPohfXAvYFJYQ3rmXuX5bMsgJqu4igiFbt9lvvFyKZ3W8FvROgLY04fEhnZZ0wMpNe+EMN+FD0MJnm5GWVU8zrEiBIqIwecLHuASwxqff7y9PKllqduW/hVQP6eBJbhLIZrxjPOfC1qDuqMzopLLjW7o/KFjeBkT4/UXFTeQ==
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(56012099006)(5023799004)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VRc4WB8exy4s/ORal/BK0I5Gk42FI2oWfbM0VeUdHvAY6hbRoatrlMG/kXZrvYnE0tnqlt/GeNxgZNYz+7rCz91rhLqCgrXTBAOg04B9EzXFS7OdfLAT/lpF52NbGn6E6m7dPkmdvpsbyQsqcAq4uyDu9s/25tquzsXuX+61x3Z2Be0Uaswja7L41+NByVYk64gzi76Hz82QKTY0lE7qRPYc62+xenYr72jy+C8gFfrEv2Dwi7BLkqtxuKjfh7LzbmZ2PisxmoZ7s0omM/KGgW8D2QIZ2kjMpXHTCOTbpfCBEv0aaX08SkT7vkFN+JGFkwfvMgxfGLIc5edMDI09jx6saZ/gatNeMRmL5s+GAY4serC1U+pKOKVULDzCiF5GvU4vzaIaxlZbi5XVv8MVHOKSOudAErIXV4QBxvNQZxNEKB03X3uf1XNR1eOa9c7n
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 14:39:46.8014 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f725815b-432d-456b-eb98-08df2aca28f2
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: WA1PEPF00009B38.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB8189
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
index 2d42338e48..2e41eaa459 100644
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

