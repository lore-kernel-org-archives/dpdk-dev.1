Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74826C71131
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 09:59:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4193840661;
	Mon,  9 Jun 2025 11:59:44 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2047.outbound.protection.outlook.com [40.107.96.47])
 by mails.dpdk.org (Postfix) with ESMTP id CA36E40658;
 Mon,  9 Jun 2025 11:59:41 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bnJ9o+Zb6yyLnl/P6VY5LFT3RJU/zyPYqfnM/iiTfjj/Bo0oq9EZgQsmMh3SmGXJfuPL4nJKQd5J8rscdlIHFDTwBWauZAZ/NPTk2T0rOSwOx59LpfbYMYG3xzqxXuYJg+uC24gxzwdqnbflSxgA3aoYz1mqb4QJRiQnTJ4Un99qb96agxvnUQnU7PTrxxCj2I/3XrwYm4WHx+hrw18uN/iv/K+ufzEBfn/gDHpg7tnWUDiPH62xLEU29PyJ+tX+ZUAdMNc+d1T9eq1AzIzDD4T0Y9xs+3KKqT+XFhkuGlaLndTks8+ybN/6SgYG7bIvWU2kjizt/obvow45z97hgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcHbVrLRwt9UAp9DP9+gmaXY0TNSj861Hu9mp8teJzs=;
 b=k8/xpxwjNJmmI11p6xl2pwyAFSWTEUDeSVdVSUeNeI64twm3Nkj7crf4PEGKOv2y9jynK6XCAnvcKgNuYKkxh+UFuCUVphSfSXU/AEt9f+Z/4MnMFNPhY924/3BRkDLjIaYMpvwkOuNB9PGWZuakSdX5MYGpGEKYboxMk7VtX64m6VCnxLd/HGC5sma8tU9jvhtN0sKnZKcjWLW2CTItO0yDe8aPKHAsii66GqugM+yK+CPLiQX73yUiHZncgZRq+HLYjH3UmSu2PuDPojXY3whUs0zhO264W/xlAvdfcsNfDlOQsqftSkRDkgx5FaFkAUiSOy63FHI6wc5hx5TKKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcHbVrLRwt9UAp9DP9+gmaXY0TNSj861Hu9mp8teJzs=;
 b=RfnnBigGEt8rq0u8/U4ylppmlRcwDMsNn1SZAcmO5kfLafPIwZ6V0PJw8d+OZKIiTMJlpQkfeZ1pq7OUN3aR5QGavcJfkdIKhDkNwR0dvC0AXNVe4I9I3cHltERmOiJWIczxhAN1u0c5HO7sWLXHINz2SZLzJjVQbgZeseHjFFo=
