Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0584BCC6B33
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 14:40:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B81740B98;
	Thu, 15 Oct 2026 16:40:32 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013052.outbound.protection.outlook.com
 [40.107.162.52])
 by mails.dpdk.org (Postfix) with ESMTP id 5FBB040B9B;
 Thu, 15 Oct 2026 16:40:31 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+6QVJmXzznGYAgfVD8YmJCKo9Ig1F8ZOFJxJRs8572v5Ju0RoLOlW+hVK1ubABrZMCFFw7JRri8H9wMESI7UtdtGrg+1VqhdeJOi84FIbd6mW0jZUMquxGUX9PKKqnzMECw0Yf7bFeTpxN0C1d9hYvBdubaJhQtywBWYwAvusvufj/ZvfgrouC+uIlNWkBcXp1+R8FeYKtUg9sEicEU9TQULyvwZJIjV98djBiS493hDfz8LCM2xVJL0aFXN/J4nVZFVKnOzSmE8IIJhcTvk8cmKU111jsNnHMma/puxb657tk1X8pl7N+4WvrP1w4+FZfE8R7MZLo0CdLGsRazag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HD2srWmJIL0Kxw6jmNSFqMrbT1Z7F36574dfX1DwP/Q=;
 b=hXP+DWDFMaoqlyF0qRXxvJ/SbrYNaC83qBOA6JWZE1AtHaaB0N5bwiYp/CKzCpWuDrghM7XGVsoJsXobyAZbWKXG2lbUnd3aN2kHFEhPfEswT1+059ZsOloLDvvepM5Bdg5CfCYQKn7h2auSn4fgc4abpko8jPsUL6TYYWduLCCIPcpxPCfRPBo7ZEH5NYaZD3j+p7L+s+ejMvAy5o/YEeSa+L/XUa7HAJZd8eGb3+oypk6T9eGMa+xGm2yQ4Zu+LERE30mbp5P383HNoQAsfXvdViyl61yPjPVhCgxMpTzu9B13Ut9DdJ1e0z/91x5u6trkgmx90adplMsi7P15/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=cisco.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HD2srWmJIL0Kxw6jmNSFqMrbT1Z7F36574dfX1DwP/Q=;
 b=QJImiprjLagLRLEtDPqnA7gJWuxkOv0w9PzPfuX+jE9NyeJc5doz3F1srtAdUGVpbwQAOp9/nH8HWMzMrvj0tlF1lNgU497oND2+V3gMNYke/PmIAP/KcaSvdcBa6u81b6enSJcGkgBiAoTpukUr1z9YVK6T2c0UwrH5oEvfYEvbqYSfo1WZgN1ROXMOZHa/x2C5LzwMecfEoVjxcpIz/0M4cipqu7NVfKaQICNfYuoHzj7HTPk13isyHTG6okNbHGS5d1Ktzv4o1G7BjV+2oeKscEGEQMdAHnbbPVH7umZ4c0WqAF/V8UAf8k0MHEjNx8B4CeoQZveZQ1icUyPoSA==
