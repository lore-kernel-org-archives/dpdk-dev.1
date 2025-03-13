Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C59EC282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 08:34:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E3BE40E49;
	Thu, 13 Mar 2025 09:34:31 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by mails.dpdk.org (Postfix) with ESMTP id B020F40289
 for <dev@dpdk.org>; Thu, 13 Mar 2025 09:34:29 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G5eDquZRb4c2E9DynzK3JSaDgZkdRXCa2Rbehw7vz+Giy1uBS8k6V5cKSjRgHXe8gz9RscY+3Srd/lH1b6PIbpt3mwpz+1Y4Xa9/cZYMaEZTXEFmXTVFmju1yyxeGA7DTGOJXSErPrd/SN7whRZ6M7f4tPD0YWpLzOOXWX9T1/lVfVsvmv3VCGh+9O9ux72TktX/43Fn46e9RqoiHo8iJv5jpWn2dwpzLJeCM36PRmRso+J8HY6GpTv2LSe1dOtBRvMcVTDtFj1ISk+G7E8th0quhIjIaAFvEQqZUgYpR5oV6np4eVBdQSo2Kb02B7eQG+xv/ajwtO4Ev38fRDfccA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tiwaweygjGudHex4SPOeCuWlfhTiD1uA9aTh+4FYTfA=;
 b=J5f4HRoRhRmEGvXZ4tsyiQMtEzT5TyCCN8REy/m7NoT9lcb1Ezb5+bngizQzACD7bwLQTZfNIoHka8tDUdU+IO0pUy9ZIXfGf0Nv3+YTGZLjW4CwVFLfBe/n+rcPM8WgiOMZ6i9gRxZAEJRELIcXW3wwv+BgYZEgP/aaGy2FAETT2V9wVo3QcaD59Z4fCoyoCB37TODmlMNNLipLcIgCOxspNbqxrivOHfsTfi7ZoU8YZyOx2lrLRA4lXFEWu+1CTUdU3Gdkr5RNrev9QZ9LcJcsbbjvO3PQz3VyJD5YOqzzUNAKSJ93CIU2lKPSLM2gGbut7awr9k3VaKTyuOb1bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tiwaweygjGudHex4SPOeCuWlfhTiD1uA9aTh+4FYTfA=;
 b=TomGGK+zx7t5pS8qT+aoCABpMWvgZipNNP9TgNxChmFYQ+RupF/ut5QKarSreKFbScwgSFtoSjJs0tQYmVY9tl4Xc5cAtBW62tNR56pR7uPggEKnVvG5BtIqfuZFBZLu9+9Z96++5e2gR5HBocVjxZUvoEG2NmFfBHt3B6NPW7aSBzlWAm7SNuRLRO/vpWKJvLIiG7mpZMCePAjbqeg5wzlhKx90WJEK3UlhManbKrdXWNagKduuErfL0n1liXIBvteMLF+il9d44r4bhGXSvWivbau5RavVjoEZAyabWz2CT/T9CB3bJoGICTwArV+xZzGRbGopr7o+JVJf0sOlwQ==
