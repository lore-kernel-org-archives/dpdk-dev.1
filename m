Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5106ACA0ED1
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 Aug 2025 11:45:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A5744026C;
	Fri, 15 Aug 2025 13:45:34 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2044.outbound.protection.outlook.com [40.107.102.44])
 by mails.dpdk.org (Postfix) with ESMTP id D56CD4003C;
 Fri, 15 Aug 2025 13:45:32 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kq6ltNQNluas1L939+OP44gsvjGgSM1TKyh/Ho2hkaGreLxOJzsuP0xoKGFno/rE/pXi3QKcnMbxdyZnhbMKKAAo4oYsofzmeUtySDcE7I4eSYf6Dr+htcsVYZssGGRl6MmVJXPcAVBHzRuJ/kefcDBrBPexH/rPFxvMa6dgKvU9wsHAHJCh8CS42+w4NV3bWQjxIJkSfEkB8XgLFTz3pzr45w3GX4tHyy29oBOspiDWhZH5N2iWr/5EYSq+0X6J4RKC2SDUUSVKhWScne9MLUSHnauDk4PKBw5rVxuASwgn6T5WxgeBvvYefQlU7r7vG3SsnxxnZmpeL5SuDQlxCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVhBXnlif+ZsWiaHCzhEqbmxasXQuKJAVcCtSFOZr5s=;
 b=cpmuvG35nUE1lOvWOsqhu+E5p3YGYpKYRKbQoJBCDivZyjZ1zbJZ2FJ8bZ9ZquY2ktumY1LfS+SYi14eMh810zB//DMKT1lFX4U/8DcUoIg7d62sRmVPcs6ZtKXw+cU8/skIs5Ziw+UDuTzlcIAKMD04Ly2c1K0E4U0OcWVhXeuzgtsTv4O1NgEr5CdT0AcgE/q+eZhGh/aDPukVh7I84nsZrVQzWQVNKC4ppFzdmlYrpM/f0Uwpfssm8HayEemDnLabiGtd8VFv+W6xY8neWg6d9OPXmW4ZkIJ0BvzoICJG2nC9vQ0bCm1TchylIKK+9b7Bd18X0WQanMkgNbG6KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVhBXnlif+ZsWiaHCzhEqbmxasXQuKJAVcCtSFOZr5s=;
 b=MAg+2Wli3Mq5a/uqVMNhtPVP9EppzuDTLtu+qhphIFlNDP+Oh75a8Pfmb4Y1bKPZ/Wg6s2QVHnh4Ng2Y2UCsq9htB1/OERk344472hyUMLGsESB5EpSK1IGU22AmyRMMCHEW7RCl+/Q7448e1MwEkduuE8XYoNx40LOAsQfDmuqgq9XpBCwDjUh+lqQcjEd7RajA44WpZZ5SL/5Gv2vXF4v6H0lpZm+J3gjAUvu7JqlfZyYIewcZoVeHbM7lhSBlhaBzlZ2PP08euG/lMxslLgS8ocZpm7tV2OMMcgaA2weUNWHz2H8QBfVGJkTx4GAbgq4t7EcR9EvTLdxT+3fuJg==
