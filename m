Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D21AEC01BD
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 10:14:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7CA8440655;
	Mon, 23 Mar 2026 11:14:25 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010012.outbound.protection.outlook.com [52.101.85.12])
 by mails.dpdk.org (Postfix) with ESMTP id 011DF4025F;
 Mon, 23 Mar 2026 11:14:23 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PpbbQ5mbbbKPe72NIske049gZb4BicglY01zSb+skpfgRMFFTf5j9MRjZBoN+L7wYjaC5XmIMIOG4SVuoprLcyu34SyI8qCW9SzMEtsMhD8tzk7pu6bekLGje1IJK0pv9tAnfJDk4XYY8c4gw/keCdyOwe/k6YsBsUnWbRLBCE2/2lcPk8V0JGt6JB85rMEsW0ek1dFPQxQO9zp9LmHFxX9ztmF+muzOozNQh7G12eAZhvQKBVWSmWUeCZWN2azmDup0Nv7QvO8sN993xcUqtob0AbtzqgzzVm6N2IIIfw97jfZ/YKefGOuz2b/Myt8JmWgl/89kYQ34PY8FEvrFCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWrAZqY5T41jaegJADnDl/youFhW/fYsZhir/+WjCj0=;
 b=iElri5dk2+bH2qT31mEROVq2HTldyT5CTAGG0NYDKx6ecSpHt8ySONrbg+Nl9S0hZ0Mki5sltXlS6cgqwKdpZnrZPZXOd7ZY4iXfb/W7Sp12131H3EAaZdA02IBq1t8gl7FrN+13KiG07nsCWXdZtLZlbmD1+dzekeqzvDL0WmbAkvuSWmVhx1PHGEr/GJDvSz9ALrmCQG0jL/RBATO3gWOQY6fRRVEMc4yksG+hvbZPcWAONrhWsdTm+u/j3NolA94/wNJleQnPtlqojWf9n268zO5+Rg6eWQYz0eQLBI3beGXnHgIrSZhXMjJS0cy6Nk9dNnEBjVE9tZ5nXPh6lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWrAZqY5T41jaegJADnDl/youFhW/fYsZhir/+WjCj0=;
 b=JY1OVTMpQhjHFBqp92swXDSd3UqPPseNsqHPARg/McxPh8aAo/5crS4/LKXI/b1Mx6hCL7+7iZN9flKc/e88CVZM1+rm0D2ettS1kSOmHAPpNNqXV8fVz0GifgurTQs8KAk4+beFqzzld1+AZqwhG0O/I81wFtkQj2KYWJJ0IFcZoPaqykfqly3ferFW6K7FmNp0FL743T8t/aSUVpBHSHQLPo4OXUEw6lOerwC0zPJ8jWuMNgVcp0iILRXG9b1IDT1x1FQRkNWCLB24CuWNRZIjTFDIJuGeG4Sqk/gZnpoMOaYZ4/UjpTsMjWWz2a5NExoiCFC5GcC8hwEtOuI79g==
