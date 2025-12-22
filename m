Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE58CE6748D
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Dec 2025 08:39:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCEBD402EE;
	Mon, 22 Dec 2025 09:39:26 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013039.outbound.protection.outlook.com
 [40.93.196.39]) by mails.dpdk.org (Postfix) with ESMTP id 6163E40264;
 Mon, 22 Dec 2025 09:39:25 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ADlD78qgVqSMzgTyGBvbeZXCnqxhrHVMmamT3ByVIpWr+3yVHk4ATwCvXeQyZl+4fci3RGoioO65nczbMDy3IlVhpuuQC0J71cHMnlMMla01n1qyvQutWoo6rXGgpdsp6X1sgSueTjc7d3E8NwfpqzPWSa+xj9GpfXr9J2GELldNi/WUhNJmGOG4lrBG7+RBqC7h+UBaCiX3E7jv/KzFmFlbn+TlqvRL9slx1l9dHVxcY+L7bIcce7geDsCJzqH2uMb+wBTIocSMtASyypUQj9u+ujvEqdyUuLj5ZVFuZ/1dhEHCfLDO3JzYKHWAhXHeh09FoI0PfgWRExsINvxjig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/QLP+75ehxB0C0yrdWa5K0n1+7KUpZTbCcSvP0JsG4=;
 b=chxW4HKP5+bVsr+aJpTx4z+IoKCRAtAbjeS7kS5f2LEFmVuN+kIgq3BICzYsjTiA+uGCQo3UBn0xVEqfepyjAskrDhIviix0zX22X2ZX3JXsOiY2nlzgD8BCs6NZqwih/0xsJhwcq1OpTQfVaDVDEIMlcWsSe2NqPPGPcZJz+SFGSimZ11wZhirSkoRSEh1l3mZscAndJWY8PP1VjgVvB9+yNjrlqOCmiO9Df4hPXI9APoOQalk0sAvWFaKu0eb7Uj8ngGfAf35w3Thf52+UXuvm2iaWqITalgnj6AVa7HBEtvzGGoTkasFs8yGR6LbaMSnRMyofphzCD2tqdoAHxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/QLP+75ehxB0C0yrdWa5K0n1+7KUpZTbCcSvP0JsG4=;
 b=Kh9cf/VpwRMai2A3J75MeBj/HU1f70K8F+s7wmaWfBkkjAK/IO8xISqk9lQnH6/f5lEzPPXdA8qAUYGGZ+WgwooPMYcgqCNUc9caYqkoErPYI1XW2TS0aDbUfs1o/I/8GyPI25ypYPtMzWFQ5vfeLiqTDWAvGprAqrbmwPuZH5wIXxS/siJ3JAmnu+puie10ThTr882/zq+KtsjDZkY6tqwGeKqt5f3nwBRO7u+lI2G6QYERg2+nNCtQ/YFtEe0vkJQpY0EuHCIQvMKD6gR3jXQAkyENuxVn42f6nDSNeoDc9kzqgeJ4oABJP3Ji+5nyTgPuxX00g4Rf3nTk5RlaaQ==
