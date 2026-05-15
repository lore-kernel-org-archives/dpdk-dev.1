Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129F9CD4851
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 May 2026 12:34:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D4AF240269;
	Fri, 15 May 2026 14:34:54 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010057.outbound.protection.outlook.com [52.101.61.57])
 by mails.dpdk.org (Postfix) with ESMTP id 1D654400EF;
 Fri, 15 May 2026 14:34:53 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rvcLUDXO727DqvFxd6t74hAKsaqn6iAECSQ4yWVfWyGtOsBPwDhb27OnBGV8Lf8JDs4r4ubFtumtjId2CZ+FG1dkj6tLumDw68gPYHTw1zXYt90L/gvkwRVhfRRgSWrO3aksrK2jY5wpLonOallKa3X6UNYaV+iTMcCX4lp3yQNhb//hG2F4e4NpMC/CBJcwiTCriRvXnDXjIWGkYrLI31lPAnYBPzNeaHqcLjwWba0K5XdUkSquDkFEPC7353vcd9FC5p5YPC75ZVo+2tGkjVyV16geg/hAV2Y0Fpli8v8Craj14hepGvNGNIPs2wfRvCfL1VM5LtR0tyn/7TNjsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WxdTF4rWv4Gs06GepjpD61ADsDwwmWBzP8hzibomf9s=;
 b=vR2XjNDupHTtA65LZPDgc9Dogzxt+y1Lx6U7RfV05bSFPidAG81NP2O9HaGNsmgOspCO5CaiLKgAZHS8yjvtKhR+3D13ca6LaJyJjTzb7YjYdOYC+q3snv1ipCokO01JiO65w8LQezDWSxZ4IKJwtRRuDHkNZr/OV5Hra31MdrIj7a1dyDpP2yCbKugpPA+3YWEouhk0FMtHSXeaUnOdbT/eeNkXwZDxTrP5pEucjFskMl7Qs6Q/RIlq54HiMCDRCjUVmxmmpoykbge+fWFX6Qg0mHR8zjKOmoZfYfFm5UwzSooyMNa1lC/WdURzYFl66c/VW/7byyhzNsqYS+lxTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxdTF4rWv4Gs06GepjpD61ADsDwwmWBzP8hzibomf9s=;
 b=muUE+rjBOG7N/EQ7eBptMuWtgKy8fS+Q9WChJ6dEMur0jXetaqy/1q3tKC1ll2BqnChWB9/yypbT31Dg+6vGa7fiPn6AO0DAINuAOYimGlw9Iw9B8IptsowsYQRYYqXjz4Q5xvkyAXl600cqY98CisLTOK6Y61cUP+UGjkJ9szqteVog8t7ErMyXsoJrWEbQFoYgrNtLKxunGJGWx63hawm90hliCxdp+ruumfvXJPT+iqp5Q05Oiz6KPHXW2qbkaVosB+pM1F80r0II+/cgHqQyYP4OaKv2w+nex2h1p5j325hkaiOrxHoJ46fvsWN7qhoTjL+me1oVkts7f21qCg==
