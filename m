Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDBCC369AB
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Apr 2025 13:32:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1EDFF40156;
	Thu, 24 Apr 2025 15:32:13 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by mails.dpdk.org (Postfix) with ESMTP id 35106400D5
 for <dev@dpdk.org>; Thu, 24 Apr 2025 15:32:12 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rzAlZmY7Hkcd/qYUmb5uMT0imWq1kqyA6CPFL/76BT7v/zSnuJPMV+xIZtTaI2Flfb++URqZ3Uv4ezMIB7/MLZCnDZSUKc50iPMgYPvXPPUZ+Khyic8PZuvB/WOXRT/o0Z+YxObpEDphDjW0AS83pkow1H3vjSk3sCK5Hkys+I+9I0W++m60PDmSuxSuBuZr7zqhSjF51uAtFAOAP+Fy8D7VHHO5qT8RqHWHROPnoJIgze3yQq6UIpFpXSymej0yGhmIQJ9lqZhhEugl79yoBmOGpnGHFvpTijmyUQFTR3YpFnimgIcFQsprYMHV0hGFUbwa6TQwlklshgYCRnSJ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1R08qwpJ2MuLvVxsmdtxYuyAuK1shL3y2H6AUVqryKI=;
 b=JT+bc1Z5GVGSrK5TzsRHFPGlimYr8ZXgh3gA0y1Iq4liobLeNOQSthAUnROXRhxwXulRdmPLDLbsjRBVqPCxMFwTI5g+WBY7EJehlJ2woRhuOKA4/soL9ZEnp3BOmmxoEHhdSTcuthjUIsZtO29jtVIJOuspetpASy5S/+EBtT1TLHLUzi4yujS8gMspeDKWkrWK7TYrq+Mnx5mEjxQnKZ6uSIwqfwRj6xJj8OaLS6L0R4SCfa2T1ShR0D8ywb0nTzPyDAdAVv9cYxawCgpK7TiG85R9JyZFY0DgzePb7JJRGvAE2IdgJ7LHa6YUnvNQkwuQvv8u1b1EKxrCIpZZNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1R08qwpJ2MuLvVxsmdtxYuyAuK1shL3y2H6AUVqryKI=;
 b=SSQBtfWugSKbPDsKqkAt8IRrXjMgwE/fQY1i1M2No4jCL/hCx1NlbypCjKHKIdZWB3bUbdNQxJzmR7LfkQrw/Me7Z7IWcjjpO35HDkWNhqpnTY6+rob5HdtcMh5QawNfWRUFBDbq18rWkA7DzrcieXu83i7JCcb7Y5bkhnCQVxMnNydMSKan3vY02ImnxLm/gulDT+GyOGgGVusKERmjumUxhWGNm5sCcnuqGkdbbO5Eb0ZOw0PIfBqtRVIXmCxyYHL3m6kbMXNdCHFI/YCQvX641LHd29etWjcaQq9qUYqOWJccmZkPJJBasaOpfbZGFL1eOeq/RdHBhtL5iGWJTQ==
