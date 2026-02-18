Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AAAE9A03E
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 08:14:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1816440299;
	Wed, 18 Feb 2026 09:14:39 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010020.outbound.protection.outlook.com [52.101.56.20])
 by mails.dpdk.org (Postfix) with ESMTP id 78CAF4014F;
 Wed, 18 Feb 2026 09:14:37 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wbnmqPyJEZmEVLGS7KNbwHTeK1XUfA8F1f4v730rjiayXor7WXszA6fyTNxqA9q+VTWyEQw6MfbIp0c++FTUzrFG4ElLfMb5jpFefUKpPoSL2LfBiyFS4npmm3WUItr7pomafQZGcF5VDAsfynBeV2WM+HGl80kAqgW52sqa/YLoetXnzPZm5TfRU5AiuIE4PILOHfH7FyW2zAHOKd6f0H+rxWcr8nSgRFtzf9bJmOAZmJxWzIVpzO7fN1EsMwitAf0XMskq2KUISFW0IfInN5U1njOgCePZujmAGzuixo8UbghgpgXinAR/8/r1y3MvbB7/PuQu8hECeO6EGxcFAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OW0gNTUo/hAaxWxxDp3AkFB7W34YmURmkxY0fK2lNlI=;
 b=rF7+qFMSn8j3L8mrgxFz9wQI3qhRwkk6+difBGq8moy6okI7+wtl5khjldZubchm/+g1vi7D+NAdQJZMU1JQsxRu4PxoAClVb720axs71Q/oydzzPZydJLqgNel0MP7xUE5oAEjQ04PjQyNKQe6xZj4GyIwC6Vwic514GORw1aFlv3z6TyoafiEZQIuBwSVbkzBCiyf/D4dXxr34col+dp/azic4+Aa9cYF6m6yR0yiicwi7d8yB01DCLhZGpGiCSM/3OdfxvkwqDc7Ms+ZIuJBxiTZXo6MM0BhFMicFObSWxy5lx5w5jWqOwNFySkLAfaA84PUUsbraWobn4kAqfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OW0gNTUo/hAaxWxxDp3AkFB7W34YmURmkxY0fK2lNlI=;
 b=Qbb0+zudlCAeilK9jCXB9CcCnIAxD3MyUKo0w5iYTIAuXS0KkvOIF2+GKbNXtgIj72ahpJ/+Q331oQIivS/3UzouUpC6puODd5vZHcGhvN4l0mIE+hKkAuzLxlKtymD0ueXfG812wK+ZMuM9xt/cadVdF+nHPPG+S8lySR4iFzMEk3ZIjPgas1SXkqkjqMn635xxw39yI5ikvE8kWa3SWHijHTUnrEOIwm1yD2ok15jXdstKH3AEniGDftYnULKcBp42w13JLfaaxKJYtO8AFu1sM/iXpDbs4wsZyKJgDoQv1yyMqrqIN/TQT/xgq9RnQvtuIpBvXeqmJTOUhFaG6Q==
Received: from BN9PR03CA0435.namprd03.prod.outlook.com (2603:10b6:408:113::20)
 by LV8PR12MB9333.namprd12.prod.outlook.com (2603:10b6:408:1fa::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 08:14:34 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:113:cafe::d8) by BN9PR03CA0435.outlook.office365.com
 (2603:10b6:408:113::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Wed,
 18 Feb 2026 08:14:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 08:14:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 00:14:22 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 00:14:20 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH] net/mlx5: fix shared Rx queue limitations
