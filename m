Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D27C369CB
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Apr 2025 12:28:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57A534029D;
	Wed, 23 Apr 2025 14:28:51 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by mails.dpdk.org (Postfix) with ESMTP id 5D1C7400D5
 for <dev@dpdk.org>; Wed, 23 Apr 2025 14:28:49 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vsKAYfn2cQvvf0NtjdklUtglrJ0hd7EscNIkWaC+BjfiTbvAviSyiw2yF4B5LnX7+a8Q2LbNgHQvfOCRiIBVR5AD82A9lTq+VwPtfDLwREQVFBYU/HI3M8QR5cZwzWHxi5VgPW1Lvys6q5CzRTJpI8hjX3Xe4nXusLVEkyRatRoVnhiAh7EOX0a4vWicplTK5oj2lHUwtq0Tt9gWMbkcsgJamXEdRlWbNfZ1SxtOlLhr0gZmNfMqMy0uH2wlIFMuY9BEbxvkcO065HVVMTnk6MINMLZD88JEyedSauONU3q55AylqofUrp0WNzZJ5/iLFQ975wzELCIfUHnfHjw5Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvwJ6Nn6XvH6CarzeE6dUBo6QKNkHo7tkhvDNTqBNA4=;
 b=ZQ0y3A9xpt9crcn3CZY3fQfsErb5ml8bqO5tdMGExq5rFwwx8RshpLMzZp8FK5/Q2AAXnFGERmjMu/3ABr+Z47gfMDXc/lMJl/aBCu/vC0xWF4ufnwoed2FEi+U8u2kyzV4OZs7UhGMHjaBdiyD4blWgpVoWQwHEUp2hmIuaRKUJOTopV+N39mS29atqfIkg8wG5CXSA4Ss4W/GviQrNUHLyF8I/inVogiAUed4SkUEBOfetgTY9xYV1avbXjLQMq1vBOhOr3X9ryYo4HCVKV5HQ/mJfXHmd9tAucpsVU0NcudsbktFMmNm5rQhcTFO2m2+0y5jTAiwVNcPxv3oZsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvwJ6Nn6XvH6CarzeE6dUBo6QKNkHo7tkhvDNTqBNA4=;
 b=AiqvT0xe3OkWrkotrc8wqcWiJM3kt4ynzYJQelYmQ7XI9j7oeIJGFdjnHHqzkSCkKsRw6FUVaDfbEsLYPqPP0xc39i9xbWHwhbA/Hg7V1rks/djeyCZv6Qnnxfq4zxQR7jc0xDMfHgX4PoTljLtAeUI+nP1ZXS5cbtwGEXm/KI4If9n2AYuYql7o6IElpM7nB2+u2RxGhaSnTz6NpIZSOTLGD9ldl+qXI9oEXZxzc7ZLMHS5uV6JfmZ2hkVVt159kc4oaCxT6tf3nsTcIUqX1Mw81w+SZxncVf1SZ+PsdP1M18cO4cOBlmM5tIfDBSYAqR1Wg2s44ybVepGyuWFDDg==
