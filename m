Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558FA108B8F7
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Mar 2026 11:14:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A8F4402E6;
	Fri, 20 Mar 2026 12:14:51 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013068.outbound.protection.outlook.com
 [40.93.196.68]) by mails.dpdk.org (Postfix) with ESMTP id A7BA640272;
 Fri, 20 Mar 2026 12:14:49 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a/MRHxfFOROvXMClh3RTAeLsnOX9lEr5LB2euyx+0qKfs6WSOVPDojDEB3HWpjWLbIFIExTRYfljwRAzJDsj8v8B0XK2ll4iNxfFrTo6Uum2NNOGdDqII/aghwY9L/vCLustt29TwC1XZLzjEgXuDoYWxSLpmbWgnQMuGq3uDrjabj/Zohagp/7DjgI2C3Wo0HW/rQPF15FkG1oMCXSmbB9c90Q2F+/i7+E8oj1Q6wM3q5O4OwhI0fp6ClAPmuknW5pZGRufg2X9W5s7zqLyMv86bM++XyixxsmjRTeAlyMi6ut1dvLZgK11Vzzt0K7GxA7WZYYKIWc2DU2CLcn7xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3j1aIuRKoYPz7/blLkkr+VRsKI0N9fjmA4EEfUKFTOI=;
 b=UqWPb0fAl7EoDsJiAL/vZhzXlZ3ztLxRxQTiWv/Qn3BWylTT2KPgMS17wRgWbPbBg/crZOdFaE0UW8AZzvBSXNOuBbzmcCj6QUt+i/VjIpUgBCTy6/vVXLAFfrn0L0bSoaQaOVwAedWKEy27qLo3L2fVB/ytsB9jZV8EjRV1Cj5xAMTtQPdEnbtTyN2Q5UlSgJKukE/U4UcJdi3U/22Q/F97TUqsDo3mduEcKWvXnUfuVyYfiqG/HymeqkqXvnJSllaTCrWNgsEw2LlbouR2op0PdlOUkpbbR3Ji3yQUijCoI3j2WK99fqbyTy3bya6lB34Uy0ixtRvN7rsy7fxneA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3j1aIuRKoYPz7/blLkkr+VRsKI0N9fjmA4EEfUKFTOI=;
 b=lXyWg0RQI9okBzDf7iTkRPRgnDbRstz2nKibYSQM5NZZD8P8jnXzsT4PAkNuwpXusVKtagPm534f03KdTu8tUmmpNnMxLyNC+//ZQpHl2JCi9JGC/Kv1pdAcInuie6b7id2DjtfDR7mDUMLe5I8olYDBLTOBUpAohrVB3r3uvHQ8q54StC8EKaP3PRlLkmMKYty0Mffl524v1AZRo85wCisc8I+FqmwUw6ZoZE4aJ9QpcfjXmCHkJXJo603grKzm4yHbUtbMuSTMYUu1p71BMLDBSjeafQQRVyjVY9DSamEhMD+avwlfwI913H09njfrCAT778WbcORa9gwqvj/A6Q==
Received: from PH1PEPF00013312.namprd07.prod.outlook.com (2603:10b6:518:1::d)
 by MN0PR12MB6247.namprd12.prod.outlook.com (2603:10b6:208:3c1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 11:14:46 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2a01:111:f403:f912::5) by PH1PEPF00013312.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Fri,
 20 Mar 2026 11:14:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 11:14:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Mar
 2026 04:14:29 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Mar
 2026 04:14:26 -0700
From: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
To: <dev@dpdk.org>
CC: <rasland@nvidia.com>, <matan@nvidia.com>, <suanmingm@nvidia.com>,
 <dsosnowski@nvidia.com>, <stable@dpdk.org>
