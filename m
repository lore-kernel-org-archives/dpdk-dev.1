Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF2ACD6E45
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 07:33:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7DA14021E;
	Fri, 29 May 2026 09:33:36 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011067.outbound.protection.outlook.com [52.101.52.67])
 by mails.dpdk.org (Postfix) with ESMTP id 6A1C7400D7
 for <dev@dpdk.org>; Fri, 29 May 2026 09:33:35 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jDl5iIjxnrQmXBMbsXatxVUod7rVDH92HCmfUTnZiPBMiDIMDE89cwOY3a8UMDGugbGe3awrj4ce5sWHb/1XlKQJNf/FGpjADRmvNNe7KLfqKyJJ5/cnTJHA1eJSHD4pEoI6Fzu8nsECwEYrfanmYk/Zip75OQuHT4z7UIH6r/th17tYk43l03p4XAxIH/Q9ehJPOaqEZ8uFfO62PcYzuDiovAyh+tU39Q76ZH5zsyHx8AUjj8iIA9CUSG/1OQvoKQqBBYRrgZ6g0x/R8o6XaJ9rF0TUY74heHtj6ZbSNwnA+vOuTdS+FbwL0Rip2QFcLtIwg6ioWB7DmUEo1zG6DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iF8MpC3OIBY8ErMOjJrZwbEBEbmGNoBYSy/ARAfidCQ=;
 b=sJuUSgCLGjhrd4lj01//Y+eiz7qZh/czo3WpoYbdZ5Zin9KpO33I2v+WDE0vGSUKDm/nSQ1XhwMEwAz5BeIMXafu7odkGS22P5Z4j0BtEhsnH2OrFG9IQNE43Yl7dos7d2BGdGWoYUxZQJDZ6tQRMUQG9Z4kPthKuZsc4O8bhc0Zou4DvKKmwNZ46NS210LU/5Ofpn6Ed9IdlZUDTgMnaRqExtpLlfsfa64+wrj5cVUZPwxZQV4PUrvRZAovwx+Y2Ryx2l3hXKE9lbZBE4BVH6/oHUkS7eOhb2L/VwvZNf41b4nlCn0VE5KucW3wPIgjDZkJaBgX8saljgcjOdPDaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iF8MpC3OIBY8ErMOjJrZwbEBEbmGNoBYSy/ARAfidCQ=;
 b=qxwd0Y9umIYNYrZ7Lq+c0JrzTuMAPS3iPwC6W9AsLOCviCJERD7YrVLCJTsuUWEjgN8MhPFli6urc9xA2G4OzoUaCdPWYy3hIbZuKx7dqGG2EWCqUNnP//NlSWfKQ8VfeKxNb3uDrFbTsxOB6+k67pXW5NmQU1HHO+ZFJTIfmO1Y3qBXPP/W8FViEIHcm4JqYaijkAo5YnrgAatwstNRUKDjbxx0D69KlOkvnSpCgauV/uYAMAR9VGmPdITDSdGIZz5PffBg+7rCY9xCXacPW3C5vYancbQ7kzNz0J2rQzOc35IG2AONUDVbWb8q+nmwl9bTy+OqDyBJT04AfbkOqQ==
