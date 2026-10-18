Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1918CCF2C9
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Oct 2026 08:55:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C082402E5;
	Sun, 18 Oct 2026 10:55:37 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010065.outbound.protection.outlook.com [52.101.56.65])
 by mails.dpdk.org (Postfix) with ESMTP id D5DE440276;
 Sun, 18 Oct 2026 10:55:35 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AwvmKTeWLAq04k/ZlcGjy9wN3uiOko1fsnLL+bE9C2GycuLcGayyWRNJ45x10iFntigYP5z+knoZbZlsVi+LFceMZhs4i6v2UHKddFVIpfhAcrVWRnMtzFHJV/sSL6BYpog9kER70gJHpAtLvSH/RGHfQz/xuFUpT4wOx4Ty6qo+eFSteO8B7e1de/ftFJT0S8NIRbeGa1yaMrR/fcyJqRQrVXa8OXCCsK0YNVGFkTR1dsJNZ6OsOpgk4c2aWQMAqJpSd0E88elie2PIHcPvgxXhdMnM/MWEewR+84rR6H9U9rT5Q0VGWDaG3uT/LsR2GylN/GMSapfI9XCNijhsSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yD1dTg2njSoiS6oYXiLQcVbeAvkQExJfF0EFvQ58tkQ=;
 b=LUQOSJCXDu/I3BC4tKBzAQSeFRRYqmED19GdYpyIwvmyzI3RqF9A4qXtMvc35DCu28EhE56A1l54ov1lEG5rrorSiMVD0IEVctizcQRKDLIEXYAxBZizLCPYC2aIHhBhrWkFRgYe+J5KZ9Kql6Wt8BaXfPhCfW5tq3oW0xb7UZfHqHTh4l4Xe5liTsCFwr+M9UT5AWRUM+xq19yZZBndq3Uka58drFEOHcDWjjpU5fRFdFDnta0oYZv0Ab3l9LBY4CHsnUHjlMjP4miK3HN/3BzmHAIynJ/WUEhTi2n3F6Cyhrk3DgxX7UXzrSgc7tcQF6s57hjxgUn0kJKQIAknmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yD1dTg2njSoiS6oYXiLQcVbeAvkQExJfF0EFvQ58tkQ=;
 b=E+SOw7dFCF/MLWtWdMWJ+Rj+0RdUp6r44tolvnWHjHMBnnj5nl8oDuH+xF495R0kMafnoewrW16hLMe49Tfx0rzAGY83y9zxUyvHYaEa0vE0yXmExFbtIxF/LC2ggAWLkHpXSF/N590cLLToNNrYIIBhVLkyBIjKH+sCmiWp03GPuV6NRwaaFfZ1LPsJJIbCG55tm0zLQStPDQ4d9M7k5PByTUtZbeUdrbz85GsBudSzy01VcuNXPqTOKMEsRSlCuRb74rj6Eg8RaV/5CUjKV8qLD2ntIQHIY7ucUKh6zfByH5Itcpiu6XqVYUOW/6bXjOu4KIuZj5RFxvHTV5nYSw==
