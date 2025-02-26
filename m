Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D028EC021BC
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 08:40:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F72A4065E;
	Wed, 26 Feb 2025 09:40:07 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by mails.dpdk.org (Postfix) with ESMTP id 8AE4F40666
 for <dev@dpdk.org>; Wed, 26 Feb 2025 09:40:04 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uzksSFhT0RFARZIntGwsnDdhy7U5TazpT75qlS2L0ZFzbNS9DtaA9S1W+XW+Yg1IYquuSNPauwqlgq0NWX2xHz+Bf60Gkm6QztMc84QkJbSPD+s/hd78KLzRNXH7uQM/EDOyINMnzGQX1i/xlmsThzDfxi2/Q20eG4Vgmg38xbv+n7RA96HYr0fSErbHOvdWhpqUsSW/kyDtHw/elcDicqTnq9j/63jEZ+Gm59zvZVb8zoW1fcoQyLqcnaBOGh9oWYWiBpvM1+14kgqsGvZg/wKw6IWt7wfVwWXgzHg/jiIqWvpFUW70MffCJY/HC+qz3VwGJY9/1dHWATc4Yh3uxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvYbeiJA2Ul2d2WFH1sPy5oGUnQooAFONfhIZCEFQ8U=;
 b=T+XS14oVtPTtnQPwwVRWkwk8Z2MA9UEuwW+3uC6CYC/E3XmGju/tL/WiOhJ62mSt0886qbue87poEsn5u44QLVnD2V3kFoYZWHO1qGPtcD5LOXkkxn4P+t4m6tp56p38vVOLVimbvS1okb423q2MBJixrqN3BNcXTYb7co4iBDtrhGPklh9wlLh9Z8vad/QYqVxpeK0NFsk5cWAkWl0lJ91WxC5yhlDO3G6oanP4a8por4p4SX5a6Qr8kDHHz/8xwgcpRBOWyUuq9Vf0LnXoUz8HZJAvJfl+gT63eWZ5sINTLp91qaVanBkgAsiCScHI2s0deIl7qAaQyRAOIKn8qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvYbeiJA2Ul2d2WFH1sPy5oGUnQooAFONfhIZCEFQ8U=;
 b=hRWYjHuZ2bJv7PlvtPE/gO/QwBMPRvWACvI0yIHJX/AxpHj1lWxlZVx38v/+vSeYU/9v/ltRo/P2U5gnBGi+/uLjhlqPWLta/ySHs8dqAKGlEYR+FlI9AB5QM5o8AM0QfIVguKiXS9nPztAl1BQMwQy1MSCS4kZ7xh4dhCDqIObmgHnzWhTlXnjomJ0IGAcYR8+k92N2bHK3uPPVzkFefNPgezRpR1dPSAkf6BDackHdVSQUrbjHXVg9+ahEKGRPQdwj19aK2gdofJO9z5jVQggnAOE0Fnv9+sRj3OpOT11032W8bzr1jTr+TpodqOMeGkBUzKmTfcE1HceLZ5fqbQ==
