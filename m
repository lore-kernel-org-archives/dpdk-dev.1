Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA05DC79F87
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Jan 2026 13:30:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5D4C4026F;
	Mon,  5 Jan 2026 14:30:26 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012061.outbound.protection.outlook.com [52.101.43.61])
 by mails.dpdk.org (Postfix) with ESMTP id 03E1D40267;
 Mon,  5 Jan 2026 14:30:24 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TEspNEqRbjJPonBSpI4BjC568tNF6/VdGyYFW2+4Si+1ClCTYlsO5QtrQMQaFIMgZhZgv8+vX6ARceqsRovsLECw6V8ilTKLZnYnh6s+9JHwRBkTycU0l//GB0ImJtollB5MsV7gvoEAE6bs94hCsL1S9noTWkK98THipZ6julF5d69e//Ck29He6OZwbElm8oBVCrj3Dlbpd9IIedrHvI9ejm/Szvy7o4FRKrINfCmLMTizodC3CncbRie8LepM3Q6c1reJ/SIrJfT/N0+drGQh0v21VSlV69Smm0JFEhG0zZDnNDmkjqlKzXzyomee0/ovRiSEoDnKbDMauj0KPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmfesezdD2P6nlmrKvVh/mqWBbLIIBWzuNP8awAp8jw=;
 b=HE14ort2NLoXQX7i/Sr6cnoM5EHByVUmWvJCyOefl+Rts98vNmAbs3N+jc/W25TtaFyqeIvHCm1P6wCMXXq+22pFWdjQizBXCN1YlE99uYsoH/jrtB04e+V2HiCEr6+i5sbVnvDCNTPWizOGe90YnR2ykufPX7T978WJWnb6PPXUaRB3MKkt4EPAw+lVwPjOwWr9kOoIQrY9H7FGEqexjJFQITYC0SHq8puf+44YmQzhIDTKFCqDO1tMTr6YeE6tBaDiNDa2QkJNrNPkt3O6q5W8fS+s4dd4fQ92aNevR1Xl1Vlfzifz2tAQB2hZhzcs7JJ7887IbjsdohU7wraGiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmfesezdD2P6nlmrKvVh/mqWBbLIIBWzuNP8awAp8jw=;
 b=ScvtOP+5SaNQcWCVSwqmJ80aqGWo/Z4eJ1eY8jeTKTZkrNxz70K11iJw2geVocUdAalPhlr+OupUs2sO2utvopzYr/mWhOCF1E6DFt1PgMyfeGeo05vYAv+eq+Y42RktCFqj7yl00FzofojBv+TDK3YSDZt2PRvTNVwIzeSV+s4CFIjR2MCG65dqROJET7W+et1lNiQ4Tp9fCYjYe9C7X/AUnlYVetscIu5bfccEh6tKia1SvK2eqBaqi+65aNfuHtkP5AlR8ycxZekydkIvO+lGD4ob8+Mq9jT9wfvttHn3K70ZI3XpjT0IMgbE51nB8g8zaHiCYuRsHpKHbJdg2A==
