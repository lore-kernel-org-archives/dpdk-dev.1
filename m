Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D122AE81BC2
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 13:57:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42B3240667;
	Mon,  9 Feb 2026 14:57:00 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010026.outbound.protection.outlook.com
 [40.93.198.26]) by mails.dpdk.org (Postfix) with ESMTP id 463C740657
 for <dev@dpdk.org>; Mon,  9 Feb 2026 14:56:59 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ijuCH+2Hvp/kV/GqKDSnuJd3/aQxcDAdFMaOTsiZOTimdksKF9saf0BP8+b1SjEvVIDczjZksRqiDU1NYt0yrp3xoOH34uFqxS64gI1DEWQOI48D2Jw7W1wwIjPTI6DQD8Fml8Ph/cYTcHbi7vnYgGoxvPab929tzf2ZWm1xw/IZCyEtgRm5mWogBw6CivP3adhMKBNgG/Y/qZEhhocfqCE9Rbwl9Plk3q3fr8E8xcxSwVdpnoFdOK1zTMiTnrSYY9+1OZcBXJMUvlIRW51gSqQ+Blemf8xDLqw6N8B+Fu11GqOBMynqqDCnxU9xnn9wZqUkCZPnSqVozpopsT5Liw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NcRGQHHq2EocVH6P9LdiNfp0I2RUTPWfbbziCj5Aud8=;
 b=IEZERbStAyClEJHPy9x1PVyNuyxw7S4xq13fTNZFMXsH5etqoDOIjGwYoRIP/zB7hx6snTgGhv0kwZ5vHOPHg16ZkeUvKqTrLaKmkNIsl5RKHCN+PMShkjHY4lk9EE/8Jft94Wb1za/p35ced0S8k+rFuK3mpG0WI1vkdcgrOva2iHkdvKwF4nL1K8MOEJAQfYyPh0uo8ZacFpTVpvns+d8rsw93OXqL9awDh3rqZmi0VpCaGAW5VP0wByegQqzx7wpIJdh5ka3L7MfgA6jt4EwK6L/ZonPcIv7obQ5vy9MQhCz4de45Kxyk6Tnn7tR2RbtDyRrL2VQvA5DJhNJsAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcRGQHHq2EocVH6P9LdiNfp0I2RUTPWfbbziCj5Aud8=;
 b=qPjCyAEW7xj7+3p2NgpJBoYuXjxDIlmtTXB3Wq2NBPw+9ln+71Cls5iY3hMqNec8G84aG9Lz+I4iQFIx3MLGcgtYEuRWPH+wkEPW/gVXaPibGZ+k+aGquFYmwsJeCeR4Ag7eb+3zFNicRhL7J6ePD/5WAx9ePslYQPl6x7bLEuJL2nylsp0ctHeoDdSuE/3I4V9hY7YP4ez/w6KBsNdtdwjV64ZF/JYNvN0QU7qGV8dSo7xE7u+ZSPIYtMgj8814eVWMVLj8AUde6HzjkA7Z8FmAKyHEZQXHzyjU6eLgBBlxMsykkpcUDZllRjJ2YcGYNuaCs1UYYJQM6Hxxqs2NYg==
