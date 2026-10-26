Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3959A606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 16:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YRUfZ4kU
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 625CB402A3;
	Mon, 26 Oct 2026 17:28:23 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010007.outbound.protection.outlook.com [52.101.201.7])
 by mails.dpdk.org (Postfix) with ESMTPS id D1B18402A3
 for <dev@dpdk.org>; Mon, 26 Oct 2026 17:28:21 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fHrL6uDbxz8G2Un4oZpekhEN6vkwEWfVtq7rnI6FrQotHOKC7ecRd+0pPCGCwFl7pw52rqnlkuHdTV+92P/l1etZpE3RBzmXz33Z/KdRyETxGnGWgkBqGINrlbEWranU/fNML5oChndYXVoiCYnqlwidEvx1F3djdvl4HlhclffvAkYPoy0uzNTt7anA+J+OH7WBT+CC9qwl1Z2e2YeYsP7GU/JAWxF7zp/Uid++TE/0z623PgONj9wYEeUbuKBpU3rXR4n9VAKfacJ0AY+tVvF9ftoI+bo0HoLbrBHWZ0vaEoEg+svuwuVQ+m0/7FKUofowUmwDwd9QhtmLwL+iUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XRhnZfmEbvNKdQTLLE4YuAPfQqPJpiYXFoUi5ZaWzFw=;
 b=V8JjuNXVKo5bpzJoORHVVZkNXAw/evooBZvMcwVVxHT/Hp64vEO/W75jw8/+luL2CNBmxVBw0PyK3aFHqtIsOJ1Tv4GqfptRZDLwtygLamO+tmlfQ0XQbqPs1ny/FYUbX9jC0LPKFUJo4mhFLhk5LLHQsnrbfyAXiANp0WxrNPjvuYc8AM1wtAQg2n9oA43TnaXciOsWQkuO9feMHIAAfMLP/aCuDw7v6XUZ/oUljNRN8Y5E0nH/UcUtJHKXRWJGpFKAVxe08krDO2vMTIFvIywiivgIspRDBzMyhcZ7Sf31Ule1CtwJKzLsURq6Yu5PZnihxCUZRVHxZ28HMHSgIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRhnZfmEbvNKdQTLLE4YuAPfQqPJpiYXFoUi5ZaWzFw=;
 b=YRUfZ4kUqDCkV0uhVFipwtdGD06tsGxm2wjrO+9aWsJvbA3aBXx0ZjDt+GXAEMfhv/yK4MlT1sA2HY5HsFxEqBOSbbd0dyIyPAddhGAPig2VXmNF5mONuqHcrdRTlzoIwSFYKF6J0AF47qi539Xp83otVfR+kRC2toN6aINs8Agw8krBwLUYVzVTStF4zk4TURqX7kbm2+MUAAuUgSQUSRxRDUAUBBYw5/A2zDoO7Zn0zFNXbNLbegE4sdHOhbBIUDuTblHtKx2e7fnW1+m66o+ERNV6BQIkVfk7eLfCiYYvNs9xKs/2/Ym06VO2df0dCySXyhFG/HBKSy+lWFHnRw==
