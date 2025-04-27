Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117B9C369D3
	for <dpdk-dev@archiver.kernel.org>; Sun, 27 Apr 2025 11:19:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA45A402C4;
	Sun, 27 Apr 2025 13:19:51 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by mails.dpdk.org (Postfix) with ESMTP id 475A84021F
 for <dev@dpdk.org>; Sun, 27 Apr 2025 13:19:50 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PnwzZCY7gkuLq7kD2/NAzmMZg8N2VcAlg6Tl+Yav5Tr/ZqZq7ZycfPxUttQWpquaXV+n4Y79jNekKrOMRYxQMbOObB+OuJvxMHkC3O4udcU9VyrjQTX2s8ivuT8Y5eOlJiVk0bAHuaYXhI96/jvWDYMCg+saCqMq/d7bg+6ejYx7d/8NRBhNY5Xkn/DqY32xp/dCphmv90r9iQsTfxcKgHnMg+KejfBkMM41JfzBh/479Ra+QcWygvwqEe7J0xo9F+MrckYdGhZA8jzVTw0PZTBs6J4PUr6hBCnf16v45og1ykXp/L9EaOtXPRU4FErICXi1483H6bC9PP0gm2DmUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KIMMPtVxnRr110FpOkaePcBxtx+uqHn2085TCiLpz1g=;
 b=mbSbKEUwPAGNE4TEBMsViy5RAtr9VbkYuc6R5Ye/83px29f+W+oSoM8mZ4dR6aGWj7fiexV7xDIZEGXOQsY7ZhCZ613VNPnW646VUFGbRW6WGDDOIdBp5R8dVLy/MwnpjOy25BHahNB/CyI9mH5zEEEie08yx1+GfMXA38qb9elPx3mUCtRjtbYwqcoG7pxE9n3MF3ppZJjKZ0GaqRzjqErd3ukMrDP063yt9nlKhtYFKK9H2AbnItGx4Kf9egKyBQ1bbG836ZGUHZlvrJzL7KtR5ZI4pgW2KC0A1zVoyJNc1wxJubup7UhR8usJwuZ6Zlhabi1Z/3rgCtaWUPN4yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIMMPtVxnRr110FpOkaePcBxtx+uqHn2085TCiLpz1g=;
 b=NXJ+sPuTpHCAn5Hz3F2m+EyUsmKMFhKyPGIhPAFUYS3aWidF6Pp8tXh2gk6DlGlzO5cEqt6EFFMzLVoLw5s+KpYTRsWw72wNiZMtVHeBEMvBCHhzXFGmL91K0D7xWinqOH/9emd8N6Ze+aaiM6NvRDqHqnl/39FZkaSM1qAuCMfedQi7PtNX23rtLv5YSTn6FjtMLXga26s31Lh3mgWPFYCaSr/kgRcjWxcOqKc30vDHFplYy+WLMu6bG5R3vrWKvtC7qnFwuR1D4AX01AY3Vpqw2KUbu5hnF9egLy8OE+oq3eoI/L2WnbbCiJYz9b8ji+sZhsTF/vS4TDGMzoIkoA==
Received: from BY3PR10CA0004.namprd10.prod.outlook.com (2603:10b6:a03:255::9)
 by SJ0PR12MB6853.namprd12.prod.outlook.com (2603:10b6:a03:47b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Sun, 27 Apr
 2025 11:19:44 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::ec) by BY3PR10CA0004.outlook.office365.com
 (2603:10b6:a03:255::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Sun,
 27 Apr 2025 11:19:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Sun, 27 Apr 2025 11:19:44 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 27 Apr
 2025 04:19:42 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 27 Apr 2025 04:19:42 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Sun, 27 Apr 2025 04:19:39 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <dsosnowski@nvidia.com>, <rasland@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH 2/2] net/mlx5: update devarg according to SWS support