Received: from AS4P189CA0035.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5dd::14)
 by DUZPR07MB9761.eurprd07.prod.outlook.com (2603:10a6:10:4e3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 14:40:27 +0000
Received: from DB1PEPF000509F3.eurprd02.prod.outlook.com
 (2603:10a6:20b:5dd:cafe::6b) by AS4P189CA0035.outlook.office365.com
 (2603:10a6:20b:5dd::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 15
 Oct 2026 14:39:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DB1PEPF000509F3.mail.protection.outlook.com (10.167.242.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 14:39:47 +0000
Received: from seliius19697.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.69) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 15 Oct 2026 16:39:47 +0200
Received: from seliiuvd10563.seli.gic.ericsson.se
 (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
 by seliius19697.seli.gic.ericsson.se (Postfix) with ESMTP id 2E5934020A9D;
 Thu, 15 Oct 2026 16:39:46 +0200 (CEST)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
 id 6EAF460B0354; Thu, 15 Oct 2026 16:39:45 +0200 (CEST)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: <dev@dpdk.org>
CC: Stephen Hemminger <stephen@networkplumber.org>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>, Jakub Grajciar <jgrajcia@cisco.com>,
 <stable@dpdk.org>
Subject: [PATCH v2 7/8] net/memif: fix bogus Tx count on invalid interrupt FD
Date: Thu, 15 Oct 2026 16:39:44 +0200
Message-ID: <20261015143945.2150772-8-sriram.yagnaraman@ericsson.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261015143945.2150772-1-sriram.yagnaraman@ericsson.com>
References: <20261015143945.2150772-1-sriram.yagnaraman@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F3:EE_|DUZPR07MB9761:EE_
X-MS-Office365-Filtering-Correlation-Id: d33d158e-dad2-459c-5189-08df2aca2997
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: jGf9raLvBeDphvbdTg50YWY4sfpZ80un9sXenrGy34byljhh0+QTNwWxOpkG9CPAjkh3rXIVkGClaoYESRw2QV9LILHrpute5xMek1pW3g9Evu6ZebL7+/0UBwCa9Dakl4StQL4elUEbm8D5eZxpD7Mv4tumC3kT2XLiufPx3j9r6NpvpKTK1YhqBejZJZxzZoW1dbLsqAWyswoZuKMM2A+X24hTysfydSvtfXkF3JPe2VaOv6YvFSzljqSjl+H/bw3lkeAV9cv9Q9N60qR1sm+md7aFlSBHiZ7aaXDqZONz/csV1tVYEvZowsn1LhYEmINAI+8CFeit3ZkDia7xQNuKzTVIG8C1XAlq3+XV6a5a7r0LbiR3yK4EYS61arQc9UbK4YNjgUYVK/x2AtKDlXelUQb38HjlAJ2I7ppTpMeE1vuE3PeBNJvhixDX+e2L/QS/3amKwXXq0tn327iP/HFg468uljDTiueeAeatOSBOyFkZlJRfbCYTDMGmBmAC9kPhfNtVT80qUGnLbm3UyEaUIzXZtuCSUiF12G+KCS5VQ32Lb5nt42ckAR0zW7A3V/hM99+i0jYN1gIvRfiCafKdWV1YBBkAs39IagQOzABYJFVwaQIPy+9j+6b71tmi4lnbxalfSp/0YUBmJlWb9gDwTwWuYYq6oU6dum/X8pgCHo3yBL1Bk+tY51UHMeu4a8MsaHI7aCCZmg5v4zZxiA==
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bILq5PufSY/v8rM363L19B1seFgaGJ9d6UVCI1809ZS06gOqDXSLHCVj1kTDpQoT+Fhird3czjAWGuQfh24zyWpiMxlTWZGTxD5/OYdzXUAYlMRTQRiN7exUSOA0EGBIJyDgQjWckIlfdQ2QRRbA4cVAI24TYAvcMEt0LOi7qkkNMGchldDGymFlLTvAWegA2DaKoN7Dvv93yFFTxkSCvFU4CauRaB5SNZD9/CjmmCbpViT60Mq62VkJbOJPbRWI0vDBXrC9mKEhRohICMjff7hnE+aHzrjKOMtVMl1zRdxKwdXAFB+m9GJ9S0xRJ8h7WLkNacYbu2ylrpjaG5oVS8OazEE43n7NGpB+2S0SOAoPinbdIqAcpWAr7MVdSYyLbEiwm2nF5n9TV+KqFJvq8J1r0CvP/dpLXyvvcShXQsEl+qPoVXsyP1JigI1QN1d8
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 14:39:47.8597 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d33d158e-dad2-459c-5189-08df2aca2997
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F3.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR07MB9761
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

eth_memif_tx_zc() returns uint16_t but did "return -1" when the
interrupt FD was invalid, so the caller saw 65535 packets sent after
ring->head had already been published. The FD can legitimately be -1:
memif_init_queues() only warns and continues when eventfd() fails. Skip
the kick when the FD is invalid, as eth_memif_tx() does, and return the
real count.

Fixes: aedd054c5c2a ("drivers: check interrupt file descriptor validity")
Cc: stable@dpdk.org

Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
---
 drivers/net/memif/rte_eth_memif.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/memif/rte_eth_memif.c b/drivers/net/memif/rte_eth_memif.c
index 3174d21dc0..039acd4b12 100644
--- a/drivers/net/memif/rte_eth_memif.c
+++ b/drivers/net/memif/rte_eth_memif.c
@@ -1254,11 +1254,9 @@ eth_memif_tx_zc(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	rte_atomic_store_explicit(&ring->head, slot, rte_memory_order_release);
 
 	/* Send interrupt, if enabled. */
-	if ((ring->flags & MEMIF_RING_FLAG_MASK_INT) == 0) {
+	if ((ring->flags & MEMIF_RING_FLAG_MASK_INT) == 0 &&
+	    rte_intr_fd_get(mq->intr_handle) >= 0) {
 		uint64_t a = 1;
-		if (rte_intr_fd_get(mq->intr_handle) < 0)
-			return -1;
-
 		ssize_t size = write(rte_intr_fd_get(mq->intr_handle),
 				     &a, sizeof(a));
 		if (unlikely(size < 0)) {
-- 
2.43.7

