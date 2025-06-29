Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F14C7EE39
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Jun 2025 17:08:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8BECB4069F;
	Sun, 29 Jun 2025 19:07:54 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by mails.dpdk.org (Postfix) with ESMTP id A82AB40691
 for <dev@dpdk.org>; Sun, 29 Jun 2025 19:07:51 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MbeOtrhASgFM6RJvla5Pm4m4rNRPJ7NIw5tPw3gwzHn6qVYTBLgCxroGS3bvXdLLHmOJVkEaRGYvjipR8TJb0lLsZvFKil4N/uQDuDyXWXaRv3FNKN82uv+pDZKjnrReQWXw/k3Fzy8G8jSbdQdOd+DdvlICy6vGQp1ezo1b8LxoLkLAKE3/ItQqEdWJmThY98slFju975DNG5I1Ugoi5Oi0z0YyQ79cNQ3X8DODFvTjq/qlHzoJ/lTa1SueEkUmfHvqziJKhR/bhtLue7O23F+tTFSBuZd0zvizL6fXLPbsabzH3bMDPYUC3C4UxT7HveL8qF9aMnapSXWJLaHCmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKiuw7CYSt87qplAKDTn2AyBRaWpAf58wcmz0jxA3XU=;
 b=x2/JulJlS2Ved6ODE0wUb4T+P+2JVh059TFwgOVd7q4UlcAhP/sciD+GAhxNRK4cuxvokQSMPGne/MUPpyR4XYjMAr+6b5PaiQlu0guQBf7PZ+ZnGHEguH6VlCfIf8idTpy0cP1mCbX8XLK/mg8YqdJfTPaJASj/ci4JS6cvz12tJHniHcU7yIcUXI1OfJtzv610mTlC1mhUs3TVOs+6oehaUm1t7EcpzMoMuME3aLHX4BJqKvtZ2ceSKUh3DoEbewr6d1FzHdxcl+K/IxgWoWEyT7mB92kTfdYQaKOgQvYJRIb81owUkEDNPELqvjs9OUAPiW8w5c/UbqyJ581Jsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKiuw7CYSt87qplAKDTn2AyBRaWpAf58wcmz0jxA3XU=;
 b=mn3Lhm2DbYdJ3lemktKPuupUNoyMcSO02/pQJSECmtnMT1qPgLZ3NOMkIy5P2H6K4RC2us+5exb4EcaUDM+IgfFI79rDwApKn6Rkua+4gbT66x8rPyxNzokFbANqbMeHBrN9zebrKk7GEZ/ktIqiEEkFRirPi5gh9x4Tm2CNeSOF3vuFiAY4TI5jl99JL/W9Neh0eKXcEc2AjwvekbTsJgGCPa70HwVj/HESZfj92hOYrV3XIV+4momROSke7TVPdfvB2gJKaidZ7tUlWtHPysFQKQ1psAKTOJFQl69HlP6b95/vqzY9ecQomWs2DLARdx3rFT3nVmJHRvqGDQQp9Q==
Received: from PH1PEPF000132F8.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::29)
 by CY5PR12MB6382.namprd12.prod.outlook.com (2603:10b6:930:3e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Sun, 29 Jun
 2025 17:07:47 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2a01:111:f403:f912::) by PH1PEPF000132F8.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.27 via Frontend Transport; Sun,
 29 Jun 2025 17:07:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Sun, 29 Jun 2025 17:07:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 29 Jun
 2025 10:07:34 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 29 Jun
 2025 10:07:31 -0700
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <matan@nvidia.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <dsosnowski@nvidia.com>,
 <suanmingm@nvidia.com>, <rasland@nvidia.com>
Subject: [PATCH v4 3/5] net/mlx5: allocate and release unique resources for Tx
 queues
