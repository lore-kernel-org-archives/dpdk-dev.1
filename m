Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9ADC282CD
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Mar 2025 13:49:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF6D44027F;
	Mon,  3 Mar 2025 14:49:45 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
 by mails.dpdk.org (Postfix) with ESMTP id 7EB55400D7;
 Mon,  3 Mar 2025 14:49:44 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pMU5VKYoOc+UPEhB5Op8d4gzgQZCX9U3YfKDIrOCqINcYIzivlIb10MvTjJs8QVvNU1iui37Zi3K/DARHsxwRZJgUv+lkgqiQqVO/dV/j8aRkjcQugxaGk88YGyTMWCJ0dsGewUmTjgdg6cILlPoyT49G5wxtxgqyv4xZ6NpBmMbYKnjhIpddz5Kbms+XpLgPgjqg/cKI4GzFiFKdZa0SfoEGDxIAJG/IWNRwHWrQFOu5L253Q+6qf00ipZWafMOl+UkAyPY1/yDz0Mji71+43yrAnsxs10PJcIv5AkIZErF3+LvqGGvGfaj8PvSkWHhYNSzL+4d0At0R5bXlmlHqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0ezHCp4R3f10ruYruaLocRGqggVqLOVzf/cfl9k8fk=;
 b=LhGCEv9fBjofEavh4fjNgM5j7NlmY50517i3psGsYtSK0gmFzoYTti7orRG49PdXGQj+cWT1ebbVXOumJ7jey3aEbVkiUdfU2+dx+raZumgfF9ODh6OmNoKVoDHuNQBGWRfap50tXWb3IhLC4z5qSV5cmp1WVn+4dsrZ1/qCe9fkLNuEl8o3hL1ZtFkilcLSva9d9K/zrp7AXo4pWY6FgKk0Oa++oGhOUwPaJCAPXCYJtZT0hx7+v1FgO4VqrNtYibKSQ40aeoakiKTNosGHBpVVk4d/5shn+0x49Sc7WjFaFs04U2vvPNY83y0YjkKeEyVpJJ7TgBAUfwHfnvHI0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0ezHCp4R3f10ruYruaLocRGqggVqLOVzf/cfl9k8fk=;
 b=pq7E8N37JlIZu+fQ2ELxU2Xk0asBQyYuHJxixh5A4C285ctVjRRHhpRTi2ZFcd6wiv/osZjSxd07xALcH+hxhJdEfgYE4kmbjtiic2teEWC/l49iw5ISDShObbJMYydUxSCij6pTBQYxmI33iNFqRWpHWiizt7kM2uFbuNvNStdemPSDzwpFsHAafnKkPLaoBYegEkr+IZ5M3bZWBafV1G/v7bQ5n/3Pru94rhWanmZN8Ef28+O4TsyXvW0zfdJK2s8PypDpVDjWnMXNyI/cH8Zg9g+Brb4fashf2ec2U+lpHAPF5jAjuAnFFhlFMf6Fil3qLXrypXZAey62CYT6jQ==
Received: from SJ0P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::18)
 by PH7PR12MB9176.namprd12.prod.outlook.com (2603:10b6:510:2e9::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.24; Mon, 3 Mar
 2025 13:49:41 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:a03:41b:cafe::18) by SJ0P220CA0027.outlook.office365.com
 (2603:10b6:a03:41b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.29 via Frontend Transport; Mon,
 3 Mar 2025 13:49:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.4 via Frontend Transport; Mon, 3 Mar 2025 13:49:41 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Mar 2025
 05:49:27 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Mar
 2025 05:49:27 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 3 Mar 2025 05:49:24 -0800
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <dsosnowski@nvidia.com>, <rasland@nvidia.com>,
 "Bing Zhao" <bingz@nvidia.com>, <stable@dpdk.org>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH] net/mlx5: fix using wrong group ID for action translation
