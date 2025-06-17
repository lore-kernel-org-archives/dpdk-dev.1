Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC7BC71136
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 15:54:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B742242670;
	Tue, 17 Jun 2025 17:54:36 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
 by mails.dpdk.org (Postfix) with ESMTP id E8245402C5
 for <dev@dpdk.org>; Tue, 17 Jun 2025 17:54:34 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hDB3sHt4yfUAXSUYnm+wo7b4BJXb2lyrfRl5Ceii8OtP/vjTGNCgzDX8dFZ+cIfKJRo6TzJAxYE3QUY1A2UH5Rv3swOncbVWDtR8PTrcyA8hp4Emkn2qybtn0Kwu/ElPWFLt6G4IgsRPr3k5naeZQjYTn6c/PNR034dJOtp3qlEoCg3J//YQ8jhZR2NH1FcYvVo6nN95kUOsyb0UUiMItwZM0wtHTxqh+FJFOJpbjSes/IqwECZVsq8i2BGLrX2rUp8eiq0auEzq8UcBTv0p2Avyjzp5lW21CIYykyWcZUpHKAyR+pLVsDIPm3kQm/IorJSHiFxW2vMzvBdaavYo9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTMpXwFHACCQ/OGUS6xweiQn3F6b7h9OXtxGK4Nd4Jo=;
 b=xywGjNP+KRzjdnOoxoY4NLN+36pli3XqDc8LDrux3P9gwYWYf47UMVPbWRWqCfSzvFX+03HIpct/eJjhHjtj0cYiXOVe7qTjDFbFglO7LFxF0qrH21CxGvzRYGBvAkKSMqKlHjWSjyl4uIQ+lNfCoHD8ZsdpZw4AWDJZs4GmOMphu7WOUiIjV34JLPCWAGzGT04yEmMo0TGQ6iy6+CGYGFWqGj69o/YhBSkT6mog/IPYztmfqUU/BNeHPcXRZrsFBjWC2iL3kPwAkfkxXyIWK+3p9hdGLIuBstZ+Y1u+SZAWWQCzcNkYY3djcs73I6rQNg7OGYdKkxOa5GGZNeC1/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTMpXwFHACCQ/OGUS6xweiQn3F6b7h9OXtxGK4Nd4Jo=;
 b=jv6EUiYai87i4Cb38w+M6w/7x8xgjc6CkOjsqXfAuv3tp2dEm6k9hUUP9J7pcHGVsq/QdpQJHAjNA2zzaG63d1a1A60IpIXsBhN2dJd2E05OFdcIES7PGiY87a1RAXKRyr5uXuyOokVOWPdUr99666S7ZcOMUa7ZgCikio7/u7DEfMBLBqjICc5rqeQ/uHneCJ+g4scCkXQwxY+vt79RKZsByT4x45FuYdT6ayY2w3GF4brwdyhS3JL7Sr/tUO0G9uUlti49gxPWoJZKJHKrqTG6a34D9Rz305V5DAX3wW1nlitD7Z9cuuNvH6YTXkpu/PFZWajoCw1u+6inavch+Q==
Received: from SJ0P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::34)
 by MW6PR12MB8960.namprd12.prod.outlook.com (2603:10b6:303:23e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 15:54:30 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::58) by SJ0P220CA0003.outlook.office365.com
 (2603:10b6:a03:41b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Tue,
 17 Jun 2025 15:54:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 15:54:29 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 17 Jun
 2025 08:54:12 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 17 Jun
 2025 08:54:12 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 17 Jun 2025 08:54:09 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <dsosnowski@nvidia.com>, <rasland@nvidia.com>,
 "Aman Singh" <aman.deep.singh@intel.com>, Thomas Monjalon
 <thomas@monjalon.net>, Ferruh Yigit <ferruh.yigit@amd.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, Reshma Pattan <reshma.pattan@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] app/testpmd: cross NUMA support