Received: from CH2PR07CA0065.namprd07.prod.outlook.com (2603:10b6:610:5b::39)
 by CH3PR12MB9027.namprd12.prod.outlook.com (2603:10b6:610:120::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 08:34:25 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::7c) by CH2PR07CA0065.outlook.office365.com
 (2603:10b6:610:5b::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.21 via Frontend Transport; Thu,
 13 Mar 2025 08:34:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Thu, 13 Mar 2025 08:34:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Mar
 2025 01:34:12 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 13 Mar
 2025 01:34:07 -0700
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, =?UTF-8?q?=C2=A0?= <mkashani@nvidia.com>,
 <rasland@nvidia.com>, Michael Baum <michaelba@nvidia.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, "Bing
 Zhao" <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH 1/2] common/mlx5: add device duplication function
Date: Thu, 13 Mar 2025 10:33:50 +0200
Message-ID: <20250313083351.25559-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|CH3PR12MB9027:EE_
X-MS-Office365-Filtering-Correlation-Id: f01918e6-7f81-4217-2ebe-08dd6209dcfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HHvFfx8/3XkOz0V9jfOKN1B2QsuIX1CvTP7iK8lXUIixMzcNBnNyflooDF28?=
 =?us-ascii?Q?X5nirzmm2/dYbdUFVrD70W2+zKWhQ0NSZdAtq6Jqab4ApXXmg9oTP1AAU/Dj?=
 =?us-ascii?Q?mxcDEkFPrTyB5a/Wl3cMyM2Z7d45a/IkO4kswOkISTpnjOesZ56TzRk39nSN?=
 =?us-ascii?Q?wcwfi43joBk72stA4mL04fMlGQta9gfdAsmUfOsj8DspTyJ1h0QFksTkAyYA?=
 =?us-ascii?Q?ztzsCayMbZSahbBhm3eZa1eBz68+4NmWjmQJbNUJTi1VC50Sn0HtdkHldz5h?=
 =?us-ascii?Q?mIF3pLrQeqdNdtAvYUZwxZpnxROlbj2GZAi7DQXSswYYPQFKYWqmsg243Xv2?=
 =?us-ascii?Q?CdEG11/8BHNAvZIFcpEjZDdVV2u7ssXRDkVwSzYnHsHG1IDYaDiFAOYQAb8L?=
 =?us-ascii?Q?jO+Q2LbA4fqfJwH43S1IEDYTb+nFdKbM+okjR6q118jco5e6qH+e1YCqNTSH?=
 =?us-ascii?Q?mXM7arWNVLcH7CTuVCU7gPAPX+GI8Jk+PSz+NXYhwybt2jcMh8cIyAe1AiPH?=
 =?us-ascii?Q?HnSW4dh3F7h8bW847gkki29ccLq4CDrjsHB5aXppN4dMEVXlMOtHnSsXz8mG?=
 =?us-ascii?Q?LKwX9HoXZoRzqwgayTjAU+R+aSh82NjL6BqBeq51Sy0EzQuz+Dzes9S5Z9ld?=
 =?us-ascii?Q?YLFxT5oghi80SvB4YzLmA6pUc3b45AcMP6UF4PoEwJowZ8qDXKIHRJDFsiW0?=
 =?us-ascii?Q?m3k/Rl+8yf2Rfm9USHltH0q4xCkLQz1WW9t0oqVoyqEJwV23sd7ypajlnHD5?=
 =?us-ascii?Q?Z6gA9Pv9ihxO5sIX/mmdZHHeHf8o0z4T6bhGvz6Fj0lU+eznU5Gtg4vtdmkP?=
 =?us-ascii?Q?tStjjurjxFr/ByABAFwqYVFVnE+SBIswh6jPcaA2QIKTNP07x7+Lirr5bJLV?=
 =?us-ascii?Q?i0kv24I0GONdXkUHydJOpALVoMXoiVCyS4DoDZl3LFWmex/OR1Bvv/iD8yv8?=
 =?us-ascii?Q?TRXIKDvCeN8AJi7j0FkLgov5eO9A1dzh+Nqp94sCP8nNqZK2wt+PbjkrevyH?=
 =?us-ascii?Q?8/H1URg12KE7HT95Xcc/1xQ7zUabW7NVc8ht2MVlSD0H9Xy/rJoJF1C7cY8k?=
 =?us-ascii?Q?tyF9fiVfVd099FjJHrIbDFLqu1mp7KnPJIu+DCr0aGlQDIvp0+75NZpHG+El?=
 =?us-ascii?Q?dyVF4g6bnD9QngrwUsrhiSQnSFQC82lR7+MP5pNofaG1QKDN3KasvCMwsgsv?=
 =?us-ascii?Q?s3bMMcQPGtl08/pUQ3KIGuToVFxDGtmXkyDORcDTTChliOWZ98IeC0Okofvj?=
 =?us-ascii?Q?9ZJiN9z92P67RvwWcEgr3HjWn6BVXyIKMMjK0dxdJ461S+taycgpjm4rutV8?=
 =?us-ascii?Q?K3CNZzQ4vTUQ6uY+00t67BQ4TOh/XcVddITswJ08NQqKwvQ2np/fbeNoX0KC?=
 =?us-ascii?Q?QJVRjMn5b0kVa+R732BqU+w/DUZI8xGrbOPBcTHYir2LmoG3yc3GQN54mtK2?=
 =?us-ascii?Q?PZXX7l2S/n46sY15FNoepdJ67RZGEdwUMIjB/vUPSR4HhgnQSbNIFQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 08:34:25.6436 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f01918e6-7f81-4217-2ebe-08dd6209dcfb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9027
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

From: Michael Baum <michaelba@nvidia.com>

Add function for creating additional CTX for same device base on
existing CTX.

Signed-off-by: Michael Baum <michaelba@nvidia.com>
---
 drivers/common/mlx5/linux/mlx5_common_os.c   | 52 ++++++++++++++++++++
 drivers/common/mlx5/mlx5_common.h            |  4 ++
 drivers/common/mlx5/version.map              |  1 +
 drivers/common/mlx5/windows/mlx5_common_os.c | 31 ++++++++++++
 4 files changed, 88 insertions(+)

diff --git a/drivers/common/mlx5/linux/mlx5_common_os.c b/drivers/common/mlx5/linux/mlx5_common_os.c
index 41345e1597..2f5032f0da 100644
--- a/drivers/common/mlx5/linux/mlx5_common_os.c
+++ b/drivers/common/mlx5/linux/mlx5_common_os.c
@@ -873,6 +873,58 @@ mlx5_os_open_device(struct mlx5_common_device *cdev, uint32_t classes)
 	return 0;
 }
 
