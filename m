Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D542C43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Jul 2026 11:01:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8EA574067A;
	Mon, 13 Jul 2026 13:01:47 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010018.outbound.protection.outlook.com [52.101.56.18])
 by mails.dpdk.org (Postfix) with ESMTP id AA7CB40290
 for <dev@dpdk.org>; Mon, 13 Jul 2026 13:01:46 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NuSBN+qkPvYLWSj8WVCYwx/ugrEoq0rmUVXiyCHqK/eaWOsaouEkTyts0soiv37U1k07cJRF4QHvTOcqcBJErFrZD4h0gMZgtnBrdtBqF+GgERlLTAhsxzYCCZwrjmElmhcXSU4d+gAp6c6sDY6WzDU1hYVw0kOxWg1dOwf0n0qrShcLl3RY/ocnJuc/VwcL43glcASkOmOxibMpveG9sUAC1ubwNYEkHQK4dCOP1w2alu31n3p991llCrfQpQOOnDz/hxMMwwzaijXFYf9/wyhvYdxK+Xudd0t15Jyn3YSDRsj8+LjCQqe3uLzORchWOky9I+bDpKCNIjq4YWrvag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CjQWEwvVza6d8EjlDgcLvx402kyjUCQXq17/Xz9RYSU=;
 b=G6BzvZ3pMNh2LWVGUYVinh0iYEqQRoM9kQm3X87o4skjKmpANvw3ukR/l+D1UKOwpL4J6OluKfc0eJsY0fPVV6kpqPrlt3O3jkTjo7eMQ7Wd59cv+NHMe4Lx4idngxkrRlWBG5u0GH3EDzuu0GdqvSKJxPgbI7s/evk6M1/6uUG3gSjzCAFFmZbcVl51D8jx8IeYADFAdNtszyoexB+SKh0bgE1a624d+sqQbTF+/LytrHvvbhg2CtM8A6FD3TtECTgI19Z5MtDkMXkcAhwfk9DuXw/20PWWdJ1HmlcL5I1jT53UobVg/BgLjMGrdpee6stdjZPtx0I3PgI64XeT0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjQWEwvVza6d8EjlDgcLvx402kyjUCQXq17/Xz9RYSU=;
 b=nAbHesYcAo0F20jzsRHX4MLr9EC09bvk3QRf8SeR0Oqm1C2MqCz2BWIdLB4OLQKbv8CjaCI20ZJk69rU/3fQrMW4hoaTz1lZMi3yXYKGJKeofZgcubNz0zKS3Kyn6hbuozizf8Yoh/JTAIwY6S0yKSrWiUl80CcXD+GolN/dsCBQ6MxuwBmULn/k/wCLHgVxzM0JUjv/xSL9icyYafgmCBYXTsy+cTLPtRCExgy0DTccqjFNolIcdvNPSgE7v/UqrZ20D3lG4Ydgpjej5SnpQHiS8kS+DkmkZ8gsjgcNBRUzBAKBt1C0ns3TIQlmZwE5svteLl/fYIYq1BMB0KmpAg==