Received: from MW4PR04CA0193.namprd04.prod.outlook.com (2603:10b6:303:86::18)
 by DS2PR12MB9568.namprd12.prod.outlook.com (2603:10b6:8:27c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Thu, 24 Apr
 2025 13:32:05 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:303:86:cafe::3e) by MW4PR04CA0193.outlook.office365.com
 (2603:10b6:303:86::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Thu,
 24 Apr 2025 13:32:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Thu, 24 Apr 2025 13:32:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 24 Apr
 2025 06:31:45 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 24 Apr
 2025 06:31:43 -0700
From: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
To: <dev@dpdk.org>
CC: <rasland@nvidia.com>, <matan@nvidia.com>, <suanmingm@nvidia.com>,
 <dsosnowski@nvidia.com>
Subject: [PATCH v2] net/mlx5: mitigate the Tx queue parameter adjustment
Date: Thu, 24 Apr 2025 16:31:28 +0300
Message-ID: <20250424133128.133900-1-viacheslavo@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <<20250423082450.5eb6cdee@hermes.local>
References: <<20250423082450.5eb6cdee@hermes.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|DS2PR12MB9568:EE_
X-MS-Office365-Filtering-Correlation-Id: 85968261-653e-4385-d1f4-08dd83346739
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?G/LIqR2AVdnLKe7QmAAaYUDyH7sYUIZ23DyRvqq2uIcttrEsU5qPp7YTlIld?=
 =?us-ascii?Q?3rVVeJfFJ6NCJSNf7iXopnTyv9ooT+NAHrLlU1qPpTlFi2odIQH6PGcZcJSl?=
 =?us-ascii?Q?jOg1Riblyoxfjzsscwei4h2i+dv8ryFJV2kB9gFG4YbdCgth2gV+LCsy5d+6?=
 =?us-ascii?Q?fXgjWZ19UjNgtJhsWwYJ4qZgjFXQzEdxAv+jJb1doZ1vqMB9T0ynvke/Xent?=
 =?us-ascii?Q?73BM5PEbRWOJ1E+Vn5A9zCBu8BY9gN6Q0jotCIAIDQPmmuKymRBLaCOAkdUe?=
 =?us-ascii?Q?l4lPzr29xo4AXH4VErx7udueEzA9JdBTKk8bSnEYjRKQe+h4py69dYRQ4MXI?=
 =?us-ascii?Q?tiFR8NqVDWJbO+SVH/oDpWQlKEMKm8HwDShtXh7gpA9w4/kNwvr+dD3/whrt?=
 =?us-ascii?Q?/3sJYXsjfo2rmNcg7X3En0+8d1fjj1/VAiUHwj01lkSjaIB0J1o4BC7ZF4MB?=
 =?us-ascii?Q?mL+IBFmFVHvHaU/Ma8PHDjukbDNRRDv0p33tFclX3lsJL+tE/TKhEogL85Fa?=
 =?us-ascii?Q?ODDXkEhZc+GPYe21A+6Cl4iSdWqQz6NZA0Y+y3k7Z00m/9G13B+moIgWb3RI?=
 =?us-ascii?Q?pMUuxrO039+EHs2PZ1CVS9lZ9fFUFS0kq1xgFtpvF2xfBH8M3cDrIQkDbqnE?=
 =?us-ascii?Q?ERQKy55f1Ed5rvoteSd+RlGn+NMlV2dWEhyBx1a1i2VKUgftgGq/OA50D3RO?=
 =?us-ascii?Q?B90F6JH87iNWJvaZS4bDGbPUZp21GG89uuBbmOgkH+fTkVv8jomgr4OOB5qF?=
 =?us-ascii?Q?u3yp/JgFoPLRDxteNXNyRI3lmnv7qOQiBrc6N/qKb9ag4PcfQYRBE8AyDwFF?=
 =?us-ascii?Q?elcP9OIxdhYY4/ENAaUFq1cQFUH8Bbe1Hsrw208pDaMJ2tZuM0EirwX+QFed?=
 =?us-ascii?Q?S85j4/fsjkjPmqrRB1us1IEMhC8e7nhnxyD2X2pPnThSDOsWJava0netMa4R?=
 =?us-ascii?Q?yncsXjaSw5qHKqlfa2MGTEIf4SrbT5aP1/WpvpVcgj02vObgacSavxmV0X7F?=
 =?us-ascii?Q?nzRxDeHJXrrekHKvRG2QJE8W3fauakoCM9/gB1+aDHXbmocleDL/j2hPSZAV?=
 =?us-ascii?Q?sC20arDFKubnD/Q/fnvbnqOWQZbxzu1mYOknJ9q1Totvcl7s8DWSO/YwA3/x?=
 =?us-ascii?Q?+Wu5pplBxxwaQ03xYyI4FGi67P3gPEK+B6Jt+kyueylF+3+7oqMwzZwYdHmc?=
 =?us-ascii?Q?FN3WlEAF8Pjhpd+Xog3MhBwb4m44kbPliq7heB0Bsfgw/HGUBNpHfZcQLl+u?=
 =?us-ascii?Q?tdMDfQSF+diMmgyqb3QplQZkJ9RQQQiBprBorFp0Sz5lyz3kllid3M79b9Y4?=
 =?us-ascii?Q?J5SrwM2KU4/YIp/Xm8+cO/58L0IcqSgX+VACW8M5+7DtWjFsVPdhJdE/wIlJ?=
 =?us-ascii?Q?OGLbpxK36/miKMSN4EoHDfTdPqUxOj+4O1RynVAb5oiQo8XPDH1DJCS5B75J?=
 =?us-ascii?Q?PyA96mDpvfRi/UwcX4TQm2yCRjVKDTHpz4KfFXXG8OU022yNGZDLE+rW0P0x?=
 =?us-ascii?Q?fmsvrGJ0jC/ol1vXlnZypEZYCSWHLl4//6Sf?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 13:32:04.8921 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85968261-653e-4385-d1f4-08dd83346739
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9568
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
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

---
v2: diagnostics messages made less wordy
---
 drivers/net/mlx5/mlx5_txq.c | 74 +++++++++++--------------------------
 1 file changed, 22 insertions(+), 52 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_txq.c b/drivers/net/mlx5/mlx5_txq.c
index 3e93517323..eebf3c2534 100644
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
 
@@ -964,11 +964,8 @@ txq_set_params(struct mlx5_txq_ctrl *txq_ctrl)
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
@@ -981,82 +978,56 @@ txq_adjust_params(struct mlx5_txq_ctrl *txq_ctrl)
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
+			"minimal data inline requirements (%u) are not satisfied (%u) on port %u",
+			txq_ctrl->txq.inlen_mode, max_inline, priv->dev_data->port_id);
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
+			"txq_inline_max requirements (%u) are not satisfied (%u) on port %u",
+			txq_ctrl->txq.inlen_send, max_inline, priv->dev_data->port_id);
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
+			"txq_inline_mpw requirements (%u) are not satisfied (%u) on port %u",
+			txq_ctrl->txq.inlen_empw, max_inline, priv->dev_data->port_id);
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
+			"tso header inline requirements (%u) are not satisfied (%u) on port %u",
+			MLX5_MAX_TSO_HEADER, max_inline, priv->dev_data->port_id);
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
@@ -1105,8 +1076,7 @@ mlx5_txq_new(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
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