Received: from BN8PR16CA0020.namprd16.prod.outlook.com (2603:10b6:408:4c::33)
 by DS0PR12MB7656.namprd12.prod.outlook.com (2603:10b6:8:11f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 08:39:59 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:4c:cafe::8d) by BN8PR16CA0020.outlook.office365.com
 (2603:10b6:408:4c::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.19 via Frontend Transport; Wed,
 26 Feb 2025 08:39:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 08:39:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Feb
 2025 00:39:40 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 26 Feb
 2025 00:39:37 -0800
From: Ophir Munk <ophirmu@nvidia.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: [PATCH V2 4/4] net/mlx5/hws: allow different types in miss validation
Date: Wed, 26 Feb 2025 10:38:46 +0200
Message-ID: <20250226083846.4023622-5-ophirmu@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250226083846.4023622-1-ophirmu@nvidia.com>
References: <20250225120213.2968616-0-ophirmu@nvidia.com>
 <20250226083846.4023622-1-ophirmu@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|DS0PR12MB7656:EE_
X-MS-Office365-Filtering-Correlation-Id: 714927ad-157e-4b8c-6e5e-08dd564127b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?En/1IrwVdC0UNszFcHFEeVkLGqI7e06nEqQSgoOzWCqSvg8b8m2vUxNzbBxH?=
 =?us-ascii?Q?cTTdhQvQvzgftaN1CN7oMeK7gfCmcYQIqxkOIgrjm4WqCMpmWuCPtDdCKn9X?=
 =?us-ascii?Q?yYVJHm7M5fHqocHwVp5aQUYZBXxMjGkFS/6vTebKJaZZ/G1N7dmKb7j7Dgpr?=
 =?us-ascii?Q?DrRfhRA7iFy55NIHYekm+9AjvLvX0jm6gVGcyDJXQBPE3/gu2nZs4xMhzpdA?=
 =?us-ascii?Q?zfMEB7DKGaMHiwTVnTss0gOguWrh2QupAxF1JPeiIHb9DPuZA0f3wl29yYLA?=
 =?us-ascii?Q?7XQBIV0Mzyztr+lNSyXbC0cZl9xrFpRSJHK9HxX145MOdDnM8tU17hwt9nq8?=
 =?us-ascii?Q?TymSkgE9LgzSrqtp90Xt0ODT20aoz0dBoN1n2JkZsRpKZ/SejwNWpuhQQQlj?=
 =?us-ascii?Q?2LnFTzEL3rWeBrsHg1AeCeMx+bfR3Z2yfYgMkqlgF3HqwwbYu38cFqdZJ+DE?=
 =?us-ascii?Q?BtneesP/GcXWgb2HIr3cMe9PrbGz5RTQUwU7BqbdXUxtqKu3e29qlnWv3oID?=
 =?us-ascii?Q?Ntpk4QXbDKR7ThJSGvb3H0JmenjowHKm38f021lr6i1WT8zLKT6lnMKQ7Q+/?=
 =?us-ascii?Q?Bf1vO6zGIT6/D7kR5C/dbPSqDgrroMwY1EGhY3M58I4R2EBW0/d/mfCnQH4o?=
 =?us-ascii?Q?fBxB6bWLMzjPg8lapV43PrsMlh9fErAktzKTNDy3EUlFB+zu2FzNQPV8Pv6v?=
 =?us-ascii?Q?sEO3HMQ3uxlKCvfnhZ2i+VO+l0+pcYwi+R/5N/ZdBs7CWhLUEv8RMER/V2AJ?=
 =?us-ascii?Q?4lZKyz/fkpu/Bqtd5TDlke29lJ1/GTxZlDglbUUMcV0OmBjAG0DH/2xtJble?=
 =?us-ascii?Q?3aJODyW56b945e32SuV6VVz6QHatwFDIFff/cJ5KvGsWtJiRxG1x4oyXluoc?=
 =?us-ascii?Q?sKIxsIwUDXVxcD3qgOqbyBfWVIe0rct8gdxpq9My/9pfYbgl1m6AQYuidwRb?=
 =?us-ascii?Q?1oNOKVQebAhBvydUmdLK8/Ej17XCIHgHcNuoKvsl3P4aXsN4pmNGyIggqfa1?=
 =?us-ascii?Q?qKVW3j5eli/TexObYt0Zw2BdKJF58CQOwj9Vm/zy4MLCEuCnQyJz+omMYfK2?=
 =?us-ascii?Q?EjS6BcJkfBPRtsjaTl4dpCMmFAYijKQR/SByyEcQxkMivgaYe5u2srzD+YOB?=
 =?us-ascii?Q?uESzN0nU7rEgTiYW2SE6QQoNOyylkRuAvh7DhqmZ9fT+EyMt6toRrhN/SSFh?=
 =?us-ascii?Q?cfKRm7NZOxiFFVnO33dnCopy6X8KMeTMwCEHM0C7niPszBA2m3YX6S/HHwIT?=
 =?us-ascii?Q?jdNvRqKwLD2Zrg5VgGuaMXB1Vypj6NY4rAi6hMWv6ng2al57310MXlXXnP87?=
 =?us-ascii?Q?sjO5Fm9MVzAqO1uQHc8XN9DF9/L5nDJpJx/ym7hwf5Bq7gKaq/d91Q/N/3D2?=
 =?us-ascii?Q?S/SvzfuGQ9bS6h6b/xwCZRbijxrR4Q77TGm/SS8SwxmtP3+8SuZgqOZkrbFW?=
 =?us-ascii?Q?c+/JBx8gDIDzzQAs5eeJ3Sxup0KNlODiKAXmiNOwJ+A6sadBk4vbF9jxOVnn?=
 =?us-ascii?Q?xEf0FqncXgsi9TQ=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 08:39:59.3446 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 714927ad-157e-4b8c-6e5e-08dd564127b4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7656
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

In validating Jump from group A to default miss group B DPDK requests
that both groups types will be identical. In practice jumping from
FDB_UNIFIED to FDB_RX or FDB_TX group types (or vice versa) is allowed.
This commit enables this jumping between the different types.

Fixes: b81f95ca770d ("net/mlx5/hws: support default miss table")

Signed-off-by: Ophir Munk <ophirmu@nvidia.com>
---
 drivers/net/mlx5/hws/mlx5dr_table.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mlx5/hws/mlx5dr_table.c b/drivers/net/mlx5/hws/mlx5dr_table.c
index b371f42..c1c60b4 100644
--- a/drivers/net/mlx5/hws/mlx5dr_table.c
+++ b/drivers/net/mlx5/hws/mlx5dr_table.c
@@ -626,6 +626,19 @@ int mlx5dr_table_connect_to_miss_table(struct mlx5dr_table *src_tbl,
 	return 0;
 }
 
+static bool mlx5dr_table_set_default_miss_valid_types(enum mlx5dr_table_type from,
+						      enum mlx5dr_table_type to)
+{
+	if (from == to ||
+	    ((from == MLX5DR_TABLE_TYPE_FDB_UNIFIED &&
+	     (to == MLX5DR_TABLE_TYPE_FDB_RX || to == MLX5DR_TABLE_TYPE_FDB_TX)) ||
+	     (to == MLX5DR_TABLE_TYPE_FDB_UNIFIED &&
+	     (from == MLX5DR_TABLE_TYPE_FDB_RX || from == MLX5DR_TABLE_TYPE_FDB_TX))))
+		return true;
+
+	return false;
+}
+
 static int mlx5dr_table_set_default_miss_not_valid(struct mlx5dr_table *tbl,
 						   struct mlx5dr_table *miss_tbl)
 {
@@ -637,8 +650,9 @@ static int mlx5dr_table_set_default_miss_not_valid(struct mlx5dr_table *tbl,
 	}
 
 	if (mlx5dr_table_is_root(tbl) ||
-	    (miss_tbl && mlx5dr_table_is_root(miss_tbl)) ||
-	    (miss_tbl && miss_tbl->type != tbl->type)) {
+	    (miss_tbl &&
+	     ((mlx5dr_table_is_root(miss_tbl)) ||
+	     !mlx5dr_table_set_default_miss_valid_types(tbl->type, miss_tbl->type)))) {
 		DR_LOG(ERR, "Invalid arguments");
 		rte_errno = EINVAL;
 		return -rte_errno;
-- 
2.8.4