Received: from SJ0PR03CA0094.namprd03.prod.outlook.com (2603:10b6:a03:333::9)
 by DS0PR12MB6464.namprd12.prod.outlook.com (2603:10b6:8:c4::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.14; Fri, 29 May 2026 07:33:30 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::60) by SJ0PR03CA0094.outlook.office365.com
 (2603:10b6:a03:333::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 07:33:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 07:33:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 29 May
 2026 00:33:14 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 29 May
 2026 00:33:12 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>
Subject: [PATCH v2] net/mlx5: promote private API to stable
Date: Fri, 29 May 2026 09:32:55 +0200
Message-ID: <20260529073255.689808-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260527103357.633429-1-dsosnowski@nvidia.com>
References: <20260527103357.633429-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|DS0PR12MB6464:EE_
X-MS-Office365-Filtering-Correlation-Id: a6c7c4e9-7749-4456-ac92-08debd5494ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|13003099007|22082099003|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: XCyheZt2iWJOwZEO6KjnaAOeDp8jphrAwIoO7rZZ5LyvUMzsYzuVI5trXhu3GCDsl7+ZAhv8qF55jOC7sw8hGvq9gA/hk7u5XyPygM6ac2lqYp7W2ogm2h0lVdCoE8JDKU8OkuwE7raF5Gf7RmzolMzQHgCqcmFDgqVlv48MgoKucOwgy3rEV75oRP8X10c8bOcSs/Ch5+76mO65u59+WGN9nnZXLnh4mHbJ/UARwaMwgeZ9X/qpBwsIDkphIGTbAfY+yqDel78T5RPbInjWXY+0cyrsm4DRT5WPflPaeiROeWlQVV9d2wLjwpjAcIgcHTTyu8rNOTTFlDheT9uV8mHtV6jsOy+E/dHb2pRGM88Ca6YS35bid5PzQxELPo3BTcZqQTXVT82boG1jjkifuep1aOqLunUy82zeID247locc13zB6s7u5kfVFsBHQM1VCPLGgC3wBdFZpvATO/Gj+A9A2DVxIM25dlaxAMvMAngZ6lHsHcS07dstbiX1dieHPG7zdcQa5guq+EoxbskNk+hrgkt5Hw88/zCaYWkLu0tHdXyJDU2K2Z6H16GguLD/QBqy2ICq4+eDoze0ydKEEyht2+OlxhK8wp87sfHODRLi1NdzZJpafa6kB5eU/MB9ObyVyi+ABe+clHwwWWPtAOeICy5RolcXhvEHZu1tTh44woXmBWYcIUDzHeQxpvp74DLimkOpWJ7Mo3mO4UqQOvmlNpzVgI/mrIiri1RwWs=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(13003099007)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Oaptsa5QHBoYh0FkmI3uSo4EheUatJX3tXQuOyhHp2ST2mcqmTQhPZsvtp2Eh1ehJkc4AFR6Mf+ygOXiLtVRuX2sQsDJmd+4fhUVEaKvr0ygvve2nTXdAJn8ftjiRUF/BfcrSp6QzBozMGd05vUbP+8/6HNRawubBt+1kRdShXgh9JMBu3NkbLO8gdWCd6o2ptGl2EWpUIKWyimWOBtzOS7dXLDKzug+qfFa4fFv0C1a+oIXPvK1xTpx77IIEwsaaGjGoZ7wXtbcnQPaQ1AVmsQksLpShEZ88BC6jxjvIoRnsXG3Agveh7B+7FjfZMThknD14yhiW/yUSHPHCJYgnNy/TzGd/YarX+Y6iBhR1pvJB38YrWDYiPtVsZc6+lcGfP+6w8hzvLLPPaY2xEqogoHatcy8nLJZCK/fhY+r8uY/OYf5vUOU1eWqCfMFLKf1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 07:33:30.5457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c7c4e9-7749-4456-ac92-08debd5494ed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6464
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
v2:
- Updated 26.07 release notes.

 doc/guides/rel_notes/release_26_07.rst | 9 +++++++++
 drivers/net/mlx5/mlx5_driver_event.c   | 4 ++--
 drivers/net/mlx5/mlx5_flow.c           | 4 ++--
 drivers/net/mlx5/rte_pmd_mlx5.h        | 4 ----
 4 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 6eba91a5e9..2af24d40a0 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -127,6 +127,15 @@ API Changes
   - ``rte_flow_dynf_metadata_get``
   - ``rte_flow_dynf_metadata_set``

+* **mlx5: promoted driver event and steering management APIs from experimental to stable.**
+
+  The following mlx5 APIs are no longer marked experimental:
+
+  - ``rte_pmd_mlx5_driver_event_cb_register``
+  - ``rte_pmd_mlx5_driver_event_cb_unregister``
+  - ``rte_pmd_mlx5_enable_steering``
+  - ``rte_pmd_mlx5_disable_steering``
+

 ABI Changes
 -----------
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
index 55a26cb067..f482875434 100644
--- a/drivers/net/mlx5/rte_pmd_mlx5.h
+++ b/drivers/net/mlx5/rte_pmd_mlx5.h
@@ -620,7 +620,6 @@ int rte_pmd_mlx5_external_sq_disable(uint16_t port_id, uint32_t sq_num);
  *   - (-EEXIST) if @p cb was already registered.
  *   - (-ENOMEM) if failed to allocate memory for callback entry.
  */
-__rte_experimental
 int
 rte_pmd_mlx5_driver_event_cb_register(rte_pmd_mlx5_driver_event_callback_t cb, void *opaque);

@@ -641,7 +640,6 @@ rte_pmd_mlx5_driver_event_cb_register(rte_pmd_mlx5_driver_event_callback_t cb, v
  *   - 0 if callback was successfully unregistered or if no such callback was registered.
  *   - (-EINVAL) if @p cb is NULL.
  */
-__rte_experimental
 int
 rte_pmd_mlx5_driver_event_cb_unregister(rte_pmd_mlx5_driver_event_callback_t cb);

@@ -679,7 +677,6 @@ rte_pmd_mlx5_driver_event_cb_unregister(rte_pmd_mlx5_driver_event_callback_t cb)
  * with other functions from ethdev API used to configure any of the mlx5 ports.
  * It is the responsibility of the application to enforce this.
  */
-__rte_experimental
 void
 rte_pmd_mlx5_disable_steering(void);

@@ -697,7 +694,6 @@ rte_pmd_mlx5_disable_steering(void);
  *   - 0 - Flow steering was successfully enabled or it flow steering was never disabled.
  *   - (-EBUSY) - There are mlx5 ports probed and re-enabling steering cannot be done safely.
  */
-__rte_experimental
 int
 rte_pmd_mlx5_enable_steering(void);

--
2.47.3

