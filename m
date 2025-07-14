Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF2FC83F1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Jul 2025 10:05:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4F02402D4;
	Mon, 14 Jul 2025 12:05:13 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by mails.dpdk.org (Postfix) with ESMTP id 280D6400D5;
 Mon, 14 Jul 2025 12:05:11 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKUYZKTB4ZgKuJd/E38F8GjnuEwybFwDwAMVdxawH2NlAf6F3srLqgP1AYhYCQuMef3mzlD0G6wCpPMOXLqsIMQ+rVuD6l745ByLr4ngUXOt1bNtkhljsMtUmdtJfoilxy8ip8NzwXnD5cm5BT5of08meN3ivrciFALccR9/Ai9wQ5S8NPUET1PEerWfWdyatiovBXMOzXlJ9tbR4eBzp9+YXkAhqLPK7y9wxo1xDQzGP0X97fkw3vli5B3BC093fdmzhrSa78b5vr9vDK2Q+SRVpiIMeLSmCQpiizieARi+0B1UmhkvhJB79nDGqOH7rjtaSZLmnTwf3CWZook8Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhpyspp+RJ0PHDcaHNbdyUD/4bYDZfk9MldasTKtFhs=;
 b=rumqi2ysmXVwcT0mTj4W8tDhO/tk5MTAV4s4ALsbplwue90/+qDmonJjtMHLRTp2vJkRRIo/rv+Ncc6JnNrn8Lxhk3TZ1qgoCSxe4uQuuJJpE/SBJ6PZbQ31srJSpVs4XgZ4geEfu+0YEzWVtWxIo1W/Df7PhRN4PRjnbXecAw/pmibfk2D3EtWadRIMqKraX5yMm2HR4cP30jQuazZdxpSCfPAS8iUgQnLYJExMq3ngS84z2Yra/fNBoVWIP8VWfbYJ29DBCDkVz9jKkuxCfNVsiLO+MGRCps5KHQBoGCHdSC2cdriZ/4JNgGjjwJcs76VzImGHMeIUmzjaxH9diA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhpyspp+RJ0PHDcaHNbdyUD/4bYDZfk9MldasTKtFhs=;
 b=ToG/ZODmRhuFxBhaMPqTqwTVfw2zUfNcDh/YJ9pjTmYg8Yu5O80bdBtUsuPSKiy6b2IVpnZO1040rG7dFNQTLvUcsVU2/kkVIarpSz5vAdYmUYD0mfbzI7Fakz/+6NvFTt9uW7my9bhfFIW+E5PBldcHJojXs4OuU+faqtr38ORnGtf3ofQzcjJN/WAl9cOsHRDx9l+mQNVIJ75CCg3ESQyDInV1Xzyg7UqhkzQ9XEbNkzk0AYzbARuNXOGWPu4nkqYEr6R7K3LeXCKbxi0bWLMmvYv84ExcKGUN1loPUHjBVqvHMSBbtTmwgGGnwoyuLrcE24TIR0pHcsOHn9b6Yg==
Received: from DM6PR11CA0047.namprd11.prod.outlook.com (2603:10b6:5:14c::24)
 by DS0PR12MB7993.namprd12.prod.outlook.com (2603:10b6:8:14b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Mon, 14 Jul
 2025 10:05:08 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:5:14c:cafe::40) by DM6PR11CA0047.outlook.office365.com
 (2603:10b6:5:14c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.30 via Frontend Transport; Mon,
 14 Jul 2025 10:05:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Mon, 14 Jul 2025 10:05:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Jul
 2025 03:04:56 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 14 Jul
 2025 03:04:54 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Michael Baum
 <michaelba@nvidia.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH] net/mlx5: fix indirect age action handling
