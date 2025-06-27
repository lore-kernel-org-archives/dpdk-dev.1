Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED81C7EE31
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 08:25:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 436E8402DF;
	Fri, 27 Jun 2025 10:25:34 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by mails.dpdk.org (Postfix) with ESMTP id 860E64025D;
 Fri, 27 Jun 2025 10:25:32 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VW0E0FpTevC9Ul88sOYRsXn3IxTSrIq6YiiteSd4X8yuUmt53sdxZYQTOd2JcoP25qB16xx6oslES8CqO4Z1H2DkFzL2HJeW/2YxNvh/C+KLwX1YojdikuVb+OLckW1kXS9xnZ6vVQjCLPGJf6+3ltPGNVCFrPM9m5Ee2g8ri/FMln4cG+dgm48H+fmD0zYakSbH5OWo3EiP5X0/GmT90lS23wiEiOWqamOrGWdj2paMUWGE37Ze7+A1tlb16LIMJJIbs2tyOUw+y3aJqnJo8k+xBiV8tD5LR5zg6ZjSZADiHJN7HzrgbKr8Peg7kD0VbPfnUrOP2vYlZ+C+cJiUDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7JWrKgpggiMSy/6UGBqtXmldJ+EjvX5oFlzl6LhGZO0=;
 b=GlsQCGHIr7LyYEae92Y7n///JFnlFJ0X85ClLUCOl0ksVbHnHYezqbH4bCcid6s9/NSnQuiKXW4L5bGblhLJBzH8H2qrziERmQDA/dnh49DgCJQCvGUbe8OgbLAYjmkKJwsbme4+8W85gzGFVzzqjL1SUXt8wygW64bIWKf3VrpsgY12C0yJaZbZ3zBoG+pydWwTeVD2bu9pF8FVyCL+xPTt96vzVrHxnq12tx1ASywYX9kgl1iN4s6ucHvsjWKEf6m7KuTPPTqD9ceBCEcCdpNvSLycbNAtcQPCxAFCiCsAcPNmbano3M/phmc23aueiF2BoF8dBa4SX82Cu8DM8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JWrKgpggiMSy/6UGBqtXmldJ+EjvX5oFlzl6LhGZO0=;
 b=c4uA9FfclgmiP9zvIKQLRpkY0pgFdnXuYH2TLutGaZEixuDn8whpsB1ym/42MFbnlE3I3Onp50YberwyDW1v80eXagPkRV9BYc8F872SEqk8J4XV9U73wPObXEdhAFcB/0rwGP7oleH5VLIP8VXsNck5rbVzqRIqaqbd41sU0trs7gjEzcu6X40jW2lQnWmrCnw6UrapcjKjv5r9/0sSMJSJWTbroMd85SG60h5vLY+x3zY9j/IuVEDail/6JuV5VWXE8ozM082Fk6d9B8tHJ4iiBCLKS6BagBkcJhbkFrwwM64gxAMXWvyRa13V0/shPHabv+WGK8U6WSU32CcbIQ==
