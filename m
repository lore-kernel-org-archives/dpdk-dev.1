Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B0AE7AD62
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Dec 2025 16:21:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D56640267;
	Thu, 25 Dec 2025 17:21:26 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010020.outbound.protection.outlook.com [52.101.201.20])
 by mails.dpdk.org (Postfix) with ESMTP id 7EFA940262;
 Thu, 25 Dec 2025 17:21:24 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CSLc0wYrfHid/1tECQoOrslVFby1RHfzvmhAOmVHjqLj4xhPooROwKYXs55JDHAkTzXzI8N7NCHewtAUK+rUkp6Lo5SdbHgm5qJwtN6qWwURgA1yThiJwi/0tCcdzObpFl5MByT4iZD70RrZxtzGsAdA27My10Z8i6Qyu5ZQ/yksJqaC9Hv0P79ETcOZ4kk240sSSrj2dP9p9tTWP7tNZKo8BX6XoHgz0irzVFzYPZZzuqG7qgEAQ9SEW+v96b16/Ectx7m2xxEDPhW5M0Z+caxMmwcf9zu67it/LUc4BAzElen5R9Q4mBbYeEqkRXv9hjZVzHEmQikZG78fjXFFvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbDWH6bzi3yFyu8hq/vyi6FwTV8Ydldf4dcqECenRLc=;
 b=k8zsTJlhMaoGBUGFiqGeKlaiXzAdTQ9CWri3POVTLk2pU3P5T2iZD9bLaNLKRIwUPCLOWrNr4+VodpMW4929cqg4lxXdalJGs83XoruIbwuhl6NrFWfWvGCgCkCgb6a97MZ+ENqxvUVuA/Dhsb0BNi8dYM341+CEixxSDVBOrm07CnorVN6KUbsV5oCPjUAlkA0EADG4SYY52kS6PrtbejrXEPIOMeLAbkUPgIQuU0H1qriHXaGJ6M2rC8NK0KAT1YRb3K7RWzXp0/AX04GzfxQUlZwdn0FeJBTtkW3wRd8JG3vqOYmNkARZXE/WnVEQ+m5eV1Eg8RkbhplIUeMpoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbDWH6bzi3yFyu8hq/vyi6FwTV8Ydldf4dcqECenRLc=;
 b=OuqUSbPjKzG/ihbhxOr11VQS14XnubhKbp4OUTudYII8F6+R8AGPGadbjbp0tpmWNSQH5wqWOS8uNmKxxX1b/CaM9xUwFrWlycd5KCkbUIvOG9FiRm2xNDlClngwAKH8zPPdIxN6M1VrInzARap+CfMTnlYmnnVeJHbuJzykt/D9FxwlmHdXnz2Fz4cdigPJWeudmir74NAv7MUtU9wnyExFoMzOIY75O8okjAKvKs286o1YiMeUXyK9R30/AdcizWlGjX7hVpCBCDjZzJvMubemzKprtM05fEGIJuUyGcNNktN6GqTFoKHx3m/AFsnZi4YNgqAf6I5Ec+M9Mv3Fow==