Received: from BY3PR05CA0010.namprd05.prod.outlook.com (2603:10b6:a03:254::15)
 by BY5PR12MB4209.namprd12.prod.outlook.com (2603:10b6:a03:20d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 11:45:29 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::22) by BY3PR05CA0010.outlook.office365.com
 (2603:10b6:a03:254::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.7 via Frontend Transport; Fri,
 15 Aug 2025 11:45:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 11:45:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 15 Aug
 2025 04:45:15 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 15 Aug
 2025 04:45:12 -0700
From: Gavin Li <gavinl@nvidia.com>
To: <matan@nvidia.com>, <viacheslavo@nvidia.com>, <orika@nvidia.com>,
 <thomas@monjalon.net>, Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, "Minggang Li
 (Gavin)" <gavinl@nvidia.com>
CC: <dev@dpdk.org>, <rasland@nvidia.com>, <stable@dpdk.org>
Subject: [PATCH V2] net/mlx5: add support for flows targeting multicast MAC
 addresses
Date: Fri, 15 Aug 2025 14:43:56 +0300
Message-ID: <20250815114356.817486-1-gavinl@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|BY5PR12MB4209:EE_
X-MS-Office365-Filtering-Correlation-Id: 78f3e5be-949c-4852-be03-08dddbf13b81
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6Cow33PCauDQX4w+WpjZT0ZmqcBHBPfwPZYnup7CZ3AukTr0CVtcJCeZw/0K?=
 =?us-ascii?Q?D6o8nEg3GjuHXEvtxF5w1qJxi1g5YlvLpr6PxCOlB51UGwzpnurLLTBuIeE0?=
 =?us-ascii?Q?ku2Pa5ykDYosFfnxmCST2iIG/2eCKfrZKyLADGPVunxyXCDRJDcC22OurFp6?=
 =?us-ascii?Q?KFCHmFn2vyUbziSqvIlFPsE9cX1emA8SsRdLjn7bAenrxUF/RME6Ha2umQ7k?=
 =?us-ascii?Q?+UCcpTI0osU3ryhrk0qmiVkNq97XiPcgYNgUBcvyElPewydIOgi/+gTO+lQD?=
 =?us-ascii?Q?ePEo1UZ3emek9qdKCxNEIslxrV0TbCoXhclra74fe9suYYXjYguew62O1Vhh?=
 =?us-ascii?Q?yYYLqcDKN2YQMjxAd+02wCjadb8pYSc7d9ZzsZzFWhXes4SqXTU3xLKdvjaq?=
 =?us-ascii?Q?fEUEC1oKrZ2cL1tmSlAdRqPdpsyxV4KRBjxHP69Mt8lMWgBxc66635gHBPvP?=
 =?us-ascii?Q?qs39ZhjUWJe+FRNVltnqJ2jXV//qysS3t6Q8cDUq2dEPMee2nLOkc7KdJvF1?=
 =?us-ascii?Q?1YcbkfydSZon4QZ0S+TiG3dS5I9YvlN1bpnXQLe1CeCC3hACwCTTiYFlQ8Qx?=
 =?us-ascii?Q?dN5iSaG7zVKEeFKixmjUq3uLkneMBdbkHMfnVi7GcrPVwxYh/Xu+ZETp2qPr?=
 =?us-ascii?Q?//KwyHVDm8o9YKVT8lWtR6qI67qm+kFRa1g0KAKfz7E+Jdd3jn/bpJD6Bd41?=
 =?us-ascii?Q?mC2zkho0kwBz9iivr3sa/tezEm0a/1SRBinyWLQ1xaNK/h1Su9PcAb6xabns?=
 =?us-ascii?Q?u4ugjAfCFVPzCKLBs8jRPojccNBy17drdmFRcvf4AKg6hQ281a5PGpRDd60i?=
 =?us-ascii?Q?hDJmuHyYAYMrU5W8U4qPGpkLWVxAu2LonhjEzxWo8RpNVfbmIcpjbcYrjYqT?=
 =?us-ascii?Q?fqzTw7ZjQwQdWwXGKsrVVp4k/jehQqHNpu8lsH0ATAbxVLNRq9wa4jTDPmU/?=
 =?us-ascii?Q?I2XtIcuMmkEmuR8XflQ8SulEnDi4Sqz+6wp5F9Ql/Y/4llex4jpZBcjbSRfi?=
 =?us-ascii?Q?UZofnjnsJZblbg18PwZ/KMfXyZjROtllsKvb0QQv8zFNT/hqucriOc+amLkC?=
 =?us-ascii?Q?34rNqlMAAtzy1uz5C7a1Hxb51arm1Y8F/yWU7eRqKJCp344tJH06k4bALsRV?=
 =?us-ascii?Q?7kAQcUgKo+1WW/n6Fz/MhGkgiboHS8iM9crbsD7TRnrcI4SeYd1BIT3kE8UY?=
 =?us-ascii?Q?BIdTCHLlNW3m+a+IHcX4C5S/WrnbvbkyfCQDnLlFHoWbUcx9UaN6pkVgrvk8?=
 =?us-ascii?Q?DMUuBNPvWDp/pQxRbBN9wHaXBxHXsD7nQJBLaeiN7WNyh7+zNI4p9MxkR4dF?=
 =?us-ascii?Q?K4JS5vPvzBVIYu5nwk5d/EVumND7VKuMFMShwDf0INIatsXVfRajpOChStKZ?=
 =?us-ascii?Q?4b6aC44BmipM2YmWy41T3uOgs3AIENXjzU5U5SDPG4+uFT1REelVxB3jHc71?=
 =?us-ascii?Q?m3ApH4HkMUOvsO/jQp6ZLeGF/S+AW+p6Rh9+IxEqCi8ulm8s+ZUOkCBAwj4S?=
 =?us-ascii?Q?XChBO+RXLm1PnSCkHi3zI7Sn6jW8AqsN7o1x?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 11:45:28.7130 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78f3e5be-949c-4852-be03-08dddbf13b81
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4209
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
 drivers/net/mlx5/linux/mlx5_os.c | 3 +++
 drivers/net/mlx5/mlx5.h          | 1 +
 drivers/net/mlx5/mlx5_trigger.c  | 5 ++++-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index 696a3e12c7..b8d75a97e7 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -3216,6 +3216,7 @@ mlx5_os_mac_addr_remove(struct rte_eth_dev *dev, uint32_t index)
 		mlx5_nl_mac_addr_remove(priv->nl_socket_route,
 					mlx5_ifindex(dev), priv->mac_own,
 					&dev->data->mac_addrs[index], index);
+	BITFIELD_RESET(priv->mac_pmd, index);
 }
 
 /**
@@ -3243,6 +3244,8 @@ mlx5_os_mac_addr_add(struct rte_eth_dev *dev, struct rte_ether_addr *mac,
 		ret = mlx5_nl_mac_addr_add(priv->nl_socket_route,
 					   mlx5_ifindex(dev), priv->mac_own,
 					   mac, index);
+	if (!ret)
+		BITFIELD_SET(priv->mac_pmd, index);
 	return ret;
 }
 
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index c08894cd03..50ed46540c 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -1976,6 +1976,7 @@ struct mlx5_priv {
 	struct rte_pci_device *pci_dev; /* Backend PCI device. */
 	struct rte_ether_addr mac[MLX5_MAX_MAC_ADDRESSES]; /* MAC addresses. */
 	BITFIELD_DECLARE(mac_own, uint64_t, MLX5_MAX_MAC_ADDRESSES);
