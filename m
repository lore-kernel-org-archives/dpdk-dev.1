Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95385C7EE30
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 10:34:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA94C40269;
	Tue,  1 Jul 2025 12:34:07 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by mails.dpdk.org (Postfix) with ESMTP id 35964400D7;
 Tue,  1 Jul 2025 12:34:06 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YbUuwQhjCQRfsglMz5D0UKWVoISMSEnwqB5N7PiZIO6MwoldnnfvCFc98NOUzsPtgJBNbESYOrIJCITBte94/7Kvn36/j+QhELmRgI0XemN4rD0fpVSOcxPcu5oE3lfKpcI40+j8UNQckjyqBpvq3UnxkU8SwEst1ik6lGEDaDcMzzlttZWEk6MMpvGhR+/UpmeTF/6uCve7ofkGJ9ArRcIsPQ2RllckgY3OD4vOIVO5+qZtEKFIMN5iv8q4NRrR+fxe5wWtjKWdpCzQCx6RCUYyetS/PMBqwzkdaOfy2k+71/8NWy4Q7QwSyvhCiXIwcjaTpqn79VsjpqHMYNLK/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKkyRnXXksy8UP+j81PLlH/tZ1lc3aA5jBfWnxUPq3Y=;
 b=Qm2dNBixc1rZIfHPoaIHaBtXcelfTri6gwL7+YJVb4JJV414i9ekwIAe3bYIDDjftdvGveUqsRSYFYprjfJn6x/MUvUNxdK51kAiKhxBpKyoZ43LxQ5RKh7wnSkx01RrpF/qA6LLozs2znPnzQHstp/kEFAyHMT0NvauMTD+NEFR1Gevabf9zvKKHFSSmN8JAsbjDexV1QSDfBQUda/kTKOw9jkxL3Ow+Clf8x0rflpiwwuVRWlGgYHQyxkvjUleMyMo5N0pfb5RMJxwmgai8O6NWSdpefAwVSG4yfT8zGkkBDirdr9U0wWgXVfMrZciUtuvbbKpWZGiyPInUeVa+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKkyRnXXksy8UP+j81PLlH/tZ1lc3aA5jBfWnxUPq3Y=;
 b=oASoDmV0YwTvIqUNkDWsbkF00fXel1Whfnb5V3lliOLQHeR5s9jhRl7OzRN38injYcKt5WDx54eYdf9T+xjmKS7V3MwhUq2OC2oZqF7NhMDD9NXyXgjJv2SAfm0O97W08o70xalHaU2zMS1OTd8uBV4w2qj7Xx61Ni7Sh92vRbkAqExNUZkVY0EJxZO8OSptcLCBaaXCfoQYap8jhM3t68RejCavIV3Ze4Huv3CtUPsJV0UUI+VfmI4zZbQ71WfQhNUNQkKNJrimc83x542tQrnd7zIjeLONa+tDcqJigQkGQxAC7h4jh9bEjwAxlQjgGCvNiq3GkeW3cJMp5PqTiQ==
Received: from SJ0PR13CA0010.namprd13.prod.outlook.com (2603:10b6:a03:2c0::15)
 by IA0PR12MB7556.namprd12.prod.outlook.com (2603:10b6:208:43c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Tue, 1 Jul
 2025 10:34:03 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::28) by SJ0PR13CA0010.outlook.office365.com
 (2603:10b6:a03:2c0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.19 via Frontend Transport; Tue,
 1 Jul 2025 10:34:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 10:34:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 1 Jul 2025
 03:33:44 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 1 Jul
 2025 03:33:41 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Michael Baum
 <michaelba@nvidia.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH] net/mlx5: fix masked indirect age action validation
