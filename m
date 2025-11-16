Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077B0CD4F3E
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Nov 2025 11:59:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F38EA40E24;
	Sun, 16 Nov 2025 12:59:41 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011027.outbound.protection.outlook.com [52.101.52.27])
 by mails.dpdk.org (Postfix) with ESMTP id 0D7FA40648;
 Sun, 16 Nov 2025 12:59:40 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0+8v2BETEss/eOJ2x5glWxDPFg6PeBOkGDzzf27x0REj0WOReK0bGmtHjg7/PTq3FomGaU721c+MjG4c8/ci29RtpKX78wnNwoVIdv8sBu3kAZdIejUlw4FsYzFybtZPQcoWjU97gvQY5M/DTejuLQMgJyDxh+er0Ug2nrLrNXPVBV1KH9L8gZcKOfGY/h6m9CbC7HxFmpVYIKtI8O8o9A29Wn3zUbhKmfmf3Hk6c+UdriD+hJ+cYRzVqu7HardOB5cW8J7kwOnc1mMU+Hljd0CQ31c7TpEau7oCQDnaS7qyQMcsIx7M+Dc5aZsETKGRWMkY9QGwiMuRXKyW/q+KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/b2aAM3TZ0kxiPPBnyuESqKK4G2RWBoFSI0ShSSt/w=;
 b=AKY0MiRhR6vNbURZjwifzz/242ZW6deoPNcn7Hdq/Dgnw1U/qCXaqh1PNGc4/JAF0HPcp83bU2/5b7Qzna91WucAzJgOxxvc4f4zlbwHGczvZL/cCjLzFw2q5VsvLKG2dLoyyBizms+yVFrRx1NNKTGqJGMuTXREGBYvpWBdJsL8I8SxC4Ff9Oiaou3qSxI4FVBCvPrvSgdmZx4OZ8IlOaqu5GkjK+KxiYhQ/07vZfoKB1wWNzMfARXrrmytaGDHy2uwnJw+ffFUz8ShVT7BfVxA2bHq8HWr62ITBIKc2LezidihzKnSqj5tt249ujxsCN3fem7hsEUhQpwPjXiR0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/b2aAM3TZ0kxiPPBnyuESqKK4G2RWBoFSI0ShSSt/w=;
 b=hlmW0FgC5jtGqXWMgQbJrLYUTHKBQgjFrb/6BXcRPjHrNW4CUf9H9hwTmHPLSlM6j89SuVklU9WvfIhZiVq4wD5FUJsvYal9NmLOnESN5oXaZ47z/UGG2ITxfZvpiMbrznTLFwBI7Lox0zVmx62EhivylBboLZlwFggDAOPu+WfZLi/RpDwR1kpTJriqjKyT6jdieTu/+P3yDVdj8IhlbTqiDoHG+lf2rKLHXMQtVSMx8yf6+QwwuWdxsQ6wYWfkgU5mBOYaL2M6wnY6UbYGxtgBK2aVxicCOauUH+o9Im/nXqJ+0IOCdNldLD1EODBLaHJPFS8iQLvZ8VSPvKOmdg==
Received: from CH0PR03CA0384.namprd03.prod.outlook.com (2603:10b6:610:119::26)
 by BL4PR12MB9477.namprd12.prod.outlook.com (2603:10b6:208:58d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Sun, 16 Nov
 2025 11:59:37 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::59) by CH0PR03CA0384.outlook.office365.com
 (2603:10b6:610:119::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.20 via Frontend Transport; Sun,
 16 Nov 2025 11:59:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Sun, 16 Nov 2025 11:59:36 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 03:59:35 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 16 Nov 2025 03:59:34 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 16 Nov 2025 03:59:31 -0800
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <rasland@nvidia.com>, Itamar Gozlan
 <igozlan@nvidia.com>, <stable@dpdk.org>, Bing Zhao <bingz@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH] net/mlx5/hws: fix cap check for hash calc