Date: Mon, 14 Jul 2025 12:04:37 +0200
Message-ID: <20250714100437.993231-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|DS0PR12MB7993:EE_
X-MS-Office365-Filtering-Correlation-Id: 33925708-5263-4f9f-18c2-08ddc2bde9ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VDiV9cxU/4mfbiYlsLtWGsCga8nLMIu4LezxCNLjrupF/TFULycO4Mxwpn9y?=
 =?us-ascii?Q?WfEEcNp0iODPZuDWNVRONnlolq1RdXYk31EcJXDpBVG3E1SqGiOnCVpysrqB?=
 =?us-ascii?Q?wfZcYr0zzjVBl7iBtWIno2RdX7QreRsnwNMopJpNxMpIccGaXv+rrICTjtyd?=
 =?us-ascii?Q?1/iNLOMrvfvBzX3TAV9+XXM6AeOYVf3bYUhhzXLaaBDV7SMJtHjJ6YDJUGzZ?=
 =?us-ascii?Q?qzMY6ddI5vy9RO9xLLU2o086HeVH7FH4nrI9tP1v3QCHn9rIlKQeHT8yKRcd?=
 =?us-ascii?Q?ZhFeDQkID8BQ4YafJLhTR8YKPww8oA1ERN/wUaWNug14sdlsJSeZQQXxATqI?=
 =?us-ascii?Q?NYEIypAjB4i2erhPzebzm6vv4gIb72mjsUFXo3G7VYZUiI+6gWkKUHkOwQ4/?=
 =?us-ascii?Q?4zRQlMBR4snqDQiAdxEV7/jl78YAeJKteZrVw5R6VhSLZ0ZSmRlfp4sBWgym?=
 =?us-ascii?Q?xSrE6Yn7cYdeQPATTVvDy+FKcNGlyTjRMJ8NFwhUhzz0o/WEhZgdgnHmfFYK?=
 =?us-ascii?Q?8TwnARIHFAtwG/q7SwF+38Sd+Jig/b8BKLvlsg6+AIYBgQsuxVIigi38QFZw?=
 =?us-ascii?Q?Tagm9BH0AutT4Fo05JEI+E7PRSstssQzsoB2G9+NJnPnovf0Jqf4G2WQQjZo?=
 =?us-ascii?Q?tTJzf/8JYoiHrpkFJSyzLIfrRgPsynKhiDeolotdQtg/dlcxm1N/WTKGVlSl?=
 =?us-ascii?Q?9pkcNBNJOjNXzkf1pNQ6lEWi4HzznzDaJyTXNxsIDwCI9QF9uyMDf8Z4iFCu?=
 =?us-ascii?Q?DY8dTfFXewRLpIY7CDHfnLvRGkLE6ubFtQ//i4L7g7Ub1KNs7xP35vRUmKHo?=
 =?us-ascii?Q?d+c3EzWudYXH0eFu3sVBAF6IqnAsufm8UGrDgsM9kZQ/VU29NYHGLuILIjQt?=
 =?us-ascii?Q?uEybzCgLBEmYhxOFGB/2d5pxnZoXfi9WaYkqBIZr4WJ8qOMLTdr9oUFFuwFT?=
 =?us-ascii?Q?L6g4pKl1AVpKt8BY5hq6lMOwhJ0ezcMsGrPCa/uneuNQbEkGQlfuOePy4Ox0?=
 =?us-ascii?Q?ERzminuNVoLIGOXT4xrXsEVQ+53rKl1HawPTveJO66A1nUaTufNgd7WZk2p2?=
 =?us-ascii?Q?agdw8d1gnrJc+NAgXO77CapeNUyP+xxCcsJo4J/pslQ0cHi9jfyoK2v+bxOv?=
 =?us-ascii?Q?LaGquha0EAhlR52pdSj3hq4tsIMp/qSM1JY3Pp7zrhTlHOKL+rCjWK0D3wkj?=
 =?us-ascii?Q?SwyOWvgm16MyCVHZshCvUsqajHlz0NTHAfI20WQGcdGxAtsSCQ+QMF+4zR+m?=
 =?us-ascii?Q?SziSbwRrjbVJcYu3jPW0vq3t2Uk7mkmn3ayt0nIMH9Nt8C9yUGnj7OVzZYOS?=
 =?us-ascii?Q?vbpf4D1gmhPBOVUcKA7OZ9F9qbOnyZTSuCM6/QL9zoJtYeXfPYGoetuht67k?=
 =?us-ascii?Q?E3oJmTJCKsHoqalMpTjGqn5XtPKEPSaq6mtqOP2lwHsjvLVYeZ2lR4VeGK4/?=
 =?us-ascii?Q?iLqZFhKio4f4An9zidUJT8qNDcJP6oVwa+0JwTgiMHtnCxY1R9mfjeJyWiGu?=
 =?us-ascii?Q?6TXOkw/fgzhe7ZZlUdp/k69cjHBJcZWEW3iN?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 10:05:08.1975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33925708-5263-4f9f-18c2-08ddc2bde9ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7993
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

This patch fixes the crash by using the index of currently used queue.

This patch also adds missing validation for synchronous
AGE flow action creation - this method cannot be used when
strict queueing is enabled, since a correct queue is required
for ageing. PMD documentation is updated accordingly.

Fixes: 04a4de756e14 ("net/mlx5: support flow age action with HWS")
Cc: michaelba@nvidia.com
Cc: stable@dpdk.org

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 doc/guides/nics/mlx5.rst        |  2 ++
 drivers/net/mlx5/mlx5_flow_hw.c | 15 ++++++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index c3a350d24e..7858d00686 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -769,6 +769,8 @@ Limitations
       in different flows may cause a wrong age state for the age actions.
     - Creating/destroying flow rules with indirect age action when it is active
       (timeout != 0) may cause a wrong age state for the indirect age action.
+    - If strict queueing is enabled (``RTE_FLOW_PORT_FLAG_STRICT_QUEUE`` flag)
+      indirect age flow actions can be created only through asynchronous flow API.

     - The driver reuses counters for aging action, so for optimization
       the values in ``rte_flow_port_attr`` structure should describe:
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 6dc16f80d3..fa9190a759 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -3176,6 +3176,7 @@ flow_hw_shared_action_construct(struct rte_eth_dev *dev, uint32_t queue,
 	uint32_t type = act_idx >> MLX5_INDIRECT_ACTION_TYPE_OFFSET;
 	uint32_t idx = act_idx &
 		       ((1u << MLX5_INDIRECT_ACTION_TYPE_OFFSET) - 1);
+	uint32_t *cnt_queue;
 	cnt_id_t age_cnt;

 	memset(&act_data, 0, sizeof(act_data));
@@ -3226,9 +3227,8 @@ flow_hw_shared_action_construct(struct rte_eth_dev *dev, uint32_t queue,
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
@@ -13124,6 +13124,15 @@ flow_hw_action_create(struct rte_eth_dev *dev,
 		       const struct rte_flow_action *action,
 		       struct rte_flow_error *err)
 {
+	struct mlx5_priv *priv = dev->data->dev_private;
+
+	if (action->type == RTE_FLOW_ACTION_TYPE_AGE && priv->hws_strict_queue) {
+		rte_flow_error_set(err, EINVAL, RTE_FLOW_ERROR_TYPE_STATE, NULL,
+				   "Cannot create age action synchronously "
+				   "when strict queueing is enabled");
+		return NULL;
+	}
+
 	return flow_hw_action_handle_create(dev, MLX5_HW_INV_QUEUE,
 					    NULL, conf, action, NULL, err);
 }
--
2.39.5