Received: from BLAPR03CA0165.namprd03.prod.outlook.com (2603:10b6:208:32f::9)
 by LV2PR12MB6014.namprd12.prod.outlook.com (2603:10b6:408:170::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Wed, 23 Apr
 2025 12:28:46 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:208:32f:cafe::a0) by BLAPR03CA0165.outlook.office365.com
 (2603:10b6:208:32f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Wed,
 23 Apr 2025 12:28:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Wed, 23 Apr 2025 12:28:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 23 Apr
 2025 05:28:28 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 23 Apr
 2025 05:28:25 -0700
From: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
To: <dev@dpdk.org>
CC: <rasland@nvidia.com>, <matan@nvidia.com>, <suanmingm@nvidia.com>,
 <dsosnowski@nvidia.com>
Subject: [PATCH] net/mlx5: mitigate the Tx queue parameter adjustment
Date: Wed, 23 Apr 2025 15:28:07 +0300
Message-ID: <20250423122807.121990-1-viacheslavo@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|LV2PR12MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: 472b363a-9f69-4146-1af8-08dd82626479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bpdOainTnp/vYfpOPuOhXDZwyUooq3wKaK6jEjtYz1NiSrDetbOaZ1I14gOk?=
 =?us-ascii?Q?ItHYWcftW3c4y/fqcpNhkXM8/H81OlmlBPr1mMiIihizRjTTPwWwLijX+mLQ?=
 =?us-ascii?Q?+c1MwUB5FslM0rvjX84n6rLgEzkNphz2exSdpojDHyHG/3BuZwQjI6XOeRuy?=
 =?us-ascii?Q?zOhpG1fLDT/xQsvgYqTDbzGidh8xRv7leRvrhqvlWwUygPZlu2b2n8LPAY1U?=
 =?us-ascii?Q?S8E0ogbyp4ua+Karq4rcnK2L06wYxOJDGlmLQDCnbM+CDaFRatfbgRSdvF4Q?=
 =?us-ascii?Q?Uxid2UqQIeSJf0N4carlZmzff9oPlf1YRS0FhPoOS/PBLgVxwvdiXhY2Hr+Z?=
 =?us-ascii?Q?65vO/Wp7xJM058NRyWjZiWjmg0JSH4bAZIS+fIg1oE7jyuKb1RlCT9PkG7w6?=
 =?us-ascii?Q?qQDrxm1gmo5B9HrM7Jnfxrvtt8V/0wZGSuJF0XKepmRzfAOJBBeRAzRFt6P4?=
 =?us-ascii?Q?dIMoYSA05pTS0dMHtuCeiIaitVXRCf+bcxt57lJfXUDoJJ5mvyUJyeD6Vc+I?=
 =?us-ascii?Q?Dmfs2Xi1qbLUk8AJVZG6xompejaGOyYgF8oA3EFl5le9DOOYBA7OgDgtjeNF?=
 =?us-ascii?Q?rsxZeeM2WWEn5hp73/1zOkNc2JGU6hNCJPjVOeGGYEu8i7OVEgaFZwI9JjdB?=
 =?us-ascii?Q?VB/wdFVLd1soBYm8eLiCWJjdufJZN2S+ogR8eszVvcStO/6WXlMhrmjm/1kn?=
 =?us-ascii?Q?LpKhgB4I5z/Vykn7kALriMQZ48oioaVQOfMOmFvniNbyJHbJblN1fO64TS/f?=
 =?us-ascii?Q?K1bNHETPChuCo8zMeMShbvEpkklJLwySrFmwlPsp8XssUZiUK9Y4KNs+bLjk?=
 =?us-ascii?Q?59k+IjOyuKl6urbe/B9C7mcDykDccZKSbIcg1JepLDLMSo2uKd0+IEblCBkq?=
 =?us-ascii?Q?D7qtKYWDtkFjLWE2UnqN0BYoFIcaHj5jaM7lO73vn60RKpS67R1VXu40d081?=
 =?us-ascii?Q?wm2pmpEhYTdno0Y5JDeMaqwE6YUtoCkdp9fkIMkhgTe6s10PY9nIzDzmpvcJ?=
 =?us-ascii?Q?6QJyfPnm8LsTB3h6tQc8qWmQ+yayNNPI/rlLW7LUYpITI4a57RVuJZePPXUS?=
 =?us-ascii?Q?sHtlxKLggI0rrMo9tX5mSDWkgikWrkPjk4bQNni+MlV5GLhkimyKh+PoRToH?=
 =?us-ascii?Q?bLoL17fxVwAIlNkYeGqIOx3EPfAvknjGxmdOkTuWAoHQU9oXzJJOp08afJFD?=
 =?us-ascii?Q?drnVMTG8lSQDLVa2PpWgLM/YVvaWfMz4xa+wO8v6bBEgfcxXM213NDC+l9KL?=
 =?us-ascii?Q?FScfLmuO5QO3hr9v616Atu6re+LcVoK3UkpbkYfU0Z1FVr9j6h2bHUaskjYh?=
 =?us-ascii?Q?i4Ede+Fmn5GXyuGQG9czjwmK9hUMjRS5ni9r424kJ9U3hrs5FLrQSZpcoTfe?=
 =?us-ascii?Q?KMP4shNwQCroVkDEavYnYSsJiarQD7geB0BMaZV+gH3QYCAOEMTlIqav33Ao?=
 =?us-ascii?Q?c3QNyyrkSCJyuL8uq64VJ+2WzfD21h1O7HMsxWVsuOTnY7UR1YkHc87dDmGl?=
 =?us-ascii?Q?cbGj3v+jlmzRrNDzH86yT8aDPYrTI1nz131/?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 12:28:45.8355 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 472b363a-9f69-4146-1af8-08dd82626479
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6014
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

he DPDK API rte_eth_tx_queue_setup() has a parameter nb_tx_desc
specifying the desired queue capacity, measured in packets.

The ConnectX NIC series has a hardware-imposed queue size
limit of 32K WQEs (packet hardware descriptors). Typically,
one packet requires one WQE to be sent.

There is a special offload option, data-inlining, to improve
performance for small packets. Also, NICs in some configurations
require a minimum amount of inline data for the steering engine
to operate correctly.

In the case of inline data, more than one WQEs might be required
to send a single packet. The mlx5 PMD takes this into account
and adjusts the number of queue WQEs accordingly.

If the requested queue capacity can't be satisfied due to
the hardware queue size limit, the mlx5 PMD rejected the queue
creation, causing unresolvable application failure.

The patch provides the following:

- fixes the calculation of the number of required WQEs
  to send a single packet with inline data, making it more precise
  and extending the painless operating range.

- If the requested queue capacity can't be satisfied due to WQE
  number adjustment for inline data, it no longer causes a severe
  error. Instead, a warning message is emitted, and the queue
  is created with the maximum available size, with a reported success.

  Please note that the inline data size depends on many options
  (NIC configuration, queue offload flags, packet offload flags,
   packet size, etc.), so the actual queue capacity might not be
   impacted at all.

Signed-off-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
---
 drivers/net/mlx5/mlx5_txq.c | 79 +++++++++++++------------------------
 1 file changed, 27 insertions(+), 52 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_txq.c b/drivers/net/mlx5/mlx5_txq.c
index 3e93517323..6122a79fdf 100644
--- a/drivers/net/mlx5/mlx5_txq.c
+++ b/drivers/net/mlx5/mlx5_txq.c
@@ -731,7 +731,7 @@ txq_calc_inline_max(struct mlx5_txq_ctrl *txq_ctrl)
 	if (!wqe_size)
 		return 0;
 	/*
-	 * This calculation is derived from tthe source of
+	 * This calculation is derived from the source of
 	 * mlx5_calc_send_wqe() in rdma_core library.
 	 */
 	wqe_size = wqe_size * MLX5_WQE_SIZE -
@@ -739,7 +739,7 @@ txq_calc_inline_max(struct mlx5_txq_ctrl *txq_ctrl)
 		   MLX5_WQE_ESEG_SIZE -
 		   MLX5_WSEG_SIZE -
 		   MLX5_WSEG_SIZE +
-		   MLX5_DSEG_MIN_INLINE_SIZE;
+		   MLX5_ESEG_MIN_INLINE_SIZE;
 	return wqe_size;
 }
 
