Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04C1606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 16:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kW7SNY0v
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3306140658;
	Mon, 26 Oct 2026 17:28:13 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010071.outbound.protection.outlook.com [52.101.56.71])
 by mails.dpdk.org (Postfix) with ESMTPS id BF2B540658
 for <dev@dpdk.org>; Mon, 26 Oct 2026 17:28:11 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tquSH5+f/0kkfaADpe8J2VZelQ21b5W8bing1kR3zaa/dpvX/OTbiHMnDW8h/MsCEHMy0F9PzHbYOfY3v30NX7segftC/5l9OdgBFsMEL8ufZqSUSGXj/a0CG5GiZ08ES4t7Cxov4+i7U4EOn9/L4TwjAAJBAF7EWCn7txJ7jw8Ib3mGIfirhRi0SheQFIcniTrEqeaKybEVI/VE931tJayMEGs1Fo1yx9Zr6WvezvdR8FS0BKNYT6jNneeNU58+hTyuq0gYdHRLFvie+w/NQTxasFEd61AQCohZzj4Nwyi2v1ttKuvzR5Pd9TdvNqF+a2wTzz66E68nIbNjznO9/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWgdLBauirZ7BzoTA0FArA8kkdBPoPYokZIjZfsNfe4=;
 b=vktjHPG7emXhgN8VB4ogtak1teKD7UqDYjM3TXCANVrKcCmky4EGzYRPvmCyYAxoIYD7XKxCLFaz2o6lAtg9T4jdTAX32ZPaIlSxdehwD3+VS53opwKKik/Ix1raRlHoWT/sogBZT1Gk6z4jmpVWzFNW6dKOYuTJmGKgciG28d5glzGvNcnCbbwHEAIbc2cKqiyk0nkq9BIKel48Vjt++E08uSUItqjtusXIGuh1JYMKOYUVJxyYBd2rC0Frx6A4mRBc32JJ8m22b69IDxRkZo021ttSQE5CcDYzivClu00LzuhYFUFtKL8ewDnfWGx0E4JJzFtPCkSUEQuvfPA87w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWgdLBauirZ7BzoTA0FArA8kkdBPoPYokZIjZfsNfe4=;
 b=kW7SNY0vB3n8XuAl5YJ9Mz+B2u1APueOQ4Go56ZURLWjpkOskEM0PurhhbHbUP/p+f/ZVCzazYG1ILS+bvoU31M8IDo+CpBsM9dBjuUZ5X9g7e0wlpJ6cpZPfHe7H6nCxeMK7ILuTl/VtcunA6rCkNt0bf/3LFPpJP6w9nVripM/qJovTk/Q4uTag0pRNzZ6Iw8e90k1X5vY7LSNdiQ4sZAT25fvIlqc/LJZHaOD3hpZyBz9HForXksuO3EL281egxZg0O1uNZWtE5ytV7se5L6eWQ8B2t5EOge4o33ORRyCevObdmkXWIOMefCDuXhDxgjTcV7Zk4WoQl6OYrxV9w==
