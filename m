Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD18CCF9E9
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 09:56:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0AE6940653;
	Wed, 29 Oct 2025 10:56:45 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012059.outbound.protection.outlook.com [40.107.209.59])
 by mails.dpdk.org (Postfix) with ESMTP id 01C3940616;
 Wed, 29 Oct 2025 10:56:43 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r+cc6Sw8LRPwkjewKDZsA2E+Z78L4MswQcoE5FXcFFQ2HH/AX6z7QDZVkKzCtQJdZz+BtCp8o9N7hJkrIqKLXerMWgpQ/dGZ8eNjowjSKlDMGCV/GW3NIiqUA0OkgDpwYVJd84zxG8rhY9sEuwbdI6Td+42kSBqZRd5G2OsKCUgHGcWB06thcAlnLh+DtcWkycUvoxPYoVFUPWBWgmZrfGnpQp0AgPI50F4xtUA8/H4zo/5ewmoM1s2IUqwkH88C4CQziEttmMcg38KB2sKvY3cmTG1r5DZShE8bvGSkNjUAUgto5VMMvNSh8hKMCrN+lwFVKOjZHiVMmDJSOz+2Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPImwncvyBRpQl5rghsUknckLCcX7Z0+ccS6L3ReWuM=;
 b=K7lu+6yeM3Iw58fs7xouzZ8vQDH9D3pREF7gYnEm46KCurPUQ4XAVg+W2dPxnpQ92qM5vSHb5ykEO/J5nBL2oYGUaDi9vN3zenNPxONzvNck3T8HjlMEUHrXV8bKkZVS+dvcO85IylV/BH4JTeUuEWjE+kbO1IDaAXPWdUX3/SSEtqKqBafcr/EM4K70KiUxHBgnI+60T8dRCOrOiK9EoeJ/Jltb6Y2TQ8GcDSt66Rsb4RnPAxknIjVppsZtPMh/H0Zk9TxpUGfeEieHP2Oq4DT7mMOmS8j+ZBgA3MBzOEtKsopVl4FTRNdSMmN37aTcfH+DtXLnG8yJIa0AF8y+cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPImwncvyBRpQl5rghsUknckLCcX7Z0+ccS6L3ReWuM=;
 b=hbBAOzP1nKsDI3781a1awQEpVmZkeD3n7MPbLki59zmZKoGnH93l/f6UoAHStrM598i1LTGoa5p/ePDAR6pRIViaWILPY0+M8A3ExlFHI2IDYpjanV/znVukY9ElT6uHwf9Bmbpr9gjrsBelKFbyptBgTnEXYC00xAytgcldaDpl5g7D0/XdaCpw465bUptCz3w8csE74VaR70jgama1E/KY/alG6bxrH8KcN6Q10Jn/J3r0kkRNurlRFFqi8EgsibX5cI9sfuma86bGueaF4LYcvc26XBQ6p6C/YSbJE6MysPnMPkySOYhKn7UNeOAB/i74ufQE05LV21xA3pwY+A==
