Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A595CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 17:48:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F2C14069D;
	Tue,  4 Nov 2025 18:48:07 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010016.outbound.protection.outlook.com [52.101.61.16])
 by mails.dpdk.org (Postfix) with ESMTP id 12DB24068E
 for <dev@dpdk.org>; Tue,  4 Nov 2025 18:48:04 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cOFXVNVWDZiJ7qzRhoXMerKlfkIJ6Vkn8IYz3DEbolkZCApPK1Cl1eomaXPbkE/Yi7/hB8epeXJagcqFrm1w5lwkvVzX+IKNbsqCUvOwqTnbemL7m4a86meDFWL967pYMAeA8cAmk/urXCgocJRqmMEM7ZwLfEvbzCLl0fR0mZ033zPlLqPZkYIvwYBy/N6ML9wRnFWWOEs8kkMbaRfx6mwlPYebhvSeuNredUNqEPL5vpeawAMDKP55syqlqrLfcVWP+ajeHdhE8Mxi3G31hQP582SaHpdp8Y7LJ2WVvewV0JChNaL4aRiMieLPqT9Sjhqiqc0rpnGAZiRnXcnzEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQhE8wV3SuuHRqVNm9FjaL8/J86rwlCU70/KNQgwZGE=;
 b=wocKf55dvdJHxxYo9ixE2+dRulldFnqPo72M6+Rmdo6MPp9Z7ddWa/AziimlsMJMushXFFwjaoV1bWR1rEOuYvkulJ4Ai0irRDgQhoDV2uh2S/1QrdwFHrSnzeCq7YBEjIdn2RCga6ngr6/nLhgvMk6uXQepjTxmTOuucXtZChSnFlzNwwbemWg3xbf9Bq1UkzH17Creke3vHIhbrZJtDdezpjqpOYTSBHZWYSrhH+UcG5J1Y3XOcm0AbtG1lSLAESL95l45T7PBGX5DAwghH7Q0OjWI6Cz7gfLkr7uQWENvX8CBVPci7YvNaXaw1kn49ybswv0Ct52shy93urTYwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQhE8wV3SuuHRqVNm9FjaL8/J86rwlCU70/KNQgwZGE=;
 b=ipuVaUNod8sQBMzG8zDQ4g3rH99K2Riy4UkLABcm9nevUqyKBSlTn3jnWcAxiI+hvy9Qr8KdLRgMdwKOeVrK1Pr2DtPx8s2B51Ta//+AB4x3iIc3kh1qjFjorAPHWAzccrXBFYO0rrrLi2R1homsHcAkRMZZ3t0ab/RmvgjEjjFWhYNcZTumTyPKY3Y+fvi5jL/UPGC0BZHHDFpx8L/0p+dL6gRMwM678+gP0LUU/wz9QehZoeSGeW5uqb8M/VN2MVZfFJSgvdzeiFei7DnotOqVhsKgmYaejMBqQ6EIeRK45hhhOWIjyxQjun2J06scE567NXLU18yjrullS0NWqA==