Received: from BYAPR08CA0061.namprd08.prod.outlook.com (2603:10b6:a03:117::38)
 by DS7PR12MB6093.namprd12.prod.outlook.com (2603:10b6:8:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 13:56:52 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:a03:117:cafe::a0) by BYAPR08CA0061.outlook.office365.com
 (2603:10b6:a03:117::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Mon,
 9 Feb 2026 13:56:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 9 Feb 2026 13:56:52 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Feb
 2026 05:56:42 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 9 Feb 2026 05:56:42 -0800
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 9 Feb 2026 05:56:40 -0800
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <rasland@nvidia.com>, Shani Peretz <shperetz@nvidia.com>, "Dariusz
 Sosnowski" <dsosnowski@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 "Viacheslav Ovsiienko" <viacheslavo@nvidia.com>
Subject: [PATCH 2/2] net/mlx4: replace LIBRTE prefix with PMD
Date: Mon, 9 Feb 2026 15:56:25 +0200
Message-ID: <20260209135625.165750-3-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260209135625.165750-1-shperetz@nvidia.com>
References: <20260209135625.165750-1-shperetz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|DS7PR12MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a9ffa10-46f4-45f9-c621-08de67e3140b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h2zurJZe90YVc2+/2N6s40cBGM3zFNC1EXH86z5ri6PYliNynaZwLG86HYHg?=
 =?us-ascii?Q?h8pRrzmyh5FgxMiqOGEP2cNP/R19lFBnjm4lrt4zf9uAmUSqU+ToT/UfN4LK?=
 =?us-ascii?Q?x3z71IDXbm+8J9684ztgnTgOG0bl7Z4QPe7jbTW6KHO7O936YIUftMW7d0mF?=
 =?us-ascii?Q?xzgVQSxPodhIaHM49QoLoIop6bFVlX0fF/+XjuX+UCt1OF4+36BDVS4F3A+U?=
 =?us-ascii?Q?BUDda8g7u16nihht4U+Mdxf2YAovU1wQBhzGfyJ7hRBlygVx85gQ4arA3WO+?=
 =?us-ascii?Q?+DOOjNANXcdKTaaefClhhdfa/Yu2g5qtSbKy6wKwpkOl4bGW01lqYKJ+0bkb?=
 =?us-ascii?Q?INDQ+0dRy9P5/2JR1dhmdNLjbZN4lqAIed7c1eKm3IDrWts4NpdxX16ckgD9?=
 =?us-ascii?Q?KnvGLFVHzIufc+dQbI7ktUfqJlLP3k2t0HZDdvZOD+yXMJcFaosoNa3c8YF3?=
 =?us-ascii?Q?Twl1RWw1MukJI/B9f55maNaulb8IoL/nuJvn2kE2Rm4yZaX4VzdLA2u93Zch?=
 =?us-ascii?Q?ympRO37qPny+cNYuD0DFOaBMS+fvPfyF2oV/TyGajmt2kFg+FIDYYd4LLqlt?=
 =?us-ascii?Q?AMxzXJedDx7vjzvt1bYkf++ksLgn/F6dVp8BOabnI+TVKelECCG9xwyS1xvZ?=
 =?us-ascii?Q?qJX8C9FTFnB0yDK6SpIZZarp0lGooLZbQkfzSFXcN0fpqiLu/pFYQJ899A2Q?=
 =?us-ascii?Q?2TA8QGat56/bBFRt3tM0nTBOPAxovi4QS0j7C8WYfUqCOl7JE3ccDDm7YKjY?=
 =?us-ascii?Q?lc4Yw0DkuiyAfVVRmrntAmwle8WKK59BgnUYJKzvzFeweMP+95fOagXn9LMp?=
 =?us-ascii?Q?fmSNSgsMyxKy4ImKdaUx6w4IyMmGGG1W2kDViHNS4L3AuS+fIGfPTp/GXe7x?=
 =?us-ascii?Q?w3QmVlnGKKSCJ/78/0cCHcxQrpquQ/t2/U+AY11F3vLrQCe2tdfuAybAG/UC?=
 =?us-ascii?Q?5PPewMhJEUc1tXz8wH3CtBpWFgbtpbFtFQNGEqKdGaDGaSAPwOhwB5OOEfu/?=
 =?us-ascii?Q?fL5J/hwANjs69uo4lMfe5tLD3ssdCJ7pf+hpTtlXCE34kN8tpbEW6+GB20Nk?=
 =?us-ascii?Q?1ZvLfTi73z07e2mj1VnUB+u5ellAhXsJgDdGilnef6KdIrRcCRYSY8LxCiii?=
 =?us-ascii?Q?9fUIXokHZix5Ax0wsBBsJTOGOTIGeeFN3AoJNQm/zTOuObAat9eabzkPXN85?=
 =?us-ascii?Q?DENZPUzqI/WgmPsx/3gsrJS10XSB2IK2N8d1Jy6WoAsrteEb7LTNrz9GlVXJ?=
 =?us-ascii?Q?RvC6jjIxHpakQbUciQJns0rIz+Bj+HYu07mucu2Fqnac5zWXYPddZcsFgYxG?=
 =?us-ascii?Q?viPMwfr8fGrfkzX4lYtE+e3Jy/DDVXBCiIkli61ZdWi7skSAzee9qK+i3EGx?=
 =?us-ascii?Q?L7fohy4S1wWVhUCpbgUa8Q7MEwhxy7MAZuz0JzOF9fAfnX98y9BrJyuxSJIZ?=
 =?us-ascii?Q?uxAeFrbmfM+l5w3TRhzH11TSN6wA3PF6jwHOL/Iz8UOT9RrATR2D6Z0u9CB+?=
 =?us-ascii?Q?dqgeNeAOezd7HdN6NWcFuxJuPBydnajhDdJqDQ26SmWtoXxnHVPvvwHcffvJ?=
 =?us-ascii?Q?6e3q84/knSWlN2NRKIigT3Fesnr5Hyxs+H9D3d/2tG3VLqfgfAhqjRQ1PHdV?=
 =?us-ascii?Q?Chh+q4+VhesjZ2070BQtm0mYj4PtdOCatLHMI8QWTiJ0+4Hfz+AXogLDbMNW?=
 =?us-ascii?Q?ui2UGQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fA8MQuIfV40k2erQ2nFk60ih0T63FjpIyN5bcBGOK6BGqrLn0TvWYs1V7tnWcqW8BJ1d+zoKF0YldlcifhOl4OUfujDqOYi6j16YYwG4jm18l/8PzwHeVCF1sTYMINghwkb1fI0x+qs49vhWiuyQVqMueBCNZxft+pzH0SZwcX23N6RiPzW7+BF7Ls0JDczOPz4AFlBKPOvEGo6GWm9PkJn+pqsT1XOHBy+KRDuSIegXXoGnf/7Znqx25stBRYR2b7RDnYuUIwU97K/AMOChbMd/siiD4TWZCSGFPm5S9qWH0+VxJRpQtJodgYPjgJWH1qLjhLDJC313uELw8B6sctub+SzvYT9V/OiPRxZa9hYgyIlEYts8m5GlxTsFe2j1+I26rxGMhUujxccClNmOrFz96fXCmyy6u4RWLs5P0j+JOSUic5hAEnoNKFtJ4cr9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 13:56:52.3719 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a9ffa10-46f4-45f9-c621-08de67e3140b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6093
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

rename RTE_LIBRTE_MLX4_DEBUG to RTE_PMD_MLX4_DEBUG.

Bugzilla ID: 1522

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx4/mlx4.c       | 4 ++--
 drivers/net/mlx4/mlx4_mr.c    | 8 ++++----
 drivers/net/mlx4/mlx4_rxtx.c  | 8 ++++----
 drivers/net/mlx4/mlx4_utils.h | 6 +++---
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/mlx4/mlx4.c b/drivers/net/mlx4/mlx4.c
index 997829a107..28f1116891 100644
--- a/drivers/net/mlx4/mlx4.c
+++ b/drivers/net/mlx4/mlx4.c
@@ -305,7 +305,7 @@ mlx4_dev_start(struct rte_eth_dev *dev)
 		      (void *)dev, strerror(-ret));
 		goto err;
 	}