Received: from CH0PR03CA0271.namprd03.prod.outlook.com (2603:10b6:610:e6::6)
 by BN7PPF0FD1DEA27.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6c8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 09:56:41 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:e6:cafe::fb) by CH0PR03CA0271.outlook.office365.com
 (2603:10b6:610:e6::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 09:56:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Wed, 29 Oct 2025 09:56:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 29 Oct
 2025 02:56:29 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Oct
 2025 02:56:24 -0700
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, <mkashani@nvidia.com>, <rasland@nvidia.com>,
 <stable@dpdk.org>, Dariusz Sosnowski <dsosnowski@nvidia.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Rongwei Liu <rongweil@nvidia.com>, Michael Baum
 <michaelba@nvidia.com>, Li Zhang <lizh@nvidia.com>
Subject: [PATCH 2/2] net/mlx5: fix unnecessary comma compilation warnings
Date: Wed, 29 Oct 2025 11:55:04 +0200
Message-ID: <20251029095505.100582-2-getelson@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029095505.100582-1-getelson@nvidia.com>
References: <20251029095505.100582-1-getelson@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|BN7PPF0FD1DEA27:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ac76b64-c493-4d08-68b5-08de16d175c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WKBp5SxB1qtlhlod8s9DDWubB8oT1X+FsC1n1+MBsUxBqPKCgfq7HK1rj8L4?=
 =?us-ascii?Q?r0nLFUnu18Oeu1TN+3IfWO8B4lWIanl5riyayN56sMMysVkGm3Ns2ZAkaAKU?=
 =?us-ascii?Q?Xe8FWtxviGbJr+QGTVJwo1bQtsoRGaqQTdXTt3pf4JdienE1922bqIfc5GPs?=
 =?us-ascii?Q?Tt6ouEwY1RxswTu44X5p6ny2G69m+Wzng8PItWIIPWmjj5w6+VQPu7lB9mRG?=
 =?us-ascii?Q?53aNBPU29r00UIUMLYpx8Zu/TckR0yDkaGBDt2SoewqeMY6pIxUVOtwcYhqU?=
 =?us-ascii?Q?camZNV4psVv2OgaltCkm8MWZUi1rwdrFYoznwAvIoRG9G2LF0XchGjFo/HYz?=
 =?us-ascii?Q?LrZUpd2ceLPhJWxdtvopkCfsOiGmkKsk+v1QlfJENh0XWqy0gahcu9WWG/fv?=
 =?us-ascii?Q?KSAmndiEvYmUXjcEGj7EFzLIpG73QWs2FKzEPHU68b9ZJdMU6GYJosDFVju4?=
 =?us-ascii?Q?AG8ONUVP5Nzd934mp190TyIsDJcFnStXYOzwA/KQz5qUi1A4ilzaxm76h2/J?=
 =?us-ascii?Q?ViSrF1SdgDaUTmfPVMi/r566gEEAzzsnm/NgDACbAneiDllfWmRENR141498?=
 =?us-ascii?Q?T2hgQwA7uwy7eqSg4+WrKRfwpexkr628AU2b7bfcXQ64E09bd2snHXpJd3Ce?=
 =?us-ascii?Q?JEer09vIE0vuGmJPdoPfcEodeW258OKJhLNY8bTImpc3vXd5DU2klv2OfE9h?=
 =?us-ascii?Q?GpKDrPqdFRwZmlaARKhbQR1Ai6fKeMYaWLc1pQ3hgxpzjKlezwoXBupUeTSC?=
 =?us-ascii?Q?6krp7YmdUf58tWyLrkBnFsgEPvtST4cYyn8PqVEgPT9vktXfFgzMZIEKH9hh?=
 =?us-ascii?Q?IDtd/I+tW4KRWBBapc+9r5VZj9sfOYMFGg/sWCJoZtIjZ7B7JqRmcpOhJmVp?=
 =?us-ascii?Q?2C69l+cEfF0nifQuRRh2yNQnXM8O6k01v7k4vCr2vLTUwyxl9Zoi1G2f8IAU?=
 =?us-ascii?Q?VHTjNDd8bmsjFGjMFCfStajBaHxeBDAiFIfMuRul0mBAT2hlbRqrRtuj4sGW?=
 =?us-ascii?Q?GCFLDLB4tUSczKgjDARSnU85c8+SMWdU+BrQRaFc/qtCIck0ynk5MLMBQR/7?=
 =?us-ascii?Q?sVHlfqohRtOorj3EsDyyk2sdJFyTMFsblpjRyyzr19fg0cmvViKSV6Cw4srX?=
 =?us-ascii?Q?mU811gMHXje7Jff+aEVN/LzgHW/CERUxtfI/ocWZ8rIvOefHOjS6GcHMLKzd?=
 =?us-ascii?Q?QCYWOWbstzn2nfFoMH2ujeGdjuWQamsGbfvEEfy9LDrxyTP57JJ90bxKYt0c?=
 =?us-ascii?Q?fDbSqyykozulY70G2CGFckv9HZ3vhHS8lHlcm/1CQLm3CeK9elxBFPovtuTg?=
 =?us-ascii?Q?B15EVkgCynZYFD5rVJDWvYDSbls8VhqxKqSsNSOzqPwdf7qadODGkb+2bzq/?=
 =?us-ascii?Q?dI6aKG8+Y/4w+g5qtKAS0pYPHjh5q4VAgbBIFPL/8ON2GV+xXXnF2D5+AJZi?=
 =?us-ascii?Q?GYjvQ9fP+Os/wzHMW7M2fDo61ZytJYca8qUjNmr8uGRxFM4SMRKnNsY7ltg1?=
 =?us-ascii?Q?HBZ9XNtqIRu4D5e8lMCJHpnepqecST1xzqMke+kt8cwqL+SxmiaDxTvHKlD8?=
 =?us-ascii?Q?aD7d+2urUbeeMyPvmo4=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 09:56:41.1706 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac76b64-c493-4d08-68b5-08de16d175c7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF0FD1DEA27
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

The patch fixes compilation warnings produced by clang -Wcomma option.

Bugzilla ID: 1810
Fixes: 630a587bfb37 ("net/mlx5: support matching on VXLAN reserved field")
Fixes: 86d259cec852 ("net/mlx5: separate Tx queue object creations")
Fixes: bc1d90a3cf6f ("net/mlx5: fix build with Direct Verbs disabled")
Fixes: 444320186393 ("net/mlx5: support meter creation with policy")
Fixes: 821a6a5cc495 ("net/mlx5: add metadata split for compatibility")
Cc: stable@dpdk.org

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
---
 drivers/net/mlx5/linux/mlx5_os.c    |  4 ++--
 drivers/net/mlx5/linux/mlx5_verbs.c |  2 +-
 drivers/net/mlx5/mlx5_flow.c        | 12 ++++++------
 drivers/net/mlx5/mlx5_flow_dv.c     |  2 +-
 drivers/net/mlx5/mlx5_nta_split.c   |  4 ++--
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index 8d11b1ac3a..c742e0f282 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -431,8 +431,8 @@ __mlx5_discovery_misc5_cap(struct mlx5_priv *priv)
 		DRV_LOG(INFO, "No SW steering support");
 		return;
 	}
