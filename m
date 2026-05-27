Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6849ECD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 10:34:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F6E540285;
	Wed, 27 May 2026 12:34:34 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010004.outbound.protection.outlook.com [52.101.46.4])
 by mails.dpdk.org (Postfix) with ESMTP id 96DDB4026C
 for <dev@dpdk.org>; Wed, 27 May 2026 12:34:33 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fotEjYZxBufJshBuqaufZ8uqEvlNb/vcz+ZsMJ3xMPLNNE4V3100a4Cdf4MEugkItQ1ymXjT2ECpg30EPGsLZLuCY7Gquh7Fv0TZoFmUA0PNaiOz3Jzc642etQK7HHOLOzELpNr+ynzU8vIog8nkwL1ZJHxFmpzyV/VmHPwWFylccaWMJnerjxL7Vy50P0+AVxjjbTZAy7O7+/MHXKgQ1ZhYTxj36INR9ZUR2Jto83IylocytsY1uHj1UUSuQWmSnWDyNLoSgi8C2oBxqe+uNUduR6gn2hZHEBHiewURb5m+I8C2WvZMEwCy5eDn5HUtL2C2TjtSi/3gnNDRUeFoqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVjDH7wpNOsC/bdfsKdA4nxOVeGN5V+x236XlCV1Vbo=;
 b=bRFej3p+rOq/lkE26LM1bD2sGnTmgUWkXMi0nXR7cpL6ExhY+Z0c2rforvDlIzHI6go0db8uCj1oh1CIV9Mq1jhq1xVgwshbNuSji5HNBC2A+Lisf8VIDvlpLuD3H4gvRAJ3v6qs9eQPjQ1qjRaweC1Ufk9jlyu+hQywI5n+YRgDU9jRsvnJl42TtiOgeK3u3bX8mr+AaSijfP67kKPvhPas6GVvGVQc75xPbutrYnP9PGzwkeRK4TWq+vE5BejgUfplKZpoDrfpYMEVTHxjKNvpHALPi5VZIDt5YqWcwSfeny/s3dQ6q7fMf6TXW1j5T8f/2EcPTJl5QCVcnld7TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVjDH7wpNOsC/bdfsKdA4nxOVeGN5V+x236XlCV1Vbo=;
 b=jIBZiB9BfLkRABVnKNtGdpDPAkSISgb52sGKpNRSwvy/9QPIEnehkyj918BOjPTHIEHwDwjUZmLUHXnVMiQQGqnOPwYFHEbVeYjHjc6hub5xBZGRdLvXfUqIWYiS8143whC59FWn/bvh/7lTz3fme7VapYFEXQxxZupRtxGaq+dd6lOTiujVcFGNPMVc3wg8thRCJS7lCEgNsm7txhCb4RF750OV2csXpYN6VArPBz/m3xufrR3bQctmqAY20vnJV5d59h0Ja87F4Nf+QZal8R6gUU980JnsiMmWo7OvuJEI1g5xVD4SDIqYrIMJAlaUbhNVpicjVOWgoknIveeUnw==
