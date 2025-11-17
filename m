Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC659CEACEF
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 08:10:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15D04427AA;
	Mon, 17 Nov 2025 09:10:23 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011033.outbound.protection.outlook.com [52.101.52.33])
 by mails.dpdk.org (Postfix) with ESMTP id 6E43F402A1
 for <dev@dpdk.org>; Mon, 17 Nov 2025 09:10:21 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=skz6M7BZnzhrwo2dLCFZxtejka1NWBwnIWgJxgijY6/5Zp4r+izYSC3a+BcKyNoAryFH1xfAvSY/J6FTpBRqMjgDYLLJdpPZygPJQNZVBqIr7Zo+40BD3Csd29cvBVN5KbJODvDcEGIRsvnx+clCDzLBcnYQCOVH+Da6twkArGIb/LzTMf/qvwan/jF/y+z1z7UEplggB2IpSDllrKvy3uXGBYVm0102mjP6s410fMzDG6E/sc+v3YQ0D+9R4l5A4qHAvvlWTcxPiwCCdrsbGr8kTDirCh5e7OiIWaSMS0fgcK+WJ4ErcgDD0A//YY6wNYSRytVnluvMoS8LMjyz/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3bx5a/erFuVD43FpGQ7lB7WK/RCJ3H36fS9zGS8kHk=;
 b=vYPS9dAqmvRvgzE5EzjT0mKG9KS3fnhkjL/aoKYwPkfdxYZEbCPkIVe9H6+MV1yPxWEpnMrC4brDhw+OaOzYAG0xwMBGhyKM3+rWxWl9JgoxE6ScSbErems1wt9dIJppKzDdPQgTBFAGyCyoZ7f+JGD+ZdzOzQ7JbVmCBvVZAKWxFOkDi7pHQjVLwqpPlJFQmD5MjXXWVJSRbmlGblLMep5XrOQjh5cJBPE+Hswcl8LkcCWeCNdC0bMfHv09LNuvT2onXl1VGoTKdPIz1NJVCgn+qpwmt8CPY+a4fC8xSPA9FKJF1TeDOc8LNuhBOVFh7FxI+noX9gI4nebN9tPWVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3bx5a/erFuVD43FpGQ7lB7WK/RCJ3H36fS9zGS8kHk=;
 b=dDt1coP21GN5QRDVt12JJ2Va4Y3fX62b5G5D5bDxHAT6FCKtRUfYOXTOj/zb5CnDhTOxhe8Ln4ZTQlTCbo18UlmMAGLdBP7tTn+Aa2dXPOLAxKbQygEDeAekYNeady+posBKTr871AiK4OSgZNLV9Q0t3mJ7XbP88qltsttw83U6M9kAtNvr4It8yFXdII0rrFDlmYL2KFxU79FMdAWhtqhnfYgC+iAJcFr7aqGrzAQzpZLz8r1HPd3SkUdzd5xq2/swSH3jH6Y5ThaUN3oGbLUNp0tHs6gge2+W1BxuKTf6bLR0zS/pItqzg3jKslIC3y24WqwtJbW/mXXVAA4OoQ==