Received: from BY3PR10CA0007.namprd10.prod.outlook.com (2603:10b6:a03:255::12)
 by IA0PR12MB8352.namprd12.prod.outlook.com (2603:10b6:208:3dd::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Thu, 25 Dec
 2025 16:21:20 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::58) by BY3PR10CA0007.outlook.office365.com
 (2603:10b6:a03:255::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.11 via Frontend Transport; Thu,
 25 Dec 2025 16:21:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Thu, 25 Dec 2025 16:21:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Dec
 2025 08:21:14 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Dec
 2025 08:21:09 -0800
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, =?UTF-8?q?=C2=A0?= <mkashani@nvidia.com>,
 <rasland@nvidia.com>, <stable@dpdk.org>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, "Bing
 Zhao" <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Rongwei Liu
 <rongweil@nvidia.com>, Alex Vesker <valex@nvidia.com>
Subject: [PATCH] net/mlx5: fix SRH flex parser initialization synchronization
Date: Thu, 25 Dec 2025 18:20:49 +0200
Message-ID: <20251225162049.648482-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|IA0PR12MB8352:EE_
X-MS-Office365-Filtering-Correlation-Id: c7917a00-0a04-4f93-613b-08de43d1a391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eU1YiaagFI/FeXJIApDqDBSz/+q4WPf4gQCpq3bj0j7PXTrJ329BQKIibfq/?=
 =?us-ascii?Q?GgwlkzZlSaYG669mghKrhmDXdoFfPb7Ks0UVsTdJrmcMQ68fJM0uhhrsN5ko?=
 =?us-ascii?Q?3zvl2Fsbj+JRyT7ffIkFdrkTRizhqKQPD28QWh2+EjbgCrCBoQFRhjifSNxQ?=
 =?us-ascii?Q?vufPihHSTdsyAVjHTCv+bUhq65U3l/bDQwPQbWDRsm9uQLHOwwm+syDf7Klg?=
 =?us-ascii?Q?AY/tNj4mmtSkuNnKjUd9dBkPKjy82zSNx4gdfiqZnHaVNM/DTWARArUKPHpj?=
 =?us-ascii?Q?UBjCmYHxqNV1x0aiq0iTuiHC7BIL0u+1GXS6jRzKUf8OCBb65iuO6VypZqyb?=
 =?us-ascii?Q?WH0nzoeq1PiDArNq6Fxc66jHB0PL/L/HrTV5g/cvkTHxEr7cGk6jGXhHOSGz?=
 =?us-ascii?Q?C4/IfGGa/CoCp4L8tM4T0LvzXQYANZI2l6JIsXzs+iHXqHNDw8NVrcaXpwK3?=
 =?us-ascii?Q?nldIaBdjfJhsehniOxn2D2wNHS5ufyjmWlffzZWN9a5ChyQb0MNWUbT0GANg?=
 =?us-ascii?Q?viDIhAxK8YTJBg4wGhJjK/thxnyexM8gkU2lGvVg0Dn3mF59hiXGYnqq9ZSI?=
 =?us-ascii?Q?L8Akp8aB4Z787Ofz5LzA7l76JvZa+qeuTqmsmuuRJzHDKCH52U3Cs4WGUSik?=
 =?us-ascii?Q?JGUQMeFZrjVsuQwp3odw15IDPJYzjg5IBxuq9Mu5wZo1fFbhMsoOdG/eRMqC?=
 =?us-ascii?Q?4EHeqDo6CBwR5LPDJybrIGOqY+vhOJskSo3PLbuJZK7rCMSnTm8+wZNrMnRJ?=
 =?us-ascii?Q?ioLcJZP0gs1FK/Y/ogB9OhQxoOHzJ0zYt1oPlabesGFwONCcvRkWd5e/jcO0?=
 =?us-ascii?Q?Bm+BCKd3roVmH/Y0GSAYxIevnuQ5kMHAsLfGXQlZ5+SgZvByNrXK92h2qNMM?=
 =?us-ascii?Q?7eXAumRZinLduyEdUQ4OTvPE2ojiMwvEyeE6mljffHQZNhiKLAuWpVzAioTY?=
 =?us-ascii?Q?44DzjgOR7Ztn9tqKLPo0TEmoXFsXpoOGR1lxxYO1/4VSSbWtW4zW7y9Qy0h0?=
 =?us-ascii?Q?A5GU2MFCJRkqmlNDnyQAjLk4tRPYBzBB3UsulzkRk1K4FejS+H3G7FM3Pnga?=
 =?us-ascii?Q?YvRgdv5YleCV25EGfYZvjn6dK077sSYF7uTOExr+UHewJT4mRxbt0B9bDCiW?=
 =?us-ascii?Q?sbgzv+thh8TE/Lp5ZiI8rFtRTfm7tYk4bYPExLeSfYy14HjqdNG5X8ttcywC?=
 =?us-ascii?Q?WpuH4s5V0sB2L3BbYSQKvG4Epg9Ql/MT1A9idFpelyMPBdxt6UxAXCcMKeJv?=
 =?us-ascii?Q?VcfCPljaSxMZPc8N0uUdxn0QV/YcjXAHSenP/i2RwRDX7rBy7B58KPIp+I4Y?=
 =?us-ascii?Q?Im0suk5S+KnD1FRNWubsjDLSYOXQu4auTdi26NcWA+5XSvHxRV75MF5Odn+5?=
 =?us-ascii?Q?0ztMuh7xoeEEdMDnYJbD4zcsQ0NK92CMId7mSphY2Iq510ve3CVWz9VW6LV0?=
 =?us-ascii?Q?EDHVLpbnnpOsAlwtNxZ4g0QaBdmrw2iF+uoR8i8WdKTt26efKIv/BzcrXPNQ?=
 =?us-ascii?Q?Jbvkm/XGQxi1tmIuZkiJttmoM8jZ+pUb0Pbv4N8tW/CrmHyvnpdB102mt81S?=
 =?us-ascii?Q?bBUzXGkrHNsxUMziC8g=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2025 16:21:20.4206 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7917a00-0a04-4f93-613b-08de43d1a391
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8352
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

When multiple threads attempt to create the SRH flex parser
simultaneously, only the first thread (T[0]) can proceed to the
initialization code.
Before doing so, T[0] increases the SRH flex parser reference counter.
Other threads (T[i]) entering the SRH creation function also increase
the reference counter before returning a successful code to their
respective caller functions (CF[i]).

This can lead to three issues:
1. CF[i] may receive a successful return code from the SRH flex parser
creation function before T[0] completes the parser construction.
2. If T[0] fails to create the SRH flex parser, CF[i] will not be
aware and will assume the parser is valid.
3. If T[0] fails, it will not update the SRH flex parser reference
counter.

The patch addresses these issues by locking the SRH flex parser node
creation attempt.

The first thread to enter the locked section will proceed with the
node creation.
If successful, T[0] increases the node reference counter and removes
the lock.
If it fails, T[0] removes the lock and returns an error.

For other threads (T[i]) that obtain the lock, if the flex parser node
reference count is non-zero, the node has already been created.
These threads will then increase the reference counter and return
success.
Otherwise, they will behave like T[0].

Fixes: 00e579166cc0 ("net/mlx5: support IPv6 routing extension matching")
Cc: stable@dpdk.org

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
---
 drivers/net/mlx5/mlx5.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index decf540c51..a0bbd28834 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -1050,6 +1050,7 @@ mlx5_flex_parser_ecpri_alloc(struct rte_eth_dev *dev)
 int
 mlx5_alloc_srh_flex_parser(struct rte_eth_dev *dev)
 {
+	static rte_spinlock_t srh_init_sl = RTE_SPINLOCK_INITIALIZER;
 	struct mlx5_devx_graph_node_attr node = {
 		.modify_field_select = 0,
 	};
@@ -1067,13 +1068,16 @@ mlx5_alloc_srh_flex_parser(struct rte_eth_dev *dev)
 		DRV_LOG(ERR, "Dynamic flex parser is not supported on HWS");
 		return -ENOTSUP;
 	}
-	if (rte_atomic_fetch_add_explicit(&priv->sh->srh_flex_parser.refcnt, 1,
-			rte_memory_order_relaxed) + 1 > 1)
-		return 0;
+	rte_spinlock_lock(&srh_init_sl);
+	if (rte_atomic_load_explicit(&priv->sh->srh_flex_parser.refcnt,
+				     rte_memory_order_relaxed) > 0)
+		goto end;
 	priv->sh->srh_flex_parser.flex.devx_fp = mlx5_malloc(MLX5_MEM_ZERO,
 			sizeof(struct mlx5_flex_parser_devx), 0, SOCKET_ID_ANY);
-	if (!priv->sh->srh_flex_parser.flex.devx_fp)
-		return -ENOMEM;
+	if (!priv->sh->srh_flex_parser.flex.devx_fp) {
+		rte_errno = ENOMEM;
+		goto error;
+	}
 	node.header_length_mode = MLX5_GRAPH_NODE_LEN_FIELD;
 	/* Srv6 first two DW are not counted in. */
 	node.header_length_base_value = 0x8;
@@ -1143,12 +1147,17 @@ mlx5_alloc_srh_flex_parser(struct rte_eth_dev *dev)
 						(i + 1) * sizeof(uint32_t) * CHAR_BIT;
 	}
 	priv->sh->srh_flex_parser.flex.map[0].shift = 0;
