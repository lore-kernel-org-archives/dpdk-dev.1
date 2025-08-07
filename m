Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C4CC87FCF
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 09:13:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B9095402AF;
	Thu,  7 Aug 2025 11:13:06 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by mails.dpdk.org (Postfix) with ESMTP id 3B0DA402AA;
 Thu,  7 Aug 2025 11:13:05 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uwJJ9t7hr518SLErKXYeIrxJtv/720X4F8fP0mdI9ieo3v7CF7f3gx0mz1TPTNsQnMqRWeYXk5q4xHg224/kzWibgVYsjJuECvJEoRpnmGZjh6HoHhFj3SyE8lYqqqsB1znXydSrXg9QnzQODiubIsNAr2l5hSODbngAUBV8rlxG/kAvRblIJSyqWY6frdFkqF18cXg/wFhmAdV6j8fNbcgkn884MjFDnihpjN9Bu4t3qocZMcDm8F8/+ALDZOU+LM7MYlTJNgRro2VfRM9k171I4mKQS9vsgOjNXr3FmSxuoDc2fiQznZdefPvbemWfzzrb6nD3FGFpx4TwBnhVJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5I1J/QsSpKNQKE3jVkbL1tWL72QMRvmV1nAGQnBE5k=;
 b=g/fOfRnGmuIW3NOYkdYbgv/x19ycXFM6bMNTDXNEZvC3fIv+txwnaEL4t1WF7ium8MLuczreGEvPDx+cLXN/RpzFNzmLecdYYGN447VNl2A4ZSL6jCu7l0ruE87K4MEN84epUncMG2fbqV/WVtiEsB5cL/L/+qacBQ0H4zrKPz2GQwHLZn4ycKrhV+nG0Y2Qll0T+dvT8si6FaFNmHJ0xgGXa7pjmDj0c1PZbnIOk4yB9kmOFHThu+rGjgIDI2kA2W+0c9eP/seH1ahnxBRuMj4DRrLPO74+jZ1SR5q9hIe72++ObhY4fgR5CULoYC5Ju4HBP56ocpvbOZNnKHtSaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5I1J/QsSpKNQKE3jVkbL1tWL72QMRvmV1nAGQnBE5k=;
 b=tjeyqajX+pCRiKYJh3ZbVAnLnYTbV8X4+OmNrVwCXCg1gmA+JN3pJV1BeS2rWC/HHNNTZsX4JlGTE2QQldTJcJbuQzDITz9qlxXwC7WBqeA+NgszMLvK/ZkqHZlspyax40nTMpfI/fIEHN6466caZIPjgQHMSKrkg6DMohFmN0C7yeyySsn6mI2OmP3Pw55507kr+8bf6h8RFDeoGMaOwvoztLG5LNITdly1wy7OHTGHOWi9sjOmUnraR5579MzSUmcHn1aUvymrmM3Ri91OBUbadL8gSCrME+t1v2BOOw2Yt01+oKbQLhlCrc57UoLmnenECG5ovinHdjVN8KbJZw==