Date: Tue, 17 Jun 2025 18:53:50 +0300
Message-ID: <20250617155351.190622-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|MW6PR12MB8960:EE_
X-MS-Office365-Filtering-Correlation-Id: bdae3992-f3b1-4637-e42e-08ddadb73eb5
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WAxYVgPUPjPaPA9No1fkTwOWOS13Z9XoRiLosXVHnjqstQKEuphhm66r4Gee?=
 =?us-ascii?Q?4a5cKZmpqQxjm92NTxBkyXoO7O9EgOHKqGg672ipBRNLLVzOjaN8rf6tXWCP?=
 =?us-ascii?Q?iPDE/7j+uyovYgFNKuZS+JshMaBvf7mz675oBePAr+PP72fD3TwtsRGdLn4Z?=
 =?us-ascii?Q?xkLEgNq/ZR3P0W5qMW0n6+UgFVBEJthaKV/jtjIBHGwq31ym4PGvFZk8lge+?=
 =?us-ascii?Q?1uAkukRTrRz9Uj3KxSI2EbUgHx1fEruxFsMBJZP5MKK1i19gD432UquRBvYi?=
 =?us-ascii?Q?o8riEHnhBLe5+Ia+te5PZhmLCqmWgBT9ANNVFnNahlqJR8fTL2plFsBaLFqs?=
 =?us-ascii?Q?dmPxC80FGIMl1VJitfxoOOGGPd5vscVJp6yJ+XchHJ24Yyfjr5zHYecqkcKc?=
 =?us-ascii?Q?wxFKBCBkDSOvgR486oqNkPsO5gLxqxYW995BI9549gxqsLQPT5jY01y2yiFi?=
 =?us-ascii?Q?ldBnF89etlKVix5w9TipIWoTQpTR1NkIXajcpYtp0OX8Wm8ztRmfz/J94hQn?=
 =?us-ascii?Q?E58zY/xQSjvO0uU2DIddHGf5oqdDBHb04YNcyE+vE34GL5zvwkqV8GZ9loLL?=
 =?us-ascii?Q?uA6K3zKPexwxkHbCEQGXSUF5rYojHyzv6Q9yidGwoYU4kyxSzkQYqB5pOJTq?=
 =?us-ascii?Q?KlAYooGqpZfMrOEMqU+H9gNKQjw7m3DKI46BN3F6SVUqF5ijlOPkh6DVq7b5?=
 =?us-ascii?Q?NumEL43IuPf+ERg9hf7BRzLB5T8O76VR2UYUCXwe2o1decmh4DB7knrjbNOW?=
 =?us-ascii?Q?b/Vw1GDxmz8lB2EfgokpYyglNHw/5X4t/QQgU+tZ8IJ32CYWs/AVpkxo+RRp?=
 =?us-ascii?Q?8hYSLmkIji9E8snOyUjOJTu0JsJO740BgnvXtKPC5V64UUTZBQW/jsfNGeoV?=
 =?us-ascii?Q?2UaeS3ShlcMoahuGcAc15VH6mo0C7qUELzi0nVnZeGVXse9iHLAhyAdgkLb/?=
 =?us-ascii?Q?mPUR+E5yfWzqndocbTkumb73umLSD7ZRmeuraNGXxHUuCt161teKLMWQH64v?=
 =?us-ascii?Q?/tsLAyAqJXtLXcT6VJvayQ9ZoVqZ1I8Ym3skiuhEyQ36HPFB03FxZrAhoScu?=
 =?us-ascii?Q?eROZOOfVihcaj+5y0Wm5RgJASImFlMk1p6bI+dvBqGKJ6vxPUkKWCAeIlPb1?=
 =?us-ascii?Q?+MR1QuLbAlo5yxNK8FOAtz3Qt0RuES3GVxIsC3RLf7aM2Be+68AIQdWKmu3L?=
 =?us-ascii?Q?lykS4KT421PeaLDtddD5z2JsRYketco+YBexHZYve/gKnCTXCbyTekXKoLqy?=
 =?us-ascii?Q?no/8ZUSe+qfv9F3VIbiQsEAbhdAK33OP7jV3LANReSCmhQcYJnQP/m/AVM5u?=
 =?us-ascii?Q?b23HVSbEBAlSwpCMMx9GIGWtil/VckOQCJMixJug5QfkW1YinUdib6RNx1H+?=
 =?us-ascii?Q?7C7wsZspWJuh85fcA2Aj7M4idGNfH9jaIY2tfCHRvYLHNvHK0KcKvd7piKGx?=
 =?us-ascii?Q?0TGVWpGGLhvmv2ops1+MuXDoorSgP+enzBAdXbcXl01pVt3MzMs9nqoRCsV7?=
 =?us-ascii?Q?JCI9aAyctLTq0iCOVKfI+Cmki0B/cRS+ypPt?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 15:54:29.7904 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdae3992-f3b1-4637-e42e-08ddadb73eb5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8960
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

