Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7033BC83013
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 09:35:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60D29402D4;
	Wed,  2 Jul 2025 11:35:38 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2066.outbound.protection.outlook.com [40.107.95.66])
 by mails.dpdk.org (Postfix) with ESMTP id D3EAA4003C
 for <dev@dpdk.org>; Wed,  2 Jul 2025 11:35:36 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJ3PAWkc1dHXDU0Qi1GExqGugvMSJo3mP+O8ZFOZPGNmpAAZp/dW6XuPVDRlplBMX3xR9gI+lyR4sABzxvzYeQaFYSwbuRM2Q7TBy6uBvhJVKVUnFX8F3v31bQz8WW35Td7RzVgqDtatdUDPr5YGxVn6FsNvztX3889iy39Yu59LiW4drBeBvHcVJE6rlXQJyRPodR506JfgZkUta3WmA3essilVTlOTfuoT1HLEVUJCYGu4j3MqU7zy8+m2ZSqXQ41fGCcO5Hb0fCm8xOMRuBimDbIfNgAtP+lm/nmOLbPhR7JkbLqb5UBSsvVKD/75faR6VX2wq6in0fyYHK4yCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCYYq6ZoIiC+OZbcraZ0903oKPk/W4dpAKlo4n9JH9o=;
 b=GYp56e+FH1i/z3X/79slW68oABYQQiueyVAugw1SaauM0/9GO1vZcY3iZV1DSu0gGBJHdTTg0sXTYmvPXxNpZ4+lbcLS+VcR1F4bqC4nln8vABbAV/E1kdiolIDVoV302aVGrFBT5Z9ogp+NlyDde8qJgDqUW6KB/E6omuoWv8kmu59licZQ48K01BZR0oQATrTezbMwdLU4oc8nWzfu5BYE3v8RkBrJcEYAip+6uERxX7/G01kDFnP+5wJ5dH0HlHdYdRpcEprPCT1KCCaV4XRZHotxtXAda6OeaBmw26QjoPgYFwrGCc3qZuUw+fRzGhvXMv1H9NMb3lZp7L+tbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCYYq6ZoIiC+OZbcraZ0903oKPk/W4dpAKlo4n9JH9o=;
 b=aUYU/Ksa0tN3sViCbs/S1JU/m76cH/93rRXK7htgJmKjOy24w1zk+ytyhoaP5SZs1ZykOE0WnUxsyaPsJ7lOK9o7dSfcqJ108M2kqs6WzJcZqMjjNdW0Cg+8DlWhOY4etP+61HTXc2OxZVJB0Q2vxMCO7s79j8xbQ/V2TfNSBzz4b5qh7Gw/Bti2ULJg/n6yU1UtDKv+LhDvAPxy4oY3oETPDBfxBvKngn6XYXgtQdqo/xmFG5ipx92AQiQClyUh2ymZ/hiE5TIIwmfprOHPcUuT3oEqGbTbSbXTBOT36ukqTYS9gDIWyRrkd6M/HcVondXIgyXZgwrg9TFLufVlDA==