Date: Sun, 16 Nov 2025 13:59:25 +0200
Message-ID: <20251116115925.158944-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|BL4PR12MB9477:EE_
X-MS-Office365-Filtering-Correlation-Id: 696548f0-53c3-4fc1-aa10-08de25079d89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Pzc7ZCac+2vucwg1f4zklSiAUdojllAW7pxRQSzHsqc6bzLPoSrKFbyvcDfM?=
 =?us-ascii?Q?XGF2No5HnRrOuXTDM2eitPfM8VA50Q37AZX9NEQX/a8o2tsrlf6XRiN/GJf5?=
 =?us-ascii?Q?WYAtfgogjXSgKPyst8gkclvp1KH57T8l9jGcz7i/IiCcRvpgvhb5iNebdkfB?=
 =?us-ascii?Q?jHAIxkPwE3G9zZ+JHtOKw351EiAKOrGsXEXhDgncthhotJW70B2axUpO7rmY?=
 =?us-ascii?Q?2GjvquK8pWqv+HC9MkSWMLgd2shcVI2wTd6xO6czwkvhbR9XLxu7/VfJ7ibw?=
 =?us-ascii?Q?KWtur0A9QtNX6RN9uWDsAwBbDA/0b1mklQ13ICprZcxOj7dUUTez5bFTDDK2?=
 =?us-ascii?Q?+ATDmX47Q3bm1P9abT7A4TpQPHKejS2LRBm/2ExOJBjhMhsnppegDnJC0p+Z?=
 =?us-ascii?Q?q7uf6JIJYcNGAC/7qBMADQjRiUB2TP0mCdqQd0PR7FAIL+aI9vDShG+sKoNS?=
 =?us-ascii?Q?ny7ChBr4/rTJ58h4wbD4MEGjLnzMglA63idmQZblesbNGFTy8AUsTq12JJii?=
 =?us-ascii?Q?FZX/Rlpb3Z/raG4tDE8z1/6OcrzEmiYvni0yg9TPqF4G+lM9N4ZlwM7cDLWM?=
 =?us-ascii?Q?03p+gOAZ3tsYwrXyCfCn819YDOYHOo0m7gwSIyWkCJWNFL2vWZTcX1AEvKI5?=
 =?us-ascii?Q?2TBnomAcsk750cSYYJ+lRCzTE9JrexKYKF5HEaPJ1TtPerhMIUQfycobIcjR?=
 =?us-ascii?Q?BOVg6sbuUAorgROBvy6cSApCw0EAr70yDF8icGuPNJPQD62ZGUaFzbUe1Z3F?=
 =?us-ascii?Q?peKqMT42fiwR4hRoSKYnpBWAzrXufeJMpCDDo4wK/dL+xbvp9lTqtQSnr8fU?=
 =?us-ascii?Q?PKvXP7zcjf5ZcvR438WKkMKDTRGxkn2G2c6VAnBmws4/7gzhu2vPQ6m+OQ6e?=
 =?us-ascii?Q?rInJ4Ql/Fth3RnDZ7gheH5wgy9tzbueQKyyjJyvU8YqEPrLjuVAqEYBY1f3R?=
 =?us-ascii?Q?xlKmD3UctJTj0ZaVW9ceCly3K4ocBZeVqMethbvDObi9YuJE1kHVtrmu2ATT?=
 =?us-ascii?Q?NvVtPlM5ypKzPpZz0RSGJBqFae/IB48/nT4JmNbIwmgE/QQ1bb5EwFdGIoCR?=
 =?us-ascii?Q?S4Csd1OllTrGt3mhb1tPMI/LsfJvmmS0XSOie5i6mykLkgU+YcVghV5vvBoJ?=
 =?us-ascii?Q?+jAFFb45cBy79n/7s2ov9lRBVYETUoD6qXUK/PtFPADD7xK3Pi51YeOQ07Oy?=
 =?us-ascii?Q?Dx3MPLTp9wBxXmcKkdZVY9xCUqztiK9zHY1xhk3LCbw+yHerj/4yCSUaXjIo?=
 =?us-ascii?Q?DiKavMJILDxDAzyAU9Tp+RBK51BO7VuzCJ4n5YO6Yjoja6xjFhW9pBw6YFYR?=
 =?us-ascii?Q?Mr31yifi7RbOVvHBymGds0+BSF0G62p2qbrDu7zjdo8MkLxek1XVIDS/SIvl?=
 =?us-ascii?Q?DrT7qrcE75j44JL2bQgNWGHD21MGH0Qr80iZsvYhfutKFMB+irWW4BTndS+a?=
 =?us-ascii?Q?lMQM0PX7PALIwLZGkecDkVcCbf2NFBluDtNM5WuLSikGxg+oQdnv1ZuSDnC/?=
 =?us-ascii?Q?XLAyx/NUlMWEAz3pAtH47Cl/1FNu3F2Hlh4v4ngMH3M8VS02USJk8r5/1Nq/?=
 =?us-ascii?Q?Rrv3sQMzo1JHfaok6jE=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2025 11:59:36.9858 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 696548f0-53c3-4fc1-aa10-08de25079d89
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9477
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

From: Itamar Gozlan <igozlan@nvidia.com>

Some cases are not supported for rule hash calculation. For example
when the matcher defined as FW matcher, or is the hash type is different
than CRC32. One case is when the distribute mode is not by hash, the
previous condition checked a wrong capability, while this commit fixes
it to the correct check.

Fixes: 7f5e6de53aae ("net/mlx5/hws: query flow rule hash")
Cc: stable@dpdk.org

Signed-off-by: Itamar Gozlan <igozlan@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/hws/mlx5dr_rule.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mlx5/hws/mlx5dr_rule.c b/drivers/net/mlx5/hws/mlx5dr_rule.c
index 878224d8b3f..895ac858eca 100644
--- a/drivers/net/mlx5/hws/mlx5dr_rule.c
+++ b/drivers/net/mlx5/hws/mlx5dr_rule.c
@@ -1084,7 +1084,7 @@ int mlx5dr_rule_hash_calculate(struct mlx5dr_matcher *matcher,
 
 	if (mlx5dr_matcher_req_fw_wqe(matcher) ||
 	    mlx5dr_table_is_root(matcher->tbl) ||
-	    matcher->tbl->ctx->caps->access_index_mode == MLX5DR_MATCHER_INSERT_BY_HASH ||
+	    matcher->attr.distribute_mode != MLX5DR_MATCHER_DISTRIBUTE_BY_HASH ||
 	    matcher->tbl->ctx->caps->flow_table_hash_type != MLX5_FLOW_TABLE_HASH_TYPE_CRC32) {
 		DR_LOG(DEBUG, "Matcher is not supported");
 		rte_errno = ENOTSUP;
-- 
2.21.0

