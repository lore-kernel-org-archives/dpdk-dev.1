Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1B1CCF2C3
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 19:59:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 63EC940291;
	Fri, 16 Oct 2026 21:59:04 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013048.outbound.protection.outlook.com
 [52.101.83.48]) by mails.dpdk.org (Postfix) with ESMTP id AE5D84026C;
 Fri, 16 Oct 2026 21:59:02 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nFxKnlZWaK+zmmHwI5iJ+TZDxwEEm6/i5cfQyyYRksvz3pi09mJXfKxS7udwFWjM3FbElRwm55Lb6Pya5UCZBazjJYQs+1uREIQcJdtPvplxtVAkFqnogEUBM1cGeVljeOO7hYZBqqomnzHU+8fLJT2UvA3AAezlUgY6tdWqEZrXkEihDyLBODpCpEVObg/ScOKYgV+srMhvhwdb9Ovd8KpvrRFWyf2PD30kR30FMU6FeNTx6ML4gzo3EvASbZjcdndiSTqegp7IpINeCykKC2auWGS/Db7RAdbg7QJMgLHbD9GS6/2mjLu/zV+pMWCaMVN2cgwx34XjvdYHi6x4FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ZZbbMTOY1ddRXaWcrHqCQ5viZRndlRvMt/Yc2mLE9k=;
 b=kQtv+tXdI2f0Sb2uT9mHHMyH/T5MDOplZjRElmipuBVWBo7lOgQTSjfB5buYg4c69DfCx4WneP5eXTB2W7fxTUANlEOShE49Qh+Eu7YeR4svrnofPtBiqYlmMpOGQ/YQHBhQQ9RPr5216/qJ1x12nRJkCSCKoWdkEGI1tKIpNQ3VvWji6qkZ0mI9isEwG0Pmy2hfvibuZLIniSxKCwOxpFP5Ww4Nq8OrJbYHAWULOCNEbiK8rc6KzzC6z7V+mxjojp6ZvcwxPfqwaH7GL+jv4G9qxHOGy9HkuhAI4pwlftw6v7rRDSxJgQoZlpuNKTIvfdLVvpdeIHx/+KV0deJcEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=cisco.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ZZbbMTOY1ddRXaWcrHqCQ5viZRndlRvMt/Yc2mLE9k=;
 b=M8pNX4hj0Yl8SSf3pxatgSm1CFxcVkPS+2BXK/tiV7luSfhdqLC5JitiknOHSokVko+NCAE/QHCZVWSg0ociZG+ICXTYJQujbbkQPHrJnAQLYGxMwb5GElctHlWg6jYLW4p3edaNrOgDV7Prny91QdRbyTAxoLfVMcjOGpY3pHvy6Q0YrjWx0XUCrc7ZdFhNGbQweH6hHFtJlcS5HoPTP6G8MHNJkIdtVDqqOtn8Wok7edt05+99bfMwNVzs8wgtNABs0RtZM2xaN8jszhy6cKzAzfSfalmYV+SFZ23Sp7C2q7gDa4i5EGe5s9kVI33aH1FXR7DPx/JrsyWEmICGWg==
