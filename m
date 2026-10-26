Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C6D606A323
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 16:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=j9tjXq4x
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55F754042E;
	Mon, 26 Oct 2026 17:29:15 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010006.outbound.protection.outlook.com [52.101.61.6])
 by mails.dpdk.org (Postfix) with ESMTPS id B4A07402E8
 for <dev@dpdk.org>; Mon, 26 Oct 2026 17:29:13 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jeUCB0WHfzzyhdiTUXhhmPzeTNJYinRVy8pZu3gL1aD1ex5UJjOXpigPPHrv13j06Xe4gaTxX8bEqSNfJ9m1rRpfAWFs2FTfbQkQx4YnjBUAkf28bMcGt1nk/JGEF6WcO2nxPM/TfwFlXxI7Ltwa01vuYij16zGkmfpryKcyq4bsE4wq+07ZYdKZaCFlcNzJ82Oku7naBBRSstFg+9lB/mwXFMVKQVqqKBXHgAMnWU1KgY688PFqr2hakJ6K3etsSQzITtMsOwd9Hzr0x6lYPZE2puBDwEuiozYGnIeeL98+5KzRk0LYl3ze5VIuFo+aX/Vb5WLz61LuQTGFxWMBvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bVa+fwfNHrKqXnMrfzF92kPLf2oqwQASd0DHq7i5e8=;
 b=gfND5s9rKdze6h9rvbuDBtTyJpOoVPZi2YRg5EZyLkgWCxWw8m0PrFngM3lsgTyDQvtvr+ghNXLG9iPpdrl6b7EqxEytrclgkTajxfe3pF3+bOuVG0T133LzpXpMPbmgAaz+g6eVmT+MLG+ZkY8B76V8MlpcX5dNaeuMvxkbvxQg9GZP3UDKQX+GMyqVzW7JkJccxDETwfa3xOT+DP9zlNW/tDXXhZBuH8TR1TMRBCy7vwUEok0SFw5Rwsb1SGeceAFyW95YV4vQXu4iifNG7y59Z80tan5o5WqcwqAKS55LfQ3kKmJK0+AhD6bHPVw7FHpa5G7oGoW9uYrQbeu64Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bVa+fwfNHrKqXnMrfzF92kPLf2oqwQASd0DHq7i5e8=;
 b=j9tjXq4xxu9pBO3gSDeW5krDJeEZ+P/FToK+0eopVa7mdJVjXrCxq4b2B2xIiJGZe91E8sFoD59gqEfsKtaLbEO23Hl//ZunEiw6CXWfN29Mw+nNcZo3JMqEOBFPZWgDI3g9nbXVLPxGEqJywrXGSKSKNXItgS7VZJuYMvh5e6f485T8EHDyWObhktTYFneilSTscOY3xreXxIyrUBcmlDxxM1kde0rg7SFBauzQLcj8f79CtMCL3AvDBWz6y8hr612QH5Te4XMyY9SE5/tnUOZwvnWA1R8/HPLVg5q1ZKzYbr1kiMKhiPaDf1H9v+T6i0Hr3DL579U5lRwhWM4BtQ==
