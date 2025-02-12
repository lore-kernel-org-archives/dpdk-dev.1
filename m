Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1649BC02198
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 04:54:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD386410F6;
	Wed, 12 Feb 2025 05:54:44 +0100 (CET)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
 by mails.dpdk.org (Postfix) with ESMTP id 53375402A7;
 Wed, 12 Feb 2025 05:54:42 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s3HT9TQXHs8+X+BmFKK/KCGEy+FJlk9edu5Kav4/CZh7ZDgikXKxc5EKM9zwRMQthPt+hlcnyeSbKTjUKM+2uXRZadB4HQskYWbdDJH3vrotRpOC1068HXbnYvr4F15tNaduV7g6glJxRT5yj5zyHMYWo+/sQD588ynXG/OUXoT1EHJy4cK82sU4CJYkv88dV2t+ZKAGiEt4Hp803KkHTyKDWN6EBPvRovYBG/u0uHwP7W6gGom6SiIByE2/acBO2bcOoqOBM0PdX7eLwRl3vaH2tQnEZb9IY6XjFL4GQ0Xxx+AZgau+rACr9B0pEXF/kmhFQ1Czyv1Zh2jzPsmIsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wA5wQBHRIvyEOJp6KSFcDFZR2hvsNeeDBKqHZqSIfqQ=;
 b=LwwuWWUBhmT2zthQPAcLXj8aRc6SMfj1BW1jMwHcel2T4QzuEJb7QGetmI9XWBHpRkLWsLm+BzXUehMIEWQNeBINXuvYTi6D/zGIDlWLVh8AXGRAAIyQliWnwCUYUojWUQA4ZZbYZLfPJOw38RRHDNj7ZXS0myUIsOKccQjJLrzKmzy9RtZPH02Jkc3y3jSt7mcEdn9E+zS7y4GFfSB+dp0pF9qrbVtuKLGbp34WiKtG2FCkb1NE26T9pvi6dPpxZG9oBExrSV+CXFa1Xu+XSW6cGDgckW9tv3csXGbF7dzOOY4jh82P0iiujaF1qltA84KYVpLJsAhchCGRZ+OEqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wA5wQBHRIvyEOJp6KSFcDFZR2hvsNeeDBKqHZqSIfqQ=;
 b=IGK01FVhBS0EVzViqqv/ut6TDXmC3f69Q3ApMCAVEsxDFFALDOT/GfymzDYQiWpUacbCTx5DXuVJwH3AUxnP1bJQMqdzf846HN5C3LEOVNO76azdHQzGp7KZNuUHep9spYWbvXAQvrmNEQA4LN3ezEzc1kutCK6U5PO8f8dKoWU=
