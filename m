Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23925FC72C5
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 12:41:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C34440268;
	Mon, 23 Mar 2026 13:41:53 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010011.outbound.protection.outlook.com [52.101.56.11])
 by mails.dpdk.org (Postfix) with ESMTP id 5BF794025F
 for <dev@dpdk.org>; Mon, 23 Mar 2026 13:41:52 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BEoyK/60fAtArnz+k8jVRvsmROegMB7sLZLjinCdNHovUGLhXueQ29KmRiw/EZbA2+M3sqM62/6wKNXHo9GFAKHiPB2C5S3NuZgFHzBUWMWaWX34G6qfU693Fd79THxLgJTGFzisolK2MlwEzOoDjI85PDltzFsLYFK6dJ9DeehjAqmEHQLYMYKmeVUQdF7OMKLuo5dkGb52VGeXp4vyU+54hPGYOPPpHcaaesr+yjzkecSFxeNljSyN8meAMjKrAnBqmdAvYinf0NMYYLfWm8gf/iWBeSIB6OLK951/4xn5hmLKpHRg/Dqwb/XL/ZkqzRxP4o1yQ6EHS2A5ggJIQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7TqRy0HKqC/tSM5e98SiO0r9/fnMX0FidiN2mM4M0z4=;
 b=uf1hcdyenJmG7irS04+bA5PJgaLdF+rzU4n2vqKXmF7TF2s8c6UtUsVwRIP/Sa8Afxor774lxM1WweyFofIbAEzcqd4mvmCOkpsTPalGh4TwCETcLdiEUHkg/yJg1V43FcWDiLFqG0e1Oy6ynUeem+CMCzv2ojtj31VW0KzscXVdK5Jl/fvXTl/h3DsXJWgSLffFmEnXie8UryaTVxHKg2bVcgy9nqsal3bayOo2oZ3wXvZY/seMDQO3qcnI91wuZWrko73F0QIGIBwFQvyo0Io70jzXh1Us0i9l/WFi/8EvEnsbPt1LUqt20eunbGLN5DGQADZcuwwZZWbNwxEVdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TqRy0HKqC/tSM5e98SiO0r9/fnMX0FidiN2mM4M0z4=;
 b=JplvKj+S/47nfRezrGoICmylMgzQuJKoEd9quJm5q4N1CMxTT3RpgikBpcxw8KvFOKT56oyVTugWYfyKyA2KlCcIQrCEAbPKXK1MgBmgRMD6lAiXXGtl4vylTLuia+P20NxIrFwi8u8jhECD+JGs6Kl9Id77MEFFXJE9wcfESG5L8rKThWku9uXY6iCHOGwmiJZQkHJ4Fzd9FxDd/jTj/1zPCwn69DaJE/7BS4834ECYICgkiEJYlT/RSHj604M9qXcSr0T0SPPvePrG8QR5nxZidl0yGbrS8mzvq4me4ldMs+uCS5kqHZUbnG2ZKjU0OgH7/VB5SG0AmcSNKEPqgQ==
