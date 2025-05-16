Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5EFC3ABDD
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 07:11:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E99D400EF;
	Fri, 16 May 2025 09:11:50 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by mails.dpdk.org (Postfix) with ESMTP id 7925840041;
 Fri, 16 May 2025 09:11:48 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kH4T6v4XQqWy1YRdVvhfrPIKLkifZ44pUKH5bIvNk8tSqSWFPdmA/YA9/HssKIC0AmNJsu37gY7hmwbQ5DAqbp1ecKzm8a8o0256YLM8XE6Q4Lrb4VXcawl6srmrvr9OivpXzA1HdXUoJP3k3J1Op1J+6E57DQvfC6yHoXc0y4sGe8m7IWmARAlD+CDahGvVo5XnF5ceh4mbhL7GDCIwgaXy9iCXC347ZGi1cAkIhT7JRy7ZExGuzPq/O7T8qYwJ7nbKeNVIv5ikv6rxdskYDF377wyq+5lpUemyVidEPhYYNaCklZwjSvLEDfB6zU8fiyCLpQ4EpE1ZOHHOsibGDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1aYkwqgRD6PbDUFn03trv9beqUTelGU3Pg876C+N2Co=;
 b=ZrstLf50R94S0nocSL5OmYJJGDwNtzqot6hNcfS+ZGVGWMgjpPs8UM9YoylCnmQp26whu3f9H0UfJYlxF3fRRmwM7FUJ3mkI4TGuKpVf129BNI/iP/Lq3L6GAqd4NojrFi/TgsG2AxTcg/onQJfEn1BlJn8uOf2yICuKynqvom6hDDoaYuNZP9ej6SlEmpTDCl0OkTu2EQ0lm7bjjL8rNKXBg4hrxJFbE5ulgzYHZsKKPM/LzPf7uvAH+C9s7+rATHyp0TECPdaA6m05xucznhY94g5a1ZHB6xQXbDEeRNAXFU4EeaF2Kc+qs7Qosq/TuG4LFszNcb/UD8K3G5jb7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aYkwqgRD6PbDUFn03trv9beqUTelGU3Pg876C+N2Co=;
 b=U93U6Sieh/WOUmFqxQHCy5ZaGS751Z126YfU0K9w9OAMo6Gg7n3o+4KcrUo3Y9M2GY3uCToE4abJlQtRAT+rTkoWvkjaUEYHVKRK+iM1kqavUh/5sy3IzSFaiAyf0M3wJwVec9E90z7wZ7OlaMbkqPmSTINdqEe3Zu0M2T9RXCOb0uKHH2nnJH+hH6iZAzWbzWbwPD8WZtzQm9iviR1hlG3q3sPNT4JO0DSgVctr7eNsXAEQOJ6tNLMe5AbQle+sE+fpITPCpOZtUjojMO2L3KuUbdF99QT+yaXKb7NVb8Mm/6iwQ5KVYL4QqD2gUGE7wv0jdOsrpQcLlQYLhldqfQ==