Received: from SJ0PR03CA0262.namprd03.prod.outlook.com (2603:10b6:a03:3a0::27)
 by MN0PR12MB6270.namprd12.prod.outlook.com (2603:10b6:208:3c2::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 11:01:40 +0000
Received: from MWH0EPF000C6185.namprd02.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::6e) by SJ0PR03CA0262.outlook.office365.com
 (2603:10b6:a03:3a0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 11:01:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000C6185.mail.protection.outlook.com (10.167.249.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 11:01:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Jul
 2026 04:01:18 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Jul
 2026 04:01:16 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: David Marchand <david.marchand@redhat.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
CC: <dev@dpdk.org>
Subject: [PATCH 26.11] net/mlx5: remove versioned symbols aliases
Date: Mon, 13 Jul 2026 13:01:01 +0200
Message-ID: <20260713110101.24218-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6185:EE_|MN0PR12MB6270:EE_
X-MS-Office365-Filtering-Correlation-Id: 97d9de3b-998c-4da1-25f7-08dee0ce1d93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: q8lWAbvRtB8UgiJjWrs6+b1MnKT3GafhkBtl7f4TqBfVDZsaA+Lwkxmg9To8DpRPolUGdD9i9mCKG7fSIBFwknYq3clv+qP3OvHrOnekfQKWCvIcqDDDqGA9Y3wlvMPEvk1SLM+4tYoifJwPOJNn8smhEvZziscyuJHkHeP9uXVXYfmzsP8oZXmv+WRHGlJH8ti+xgQ2/KeFI0f035ewwu4ILlIV8GqX33vJvpdcKUef0wmQDCOAZJrO7WCNkxXn8KJl+D7raIRFbyiwbuae0SSMN90X8mZCZOe6IcnM1oZYfkM3dovkQXkavxUBfKSohNhVSqqO7l3fwF4EBSPATz8PtdFuflqgybJEhe5BfWmumoGCu5EFnI45LtfntHLSDaAd12E97UgZcGlQEUyO9xvp4TiRcblKUGlTA53B85e153TZPajPDCFMIZ9Q3mmcGmdwC86BJ2Q6CrHspbzXrIr+rdGsVgj3jcq90qpIqpN5+YmDzTZx2CZzKE9Z5g0SxWLLm6KLum9OQGuqZ9rFbwLx6jfSTPUlUwopxFG+6c7/4MTPyxBS6DRCC/gXKEfuxJkdJ+XesVgt2r+wxywhH8v0yLkZgm9BcSbBk3WQ7Bx9YR5Dknrh12IoBF1lEqiMCXrOyMS40VcPIRbh0NUIcQVnzwZJHftEufT+K3QQMyPGGIXVeeGPL+7XEkpEcewuwhlszlNN5l8CiQnQ61b54g==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(18002099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ph00xmP64d/+njqXXJV/L6u+ra6Q666Zd1KbU2oRXJBW6B0nUrErgueEDgkvH6dgXFGB/bj/HelNZAbI2K5LQASO/K4zmFx8Y4VD9DAoacepRSVsduCkSdf90V843Uo0wVRBXBcz8f4CSnuBDbsQwSToJq+MJWlQW2aa7WVvbAymq2zEzPfi54so2RkBWs6M8X2PoEfv/SC/4eZDx5ktKbIMpSnBckVHoI4DFPNjlsXa5Nf5tW+bk7g24Wd4ziOo+6QqUSETPW9yEu7wiDNGnIrIt9oIbg+lNGydsBJvtFcddfIUWnvXM7OeN6ZGC2DUMwhbvfRxnkQLEaokHBBJW4ieHzH+r2PH4vqxKQtX3AruKHNmyKAx7O/yrXfKUT3YVIDzizTrWzsrnBrJY7jc13vyaAM1rXm2ObCyp5umWqpD70FjAfPatAuc775+vBWf
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 11:01:39.6327 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d9de3b-998c-4da1-25f7-08dee0ce1d93
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6185.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6270
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

Version symbols added in [1] for functions:

- rte_pmd_mlx5_driver_event_cb_register
- rte_pmd_mlx5_driver_event_cb_unregister
- rte_pmd_mlx5_enable_steering
- rte_pmd_mlx5_disable_steering

are not needed after ABI version bump.
This patch removes versioned symbols.

[1]: 556b2a33727a ("net/mlx5: add aliases for some promoted symbols")

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/meson.build         |  2 --
 drivers/net/mlx5/mlx5_driver_event.c | 22 ++++++----------------
 drivers/net/mlx5/mlx5_flow.c         | 18 ++++++------------
 3 files changed, 12 insertions(+), 30 deletions(-)

diff --git a/drivers/net/mlx5/meson.build b/drivers/net/mlx5/meson.build
index 0fa6322779..82a7dfe782 100644
--- a/drivers/net/mlx5/meson.build
+++ b/drivers/net/mlx5/meson.build
@@ -2,8 +2,6 @@
 # Copyright 2018 6WIND S.A.
 # Copyright 2018 Mellanox Technologies, Ltd

-use_function_versioning = true
-
 if not (is_linux or is_windows)
     build = false
     reason = 'only supported on Linux and Windows'
diff --git a/drivers/net/mlx5/mlx5_driver_event.c b/drivers/net/mlx5/mlx5_driver_event.c
index d0e22d6151..89e49331c8 100644
--- a/drivers/net/mlx5/mlx5_driver_event.c
+++ b/drivers/net/mlx5/mlx5_driver_event.c
@@ -236,8 +236,9 @@ notify_existing_devices(rte_pmd_mlx5_driver_event_callback_t cb, void *opaque)
 		notify_existing_queues(port_id, cb, opaque);
 }

-RTE_DEFAULT_SYMBOL(26, int, rte_pmd_mlx5_driver_event_cb_register,
-		   (rte_pmd_mlx5_driver_event_callback_t cb, void *opaque))
+RTE_EXPORT_SYMBOL(rte_pmd_mlx5_driver_event_cb_register)
+int
+rte_pmd_mlx5_driver_event_cb_register(rte_pmd_mlx5_driver_event_callback_t cb, void *opaque)
 {
 	struct registered_cb *r;

@@ -263,14 +264,9 @@ RTE_DEFAULT_SYMBOL(26, int, rte_pmd_mlx5_driver_event_cb_register,
 	return 0;
 }

-RTE_VERSION_EXPERIMENTAL_SYMBOL(int, rte_pmd_mlx5_driver_event_cb_register,
-				(rte_pmd_mlx5_driver_event_callback_t cb, void *opaque))
-{
-	return rte_pmd_mlx5_driver_event_cb_register(cb, opaque);
-}
-
-RTE_DEFAULT_SYMBOL(26, int, rte_pmd_mlx5_driver_event_cb_unregister,
-		   (rte_pmd_mlx5_driver_event_callback_t cb))
+RTE_EXPORT_SYMBOL(rte_pmd_mlx5_driver_event_cb_unregister)
+int
+rte_pmd_mlx5_driver_event_cb_unregister(rte_pmd_mlx5_driver_event_callback_t cb)
 {
 	struct registered_cb *r;
 	bool found = false;
@@ -293,12 +289,6 @@ RTE_DEFAULT_SYMBOL(26, int, rte_pmd_mlx5_driver_event_cb_unregister,
 	return 0;
 }

-RTE_VERSION_EXPERIMENTAL_SYMBOL(int, rte_pmd_mlx5_driver_event_cb_unregister,
-				(rte_pmd_mlx5_driver_event_callback_t cb))
-{
-	return rte_pmd_mlx5_driver_event_cb_unregister(cb);
-}
-
 RTE_FINI(rte_pmd_mlx5_driver_event_cb_cleanup) {
 	struct registered_cb *r;

diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
index e8141d2100..b0eac185b5 100644
--- a/drivers/net/mlx5/mlx5_flow.c
+++ b/drivers/net/mlx5/mlx5_flow.c
@@ -12537,7 +12537,9 @@ flow_disable_steering_run_on_related(struct rte_eth_dev *dev,
 	}
 }

-RTE_DEFAULT_SYMBOL(26, void, rte_pmd_mlx5_disable_steering, (void))
+RTE_EXPORT_SYMBOL(rte_pmd_mlx5_disable_steering)
+void
+rte_pmd_mlx5_disable_steering(void)
 {
 	uint16_t port_id;

@@ -12561,12 +12563,9 @@ RTE_DEFAULT_SYMBOL(26, void, rte_pmd_mlx5_disable_steering, (void))
 	mlx5_steering_disabled = true;
 }

-RTE_VERSION_EXPERIMENTAL_SYMBOL(void, rte_pmd_mlx5_disable_steering, (void))
-{
-	rte_pmd_mlx5_disable_steering();
-}
-
-RTE_DEFAULT_SYMBOL(26, int, rte_pmd_mlx5_enable_steering, (void))
+RTE_EXPORT_SYMBOL(rte_pmd_mlx5_enable_steering)
+int
+rte_pmd_mlx5_enable_steering(void)
 {
 	uint16_t port_id;

@@ -12583,11 +12582,6 @@ RTE_DEFAULT_SYMBOL(26, int, rte_pmd_mlx5_enable_steering, (void))
 	return 0;
 }

-RTE_VERSION_EXPERIMENTAL_SYMBOL(int, rte_pmd_mlx5_enable_steering, (void))
-{
-	return rte_pmd_mlx5_enable_steering();
-}
-
 bool
 mlx5_vport_rx_metadata_passing_enabled(const struct mlx5_dev_ctx_shared *sh)
 {
--
2.47.3