Received: from PA7P264CA0092.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:348::17)
 by AM7PR07MB6771.eurprd07.prod.outlook.com (2603:10a6:20b:1bd::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 19:59:00 +0000
Received: from ZR1PEPF0000E6B3.eurprd05.prod.outlook.com
 (2603:10a6:102:348:cafe::74) by PA7P264CA0092.outlook.office365.com
 (2603:10a6:102:348::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 19:58:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 ZR1PEPF0000E6B3.mail.protection.outlook.com (10.167.241.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 19:58:59 +0000
Received: from seliius19819.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 16 Oct 2026 21:58:59 +0200
Received: from seliiuvd10563.seli.gic.ericsson.se
 (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
 by seliius19819.seli.gic.ericsson.se (Postfix) with ESMTP id E4B274020B73;
 Fri, 16 Oct 2026 21:58:57 +0200 (CEST)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
 id B16966285898; Fri, 16 Oct 2026 21:58:57 +0200 (CEST)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: <dev@dpdk.org>
CC: Stephen Hemminger <stephen@networkplumber.org>, Jakub Grajciar
 <jgrajcia@cisco.com>, <stable@dpdk.org>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>
Subject: [PATCH v4 1/9] net/memif: guard against empty Tx burst
Date: Fri, 16 Oct 2026 21:58:49 +0200
Message-ID: <20261016195857.3258796-2-sriram.yagnaraman@ericsson.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261016195857.3258796-1-sriram.yagnaraman@ericsson.com>
References: <20261016195857.3258796-1-sriram.yagnaraman@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1PEPF0000E6B3:EE_|AM7PR07MB6771:EE_
X-MS-Office365-Filtering-Correlation-Id: 3139971e-365a-4417-bfc0-08df2bbfeb5c
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|56012099006|11063799006|5023799004|261009223027099003|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: CUgfwT9BAUgPvj9pHLZrnH+qU07PLVhdIOahfZFeyPJayrVbUF7NqX18Xq34u8UgOCJCdC/8yBjMEd0dtpl2GkQdbRPb35E36mtRkB1K1zoNG6vnD6w3yh5oBTSmWnTm1Xn0WRvaCQSVpf4lhf4rz//nrHQrWU+hCuXFyekAMxr8e7G1gukGjsaqcB1ZDQEb72Ha6SiFwzr6P7flHoac3Xtr1r02jYxwSOu1vg9jEgs3Zy0e92elbJMqdnTmGAKS4qTwdWBuHxzuGX9iGds24fFFjVinKpeayhEJV5QFGB4wnuORHGff2rzsfVndTQaFrzkBQb0WcxLUeKzuN5KH6uvuvIQwxyLZKOF1JWAfxrwTC17YTRVrw+9iOwP1e4f7MQTFJ2GkuVhncoBvAQ8j2sIiC80MLrn0CFL8ggHTHOhfM3LLO4Gi3FNKyhak4vSRP/brmgKJFMBVzta1ZnsLGchWZCgvMtKkWOIG1nFpcJ65OyVLE59R1h+kLo48PbxZTCdoIrxTTEa/Nkk2yG0BnOBqJUBnCbKIH2duRyUdoIS0vCZb3tL1+ziaCVoc+aSSR0FSuaQsrRaeJgvRif1tAJPuKdWglIw2Yu2BfPLM26aeeQNsJC2Ywh1K6rUnBL1JUCK+EwKDjNq1NTtuoPWhnZbOtXd9C3ay/B6H5L/Hl1YkG1STONEQz9lFMtfHwHlLHa7PF80cUFe2n+L8ZT6SPw==
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(56012099006)(11063799006)(5023799004)(261009223027099003)(22082099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: odt18e3sJLbpk84rfPfSfsFZb2GHu42tk38RslLY3CzJ0WLCHZeLiJS40IV0mZbKDb0fUbK9SrC9Bkzkujqg6hMd20cpGo/iX0FKnmkwhaoHiCr7CNusd6Fqwg0uZCdXX/1J3ss6k81rRkFdAJSKXFs1Qcp3QYCeSH+rFEmrAZy20zLA9Qw1ZPyHMmyMqnrDYoGvE7UiqiCiSGPEpx385LxPtypJL3al/G0W+3D5/43V/ItAGEUwrETYUI9sAcq/2tgV0MrS4Vlqxg1GkiIqIFB7pR2JH5iFudjTdy/bI+j/CNP7inzhIXgkVEIIMVJbDQvKbX6NfQpGG7mK9Vnr4hJ2nhKSjzAq80hEAgb0qoEnZ+fQdZoM1lX7OBDn5CYNrTAY7E3rSsCZEJ3ZhqypqRxkB9YVGDBoU4eiYPUnw/gjKehLF0s0zaYmskItF5wT
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 19:58:59.6668 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3139971e-365a-4417-bfc0-08df2bbfeb5c
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: ZR1PEPF0000E6B3.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6771
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

