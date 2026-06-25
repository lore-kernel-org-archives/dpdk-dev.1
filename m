Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A110ACDE000
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 16:08:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D1DCF40A6B;
	Thu, 25 Jun 2026 18:08:15 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012021.outbound.protection.outlook.com [52.101.53.21])
 by mails.dpdk.org (Postfix) with ESMTP id EAC9040685
 for <dev@dpdk.org>; Thu, 25 Jun 2026 18:08:13 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K3aiv8/huYAEvdt3UaMZwNwzPtIIf+yae6s2OCOJN3/20RVqa5k9PhuKCEdx5JRLJdmr+eFFliKqVb80tYhFeVVrEgFCO8FGU0FS7fqKPL2ihs7jaEiTJityAD+z6BTU+t9MBlarTqclJlRszGuOSF3+vF6U3AWpbAM/M7LpBGlzusFxz/R4AD1p8GWOkn6+9rcknQfCP/3BjKswD/8aommq/E8/jJK5BpNC9hqlfSnH7C9KVSLbHXPAuql9qf7/Jt8HRQPUIcI3QobIa7zt9YyaKFtKzc/U52OCXQwwlqQo0bvslid7ZL0NclJKbPftvlNLoJlTZJ0VgUs6GEc0cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIXx8J9om4itPuGNUP2LzXE/25Q4iidn3iJlaG8UDRU=;
 b=H6XLLYiJq2YLTGFJJZs+z35ZW2RMAcp6Hm18dBmBViYVS7fsxMgBG0VgHpjlwqk/1epFREk7XShVK+VzBW6Y+hr5d42Yn1DrgP2iCLNq6Too8z139zomvFB7DewPwrNBKfNlPG5uihVes8OCXRU1AXh4P0Vx8Vv84x23bLgKR20kDUhrIJDTy1MsIadxofqMoxZ09xb9avM7GtfS22dga+4miRkcDLtzfrPUCF8Y0GfSw2r6IB0t9Dg3fbQgdxt7wov06JRjP7HuleVxmYdj3r1hJsuQGcrqtFSqMC7qJ5d2bp07pFsKtGUxpMyn5qYQiE3+Dv/W06/xvtTLhP/4tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIXx8J9om4itPuGNUP2LzXE/25Q4iidn3iJlaG8UDRU=;
 b=XDOLQafegOJ76Zf+oJaHeHChKbkiLVMh6vmXaB0H8cJMvDfXMOFvacySoknSGVxFS/silzF65Sr0vcfH0vQqM2O7jaXSQNNMOTxiA31JuwYActQQBocctehMaXkTLYY2YxPesU2w+NBUm9CKIVtatGNJmBrg5WwFCmGuGy6qLE1eqjvN49R0QDzyaOlMSOQ0TPB/1MqbJ2boxtu7FiGH36yjELXwAa+cda3Y0VULMyU9fktar20kL3FBFy7lPMmsFz5JqU7LCQbRLrxslfuQhbyo6ATk0jrv05pH+SWbciRs0lkoWnY9ckzchhGiXQ7K8d40hhtRI82b6xxiq1N/HA==
Received: from SJ0PR13CA0009.namprd13.prod.outlook.com (2603:10b6:a03:2c0::14)
 by SJ0PR12MB5610.namprd12.prod.outlook.com (2603:10b6:a03:423::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Thu, 25 Jun
 2026 16:08:08 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::9) by SJ0PR13CA0009.outlook.office365.com
 (2603:10b6:a03:2c0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6 via Frontend Transport; Thu, 25
 Jun 2026 16:08:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 16:08:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Jun
 2026 09:07:46 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Jun
 2026 09:07:44 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: David Marchand <david.marchand@redhat.com>, Bruce Richardson
 <bruce.richardson@intel.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Yu Jiang <yux.jiang@intel.com>
Subject: [PATCH v4 3/4] net/mlx5: fix stabilized function versions
Date: Thu, 25 Jun 2026 18:06:42 +0200
Message-ID: <20260625160645.1341914-4-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625160645.1341914-1-dsosnowski@nvidia.com>
References: <20260625133311.1299705-1-dsosnowski@nvidia.com>
 <20260625160645.1341914-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|SJ0PR12MB5610:EE_
X-MS-Office365-Filtering-Correlation-Id: 59adcd52-9f78-4a3e-aefe-08ded2d3f2aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|18002099003|22082099003|4143699003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: 2ickik99w0yxrJfrnFxEoF6OAbxmrNGgdsowcecGiFq3R9PEUUlBAo2S7nYWeCWu4RI70+KppB7MyOozSkaXa60rBIGW2abAP020gx+uUkcz6E4zHjOf7rs+xFdARtQ/miy+yr3uRdrDnRxbQ56sbNVIYBwsUBuyHuNDBwqwcenOkSvPGcNL2FaDvrwWBNJ27ffAFO7rryaWIVa8VcfCpUMq5amuKnuMbCHF0KnvWS4WeNqE0hK2UF0nb5iY5tVC81a3NVN1XNEkvgJ88tuSVTaGZZ72u6wEl6/u7+X+ojzO2URJOLYdtq7iP8mlydDdBPKl0FBuu/oP2pIclrYaiwR3ndsXGoIUU6k+gNjdwqeEKzUANHr7EvfDzrnReFOIYQQkA6dlB0On/4QOArEe7Rb0W/FuhpYj+OBcqFw0UY0vYzgh9C2dsv2heGRwsNEiyEcRmGo9LkyrrFKme2WX2gjLRkacCTRbBrKsrPbyuycXgDFwSEbV4rDb3crHJMCu0p2NUUrAC8BUVAcu9FdHiF3BAV0SbKB6eqOO2OwoeIbDSWt1nO0WqnJ6EptWFhMTEPasocWCyQhti2J3IuHVHxbd+tObeqohVFQhAmL/Z2CQRJICszMrZ6xArHqBnrRl/bGfG8xer3NID586n6OJ9+bSoe/C92HYdWL0c1MEaTvPBvdQOtMlG/Bs3j6/mWldSIUCtNsmrjjc95pid+WKQw==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HuPa1VOAlE//+lRJwtFrrqCRZjQJdtirq/oEC+AL3i9IuTZU2iJrR5Orcp7K8S8UDbbvwkLcXl5gf4canjzQO0L+epoX5zl4jG1DWmIowMUUAlkXgvKaUHCGSurLMGxN0C9Ihjlxj0PKs3LX9foZQciWo8rOxpqz3JGeCYdJBjyFshIVJgj5NMaTdQ2nvONh3U+C3wREc3FsF0XpP0T13Ei+jrIUozi5ROyseS3sYSldkwg4dxjVSRSN/4G8MUrOdHu85njam5xq+xczUsowScQ3JulqHvKcFqKbYCen83iV6AHSxVgDI3vzQsjSuDbVyfICqb4OgqF5YoKFU9dFGzPN14fJeNVvcQICy+TqVqq9YWQoMavMLbW211ocpZzWGOZ2V/wy41zeWTtpH3UbEdgC2QKagd4hvo0hQNp743Z2iJlr/sItvsvlLJPo+it0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 16:08:08.4144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59adcd52-9f78-4a3e-aefe-08ded2d3f2aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5610
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