Received: from MN2PR05CA0006.namprd05.prod.outlook.com (2603:10b6:208:c0::19)
 by PH7PR12MB7281.namprd12.prod.outlook.com (2603:10b6:510:208::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Thu, 7 Aug
 2025 09:13:00 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:208:c0:cafe::b5) by MN2PR05CA0006.outlook.office365.com
 (2603:10b6:208:c0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.6 via Frontend Transport; Thu, 7
 Aug 2025 09:13:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.8 via Frontend Transport; Thu, 7 Aug 2025 09:12:59 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 7 Aug
 2025 02:12:53 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 7 Aug 2025 02:12:52 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 7 Aug 2025 02:12:50 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <rasland@nvidia.com>, <stable@dpdk.org>, "Dariusz
 Sosnowski" <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH] net/mlx5: fix unsupported port ID action
Date: Thu, 7 Aug 2025 12:12:47 +0300
Message-ID: <20250807091247.155266-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|PH7PR12MB7281:EE_
X-MS-Office365-Filtering-Correlation-Id: e50ba87c-25fd-4d32-afa0-08ddd5929b10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z916drrxSg1fhloXyZ+nlsjj3pwXUiyryRe78UGKxn0H5eXqkZwvhoFxfWDK?=
 =?us-ascii?Q?8LVabtp8Ypf4zEGetiYJsISFCUCodcsahCd6sKfZV9Kdh3kRq4ZR7oKZlEBu?=
 =?us-ascii?Q?Z9JC4gssET4vggiqHHhhwsq05MfTSnYA6X0AYI2Yc5SYr8S2GDBxbGI+mtqh?=
 =?us-ascii?Q?PIcrBDks07qDfccI0mcFStY14xooYYpCPetlgh08UmYWHxVdR6vqBM5BL6fj?=
 =?us-ascii?Q?p7i40V80fTUU+13N3Pn7c6vYpsnovD9oTziuq4a6osmL7+/opUGOZelKlXiy?=
 =?us-ascii?Q?v3OKDvWjsmV4wDQco2AY7+/hH0zk5XTJqfBqOuzG1TPchKUOvKXzq6axve+7?=
 =?us-ascii?Q?jq0YJH/0PIwbHoJWvL3jFpLdXe9nXQSmDBPfM/5gKCcb5zsOgnH6JKU5qKR3?=
 =?us-ascii?Q?qgzZdRb4AL4CVTLjEnsW8EL04+O1ak8S8jZaU3E5AGks1Xyx/IwcjZQSEc2q?=
 =?us-ascii?Q?5E3TsTWkSYnuKAT76lkWTqEtbQcMwNRhxkkdpbcPeT2YXBPpQizR+rxxx5Wx?=
 =?us-ascii?Q?Hr5PZM5ftoy1kTSM29tljldHm04W/OPBJ5EIn6tHB/TOTo0ofoUZiLTPqYMc?=
 =?us-ascii?Q?AVX6wo2Ev0Cqyp8axkgbw5xpNunIMVUE9OwslXIYJjQLfS/4XE/Gw2ucw57P?=
 =?us-ascii?Q?O+xJxqQ81AejUhn4cHjJHHiMjdx0TyZHkm3khDdU0swNUHn15GwqwRifFGtG?=
 =?us-ascii?Q?JqUkUXo2W9TURVeAqWzDQhgBfBUltXcn1RLwWjsEe+0evcL8LSPdTRVIHwUX?=
 =?us-ascii?Q?4yf+VjChI5B9K+CXEpZJzDX/EFui9UigOey90Nn+eulMAZi31ZS1GF2k124R?=
 =?us-ascii?Q?AlBaM6hwHLc3D0x8l7c52ZDVGtJtaygC4lxx1dx2EYFihs87hmL5wrZZxiO7?=
 =?us-ascii?Q?rLCk7tQddSbkWqT7wiRd7HEzykqafzEZtJEFF4jaqXAnY88EsAHQf7ItosKz?=
 =?us-ascii?Q?r/OXfe68sNHzwUAWLEiEj0T9a6As4G6ijYuSkQd19ug3nJhoOUCXkhxJOaN+?=
 =?us-ascii?Q?BS3rkQbKKYb1q/eWe25GnAblul1khMiUU4I1/xll1hDsp0rrclYiDlYgQ5ul?=
 =?us-ascii?Q?wvvgkURNu7JyGJWirAXbZaONjqJ4TKpSQeYFy9HnYtEMFcR3CyBkeY5R+rsm?=
 =?us-ascii?Q?BYiT14vYC22sC17alN1gzPgLPWqaw1jIuzhn2WOnFTL6DrSR0ZK4VDCSYne5?=
 =?us-ascii?Q?xMFbsbAY2shBQ3kBZOJhpLfLdhMztwgHXw3V/L0XrwPoNkAd7HRR0MJ7d7j4?=
 =?us-ascii?Q?h/03j5opL1gB5SwWAMpdy0jk0zNU82HHVBVATJxtNeS5Rcs6DgohtB5smx9P?=
 =?us-ascii?Q?Qu6Bw/w6s8eAzHifAwRIo0bVHtv5UkLe1DoK2L7HKnIrzfO0+Mymx0uFCqKu?=
 =?us-ascii?Q?fq8AwxcH8eSli3gXkbd3bOyjgL0p99g4HzT8Dn7aTzYTOWfAWwIpnGO6O39O?=
 =?us-ascii?Q?2d845FuWLAxcYKBN7HNQwapGby78exTz6ykRwzPBq47mNGdr3GvdfqrjqljW?=
 =?us-ascii?Q?i1pj3LPClx2azZpweUPrgXV7vxHeixCyDB4N?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 09:12:59.8310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e50ba87c-25fd-4d32-afa0-08ddd5929b10
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7281
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

When dv_flow_en=2, the port ID action is not supported.
Although a rule can be created successfully in non-template mode,
the specified action will be silently ignored and not applied.

To prevent this ambiguous behavior, explicitly return an error
when a port ID action is used with dv_flow_en=2,
and recommend using a represented port action instead.

Fixes: f1fecffa88df ("net/mlx5: support Direct Rules action template API")
Cc: stable@dpdk.org

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow_hw.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 6dc16f80d32..58d4882cb96 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -2913,6 +2913,10 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 		case RTE_FLOW_ACTION_TYPE_END:
 			actions_end = true;
 			break;
+		case RTE_FLOW_ACTION_TYPE_PORT_ID:
+			DRV_LOG(ERR, "RTE_FLOW_ACTION_TYPE_PORT_ID action is not supported. "
+				"Use RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT instead.");
+			goto err;
 		default:
 			break;
 		}
@@ -7644,7 +7648,11 @@ flow_hw_parse_flow_actions_to_dr_actions(struct rte_eth_dev *dev,
 		case MLX5_RTE_FLOW_ACTION_TYPE_MIRROR:
 			at->dr_off[i] = curr_off;
 			action_types[curr_off++] = MLX5DR_ACTION_TYP_DEST_ARRAY;
-				break;
+			break;
+		case RTE_FLOW_ACTION_TYPE_PORT_ID:
+			DRV_LOG(ERR, "RTE_FLOW_ACTION_TYPE_PORT_ID action is not supported. "
+				"Use RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT instead.");
+			return -EINVAL;
 		default:
 			type = mlx5_hw_dr_action_types[at->actions[i].type];
 			at->dr_off[i] = curr_off;
-- 
2.21.0

