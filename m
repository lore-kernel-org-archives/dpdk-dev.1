Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C53C021B2
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 12:03:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC20A42E73;
	Tue, 25 Feb 2025 13:03:49 +0100 (CET)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
 by mails.dpdk.org (Postfix) with ESMTP id B3FBC42E4A
 for <dev@dpdk.org>; Tue, 25 Feb 2025 13:03:45 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O1+dp6w6J03XXsmSWwaZDEToZ8nX/hX2h9az00YOIyjgMQ0C6wgXc+Q64gqiUvqLRdJtZBILHVUREWGTS093AnZQnY/eAM/0G7AGFMNNKsx6gZEsro+ZSR07IOb+In85Sh4eVWPPw095E3YwCcHp7AQmJQ71HoYgnv24g6hgiai2UlU60yB714NIzybniZxCalkhfmsyfDmB4okeLNeKdqybvu6AcxOzhiqlvIXe/O6rjgZxOdIY9PbuLBhUsRDW0XnO50qvyhet+2ok7jqetnV5ev2yfiJJ9eDjyI/xtPXmAn8gjjxjBvFNqR/y8VKDC5wmyK1KMG/MUnN1G17l2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sx2WW3RDVxhzK/iQcgwQnt5+iSR53HJeyu7/O1WvBgE=;
 b=thZCgJwTLaVvo3UhGjR0DgW3H8QALxwVbcsGWb6u/F8mJiNF8clRwXPhJNjfGRC8P/+gTatJuNT2uSheZ7yBQRyHxcDiwvXNBvfdMJNAWigGIa79qMgfPqSA7xk3QlgDK9sUOt0++S9+w4Y7/C0uY5ig0fxsOuJdMIJkONzigfArHrlIJnB8z89Z/Zj4WS+rCySDlXprHtWgoqECDfK6UvFiBkxGMHoXzU891HvbpEzULNtZv/oimLEK7esrEyeU3M7hr33Eo4rEym9/+3ae5MtytMWGYwm56b8CDTRApgNqgxT9FNxMY6LIB96eQ0cS4eGZd0WGon2w//fe5vPOEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sx2WW3RDVxhzK/iQcgwQnt5+iSR53HJeyu7/O1WvBgE=;
 b=dqxDSwiMmjgcvFUFwkIDF/fVGrTv3riASGbWXW19jTl64Mx7ZdzIfo4ftxml5RXZC5fm8qPbjSSbM492y6g6Sj1eY1opj9BbQWc0RY9V2oS0rHeL3hzEAdc+bTJvP4fvR84WcxLVqwGxScHNOV4HDfQNEV1D35PMUtkEeTJMQVifBZz42S/vuDSXWaT3HW+EiF2sek/hcFxLhFZvFwqyO1isU6ieATBh5OkdmIhEfXhPWlBNeiT+NfAljTTco0pJxZVkPoeZXVqoLVNO7IlxUy7QC4/jkE/6vV5nzSUC8sL+BcV4GCj0Y/YjbCjfNBPnAG2X7krje1of5tH1uREzAg==
