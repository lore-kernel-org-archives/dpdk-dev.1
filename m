Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F740CE9D6A
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Jan 2026 15:46:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 195984069F;
	Tue,  6 Jan 2026 16:46:49 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013050.outbound.protection.outlook.com
 [40.93.201.50]) by mails.dpdk.org (Postfix) with ESMTP id 30EB5402DC
 for <dev@dpdk.org>; Tue,  6 Jan 2026 16:46:48 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uk4CiWstgmLTgo7dH6fKoRfk5N3P3h+Ijn5MsGcB1ANL9h6Ow5k/0JPjbOvb0Bd5yamW28Sf8MaF3T9UzgIojfWJdBQYS8tHzddFA9S0cjudUWJLHJ+JV2zXFe+wLztNIJG7dYvTW36s8iiAnlfC29xwfArzSh7+s/r4kJmCCg1aeaSqMKejEdjSKrCgO2crLHPrnsdjVrYmR/dkrJ06OQM1hLthqamYxbvHwQDag++6pgReHIGWNyL2fmSGP0HtlZbyDGAy3qf8eFBD1zGbKMybTxA36ytv8FLv7cFdJlB0sy66SkMNIlFOhhYRRqF2Cc0K8vjq9tDjyQkdQcTW+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2N7Hn+uwnTUauBl/BySRtXjaRYF13AqgYnfnAUUpJw=;
 b=LGw1IfwiV9oRwP+R8bOFcwVo3OnOjE/cV+Si5gntYALn3i4GcdUVdMYr2gKflzQMVOQbZUmZdBNAbhG30X63LLJ1KjBWK5CKev256nQ7+/BvonpCK9HrQto8gxItRuLldRt6g3n6ZAf5o+HVNcaMAVVMSyKwlGOSyo2DMGMEu51JtJdZ4HW9GIIJLNSG0SXsyn0iIXjGJKKUuOAycfF7qITOcZ7rldXUCDJR/TBPfLaF2SShWC8LU7DJME5P3TU4zD4m3yJB6+0rebb9c2dVwF1ryObJoqsuOaJYBkNdF0JTnsrTPuXohVDLzpCGJ/Ur3C99u04Px8yJkWTE/RPvUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oktetlabs.ru smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2N7Hn+uwnTUauBl/BySRtXjaRYF13AqgYnfnAUUpJw=;
 b=SRWd+PaMZUq8ju+eZmaBf/VPN6puM3Uu0ee2Bt6UBYt0yjTaLF/TztVkQ1w459f+O8/t/eVjzHkcPQx6taeQCoFLCtr7SOojnkDB/OFW9QZj8E14zJCpuDx1EvpLpou+poa3D9WBXjQTnfmzh2xyh57G+ZG5lUz7+iGOHWn+QXeOxadmNKr/6wPeLgfVQhz7/Js6G5Sumk7otqsZYWJZ5IF/qYhZ8Rho8fy15X34oXyVRnOH+Uxm5NFYr23qsVBU1+zbTcFysuQeYDRBke+b+bZx0UvKUP5nP67d4isI6M9PDV3YfGpMkczn6jJUY5d/EeWIeVH0ccn2x5nvg+OXMw==
