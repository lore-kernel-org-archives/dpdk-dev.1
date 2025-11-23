Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C139CFC518
	for <dpdk-dev@archiver.kernel.org>; Sun, 23 Nov 2025 10:13:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F0BD400EF;
	Sun, 23 Nov 2025 11:13:27 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012058.outbound.protection.outlook.com [40.107.209.58])
 by mails.dpdk.org (Postfix) with ESMTP id 3AA6E400D7
 for <dev@dpdk.org>; Sun, 23 Nov 2025 11:13:23 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hLRCiXRSZc4ecVZyPKapW53kcv393PaUvCtA0HkBj8ld7tBDivr7GqbnkoftP0U5CcE+2dEpmzHRcV+ksrPr3wWgmo9BbTGtlW9PpxynX5NpqmCt2t1nvau+VbFjwbNSYRiMOZz6Q+yJ7mRJs6zfomSjI8yS/+nv1QucwOi7kT/5LXFzJ06MdidOII5HLwdADnzXJra9taiZrDxq6nDlpGfX0V/XPMAeIpiCPGJRrTwqcOK5K0qVr6zB3eDEiE8bWEDRJzvy4cBq9/jLhBqhMVLyyvkvJBzFgk4e9LlaJuvAApoIrCayphr+D4i5Km62RImh3DHxXGhpajE3nOQpIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnTklGu1uzYpb98nLJLKqBPf/9+2kkfTGBZiV9AWb00=;
 b=U1KEE8uPyK/cLpu+HcWUNnulI34snLINPKczYWAwZlDO+IvCJV/Yk15YICdzO0Ls6jn406FGRqDmDepZF2ffJMC60PNOL/8YVyQDRJmyXNIy1ZVndCCR4oh0L0NMUOoIqqqpbojM53gxdoU79D+tN++LWBTiFybVvNEsK9WxUcP/hAeyioh34/ihmphIN9xUgT84PEfdPK6rKPXDqka1my6mNJA9KYpwW/a/QNHCheoMlyr4F7+ldJeKekz3Xm2AHuMBcDvQtXa43wPn7FeixBy0mS8KvEoNl6y0jGykQmq8PmxjGJfmjljcpLrQUot42fSQGTb2HyrrdBV7EmV07Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnTklGu1uzYpb98nLJLKqBPf/9+2kkfTGBZiV9AWb00=;
 b=rT+aKUsHipGK6UOw6r6hKtEC2VYP4sjj1c/QAUCYLrkDCyUX0oEY4WRhB37UiIuAdct8Bw+bsLZHIitNrbk+YwXD9B6eIS3DIUw7Wy/EfnxxCsiqsNMvflkW1k6BgXE65Zwn3y3h8+cu3AT0jXVs8+qlUsT70DgTzWMJb+fk2wRmrlP5kJrJcs6Ow+jePrKilQX7Kfk2IVfHk1yqL2Y2GEJrzOu6tFqZ3V1YcFwHzk+knnxphA+4kaDHQokbdVTdKdYUk0kGsDwunoYLxsiQSGOpB+KbOBGmJT7zcCZLzzLzU6bBp7G9wPL/L7udM9wlvPcU+eiUGqs/e8Uyhl5JaQ==
