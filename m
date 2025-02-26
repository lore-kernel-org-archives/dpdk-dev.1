Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1575FC19776
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 08:40:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D4C840656;
	Wed, 26 Feb 2025 09:40:01 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by mails.dpdk.org (Postfix) with ESMTP id 2D70D40615
 for <dev@dpdk.org>; Wed, 26 Feb 2025 09:40:00 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BePfXmT+B9SUzDRSeTMgIToj9vRr16WfhMdhnnHjXsDxUGP73hvJg/ZQ5vp4FeAjmGoaM1BfpdFdVWk9FJae26AuZEJXi97lM9ik/vonznCu3b5js1OAS/1XLpDjAnNP5g/q6qZCkBV2iwcxd2c8/GDZ/HKJ98O9OFu/sQWl/nwO8LeIVrWPnF8zjd0aLTm//xv3yYSN1KnjAwanKP0hrIN1hv1VdV6ubVr9t+ad8RnQ+M8GJjC/KX9Js4cAza4Hs/LpwmFpaAziVsavfh6j6YCdE1R6f2MnqPq+HkqRQd7Jl3dE6sHfcPGsCiH9jbLpfBAWCpOyr4J0xEVb2wrSwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcppF04OtxTHbHRPlifeW0PsoBqClc+mX5twpG5WIf0=;
 b=drUqsH7W5s+SlrbFLYgoXnBobHWzW5UpFobWIEbN+xawZNes0lUZtpq9ABRMCv+tz6k2EJ6zkQlbvz8PJ096PBSWY+Ay6+oFUtrEOfDUfkq84xun56FJ+Je63Cw9okG2hCANZZc0AulMd6+USbHPg8oELGgz6XFm+ltS9DGnzj0G+0YZx3TFgYy907IWFNpQRPCWfOyv/SuJWDhVwKJvWvIFqwZIBqi0V0pk+Ktqx7z7M+C67XCuvgyfxy9ign52tsB3qFovxzwnUq8S6EhymsOIv/6c2jW/xJTWH0YN0Bw8VWAe9j4TSfiqxVr9rLqJkzuW041Q/IeDPVTqkxXsEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcppF04OtxTHbHRPlifeW0PsoBqClc+mX5twpG5WIf0=;
 b=H6vJNzLfc6mdXNHKCfm3g9nIQGe8XoaF2GN2cU4nFTZJkEF9aMHI2Axb0UNowNXaEI4LX53KXwM2H03VVDRY+TKj9O9DVZwHIXqtNM5PSU89jSWfVYLgrxn4DYU5Mk0lgggExwhdXgRpkAuD8YqwQCyg3gYGQ8xuhiaDBSPPRfLR0qmBoef8t97tE+FFy5zMZSRSEdzaOr1xNg/U7mJAaGrC7bb20WJsEgbUieOGma2rFlSl6W6uFtgo5TbH+yhMeErVhQkSrWNNOJrQHQ9pzbIgVbKh+L4g/sTdkLq+bePzqTSiJotYovTNo4QewICDwl2xsAUTW8Q/BW6/TzApnA==
