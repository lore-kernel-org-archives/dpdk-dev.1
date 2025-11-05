Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB5DCCFA0D
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 16:55:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F9D440DD6;
	Wed,  5 Nov 2025 17:55:00 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011035.outbound.protection.outlook.com [52.101.62.35])
 by mails.dpdk.org (Postfix) with ESMTP id C336D40B98
 for <dev@dpdk.org>; Wed,  5 Nov 2025 17:54:58 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PkcRsZsstFJw578u5hpO3aE3+YSGDo0A/zLbsxi0K1/DuPGqmtTNJwEwTbEm7KEFUo/mQt46j2KWbG8UFSA2NtSUHejKo3KijtVHaSf3HPAMu2T3dAjP8lZOQaaWj3THrbs1KlV5EwD1LiqNZLG4b22QtacLw/ZSf6irxhDsxqWJ+XTiRVsiC1HLmgdxyodEzQZ5T64iDTtiwP5UZr+ff69vWSFY0vkBGjxt1PDgzokfOcDJGIQ69oCbY4efNeHShVIfgwmkJD/+jPHBDe2vaKzMjGc84E9tkyDTWsHmBb8u0YlAVnEx7fmdcHKoejkroiYXrzzBpLtuVOw/MXFEJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//flNTphmvxX8Buap8nrcJ72z1d+t7DkZLWMjC1F9Ls=;
 b=IwnkyJfwHDDnaDMO5iynQdSy+Tke7ZmwqmV6UdeJeDSPf2kY3extCuvLY3ceZhO0snDD17wWrFWgi0dn1VeiP4iIcbwsmz9NuzRpsed89WLHBUHTbCuWeoadhnrfMu2AReJH3+WqZVc4fxo9pw1g6m+NadWMnwuO6/PUWOAC90jt8LepI4xz0rRiOuPNbpy4/3ejEX/JedgWcbaTEDGmAPQCWcjKm5HrPPPLg9ev5BrZoMd3ko+Lq6qqb7jF/lMPoQszGvlpdl5k2U0+Yiu6MZwdvsIdtZOKvcr4krDwoc3IhOixwyf4ecNTly50G320x0r4wtyUnLfLSwo84TVuxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//flNTphmvxX8Buap8nrcJ72z1d+t7DkZLWMjC1F9Ls=;
 b=Zqg1NjyU/9M1pkXioD8rHlxioJXgqvo/Az1vwqrkH9lEWtsm8nmY96c2Nd/G5mPNySY4+Ru7I+maCR/4rEaoEv0PNql8gVe0juQOW6qI68VVZozBWbRX9APoCMXydPjNVtgbR+pQqtX3O6KqgrrfqPlegbU6N4TmMM4wQxwtyEWTrIx6l8JiFGulp2NsAtrrrPerjyBuiz6lmFoG4UaGJpqAwPfTCdnKFNDago8ZHbVCDdPi6mN9GaOqZXl1bHSWrFGWFqM/9vcxz9hDvUIzi1islRMPEJPeoU4vtRU1Asd5IkvCXMN2VDvfJI1bl3DkqP4PP61PygakvgZSvaDUWQ==
