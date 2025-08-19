Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0C0CA0EEB
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 Aug 2025 11:29:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D904402D9;
	Tue, 19 Aug 2025 13:29:27 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by mails.dpdk.org (Postfix) with ESMTP id AD73E40144;
 Tue, 19 Aug 2025 13:29:25 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FfAzO2xqq5dYHnVWRg1jplNzOT8vacVRUIMeqsLUI1kW7jCO2zFuF0ysqh2hge0Ku6qn3jvUg8uiu0el3VtRoHNAitosQ2bALX58qVTUZgTo0yEksb6k2Py0ChnxS29TZ+tQ7HopkuG/AHsUfsG2/gAzbuboYbfMUGDfw9wwd0GUV3ElaSVLupHSf7R+vdwx/ksADG5hyRKOpw/V/kpTwfrR6qAvKnrRdwdfG7tYuSOyzKdTf+Sxu0OgI2SzOBBvow8EuafY2ghaa0AGfe+AU0yar7bSLxKBl58SZQWjoZ4kr8pK7G2y5bTHhKN5xYF2jfBwc0YgTlj3o5EFaX3P9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gaFOhvMUJVkw3sCOqQbLOv2MXwV9ngPc+TS3IsNMTtU=;
 b=jlvHoUJ65P5mVgCkiRpQfGBg9uCPIReFfW7sIgHEOCCCwUljuMoXt8AXti/tHxUyYMZwhXmJQ9FL42aFZnWMT1wLsFrdQzumapxkz9BLWO+L7sqWCCbXWTTdK2mOOAOoIPH7MRoxAT96h7EMBNJZAOLlhxg5s7RP4lurzftsidUKWHbqVf29fhsOEkA33Ck38Q0xp7ZUxCc+Fe8zyt401SlMv7WqjjIGxsmVPk7KI64abyp980JOsFFjG7ZUg1cDyk4mNT9iqZ0zlhYZC4zE5I07sMIUdDXhBhCEm4Pgu3X8cwGXdP7tAEgX1lOBZ3h+vhnCptQLhiFxukz144aFsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gaFOhvMUJVkw3sCOqQbLOv2MXwV9ngPc+TS3IsNMTtU=;
 b=Y9kQRsVAGYT0Nr65Ujn0Yb3sPtBcoLZtUKWJSc+IEP62S302kLc6BspPusfprGYgsDhuW+H0NJ+RALB+WnTy6fwta9CabS8Gtd+mxue8sooI9ucAeeBI1p4foBcBWb3K+0PhyBus7EbMbwqAV+IhWlfPKKdUEIUbpuwQgEK07yyiMJmJmC3sZ3U+LYuXE1i8yC4MDf/7jBepzZ9CKOURQmy05iCFM8vhQMIrYb16LgDGzgKVX8X2UMkGub1Oxc5BtomhXOPvVav3+Flg3sdrNRIO2zCN9T7TgJZjXURYoiJzuonDggQ2rBJ3SSrPr1HrIQESLbnSYYcsntn2LQQL6Q==
