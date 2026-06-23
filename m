Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1066CD98F2
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 11:39:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 747CD4067A;
	Tue, 23 Jun 2026 13:38:51 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011030.outbound.protection.outlook.com [52.101.62.30])
 by mails.dpdk.org (Postfix) with ESMTP id D608040668
 for <dev@dpdk.org>; Tue, 23 Jun 2026 13:38:49 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CU8bvh1bQ5cfL0On64FePQZpzFLo/Czym2bMSA2zrw66VLiSxpdzX6qMEqOAmQslERPkftoThJvbhZqsPrdhi8T3rE1wfRqt+dCRP/7E2bL+e77z56Asrbo25FVq2h7DlhQYdvc5KuzmlbD3i5z1Csc/VKXjYVikRRce4Q8Lx1PSklmCyWYHj9bZDR/JNjDNWWE5unvvZD97RKUOsPDogDNQkuQt2iJjiXaULtf1XJbMH8XwA6af/5ztG6QojqtLvP3leBQfZdzEBU1xvBZ3WX7Q+w3r0/THCfpaQ8wzWt6RNsSitwlGjd9Pcc0zOpHH9IBgLww+nQpTbS44PshqEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AX6QJoDuH4v2r6ClIq2LDwTS2lFB2dPw9r440WRPznA=;
 b=iUvMHYWEs+vTgKjvJLkaDAwi97HSy3yYqteuXp5xdcNpejLHR8AWzD6Af9p90Nax0vMOeL9+x8oAydEVhJ0AGeiPpZa0dr4N8W81AC/4/1YBwUy0BqJXM7RJlAhKBVmbvyidA4pKta0eZQLICJyYSrdeCB7zgiUZcG+WEP2iz6H/8T7TFepEcRPfPBhaDkCSL86/Z+PfwJzmVWyN0/8TeWl8n09bhCfGV3OzXytxLXvLwVfyUDUeTzVPg8gEMPA9e2vJfsDC+4fPV+rGHcJ22V+bmoPCrHNj7SKITVIO2pjWYd3v4lwsNeYvl/R2XXV1xWmFcBwhZUVsfxDZQqpAew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AX6QJoDuH4v2r6ClIq2LDwTS2lFB2dPw9r440WRPznA=;
 b=krWwafeHWNUnNXQy0J+D+vNSbI87+g9zO+sV7FnMWq1HrzldBkcP5yYEuMPSkppSvMKqgnVIVMBsVyFf/vqPZDMlcBRA7t6CWPI1GbZjW7gw9au2RpG9m5idurgJ8XJLFrHI7bpkGucONzMnOjka93X3mw7rtU5Db3TOZxDih+xtsvfz0F4X1P1qoNRNzIK4VGbsD96DS1ahZp1cVuyhvZSBNit26sNcFG+peDj43X5OWLxThCMNspF+EjiAf2Ha6m2HCUjOVB63qqGqVZSw1huk81AVWH2J/Q5Q+cDavA64qWOEvqxkogLp7wHs7nLaCG2CZ3bKDHgtnTfDrWkizw==
Received: from BN9PR03CA0690.namprd03.prod.outlook.com (2603:10b6:408:10e::35)
 by DS5PPF7B9F1F8E0.namprd12.prod.outlook.com (2603:10b6:f:fc00::656)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Tue, 23 Jun
 2026 11:38:43 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::61) by BN9PR03CA0690.outlook.office365.com
 (2603:10b6:408:10e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Tue,
 23 Jun 2026 11:38:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 11:38:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Jun
 2026 04:38:27 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Jun
 2026 04:38:24 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, David Marchand <david.marchand@redhat.com>, "Bruce
 Richardson" <bruce.richardson@intel.com>
Subject: [PATCH 3/5] net/mlx5: fix stabilized function versions
Date: Tue, 23 Jun 2026 13:37:49 +0200
Message-ID: <20260623113752.1100072-4-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260623113752.1100072-1-dsosnowski@nvidia.com>
References: <20260623113752.1100072-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|DS5PPF7B9F1F8E0:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bbf3e1a-af5c-4d46-41aa-08ded11bfa61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|82310400026|376014|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: 8JWBLGQZcggAV82aDmjyFPTq9DJ4AjFzl39BClPQ9gOBkngzFGTnWf+Bzl69sv+iAfmCdMufRJxLj9WuwpHuVlpmHehhH0uFXKyl433lDsAOQLObVBsnSZylSvKhLlLi8vS1YpA6a7nnffTN5TadM3hK5QFWDfwlL0cibHxXCCechEWWOeG0p9pNAS7ZAXrvu49G4OW9DBGfhykzoNSTikmrEZe7Zb74dTn2TTij7pWD2oacdr6IEiIQIM/o9V49urCsXnt84C9JE6pQt/tlykFuOe5EK2oK+lMhe1nd1kpHTENMnxX/ydgAEqGVv+MtGxQtL3OIhO9fs/AsFme+hCp/nPu0dr/x8FNYk3kD1Ep+6rHgy6NwXZdKJLgz02m0oVFW67dfXkDg8kHI0xtQzlZMI1wfuQeqsepzZNidCXR85acRdJffD6T8vmi52h65+hgsf1GtvZDBHOdKWwW5H74FXS4uEAf+gW2tcMAUhdv+SKwaao1Jt7MU6DXlO5Wzuk2o2WPPCyc4tAo5XMkTpVRWrsuWwWMd7UuvECTfDiWOgTefUTPiKQ3DheQYp9PleTddkzUmCyxyTR51cKQvAkAMQuAGpoR+kpv9iOlWjDQkhFcM+9hO+S6CCG3zZ9l/WIcWZ42C/IJAS1rV5n4yAGDNzGaLZzoraVyndrXrSZfUAc7AAXz7GBrf+2rnQrFl31KSO6g044vhfeMddZwDBA==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(82310400026)(376014)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 544UK/Yo72/o5+tncnELVzbnOZslBphhEM4Hu5RBMUdZ//f8vKuhWi/G8H7Q1L8gFjjErkhy+0yWgJzbIfdL+o0W/He4w/Y6lFt00dex8Ck8Ck6V7fP/SS3K9kPVfWTFv6wrFmsSpatsXMFGggvTij+bcDKGVjEjGoDvQ4YJB2QkFMuClIJWWfgr9B21fydvz41ETqC7Q2GwYXMpwVlBq9dvN2cXw8Zgii4wao6g+D5yBAFXhpO5YL5SqG8gltnxPXo8coYUHvof5Qs01CsXomY/dliw+YokyukasC/tZt3As5RR59PYwUhGAW202HHqjvunU/PlcUR47hIeXxPTWtNoYn2/k4RF4FjkQYsyLGWHQHJeU24+5insTSwly4yQ0NbsPnMTWgu0rzHxPnA+axT6LGEAj/ZJi+bJ1w1NFDQA7mMSbpc5rBc2mjXh1R0F
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 11:38:42.6218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bbf3e1a-af5c-4d46-41aa-08ded11bfa61
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF7B9F1F8E0
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

