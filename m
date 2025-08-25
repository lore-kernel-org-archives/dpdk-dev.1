Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2445CA0FE7
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 14:15:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E697B40659;
	Mon, 25 Aug 2025 16:15:14 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by mails.dpdk.org (Postfix) with ESMTP id 564E44064E;
 Mon, 25 Aug 2025 16:15:13 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jnhn94i1Ck4pYhE5gZWFLJzl+vf2dakuYbuWgq4nbaW+Mz9lUxJtGxk+pNRevw4wudyx2mnsX6y2jO41C1gKz/0PZpBieptjIgIwlCAtG/3RrLTnBkv8MxLHqKKGRx5sfGwNv5No1Kvvbk/5stKUlSWo9kvVX3LrZ3h66Laya2TNQI6AYX8pF3LkPiqL+ax4dtfk3ZP64ESOBYPKlu3piFziVfkysHofWNmA50SBcOiWvOT2wWA4/cnkvo+Ms1+XTriVMzqv3gJGYsCaMRdFAHl62CXHxJRG40SUxYNAKmR03MW8c1W5dly8YkO4HLFUG2rSk12vlevzA10c6BcxmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6gW3z4uZ60zqM6D6NBQKyhqoBsZBWkcrW4Pyx2Pdbo=;
 b=v3q2nKiLhMjO+NJONNkuzwmLulpBNkXcdeLKIDDGPZw1fUI43Pa9JCtRC40DRngkvmJAPKXYLFUnlapzQnZLtukk1L7wsl03KwEboV5yOftZikdjtq8ssIHCFaI1pMGikcaNmJZCDxm9kK2cdkmnfFpDRgAXV4NHJNLkZgfjFh8Uk7YAS8kHg6gyJHOS8OuvKnzSwXjtup4fXZwgRkpgZTVUQzgcmaeWZCu+OXhpMjUB/Sa83jpPIsgSpyjS4eZHmjXQon40oLULyPm+yyX7O1vUSrdDVtxGccJ75Ou9r8O+IbVzQsJFQ1NZqB42o3AcixRI6dobMpm+uCllpE25HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6gW3z4uZ60zqM6D6NBQKyhqoBsZBWkcrW4Pyx2Pdbo=;
 b=HUC5qoSPCeEkx0iJ7wSc4XsKkIJnReBLhcPoCwFIuqfSk8SlFvOTHs6vfKewGedyuc3PHKvsXwtgreUWNQ+3XseCQKCPdByonYQkdpv++3j5VH7CqIwueGvWEMKs6GTJBGnanmCk5CpjOorijQCIoeY9RCW7gJpQDFr8MUThwLjJ0cx7yq9WXfyXWVpJlf5kClXjfRSOVBwMtJNgnXj0IoMr1TFukAbUolu6Nfj9WGaszrR7adNU8UR7Hev1lpA9/3kZjwQ3Ai/Fw/xaomD6mDt7l2SlQltvEGlFJEu5qUp8CnFcPpUhnjxr03HWP8eKeCaghVJRsVW/pkWq1NQwCw==