-#ifdef RTE_LIBRTE_MLX4_DEBUG
+#ifdef RTE_PMD_MLX4_DEBUG
 	mlx4_mr_dump_dev(dev);
 #endif
 	ret = mlx4_rxq_intr_enable(priv);
@@ -1367,7 +1367,7 @@ RTE_INIT(rte_mlx4_pmd_init)
 		return;
 	MLX4_ASSERT(mlx4_glue);
 #endif
-#ifdef RTE_LIBRTE_MLX4_DEBUG
+#ifdef RTE_PMD_MLX4_DEBUG
 	/* Glue structure must not contain any NULL pointers. */
 	{
 		unsigned int i;
diff --git a/drivers/net/mlx4/mlx4_mr.c b/drivers/net/mlx4/mlx4_mr.c
index 2251c624ff..e307029b15 100644
--- a/drivers/net/mlx4/mlx4_mr.c
+++ b/drivers/net/mlx4/mlx4_mr.c
@@ -241,7 +241,7 @@ mlx4_mr_btree_free(struct mlx4_mr_btree *bt)
 	memset(bt, 0, sizeof(*bt));
 }
 
-#ifdef RTE_LIBRTE_MLX4_DEBUG
+#ifdef RTE_PMD_MLX4_DEBUG
 /**
  * Dump all the entries in a B-tree
  *
@@ -956,7 +956,7 @@ mlx4_mr_mem_event_free_cb(struct rte_eth_dev *dev, const void *addr, size_t len)
 		      priv->mr.dev_gen);
 	}
 	rte_rwlock_write_unlock(&priv->mr.rwlock);
-#ifdef RTE_LIBRTE_MLX4_DEBUG
+#ifdef RTE_PMD_MLX4_DEBUG
 	if (rebuild)
 		mlx4_mr_dump_dev(dev);
 #endif
@@ -1374,7 +1374,7 @@ mlx4_mr_update_mp(struct rte_eth_dev *dev, struct mlx4_mr_ctrl *mr_ctrl,
 	return data.ret;
 }
 
-#ifdef RTE_LIBRTE_MLX4_DEBUG
+#ifdef RTE_PMD_MLX4_DEBUG
 /**
  * Dump all the created MRs and the global cache entries.
  *
@@ -1434,7 +1434,7 @@ mlx4_mr_release(struct rte_eth_dev *dev)
 	rte_rwlock_write_lock(&mlx4_shared_data->mem_event_rwlock);
 	LIST_REMOVE(priv, mem_event_cb);
 	rte_rwlock_write_unlock(&mlx4_shared_data->mem_event_rwlock);
-#ifdef RTE_LIBRTE_MLX4_DEBUG
+#ifdef RTE_PMD_MLX4_DEBUG
 	mlx4_mr_dump_dev(dev);
 #endif
 	rte_rwlock_write_lock(&priv->mr.rwlock);
diff --git a/drivers/net/mlx4/mlx4_rxtx.c b/drivers/net/mlx4/mlx4_rxtx.c
index a4df6f7bcb..3ad1c5b6ec 100644
--- a/drivers/net/mlx4/mlx4_rxtx.c
+++ b/drivers/net/mlx4/mlx4_rxtx.c
@@ -320,7 +320,7 @@ mlx4_txq_complete(struct txq *txq, const unsigned int elts_m,
 		if (unlikely(!!(cqe->owner_sr_opcode & MLX4_CQE_OWNER_MASK) ^
 		    !!(cons_index & cq->cqe_cnt)))
 			break;
-#ifdef RTE_LIBRTE_MLX4_DEBUG
+#ifdef RTE_PMD_MLX4_DEBUG
 		/*
 		 * Make sure we read the CQE after we read the ownership bit.
 		 */
