Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E43BE9B36A
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 11:35:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64F1C40E1E;
	Mon,  2 Mar 2026 12:35:30 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012007.outbound.protection.outlook.com [52.101.43.7])
 by mails.dpdk.org (Postfix) with ESMTP id 76EFA40DFD;
 Mon,  2 Mar 2026 12:35:26 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lf335o9zCIe0NLCQtsNGOPfgelTHi4CnqqshMvD1mpLr0xKlSUk7Jg7iMwpz4wBXcbDIP9kdNWDuMQcJbbAmi9MY2tgZQxr44nXqVGX06iH/yfjTvXmyMCBCp4uWpFHtax9zZHN53DYFijG67mkxG9mFQvHCX15yUjVyXoGdT8lDcvJf1ksCCmMOmsm0W6GiA/sO2gzVECTM8+JgcO2DENcSBEFhGXhzRg6IHrRWbuCBh4iQNlzAlMY7GBRTrf4nr8ON8VdBgUFGA/zdw4r6//k0VGMaidohX9gx84FlhKkDE2Ef3qrotgaZ0XD/0/HUJH+eUvF/ZhLr/YeAIcS8gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxI+dR26qjxICRmdk/QRiWM5mR6VblDYBf+RDpwuTzA=;
 b=t/o/OUsR9epWmqYy555nE6aUqEq4HhOdE5eVGTceYeNtwWO1Dq4nKopE2m/ktGpJeHwplqDThSGuZkKglk5/PzoeYHB4FUWhxRSSR69kMeWomoI2cdfW5YxJkbSkekoAfg7m7hqYuogCEkYgyZrm/kkk5jLD5+KbuwTa+tedKhqKVK7vDkxUG1soBfMpMRXv79Dxt1lfhMjEH6Zbb8YG2tBx587xKYShZDKNQGafYyn6s9fQ4VR3/V9RcUC0nrNJglk74IyYi0Sq2BBtpwU99QqJ7pck/Wcx9UQYXBWnKp7mlsuomWdtd7yqyEW98rL05336w1FQuwHEZAKHrbTBJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxI+dR26qjxICRmdk/QRiWM5mR6VblDYBf+RDpwuTzA=;
 b=lIMVGEVXP1luB1BpE+fcBSCxA7t9vCO9/tsWOUiuEJVg59x3X0gBr5fVUdaxa9Gj+rdAVeBni2Qq4OPTQWthnavMfzLcne0n+H0DELE8XSxt3LVRyYF6KpG7XvNQLEBeljvm1i/jfQVKx2Egrf9aJHMQcWkSY3vUomZQX6Ifsag40WXuSikjZzWtckMObrXmQkRncZ/YqL6usg9OU3SOyop5vjYalG+kLjHWVBwbXG+Jd52RNEsgLmb80/eER5Fotov8W84ZxEbij5yvLoska7dskDcD+5EqpBwegqZiupnRjl5nnSK4+JUNH7UBxjETLhJZjnQeQJt/yiqXSSTXCw==