Subject: [PATCH] net/mlx5: fix send skew settings when using wait on time
Date: Fri, 20 Mar 2026 13:14:10 +0200
Message-ID: <20260320111410.148572-1-viacheslavo@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|MN0PR12MB6247:EE_
X-MS-Office365-Filtering-Correlation-Id: 582441d5-e6b0-4fb0-0206-08de8671e4c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: gYPJ6B2+zOFBDv7JlU0zgfmZ+RII5lSMpc3p3xs04wjJUAYN56UnwXbKBU8B+vxcLzxRreiyqewvmms8cihI0HFKMWIHYaug3jE/s8+0CVsI6dhk/53fXC8rfzwKX89W0htVyRhO5N7yQ15AebxEbfJVvFpwrHw0b1d/JfyZOcSpdp8ip0aqpzM25PixlEacuWiGUK1Bjp6JPyTsUvd/nXdp3VCTjboJKmm+W623ejsHCksVAmRbrVtVotYnZCJqrjS0j8KyQ1t1kNm1Lq0OaUwlOGD3F7p6DHy9L4qHzzK+mu9Wcd1uJiz66y7MajOgUAHYfVu8jgkInh5ABiowjAu4dzqsYuIbEBFZruJ8XMWgVxtPo+Su881MD1/E/rZzQEsJ97009o1+hL9iEp+gTgJER2C+uvRKHpNVt2p1j6eoBwsj85WpjX+hLQuxIWFrGyufuehEB3dAGJrLrTbELxKvdEZHe2oNy3jHIPQ6iA3kF2TFMPPPQ2+I6O9dJP/amFcckOCV98PJW7jZpj9Cp3ChXtMr99zdd2Q4w16CQrwcrVkMXTozX0ZfvpRwpgM+/7blmJl8Y+StHWAx4H8nVC1FyvS1ltY8u2FdXZrWrgLY8KOD7juSserMu7/r1UvJuLnFQK+iT5dGO/lsQzEHYFVUGK8ToykLxWSUSD1+DCGgn8dFsgYN6TK0EU6r6B32rZWn8i5LzFtdUkcPf3FPY27GsATEmwm0nRfIMIjHf9pJTvP6OAEO+PdjUt1Y5PHkeQAKlRWU/1KM8L+IYY2ngQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7MfRRbn+lfzbo1Tu8t9TUbmhaaeZWgrRhZ8gbxKZy6mgkIeS1/+kUCXmUXkI5ty9WqSefFckcTRoWwb1xsZasnHFd/NPVr7rCZgo774c+l0RK1FxDaIVgnNe2INO8lLnTfWX2D7XDAfNyABXvgHWOfwpj0mKnw4qXZFvIvO9kORRkG9KmlDz1raa9LI0wxojW6IoDnFXUVYGRH0MGuPnf30TYm2BtqZlauFDG2yN03r7WDwk29MszlXYwR0jAAHVyICeyAbb9Ukh0goe8R6ipaxFhQZVVqvmL79JEj+Uyz06aQguc1ZbFf4PbHZwejgCRV9KWQ4tr3TiY3LIBsM+czmyWH4KeuZSDZwJNUynYxDRsLEclyprBGBPZ7rgs3Q3WbZJY5sRGKxAKksk2pnVaVcSjTIq1FXG/NxS47NidrLM0pOSd4GeWn3g9lWZz00v
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 11:14:45.9488 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 582441d5-e6b0-4fb0-0206-08de8671e4c4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6247
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

There are two modes to support tx send scheduling in mlx5 drivers,
using the Clock Queue and tx_pp parameter, and using the wait_on_time
hardware capability. The tx_skew devarg is applicable for both, but
in case of tx_pp=0 (that supposes wait_on_time mode is engaged
on ConnectX-7 and above), the tx_skew setting was missed (as
mlx5_txpp_create was not invoked).

Fixes: 2f5122dfc41f ("net/mlx5: configure Tx queue with send on time offload")
Cc: stable@dpdk.org

Signed-off-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
---
 drivers/net/mlx5/mlx5.c      | 2 ++
 drivers/net/mlx5/mlx5_txpp.c | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index f5784761f9..b70792d77c 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -1906,6 +1906,8 @@ mlx5_alloc_shared_dev_ctx(const struct mlx5_dev_spawn_data *spawn,
 			strerror(rte_errno));
 		goto error;
 	}
+	/* Used on Tx send scheduling (tx_pp=1 or wait-on-time). */
+	sh->txpp.skew = sh->config.tx_skew;
 	sh->refcnt = 1;
 	sh->max_port = spawn->max_port;
 	strncpy(sh->ibdev_name, mlx5_os_get_ctx_device_name(sh->cdev->ctx),
diff --git a/drivers/net/mlx5/mlx5_txpp.c b/drivers/net/mlx5/mlx5_txpp.c
index 756a772cc5..a8cfe233d6 100644
--- a/drivers/net/mlx5/mlx5_txpp.c
+++ b/drivers/net/mlx5/mlx5_txpp.c
@@ -908,7 +908,6 @@ mlx5_txpp_create(struct mlx5_dev_ctx_shared *sh)
 	/* Store the requested pacing parameters. */
 	sh->txpp.tick = tx_pp >= 0 ? tx_pp : -tx_pp;
 	sh->txpp.test = !!(tx_pp < 0);
-	sh->txpp.skew = sh->config.tx_skew;
 	sh->txpp.freq = sh->cdev->config.hca_attr.dev_freq_khz;
 	ret = mlx5_txpp_create_event_channel(sh);
 	if (ret)
@@ -934,7 +933,6 @@ mlx5_txpp_create(struct mlx5_dev_ctx_shared *sh)
 		mlx5_txpp_destroy_event_channel(sh);
 		sh->txpp.tick = 0;
 		sh->txpp.test = 0;
-		sh->txpp.skew = 0;
 	}
 	return ret;
 }
@@ -956,7 +954,6 @@ mlx5_txpp_destroy(struct mlx5_dev_ctx_shared *sh)
 	mlx5_txpp_destroy_event_channel(sh);
 	sh->txpp.tick = 0;
 	sh->txpp.test = 0;
-	sh->txpp.skew = 0;
 }
 
 /**
-- 
2.34.1