Received: from SJ0PR03CA0057.namprd03.prod.outlook.com (2603:10b6:a03:33e::32)
 by SA1PR12MB5657.namprd12.prod.outlook.com (2603:10b6:806:234::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 11:29:21 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::33) by SJ0PR03CA0057.outlook.office365.com
 (2603:10b6:a03:33e::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.22 via Frontend Transport; Tue,
 19 Aug 2025 11:29:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Tue, 19 Aug 2025 11:29:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 19 Aug
 2025 04:29:04 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 19 Aug
 2025 04:29:01 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Michael Baum
 <michaelba@nvidia.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: [PATCH v2] net/mlx5: fix indirect age action handling
Date: Tue, 19 Aug 2025 13:27:42 +0200
Message-ID: <20250819112742.1068903-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <net/mlx5: fix indirect age action handling>
References: <net/mlx5: fix indirect age action handling>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|SA1PR12MB5657:EE_
X-MS-Office365-Filtering-Correlation-Id: 27e0c74f-c62b-4773-4876-08dddf13a484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?idpPxV752MvFl6gaD+R7O8UwRpi/XfOyE3x8OlnWVSJdPK65FrJ+dVJZiAd1?=
 =?us-ascii?Q?VsTbnB8doX0tS5HCGDq6BPTb+2GPswCPupg1eVGgwdikjNjZoc0tapAnPvz/?=
 =?us-ascii?Q?zDltenOLE8yffQgcIWSK7SoiChuoV/OroWzUwCh0WS6Ts/UNSar4erdYSuQ5?=
 =?us-ascii?Q?NIxaCxPNJB6hRbBPatNCI3iQvKPSZwws3pJfRxu7pcr8xMUaFcPAnG7gsgoG?=
 =?us-ascii?Q?Pp0mTV5zUB/6wE+vTuU3qQlKM6X/UoY4YNTNzDDdKW0bHBnskpFDhGJc6LQc?=
 =?us-ascii?Q?jPn6pBZLzQwSos5W8daMwtGkYrBLt6PSN3myE4qMLRmZUqFcfp3dVY3d4joB?=
 =?us-ascii?Q?mRwK7kfX/iV1remCgYv4Q6s/Bh/dUEKCFLWa6pLBGBv+UnoAw17HXnZtjuTV?=
 =?us-ascii?Q?kbUi1alS5XCuz4nDVfObUma9x88IgoQkF5M3vM5dbJZKZNkKksDKEzrPt3LW?=
 =?us-ascii?Q?KVMJjizFMV7haXkPKjdHGrw628/Mw5v4k03y2vcAwf730tQMho9IFSlgBNZj?=
 =?us-ascii?Q?yC0Ll9udBjCKnBLwszln2wxgXsugNwZiG1hQ55GhIV7yi9bagbLy8QgrwF8V?=
 =?us-ascii?Q?qIelaVJex3vHS6DrXEkjXbslQ9/GZUfNVR5AXKmofAKR/HSuiGLuzo3bNm29?=
 =?us-ascii?Q?smmXvvRSOX/7TbdZ+SN84GoUYVOE7c+2fFHmjwO7/MSMJZ+B9X8ECqeciUVQ?=
 =?us-ascii?Q?nSB6/THiCsSVdSr/0isH7YrpwXXMYwo1+yyVA/m5iTklmMcOqFCvcabo9ypo?=
 =?us-ascii?Q?92UGm8GvGeYsgxKEMsVF+g8lnahRipqySfmyhF7ybP047WUzEEsIoNQdWXcJ?=
 =?us-ascii?Q?jouO+Qcy5YripoOrOKu+A6ohmYrOcmAlTlSt+jbbFFlRl0mq3WDr/JRO4v4X?=
 =?us-ascii?Q?fHXYHFw0AsiUxfnE9stHAn3Jz7RRePryTCfV5NPZ5BrvXoaW/NtoblcS4NML?=
 =?us-ascii?Q?i2WZ4g4pfCfQmp3p3ftYxEBTPIMR+JK0o24HAm1ErwvaWVrzDcMpVzm9aE8w?=
 =?us-ascii?Q?zMvduZjDUDJL8o+NRRDt4YFFnPgcT+IJGqcVHUXW09j9pG/HdX8Cn5Ky3kWW?=
 =?us-ascii?Q?ug5iT0BN/n16GuRDH/n6EK2eM7erdiDUs85jJz/7208TOmKYRpxTtnaxwlYg?=
 =?us-ascii?Q?WoohypGsDey2kdd5OGsupgGieTMA+M8cA4sSBpMAREHUMOUNrqDwBy35Wkl5?=
 =?us-ascii?Q?RjI07PfzWHo4W4s+DOopKh5GcJvwF5YEgtjBuukR0TmB+aBn7hbh2BXjJvuV?=
 =?us-ascii?Q?RcAtugYiRz1eoFzADq5RGqIHzk3++T3BidbPF1AqlNC4Ns/vMrJWCyM7g5JG?=
 =?us-ascii?Q?y7Fko3WZW9pDjyMe6z4EGUAjRb0pho73xIo0ILXIkCGU40LgAzdY8Lw3lDZr?=
 =?us-ascii?Q?j+f57vjaaF9MIeswlYNMGHXqXHe9jlYd9FC3Gy4DkMvVzeokBnJpqQT4FZNG?=
 =?us-ascii?Q?DHYsFmETB50iCBfF+LXSm/7YO/Smf83FuFu06PFUo7PEuMusizCJbbQdzpZk?=
 =?us-ascii?Q?FukUfdGE2YuWpYgaOLtmPDDZbyH/XUUSAunv?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 11:29:21.2046 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e0c74f-c62b-4773-4876-08dddf13a484
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5657
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

Indirect AGE flow actions can be created either through synchronous
or asynchronous flow API.
mlx5 PMD stores the queue used to create that action to support
strict queueing. When action is created through synchronous API
invalid queue index is stored instead.

Whenever a flow rule is created with indirect AGE and
direct COUNT flow actions, PMD allocates a HW counter for ageing
that flow rule during rule creation.
During allocation of the counter a queue index is needed
to select a proper counter pool cache.

In case when indirect AGE action created through synchronous API
was used in that case, the associated queue index was used
to select pool cache. Since queue index was invalid, PMD crashed.

Counter can be allocated using the index of currently used queue and
it does not have to match the queue used to create AGE action.

This patch fixes the crash by using the index of currently used queue
for counter allocation.

This patch also adds missing validation for synchronous
and asynchronous AGE flow action creation:

- If strict queueing is disabled, only synchronous creation is allowed.
- If strict queueing is enabled, only asynchronous creation is allowed.

PMD documentation is updated accordingly.

It also updates validation of synchronous query
of aged flow rules in regards to strict queueing.
When strict queueing is enabled, synchronous query is rejected.
This aligns PMD behavior with API description.

Fixes: 04a4de756e14 ("net/mlx5: support flow age action with HWS")
Cc: michaelba@nvidia.com
Cc: stable@dpdk.org

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
Acked-by: Raslan Darawsheh <rasland@nvidia.com>
---
v2:
- Rebased on latest commit in next-net-mlx-main -
  031f4aad9ea6 ("net/mlx5: fix panic for non template age rules flush")
- Added validation of rte_flow_get_aged_flows() to match API docs -
  reject when strict queueing is enabled.

 doc/guides/nics/mlx5.rst        |  4 ++++
 drivers/net/mlx5/mlx5_flow_hw.c | 24 +++++++++++++++++-------
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index 20cfbe3a9a..b5f71cf84f 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -2740,6 +2740,10 @@ With :ref:`HW steering <mlx5_hws>`,
      in addition to flow rules using only age (without count action).
    - ``nb_aging_objects`` is the number of flow rules containing age action.

+#. With strict queueing enabled (when ``RTE_FLOW_PORT_FLAG_STRICT_QUEUE`` flag is passed
+   to ``rte_flow_configure()``), indirect age actions can be created
+   only through asynchronous flow API.
+

 .. _mlx5_quota:

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 3da8d93454..782f7982aa 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -3180,6 +3180,7 @@ flow_hw_shared_action_construct(struct rte_eth_dev *dev, uint32_t queue,
 	uint32_t type = act_idx >> MLX5_INDIRECT_ACTION_TYPE_OFFSET;
 	uint32_t idx = act_idx &
 		       ((1u << MLX5_INDIRECT_ACTION_TYPE_OFFSET) - 1);
+	uint32_t *cnt_queue;
 	cnt_id_t age_cnt;

 	memset(&act_data, 0, sizeof(act_data));
@@ -3230,9 +3231,8 @@ flow_hw_shared_action_construct(struct rte_eth_dev *dev, uint32_t queue,
 		if (param == NULL)
 			return -1;
 		if (action_flags & MLX5_FLOW_ACTION_COUNT) {
-			if (mlx5_hws_cnt_pool_get(priv->hws_cpool,
-						  &param->queue_id, &age_cnt,
-						  idx) < 0)
+			cnt_queue = mlx5_hws_cnt_get_queue(priv, &queue);
+			if (mlx5_hws_cnt_pool_get(priv->hws_cpool, cnt_queue, &age_cnt, idx) < 0)
 				return -1;
 			flow->flags |= MLX5_FLOW_HW_FLOW_FLAG_CNT_ID;
 			flow->cnt_id = age_cnt;
@@ -13136,6 +13136,14 @@ flow_hw_action_create(struct rte_eth_dev *dev,
 		       const struct rte_flow_action *action,
 		       struct rte_flow_error *err)
 {
+	struct mlx5_priv *priv = dev->data->dev_private;
+
+	if (action->type == RTE_FLOW_ACTION_TYPE_AGE && priv->hws_strict_queue) {
+		rte_flow_error_set(err, EINVAL, RTE_FLOW_ERROR_TYPE_STATE, NULL,
+				   "Cannot create age action synchronously with strict queueing");
+		return NULL;
+	}
+
 	return flow_hw_action_handle_create(dev, MLX5_HW_INV_QUEUE,
 					    NULL, conf, action, NULL, err);
 }
@@ -13355,6 +13363,8 @@ flow_hw_get_q_aged_flows(struct rte_eth_dev *dev, uint32_t queue_id,
 					  RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
 					  NULL, "No aging initialized");
 	if (priv->hws_strict_queue) {
+		/* Queue is invalid in sync query. Sync query and strict queueing is disallowed. */
+		MLX5_ASSERT(queue_id != MLX5_HW_INV_QUEUE);
 		if (queue_id >= age_info->hw_q_age->nb_rings)
 			return rte_flow_error_set(error, EINVAL,
 						RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
@@ -13408,10 +13418,10 @@ flow_hw_get_aged_flows(struct rte_eth_dev *dev, void **contexts,
 	struct mlx5_priv *priv = dev->data->dev_private;

 	if (priv->hws_strict_queue)
-		DRV_LOG(WARNING,
-			"port %u get aged flows called in strict queue mode.",
-			dev->data->port_id);
-	return flow_hw_get_q_aged_flows(dev, 0, contexts, nb_contexts, error);
+		return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_STATE, NULL,
+				"Cannot get aged flows synchronously with strict queueing");
+
+	return flow_hw_get_q_aged_flows(dev, MLX5_HW_INV_QUEUE, contexts, nb_contexts, error);
 }
 /**
  * Initialization function for non template API which calls
--
2.39.5

