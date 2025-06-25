Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B97C7EE30
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Jun 2025 09:33:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F11994068A;
	Wed, 25 Jun 2025 11:33:15 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2053.outbound.protection.outlook.com [40.107.95.53])
 by mails.dpdk.org (Postfix) with ESMTP id 7531E402B1;
 Wed, 25 Jun 2025 11:33:14 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PplmtVY6ejXSOatoHadjnAP+YMDsQlmU43wERPaercjjU19SxSVL1L5eQC+iTmfU5aDxMRQTkwcGUZX6+vBV1p7Fx83gEdAAQ4B/7XdnnVvDuDDzfJQe1ih+jOR1tYrznTWnWbS4EzsSFfofFtMAxVFGpN9Z0dQJ97pnwTprQjUf/NFTUS3iIuE1PgMs6zc16qmw3ljJFjp1XUv6SyPrcMEwUFkfAIfl9TPZTIDc0lwoF+40ufb/uWnKpPvIqU6qO0a8bg87rUvoa9xJSCo6Fitu/v0Z67jDQ2tMwf+BUflqlftHYa1g9zb7Wo8jUWghBr6/uY68pMLRLS8bMbUZeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=voGgkSUsV/c2CLTWtA0NS0oDuZJY4kU+3AQzEnD+Mrw=;
 b=coQMsavmk1mRkCnAx2mCEJyE0WMweypeVjuOPH51oUKMHcFCDkadlV2VALaM1x5UAnYx6zNs9Cu8M9Lzes4HGq8tqZXo9pzmHsQjRhjHem4zZ4ItKmzYewJqZZanA0y+NifSISmmZGUcOLC1W68oHtDtIcvMHmLnkLDkzN6TibaJo54AQuJe7FoJG15HsrsWMr4rXfWRAJFLGpLCHcw9Ffq+nnscE7HWN65dTru5LNcCb3x3UHvPm5GWHt4Aixs79CweDlAaK+ujXIxk1JGjxQz1Vb+6jR1U7teeSatnhCVuq1vigvx7g5lTY2rWq/5UGsPg/Lc8Vr0ZqFVdf+5hqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=voGgkSUsV/c2CLTWtA0NS0oDuZJY4kU+3AQzEnD+Mrw=;
 b=XsPW97ks8IGOZYWwiCzhxlvq9qnOk+1+JbF5bHxXnQ9tVB1US9p3usXhs7lnhVoTMt1DIwsfSucSHhZ+C4iSzRBfyhRhuTfsaDX0aFwNwouK7BLDs0kw0qcNsM0NcaQCJrDlV6qEFgsaY1/V3AOGFb3QfOhDqPYmtRTaSoApOHKLDJiakzEumakRyGS7pnwKsuy5e1LxmhRkc+2R//TIViYks4sjYy2jH/HaP4Vmt/JSQToTvE8PpNS83lCxWfpMqMXfcskG7S26Fq3gaabafC14gStQzcSY9d7j7x5YVGysPEzbIlSrAEBxEs837c9fUTmLcv8jmAXozvzDLKr+lQ==
Received: from BYAPR21CA0018.namprd21.prod.outlook.com (2603:10b6:a03:114::28)
 by DS4PR12MB9636.namprd12.prod.outlook.com (2603:10b6:8:27f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Wed, 25 Jun
 2025 09:33:11 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:114:cafe::ec) by BYAPR21CA0018.outlook.office365.com
 (2603:10b6:a03:114::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.6 via Frontend Transport; Wed,
 25 Jun 2025 09:33:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 09:33:10 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 25 Jun
 2025 02:32:56 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 25 Jun
 2025 02:32:55 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 25 Jun 2025 02:32:53 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <rasland@nvidia.com>, <stable@dpdk.org>, Bing Zhao
 <bingz@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH] net/mlx5: fix segfault in counter pool destroy