Received: from DM6PR06CA0076.namprd06.prod.outlook.com (2603:10b6:5:336::9) by
 DS0PR12MB6654.namprd12.prod.outlook.com (2603:10b6:8:d1::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Mon, 23 Mar 2026 10:14:14 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::13) by DM6PR06CA0076.outlook.office365.com
 (2603:10b6:5:336::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 10:14:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 10:14:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Mar
 2026 03:14:02 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Mar
 2026 03:14:00 -0700
From: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
To: <dev@dpdk.org>
CC: <rasland@nvidia.com>, <matan@nvidia.com>, <suanmingm@nvidia.com>,
 <dsosnowski@nvidia.com>, <stable@dpdk.org>
Subject: [PATCH] net/mlx5: cleanup unused olx parameter in Tx free routines
Date: Mon, 23 Mar 2026 12:13:45 +0200
Message-ID: <20260323101345.393740-1-viacheslavo@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|DS0PR12MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: d4d0c245-f4b3-467b-2f00-08de88c4ef19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: VGJN0gBGIy8vaqfaPpiNL/Sf6e3FEtp/+4b19ZZWS94ySrFrIcg7LMs4m4BtxaHw4Bz2x72PSiwYP8v+dGclfydC7OdpbrJHbRCUD1m4WNj1XNFsdC0jYBmNqNjnXiEQxWzrFitD7wwh99Z5udrGbahYXGrAum2zS7vQ6qFOFlM6PjDhNLMRXeuBKDHiGv/1PMMleGPBTQLwWXzzHs2vpAihBmgltUBdA8eEb2L5UCD5bImUvf1DipjCVrRCt+c/CYNBL7jAmofC/5cBVKumuLgcGa226Sv9COqp8x3VHCn1CJggcCnSSX+E6yEyqJ8f95QCAhvsqff8xPOp2OB/OznBRuR6aEBhe/U3DnDTozNTBllTBsKFn4X0dlWE0DH6jfHFuWlRYlgukcHOVDxktnAnx0/472+hkaoQXNMJ7zam5i2i/pVVD1zqKO9yorrFBRoxgjcxoef8K3T8aaX3IlQTrhVPizJhOPLvt7Fe8eIq5dEDLPo8X3osnquUy9Ew8HQo98CxrxBI1uFD1i9uH7A9kXkW08JDesfUMdHjzS2DvHpTX37V7U1bjP+v0Jz0O4D1oN6MAVxGoOjoPh/p1RP3w0isTkyDd3BvjDvQoxO3t/uQevHo1eNHqG4hF4FFCfdJ8/GbsLZDqAtocdvhaMJF5sWzPBc5obtliR718yCk4DTj1fq7aQXeAdumBh4yzmWEWb85+JPE8GnijwLibewlbSzGr0t7HG7X9/LJ6jiZcRYfY4DEGytID6JQE2ke06z4kYsjJvw2aF9H3fpSUQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4SDl0TvlbVRXQQ0onMRzg2AZYkeKK4ACujP5CpX/tV0bGRH8y7o2rLdSxFbPxOrWnDdjOFovm9anDEfEngB3rgxuL8ufDJ9AZf6YuvdkLMBoFZs1CiwXlfzcQ5fZNuP2XsnqomVB0eY16UYVlXKaq45Cf66RfeM/vspcQWnecLF6mMaIxaKFhCu1oI0PRX5pmeTm9pAbTZX/VsvT9nLH3MzXiYsxu3AVhcy3KMF+UWuue6jkXvWPQck59FbdN7OLxl5xbT1Ti0OwVnXoGEhlB3sx0sMO6oTR3NSysbjrzN5r1BgJ/YJlAB988e/gXnzTrXUvC9+APbf7vd/gaNKsUy8ncxx1kw5szQOJv62pEATFrvO+qwJEuJ6b/7GQvxOG3tuDxQlE4xFVGDMRw0gk4HHg8NwvJy36fH/jDvjXMKtJUnJXk5Kd8KRGn8Ess3Rz
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 10:14:13.8024 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4d0c245-f4b3-467b-2f00-08de88c4ef19
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6654
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

The olx parameter is intended to be known in compile time and
widely used for static optimizations while generating the tx_burst
rotuines code from the template.

However, in the mlx5_tx_free_mbuf routine we have the olx parameter
provided in runtime only, for all possible execution paths. And the
only intended optimization (that actually does not happen) is to check
whether multi-buf packets are supported. As fast free offload is not
supported for multi-buf packets, we can simplify the code and get rid of
the unused olx parameter in the entire call chain.

Cc: stable@dpdk.org

Signed-off-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_tx.c | 18 +++++-------------
 drivers/net/mlx5/mlx5_tx.h | 28 +++++++++-------------------
 2 files changed, 14 insertions(+), 32 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_tx.c b/drivers/net/mlx5/mlx5_tx.c
index 8085b5c306..94644bc3b9 100644
--- a/drivers/net/mlx5/mlx5_tx.c
+++ b/drivers/net/mlx5/mlx5_tx.c
@@ -144,14 +144,10 @@ mlx5_tx_error_cqe_handle(struct mlx5_txq_data *__rte_restrict txq,
  *   Pointer to TX queue structure.
  * @param last_cqe
  *   valid CQE pointer, if not NULL update txq->wqe_pi and flush the buffers.
- * @param olx
- *   Configured Tx offloads mask. It is fully defined at
- *   compile time and may be used for optimization.
  */
 static __rte_always_inline void
 mlx5_tx_comp_flush(struct mlx5_txq_data *__rte_restrict txq,
-		   volatile struct mlx5_cqe *last_cqe,
-		   unsigned int olx __rte_unused)
+		   volatile struct mlx5_cqe *last_cqe)
 {
 	if (likely(last_cqe != NULL)) {
 		uint16_t tail;
@@ -159,7 +155,7 @@ mlx5_tx_comp_flush(struct mlx5_txq_data *__rte_restrict txq,
 		txq->wqe_pi = rte_be_to_cpu_16(last_cqe->wqe_counter);
 		tail = txq->fcqs[(txq->cq_ci - 1) & txq->cqe_m];
 		if (likely(tail != txq->elts_tail)) {
-			mlx5_tx_free_elts(txq, tail, olx);
+			mlx5_tx_free_elts(txq, tail);
 			MLX5_ASSERT(tail == txq->elts_tail);
 		}
 	}
@@ -172,16 +168,12 @@ mlx5_tx_comp_flush(struct mlx5_txq_data *__rte_restrict txq,
  *
  * @param txq
  *   Pointer to TX queue structure.
- * @param olx
- *   Configured Tx offloads mask. It is fully defined at
- *   compile time and may be used for optimization.
  *
  * NOTE: not inlined intentionally, it makes tx_burst
  * routine smaller, simple and faster - from experiments.
  */
 void
-mlx5_tx_handle_completion(struct mlx5_txq_data *__rte_restrict txq,
-			  unsigned int olx __rte_unused)
+mlx5_tx_handle_completion(struct mlx5_txq_data *__rte_restrict txq)
 {
 	unsigned int count = MLX5_TX_COMP_MAX_CQE;
 	volatile struct mlx5_cqe *last_cqe = NULL;
@@ -259,7 +251,7 @@ mlx5_tx_handle_completion(struct mlx5_txq_data *__rte_restrict txq,
 		/* Ring doorbell to notify hardware. */
 		rte_compiler_barrier();
 		*txq->cq_db = rte_cpu_to_be_32(txq->cq_ci);
-		mlx5_tx_comp_flush(txq, last_cqe, olx);
+		mlx5_tx_comp_flush(txq, last_cqe);
 	}
 }
 
@@ -280,7 +272,7 @@ mlx5_tx_descriptor_status(void *tx_queue, uint16_t offset)
 	struct mlx5_txq_data *__rte_restrict txq = tx_queue;
 	uint16_t used;
 
-	mlx5_tx_handle_completion(txq, 0);
+	mlx5_tx_handle_completion(txq);
 	used = txq->elts_head - txq->elts_tail;
 	if (offset < used)
 		return RTE_ETH_TX_DESC_FULL;
diff --git a/drivers/net/mlx5/mlx5_tx.h b/drivers/net/mlx5/mlx5_tx.h
index 0134a2e003..48dbb2d867 100644
--- a/drivers/net/mlx5/mlx5_tx.h
+++ b/drivers/net/mlx5/mlx5_tx.h
@@ -234,8 +234,7 @@ struct mlx5_external_q *mlx5_ext_txq_get(struct rte_eth_dev *dev, uint16_t idx);
 
 /* mlx5_tx.c */
 
-void mlx5_tx_handle_completion(struct mlx5_txq_data *__rte_restrict txq,
-			       unsigned int olx __rte_unused);
+void mlx5_tx_handle_completion(struct mlx5_txq_data *__rte_restrict txq);
 int mlx5_tx_descriptor_status(void *tx_queue, uint16_t offset);
 void mlx5_txq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
 		       struct rte_eth_txq_info *qinfo);
@@ -526,15 +525,11 @@ txq_ol_cksum_to_cs(struct rte_mbuf *buf)
  *   Pointer to array of packets to be free.
  * @param pkts_n
  *   Number of packets to be freed.
- * @param olx
- *   Configured Tx offloads mask. It is fully defined at
- *   compile time and may be used for optimization.
  */
 static __rte_always_inline void
 mlx5_tx_free_mbuf(struct mlx5_txq_data *__rte_restrict txq,
 		  struct rte_mbuf **__rte_restrict pkts,
-		  unsigned int pkts_n,
-		  unsigned int olx __rte_unused)
+		  unsigned int pkts_n)
 {
 	struct rte_mempool *pool = NULL;
 	struct rte_mbuf **p_free = NULL;
@@ -552,7 +547,7 @@ mlx5_tx_free_mbuf(struct mlx5_txq_data *__rte_restrict txq,
 	 * Free mbufs directly to the pool in bulk
 	 * if fast free offload is engaged
 	 */
-	if (!MLX5_TXOFF_CONFIG(MULTI) && txq->fast_free) {
+	if (txq->fast_free) {
 		mbuf = *pkts;
 		pool = mbuf->pool;
 		rte_mempool_put_bulk(pool, (void *)pkts, pkts_n);
@@ -642,10 +637,9 @@ mlx5_tx_free_mbuf(struct mlx5_txq_data *__rte_restrict txq,
 static __rte_noinline void
 __mlx5_tx_free_mbuf(struct mlx5_txq_data *__rte_restrict txq,
 		    struct rte_mbuf **__rte_restrict pkts,
-		    unsigned int pkts_n,
-		    unsigned int olx __rte_unused)
+		    unsigned int pkts_n)
 {
-	mlx5_tx_free_mbuf(txq, pkts, pkts_n, olx);
+	mlx5_tx_free_mbuf(txq, pkts, pkts_n);
 }
 
 /**
@@ -655,14 +649,10 @@ __mlx5_tx_free_mbuf(struct mlx5_txq_data *__rte_restrict txq,
  *   Pointer to Tx queue structure.
  * @param tail
  *   Index in elts to free up to, becomes new elts tail.
- * @param olx
- *   Configured Tx offloads mask. It is fully defined at
- *   compile time and may be used for optimization.
  */
 static __rte_always_inline void
 mlx5_tx_free_elts(struct mlx5_txq_data *__rte_restrict txq,
-		  uint16_t tail,
-		  unsigned int olx __rte_unused)
+		  uint16_t tail)
 {
 	uint16_t n_elts = tail - txq->elts_tail;
 
@@ -681,7 +671,7 @@ mlx5_tx_free_elts(struct mlx5_txq_data *__rte_restrict txq,
 		MLX5_ASSERT(part <= txq->elts_s);
 		mlx5_tx_free_mbuf(txq,
 				  &txq->elts[txq->elts_tail & txq->elts_m],
-				  part, olx);
+				  part);
 		txq->elts_tail += part;
 		n_elts -= part;
 	} while (n_elts);
@@ -3580,7 +3570,7 @@ mlx5_tx_burst_tmpl(struct mlx5_txq_data *__rte_restrict txq,
 	 * - doorbell the NIC about processed CQEs
 	 */
 	rte_prefetch0(*(pkts + loc.pkts_sent));
-	mlx5_tx_handle_completion(txq, olx);
+	mlx5_tx_handle_completion(txq);
 	/*
 	 * Calculate the number of available resources - elts and WQEs.
 	 * There are two possible different scenarios:
@@ -3829,7 +3819,7 @@ mlx5_tx_burst_tmpl(struct mlx5_txq_data *__rte_restrict txq,
 	txq->stats.opackets += loc.pkts_sent;
 #endif
 	if (MLX5_TXOFF_CONFIG(INLINE) && loc.mbuf_free)
-		__mlx5_tx_free_mbuf(txq, pkts, loc.mbuf_free, olx);
+		__mlx5_tx_free_mbuf(txq, pkts, loc.mbuf_free);
 	/* Trace productive bursts only. */
 	if (__rte_trace_point_fp_is_enabled() && loc.pkts_sent)
 		rte_pmd_mlx5_trace_tx_exit(mlx5_read_pcibar_clock_from_txq(txq),
-- 
2.34.1