Received: from SJ0PR03CA0148.namprd03.prod.outlook.com (2603:10b6:a03:33c::33)
 by SJ2PR12MB9086.namprd12.prod.outlook.com (2603:10b6:a03:55f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.22; Wed, 2 Jul
 2025 09:35:34 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::b5) by SJ0PR03CA0148.outlook.office365.com
 (2603:10b6:a03:33c::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.19 via Frontend Transport; Wed,
 2 Jul 2025 09:35:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Wed, 2 Jul 2025 09:35:34 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 2 Jul 2025
 02:35:24 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 2 Jul 2025 02:35:21 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 2 Jul 2025 02:35:19 -0700
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: Shani Peretz <shperetz@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, "Bing
 Zhao" <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH] net/mlx5: fix inline data size adjustment for Verbs API
Date: Wed, 2 Jul 2025 12:34:59 +0300
Message-ID: <20250702093459.102142-1-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|SJ2PR12MB9086:EE_
X-MS-Office365-Filtering-Correlation-Id: 6de693b2-69bc-426e-c776-08ddb94bcb8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?z3vSLMiAGJuPvACGdwz2NRGCBg90UvHkVNulTzvSilVIKqH4DRv3apI6kFQN?=
 =?us-ascii?Q?Tad4a5yPqiCtjJxrf8WNBDfUugIftkDE3UMvPN1Ndh/r4EycTY+I8Z9gTfl/?=
 =?us-ascii?Q?5mydjgP5jc9ax7odt5ubA8mkdKoXU1nysmNrHY+0KdB0V/gak5a314zSRku/?=
 =?us-ascii?Q?k+F8aM2D1hydAEBN+2Y0ih6jS3HpXRiE2ji6MSYWmOuMzFs01ryUCGvlxgRI?=
 =?us-ascii?Q?mM5XI37V3JVWrJrM31PoaXnTSVE0veZze6SOsdjoT1QG4eRJ+vvIzwa4u1yg?=
 =?us-ascii?Q?NhGEO/AfrYKfkwMn8JJzisgMLmLWmMEvEZ+kvuRVRBWfTQVyEg232BuljBfS?=
 =?us-ascii?Q?W85TJ5MaPzKHAsC4E9sRAMSoRP+ZIQuvcDUORKrLsO48MUxRibsyfcoD5hR3?=
 =?us-ascii?Q?rH7xyTo3963gtSVA2TQOslfBjkY5BKuvaWCt1mGOUo8GQLDdMdVOsDUUC5mZ?=
 =?us-ascii?Q?OYm9cVXMraoWND+7k/j+Ub4I5teQ8namD2pJU2+YjfwBV8KOMAIPafrOLXYH?=
 =?us-ascii?Q?+kEXwGqBj01VJmyOxctQm47I1MWNEascpk53Qs/OvspN6Yqs+oDLvY/bxuzF?=
 =?us-ascii?Q?TF9eB/oHGIhzhCHPicvoI284OJ0IQZXMhIiQrX0KLof1eQKW+DNBkbLS93K7?=
 =?us-ascii?Q?SaOc8igjZZ0f1E6yQHhRWaN+jRfkAEOPp5vWO0nvIG5XsnEaNRghbIWUm6kN?=
 =?us-ascii?Q?3Oaht+aGTZkz5eSBOD2wtWnoy5XzSVtFuCSojfNwiQ8mnvOvEzgrZapMciuY?=
 =?us-ascii?Q?zSBdt4Ce8ShisVHmyfWvnjRZsWsT0w4EdIAQMg+Bx96XNmk+rVdxoNJIaXwf?=
 =?us-ascii?Q?X/URRnDC5A2Ibn3HxdtTg4+dY5jA0BmXzgtCk/0jzSfSTWb7sp9Ctz9jJBh2?=
 =?us-ascii?Q?0QLvIFhQ7Jvf2Uh09DKwMSSjaTUtomzpXbK2eaEQvDxogsSdDUcX4tIfrKtn?=
 =?us-ascii?Q?fx9mM9hkGpIFJfIAflnARne7hZFQGlpRhHP3SIwRksTKMWyV/NC8oRqhvsVl?=
 =?us-ascii?Q?RmrExH41His3jF6wXq2MYzYDuijSDXjal42mKKbE5PnSi7UPrMSGatop0SS3?=
 =?us-ascii?Q?X1uvU06vLp/g3vZsZZMBDsAuQXk2HTsN7JMS1GiSUPZKhNmqKPSXaeoKxrJb?=
 =?us-ascii?Q?yycwN9sGykXqWLD4ceEWDoPWxT875bQ5dxOdF8jcpvToTZatJ6YTwQ2kcxEy?=
 =?us-ascii?Q?HbAufJgl4pk/EE17B7OFBfWxIvhctXDTQ66sj0aQYqUFbDyMudPoGMtco3Jx?=
 =?us-ascii?Q?XO23O0uDzWMLUHp+I2M8cQsMnOvLg/OnKkFhnR3O9FEw8nPuL2psSZ9wmC4x?=
 =?us-ascii?Q?PIAjN4QpIVm4OoYcYp0QoA9Vnj4PAdc268N27HTj3vSQfESz8pKDz9lOUSi8?=
 =?us-ascii?Q?p3XYPpbqmYyQsQkfYWQGGYUjYlEAxruamU9LfgNYhARVk28Pshr9yDBhGE7H?=
 =?us-ascii?Q?F6lRkU1KoUipIDCzqiPYAl0jJFtsJNkujUVsOzMktWr+Zkfx23/YPRU2MiF6?=
 =?us-ascii?Q?XyHcwIXQfJGA4fxYzA3umcdf3qgqA8TMgiAo?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 09:35:34.4657 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de693b2-69bc-426e-c776-08ddb94bcb8e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9086
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

This fix ensures that when using Verbs for queue creation,
the maximum inline data size is adjusted to prevent rejection
in mlx5_calc_send_wqe() from the rdma_core library.
The adjustment is achieved by reducing the Ethernet minimal inline
size and adding the data minimal inline size,
there for decreasing the maximum inline data size to fit within
acceptable limits.

Fixes: 0c2f7837c673 ("net/mlx5: mitigate Tx queue parameter adjustment")

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
---
 drivers/net/mlx5/mlx5_txq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/mlx5/mlx5_txq.c b/drivers/net/mlx5/mlx5_txq.c
index 1948a700f1..0981091acd 100644
--- a/drivers/net/mlx5/mlx5_txq.c
+++ b/drivers/net/mlx5/mlx5_txq.c
@@ -1009,6 +1009,8 @@ txq_adjust_params(struct mlx5_txq_ctrl *txq_ctrl)
 			"txq_inline_mpw requirements (%u) are not satisfied (%u) on port %u",
 			txq_ctrl->txq.inlen_empw, max_inline, priv->dev_data->port_id);
 	}
+	MLX5_ASSERT(max_inline >= (MLX5_ESEG_MIN_INLINE_SIZE - MLX5_DSEG_MIN_INLINE_SIZE));
+	max_inline -= MLX5_ESEG_MIN_INLINE_SIZE - MLX5_DSEG_MIN_INLINE_SIZE;
 	if (txq_ctrl->txq.tso_en && max_inline < MLX5_MAX_TSO_HEADER) {
 		DRV_LOG(WARNING,
 			"tso header inline requirements (%u) are not satisfied (%u) on port %u",
-- 
2.34.1