Date: Wed, 18 Feb 2026 09:13:50 +0100
Message-ID: <20260218081350.57011-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|LV8PR12MB9333:EE_
X-MS-Office365-Filtering-Correlation-Id: 66473c82-91af-40ae-51b1-08de6ec5bff2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1MRfSr3JH4q1YX1P8D4JBqj2O2rSwYa59TJfYRByfYAn5Xm1tEgQzBNrmJI/?=
 =?us-ascii?Q?bi7mtzXvhze4mMGzAfPkWA+2bONwlnRyWQce+QR7vM67Siqn6SerozEKDWGV?=
 =?us-ascii?Q?+5RJ2pRa/UJHyBcwPEJcp80ZwKsIbebXy1ohpektL2wi8QYyCuBJT1UlaYhR?=
 =?us-ascii?Q?3lzChlaSAt52HH9zYzun9QJ1BkWIUzEKCTqiMWl7BFShy5wqfhOeNkZHTqqI?=
 =?us-ascii?Q?yBVKlon4uc5kUmOp+g+cAJdju5MF2GSDi83ar7q9HeKDnU2QV7hc+OL2vuJD?=
 =?us-ascii?Q?GH2UhmCPRV70YzY+WqOk4krmv7rw06wURcJDB7b8mjwc5YksNE5HCNW5/aP6?=
 =?us-ascii?Q?4po2V1SL6REmvWkIniiKuc/MzZdi3bfhU8h8L2UK7IvFKkcnOUS3FtYMOVQt?=
 =?us-ascii?Q?d1T9I+GY+auMjVtBv5X5D316eh4nNKBUqnJHwfc8YpXb2jn7hEg9ddT2tSym?=
 =?us-ascii?Q?lTgPD8Y07cLPSa/2+h2r6/GMapPB69N9pdHQ/o4DjFnAIwBUNNOBCPKPwvJ3?=
 =?us-ascii?Q?l7TYz7fyWWt2kt+Puru9UqpRhyCGgytrGzd043rFJdIxg/jyrulLVv+kVid/?=
 =?us-ascii?Q?m++GYPRToHLUgM3i+YoO3hNxwhz3IKN/fmIfP0Z7qs50yAyUv0X+afsR2q0n?=
 =?us-ascii?Q?WwDmMQPZsB9YQ88TEO0kq1WnMyyjcyWdYAJeOPcXjo0eT5zc/+PBqky2zHKI?=
 =?us-ascii?Q?x/3xrCrudIzi878zlFiROSzTJwIkYQqS/JwNW3EvvlwM3AUdpDPQZMTYKYZe?=
 =?us-ascii?Q?1NcjSPUg3JF3FwgLm0Y+ENDy/oUqRYa70EMIe7uJUzoTj2ZS5aYPV8rai8Aa?=
 =?us-ascii?Q?dcCba+nbBPos1fG0xJc/cMZNCGhNg+0iutgX4KWboN6pgNH9uXqPF6vI52Uy?=
 =?us-ascii?Q?+0nv9JqcSAxI24F1VMYim2gt0BJxwN4RxuN/SVJEk90UlabCQ/n8NWKVzHEu?=
 =?us-ascii?Q?y7nIPjv7nm4IKUhtMuj+aFMjGwlWxc1vjr1o/UcEq+3rne+ec2Nugro3T+58?=
 =?us-ascii?Q?fmIMT6lPvXSrMKfkUTedudTRVX/F4EF8GvDjRSigB5cVOVM188hJm41F+cRW?=
 =?us-ascii?Q?oymTU+j2+ClXhp1Uhqfm79t22ibEQ0EKfZ0/3h0YSW8EHqQhQZa4jRc5nUil?=
 =?us-ascii?Q?D4Irti83umtEGnok6gbEMilERPZ89Ej/jJZ+lTF0JvhsBHYKeOlH4bmFukcy?=
 =?us-ascii?Q?7VB/HQeIQYj1vTmUXa8G5wFNZGqXNEKEk6vwf9tDGdJomjPYuKAtumBci7O9?=
 =?us-ascii?Q?7g/adPuNoJVGaM4TA5vg6125oRDf8ewhv0TwXQEGxyGqBmaB8fnAj9gQzZ/j?=
 =?us-ascii?Q?Iyx95oOP8yzKeTxxoJ2MV8OyokgxAky+gdYXSy4BJo1+52YopptOc4yR0QpT?=
 =?us-ascii?Q?1dH1bF5P36VZhVC/2Kiyx7ZDUiKSijbBrmSUP0Mxg/+Rg3Pwqh7OIdJiX44/?=
 =?us-ascii?Q?/u7mp1OQ7RQ67JlFRNCUjo6hHrt5FEGvpBKNBliVhVLaqghM78k6sP4JbaWF?=
 =?us-ascii?Q?4Z3MSPDoHQIdSo1WIJE/BUeedKFR3Alh1/fIq2ZQ+dRpPMF6776UOZRCZwtG?=
 =?us-ascii?Q?z9MKUDEZR8JYKCyKZr599Ha8Cbw+J+HpnRDI2Xlop6Yc5ZwCWWochYuVUzNR?=
 =?us-ascii?Q?j+m9KdFymCfgZvfvhEnqmaisYpgtaOQjgzUh2rnIB8rf8Tb7YK2Gmat0veRc?=
 =?us-ascii?Q?bgpjCg=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: M4OCmJqwPbIRPY0Jb7Cm2WJ1ZF2+tB0wf5CtAmBSP8YfEYTTBEdWcEmoa91/br0lwR8yFaKU2JWtmzDvNvex/INkDhhBucmVPbqGS0iyiFGXbUtTN85fxpn4nUFOG1+5OtVpk4joVJcjE7V75LnP+dWd8v7cQbH8PAXOgOkbjcRbyHqliLq6DRlJXXGtLYNvbLwrK4lG0XNUBPYfJH6ZxJ5E/IL308ACYq5Te/mByooyY1UYDJppSGmZbi2vWLrZzpKtAmm29qGcehsfuwDscQEm5FateKw36yGT8V1gZUeoXaaCsOEpFSbSUKi/YE7D+kfuTgh9jxPOXjDArCxBHsWteDhjloGL77Se7/e49ri8t06LplXlYGgBf2x+UVImKbC54GWNDIq24eQgUxmyBZv/nsXwNdf6AfkQswbkfzLejlvVNygpBPuDz//6+D3i
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 08:14:33.9094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66473c82-91af-40ae-51b1-08de6ec5bff2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9333
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

