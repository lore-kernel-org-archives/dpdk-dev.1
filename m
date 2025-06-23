Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C94C7115B
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Jun 2025 18:35:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F01CD4066D;
	Mon, 23 Jun 2025 20:35:42 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by mails.dpdk.org (Postfix) with ESMTP id 11C3440664
 for <dev@dpdk.org>; Mon, 23 Jun 2025 20:35:38 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=InkJYUUFNNF9C8Iv1QcJ7QOy8nzF68mgaLnRNW1hhX2Tse0xG0MBWDzyr36Lf8XVVm9SK2Qyw57YM98cNZ6yAGNAOdfsNS1TNbNNm7BTKc8Imq9RrudSTyyt7nn95B6bwJfB7w+ae4LRaGDvCUnvv7MY42+x0KfUbq2eQQSOB1RHbCCFKD7+kNdkAtiuN7biG/KE/be0kyJCwGP2bhiRk/PqOPQ203v4dkshN22+q+dHRXI9wWNVFFaGJa2CWM+q85ekevt7e+j/Lpcet81C1KtMzmTMn5NE28mZyjySDbpObojrpGKY0R9lQ4XZJve+ECgRW+83ZwQpFJFRj+lITA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZg0QNGi6cOyWmvGnaCjFAnwwfcwOAsFwo35BejOFRU=;
 b=WHBXqOhwtVJ2fbw3RcLgSgXwt51N4ZV9HBPRFdmpWolHJqCx+ZndrOmnBYTycVsE2p/WWgpmpH6NOfCoD7UqvbSmGqAnaIr7sGJKs22aq8ua4miyU3DpnR9yqMCtdMuyglcsjaePRKBY6dUrUki3t5ffhED3kARYBsyAR5nDaLwyCGLdCrjxkpx6ZuQIeWF7pj8HBc0/KEiNhPf9cKQBTDMsc778FICt3jMJPa6q+1X+sgFCxJ/VGJS8rYp/0aK6zMehWdg8lDjVrfMNigF+NNBQ1TGto6AHwtQTGM/ZTw0TNEiEFtvtH2wu52KYZpf5Pg597Zgz25+NYGRX6ud+gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZg0QNGi6cOyWmvGnaCjFAnwwfcwOAsFwo35BejOFRU=;
 b=TNJxmAoC+kuNjhHU1RJLQubjjYFIeAeRJbwrLDgIqd0sFDwuAQ2BU19KygUFOEBOoWnlEzC9fsWqVsJCvRMaapbZ+W/j7fy6mvkEDfVvkEPRfYRqMUyAfHMNuzUcPxCNiR8pKO3XWXGX1GKcj8ynJe/VruyjOhgiNwqTBT552zxqrEcUirZAnApNuALfw0OhsN5p/iItAmctrkegaXTXbapTdev6rHdTmfRkNg20awo7Po30qtZVKUY+uj5MuGzOKjuc502iRF2VK0dY8fNRiDs+7Ve3lZn6xWfVmWPJVukwO7/s+iZ1rBjKD3ZR8Sm+jatz0KOy1vJQHhmWVPxGlQ==