+	BITFIELD_DECLARE(mac_pmd, uint64_t, MLX5_MAX_MAC_ADDRESSES);
 	/* Bit-field of MAC addresses owned by the PMD. */
 	uint16_t vlan_filter[MLX5_MAX_VLAN_IDS]; /* VLAN filters table. */
 	unsigned int vlan_filter_n; /* Number of configured VLAN filters. */
diff --git a/drivers/net/mlx5/mlx5_trigger.c b/drivers/net/mlx5/mlx5_trigger.c
index 6c6f228afd..cbc91be3b1 100644
--- a/drivers/net/mlx5/mlx5_trigger.c
+++ b/drivers/net/mlx5/mlx5_trigger.c
@@ -1813,7 +1813,10 @@ mlx5_traffic_enable(struct rte_eth_dev *dev)
 	for (i = 0; i != MLX5_MAX_MAC_ADDRESSES; ++i) {
 		struct rte_ether_addr *mac = &dev->data->mac_addrs[i];
 
-		if (!memcmp(mac, &cmp, sizeof(*mac)) || rte_is_multicast_ether_addr(mac))
+		/* Add flows for unicast and multicast mac addresses added by API. */
+		if (!memcmp(mac, &cmp, sizeof(*mac)) ||
+		    !BITFIELD_ISSET(priv->mac_pmd, i) ||
+		    (dev->data->all_multicast && rte_is_multicast_ether_addr(mac)))
 			continue;
 		memcpy(&unicast.hdr.dst_addr.addr_bytes,
 		       mac->addr_bytes,
-- 
2.34.1

