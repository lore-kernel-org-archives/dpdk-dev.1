Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BE7CCF2C4
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 19:59:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF3AB40695;
	Fri, 16 Oct 2026 21:59:07 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013018.outbound.protection.outlook.com
 [40.107.162.18])
 by mails.dpdk.org (Postfix) with ESMTP id 42B404026C;
 Fri, 16 Oct 2026 21:59:03 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sE/4Jq4Ec8WN3jaF+hp4yC+RBlfkNGDmR6CVAQm8/8n5sP+p8tiBYL6lHt5z/QWeex5GMNrPxqIzL3jS8fEUZuHGjIBNnWfA4udkmgmdKYmQ1n8r7t0LWTnhO0+DMiHYxp+4B1j6gCWcojNog2g/5BUYXehQUkDI5LWcVIhJh7iqcXvO8K9ccCHOT8Qn+YJnLPxBA9M590xZxeHqSLYdCp2zuyZL035EvPntsWTYvFwbq5ViBODQW1Ww7leQiRVuUvpqXOBbG2nqfloXw430OeTRMCFxatOpXU/XhNTMTN+9o+DpqwGYJPXMx10veAfcfuXyZ6BRlu/vKPpOKON2Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtmj5rmFr7SlV3MngwmYHEAXdnP6wosWgiWgVMcbLS8=;
 b=e7bBJBhfRMJmqwBldcZPGsfzb6WUYlyPLO9/gCvs4REAG8DZ2Cs//HHPpRvlm88oGz0KlVuJCMb+91ojCaEsCrvWZw7bjEEKFHESBRSaGrgrPzcQrINVUERC0ZWeRuZExEwMLgH+foG1Q7HDe4oxywHMGQro1gBMeIPQQXUoppph+MUVvkxO7PZ+kQY7EIyZ+ExyHTWMBZcD5XFAP2GQjXkwBAevDis1BU5vXUPkhMKlhPlNAK6v7EB7fJnbCJnnbojf4rOJv40giZb5XYOVQy+mBQepkrlwqY3mljtNjenbUuwRxIm2s8fuQJmIRbLZ/YrYy4+6h4Mx0/izAgMiyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=cisco.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtmj5rmFr7SlV3MngwmYHEAXdnP6wosWgiWgVMcbLS8=;
 b=GZUQDnhxrLXpPQC3aCA/IPTESt7bZQGshaQZWUTzmaAK6n1BqrLQUgzZVOJGhZZe2KwHhdG+p2mrhSnC290jL9DxtFUtLTaUZHUcujpa1Ftztwqiwng6M8Xq3gPjSXdDep55e41RaJuZN7p1mXGNGEPp6ilneb102j+aj0cCZJe4eN1g4L5itelkXolIVFN0iIuKXE7P0/kERTzE3g6E1bI43ye7SnFBh1jqhCn/E8P40Gbc0edO30KlVrfGcbeD3cyH/aJYzg0wkg6wIok7gwTMBRzc11l6UG20aZMUPl6OTT8fOhk1nvVjxZ59ZCLzPOw+PlQvsb3a5ZaLUCwF/Q==