Received: from SN7PR04CA0179.namprd04.prod.outlook.com (2603:10b6:806:125::34)
 by MN0PR12MB5930.namprd12.prod.outlook.com (2603:10b6:208:37d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 08:39:20 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:806:125:cafe::24) by SN7PR04CA0179.outlook.office365.com
 (2603:10b6:806:125::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.10 via Frontend Transport; Mon,
 22 Dec 2025 08:39:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Mon, 22 Dec 2025 08:39:19 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Dec
 2025 00:39:08 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 22 Dec 2025 00:39:08 -0800
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 22 Dec 2025 00:39:06 -0800
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, Shani Peretz <shperetz@nvidia.com>,
 <stable@dpdk.org>, Remy Horton <remy.horton@intel.com>
Subject: [PATCH v2] examples/ethtool: fix buffer size for pkt pool name
Date: Mon, 22 Dec 2025 10:38:58 +0200
Message-ID: <20251222083858.1035980-1-shperetz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251203110157.51471-1-shperetz@nvidia.com>
References: <20251203110157.51471-1-shperetz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|MN0PR12MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eb427f0-f31c-4d7c-b6d3-08de4135999b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AeN3qluRMRPYIuB0h3fTGWmWuXGrQL49/2C0I0o/3OwMhOkMJtdJjbNikd+A?=
 =?us-ascii?Q?ztMxSvFiNqGzTCM/7R9mc4NiHqUhaHm2+4pzucwY1jRop0mRlAJljGWwz5Bu?=
 =?us-ascii?Q?gjCCQFCxYkCUayApH6a5uWFNE92uULiOSgO+yYgLz6PeHK/IwQw8WPzkmZ26?=
 =?us-ascii?Q?pRJUgSPEzjkVtTAxrS5wliq9ksoHNwd91f4OgOkgHsJFrnqetPMvL5t6qhCC?=
 =?us-ascii?Q?NEOYj8LfSwFPEL3KCvOQCjU8upjY9Ikwriz+3jnDMUHKdO8j8jz+XG0vXIH0?=
 =?us-ascii?Q?+Gn4P4/pR0QRsvlae6oprtTJSgBUI+gqd92R5k2Un/vCy9lUSQ4V/CVx/xx1?=
 =?us-ascii?Q?CiGL5W9CyKjBzE/o5H9peS3kW/HbCCLNRLqqYCEEGVJxtBVdPW1jFAd6X+jX?=
 =?us-ascii?Q?3ybWJOxwXY3nGhB/hKFgfDmSbKZS23m89TpxRKlbeNt4cdmUKXipfsJ8AINS?=
 =?us-ascii?Q?MM88BLijnwsUzwXxlB4Vg/jD+0idmGrWgjU2vIPhggmUeF1oPF3ji08psObB?=
 =?us-ascii?Q?ODQOsCSUnzetIIpPKJ53zBRCrTtm9ZkBnPqPCoULTYjVy+D7HUCJo/FPeBT+?=
 =?us-ascii?Q?lI+4FQ+rZwCrF+32LSlOUXJ02MszVmfvOm+NivikGZKbMzyhAi5VfqVskl6w?=
 =?us-ascii?Q?lyxNkh74KKDHgqfCiwnmsR93nKsEicWlZBe+Cnl8yyO8t8UxFaO+/wIGAULs?=
 =?us-ascii?Q?QzrEI4Tof1LjSnZEg2ToFQLKB3/kVT+J9mJOqkPv8q34LRjSNB9P6byRP6BQ?=
 =?us-ascii?Q?XywGWelKOppwMftvZPorJRP4JT7R5Xtxj/ao2+GlibUFOHyUbUQr//p3NcKK?=
 =?us-ascii?Q?S3nsjwh29q4rKcDWcTVreWW7vPmvIojK4tfmN/bJqlg6hl0oiOqizn6nsl16?=
 =?us-ascii?Q?RJ7YvD73iCCDNMqvCEKQT+izHv/Y+8RGx5Lk9QygnlseNVbHhA8658tFmXt5?=
 =?us-ascii?Q?HgsrIfn8S2BWvcAlA+f3ecAokbgIIZwVu9ije0h84SbQibysqs+YysNC0NZG?=
 =?us-ascii?Q?uWpR9WBqc6PmQP3bZ5JaGMUUX8mmOFsmJz3X7ESoU8iwT8O3+Az4mogp9HHV?=
 =?us-ascii?Q?Lj8vpQ1nD2aG9m0e4DJIoaa2kEpxqT1kxPV7LMW95Lgoh3BAXCbeHSfX4313?=
 =?us-ascii?Q?CljP+Pk7cMlyfQxFVVpG5qg+LcWo+qGFWA1uVDEQzwR0Md00/xO7T5VPR2QO?=
 =?us-ascii?Q?TIvVhbLuOtdd8kILT2bt0x/r5Cqo8oZNlLjFKGKS7NNWsm4Cq46ZdGjU/g++?=
 =?us-ascii?Q?3bfv5cOWdf26bzRroFOH50AaOHrGfmKTmES5IxAd3JYW1wnHFkqOPCjruzv/?=
 =?us-ascii?Q?xyql/tsOwNKCIj9hA+0hta4hchSOx6Bg9KWbvH10BkwJp8XUYtbueZepRTTl?=
 =?us-ascii?Q?P8ZKFxtteCftsSsrT+tW7abZM+X8R1nhK1QntzbMNC7r0oZnTHuvZtWxsrrW?=
 =?us-ascii?Q?7GgtsIk/OyVuU2qk/T27MndcBSACt3+bmWOpwY5H3fRSwgF47BIjBGEgkbyu?=
 =?us-ascii?Q?lqRcZIRH/fCc3QyXcAFLzLjbGTWPRIcCrcD0HdeAJiIOwv8KtW1/1sQbwR4S?=
 =?us-ascii?Q?x/bZh4mPmAUnxRMNsNk=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 08:39:19.8054 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb427f0-f31c-4d7c-b6d3-08de4135999b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5930
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

Use RTE_MEMPOOL_NAMESIZE for str_name buffer size instead of the
hardcoded value 16, which was insufficient as the format
string "pkt_pool%i" can produce up to 19 bytes (8 for "pkt_pool",
up to 10 for integer value, and 1 for null terminator).

Fixes: bda68ab9d1e7 ("examples/ethtool: add user-space ethtool sample application")
Cc: stable@dpdk.org

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
---
 examples/ethtool/ethtool-app/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/examples/ethtool/ethtool-app/main.c b/examples/ethtool/ethtool-app/main.c
index 1f011a9321..d380f69cea 100644
--- a/examples/ethtool/ethtool-app/main.c
+++ b/examples/ethtool/ethtool-app/main.c
@@ -92,7 +92,7 @@ static void setup_ports(struct app_config *app_cfg, int cnt_ports)
 	int size_pktpool;
 	struct rte_eth_conf cfg_port;
 	struct rte_eth_dev_info dev_info;
-	char str_name[16];
+	char str_name[RTE_MEMPOOL_NAMESIZE];
 	uint16_t nb_rxd = PORT_RX_QUEUE_SIZE;
 	uint16_t nb_txd = PORT_TX_QUEUE_SIZE;
 	int ret;
@@ -112,7 +112,7 @@ static void setup_ports(struct app_config *app_cfg, int cnt_ports)
 		size_pktpool = dev_info.rx_desc_lim.nb_max +
 			dev_info.tx_desc_lim.nb_max + PKTPOOL_EXTRA_SIZE;
 
-		snprintf(str_name, 16, "pkt_pool%i", idx_port);
+		snprintf(str_name, sizeof(str_name), "pkt_pool%i", idx_port);
 		ptr_port->pkt_pool = rte_pktmbuf_pool_create(
 			str_name,
 			size_pktpool, PKTPOOL_CACHE,
-- 
2.43.0