Received: from MN2PR08CA0022.namprd08.prod.outlook.com (2603:10b6:208:239::27)
 by DM4PR12MB6663.namprd12.prod.outlook.com (2603:10b6:8:8f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Fri, 15 May
 2026 12:34:48 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:208:239:cafe::c8) by MN2PR08CA0022.outlook.office365.com
 (2603:10b6:208:239::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.20 via Frontend Transport; Fri, 15
 May 2026 12:34:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.0 via Frontend Transport; Fri, 15 May 2026 12:34:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 15 May
 2026 05:34:18 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 15 May
 2026 05:34:16 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Alexander Kozyrev
 <akozyrev@nvidia.com>
CC: <dev@dpdk.org>, Kiran Vedere <kiranv@nvidia.com>, <stable@dpdk.org>
Subject: [PATCH] net/mlx5: fix uninitialized skip count
Date: Fri, 15 May 2026 14:33:58 +0200
Message-ID: <20260515123358.354191-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|DM4PR12MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: 644869ab-4a22-4535-88be-08deb27e5a37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|11063799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: GsmVzY1D0pn8PmCpXXgsqKS+N6eWQmIYtk0ahwGwtPtsfPR2JiSGTqsDkhqCgrlcjxA9+tOcT0UL8yKdEvChv1COk+oKDZEVynDi5xSnjRNqYBXqP0LxlKoPsG/+H+c3u70ztLi7Ez/CQKX1r0YoIx2VwKv4ZU/y8Ljmct37TF4xpksMIXdZqPTQr4FtegZRj6du6nhUGLd/o2OctNvpgJJZNbq5GhQmLAiNsgL1zN30wZQivGVrlDqiQtONs2rUsFWzcUFSkCy6tNddYu9LD7BykMbVpwMq2mHw1G5vNhoQfFEx7PSvJl2AUC3kVPdZtehIB/zfCWAv47mYa9Yj+cXinAfAheWGNI6K70BBDa0g77sEn9oFgiPrE0bw1T42P2J0lpq7wxseBbTuvwBdyvwmJGu+d9weSyPYoCf5jnHKau/PF/UiVOVlrDxrhQ7b4JOix0v976dp9e1NWIGAVIztwr1tWlU7w28g6oaukym/b/HQi7SF/+lXmfDf+HAHptPdgC4wNHzJcyRAGhlzxkTrzsrVEnvY+tVpxabGSyxwRhK6L2zemdTPB50cckoyI0yyfz3Yu78Q1ocR5uSAqoDaG5S3aE/5JQTUzR/3cag46iPoX7MaDBY130guWgs5EPWbaXh6yIhCDjRPLSrLwB98P5s3c/WSTgF5zhtMF5s8y3fAW77LsDJpxRm2/JSg
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(11063799003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5M+teTID47h5Uh7ymlMFAJHAOZ3jxkyP1/zlB45kZZXBFKMRhOeT3CUeBpeO51/cJ+J3J656eVWnidZNzVkeQeEgop7WtACERPPju0gucAFKvxJ++YlxqVXrshFe2EKIuWnhFyK4S77SAN7GN+9wP9G6D0jRI8n6DPDggmZ09N/bwDg7y/1HwKOSO1w/1xObWO7jji7R+demBL/zDyEj5ywXNrBlZEmcgHZFUs5uh5N97TCIWuR/bLOhHXNZR8Wj05l7t1mn5bBpcEkb6KU2vul0B8XkR5CS1AVdiJXob9DFGbHLrwYAm/rjuPnlegcQjPSLnKC4ruvG8n7e+bUfawidFjLKUP5H36kdNCvVj2c766eyBEcjS1caYEPO/YX9deCww5D2C69wI3jCh1eHH/rgMYEVV/9mSRUV8tPvZ4TBOUbpPRUNcPDZw0/2eYEW
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 12:34:48.0453 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 644869ab-4a22-4535-88be-08deb27e5a37
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6663
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

From: Kiran Vedere <kiranv@nvidia.com>

mlx5_rx_poll_len() may return MLX5_ERROR_CQE_MASK when
mlx5_rx_err_handle() reports MLX5_CQE_STATUS_HW_OWN while the Rx queue
is in IGNORE error state. In this HW_OWN case mlx5_rx_err_handle()
does not necessarily write to *skip_cnt, yet the caller (mlx5_rx_burst)
unconditionally uses skip_cnt to advance rq_ci.

This can cause rq_ci to jump by an undefined value, desynchronizing the
RQ and CQ rings and leading to persistent bad packet delivery until the
queue is reset.

Fixes: aa67ed308458 ("net/mlx5: ignore non-critical syndromes for Rx queue")
Cc: akozyrev@nvidia.com
Cc: stable@dpdk.org

Signed-off-by: Kiran Vedere <kiranv@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_rx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_rx.c b/drivers/net/mlx5/mlx5_rx.c
index 185bfd4fff..09cd3f1ffb 100644
--- a/drivers/net/mlx5/mlx5_rx.c
+++ b/drivers/net/mlx5/mlx5_rx.c
@@ -1051,7 +1051,7 @@ mlx5_rx_burst(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
 	int len = 0; /* keep its value across iterations. */
 
 	while (pkts_n) {
-		uint16_t skip_cnt;
+		uint16_t skip_cnt = 0;
 		unsigned int idx = rq_ci & wqe_mask;
 		volatile struct mlx5_wqe_data_seg *wqe =
 			&((volatile struct mlx5_wqe_data_seg *)rxq->wqes)[idx];
@@ -1497,7 +1497,7 @@ mlx5_rx_burst_mprq(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
 		uint16_t strd_cnt;
 		uint16_t strd_idx;
 		uint32_t byte_cnt;
-		uint16_t skip_cnt;
+		uint16_t skip_cnt = 0;
 		volatile struct mlx5_mini_cqe8 *mcqe = NULL;
 		enum mlx5_rqx_code rxq_code;
 
-- 
2.47.3

