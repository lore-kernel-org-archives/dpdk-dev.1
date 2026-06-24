Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E86CDB481
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 13:15:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19A834067D;
	Wed, 24 Jun 2026 15:15:08 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013043.outbound.protection.outlook.com
 [40.93.196.43]) by mails.dpdk.org (Postfix) with ESMTP id 14B2040662
 for <dev@dpdk.org>; Wed, 24 Jun 2026 15:15:04 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZnjxzdzzsPV81kO2VJh1qdRUBhi+jrTrLkJyJom6H+lusw94CK0zha2+Un6n46pl0XeIozlPDJYSKR0otQhMvSVGMkbewLTxilyixyLFEXoZOnhA8cMQZ5sHqVzNrdtAEnF/MRDx+X5bETkQqdovxyjIctzSYfFWw1RGIqiCEOcbis15AMgC3WDt9Ryt4jVi4u0aqOia+ankpKlBmNV8FSx8rQTJf/sLG1CagsMvscPkzR458B4tewS4KvmRQCoVWuzihJZYgS8iUVIuV4RCchKdTS7OTuvXIHyC/9CmgmcjyhespjZ5F8wLeh/SLokiGIo/PdNCfaIlchHIanbMkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AX6QJoDuH4v2r6ClIq2LDwTS2lFB2dPw9r440WRPznA=;
 b=nWuNv8dUpYxF8djNBgzm3GVvFnMnFo4cnob+qsJg2sRrgzsULaNVJPW2WxahdfIWhZ66xqwM7BEKfoY2JbAy5ldOtHXeFMSqDrenvkC4mkafC4uNt6t8oLByt/EtougtVtPuPiAkp1+gZ+XpTfYkkW+CFFUl411T0RoRF4YU7kFAc42r0HoCY+uGJTffosv4Fhf2o1qsmzHUGk9cicHSO8mFo1YVa1z7aUPn/h5IEb9ZZzmpZBZq4NfEEf/GnFhi09fI+BGPkf0dXd6fE4lNluhyiZoxygIeigl7sFonKSgHwHTIPc3+83jG2zRuMmX6kR1ZzbAhSw2QQ1f1sjmdwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AX6QJoDuH4v2r6ClIq2LDwTS2lFB2dPw9r440WRPznA=;
 b=Ov75TdfeAqQWUh2jsuW9xhLuz8ItdYV82A+geIUBxMQNrJVK0rHJpKD4HjDZd2ak6PhBBvmYDIWp2cSQP/Mh2xDcCDGVwr+MppW4u/13KBVfsdR0QWH0dxhiEJz4qxyK6V75u1b3K4uQan52f+V46yPRb03E1mfEMVk1zIodItrQICpaAg1ftHmhPtt+p+NQAIl/SGnwGrOHqOEGO7hgaeSG9Tor0NXNHmV+ijlmlMeVqO3lCoEf6jWcDHkTJFl/R0vFG1ED0/pWNJgSfqvX22KEHBjZnbn0+WeKWULXtcvuW1WHstnnWq+I+b36Rj+ZfjRIEnq5PJeu25b199vbWA==
Received: from BL1PR13CA0443.namprd13.prod.outlook.com (2603:10b6:208:2c3::28)
 by MW3PR12MB4490.namprd12.prod.outlook.com (2603:10b6:303:2f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Wed, 24 Jun
 2026 13:14:59 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:2c3:cafe::6b) by BL1PR13CA0443.outlook.office365.com
 (2603:10b6:208:2c3::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.13 via Frontend Transport; Wed,
 24 Jun 2026 13:14:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 13:14:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 24 Jun
 2026 06:14:39 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 24 Jun
 2026 06:14:36 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: David Marchand <david.marchand@redhat.com>, Bruce Richardson
 <bruce.richardson@intel.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Yu Jiang <yux.jiang@intel.com>
Subject: [PATCH v2 3/4] net/mlx5: fix stabilized function versions
Date: Wed, 24 Jun 2026 15:13:35 +0200
Message-ID: <20260624131337.1127323-4-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260624131337.1127323-1-dsosnowski@nvidia.com>
References: <20260623113752.1100072-1-dsosnowski@nvidia.com>
 <20260624131337.1127323-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|MW3PR12MB4490:EE_
X-MS-Office365-Filtering-Correlation-Id: 75bb201d-35e3-4a43-cb20-08ded1f2980d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|11063799006|56012099006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: wuyQauoc5rlPgT4Q9LUJa25YCgl8gLvZsOsYqISNGCuJt4HrQpSj3kodiYJ0rD4Oz62AbHEqhjsIZR76JCuXI+DNFtej+OU0ulqMtzCjy4yNJSJ+v9zEHL1xLQ5L9auyQO33zH/VOX8trfTb/fd5WJkWeCJOuh5wRckhAoS3yoemg/O8YmIlE7jynMcW0kHGwae3Rums8aLgFqNZzm+LIfUyxmbC5RoszuhUiIyssgVIW+UlcVPcsPgtTs2bRFPVw5MdJ31xMZDjAXPBU0iHlmCdSivNovCKYXRpa7VWgevEHJkANsY3oimcvLmFTgfl2gtHt00mg7fto0PFa2XuKeVCBCsPgNNtoQt34rGQe63nN+c3f+t1qXXAUhW4eTzZ19bRV+UnW0+mArgzEQ0BcO1WDpgsAa2Gq8ZOkWSVrkkSHzSA7VirAVQ8RjMS4DusuMVXNl/3XbbNdK+2OVCf1A8zLsKNyHtTzHRLzX1++nx98h2VeFaxFsyewxnMBiPGmHnln2QNqr0o0ovTcUOR8yNcJWbaFj+Aj/2q4IAXb4HHSSYEBD/tpxQ2GsMPgWkCiJiqW2bpxFWXyW6kT8EvsqGyxRR+c5HDniVDeqVqBJJ1ZcnM22CyXgSrGbdiIo13v3I6KRVsfgk2ZdbmOJeQc5sV2Qeg88Osk4U10dJfERWoF+igDaNqFwtSD2pna7RymTzOupyROL6gACPYgEsLYw==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(11063799006)(56012099006)(4143699003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZDjlgnoJJeg5MBd2moBMJ79toj9iXolljsOQtyTVeJ+dRqdEaQl6bk027Kplw4q2gd9kn/9j5JPWCiA8upOH3PqypgtipT6Ixqw8Loxl3pCUykNWq+8qUBPcFSiluOuYN3DFTYAxO1z6qBOQ9qM6Jai5ZoBsmJdsZXKmsPo2eRogrgKlFl1Mfwxo65aY4TopR1tzlarsDmcTjUVNBPYoe610MRv86eIXZZi+xTT2wOU5VMMqVEA1K7fzscIzLwWEQDU1BqHXkIZlADTnm+BM/XrM2VACgBPsvJepBc2sQuXQqfINSkuT6p1n6gYawWC0H3+jad3xVYG3Z7o6CvMaPhN3UJefKTOXF7PKZdjomOErbzlGwl5a+oM0fkROQ3lZgYKVUzrlwHIO7Vnq4Aar5CeHKOX5ygCNmnh/q8k2F+DocH25xJQy40YZFr+SIRWP
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 13:14:59.4603 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75bb201d-35e3-4a43-cb20-08ded1f2980d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4490
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

