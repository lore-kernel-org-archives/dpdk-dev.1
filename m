Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6084C5B543
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Jun 2025 10:08:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6723402D5;
	Thu,  5 Jun 2025 12:08:26 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by mails.dpdk.org (Postfix) with ESMTP id ABBD54026C;
 Thu,  5 Jun 2025 12:08:25 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zafkz9A5CKxrlm63b5SyveE1JhDTctgyB+r1IuP75vCpkHCdxjP8numgO58xgR1nh6J0kZLxQxlIdZSInVZlE+3WhX4ocz/pnjLUapoNXqD8+Bf3vSlFvRdX7AVdSG1pyY6bXMxOCG2P8ET3z3dfaWvkZYGxM03iqqd8UodAa70jPkK48GdRbDTpwezyF1ioQFQ5MhLxN3KWWK+uYucFzhmfbY7JWDCsnK5OoM/gaYyFZTDKgOBHurl2euPHB4mXs2pOCggnAZFp6YVwzAu/LWri17uEOkdD3dC7OIc6HV6V2MTy8t6MJS/XqjIXR8lb6bkKXLKs+AhEVPiWLBcchQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6yYUTR1z1AeK/f7BpjUBMFGpuxz8AVtZO+9O19MRFVk=;
 b=vlCXL2yqqgnTGwyzW2VMfcbF47rUcSBGsICl19eSaBsIBOl0LvtrM0PKafxI+glBGPuLstuuaCsQXe/t+PMPjOt5D/W6CQFnh6Ma+rkaw+Vkhcf/bBQRCaqejpPM2hy6JMLHdo/DtXsA2AikatyJm4qMAO1LjwTpeAwIpVwFlmTt4aRODvRI9O2Gd1BkqrhYjzWcbEmaIiWF5y7mIi+bZ4vseHlVGrKYEzrHnY5O84AFsPQXDYpho5EnXxIDSK5VdeH0z43GkAzlsqUGM0yJh5ceNmzwtyrTtscQuDGPgFbVhCKnHMFbku8fD6TRdIMh+P7PgwfPEyiUOYRuPZ9Qtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yYUTR1z1AeK/f7BpjUBMFGpuxz8AVtZO+9O19MRFVk=;
 b=TfCYIUi+FpvT0LxhVc1xO6VrvN58vRoDF7BwKpjezlxGBk02h9LrDDLvWJ+YA1hTxVhq5pHqRCJlIX9w93TRLBy+hIeAc9tQY6x7oDO6WkTpKg0wWbzisareB3QKepGg2CVForCXiUXse4fAp3WFWEhzIltjg9xqRbyYrpTsmDyg1EyiUsPIgdjDyo9LNn/Dxz5GIu7b/CKMtgDgvrvEQJOZnpEDfcMFR7t/tJ/mjg9140X7VKEDN+ecuLWu0rkzSlOgcqcdgVgOky9iX7AHTHp7oXuABmopxxAmTlN1NjrnWA/y1Cbpixqr466HZfD/6X9HPSKrGhVgBXW0K6+fmw==
