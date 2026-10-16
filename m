Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BB4CCA462
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 14:16:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D65C140656;
	Fri, 16 Oct 2026 16:16:05 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013045.outbound.protection.outlook.com [52.101.72.45])
 by mails.dpdk.org (Postfix) with ESMTP id 83E3B402DA;
 Fri, 16 Oct 2026 16:16:03 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVselD+3wcHiG/mGQIunmmkFUo+bOc7p0gUiypzF+U7NqlrRZos34ELCAi1brB9U034NfbYeUNTLuDClgug2C9V4jOZ/5oq+kRMWKDwG6Vqo9SFtU/6l8/K0TeZMXUfL7E2c6n72ZSVlqNOOPNG0POURUljQtrCY3haKsomxGfYeJ6zvAvAKyqDYp26jrXbNpTy/qiR7+0BJL8UslDav9Yy3qCAo3BibNtNumgGsKtUrZj9d22k4+njDhrP6/whHQXWjpBEQGnyyZu8g4cb1NEW5o5QJz+HTILtsKGKmXjx6UGB2TkjIYKBRQPxkaiQU86WlFGQxb309mCQk+2Ibwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtmj5rmFr7SlV3MngwmYHEAXdnP6wosWgiWgVMcbLS8=;
 b=M4xtCfnfZ6/SOrcXWqhwxt4cQhPtaUkXrX8Gp1wszuLzA/9LkBPjIHHgBnCPG5Cih3o6jKhh5bptrMAunhXASkDCPpYM4/dFUHHgMtTmGn+I9IAh0EXd5ZeqbxKojLxi5aLI/wbB1Tpa6FjlQo+ypOpmhszeEGHto2RjKVwAqg4i44jcTCoGzbzf2wwf37yGouqU7+EayRBIcxG7+hQn290Po7VeOTDbt6L9ySg35WaiYZDjhaQfR5clO39yXouJnlZn40ZjW2wz2lT0m4L5Dt+0zPvHUxvHcDVfq3Hxi7HOdL+5jRLJLV9hJxjK9fZM1eZTEpyiXks24XcrAEswcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=cisco.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtmj5rmFr7SlV3MngwmYHEAXdnP6wosWgiWgVMcbLS8=;
 b=dMsD8AAxzIl2mfBr3kgwW/rLpRXhre64l1tq2jE3wzdZsjOZJE2t1wMVUTDod8ttm1I+w2X0vWXuyDEvvGzZYkSF5WadqjYxjX5XbErWi/ix/V8i9KT0Hoy5eohVvSiJqupeb1id7cHDKluwdZm21S4tons02pIr33yX0Vrj6b9CqzflziAnniMirXTxVizoRRAEd4m/Kd91tkQJPKYzD5r/4NzImPY/g14y1URqHMAIJYuFeaPE3BxwWY9NfV9zNF+09KabuAG9GBNv/ACV/vVxKYQxhLwbVZeADgt4CyvdTTDnjNVAfYSa8OoC1Uy+Jo6nNune9+szU71/gnZk9w==