Received: from BYAPR05CA0070.namprd05.prod.outlook.com (2603:10b6:a03:74::47)
 by PH7PR12MB8056.namprd12.prod.outlook.com (2603:10b6:510:269::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.35; Fri, 27 Jun
 2025 08:25:29 +0000
Received: from SJ1PEPF000023CB.namprd02.prod.outlook.com
 (2603:10b6:a03:74:cafe::2e) by BYAPR05CA0070.outlook.office365.com
 (2603:10b6:a03:74::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.11 via Frontend Transport; Fri,
 27 Jun 2025 08:25:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023CB.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 08:25:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 27 Jun
 2025 01:25:18 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 27 Jun
 2025 01:25:15 -0700
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <matan@nvidia.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <dsosnowski@nvidia.com>,
 <suanmingm@nvidia.com>, <rasland@nvidia.com>, <stable@dpdk.org>
Subject: [PATCH] net/mlx5: fix the WQE size calculation for Tx queue
Date: Fri, 27 Jun 2025 11:25:02 +0300
Message-ID: <20250627082502.26088-1-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250623173524.128125-1:x-bingz@nvidia.com>
References: <20250623173524.128125-1:x-bingz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CB:EE_|PH7PR12MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: a75b5a07-580b-4562-0995-08ddb5542d15
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?t2N8aP5u0pqtD8y90f0T093DsrAiuXFWSqv7tE8ct6IjOf14L5tCM/SQ3Suv?=
 =?us-ascii?Q?w0QT+UWDBU1bvv85m9/7kWRouJvaO3PNi3l3wZrCnTbPtMdRSe4diH6ERfD7?=
 =?us-ascii?Q?r2Lz0WhECqL4ZNovFCPqU0TP5dxHPMDAG6wr0RJLDHQkkYdXuw6PGiyAVx6z?=
 =?us-ascii?Q?n8JHIBxP74PgVUO3KcW9t1QnpeDWFn4S17Z7Rst2S1ognMALn4142F8GpwTz?=
 =?us-ascii?Q?o8xBsaU0Ec/IQIkPZKNksTq9V1gLcofFds7MtV0/LCwKrURSeOJg5lGZ4raz?=
 =?us-ascii?Q?jSonW5iLBisBVZCdbi8QeK4yx7fJpfWDQMGSWzmQH0EBVz2YP/ez+ukQyNoQ?=
 =?us-ascii?Q?KREvHOmXBu4Er1CWfnqZ8vThLWBmNiH8FCFGhJehk2mpHAoCkNaQSFA6vfmK?=
 =?us-ascii?Q?AD4IyD1z3LIpzoGbCycLxVG9f7B4d6kW23SXl2BOwWbuzUBLD2CKI+6Tk4QN?=
 =?us-ascii?Q?YB8utZEcErQ5taBDDNk/YkoSdk9xtJOwYJtR+9vU00FqzjOnpEUUnvJ8BCf6?=
 =?us-ascii?Q?3TFN92ACx1kgaA5bOUghDFMieKC+bslFaM5iApKn8ConF4+siTjaRqwWCDCu?=
 =?us-ascii?Q?PJq4PqMC7VpfpBsD2qHPDdKlH5XlVumcYd6Mp4CS2sd9LzHLHqztalRZ2SO6?=
 =?us-ascii?Q?m9CR/Go0kXmw4a8sQ7fDDc5ELGyqcJM8TOKBUymP78fyuLMdtH9GJVK1vaf+?=
 =?us-ascii?Q?RqwsObNgZw02xOHsmJADRla7BRHqk7fIDyfbkZ70NlfRQHs53BhIcGznhzsN?=
 =?us-ascii?Q?9a2VgXWjsdDAjdpmdK25GznLysipYhIlwGHMSqe9wcO/wmRaAxXI1gp+8fUv?=
 =?us-ascii?Q?Lxj+qWwdD6/DuVSts1OsSoeMVi2Stv83NAuTH/d5REJAQFkzcG3HHjVu50ox?=
 =?us-ascii?Q?ahpDi6kl92tzDzVNAbE1HEkRydOHqnnK0bZfaQoffnLCthohGh4YNJZCaAHM?=
 =?us-ascii?Q?6htIvojYSMRWqT2td5m6OULRcuN4zPzw++MUHFVR5jzspbahiVNHiukgdA2O?=
 =?us-ascii?Q?KXqmIYmUHyuI1Uqu4DxIuaLcchUbac4FLWMPOvifGJMb0TrpAmDhfmyn8f2Z?=
 =?us-ascii?Q?Yu8+MyD5K7AlIQyAbdd7WSKsoREzCO9wIVPjoQPTIEe5WVECZ3hB2092vTvZ?=
 =?us-ascii?Q?HdVapjzHxX2cfGZJoZ8cDn5T29cmXTnJZ5i+Ays92AIr7z7GwcytdkWBfwIv?=
 =?us-ascii?Q?6pNYxBl5DjDF31xdHDI6Qt7ufnCrdcMyazGNza5a/lrIHeeSaNJQ8GWef3Ub?=
 =?us-ascii?Q?g81SqVOo1VuE9mp2u8J8iDX/fvzq9frvW2Hwio6f5sNOH9T2p+GlG+tz/Ir7?=
 =?us-ascii?Q?LDwFbhHniEf3Bfx1J4CijIVxX9YCH1Q1OIBx0Mj87ZzVeCM/xUuyIpYfWBsA?=
 =?us-ascii?Q?EfNnTwcSsSTpmQU4km7VeexlG+V9p5OBX0GRo3bB6lTRyCkQ966G8egwCiEG?=
 =?us-ascii?Q?besKo9hayLXapwFCDEE+0V+Q4h2k3pj/Tn5V/otjvORFvx8uM34MC23fhhzm?=
 =?us-ascii?Q?0yx9zRHECW+U3nhw85sMzty0e+ITCpkBdRyW?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 08:25:29.4412 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a75b5a07-580b-4562-0995-08ddb5542d15
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8056
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

The txq_calc_wqebb_cnt() should be consistent with the calculation in
the function mlx5_txq_devx_obj_new(). Or when the input descriptor
number is 512, the WQE size will be wrongly considered to be 30 when
no max_inline_data is zero in some cases. The total number of WQE will
be considered as 256 and that is incorrect.

Adjusting the WQE size will solve the wrong calculation when the
calculated WQE size is less than 64B.

Fixes: 38b4b397a57d ("net/mlx5: add Tx configuration and setup")
Cc: viacheslavo@nvidia.com
Cc: stable@dpdk.org

Signed-off-by: Bing Zhao <bingz@nvidia.com>
Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
---
 drivers/net/mlx5/mlx5_txq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/mlx5/mlx5_txq.c b/drivers/net/mlx5/mlx5_txq.c
index 5fee5bc4e8..62b3fc4f25 100644
--- a/drivers/net/mlx5/mlx5_txq.c
+++ b/drivers/net/mlx5/mlx5_txq.c
@@ -709,6 +709,7 @@ txq_calc_wqebb_cnt(struct mlx5_txq_ctrl *txq_ctrl)
 		   MLX5_WSEG_SIZE -
 		   MLX5_ESEG_MIN_INLINE_SIZE +
 		   txq_ctrl->max_inline_data;
+	wqe_size = RTE_MAX(wqe_size, MLX5_WQE_SIZE);
 	return rte_align32pow2(wqe_size * desc) / MLX5_WQE_SIZE;
 }
 
-- 
2.34.1