Received: from DS7PR06CA0004.namprd06.prod.outlook.com (2603:10b6:8:2a::19) by
 SJ0PR12MB7068.namprd12.prod.outlook.com (2603:10b6:a03:4ae::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.34; Thu, 5 Jun 2025 10:08:22 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:8:2a:cafe::a1) by DS7PR06CA0004.outlook.office365.com
 (2603:10b6:8:2a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.22 via Frontend Transport; Thu,
 5 Jun 2025 10:08:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 10:08:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Jun 2025
 03:08:08 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 5 Jun
 2025 03:08:05 -0700
From: Junfeng Guo <junfengg@nvidia.com>
To: <dev@dpdk.org>
CC: <stable@dpdk.org>, <dsosnowski@nvidia.com>, <viacheslavo@nvidia.com>,
 <bingz@nvidia.com>, <orika@nvidia.com>, <suanmingm@nvidia.com>,
 <matan@nvidia.com>, <junfengg@nvidia.com>
Subject: [PATCH] net/mlx5: fix flag non-template rule cleanup
Date: Thu, 5 Jun 2025 13:07:34 +0300
Message-ID: <20250605100734.35936-1-junfengg@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|SJ0PR12MB7068:EE_
X-MS-Office365-Filtering-Correlation-Id: 7920e593-6062-4ca0-52ab-08dda418e6df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0hofInKnEh4C7Vmf3RQLw0oUKVBasG35RBHZcmi+iDQuaWn3+u47rwvtT6BB?=
 =?us-ascii?Q?Al6fnykcdOA024VyPMXVELOFpX+xgEEcMzwXjvfUV0OmCx+7HNbCftrU3quu?=
 =?us-ascii?Q?yrMlC6LDObz+BdZUKknBONk+Mch1IuNfiFKMtPNbFG+kV1cH9KLxT/tVRJIw?=
 =?us-ascii?Q?drzH+UskfbolbYeU08uaQi3tk29ypVi7L783aFedfSr0JV/lc25QnRHQG4Za?=
 =?us-ascii?Q?4nTSrh1qMHgkUQsQno0MbP39itSZJ9H4Yu7Gu09TWgb3EOHHzwlPnrlzCaax?=
 =?us-ascii?Q?3g5lPV2tVxFdXJRgd130tpC/VAUGUePLdWC8kQsuk4vpmC8ckDho5crcPjC+?=
 =?us-ascii?Q?0/Nh0OjwFCum57bbeHMXCUBhlHRZFpROH/WOiVUuN0RQv/za7LYdVFGc40+E?=
 =?us-ascii?Q?R33j+1k1zujzPnPdN35Oqhw9XOPdlOwYknz6KbIdCt/98cHDK1zsRMTsc9nR?=
 =?us-ascii?Q?h1F2FDf/mX1Fv9pjhLyk4YZyXEdlRcn+tu04v640GSekLwH2G4OspfwadnFY?=
 =?us-ascii?Q?PcIZ/MKdQ09dkWWtBEgY1USoIEfDpPEI7ap1IT7pU4T5hvPh0TegjbDeERDN?=
 =?us-ascii?Q?x+LHDi3IutvObiohVie60bxkySclK1W5qYXS9ICkTgVMi0kF6CmXFLP2pTTQ?=
 =?us-ascii?Q?64HfERklKnY9bj/wwtL0LVl5kVb3+pmZ0ee5K+peD7JDf97xo/cb0ZcbEBlM?=
 =?us-ascii?Q?1RIBQ7lvQYY76rw6Lx0vmrZCSNvM6iMU9ttaY/4VKSBCzl261OVGq7kS0EPz?=
 =?us-ascii?Q?kRZJmZjBHyNZ8pW9hy+hzM+raAtAMM8Ix1l3X7fSJzKCAeyWkpN+X/v/ny6W?=
 =?us-ascii?Q?ulZ4j1xZwJ3ga4ABtHBxWhX60ClR+dXg3dnyiWNm2g/DV+B2a94K/N0S8uRp?=
 =?us-ascii?Q?0twoehw5R4okWoPd6P2iniAJ16U/X1ntbUANtgRusUAL7qUC6LmSrWmdIaYR?=
 =?us-ascii?Q?YplVu5Ni/H2Un+ficjHttw4kl6tqcnihSHKx2dyyvq3i1r8z6Q2qqeHOZUd/?=
 =?us-ascii?Q?MBOIXlXAmGXs1jGY4yEp8CWZv5f5nhOSuO1HMvz3AXH8zCkn+AaScNr/vHBB?=
 =?us-ascii?Q?cdES/JmHRKXSbbhRYvJL4mAvfeA2Kraha+jiQGWQzNcHAAa4Y1nM3wWDZezX?=
 =?us-ascii?Q?EbErId8mPh++ruvxNxgkNqOYhKRSF8ZjtDEZsGoYI2yS0Lwa0Tk9HWb7p6q/?=
 =?us-ascii?Q?Hqq6pLwsBLUNEY3uGDmBPWnVJaw2qxv7vHq+SMrC4DZ0ACqjMOVCuTsAOVQA?=
 =?us-ascii?Q?vLKo63R3H5HUgTHtDfgaDp3t8FMWvUz0YVVT71C9452q/SgRXtve6n0lVB3i?=
 =?us-ascii?Q?m5rmtH5mFN42sYQ6HEh5ufAG5b9cfjyBomfVfPTYyVxeRr5MoMdRKVLnRCtu?=
 =?us-ascii?Q?TkpU/j/B2T+d1gABUwQ0CqHrWNW6xOVisywo66g16+uhj/zY2siOIn2Ocq8c?=
 =?us-ascii?Q?Sdda2U+BIowY9SXxjIt2uPydoWFKZ/UUCRVXKD/5gHVHGAl/NAcqaar1okMZ?=
 =?us-ascii?Q?+6QwwduJsW7oAajhuUD2pARZogybfn5paiud?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 10:08:21.4807 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7920e593-6062-4ca0-52ab-08dda418e6df
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7068
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

Set the flag nt_rule to be FALSE whenever the flow rule is created
through template API. This would ensure that this flow is always
treated as template API flow after mlx5_ipool_malloc without being
zeroing via memset.

Otherwise, some tables or template actions may be still in use for
port init stage when attaching a port for template or non-template
rule, in scenarios where the uninitialized memory nt_rule happens
to contain a TRUE value.

Fixes: 2fda185a8c1c ("net/mlx5: reuse flow fields")
Fixes: 63296851fadb ("net/mlx5: support flow rule update")
Cc: stable@dpdk.org

Signed-off-by: Junfeng Guo <junfengg@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow_hw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index e26093522f..af2e7a84a5 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -3935,6 +3935,7 @@ flow_hw_async_flow_create_generic(struct rte_eth_dev *dev,
 		rte_errno = ENOMEM;
 		goto error;
 	}
+	flow->nt_rule = false;
 	rule_acts = flow_hw_get_dr_action_buffer(priv, table, action_template_index, queue);
 	/*
 	 * Set the table here in order to know the destination table
@@ -4141,7 +4142,7 @@ flow_hw_async_flow_update(struct rte_eth_dev *dev,
 	}
 	aux = mlx5_flow_hw_aux(dev->data->port_id, of);
 	nf = &aux->upd_flow;
-	memset(nf, 0, sizeof(struct rte_flow_hw));
+	nf->nt_rule = false;
 	rule_acts = flow_hw_get_dr_action_buffer(priv, table, action_template_index, queue);
 	/*
 	 * Set the table here in order to know the destination table
-- 
2.34.1

