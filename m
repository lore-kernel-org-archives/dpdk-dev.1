Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28822C87FCA
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 12:06:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5955B402E0;
	Thu,  7 Aug 2025 14:06:45 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by mails.dpdk.org (Postfix) with ESMTP id D62724027C;
 Thu,  7 Aug 2025 14:06:42 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y0lzXYZuTUGXtRNkCp480t3E4e4dY9fwnJ4uuVVYEHweq5jwyVkpM1+U+rl86U6kWVoezYI2d1eMUWptrWRENxcJ97WVtlHy43JUGsbjmZp/V/DX2NWkItTREwNBdnFM+u+oneUyXgEuJveZbF/n+M/wZT7+996EAeP0LtbqIK9t1kAxuSwiIljNkxMnYwCnGWWg0SgtDYfM2+/kRmXoszwCT6a39m4isNjO+kZWDWuzc3b2JTyJeE65R62u0FL8KwW5n1wa+AbaVGgnUt7dD+82PXABHZlSRoqxJIElLICHqft5NybAsthRVcyWf3wGmTdBsb6W2uNWbnGx3ugGaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EI7oZT4L1nAqEBkMYF16VneX9+8PlDWiUhbffc2aKC0=;
 b=BJ8V1LWp1ZjbZYMKiWIxnIwMOWa5QDhT4cGjDQu3llv1/+rrx9NdWEuTAURXzzNNic0RreL7uixlMKeJHlFoBpUNDDcOidWqAvo8sChyCqBcYP8kV+JOv9XZ4emE+VuIak6+FhQ7zP6QI4smaIcsgcMmTZIZly8dnlY5jlLC5WX2tgFsNCyxmexU9OflKlOeOLy4kiBK7CVPZoMBCLyuFV/8DWS/jVZkdaEGVB9LVVXlMThYKNM2itToRJhO40MoHR63XjYGHDTjycYNiKKGLo2QRAbVojil97pnEHdm1Jjpftk4dYj/8xftiOmS9MtQsCodA5GKruZnx064/buMPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EI7oZT4L1nAqEBkMYF16VneX9+8PlDWiUhbffc2aKC0=;
 b=b1Pw6jK0OMwm7NzJHg+jHFKnT05Ue0XDd2tfF+bZxwVIdSNEI1tPb3k+0s/Y5Z9QAl2Hs4XLj0ZKyJBP3fQASCUFyQoewb6JEDEpoYQ/C8xr85YhrTKZ+Twsn+aust0+SJdTHlYGOpHjESj5FZm3DdVXJLCCxuzgXhMCZDvNE39Uo1hO9IIZivEm+RCvg8zVJgZ0dNvhI0UbKdbSIatW35a6jMqmg+sStqGyfHbjY+NsDsSqb20yPVNvyL8H4aqGclSHLtBd/PAjIyYyBD69pQXbi6IHAZ4uorqAIArpuXQLo2r0fYhttBWGU4e/RBODr0nMqCMH1ey2cPJRUHBqJg==