Received: from SJ0PR13CA0122.namprd13.prod.outlook.com (2603:10b6:a03:2c6::7)
 by CY1PR12MB9627.namprd12.prod.outlook.com (2603:10b6:930:104::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 13:30:14 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::28) by SJ0PR13CA0122.outlook.office365.com
 (2603:10b6:a03:2c6::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.1 via Frontend Transport; Mon, 5
 Jan 2026 13:30:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Mon, 5 Jan 2026 13:30:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 5 Jan
 2026 05:29:59 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 5 Jan
 2026 05:29:55 -0800
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <dev@dpdk.org>, <rasland@nvidia.com>
CC: <orika@nvidia.com>, <dsosnowski@nvidia.com>, <suanmingm@nvidia.com>,
 <matan@nvidia.com>, <thomas@monjalon.net>, Gregory Etelson
 <getelson@nvidia.com>, <stable@dpdk.org>
Subject: [PATCH] net/mlx5: fix MPESW PF probe
Date: Mon, 5 Jan 2026 15:29:41 +0200
Message-ID: <20260105132941.72705-1-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|CY1PR12MB9627:EE_
X-MS-Office365-Filtering-Correlation-Id: 4627eff0-69e8-4854-c754-08de4c5e8db1
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o3rtUAqtJAyw3KE3EdE7Zeydcw4hl9xQ5Ptx4bUq2s2IB4KONAW+8FY9YQzD?=
 =?us-ascii?Q?0c1AXh8WkGqvaejwH3ICgAutjNrUVCugHFgkzEEi7LRzkiMnOuMECZYh7EeH?=
 =?us-ascii?Q?MrSq3uGka/6GAfcKHl5R7gsGL6JTA3ZfExh5/+nfc+ByWNkT5oPlxtMNaUDZ?=
 =?us-ascii?Q?RXDlTrbsqYuBJc/PxdlCkrTydhHd1N8TQ7c4pRe5vNDbETpR0XuQQzrn4VK/?=
 =?us-ascii?Q?pwSTRxhghLId7B7pXwsJMRIPxeClH/cwvSLkNqufssnn2sigd4nyrIQPJHDU?=
 =?us-ascii?Q?K0M6TIuC7ESZCzKIlyOPMqcQmLxHynqmfVz+ZL3+G5QELPc8CBaHcTRIaqeP?=
 =?us-ascii?Q?ge7R7vNpkIRv6SKuHlh01R7QPjZ5dR7W6rpCCV9dH3sBWse4h8pCJ1YmshEr?=
 =?us-ascii?Q?/iTFlISmz/fDbYCNDGhmaHRCl2WYWu/qGfuOGH7Lw6zZ2UYVNEVDdOA7fBym?=
 =?us-ascii?Q?6NIspR8dgNkgv5XOYkqycK7Opd/cWLu5Y3NEQorPD3ySpLYAcsKXSpdgFKMX?=
 =?us-ascii?Q?n2Ws5Y0x5nKUQ8m8Ge3A81YvjTMdxtraDzvqfKW+tOrH43YLgfloRTtY13bL?=
 =?us-ascii?Q?OBuUY3RQetSuIv1M1D4WUb2uI5T+5+xgEdq1N50/nd6eIeoNGdqz0WaEqcH2?=
 =?us-ascii?Q?KLbsHxeuUN306bdw/IKjkWTpAjmshMgdfIl37veSmyXnTvSM4VLEE/UTuoPG?=
 =?us-ascii?Q?S91FhUDojOQu/FRhMhubwusJP04Vf1kwKCbEPoyRY1t3fLRBAeDCg0FcoO3f?=
 =?us-ascii?Q?TH4ERKgNqPOCvVfDGdfn2wt4CwBpzhohOxiiGSKS0npdudFjdFG+7qvBhY+X?=
 =?us-ascii?Q?CZbJlhuw5zgkkLQj+6wjSWoCXxmIlzQ+PWFE1grG0yyi1SPMRNo8jlkNCHx/?=
 =?us-ascii?Q?e7UHgDk8oYJ9s7CmJhA+YzppMRNwxs4YQsMihB4wL0Noc7fsleuUda/fcGZ6?=
 =?us-ascii?Q?NRFSLd5NN7rrbZbc0pje8LwX5RZp8Loh6egJHj47KvoV9Hu27aGsRHHO4iZR?=
 =?us-ascii?Q?tJLK38NTkmamUogsyuu6zuES8tvoXODmp8xnVDS97f8UkNrqb9FEsJgfxy96?=
 =?us-ascii?Q?YRRwpKUDNWRsolxpKYMQk6XsIozCYttg0g4kGRY1HTCBUy5zIERNFbT6z5SL?=
 =?us-ascii?Q?ZbRdhu5A/r9AYpSnKAebVZr1eIr8BzlDS1qkAhLJgp94jI3+cvQ8oRPNm+ma?=
 =?us-ascii?Q?YQVa16x0slye2mt1uAicaWyrI+bzB2hDWmUsuBnHKmnC4lVF87ldgiOUodxj?=
 =?us-ascii?Q?6u9jgrk0OpnXqJVPz0mzuhF3RfMsKnozV5h0ujYO95UXWl4Tqr0NacrNrQYi?=
 =?us-ascii?Q?tHUgV+2Kpuu6afXIAoDw5e/mBOlE0VSdbvRaKtlM92B8bF1eS1ZxcEyeur17?=
 =?us-ascii?Q?kH1kZOddjA6gFNyFEHKdzgRErFpndxY1fKJqnZxT2gY3PFIIwXGkhGLIcy71?=
 =?us-ascii?Q?h3cULxW2EQaLXPmikUH5GQghxJU/fu1408kPjGoarlkTp/fvNkhObFlOyp9j?=
 =?us-ascii?Q?B+b8RTVHSwzeYcM7gPUCkHVxAUCeCTZbQUBTVtDOiwHHQREXbcwIFDQ3/BXo?=
 =?us-ascii?Q?DXNDjQ7/atTz5NDvQ9g=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 13:30:12.0732 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4627eff0-69e8-4854-c754-08de4c5e8db1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9627
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

From: Gregory Etelson <getelson@nvidia.com>

Current MPESW PF probe was designed for interfaces with up to 2 ports.

The patch can handle interfaces with any number of ports.

Fixes: 11c73de9ef63 ("net/mlx5: probe multi-port E-Switch device")
Cc: dsosnowski@nvidia.com
Cc: stable@dpdk.org

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
Reviewed-by: Bing Zhao <bingz@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Signed-off-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/mlx5_ethdev.c | 47 +++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_ethdev.c b/drivers/net/mlx5/mlx5_ethdev.c
index 7747b0c869..c93a7ac4f2 100644
--- a/drivers/net/mlx5/mlx5_ethdev.c
+++ b/drivers/net/mlx5/mlx5_ethdev.c
@@ -493,8 +493,9 @@ mlx5_representor_info_get(struct rte_eth_dev *dev,
 			  struct rte_eth_representor_info *info)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
-	int n_type = 5; /* Representor types: PF, VF, HPF@VF, SF and HPF@SF. */
-	int n_pf = 2; /* Number of PFs. */
+	/* Representor types: PF, VF, HPF@VF, SF and HPF@SF, total 5. */
+	int n_type = RTE_ETH_REPRESENTOR_PF + 2; /* Maximal type + 2 for HPFs. */
+	int n_pf = 8; /* Maximal number of PFs. */
 	int i = 0, pf;
 	int n_entries;
 
@@ -509,25 +510,29 @@ mlx5_representor_info_get(struct rte_eth_dev *dev,
 	info->pf = 0;
 	if (mlx5_is_port_on_mpesw_device(priv)) {
 		info->pf = priv->mpesw_port;
-		/* PF range, both ports will show the same information. */
-		info->ranges[i].type = RTE_ETH_REPRESENTOR_PF;
-		info->ranges[i].controller = 0;
-		info->ranges[i].pf = priv->mpesw_owner + 1;
-		info->ranges[i].vf = 0;
-		/*
-		 * The representor indexes should be the values set of "priv->mpesw_port".
-		 * In the real case now, only 1 PF/UPLINK representor is supported.
-		 * The port index will always be the value of "owner + 1".
-		 */
-		info->ranges[i].id_base =
-			MLX5_REPRESENTOR_ID(priv->mpesw_owner, info->ranges[i].type,
-					    info->ranges[i].pf);
-		info->ranges[i].id_end =
-			MLX5_REPRESENTOR_ID(priv->mpesw_owner, info->ranges[i].type,
-					    info->ranges[i].pf);
-		snprintf(info->ranges[i].name, sizeof(info->ranges[i].name),
-			 "pf%d", info->ranges[i].pf);
-		i++;
+		for (i = 0; i < n_pf; i++) {
+			/* PF range, both ports will show the same information. */
+			info->ranges[i].type = RTE_ETH_REPRESENTOR_PF;
+			info->ranges[i].controller = 0;
+			info->ranges[i].pf = priv->mpesw_owner + i + 1;
+			info->ranges[i].vf = 0;
+			/*
+			 * The representor indexes should be the values set of "priv->mpesw_port".
+			 * In the real case now, only 1 PF/UPLINK representor is supported.
+			 * The port index will always be the value of "owner + 1".
+			 */
+			info->ranges[i].id_base =
+				MLX5_REPRESENTOR_ID(priv->mpesw_owner,
+						    info->ranges[i].type,
+						    info->ranges[i].pf);
+			info->ranges[i].id_end =
+				MLX5_REPRESENTOR_ID(priv->mpesw_owner,
+						    info->ranges[i].type,
+						    info->ranges[i].pf);
+			snprintf(info->ranges[i].name,
+				 sizeof(info->ranges[i].name),
+				 "pf%d", info->ranges[i].pf);
+		}
 	} else if (priv->pf_bond >= 0)
 		info->pf = priv->pf_bond;
 	for (pf = 0; pf < n_pf; ++pf) {
-- 
2.34.1

