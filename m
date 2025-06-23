Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367A4C77B7C
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Jun 2025 17:36:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 300E340395;
	Mon, 23 Jun 2025 19:36:07 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by mails.dpdk.org (Postfix) with ESMTP id 4611E402EE
 for <dev@dpdk.org>; Mon, 23 Jun 2025 19:36:06 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=evZcXprFtIhCUrvQKvFckvIWIFEXo8TteArBrh/RBf5C9zJRuzGIVUveFkkOBZglte3m3klBuAPMGYEg0294xiB0Rzlqx8a1M1C8n0xbAXGuC6Vyztx1ko2zEgsF/X9pLeK4plXoy2pr297+X1RY75NpiH2ph/bapcd4txRf/yTKXbhIhAIEc0IN3lGolkRXoozvL7+sSwOntsIAVBJBYcFgPl52ZdDPvm+k4OLZSAPW0eJeZnPE9+UEhUUXUacCLcZWwEDwj6He41ymj8NMsWa3jD6HWs5YCkdBKtMb19KWqomSTFaOJVSgfei2ZPM7FjjkfWyOjoYGlgEprfoJ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZg0QNGi6cOyWmvGnaCjFAnwwfcwOAsFwo35BejOFRU=;
 b=s11BoLSiyLfjrUaVbPk80Xt9ILRk6yPAWfv/Fu86Clx+tXdnoxaDmho/aTzGrU/rmB92RzOPT8AlVsfLd7/m8qe7kDktEQs3ZNSEGFi6/Do0OSvzWJHP8VhBrEkZ12+L8lsYHKgsWobIxouP5uxD3+gLyXABRz/f32rPovNzVbLwjgKNNRtZE7S+SjFcwMqMIqJrV7oZ2G+5PRTtIQnK0vj9ed1GHVPpmzRV9t2TpVc2NJlZuWTYxE5eYyTMLa5KuzUXeA0A8dmDCwOW3iMa+FCPsoXXaHMUlnNfpqVBMaJGGSXCwE7YEC9ExVC5pNlZgbNu/O0U9Iu559QqaGkzSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZg0QNGi6cOyWmvGnaCjFAnwwfcwOAsFwo35BejOFRU=;
 b=cMNM4+UryHA8JAW4JzF4PnKakdeWbjwKx4bjCrTG591HYHDOJwcpY9w3PT4wKiPK+rFSa033TYR8PtFG9uXdgbdj4lJTaOhRKH0VhGjVkQkFa1OgFhP6hklgwg73FuHO7h2YOQG+Y/YJCIwEjzsRYL/OTFWbsBQ3bxJ4/EgCpMFKNr4IQIEXsWmQ5hZ1tGi2WbBymJC0a5BhjLEQqeoB37RusuwvPeJodVloN7F1AmHNnHgEBz4S5uBsSs+J+ebo9ShYR4KuaIowuZ+7inberMhTCN+Rs5s+XvVV+jYlyBZHv5lTcgOQpejlDfeWHAJ/aKK2lyDfHWHvxbIxyBrJMA==
