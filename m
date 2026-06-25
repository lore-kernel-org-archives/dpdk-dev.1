Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A83CDE000
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 13:34:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FA4740DF5;
	Thu, 25 Jun 2026 15:34:47 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012044.outbound.protection.outlook.com [52.101.43.44])
 by mails.dpdk.org (Postfix) with ESMTP id C19FB40B90
 for <dev@dpdk.org>; Thu, 25 Jun 2026 15:34:43 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XFyyCCwlSOdXTd2l5GJntSbpqzLYcFaSkU2EntcFXyp3exc//55uH5MiSB5iZrZ3xVnB9uBFcd1u7Q0VL4NHdLSB5zskLZIvdzR5gML2YTdef8Uoj93uBgMAEIJbYMyQM2MQaamTRFOQvjiIOo02Fs0E9MKC2oEvxFQG+YxDL5H5iBnPSjEt/4HXfaHNZdeNNuNjypxbp7OOi8DH4fylLOkxEAg0QycDv+zwwOkEEGDvKHGVs4DpkzmnEcqsFdrRVRj/XB6RcLw/tq9Tropw/ZT+nNCAJxzKkAb4LpCxwrzqkxLPu040R63Z04n9mH7ryJwwoB7v5zeS8//wdyadBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIXx8J9om4itPuGNUP2LzXE/25Q4iidn3iJlaG8UDRU=;
 b=oKH7VwxXLH1Cz/F3nSgrZqrcBLRW7rEQTLabhlspRq8wZvx17bqiI3rQ97Vx8XsstFNKgB+mi3Ayy9eY4SGVznasy1X6O4ty0JnaT6NKtOTXTBe5zdNHlQ4J7v/Zu3iDFwkBLBraEoBHzN+UuGWICkVWuV6xuPElzH+yxqXmsJ45jL1Q/l/W2FG20e8Wf+uTO5fo6OmivXQvx4YgpDU4FcyYZf25MswrBwtQu2+cICjqWqvv+9aD9hnJjvR6V+0BXQW3Db52wy5M5S9+56vKD2vcz8+JVcfhE7J89X27SD6C8GrtYalASO7KLuAC+NRMSITZ+6MmEy4Py1BSuuML8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIXx8J9om4itPuGNUP2LzXE/25Q4iidn3iJlaG8UDRU=;
 b=kWh3z5yx4iK2kLuFIoV3c2qIODuEDmlA6OOoCiovmyhPsdPYGXzr04rhVgyThHA+vNNjb17u9xSfCeLEwrk0IR2HqwtFCwAGL3Y/q+DkW2tLOLDToax45FFyn1fEnHvOw8Wf26ft5nTG/H9vn0yRcyGN5z+rY2fn5MpW/AYMsfAT3Bwtbw6JUo39TScmrL7CXtGMqlQ6rXf6nSZeM7vPbINemKaWFtEJtVN+lD6toXwedh/dv3hnzEMZHFZl6vV26vT/BvMHsrL9SLl65xAu6wZXPDq7h22tr6790C413vsdnXNq24PnLv/Te1JMhWl6pLNmrF2l2zNpmC8KZmFZGg==