Affected patch introduced a new Rx burst function to mlx5 PMD
for handling out of order completions which are possible
on shared Rx queues.
This burst function is selected if and only if at least one of
the Rx queues on the device is configured as shared.

This burst function contains only non-vectorized code and is not
compatible with multi packet Rx (MPRQ). Although the function selection
worked correctly, if either vectorized Rx datapath was supported
or MPRQ was enabled, the relevant resources were still initialized.
For example, additional fake mbufs were set up for vectorized Rx
leading to memory leaks.

This patch fixes that by adding additional checks for shared Rx queues
to vectorized and MPRQ support checks.
Shared Rx queue limitations and Rx burst functions info is also amended
in mlx5 PMD documentation.

Fixes: 5f9223611f35 ("net/mlx5: fix out-of-order completions in ordinary Rx burst")
Cc: viacheslavo@nvidia.com
Cc: stable@dpdk.org

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
---
 doc/guides/nics/mlx5.rst         | 41 +++++++++++++++++++-------------
 drivers/net/mlx5/mlx5_rx.h       | 36 +++++++++++++++-------------
 drivers/net/mlx5/mlx5_rxtx_vec.c |  2 ++
 3 files changed, 46 insertions(+), 33 deletions(-)

diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index 2529c2f4c8..a1a428dd69 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -956,27 +956,32 @@ The Rx function is selected based on multiple parameters:
 - :ref:`multi-packet Rx queues (MPRQ) <mlx5_mprq_params>`
 - :ref:`vectorized Rx datapath <mlx5_rx_vec_param>`
 
-This parameter may also have an impact on the behavior:
+These configurations may also have an impact on the behavior:
 
 - :ref:`packet descriptor (CQE) compression <mlx5_cqe_comp_param>`
+- :ref:`shared Rx queue <mlx5_shared_rx>`
 
 .. table:: Rx burst functions
 
-   +-------------------+------------------------+---------+-----------------+------+-------+
-   || Function Name    || Parameters to Enable  || Scatter|| Error Recovery || CQE || Large|
-   |                   |                        |         |                 || comp|| MTU  |
-   +===================+========================+=========+=================+======+=======+
-   | rx_burst          | rx_vec_en=0            |   Yes   | Yes             |  Yes |  Yes  |
-   +-------------------+------------------------+---------+-----------------+------+-------+
-   | rx_burst_vec      | rx_vec_en=1 (default)  |   No    | if CQE comp off |  Yes |  No   |
-   +-------------------+------------------------+---------+-----------------+------+-------+
-   | rx_burst_mprq     || mprq_en=1             |   No    | Yes             |  Yes |  Yes  |
-   |                   || RxQs >= rxqs_min_mprq |         |                 |      |       |
-   +-------------------+------------------------+---------+-----------------+------+-------+
-   | rx_burst_mprq_vec || rx_vec_en=1 (default) |   No    | if CQE comp off |  Yes |  Yes  |
-   |                   || mprq_en=1             |         |                 |      |       |
-   |                   || RxQs >= rxqs_min_mprq |         |                 |      |       |
-   +-------------------+------------------------+---------+-----------------+------+-------+
+   +-------------------+------------------------+---------+-----------------+------+-------+---------+
+   || Function Name    || Parameters to Enable  || Scatter|| Error Recovery || CQE || Large|| Shared |
+   |                   |                        |         |                 || comp|| MTU  |  RXQ    |
+   +===================+========================+=========+=================+======+=======+=========+
+   | rx_burst          | rx_vec_en=0            |   Yes   | Yes             |  Yes |  Yes  | No      |
+   +-------------------+------------------------+---------+-----------------+------+-------+---------+
+   | rx_burst_vec      | rx_vec_en=1 (default)  |   No    | if CQE comp off |  Yes |  No   | No      |
+   +-------------------+------------------------+---------+-----------------+------+-------+---------+
+   | rx_burst_mprq     || mprq_en=1             |   No    | Yes             |  Yes |  Yes  | No      |
+   |                   || RxQs >= rxqs_min_mprq |         |                 |      |       |         |
+   +-------------------+------------------------+---------+-----------------+------+-------+---------+
+   | rx_burst_mprq_vec || rx_vec_en=1 (default) |   No    | if CQE comp off |  Yes |  Yes  | No      |
+   |                   || mprq_en=1             |         |                 |      |       |         |
+   |                   || RxQs >= rxqs_min_mprq |         |                 |      |       |         |
+   +-------------------+------------------------+---------+-----------------+------+-------+---------+
+   | rx_burst (OoO)    | at least one Rx queue  |   Yes   | Yes             |  Yes |  Yes  | Yes     |
+   |                   | on the device          |         |                 |      |       |         |
+   |                   | is shared              |         |                 |      |       |         |
+   +-------------------+------------------------+---------+-----------------+------+-------+---------+
 
 
 Rx/Tx Tuning