Date: Sun, 27 Apr 2025 14:19:15 +0300
Message-ID: <20250427111916.108276-2-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20250427111916.108276-1-mkashani@nvidia.com>
References: <20250427111916.108276-1-mkashani@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|SJ0PR12MB6853:EE_
X-MS-Office365-Filtering-Correlation-Id: 930e01b7-20c1-4d3c-d6c5-08dd857d69a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gVkZAtL8tQwxz3VGerz+OAnB2Wg2UY4NwuOKBALHS4/j/c+wuwQqke3BbMM6?=
 =?us-ascii?Q?Naq+Ucb2BWAKuF+hnKCUm4UCA3bgEdS0x5+kQVTLNgcMzWNsizgSNQgDgb4u?=
 =?us-ascii?Q?zy7+8yD60ZfSzTdveb+HzB8EmQUqzJq4EEoB9wJY/N1577vAnhU3vteKUg/J?=
 =?us-ascii?Q?OfKPLq8neY1mCvyJi7h7fuyXU7n+PGax+/fpTusSFKvwc0EWHODM09gHJ6V9?=
 =?us-ascii?Q?vFfLEt8cLfze3gOFYXTHKcc5qAfFUauZpABnd6paaYBoLKvLY3aCoMbaP/Be?=
 =?us-ascii?Q?MoFhm3GTc2pO93S4OPrakgLOITZhNJdkfF8TNyBfucyrrgjFjKoe1fW1f4YH?=
 =?us-ascii?Q?ncE5QkNdzL9oS9UlOEE0XyaAuEVDNxblnInB8XZE3sD9K++SP60aRDsGB4X7?=
 =?us-ascii?Q?+1/hYqepl1h8QVVkBmAggOiIRKgO+SPeVxxZNofsXx9sL6H5ohd+y++dDmC8?=
 =?us-ascii?Q?NFoRCkRpZ0jhgFxSjVeBkFXuxNVDtkFhZQSH+dVN2W6KtivDQ/UW0q4J/VTI?=
 =?us-ascii?Q?SCZa64kV8EtQ0N833C5qyedBg+IxMDPM6tsxjlc0vROTbJOCSb2ujK5AIKnE?=
 =?us-ascii?Q?ZBMzl7IY0w0xXcQSKfiPs1HoMHq0vILMoMj7cWjTFRMsdT/u9CskkCUJoh3o?=
 =?us-ascii?Q?EAACMwidYz4hGvZ6yWP+EnLqQ0/DlnkeOjoumI1AfKsvmpzRMj44tEH3PgPp?=
 =?us-ascii?Q?+a5RXb7eLTuP25tFH5gURB/Pt09HAhjpZC7AYG2+rvYqhzc3ZKfPAZTQIh7y?=
 =?us-ascii?Q?HF6t1hmjmtXFXQoIiiNL6qkJYuZC/fW/ly7dSPJrkaiIgBlnQHZz8LY7dFut?=
 =?us-ascii?Q?OpUmPNHiBMkhrL54bhXDdcMkB8Pj243vZcNONeXkMaEpLmVxrXyoXN0foOAP?=
 =?us-ascii?Q?Pr9TD4Hc0QBIp4YYcdYVQjyZOk+72PBXIZduVs0XoswX8w9QBBUSMv0vkY0n?=
 =?us-ascii?Q?Ssncc7ly4dVdGi00GOij9TVanPqrwzcdXs29LxMg+CY/veH8E3HMOl/COB7R?=
 =?us-ascii?Q?qw1NlUmP/akF7bijIGObqNBQKY5qSvk1oZBnCedzIiCcKD2uAnHXfn1lGpjV?=
 =?us-ascii?Q?SE5QlNW+kJakZ+M6FpphizQaix5zMcZ83DRQaRgjsk55UzfW49ihh4zHuVs3?=
 =?us-ascii?Q?OXKADvl7zmQeAg2zDWt/8jJ6gdoWxMWFo9e+9z1REsmKNaUpMkM6ltvqj3Q5?=
 =?us-ascii?Q?CEWdslxc8GQXxoOOsithugtkUIHqrY8ySx3LBezy24IEBXHC4ryvMP/CsPr+?=
 =?us-ascii?Q?Vs0Oliuin48v7X9ZkgHJ2c/nA/nnz+PHUchj+q2FUPF8cfASYihJTquxn9NA?=
 =?us-ascii?Q?aGSYTjGUxMpINPGtrwZ6l37PnodhcIp9LFZ+e9g6Z5C1LcpOhy58EYQGacmd?=
 =?us-ascii?Q?t9/yOrJJizaC4mkedkzI7px3mC0+EhajVeQmmU4dgp3TgWeb2YwzbI5NKAYK?=
 =?us-ascii?Q?25p/90gWTRPvaRGlhk8RB4U2+u26UH251bRpPjKSfVmMvd+GdkopNGEYkt5C?=
 =?us-ascii?Q?UDr4fEAhGBn8MJLo5j4m0J4yjpK6yedTYDJU?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2025 11:19:44.5448 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 930e01b7-20c1-4d3c-d6c5-08dd857d69a3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6853
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