Received: from CH0PR03CA0090.namprd03.prod.outlook.com (2603:10b6:610:cc::35)
 by DM4PR12MB7693.namprd12.prod.outlook.com (2603:10b6:8:103::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 17:47:55 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::47) by CH0PR03CA0090.outlook.office365.com
 (2603:10b6:610:cc::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 17:47:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 17:47:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 09:47:43 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 09:47:41 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: [PATCH 5/5] net/mlx5: support count and age on root group
Date: Tue, 4 Nov 2025 18:46:12 +0100
Message-ID: <20251104174612.1341962-6-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251104174612.1341962-1-dsosnowski@nvidia.com>
References: <20251104174612.1341962-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|DM4PR12MB7693:EE_
X-MS-Office365-Filtering-Correlation-Id: b679ee35-62a3-4ebb-2b83-08de1bca48e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?naEYMe1jFmGsOmUYAhESHYLGqiHNideZUf7kIyew0+1U84YWYuPt9WQleXc0?=
 =?us-ascii?Q?c2XGLQm92uXfW2mn8yqQmM+8YvxiWxvVDup+pU1FbL+mAzynhBdDaJyCuVs5?=
 =?us-ascii?Q?tSxG8kbiyghX5QbqrpqtF1VVKgIMBL1OhwYDt265e0aClkxY4LWh4O7wNNR4?=
 =?us-ascii?Q?XRQi8niVuCIbC852goC/R3TBCAzmDLDrQr0alqwHpSSZcYjzh3jBPNrKgVgK?=
 =?us-ascii?Q?dgSGYXeKuSsbgVi3/hhIKE2yGJQ/7YnA7omZhgxhnP4cQhk0uVyOAEh3DUNA?=
 =?us-ascii?Q?Vju2INWRqAldfps46ePwe7FdnJ066VrlAErXDrgj58dHyKI6j6Df6teSLOMt?=
 =?us-ascii?Q?XRcvHFXdkqiup2TbP1C5AYSDHTk4JQ6fgB62QsAgUvRrBM1SrNUOqygjjOhv?=
 =?us-ascii?Q?RPHGAl/XFDMvkiX+/VXGpilijd2P0NYF7cAkrxfhm328LK0t4Y77gtebQ12q?=
 =?us-ascii?Q?wAOAGcn77L+00cW8gLaeLTYkamJjofjGM24TY8Aw0NHQTh8KL06PkhkjE7vU?=
 =?us-ascii?Q?CZEFZd2fworAGufhHCc7QEV3lrCA1iO8CL6jWbYQ8L5mS6h4hCXmyKYCcivQ?=
 =?us-ascii?Q?x563+XTmu5ufluBMtYhnkPKN8UZwbJzAVxNiu3wEL6lA+fTVESwiNZZcoabd?=
 =?us-ascii?Q?6SIMRaSvU0zTEKECpkKwTKHpmkJVnHMYOMeUCKHyyT0iI/Dmc9MAiQMfkzWo?=
 =?us-ascii?Q?y7uq0ppDaU7U0TzkD+itxIRDLe91OjuyfoSg9jptcXqm+KzG9PiSsw9dq0O+?=
 =?us-ascii?Q?uXzw7nqIbi91hq7BWPU7GGVj1nZ024AZ6kdnljP0qz9PSLywJjdx6bMmZ/nY?=
 =?us-ascii?Q?pSYW/Cdmz9Qg8VJOr407M37k5oiHnxglCbTT8VVqUenn6hegkUM8UMzEi+qK?=
 =?us-ascii?Q?j/6eWZXXZ0w9BXTvD834Zbb+Cvz39HmAZiWTyh+egSRAxJXn20kac4mTFx+L?=
 =?us-ascii?Q?aQV3iSBpJsEr0DlDUOyTLykqQlQy65VGEjejzMlF+Ddael+bu/tL1IcOys8L?=
 =?us-ascii?Q?jmxcbduUXqgGzAwd4KY8gzhWN/x9lFPM/mhitVJM+rg46QyHZvNvwSixPCXj?=
 =?us-ascii?Q?ZO07u7uBa9iW+YrrIV0ka4YxUBThyjeSev7ywNuzsHH4qV/pVM5iv1F616Px?=
 =?us-ascii?Q?if/EYWLmaIZ7KSGQu4stZbcTa8btC5ikIUtaviV3DRqBYkZloTAN5oR7UQ2Z?=
 =?us-ascii?Q?sqNpCnJPdqU+SBrj89zTJGjmmkvyu1dLhBB9efZHHV2Mlb0O8eDCBGcJYJNp?=
 =?us-ascii?Q?66/GdwLm5EEMDrux9x74Qfo4j2Vt2sXenLMwSZGoFkTjJC6FBTik0c3OpP0U?=
 =?us-ascii?Q?uHv4nk5gANCuPvJefAT0Pc4BBhbqlVZpnwWsc8G2YnIGzVwzfVBs5jbd3G79?=
 =?us-ascii?Q?O7RXa1vj8pVxW2gkUQS156wTsD0UDYt8OuImikSKIctlrGiEO3WB+buKlUjM?=
 =?us-ascii?Q?XWzzNAiFCtK+6qpb/3MIDJwW6kKSbzfswXYfpbZA+idAwubw8HsfbsAKbCJq?=
 =?us-ascii?Q?eeUfXEnvYZ2FH/ASVKNHUElHHtEv2mv+Qm2HSmIJ8lPzd1EmXg8YmtVzBgie?=
 =?us-ascii?Q?HbycFqFIP1ZyLHjxuD8=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:47:55.2294 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b679ee35-62a3-4ebb-2b83-08de1bca48e9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7693
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

This patch enables support for count and age flow actions
in root table i.e. flow group 0, when working
with HW Steering flow engine (dv_flow_en = 2).
It depends on support in HWS layer introduced in previous patches.

Specifically this patch:

- Adjusts action validation during flow actions translation
  to allow count and age on root group.
- Adds creation and destruction of mlx5dr count action
  for use on root group.
- Adjusts count action construction (done during rule create)
  to select correct action variant based on the group
  where the rule is created.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 doc/guides/nics/mlx5.rst               | 34 ++++++++-----
 doc/guides/rel_notes/release_25_11.rst |  4 ++
 drivers/net/mlx5/mlx5_flow_hw.c        | 66 ++++++++++++++++++--------
 drivers/net/mlx5/mlx5_hws_cnt.c        | 43 +++++++++++++----
 drivers/net/mlx5/mlx5_hws_cnt.h        | 17 +++++--
 5 files changed, 121 insertions(+), 43 deletions(-)

diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index fde98ae993..1ddd82b5d6 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -2698,19 +2698,26 @@ DPDK       19.05         19.02          21.05                    21.05
 Limitations
 ^^^^^^^^^^^
 
-Because freeing a counter (by destroying a flow rule or destroying indirect action)
-does not immediately make it available for the application,
-the PMD might return:
+With :ref:`HW steering <mlx5_hws>`:
 
-- ``ENOENT`` if no counter is available in ``free``, ``reuse``
-  or ``wait_reset`` rings.
-  No counter will be available until the application releases some of them.
-- ``EAGAIN`` if no counter is available in ``free`` and ``reuse`` rings,
-  but there are counters in ``wait_reset`` ring.
-  This means that after the next service thread cycle new counters will be available.
+#. Because freeing a counter (by destroying a flow rule or destroying indirect action)
+   does not immediately make it available for the application,
+   the PMD might return:
 
-The application has to be aware that flow rule create or indirect action create
-might need be retried.
+      - ``ENOENT`` if no counter is available in ``free``, ``reuse``
+        or ``wait_reset`` rings.
+        No counter will be available until the application releases some of them.
+      - ``EAGAIN`` if no counter is available in ``free`` and ``reuse`` rings,
+        but there are counters in ``wait_reset`` ring.
+        This means that after the next service thread cycle new counters will be available.
+
+      The application has to be aware that flow rule create or indirect action create
+      might need be retried.
+
+#. Using count action on root tables requires:
+
+   - Linux kernel >= v6.4
+   - rdma-core >= v60.0
 
 
 .. _mlx5_age:
@@ -2754,6 +2761,11 @@ With :ref:`HW steering <mlx5_hws>`,
    (``RTE_FLOW_PORT_FLAG_STRICT_QUEUE`` passed to ``rte_flow_configure()``),
    indirect age actions can be created only through asynchronous flow API.
 
+#. Using age action on root tables requires:
+
+   - Linux kernel >= v6.4
+   - rdma-core >= v60.0
+
 
 .. _mlx5_quota:
 
diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
index c5ba335cfc..40c6f30ae2 100644
--- a/doc/guides/rel_notes/release_25_11.rst
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -147,6 +147,10 @@ New Features
   * Added multi-process per port.
   * Optimized code.
 
+* **Updated NVIDIA mlx5 driver.**
+
+  * Support count and age flow actions on root tables with HW Steering flow engine.
+
 * **Added PQC ML algorithms in cryptodev.**
 
   * Added PQC ML-KEM support with reference to FIPS203.
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 4aa0a01b5e..cca8fe6f46 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -1801,7 +1801,7 @@ flow_hw_represented_port_compile(struct rte_eth_dev *dev,
 
 static __rte_always_inline int
 flow_hw_cnt_compile(struct rte_eth_dev *dev, uint32_t  start_pos,
-		      struct mlx5_hw_actions *acts)
+		      struct mlx5_hw_actions *acts, bool is_root)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 	uint32_t pos = start_pos;
@@ -1815,7 +1815,8 @@ flow_hw_cnt_compile(struct rte_eth_dev *dev, uint32_t  start_pos,
 				(priv->hws_cpool,
 				 cnt_id,
 				 &acts->rule_acts[pos].action,
-				 &acts->rule_acts[pos].counter.offset);
+				 &acts->rule_acts[pos].counter.offset,
+				 is_root);
 	if (ret != 0)
 		return ret;
 	acts->cnt_id = cnt_id;
@@ -2461,6 +2462,28 @@ mlx5_create_ipv6_ext_reformat(struct rte_eth_dev *dev,
 	return -EINVAL;
 }
 
+static bool
+is_counter_supported_root(struct rte_eth_dev *dev)
+{
+	struct mlx5_priv *priv = dev->data->dev_private;
+	struct mlx5_hws_cnt_pool *pool = mlx5_hws_cnt_host_pool(priv->hws_cpool);
+
+	return pool->is_root_supported;
+}
+
+static bool
+is_indirect_action_type_supported_root(struct rte_eth_dev *dev,
+				       const enum rte_flow_action_type type)
+{
+	switch (type) {
+	case RTE_FLOW_ACTION_TYPE_COUNT:
+	case RTE_FLOW_ACTION_TYPE_AGE:
+		return is_counter_supported_root(dev);
+	default:
+		return false;
+	}
+}
+
 /**
  * Translate rte_flow actions to DR action.
  *
@@ -2545,8 +2568,10 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 				goto err;
 			break;
 		case RTE_FLOW_ACTION_TYPE_INDIRECT:
-			if (is_root) {
-				DRV_LOG(ERR, "Indirect action is not supported in root table.");
+			if (is_root && !is_indirect_action_type_supported_root(dev, masks->type)) {
+				DRV_LOG(ERR, "Indirect action type (%d) is not supported on "
+					     "root table.",
+					masks->type);
 				goto err;
 			}
 			if (actions->conf && masks->conf) {
@@ -2781,12 +2806,10 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 				goto err;
 			break;
 		case RTE_FLOW_ACTION_TYPE_AGE:
-			if (is_root) {
-				__flow_hw_action_template_destroy(dev, acts);
+			if (is_root && !is_counter_supported_root(dev)) {
 				rte_flow_error_set(&sub_error, ENOTSUP,
-					RTE_FLOW_ERROR_TYPE_ACTION,
-					NULL,
-					"Age action on root table is not supported in HW steering mode");
+					RTE_FLOW_ERROR_TYPE_ACTION, NULL,
+					"Age action is not supported on group 0");
 				goto err;
 			}
 			if (__flow_hw_act_data_general_append(priv, acts,
@@ -2796,12 +2819,10 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 				goto err;
 			break;
 		case RTE_FLOW_ACTION_TYPE_COUNT:
-			if (is_root) {
-				__flow_hw_action_template_destroy(dev, acts);
+			if (is_root && !is_counter_supported_root(dev)) {
 				rte_flow_error_set(&sub_error, ENOTSUP,
-					RTE_FLOW_ERROR_TYPE_ACTION,
-					NULL,
-					"Counter action on root table is not supported in HW steering mode");
+					RTE_FLOW_ERROR_TYPE_ACTION, NULL,
+					"Count action is not supported on group 0");
 				goto err;
 			}
 			if ((at->action_flags & MLX5_FLOW_ACTION_AGE) ||
@@ -2815,7 +2836,7 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 			if (masks->conf &&
 			    ((const struct rte_flow_action_count *)
 			     masks->conf)->id) {
-				err = flow_hw_cnt_compile(dev, dr_pos, acts);
+				err = flow_hw_cnt_compile(dev, dr_pos, acts, is_root);
 				if (err)
 					goto err;
 			} else if (__flow_hw_act_data_general_append
@@ -3157,7 +3178,7 @@ flow_hw_construct_quota(struct mlx5_priv *priv,
 static __rte_always_inline int
 flow_hw_shared_action_construct(struct rte_eth_dev *dev, uint32_t queue,
 				const struct rte_flow_action *action,
-				struct rte_flow_template_table *table __rte_unused,
+				struct rte_flow_template_table *table,
 				const uint64_t item_flags, uint64_t action_flags,
 				struct rte_flow_hw *flow,
 				struct mlx5dr_rule_action *rule_act)
@@ -3176,6 +3197,7 @@ flow_hw_shared_action_construct(struct rte_eth_dev *dev, uint32_t queue,
 		       ((1u << MLX5_INDIRECT_ACTION_TYPE_OFFSET) - 1);
 	uint32_t *cnt_queue;
 	cnt_id_t age_cnt;
+	bool is_root = mlx5_group_id_is_root(table->grp->group_id);
 
 	memset(&act_data, 0, sizeof(act_data));
 	switch (type) {
@@ -3201,7 +3223,8 @@ flow_hw_shared_action_construct(struct rte_eth_dev *dev, uint32_t queue,
 		if (mlx5_hws_cnt_pool_get_action_offset(priv->hws_cpool,
 				act_idx,
 				&rule_act->action,
-				&rule_act->counter.offset))
+				&rule_act->counter.offset,
+				is_root))
 			return -1;
 		flow->flags |= MLX5_FLOW_HW_FLOW_FLAG_CNT_ID;
 		flow->cnt_id = act_idx;
@@ -3242,7 +3265,7 @@ flow_hw_shared_action_construct(struct rte_eth_dev *dev, uint32_t queue,
 		}
 		if (mlx5_hws_cnt_pool_get_action_offset(priv->hws_cpool,
 						     age_cnt, &rule_act->action,
-						     &rule_act->counter.offset))
+						     &rule_act->counter.offset, is_root))
 			return -1;
 		break;
 	case MLX5_INDIRECT_ACTION_TYPE_CT:
@@ -3476,6 +3499,7 @@ flow_hw_actions_construct(struct rte_eth_dev *dev,
 	struct mlx5_aso_mtr *aso_mtr;
 	struct mlx5_multi_pattern_segment *mp_segment = NULL;
 	struct rte_flow_hw_aux *aux;
+	bool is_root = mlx5_group_id_is_root(table->grp->group_id);
 
 	attr.group = table->grp->group_id;
 	ft_flag = mlx5_hw_act_flag[!!table->grp->group_id][table->type];
@@ -3673,7 +3697,8 @@ flow_hw_actions_construct(struct rte_eth_dev *dev,
 				(priv->hws_cpool,
 				 cnt_id,
 				 &rule_acts[act_data->action_dst].action,
-				 &rule_acts[act_data->action_dst].counter.offset
+				 &rule_acts[act_data->action_dst].counter.offset,
+				 is_root
 				 );
 			if (ret != 0)
 				goto error;
@@ -3685,7 +3710,8 @@ flow_hw_actions_construct(struct rte_eth_dev *dev,
 				(priv->hws_cpool,
 				 act_data->shared_counter.id,
 				 &rule_acts[act_data->action_dst].action,
-				 &rule_acts[act_data->action_dst].counter.offset
+				 &rule_acts[act_data->action_dst].counter.offset,
+				 is_root
 				 );
 			if (ret != 0)
 				goto error;
diff --git a/drivers/net/mlx5/mlx5_hws_cnt.c b/drivers/net/mlx5/mlx5_hws_cnt.c
index fb01fce4e5..7a2bb6fec4 100644
--- a/drivers/net/mlx5/mlx5_hws_cnt.c
+++ b/drivers/net/mlx5/mlx5_hws_cnt.c
@@ -439,6 +439,10 @@ mlx5_hws_cnt_pool_init(struct mlx5_dev_ctx_shared *sh,
 	}
 
 	cntp->cfg = *pcfg;
+	cntp->is_root_supported = mlx5dr_action_counter_root_is_supported();
+	DRV_LOG(DEBUG, "ibdev %s counter and age action %s supported on group 0",
+		sh->ibdev_name,
+		cntp->is_root_supported ? "is" : "is not");
 	if (cntp->cfg.host_cpool)
 		return cntp;
 	if (pcfg->request_num > sh->hws_max_nb_counters) {
@@ -659,9 +663,13 @@ mlx5_hws_cnt_pool_action_destroy(struct mlx5_hws_cnt_pool *cpool)
 	for (idx = 0; idx < cpool->dcs_mng.batch_total; idx++) {
 		struct mlx5_hws_cnt_dcs *dcs = &cpool->dcs_mng.dcs[idx];
 
-		if (dcs->dr_action != NULL) {
-			mlx5dr_action_destroy(dcs->dr_action);
-			dcs->dr_action = NULL;
+		if (dcs->root_action != NULL) {
+			mlx5dr_action_destroy(dcs->root_action);
+			dcs->root_action = NULL;
+		}
+		if (dcs->hws_action != NULL) {
+			mlx5dr_action_destroy(dcs->hws_action);
+			dcs->hws_action = NULL;
 		}
 	}
 }
@@ -673,11 +681,14 @@ mlx5_hws_cnt_pool_action_create(struct mlx5_priv *priv,
 	struct mlx5_hws_cnt_pool *hpool = mlx5_hws_cnt_host_pool(cpool);
 	uint32_t idx;
 	int ret = 0;
-	uint32_t flags;
+	uint32_t root_flags;
+	uint32_t hws_flags;
 
-	flags = MLX5DR_ACTION_FLAG_HWS_RX | MLX5DR_ACTION_FLAG_HWS_TX;
+	root_flags = MLX5DR_ACTION_FLAG_ROOT_RX | MLX5DR_ACTION_FLAG_ROOT_TX;
+	hws_flags = MLX5DR_ACTION_FLAG_HWS_RX | MLX5DR_ACTION_FLAG_HWS_TX;
 	if (priv->sh->config.dv_esw_en && priv->master) {
-		flags |= (is_unified_fdb(priv) ?
+		root_flags |= MLX5DR_ACTION_FLAG_ROOT_FDB;
+		hws_flags |= (is_unified_fdb(priv) ?
 				(MLX5DR_ACTION_FLAG_HWS_FDB_RX |
 				 MLX5DR_ACTION_FLAG_HWS_FDB_TX |
 				 MLX5DR_ACTION_FLAG_HWS_FDB_UNIFIED) :
@@ -687,10 +698,24 @@ mlx5_hws_cnt_pool_action_create(struct mlx5_priv *priv,
 		struct mlx5_hws_cnt_dcs *hdcs = &hpool->dcs_mng.dcs[idx];
 		struct mlx5_hws_cnt_dcs *dcs = &cpool->dcs_mng.dcs[idx];
 
-		dcs->dr_action = mlx5dr_action_create_counter(priv->dr_ctx,
+		dcs->hws_action = mlx5dr_action_create_counter(priv->dr_ctx,
+					(struct mlx5dr_devx_obj *)hdcs->obj,
+					hws_flags);
+		if (dcs->hws_action == NULL) {
+			mlx5_hws_cnt_pool_action_destroy(cpool);
+			ret = -ENOSYS;
+			break;
+		}
+
+		if (!cpool->is_root_supported) {
+			dcs->root_action = NULL;
+			continue;
+		}
+
+		dcs->root_action = mlx5dr_action_create_counter(priv->dr_ctx,
 					(struct mlx5dr_devx_obj *)hdcs->obj,
-					flags);
-		if (dcs->dr_action == NULL) {
+					root_flags);
+		if (dcs->root_action == NULL) {
 			mlx5_hws_cnt_pool_action_destroy(cpool);
 			ret = -ENOSYS;
 			break;
diff --git a/drivers/net/mlx5/mlx5_hws_cnt.h b/drivers/net/mlx5/mlx5_hws_cnt.h
index 8d7a9d34df..7d65ae82a0 100644
--- a/drivers/net/mlx5/mlx5_hws_cnt.h
+++ b/drivers/net/mlx5/mlx5_hws_cnt.h
@@ -31,7 +31,8 @@
 #define MLX5_HWS_AGE_IDX_MASK (RTE_BIT32(MLX5_INDIRECT_ACTION_TYPE_OFFSET) - 1)
 
 struct mlx5_hws_cnt_dcs {
-	void *dr_action;
+	struct mlx5dr_action *root_action; /* mlx5dr action used on root groups. */
+	struct mlx5dr_action *hws_action; /* mlx5dr action used on non-root groups. */
 	uint32_t batch_sz;
 	uint32_t iidx; /* internal index of first counter in this bulk. */
 	struct mlx5_devx_obj *obj;
@@ -113,6 +114,7 @@ struct __rte_cache_aligned mlx5_hws_cnt_pool {
 	struct mlx5_hws_cnt_pool_caches *cache;
 	uint64_t time_of_last_age_check;
 	struct mlx5_priv *priv;
+	uint32_t is_root_supported:1;
 };
 
 /* HWS AGE status. */
@@ -632,12 +634,21 @@ mlx5_hws_cnt_pool_get_size(struct mlx5_hws_cnt_pool *cpool)
 static __rte_always_inline int
 mlx5_hws_cnt_pool_get_action_offset(struct mlx5_hws_cnt_pool *cpool,
 		cnt_id_t cnt_id, struct mlx5dr_action **action,
-		uint32_t *offset)
+		uint32_t *offset, bool is_root)
 {
 	uint8_t idx = cnt_id >> MLX5_HWS_CNT_DCS_IDX_OFFSET;
 
 	idx &= MLX5_HWS_CNT_DCS_IDX_MASK;
-	*action = cpool->dcs_mng.dcs[idx].dr_action;
+	if (likely(!is_root)) {
+		*action = cpool->dcs_mng.dcs[idx].hws_action;
+	} else {
+		/*
+		 * Any table using counter on root group should be rejected on validation
+		 * when counter on root is not supported.
+		 */
+		MLX5_ASSERT(cpool->dcs_mng.dcs[idx].root_action != NULL);
+		*action = cpool->dcs_mng.dcs[idx].root_action;
+	}
 	*offset = cnt_id & MLX5_HWS_CNT_IDX_MASK;
 	return 0;
 }
-- 
2.39.5

