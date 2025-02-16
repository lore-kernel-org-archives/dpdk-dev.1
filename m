Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A265C021A4
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Feb 2025 11:05:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79A6C40E2B;
	Sun, 16 Feb 2025 12:05:34 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by mails.dpdk.org (Postfix) with ESMTP id 0758340E22
 for <dev@dpdk.org>; Sun, 16 Feb 2025 12:05:32 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=etkgzgNY6qi5iX7ZnD6e+siNo7Ff7YSkIg7mFIjjCdlO0iR0Dtg4adv8IZSZrJYTMujMv97UnqxsX8Mur9WslvrTvefGx8M5mG89FMbYgGg6OgyRoxeSkYYEY57aFgXFzyGofhrPDq/M8UpkP7EIPMBSVXIIITI8R6iw7brw65RVzbZhTQvkGMlFsfDi1uCTK0cxtli3PQjgeaZO8rbfq8CC+DXn6qO7jm2GMsGW6tEyAByyXAiF2EKfyNJIE//3ly7133xMOosi6JdoxxbgaEfEk2v0oZKqz5cs+1qvsYxT5NJvDVSefKV26a28ywTA4NBedmfymNWs4aHtT6StyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0rj4iuLBKAEbEGZw+BFPLmejb3wmtgs8G05Rh6BUeU=;
 b=RIonYBdqcr+3d6SGYmcxDRIo12sgZ6NoKfbgcrTvLOmuj0zYKtH2/++Icb53zM9aJwiJ4hSlO1nSU0ftZjEOzhN+zj2zaNIbNz+sAmDXeru+TGEjp/tuwSW81GcvAYyp94wxb0Sq0lz9pODxGNek95E4z3s1suLOsNDePi2+Z87598NhRXbEy9+uwjtHEKT7InEfVcqW2iTvELWpY9aMAEAw5ImLRMZksh9D/Pcu5cFcl+6DlPUvyZGF33kLBP/Oc7nVEZD2mdGbeZIlhiP6As4s+A68tWwLrA9zlqelE3TqD33cyKTY4thcsBxHTFPZW3JsWTUcMGY0WQKYAkCdPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0rj4iuLBKAEbEGZw+BFPLmejb3wmtgs8G05Rh6BUeU=;
 b=n9b7m6ow6rwbUF83qgrAqOcCzzmV+p84T3JacjbuzD7Mvj37u2AZ7h/s5f5I1LouBJm7RqFV5D0yqXyt+YjPKhsFASzyCqqmqBQa4tc4T33t2jecT8mKOsypo7XaJnweTQDNFUBOt5gSxUSP57EIiI4q/skIer4xDCBfMfr0jWqEyyNqqFz7O+i5oUo7qqVoql6aN8fGsrE4+JVGRX+W/7uQ4aDzxIcyHnKA2VReDkJBg7+ZBpM4Os6ErZMkrwBN4PXjJybovDG54ES6SMU7aZ4Qn3+ZMiqh8mETw0YW6TGqn9QzXnsEXPNGiuX/xCmgN3ADt2NrAp7cAu2GdCNRfQ==