Received: from CH5P221CA0021.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::8)
 by CYXPR12MB9387.namprd12.prod.outlook.com (2603:10b6:930:e6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 11:35:23 +0000
Received: from DS2PEPF000061C8.namprd02.prod.outlook.com
 (2603:10b6:610:1f2:cafe::d4) by CH5P221CA0021.outlook.office365.com
 (2603:10b6:610:1f2::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Mon,
 2 Mar 2026 11:35:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF000061C8.mail.protection.outlook.com (10.167.23.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 11:35:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 03:35:08 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 03:35:06 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>, <stable@dpdk.org>
Subject: [PATCH 2/5] net/mlx5: fix bond check
Date: Mon, 2 Mar 2026 12:34:40 +0100
Message-ID: <20260302113443.16648-3-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260302113443.16648-1-dsosnowski@nvidia.com>
References: <20260302113443.16648-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C8:EE_|CYXPR12MB9387:EE_
X-MS-Office365-Filtering-Correlation-Id: dea2b04e-9502-4523-fc76-08de784fca25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: vADwOxlQkGLCb/FQALeNer9KksP3sYRlHI5M0IY7PGpcWNXNpDtPoTRP523TSSEiGYougShiDbIm7TpuKFQaQZ5GPfvDCP1ELo7AZhTbxhQjgzMgM1CcBj9AKT2eFoFGTTnIIual8CdCcz93qj0itYv5DC18zRTzV24FhkI58qQ6hoqbIYq/whSI+sgv1UN+xm4JEiWKtxyDoQk7i/OJfevySAWlEfa17G6PJloGheKRW4V5QdgpIpmKPNrepz/TibUDYhu56ImwqR/VplYaH6mOSchfFFYleUgYhC5PV8bafsvr4rCdK/fFm4P+IMOw6fiQCDDw+7uzvz4dCFixIuYVEPZyGym8De3IsGccCiJhonhDyFvIf6M+BLJZzSO1EOdDZak2k8pegbGATp8RtmwS5K0a+FNg/dQk+aNvhGoj2+QlIsW8l8FPaAV5tCLUKilGRwstxnaGU3iljuD5OOGoOHFSEcG/f6SMxkW68l6S/VXKg5QkuUm1OkEOujtxClZmiT3NJDQQXNVRQzrI3E8zuKa3iUKas1BMPX4Yu1hRYmtTacVONXLb4205hol5ZFZe6YU1XlBclVzyCQOxHetmNDe587HrsstVe+QFJkqFAPVcGMhgO2Q8/15DQfMPiWTAbUmPF4aYEY3RzPVdTwUiqhz1U0eHgQVaKKzwpVEBliNkMc+GHA4IvTttFyB1i3cJLzdnnqmMj3hXbfiG6VD8ONiCUnrAijkD3XZIqUawMGWUSwcPEbOitFG4OeKHpnmGoVIPjoqpn+3+Lg+avDEMTHUJXnY1AVBE1uux8kqp3KmJMBUiC2apiQVbjN+Y9PEJpLe/QIpXRo8Fj1tkIA==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dEP+9GCE0NBVGeh1sLSqwdGoI81HIojC+a/tiJfJhtN8wj5t9bWHCo8mz27Lgj5PWm4tyBmLqUsPi5d8EbRyDJmetwYH+rKSw1dd7244J84nGyV7eyyG7oyId9o9Rj5Vm7PTm8LVCxT8roYwkk5V1fyMqZxx26yaBUwutuBQYUcWCbF330zOHGg42KjL5bc7NUq6gSHHfMibYvvTBw3FMRtRX0gvpeOHYk1txkZz74kGvHw9S5iKMN6or/EnURUzmxkDHQa97dafSMr8hc2CrN/XfgiMryUZjfQzdMpTVE82CI49DrorpJ/McF3yJTA1eFeB6Jv92j2uyNpIXgsnmB5uuzNNJVdRwCpp5PvZrX3UqkmEbqznTntc6J45yXVtnAm26rnYjEWP/GcNylJWJFQAH+WlsRBJ0+HlnYyiDO2xtNR8QbhJ3afUbWRLUr9U
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 11:35:22.1008 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dea2b04e-9502-4523-fc76-08de784fca25
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9387
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

mlx5 networking PMD supports probing ethdev ports based
on LAG configured on Linux kernel level.
In such cases, a single IB device is created in the kernel
and mlx5 PMD configured the device through this IB device.
In order to recognize whether PMD will run over LAG device or not,
mlx5 PMD relied on IB device name.

This patch fixes mlx5 networking PMD logic to rely on
mlx5_os_is_device_bond() introduced in previous commit,
instead of relying solely on IB device name.

Fixes: 2e569a370395 ("net/mlx5: add VF LAG mode bonding device recognition")
Cc: viacheslavo@nvidia.com
Cc: stable@dpdk.org

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/linux/mlx5_os.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index 76edd19c70..405aa9799c 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -1928,8 +1928,8 @@ mlx5_dev_spawn_data_cmp(const void *a, const void *b)
 /**
  * Match PCI information for possible slaves of bonding device.
  *
- * @param[in] ibdev_name
- *   Name of Infiniband device.
+ * @param[in] ibdev
+ *   Pointer to IB device.
  * @param[in] pci_dev
  *   Pointer to primary PCI address structure to match.
  * @param[in] nl_rdma
@@ -1946,7 +1946,7 @@ mlx5_dev_spawn_data_cmp(const void *a, const void *b)
  *   positive index of slave PF in bonding.
  */
 static int
-mlx5_device_bond_pci_match(const char *ibdev_name,
+mlx5_device_bond_pci_match(const struct ibv_device *ibdev,
 			   const struct rte_pci_addr *pci_dev,
 			   int nl_rdma, uint16_t owner,
 			   struct mlx5_dev_info *dev_info,
@@ -1968,9 +1968,9 @@ mlx5_device_bond_pci_match(const char *ibdev_name,
 	memset(bond_info, 0, sizeof(*bond_info));
 	if (nl_rdma < 0)
 		return -1;
-	if (!strstr(ibdev_name, "bond"))
+	if (!mlx5_os_is_device_bond(ibdev))
 		return -1;
-	np = mlx5_nl_portnum(nl_rdma, ibdev_name, dev_info);
+	np = mlx5_nl_portnum(nl_rdma, ibdev->name, dev_info);
 	if (!np)
 		return -1;
 	if (mlx5_get_device_guid(pci_dev, cur_guid, sizeof(cur_guid)) < 0)
@@ -1982,7 +1982,7 @@ mlx5_device_bond_pci_match(const char *ibdev_name,
 	 */
 	for (i = 1; i <= np; ++i) {
 		/* Check whether Infiniband port is populated. */
-		ifindex = mlx5_nl_ifindex(nl_rdma, ibdev_name, i, dev_info);
+		ifindex = mlx5_nl_ifindex(nl_rdma, ibdev->name, i, dev_info);
 		if (!ifindex)
 			continue;
 		if (!if_indextoname(ifindex, ifname))
@@ -2396,7 +2396,7 @@ mlx5_os_pci_probe_pf(struct mlx5_common_device *cdev,
 			info = &tmp_info[ret];
 		}
 		DRV_LOG(DEBUG, "Checking device \"%s\"", ibv_list[ret]->name);
-		bd = mlx5_device_bond_pci_match(ibv_list[ret]->name, &owner_pci,
+		bd = mlx5_device_bond_pci_match(ibv_list[ret], &owner_pci,
 						nl_rdma, owner_id,
 						info,
 						&bond_info);
-- 
2.47.3