Received: from BN8PR16CA0009.namprd16.prod.outlook.com (2603:10b6:408:4c::22)
 by DM4PR12MB5771.namprd12.prod.outlook.com (2603:10b6:8:62::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 08:39:57 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:4c:cafe::dc) by BN8PR16CA0009.outlook.office365.com
 (2603:10b6:408:4c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Wed,
 26 Feb 2025 08:39:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 08:39:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Feb
 2025 00:39:37 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 26 Feb
 2025 00:39:34 -0800
From: Ophir Munk <ophirmu@nvidia.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>, <jiaweiw@nvidia.com>
Subject: [PATCH V2 3/4] net/mlx5: remove unneeded FDB flag on representor
 action
Date: Wed, 26 Feb 2025 10:38:45 +0200
Message-ID: <20250226083846.4023622-4-ophirmu@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250226083846.4023622-1-ophirmu@nvidia.com>
References: <20250225120213.2968616-0-ophirmu@nvidia.com>
 <20250226083846.4023622-1-ophirmu@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|DM4PR12MB5771:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ebd3413-6ec4-4182-e5a5-08dd56412604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iaJZYsvO5UGEUQIhmAZlGSWFxaBqMghS7kvTPwfTNqcXH7nLyN59eWbapJWH?=
 =?us-ascii?Q?ZIV3FmbXY4Hpy8J1hbufuQ5hxnsL+RgOiujsqEdouaqugSDT0nXO74nWjTSf?=
 =?us-ascii?Q?/e2nvXtygGR9LUXimezP7OX8PGJfOgnxdJwjSKNmgKxsOkpq80jzDxtv2kgB?=
 =?us-ascii?Q?lGam64oG3yWieVr0VjA+u6ABq4V480vF+0wixhaJypsEbmMqMgdlorDUJ+JM?=
 =?us-ascii?Q?FAY/LaWX55XkJ/HViKQIpfJUFwukUhncx+hp4IxkkyNMnJiGAtBeFWJJ3kl/?=
 =?us-ascii?Q?CIn8EysPUt7gb2WhkQP+EOfC29V6Btn9yr/zh6l1w6skV2ZlT5E+DsSIdNMf?=
 =?us-ascii?Q?l8fysiUvjBjYHo7HjLUgHfb4P0XZKIwGK7F3hxe3Z3mxib1VOPi0rqY1bghJ?=
 =?us-ascii?Q?x0cIPyqJmnk02yOs0FNfR1wNDdA3+Q46grM+SX3A1Jg/54/795+bbRZUQjD6?=
 =?us-ascii?Q?7FFQk+HmKfNOBywtNR7c6Oob7pwAvtGl+OcUPOXlxkjgq2WCZgXPuwQ1OTTy?=
 =?us-ascii?Q?lGHkGVLCqhBsJMyjMWqGGc0seEjoC21YNw31ollAc+Kps+1Co3i8VvYs/q4Q?=
 =?us-ascii?Q?NeDzY5y5HFq963pcg3W8NnCaYPvZ03lk5N8UYTpvzKYyxk4EcjYYvZrJY06l?=
 =?us-ascii?Q?yeWEJYBIfaV+DKDfhLE9GeacOfYi+nSHyblNHbsw9ZWfWejkKWdQ8apAnUXD?=
 =?us-ascii?Q?++8t4hmt2uFYnH/DahbcVxjE24/xXnHtP7yHVfBytReS8QPVkp8/Kdtntemh?=
 =?us-ascii?Q?V5xlD6mQm/9IgW8lTdWeUKXfv3rSo5jC/rhPLbsYBWEZQF2l4xi0kq7m5eJN?=
 =?us-ascii?Q?HUkPbR2AWJ8ZCs2Xt3jry3YoQTFa3fKV5Xea7A8c4dgkl18dMZCWjsDoCeX1?=
 =?us-ascii?Q?yX7QZOjSTinxoLBwiwy3K8quho66EJFy6YeLRqcCJqQkr26ZAnaA2e6h9BAO?=
 =?us-ascii?Q?H2A9RlW9NQcObfkZc1Lbv8MRnUU12pmnDxEKIrCIm75Yrv00eQGDsONbaJJB?=
 =?us-ascii?Q?n0GFVQOvNvyfK2kovozlqQo/UZOYqgWGWYM+5aoFrY9AT7DfPCmHBVQ8fi8D?=
 =?us-ascii?Q?6Z2ucKS0pJqynwLQcIb61ycuAGv76mHXzK4nUa5+1Tnw+nzw2lgOM+s68iAC?=
 =?us-ascii?Q?TsMkRpIiplRhS5+jmBNK7A+kaMz0XRho9ZNG8lTjUY+EHCQy2Q4JwZhONr9X?=
 =?us-ascii?Q?lIWOE5OWRCygfYq6epN7xI4jKp1P697MfxjLPHsZFNvz6by7lTixDkDMHd36?=
 =?us-ascii?Q?iI5XzFSsNsOmz3kybB/orjgctH6tk3LFbNkvhLRxUXjhL3jonc4pBILKXqQN?=
 =?us-ascii?Q?hpxz6GBWh7v7IshgE87rVQYQQlyjmZhx53UJMjmJQUKpsJMUwtex9+cTkmCv?=
 =?us-ascii?Q?qPcQ9jo4BHG98Pn71K1yABgP40Mj3k2cUz4eiBQmao8XSD1ObLtUGS2p93EB?=
 =?us-ascii?Q?ufL1Of5kqzh7xjEDVkDHL+lsbgLHobSdzpLhwY5rXsPvfdh/GUF/3FqRyV+I?=
 =?us-ascii?Q?/lnZ2o//Qe+jqEo=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 08:39:56.5321 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ebd3413-6ec4-4182-e5a5-08dd56412604
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5771
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

From: Bing Zhao <bingz@nvidia.com>

The "send_to_kernel" action is shared and created during the HWS
configuration stage. By default, the NIC Rx and Tx flags are needed.

There is only one case that the FDB* flags are needed when creating
the action, the same as other shared actions. Only the transfer proxy
port needs the FDB* flags for shared actions.

Removing the unneeded FDB flags will help to save the resources of
memory and STCs.

Fixes: 07836ba156cb ("net/mlx5: fix device checking for send to kernel action")
Cc: jiaweiw@nvidia.com

Signed-off-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow_hw.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 1cc074d..f0888db 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -9649,21 +9649,18 @@ _create_send_to_kernel_actions(struct mlx5_priv *priv, int type)
 }
 
 static void