Received: from DB9PR02CA0016.eurprd02.prod.outlook.com (2603:10a6:10:1d9::21)
 by AS5PR07MB10572.eurprd07.prod.outlook.com (2603:10a6:20b:6c5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 14:16:00 +0000
Received: from DU6PEPF0000A7DD.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9:cafe::40) by DB9PR02CA0016.outlook.office365.com
 (2603:10a6:10:1d9::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 14:15:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DU6PEPF0000A7DD.mail.protection.outlook.com (10.167.8.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 14:15:59 +0000
Received: from seliius19819.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 16 Oct 2026 16:15:59 +0200
Received: from seliiuvd10563.seli.gic.ericsson.se
 (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
 by seliius19819.seli.gic.ericsson.se (Postfix) with ESMTP id 534324020B7E;
 Fri, 16 Oct 2026 16:15:58 +0200 (CEST)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
 id A319962858A6; Fri, 16 Oct 2026 16:15:57 +0200 (CEST)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: <dev@dpdk.org>
CC: Stephen Hemminger <stephen@networkplumber.org>, Jakub Grajciar
 <jgrajcia@cisco.com>, <stable@dpdk.org>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>
Subject: [PATCH v3 8/9] net/memif: fix bogus Tx count on invalid interrupt FD
Date: Fri, 16 Oct 2026 16:15:56 +0200
Message-ID: <20261016141557.3081522-9-sriram.yagnaraman@ericsson.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261016141557.3081522-1-sriram.yagnaraman@ericsson.com>
References: <20261016141557.3081522-1-sriram.yagnaraman@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7DD:EE_|AS5PR07MB10572:EE_
X-MS-Office365-Filtering-Correlation-Id: 28c2d942-c63e-4fb5-05a5-08df2b9000cf
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|18002099003|22082099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: xmFn38D2JZOWmaXpI6m6PY8i6QZK5/AjtRBwbrvLqrq072QgeQHsbJ24r+XUJP+lqT9JPHSMh9iGzJLA0oCJ5o+XwNVsl3ta8RC1ArwXlIbVy7yGKK4RGzX9JOoSC0YokUkh97EMCU9QPtxNp/IqcLbiCQw7di+G2sqhWVOam+eLpSu+fGXk5HvfE8iLlmv9Wzj0Bx8YvVw+9J8cb+KPxEXy8Aud/mVjVghNeMteNN/nNQscY9aU/TX+NREdDizVjMNw9BlGeSAvcVwSmB7Eil2+b5UiDq3qfaG6Y3omUO7d2PDx6cj5IcL0qN+b1gfB8zU2y7uA2+CVzBgSOPKtRf02t8kyaM0rWcR8W/an9glNw4GKHLSfJ2qR1gBsDHZWb5m3ev2na1BIxSOCZ9yWGUAQWxH8E4QJyIUqRxwAB43f9rwWiGyECHE7r5S7v+3uw6piL/3jHco/kAVoi0CQqUNAMeev1yVCUQCXAEp2jpLcljJ3qp0AhyaVsxYrmI2u18Fjn1bmHAF4VVHxiAf4vPjLfzGibzVLoRQJPvARZEFYeqPKcsjwhE9KVp8PoymHN5pB39QGrJvC23GeX550cJmfyoUYreZ6ShIkdUw9+fbxyrkIctkPC0SDZ7uC6UxDYEiZbTNrDn3ysHOlPPYKxCxOdj7kky+UtiZdFXSdcmUKEu8EY+5UO3H9KkE+AIJnrQ9kSk+D40KVb//N2UmZSQ==
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(10067099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UnIpHD2pyaw0kF4cBs+9mk85U7XMUxyXqYvRxQE+ucO2tAssZRFf2oWCy9lSx7Fm7l+bY1MqFeE9NakYvzdz4A8o14d653OVTeFHuGBolK6t3yDItc0oavrHvciS0CdwM7PFnvXIx+NYvj4NaOVJhzAmgqGnwYfzPQHFM2pxrlREAmROGVL6HeG5hijgGnnlUQmVrGgdvbaLM+I3eK1XJMgp7BoYCheErmcFNpuEj08n5BI2aZcWuJAc6psURAa5+J4xLgFdJrstm2mz4Muf4fgyb736txrAYMBWpqSohx85Vg7Lae2cM0MbeM8MVo6NWXtG6NFKwvNeC+OiOUx+EsGDZbqRoXHvdOLxP4isMuSWEcMDPaXzwc74mGWgjQRVu2Gw4t/cVKzDANXliT1uxW587VZC/Eqn/fWxU4I1tWt1fYVFlT+/JT4TFGnPziwC
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 14:15:59.7893 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c2d942-c63e-4fb5-05a5-08df2b9000cf
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000A7DD.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR07MB10572
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
index cdf77d77b0..0680dc3947 100644
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

