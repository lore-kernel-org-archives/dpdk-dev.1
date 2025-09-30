Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2D2CAC5B8
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:30:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8135B40150;
	Tue, 30 Sep 2025 09:30:15 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011041.outbound.protection.outlook.com [52.101.52.41])
 by mails.dpdk.org (Postfix) with ESMTP id BC79A400D7;
 Tue, 30 Sep 2025 09:30:13 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q6a8tlGksiHnXWTl8cKv2ivq/bt4GVr54rAikA+fmzDNPdWgt5LU7BCQdxRimpxrasyNJSfSHsQOfhkjKWvZYg+SxR5l9U44GQvTsBSIcKqcg0bQTJLEM+zSC5Ji4Qp71LuoJZE22GAPMdVyTlv1TF7N9YdRqVB3o7cI4vLM+VOQ6LniGlD3JRlL5MNP3rslGTAk0pG3HQnx+hkIkB17I008UfrFX1Yhj8ErHq3YUF9dtgNcV0u3ZU8q2Jj7vE80F8uTF+3uK82BoUXoMXGOdvzIbGb65FJxg4OH62XKU3JT+1GE1YHiNvfJ+m+qaNPNMntO4Fw0e+qdeqtVbdjW0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXW6rsnXJQ99io7B1c19+DFbGu3kgj8NDDRcGnZrKIE=;
 b=evq0l+j4nDS5VKgF8zNpu6gkzdupP5MQSZuJoPRaupm66mKLC+F3R7o7Pcs84JWv1kGLHwndZBpbMFBWUPK+cWU2dvg+NFqwStdhGhW8zqWLaW87xqaDe7VEwFP/JZa84unWDkUyD6xNpGfBqJg/GqJFzGRv28R2NW20DJlxln5uOlb5+bT7JbGy1Eu+ek5+/qGy7u/eox4R7a5JFXW9PcEc8+hL6vb0LsU5TkP7KI64EVAPPsa6CsTEUZOu6WiNpNq4X8fa/5kRrSGn4InIpfeabmk7+nFxkJ1UShrSlfhxnrLAcyW3AdiQ/rzxh5cmPxSiwaq+LpcuCr9jI/plDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXW6rsnXJQ99io7B1c19+DFbGu3kgj8NDDRcGnZrKIE=;
 b=TmHYGPCd1Pznl1j/Hg54eUqvT9wi1F/x46TbkuZnOSyWp4sqkJpIOw3WzbeIuumi62wG8E2AyiIgAPcHQFHCXluHfP4O7F6o1Tj0dVn7Ol4EmVL/8g4Yr1msC/YQFeuhZbnMmuOMHzTfuG3zLujndCwmWPTUV084EH3g6sNWXO+YahCMxzQs038Wq17yzPM73BRoFpkbxISsMKuMUskpgKyLuEs4v+bTFKLDnk47sLAWNgCS328RMl0jbWFiplYzJfSMQ1ONrm5uQhp7LDaNavbjhkbJhpJscH2v6n9KYx/a1dYTd7UhuYRP5HYPRIxFNaPgZWGGQggdGe90gOmhkw==