Received: from PH8PR02CA0011.namprd02.prod.outlook.com (2603:10b6:510:2d0::10)
 by SA3PR12MB8811.namprd12.prod.outlook.com (2603:10b6:806:312::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 15:46:40 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:510:2d0:cafe::ad) by PH8PR02CA0011.outlook.office365.com
 (2603:10b6:510:2d0::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Tue, 6
 Jan 2026 15:46:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 15:46:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 07:46:16 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 07:46:13 -0800
From: Gregory Etelson <getelson@nvidia.com>
To: <getelson@nvidia.com>
CC: <andrew.rybchenko@oktetlabs.ru>, <dev@dpdk.org>, <mkashani@nvidia.com>,
 <thomas@monjalon.net>, <viacheslavo@nvidia.com>, <matan@nvidia.com>,
 <stephen@networkplumber.org>
Subject: [RFC PATCH v3] ethdev: support selective Rx data
Date: Tue, 6 Jan 2026 17:45:54 +0200
Message-ID: <20260106154554.40556-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260104131301.196350-1-getelson@nvidia.com>
References: <20260104131301.196350-1-getelson@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|SA3PR12MB8811:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e9df2c1-0d92-453b-1d57-08de4d3ac7e8
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fGRmmgVIeO5IG7cqfWabM+PtE1jueCjSADIoKNRSfrXz+/CZDi7huZJRh20F?=
 =?us-ascii?Q?sdVb6rl5R63g2q36DkwZ4fZyUk2OI/Lkn+lu16tzbp/E+gKjv3SyY7BUS8no?=
 =?us-ascii?Q?008f/4UvmrPJ2S/KsfmKru2hthPJwQCSyTdq8+PrKZhKk0OJtmnZLjo8kSrb?=
 =?us-ascii?Q?chj5hrt0MzV9jYgwqIk97/z34RizFP4OG7AA0uMcnSAi+V9QchSeSjGuI0ih?=
 =?us-ascii?Q?A4/h3piQ9HfRxLd8MmO/lRPmrDttbYZkniOOJqKSzhpIpMuMHK0DKKHeTSRk?=
 =?us-ascii?Q?pysKknCe62lf+JB+i4xO15PntgE7P55sfrH8y5hVTEymyRWbaEP6h+k2s9wz?=
 =?us-ascii?Q?qnuXB6jKVvB7s2/2hCrJJEEjj3zVUXWNtJkWcGs6ZuVeNWXHeqipir2iXPb2?=
 =?us-ascii?Q?gi/VPZ1pfVZti7gz3HUMQZPAijIEw2fpQWUKDP7oIczzgHJK4VrfipMYGNz4?=
 =?us-ascii?Q?OdfwVmLDTh/Q8ByjY/Kk4gH8D8Lp36Kte5WbNWmL53nQBY3WW7Negw5HJVrK?=
 =?us-ascii?Q?HwZWeSbgnuPfl/9kAhAYzh+ZmcxT9LuYoNY1RtCV+w2YAASpsV0RNw8ScS2M?=
 =?us-ascii?Q?blQ5MyGn8jvpRkmz39yzbwgxUVb+unJCqFTqIfYLvPyY9gwQrsU9MESFFIC2?=
 =?us-ascii?Q?Ap1QV6feiZFU5eLmOMnT4GMaHhfaBhcxMnyVpxCH8xjvjPmAUd4RMBMrVeJs?=
 =?us-ascii?Q?MBCfZDAe0yNO++MmsHF+d+c40p7c9tmSOCZcoRb/1PLDTRXg+6mUxU94vwiW?=
 =?us-ascii?Q?Ym8xnJbvGFWxG3S+UnZ9YYP0bNrB+JStcg/5SOs5gv0B6hl8PNdF5ByOeVVp?=
 =?us-ascii?Q?RRxojA2z+AMKJBkK1ksfvmHPnYRn4NnnGk/73NQxPSwyNd9/g5YMyUhUklqr?=
 =?us-ascii?Q?s5IWTqozWx3nP4GpxMAGnfMSFEDpaTxr3V5ZjYFLa+nl1yF0tQgVjYnQZ9t0?=
 =?us-ascii?Q?phDikiwGvs1KRQsnPaOfuaDM/gaT+n1sirDRU47xaMBzENco87AsmY1XZd1M?=
 =?us-ascii?Q?pBLLszQjqWYc41yUsYraN3plKwY8ZIg22aIA7Jsja34gk5t24USKTd3uUBze?=
 =?us-ascii?Q?B0mSbPFonTd+0AhdGW3omrdfSElpK7g4H4ASbdfHp5kMKMkVholg2LJ0Pbzv?=
 =?us-ascii?Q?eauAG98kVXtdOTmnBgX4vEMuZ9FHcVw1qbIheof3ESSu4iKVCaQ1D1EObYsN?=
 =?us-ascii?Q?Ll6giBYjXYV7BzmPQ8hJDd5qi25y3BFjOJPpPHKZnvhoaQLlWSKWc783Lt4r?=
 =?us-ascii?Q?tChSu4R3eGFc+KfFN0lFWVUGoBHOiOPj2f1IQqfdDhYHQ21Zpc+GuarBFIA4?=
 =?us-ascii?Q?h+usEwRTErimchFKmt9Um1GYMdmrPzwdPAoKk4c1CeL27deCgh0+1zo5zW68?=
 =?us-ascii?Q?J055XknKNCItdo9PNr3aEGyqrg2HgaWzXTiuJZhRn/GI6v4VRfwrhC9XY/dk?=
 =?us-ascii?Q?g+5ey0BjmfPCZdC1MsGFIxzg3iNA2pQ7MgOSboezQTqmDTrRJAv9ytzeImib?=
 =?us-ascii?Q?3JFp9IeY9U6BmoWjXv6/Wl/awDiMEEE61Epw3yl+7dEndAJS2jduRTgnTz0A?=
 =?us-ascii?Q?7gdnyqFpXwpqj8zDT8A=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 15:46:38.8943 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9df2c1-0d92-453b-1d57-08de4d3ac7e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8811
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

In some cases application does not need to receive entire packet
from port hardware.
If application could receive required Rx data only and safely discard
the rest of Rx packet data, that could improve port performance by
reducing PCI bandwidth and application memory consumption.

Selective Rx data allows application to receive
only pre-configured packet segments and discard the rest.
For example:
- Deliver the first N bytes only.
- Deliver the last N bytes only.
- Deliver N1 bytes from offset Off1 and N2 bytes from offset Off2.

Selective Rx data is implemented on-top of the existing Rx
BUFFER_SPLIT functionality:
- The rte_eth_rxseg_split will use the NULL mempool for data segments
that should be discarded.
- PMD will not create MBUF segments if no data was read.

For example: Deliver Ethernet header only

Rx queue segments configuration:
struct rte_eth_rxseg_split split[2] = {
    {
        .mp = <some mempool>,
        .length = sizeof(struct rte_ether_hdr)
    },
    {
        .mp = NULL, /* discard data */
        .length = <MTU>
    }
};

Received MBUF configuration:
mbuf[0].pkt_len = <original packet length>;
mbuf[0].data_len = sizeof(struct rte_ether_hdr);
mbuf[0].next = NULL; /* The next segment did not deliver data */

A PMD activates the selective Rx data capability by setting the
rte_eth_rxseg_capa.selective_read bit.

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
---
v3: Change the selective_read bit location.
---
 lib/ethdev/rte_ethdev.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index a66c2abbdb..84769d3d26 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -1121,7 +1121,11 @@ struct rte_eth_txmode {
  *   The rest will be put into the last valid pool.
  */
 struct rte_eth_rxseg_split {
-	struct rte_mempool *mp; /**< Memory pool to allocate segment from. */
+	/**
+	 * Memory pool to allocate segment from.
+	 * NULL means skipped segment in selective Rx data. @see selective_read.
+	 */
+	struct rte_mempool *mp;
 	uint16_t length; /**< Segment data length, configures split point. */
 	uint16_t offset; /**< Data offset from beginning of mbuf data buffer. */
 	/**
@@ -1758,6 +1762,7 @@ struct rte_eth_rxseg_capa {
 	uint32_t multi_pools:1; /**< Supports receiving to multiple pools.*/
 	uint32_t offset_allowed:1; /**< Supports buffer offsets. */
 	uint32_t offset_align_log2:4; /**< Required offset alignment. */
+	uint32_t selective_read:1; /**< Supports selective read. */
 	uint16_t max_nseg; /**< Maximum amount of segments to split. */
 	uint16_t reserved; /**< Reserved field. */
 };
-- 
2.51.0