Received: from BY5PR13CA0003.namprd13.prod.outlook.com (2603:10b6:a03:180::16)
 by CH3PR12MB8210.namprd12.prod.outlook.com (2603:10b6:610:129::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Sun, 16 Feb
 2025 11:05:28 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::21) by BY5PR13CA0003.outlook.office365.com
 (2603:10b6:a03:180::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.10 via Frontend Transport; Sun,
 16 Feb 2025 11:05:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Sun, 16 Feb 2025 11:05:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 16 Feb
 2025 03:05:11 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 16 Feb
 2025 03:05:08 -0800
From: Hamdan Igbaria <hamdani@nvidia.com>
To: <hamdani@nvidia.com>, <viacheslavo@nvidia.com>, <thomas@monjalon.net>,
 <suanmingm@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
CC: <dev@dpdk.org>, Erez Shitrit <erezsh@nvidia.com>
Subject: [PATCH 7/8] net/mlx5/hws: unified rule changes
Date: Sun, 16 Feb 2025 13:04:13 +0200
Message-ID: <20250216110414.10926-7-hamdani@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20250216110414.10926-1-hamdani@nvidia.com>
References: <20250216110414.10926-1-hamdani@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|CH3PR12MB8210:EE_
X-MS-Office365-Filtering-Correlation-Id: 54e72d83-32cc-4203-5333-08dd4e79d23a
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wm/S+xEp1sMLkfSsOc5ViCTg3guPcWeg6eD4NmBATSh43VCQJApYm6nKY12P?=
 =?us-ascii?Q?to0K2lm+U33N8U+PRYaIzrUrogNQREMJZPk9DYSv/3uzARPbmLyfcDCpOLFV?=
 =?us-ascii?Q?qPvRBxrpxA0USxR9mrLRP5foqnnq5N8ZdTA2cQPzts+GBFOLxzJISQ3ZmSYJ?=
 =?us-ascii?Q?HRMPt1P+Ie9bae67fTGgDZxjbhUcxlctOn0WE/z6KNrKFRmAlNtG0IUUumrH?=
 =?us-ascii?Q?1swutJGEbEKa3L6WQ0QMPvYVllJff+PyhnmTE5JcUn/Yx7yKlXZpGYRTXxP0?=
 =?us-ascii?Q?n/fegiqYARsNEg8dPhV+u6IsCr8eJOx7//V4qfUHeA5kAPzM8KMD5vHY8cqn?=
 =?us-ascii?Q?M25RFwqFcbTwMNYXD/GrMzxbYZDhx4fX52bJkL2xGA7QCTA8xfHp0dSLzxFw?=
 =?us-ascii?Q?2GFyaCfJH8zEERL2x3v8jYUkhO/HeJgeyWq1g37Jwwb9WBRY8IeL1Z6IOWsl?=
 =?us-ascii?Q?07y5mUlkptnpsnByFaGVuqHOJ4hX9b+Ca77OMveytPx1e4/TtdyY8gfAi2z/?=
 =?us-ascii?Q?p3KFng0+kOeHfGzjuNPn3HsFFEdjjtlya34qF8cVMkEnqDC2vhbni47pWPF2?=
 =?us-ascii?Q?d8l5OxXjD2mLzxJe9cPJWGjl1fq017si10n0yqCXJYD2ZiI7fWqHk+EZxTn5?=
 =?us-ascii?Q?E8Ccxns4FD6qpvZWqPtPtGqSxJuddEM1Lgcx2TUeqwUKVlBe5wXJR5+K+Nah?=
 =?us-ascii?Q?fiIjHKj7YObm6O4sjxCOjzzTxvr00v9ijS8pH8ZeRrNEBABk35GAey+mqaWi?=
 =?us-ascii?Q?NIWJG7Fh2MMlGGJYHJzMtOurx5ejupX7THAHc0SkHQFG6iEQ2VquEqgP2Ejr?=
 =?us-ascii?Q?qlFXMO4EOewKz3cPP3sAJUZS+eIxOVEcSfh49aHvD8h88MoR6fodewvgK1D/?=
 =?us-ascii?Q?5NQC3w90qzqbKYBWkGMRxM8EcxXiYqoFzJpOmliOmTWFkgMvu3IyNShN4z/l?=
 =?us-ascii?Q?EfPqMg+D3R8pRsx+y6bO88wzy131j6LkhdDxXqOHvYbJvkO2WipvVVFQrCOp?=
 =?us-ascii?Q?rXiml8EQTBpkBCaF+/or9krseDBlXpn67+s/BzMHQR9YfTu8UwlRmaGuhq7g?=
 =?us-ascii?Q?EGWJktT8R1G+C1PvlexIEss8JtMHHQVxnpI597Yz3K8AkZOXNKHvyl6AN09V?=
 =?us-ascii?Q?okg6bdLeN+a/TjMlzGi04hyp91f3jV5gUmPhSXvWfJsoabFkMvwKY97e6SII?=
 =?us-ascii?Q?vPQUTXrRBpvinAR8lwhiPSdJHGvDYrRocsEaNe9OxexavTqCme8SvT9nWpDD?=
 =?us-ascii?Q?pFYtC8dywafTVkPPx+xszjm59Vh1dxJtp9Hahvmq1wisZCE2cvThdQXHhK2+?=
 =?us-ascii?Q?58emTjoEEXZIFLfj/26z8AiqW9Jizv1YDapHoAxjalOhVWH57hT3BYcqFCy5?=
 =?us-ascii?Q?lswvvgSGNz2g+hK89IST9Jqma9ywmPWOMG1RxbNtKuq4obS38KpkeVZlLR0f?=
 =?us-ascii?Q?ZKiusKVvoqBWw1J75/E0Bd4OMe2cQqnHz7XiYIBFWJEgnZPBiXVuhk9jkIS8?=
 =?us-ascii?Q?SIGbB64DyEm4OZw=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2025 11:05:28.0275 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e72d83-32cc-4203-5333-08dd4e79d23a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8210
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

From: Erez Shitrit <erezsh@nvidia.com>

Rule is set according to its specific domain.

Signed-off-by: Erez Shitrit <erezsh@nvidia.com>
Signed-off-by: Hamdan Igbaria <hamdani@nvidia.com>
Acked-by: Matan Azrad <matan@nvidia.com>
---
 drivers/net/mlx5/hws/mlx5dr_rule.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/mlx5/hws/mlx5dr_rule.c b/drivers/net/mlx5/hws/mlx5dr_rule.c
index 519328ccf3..878224d8b3 100644
--- a/drivers/net/mlx5/hws/mlx5dr_rule.c
+++ b/drivers/net/mlx5/hws/mlx5dr_rule.c
@@ -11,18 +11,28 @@ static void mlx5dr_rule_skip(struct mlx5dr_matcher *matcher,
 {
 	const struct flow_hw_port_info *vport;
 	const struct rte_flow_item_ethdev *v;
+	enum mlx5dr_table_type type;
 
-	/* Flow_src is the 1st priority */
+	/* By default FDB rules are added to both RX and TX */
+	*skip_rx = false;
+	*skip_tx = false;
+
+	type = matcher->tbl->type;
+	if (type == MLX5DR_TABLE_TYPE_FDB_RX || type == MLX5DR_TABLE_TYPE_FDB_UNIFIED) {
+		*skip_tx = true;
+		return;
+	} else if (type == MLX5DR_TABLE_TYPE_FDB_TX) {
+		*skip_rx = true;
+		return;
+	}
+
+	/* Flow_src is the 1st priority after table type */
 	if (matcher->attr.optimize_flow_src) {
 		*skip_tx = matcher->attr.optimize_flow_src == MLX5DR_MATCHER_FLOW_SRC_WIRE;
 		*skip_rx = matcher->attr.optimize_flow_src == MLX5DR_MATCHER_FLOW_SRC_VPORT;
 		return;
 	}
 
-	/* By default FDB rules are added to both RX and TX */
-	*skip_rx = false;
-	*skip_tx = false;
-
 	if (unlikely(mlx5dr_matcher_is_insert_by_idx(matcher)))
 		return;
 
@@ -88,6 +98,9 @@ static void mlx5dr_rule_init_dep_wqe(struct mlx5dr_send_ring_dep_wqe *dep_wqe,
 		break;
 
 	case MLX5DR_TABLE_TYPE_FDB:
+	case MLX5DR_TABLE_TYPE_FDB_RX:
+	case MLX5DR_TABLE_TYPE_FDB_TX:
+	case MLX5DR_TABLE_TYPE_FDB_UNIFIED:
 		mlx5dr_rule_skip(matcher, mt, items, &skip_rx, &skip_tx);
 
 		if (!skip_rx) {
-- 
2.21.0