Received: from BYAPR08CA0049.namprd08.prod.outlook.com (2603:10b6:a03:117::26)
 by DM6PR12MB4105.namprd12.prod.outlook.com (2603:10b6:5:217::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Mon, 23 Jun
 2025 18:35:35 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::3a) by BYAPR08CA0049.outlook.office365.com
 (2603:10b6:a03:117::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.29 via Frontend Transport; Mon,
 23 Jun 2025 18:35:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 18:35:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 23 Jun
 2025 11:35:20 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 23 Jun
 2025 11:35:17 -0700
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <matan@nvidia.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <dsosnowski@nvidia.com>,
 <suanmingm@nvidia.com>, <rasland@nvidia.com>
Subject: [PATCH v2 2/3] net/mlx5: add new devarg for Tx queue consecutive
 memory
Date: Mon, 23 Jun 2025 21:34:55 +0300
Message-ID: <20250623183456.130666-3-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250623183456.130666-1-bingz@nvidia.com>
References: <20250623173524.128125-1:x-bingz@nvidia.com>
 <20250623183456.130666-1-bingz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|DM6PR12MB4105:EE_
X-MS-Office365-Filtering-Correlation-Id: 56cba2a3-44eb-4632-bc8a-08ddb284be38
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JYbwaqS475Nkj3GBNZmHTo0L7WAJ4rCgvu5TE0xES22yB/SEMQ+DDYpYZNCg?=
 =?us-ascii?Q?k2WxYmay1bVjqO3tfyHCN9l9XvIJmtei/hV+gv9HOm29ODcePxd5hVB3r8HC?=
 =?us-ascii?Q?zCo2BPa2vZf2xT7LhZKPl0cqMze39tgCs4ZGI4qvDIM97aNr8vBCQOjyTHsi?=
 =?us-ascii?Q?IYzfdENCqd3ISXywdBd9tH45PBVyyqQDlGbymoLAgLb9pW/NkIeMFfySt1Qz?=
 =?us-ascii?Q?oSwLbvfae7Fo5sCvliwiY1FKrujrfLNe58eXZnUtiVZ+mR58/5nAgglRmu/c?=
 =?us-ascii?Q?F1VUR3niJmaiG2qiRu0bAzpu1aXIz1/8ssIdN1DWRePKl8+eKrgfKmaIjIAW?=
 =?us-ascii?Q?Ow7BAv61OpDk1IVqSmmkoIr/JkLUE5sW3NcavHLi2GLdsHF3kxovrtc7YIse?=
 =?us-ascii?Q?agK6Tk3Fh0xmeL8/yWcNXY2LAJR96axEq566SQhX5xmzKqozEdfKnLEKwmdi?=
 =?us-ascii?Q?+9l6J93Ulf4C0ZxUmzKiuYART+1ONHYmSClj+Osv3w6kRHsI72q7sHgMgavo?=
 =?us-ascii?Q?ya98exZu0rTTrDtS1YMbjLPsE9jcA7P0EMCtQnirrw+ghJY3ddh6wI4ZGMwU?=
 =?us-ascii?Q?wnV+nba9AOKaqFN8yeUxL6/3KEMZ4EunR4TU6pLo/z7A1iIgJvwrufeH+RsN?=
 =?us-ascii?Q?8ga1errbNGXuchhzvwroSwHTV9yFDmEU782Aj+R5EPW8g73nm9ljL+ivaF36?=
 =?us-ascii?Q?X/aBwAuePzrZTvKny2POFhnBI253wPjkR/4dm/Y3p7mWsfsyzh4oJ6vum5mw?=
 =?us-ascii?Q?qOjZ0OV5yXmNznxldwv8tEp6fhnz0mlMXuR/sMBe9rYsspO8CXGW201LPVvt?=
 =?us-ascii?Q?Dz0E12wplUHOPPz/JFjM+GRqT4TSnUxdBSTxH8BxL5DdqkzgXJb8zh6xa8LP?=
 =?us-ascii?Q?NDcxK7hn8833xFHxeT5qudmRKk+cnbn/DFyq2st5b9wGd8luKeGetMsDrYW/?=
 =?us-ascii?Q?Uqk4/LbtEKmAzFGnmM9ElbkHW9XNaBpmPdb/4dkCgEPtfSsycUcUN9RUEu2I?=
 =?us-ascii?Q?yeF9pugo7Sb40+WZhcD1IKMSUYpy3Rmx4T5iRE3SKKQnyTfxW17wLUbO6bBb?=
 =?us-ascii?Q?97DvGZfwmPfg1znDdYQdUn1VfHdaJ8qBtUCDBztkKV1dQSw918HswDNzKG+9?=
 =?us-ascii?Q?WYKeuCuAJJ0n2zgh1t/5d29LiC1CmLF4APJ/5BpsMauyFWw4zOcjb7ITnKSZ?=
 =?us-ascii?Q?n/UE4teTDmg41TvSR42n0PFDAIr3J1yKerAXHaJa5/EbCMkWtXjdr+FrtR5s?=
 =?us-ascii?Q?cTdxJld0Q9UfN8v6lqwjtq8g6ANZFzYe/RDygLQe7V+zkg8GcbbTT5oGV7+0?=
 =?us-ascii?Q?e3kBPAQISY/26ic8i64wN4rIZs+jGA1Jwd73yGieq/9KN0N6jhb3leCQh7td?=
 =?us-ascii?Q?VGx9tl5h4FW2t+ZU7ImrJIvrn4UI6w9+V49gs44iZptOIPajfHdMZkoXuwVW?=
 =?us-ascii?Q?Rxdr0x+JXq+mFPEbI+AfZVyHtOoFJ46boGFiqmpCLsWSY5jNtVsQR/DfvlXw?=
 =?us-ascii?Q?2iRgE6xgSFbL/P3Ei7+cLrTcYSiXIpx1qSwA?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 18:35:35.2977 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56cba2a3-44eb-4632-bc8a-08ddb284be38
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4105
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

With this commit, a new device argument is introduced to control
the memory allocation for Tx queues.

By default, 'txq_consec_mem' is 1 to let all the Tx queues use a
consecutive memory area and a single MR.

Signed-off-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/mlx5.c | 14 ++++++++++++++
 drivers/net/mlx5/mlx5.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index b4bd43aae2..f5beebd2fd 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -185,6 +185,9 @@
 /* Device parameter to control representor matching in ingress/egress flows with HWS. */
 #define MLX5_REPR_MATCHING_EN "repr_matching_en"
 
+/* Using consecutive memory address and single MR for all Tx queues. */
+#define MLX5_TXQ_CONSEC_MEM "txq_consec_mem"
+
 /* Shared memory between primary and secondary processes. */
 struct mlx5_shared_data *mlx5_shared_data;
 
@@ -1447,6 +1450,8 @@ mlx5_dev_args_check_handler(const char *key, const char *val, void *opaque)
 		config->cnt_svc.cycle_time = tmp;
 	} else if (strcmp(MLX5_REPR_MATCHING_EN, key) == 0) {
 		config->repr_matching = !!tmp;
+	} else if (strcmp(MLX5_TXQ_CONSEC_MEM, key) == 0) {
+		config->txq_consec_mem = !!tmp;
 	}
 	return 0;
 }