SWS will be disabled in future HW generation.
Update default for dv_flow_en/allow_duplicate_pattern devargs and
return relevant error if user configuration is not supported.

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 doc/guides/nics/mlx5.rst | 10 +++++++---
 drivers/net/mlx5/mlx5.c  | 25 +++++++++++++++++++++++--
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index 08f3648e993..3a8879939f9 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -1546,8 +1546,11 @@ for an additional list of options shared with other mlx5 drivers.
   Value 2 enables the WQE based hardware steering.
   In this mode, only queue-based flow management is supported.
 
-  It is configured by default to 1 (DV flow steering) if supported.
-  Otherwise, the value is 0 which indicates legacy Verbs flow offloading.
+  Default configuration depends on HW capabilities:
+
+    - If DV flow steering is supported, it will be set to 1.
+    - Otherwise, if HW steering is supported, it will be set to 2.
+    - Otherwise, PMD will fallback to legacy Verbs and it will be set to 0.
 
 - ``dv_esw_en`` parameter [int]
 
@@ -1680,7 +1683,8 @@ for an additional list of options shared with other mlx5 drivers.
     In this case, all rules are inserted but only the first rule takes effect,
     the next rule takes effect only if the previous rules are deleted.
 
-  By default, the PMD will set this value to 1.
+  By default, the PMD will set this value according to capability
+  (For NICs supporting DV flow steering, it will be set 1. Otherwise, it will be set to 0.).
 
 
 Multiport E-Switch
diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index 646da8e846c..03f6db5ecd7 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -1488,14 +1488,23 @@ mlx5_shared_dev_ctx_args_config(struct mlx5_dev_ctx_shared *sh,
 		NULL,
 	};
 	int ret = 0;
+	struct mlx5_hca_attr *attr = &sh->cdev->config.hca_attr;
+	bool sws_is_supported = (attr->sw_owner ||
+		(attr->sw_owner_v2 &&
+		 attr->steering_format_version <= MLX5_STEERING_LOGIC_FORMAT_CONNECTX_8));
 
 	/* Default configuration. */
 	memset(config, 0, sizeof(*config));
 	config->vf_nl_en = 1;
 	config->dv_esw_en = 1;
-	config->dv_flow_en = 1;
+	if (sws_is_supported) {
+		config->dv_flow_en = 1;
+		config->allow_duplicate_pattern = 1;
+	} else {
+		config->dv_flow_en = 2;
+		config->allow_duplicate_pattern = 0;
+	}
 	config->decap_en = 1;
-	config->allow_duplicate_pattern = 1;
 	config->fdb_def_rule = 1;
 	config->cnt_svc.cycle_time = MLX5_CNT_SVC_CYCLE_TIME_DEFAULT;
 	config->cnt_svc.service_core = rte_get_main_lcore();
@@ -1510,6 +1519,18 @@ mlx5_shared_dev_ctx_args_config(struct mlx5_dev_ctx_shared *sh,
 			return -rte_errno;
 		}
 	}
+	if (!sws_is_supported) {
+		if (config->dv_flow_en == 1) {
+			DRV_LOG(ERR, "DV flow steering is not supported.");
+			rte_errno = ENODEV;
+			return -rte_errno;
+		}
+		if (config->allow_duplicate_pattern == 1) {
+			DRV_LOG(ERR, "Duplicate pattern is not allowed.");
+			rte_errno = ENODEV;
+			return -rte_errno;
+		}
+	}
 	/* Adjust parameters according to device capabilities. */
 	if (config->dv_flow_en && !sh->dev_cap.dv_flow_en) {
 		DRV_LOG(WARNING, "DV flow is not supported.");
-- 
2.21.0