Received: from SJ0PR03CA0186.namprd03.prod.outlook.com (2603:10b6:a03:2ef::11)
 by CY5PR12MB6454.namprd12.prod.outlook.com (2603:10b6:930:36::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 12:03:43 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::8d) by SJ0PR03CA0186.outlook.office365.com
 (2603:10b6:a03:2ef::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Tue,
 25 Feb 2025 12:03:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 12:03:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Feb
 2025 04:03:28 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 25 Feb
 2025 04:03:26 -0800
From: Ophir Munk <ophirmu@nvidia.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>, <jiaweiw@nvidia.com>
Subject: [PATCH V1 3/4] net/mlx5: remove unneeded FDB flag on representor
 action
Date: Tue, 25 Feb 2025 14:02:12 +0200
Message-ID: <20250225120213.2968616-3-ophirmu@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250225120213.2968616-1-ophirmu@nvidia.com>
References: <20250225120213.2968616-1-ophirmu@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|CY5PR12MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: 19ddd8d6-c77e-467f-71bc-08dd55947312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/IJgkQNqs/rYi8r3E8ESVwTcXutUSaIOC0+b0nUgc5lzpFB+NHTTCR9h1/N8?=
 =?us-ascii?Q?CFiUmTtk7KzAGE93bAgnD5uQd1SyRppYR9xfQ+FTiMgPEAI/1QXARfZ4HqzR?=
 =?us-ascii?Q?gy1hi4ml+sZEIN382ylJw1IyYjJD9IpdvGYr/Dw0L0VTXFjrwajRHoLSF/U5?=
 =?us-ascii?Q?CSF6p5K3Giq6oPc8S9lF13oTlA9Qsp2eiDMoOFGC7xyE60ty/iidRKW5pgPB?=
 =?us-ascii?Q?7GIaZ69KgFb+vTQLNGJgNot1xJo0rtYoOJFn1S9FxlALI67eZy5gq564jx+D?=
 =?us-ascii?Q?F2FgKXCb3i6zrOmO81kVviy0gdElqoDgcCvpAI9kIT7Gndu3APaKe9iXntM5?=
 =?us-ascii?Q?wFEV31wZunxP6CA4XYl0tnHUhMOCzu6ev7rECRbKoG4+Pz4Sk5CeRQrw/xz6?=
 =?us-ascii?Q?V/gu0wS2ss/IIADXus/sC2y3hhxWfoJeFP1awEkWexI+YgQFocFUcxB2EaFo?=
 =?us-ascii?Q?1r7a6TEZvbCwV/z1T+uLtJpNtoYYAitP67p/VVKlzCSh0mjzuSVm4Ipg1ojB?=
 =?us-ascii?Q?TjDskq61UQjpwze2htcRjb9/hC6YPFCzimEXBrpumMP81Hjx/Vwui2cE0laY?=
 =?us-ascii?Q?JPRwUIQtri8VUS0M7XJHxyy2zxybKi3cJsXNTDrbcVzVsfsOLLNnv3DPr9DL?=
 =?us-ascii?Q?tD2io+clKlFZOHXRVh2DFcniQKEKwxqeUsyCwvW0w9WXeXFZA1OhYoz1ECGh?=
 =?us-ascii?Q?bOlSV0IQ4fVjGiZC0uwyczYNAUbE5cDxJmmBJm4JMln7ia/4opZXyOkjczMM?=
 =?us-ascii?Q?QZ/4ZazQsH8tgnTEworOOPL12zLm9WTVxdSLOY5V0z6mVWqXVidBqW+0R9Cv?=
 =?us-ascii?Q?5DO0lWJLcv6ACBr/R10OvzQAnJaB9tPCSmfMP42ajZt/9JuEjxRYOwwrNPvU?=
 =?us-ascii?Q?Yuz09rRehklpFZ0oG/rwJ8+lqFRjVbjd+mX+QEB/ppSKPVru07E2HbaU3vKB?=
 =?us-ascii?Q?W9wYkL/BJ8h0vT9sX7+tBzbe7FDtmm1WwmlCMFPMxsTeWotqVnDqDlyRdkyb?=
 =?us-ascii?Q?7vWMzCkbAZTbdW3R3LB3idlbz8GKB7+ZM/ar8PUckS+4rJiygc1WFS4n7sqs?=
 =?us-ascii?Q?Tevd6MN7SQMUUxTH110K9tqhzzgVSegfBJMo4DlesF946oO1Fd5wjndqJRw6?=
 =?us-ascii?Q?vt9IczKIN5jfuCZ0JBQsynDsUNi2/USQq/nH+ftuRac9cGjBSrdUuUZAUe/E?=
 =?us-ascii?Q?EMon00mXwppcVM1ibx93XoZCAJyAc2sX9+Lh2iIojPB419yZtAG56LqHKxb6?=
 =?us-ascii?Q?HEj+auC4bmI8YsaBHDf8MlvC8v3u/ZvXUXgozKbkG47zoGXWUHQfuJzGQHaz?=
 =?us-ascii?Q?iZzCQRbhjxGCgo3DnETxbfg9V/tyqeLKFY+Vwdmfm72BPKGPp5oMtfLWVjOO?=
 =?us-ascii?Q?BpAARvGmF9yRgVMnoT82lQbOmXEkMwqrBBaTNUPGiLzwY+iERxy9uUQjBXOA?=
 =?us-ascii?Q?DJpPJHH88ffKKJX4Ok6MhM5qWdaHKwskZxV72bIFqZEs/ISmrFt66kldx/fd?=
 =?us-ascii?Q?8oNQrkVa2c2ALc0=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 12:03:42.9337 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ddd8d6-c77e-467f-71bc-08dd55947312
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6454
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
index 4e015bf..6ddf1e5 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -9636,21 +9636,18 @@ _create_send_to_kernel_actions(struct mlx5_priv *priv, int type)
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
@@ -9661,6 +9658,7 @@ static void
 flow_hw_destroy_send_to_kernel_action(struct mlx5_priv *priv)
 {
 	int i;
+
 	for (i = MLX5DR_TABLE_TYPE_NIC_RX; i < MLX5DR_TABLE_TYPE_MAX; i++) {
 		if (priv->hw_send_to_kernel[i]) {
 			mlx5dr_action_destroy(priv->hw_send_to_kernel[i]);
@@ -12158,7 +12156,7 @@ __flow_hw_configure(struct rte_eth_dev *dev,
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

