Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF7D606A31D
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 16:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=r0rwTExV
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 826984069F;
	Mon, 26 Oct 2026 17:28:29 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013024.outbound.protection.outlook.com
 [40.93.201.24]) by mails.dpdk.org (Postfix) with ESMTPS id 785A34064F
 for <dev@dpdk.org>; Mon, 26 Oct 2026 17:28:27 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hWhSwFGIvUKG2JYunWJFY5oIzutBXb7fzQ2SBkgGqB/ZXuqG6VVXEV8Mt8777hImV2/1R6817prjmqYQAYofwISmRL43e3t/d1aNCS8B9L4k4HgnvdbJgmHolz66xedQ8wiSSOjjX/8NVotcDNqE8SK+ElMzpOOUCM4jWC307U7zc7XweJQGvuBtM0N6l5HICj84rbdobNglG/G2DcTXoPKqILmt0TQ6touwnBQkAFNwpKw0Wkv+DA5OqX9i5cSH8Adnrzstg4nMDIioXWbvguhlEhwlxN2y7I8nLRAvUJbmgR+ZCFNZPTx3RD7q6DNtTn/mHzVkYGm+Zb/HWV2a8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lWXYApxYtgt7P5xsUkwYugUsi+ObWfDoLiNCB/JAqBw=;
 b=hKviKK4/GGKUHr6MZY3VXln2KMr9J7nFhmm90/Y1EucDbi2sSjDzcYEEhV+w1uDwLbK8jKsfHc2W1fgEvJyWbJCAcECK4Zcr+vKyet79GlRCuiEagIu1SVNHv/zIGXW938/PbFRrk34D0QgsR/iSVL5g4x9SPdx41eMI+B5ccebYYdhLFyOGoTBbqX6yBMRzjBcwhHd1j8YAf3H1mxz73oJ6+PePbt+AptTZ1Zn+YMkVkBcg957QpTJM+NJs+XdWM7YysA+GQu6k7vCTisss8imW6O/yHpC10btjKDIicEoT6kxn6bEcElw9mKh1Ue3RoCf41Tz9tx64nkgz2pr6cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWXYApxYtgt7P5xsUkwYugUsi+ObWfDoLiNCB/JAqBw=;
 b=r0rwTExVZ0vIvYTFSaNM4zBApn6HPfCaCzHi4kCbgCn7IZuxjSVU0V7waByArSZoxi9sn8s/WNkxVboNU6g6ZFtoCIesLwVR39iqQlPGIbTc+9oXN2kkL4DmO+OFimOAoV3r4/SaVh4JrfW8ZU5oEwDeGR6ex7f8qvlY9LMb6UdQcQlE9lfZ+YSZzQNImwRmdFqyPrHFW0r/yfZ4+xcjLzoTVS662RyYggZHSrGEyZi0hqfALs5cr21P6Jl9oPLgCgIhHjj3VwVgXz/Dphw7g+xXTb8SZkJo8p//9/CpLJ0JsfeluqHqvWQ/5I5Bnt/0J3YcMMiayxVpRd5i6ouU8Q==