@@ -1829,6 +1834,10 @@ Shared Rx Queue
 Limitations
 ^^^^^^^^^^^
 
+#. Shared Rx queue is not compatible with both vectorized Rx datapath and multi-packet Rx queues.
+   Any configuration related to these features passed through device arguments
+   will be ignored.
+
 #. Counters of received packets and bytes of devices in the same share group are same.
 
 #. Counters of received packets and bytes of queues in the same group and queue ID are same.
diff --git a/drivers/net/mlx5/mlx5_rx.h b/drivers/net/mlx5/mlx5_rx.h
index 86636d598f..dffab3955b 100644
--- a/drivers/net/mlx5/mlx5_rx.h
+++ b/drivers/net/mlx5/mlx5_rx.h
@@ -602,6 +602,23 @@ mprq_buf_to_pkt(struct mlx5_rxq_data *rxq, struct rte_mbuf *pkt, uint32_t len,
 	return MLX5_RXQ_CODE_EXIT;
 }
 
+/**
+ * Check whether Shared RQ is enabled for the device.
+ *
+ * @param dev
+ *   Pointer to Ethernet device.
+ *
+ * @return
+ *   0 if disabled, otherwise enabled.
+ */
+static __rte_always_inline int
+mlx5_shared_rq_enabled(struct rte_eth_dev *dev)
+{
+	struct mlx5_priv *priv = dev->data->dev_private;
+
+	return !LIST_EMPTY(&priv->sh->shared_rxqs);
+}
+
 /**
  * Check whether Multi-Packet RQ can be enabled for the device.
  *
@@ -616,6 +633,8 @@ mlx5_check_mprq_support(struct rte_eth_dev *dev)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 
+	if (mlx5_shared_rq_enabled(dev))
+		return -ENOTSUP;
 	if (priv->config.mprq.enabled &&
 	    priv->rxqs_n >= priv->config.mprq.min_rxqs_num)
 		return 1;
@@ -671,23 +690,6 @@ mlx5_mprq_enabled(struct rte_eth_dev *dev)
 	return n == n_ibv;
 }
 
-/**
- * Check whether Shared RQ is enabled for the device.
- *
- * @param dev
- *   Pointer to Ethernet device.
- *
- * @return
- *   0 if disabled, otherwise enabled.
- */
-static __rte_always_inline int
-mlx5_shared_rq_enabled(struct rte_eth_dev *dev)
-{
-	struct mlx5_priv *priv = dev->data->dev_private;
-
-	return !LIST_EMPTY(&priv->sh->shared_rxqs);
-}
-
 /**
  * Check whether given RxQ is external.
  *
diff --git a/drivers/net/mlx5/mlx5_rxtx_vec.c b/drivers/net/mlx5/mlx5_rxtx_vec.c
index 1b701801c5..79e92811d5 100644
--- a/drivers/net/mlx5/mlx5_rxtx_vec.c
+++ b/drivers/net/mlx5/mlx5_rxtx_vec.c
@@ -606,6 +606,8 @@ mlx5_rxq_check_vec_support(struct mlx5_rxq_data *rxq)
 
 	if (!RXQ_PORT(ctrl)->config.rx_vec_en || rxq->sges_n != 0)
 		return -ENOTSUP;
+	if (mlx5_shared_rq_enabled(RXQ_DEV(ctrl)))
+		return -ENOTSUP;
 	if (rxq->lro)
 		return -ENOTSUP;
 	return 1;
-- 
2.47.3

