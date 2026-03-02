Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A62FE9B36A
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 11:36:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 496BF40E2C;
	Mon,  2 Mar 2026 12:35:43 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012018.outbound.protection.outlook.com [52.101.43.18])
 by mails.dpdk.org (Postfix) with ESMTP id 132AE402B0
 for <dev@dpdk.org>; Mon,  2 Mar 2026 12:35:42 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kEjmfTX12XlSAk2oUfxTgYRluktKtRmGZCOAET4AZmnUYesp3gPq7CiGS42HRLoPKLje65RtnEDGO0S6/4XncroKxI9H8iYrRSRLJ6juvCDOCAjHakES97rI1mmImxWiBEdrnJGidVtWmok3OJ/1IoJztNYfVQtJV+d+SLXLzsaxaVxGI6sDCk0Vxkytozlqp4JC11NXegtvo98nYEBLegVJjV7/edrDIKVtpwKWZzd3nAZ5f655bFwBkNtANhGeGsCsUtqsEAeSEPvvv9TeLXV0NTsew6kMw1BlZdroeZG2t08pniN4ApDDhlZVIxhNMx7xRZhZhzMqoZmhbpYqOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfI1rzKCgqQP7OjmVYlvvD6ZSHCLD9al09a5+xOjEcE=;
 b=Z5d4/U7kXrOvhT4CMEG9B2rxGEhicVlfLKBwEHb+LvSyxnXNsROUonDbimuaVbiC3Cu5kV6tsZ4VqMauzWteVlNl1uGfBmorO7IxmCTDeW1lNX+UZKzym2EhQZ2mXb4NUjifR5wO4ax3tDxtiAqOkpf2jwjbf/N9lj+iqY7ntXjVYG5CmaIM1JOWxMNyQMHHIg6LEqISe/hpYz41u28dLOUoX8el6U7WUiUv1fI7vjAlI+2L2e/aJ9UDK0CCzo3yEwXdOfuzNuc3ah88yX2Vst0Wykz4mg/Z2ECm2FNcARw+xkb4qIFDcBNwhYGS5CLMfaxiSS2s+nrAuWk1VX8bew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfI1rzKCgqQP7OjmVYlvvD6ZSHCLD9al09a5+xOjEcE=;
 b=otLYeHuBbl4w0Lnw02t/59L8EsIEXp1vfeXd+KRJvHEETRdo9BZXOZTGUCLedzAv+sZhEj2ISoh6g5av/8kkgqu4pGFliqhkTGaUrIwZX63hbgZPvujYcSST5YHIZDPwRKGSe2fIpcX9eqL7rPhiT2viRwm0lQ9Tx3yDbNkaWGSML/AFr94JbV0gYLFM+/WiiY1LNBM6USUGN0XQBn4ydoGUqlZCBQQVp3HXDsDnqNsBZtNIf8wVVCg2nlXZGy/O6TAWbwJsHlfTDRoYag22wGjnys4t/WjEq5jiCYJpyIucGxFR5Hjl32O7gOh4W2+u1w2raL0oCOi9NY8xbhOOtg==
