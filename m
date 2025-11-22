Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64ADACFC539
	for <dpdk-dev@archiver.kernel.org>; Sat, 22 Nov 2025 15:52:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A45840269;
	Sat, 22 Nov 2025 16:52:19 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013015.outbound.protection.outlook.com
 [40.93.196.15]) by mails.dpdk.org (Postfix) with ESMTP id 07774400EF;
 Sat, 22 Nov 2025 16:52:16 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2xGLq3yBekvzUx3OadjL6fI6e6l9ax+eor0QSuJXBtF8tKupQVvo7ue/RcU48dx0IDtNVSzeUjwscMo9Ic5FDdEsaoLgsns8akh0uIJU5ScDlyTUY3PKx9Zuzs1/pjOLcmtBjwF/t7MyZHzqyUdLNh9cLBxbqTA2TVXvyna2OMHuSicAVTMJy2QfuLleersOSeETf+L4NJhcBNXKpa+M/ddsQUx7jIkZYkhW2v3l/i9043Z5bQrwa9J+91QGB2LLx3MtJb4lzej2DFiEeGbWwogySnWbN+f62CqHgc/a6U1/GBl/LGBGBgciSIkvUXFaNj4NF5bec3quHSe9xI+2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hed4aDdeVs5VKi1hdwJD9lWD7itdjpCl+Clyglpw1X4=;
 b=YkKyHDs0xAftfHaIEte0qEvwVKL9Y0tkm3Mf3++NP91KK4d4S2zuhkWDNm42X4Sm2z8aFGrtkoecav/I7d5WS94GJSYyMB6+SsGaQRFd18QEgetUZbmqAeFw+JR9Pko+r9S8R4ouFozYdUWaD3424glLYQYP+hBpD7+mItkARxc0vBGJxuVqZlsu3G+fFeLKT0/WNYpe8wRRA16Zn5LP1nrQ9iVqA9/miIgTCy4TGQD82KMInx8xsBPy/upV1qfj+A6qJ2LAvwsKzKGSYMwtIYiOkeqho3tK11St4+QGkB9G1K+UWW9P+rr8bfrACpAKsi7hdjyX/VJk+NAnATYL5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=monjalon.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hed4aDdeVs5VKi1hdwJD9lWD7itdjpCl+Clyglpw1X4=;
 b=v3dTopBfGDUHLU5hJUwHx8lUM63kjXZVuXKNlgpGAet8Qv+LTFx2RPweUD1mhKjN1mTA2ovgWmmytftRZL3B66/x/WLUB4P/c9KgKXR2wxIYICcrDq6P2Q/dL48O+QxIE3FUzX/JccYV1b3j0cdqpF2oxaptI39xHgeoMvUlxsk=