Received: from DUZPR01CA0186.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::15) by DU0PR07MB8570.eurprd07.prod.outlook.com
 (2603:10a6:10:321::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Fri, 16 Oct
 2026 19:59:01 +0000
Received: from DB1PEPF000509F1.eurprd03.prod.outlook.com
 (2603:10a6:10:4b3:cafe::1e) by DUZPR01CA0186.outlook.office365.com
 (2603:10a6:10:4b3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.21 via Frontend Transport; Fri,
 16 Oct 2026 19:59:01 +0000
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
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 19:59:01 +0000
Received: from seliius19819.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 16 Oct 2026 21:58:59 +0200
Received: from seliiuvd10563.seli.gic.ericsson.se
 (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
 by seliius19819.seli.gic.ericsson.se (Postfix) with ESMTP id 996014020B7E;
 Fri, 16 Oct 2026 21:58:58 +0200 (CEST)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
 id D964A62858A3; Fri, 16 Oct 2026 21:58:57 +0200 (CEST)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: <dev@dpdk.org>
CC: Stephen Hemminger <stephen@networkplumber.org>, Jakub Grajciar
 <jgrajcia@cisco.com>, <stable@dpdk.org>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>
Subject: [PATCH v4 8/9] net/memif: fix bogus Tx count on invalid interrupt FD
Date: Fri, 16 Oct 2026 21:58:56 +0200
Message-ID: <20261016195857.3258796-9-sriram.yagnaraman@ericsson.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261016195857.3258796-1-sriram.yagnaraman@ericsson.com>
References: <20261016195857.3258796-1-sriram.yagnaraman@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F1:EE_|DU0PR07MB8570:EE_
X-MS-Office365-Filtering-Correlation-Id: 46711c70-52b2-4750-ad6c-08df2bbfec45
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ZaeUZRIAe6Hnfum98aSJgq+zhikECVkNuAwrphV430sUXt7h+r9a+xXggO0FOF/OHEf/ghW1vnqdV2f5HpE1fT9hvQ7x7ryjfTaEGPusBoH4P+rr6FITyRpL0+T6anZhZXQ2xvGJW+hZzZJ9zWmMV9nxqNgI6IhaPVw3mizMk5no6xDLnyj5nuv29CzbyPzu+7LFiP1Gv0wCPSpo3Si6X7kITwENLH4DOn1Xk29OLKr0KJnj/FQu8Xo2F6Q4hSwd2BHhMo1eJR0/sjrB5MTdNSKcl4+0Yoje2y186VPoedQMWTZYe38aSU/Ww7YDrUD8oe+5+9Y5tK5xY3qB3xzicJd0LkGu6cnQ+EtHxlDJakuabe36ny+gX07P7xNfy6YIFbmRSHXEIyCfV3vw3/DCvvBK5IaqmNnN0MLgjDsoNoivxVBjJx666vaADUernkCL4ejRtKlTRB7rtLUMetEYBko0B8TYu3fRUHS1ZPcs5t2fmm52VFV2ANrOOyQRAK76q8w6AD8xRLGuQlOs+DJytfCKyq/apKljq0SURmJiCMoMicPEXVTRDVvXGntG5XcuUQ9pfCIXYi9lbz8jyMPdL5gvKRaSq0wqz2bHfUUakHxHjwwxtts+MbubPHcVwtnKNjrg/bTKLMNB3AXxsyzq+qOwbCRr409FcpQqIPPalQjFqgZR6moqw/VU19A76PjWi1yHXou5zsFGywnE9Mwbpw==
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eJ9tF1PFDPWm1ei6OovF/VrjMxHzDVLGFJ7ffgHb4VaFNZJCAfEWsXvywQt1/9xa1C5TC5/9GRZ7+WCPqBeXOSePx/WBk7TOODJv7dXBtHpexKWX1dE183MUFM4HJs5iazrpAesl7NkIw7FLQTU7VuP4TWwnnQyrkBVrIXAEEzKxk7ZG0LkOzaCty4T6hfsi/9bbI46WThKdLEHi3EkMn5kjnAnBqaLaMqwovgeLi0OOCuhx5EmMogKcQ784icAhp1l72fD6Fur2sjTbOwdTVh610Fehp9QsXxBNDqLWjX84wmyuPJ5Ajf6l07onG6ggkHMrXigArPxAjjCnqdl2Btm+5+8N7EbYxZ1KQA4OBBq3kW5nXgnpa6tO/X0JlW5ZB6ZpJfAVLtzRr1adh0hysEsPb543mRbRDSQhv0nrbj72tmnVeMobr8Ple+UcF/j+
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 19:59:01.1812 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46711c70-52b2-4750-ad6c-08df2bbfec45
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB8570
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