Received: from MN0P223CA0014.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::26)
 by DM4PR12MB7647.namprd12.prod.outlook.com (2603:10b6:8:105::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 12:41:47 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:52b:cafe::4e) by MN0P223CA0014.outlook.office365.com
 (2603:10b6:208:52b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 12:41:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 12:41:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Mar
 2026 05:41:25 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Mar
 2026 05:41:23 -0700
From: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
To: <dev@dpdk.org>
CC: <rasland@nvidia.com>, <matan@nvidia.com>, <suanmingm@nvidia.com>,
 <dsosnowski@nvidia.com>
Subject: [PATCH v2] net/mlx5: cleanup unused olx parameter in Tx free routines
Date: Mon, 23 Mar 2026 14:41:10 +0200
Message-ID: <20260323124110.425154-1-viacheslavo@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323101345.393740-1-viacheslavo@nvidia.com>
References: <20260323101345.393740-1-viacheslavo@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|DM4PR12MB7647:EE_
X-MS-Office365-Filtering-Correlation-Id: 12380a44-11bc-4468-bf53-08de88d98b34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: QZxUlS9NqcFlXCunD5eny9VheWnApry0OreRABp3pR1zywwVumYja8SEB8Nn1MKL0z0aWw1HqXMNS+jWDHDp0SKkRcQGiYoAYXDdARc7DhAGxTsgUwCdpHujB24XBvNiJWVjgM6neWRQuWroWZAOvLbPk5HEN3d1am02a1sBu3Ejn7lMbwEuD1dwoDPlGlpWu66Sp7PWCMz+7REey78pUxraoKFib/J6tkrJymdcTxlQ2bmkpVkMob+1XxSEK7U9zyVpDde0mXwgK6hAt9LvZTpYMIbeLKd8C4tCvcKbXtwVgb2EjyjXbwHNMB/UANr01y2HIRgzG5ATIMaNvnig8bJNvnYt8Ejl/CqZCE96j2/z/mJhb/SYapUvjxIVUR8xoTPxqjznNsOwosWaFvrDQRf9hgEHSene3s0Fp54gMKmi0nP1NnJmNXPN75x/PLJ9t04JGFgnJYjzHLUL84Hd/Lg33gEXuVMWUQPMzg+a4mvn2tRlcQh/ukBbxQBnIo/RRonHzhmbtiTeKnrSLXF2QbtZKGSbDWzn4w2w0EJ+BVKlRfNY3eVaVk9cTH3AHkFo4YyTwspZp1F35WoFAxbUlJahnscxk/Qtv3g+vwAu0o2jgHtuW2uW8KimCyB8Tah8HX6H7QkZj6v3xn3oHolAbbaDdo3X0slSVQI5GHjbReL0mlmeCGwcbUs7TjnnG40UiCSJOJT9P9rED/gftUA+a3BTjM7sr5rwX2jvYWR4lunjq1hTLJZwiCzTa9AO9E3qhkRzUnFOtzk8uCKPfLw9tg==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yJgwqql1c8N66RTivjROcRI+IOixTN2ofjZRm5G9DFwxz0hV91+CtzHZFGrZCoRshJrV3Qsmb0PkvuEuBi0hnKMiLmzOeeE8otR5iSKr992iQsryg2vPMDURNwchtyVwTTaVYYn8Lx7psLMDu86CkSHdYC38y6gVmhd+J4NQzxKDXHJ8j2B4ro5o9TzvScnAOLqtsoBeHQbr+fAqp26JeisrOSqhaLZY74vESwBLW00NKX3eB+KJMxQxH+crpoztRo76xA4Ktd+SqJYt5gCfyhfSKuj9NlV9sYDE8L95wtazd/EigxwL40uCRQX0fTk7+o+bkbA1ksFRskyjFngMR5dl8hH8SIfy+SPo7Xv1PJ5NR4Ouw3BMHQpjSOaE7jzw/RiZAfRYfEMMhSlUVZEyvtL8NUYovnat0MZaQ+quoetWRBQhJfFB00oUbwWSImT7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 12:41:45.6519 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12380a44-11bc-4468-bf53-08de88d98b34
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7647
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

Signed-off-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

---
v2: updated commit message
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
index 2f4402eb50..016dba0b03 100644
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
@@ -511,15 +510,11 @@ txq_ol_cksum_to_cs(struct rte_mbuf *buf)
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
@@ -537,7 +532,7 @@ mlx5_tx_free_mbuf(struct mlx5_txq_data *__rte_restrict txq,
 	 * Free mbufs directly to the pool in bulk
 	 * if fast free offload is engaged
 	 */
-	if (!MLX5_TXOFF_CONFIG(MULTI) && txq->fast_free) {
+	if (txq->fast_free) {
 		mbuf = *pkts;
 		pool = mbuf->pool;
 		rte_mempool_put_bulk(pool, (void *)pkts, pkts_n);
@@ -627,10 +622,9 @@ mlx5_tx_free_mbuf(struct mlx5_txq_data *__rte_restrict txq,
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
@@ -640,14 +634,10 @@ __mlx5_tx_free_mbuf(struct mlx5_txq_data *__rte_restrict txq,
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
 
@@ -666,7 +656,7 @@ mlx5_tx_free_elts(struct mlx5_txq_data *__rte_restrict txq,
 		MLX5_ASSERT(part <= txq->elts_s);
 		mlx5_tx_free_mbuf(txq,
 				  &txq->elts[txq->elts_tail & txq->elts_m],
-				  part, olx);
+				  part);
 		txq->elts_tail += part;
 		n_elts -= part;
 	} while (n_elts);
@@ -3565,7 +3555,7 @@ mlx5_tx_burst_tmpl(struct mlx5_txq_data *__rte_restrict txq,
 	 * - doorbell the NIC about processed CQEs
 	 */
 	rte_prefetch0(*(pkts + loc.pkts_sent));
-	mlx5_tx_handle_completion(txq, olx);
+	mlx5_tx_handle_completion(txq);
 	/*
 	 * Calculate the number of available resources - elts and WQEs.
 	 * There are two possible different scenarios:
@@ -3814,7 +3804,7 @@ mlx5_tx_burst_tmpl(struct mlx5_txq_data *__rte_restrict txq,
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