-	dv_attr.type = IBV_FLOW_ATTR_NORMAL,
-	dv_attr.match_mask = (void *)&matcher_mask,
+	dv_attr.type = IBV_FLOW_ATTR_NORMAL;
+	dv_attr.match_mask = (void *)&matcher_mask;
 	dv_attr.match_criteria_enable =
 			(1 << MLX5_MATCH_CRITERIA_ENABLE_OUTER_BIT) |
 			(1 << MLX5_MATCH_CRITERIA_ENABLE_MISC5_BIT);
diff --git a/drivers/net/mlx5/linux/mlx5_verbs.c b/drivers/net/mlx5/linux/mlx5_verbs.c
index 9011319a3e..01d3d6ae5d 100644
--- a/drivers/net/mlx5/linux/mlx5_verbs.c
+++ b/drivers/net/mlx5/linux/mlx5_verbs.c
@@ -883,7 +883,7 @@ mlx5_txq_ibv_qp_create(struct rte_eth_dev *dev, uint16_t idx)
 	 * dev_cap.max_sge limit and will still work properly.
 	 */
 	qp_attr.cap.max_send_sge = 1;
-	qp_attr.qp_type = IBV_QPT_RAW_PACKET,
+	qp_attr.qp_type = IBV_QPT_RAW_PACKET;
 	/* Do *NOT* enable this, completions events are managed per Tx burst. */
 	qp_attr.sq_sig_all = 0;
 	qp_attr.pd = priv->sh->cdev->pd;
diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
index 1de398982a..f354008a60 100644
--- a/drivers/net/mlx5/mlx5_flow.c
+++ b/drivers/net/mlx5/mlx5_flow.c
@@ -11132,12 +11132,12 @@ flow_tunnel_add_default_miss(struct rte_eth_dev *dev,
 				(error, ENOMEM,
 				RTE_FLOW_ERROR_TYPE_ACTION_CONF,
 				NULL, "invalid default miss RSS");
-		ctx->action_rss.func = RTE_ETH_HASH_FUNCTION_DEFAULT,
-		ctx->action_rss.level = 0,
-		ctx->action_rss.types = priv->rss_conf.rss_hf,
-		ctx->action_rss.key_len = priv->rss_conf.rss_key_len,
-		ctx->action_rss.queue_num = priv->reta_idx_n,
-		ctx->action_rss.key = priv->rss_conf.rss_key,
+		ctx->action_rss.func = RTE_ETH_HASH_FUNCTION_DEFAULT;
+		ctx->action_rss.level = 0;
+		ctx->action_rss.types = priv->rss_conf.rss_hf;
+		ctx->action_rss.key_len = priv->rss_conf.rss_key_len;
+		ctx->action_rss.queue_num = priv->reta_idx_n;
+		ctx->action_rss.key = priv->rss_conf.rss_key;
 		ctx->action_rss.queue = ctx->queue;
 		if (!priv->reta_idx_n || !priv->rxqs_n)
 			return rte_flow_error_set
diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
index bcce1597e2..1564bd7cbe 100644
--- a/drivers/net/mlx5/mlx5_flow_dv.c
+++ b/drivers/net/mlx5/mlx5_flow_dv.c
@@ -18903,7 +18903,7 @@ flow_dv_create_mtr_tbls(struct rte_eth_dev *dev,
 			}
 		}
 		/* Create default matcher in drop table. */
-		matcher.tbl = mtrmng->drop_tbl[domain],
+		matcher.tbl = mtrmng->drop_tbl[domain];
 		tbl_data = container_of(mtrmng->drop_tbl[domain],
 				struct mlx5_flow_tbl_data_entry, tbl);
 		if (!mtrmng->def_matcher[domain]) {
diff --git a/drivers/net/mlx5/mlx5_nta_split.c b/drivers/net/mlx5/mlx5_nta_split.c
index 6a85ab7fd1..c95da56d72 100644
--- a/drivers/net/mlx5/mlx5_nta_split.c
+++ b/drivers/net/mlx5/mlx5_nta_split.c
@@ -345,8 +345,8 @@ flow_nta_mreg_create_cb(void *tool_ctx, void *cb_ctx)
 	/* (match REG 'tag') or all. */
 	items[1].type = RTE_FLOW_ITEM_TYPE_END;
 	/* (Mark) or void + copy to Rx meta + jump to the MREG_ACT_TABLE_GROUP. */
-	actions[1].type = RTE_FLOW_ACTION_TYPE_MODIFY_FIELD,
-	actions[1].conf = &rx_meta,
+	actions[1].type = RTE_FLOW_ACTION_TYPE_MODIFY_FIELD;
+	actions[1].conf = &rx_meta;
 	actions[2].type = RTE_FLOW_ACTION_TYPE_JUMP;
 	actions[2].conf = &jump;
 	actions[3].type = RTE_FLOW_ACTION_TYPE_END;
-- 
2.51.0