@@ -964,15 +964,13 @@ txq_set_params(struct mlx5_txq_ctrl *txq_ctrl)
  *
  * @param txq_ctrl
  *   Pointer to Tx queue control structure.
- *
- * @return
- *   Zero on success, otherwise the parameters can not be adjusted.
  */
-static int
+static void
 txq_adjust_params(struct mlx5_txq_ctrl *txq_ctrl)
 {
 	struct mlx5_priv *priv = txq_ctrl->priv;
 	struct mlx5_port_config *config = &priv->config;
+	const unsigned int desc = 1 << txq_ctrl->txq.elts_n;
 	unsigned int max_inline;
 
 	max_inline = txq_calc_inline_max(txq_ctrl);
@@ -981,82 +979,60 @@ txq_adjust_params(struct mlx5_txq_ctrl *txq_ctrl)
 		 * Inline data feature is not engaged at all.
 		 * There is nothing to adjust.
 		 */
-		return 0;
+		return;
 	}
 	if (txq_ctrl->max_inline_data <= max_inline) {
 		/*
 		 * The requested inline data length does not
 		 * exceed queue capabilities.
 		 */
-		return 0;
+		return;
 	}
 	if (txq_ctrl->txq.inlen_mode > max_inline) {
-		DRV_LOG(ERR,
-			"minimal data inline requirements (%u) are not"
-			" satisfied (%u) on port %u, try the smaller"
-			" Tx queue size (%d)",
-			txq_ctrl->txq.inlen_mode, max_inline,
-			priv->dev_data->port_id, priv->sh->dev_cap.max_qp_wr);
-		goto error;
+		DRV_LOG(WARNING,
+			"minimal data inline requirements (%u) are not satisfied (%u) on port %u,"
+			" the Tx queue capacity (%d) may not be guaranteed",
+			txq_ctrl->txq.inlen_mode, max_inline, priv->dev_data->port_id, desc);
 	}
 	if (txq_ctrl->txq.inlen_send > max_inline &&
 	    config->txq_inline_max != MLX5_ARG_UNSET &&
 	    config->txq_inline_max > (int)max_inline) {
-		DRV_LOG(ERR,
-			"txq_inline_max requirements (%u) are not"
-			" satisfied (%u) on port %u, try the smaller"
-			" Tx queue size (%d)",
-			txq_ctrl->txq.inlen_send, max_inline,
-			priv->dev_data->port_id, priv->sh->dev_cap.max_qp_wr);
-		goto error;
+		DRV_LOG(WARNING,
+			"txq_inline_max requirements (%u) are not satisfied (%u) on port %u,"
+			" the Tx queue capacity (%d) may not be guaranteed",
+			txq_ctrl->txq.inlen_send, max_inline, priv->dev_data->port_id, desc);
 	}
 	if (txq_ctrl->txq.inlen_empw > max_inline &&
 	    config->txq_inline_mpw != MLX5_ARG_UNSET &&
 	    config->txq_inline_mpw > (int)max_inline) {
-		DRV_LOG(ERR,
-			"txq_inline_mpw requirements (%u) are not"
-			" satisfied (%u) on port %u, try the smaller"
-			" Tx queue size (%d)",
-			txq_ctrl->txq.inlen_empw, max_inline,
-			priv->dev_data->port_id, priv->sh->dev_cap.max_qp_wr);
-		goto error;
+		DRV_LOG(WARNING,
+			"txq_inline_mpw requirements (%u) are not satisfied (%u) on port %u,"
+			" the Tx queue capacity (%d) may not be guaranteed",
+			txq_ctrl->txq.inlen_empw, max_inline, priv->dev_data->port_id, desc);
 	}
 	if (txq_ctrl->txq.tso_en && max_inline < MLX5_MAX_TSO_HEADER) {
-		DRV_LOG(ERR,
-			"tso header inline requirements (%u) are not"
-			" satisfied (%u) on port %u, try the smaller"
-			" Tx queue size (%d)",
-			MLX5_MAX_TSO_HEADER, max_inline,
-			priv->dev_data->port_id, priv->sh->dev_cap.max_qp_wr);
-		goto error;
+		DRV_LOG(WARNING,
+			"tso header inline requirements (%u) are not satisfied (%u) on port %u,"
+			" the Tx queue capacity (%d) may not be guaranteed",
+			MLX5_MAX_TSO_HEADER, max_inline, priv->dev_data->port_id, desc);
 	}
 	if (txq_ctrl->txq.inlen_send > max_inline) {
 		DRV_LOG(WARNING,
-			"adjust txq_inline_max (%u->%u)"
-			" due to large Tx queue on port %u",
-			txq_ctrl->txq.inlen_send, max_inline,
-			priv->dev_data->port_id);
+			"adjust txq_inline_max (%u->%u) due to large Tx queue on port %u",
+			txq_ctrl->txq.inlen_send, max_inline, priv->dev_data->port_id);
 		txq_ctrl->txq.inlen_send = max_inline;
 	}
 	if (txq_ctrl->txq.inlen_empw > max_inline) {
 		DRV_LOG(WARNING,
-			"adjust txq_inline_mpw (%u->%u)"
-			"due to large Tx queue on port %u",
-			txq_ctrl->txq.inlen_empw, max_inline,
-			priv->dev_data->port_id);
+			"adjust txq_inline_mpw (%u->%u) due to large Tx queue on port %u",
+			txq_ctrl->txq.inlen_empw, max_inline, priv->dev_data->port_id);
 		txq_ctrl->txq.inlen_empw = max_inline;
 	}
 	txq_ctrl->max_inline_data = RTE_MAX(txq_ctrl->txq.inlen_send,
 					    txq_ctrl->txq.inlen_empw);
-	MLX5_ASSERT(txq_ctrl->max_inline_data <= max_inline);
-	MLX5_ASSERT(txq_ctrl->txq.inlen_mode <= max_inline);
 	MLX5_ASSERT(txq_ctrl->txq.inlen_mode <= txq_ctrl->txq.inlen_send);
 	MLX5_ASSERT(txq_ctrl->txq.inlen_mode <= txq_ctrl->txq.inlen_empw ||
 		    !txq_ctrl->txq.inlen_empw);
-	return 0;
-error:
-	rte_errno = ENOMEM;
-	return -ENOMEM;
 }
 
 /**
@@ -1105,8 +1081,7 @@ mlx5_txq_new(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
 	tmpl->txq.port_id = dev->data->port_id;
 	tmpl->txq.idx = idx;
 	txq_set_params(tmpl);
-	if (txq_adjust_params(tmpl))
-		goto error;
+	txq_adjust_params(tmpl);
 	if (txq_calc_wqebb_cnt(tmpl) >
 	    priv->sh->dev_cap.max_qp_wr) {
 		DRV_LOG(ERR,
-- 
2.34.1

