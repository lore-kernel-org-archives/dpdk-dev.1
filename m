Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7BACEACC9
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 20:07:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD7B740E54;
	Fri, 14 Nov 2025 21:07:18 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011024.outbound.protection.outlook.com [52.101.62.24])
 by mails.dpdk.org (Postfix) with ESMTP id 9C20A40E34
 for <dev@dpdk.org>; Fri, 14 Nov 2025 21:07:17 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dCfQyFoHWd0Oe6S7az0ijSFQpNoYyysoTL73cyAxxGFfimMMFK+qXzJYG3QSVMAst/0COsaM5rNXcNsNH61CO5a17GTNuxYLciNiVVV0wEOIcOShXrhmg019n6/cHjzukKanJmGx00jX4B0M32jBdNFoEaFYbyb+X2b7ddHaXeaXibKuKSrX++h5EUsXbwAC5r8IqH+I7XTRqP5fcYiYH6RiO9Q24K++axtimTnrlXCKazpF0eCcX7x/OKAfRX1kn77FjeUGxeiWmV3NwATshkx1xEKadurQz7k0EO08IYG1QOEVwlyxy15GXbt14v9WfgChSglkGtRoEXJhgGCRvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNW4ZHvIFQcsXKBrLp3+F30saEoZX5FDNv+ER7jJng8=;
 b=IQj2CuWJnSg8yyqTdxX1kyfq4MRpBlYYU1fnANE1N0w7haBXGQH+no0BxFKq/M2thacyf30DCbv6nFTcPJ0ixejiuA5bxfEIU8NwkakXCHGqiuPPaH3+FN99SlW+D7YRgl31Yqf+LH+4WLIL0NJyZZFxZY8Jbq48rVqKiKQpP9EPiMHBS19rCzzG6ZO7ONO/rLFpNrYMS1FKHf2yFRQ78K8YH0ySvOc7mPBfg0EIIhaVVXXn18kHh7ufAmFbA8RMJ3fXgjyJzZW4DTOdAKLrfVs0XOD9kE4h+rS9iFCWZTFZwjKQ6TPbALWLzHRv0Ea2MbVeU/lGlMx8dQLqRnbUig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNW4ZHvIFQcsXKBrLp3+F30saEoZX5FDNv+ER7jJng8=;
 b=Lk6c0J9mFXTdCmR2KPFxRU6WSzyWWKLTML07KsnN8rpA2XJEq3ZNSKEG9pOW8SoL6Y6j7j0s4tYkMNSJ/fXGQSI2JVTJHPreHkF74DcZ9aCTsGAfVDa7J2AZCeqBISl4Tu3HZKcWvsTl6vDHOVxJexI4yzOTuCqRY+XTiajdKbG4aE/7helgSK7Mw7xU35NiylkqMzpvTiba8WcEzfjIRdV9mKSNBGArvw0rxEL32pV95Jp+PCST9Jn41YztGSACOdf+TrKuIdNowmsVR1Puw/Te0rT990nNP5t5LCTn2gQTSEenGqGA0z2D+1LFvpQDDh7G+JAkwtuTA8F68R/uUQ==
Received: from BY5PR03CA0019.namprd03.prod.outlook.com (2603:10b6:a03:1e0::29)
 by BN3PR12MB9570.namprd12.prod.outlook.com (2603:10b6:408:2ca::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Fri, 14 Nov
 2025 20:07:14 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::52) by BY5PR03CA0019.outlook.office365.com
 (2603:10b6:a03:1e0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Fri,
 14 Nov 2025 20:07:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 20:07:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 14 Nov
 2025 12:06:54 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 14 Nov
 2025 12:06:53 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>, Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2] devtools: ignore new warnings on reported-by tag