Received: from MW3PR05CA0015.namprd05.prod.outlook.com (2603:10b6:303:2b::20)
 by BN7PPF2E18BD747.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6ca) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Mon, 9 Jun
 2025 09:59:35 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:303:2b:cafe::cc) by MW3PR05CA0015.outlook.office365.com
 (2603:10b6:303:2b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.12 via Frontend Transport; Mon,
 9 Jun 2025 09:59:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 09:59:34 +0000
Received: from 7dbylenovo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Jun
 2025 04:59:32 -0500
From: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
To: <david.hunt@intel.com>, <anatoly.burakov@intel.com>, <jerinj@marvell.com>, 
 <radu.nicolau@intel.com>, <gakhil@marvell.com>,
 <cristian.dumitrescu@intel.com>, <Ferruh.Yigit@amd.com>,
 <konstantin.ananyev@huawei.com>, <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, <haijie1@huawei.com>, <stable@dpdk.org>, Venkat Kumar Ande
 <VenkatKumar.Ande@amd.com>, Dengdui Huang <huangdengdui@huawei.com>
Subject: [PATCH v2] examples/l3fwd: adjust Tx burst size based on Rx burst
Date: Mon, 9 Jun 2025 09:58:27 +0000
Message-ID: <20250609095827.4174387-1-sivaprasad.tummala@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212045416.2393001-1-sivaprasad.tummala@amd.com>
References: <20250212045416.2393001-1-sivaprasad.tummala@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|BN7PPF2E18BD747:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c91555e-f711-456d-3c91-08dda73c5661
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|7416014|376014|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CVJD4MNeNi4a1FDba7oZmfHYlfPKIfy/9O3QtfgmWhA8SPYFiIJpVGNfy5gb?=
 =?us-ascii?Q?xF41JdAAIGF5siz+HJ7hZ5/3lnQlWjhJV1k3oJe/Ji0WNXNkeoVHPW4klt7G?=
 =?us-ascii?Q?yOCr4NPA5ISMq2fjvCPAKt9l+Iew88nV5cIxpaNs5QQGak3nzpgsByAjGeZd?=
 =?us-ascii?Q?HJ+JbMOGGpv1b5SalLzcHfP4le86ez8YI5BZOk8/Th+D550gEyZro9RGlnO0?=
 =?us-ascii?Q?FPV81rybPri6hQubGDOhUQ7IheuiwU19LTqDc6tkLUtI4uSfcx7k8zufnMh7?=
 =?us-ascii?Q?DV7ogfyKjdAfDY5a5zwpmHiMnXiS4vp6dOlTEKZtLNBrCBe4bIbQsNzwKgdG?=
 =?us-ascii?Q?DjHN48ZqcWNqqjlMYeq2KqiKXnXTI1xlxy0GSTbk3Hn83MrhfQGbhc3fQ5yi?=
 =?us-ascii?Q?l3G4gRBQKFTQ/5dG5qQ/NRM9tbVqWWFSnbF4HJc+A28W+8N+ZAf1IOvLF0Gv?=
 =?us-ascii?Q?TFM/WnXU8cbIOEYJNfq9heU51Aov4nTf6zChLGJwdRm61Dsy85FtOqyBGXK5?=
 =?us-ascii?Q?vAz10oEvx54IfUcw9awd1v4JUOlPifzZqEVCvuOoBlyrv/KIei93z20yZ8QP?=
 =?us-ascii?Q?r8QFJdheDae45ldDi12IHHLvHoIyHR+PoGmIE7FaAqgg3pDg5fRQMuJLork0?=
 =?us-ascii?Q?okn4Kt/2BISQPDfMqK+bqNJegAnTXBSHFT2PrtsUmUSUPCc1FE0XivJXffX/?=
 =?us-ascii?Q?zJEQK0nH0xi/Ob8c7q+C5pLRA76ctZxD74IkTH3e7EKFu4tx3Vn2Gw2b3qSD?=
 =?us-ascii?Q?RFE8lxqnv4EXaVFWO65Q+oonIonNkXTJBJHMtZ777JqmwCSHm1wb8Yx5Ovxm?=
 =?us-ascii?Q?c4X/gywDrR1L0tU31ay8W7tpyiNFJBIurJK0DdEMDmICYjjn+50TZ9/RjW59?=
 =?us-ascii?Q?kTUee3uRW/h4j43Im9Eno/daUNBkGP5I3p8rXi3UPL5SfquhQ4uwqNcuR93k?=
 =?us-ascii?Q?YwrNJKXRf0rFA1QerCEl+TNkpizpycYrCMdFfx0T40RFpz+czlsigEoiOPps?=
 =?us-ascii?Q?RgwzQfHOQ87bmk2VqxMiwbAfLv+9S1ihsSOQNYVi0EE+uYArk9BsbOIzH2L/?=
 =?us-ascii?Q?UXjXARH96r5bxBLW/y5t/8FPJWjSafTQAu1oiWvyQz+md+6MZo4bn038pHqs?=
 =?us-ascii?Q?EwDhs6yjBhVU1rztaFE0YKZp739Ntvm/BiTyEGDU1L5nU5LoQjHi5IzhmEKX?=
 =?us-ascii?Q?jyVSljVig76p4SlnWV+jcSYhhZlav6pfNFwO6E0JbTVGvyBGU9BO8Kb+NZHE?=
 =?us-ascii?Q?XgEltrUrGp1731udRSCoQjshurgpkAncL0zcETStIy1hbWfRF2M1BOBclBJG?=
 =?us-ascii?Q?e3mqd7Q5c9h0gECJxIXI0X/U/pAKQpkAvEZA4hc5SpLV6yu323LRUoR6/fhr?=
 =?us-ascii?Q?9SWfmN88Ieq6mpHtHkdxPWmfpvCxdT+tsyjAeeo3QnBMqOXqcEweYe8RXSLc?=
 =?us-ascii?Q?+lEeKULwcOnG6NKSZLihW6yNih7dSIpTWK2CUY3ZWUV4AdnLA9KmZw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 09:59:34.4289 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c91555e-f711-456d-3c91-08dda73c5661
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF2E18BD747
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

Previously, the TX burst size was fixed at 256, leading to performance
degradation in certain scenarios.

This patch introduces logic to set the TX burst size to match the
configured RX burst size (--burst option, default 32, max 512)
for better efficiency.

Fixes: d5c4897ecfb2 ("examples/l3fwd: add option to set Rx burst size")
Cc: haijie1@huawei.com
Cc: stable@dpdk.org

Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Tested-by: Venkat Kumar Ande <VenkatKumar.Ande@amd.com>
Tested-by: Dengdui Huang <huangdengdui@huawei.com>
---
 examples/l3fwd/l3fwd.h        |  8 ++------
 examples/l3fwd/l3fwd_common.h | 11 +++++++----
 examples/l3fwd/main.c         |  2 ++
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/examples/l3fwd/l3fwd.h b/examples/l3fwd/l3fwd.h
index 0cce3406ee..bbc54bcfae 100644
--- a/examples/l3fwd/l3fwd.h
+++ b/examples/l3fwd/l3fwd.h
@@ -32,10 +32,6 @@
 
 #define VECTOR_SIZE_DEFAULT   MAX_PKT_BURST
 #define VECTOR_TMO_NS_DEFAULT 1E6 /* 1ms */
-/*
- * Try to avoid TX buffering if we have at least MAX_TX_BURST packets to send.
- */
-#define	MAX_TX_BURST	  (MAX_PKT_BURST / 2)
 
 #define NB_SOCKETS        8
 
@@ -152,8 +148,8 @@ send_single_packet(struct lcore_conf *qconf,
 	len++;
 
 	/* enough pkts to be sent */
-	if (unlikely(len == MAX_PKT_BURST)) {
-		send_burst(qconf, MAX_PKT_BURST, port);
+	if (unlikely(len == nb_pkt_per_burst)) {
+		send_burst(qconf, nb_pkt_per_burst, port);
 		len = 0;
 	}
 
diff --git a/examples/l3fwd/l3fwd_common.h b/examples/l3fwd/l3fwd_common.h
index d94e5f1357..6cb7de5144 100644
--- a/examples/l3fwd/l3fwd_common.h
+++ b/examples/l3fwd/l3fwd_common.h
@@ -25,6 +25,9 @@
  */
 #define SENDM_PORT_OVERHEAD(x) (x)
 
+extern uint32_t nb_pkt_per_burst;
+extern uint32_t max_tx_burst;
+
 /*
  * From http://www.rfc-editor.org/rfc/rfc1812.txt section 5.2.2:
  * - The IP version number must be 4.
@@ -71,7 +74,7 @@ send_packetsx4(struct lcore_conf *qconf, uint16_t port, struct rte_mbuf *m[],
 	 * If TX buffer for that queue is empty, and we have enough packets,
 	 * then send them straightway.
 	 */
-	if (num >= MAX_TX_BURST && len == 0) {
+	if (num >= max_tx_burst && len == 0) {
 		n = rte_eth_tx_burst(port, qconf->tx_queue_id[port], m, num);
 		if (unlikely(n < num)) {
 			do {
@@ -86,7 +89,7 @@ send_packetsx4(struct lcore_conf *qconf, uint16_t port, struct rte_mbuf *m[],
 	 */
 
 	n = len + num;
-	n = (n > MAX_PKT_BURST) ? MAX_PKT_BURST - len : num;
+	n = (n > nb_pkt_per_burst) ? nb_pkt_per_burst - len : num;
 
 	j = 0;
 	switch (n % FWDSTEP) {
@@ -112,9 +115,9 @@ send_packetsx4(struct lcore_conf *qconf, uint16_t port, struct rte_mbuf *m[],
 	len += n;
 
 	/* enough pkts to be sent */
-	if (unlikely(len == MAX_PKT_BURST)) {
+	if (unlikely(len == nb_pkt_per_burst)) {
 
-		send_burst(qconf, MAX_PKT_BURST, port);
+		send_burst(qconf, nb_pkt_per_burst, port);
 
 		/* copy rest of the packets into the TX buffer. */
 		len = num - n;
diff --git a/examples/l3fwd/main.c b/examples/l3fwd/main.c
index ae3b4f6439..8353e8e16f 100644
--- a/examples/l3fwd/main.c
+++ b/examples/l3fwd/main.c
@@ -59,6 +59,7 @@ uint16_t nb_rxd = RX_DESC_DEFAULT;
 uint16_t nb_txd = TX_DESC_DEFAULT;
 uint32_t nb_pkt_per_burst = DEFAULT_PKT_BURST;
 uint32_t mb_mempool_cache_size = MEMPOOL_CACHE_SIZE;
+uint32_t max_tx_burst = DEFAULT_PKT_BURST / 2;
 
 /**< Ports set in promiscuous mode off by default. */
 static int promiscuous_on;
@@ -734,6 +735,7 @@ parse_pkt_burst(const char *optarg)
 		return;
 	}
 	nb_pkt_per_burst = burst_size;
+	max_tx_burst = burst_size / 2;
 	RTE_LOG(INFO, L3FWD, "Using PMD-provided burst value %d\n", burst_size);
 }
 
-- 
2.34.1

