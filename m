Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB02FC72B9
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Mar 2026 10:25:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 647D740652;
	Sun, 22 Mar 2026 11:25:31 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012054.outbound.protection.outlook.com [52.101.48.54])
 by mails.dpdk.org (Postfix) with ESMTP id 64BD240649;
 Sun, 22 Mar 2026 11:25:29 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QaDyX0QBqDGNnMZCCMX2zXXDZzvGXU0exPxaGvaJptIyV2YToBQCkO+GF2jkfWL2w017dQpHC56wVcNOV9jPG8Vbg53oKcWiHxnG6dka6SZ7iEYhyGcSuAcxZZqcmHJUHiC8ONKfG4cmNytyzuRFv+5+QEScUMMrcbw5+BfjRbn4S0HW3Nh//JH9IKTDVxyevGvA1TK5VgCaFm9aIB5jb8QlsiHZYGLXPIu9DWBWkISeUSXyQmMJzcPlafVydb/iQ4IgPXpOWaCLgqeM2x9JYL8RfpgD1SHooOCncNGfbr5T6kWK7gMf111lJ+ES/Ja/Iw2j5+6Xh0FhiPvKfOhMLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9UUH6zXmDpJIxRcUsvsSg3LksNJ3GlpR5D2bzfGGiM=;
 b=kob4nNsCSw6/vW/6i52DfDkHWWMEUgvD0ZN2J9OlFzZESGH6JOuMEv2wRSKbJRwI82h5LKYHsH0xUU07zVAbuxyx/Ql82dLrplN6q7jnyicGk6IxUNGGZ6xdPApDMX2SY9VDgTBlXeYlD3Igg+uY25JgUwD+svUxol8xinlQEyBYNb2lfDAmd9fQHusv0QFJAyFgnnoCM+JSOdDRf5eMfdrhq+sCKxk9te4BFNKQ+LT/Brnj/F7N6uswJyDK3qrzLthnsCUesORvIzMY3EUCC26wa+nSAUDzil+1N9QXHaNmO1+YTuLmx2TxUhWlaVP8DfNt34DPFMOVVJn3m5ojCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9UUH6zXmDpJIxRcUsvsSg3LksNJ3GlpR5D2bzfGGiM=;
 b=rSEu18B+zwgpZG0yPJzlltOhNu0AIORfPTnEoMYgTb0HxJWCVOFb85H+R+CiZxt0DEITQJj4/RKSDYomj26+9v2kBz0aCphl4S24pePjWdTpAAInQ5WV4rAPabYD/WWoYpkpW8Fg5j0kCg7BmW4AZ06jSTlfg/JDFbwGXU0lJxwD1SPrOb9Jobk9AMuOZ2RmAGH4BeCm1iXVGO1y3XECJ0iUjZVSjf1ogbYpzmwppDNGTxwiH5w8RyObLLnf6X8PeoNZsLpDJhqR5GhnznImhxz3KBXfwAg08gW1cuFoUyp+dzAlGi2hYshD4XJNgNc+NRGZ7R8UZQsU/J9TRMefwA==