Received: from BN9PR03CA0888.namprd03.prod.outlook.com (2603:10b6:408:13c::23)
 by PH0PR12MB7488.namprd12.prod.outlook.com (2603:10b6:510:1e9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 16:54:44 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:13c:cafe::f4) by BN9PR03CA0888.outlook.office365.com
 (2603:10b6:408:13c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Wed,
 5 Nov 2025 16:54:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 16:54:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 08:54:21 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 08:54:19 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: [PATCH v2 5/5] net/mlx5: support count and age on root group
Date: Wed, 5 Nov 2025 17:52:58 +0100
Message-ID: <20251105165258.1396352-6-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251105165258.1396352-1-dsosnowski@nvidia.com>
References: <20251104174612.1341962-1-dsosnowski@nvidia.com>
 <20251105165258.1396352-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|PH0PR12MB7488:EE_
X-MS-Office365-Filtering-Correlation-Id: 348eb502-9018-42d2-d608-08de1c8c0523
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4Q0au3op1+wStHtVn50FER61ZpbTgGVJqb2KT1PTRG+IFe9FhEnxPLnnqOpB?=
 =?us-ascii?Q?5zxqa6ic8nMwR0NJEvWqL8HDqCudE0Uc2fxgu6efL14Z9Hn0/Y5fxN6h/53/?=
 =?us-ascii?Q?2cBAG4Yl7O/w9q9fSC4kM1/jK30iJdQVdh+NzNH+2tYSmVpEprTZPO+mVYpv?=
 =?us-ascii?Q?egMQioB9GUKlTADELaGu96fIUCrERmRcA0KJye0/nqA5StL64s5X29Oal4Lw?=
 =?us-ascii?Q?T4KQyV1rwzK2p8VJ6Eu8NpUL1rTnJpwqDQLh8+oM6LP9pJJ0xD+U26l4tRsY?=
 =?us-ascii?Q?nxnvkUcFH5970OGYEz+h+YJOH+Qp3sQcWhqrpMpP1Gk6WcdOGwtF2CKC90ED?=
 =?us-ascii?Q?lks1PlG5L14ReWMVv41hiz2PFqk4FiowbJQ/felVw2CQdrRbmop/pVtVBXZR?=
 =?us-ascii?Q?TSrIUSgviW0sh5/+6kwny8w+occ/1m/dsaVQAce8TPPC9xpi3M/Y9csyAuJN?=
 =?us-ascii?Q?k30iLuV83531KmCHvTTGxxSbL606rLlDdj/AkySjbrOMn+ty/AO0xWLDRywl?=
 =?us-ascii?Q?gRAl8p6y1C36IsH1qCez8ofjb89zVLF6LwSc48ccCkCiRzavY0FLTTKaftX7?=
 =?us-ascii?Q?zX561HB90f59GfWr6Go1QfVPC4a/w68GMIDgnIT+kpCk1c8yvKcLO9FuXXWo?=
 =?us-ascii?Q?Q3xB0EGd5vC9KNJvZVo2JjfEYA3Ykh5LpyZTSf+GWxWr+CPeTKkBZTcGsEPq?=
 =?us-ascii?Q?GL/6HoWLBmhdA2m2qXpN6sHVnjavISqFYvg0T/oQg7a7Aq8RpWjSDUIrJsZc?=
 =?us-ascii?Q?JqoPDLnPJLbzdQ4xv4yn7+jIXSmTxjgBrt7zGCecOkFb235ffVMmTPt69lEx?=
 =?us-ascii?Q?VItog6e4FSR7Heyq8DEHNL7Fm4XQ2OrO4YlHm3oxLOid5NrZWTnkfxpVAJ4/?=
 =?us-ascii?Q?SVSdksn+50lZtrRf7lbEvKm7w0HkHugBOMuC9D5NjBULtJgK/7eYF1WPCMRL?=
 =?us-ascii?Q?s08MCrCK7pDWiJJHOwMACMYXoOx97JiopiYtAgX/v+d7DuP+B93DUHJ+zSkK?=
 =?us-ascii?Q?fm1ls3b8rFdyk1NeebB+clZxSbbnRKJyuz+wtYLSyX6JiUm/va5orXMJN8HR?=
 =?us-ascii?Q?jauFOtnhvtOqJ3UrB5ovGo+9+6NDaCGW4tHBtu1KFBFi90/t5NojYiFdpEu+?=
 =?us-ascii?Q?5lS0xOi0A4UMYHv1wMay4VG5/OssFi6pbbWisKe/s5PPOgMvCb6mZHHQnXCE?=
 =?us-ascii?Q?tBMKKd+VF5mrX60dBvDaUrLqeHB/mrIqD0axbw0F77HLeKw/Z3laJDZJRkFk?=
 =?us-ascii?Q?6gonJresXzTxXlmUfHvDuSWnVEbssUZLRMfbEEfi4a+bYqZimn+DSSe9amRY?=
 =?us-ascii?Q?3m3q/2j+CGNg6rEnpi7OymUpUoa9LId7sl3xdQs/M86IiLCcumWTHJFfLATB?=
 =?us-ascii?Q?fVnHrCcS8/WoP/uHvSdCPhQolu/8hzNGeS9+jR9WEyq87H64fG/SqBmxuXRs?=
 =?us-ascii?Q?2nOxLlC7+1q2bmc0LieTUCs71qHV5q9yYzyzNi5FE8XIS7vBURilBft3isCC?=
 =?us-ascii?Q?ZIvDX/Ym4G6pFoFog5euo/uU0KZ8rn8WoYMJ3tn3wLIqdYLiv+As98Ivx00j?=
 =?us-ascii?Q?U39f3nj5ZiYUujGPZ9Q=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 16:54:43.8428 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 348eb502-9018-42d2-d608-08de1c8c0523
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7488
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
 doc/guides/nics/mlx5.rst               | 34 ++++++++++------
 doc/guides/rel_notes/release_25_11.rst |  4 ++
 drivers/net/mlx5/mlx5_flow_hw.c        | 55 ++++++++++++++++----------
 drivers/net/mlx5/mlx5_hws_cnt.c        | 42 +++++++++++++++-----
 drivers/net/mlx5/mlx5_hws_cnt.h        | 16 ++++++--
 5 files changed, 108 insertions(+), 43 deletions(-)

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
index bab081e775..da4e6efa39 100644
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
@@ -2461,6 +2462,18 @@ mlx5_create_ipv6_ext_reformat(struct rte_eth_dev *dev,
 	return -EINVAL;
 }
 
+static bool
+is_indirect_action_type_supported_root(const enum rte_flow_action_type type)
+{
+	switch (type) {
+	case RTE_FLOW_ACTION_TYPE_COUNT:
+	case RTE_FLOW_ACTION_TYPE_AGE:
+		return mlx5dr_action_counter_root_is_supported();
+	default:
+		return false;
+	}
+}
+
 /**
  * Translate rte_flow actions to DR action.
  *
@@ -2545,8 +2558,9 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 				goto err;
 			break;
 		case RTE_FLOW_ACTION_TYPE_INDIRECT:
-			if (is_root) {
-				DRV_LOG(ERR, "Indirect action is not supported in root table.");
+			if (is_root && !is_indirect_action_type_supported_root(masks->type)) {
+				DRV_LOG(ERR, "Indirect action type (%d) is not supported on root.",
+					masks->type);
 				goto err;
 			}
 			if (actions->conf && masks->conf) {
@@ -2785,12 +2799,10 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 				goto err;
 			break;
 		case RTE_FLOW_ACTION_TYPE_AGE:
-			if (is_root) {
-				__flow_hw_action_template_destroy(dev, acts);
+			if (is_root && !mlx5dr_action_counter_root_is_supported()) {
 				rte_flow_error_set(&sub_error, ENOTSUP,
-					RTE_FLOW_ERROR_TYPE_ACTION,
-					NULL,
-					"Age action on root table is not supported in HW steering mode");
+					RTE_FLOW_ERROR_TYPE_ACTION, NULL,
+					"Age action is not supported on group 0");
 				goto err;
 			}
 			if (__flow_hw_act_data_general_append(priv, acts,
@@ -2800,12 +2812,10 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 				goto err;
 			break;
 		case RTE_FLOW_ACTION_TYPE_COUNT:
-			if (is_root) {
-				__flow_hw_action_template_destroy(dev, acts);
+			if (is_root && !mlx5dr_action_counter_root_is_supported()) {
 				rte_flow_error_set(&sub_error, ENOTSUP,
-					RTE_FLOW_ERROR_TYPE_ACTION,
-					NULL,
-					"Counter action on root table is not supported in HW steering mode");
+					RTE_FLOW_ERROR_TYPE_ACTION, NULL,
+					"Count action is not supported on root table");
 				goto err;
 			}
 			if ((at->action_flags & MLX5_FLOW_ACTION_AGE) ||
@@ -2819,7 +2829,7 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 			if (masks->conf &&
 			    ((const struct rte_flow_action_count *)
 			     masks->conf)->id) {
-				err = flow_hw_cnt_compile(dev, dr_pos, acts);
+				err = flow_hw_cnt_compile(dev, dr_pos, acts, is_root);
 				if (err)
 					goto err;
 			} else if (__flow_hw_act_data_general_append
@@ -3161,7 +3171,7 @@ flow_hw_construct_quota(struct mlx5_priv *priv,
 static __rte_always_inline int
 flow_hw_shared_action_construct(struct rte_eth_dev *dev, uint32_t queue,
 				const struct rte_flow_action *action,
-				struct rte_flow_template_table *table __rte_unused,
+				struct rte_flow_template_table *table,
 				const uint64_t item_flags, uint64_t action_flags,
 				struct rte_flow_hw *flow,
 				struct mlx5dr_rule_action *rule_act)
@@ -3180,6 +3190,7 @@ flow_hw_shared_action_construct(struct rte_eth_dev *dev, uint32_t queue,
 		       ((1u << MLX5_INDIRECT_ACTION_TYPE_OFFSET) - 1);
 	uint32_t *cnt_queue;
 	cnt_id_t age_cnt;
+	bool is_root = mlx5_group_id_is_root(table->grp->group_id);
 
 	memset(&act_data, 0, sizeof(act_data));
 	switch (type) {
@@ -3205,7 +3216,8 @@ flow_hw_shared_action_construct(struct rte_eth_dev *dev, uint32_t queue,
 		if (mlx5_hws_cnt_pool_get_action_offset(priv->hws_cpool,
 				act_idx,
 				&rule_act->action,
-				&rule_act->counter.offset))
+				&rule_act->counter.offset,
+				is_root))
 			return -1;
 		flow->flags |= MLX5_FLOW_HW_FLOW_FLAG_CNT_ID;
 		flow->cnt_id = act_idx;
@@ -3246,7 +3258,7 @@ flow_hw_shared_action_construct(struct rte_eth_dev *dev, uint32_t queue,
 		}
 		if (mlx5_hws_cnt_pool_get_action_offset(priv->hws_cpool,
 						     age_cnt, &rule_act->action,
-						     &rule_act->counter.offset))
+						     &rule_act->counter.offset, is_root))
 			return -1;
 		break;
 	case MLX5_INDIRECT_ACTION_TYPE_CT:
@@ -3480,6 +3492,7 @@ flow_hw_actions_construct(struct rte_eth_dev *dev,
 	struct mlx5_aso_mtr *aso_mtr;
 	struct mlx5_multi_pattern_segment *mp_segment = NULL;
 	struct rte_flow_hw_aux *aux;
+	bool is_root = mlx5_group_id_is_root(table->grp->group_id);
 
 	attr.group = table->grp->group_id;
 	ft_flag = mlx5_hw_act_flag[!!table->grp->group_id][table->type];
@@ -3677,7 +3690,8 @@ flow_hw_actions_construct(struct rte_eth_dev *dev,
 				(priv->hws_cpool,
 				 cnt_id,
 				 &rule_acts[act_data->action_dst].action,
-				 &rule_acts[act_data->action_dst].counter.offset
+				 &rule_acts[act_data->action_dst].counter.offset,
+				 is_root
 				 );
 			if (ret != 0)
 				goto error;
@@ -3689,7 +3703,8 @@ flow_hw_actions_construct(struct rte_eth_dev *dev,
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
index fb01fce4e5..1b6acb7a3b 100644
--- a/drivers/net/mlx5/mlx5_hws_cnt.c
+++ b/drivers/net/mlx5/mlx5_hws_cnt.c
@@ -439,6 +439,9 @@ mlx5_hws_cnt_pool_init(struct mlx5_dev_ctx_shared *sh,
 	}
 
 	cntp->cfg = *pcfg;
+	DRV_LOG(DEBUG, "ibdev %s counter and age action %s supported on group 0",
+		sh->ibdev_name,
+		mlx5dr_action_counter_root_is_supported() ? "is" : "is not");
 	if (cntp->cfg.host_cpool)
 		return cntp;
 	if (pcfg->request_num > sh->hws_max_nb_counters) {
@@ -659,9 +662,13 @@ mlx5_hws_cnt_pool_action_destroy(struct mlx5_hws_cnt_pool *cpool)
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
@@ -673,11 +680,14 @@ mlx5_hws_cnt_pool_action_create(struct mlx5_priv *priv,
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
@@ -687,10 +697,24 @@ mlx5_hws_cnt_pool_action_create(struct mlx5_priv *priv,
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
+		if (!mlx5dr_action_counter_root_is_supported()) {
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
index 8d7a9d34df..63a14f4f7a 100644
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
@@ -632,12 +633,21 @@ mlx5_hws_cnt_pool_get_size(struct mlx5_hws_cnt_pool *cpool)
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