Received: from SJ0PR03CA0373.namprd03.prod.outlook.com (2603:10b6:a03:3a1::18)
 by CH1PPF934D73F2C.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::61a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 10:34:28 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::21) by SJ0PR03CA0373.outlook.office365.com
 (2603:10b6:a03:3a1::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 10:34:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 10:34:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 27 May
 2026 03:34:11 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 27 May
 2026 03:34:10 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>
Subject: [PATCH] net/mlx5: promote private API to stable
Date: Wed, 27 May 2026 12:33:57 +0200
Message-ID: <20260527103357.633429-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|CH1PPF934D73F2C:EE_
X-MS-Office365-Filtering-Correlation-Id: 03cb0548-e6f4-4a63-5102-08debbdb87fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|11063799006|56012099006|6133799003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: MKCtocdxqUjiglOOCeDVzpgXQ0Hc1UPxpQ3kEXxYgjJoZQFk/2jj6kWCVBLoA0xw5Sq6qN6cv4c/Qh6r7IDcL74kipKTcXCvxMBuC1L5XCz+NSMwWY8yuaWJMTnZGMfZmpWo3anpZpLGm74lCTEdK6x1cFk0kJt/g/WDBuLFMRodQwIollVTj64XSd0NrRBO8oTNwjBQBVgKolpErVEr90PFmubLdegrGNirG+hxle9gKZLKSDNMU67kkbLHxLCYT/CMvnpyVX/XuejGSyfGJOHk+pe3oNHe3jg1QjX+BoKubAMhbCaKwPvtJiU0gMcMo5NAoJ7jJ9aqaXchxK3MwfvfMjsxPwlQ1mhaLWaEFwRVUyolb5nqk7K/GdOY4JUfM2wfMiVytOpKy2i76cFABRky6oexOyIwGQg1YN774lZWBI5MMQQ/EPBj2BrMCXKw5Fq+R3BH/sMSeEox76GDzQzRATqlpEUTJtpvWtE8HEECy2XSBPL6mq9FlwXxm1GPOAlcCeCjjNnT8M1+VOEIQBZOeYJ/qWtt0ZAyvfMWSdxq/y8bem4809I7zHbAqlFnltVKMBXwGD/q8t4mbdIhO8Vxeds0Bggyr3nDfPK/x6GeNj4zGigjzQTvrl1JCm+/S6WYg4WYlyThSE893rMKOsit45jy2AFMBsPKs6uh05kgB2vdu+MxmT9fzovB9lMSIeYhTVJo45PoHU+OPmdZhFFrosmT/2dO23yBze7WbyQ=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(11063799006)(56012099006)(6133799003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ThWQR+N5NNuop5w0P2vEMuLxHWs/2G04W5yITuo/V0lyNUC8zOpXL5pL9zaOjSrYuwg2yrA+vC0EfaHJ35ZceJSgRWJphukZiLN4fS5gqjQKzA6JJQYCtLDEyiGE5UWpUoB+vVIojBRvYKeHazMGlvo9L8YNQNFcwCw9wUdAKGMUuE1vcJfJVd56XJ/JrKSemnCYBpuzBMtYgilzB2a82OxtCPM5mOg//zwodCxPvoJ1gU6Co/Wobj9ERL9VrGwozFPMFqYvfgq+JTySfXRov/fdjaKxnvATfNF25Xq9cAhff3r3PHPlzJmh5JVKLHMB4vjrZdbDybIa5iVEKavdU3rlVUBC14Ng2QZEWB45QQrOMXl0QAWdWDjd7RmSbNt9jMMU3+YI26wkw8fvNecXbecZWegDydLfS67oNhN9oyNEaAXkn8+4NsJnJcgO3M6Z
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 10:34:28.5640 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03cb0548-e6f4-4a63-5102-08debbdb87fd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF934D73F2C
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

Following experimental functions are exposed by mlx5 PMD
since 25.11 release:

- rte_pmd_mlx5_driver_event_cb_register
- rte_pmd_mlx5_driver_event_cb_unregister
- rte_pmd_mlx5_enable_steering
- rte_pmd_mlx5_disable_steering

First two are used to register callbacks for driver events
(when Rx/Tx queues are created or destroyed).
Other two are used to enable/disable flow steering in mlx5 PMD.
No changes were made and no changes are planned to these symbols.

These are currently used by NVIDIA DOCA SDK since version 3.3,
which started depending on upstream DPDK releases [1].
Purpose of their use is to:

- expose HW identifiers of Rx/Tx mlx5 queues managed by DPDK and
- allow flow steering to happen outside of DPDK.

Also, some of these symbols will be used by netdev-doca backend
in Open vSwitch [2].
Whenever a DOCA netdev would be added/removed in Open vSwitch,
it will have to disable/enable steering for mlx5 driver.
Stabilizing these symbols is required by current OVS policy
to remove the need for ALLOW_EXPERIMENTAL_API [3].

This patch promotes aforementioned symbols to stable.

[1]: https://docs.nvidia.com/doca/sdk/customer-affecting-changes/index.html
[2]: https://patchwork.ozlabs.org/project/openvswitch/list/?series=504726&state=%2A&archive=both
[3]: https://mail.openvswitch.org/pipermail/ovs-dev/2026-May/432066.html

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_driver_event.c | 4 ++--
 drivers/net/mlx5/mlx5_flow.c         | 4 ++--
 drivers/net/mlx5/rte_pmd_mlx5.h      | 4 ----
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_driver_event.c b/drivers/net/mlx5/mlx5_driver_event.c
index 1dc8029ee5..89e49331c8 100644
--- a/drivers/net/mlx5/mlx5_driver_event.c
+++ b/drivers/net/mlx5/mlx5_driver_event.c
@@ -236,7 +236,7 @@ notify_existing_devices(rte_pmd_mlx5_driver_event_callback_t cb, void *opaque)
 		notify_existing_queues(port_id, cb, opaque);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_driver_event_cb_register, 25.11)
+RTE_EXPORT_SYMBOL(rte_pmd_mlx5_driver_event_cb_register)
 int
 rte_pmd_mlx5_driver_event_cb_register(rte_pmd_mlx5_driver_event_callback_t cb, void *opaque)
 {
@@ -264,7 +264,7 @@ rte_pmd_mlx5_driver_event_cb_register(rte_pmd_mlx5_driver_event_callback_t cb, v
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_driver_event_cb_unregister, 25.11)
+RTE_EXPORT_SYMBOL(rte_pmd_mlx5_driver_event_cb_unregister)
 int
 rte_pmd_mlx5_driver_event_cb_unregister(rte_pmd_mlx5_driver_event_callback_t cb)
 {
diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
index 915ea29a5a..a95dd9dc94 100644
--- a/drivers/net/mlx5/mlx5_flow.c
+++ b/drivers/net/mlx5/mlx5_flow.c
@@ -12506,7 +12506,7 @@ flow_disable_steering_run_on_related(struct rte_eth_dev *dev,
 	}
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_disable_steering, 25.11)
+RTE_EXPORT_SYMBOL(rte_pmd_mlx5_disable_steering)
 void
 rte_pmd_mlx5_disable_steering(void)
 {
@@ -12532,7 +12532,7 @@ rte_pmd_mlx5_disable_steering(void)
 	mlx5_steering_disabled = true;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_enable_steering, 25.11)
+RTE_EXPORT_SYMBOL(rte_pmd_mlx5_enable_steering)
 int
 rte_pmd_mlx5_enable_steering(void)
 {
diff --git a/drivers/net/mlx5/rte_pmd_mlx5.h b/drivers/net/mlx5/rte_pmd_mlx5.h
index 7acfdae97d..8f355070e1 100644
--- a/drivers/net/mlx5/rte_pmd_mlx5.h
+++ b/drivers/net/mlx5/rte_pmd_mlx5.h
@@ -546,7 +546,6 @@ int rte_pmd_mlx5_external_sq_disable(uint16_t port_id, uint32_t sq_num);
  *   - (-EEXIST) if @p cb was already registered.
  *   - (-ENOMEM) if failed to allocate memory for callback entry.
  */
-__rte_experimental
 int
 rte_pmd_mlx5_driver_event_cb_register(rte_pmd_mlx5_driver_event_callback_t cb, void *opaque);
 
@@ -567,7 +566,6 @@ rte_pmd_mlx5_driver_event_cb_register(rte_pmd_mlx5_driver_event_callback_t cb, v
  *   - 0 if callback was successfully unregistered or if no such callback was registered.
  *   - (-EINVAL) if @p cb is NULL.
  */
-__rte_experimental
 int
 rte_pmd_mlx5_driver_event_cb_unregister(rte_pmd_mlx5_driver_event_callback_t cb);
 
@@ -605,7 +603,6 @@ rte_pmd_mlx5_driver_event_cb_unregister(rte_pmd_mlx5_driver_event_callback_t cb)
  * with other functions from ethdev API used to configure any of the mlx5 ports.
  * It is the responsibility of the application to enforce this.
  */
-__rte_experimental
 void
 rte_pmd_mlx5_disable_steering(void);
 
@@ -623,7 +620,6 @@ rte_pmd_mlx5_disable_steering(void);
  *   - 0 - Flow steering was successfully enabled or it flow steering was never disabled.
  *   - (-EBUSY) - There are mlx5 ports probed and re-enabling steering cannot be done safely.
  */
-__rte_experimental
 int
 rte_pmd_mlx5_enable_steering(void);
 
-- 
2.47.3