Date: Tue, 1 Jul 2025 12:32:53 +0200
Message-ID: <20250701103253.318225-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|IA0PR12MB7556:EE_
X-MS-Office365-Filtering-Correlation-Id: aef4cf63-1609-48c6-3653-08ddb88accc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rueWh0rsJvfa60CjVTHAyBZLgPNF9OP4OXj0UhGsojfNrtYhvJ7Ao0BtNujb?=
 =?us-ascii?Q?gsxYMOzszLoZ8LkTTpSFqbRNPo/tNsXmH2vZCU7T9pjSJI8QLuW4joL6y0mC?=
 =?us-ascii?Q?kjGM2ZvWuAAShiStbAEoc7qyPp8sIQU4B1unLneMLF24dFUdDphucsG7QjMU?=
 =?us-ascii?Q?7dTadNR55Rrp7RZfPl9IkWY86P81e+YSllqehq+J49sWn+dVkr7l5QAAyrnd?=
 =?us-ascii?Q?/5ZnPmoMA9GeZNQjUQehJ6Lwk2pUHlCAHx9ORvr0ye+OVuRtOpSChcYuMI8b?=
 =?us-ascii?Q?Ydynxfdnfgj2eXDRNqngy2ie1Z1XP37Eg0oDC/NIaD7yXU3M44fusIg4sMsn?=
 =?us-ascii?Q?jWMYiNi/qdVDihunwZz549YOs2RFCkzOwovl+i9OYqsb9KYXapqhBzw3ACq3?=
 =?us-ascii?Q?a/ynt1HS+z3KbxV7bKRTMQVYE6YOzheyhnKRaqyA8x8lAddwLxyDppU/kdkB?=
 =?us-ascii?Q?Ss/hPiZXd4lLO4Ff1lFNQj+AqmOdqmTcyETQPzkdrlp1nLGcxMjj5jyPUQZQ?=
 =?us-ascii?Q?i43LXKDadxbyH61qmVxjR95YXcTNq1TD8MQa4/xL4GnB84swkn+aHLwOdSJq?=
 =?us-ascii?Q?+uieq8Q9ra7i5OVi5QfK6orODQahSm/iXFmyzFmQcspVs9yrWP9lzB82lTJb?=
 =?us-ascii?Q?vY0tq5rv5hBGu6piT59ZERxmSvraCtpvSbAyHsnb2oBVe5mpNpBKRH/zv/i9?=
 =?us-ascii?Q?sTHWXNcImNZV1PW31EVOJo3lcQENPj2TOjjifcpbG/tkzzzvHeNNCqctlhCC?=
 =?us-ascii?Q?d4P6S5ujnJ8WSw1mUT7MFH3ZwjppZhzWkVNEq2Vko69B0pc4+EhTOGl2njws?=
 =?us-ascii?Q?QDoFa3vvGTeLhZ88cj9ocqDutFHPGG6ZMDK8lWXiH2YCf+/CFzk1KLKIreeQ?=
 =?us-ascii?Q?McignTX7+sYfD96xK5X64LXwUe/6hII0BGugQEDQI2jGSi0ZDNbBeMye32So?=
 =?us-ascii?Q?kMLBTEdCSzXv+FipP6ChE4j1DiNp6rRAuudChcYMPbC5nFGyr5CvX+9Mpqf4?=
 =?us-ascii?Q?y2c2cYhDgcjx1bDAMZwRNpMZzABkY+1bjUxalM/8Qhj2Y0OqwEn+oTjVTXxh?=
 =?us-ascii?Q?/MK6n5b1Lc7aCitTG0hJmyn+910yNXjpa/7nTUGwo3706zx5ooC4g+E1w0WA?=
 =?us-ascii?Q?O+Gw93Kh7uJM5wnvPmOvWTkgJtzWyCKcrOD18S91HkGNOnc7Gkd8uno5A9Nb?=
 =?us-ascii?Q?ou6TE9CrO8lWxuwRRSWk6s/7UKgLA3yrbjdA/TxrWaRsTz7vP3tKpqIUAkPV?=
 =?us-ascii?Q?VScRgQyY2bAfXzNrizTdIeiqD+FdtOmo6NpSpuC+9mA3gPh+0YEPM1G7eu5/?=
 =?us-ascii?Q?EMr5TXIErgKSFaNchIB3UkHk/81+nAq9lVWzG8VAcCgpFaqDNyM0oXTtWazk?=
 =?us-ascii?Q?9BKt0r8zh3abd3orklM7ZEV1HorRo2G+OOtTRAK7K2vVXp9jrwOg6vW5TVMl?=
 =?us-ascii?Q?MGm2Kgk7TEjbYlkGtPBcZrwLCgLGfc5wxc7XT+4hv7p542yqIpqIFMRk5hhz?=
 =?us-ascii?Q?dKgmEkoYa/NlRy6iYakMJ3ZE76EhwstxqxK2?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 10:34:03.5402 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aef4cf63-1609-48c6-3653-08ddb88accc4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7556
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

Masked indirect age flow action is not supported in
actions templates.
Up to this patch, this case was checked only through
debug assertion. As a side effect, in a build without assertions,
this lead to a segfault on the attempt to create
a table using actions template with masked indirect age action.
To prevent the segfault, this patch adds relevant validation
to actions template creation and removes the debug assertion
which now becomes redundant.

Fixes: 04a4de756e14 ("net/mlx5: support flow age action with HWS")
Cc: michaelba@nvidia.com
Cc: stable@dpdk.org

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow_hw.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 4ecc2bacfc..6dc16f80d3 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -1351,10 +1351,6 @@ flow_hw_shared_action_translate(struct rte_eth_dev *dev,
 			return -1;
 		}
 		break;
-	case MLX5_INDIRECT_ACTION_TYPE_AGE:
-		/* Not supported, prevent by validate function. */
-		MLX5_ASSERT(0);
-		break;
 	case MLX5_INDIRECT_ACTION_TYPE_CT:
 		if (flow_hw_ct_compile(dev, MLX5_HW_INV_QUEUE,
 				       idx, &acts->rule_acts[action_dst])) {
@@ -6405,6 +6401,10 @@ flow_hw_validate_action_indirect(struct rte_eth_dev *dev,
 		*action_flags |= MLX5_FLOW_ACTION_INDIRECT_COUNT;
 		break;
 	case RTE_FLOW_ACTION_TYPE_AGE:
+		if (action->conf && mask->conf)
+			return rte_flow_error_set(error, ENOTSUP, RTE_FLOW_ERROR_TYPE_ACTION,
+						  action,
+						  "Fixed indirect age action is not supported");
 		ret = flow_hw_validate_action_age(dev, action, *action_flags,
 						  *fixed_cnt, error);
 		if (ret < 0)
--
2.39.5