Received: from BYAPR02CA0023.namprd02.prod.outlook.com (2603:10b6:a02:ee::36)
 by LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Thu, 7 Aug
 2025 12:06:39 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a02:ee:cafe::71) by BYAPR02CA0023.outlook.office365.com
 (2603:10b6:a02:ee::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.16 via Frontend Transport; Thu,
 7 Aug 2025 12:06:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.8 via Frontend Transport; Thu, 7 Aug 2025 12:06:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 7 Aug
 2025 05:01:05 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 7 Aug
 2025 05:01:02 -0700
From: Gavin Li <gavinl@nvidia.com>
To: <matan@nvidia.com>, <viacheslavo@nvidia.com>, <orika@nvidia.com>,
 <thomas@monjalon.net>, Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, "Minggang Li
 (Gavin)" <gavinl@nvidia.com>
CC: <dev@dpdk.org>, <rasland@nvidia.com>, <stable@dpdk.org>
Subject: [PATCH] net/mlx5: add support for flows targeting multicast MAC
 addresses
Date: Thu, 7 Aug 2025 14:59:42 +0300
Message-ID: <20250807115943.690540-1-gavinl@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|LV2PR12MB5869:EE_
X-MS-Office365-Filtering-Correlation-Id: 7559f242-90f9-46d3-74b4-08ddd5aadda2
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Qg6l8tDC3n+dMfCajDGDKCsFM0smqLxLhrSxOZxKE/U45epYgveC+Bh5Ryig?=
 =?us-ascii?Q?MW80iZatJi0EXLyBi88TsVXzqQFFlEgeXAkVvWgsLoLQzqGwpCUhyCekf0Yy?=
 =?us-ascii?Q?M5DgV1ZviIEqzRvyAF+VdlXyyDyxxJn3sdJzvpEY1g0AD7LSSvdkuuItAIDt?=
 =?us-ascii?Q?rj2lalhTNCkkKRJ3qBJo9/c5gtThMTIzDpRwEEYR9vIugwKFmv7IMQlk3l0a?=
 =?us-ascii?Q?Hl8YbQQo9Bv3BurRpeWPtRD5P32xi1F4QknM4KAvQy4xxEsBfN9z69GqXTHt?=
 =?us-ascii?Q?QXjY+G03OWAH9EXZfXK9LdM1O4vDMfJ1Mc1GVJXV4aMqFemoJi+zMPCVJtRr?=
 =?us-ascii?Q?1QhxZ6z0t9/J5Um2x+2JbcJcgOMoCIjmyyxmTmlH85N48ZDo8gd8HdrAmwPq?=
 =?us-ascii?Q?xJILSGvdW5H2JrPObK/0Fy/JrHOXI3tnesHjHNTMpre+EyKdWK6BYG3haE0S?=
 =?us-ascii?Q?k7f2G7CJkwjECwZBnSfsSQq3jG13K2S+MlEfAZ+JAs626+1Nbu1b6rS7lIQa?=
 =?us-ascii?Q?rCxGyC1RkGFcf7EEcdqMpGf1Zai2tltkbS2LvaWoyRlA/TiBlvmhaxkAQ2Qs?=
 =?us-ascii?Q?tMqoGBW0n8n/niMdLALE/AXlgyUQThvtg+w1FmuRHzLJeShRN7uf/Do6+AZQ?=
 =?us-ascii?Q?CP8N/up36IDE5ALxInAOxkstCffJH/hPzGCUG26emyynzOLK1Z2pWmxFOZ3w?=
 =?us-ascii?Q?g/J89uZLQQF3+PlBfsZ21iwApYhhQJKIeZF9gzssy2TrEKvet3hKVHuCwUvb?=
 =?us-ascii?Q?xuTxiyYDcvY2vOVrsAObttb02CdF45aRuYtypw6AcK62SgZYNFiggp5GAtnR?=
 =?us-ascii?Q?cNuZcXPuB4LU9X0P7cQKjb6TwfIyxYOHzOcAC+dgB4QbWSGCmLHAnv8dfrr3?=
 =?us-ascii?Q?ELZQzu8e5b/DOJW4tTPXSoRwNWjqIhJ8AZl7vhpXRXYYO2+3Ybrf7f9rpYEO?=
 =?us-ascii?Q?JO55QFXRbH1ooGdpjVEFr2jwx8IwnpTR3sXYOKxxfkyYsMc8dAodP5ony6BD?=
 =?us-ascii?Q?TRF4GcvNatw10TKfGoRBRQBUDyO7jZPOUs6mfO9Vk11TBp6gQ8GHn4lx46Lx?=
 =?us-ascii?Q?5H75ia34VJEW3gmfEdWuzL5hhl8XEGTpoN/Gw0t5z7HJvg/plvt9+G+ZfmmP?=
 =?us-ascii?Q?oyx06VXnPO1u0q2PJk0Nb6/xrzng3LqOAEgeAZ+/78yJ3J1DGNUlV15I2vdr?=
 =?us-ascii?Q?p4XZZQoJGTyA1qmvy6AL2x6ZVWvPbW1QsuxeMe5pvgEFRRRu1JF2yuXJPZv3?=
 =?us-ascii?Q?o0S+tMKRBvDoamhWrLOOPEshwE97Mfs7PTFS9UZZB9S6uBHBFhJHGcn8WuhU?=
 =?us-ascii?Q?wsWSTZQoRRPsoEkxJxLCFlM0fKJbRINRI1ykHvRKC1QeqKwHV/yh122oDhyD?=
 =?us-ascii?Q?rgwZUhq8x5HwW/H3yg1AjZM+UX2sii3gKuvs99j/wpJlqF5Qsa/7kSml6ikW?=
 =?us-ascii?Q?ucYunTzD+XHIOEwtaK/P5utB/8XuR4S4ZEvYlPLiAneLIOx1Q2RY5tLmBNJu?=
 =?us-ascii?Q?WR57UC89M/IuFiiEGKcAVJqLVgj8TywLCmi6?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 12:06:39.5318 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7559f242-90f9-46d3-74b4-08ddd5aadda2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5869
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

Rules for multicast MAC addresses are intended to filter multicast traffic
and are managed through multicast MAC add/remove APIs. In mlx5_dev_spawn
function, devices (PF, VFs, and SFs) retrieve the netdev-configured MAC
addresses via netlink and store them in the PMD device data, which
includes multicast MAC addresses.

To update multicast MAC address rules, create them within
mlx5_traffic_enable.

Fixes: 2d0665a7f771 ("net/mlx5: align PF and VF/SF MAC address handling")
Cc: stable@dpdk.org

Signed-off-by: Gavin Li <gavinl@nvidia.com>
---
 drivers/net/mlx5/mlx5_trigger.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mlx5/mlx5_trigger.c b/drivers/net/mlx5/mlx5_trigger.c
index 6c6f228afd..6e82a8b021 100644
--- a/drivers/net/mlx5/mlx5_trigger.c
+++ b/drivers/net/mlx5/mlx5_trigger.c
@@ -1813,7 +1813,8 @@ mlx5_traffic_enable(struct rte_eth_dev *dev)
 	for (i = 0; i != MLX5_MAX_MAC_ADDRESSES; ++i) {
 		struct rte_ether_addr *mac = &dev->data->mac_addrs[i];
 
-		if (!memcmp(mac, &cmp, sizeof(*mac)) || rte_is_multicast_ether_addr(mac))
+		/* Add rules for unicast and multicast mac addresses synchronized from kernel. */
+		if (!memcmp(mac, &cmp, sizeof(*mac)))
 			continue;
 		memcpy(&unicast.hdr.dst_addr.addr_bytes,
 		       mac->addr_bytes,
-- 
2.34.1