Cross NUMA support means that
if the current NUMA is out of memory,
 use another available NUMA memory.

Replace socket id specific initializations
with SOCKET_ID_ANY needed for testpmd
init when --no-numa flag is set.

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
---
 app/test-pmd/testpmd.c      | 8 ++++----
 lib/ethdev/ethdev_private.c | 2 +-
 lib/pdump/rte_pdump.c       | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index b00c93c4536..66ebdee6978 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -1729,8 +1729,7 @@ init_config(void)
 			mempools[i] = mbuf_pool_create
 					(mbuf_data_size[i],
 					 nb_mbuf_per_pool,
-					 socket_num == UMA_NO_CONFIG ?
-					 0 : socket_num, i);
+					 SOCKET_ID_ANY, i);
 	}
 
 	init_port_config();
@@ -3058,7 +3057,8 @@ start_port(portid_t pid)
 				} else {
 					struct rte_mempool *mp =
 						mbuf_pool_find
-							(port->socket_id, 0);
+							((numa_support ? port->socket_id :
+							(unsigned int)SOCKET_ID_ANY), 0);
 					if (mp == NULL) {
 						fprintf(stderr,
 							"Failed to setup RX queue: No mempool allocation on the socket %d\n",
@@ -4484,7 +4484,7 @@ main(int argc, char** argv)
 
 #ifdef RTE_LIB_METRICS
 	/* Init metrics library */
-	rte_metrics_init(rte_socket_id());
+	rte_metrics_init(SOCKET_ID_ANY);
 #endif
 
 #ifdef RTE_LIB_LATENCYSTATS
diff --git a/lib/ethdev/ethdev_private.c b/lib/ethdev/ethdev_private.c
index b96d992ea12..285d377d91f 100644
--- a/lib/ethdev/ethdev_private.c
+++ b/lib/ethdev/ethdev_private.c
@@ -343,7 +343,7 @@ eth_dev_shared_data_prepare(void)
 		/* Allocate port data and ownership shared memory. */
 		mz = rte_memzone_reserve(MZ_RTE_ETH_DEV_DATA,
 				sizeof(*eth_dev_shared_data),
-				rte_socket_id(), flags);
+				SOCKET_ID_ANY, flags);
 		if (mz == NULL) {
 			RTE_ETHDEV_LOG_LINE(ERR, "Cannot allocate ethdev shared data");
 			goto out;
diff --git a/lib/pdump/rte_pdump.c b/lib/pdump/rte_pdump.c
index 79b20ce59b2..ba75b828f2e 100644
--- a/lib/pdump/rte_pdump.c
+++ b/lib/pdump/rte_pdump.c
@@ -426,7 +426,7 @@ rte_pdump_init(void)
 	int ret;
 
 	mz = rte_memzone_reserve(MZ_RTE_PDUMP_STATS, sizeof(*pdump_stats),
-				 rte_socket_id(), 0);
+				 SOCKET_ID_ANY, 0);
 	if (mz == NULL) {
 		PDUMP_LOG_LINE(ERR, "cannot allocate pdump statistics");
 		rte_errno = ENOMEM;
-- 
2.21.0