Received: from MN2PR13CA0010.namprd13.prod.outlook.com (2603:10b6:208:160::23)
 by SJ0PR12MB7473.namprd12.prod.outlook.com (2603:10b6:a03:48d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Mon, 17 Nov
 2025 08:10:16 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:208:160:cafe::df) by MN2PR13CA0010.outlook.office365.com
 (2603:10b6:208:160::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Mon,
 17 Nov 2025 08:10:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 08:10:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 17 Nov
 2025 00:09:59 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 17 Nov
 2025 00:09:55 -0800
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <dev@dpdk.org>, <rasland@nvidia.com>
CC: <orika@nvidia.com>, <dsosnowski@nvidia.com>, <suanmingm@nvidia.com>,
 <matan@nvidia.com>, <thomas@monjalon.net>, <mkashani@nvidia.com>
Subject: [PATCH 2/2] net/mlx5: fix the masked value for a rule for sync API
Date: Mon, 17 Nov 2025 10:09:42 +0200
Message-ID: <20251117080942.9750-1-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|SJ0PR12MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: 2092b199-9bc4-4933-57b9-08de25b0bde4
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4ci+l45T+S2ESCcQyyxr1JW0nngxeiE9VZ4rYNaU79+Aojn51ToY2VHpFjMb?=
 =?us-ascii?Q?tsfYlMkBz7ovKJmykuinwVUd5xx6NQoNLR14l/n5xxOormwjOCchFyJo5xpw?=
 =?us-ascii?Q?xMm/8KW3nOOzZ+ExoY7Gl4fZEHDkEWNcAkFrhBR3f6CvE/BK5sVxLDkQNaj9?=
 =?us-ascii?Q?aklEyc6wmeSuSMgkVkRKAP3P+qBboJIIe/rX62RvllcEx1sd7tZTiTMBbstz?=
 =?us-ascii?Q?onRIhc6HPgY5DiUxzLwwMYlhH/coIX1Ni14nUaqMda6LTSay+9Ec1wwxoM9k?=
 =?us-ascii?Q?TBe1zKNUlSsmo8Lv33RIxZN0H2hWGHOFFo9rBfSZnyLyPrqf+8bWcCrAzzdF?=
 =?us-ascii?Q?R4pKUbLz6PYb5ra4gJlhlX2tDMiF45Hph+bG4yNL9pu0PGrsiexoMRe9PGfk?=
 =?us-ascii?Q?g/sI8xaZEIMziesLiywedaFWZThwXMGWL+F17YdsdJ5jsgWI/TN+/jA+3MBH?=
 =?us-ascii?Q?uZ7GLUzwLGHGqvPOZLW3jez2DIW2Ijd5dRN7bqIeb53KlvJlR8E5m6QYdZdz?=
 =?us-ascii?Q?PEVWP+ZhHf2iNSXZteJftUuW+x3OcOWooDw4P6NOfFbueaiBPYzaFByIBajK?=
 =?us-ascii?Q?mb+3GUhNqS4BYzT1Gnb8RgVJr8JTSYDOzr+zGzHo93xIhVOrbISUSkc38FAk?=
 =?us-ascii?Q?5FIdufiQcGu15H6jisrJsNGex4RZpIUMlxA/QiZeo3BX+6yap5sf4QcFbIJi?=
 =?us-ascii?Q?Vnyto2/0PuqQiQLbtfC2GiOhU9JfGMGs+oCWtuiMIheW+uLddf0URAVl3FJg?=
 =?us-ascii?Q?k1LbX3IaBqca1zWYLW0UVvtsccGClwJYI46gvHc5VQO3/9+B1SU1rujOYDHv?=
 =?us-ascii?Q?TQcyUkdNspvZcEU8BiN1zyoQxJNhUyNylh1AUi+5khL4xD9EsugKcdhuK8+6?=
 =?us-ascii?Q?wRuiYrAwVLWfe9QZ6k89RgAYj4IOoXl/fhHxtapMtAlzxEIL0p6/SupeX33M?=
 =?us-ascii?Q?D6ip7wCtbedYgUEfY8GxeuEVejCZUvCfD3NHy5wKvYGr0vfkhAyGJ8ael6i5?=
 =?us-ascii?Q?rrVDZujpwrh0WMBn3jeP1LeDKHoI4L3Eem4tds64yiTK8cTp1JvalzBingdJ?=
 =?us-ascii?Q?gV5tsKoKzEPxim7m9O4qFF3hLZp75nXT+zYY3c0w75DoinSM9mTX/+xsBCXY?=
 =?us-ascii?Q?TbWXWx4GbPFCS/WIfHxATKcPNqe2uX8+IJOBFDNYlovfk40rqn9/N/H/KEtk?=
 =?us-ascii?Q?3fpvZpob9UX6eIfDiae8ykDoLf7Z36wLumhEkHWBxwmaxgnM3F7n1/Rgy2Y2?=
 =?us-ascii?Q?bNrbU+r//IjlO+8aAhHuYqICPFSFGpfeGsLmzUWnuXU3ICBzA0Ruhy60r8no?=
 =?us-ascii?Q?pgk8XF+5OmxuqwkAUkQBuEUhPeiIJ9u5JIeMUMi1iw19rcE1xo91ZRDyCP8x?=
 =?us-ascii?Q?67UalYuGmwzofavbKJ6QF/dNNQunnYlNLYW/5Oke4ypx0oDseE+mXyKwMMR5?=
 =?us-ascii?Q?uD2G5ZIbPZ433hL2GZ+LQCtWgRG7a/ChVs1x7+D7AUpFRSQTqaw7FrpNUf0Q?=
 =?us-ascii?Q?MoKtjEWfMSKTKMdO716WtqmYyNbhizdsbFNu2j84EQVKv9IQrievWSxb/ukv?=
 =?us-ascii?Q?FnPeGNDxJ3sg7nauze8=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 08:10:16.1622 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2092b199-9bc4-4933-57b9-08de25b0bde4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7473
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

When inserting a rule via HWS synchronous API, the underlayer
implementaiton is a bit different from HWS. The template(async)
API calls are re-used. In the template API definition, the user
should ensure that there is no value bit that is not masked by
the template.

In the legacy SWS synchronous API, when translating the item, if a
mask is provided together with the spec. The value is the result of
the spec OP-AND mask. If no mask, a default mask with all 1s are used
and the value of the spec remain the original input.

By introducing the new logic to do the OP-AND and duplicate the
items from the input in the rte_flow layer. The spec field will
be with the correct value after inline OP-AND calculating. The rule
will be inserted with proper value as expected by the user.

Fixes: e38776c36c8a ("net/mlx5: introduce HWS for non-template flow API")
Cc: mkashani@nvidia.com

Signed-off-by: Bing Zhao <bingz@nvidia.com>
---
Depends-on: patch-158854("lib/ethdev: support inline calculating masked item value")
---
 drivers/net/mlx5/mlx5_flow.h    |  2 ++
 drivers/net/mlx5/mlx5_flow_hw.c | 43 ++++++++++++++++++++++++++++++++-
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mlx5/mlx5_flow.h b/drivers/net/mlx5/mlx5_flow.h
index e890e732c3..2239f20bbf 100644
--- a/drivers/net/mlx5/mlx5_flow.h
+++ b/drivers/net/mlx5/mlx5_flow.h
@@ -1945,6 +1945,8 @@ struct mlx5_flow_workspace {
 	/* The final policy when meter policy is hierarchy. */
 #ifdef HAVE_MLX5_HWS_SUPPORT
 	struct rte_flow_template_table *table;
+	struct rte_flow_item *masked_items;
+	size_t masked_items_size;
 #endif
 	uint32_t skip_matcher_reg:1;
 	/* Indicates if need to skip matcher register in translate. */
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 6dc16f80d3..4c3056e8b2 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -13952,6 +13952,42 @@ static int flow_hw_apply(const struct rte_flow_item items[],
 }
 
 #ifdef HAVE_MLX5_HWS_SUPPORT
+
+static inline
+int flow_hw_duplicate_items(struct mlx5_flow_workspace *pt_wks,
+			    const struct rte_flow_item items[],
+			    struct rte_flow_error *error)
+{
+	int ret = 0;
+	size_t len;
+
+	/* Only the specs are needed for the rule. */
+	ret = rte_flow_conv(RTE_FLOW_CONV_OP_PATTERN, NULL, 0, items, error);
+	if (ret <= 0) {
+		DRV_LOG(ERR, "Can't get items length.");
+		return -rte_errno;
+	}
+	len = (size_t)RTE_ALIGN(ret, 16);
+	if (len > pt_wks->masked_items_size) {
+		pt_wks->masked_items = mlx5_realloc(pt_wks->masked_items, MLX5_MEM_ZERO,
+						    len, 0, SOCKET_ID_ANY);
+		if (!pt_wks->masked_items) {
+			rte_flow_error_set(error, ENOMEM,
+					   RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
+					   NULL,
+					   "No enough memory for items caching.");
+			return -rte_errno;
+		}
+		pt_wks->masked_items_size = len;
+	}
+	ret = rte_flow_conv(RTE_FLOW_CONV_OP_PATTERN_MASKED, pt_wks->masked_items,
+			    len, items, error);
+	if (ret <= 0) {
+		DRV_LOG(ERR, "Can't duplicate items' specs.");
+		return ret;
+	}
+	return 0;
+}
 /**
  * Create a flow.
  *
@@ -14001,6 +14037,8 @@ flow_hw_create_flow(struct rte_eth_dev *dev, enum mlx5_flow_type type,
 		.act_flags = action_flags,
 		.tbl_type = 0,
 	};
+	int len;
+	struct mlx5_flow_workspace *pt_wks = mlx5_flow_push_thread_workspace();
 
 	if (attr->transfer)
 		tbl_type = MLX5DR_TABLE_TYPE_FDB;
@@ -14065,7 +14103,10 @@ flow_hw_create_flow(struct rte_eth_dev *dev, enum mlx5_flow_type type,
 	if (external || dev->data->dev_started ||
 	    (attr->group == MLX5_FLOW_MREG_CP_TABLE_GROUP &&
 	     attr->priority == MLX5_FLOW_LOWEST_PRIO_INDICATOR)) {
-		ret = flow_hw_apply(items, hw_act.rule_acts, *flow, error);
+		ret = flow_hw_duplicate_items(pt_wks, items, error);
+		if (ret)
+			goto error;
+		ret = flow_hw_apply(pt_wks->masked_items, hw_act.rule_acts, *flow, error);
 		if (ret)
 			goto error;
 	}
-- 
2.34.1