Date: Wed, 25 Jun 2025 12:32:47 +0300
Message-ID: <20250625093248.167642-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|DS4PR12MB9636:EE_
X-MS-Office365-Filtering-Correlation-Id: 33d1783e-9c05-4a17-fb90-08ddb3cb4d02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2Xr1NvJttc/t/XTR9PP4xvbk12FGufcfP8w8nRLDgZSY+D4IS3p2QAVfcLBJ?=
 =?us-ascii?Q?msI1CLPb4NAINN/yeTooF9bru9ehSVaYQMYfDH3zjNEFhs4f/tvpvi9F6CWw?=
 =?us-ascii?Q?094wawF3JDFpwBbmBQjUUTtrAHFSxuKFkG9nhrRVVxKxC70kE3QTf9XI3L+W?=
 =?us-ascii?Q?BPNS2BlXFWV6+U8xGkn+Kb3tJsijyFqmmLSHgr4/XfXtAdXmJi4zvdDIeAhe?=
 =?us-ascii?Q?FLYWosVG52ZX9kevNLk0JwOs0hH9uXubTMvHnZX1cuqmx2dmBcjvXbZBgy/u?=
 =?us-ascii?Q?gPM3m8LBJukC4GIN/OaCa8N6YzxqzGY1CtsYw1RY+IC6UDs7g/LwLwgTQAFo?=
 =?us-ascii?Q?OX7ElmD3aBpN8nkr0TefEGQYvroKNSGR52LqmavJqAUDzTLxU5LsVjWkosbC?=
 =?us-ascii?Q?IgLQfr8xq7rR4wjL/Uf1DJgVa9TZpMxEk6SXOxLuW2UOQHGhexQ6RNv4Fkxc?=
 =?us-ascii?Q?K6SArXczL8vFXrLXAk/w0X8tZuKaktK7jRklvb7FsgeqGbqf2YF6yEgdjG9h?=
 =?us-ascii?Q?nfxtBzgJg9FdAqx55Nh0nf9CgybiBGrMs/3C9082xalhExBtUbPkalytdWy2?=
 =?us-ascii?Q?uG5Zd8cnZlYWKjN4i/GJsHxmNH2FzJ5WC6kNgJOAKILyRolAi55245P76bMM?=
 =?us-ascii?Q?bHkW0qlIxNTzmKmabCxv2HX92SqOiJ35vkVkhhPpRNQuEyERICxucYD4uMOo?=
 =?us-ascii?Q?rlkzexVIZvb1zf1rM86UFaZudGFvIzJnamPlnMi/FzRXoV3x0iGtH4Fvd5I2?=
 =?us-ascii?Q?ICr/G4E0seBWxNHpvRRkQcUrQf0dpWfuXDA2ukfkkxdbNJM+2GC/GF8Ea2Fg?=
 =?us-ascii?Q?jA+SXlrv/dE6oRM1T7Z6jHRJRUL6VBhw9oSdBBoybPG5PrH8FZeB5jlzVUx9?=
 =?us-ascii?Q?HY7TLeaoUeruyrrTJhTfantEtLOpVyaojYaxRJT5mk228oVr/oVFjxDo2mA/?=
 =?us-ascii?Q?mV7ulv1goHZvuw7LDagLRNa9ns8Z9Ui1+GaNulgNj2Up1xH2HatqdD2u+8x0?=
 =?us-ascii?Q?Lz+vfkvapw4UAkqSHAgwJCvixuBT2dIe4FtRQdTn9q6G+/EoEOWRIU77+WG3?=
 =?us-ascii?Q?vXtv8I0MGrfnWScTdwOL4iKUbrzh7Dqk39qPuALgKiFXo0D3dcD06GduUxBT?=
 =?us-ascii?Q?lsgTQBpwrkqrmvp4DS2V7SLs08ScEVYaE8nb5OnoM48CsRMTgKg1rUzXt5mc?=
 =?us-ascii?Q?lSF5OR5ccHt2K5p99pWm8i5JY8AMFV7fxavResddljpF8oQvt5ejlzBKYSot?=
 =?us-ascii?Q?jF/Weq6orfy4osiDe2eTSSMfGryA3clMxA9FIuGcKIW8IwIGfi4+JpRemGeX?=
 =?us-ascii?Q?avkjkZgZqsGUuJm2A14+kP0FWFiDQ7YFtJMcXsQDupstB68WQb05Fj80A0Jm?=
 =?us-ascii?Q?xfHZX+OKELmHFVXXspxBaSwPCMBy+icDqKSEazlVUNFVSVixZVlaKQafJBVj?=
 =?us-ascii?Q?jjI38GqQaXnKHW36lUMWJJ7QiwXlz6qMf3uM0pcx9owkDDXub0QxMAPOh9z6?=
 =?us-ascii?Q?2OX24uw5A6xyhK4sZzyKR0kqG8ufkhWDOG1k?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 09:33:10.7325 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d1783e-9c05-4a17-fb90-08ddb3cb4d02
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9636
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

When there is not enough memory, counter pool creation fails.
As a result, the pool is being destroyed.
Since not all pointers were initialized during creation,
Need to check for null pointer in destruction.

Fixes: 13ea6bdcc7ee ("net/mlx5: support counters in cross port shared mode")
Cc: stable@dpdk.org

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/mlx5_hws_cnt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mlx5/mlx5_hws_cnt.c b/drivers/net/mlx5/mlx5_hws_cnt.c
index 83db242bf90..fce7a7e815f 100644
--- a/drivers/net/mlx5/mlx5_hws_cnt.c
+++ b/drivers/net/mlx5/mlx5_hws_cnt.c
@@ -810,7 +810,7 @@ mlx5_hws_cnt_pool_destroy(struct mlx5_dev_ctx_shared *sh,
 		LIST_REMOVE(cpool, next);
 	rte_spinlock_unlock(&sh->cpool_lock);
 	if (cpool->cfg.host_cpool == NULL) {
-		if (--sh->cnt_svc->refcnt == 0)
+		if (sh->cnt_svc && --sh->cnt_svc->refcnt == 0)
 			mlx5_hws_cnt_svc_deinit(sh);
 	}
 	mlx5_hws_cnt_pool_action_destroy(cpool);
-- 
2.21.0

