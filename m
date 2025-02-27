Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3055C19F2E
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Feb 2025 10:48:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C5B940A7D;
	Thu, 27 Feb 2025 11:48:19 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by mails.dpdk.org (Postfix) with ESMTP id B4ACE4064F;
 Thu, 27 Feb 2025 11:48:18 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rfD+xIVWNtE2VXP8qJSLG7BzZxHgRz3rW5vg2pCI8O8eCWH1ZVuDheLEsLhCDgu+ySELzig4ADD5gngBWOsMeMISk+23eL+jH0dF8vz7GfR/H1j7fDngzm4KWSZ1cmDSoms2yO7QqZWcE+CwHOgatURE3y+JHCpWBKGJnQExao2iwWolx1a/d9j039PdWj4Bc4BumyL7HF/8WnFKc4Bo3GNWPWI+4IK5bHyKQgWDLVsscn30WrzWFcI1aci/9U2DvF+jDLchoVyN85LAS9Qx/D2StgLEXnJ2/sP5r1g+btAsWxZeVRAZ0xh3Jgwob3XNe04FTAb2qLoznEqg9ndB1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1FxoONEk0bn1Jv4vvsF6cGz++LJ0kae3O55wfoRlAw=;
 b=bGPpaqB4r7R7cZhoQSRBqQOqOruakN3UtW3UEYgWGyQr76wflWxawEAxdJqrPaJOtxDi9NeFdAtQBtVRbgukZg7AHZ2TYqkH4FEKjDLmEfHrLj5ALfs+Mrgf2nYTmVZW3y2VZSZGxF5LhoWdZFeCeS1F4WZMFMcMLcV6atYQ1dDEvwHg6i1rhjuGqEfb7eNDZME+EtOMobYnse9BiXh9AKurO+TEw2rrFzuW/bRkmvuS62a8/hHeAR7JNTflzZkOmcksL2e9VnJ5e1AvRgjU3ub04SyCU9DDqLzvvl08BudNmxEh6j36qZYL/MOkBJvABFof5fJX9vC+6OBzDcoKyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1FxoONEk0bn1Jv4vvsF6cGz++LJ0kae3O55wfoRlAw=;
 b=NGefJY8rsc9byh5So5vcgb2HlkdZ08DXm3/UzHqiDmJMv6exHm3WU20M8qu2kRyzIHrZTyoIW0D+nqpaSre3Sm2VxdMFQb4BM3WeaSq4Ff7mh1/lLqmUf9TYrWJ5HxlY7AYqO/DSRG8F1RIhggFYZb8cQZF+zLx/bH+4c20Fu5hTp5gzeUHWSpIYdf0mwGjybrc2iMviDmT7m+Eq2giZSEEvFcWfED14l7ib4T7ECqARBo2s0BBbGh/yxK6Drdcls53NGnVLiEmwYedrljeOWKGg0ikEZa5NaVoEVwgQj7puzMIgcwhpQ8g2zj68cjGnjrlxw1joA1T27c3aAKPxiQ==