Date: Mon, 3 Mar 2025 15:49:20 +0200
Message-ID: <20250303134920.72182-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|PH7PR12MB9176:EE_
X-MS-Office365-Filtering-Correlation-Id: fca47c05-1309-43d6-54ae-08dd5a5a3f87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4O9fF040EVkBle8dEIAkjV5xZYxuLn0isWe1nqhnkgp5/d9B+di1e8LsvzvE?=
 =?us-ascii?Q?VGIbScex35uWkYnG32Wnj15X2cMmTSsFHuaGH53azzqkxzdnRc+2CqBLDIEk?=
 =?us-ascii?Q?jZrorHQevtBnwRihwGXM3wX+icIdMoz0AbJSONz52fcM9z3wRl0HVPiIPzsC?=
 =?us-ascii?Q?bp8mS3RkQ8k2VW+oEE46Ato+jl+YJDPG5AW/n+U9ki3IZwjNbfkJKQRm/JrK?=
 =?us-ascii?Q?lPLjP6YLuHyjt7nEwwW8zhnb8FB7LEHZ1dvfYNQeggv1CPlVsR/vWaBHLKy+?=
 =?us-ascii?Q?1Z/k8LWHPlwUlE+JFdQI/Jm5VlvgvigVFDjB4a1cYeZsl5DmALnXb5hTqcLg?=
 =?us-ascii?Q?ws+XV2FJG9WmpvN1XsxC59/Ox1RfLEyaVKRgM81CI5u0gXRCRqRfw/rENK7g?=
 =?us-ascii?Q?/uahiztKSKjOsPAZMyGp3a8m28v+j1IkyOwW80lDP1uyYMPF7Xg4TKvsuKey?=
 =?us-ascii?Q?r1MMpfmZi19RQwYS/cd8vKh/Fwf9rQpNJVM+PCVCkFDDfGljnhjHZP7gtZFe?=
 =?us-ascii?Q?OBoFGrYUVsz10yD+AWXRrWGI91tuqDO7CpR8lgH8gR2woZjTbN8/+iKyRYw3?=
 =?us-ascii?Q?BcMWlt737TiijA6A4hjZJwkpq93ueYwSxMdOfWfwm/iOgB7DISdwOJQjpS05?=
 =?us-ascii?Q?Z5UahShPqACGguCcWJcC+Ne9E6qdL73tmbo5zyuPBxb+2jG4zFPBYs8eJ+5I?=
 =?us-ascii?Q?Jq0TbGEni9mk4T7MEMN8rMIAzV6Le3Z6PexXe4BrKOC5J/st1zKHQ9cFqSQk?=
 =?us-ascii?Q?zbWerS90dW+xjCyNW5xtjfW+XPLTcEYDYPk4hxSqG1wWcfkaMd6wO8FWhe1E?=
 =?us-ascii?Q?WdUMFenXKRZB9AFQku3+/nCPRIxhKs0IZAjPsALlkp9uvoy7i4S5VC5FNg2t?=
 =?us-ascii?Q?WA5qM5EW7Hg8CQHAHITAl+1LQZtRGP3Gw5WAPBBXtCNSFUH/vNROUOdyUqkB?=
 =?us-ascii?Q?YfYJjGq+CvbslN7rvnAyYuVQjzRU3dHlvtZJDIb94BtfTcplAF3cSiLquTYA?=
 =?us-ascii?Q?nzr1biQJ+evkvUj6+NnhJqBNL/eWlUIPtzbVYcyHDajje4d54HbNDgWGT8SN?=
 =?us-ascii?Q?pPrzNY7aCBRfI9b7KbnJfwVhLZPAVF2WA1/wMcfoydAMjCaLt/2hsr0mFowz?=
 =?us-ascii?Q?ewXSLYUywP69kIpiKu1XOhVrvNsFUMoJ7KYHJQFIoCs1HPuJRizNJupHJyMU?=
 =?us-ascii?Q?fjBnjVrLc4Huh7yTO8HahvoN7iOAmZwiaSm8YqzVxdPS7D+HiTPODNYO9F65?=
 =?us-ascii?Q?VxY4+GfynTXeTTihnamkSOKsoTQLM9XJJvNu57r7KRa96Jf+aRnd+9uzf1QU?=
 =?us-ascii?Q?vc6kKRrDtK9Lx9kG29eavfcfFQC4BkMdjJCo7xKOCV4viRDP53FxmGz5Ms2q?=
 =?us-ascii?Q?9DyEQ53ODj57Uikk1Fj6g50mnpkk6ONBpyQjCV5qsY8cv1P9OP0cp3m4ux+m?=
 =?us-ascii?Q?XMYdx0tTswAwKBCJh0EkQeWwiaPoRoQfGlTzuEPZ5YgCCkNaBk4s9izLQoL1?=
 =?us-ascii?Q?8csa6ZHzZfxkg6Q=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 13:49:41.4618 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fca47c05-1309-43d6-54ae-08dd5a5a3f87
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9176
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

In HWS non-template API, the actual group ID is calculated in the
flow_hw_translate_flow_actions(). This would be set into the dummy
template table for the following usage.

Since __flow_hw_translate_actions_template() is also called for the
dummy action template and some fixed actions' translation. The actual
group ID is also needed to avoid the misuse of actions for 'root'
table. Only the 'group' in the attributes can be used in this
function. The actual group should be set explicitly before calling
it in the non-template API.

Fixes: 27d171b88031 ("net/mlx5: abstract flow action and enable reconfigure")
Cc: stable@dpdk.org

Signed-off-by: Bing Zhao <bingz@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow_hw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 03cbf53f492..93e71192552 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -13825,6 +13825,7 @@ flow_hw_translate_flow_actions(struct rte_eth_dev *dev,
 	table->cfg.external = external;
 	table->nb_action_templates = 1;
 	memcpy(&table->cfg.attr.flow_attr, attr, sizeof(*attr));
+	table->cfg.attr.flow_attr.group = src_group;
 	table->ats[0].action_template = at;
 	ret = __flow_hw_translate_actions_template(dev, &table->cfg, hw_acts, at,
 						   &table->mpctx, true, error);
-- 
2.21.0