-flow_hw_create_send_to_kernel_actions(struct mlx5_priv *priv)
+flow_hw_create_send_to_kernel_actions(struct mlx5_priv *priv, bool is_proxy)
 {
 #ifdef HAVE_MLX5DV_DR_ACTION_CREATE_DEST_ROOT_TABLE
 	int i, from, to;
-	bool is_vf_sf_dev = priv->sh->dev_cap.vf || priv->sh->dev_cap.sf;
 	bool unified_fdb = is_unified_fdb(priv);
 
 	for (i = MLX5DR_TABLE_TYPE_NIC_RX; i <= MLX5DR_TABLE_TYPE_NIC_TX; i++)
 		_create_send_to_kernel_actions(priv, i);
 
-	if (priv->sh->config.dv_esw_en && !is_vf_sf_dev) {
-		from = unified_fdb ? MLX5DR_TABLE_TYPE_FDB_RX :
-					MLX5DR_TABLE_TYPE_FDB;
-		to = unified_fdb ? MLX5DR_TABLE_TYPE_FDB_UNIFIED :
-				      MLX5DR_TABLE_TYPE_FDB;
+	if (is_proxy) {
+		from = unified_fdb ? MLX5DR_TABLE_TYPE_FDB_RX : MLX5DR_TABLE_TYPE_FDB;
+		to = unified_fdb ? MLX5DR_TABLE_TYPE_FDB_UNIFIED : MLX5DR_TABLE_TYPE_FDB;
 		for (i = from; i <= to; i++)
 			_create_send_to_kernel_actions(priv, i);
 	}
@@ -9674,6 +9671,7 @@ static void
 flow_hw_destroy_send_to_kernel_action(struct mlx5_priv *priv)
 {
 	int i;
+
 	for (i = MLX5DR_TABLE_TYPE_NIC_RX; i < MLX5DR_TABLE_TYPE_MAX; i++) {
 		if (priv->hw_send_to_kernel[i]) {
 			mlx5dr_action_destroy(priv->hw_send_to_kernel[i]);
@@ -12171,7 +12169,7 @@ __flow_hw_configure(struct rte_eth_dev *dev,
 		}
 	}
 	if (!priv->shared_host)
-		flow_hw_create_send_to_kernel_actions(priv);
+		flow_hw_create_send_to_kernel_actions(priv, is_proxy);
 	if (port_attr->nb_conn_tracks || (host_priv && host_priv->hws_ctpool)) {
 		if (mlx5_flow_ct_init(dev, port_attr->nb_conn_tracks, nb_q_updated))
 			goto err;
-- 
2.8.4