Received: from SA1P222CA0171.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::8)
 by MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 12 Feb
 2025 04:54:39 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:3c3:cafe::44) by SA1P222CA0171.outlook.office365.com
 (2603:10b6:806:3c3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.12 via Frontend Transport; Wed,
 12 Feb 2025 04:54:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Wed, 12 Feb 2025 04:54:38 +0000
Received: from jfw9ny3-os.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 22:54:34 -0600
From: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
To: <david.hunt@intel.com>, <anatoly.burakov@intel.com>, <jerinj@marvell.com>, 
 <radu.nicolau@intel.com>, <gakhil@marvell.com>,
 <cristian.dumitrescu@intel.com>, <ferruh.yigit@amd.com>,
 <konstantin.ananyev@huawei.com>, <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, <haijie1@huawei.com>, <stable@dpdk.org>
Subject: [PATCH] examples/l3fwd: adjust Tx burst size based on Rx burst
Date: Wed, 12 Feb 2025 04:54:16 +0000
Message-ID: <20250212045416.2393001-1-sivaprasad.tummala@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|MN2PR12MB4333:EE_
X-MS-Office365-Filtering-Correlation-Id: 8121ae82-f9e0-4f31-be1c-08dd4b215acf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|36860700013|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jH37kC5nExej3imqwmn79/CVL2cB65iZIVkjVhe5r/XD+hCHZUIcmA8FHl1K?=
 =?us-ascii?Q?/3hGj00OBfn9nXzW8pwYx3WJnvZ33nmz4YBAbDCPCf5E1gIG8Ldf+cU94MNY?=
 =?us-ascii?Q?MAiVvSvx6e+b8HONmp1Eeni3v099yFs5rOHQvNjIOehXgVZH0wyhmNmLiRFl?=
 =?us-ascii?Q?rcN2gUHfObe4bI2lAERrwBNn3rPbUDX2bSjuRt1WTUOXnpR/glFRQ1tvoKE2?=
 =?us-ascii?Q?yFbBTokAu98cpS85fa28wI3nXPkooTVnM5pAUfbXbqwDvbO9biqe+h0/1gYm?=
 =?us-ascii?Q?duNnadv1c0Q1XBObMX09a0e1pfuUPDs1EL0spfjmD70IC4cbZGbjZ+yclvpt?=
 =?us-ascii?Q?eQPsjzeJVNuPMWXV8TlChEKLW5lMkJ9MKQ1nNPQiaKmTcrnfOktg/3l6l25a?=
 =?us-ascii?Q?svticSrWwgxuKO4Kha6gwXuGn2Xf3g5wxB9WrBzQyrN0TRa6dAmQsqrYTV5R?=
 =?us-ascii?Q?1eA1z6QF4Pvu9xCY6Fg1tw8Seo4Ee9bxmTiksjxSnqmjFvAQ8brRHbg2vL6z?=
 =?us-ascii?Q?byY0sOdAT6OSs327Tx9fvWK+ltJRKWoXpCN6lCqSMZW59rs/kRPh5sxn/XX6?=
 =?us-ascii?Q?Q0lp+VnNVtXr1hdRgSTcK7JBc3J1mTS8BbddGVYLvhcVlM8GDfbV1ATKucWB?=
 =?us-ascii?Q?g3PXe86zYJ9yo+h2/6sD9V2/8B7cqOoQpeKhRiyyTCQel/5torQjOIuiI4d1?=
 =?us-ascii?Q?B6CXQdm6iDdmqtHZP4PtiWzuMtI/8Yo6H5XOl97B6G7AiWLsM/y8Fd4TxD5R?=
 =?us-ascii?Q?wBcwFsMR7QLYDy1fZWUEUFlkeMtMWTas895Iot3FFVajmdk1xW6P+oFlb/03?=
 =?us-ascii?Q?zouA2A1Hgebzax6gUt2J4hsLSpuVTCdOt6orZQk+6HSGlhfPFSDIcKew6xk2?=
 =?us-ascii?Q?J7/txTFLbIk/uYegpKRtQ+IcYOdVk54BFB8PLY+XCyLm3B8r17vmFlDIANPF?=
 =?us-ascii?Q?YqWcwNm6qMm9kqSx8Ba3vSXpxAzcVOmXHBSnv5eRSjbCBGcAg5Aall+obCHl?=
 =?us-ascii?Q?WJXalDe26Bs7ZQUs6yBYYwbGFVAOAORROteQULz2NejCdTkQnjWks0QJ0/Of?=
 =?us-ascii?Q?WaIdTov/e6qxxEdl+w9ZELXsOZysNqEuUGrZ2YaHDOM2AIVEemYITnRaUK1+?=
 =?us-ascii?Q?SUaXjfjAeJL0ChTZg6IUMivf6dEDdCLWKAvXnyT2R3oz/0kfdNUClAnrZ8+H?=
 =?us-ascii?Q?T5cr6tQn/YbvS6n9oBErxEHgwFFDckfuLfFHFeVsOQV0me1lMQEi8JS7KErR?=
 =?us-ascii?Q?gyIfl+vDxXXE/P+yyDiOWPbhFOzaGKgNf/Udp82FfBMZN+x8uMrZq4Coy0HS?=
 =?us-ascii?Q?0NZm8VjhERW7cIkUBb4qZasgTtVpyh7TpT+ni9EZhdQN2RrptQhNkNiY2Eyy?=
 =?us-ascii?Q?f7o5WCT3JZ1tdyHE+BzbIT6jPtVkz/deKbWcScS1mci+TaKUw6pAblASK2pD?=
 =?us-ascii?Q?sAvJec+ehnY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 04:54:38.5108 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8121ae82-f9e0-4f31-be1c-08dd4b215acf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4333
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
---
 examples/l3fwd/l3fwd.h        |  6 +++---
 examples/l3fwd/l3fwd_common.h | 11 +++++++----
 examples/l3fwd/main.c         |  2 ++
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/examples/l3fwd/l3fwd.h b/examples/l3fwd/l3fwd.h
index 0cce3406ee..9d7c73504b 100644
--- a/examples/l3fwd/l3fwd.h
+++ b/examples/l3fwd/l3fwd.h
@@ -35,7 +35,7 @@
 /*
  * Try to avoid TX buffering if we have at least MAX_TX_BURST packets to send.
  */
-#define	MAX_TX_BURST	  (MAX_PKT_BURST / 2)
+#define	MAX_TX_BURST	  (DEFAULT_PKT_BURST / 2)
 
 #define NB_SOCKETS        8
 
@@ -152,8 +152,8 @@ send_single_packet(struct lcore_conf *qconf,
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
index 994b7dd8e5..4cabd05be2 100644
--- a/examples/l3fwd/main.c
+++ b/examples/l3fwd/main.c
@@ -59,6 +59,7 @@ uint16_t nb_rxd = RX_DESC_DEFAULT;
 uint16_t nb_txd = TX_DESC_DEFAULT;
 uint32_t nb_pkt_per_burst = DEFAULT_PKT_BURST;
 uint32_t mb_mempool_cache_size = MEMPOOL_CACHE_SIZE;
+uint32_t max_tx_burst = MAX_TX_BURST;
 
 /**< Ports set in promiscuous mode off by default. */
 static int promiscuous_on;
@@ -733,6 +734,7 @@ parse_pkt_burst(const char *optarg)
 		return;
 	}
 	nb_pkt_per_burst = burst_size;
+	max_tx_burst = burst_size / 2;
 	RTE_LOG(INFO, L3FWD, "Using PMD-provided burst value %d\n", burst_size);
 }
 
-- 
2.34.1