Received: from SJ0PR03CA0199.namprd03.prod.outlook.com (2603:10b6:a03:2ef::24)
 by SA1PR12MB6872.namprd12.prod.outlook.com (2603:10b6:806:24c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 07:30:09 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::21) by SJ0PR03CA0199.outlook.office365.com
 (2603:10b6:a03:2ef::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.10 via Frontend Transport; Tue,
 30 Sep 2025 07:30:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Tue, 30 Sep 2025 07:30:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 30 Sep
 2025 00:29:57 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 30 Sep
 2025 00:29:51 -0700
From: Gavin Li <gavinl@nvidia.com>
To: <matan@nvidia.com>, <viacheslavo@nvidia.com>, <orika@nvidia.com>,
 <thomas@monjalon.net>, Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, "Minggang Li
 (Gavin)" <gavinl@nvidia.com>
CC: <dev@dpdk.org>, <rasland@nvidia.com>, <stable@dpdk.org>
Subject: [PATCH] net/mlx5: fix IPv6 DSCP offset in NT HWS API
Date: Tue, 30 Sep 2025 10:28:27 +0300
Message-ID: <20250930072827.9630-1-gavinl@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|SA1PR12MB6872:EE_
X-MS-Office365-Filtering-Correlation-Id: 26da8918-3af4-4418-3fd6-08ddfff32f54
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P58v0LQurWMCgq8lGnPvtPQS3sAtmZL0wOgAJt11xKT9UQFsc0hcVy0aoKe9?=
 =?us-ascii?Q?39rLpLsqlEGUFgPr7tWY/nYNh/PmIr+OPd2kgXxyWyzfkt3uSd0bBjhcyNoN?=
 =?us-ascii?Q?Y/2fbUAs9N9vwqQBATQkDb7Z71SgN6AFqNXl1bSHBP5ac3ZujIzS/ZzxMlUp?=
 =?us-ascii?Q?4EUxIMUtSrQmCECf8QkS78277od3RGcBizgctbNTAPPENaLjx0mdPVqy/Cqb?=
 =?us-ascii?Q?XLw37sPphcn7jc+i5QR97UKF6uyGSGyyyUyxb2TPAQbxLzi5OBV7pyPBmYjW?=
 =?us-ascii?Q?zBjBqsA0VnnJ83C4UXvtkW0V0tGhSNE66jVFL2JyfcErw1+8vLHGjNFMq4S/?=
 =?us-ascii?Q?ZFxVTnlko/+UApyjLT0xLncjjyKQHuCe+Gd1SKJi37BroRB3qX9svo+jQ0rg?=
 =?us-ascii?Q?Fmhj8dJxeSoshfENfihwk9ZoMgtbCX/t+7tCDubGmU7mvs9gzJwHyuIW/5uT?=
 =?us-ascii?Q?hioivjaNtz1h9piy2uo9VcF6N3JvBVtFZ2nLX2HVjWNZW6SGi3Xr5Slbzq5F?=
 =?us-ascii?Q?hTvPpUZkEFoFdI8ZqDroLkuiCszTztQjKkLw7HA98XdfIn4R5Huin7hzci+9?=
 =?us-ascii?Q?22JRWZ6kun0S23ovzEOBkQEnOo/UCeGJtNoe+BcvTIxXwAiy5fre58b0amjO?=
 =?us-ascii?Q?4ixYSJKEsXgGON7CEnvMGZZlCYus91Z2RjjQKJbUbhZKIlzzLJT0En61TxXD?=
 =?us-ascii?Q?HcG4ELWcuBo7/B7tUOFq9XU/D7WMypVSmyctYcnnStePreA31VLnYTahdSi7?=
 =?us-ascii?Q?luEVrJ6yVJpoa+G+636oJmHuHKT3KQW3eO3mPUCsGPvyyQj0EHc31t++xmnZ?=
 =?us-ascii?Q?emP9+QLObytD1dkxyER0b94S50CrCCKreZuPYfBUtcFvjSRYbNO3yeCtFw0k?=
 =?us-ascii?Q?BuogIxAbziglZFqsoXf/D0vgMdedChqNXtqzDVWaa/kmOnZAS1zbAwIlsfma?=
 =?us-ascii?Q?K5eKItxKhE7l0zskEpOLKf3FPkCBKand6OMfAQaJuKaJpcjscUYn6QmU+uE/?=
 =?us-ascii?Q?ndCiLaZ72+mgB27Cy5sT0xI6x+u2QJlt5kCuIlHok3Mc5c3bsbBM026vPW9E?=
 =?us-ascii?Q?f43dswVxL1t0Niga1nhFhZG6oxqcmw1wpW/IlwibQRzKpMaATHnM6tAQdKU+?=
 =?us-ascii?Q?N6nBQ2bqW/4f8SdOICf2l4gohuguhCIS09YfrLajtBR7l0xHFIm2jpZcDHci?=
 =?us-ascii?Q?Ahh8xiSj9u3LCCYqHU+c6WPtcpFH+J3KBCSTadrOfa6fqRLJYrznbd/krgFb?=
 =?us-ascii?Q?uAlRa/kBzFROfRlx3kfTKLzq7tXVbjkzsHSLvA/nXQYrDfe74+HwzzhYZiLb?=
 =?us-ascii?Q?nCJQXeXAUxI1tUBHm8pfjnqoacsvJzVFxLRh+vhirOWQ5m3mr0CDOV3FN+99?=
 =?us-ascii?Q?x4xE1q/xMQu1M88FiyJsRxjHch50vBEZmUNY6gdJuYfMBEM+4RTQ1VrruuQv?=
 =?us-ascii?Q?kFGJqFw3w5fw5RvipdnrcCprVGKTsJ09F4Lq0Q+44VEFOVnsivSSEUsdULaT?=
 =?us-ascii?Q?l9tcUDZpXhWGmdZ7NTgLfzcReZuQ0xd+5CQmIR3edAAqRWzUnTOxnaR6xcnx?=
 =?us-ascii?Q?2UAxxcwCrRJPCYTyofI=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 07:30:09.0980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26da8918-3af4-4418-3fd6-08ddfff32f54
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6872
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

The RTE action process in the HWS non-template API differs from the
process in SWS. The bit shift handling for IPv6 DSCP was not handled in
HWS, resulting in incorrect data in the field.

To resolve this, bit shift handling should be added to HWS.

Fixes: ec1e7a5ceb69 ("net/mlx5: update IPv6 traffic class modification")
Cc: stable@dpdk.org
Signed-off-by: Gavin Li <gavinl@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow.h    | 5 +++++
 drivers/net/mlx5/mlx5_flow_dv.c | 6 ------
 drivers/net/mlx5/mlx5_flow_hw.c | 5 +++++
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow.h b/drivers/net/mlx5/mlx5_flow.h
index ff61706054..6ec853f018 100644
--- a/drivers/net/mlx5/mlx5_flow.h
+++ b/drivers/net/mlx5/mlx5_flow.h
@@ -3680,6 +3680,11 @@ void
 mlx5_indirect_list_handles_release(struct rte_eth_dev *dev);
 
 bool mlx5_flow_is_steering_disabled(void);
+static inline bool
+mlx5_dv_modify_ipv6_traffic_class_supported(struct mlx5_priv *priv)
+{
+	return priv->sh->phdev->config.ipv6_tc_fallback == MLX5_IPV6_TC_OK;
+}
 
 #ifdef HAVE_MLX5_HWS_SUPPORT
 
diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
index bcce1597e2..517a5e530d 100644
--- a/drivers/net/mlx5/mlx5_flow_dv.c
+++ b/drivers/net/mlx5/mlx5_flow_dv.c
@@ -1638,12 +1638,6 @@ mlx5_modify_flex_item(const struct rte_eth_dev *dev,
 	}
 }
 
-static inline bool
-mlx5_dv_modify_ipv6_traffic_class_supported(struct mlx5_priv *priv)
-{
-	return priv->sh->phdev->config.ipv6_tc_fallback == MLX5_IPV6_TC_OK;
-}
-
 void
 mlx5_flow_field_id_to_modify_info
 		(const struct rte_flow_field_data *data,
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 9a0aa1827e..628a47f2ce 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -1613,6 +1613,11 @@ flow_hw_modify_field_compile(struct rte_eth_dev *dev,
 			value = *(const uint8_t *)item.spec << 24;
 			value = rte_cpu_to_be_32(value);
 			item.spec = &value;
+		} else if (conf->dst.field == RTE_FLOW_FIELD_IPV6_DSCP &&
+			   !(mask[0] & MLX5_IPV6_HDR_ECN_MASK) &&
+			   mlx5_dv_modify_ipv6_traffic_class_supported(dev->data->dev_private)) {
+			value = *(const unaligned_uint32_t *)item.spec << MLX5_IPV6_HDR_DSCP_SHIFT;
+			item.spec = &value;
 		}
 	} else {
 		type = conf->operation == RTE_FLOW_MODIFY_SET ?
-- 
2.34.1