Date: Fri, 14 Nov 2025 21:06:40 +0100
Message-ID: <20251114200640.1639056-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|BN3PR12MB9570:EE_
X-MS-Office365-Filtering-Correlation-Id: 21effda8-853c-4984-e142-08de23b9663b
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m5qL9mltQvjz7KK4co86urkM1Nuul5fWfo2Keci5VTzZb4S5UeOT0PzIsNPX?=
 =?us-ascii?Q?7oZ0WG1mmC4h2UXUttkmTGLS2PYDGXtOtP6QfERCqt9L2wPl7BgYUypWMM97?=
 =?us-ascii?Q?2SfH4ygfIpn3xoLX+V9Fg/oF1ub0aarvhi0a92eA6pFiTJglGsVsUG09pc6J?=
 =?us-ascii?Q?UoTfUYDoJawrq+DMfsYNRGIt8U0lWLFeGkbuvDa+CtPsR8BHQqgFubPV2I7X?=
 =?us-ascii?Q?PkzzEwaK5Fz5E+3R6bRifLTlMQtBqxZN8RnVsANbCXEsVhu4BE+tg3z8HK/R?=
 =?us-ascii?Q?qTGZ731neIS0slDydUB5rj/v9ymIUiQHBs8zixhQfb84U9xZuCANEMkLgqCk?=
 =?us-ascii?Q?9vGgl7Fq/yZi3mjouXMMXvIjB4SHJQJkXjFIlE5D8Imx44FHQk1bjsQfmprz?=
 =?us-ascii?Q?RVfLZzo6dVMaSpZAic2Zt0QPXRLfxVE9cRbbYkPTKTzuSeptEM1sAZWL/1wk?=
 =?us-ascii?Q?CE19A9jzB5f//flujb+UBGBzVyzUJUMHu/Gr2MVHG9wuIYa/dE5C8K3ryQBY?=
 =?us-ascii?Q?Jct7AW6yzBkUmoSBjbPJu6jubyxtmF5J59oNOUtX1rmdqZoKknyY+WdF/heq?=
 =?us-ascii?Q?PPuZAY87LJCbNeHUu9T2hDLQVp1gCsj2zza9AyWIGRjfsQu5no9nQICj6xzy?=
 =?us-ascii?Q?WiTkLuJbx4M4kz4ZhZrXyxmC94wt3mehLh/s1NjAK0ql2OBlKD04OkWmzvy4?=
 =?us-ascii?Q?d5pH54NQUp6k+86JW7YwplpNyxW4M5Obxq+n46sLyw+cXvnoGhUiSYhFb7Hj?=
 =?us-ascii?Q?7PK9IjH8gC2f+YrahmJhLVo+Pd1VHjJ8mrqyOqV+1GUE/Vx8znqJ+agf0xi+?=
 =?us-ascii?Q?aaAypHByWFoY7ejW2ZEUiYN4ZEiup97LY6BNgpEtKg6gTFegyYXOpWhjdPOz?=
 =?us-ascii?Q?Kos7FhiqZB0OT1BsdHQk0dwr2vc8cp5wBm/2TQuFzfAyR3ya41Cl4Ie4PBSD?=
 =?us-ascii?Q?EYJY+gEH6eemjfL0goPrt8EuuV+hDKM2YrQONF2z+gtweAxTAVvHythJtkiM?=
 =?us-ascii?Q?SGsYjnBU/emKCIbuvhh/+nLakPcbQOyUkazcsVTBfNwgG6vJMRItHqtQIlWH?=
 =?us-ascii?Q?YvBa3iQ58TmXgyb6IM7BhiwKFskYS5iee5welb7LhItGsDai0kAjNEjFFFhZ?=
 =?us-ascii?Q?a6KkphD8e5P6rSf4iTCF4qtgiBkRmG+b+3Yqkx6Bs29ssbB9wJJ/15ZZflH6?=
 =?us-ascii?Q?lF0RQsYP/3JhvXoVIyfKUSt1CTYTL2odpgcKf+BxebkOxlZTOMRKhY1uWZ8e?=
 =?us-ascii?Q?SOhoemkhaaZP3zJ/zJmM0aFGQUhZeH/hqUR00t/i/+wiCXtjiriFlGD8VJdN?=
 =?us-ascii?Q?1XkRpr+NFLBehGN3VNiIFe1L8SgkbtZ9fQEYgZ+EVfWbrnhNpbSq9TR+2nlP?=
 =?us-ascii?Q?u1/r0vCXLsaYx/UhOk8gVxPxO83l/WshhgSVfirZsvs5WVlFgS6SO+CP5W7c?=
 =?us-ascii?Q?EQ9xcwQRs1ks8vmDA4JBbK1MkDr1OrAtgvy1hBLGGY5Kd6F6Yt4AVUudut4d?=
 =?us-ascii?Q?klUt/z2KSJ3KXly6hIa0fXP9v82w3PdJv2F0sTxf7uP5J+lndSpqwBji44SC?=
 =?us-ascii?Q?41yprXXeO6vDsJmqebX0FD5NDq97QcsH1YOak+rq?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 20:07:12.3957 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21effda8-853c-4984-e142-08de23b9663b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9570
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

There were 2 changes introduced in checkpatch.pl script [1][2]
which verify if Reported-by tag is followed by Link or Closes tag.
Example of the warning output:

    WARNING:BAD_REPORTED_BY_LINK:
      Reported-by: should be immediately followed by Closes:
      with a URL to the report

Original purpose is to link the patch to the mailing list discussion
and/or a bug report.

Since Link and Closes tag are not mandated in commit messages
where Reported-by tag is used, the warning about lack of Link/Closes
tags can be suppressed.

[1]: https://github.com/torvalds/linux/commit/d7f1d71e5ef630ab9e15b5821d297a9e1a5fa1da
[2]: https://github.com/torvalds/linux/commit/44c31888098a590b8ec5ba37009e5a983f7c4b46

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
v2:
- Rebased on top of latest commit in main branch.
- Reworded the commit message

 devtools/checkpatches.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/devtools/checkpatches.sh b/devtools/checkpatches.sh
index 9fb8fd0a07..614cd7c32b 100755
--- a/devtools/checkpatches.sh
+++ b/devtools/checkpatches.sh
@@ -33,7 +33,7 @@ VOLATILE,PREFER_PACKED,PREFER_ALIGNED,PREFER_PRINTF,STRLCPY,\
 PREFER_KERNEL_TYPES,PREFER_FALLTHROUGH,BIT_MACRO,CONST_STRUCT,\
 SPLIT_STRING,LONG_LINE_STRING,C99_COMMENT_TOLERANCE,\
 LINE_SPACING,PARENTHESIS_ALIGNMENT,NETWORKING_BLOCK_COMMENT_STYLE,\
-NEW_TYPEDEFS,COMPARISON_TO_NULL,AVOID_BUG,EXPORT_SYMBOL"
+NEW_TYPEDEFS,COMPARISON_TO_NULL,AVOID_BUG,EXPORT_SYMBOL,BAD_REPORTED_BY_LINK"
 options="$options $DPDK_CHECKPATCH_OPTIONS"

 print_usage () {
--
2.39.5

