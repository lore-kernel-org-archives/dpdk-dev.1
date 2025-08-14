Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DA4CA0EDC
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 10:09:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A390E42707;
	Thu, 14 Aug 2025 12:09:51 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by mails.dpdk.org (Postfix) with ESMTP id C94F44026D;
 Thu, 14 Aug 2025 12:09:50 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dg2zQOxOIhfK/yUA3lYjFWCtd8yGdNrmRp1qguVWjGNNevUJwa6QA3ztnYls2096/zeEZ+W+ork0dWmBkJhA8mLrQiPO4AEFCUQQjDQZR1lma9xjz0ZGR9oCsv0SBMPLPftBHfGRsqVEYLG7kjBecFUx2EqpY1BwdIPLJmxhnclgV79cQIWivsfnDnLQxE7Mvo+hZQ1Tl0xTD+ue4HhyVlVkGycKgW1YKVDPsvQyNbBFekKnWCyUc4dBhiIYGTbnSePKXcAZgptYty1RDbRMCCVAdqd142Xf1/XtW9Rn0u7/e4IRvQaNr8ezcoAsHA5kFiH4Xv+jwA9b4NJMLn/cUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJxyMTlXyJrncss8HhzsXVCM8M9TLd+CfyNsgGun9lw=;
 b=eySGoC9hl9xutlGTsF15bbbUlDf9wcy8MPe0FcckwKtoBDf8wV+/1CyHO/cgP5m6X01Et6OsIgjVBPSyXip8YMvim5m2WNZcRKhQ/797sqEnCqO2WV78dQi02FtAKXFjJtxXXZ4mDJXCm5OW5/OM2X6p2QSsZUYTBvW2Ui2pF9+0kotC+ytJ/BtQIL229xQmQNdaDrFUx/4J0nf3Qp1c3xO89pvx0krpMrZ1pup42zRoTjSqYQ9A0XZy4UsKMmz9/J4p0KzXJnORngzaA6E88CHdVzf6fcAeQRGzvLBpHz9hhhH+U0fjGTUMm0ZSCpeXHoAxYjxVL+ndRJzts4b9Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJxyMTlXyJrncss8HhzsXVCM8M9TLd+CfyNsgGun9lw=;
 b=lSqT38kXX7FEjILXAvEC1nzol1BR2GIlFwUEuo6Z1NHzEmpyvBn5Nj8VJyf3OpbCF6oy/q7r9VYi9PAJWvysaOPbDMJrXoy6tLvbBIJSE8sD5ZX3kdeMmzhRZb9DvJ/GjmuFvyLwRedWft0lnOXizP2QN2a7QtT4Lhpdb0ikK9DbLP1De0ywmteYTf+r1cpc4vqZZP+6iSqO8BE3rYI6zq2D36VgDWq21yN8WCM1g2CahdooPluKaunpY86wZNVqaN+J+Enes/PvLjz1wBZbJcdVbA7eiU41CoM3ABlvY9AVNojjtjj1XYymagLHAwe35astrVIyZ3Y9/rr58LgwKw==