Date: Sun, 29 Jun 2025 20:07:07 +0300
Message-ID: <20250629170709.69960-4-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250629170709.69960-1-bingz@nvidia.com>
References: <20250627163729.50460-1-bingz@nvidia.com>
 <20250629170709.69960-1-bingz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|CY5PR12MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a436c83-d393-44af-a430-08ddb72f7896
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RvJhKlEH/oFLxeYYzACU/hr4TJmmWt6fbVNWbswiKmayklEOz8f+FlMt78aI?=
 =?us-ascii?Q?bG/q4BayibeasZ2X66zSSy2LgPyidkWfnEjXEiKnjKx6trKcgEuUsQywjHbf?=
 =?us-ascii?Q?N7mM4vYq0S97zrMT1yKxpdrB377pA1SIxSYBmX0+GutGfj/0vXEdOBNFPqQQ?=
 =?us-ascii?Q?j/+0WRPevLdgd5l7yFqArrjuTsNswJZRG3ceQhY1LloRe/p0lmTFLOEPwk4+?=
 =?us-ascii?Q?I+i119Nws3nNsg8MDKnDlJi0iwrCCGC9SLYH1PuNV4PDFemMB/47J1P3TVDs?=
 =?us-ascii?Q?VK32CPlUdDPMPIp61PCugObwCnR/uNX9Ax/m4Fe0aBz5HqkgPCyeOLLQa4tT?=
 =?us-ascii?Q?ZT8tGob3/7ON9KEziKPWpi4OqbG4R98ynO7Neo9yR4h64ujIefLyhSXDq+/h?=
 =?us-ascii?Q?XWItiCU4If23SJaDasynZEA5vkF+ityhbJPApFRQJ8d/3ypIXu8liDIhf05/?=
 =?us-ascii?Q?4x3LH3GX+XKZj8R+g/u3OuZFa7XlyhCC8WOmFopidBMHSVSdr6JRDm1iyB9g?=
 =?us-ascii?Q?8nypTP7Pi0aSF3yGEZQszj7oQrHvW1oqjNQNs2ZMM+jfgQLgEsLYvoEHoQQO?=
 =?us-ascii?Q?3JnnFWZjeUkxAgZq9KA13+SdquUszSYKaDnNG7HvsE0CSzyRhba3rHdKHghb?=
 =?us-ascii?Q?bhWnHBkGqPBUSHU9EWyXrcR3g8HpNQ+t3830+kxuZfvxaB9t/OEc9JfkpW2q?=
 =?us-ascii?Q?muacJigOenBFPDa4mpqOpeArXtsAwsDd04iAGv5dfknthbf25GWNhrYZWVxO?=
 =?us-ascii?Q?LWYpY3C3TwcsbL1FjSktnp/W3x9N2lB+pY3zvfPRLry9PkwPCYU2xSoBPemZ?=
 =?us-ascii?Q?GCzpyjGL8fqoxk8QRqn7NxK46cQ+SgRBy/VZvNvO0+h8KmUIaaZYhnY8usOh?=
 =?us-ascii?Q?bjllyIKrBmJO4A5KnKStm2sQUcYDu4I5VSKCUm/xS46ZdHlAVAfT/Wu6m4c9?=
 =?us-ascii?Q?7FOWdBJJwnLwCOh4nW0wmAiqHOYfPipur/hS3tmEFEywjCpufFtnGDuZWO19?=
 =?us-ascii?Q?P1KEr2CFrsvcpQyxZzrMEC2IZu/aqa6maQwUjb4M1sPbcsQGMbCULB7jw1Dk?=
 =?us-ascii?Q?9xLx9vJFmIZogER7C1HEBhLvw3lfdp91zM+6tG+iEm1ZBJx8IwtstNL2mhL7?=
 =?us-ascii?Q?WFkUVgSvmUb+al5oZ9cPX3MHFFspuvIJUKEggjsCZcjJ6B3N5msGo1dsixh4?=
 =?us-ascii?Q?N7iGXZvAoxhJK7gFkghWxhOrIDcPRs8Ry779FPencoHXbpJ9s/rhmvfDkULF?=
 =?us-ascii?Q?2+VKgWsdBf+Q/184rLjtkYxkSD0GYgz+hOydbD1y+5IQE6S1ZAmZRoADoTyw?=
 =?us-ascii?Q?HvxE8C+vMcYeN2rs1fHk+EzbCYE0T5RDev4u46v26bttM2ooYy5d5P7t35/q?=
 =?us-ascii?Q?QlwDfz1+DWSNbLCdoI8eRwQr9KACZo4afV77KzrFLTlXjyxpgPj6qvJO+gxO?=
 =?us-ascii?Q?Q1G5Ffhb5LoIxu/QwoJ92rUiB7OongBXa0e4qBSiWP18FsJRwd8P6lR4lww7?=
 =?us-ascii?Q?pdzaajtTqmi3fjkYxwf9res82xbxbiQCR98e?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2025 17:07:46.9788 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a436c83-d393-44af-a430-08ddb72f7896
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6382
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