Received: from CH2PR18CA0001.namprd18.prod.outlook.com (2603:10b6:610:4f::11)
 by MW4PR12MB6804.namprd12.prod.outlook.com (2603:10b6:303:20d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 16:28:03 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::9a) by CH2PR18CA0001.outlook.office365.com
 (2603:10b6:610:4f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 16:28:03 +0000
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
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 16:28:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 09:27:38 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 09:27:36 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>
Subject: [PATCH 07/13] common/mlx5: always use EAL device for probing
Date: Mon, 26 Oct 2026 17:27:03 +0100
Message-ID: <20261026162709.1292958-8-dsosnowski@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|MW4PR12MB6804:EE_
X-MS-Office365-Filtering-Correlation-Id: d5a038cf-811a-4d06-8cbb-08df337e1b69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|261009223027099003|261021121427099003|261021123027099003|261022075727099003|261022105027099003|10067099003|56012099006|261026140227099003|6133799003|18002099003|22082099003|261026121527099003|11063799006;
X-Microsoft-Antispam-Message-Info: 7yJ4/n71tJoG76lI4At5rqdYWXLBERFYBXkh/F0m662VW3mZIHC0PrsbNjrJ+tYMtLJNSf+ycCd+zzJXxAxSj/887pVgBHdr60Lk8SVR/m2WvTtCJkU99wkR8QyIS2LxNtfaLTKG73Zq9sg+Sauy2i3hwtqPwPhc5mOo2YAXhLDqUIfKzFkeGVrY3tRW55FCiGOs2NRj/wA5gRne7lFqPtpCPOXBeIlLfKkMAK8cZRjf4IvJyxd5g4tVqnKTCBKRJi1hmrlTRgJYY6o7OTrvOupQNWiLX7tx1qFZFknWxKEkHW/lWl9o3OXtr9JiEVMTjEkGNz7KenviBdlAHlTgCt/ZmSFmO40zXifmw0yEAZzn1jz+SyGG0Nim3qX5b0S6E0w8jnu2wT5y6vqt17J1NV8+OUgoVb7L4P1SEJRtjKqAx/tmBv9Eev+3/gMsuLbhxQ8ENCc43duhMreADsyrAjGA2YIxkXfZHhFcXYLHoE8iyNmneGQ8PmghCe9bA1lIgyVI84BCRf7Ao83XyaA9GxJOrCqERtvPViIclzNQZlXYt7WFsJtj2GHqKBRJH3rU0qljBlN7AfQl7OZJeVG60XBgOsn/DUMxyMLAZNcTyhidRK7oH3WYJR59Hw/Zk5TRL1vOHN9VUwvdmkxXQzzFn2OInaRRRoDrZc9C1jB2z72FNTZx2922SlkKgDkvth8XE06lQ/FhqR3M4DrcNsvYvg==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(261009223027099003)(261021121427099003)(261021123027099003)(261022075727099003)(261022105027099003)(10067099003)(56012099006)(261026140227099003)(6133799003)(18002099003)(22082099003)(261026121527099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 78hSE2rA7D902UkcCn1U+FNThkbF2dFG3icscWg8dS+01ZesV7Yw+BN8H5XbjJXQJC9UupK4azBMcWHBwiPEGxto7gy22u25hhlsz3B7pMzJGqcSmFQ98jUcBac+zLihV5/s+Kz7nA0GrAIYW3I5tY/bC3gV0khZ67fQd61EE9wfpx8dQOgIf7YBSNzYPG824OyxzP41gb5TFGraU8qbqxsuaqqVo12urRVhM4w0ZzlRby+SqUsNCNOtnIPkb2atmvya3wLZiStf7H0Huz8L7zv9956r2dDCYm6gK955rOJcsULJgbThn7EP7t0rVur8RaOJWUjVjONNWaFswEA2ASjWZV0qm2CxR46bNhgFA0QANdsbVZJ/To52oTVfZ3cGcRXnFEky6a3CyXQzJtA4NZZytKYgcy7ND/rZoALFkMfKJ91tNk/5Mo0drmrRicSh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 16:28:02.6753 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a038cf-811a-4d06-8cbb-08df337e1b69
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6804
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

Previous patch added gathering a list of all associated devices
for each mlx5 common device.
This patch prepars the mlx5 driver probing to take requested rte_device,
instead of relying on mlx5 common device to rte_device correspondence.

As of this patch, all mlx5 drivers will support only probing
with the main device (IB device owner).
Future patches will allow networking driver to probe
using multiple rte_device's.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
---
 drivers/common/mlx5/mlx5_common.c     | 38 ++++++++++++++++++++++-----
 drivers/common/mlx5/mlx5_common.h     |  2 ++
 drivers/compress/mlx5/mlx5_compress.c |  1 +
 drivers/crypto/mlx5/mlx5_crypto.c     |  1 +
 drivers/net/mlx5/linux/mlx5_os.c      |  3 +++
 drivers/net/mlx5/mlx5.h               |  1 +
 drivers/net/mlx5/windows/mlx5_os.c    |  1 +
 drivers/regex/mlx5/mlx5_regex.c       |  1 +
 drivers/vdpa/mlx5/mlx5_vdpa.c         |  1 +
 9 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/drivers/common/mlx5/mlx5_common.c b/drivers/common/mlx5/mlx5_common.c
index 67566e01b2..57f484fcb7 100644
--- a/drivers/common/mlx5/mlx5_common.c
+++ b/drivers/common/mlx5/mlx5_common.c
@@ -470,13 +470,30 @@ mlx5_bus_match(const struct mlx5_class_driver *drv,
 	return true;
 }
 
+static bool
+mlx5_associated_device_contains(struct mlx5_common_device *cdev,
+			        const struct rte_device *rte_dev)
+{
+	struct mlx5_associated_device *assoc;
+
+	TAILQ_FOREACH(assoc, &cdev->associated_devices, next) {
+		if (assoc->is_rte_device && rte_dev == assoc->dev)
+			return true;
+
+		if (mlx5_dev_matches(rte_dev, assoc->info.bus_name, assoc->info.dev_name))
+			return true;
+	}
+
+	return false;
+}
+
 static struct mlx5_common_device *
 to_mlx5_device(const struct rte_device *rte_dev)
 {
 	struct mlx5_common_device *cdev;
 
 	TAILQ_FOREACH(cdev, &devices_list, next) {
-		if (rte_dev == cdev->dev)
+		if (mlx5_associated_device_contains(cdev, rte_dev))
 			return cdev;
 	}
 	return NULL;
@@ -981,7 +998,9 @@ drivers_remove(struct mlx5_common_device *cdev, uint32_t enabled_classes)
 }
 
 static int
-drivers_probe(struct mlx5_common_device *cdev, uint32_t user_classes,
+drivers_probe(struct mlx5_common_device *cdev,
+	      struct rte_device *dev,
+	      uint32_t user_classes,
 	      struct mlx5_kvargs_ctrl *mkvlist)
 {
 	struct mlx5_class_driver *driver;
@@ -992,16 +1011,21 @@ drivers_probe(struct mlx5_common_device *cdev, uint32_t user_classes,
 	TAILQ_FOREACH(driver, &drivers_list, next) {
 		if ((driver->drv_class & user_classes) == 0)
 			continue;
-		if (!mlx5_bus_match(driver, cdev->dev))
+		if (!mlx5_bus_match(driver, dev))
 			continue;
+		if (!driver->probe_associated && cdev->dev != dev) {
+			DRV_LOG(ERR, "Invalid device %s used to probe on common device %s",
+				dev->name, cdev->dev->name);
+			ret = -EINVAL;
+			goto probe_err;
+		}
 		already_loaded = cdev->classes_loaded & driver->drv_class;
 		if (already_loaded && driver->probe_again == 0) {
-			DRV_LOG(ERR, "Device %s is already probed",
-				cdev->dev->name);
+			DRV_LOG(ERR, "Device %s is already probed", dev->name);
 			ret = -EEXIST;
 			goto probe_err;
 		}
-		ret = driver->probe(cdev, mkvlist);
+		ret = driver->probe(cdev, dev, mkvlist);
 		if (ret < 0) {
 			DRV_LOG(ERR, "Failed to load driver %s",
 				driver->name);
@@ -1091,7 +1115,7 @@ mlx5_common_dev_probe(struct rte_device *eal_dev)
 		DRV_LOG(ERR, "Unsupported mlx5 classes combination.");
 		goto class_err;
 	}
-	ret = drivers_probe(cdev, classes, mkvlist_p);
+	ret = drivers_probe(cdev, eal_dev, classes, mkvlist_p);
 	if (ret)
 		goto class_err;
 	/*
diff --git a/drivers/common/mlx5/mlx5_common.h b/drivers/common/mlx5/mlx5_common.h
index 8f8ab01700..0d940b1fdf 100644
--- a/drivers/common/mlx5/mlx5_common.h
+++ b/drivers/common/mlx5/mlx5_common.h
@@ -565,6 +565,7 @@ mlx5_imported_pd_and_ctx(struct mlx5_common_device *cdev)
  * Initialization function for the driver called during device probing.
  */
 typedef int (mlx5_class_driver_probe_t)(struct mlx5_common_device *cdev,
+					struct rte_device *dev,
 					struct mlx5_kvargs_ctrl *mkvlist);
 
 /**
@@ -584,6 +585,7 @@ struct mlx5_class_driver {
 	const struct rte_pci_id *id_table;    /**< ID table, NULL terminated. */
 	uint32_t probe_again:1;
 	/**< Device already probed can be probed again to check new device. */
+	uint32_t probe_associated:1; /**< Supports probing using associated devices. */
 	uint32_t intr_lsc:1; /**< Supports link state interrupt. */
 	uint32_t intr_rmv:1; /**< Supports device remove interrupt. */
 };
diff --git a/drivers/compress/mlx5/mlx5_compress.c b/drivers/compress/mlx5/mlx5_compress.c
index 1361dab630..ab503d74e3 100644
--- a/drivers/compress/mlx5/mlx5_compress.c
+++ b/drivers/compress/mlx5/mlx5_compress.c
@@ -820,6 +820,7 @@ mlx5_compress_fill_caps(struct mlx5_compress_priv *priv,
 
 static int
 mlx5_compress_dev_probe(struct mlx5_common_device *cdev,
+			struct rte_device *dev __rte_unused,
 			struct mlx5_kvargs_ctrl *mkvlist)
 {
 	struct rte_compressdev *compressdev;
diff --git a/drivers/crypto/mlx5/mlx5_crypto.c b/drivers/crypto/mlx5/mlx5_crypto.c
index 821dd54b31..aba56b300d 100644
--- a/drivers/crypto/mlx5/mlx5_crypto.c
+++ b/drivers/crypto/mlx5/mlx5_crypto.c
@@ -344,6 +344,7 @@ mlx5_crypto_parse_devargs(struct mlx5_kvargs_ctrl *mkvlist,
 
 static int
 mlx5_crypto_dev_probe(struct mlx5_common_device *cdev,
+		      struct rte_device *dev __rte_unused,
 		      struct mlx5_kvargs_ctrl *mkvlist)
 {
 	struct rte_cryptodev *crypto_dev;
diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index 7c2c35c945..42b23e7f58 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -3163,6 +3163,8 @@ mlx5_os_auxiliary_probe(struct mlx5_common_device *cdev,
  *
  * @param[in] cdev
  *   Pointer to the common mlx5 device.
+ * @param[in] dev
+ *   Pointer to the probed EAL device.
  * @param[in, out] mkvlist
  *   Pointer to mlx5 kvargs control, can be NULL if there is no devargs.
  *
@@ -3171,6 +3173,7 @@ mlx5_os_auxiliary_probe(struct mlx5_common_device *cdev,
  */
 int
 mlx5_os_net_probe(struct mlx5_common_device *cdev,
+		  struct rte_device *dev __rte_unused,
 		  struct mlx5_kvargs_ctrl *mkvlist)
 {
 	int ret;
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index e3df458915..b1493745ee 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -2636,6 +2636,7 @@ struct rte_pci_driver;
 int mlx5_os_capabilities_prepare(struct mlx5_dev_ctx_shared *sh);
 void mlx5_os_free_shared_dr(struct mlx5_priv *priv);
 int mlx5_os_net_probe(struct mlx5_common_device *cdev,
+		      struct rte_device *dev,
 		      struct mlx5_kvargs_ctrl *mkvlist);
 void mlx5_os_dev_shared_handler_install(struct mlx5_dev_ctx_shared *sh);
 void mlx5_os_dev_shared_handler_uninstall(struct mlx5_dev_ctx_shared *sh);
diff --git a/drivers/net/mlx5/windows/mlx5_os.c b/drivers/net/mlx5/windows/mlx5_os.c
index cc60f07e17..8e3baa95b4 100644
--- a/drivers/net/mlx5/windows/mlx5_os.c
+++ b/drivers/net/mlx5/windows/mlx5_os.c
@@ -900,6 +900,7 @@ mlx5_os_get_allmulti(struct rte_eth_dev *dev)
  */
 int
 mlx5_os_net_probe(struct mlx5_common_device *cdev,
+		  struct rte_device *dev __rte_unused,
 		  struct mlx5_kvargs_ctrl *mkvlist)
 {
 	struct rte_pci_device *pci_dev = RTE_BUS_DEVICE(cdev->dev, *pci_dev);
diff --git a/drivers/regex/mlx5/mlx5_regex.c b/drivers/regex/mlx5/mlx5_regex.c
index 042f585abd..b5f4bfa875 100644
--- a/drivers/regex/mlx5/mlx5_regex.c
+++ b/drivers/regex/mlx5/mlx5_regex.c
@@ -68,6 +68,7 @@ mlx5_regex_get_name(char *name, struct rte_device *dev)
 
 static int
 mlx5_regex_dev_probe(struct mlx5_common_device *cdev,
+		     struct rte_device *dev __rte_unused,
 		     struct mlx5_kvargs_ctrl *mkvlist __rte_unused)
 {
 	struct mlx5_regex_priv *priv = NULL;
diff --git a/drivers/vdpa/mlx5/mlx5_vdpa.c b/drivers/vdpa/mlx5/mlx5_vdpa.c
index 1bb5de51b6..a087b232b6 100644
--- a/drivers/vdpa/mlx5/mlx5_vdpa.c
+++ b/drivers/vdpa/mlx5/mlx5_vdpa.c
@@ -813,6 +813,7 @@ mlx5_vdpa_create_dev_resources(struct mlx5_vdpa_priv *priv)
 
 static int
 mlx5_vdpa_dev_probe(struct mlx5_common_device *cdev,
+		    struct rte_device *dev __rte_unused,
 		    struct mlx5_kvargs_ctrl *mkvlist)
 {
 	struct mlx5_vdpa_priv *priv = NULL;
-- 
2.43.0