Received: from CH5PR04CA0010.namprd04.prod.outlook.com (2603:10b6:610:1f4::18)
 by DS4PR12MB9794.namprd12.prod.outlook.com (2603:10b6:8:2a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Thu, 25 Jun
 2026 13:34:38 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::90) by CH5PR04CA0010.outlook.office365.com
 (2603:10b6:610:1f4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.16 via Frontend Transport; Thu,
 25 Jun 2026 13:34:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 13:34:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Jun
 2026 06:34:13 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Jun
 2026 06:34:10 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: David Marchand <david.marchand@redhat.com>, Bruce Richardson
 <bruce.richardson@intel.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Yu Jiang <yux.jiang@intel.com>
Subject: [PATCH v3 3/4] net/mlx5: fix stabilized function versions
Date: Thu, 25 Jun 2026 15:33:09 +0200
Message-ID: <20260625133311.1299705-4-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625133311.1299705-1-dsosnowski@nvidia.com>
References: <20260624131337.1127323-1-dsosnowski@nvidia.com>
 <20260625133311.1299705-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|DS4PR12MB9794:EE_
X-MS-Office365-Filtering-Correlation-Id: 4146b4f1-e248-443f-79ba-08ded2be8144
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|6133799003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SVv5QTVJ66RRuikAvndH3K19MygDJjmX5KAkpWiKIO1Z+XzrmmJp5xmckqB4h9vfW/qFA05WWxyc0/rfMjRylrp/BKxmRug4VC2XpgDsvZptarK2kRUMu6g2a8M10mHAmzG/3OxUMk5iUvdHKEd1A1AYeT3zXzNEUnMdV3JY75ErNXh+GYejen3VM0VGqgiQnGbabHmkAufe6OFz/uQfJ0hiqUR2putA9eQUJgb3gmoFdEo4tptJzIH8jFwBJ+QaSu0FxzyjrQ7F2rzOEyc7FNuoXzbpa0PR5prdgzLiuRBrjk5JQRfJp507iAWxLDUsqXlIxeoJD3RXvfleHJDMIHS4M7YKQrGPhOG3rFZoxil7AiAkpJAQ5zwwEsDWUQSgv1ZKtcRa+hWmn3FLxO4wzrp78/IJcBB9xTkKtrVpSThZKhpfKlhbgOSAvk4mqrdfYMN7AQtkcCWgKqnaNlimqcbfw7/93I7ehqrgs1aVFTzK0y04jaJ/HV4rOH5JIqLelWA7pYnWY9vz8vIdOJhJFlNlvGR/46EB5PQAeAyxrj6JuLdiK/VVlLCGVi/7WoOdq2HnTkhrkB6qA91oOH1nzos/hSdHiFS0SnFA7g8vfp4X91gb9WODEoxRBqhurNnW1oGTbyJomonzFKzT2JlSTVt4+hEStBQBOcQzrngujwfDGyNok92DHtK9mIS+ZGLUzWhp3OYGGNp+pW8PhWCBSw==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(6133799003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HBTIP83BUqsXCLhmbImU+nao8pB2NsFynGbF6hx+v8T5HgOY2TOM/1JYhp4+wuVkoJM1PkjPxRNJo6MjHAayjADzGc+qWWMvnhtXCi9i0tqfnu7IHQpYQ6otJY1sa9jHUto9G2/WtznczdidG82JRaQl7XgR0bzaCoD9McYoVd/pmQJpEE/NXAzlzjucEfLfNk3T040YVUWsiNh2WzxBSkvKRKuCYxitHmaZCUOwyM7KsIEf+hHX059ucTT4FT4aDgCirs65pg+SMU3tfkuokw/nxN9CswOcFWwmwdRnAo97jD4ZLuk5X0KTwmmFaSR/uGUo7R5+2vmmnbZoWH5TT97U3L37HkW73dklRsYUgmFOhX0Upt7jlqz1xrNBgN+oLQ3SM88pPuXh/kpVLK+ia5yVUatVgWtVhTzUPavS1XcC8vpiYtFL0LfojJ0KJ7OJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 13:34:38.5986 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4146b4f1-e248-443f-79ba-08ded2be8144
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9794
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

Offending patch stabilized the following function symbols:

- rte_pmd_mlx5_driver_event_cb_register
- rte_pmd_mlx5_driver_event_cb_unregister
- rte_pmd_mlx5_enable_steering
- rte_pmd_mlx5_disable_steering

These function symbols were introduced in 25.11.
Any application using these functions, linked against 25.11 version,
would fail when used with 26.07 libraries, because only DPDK_26 versions
of these symbols were exported.

This patch fixes that by adding proper function symbol versioning
to these symbols.

Fixes: e8cab133645f ("net/mlx5: promote some private API to stable")

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: David Marchand <david.marchand@redhat.com>
---
 drivers/net/mlx5/meson.build         |  2 ++
 drivers/net/mlx5/mlx5_driver_event.c | 22 ++++++++++++++++------
 drivers/net/mlx5/mlx5_flow.c         | 18 ++++++++++++------
 3 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/net/mlx5/meson.build b/drivers/net/mlx5/meson.build
index 82a7dfe782..0fa6322779 100644
--- a/drivers/net/mlx5/meson.build
+++ b/drivers/net/mlx5/meson.build
@@ -2,6 +2,8 @@
 # Copyright 2018 6WIND S.A.
 # Copyright 2018 Mellanox Technologies, Ltd
 
+use_function_versioning = true
+
 if not (is_linux or is_windows)
     build = false
     reason = 'only supported on Linux and Windows'
diff --git a/drivers/net/mlx5/mlx5_driver_event.c b/drivers/net/mlx5/mlx5_driver_event.c
index 89e49331c8..d0e22d6151 100644
--- a/drivers/net/mlx5/mlx5_driver_event.c
+++ b/drivers/net/mlx5/mlx5_driver_event.c
@@ -236,9 +236,8 @@ notify_existing_devices(rte_pmd_mlx5_driver_event_callback_t cb, void *opaque)
 		notify_existing_queues(port_id, cb, opaque);
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_mlx5_driver_event_cb_register)
-int
-rte_pmd_mlx5_driver_event_cb_register(rte_pmd_mlx5_driver_event_callback_t cb, void *opaque)
+RTE_DEFAULT_SYMBOL(26, int, rte_pmd_mlx5_driver_event_cb_register,
+		   (rte_pmd_mlx5_driver_event_callback_t cb, void *opaque))
 {
 	struct registered_cb *r;
 
@@ -264,9 +263,14 @@ rte_pmd_mlx5_driver_event_cb_register(rte_pmd_mlx5_driver_event_callback_t cb, v
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_mlx5_driver_event_cb_unregister)
-int
-rte_pmd_mlx5_driver_event_cb_unregister(rte_pmd_mlx5_driver_event_callback_t cb)
+RTE_VERSION_EXPERIMENTAL_SYMBOL(int, rte_pmd_mlx5_driver_event_cb_register,
+				(rte_pmd_mlx5_driver_event_callback_t cb, void *opaque))
+{
+	return rte_pmd_mlx5_driver_event_cb_register(cb, opaque);
+}
+
+RTE_DEFAULT_SYMBOL(26, int, rte_pmd_mlx5_driver_event_cb_unregister,
+		   (rte_pmd_mlx5_driver_event_callback_t cb))
 {
 	struct registered_cb *r;
 	bool found = false;
@@ -289,6 +293,12 @@ rte_pmd_mlx5_driver_event_cb_unregister(rte_pmd_mlx5_driver_event_callback_t cb)
 	return 0;
 }
 
+RTE_VERSION_EXPERIMENTAL_SYMBOL(int, rte_pmd_mlx5_driver_event_cb_unregister,
+				(rte_pmd_mlx5_driver_event_callback_t cb))
+{
+	return rte_pmd_mlx5_driver_event_cb_unregister(cb);
+}
+
 RTE_FINI(rte_pmd_mlx5_driver_event_cb_cleanup) {
 	struct registered_cb *r;
 
diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
index a95dd9dc94..4b984df892 100644
--- a/drivers/net/mlx5/mlx5_flow.c
+++ b/drivers/net/mlx5/mlx5_flow.c
@@ -12506,9 +12506,7 @@ flow_disable_steering_run_on_related(struct rte_eth_dev *dev,
 	}
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_mlx5_disable_steering)
-void
-rte_pmd_mlx5_disable_steering(void)
+RTE_DEFAULT_SYMBOL(26, void, rte_pmd_mlx5_disable_steering, (void))
 {
 	uint16_t port_id;
 
@@ -12532,9 +12530,12 @@ rte_pmd_mlx5_disable_steering(void)
 	mlx5_steering_disabled = true;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_mlx5_enable_steering)
-int
-rte_pmd_mlx5_enable_steering(void)
+RTE_VERSION_EXPERIMENTAL_SYMBOL(void, rte_pmd_mlx5_disable_steering, (void))
+{
+	rte_pmd_mlx5_disable_steering();
+}
+
+RTE_DEFAULT_SYMBOL(26, int, rte_pmd_mlx5_enable_steering, (void))
 {
 	uint16_t port_id;
 
@@ -12551,6 +12552,11 @@ rte_pmd_mlx5_enable_steering(void)
 	return 0;
 }
 
+RTE_VERSION_EXPERIMENTAL_SYMBOL(int, rte_pmd_mlx5_enable_steering, (void))
+{
+	return rte_pmd_mlx5_enable_steering();
+}
+
 bool
 mlx5_vport_rx_metadata_passing_enabled(const struct mlx5_dev_ctx_shared *sh)
 {
-- 
2.47.3