Received: from DM6PR06CA0054.namprd06.prod.outlook.com (2603:10b6:5:54::31) by
 SJ1PR12MB6337.namprd12.prod.outlook.com (2603:10b6:a03:456::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Fri, 16 May
 2025 07:11:41 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:54:cafe::f4) by DM6PR06CA0054.outlook.office365.com
 (2603:10b6:5:54::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.20 via Frontend Transport; Fri,
 16 May 2025 07:11:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Fri, 16 May 2025 07:11:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 16 May
 2025 00:11:24 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 16 May
 2025 00:11:19 -0700
From: Gavin Li <gavinl@nvidia.com>
To: <matan@nvidia.com>, <viacheslavo@nvidia.com>, <orika@nvidia.com>,
 <thomas@monjalon.net>, Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Nelio Laranjeiro
 <nelio.laranjeiro@6wind.com>, Yongseok Koh <yskoh@mellanox.com>
CC: <dev@dpdk.org>, <rasland@nvidia.com>, <stable@dpdk.org>
Subject: [PATCH] net/mlx5: align PF and VF/SF MAC addresses handling
Date: Fri, 16 May 2025 10:10:32 +0300
Message-ID: <20250516071032.4357-1-gavinl@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|SJ1PR12MB6337:EE_
X-MS-Office365-Filtering-Correlation-Id: 30be24cf-87bd-4d48-11aa-08dd9448e83b
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?t9NFwKlJu8q7QgZlLiR1BKlDaLVU6EFLijTGet91uDLNAyuQrV3Jv4ixfVhz?=
 =?us-ascii?Q?EWOtEVzT875w0fY3OYWHQgk/KwAmUegFiXeuqZ5pz3Atryk/zzgUBZV0RvMY?=
 =?us-ascii?Q?RDs3QZEseGwp3/rPVjRb8iscbxlrzpgU58u8/PTKa9jJ38tQog/CA9JCalbi?=
 =?us-ascii?Q?9eOUZroUzodetUUOX9Dv3VuR7nV5Hta5xRcdFOiiwJfuKkHIykv0rM0LvEX/?=
 =?us-ascii?Q?MI6OzaXp4+n4gIhjsN9oHpl9EhS3RHIc5RySRh0PD0sAJdg5bQJZlr11tX6+?=
 =?us-ascii?Q?n3m8LawRtqcqyc1bGag7sDAN+0x1d1R5XtDzw+8+rTiE1zepBx30Lgl+29QL?=
 =?us-ascii?Q?Y1vCwfCwSpDV9KbmZpzsceeMCGgI6GFeNgSD0kbdBb0W57amaVVSV05sRqhV?=
 =?us-ascii?Q?878UgHcP8jbqHL+mpmcJ8Zl3o2XJPtrav3Maixko6W62ossK81ljuOY5WRV0?=
 =?us-ascii?Q?/XTw6vPy2qH0FZuyV40OjmvxAaoEDIv9OaAIbXNA4Db4TWzZn4LfJCHWe/Bm?=
 =?us-ascii?Q?iSbGE/jslexsGNwIRXuLSOHpPiw7p8oHXE+MIWDn6QUwKsdWxpdfPYAC4b0j?=
 =?us-ascii?Q?Uxju36TkQ9qshp5Meu5pWB1XkjgRgbeyx1Ri6piM8CvssLQeB/YE+/eXhsFQ?=
 =?us-ascii?Q?U5lWEvEP5z6AVd+R18tgcitc8n7oVomxYhAp+rVMld9LsUSNaLKOrcyrVSeS?=
 =?us-ascii?Q?6eh67Fq86aXOXGL8qOoZRlYScNxZOSRmbQX2USQk/foOdcaZVtXm8Kuc3+jT?=
 =?us-ascii?Q?QvaNUM4cFd17Ju2fMUZYDuVJBVlgXG+rbfbbSP86lOYGHcIqhuPTU32fYxLe?=
 =?us-ascii?Q?9t8xARBEN3yVwabCz28fnwuZ4i1tVk7EDuP3RHgAkvPpXpXZlJN1Pwhp7wCI?=
 =?us-ascii?Q?Jun4gudaDIUqp4YxbcuLi0VwpVAUcq1Fkxm43YVWHtEug54O8ZSaYEtN+00Z?=
 =?us-ascii?Q?gyz2+p65RuElGtDh4JCwkwYqm2xfTTfoGnooGcVL9/4+1V+K/guzUQ7tI8bN?=
 =?us-ascii?Q?YyWJoJu56G2+KkxOBwYatNq0w4GqC5KRzmvZwYN5ULs2g1F8iVZobb7ZGsgY?=
 =?us-ascii?Q?nJJNxbLL9NsFfv06xEF8HLg9Wu2SeWEPFbfo62czzLX2QtuLA6YMepqeaEzz?=
 =?us-ascii?Q?BnEhfo5NPxvJ+d8AdEtIk3GuWqYZ9uhZO2QUfCWv3OSOHBJeATtHpvD1Cclw?=
 =?us-ascii?Q?DF97Tqmt6VqWJZDqqHcBz5bTXJrETCKNTRQPf6B1HH8jdDquAqHrML234sfH?=
 =?us-ascii?Q?NRyiylIMVlPw/46mlaYsCTBhfvtAJF69rqO4czi9eQjdOcQIgIxgCpWI/RDU?=
 =?us-ascii?Q?lqWgwNzBCM4ifudP7zNUgdl/qQOB7efePN2HQryUq7K3MKMi/JN4OYnhi1Ta?=
 =?us-ascii?Q?ztLTdUdVPcHIt3a5gD/OjgNy0s+KR2Yx6F+IGS5dsa45llFEkK23ZY7JwwJL?=
 =?us-ascii?Q?c7B4kXt2O6YhGRv/wfYgNpT94/sWL7/S5COQf3mnV+hrVRFGsYGJkabhcOsf?=
 =?us-ascii?Q?jsZuAlrEaFIV2LUy8WZ9P0ZTm9FctzhldCzJ?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 07:11:40.9855 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30be24cf-87bd-4d48-11aa-08dd9448e83b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6337
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

In the mlx5_dev_spawn function, the Virtual Function (VF) synchronizes MAC
addresses from the kernel using netlink. It queries the netdev-configured
MACs and populates the list in the PMD device data, including multicast
MAC addresses. These addresses are later used for control flow creation,
allowing traffic for the listed MACs to be received. However, the Physical
Function (PF) does not synchronize with the kernel and thus does not add
any multicast MAC address rules when enabling traffic. This discrepancy
causes the IFF_ALLMULTI ioctl code to malfunction, as it fails to disable
all multicast traffic, leaving the VF still able to see it.

To align PF and VF behavior, only unicast MAC address flows should be
added.

Fixes: 272733b5ebfd ("net/mlx5: use flow to enable unicast traffic")
Cc: stable@dpdk.org
Signed-off-by: Gavin Li <gavinl@nvidia.com>
---
 drivers/net/mlx5/linux/mlx5_os.c | 3 ++-
 drivers/net/mlx5/mlx5_trigger.c  | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index 573e846ed2..696a3e12c7 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -1603,7 +1603,8 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 	eth_dev->rx_queue_count = mlx5_rx_queue_count;
 	/* Register MAC address. */
 	claim_zero(mlx5_mac_addr_add(eth_dev, &mac, 0, 0));
-	if (sh->dev_cap.vf && sh->config.vf_nl_en)
+	/* Sync mac addresses for PF or VF/SF if vf_nl_en is true */
+	if ((!sh->dev_cap.vf && !sh->dev_cap.sf) || sh->config.vf_nl_en)
 		mlx5_nl_mac_addr_sync(priv->nl_socket_route,
 				      mlx5_ifindex(eth_dev),
 				      eth_dev->data->mac_addrs,
diff --git a/drivers/net/mlx5/mlx5_trigger.c b/drivers/net/mlx5/mlx5_trigger.c
index 8145ad4233..485984f9b0 100644
--- a/drivers/net/mlx5/mlx5_trigger.c
+++ b/drivers/net/mlx5/mlx5_trigger.c
@@ -1714,7 +1714,7 @@ mlx5_traffic_enable(struct rte_eth_dev *dev)
 	for (i = 0; i != MLX5_MAX_MAC_ADDRESSES; ++i) {
 		struct rte_ether_addr *mac = &dev->data->mac_addrs[i];
 
-		if (!memcmp(mac, &cmp, sizeof(*mac)))
+		if (!memcmp(mac, &cmp, sizeof(*mac)) || rte_is_multicast_ether_addr(mac))
 			continue;
 		memcpy(&unicast.hdr.dst_addr.addr_bytes,
 		       mac->addr_bytes,
-- 
2.34.1

