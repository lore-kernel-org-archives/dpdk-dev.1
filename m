Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57DCC28B2E
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 09:01:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D017A40263;
	Tue, 11 Mar 2025 10:01:45 +0100 (CET)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2078.outbound.protection.outlook.com [40.107.95.78])
 by mails.dpdk.org (Postfix) with ESMTP id E9D0B40261;
 Tue, 11 Mar 2025 10:01:43 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o5TItvB0BsHKkbtN8jkSie3tZrVt1U1BVdZ7zR6PeENiVErb4000ZH3D1g73KCgl1B17ONX+g7ssVrxxf39lFXScNaxEVz+sxOEF02J9H57l6sZMeyfS+utg39hByEjfFP4un6yYm2yi0eVJCcqyCPLQlgIohw4tWNgUtwwYVk5UkG9mX5B4Wz1hd0CrA9op0qrIlm8uG8Cxlvam8Leu0MW3aPhxGrJ4NZvlVnlFRsovyVX/w2E/eDIj6mjyf7yupSar8V7+H3DBSYQTW24JF3KqjkNkOjpOZFvN8VjtRemJrrjP/Gl4+xb+ReWWaz1RBK+kgLHGgp9rMkeFAd/YOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJ+jXj/EzRl0bJfHE4OWR0G89ZTf9yQIea0s9zxY1rI=;
 b=Z24L8SiBx7jqkAhPbYYLG88dIXithg2IjGbAPaGcRYMtb22I7i16/NrtauDU/fpwoJFgRWwII40ydMG5pPxtx8Eam9j/81cyngPJHLZ8XjOjpRmNyMH43TJXyEKMlxapkFe20yDdx9fR99K5nVuba6SCVMpkyTujoyljpx1lebApY4r4vOPhqXLVU1ixD9M2xppGaVG01Ufo2JRWvleXx1gpaXn5lPM5cK6wZKtU624LNQompyOdPNpPIKAiXWZdGdvzAGSr3PetuRcMr+Q8Hq4Vy2//BGYTgZaziIYyFttNfVbZT1xfK7BUA1dII0NDmo8/m/qCl6ciwV/A3+xEVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJ+jXj/EzRl0bJfHE4OWR0G89ZTf9yQIea0s9zxY1rI=;
 b=Rjfb7DzSd7JlUdRVSsm4CGa/alQwIi6n+axFkcPibUmw2TUmr0K1zecY0HYcKiSvJRqNvxueJcs+8eP/MnYZHlr5k4qaFJDw5g3SBT0Qg1pVqrtYZbBfMjN4Kzb1SDnKGQMAtZ7a4/DrddzI3qfY+CVpbD31ej9n2G6JT4mkFHjUdH+UVu8Jo/4ybNVb8eQaD5EPt+OhlFdFGELyAw5sFg30lxEmwtD0B7a+uxgbe3Bgugoahso43RrLUXyjowTRNyVlM1YfTacJHQPYrjMT/bvzk884M6rOosp6JBD7xKWvPQy2C6k6Ps93M739fYsP6d7O8diVKJ6CPG8BtLKTFQ==