Received: from PH8PR22CA0020.namprd22.prod.outlook.com (2603:10b6:510:2d1::27)
 by DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Sun, 22 Mar
 2026 10:25:21 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:2d1:cafe::f2) by PH8PR22CA0020.outlook.office365.com
 (2603:10b6:510:2d1::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.25 via Frontend Transport; Sun,
 22 Mar 2026 10:25:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Sun, 22 Mar 2026 10:25:20 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 22 Mar
 2026 03:25:08 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 22 Mar
 2026 03:25:08 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 22 Mar 2026 03:25:05 -0700
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <rasland@nvidia.com>, Shani Peretz <shperetz@nvidia.com>,
 <stable@dpdk.org>, Bing Zhao <bingz@nvidia.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, "Ori
 Kam" <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Fan Zhang <fanzhang.oss@gmail.com>, Ashish Gupta
 <ashishg@marvell.com>, Michael Baum <michaelba@nvidia.com>
Subject: [PATCH 1/2] common/mlx5: fix doorbell race from compiler reordering
Date: Sun, 22 Mar 2026 12:24:58 +0200
Message-ID: <20260322102459.141958-2-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260322102459.141958-1-shperetz@nvidia.com>
References: <20260322102459.141958-1-shperetz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|DS0PR12MB6486:EE_
X-MS-Office365-Filtering-Correlation-Id: 0342aa9b-1879-4c63-7957-08de87fd524c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: it/kSvP3Bmw1EqMus1fY98RZ2xQXy5OpgqLJh9Vy0BLodYBTmR//GH9qWNFfnD4I/kZbZ8n1n0BjJPLVMehQuTyfzekFC3qIBAhMwk4oKhKXWVfSLXQ57Eznt5jAjfdlYkCpTQK1H2RQheFQA5KS9pN2GKMB67EA+AhFunBNmCDPUPqWwR6BQCOBR5E/kBwu65Bd2vz/I3XoKEk1hXPmzZJK8uPFJ0cKl8BjMdyqurFXX+n2tOtzh6iVQvppi1t+9AOPybWIAyXdt9maPZYXHRnMVR4U00Of8MnWw6B48IfFpWXozrkmWfy7hQ+6yRpCTGDN5nhqpUet6No+qW09KL+Vm83SPaWvfocBUPdPmoCowdqHkCZglw/4CARoxU/CI7Yio58PyngttoariFVDJ+BldFm9DKu59XNeJs6SdqlpzKRIj5lPkVNVgemhg87FPAgn1QsyHk3bBsSTJjoJ842GMGEtoChl1an/fOJBSW/iPVQY+gPOgEgZ2BnVPEfnQWXxIpCx0s8pPj+kUgBle2ReUbBkzelNWi80la0+y1jxpLGoZFByVGrtv/0IrJqpjBacszScnC9SWrIJXcVs1IKRBjjjmdB9T57bRW+PNdzIWuoQxcZiEP1XBCEkFEIuS9izI2+6J+fSN1VfNnzzKgFeAllbsgXr10qbb0p/95f/bR8Lwn1Vn0hQmk5EiRO5Exq31NJJ5kFIaGCEpAy3OTPqSw3J9xmdaoDWh1nuc8rke4mOPt/fSTllnoN7aYa4Ks/zgoQy9MsQNkGVl+5xPQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: G8+kqTsX/q312Ga7f9XF66lupDsdtQ2YYRK4mSOaZ5oNLh+iEB22lBwCtGWcVReJBZCBdGm7w2f8ia0M7b6IkSAl02B+zprFsdbwAM0bcBUzEO7GtGv8B3jgMnJVIpL1T0xXLKjWpScOHLNBYFqFpDmcflm2/SG0y2n8W8d+XiYDokRvu3tffgMqlC7y/wQ8W3y6HIXdDnB7iOi6Hl2IDmqxzLLRjWOPV7zAMZ1HwOEW24+/WrBHRpZEBe1ot0C3Qnewzdi8januFhMd8A10395f4cdsGxmbFYdKir7iehY8gnnCXj1fodS+pvmJR+l5iv8zcRxfQQB+MP7osnKMIGlLRdBKkYI4Y9fXfUxVly6kIqmY5u4THPJZz2ZYkdW4fYvXtSGCI79vS75GKlv3d7t3884It/c6fX/MXS9qbeRNEc95uuaGLNwF7+olU6W/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2026 10:25:20.9661 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0342aa9b-1879-4c63-7957-08de87fd524c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6486
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

The first 8 bytes of a WQE are written to the hardware doorbell.
When compiling with -mcpu=cortex-a78ae, the compiler reorders the
64-bit load of these bytes before the 32-bit stores that construct them.
This happens because mlx5_doorbell_ring() receives the WQE value
by-value as a function argument, so the compiler evaluates the load
at the call site. The A78AE-specific instruction scheduler then hoists
this load above the WQE construction stores, as it fails to detect
the memory alias between the addresses used for the store and load.

The result is that stale data is written to the hardware doorbell,
corrupting the WQE and causing an infinite loop in the crypto
datapath.

Fix this by changing mlx5_doorbell_ring() to accept a pointer to the
WQE value instead of the value itself. A compiler barrier
(rte_compiler_barrier) is placed before the dereference to ensure all
WQE construction stores are visible before the value is read.

Fixes: 5dfa003db53f ("common/mlx5: fix post doorbell barrier")
Cc: stable@dpdk.org

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/common/mlx5/mlx5_common.h        | 12 ++++++++----
 drivers/compress/mlx5/mlx5_compress.c    |  2 +-
 drivers/crypto/mlx5/mlx5_crypto_gcm.c    |  6 +++---
 drivers/crypto/mlx5/mlx5_crypto_xts.c    |  2 +-
 drivers/net/mlx5/mlx5_flow_aso.c         | 12 ++++++------
 drivers/net/mlx5/mlx5_flow_quota.c       |  2 +-
 drivers/net/mlx5/mlx5_rxq.c              |  3 ++-
 drivers/net/mlx5/mlx5_tx.h               |  4 ++--
 drivers/net/mlx5/mlx5_txpp.c             |  4 ++--
 drivers/regex/mlx5/mlx5_regex_fastpath.c |  2 +-
 drivers/vdpa/mlx5/mlx5_vdpa_event.c      |  2 +-
 11 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/drivers/common/mlx5/mlx5_common.h b/drivers/common/mlx5/mlx5_common.h
index 47fcc3fb06..7e8d6349e4 100644
--- a/drivers/common/mlx5/mlx5_common.h
+++ b/drivers/common/mlx5/mlx5_common.h
@@ -420,8 +420,8 @@ struct mlx5_uar {
  *
  * @param uar
  *   Pointer to UAR data structure.
- * @param val
- *   value to write in big endian format.
+ * @param wqe
+ *   Pointer to the first 64 bits of the WQE to write in big endian format.
  * @param index
  *   Index of doorbell record.
  * @param db_rec
@@ -430,9 +430,13 @@ struct mlx5_uar {
  *   Decide whether to flush the DB writing using a memory barrier.
  */
 static __rte_always_inline void
-mlx5_doorbell_ring(struct mlx5_uar_data *uar, uint64_t val, uint32_t index,
-		   volatile uint32_t *db_rec, bool flash)
+mlx5_doorbell_ring(struct mlx5_uar_data *uar, volatile uint64_t *wqe,
+		   uint32_t index, volatile uint32_t *db_rec, bool flash)
 {
+	uint64_t val;
+
+	rte_compiler_barrier();
+	val = *wqe;
 	rte_io_wmb();
 	*db_rec = rte_cpu_to_be_32(index);
 	/* Ensure ordering between DB record actual update and UAR access. */
diff --git a/drivers/compress/mlx5/mlx5_compress.c b/drivers/compress/mlx5/mlx5_compress.c
index e5325c6150..fa687b0eec 100644
--- a/drivers/compress/mlx5/mlx5_compress.c
+++ b/drivers/compress/mlx5/mlx5_compress.c
@@ -589,7 +589,7 @@ mlx5_compress_enqueue_burst(void *queue_pair, struct rte_comp_op **ops,
 		qp->pi++;
 	} while (--remain);
 	qp->stats.enqueued_count += nb_ops;
-	mlx5_doorbell_ring(&qp->priv->uar.bf_db, *(volatile uint64_t *)wqe,
+	mlx5_doorbell_ring(&qp->priv->uar.bf_db, (volatile uint64_t *)wqe,
 			   qp->pi, &qp->qp.db_rec[MLX5_SND_DBR],
 			   !qp->priv->uar.dbnc);
 	return nb_ops;
diff --git a/drivers/crypto/mlx5/mlx5_crypto_gcm.c b/drivers/crypto/mlx5/mlx5_crypto_gcm.c
index 89f32c7722..8875f9b71c 100644
--- a/drivers/crypto/mlx5/mlx5_crypto_gcm.c
+++ b/drivers/crypto/mlx5/mlx5_crypto_gcm.c
@@ -858,12 +858,12 @@ mlx5_crypto_gcm_enqueue_burst(void *queue_pair,
 		RTE_BE32(MLX5_COMP_ALWAYS << MLX5_COMP_MODE_OFFSET);
 	/* Only when there are no pending SEND_EN WQEs in background. */
 	if (!umr_cnt && !qp->has_umr) {
-		mlx5_doorbell_ring(&priv->uar.bf_db, *(volatile uint64_t *)qp->wqe,
+		mlx5_doorbell_ring(&priv->uar.bf_db, (volatile uint64_t *)qp->wqe,
 				   qp->pi, &qp->qp_obj.db_rec[MLX5_SND_DBR],
 				   !priv->uar.dbnc);
 	} else {
 		mlx5_crypto_gcm_build_send_en(qp);
-		mlx5_doorbell_ring(&priv->uar.bf_db, *(volatile uint64_t *)qp->umr_wqe,
+		mlx5_doorbell_ring(&priv->uar.bf_db, (volatile uint64_t *)qp->umr_wqe,
 				   qp->umr_pi, &qp->umr_qp_obj.db_rec[MLX5_SND_DBR],
 				   !priv->uar.dbnc);
 		qp->last_gga_pi = qp->pi;
@@ -1078,7 +1078,7 @@ mlx5_crypto_gcm_ipsec_enqueue_burst(void *queue_pair,
 	/* Update the last GGA cseg with COMP. */
 	((struct mlx5_wqe_cseg *)qp->wqe)->flags =
 		RTE_BE32(MLX5_COMP_ALWAYS << MLX5_COMP_MODE_OFFSET);
-	mlx5_doorbell_ring(&priv->uar.bf_db, *(volatile uint64_t *)qp->wqe,
+	mlx5_doorbell_ring(&priv->uar.bf_db, (volatile uint64_t *)qp->wqe,
 			   qp->pi, &qp->qp_obj.db_rec[MLX5_SND_DBR],
 			   !priv->uar.dbnc);
 	return nb_ops;
diff --git a/drivers/crypto/mlx5/mlx5_crypto_xts.c b/drivers/crypto/mlx5/mlx5_crypto_xts.c
index 1c914caa85..e62641d154 100644
--- a/drivers/crypto/mlx5/mlx5_crypto_xts.c
+++ b/drivers/crypto/mlx5/mlx5_crypto_xts.c
@@ -353,7 +353,7 @@ mlx5_crypto_xts_enqueue_burst(void *queue_pair, struct rte_crypto_op **ops,
 		qp->pi++;
 	} while (--remain);
 	qp->stats.enqueued_count += nb_ops;
-	mlx5_doorbell_ring(&priv->uar.bf_db, *(volatile uint64_t *)qp->wqe,
+	mlx5_doorbell_ring(&priv->uar.bf_db, (volatile uint64_t *)qp->wqe,
 			   qp->db_pi, &qp->qp_obj.db_rec[MLX5_SND_DBR],
 			   !priv->uar.dbnc);
 	return nb_ops;
diff --git a/drivers/net/mlx5/mlx5_flow_aso.c b/drivers/net/mlx5/mlx5_flow_aso.c
index 5e2a81ef9c..3091cec411 100644
--- a/drivers/net/mlx5/mlx5_flow_aso.c
+++ b/drivers/net/mlx5/mlx5_flow_aso.c
@@ -469,7 +469,7 @@ mlx5_aso_sq_enqueue_burst(struct mlx5_dev_ctx_shared *sh, uint16_t n)
 	} while (max);
 	wqe->general_cseg.flags = RTE_BE32(MLX5_COMP_ALWAYS <<
 							 MLX5_COMP_MODE_OFFSET);
-	mlx5_doorbell_ring(&sh->tx_uar.bf_db, *(volatile uint64_t *)wqe,
+	mlx5_doorbell_ring(&sh->tx_uar.bf_db, (volatile uint64_t *)wqe,
 			   sq->pi, &sq->sq_obj.db_rec[MLX5_SND_DBR],
 			   !sh->tx_uar.dbnc);
 	return sq->elts[start_head & mask].burst_size;
@@ -576,7 +576,7 @@ mlx5_aso_push_wqe(struct mlx5_dev_ctx_shared *sh,
 {
 	if (sq->db_pi == sq->pi)
 		return;
-	mlx5_doorbell_ring(&sh->tx_uar.bf_db, *(volatile uint64_t *)sq->db,
+	mlx5_doorbell_ring(&sh->tx_uar.bf_db, (volatile uint64_t *)sq->db,
 			   sq->pi, &sq->sq_obj.db_rec[MLX5_SND_DBR],
 			   !sh->tx_uar.dbnc);
 	sq->db_pi = sq->pi;
@@ -885,7 +885,7 @@ mlx5_aso_mtr_sq_enqueue_single(struct mlx5_dev_ctx_shared *sh,
 	sq->head++;
 	sq->pi += 2;/* Each WQE contains 2 WQEBB's. */
 	if (push) {
-		mlx5_doorbell_ring(&sh->tx_uar.bf_db, *(volatile uint64_t *)wqe,
+		mlx5_doorbell_ring(&sh->tx_uar.bf_db, (volatile uint64_t *)wqe,
 			   sq->pi, &sq->sq_obj.db_rec[MLX5_SND_DBR],
 			   !sh->tx_uar.dbnc);
 		sq->db_pi = sq->pi;
@@ -1338,7 +1338,7 @@ mlx5_aso_ct_sq_enqueue_single(struct mlx5_dev_ctx_shared *sh,
 	sq->head++;
 	sq->pi += 2; /* Each WQE contains 2 WQEBB's. */
 	if (push) {
-		mlx5_doorbell_ring(&sh->tx_uar.bf_db, *(volatile uint64_t *)wqe,
+		mlx5_doorbell_ring(&sh->tx_uar.bf_db, (volatile uint64_t *)wqe,
 				   sq->pi, &sq->sq_obj.db_rec[MLX5_SND_DBR],
 				   !sh->tx_uar.dbnc);
 		sq->db_pi = sq->pi;
@@ -1470,7 +1470,7 @@ mlx5_aso_ct_sq_query_single(struct mlx5_dev_ctx_shared *sh,
 	 */
 	sq->pi += 2;
 	if (push) {
-		mlx5_doorbell_ring(&sh->tx_uar.bf_db, *(volatile uint64_t *)wqe,
+		mlx5_doorbell_ring(&sh->tx_uar.bf_db, (volatile uint64_t *)wqe,
 				   sq->pi, &sq->sq_obj.db_rec[MLX5_SND_DBR],
 				   !sh->tx_uar.dbnc);
 		sq->db_pi = sq->pi;
@@ -1904,7 +1904,7 @@ mlx5_aso_cnt_sq_enqueue_burst(struct mlx5_hws_cnt_pool *cpool,
 	} while (max);
 	wqe->general_cseg.flags = RTE_BE32(MLX5_COMP_ALWAYS <<
 							 MLX5_COMP_MODE_OFFSET);
-	mlx5_doorbell_ring(&sh->tx_uar.bf_db, *(volatile uint64_t *)wqe,
+	mlx5_doorbell_ring(&sh->tx_uar.bf_db, (volatile uint64_t *)wqe,
 			   sq->pi, &sq->sq_obj.db_rec[MLX5_SND_DBR],
 			   !sh->tx_uar.dbnc);
 	bursted_cnts = RTE_MIN((uint32_t)(sq->elts[0].burst_size * 4), n);
diff --git a/drivers/net/mlx5/mlx5_flow_quota.c b/drivers/net/mlx5/mlx5_flow_quota.c
index d94167d0b0..72d2c545aa 100644
--- a/drivers/net/mlx5/mlx5_flow_quota.c
+++ b/drivers/net/mlx5/mlx5_flow_quota.c
@@ -312,7 +312,7 @@ mlx5_quota_cmd_wqe(struct rte_eth_dev *dev, struct mlx5_quota *quota_obj,
 	sq->head++;
 	sq->pi += 2; /* Each WQE contains 2 WQEBB */
 	if (push) {
-		mlx5_doorbell_ring(&sh->tx_uar.bf_db, *(volatile uint64_t *)wqe,
+		mlx5_doorbell_ring(&sh->tx_uar.bf_db, (volatile uint64_t *)wqe,
 				   sq->pi, &sq->sq_obj.db_rec[MLX5_SND_DBR],
 				   !sh->tx_uar.dbnc);
 		sq->db_pi = sq->pi;
diff --git a/drivers/net/mlx5/mlx5_rxq.c b/drivers/net/mlx5/mlx5_rxq.c
index 48d982a8c2..5e9bc0e666 100644
--- a/drivers/net/mlx5/mlx5_rxq.c
+++ b/drivers/net/mlx5/mlx5_rxq.c
@@ -1265,7 +1265,8 @@ mlx5_arm_cq(struct mlx5_rxq_data *rxq, int sq_n_rxq)
 	doorbell_hi = sq_n << MLX5_CQ_SQN_OFFSET | (rxq->cq_ci & MLX5_CI_MASK);
 	doorbell = (uint64_t)doorbell_hi << 32;
 	doorbell |= rxq->cqn;
-	mlx5_doorbell_ring(&rxq->uar_data, rte_cpu_to_be_64(doorbell),
+	doorbell = rte_cpu_to_be_64(doorbell);
+	mlx5_doorbell_ring(&rxq->uar_data, &doorbell,
 			   doorbell_hi, &rxq->cq_db[MLX5_CQ_ARM_DB], 0);
 }
 
diff --git a/drivers/net/mlx5/mlx5_tx.h b/drivers/net/mlx5/mlx5_tx.h
index 0134a2e003..cd35a89ff8 100644
--- a/drivers/net/mlx5/mlx5_tx.h
+++ b/drivers/net/mlx5/mlx5_tx.h
@@ -313,7 +313,7 @@ mlx5_tx_bfreg(struct mlx5_txq_data *txq)
 static __rte_always_inline void
 mlx5_tx_dbrec(struct mlx5_txq_data *txq, volatile struct mlx5_wqe *wqe)
 {
-	mlx5_doorbell_ring(mlx5_tx_bfreg(txq), *(volatile uint64_t *)wqe,
+	mlx5_doorbell_ring(mlx5_tx_bfreg(txq), (volatile uint64_t *)wqe,
 			   txq->wqe_ci, txq->qp_db, 1);
 }
 
@@ -3796,7 +3796,7 @@ mlx5_tx_burst_tmpl(struct mlx5_txq_data *__rte_restrict txq,
 	 *   the next burst (after descriptor writing, at least).
 	 */
 	mlx5_doorbell_ring(mlx5_tx_bfreg(txq),
-			   *(volatile uint64_t *)loc.wqe_last, txq->wqe_ci,
+			   (volatile uint64_t *)loc.wqe_last, txq->wqe_ci,
 			   txq->qp_db, !txq->db_nc &&
 			   (!txq->db_heu || pkts_n % MLX5_TX_DEFAULT_BURST));
 	/* Not all of the mbufs may be stored into elts yet. */
diff --git a/drivers/net/mlx5/mlx5_txpp.c b/drivers/net/mlx5/mlx5_txpp.c
index 0e99b58bde..ef94a5a7d5 100644
--- a/drivers/net/mlx5/mlx5_txpp.c
+++ b/drivers/net/mlx5/mlx5_txpp.c
@@ -171,7 +171,7 @@ mlx5_txpp_doorbell_rearm_queue(struct mlx5_dev_ctx_shared *sh, uint16_t ci)
 			(wqe[ci & (wq->sq_size - 1)].ctrl[0]) | (ci - 1) << 8);
 	cs.w32[1] = wqe[ci & (wq->sq_size - 1)].ctrl[1];
 	/* Update SQ doorbell record with new SQ ci. */
-	mlx5_doorbell_ring(&sh->tx_uar.bf_db, cs.w64, wq->sq_ci,
+	mlx5_doorbell_ring(&sh->tx_uar.bf_db, &cs.w64, wq->sq_ci,
 			   wq->sq_obj.db_rec, !sh->tx_uar.dbnc);
 }
 
@@ -480,7 +480,7 @@ mlx5_txpp_cq_arm(struct mlx5_dev_ctx_shared *sh)
 	uint64_t db_be =
 		rte_cpu_to_be_64(((uint64_t)db_hi << 32) | aq->cq_obj.cq->id);
 
-	mlx5_doorbell_ring(&sh->tx_uar.cq_db, db_be, db_hi,
+	mlx5_doorbell_ring(&sh->tx_uar.cq_db, &db_be, db_hi,
 			   &aq->cq_obj.db_rec[MLX5_CQ_ARM_DB], 0);
 	aq->arm_sn++;
 }
diff --git a/drivers/regex/mlx5/mlx5_regex_fastpath.c b/drivers/regex/mlx5/mlx5_regex_fastpath.c
index 3207bcbc60..52a0a93ad9 100644
--- a/drivers/regex/mlx5/mlx5_regex_fastpath.c
+++ b/drivers/regex/mlx5/mlx5_regex_fastpath.c
@@ -215,7 +215,7 @@ send_doorbell(struct mlx5_regex_priv *priv, struct mlx5_regex_hw_qp *qp)
 
 	/* Or the fm_ce_se instead of set, avoid the fence be cleared. */
 	((struct mlx5_wqe_ctrl_seg *)wqe)->fm_ce_se |= MLX5_WQE_CTRL_CQ_UPDATE;
-	mlx5_doorbell_ring(&priv->uar.bf_db, *(volatile uint64_t *)wqe,
+	mlx5_doorbell_ring(&priv->uar.bf_db, (volatile uint64_t *)wqe,
 			   actual_pi, &qp->qp_obj.db_rec[MLX5_SND_DBR],
 			   !priv->uar.dbnc);
 }
diff --git a/drivers/vdpa/mlx5/mlx5_vdpa_event.c b/drivers/vdpa/mlx5/mlx5_vdpa_event.c
index 43585a94b2..b9983a61ef 100644
--- a/drivers/vdpa/mlx5/mlx5_vdpa_event.c
+++ b/drivers/vdpa/mlx5/mlx5_vdpa_event.c
@@ -77,7 +77,7 @@ mlx5_vdpa_cq_arm(struct mlx5_vdpa_priv *priv, struct mlx5_vdpa_cq *cq)
 	uint64_t doorbell = ((uint64_t)doorbell_hi << 32) | cq->cq_obj.cq->id;
 	uint64_t db_be = rte_cpu_to_be_64(doorbell);
 
-	mlx5_doorbell_ring(&priv->uar.cq_db, db_be, doorbell_hi,
+	mlx5_doorbell_ring(&priv->uar.cq_db, &db_be, doorbell_hi,
 			   &cq->cq_obj.db_rec[MLX5_CQ_ARM_DB], 0);
 	cq->arm_sn++;
 	cq->armed = 1;
-- 
2.34.1