Received: from SJ0PR05CA0081.namprd05.prod.outlook.com (2603:10b6:a03:332::26)
 by SA5PPF8ECEC29A9.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 11:35:36 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:a03:332:cafe::2c) by SJ0PR05CA0081.outlook.office365.com
 (2603:10b6:a03:332::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.18 via Frontend Transport; Mon,
 2 Mar 2026 11:35:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 11:35:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 03:35:15 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 03:35:13 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: [PATCH 5/5] net/mlx5: build port name dynamically
Date: Mon, 2 Mar 2026 12:34:43 +0100
Message-ID: <20260302113443.16648-6-dsosnowski@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|SA5PPF8ECEC29A9:EE_
X-MS-Office365-Filtering-Correlation-Id: 86e7f85d-4588-49ba-6603-08de784fd2b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: P2djIBGOi3vTwU2jeBQZ913Uz6JcE20Ys9j7D5BalOBqSAn9c6gjYRhjA7QhFLHfWYhCiMQ9PUyWzKWDuTaa8LAjkcPkwzB42iEwB8jQYme2wiZUpdILnzgvVWYpkvYKZx29Iz0TjE4JQOEqC4/n3NRtTd45R+a/L6wa6+AOqNb8/oXrsKUrOvVWkrf50ZQ/IONrBuBxIEkBoE7BZeGBawA1mIgx21ovkT/vjJK/hWyfLBXaGMjSMJBOVO8chaNs6uHIcP/7x0GpzNQwkdE0XF6783DtDzOAWfR1dvKJxvPex0Swhunjbqhcq4vAfvnHHQZ0y3u4XNf1bnv5V7r6ad44upzbVaRRR22PAG4UhNxE8ZSp8BPyMlqhZWqWlEd6sn7z1LEi6fJjQKIVwKdtKwkVRXTQlIDm+BA21ZbPPM8TZqmFu9Md0uPzXQUNUqrPdxEPHRSF2vuhnmGrKYU5lCBb0fvRQ41vEIC+SvgC+CXVD50BBucjWqI2QXjeYhPIaNk2Vk/yLBUSz1MjrVhDXcSi5fEbflGb6eVd8lhiC/HO3pTSgYXmFT9bYufzc/j0QZc8VKLWYBpZV/RzOdh6Df4fWtnRO4rqVKL7GKRJjMIBJf4d0UfRiSDnjmb2dypLmW2i2X0qw8KAXAR7bSVjKRY3Z8A31UOdMzsFMA2HY//VZPbelueW5kdBsVphIhmfxxFqPQCUUhSUesetuwtlB0bFmRosXzQHaF+BFxu0yuEcZE5gRbGSAE/JPwLzxrks6C0cgTVllFnJx+4f+D2D6eSjZZZvk34NV1HalnCsruHSmaGZVl7uacjecrDvVNWFO1Zd8G8TJmy9FNhksxcAcA==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 87HOfFMdfySUiclpBp1leaP2ZMYlH/hwFlwZt7MLYcLpFyYoIXyHt1iIXXcwHz8M62C+aBAMMIXqXvry9qqlHQPorLIYCtEHqhaMT9tc2Md710aZnhokD5zfNqS8ratiqBKYhFQMO0vNA20QUZ0iD055ystyvl1IVVPLiihiX+Hhz96t/8doB9EsihhTKd4Gk2m5x7Ive+2PQLJsf8DGQG3hZihHnATgI1Cm5IC/kIZTCCaFTsXEhi1wSOLAiEee6wy0ReZ/h1IELPt9/1XSjmD5uRby/bZhx5f2euo6yhDVEz287oVE/lxTsyUhvtnX+U6RMF9ufA+4tYPbkT8ywOzTUn3afRCHDOCJ0tq6Xlljy7QUlEtWbvVGqbMCOVYvkN+yawELbFWmBFtEc5uH41sqvjeIyPfmQplUvv+ZJ7XW9ijVXNTCnrh8ePt2S6GU
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 11:35:36.5726 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e7f85d-4588-49ba-6603-08de784fd2b6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF8ECEC29A9
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

When new mlx5 ethdev port was spawned, the port's name was generated
based on specific type of setup the port was probed on.
The types of names however were identical in each case.

In order to prevent future changes, which require adding
specific cases for new specific setups, this patch reworks
the port's name building logic to be dynamic.
This logic will be based on information independent of setup type,
such as:

- number of uplinks (physical ports),
- number of host PFs (host PF representors on BlueField ARM),
- whether port is an uplink,
- whether port is a representor or not.

This patch keeps addition of IB device name in ethdev port name
in case underlying device is a LAG, for name compatibility reasons.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/linux/mlx5_os.c | 122 +++++++++++++++++++++----------
 1 file changed, 84 insertions(+), 38 deletions(-)

diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index d30106c4c5..324d65cf32 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -1068,6 +1068,84 @@ is_hpf(const struct mlx5_dev_spawn_data *spawn)
 	       spawn->info.name_type == MLX5_PHYS_PORT_NAME_TYPE_PFHPF;
 }
 