@@ -335,7 +335,7 @@ mlx4_txq_complete(struct txq *txq, const unsigned int elts_m,
 			      cqe_err->syndrome);
 			break;
 		}
-#endif /* RTE_LIBRTE_MLX4_DEBUG */
+#endif /* RTE_PMD_MLX4_DEBUG */
 		cons_index++;
 	} while (1);
 	completed = (cons_index - cq->cons_index) * txq->elts_comp_cd_init;
@@ -487,14 +487,14 @@ mlx4_tx_burst_fill_tso_dsegs(struct rte_mbuf *buf,
 				((uintptr_t)dseg & (MLX4_TXBB_SIZE - 1))) >>
 			       MLX4_SEG_SHIFT;
 		switch (nb_segs_txbb) {
-#ifdef RTE_LIBRTE_MLX4_DEBUG
+#ifdef RTE_PMD_MLX4_DEBUG
 		default:
 			/* Should never happen. */
 			rte_panic("%p: Invalid number of SGEs(%d) for a TXBB",
 			(void *)txq, nb_segs_txbb);
 			/* rte_panic never returns. */
 			break;
-#endif /* RTE_LIBRTE_MLX4_DEBUG */
+#endif /* RTE_PMD_MLX4_DEBUG */
 		case 4:
 			/* Memory region key for this memory pool. */
 			lkey = mlx4_tx_mb2mr(txq, sbuf);
diff --git a/drivers/net/mlx4/mlx4_utils.h b/drivers/net/mlx4/mlx4_utils.h
index 4b3323be8c..98de27423d 100644
--- a/drivers/net/mlx4/mlx4_utils.h
+++ b/drivers/net/mlx4/mlx4_utils.h
@@ -27,7 +27,7 @@
 extern int mlx4_logtype;
 #define RTE_LOGTYPE_MLX4 mlx4_logtype
 
-#ifdef RTE_LIBRTE_MLX4_DEBUG
+#ifdef RTE_PMD_MLX4_DEBUG
 
 /*
  * When debugging is enabled (MLX4_DEBUG is defined), file, line and function
@@ -53,7 +53,7 @@ pmd_drv_log_basename(const char *s)
 #define MLX4_ASSERT(exp) RTE_VERIFY(exp)
 #define claim_zero(...) MLX4_ASSERT((__VA_ARGS__) == 0)
 
-#else /* RTE_LIBRTE_MLX4_DEBUG */
+#else /* RTE_PMD_MLX4_DEBUG */
 
 /*
  * Like MLX4_ASSERT(), claim_zero() does not perform
@@ -65,7 +65,7 @@ pmd_drv_log_basename(const char *s)
 #define MLX4_ASSERT(exp) RTE_ASSERT(exp)
 #define claim_zero(...) (__VA_ARGS__)
 
-#endif /* RTE_LIBRTE_MLX4_DEBUG */
+#endif /* RTE_PMD_MLX4_DEBUG */
 
 #define DEBUG(...) PMD_DRV_LOG(DEBUG, __VA_ARGS__)
 #define INFO(...) PMD_DRV_LOG(INFO, __VA_ARGS__)
-- 
2.34.1