If the unique umem and MR method is enabled, before starting Tx
queues in device start stage, the memory will be pre-allocated
and the MR will be registered for the Tx queues' usage later.

Signed-off-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/mlx5.h         |  4 ++
 drivers/net/mlx5/mlx5_trigger.c | 91 +++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+)

diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index 285c9ba396..c08894cd03 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -2141,6 +2141,10 @@ struct mlx5_priv {
 	struct {
 		uint32_t sq_total_size;
 		uint32_t cq_total_size;
+		void *umem;
+		void *umem_obj;
+		uint32_t sq_cur_off;
+		uint32_t cq_cur_off;
 	} consec_tx_mem;
 	RTE_ATOMIC(uint16_t) shared_refcnt; /* HW steering host reference counter. */
 };
diff --git a/drivers/net/mlx5/mlx5_trigger.c b/drivers/net/mlx5/mlx5_trigger.c
index 3aa7d01ee2..00ffb39ecb 100644
--- a/drivers/net/mlx5/mlx5_trigger.c
+++ b/drivers/net/mlx5/mlx5_trigger.c
@@ -1135,6 +1135,89 @@ mlx5_hw_representor_port_allowed_start(struct rte_eth_dev *dev)
 
 #endif
 
+/*
+ * Allocate TxQs unique umem and register its MR.
+ *
+ * @param dev
+ *   Pointer to Ethernet device structure.
+ *
+ * @return
+ *   0 on success, a negative errno value otherwise and rte_errno is set.
+ */
+static int mlx5_dev_allocate_consec_tx_mem(struct rte_eth_dev *dev)
+{
+	struct mlx5_priv *priv = dev->data->dev_private;
+	size_t alignment;
+	uint32_t total_size;
+	struct mlx5dv_devx_umem *umem_obj = NULL;
+	void *umem_buf = NULL;
+
+	/* Legacy per queue allocation, do nothing here. */
+	if (priv->sh->config.txq_mem_algn == 0)
+		return 0;
+	alignment = (size_t)(1U << priv->sh->config.txq_mem_algn);
+	total_size = priv->consec_tx_mem.sq_total_size + priv->consec_tx_mem.cq_total_size;
+	/*
+	 * Hairpin queues can be skipped later
+	 * queue size alignment is bigger than doorbell alignment, no need to align or
+	 * round-up again. One queue have two DBs (for CQ + WQ).
+	 */
+	total_size += MLX5_DBR_SIZE * priv->txqs_n * 2;
+	umem_buf = mlx5_malloc_numa_tolerant(MLX5_MEM_RTE | MLX5_MEM_ZERO, total_size,
+					     alignment, priv->sh->numa_node);
+	if (!umem_buf) {
+		DRV_LOG(ERR, "Failed to allocate consecutive memory for TxQs.");
+		rte_errno = ENOMEM;
+		return -rte_errno;
+	}
+	umem_obj = mlx5_os_umem_reg(priv->sh->cdev->ctx, (void *)(uintptr_t)umem_buf,
+				    total_size, IBV_ACCESS_LOCAL_WRITE);
+	if (!umem_obj) {
+		DRV_LOG(ERR, "Failed to register unique umem for all SQs.");
+		rte_errno = errno;
+		if (umem_buf)
+			mlx5_free(umem_buf);
+		return -rte_errno;
+	}
+	priv->consec_tx_mem.umem = umem_buf;
+	priv->consec_tx_mem.sq_cur_off = 0;
+	priv->consec_tx_mem.cq_cur_off = priv->consec_tx_mem.sq_total_size;
+	priv->consec_tx_mem.umem_obj = umem_obj;
+	DRV_LOG(DEBUG, "Allocated umem %p with size %u for %u queues with sq_len %u,"
+		" cq_len %u and registered object %p on port %u",
+		umem_buf, total_size, priv->txqs_n, priv->consec_tx_mem.sq_total_size,
+		priv->consec_tx_mem.cq_total_size, (void *)umem_obj, dev->data->port_id);
+	return 0;
+}
+
+/*
+ * Release TxQs unique umem and register its MR.
+ *
+ * @param dev
+ *   Pointer to Ethernet device structure.
+ * @param on_stop
+ *   If this is on device stop stage.
+ */
+static void mlx5_dev_free_consec_tx_mem(struct rte_eth_dev *dev, bool on_stop)
+{
+	struct mlx5_priv *priv = dev->data->dev_private;
+
+	if (priv->consec_tx_mem.umem_obj) {
+		mlx5_os_umem_dereg(priv->consec_tx_mem.umem_obj);
+		priv->consec_tx_mem.umem_obj = NULL;
+	}
+	if (priv->consec_tx_mem.umem) {
+		mlx5_free(priv->consec_tx_mem.umem);
+		priv->consec_tx_mem.umem = NULL;
+	}
+	/* Queues information will not be reset. */
+	if (on_stop) {
+		/* Reset to 0s for re-setting up queues. */
+		priv->consec_tx_mem.sq_cur_off = 0;
+		priv->consec_tx_mem.cq_cur_off = 0;
+	}
+}
+
 /**
  * DPDK callback to start the device.
  *
@@ -1225,6 +1308,12 @@ mlx5_dev_start(struct rte_eth_dev *dev)
 		if (ret)
 			goto error;
 	}
+	ret = mlx5_dev_allocate_consec_tx_mem(dev);
+	if (ret) {
+		DRV_LOG(ERR, "port %u Tx queues memory allocation failed: %s",
+			dev->data->port_id, strerror(rte_errno));
+		goto error;
+	}
 	ret = mlx5_txq_start(dev);
 	if (ret) {
 		DRV_LOG(ERR, "port %u Tx queue allocation failed: %s",
@@ -1358,6 +1447,7 @@ mlx5_dev_start(struct rte_eth_dev *dev)
 	mlx5_rxq_stop(dev);
 	if (priv->obj_ops.lb_dummy_queue_release)
 		priv->obj_ops.lb_dummy_queue_release(dev);
+	mlx5_dev_free_consec_tx_mem(dev, false);
 	mlx5_txpp_stop(dev); /* Stop last. */
 	rte_errno = ret; /* Restore rte_errno. */
 	return -rte_errno;
@@ -1470,6 +1560,7 @@ mlx5_dev_stop(struct rte_eth_dev *dev)
 	priv->sh->port[priv->dev_port - 1].nl_ih_port_id = RTE_MAX_ETHPORTS;
 	mlx5_txq_stop(dev);
 	mlx5_rxq_stop(dev);
+	mlx5_dev_free_consec_tx_mem(dev, true);
 	if (priv->obj_ops.lb_dummy_queue_release)
 		priv->obj_ops.lb_dummy_queue_release(dev);
 	mlx5_txpp_stop(dev);
-- 
2.34.1