+end:
+	rte_atomic_fetch_add_explicit(&priv->sh->srh_flex_parser.refcnt, 1,
+				      rte_memory_order_relaxed);
+	rte_spinlock_unlock(&srh_init_sl);
 	return 0;
 error:
 	if (fp)
 		mlx5_devx_cmd_destroy(fp);
 	if (priv->sh->srh_flex_parser.flex.devx_fp)
 		mlx5_free(priv->sh->srh_flex_parser.flex.devx_fp);
+	rte_spinlock_unlock(&srh_init_sl);
 	return (rte_errno == 0) ? -ENODEV : -rte_errno;
 }
 
@@ -1165,7 +1174,7 @@ mlx5_free_srh_flex_parser(struct rte_eth_dev *dev)
 	struct mlx5_priv *priv = dev->data->dev_private;
 	struct mlx5_internal_flex_parser_profile *fp = &priv->sh->srh_flex_parser;
 
-	if (rte_atomic_fetch_sub_explicit(&fp->refcnt, 1, rte_memory_order_relaxed) - 1)
+	if (rte_atomic_fetch_sub_explicit(&fp->refcnt, 1, rte_memory_order_relaxed) > 1)
 		return;
 	mlx5_devx_cmd_destroy(fp->flex.devx_fp->devx_obj);
 	mlx5_free(fp->flex.devx_fp);
-- 
2.51.0