Received: from CH2PR18CA0020.namprd18.prod.outlook.com (2603:10b6:610:4f::30)
 by SA3PR12MB239779.namprd12.prod.outlook.com (2603:10b6:806:5a5::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 16:28:16 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::4e) by CH2PR18CA0020.outlook.office365.com
 (2603:10b6:610:4f::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 16:28:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 16:28:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 09:27:47 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 09:27:45 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>
Subject: [PATCH 11/13] net/mlx5: add sibling device iteration macro
Date: Mon, 26 Oct 2026 17:27:07 +0100
Message-ID: <20261026162709.1292958-12-dsosnowski@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|SA3PR12MB239779:EE_
X-MS-Office365-Filtering-Correlation-Id: d9f10baf-7ee1-4421-dc2d-08df337e2304
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|261009223027099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|10067099003|56012099006|3023799007|261026140227099003|6133799003|18002099003|22082099003|261026121527099003|11063799006;
X-Microsoft-Antispam-Message-Info: BFUXpjE6pQ+7yVE98aY1Vallw/rwnxj0gKpZX2NWO0Ey5/0PFH7lipL0zgDtMGXzBMzjYlgDGEF41YBYOZxyHMY97m0+X/13NsXPFqrfTWJXSQ6HAoap2T1ayVGe4tyFpxgpEqeCLDsWl4U7derHcZSxDda43myaDhA8jqhMwNDCmNgaP2RIscJW3Jn7wt0tYOHmnqcqOhLicauyWaAbVZ5oL0FxGajwL5oY6F5hLv4/t2//zWP99lDUSjd/qEK0P4DsKPGdIqf8IO6aK772Wy95mGH2qGD8S6Q/VA3Vxd8VcDSk0nIwx0eH7A+sg2VDk8wZ3givwsKZO6x3wtGukyFzr4gwYfP5sT7NXgL/uIe9mlkpr2QbyZa+X7yN3Ct2NjanTZBg3IB4eVPWjpBjYZFgeUwNCNH3hK5e4n2oaMtXLAGIZvkdQSYVQ3vyjWaloZTnQP4pJiHGHODTK32qoz36xhfDN1M3LjJqxPmchyxHa8dAkUZkSChzrueNzrfKNqaWsjgkybFEHoQn8y0E+FXFLFoimcdmxoWzwmo0rlV8rJA26Hbtaagt9IFqlnAOH3lH/ZQr00hKtRkAoJICDwob3ufcaQJi0PLtDy/oB4YCsWBnKm/q+7VcOMmPrOIx2zuB5+dATFcpkaL2paGJNEoIy3wndlLv2CymVn1TxAg4Vg94wI9wp/X3TuK2Q5QaFh01hOJTj2ZjcUdl9nc7Xg==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(261009223027099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(10067099003)(56012099006)(3023799007)(261026140227099003)(6133799003)(18002099003)(22082099003)(261026121527099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CHAppFMSreTacfV1NTcoWMqwRvBlMNkYugc3oit0lJQ74/ghkt66XaQ8BU1ze46G8/d6Zb/Yp5pIJOgL4hWc1M9eT7wr9XKuQl9TrYNVqIcKCd5MKjtIyFYg4lTjsez2ZtdKxi3mLJZZ81isZYukG1Hf+yT3E/y/Ag7ch9HzS3iUnLHweDe1pOPJ41cNcS0bzWOP3+/iIBbWSbCFQijQU5TCCdtQqvHO05sM6FcAYcqdSUsZeq3O3IQpfqtNOZylXSg3SdDRNrKUf2E20CqRYHsGMBJxitm2XOiP7w1fJeBtbxPI9zt5K5vAzpHHntAaS3vm9oYkgi1ohG1PtYl1zHDVKsIQe3zeELyNEcF0Xe3QefUS7QqaGTfnbGMMYUb7hBYSZi76QTkJLTQkOy3xJG64CD7/Bs3P7WJSaYPN44MC03ABAjQiJjLIZcaCWneV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 16:28:15.4535 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f10baf-7ee1-4421-dc2d-08df337e2304
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB239779
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In some embedded switch topologies, not all DPDK representor ports
will be based on the same rte_device.
One such example is ConnectX socket direct configurations
or nested switches based on VFs/SFs.
mlx5 networking driver in many cases requires to iterate
over all DPDK ethdev ports belonging to the same switch.
In the past it relied on "one rte_device" assumption.

This patch introduces a new macro - MLX5_ETH_FOREACH_SIBLING -
which iterates over all ethdev ports managed by mlx5 driver,
which share the same mlx5 common device.
All relevant usages of previous iteration macros are replaced with
MLX5_ETH_FOREACH_SIBLING, in preparation for allowing usage of multiple
rte_device's in mlx5 networking driver.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
---
 drivers/net/mlx5/linux/mlx5_ethdev_os.c | 13 ++---
 drivers/net/mlx5/linux/mlx5_os.c        | 22 +++-----
 drivers/net/mlx5/mlx5.c                 | 70 ++++++++++++++++++++-----
 drivers/net/mlx5/mlx5.h                 |  6 +++
 drivers/net/mlx5/mlx5_ethdev.c          | 27 +++-------
 drivers/net/mlx5/mlx5_flow.c            | 24 ++++-----
 drivers/net/mlx5/mlx5_mac.c             |  2 +-
 drivers/net/mlx5/mlx5_trigger.c         | 10 ++--
 drivers/net/mlx5/windows/mlx5_os.c      | 24 ++++-----
 9 files changed, 105 insertions(+), 93 deletions(-)

diff --git a/drivers/net/mlx5/linux/mlx5_ethdev_os.c b/drivers/net/mlx5/linux/mlx5_ethdev_os.c
index f6394ebd19..55cae148f0 100644
--- a/drivers/net/mlx5/linux/mlx5_ethdev_os.c
+++ b/drivers/net/mlx5/linux/mlx5_ethdev_os.c
@@ -300,18 +300,13 @@ mlx5_find_master_dev(struct rte_eth_dev *dev)
 {
 	struct mlx5_priv *priv;
 	uint16_t port_id;
-	uint16_t domain_id;
 
 	priv = dev->data->dev_private;
-	domain_id = priv->domain_id;
 	MLX5_ASSERT(priv->representor);
-	MLX5_ETH_FOREACH_DEV(port_id, dev->device) {
-		struct mlx5_priv *opriv =
-			rte_eth_devices[port_id].data->dev_private;
-		if (opriv &&
-		    opriv->master &&
-		    opriv->domain_id == domain_id &&
-		    opriv->sh == priv->sh)
+	MLX5_ETH_FOREACH_SIBLING(port_id, priv->sh->cdev) {
+		struct mlx5_priv *opriv = rte_eth_devices[port_id].data->dev_private;
+
+		if (opriv->master)
 			return &rte_eth_devices[port_id];
 	}
 	return NULL;
diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index 42b23e7f58..1b1b1bb013 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -1585,14 +1585,10 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 	 * Look for sibling devices in order to reuse their switch domain
 	 * if any, otherwise allocate one.
 	 */
-	MLX5_ETH_FOREACH_DEV(port_id, dpdk_dev) {
-		const struct mlx5_priv *opriv =
-			rte_eth_devices[port_id].data->dev_private;
-
-		if (!opriv ||
-		    opriv->sh != priv->sh ||
-			opriv->domain_id ==
-			RTE_ETH_DEV_SWITCH_DOMAIN_ID_INVALID)
+	MLX5_ETH_FOREACH_SIBLING(port_id, priv->sh->cdev) {
+		const struct mlx5_priv *opriv = rte_eth_devices[port_id].data->dev_private;
+
+		if (opriv->domain_id == RTE_ETH_DEV_SWITCH_DOMAIN_ID_INVALID)
 			continue;
 		priv->domain_id = opriv->domain_id;
 		DRV_LOG(DEBUG, "dev_port-%u inherit domain_id=%u\n",
@@ -1711,13 +1707,9 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 	if (priv->representor) {
 		eth_dev->data->dev_flags |= RTE_ETH_DEV_REPRESENTOR;
 		eth_dev->data->representor_id = eth_dev->data->port_id;
-		MLX5_ETH_FOREACH_DEV(port_id, dpdk_dev) {
-			struct mlx5_priv *opriv =
-				rte_eth_devices[port_id].data->dev_private;
-			if (opriv &&
-			    opriv->master &&
-			    opriv->domain_id == priv->domain_id &&
-			    opriv->sh == priv->sh) {
+		MLX5_ETH_FOREACH_SIBLING(port_id, priv->sh->cdev) {
+			struct mlx5_priv *opriv = rte_eth_devices[port_id].data->dev_private;
+			if (opriv->master) {
 				eth_dev->data->backer_port_id = port_id;
 				break;
 			}
diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index 7093eefa15..615b2ff943 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -2565,23 +2565,14 @@ mlx5_dev_close(struct rte_eth_dev *dev)
 	 * since 'mlx5_dev_interrupt_nl_cb' uses priv.
 	 */
 	rte_io_wmb();
-	/*
-	 * Free the shared context in last turn, because the cleanup
-	 * routines above may use some shared fields, like
-	 * mlx5_os_mac_addr_flush() uses ibdev_path for retrieving
-	 * ifindex if Netlink fails.
-	 */
-	mlx5_free_shared_dev_ctx(sh);
 	if (priv->domain_id != RTE_ETH_DEV_SWITCH_DOMAIN_ID_INVALID) {
 		unsigned int c = 0;
 		uint16_t port_id;
 
-		MLX5_ETH_FOREACH_DEV(port_id, dev->device) {
-			struct mlx5_priv *opriv =
-				rte_eth_devices[port_id].data->dev_private;
+		MLX5_ETH_FOREACH_SIBLING(port_id, priv->sh->cdev) {
+			struct mlx5_priv *opriv = rte_eth_devices[port_id].data->dev_private;
 
-			if (!opriv ||
-			    opriv->domain_id != priv->domain_id ||
+			if (opriv->domain_id != priv->domain_id ||
 			    &rte_eth_devices[port_id] == dev)
 				continue;
 			++c;
@@ -2590,6 +2581,13 @@ mlx5_dev_close(struct rte_eth_dev *dev)
 		if (!c)
 			claim_zero(rte_eth_switch_domain_free(priv->domain_id));
 	}
+	/*
+	 * Free the shared context in last turn, because the cleanup
+	 * routines above may use some shared fields, like
+	 * mlx5_os_mac_addr_flush() uses ibdev_path for retrieving
+	 * ifindex if Netlink fails.
+	 */
+	mlx5_free_shared_dev_ctx(sh);
 	mlx5_flow_pools_destroy(priv);
 	memset(priv, 0, sizeof(*priv));
 	priv->domain_id = RTE_ETH_DEV_SWITCH_DOMAIN_ID_INVALID;
@@ -3508,6 +3506,54 @@ mlx5_eth_find_next(uint16_t port_id, struct rte_device *odev)
 	return port_id;
 }
 
+/**
+ * Look for the ethernet device belonging to mlx5 driver, which share the device context.
+ *
+ * If port index is found, then caller can assume that:
+ *
+ * - Port is a valid ethdev port, managed by mlx5 driver.
+ * - Port has private device data set (mlx5_priv).
+ * - Port has shared mlx5 device context set (priv->sh).
+ * - Port is based on the @p cdev common device.
+ *
+ * @param[in] start_port_id
+ *   Port index to start looking for device.
+ * @param[in] cdev
+ *   Pointer to common device.
+ *
+ * @return
+ *   Port index of found device, RTE_MAX_ETHPORTS if not found.
+ */
+uint16_t
+mlx5_eth_find_next_sibling(uint16_t start_port_id, struct mlx5_common_device *cdev)
+{
+	struct mlx5_priv *priv;
+	uint16_t port_id;
+
+	if (cdev == NULL)
+		return RTE_MAX_ETHPORTS;
+
+	for (port_id = start_port_id; port_id < RTE_MAX_ETHPORTS; port_id++) {
+		if (rte_eth_dev_is_valid_port(port_id) == 0)
+			continue;
+
+		if (!mlx5_dev_is_managed(rte_eth_devices[port_id].device))
+			continue;
+
+		priv = rte_eth_devices[port_id].data->dev_private;
+		if (priv == NULL || priv->sh == NULL)
+			continue;
+
+		if (priv->sh->cdev == cdev)
+			break;
+	}
+
+	if (port_id >= RTE_MAX_ETHPORTS)
+		return RTE_MAX_ETHPORTS;
+
+	return port_id;
+}
+
 static int
 mlx5_hairpin_queue_counter_supported(struct mlx5_priv *priv)
 {
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index b1493745ee..e4ebdd4c2f 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -2295,6 +2295,7 @@ void mlx5_proc_priv_uninit(struct rte_eth_dev *dev);
 int mlx5_udp_tunnel_port_add(struct rte_eth_dev *dev,
 			      struct rte_eth_udp_tunnel *udp_tunnel);
 uint16_t mlx5_eth_find_next(uint16_t port_id, struct rte_device *odev);
+uint16_t mlx5_eth_find_next_sibling(uint16_t port_id, struct mlx5_common_device *cdev);
 int mlx5_dev_close(struct rte_eth_dev *dev);
 int mlx5_net_remove(struct mlx5_common_device *cdev);
 bool mlx5_is_hpf(struct rte_eth_dev *dev);
@@ -2312,6 +2313,11 @@ int mlx5_disable_per_queue_hairpin_counter(struct rte_eth_dev *dev, uint64_t id)
 	for (port_id = mlx5_eth_find_next(0, dev); \
 	     port_id < RTE_MAX_ETHPORTS; \
 	     port_id = mlx5_eth_find_next(port_id + 1, dev))
+/* Macro to iterate over all valid ports for mlx5 driver spawned on given common device. */
+#define MLX5_ETH_FOREACH_SIBLING(port_id, cdev) \
+	for (port_id = mlx5_eth_find_next_sibling(0, cdev); \
+	     port_id < RTE_MAX_ETHPORTS; \
+	     port_id = mlx5_eth_find_next_sibling(port_id + 1, cdev))
 void mlx5_rt_timestamp_config(struct mlx5_dev_ctx_shared *sh,
 			      struct mlx5_hca_attr *hca_attr);
 struct mlx5_dev_ctx_shared *
diff --git a/drivers/net/mlx5/mlx5_ethdev.c b/drivers/net/mlx5/mlx5_ethdev.c
index 306c1cd734..f41724725c 100644
--- a/drivers/net/mlx5/mlx5_ethdev.c
+++ b/drivers/net/mlx5/mlx5_ethdev.c
@@ -424,15 +424,12 @@ mlx5_dev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *info)
 	if (priv->representor) {
 		uint16_t port_id;
 
-		MLX5_ETH_FOREACH_DEV(port_id, dev->device) {
-			struct mlx5_priv *opriv =
-				rte_eth_devices[port_id].data->dev_private;
-
-			if (!opriv ||
-			    opriv->representor ||
-			    opriv->sh != priv->sh ||
-			    opriv->domain_id != priv->domain_id)
+		MLX5_ETH_FOREACH_SIBLING(port_id, priv->sh->cdev) {
+			struct mlx5_priv *opriv = rte_eth_devices[port_id].data->dev_private;
+
+			if (opriv->representor)
 				continue;
+
 			/*
 			 * Override switch name with that of the master
 			 * device.
@@ -523,14 +520,9 @@ mlx5_representor_info_count(struct rte_eth_dev *dev)
 	uint16_t port_id;
 	unsigned int count = 0;
 
-	MLX5_ETH_FOREACH_DEV(port_id, dev->device) {
+	MLX5_ETH_FOREACH_SIBLING(port_id, priv->sh->cdev) {
 		struct mlx5_priv *opriv = rte_eth_devices[port_id].data->dev_private;
 
-		if (!opriv ||
-		    opriv->sh != priv->sh ||
-		    opriv->domain_id != priv->domain_id)
-			continue;
-
 		count += mlx5_representor_info_count_one(opriv);
 	}
 
@@ -629,14 +621,9 @@ mlx5_representor_info_fill(struct rte_eth_dev *dev,
 	info->controller = priv->port_info.ctrl_num;
 	info->pf = RTE_BUS_DEVICE(dev->device, struct rte_pci_device)->addr.function;
 
-	MLX5_ETH_FOREACH_DEV(port_id, dev->device) {
+	MLX5_ETH_FOREACH_SIBLING(port_id, priv->sh->cdev) {
 		struct mlx5_priv *opriv = rte_eth_devices[port_id].data->dev_private;
 
-		if (!opriv ||
-		    opriv->sh != priv->sh ||
-		    opriv->domain_id != priv->domain_id)
-			continue;
-
 		mlx5_representor_info_fill_one(opriv, info);
 	}
 
diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
index b0eac185b5..cceb6668f9 100644
--- a/drivers/net/mlx5/mlx5_flow.c
+++ b/drivers/net/mlx5/mlx5_flow.c
@@ -1665,15 +1665,12 @@ mlx5_flow_rxq_mark_flag_set(struct rte_eth_dev *dev)
 	if (priv->sh->shared_mark_enabled)
 		return;
 	if (priv->master || priv->representor) {
-		MLX5_ETH_FOREACH_DEV(port_id, dev->device) {
-			struct mlx5_priv *opriv =
-				rte_eth_devices[port_id].data->dev_private;
-
-			if (!opriv ||
-			    opriv->sh != priv->sh ||
-			    opriv->domain_id != priv->domain_id ||
-			    opriv->mark_enabled)
+		MLX5_ETH_FOREACH_SIBLING(port_id, priv->sh->cdev) {
+			struct mlx5_priv *opriv = rte_eth_devices[port_id].data->dev_private;
+
+			if (opriv->mark_enabled)
 				continue;
+
 			LIST_FOREACH(rxq_ctrl, &opriv->rxqsctrl, next) {
 				rxq_ctrl->rxq.mark = 1;
 			}
@@ -12290,12 +12287,9 @@ mlx5_flow_pick_transfer_proxy(struct rte_eth_dev *dev,
 		*proxy_port_id = dev->data->port_id;
 		return 0;
 	}
-	MLX5_ETH_FOREACH_DEV(port_id, dev->device) {
-		const struct rte_eth_dev *port_dev = &rte_eth_devices[port_id];
-		const struct mlx5_priv *port_priv = port_dev->data->dev_private;
-
-		if (port_priv->master &&
-		    port_priv->domain_id == priv->domain_id) {
+	MLX5_ETH_FOREACH_SIBLING(port_id, priv->sh->cdev) {
+		const struct mlx5_priv *port_priv = rte_eth_devices[port_id].data->dev_private;
+		if (port_priv->master) {
 			*proxy_port_id = port_id;
 			return 0;
 		}
@@ -12511,7 +12505,7 @@ flow_disable_steering_run_on_related(struct rte_eth_dev *dev,
 		}
 
 		/* Run callback on representors. */
-		MLX5_ETH_FOREACH_DEV(other_port_id, dev->device) {
+		MLX5_ETH_FOREACH_SIBLING(other_port_id, priv->sh->cdev) {
 			struct rte_eth_dev *other_dev = &rte_eth_devices[other_port_id];
 
 			if (other_port_id != proxy_port_id)
diff --git a/drivers/net/mlx5/mlx5_mac.c b/drivers/net/mlx5/mlx5_mac.c
index 9e7bf7f2ec..8cbaaf67dd 100644
--- a/drivers/net/mlx5/mlx5_mac.c
+++ b/drivers/net/mlx5/mlx5_mac.c
@@ -191,7 +191,7 @@ mlx5_mac_addr_set(struct rte_eth_dev *dev, struct rte_ether_addr *mac_addr)
 				mac_addr,
 				MLX5_REPRESENTOR_REPR(priv->representor_id));
 		}
-		RTE_ETH_FOREACH_DEV_SIBLING(port_id, dev->data->port_id) {
+		MLX5_ETH_FOREACH_SIBLING(port_id, priv->sh->cdev) {
 			pf_priv = rte_eth_devices[port_id].data->dev_private;
 			if (pf_priv->master == 1)
 				return mlx5_os_vf_mac_addr_modify
diff --git a/drivers/net/mlx5/mlx5_trigger.c b/drivers/net/mlx5/mlx5_trigger.c
index c5f493117b..ae0584f1b4 100644
--- a/drivers/net/mlx5/mlx5_trigger.c
+++ b/drivers/net/mlx5/mlx5_trigger.c
@@ -1578,13 +1578,11 @@ mlx5_hw_proxy_port_allowed_stop(struct rte_eth_dev *dev)
 	/* If transfer proxy port was not configured for HWS, then stopping it is allowed. */
 	if (!priv->dr_ctx)
 		return 0;
-	MLX5_ETH_FOREACH_DEV(port_id, dev->device) {
-		const struct rte_eth_dev *port_dev = &rte_eth_devices[port_id];
-		const struct mlx5_priv *port_priv = port_dev->data->dev_private;
+	MLX5_ETH_FOREACH_SIBLING(port_id, priv->sh->cdev) {
+		struct rte_eth_dev *odev = &rte_eth_devices[port_id];
+		struct mlx5_priv *opriv = odev->data->dev_private;
 
-		if (port_id != dev->data->port_id &&
-		    port_priv->domain_id == priv->domain_id &&
-		    port_dev->data->dev_started)
+		if (opriv->representor && odev->data->dev_started)
 			representor_started = true;
 	}
 	if (representor_started) {
diff --git a/drivers/net/mlx5/windows/mlx5_os.c b/drivers/net/mlx5/windows/mlx5_os.c
index 8e3baa95b4..2dbcbb1acb 100644
--- a/drivers/net/mlx5/windows/mlx5_os.c
+++ b/drivers/net/mlx5/windows/mlx5_os.c
@@ -437,16 +437,14 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 	 * Look for sibling devices in order to reuse their switch domain
 	 * if any, otherwise allocate one.
 	 */
-	MLX5_ETH_FOREACH_DEV(port_id, dpdk_dev) {
-		const struct mlx5_priv *opriv =
-			rte_eth_devices[port_id].data->dev_private;
-
-		if (!opriv ||
-		    opriv->sh != priv->sh ||
-			opriv->domain_id ==
-			RTE_ETH_DEV_SWITCH_DOMAIN_ID_INVALID)
+	MLX5_ETH_FOREACH_SIBLING(port_id, priv->sh->cdev) {
+		const struct mlx5_priv *opriv = rte_eth_devices[port_id].data->dev_private;
+
+		if (opriv->domain_id == RTE_ETH_DEV_SWITCH_DOMAIN_ID_INVALID)
 			continue;
 		priv->domain_id = opriv->domain_id;
+		DRV_LOG(DEBUG, "dev_port-%u inherit domain_id=%u",
+			priv->dev_port, priv->domain_id);
 		break;
 	}
 	if (priv->domain_id == RTE_ETH_DEV_SWITCH_DOMAIN_ID_INVALID) {
@@ -476,13 +474,9 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 	if (priv->representor) {
 		eth_dev->data->dev_flags |= RTE_ETH_DEV_REPRESENTOR;
 		eth_dev->data->representor_id = priv->representor_id;
-		MLX5_ETH_FOREACH_DEV(port_id, dpdk_dev) {
-			struct mlx5_priv *opriv =
-				rte_eth_devices[port_id].data->dev_private;
-			if (opriv &&
-			    opriv->master &&
-			    opriv->domain_id == priv->domain_id &&
-			    opriv->sh == priv->sh) {
+		MLX5_ETH_FOREACH_SIBLING(port_id, priv->sh->cdev) {
+			struct mlx5_priv *opriv = rte_eth_devices[port_id].data->dev_private;
+			if (opriv->master) {
 				eth_dev->data->backer_port_id = port_id;
 				break;
 			}
-- 
2.43.0