Received: from SN7PR18CA0018.namprd18.prod.outlook.com (2603:10b6:806:f3::10)
 by CH3PR12MB7593.namprd12.prod.outlook.com (2603:10b6:610:141::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Mon, 23 Jun
 2025 17:36:01 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:f3:cafe::d5) by SN7PR18CA0018.outlook.office365.com
 (2603:10b6:806:f3::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Mon,
 23 Jun 2025 17:36:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 17:36:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 23 Jun
 2025 10:35:47 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 23 Jun
 2025 10:35:44 -0700
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <matan@nvidia.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <dsosnowski@nvidia.com>,
 <suanmingm@nvidia.com>, <rasland@nvidia.com>
Subject: [PATCH 1/2] net/mlx5: add new devarg for Tx queue consecutive memory
Date: Mon, 23 Jun 2025 20:35:23 +0300
Message-ID: <20250623173524.128125-2-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250623173524.128125-1-bingz@nvidia.com>
References: <20250623173524.128125-1-bingz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|CH3PR12MB7593:EE_
X-MS-Office365-Filtering-Correlation-Id: 910bb91e-8a53-4007-b204-08ddb27c6ba9
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FYLr1PUkUBCTxqtHqwoXrmMvi4zzshAcQciiQysu8x39rZs5095866JJN6mD?=
 =?us-ascii?Q?fJRDFrxH+eTX3NnQnvrIRTVC+yM7Kd4n07hrus0Wob58+CxXTDQuuZ2RULkz?=
 =?us-ascii?Q?JmWErIF2dTtDq/7hJu3kRGB00e6g9661nugTcJWwy2zT0IGvJFzGRtM04rDQ?=
 =?us-ascii?Q?AdLhdWRevoLThmNlqoaVC0jj3x3CXxx1HB4rPkL1U/03rWwEFyok+wlIB3x8?=
 =?us-ascii?Q?cdJ0u8XycVE5eOavwqZzKsXzU7thbSA/MIWl8p1JKNR/x582tsBBZXdDmVke?=
 =?us-ascii?Q?pXmOh0bvAt7Fem0sZwh/YMSMhEh1f7lnLeisZtFVO7m28k8vJ/iqED53xRC0?=
 =?us-ascii?Q?KCMuYa43xxhSZRZ8BMWOmZaNe4/7G+246eWEvHYs6+E5eUv0g822uAKXNZn3?=
 =?us-ascii?Q?XD8qzKgJhCJuQyyJEGeJbiRmkUT2pNOMOK1MSXWkzLLxAW2VgYx3UEOUAWTb?=
 =?us-ascii?Q?1Nn1ZUL0e2C8NogeYkBpJV1J3Hl5Uk3MklJBbdPyw6hz3ot+EUpEiVehk1NX?=
 =?us-ascii?Q?OF4K7PYl5rkE7AhDFZvTgxxlSAmCxhYS5cG5xMHYX0kiXZmBWc+wkBf6Ugvc?=
 =?us-ascii?Q?v9GzMGeCck9DBX+KB3T1MyKaIEeL+1vAAPPLATZw9d0oVB1AQDCqzz/6wak3?=
 =?us-ascii?Q?JuLG0WNNTwGY3Vcw5q/nE2qyLCpBq1+LwAQ5CgwHIz+dMad5lekbii3HHR0Q?=
 =?us-ascii?Q?+d6YyybUGd0at22jFqJrJmM7a2XtLh2gRMVNsvFz4MBb0biZLZRKtVgZsUe/?=
 =?us-ascii?Q?95763RnfHcntCGuFN8GnikYAGWgQfQYZjLrEH2xlYCrfLszwO8bcesk2rSEw?=
 =?us-ascii?Q?JGYpjHVUQFIK5ESB+PorEIk2d2yGU/PnNInaYuClBPDTrMf24xCogycUErVl?=
 =?us-ascii?Q?qRKZJlLwFBTBH3k9rJnJAsBa7+u6gkhlYF2Onoyvb7dVXvSan+o/HKa+uOaI?=
 =?us-ascii?Q?BnTTA7HtGvdaYTPc75ySHfrob28WYm6YND5SNpWSKSbhTJ5sckHiaP56wdi+?=
 =?us-ascii?Q?De112Ao2WkhY5jOSJYp2ukwtLkaJDFPoQUorUc70EQ88X9FADHiwXc4WSOBs?=
 =?us-ascii?Q?WJUgF9p335gbZAHU8HxxjVZKuoBI7dnY/qfKi3UfYmS6yg7G0By6OiAuupwB?=
 =?us-ascii?Q?HMobBmOw1abQ1sPsv9CTYqBk1iX4nZ/Yrx9hLdb8ZQ4yp0ItQSOS842E38JF?=
 =?us-ascii?Q?4bJM344pLXiSgT/ovN8k5At5Mc2L9Tv92rWMmR1P2hDR/b7bLZQvaQ/9xal1?=
 =?us-ascii?Q?4iRCX377qToi0rThqe+9vkVioYkbhdPnPEsiOoNHcpepmbCyWZqCfBfyCmLh?=
 =?us-ascii?Q?epkfxu7MaovMlU1MKVOGf9XNAbDzfXpGF1A4A7q5VbzF0Qpin1Jj3gV/fcTp?=
 =?us-ascii?Q?g61iGOQrV6oKHZHito1MCvEASHfzaI+wxXG1+Q4n1lh7KTzIn1z3mnSp3QXr?=
 =?us-ascii?Q?FyItdZEGgwUhTMWM6PlSaLePtVc36osWda1N++3antlb5e8dCS2T3Prr4F1A?=
 =?us-ascii?Q?NcoE5499Tl7BOp4kJyRHj+hVQP9Lle8PTM5V?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 17:36:00.6973 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 910bb91e-8a53-4007-b204-08ddb27c6ba9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7593
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