Received: from BL1P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::11)
 by IA0PPFDDA81179A.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::be9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 09:01:41 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:208:2c7:cafe::cc) by BL1P222CA0006.outlook.office365.com
 (2603:10b6:208:2c7::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Tue,
 11 Mar 2025 09:01:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 09:01:40 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 11 Mar
 2025 02:01:30 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 11 Mar 2025 02:01:29 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 11 Mar 2025 02:01:28 -0700
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <suanmingm@nvidia.com>, Shani Peretz <shperetz@nvidia.com>,
 <stable@dpdk.org>, Brian Dooley <brian.dooley@intel.com>, Pablo de Lara
 <pablo.de.lara.guarch@intel.com>, Akhil Goyal <gakhil@marvell.com>
Subject: [PATCH] app/crypto-perf: fix aad offset alignment
Date: Tue, 11 Mar 2025 11:01:21 +0200
Message-ID: <20250311090122.121190-1-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|IA0PPFDDA81179A:EE_
X-MS-Office365-Filtering-Correlation-Id: 9139027a-1f9a-4f14-44f3-08dd607b56d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Uzv6W6Y1gzB+iL/leHuIBA3AO/w0ZUdQEmjVxT89YTE0xSL9ibgee2x8Atw0?=
 =?us-ascii?Q?ge6ovDtFwAJtKwY5xDVEx3deIMlyDH4TObb/vfjhsnhIKZVOTXGml8vjsphU?=
 =?us-ascii?Q?h9bugSSBncX1SYyjHqj4EUDaeRd9J21oUEsyMa2mzKTq4E1wjB896IWE4eoo?=
 =?us-ascii?Q?yHvtLmXvEs+1TZCSnvrSgThAQsFmMKj6aXhd6ACxOD/+Jijv29+3c0nW91Dz?=
 =?us-ascii?Q?Bh15jfMreVevdbAbflCjOs0gFZ4sXkOWuYya0LVj6/44Nd6zdgLAo0c32Paj?=
 =?us-ascii?Q?CH9DqsqfMhE0NZmsrQyUvWB8hiFkKd8CfPVwwF4swh6s+nUVbf0qIAtzAnOV?=
 =?us-ascii?Q?fnSJAafRN5g04K9401ARZSQlEA6EvDO9sTbSeB+arcvlyjKeWckpUiQ1c3ER?=
 =?us-ascii?Q?fojIOGsTuHG8d3TbK8Df5W6AoqUS9AesfE/QG+ZnHAX1JhOvDzoZ88BMaKB4?=
 =?us-ascii?Q?o6FoRtDV4kmHXa0FZNYfnWLbWFMnnqpprhtCjsm5Q5h6zTXZXwvRvuWdneMZ?=
 =?us-ascii?Q?wATjuymt9JS7RCiLayaemgGegEeabBfgG6LgyNwi/WqtXYn9x5Ap23SK9Mcn?=
 =?us-ascii?Q?ic+soJE6Fc+edmkWG3Usf/rPy4fzo/MSJQtp8tagEipn78nLIwnq9rJTWHp/?=
 =?us-ascii?Q?xZPCNPLCvzj/bLpZptB46zY34s2kuzo3iM0nr9NhLE3HP44icuX5vWVJpQXM?=
 =?us-ascii?Q?4Z1SPI4P+iYv3OvU5z3lc6idBdEoNri8x0A63Xem2souiIXUpooiy5oijqRQ?=
 =?us-ascii?Q?6HLC/Rgli0HYRa+49VwTXNnCG7KI+X5iNFvLzV5Nvt/BTZx9ZcW4hO5VY6NW?=
 =?us-ascii?Q?TMQ+zdLsWT38K7DwJV/u65i2mzaXOJrsooRr5ctdvI3YaNYIYoHf1bH+ZRkv?=
 =?us-ascii?Q?CPX8P8Pe4YnZrYDWPC9e9drorhqNy+GoQK2rstZ4vxd0m45o0IUFnR51uXDU?=
 =?us-ascii?Q?xUIibwIduywG5Qx/hUEahM8ywEi93fzO5Lf43qQY8vZd6hv8TQQ6dTNGnA41?=
 =?us-ascii?Q?SCIc3L5zJJ5gd4igocjy1uLx9FbeW7EqMkO+w21sqp327HKxYp5xCCeFWwmX?=
 =?us-ascii?Q?c1SmTNLXwKfWIT67eLwTfqc6fx7mJGTYWRbTG61Bn44YABBdy9rcrK9UJsMF?=
 =?us-ascii?Q?lamkTD9LaPM0ELs1dtBKXv5BxFAm8limSG58Fy6S35EtKT8N9VYd47l7TBQw?=
 =?us-ascii?Q?S7Vxs8ZBXU/0eMYpCyh9ZRNhGCco99BqWNxcoo2rSSYKSs5FO00Cy8vlmy6w?=
 =?us-ascii?Q?0lGl0/hP40iCu1+8PXH+oLuBlf6xtxREE7VeADWKWZ9MyuVeipqaCyTcbDSe?=
 =?us-ascii?Q?8xsHSNy+9OLNTvmD0R45B73zOQNelDYWt+TJkffwq1vNmYi3nO37m9rLjELG?=
 =?us-ascii?Q?1bRY61XvXf11DNz01c9Ej28sE1qmz2F7WaVSJtl8u6b3nXiD6ZbRVbHIbi7Y?=
 =?us-ascii?Q?wPNC9n0mieJFOffqs+hU25F7Y9a1wi9jIgHXqIwJ/d7m/IP8kYgkuPepOtOS?=
 =?us-ascii?Q?UaPv6Ss6kkdtzj8=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 09:01:40.8639 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9139027a-1f9a-4f14-44f3-08dd607b56d7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFDDA81179A
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

AAD offset in AES-GCM crypto test was calculated by adding
16-byte alignment after the IV, which is only needed in AES-CCM.

The patch correct the AAD offset calculation in AES-GCM algorithm tests.

Fixes: 0b242422d385 ("app/crypto-perf: set AAD after the crypto operation")
Cc: stable@dpdk.org

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
---
 app/test-crypto-perf/cperf_ops.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/app/test-crypto-perf/cperf_ops.c b/app/test-crypto-perf/cperf_ops.c
index 6d5f510220..f9be51e17f 100644
--- a/app/test-crypto-perf/cperf_ops.c
+++ b/app/test-crypto-perf/cperf_ops.c
@@ -688,7 +688,9 @@ cperf_set_ops_aead(struct rte_crypto_op **ops,
 	uint16_t i;
 	/* AAD is placed after the IV */
 	uint16_t aad_offset = iv_offset +
-			RTE_ALIGN_CEIL(test_vector->aead_iv.length, 16);
+			((options->aead_algo == RTE_CRYPTO_AEAD_AES_CCM) ?
+			RTE_ALIGN_CEIL(test_vector->aead_iv.length, 16) :
+			test_vector->aead_iv.length);
 
 	for (i = 0; i < nb_ops; i++) {
 		struct rte_crypto_sym_op *sym_op = ops[i]->sym;
-- 
2.25.1