Received: from MW4PR04CA0167.namprd04.prod.outlook.com (2603:10b6:303:85::22)
 by IA0PR12MB8303.namprd12.prod.outlook.com (2603:10b6:208:3de::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 14:15:06 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:303:85:cafe::e7) by MW4PR04CA0167.outlook.office365.com
 (2603:10b6:303:85::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.22 via Frontend Transport; Mon,
 25 Aug 2025 14:15:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Mon, 25 Aug 2025 14:15:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 25 Aug
 2025 07:14:46 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 25 Aug
 2025 07:14:42 -0700
From: Gavin Li <gavinl@nvidia.com>
To: <matan@nvidia.com>, <viacheslavo@nvidia.com>, <orika@nvidia.com>,
 <thomas@monjalon.net>, Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, "Minggang Li
 (Gavin)" <gavinl@nvidia.com>
CC: <dev@dpdk.org>, <rasland@nvidia.com>, <stable@dpdk.org>
Subject: [PATCH V3 2/2] net/mlx5: add support for flows targeting multicast
 MAC addresses
Date: Mon, 25 Aug 2025 17:13:22 +0300
Message-ID: <20250825141322.974335-3-gavinl@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250825141322.974335-1-gavinl@nvidia.com>
References: <20250825141322.974335-1-gavinl@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|IA0PR12MB8303:EE_
X-MS-Office365-Filtering-Correlation-Id: db89f112-e9b6-453e-9ff0-08dde3e1ca41
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dAILSpiRubW9jD77lvSUA0jkOoPROSsEv8CcX35K9qc+2x3zYdM+H7HEuhs9?=
 =?us-ascii?Q?TTHWX8ZyeKUjle03M1oscWHs/dJnzu3ZGr5hOaxWcB7ww//1iSOngAiaWqLm?=
 =?us-ascii?Q?gLXCp+4i3MulM5yERB++gfv2WV/8EWrIrbIQktnTAoo6WzC2F9BL+QmB5A2q?=
 =?us-ascii?Q?F+novAavFg1FrMmEFwQd7/FEx9FfFWvaD2XlYGzqNYh2T9S7GPjh3dVQVTc/?=
 =?us-ascii?Q?NN4U/rjML9xEo7QSUMIA2/WtwWvLVXOL2GVktBk3gvV5ZikPyMv5pt9COO8N?=
 =?us-ascii?Q?1y4aYAJ7FoxqJBXvjDtH8pI8vpLr2Yt9RV8BsMIe6gC7g0P+knnQ8/lnpQOT?=
 =?us-ascii?Q?slf5wahRC9zLzin7+t0/gRVuTR+rUvkwP2wzvJwGRt8CxuNOUZBdVwdC4u9M?=
 =?us-ascii?Q?CarS5P8/HH4R+t31Gs8qB0DG2TTfNbPnxs5ejfu0VL0pqzhxmRkUHsiM1TO8?=
 =?us-ascii?Q?HipXzmHaTA3UPN1QNfZ4mFpZIoeWy6Vk5MfARrm3arZ34p55Mlak3EjwmA0O?=
 =?us-ascii?Q?ngszc9PSBJ+ubY9XnYu2QO2+CzrvTIflRqxIQ4drn0aEMkvFDumDoQ36IezP?=
 =?us-ascii?Q?tqo5wul/eLYvjks96Mn9DAzvx73Ft4DbZJs8jia1BX9hwcA0o5SS+I4iPYSG?=
 =?us-ascii?Q?RvEt/ZvT0RNnxXgGw5eUTQpXnvvgFnBQB48yx2nqa5czqz4AVe8LcPbM8r4K?=
 =?us-ascii?Q?AhQAIBiS5z7gsPRuXjWgWA2XFoQ8viGRbytRYOXD33i3H07LbZJftD7Dg+9Y?=
 =?us-ascii?Q?1CqFpY26yxH+Uzsx0zblrTAnBzTEe6C23nAAn2rlC8uhBhtVab5i7XOV839z?=
 =?us-ascii?Q?JPY+s8VN0LM9kdFTzFRQWxTdN6kMp9znGJJDvO0X972zCOvPSCBNynP/SvrG?=
 =?us-ascii?Q?Tc2iViC0c47lkKP0KW92Fozwv58GGj2R8oSDprPKlQ8NO6vWZoOf9oH7/l4C?=
 =?us-ascii?Q?q2R2O+HGDVbTL/k8MP2UUEkfAKgEaXK2nPpUn+PjgsFikILJzXBTFZnVQDsy?=
 =?us-ascii?Q?2DqxYDCaSVkkUCqIcwQ0PAIsCbsqdCefjo1uvcxXRe9mITXM777uaDctcBBh?=
 =?us-ascii?Q?3JmR6Jd2SF7bAAwHy2d/nrokRslfWWAEWb3VPb0izlkdiLUCzpajLdDgyE61?=
 =?us-ascii?Q?OJVaKhNPUvC89Ey6GPItQ7x9v5o8GWQBjehZPjdSHKkoe8kTol43fHRPDas3?=
 =?us-ascii?Q?z6t0gvFnh5ZRjiHwRrf1eGlZVXW35N/X0X/qD6wiLM9Y5KvSPuqeOkgHikEA?=
 =?us-ascii?Q?PB1dX6tCXuA2no8GXK5F9mvtafYlbnlu4cM+Fe1QuzzF6Havu4nV5S/QPpO3?=
 =?us-ascii?Q?L9a+ldHnzYlvfvM7/gMW2j9CyNmUTbIPMUjliLoPQN9/lwPE6c5bx4Ro/MYi?=
 =?us-ascii?Q?KQMuU2/ovb8ObuCpvAG1cDjetkrZRVrGsU2MBsoHJo5jualGgVGP7aPXBOI0?=
 =?us-ascii?Q?rhF6E4N/jjxM1MOiV8fcZdsDpn+1YNJK+DQTR3M0z91XEkrsBY70YRZKaXLZ?=
 =?us-ascii?Q?L8o4c0KAi1jIh82cHsYNumgYLKxk7ag9VKGf?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 14:15:05.6632 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db89f112-e9b6-453e-9ff0-08dde3e1ca41
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8303
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

Previously, flows for multicast MAC addresses were incorrectly disabled,
causing the multicast MAC add API to stop working. As a result, multicast
traffic directed to those multicast MAC addresses was not received.

To resolve this and update the multicast MAC address rules, create them
within mlx5_traffic_enable.

Fixes: 2d0665a7f771 ("net/mlx5: align PF and VF/SF MAC address handling")
Cc: stable@dpdk.org

Signed-off-by: Gavin Li <gavinl@nvidia.com>
---
 drivers/net/mlx5/mlx5_trigger.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mlx5/mlx5_trigger.c b/drivers/net/mlx5/mlx5_trigger.c
index 6c6f228afd..46479fbf09 100644
--- a/drivers/net/mlx5/mlx5_trigger.c
+++ b/drivers/net/mlx5/mlx5_trigger.c
@@ -1813,7 +1813,10 @@ mlx5_traffic_enable(struct rte_eth_dev *dev)
 	for (i = 0; i != MLX5_MAX_MAC_ADDRESSES; ++i) {
 		struct rte_ether_addr *mac = &dev->data->mac_addrs[i];
 
-		if (!memcmp(mac, &cmp, sizeof(*mac)) || rte_is_multicast_ether_addr(mac))
+		/* Add flows for unicast and multicast mac addresses added by API. */
+		if (!memcmp(mac, &cmp, sizeof(*mac)) ||
+		    !BITFIELD_ISSET(priv->mac_own, i) ||
+		    (dev->data->all_multicast && rte_is_multicast_ether_addr(mac)))
 			continue;
 		memcpy(&unicast.hdr.dst_addr.addr_bytes,
 		       mac->addr_bytes,
-- 
2.34.1