Received: from CH2PR18CA0004.namprd18.prod.outlook.com (2603:10b6:610:4f::14)
 by SN7PR12MB7836.namprd12.prod.outlook.com (2603:10b6:806:34e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 16:28:14 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::66) by CH2PR18CA0004.outlook.office365.com
 (2603:10b6:610:4f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 16:28:12 +0000
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
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 16:28:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 09:27:45 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 09:27:43 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>
Subject: [PATCH 10/13] common/mlx5: add check for managed device
Date: Mon, 26 Oct 2026 17:27:06 +0100
Message-ID: <20261026162709.1292958-11-dsosnowski@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|SN7PR12MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fafdaa9-cf61-4460-7a0f-08df337e211c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|261009223027099003|261021123027099003|261021121427099003|10067099003|56012099006|261026121527099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: gaimIopO5fDAF0pp2K6AMvNFXXnjbtVIei2QWDEBcVplA1TfV18AEKGPvJ2IO2iw34wpMNSFCyUbyRANUYqn/RJgRbBEr1sbcei+6d9IYVLpajRtNESc6kIUq10mnkbYWzDwzzL9b1fvu3P8S88tf2D2YJgM+OwhNv+BAf/sAx8gomHo/JJUnn9zn7BgVy8Qa8WYm0ncEuckFhPdMXGpRjTK7X6eZjnCy4VzC1i6tOC4O2BDUY3vsjVDw6vJJZ8mXgGtkTodDpd3y4Q5MLuELIAmFkz9Vaz1F7CVepZcUJxFwzpEf+axZTxq+ceoilFlKTxVZg56nE4hrFz3pqOYiZL9Nd8X5EMwQxTWr5ojD65hrjgr6GIGACt6bzmA6HwONH9YtxPPzZ+3lb7TGO3os7JZD+vSlq1oFTONQF5jfalYtA9qaVlx619fLi4U7kkrvh4R4QZCAEtKS6FvZHlqL2WoJnFlKDnoJ51kh8U+oPSaE7OlCHYQGbw5HqIz5voVhFsWq/p0xd5EmBXNH6tBBHcVXyIuv74qIn+lKajYg+0d8og3w3CrqIy8YWBF5bjWN5K5JcWprLwHHNL19/dqkZZy+ARqcGxmGY/tqhz8ICmcggy8lowj2BzNMrfio7J2L5cJ8ZYbK3t1XO31S8gSsTtJ9+jBvTRWgsZnWmRxB3N4ej9n/XK0lsG/BaTyq0Qs+hrZJqAAuk1ZRFcdqD2UMA==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(261009223027099003)(261021123027099003)(261021121427099003)(10067099003)(56012099006)(261026121527099003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2c1OmeY4kWt3hM++33Q8qSl4yOFgarLdxNiA+k4S9YicsoNjHfrGlM1lvc2L8isXdWl6T58e9Dtj2PSDNBiF29TDxf2EGlZFMDGDJywq3PMpHy687Mvv2c29hbfvAe5XFggBS/N49UFa1fKKABOfZDsS/3y5UXWRUYkJxknV8T9NsP2Prpge3zw805OBfdezGmhm03dPI8hGUSKWq23ZwMNXWeSUJ2G/j3/0Noe2JGQOKTkatBDMgtLZ91yXN0sMYcT+xrFm3RinkSFVdd3AgvEM+o3ZKaiVDCChdrJrdSUxRUSaHdEcLO3cuB2gYfdiuE76CsLLhyXBJHrqE+fkomQUerJtf+BxoPSYnGFgRXJiu2ShBDWInnej26Dxo0bTZPa6FvQOua2/ADlgFRPb10EFSO3uHAb3ZPU8AcCJcPIccJ1mRN2oIw3BN3J6fxqK
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 16:28:12.2405 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fafdaa9-cf61-4460-7a0f-08df337e211c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7836
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

Add a common function for checking whether given
device is managed by any mlx5 driver.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
---
 drivers/common/mlx5/mlx5_common.c | 11 +++++++++++
 drivers/common/mlx5/mlx5_common.h | 14 ++++++++++++++
 drivers/net/mlx5/mlx5.c           |  8 +-------
 3 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/common/mlx5/mlx5_common.c b/drivers/common/mlx5/mlx5_common.c
index 57f484fcb7..46da81ebd8 100644
--- a/drivers/common/mlx5/mlx5_common.c
+++ b/drivers/common/mlx5/mlx5_common.c
@@ -1516,6 +1516,17 @@ mlx5_devx_uar_prepare(struct mlx5_common_device *cdev, struct mlx5_uar *uar)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_dev_is_managed)
+bool
+mlx5_dev_is_managed(const struct rte_device *dev)
+{
+	if (dev == NULL || dev->driver == NULL || dev->driver->name == NULL)
+		return false;
+
+	return strcmp(dev->driver->name, MLX5_PCI_DRIVER_NAME) == 0 ||
+	       strcmp(dev->driver->name, MLX5_AUXILIARY_DRIVER_NAME) == 0;
+}
+
 RTE_EXPORT_INTERNAL_SYMBOL(mlx5_dev_matches)
 bool
 mlx5_dev_matches(const struct rte_device *dev,
diff --git a/drivers/common/mlx5/mlx5_common.h b/drivers/common/mlx5/mlx5_common.h
index 0d940b1fdf..548f0c887b 100644
--- a/drivers/common/mlx5/mlx5_common.h
+++ b/drivers/common/mlx5/mlx5_common.h
@@ -601,6 +601,20 @@ __rte_internal
 void
 mlx5_class_driver_register(struct mlx5_class_driver *driver);
 
+/**
+ * Check if given EAL device is managed by any mlx5 driver.
+ *
+ * @param dev
+ *   Pointer to device.
+ *
+ * @return
+ *   - True if device is managed by mlx5 driver.
+ *   - False otherwise.
+ */
+__rte_internal
+bool
+mlx5_dev_is_managed(const struct rte_device *dev);
+
 /**
  * Test device is a PCI bus device.
  *
diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index 19491b9dc9..7093eefa15 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -3499,13 +3499,7 @@ mlx5_eth_find_next(uint16_t port_id, struct rte_device *odev)
 
 		if (dev->state != RTE_ETH_DEV_UNUSED &&
 		    dev->device &&
-		    (dev->device == odev ||
-		     (dev->device->driver &&
-		     dev->device->driver->name &&
-		     ((strcmp(dev->device->driver->name,
-			      MLX5_PCI_DRIVER_NAME) == 0) ||
-		      (strcmp(dev->device->driver->name,
-			      MLX5_AUXILIARY_DRIVER_NAME) == 0)))))
+		    (dev->device == odev || mlx5_dev_is_managed(dev->device)))
 			break;
 		port_id++;
 	}
-- 
2.43.0