Received: from SJ0PR13CA0046.namprd13.prod.outlook.com (2603:10b6:a03:2c2::21)
 by MW4PR12MB7357.namprd12.prod.outlook.com (2603:10b6:303:219::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Sun, 18 Oct
 2026 08:55:31 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::25) by SJ0PR13CA0046.outlook.office365.com
 (2603:10b6:a03:2c2::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Sun,
 18 Oct 2026 08:55:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Sun, 18 Oct 2026 08:55:30 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sun, 18 Oct
 2026 01:55:17 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sun, 18 Oct
 2026 01:55:16 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Sun, 18 Oct 2026 01:55:13 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <rasland@nvidia.com>, <stable@dpdk.org>, "Dariusz
 Sosnowski" <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Alexander Kozyrev <akozyrev@nvidia.com>
Subject: [PATCH] net/mlx5: fix HWS meter ASO SQ leak on multi-port init
Date: Sun, 18 Oct 2026 11:55:09 +0300
Message-ID: <20261018085510.8592-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|MW4PR12MB7357:EE_
X-MS-Office365-Filtering-Correlation-Id: ed86298b-fb53-4fcc-b2bd-08df2cf5901d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|6133799003|18002099003|11063799006|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: JjivVb9rvUQwei8FENvaHYdIX3KdZigl/MvZSudzAhoAJW6RSSRl7P0BxCwO6jXznL8yv1Gaz9Sd8d0V3Inhjvgl4LVUfLxhDayRF7chVZLUQHQQ/VeHKpZd7XPu/s53vy/4anHYtRphG9AOIlM4oyXrt3Dqqm/SJzBxKsZ/6ahyfeiGFyVYlkuD6zno2O60wCRTL6Pe/8FaYGPiNEApNrvuAzuPuvOgEqKi+MDElbWsoETP/d0kJHp7JCJjdd6fyDHkERH3Bz8hCZuS+/Wlb1lLbxxzaLYsrSF0byeUfEM0YPALZVPv6+wM906t3X/ANWZ6R8BS/heuNLl/b0bmNzVj2Zi21PjqEpHhKRePfjQId1uxAzzK+XEKoZPvmZsW+N9H+fi0FFKpd0rqqcSSXOgztj00HQIAX2O3sN5JVM7iSzVSHmAS0ZbmvwAqt5/+pmuVchvLPSQGcyY/mcfa+tjNt/COstveQxOq1j++GegLNe/H5Sq8DhlqZ1WuyIy3F59OPFdqxyKO1x7w+6Ev0nqpuIc+hVOaFt7Y6i+hkfSD8Sd7ThjLDJ8S1hmMKVsIXGl7cKxlywkG+V6YBiG8yJBkb8PJY+Cc1fcjevHZpvvmk9kvnj4PP4KlVeG07vU7mDQkvGsnC87buj8SrTqwCuC6e8LI1PTclN7pVdtcFswKVl8sD8Nv5UbfJGQFvGBRJSKiC15D6R9CSpbo/QDXgg==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(6133799003)(18002099003)(11063799006)(10067099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xhQnGbBlPLvIHnsMIdrgiVHwRjfkkgzLnz2RmqDUMQydtpcPDN+FJw4HXtyP8/OEbUkdbuppFTPVGJAz2KYErCUsLPbXh/upwc4qePelFQlRNxRD41344mM+K2nMH3H4Q5PScvXaXn1wK57OdzEcKjdMmCgFFKY15CSe+kXkDFuwCNGym69Qfuyag2uNiSqhYeKEt49/P+hje2tDPWWkU5iksBY0QZ183wtG8lQsHH3IzhH+6WN60zBnVRObwZgg6Gx1rOSAMeOYbAs+r4qbTeYanJBv4fHwGVh9kn7yRIsE2GRGczJqvhoga1qJwvNiB7foK6F4N4DgvxzxA/bXqZTidCnnYsdqH4wJMdV9d5+RukZCMQn58SLC5cZVgDevrBXLeEpo39u9FuQvggWKcw3HEEFaFbWOxUYE+P8bNxco7O23xYF3nqzk3gOgt7CC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 08:55:30.5035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed86298b-fb53-4fcc-b2bd-08df2cf5901d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7357
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

When multiple ports on the same device initialize HWS meters via
rte_flow_configure(), mlx5_aso_mtr_queue_init() recreates the shared
pools_mng ASO send queue without destroying the previous one. Each
additional port with meters configured leaks one SQ/CQ pair until the
shared device context is torn down.

This is observed as steady growth of hugepage allocations (dump
socket_mem count alloc) when repeatedly attaching and detaching a device
with multiple SF representors configured with meters in HWS mode.

Create pools_mng.sq only when its DevX object is missing. A send-queue
id of zero is valid, so sqn cannot be used as the existence check.

Do not destroy that queue from mlx5_flow_meter_uninit(). It is shared
by every port on the device, and releasing it when one port closes
breaks meters still configured on the others. The queue is released
with the shared context in mlx5_aso_flow_mtrs_mng_close().

Fixes: 24865366e495 ("net/mlx5: support flow meter action for HWS")
Cc: stable@dpdk.org

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow_aso.c   | 7 ++++++-
 drivers/net/mlx5/mlx5_flow_meter.c | 6 +++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow_aso.c b/drivers/net/mlx5/mlx5_flow_aso.c
index cd84ab1966d..caaa319d10e 100644
--- a/drivers/net/mlx5/mlx5_flow_aso.c
+++ b/drivers/net/mlx5/mlx5_flow_aso.c
@@ -316,7 +316,12 @@ mlx5_aso_mtr_queue_init(struct mlx5_dev_ctx_shared *sh,
 		}
 		hws_pool->nb_sq = nb_queues;
 	}
-	if (pool_mng) {
+	/*
+	 * pools_mng->sq is shared by every port on the device.
+	 * A send-queue id of zero is valid, so the DevX object pointer
+	 * is the indicator that the queue was already created.
+	 */
+	if (pool_mng != NULL && pool_mng->sq.sq_obj.sq == NULL) {
 		if (mlx5_aso_sq_create(cdev, &pool_mng->sq,
 				       sh->tx_uar.obj,
 				       MLX5_ASO_QUEUE_LOG_DESC))
diff --git a/drivers/net/mlx5/mlx5_flow_meter.c b/drivers/net/mlx5/mlx5_flow_meter.c
index e7afcf5399b..6d30f318521 100644
--- a/drivers/net/mlx5/mlx5_flow_meter.c
+++ b/drivers/net/mlx5/mlx5_flow_meter.c
@@ -60,7 +60,11 @@ mlx5_flow_meter_uninit(struct rte_eth_dev *dev)
 		mlx5_free(priv->mtr_bulk.aso);
 		priv->mtr_bulk.aso = NULL;
 		priv->mtr_bulk.size = 0;
-		mlx5_aso_queue_uninit(priv->sh, ASO_OPC_MOD_POLICER);
+		/*
+		 * pools_mng->sq is shared by every port on this device.
+		 * Destroying it here would break meters still in use on
+		 * another port. It is released with the shared context.
+		 */
 	}
 	if (priv->mtr_bulk.action) {
 		mlx5dr_action_destroy(priv->mtr_bulk.action);
-- 
2.21.0