+/**
+ * API function to obtain a new InfiniBand (IB) context for a given common device.
+ *
+ * This function provides a port-agnostic IB context for a physical device, enabling the
+ * device to create and manage resources that can be initialized when a port starts and
+ * released when another port stops.
+ *
+ * For Linux, it imports new context from the existing context.
+ *
+ * @param cdev
+ *   Pointer to the mlx5 device structure.
+ *
+ * @return
+ *   Pointer to an `ibv_context` on success, or NULL on failure, with `rte_errno` set.
+ */
+void *
+mlx5_os_get_physical_device_ctx(struct mlx5_common_device *cdev)
+{
+	struct ibv_context *ctx = NULL;
+	int cmd_fd = ((struct ibv_context *)cdev->ctx)->cmd_fd;
+	int new_cmd_fd;
+
+	/*
+	 * Duplicate the command FD to pass it as input to the import device function.
+	 * If the import function succeeds, the new device context takes ownership of
+	 * this FD, which will be freed when the new device is closed.
+	 * If the import function fails, we are responsible for closing this FD.
+	 */
+	new_cmd_fd = dup(cmd_fd);
+	if (new_cmd_fd < 0) {
+		DRV_LOG(ERR,
+			"Failed to duplicate FD %d for IB device \"%s\": %s",
+			cmd_fd, mlx5_os_get_ctx_device_name(cdev->ctx),
+			rte_strerror(errno));
+		rte_errno = errno;
+		return NULL;
+	}
+	/* Attempt to import the duplicated FD to create a new device context. */
+	ctx = mlx5_glue->import_device(new_cmd_fd);
+	if (!ctx) {
+		DRV_LOG(ERR, "Failed to import IB device \"%s\": %s",
+			mlx5_os_get_ctx_device_name(cdev->ctx),
+			rte_strerror(errno));
+		close(new_cmd_fd);
+		rte_errno = errno;
+		return NULL;
+	}
+	DRV_LOG(INFO, "IB device \"%s\" successfully imported, old_fd=%d, new_fd=%d",
+		mlx5_os_get_ctx_device_name(cdev->ctx), cmd_fd, new_cmd_fd);
+	return (void *)ctx;
+}
+
 int
 mlx5_get_device_guid(const struct rte_pci_addr *dev, uint8_t *guid, size_t len)
 {
diff --git a/drivers/common/mlx5/mlx5_common.h b/drivers/common/mlx5/mlx5_common.h
index e7bd4c6ec4..bea1382911 100644
--- a/drivers/common/mlx5/mlx5_common.h
+++ b/drivers/common/mlx5/mlx5_common.h
@@ -651,6 +651,10 @@ mlx5_devx_uar_release(struct mlx5_uar *uar);
 
 /* mlx5_common_os.c */
 
+__rte_internal
+void *
+mlx5_os_get_physical_device_ctx(struct mlx5_common_device *cdev);
+
 int mlx5_os_open_device(struct mlx5_common_device *cdev, uint32_t classes);
 int mlx5_os_pd_prepare(struct mlx5_common_device *cdev);
 int mlx5_os_pd_release(struct mlx5_common_device *cdev);
diff --git a/drivers/common/mlx5/version.map b/drivers/common/mlx5/version.map
index 8301485839..819e6b96cb 100644
--- a/drivers/common/mlx5/version.map
+++ b/drivers/common/mlx5/version.map
@@ -150,6 +150,7 @@ INTERNAL {
 	mlx5_nl_rdma_monitor_info_get; # WINDOWS_NO_EXPORT
 	mlx5_nl_rdma_monitor_cap_get; # WINDOWS_NO_EXPORT
 
+	mlx5_os_get_physical_device_ctx;
 	mlx5_os_umem_dereg;
 	mlx5_os_umem_reg;
 
diff --git a/drivers/common/mlx5/windows/mlx5_common_os.c b/drivers/common/mlx5/windows/mlx5_common_os.c
index 2b6058eb3e..68f1981193 100644
--- a/drivers/common/mlx5/windows/mlx5_common_os.c
+++ b/drivers/common/mlx5/windows/mlx5_common_os.c
@@ -266,6 +266,37 @@ mlx5_os_open_device(struct mlx5_common_device *cdev, uint32_t classes)
 	return -rte_errno;
 }
 
+/**
+ * API function to obtain a new MLX5 context for a given common device.
+ *
+ * This function provides a port-agnostic context for a physical device, enabling the
+ * device to create and manage resources that can be initialized when a port starts and
+ * released when another port stops.
+ *
+ * For Windows, it creates a new context for the device regardless to existing context.
+ *
+ * @param cdev
+ *   Pointer to the mlx5 device structure.
+ *
+ * @return
+ *   Pointer to an `ibv_context` on success, or NULL on failure, with `rte_errno` set.
+ */
+void *
+mlx5_os_get_physical_device_ctx(struct mlx5_common_device *cdev)
+{
+	struct mlx5_common_device temp = {
+		.dev = cdev->dev,
+	};
+
+	if (mlx5_os_open_device(&temp, MLX5_CLASS_ETH) < 0) {
+		DRV_LOG(ERR, "Failed to duplicate DevX device \"%s\": %s",
+			mlx5_os_get_ctx_device_name(cdev->ctx),
+			rte_strerror(rte_errno));
+		return NULL;
+	}
+	return (void *)temp.ctx;
+}
+
 /**
  * Register umem.
  *
-- 
2.45.2