+static int
+build_port_name(struct rte_device *dpdk_dev,
+		struct mlx5_dev_spawn_data *spawn,
+		char *name,
+		size_t name_sz)
+{
+	bool is_bond = spawn->pf_bond >= 0;
+	int written = 0;
+	int ret;
+
+	ret = snprintf(name, name_sz, "%s", dpdk_dev->name);
+	if (ret < 0)
+		return ret;
+	written += ret;
+	if (written >= (int)name_sz)
+		return written;
+
+	/*
+	 * Whenever bond device is detected, include IB device name.
+	 * This is kept to keep port naming backward compatible.
+	 */
+	if (is_bond) {
+		ret = snprintf(name + written, name_sz - written, "_%s", spawn->phys_dev_name);
+		if (ret < 0)
+			return ret;
+		written += ret;
+		if (written >= (int)name_sz)
+			return written;
+	}
+
+	if (spawn->info.name_type == MLX5_PHYS_PORT_NAME_TYPE_UPLINK) {
+		/* Add port to name if and only if there is more than one uplink. */
+		if (spawn->nb_uplinks <= 1)
+			goto end;
+
+		ret = snprintf(name + written, name_sz - written, "_p%u", spawn->info.port_name);
+		if (ret < 0)
+			return ret;
+		written += ret;
+		if (written >= (int)name_sz)
+			return written;
+	} else if (spawn->info.representor) {
+		/*
+		 * If port is a representor, then switchdev has been enabled.
+		 * In that case add controller, PF and VF/SF indexes to port name
+		 * if at least one of these conditions are met:
+		 * 1. Device is a bond (VF-LAG).
+		 * 2. There are multiple uplinks (MPESW).
+		 * 3. There are multiple host PFs (BlueField socket direct).
+		 *
+		 * If none of these conditions apply, then it is assumed that
+		 * this device manages a single non-shared E-Switch with single controller,
+		 * where there is only one uplink/PF and one host PF (on BlueField).
+		 */
+		if (!is_standard_eswitch(spawn))
+			ret = snprintf(name + written, name_sz - written,
+				       "_representor_c%dpf%d%s%u",
+				       spawn->info.ctrl_num,
+				       spawn->info.pf_num,
+				       spawn->info.name_type ==
+				       MLX5_PHYS_PORT_NAME_TYPE_PFSF ? "sf" : "vf",
+				       spawn->info.port_name);
+		else
+			ret = snprintf(name + written, name_sz - written, "_representor_%s%u",
+				       spawn->info.name_type ==
+				       MLX5_PHYS_PORT_NAME_TYPE_PFSF ? "sf" : "vf",
+				       spawn->info.port_name);
+		if (ret < 0)
+			return ret;
+		written += ret;
+		if (written >= (int)name_sz)
+			return written;
+	}
+
+end:
+	return written;
+}
+
 static bool
 representor_match_uplink(const struct mlx5_dev_spawn_data *spawn,
 			 uint16_t port_name,
@@ -1247,44 +1325,12 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 	    !mlx5_representor_match(spawn, eth_da))
 		return NULL;
 	/* Build device name. */
-	if (spawn->pf_bond >= 0) {
-		/* Bonding device. */
-		if (!switch_info->representor) {
-			err = snprintf(name, sizeof(name), "%s_%s",
-				       dpdk_dev->name, spawn->phys_dev_name);
-		} else {
-			err = snprintf(name, sizeof(name), "%s_%s_representor_c%dpf%d%s%u",
-				dpdk_dev->name, spawn->phys_dev_name,
-				switch_info->ctrl_num,
-				switch_info->pf_num,
-				switch_info->name_type ==
-				MLX5_PHYS_PORT_NAME_TYPE_PFSF ? "sf" : "vf",
-				switch_info->port_name);
-		}
-	} else if (mlx5_is_probed_port_on_mpesw_device(spawn)) {
-		/* MPESW device. */
-		if (switch_info->name_type == MLX5_PHYS_PORT_NAME_TYPE_UPLINK) {
-			err = snprintf(name, sizeof(name), "%s_p%d",
-				       dpdk_dev->name, spawn->mpesw_port);
-		} else {
-			err = snprintf(name, sizeof(name), "%s_representor_c%dpf%d%s%u",
-				dpdk_dev->name,
-				switch_info->ctrl_num,
-				switch_info->pf_num,
-				switch_info->name_type ==
-				MLX5_PHYS_PORT_NAME_TYPE_PFSF ? "sf" : "vf",
-				switch_info->port_name);
-		}
-	} else {
-		/* Single device. */
-		if (!switch_info->representor)
-			strlcpy(name, dpdk_dev->name, sizeof(name));
-		else
-			err = snprintf(name, sizeof(name), "%s_representor_%s%u",
-				 dpdk_dev->name,
-				 switch_info->name_type ==
-				 MLX5_PHYS_PORT_NAME_TYPE_PFSF ? "sf" : "vf",
-				 switch_info->port_name);
+	err = build_port_name(dpdk_dev, spawn, name, sizeof(name));
+	if (err < 0) {
+		DRV_LOG(ERR, "Failed to build port name for IB device %s/%u",
+			spawn->phys_dev_name, spawn->phys_port);
+		rte_errno = EINVAL;
+		return NULL;
 	}
 	if (err >= (int)sizeof(name))
 		DRV_LOG(WARNING, "device name overflow %s", name);
-- 
2.47.3