Received: from BYAPR08CA0023.namprd08.prod.outlook.com (2603:10b6:a03:100::36)
 by PH8PR12MB7159.namprd12.prod.outlook.com (2603:10b6:510:229::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.19; Sat, 22 Nov
 2025 15:52:14 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:a03:100:cafe::9d) by BYAPR08CA0023.outlook.office365.com
 (2603:10b6:a03:100::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.15 via Frontend Transport; Sat,
 22 Nov 2025 15:52:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.0 via Frontend Transport; Sat, 22 Nov 2025 15:52:13 +0000
Received: from epycpwr02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 22 Nov
 2025 09:52:09 -0600
From: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
To: <thomas@monjalon.net>, Konstantin Ananyev <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>, <ndabilpuram@marvell.com>, <stable@dpdk.org>
Subject: [PATCH v2 3/5] examples/ip_fragmentation: remove redundant Tx queue
 limit
Date: Sat, 22 Nov 2025 15:51:54 +0000
Message-ID: <20251122155156.1385975-3-sivaprasad.tummala@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251122155156.1385975-1-sivaprasad.tummala@amd.com>
References: <20250901154400.2333310-1-sivaprasad.tummala@amd.com>
 <20251122155156.1385975-1-sivaprasad.tummala@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|PH8PR12MB7159:EE_
X-MS-Office365-Filtering-Correlation-Id: 52002b65-22bb-492f-256e-08de29df1ae7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0VQQVHxtAu+CKLoSHCISXurOUAC6EtdnbzvxfvAGmmD9QHhvqs60BiBGZ5Zw?=
 =?us-ascii?Q?/fA+95LnPqtyeKi/HlUCs/DHDH4/7mzxXij3iJ8pQzrkdaOMpeIuvC5F+xCd?=
 =?us-ascii?Q?e3LvHjV062P3wKEVlyk7TELYwxww2qSxquEa6XwnOmIwYUbK9CZDQ7HxJ41s?=
 =?us-ascii?Q?KaRxte/KVUqx2UbAkKTeuh4bC7oy6vA6I4YUj+cYW0W9aZMvxzHD+UriQEt5?=
 =?us-ascii?Q?sN2YbeMrliLBaFdcqPe+rTQkbwbB7FsNNnjU7dxXJ3oUlgAn7UYlHtFSD1S1?=
 =?us-ascii?Q?K4DfWjWhkxc2j4/iRgY6UbBhBKeN017CbKBpUNmWehoXWkJ1R/RcvysnlKHj?=
 =?us-ascii?Q?QToxb1w+YXNfzc2+ueFa22biEVxbkifYn/Jw+Sb7KJylghy6J3Y5z7cw/2m1?=
 =?us-ascii?Q?nH/iMEDp+Y3MsXEV8vA3u5NmQhmcmZCY8Am8FpfBRHgRdSHIie+m+2CsP4pu?=
 =?us-ascii?Q?/JayGxVGGYkDxnn7AZ+eQ+i0s6P2iWPjCMgl/Qh9mSh5HaBI/Cd3idur5ZRo?=
 =?us-ascii?Q?n6WFt99k67QQyRz/RM0JnUOO3M+cRIUOOEn/1WxWASb/NM0h7cMe9Gd6f479?=
 =?us-ascii?Q?HCqg7DBj5W5mGdIZItL9lfSafEFuWGpvpatTP9SYQSXvBDPFNXLwScuEfL8f?=
 =?us-ascii?Q?ezKga6vMsMGZCThyUNZMkEbqtTWzf5Ge8lwpZdrT5trglK/VdUsf/Z8nPEh7?=
 =?us-ascii?Q?tzdECOpTslg8MiNy8Bt5axiDN22R7hR1z/CahEV6OiICwJuKoY96lESFGg1b?=
 =?us-ascii?Q?VZg8FgExg+UKtfEF91dFtfx2r48gX70EM+whpOIjQV1lH3k0K25i/VRWrkQ9?=
 =?us-ascii?Q?tnWc0E3VOHpPMfVsliuMY6RWO1YqqlNMVdw6eg6CD6N8H7BwInYIt8MsW/GK?=
 =?us-ascii?Q?0uKpiVn7UFjLlGnsI9Ys3v0y1DxrH4xx6bCdItcBqa77gFDrGTcBglVEZqQd?=
 =?us-ascii?Q?l9hBDIAnYayDcNvkuy4UpDedP0ruOsei9mn3GAzHA3binNImAQIPJ420zikX?=
 =?us-ascii?Q?fM6ttA6/UHHORvEKNvsEArLBL7fHBoS2rnaPI5y86zadXlJ4pIjjvD6/ywGU?=
 =?us-ascii?Q?Ko9IhEJWDm8vVp9CjvB49JT8oBRMfiYYoJGqYxKOByjYYub+8t2vTwsAcL6H?=
 =?us-ascii?Q?DIFQn+AJtEDobea6k+NvdThdnqWW5+QKoJWnwRf/l1g1yrcQE+k0BIbQpCc9?=
 =?us-ascii?Q?T+MNDpAwXyYHeSJaOAR0e7z9D0n+4oYz3hqX1ZU5tvx34+3Bl67TINtnpJSZ?=
 =?us-ascii?Q?gFhu3b+Sc1YAm5Y0JUpXlx6m1hQQqFjo4LdAmz7aCN19N2fhrGXFQUHwriYt?=
 =?us-ascii?Q?zbg4w6Zf+pvfCU1YOtDdznbnTLo9/r2iSlYnARxoR+rBnZz1EQZee6V2c6bi?=
 =?us-ascii?Q?TQoTuiLLUdQUt6hs42gwRhQK7tbKM7X8YueidJ9KNsz9EFJW8t+NG4Zr3cM3?=
 =?us-ascii?Q?WWlEkkUVW/ph8U2XFga8KvbGygXHBd0V4R19nTStCDY4zicYcXDj07SlyEPR?=
 =?us-ascii?Q?5c6Ew3sI/6zKFAlQqUzKtxIflWudwl3UT/GGnUPVdI1MvRScoBcccPxEHelP?=
 =?us-ascii?Q?GCs/0MCqKltu+LNLIJY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2025 15:52:13.7650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52002b65-22bb-492f-256e-08de29df1ae7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7159
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

In `ip_fragmentation` application, Tx queues are configured per lcore
to enable a lockless design and achieve optimal performance.

The `MAX_TX_QUEUE_PER_PORT` macro, defined as `RTE_MAX_ETHPORTS`,
introduced an artificial constraint on the number of Tx queues
and limited core-scaling performance.

This patch removes the unused `MAX_TX_QUEUE_PER_PORT` macro and
redundant Tx queue check, allowing Tx queues to scale directly
with the no. of lcores.

Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
---
 examples/ip_fragmentation/main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/examples/ip_fragmentation/main.c b/examples/ip_fragmentation/main.c
index 1f84102844..9be2f72983 100644
--- a/examples/ip_fragmentation/main.c
+++ b/examples/ip_fragmentation/main.c
@@ -134,7 +134,6 @@ struct rx_queue {
 };
 
 #define MAX_RX_QUEUE_PER_LCORE 16
-#define MAX_TX_QUEUE_PER_PORT 16
 struct __rte_cache_aligned lcore_queue_conf {
 	uint16_t n_rx_queue;
 	uint16_t tx_queue_id[RTE_MAX_ETHPORTS];
@@ -948,8 +947,6 @@ main(int argc, char **argv)
 		fflush(stdout);
 
 		n_tx_queue = nb_lcores;
-		if (n_tx_queue > MAX_TX_QUEUE_PER_PORT)
-			n_tx_queue = MAX_TX_QUEUE_PER_PORT;
 		ret = rte_eth_dev_configure(portid, 1, (uint16_t)n_tx_queue,
 					    &local_port_conf);
 		if (ret < 0) {
-- 
2.43.0