Received: from DS1P222CA0028.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:44b::11) by
 SA1PR12MB6945.namprd12.prod.outlook.com (2603:10b6:806:24c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 16:28:13 +0000
Received: from CY6PEPF0000004C.namprd03.prod.outlook.com
 (2603:10b6:8:44b:cafe::66) by DS1P222CA0028.outlook.office365.com
 (2603:10b6:8:44b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 16:28:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY6PEPF0000004C.mail.protection.outlook.com (10.167.247.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 16:28:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 09:27:51 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 09:27:49 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>
Subject: [PATCH 13/13] net/mlx5: allow multiport auxiliary device probe
Date: Mon, 26 Oct 2026 17:27:09 +0100
Message-ID: <20261026162709.1292958-14-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026162709.1292958-1-dsosnowski@nvidia.com>
References: <20261026162709.1292958-1-dsosnowski@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY6PEPF0000004C:EE_|SA1PR12MB6945:EE_
X-MS-Office365-Filtering-Correlation-Id: 19bc9990-e89f-4f62-da96-08df337e2174
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|261009223027099003|261021121427099003|261021123027099003|261021135927099003|261022105027099003|10067099003|56012099006|261026140227099003|6133799003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: nSu6CHJ/IN4Vv7Xmy+xBaQ/B20oSfT0MXhr0pZKL5OQxttfnVviuDKbYggPpg+e/VJbtLsBVaX2foIDs6mS8m0BozmkEGatC9yL7V1yJ22wpbPWMWro0f1gsVNTnsPnrzgdBB/jogYBbiCJLC1Xi6EXuSghF9WhLX6SPmz3GyKBCN/YoaIQfFLOE+hwdSJJpNlW0a6bYX4hWL8RN+BsLbrhbKTVKVqsgtczvyx8+RjahbgJE8/Z/q7o4E9MGgHx9Ecu2tH1qva3didtD4xjakQxAmPfroz2/S2ZF1OsorlEXw2efmq+/7l5gvodZclrmhiojNTxR+g1Ovl0lxbzbZ6ACLCRzI/SpO1FbOdHv4knmAyAeCWkXKLqaIWDx8p2FfIJC8IW6T27ja4bGJMNAXVKcRrtT56fXnzqjCXU+Ouxe4lkIAY1ev8Vdn9CiexcHFIvZtbalyKgjQrZiI0bHi7tETdAn0tmDLn+QzHwj8nB9avsp2m51GRy/AkWjyKTHC0YPNufYDxhUanLH5A4UgQ5HPqL9kxcGp3h1dWF09c15Z5tW9JeIzPOZsQZ9W8nnynyoK1SoeVTP4QKaniK4MqWzlPt5w/xWtc4mfxUwO3tsVqIXxA0Uo673DbX3iiYj/XLxBtv6EPglF5MZcya7AwjrspBPhNIkIk6UAMFhVSNYvkNuUqLViSSrUToDJeSHalXi6uWXblegHi2WtW/x2w==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(261009223027099003)(261021121427099003)(261021123027099003)(261021135927099003)(261022105027099003)(10067099003)(56012099006)(261026140227099003)(6133799003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: U4UXRi3tkpjJn6grFGFa9CE3Bs8dkZ8pG0ksSdC+RQ9M4i6vmD4l7KyuXMOYzdc47dA3eXJZPV1FFELcR1Dg7YTHzweEQNdz2zxv20bHfJ4g6T9ahzCk7+fYe+f0I34irvs7so/kRdEFfC5s4r3+twgBQmEHJfksyL2TScP4bYq+qPSriTIOY1XApisDCpA4R1qzcr0OJJajhgIeC6dh0wKfr+DxxHfOICJ7ihNhGroUGfINNCnfM1A7/IXMl3CD9QKcLdHbMEyd29of7D/QCl44N8s2QUhX+FHtMeudx0Jb6WNy/0z0MylAvXL/QX4MZ7cbQgGBpay4iNwh//H7QwdBmZYGQYYhtJkaHJiCTzX0W2g7Ig16R5GgOtxkqgLgdc2uXLVUmhopNxmSTl/lfEd9DF9EGaAXPuJQqvZrgGI3ZmJRgxnQYJk+TSS4DNDZ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 16:28:12.9015 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19bc9990-e89f-4f62-da96-08df337e2174
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY6PEPF0000004C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6945
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Future FW versions for NVIDIA NICs and DPUs will allow
SubFunctions (SFs) to be group into local E-Switch instances.
One of such SFs would serve as a transfer proxy for that E-Switch
while others will be representors.
In this topology, probing in mlx5 networking driver must support
working with associated SF devices.

This patch addresses that by adding necessary check for multiport
IB device on auxiliary device probing. If multiport device is detected,
it'll be treated as E-Switch instance. Probing will be allowed
if and only if probed device belongs to set of network devices
associated with given IB device.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
---
 drivers/net/mlx5/linux/mlx5_ethdev_os.c |  11 +-
 drivers/net/mlx5/linux/mlx5_os.c        | 162 +++++++++++++++++++++---
 drivers/net/mlx5/linux/mlx5_os.h        |   2 +-
 3 files changed, 152 insertions(+), 23 deletions(-)

diff --git a/drivers/net/mlx5/linux/mlx5_ethdev_os.c b/drivers/net/mlx5/linux/mlx5_ethdev_os.c
index 55cae148f0..e3b27818ff 100644
--- a/drivers/net/mlx5/linux/mlx5_ethdev_os.c
+++ b/drivers/net/mlx5/linux/mlx5_ethdev_os.c
@@ -48,15 +48,20 @@
 #include "mlx5_utils.h"
 
 /* Get interface index from SubFunction device name. */
-int
+unsigned int
 mlx5_auxiliary_get_ifindex(const char *sf_name)
 {
 	char if_name[IF_NAMESIZE] = { 0 };
+	unsigned int ifindex;
 
 	if (mlx5_auxiliary_get_child_name(sf_name, "/net",
 					  if_name, sizeof(if_name)) != 0)
-		return -rte_errno;
-	return if_nametoindex(if_name);
+		return 0;
+
+	ifindex = if_nametoindex(if_name);
+	if (ifindex == 0)
+		rte_errno = errno;
+	return ifindex;
 }
 
 /**
diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index 83c9774443..ef89510b6a 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -3151,43 +3151,167 @@ mlx5_os_pci_probe(struct mlx5_common_device *cdev,
 	return ret;
 }
 
-/* Probe a single SF device on auxiliary bus, no representor support. */
+static int
+mlx5_auxiliary_fill_single_spawn_data(struct mlx5_common_device *cdev,
+				      struct rte_device *dev,
+				      struct mlx5_dev_spawn_data *spawn)
+{
+	unsigned int ifindex;
+
+	/* Probed device is the primary IB device. */
+	MLX5_ASSERT(cdev->dev == dev);
+	/* IB device is single port. */
+	MLX5_ASSERT(spawn->max_port == 1);
+	/* IB device name is provided. */
+	MLX5_ASSERT(spawn->phys_dev_name != NULL);
+
+	spawn->phys_port = 1;
+	ifindex = mlx5_auxiliary_get_ifindex(dev->name);
+	if (ifindex == 0) {
+		DRV_LOG(ERR, "dev %s failed to get ethdev ifindex (%s)",
+			dev->name, rte_strerror(rte_errno));
+		return -rte_errno;
+	}
+	spawn->ifindex = ifindex;
+	spawn->cdev = cdev;
+	spawn->dpdk_dev = dev;
+
+	return 0;
+}
+
+static int
+mlx5_auxiliary_fill_switch_spawn_data(struct mlx5_common_device *cdev,
+				      struct rte_device *dev,
+				      int nl_rdma,
+				      int nl_route,
+				      struct mlx5_dev_spawn_data *spawn)
+{
+	unsigned int dev_ifindex;
+	int ret;
+
+	/* IB device is multi port. */
+	MLX5_ASSERT(spawn->max_port > 1);
+	/* IB device name is provided. */
+	MLX5_ASSERT(spawn->phys_dev_name != NULL);
+
+	dev_ifindex = mlx5_auxiliary_get_ifindex(dev->name);
+	if (dev_ifindex == 0) {
+		DRV_LOG(ERR, "dev %s failed to get ethdev ifindex (%s)",
+			dev->name, rte_strerror(rte_errno));
+		return -rte_errno;
+	}
+
+	for (unsigned int port = 1; port <= spawn->max_port; ++port) {
+		struct mlx5_switch_info switch_info;
+		unsigned int ifindex;
+
+		ifindex = mlx5_nl_ifindex(nl_rdma, spawn->phys_dev_name, port, NULL);
+		if (ifindex == 0)
+			continue;
+
+		if (ifindex != dev_ifindex)
+			continue;
+
+		ret = mlx5_nl_switch_info(cdev, nl_route, ifindex, &switch_info);
+		if (ret < 0)
+			return ret;
+
+		if (switch_info.name_type != MLX5_PHYS_PORT_NAME_TYPE_VIRTUAL)
+			continue;
+
+		/* All checks passed. This IB port can be used. */
+		spawn->phys_port = port;
+		spawn->ifindex = ifindex;
+		spawn->cdev = cdev;
+		spawn->dpdk_dev = dev;
+		spawn->info = switch_info;
+		return 0;
+	}
+
+	/* If no valid port was found, then probed device cannot be used. */
+	rte_errno = ENODEV;
+	return -rte_errno;
+}
+
+static int
+mlx5_auxiliary_fill_spawn_data(struct mlx5_common_device *cdev,
+			       struct rte_device *dev,
+			       struct mlx5_dev_spawn_data *spawn)
+{
+	const char *phys_dev_name;
+	unsigned int portnum;
+	int nl_route = -1;
+	int nl_rdma = -1;
+	int ret;
+
+	phys_dev_name = mlx5_os_get_ctx_device_name(cdev->ctx);
+	if (phys_dev_name == NULL)
+		return -EINVAL;
+
+	nl_rdma = mlx5_nl_init(NETLINK_RDMA, 0);
+	if (nl_rdma < 0) {
+		/* If NETLINK_RDMA is not available, assume single port for fallback. */
+		DRV_LOG(DEBUG,
+			"cdev %s Unable to open NETLINK_RDMA socket, assume single IB port (%s)",
+			cdev->dev->name, rte_strerror(rte_errno));
+		rte_errno = 0;
+		portnum = 1;
+		goto fill_spawn_data;
+	}
+
+	portnum = mlx5_nl_portnum(nl_rdma, phys_dev_name, &cdev->dev_info);
+	if (portnum == 0) {
+		ret = -rte_errno;
+		goto exit;
+	}
+
+fill_spawn_data:
+	memset(spawn, 0, sizeof(*spawn));
+	spawn->pf_bond = -1;
+	spawn->mpesw_port = MLX5_MPESW_PORT_INVALID;
+	spawn->max_port = portnum;
+	spawn->phys_dev_name = phys_dev_name;
+
+	if (portnum == 1) {
+		ret = mlx5_auxiliary_fill_single_spawn_data(cdev, dev, spawn);
+	} else {
+		nl_route = mlx5_nl_init(NETLINK_ROUTE, 0);
+		if (nl_route < 0) {
+			ret = nl_route;
+			goto exit;
+		}
+		ret = mlx5_auxiliary_fill_switch_spawn_data(cdev, dev, nl_rdma, nl_route, spawn);
+	}
+
+exit:
+	if (nl_route >= 0)
+		close(nl_route);
+	if (nl_rdma >= 0)
+		close(nl_rdma);
+	return ret;
+}
+
 static int
 mlx5_os_auxiliary_probe(struct mlx5_common_device *cdev,
 			struct rte_device *dev,
 			struct mlx5_kvargs_ctrl *mkvlist)
 {
 	struct rte_eth_devargs eth_da = { .nb_ports = 0 };
-	struct mlx5_dev_spawn_data spawn = {
-		.pf_bond = -1,
-		.mpesw_port = MLX5_MPESW_PORT_INVALID,
-	};
+	struct mlx5_dev_spawn_data spawn;
 	struct rte_auxiliary_device *adev = RTE_BUS_DEVICE(dev, *adev);
 	struct rte_eth_dev *eth_dev;
 	int ret = 0;
 
-	if (cdev->dev != dev) {
-		DRV_LOG(ERR, "Invalid device %s used to probe common device %s",
-			dev->name, cdev->dev->name);
-		rte_errno = EINVAL;
-		return -rte_errno;
-	}
 	/* Parse ethdev devargs. */
 	ret = mlx5_os_parse_eth_devargs(dev, &eth_da);
 	if (ret != 0)
 		return ret;
 	/* Init spawn data. */
-	spawn.max_port = 1;
-	spawn.phys_port = 1;
-	spawn.phys_dev_name = mlx5_os_get_ctx_device_name(cdev->ctx);
-	ret = mlx5_auxiliary_get_ifindex(dev->name);
+	ret = mlx5_auxiliary_fill_spawn_data(cdev, dev, &spawn);
 	if (ret < 0) {
-		DRV_LOG(ERR, "failed to get ethdev ifindex: %s", dev->name);
+		DRV_LOG(ERR, "failed to fill spawn data: %s", dev->name);
 		return ret;
 	}
-	spawn.ifindex = ret;
-	spawn.cdev = cdev;
-	spawn.dpdk_dev = dev;
 	/* Spawn device. */
 	eth_dev = mlx5_dev_spawn(&spawn, &eth_da, mkvlist);
 	if (eth_dev == NULL)
diff --git a/drivers/net/mlx5/linux/mlx5_os.h b/drivers/net/mlx5/linux/mlx5_os.h
index 4d073048fb..c55c9bcefa 100644
--- a/drivers/net/mlx5/linux/mlx5_os.h
+++ b/drivers/net/mlx5/linux/mlx5_os.h
@@ -13,7 +13,7 @@
 
 #define MLX5_NAMESIZE IF_NAMESIZE
 
-int mlx5_auxiliary_get_ifindex(const char *sf_name);
+unsigned int mlx5_auxiliary_get_ifindex(const char *sf_name);
 
 
 enum mlx5_sw_parsing_offloads {
-- 
2.43.0