Received: from CH5P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::10)
 by SN7PR12MB7273.namprd12.prod.outlook.com (2603:10b6:806:2ac::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 10:09:46 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::f8) by CH5P223CA0002.outlook.office365.com
 (2603:10b6:610:1f3::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.17 via Frontend Transport; Thu,
 14 Aug 2025 10:09:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 10:09:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 14 Aug
 2025 03:09:33 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 14 Aug
 2025 03:09:30 -0700
From: Gavin Li <gavinl@nvidia.com>
To: <matan@nvidia.com>, <viacheslavo@nvidia.com>, <orika@nvidia.com>,
 <thomas@monjalon.net>, Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, "Minggang Li
 (Gavin)" <gavinl@nvidia.com>
CC: <dev@dpdk.org>, <rasland@nvidia.com>, <stable@dpdk.org>
Subject: [PATCH V2] net/mlx5: add support for flows targeting multicast MAC
 addresses
Date: Thu, 14 Aug 2025 13:08:15 +0300
Message-ID: <20250814100815.801132-1-gavinl@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|SN7PR12MB7273:EE_
X-MS-Office365-Filtering-Correlation-Id: e853f68b-55c4-4d38-b260-08dddb1ab179
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JV6rADHsVlXVnKsC2kt4Kuq8vdwNqQ2xQ/+1qT3H/E5NKT86NATgeZ8ggCl6?=
 =?us-ascii?Q?91sYgIdT3k7eBgP59wVMVeKRXnQgbfSiV86qVksbdhIzW3uJ1KJKxVN2NSON?=
 =?us-ascii?Q?y3eFGX2uC2xJ8mM5ylWufa/TqUuYkr5XpL/yICljlev/2IR5Sm38xxGxzmrG?=
 =?us-ascii?Q?Mx0/pCpdIpT6IAUPnMK6SHEowkpzdyj2osq3IDeha0ffSTLGgFyVpYRuGaha?=
 =?us-ascii?Q?/eNWxK0CBDtpVn02oERUSJoLcys18NliUfcFJARmwf0PG8gh0A53JerMr8pY?=
 =?us-ascii?Q?sDVcUmuqWwZ8S+zcz4sOz0IKaycaKxhaSlb2XjF+VCH3yzZFdtiRfgWy8EDe?=
 =?us-ascii?Q?iCMDNYTdAWgi/GwqKpxXfhE+1X3La1U+rbxC8tvdm5YSm/iOv/flod5oBusD?=
 =?us-ascii?Q?KaeBua2Lc/LqGaxJU5Kl8LEt73cQQGR6SZ694p96AK1ErbWCxEo6czFtiMbX?=
 =?us-ascii?Q?cpwSHo8U6gRWuTysK+ZDZdBEWXytcvmqmG48XGx8GDMSo9lq79PM491pYJPS?=
 =?us-ascii?Q?RC5jUnP383Keb1B1QSCmq4KeIryb/VJ18r8Mtp91l5DE6u5Kw61BaGXekGWi?=
 =?us-ascii?Q?nHzm7y9dicv9Uud98Wyyh3U+gh/ClJMW3st6WvHA5Fvyejvm6uCi8NvlNOnT?=
 =?us-ascii?Q?AJs/t0pV4/C0j+mVl+v3V5GGp15Yzl9DX4HjJsm8OhGSMj7u1KpusRxU3oKi?=
 =?us-ascii?Q?3WDDGH90K6mn+Nite3A53RF4JueiqxmEcyefcSU067txR8L37eW1Jn9zWx+X?=
 =?us-ascii?Q?h2XCOucfoS0z7wD5UpdvXD3mm/UHm1XbKeE/uGF1zCOFaghyOOTt/kGsGiTr?=
 =?us-ascii?Q?mimsPtONyNUkgdS+dTu1RpQU+v10cyf2iIB/A63VrVADf5SwcQBzBUNVfzBG?=
 =?us-ascii?Q?xXZ3ByhlLDsw51BDXym4ErcJUdB7QJ4sW6pELBG00cCv+eV8c2YxWJDQLKq6?=
 =?us-ascii?Q?JbpX+XL0V4CdzSKec/r4lwHEf5ojbNF84J1zc5xQPxiBumZ9QgCPwAWEGTNQ?=
 =?us-ascii?Q?6iSYgpm4GBASJX9MbCba+hKm3OgaatnWoDbK7EavbCHaDBDKfalrg3SmD1MH?=
 =?us-ascii?Q?4YFdv/1LQnUNjvk9FPtSV++AoCVHdP/dr5rfjaWyrk0s0B2ybJPwS+NtbDcw?=
 =?us-ascii?Q?6jtF+lQZ5KSQT68UQZkEso3E9v1eAY0J1XA3ukTODjOnxXMv3Gk8yZIx/qIe?=
 =?us-ascii?Q?YEx/crG9gC+I9yLBXSYwqbBxfBMPn3CWFOsKr6Pbaaewnp3jTdSH34ICOmNH?=
 =?us-ascii?Q?5GIxOGG2nSUgXN1uAiMdqwddHOPfrfRSd+HdZdX5FEb2Gd2jq3kLTmJrcu60?=
 =?us-ascii?Q?0ic3WMBBwpOz9P2wLbw4roxuz6JzF3E61kJ7gdHomspXjr+rtmDc/FEk6dap?=
 =?us-ascii?Q?COqNyCOf/+k4LnHflBEkh7Jgu1pN2HRVUhHUB9jd965V29+ByZf8yzRZvbK+?=
 =?us-ascii?Q?iwQyBgTk0ubZBnB6uLr+juxNhK7Cm4jyil5cHx1hTXvv/+T9pfDMqcgDwdwS?=
 =?us-ascii?Q?YuiVdLj0I+0nvtUXW/V+KvFGYhao2A7hx1v3?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 10:09:44.7949 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e853f68b-55c4-4d38-b260-08dddb1ab179
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7273
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