Received: from BY3PR10CA0002.namprd10.prod.outlook.com (2603:10b6:a03:255::7)
 by MW4PR12MB5626.namprd12.prod.outlook.com (2603:10b6:303:169::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Thu, 27 Feb
 2025 10:48:13 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:a03:255:cafe::e6) by BY3PR10CA0002.outlook.office365.com
 (2603:10b6:a03:255::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.23 via Frontend Transport; Thu,
 27 Feb 2025 10:48:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 10:48:13 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Feb
 2025 02:48:07 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 27 Feb 2025 02:48:06 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 27 Feb 2025 02:48:04 -0800
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <dsosnowski@nvidia.com>, <rasland@nvidia.com>,
 <stable@dpdk.org>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Gregory Etelson
 <getelson@nvidia.com>
Subject: [PATCH 2/2] net/mlx5: fix error info in actions construct
Date: Thu, 27 Feb 2025 12:45:28 +0200
Message-ID: <20250227104531.93668-2-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20250227104531.93668-1-mkashani@nvidia.com>
References: <20250227104531.93668-1-mkashani@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|MW4PR12MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: 709f0f54-ff79-45da-3e16-08dd571c3bcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WeuyChsYjwX/9UJtcwDSfSEx5FwR230TzOsiVrJMxcnSMD/L24ByHzEQ5/Kr?=
 =?us-ascii?Q?WGZo0QT3AYeIlOdSCMljkGBm+GjhICIA7V9DXP5C1ydMznM21ktRH3Se3tRI?=
 =?us-ascii?Q?Xs+VOQ/N07FlHsjyfCOcol8oCtpCULFfm1NSRe+5wVVz/xSdXpDvRaPeleqV?=
 =?us-ascii?Q?QrfcaNfy8OavIzrd31lIOrRF7xH39e+G0Tr2SYIx4bL+ISgq9ryN+uPQyDA+?=
 =?us-ascii?Q?01wX8iBaiDrtZSDYTnjn/fYGSHD6hmwtaSqY7ZM9BobRsZTu4kVvTKpqWEkb?=
 =?us-ascii?Q?1NkOoRvUMEHX8irlvSwtMxnFnGJvVxyC4Q3pe3eh224+QfqmJHUb5/k/GF7A?=
 =?us-ascii?Q?Lw6SyCZe3Xq+x7TyFJg+Th3Zz/flzJ8jdIbPEJQeNXSOcZtMtNHODhzb+BjH?=
 =?us-ascii?Q?Je8Fk83s+AIYb3GozUnVr241X3rfZLmGzbzMYI6A57uEvwiCr3KfyL6G1tiM?=
 =?us-ascii?Q?hVFWjt3EIsvSYWIqyglKFUwltMR2KG6K1cpAJBZBXi8FlqxA/vkY0g2O4sA6?=
 =?us-ascii?Q?rZC3sUBhKS8myNu9L5z1TBeU8eIYulHNwT8iomKbyLKcP4nz6DBc7UDun3gl?=
 =?us-ascii?Q?FDxkmGqV1U+1XrAJE7Lgrj9/ablcdGyUXJNoz7ncIm29JM4Tkutqg4ghvUdv?=
 =?us-ascii?Q?JWGr90rlLn1fN3Aho65d9Z2ADMXrluu/WrfZEDYvAOUpbMippLsvBq/GXu3K?=
 =?us-ascii?Q?Y/2mI5IX8cPr6KfDctGO8JSnjEmNpTThA1Anh/vd9erVUPU8QRbKlH7ltX6P?=
 =?us-ascii?Q?/0R288iyPh7eefibJvyD/pvZsXMUcpRsW9vaFau5h5ru1RBqpbyQhFufoFjL?=
 =?us-ascii?Q?fs6/nYhHFwMJm0VNBPObqpTPtBTknpJMMiQ3Ry0xHLt8jJymX175So3hMUuo?=
 =?us-ascii?Q?XwVWz99Sqst5xrUul8FhI/wTk8dVt5EzDg+N+St5KWXOxhhrGqYOo4lSK2qj?=
 =?us-ascii?Q?IYcEqb97KSOHwe9RAtshothIYwH8OiBF8XAhFSoyw5ShMNVdd3F81GfVO3QW?=
 =?us-ascii?Q?xmofM8+Y5F6tJDL1kQqC/tHSWUJOzs4jJvdL4koY/tKXgXbuEEsvex/NWinG?=
 =?us-ascii?Q?NNDw6dp/M/gIx/21FMm2Kq8Le5YfDcrPCMT+3nDYea3fTfQJEwB1SBzT0PbO?=
 =?us-ascii?Q?1GuJUKU55/e7vgcOdRGfYMAZuQU6a0Pnd/ESQYKB8L8Hz0sxhsDqgqqS7ssz?=
 =?us-ascii?Q?qaEl+3Dog76l15KZZNLe23vkN2dwLRfZVheux+G2UyRqbOQB6OG8E/K+Yxc8?=
 =?us-ascii?Q?sfPuj8Hc0VTwKza+PZA5vKgAKNCNIfH434iyaCs88TPQWXFvNU2JCTqT4EnS?=
 =?us-ascii?Q?EAY25ReZPKI4GrD5yeVf9cnwOpLEavckZp+EChFp49lrZXxANcLlrUP1um4I?=
 =?us-ascii?Q?wndgjeXyBauineY1lO6ZwBn9ypmoYGKpBN8JUp0E36w5zU0ujThNORooii9d?=
 =?us-ascii?Q?k2yALWKyv9XOqRe0tf76I+IqXVU4tie5s3lQUTsY97WBHUI4oBLHq0PgVuR+?=
 =?us-ascii?Q?JjSBSirb/L2HJjs=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 10:48:13.0147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 709f0f54-ff79-45da-3e16-08dd571c3bcf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5626
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

In some cases in debug it misses the error info.
Fix to update the error structure.

Fixes: 654ebd8cb7a3 ("net/mlx5: support flow table resizing")
Cc: stable@dpdk.org

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow_hw.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index ec047e855e3..1820b79d229 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -3615,7 +3615,8 @@ flow_hw_actions_construct(struct rte_eth_dev *dev,
 
 		mp_segment = mlx5_multi_pattern_segment_find(table, flow->res_idx);
 		if (!mp_segment || !mp_segment->mhdr_action)
-			return -1;
+			return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
+						  NULL, "No modify header action found");
 		rule_acts[pos].action = mp_segment->mhdr_action;
 		/* offset is relative to DR action */
 		rule_acts[pos].modify_header.offset =
@@ -3946,8 +3947,8 @@ flow_hw_actions_construct(struct rte_eth_dev *dev,
 
 error:
 	flow_hw_release_actions(dev, queue, flow);
-	rte_errno = EINVAL;
-	return -rte_errno;
+	return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
+				  NULL, "Action construction failed");
 }
 
 static const struct rte_flow_item *
-- 
2.21.0