@@ -1486,6 +1491,7 @@ mlx5_shared_dev_ctx_args_config(struct mlx5_dev_ctx_shared *sh,
 		MLX5_HWS_CNT_SERVICE_CORE,
 		MLX5_HWS_CNT_CYCLE_TIME,
 		MLX5_REPR_MATCHING_EN,
+		MLX5_TXQ_CONSEC_MEM,
 		NULL,
 	};
 	int ret = 0;
@@ -1501,6 +1507,7 @@ mlx5_shared_dev_ctx_args_config(struct mlx5_dev_ctx_shared *sh,
 	config->cnt_svc.cycle_time = MLX5_CNT_SVC_CYCLE_TIME_DEFAULT;
 	config->cnt_svc.service_core = rte_get_main_lcore();
 	config->repr_matching = 1;
+	config->txq_consec_mem = 1;
 	if (mkvlist != NULL) {
 		/* Process parameters. */
 		ret = mlx5_kvargs_process(mkvlist, params,
@@ -1584,6 +1591,7 @@ mlx5_shared_dev_ctx_args_config(struct mlx5_dev_ctx_shared *sh,
 		config->allow_duplicate_pattern);
 	DRV_LOG(DEBUG, "\"fdb_def_rule_en\" is %u.", config->fdb_def_rule);
 	DRV_LOG(DEBUG, "\"repr_matching_en\" is %u.", config->repr_matching);
+	DRV_LOG(DEBUG, "\"txq_consec_mem\" is %u.", config->txq_consec_mem);
 	return 0;
 }
 
@@ -3150,6 +3158,12 @@ mlx5_probe_again_args_validate(struct mlx5_common_device *cdev,
 			sh->ibdev_name);
 		goto error;
 	}
+	if (sh->config.txq_consec_mem ^ config->txq_consec_mem) {
+		DRV_LOG(ERR, "\"txq_consec_mem\" "
+			"configuration mismatch for shared %s context.",
+			sh->ibdev_name);
+		goto error;
+	}
 	mlx5_free(config);
 	return 0;
 error:
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index 5695d0f54a..4e0287cbc0 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -393,6 +393,7 @@ struct mlx5_sh_config {
 	/* Allow/Prevent the duplicate rules pattern. */
 	uint32_t fdb_def_rule:1; /* Create FDB default jump rule */
 	uint32_t repr_matching:1; /* Enable implicit vport matching in HWS FDB. */
+	uint32_t txq_consec_mem:1; /**/
 };
 
 /* Structure for VF VLAN workaround. */
-- 
2.34.1