Received: from BL1PR13CA0215.namprd13.prod.outlook.com (2603:10b6:208:2bf::10)
 by IA1PR12MB6019.namprd12.prod.outlook.com (2603:10b6:208:3d5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.15; Sun, 23 Nov
 2025 10:13:18 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:208:2bf:cafe::3b) by BL1PR13CA0215.outlook.office365.com
 (2603:10b6:208:2bf::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.6 via Frontend Transport; Sun,
 23 Nov 2025 10:13:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.0 via Frontend Transport; Sun, 23 Nov 2025 10:13:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 23 Nov
 2025 02:13:05 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 23 Nov
 2025 02:13:01 -0800
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, <mkashani@nvidia.com>, <rasland@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH] net/mlx5: fix metadata sharing between E-Switch and VM
Date: Sun, 23 Nov 2025 12:12:42 +0200
Message-ID: <20251123101242.1090544-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|IA1PR12MB6019:EE_
X-MS-Office365-Filtering-Correlation-Id: a8387426-995a-4654-cf8d-08de2a78ec0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hw+uTNdV7tbO67ry6+6aaFWI+jenULq2AYqu1P/lWaWdZqI2O1R6VkzfUAvB?=
 =?us-ascii?Q?4j39Z5nSxp02ZOt98A9NU2enJ718LSKtyAF7EVnD1+YKR2qlQzGzaI8J2gBd?=
 =?us-ascii?Q?GleOBMBPLQZREshZM5BEzrfEUBfSassUsNddwzFQsaWNdVClA9xmiNcItr9Z?=
 =?us-ascii?Q?UJ5hIUEfILONsmehhZMpV5IUXNaMZNNIImXt0AUJfFXB27yPzTZFwa5++cfG?=
 =?us-ascii?Q?UG5a6oztV2FiPZQJtidvs8pnqRI1LwVvaVaCZl5tZ83ELs2qEVf8xEOk1b6I?=
 =?us-ascii?Q?c5DTyBnRmDJWbVYBdWR0IcrV8vrcIM69nPY0Ft7js3Zt/n6qDfKh0VTAimRC?=
 =?us-ascii?Q?zJR3nOO3mcsoIekCccwspFTwPM8Ia4h+OBdFIpEpJ9LDIzfdV4wlVPA+z46a?=
 =?us-ascii?Q?KBc7fQvrcuOfTlhhn2KKljXCEMcLt5N0jbAD577vI6h2OKTmc3tQ2fvPVFZw?=
 =?us-ascii?Q?jtVJYLgGPZ47k8awfenvQ0DXkCepjsShx4ZGB6WR2oCjkHDllt5ZB8WDZJyj?=
 =?us-ascii?Q?sMJDZ7zVfwOHtkp8jqg1BpY3nbDwigNjA+LnCliLkddfZq6ayB2QGbzK45ov?=
 =?us-ascii?Q?gkZlfWUkVm24H6TDIUZTL+lL0DAsM3iXIcow0fYfLN93ltkr3yM1X1cuNfSu?=
 =?us-ascii?Q?Ewk5vJOP6b8hg+tERMjMVZ/QwVFeD99eAK5YLqrjWd6sU7ChmnBbSctu5MTY?=
 =?us-ascii?Q?RRosSGPPMObKVS27nMmyTUEhdtsk/13V8yhfgXGigw0WPqZhjEVEVPkoyifA?=
 =?us-ascii?Q?BQB8RT4CHQ8cWakg/0dJz9UjUBmm0EnodrMTN2UFB+NKJm5piC4hzoa+xnUx?=
 =?us-ascii?Q?1iKf8/Vluxhu5fuLQf3IsAE9xzZoArCRbeTz0Lic3t2N/uAtbLsuknC1kd36?=
 =?us-ascii?Q?8SZqPOdBsndxlieiRJmZLebQFLLidOqdoN39wPijVKrKjkxGL2E73qzoyPDk?=
 =?us-ascii?Q?hGMHjsEM7gj9j8R2PJPd9HW04jMo6xgnDCeVEuuzHaD3gqj2fjJG3L1SaDHB?=
 =?us-ascii?Q?YlpCEW8a8Jkd9YLjU/Br6IyGOJ/rd0HtCyp9W2M0GatQRkQYfd+vsDi+52ub?=
 =?us-ascii?Q?PRv20IfPYv+d45t8GjPRni9eYOXMrzVhfNpujNtRgM3n2uOPqJPaDixjqcti?=
 =?us-ascii?Q?mxb8INM6bQjhsg3QktphvfMsi6RNAe2QyJeaOO5qAYvss41Er2jm/R7gC5Xk?=
 =?us-ascii?Q?rczIyLKyXRUndZMdYazSH3ozCn+JtOwJ3o9tvb2NqJob4IcdBRSWjUBAq2J0?=
 =?us-ascii?Q?1t/3W2nfaoozHF4BlOzNKJ0d4HLdydtFpbeuYvEZcPPJVTQcEEdEXIzZEIxZ?=
 =?us-ascii?Q?NgRoKbDRxMnsVOJKBbbb6MSFBgLPVx9AXTVyIoyT6KZqsarW/WifN46/gzJj?=
 =?us-ascii?Q?Tk6tSCvuTUNt5czfqzKx865L0/iWQwpo1IDO1p4GTHI2k3DTE5fXXPnJruy+?=
 =?us-ascii?Q?cXdMDjamFN9vMReLoop1vOipDbFtnW0C69BVxy4yjHODPrFWwDq/LfXCtD6J?=
 =?us-ascii?Q?ptTRkE/eXOGL1rQfNfqdsqJhWb5eta4T2cDWqus34Q0WeWmg9jf8dBZcrf3/?=
 =?us-ascii?Q?46uS97iAA0ia7GVzisE=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2025 10:13:17.6107 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8387426-995a-4654-cf8d-08de2a78ec0f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6019
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

If metadata sharing between E-Switch and VM (multi GVMI sharing) is
enabled, PMD creates the default metadata copy rule from register A
to register C_1 on Tx.
This rule should be created in group 0, but due to an incorrect
condition, it was created in group 1.
It prevented propagation of metadata from an application.

This patch fixes the condition by adding the missing check for
external rules, so egress group translation applies only to
application rules.

Fixes: a78425ba3793 ("net/mlx5: support flow metadata between E-Switch and VM")

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow_hw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index c41b99746f..5932b2cd96 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -5347,7 +5347,8 @@ __translate_group(struct rte_eth_dev *dev,
 						  NULL,
 						  "group index not supported");
 		*table_group = group + 1;
-	} else if (mlx5_vport_tx_metadata_passing_enabled(priv->sh) && flow_attr->egress) {
+	} else if (mlx5_vport_tx_metadata_passing_enabled(priv->sh) &&
+		   flow_attr->egress && external) {
 		/*
 		 * If VM cross GVMI metadata Tx was enabled, PMD creates a default
 		 * flow rule in the group 0 to copy metadata value.
-- 
2.51.0

