Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13700606A331
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 09:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=T1NNsDlY
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25FA64026F;
	Tue, 17 Nov 2026 10:33:04 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010001.outbound.protection.outlook.com [52.101.61.1])
 by mails.dpdk.org (Postfix) with ESMTPS id 6C6CA40041;
 Tue, 17 Nov 2026 10:33:02 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uncRl8vb4G0aRPsIfY3zGM8EFYtTmWaMV0bQykThkGq98WHdkqio1QDpJZaOA8cm7QdFoPxskzDp4xeV00QSibAn5/Haqx1353OcpqeYxBLyqP81eHg4xBcUcfJgapqlolNX+d8OxPhiHwc60FxsPeoPoen9grGZInGdlsUp7EOXrFUKIHQyp+y5lyIU2b3BZQJ/bsgdC7QoxZrbczsQ4SJK5qhv+ua8LYQgULRzP7v+k7u+6xIaLIEjC9/riU/z8Xd6KjuK0aNyC6zc/eiLN0lIHp4Ys+gYGcrdXAqy7OTd0dyc7tY1nA1iHD5QqCB/MO+5jqApQCdUg0ca34eNww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGdAu6cdz291gPcbx1LNtvJRZObVMMNG81KLBU7+Cbc=;
 b=a4AVERCJA5QENHgV5gJ+2urq1E443G+omKoKs4wyVtTxVOiWEW6rgtzEsC4zMYBS1kvCy57beOjTGizS1lv8gtQEsr+EGSEo0SjILyHOWsaH4ct5lT29hts4ComCZD/Cf2O+UBUPWH1GCFzY/SPDiPqtrisml862EocyKdW4y3UrzZWIGRNF5PMQwzwWTEbYUaJi7fnvNHmUylhfYPR9slA/gvL/8RFqvvIl8GaFoYttsdPsG7zEMG8xts5w+BPqYQWecmw5dJCppPIlZfrDPAzs0h66o2ycgcB9ZK5Bq6BrcqqOyHOY5rTU+paly8rq+nCDyo9sJ2DbQa6tACnKYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGdAu6cdz291gPcbx1LNtvJRZObVMMNG81KLBU7+Cbc=;
 b=T1NNsDlYdYuaIZ/P7x09jKoARZLQYYUphesme7ckrikEyHSGzoZgKLZ9dVTw1ZvsaytWzVCq0PXc+fRwDc32e0fEmDqyYn/zZWZJdzxaadeyJMBqxqqSlSq/CDk54kjHERVdKTgC84HQmVMdtYwr0DnW21/9ZAizcsDPVltho6cb5yVnWm0kBTj8UHSS2MwMPp1In7efxcdmjXW8xCms/QaZw2Xr3qqSEriVeuGi+pzav+RhrQIAfFbs4y2Jwm175eg928q4cxEkLlA7UKEus/Ql0I5mJ4RMZ/eWW1Ha53KZdwhp1nTuXchbJjI8l+Ztbi9ZCpri+4tZ77Cehj1Big==
Received: from CH0PR04CA0054.namprd04.prod.outlook.com (2603:10b6:610:77::29)
 by SJ2PR12MB8691.namprd12.prod.outlook.com (2603:10b6:a03:541::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Tue, 17 Nov
 2026 09:32:03 +0000
Received: from DS2PEPF00007107.namprd05.prod.outlook.com
 (2603:10b6:610:77:cafe::a6) by CH0PR04CA0054.outlook.office365.com
 (2603:10b6:610:77::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Tue, 17
 Nov 2026 09:32:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00007107.mail.protection.outlook.com (10.167.23.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 09:32:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 17 Nov
 2026 01:31:45 -0800
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 17 Nov
 2026 01:31:42 -0800
From: Bing Zhao <bingz@nvidia.com>
To: <rasland@nvidia.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, <dsosnowski@nvidia.com>,
 <viacheslavo@nvidia.com>, <orika@nvidia.com>, <suanmingm@nvidia.com>,
 <matan@nvidia.com>, <bingz@nvidia.com>
Subject: [PATCH] net/mlx5: fix Tx completion index wrap
Date: Tue, 17 Nov 2026 09:31:28 +0000
Message-ID: <20261117093128.1791266-1-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00007107:EE_|SJ2PR12MB8691:EE_
X-MS-Office365-Filtering-Correlation-Id: e120fdb8-f6ea-4b4b-99e5-08df448da2c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|261022075727099003|10067099003|56012099006|11063799006|261026121527099003|261021123027099003|261102123227099003|261021121427099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info: oO0dji+1b/7SIvmDI177Vh9pHQKs2Z0TZZzRL2h7FFZtMi+4410KqETdF4N9KnbKxtPB0ZOyv/CDrii71N0yOW91GFAUs4XbEzJ5gQiZSEdMCDu9SuXKtSXaZldWrvwrMWiuz2v3qy9MfWeLdmzKYl98dc1vlwDkzv30HZ0dOYFT32CJ3W0DohzKHTHi9HLlFCrsnpRG9jR/2AP7fm5V5FJ98vRYj3VcfDvoZ+/dIN8cABi2cfa/g2eC19ZJctIUEI7P/Ec5zbuoNreccu6Jic3nI0rrqnftD2DSuJSnFr4PG0uWYnD1+efJNP1LLKnXx9vn2KAIHXVEmosENPEe7rtkq0eVRhxN+WB8H4cm4+1IvFaCtH3N1ai01RXgcgR5esXfkrTdC9tf8yzmiGfSAbonOmVO2a0sGX1A9pPB0Ri05XkdvyWT6DeTp9dSxNIYfW/riDBjGfUUt4a6+Wa6NRZl4oTiaZoSO8ljCfIGMYhpawxwiofF8rytsHxEPJX+s0EcV6E6rDH3Jw2nBeh3/tbgH4U0ZUKrVDhC7wcAWsxMHI7JqQpF7EX7quHUq45fs9a41Th3Rxyie8+cTlCnmZg0t0wGkzhJUyHnqfrLA5JPRWyDoCqUkoeeAWYCjo9cRK0ynznIinOMv49kA++YH7toH7E75NBWQDeu8wJpCeCFWCZ4MxQ+I22dlE3bem+M70hOl3IdQxlTqx4VuduQ0A==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(261022075727099003)(10067099003)(56012099006)(11063799006)(261026121527099003)(261021123027099003)(261102123227099003)(261021121427099003)(261009223027099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TnyxBgL79YWJcZFQCX6eAVKAkpAKQPbT3I1OnsrnvXdxZvNJ6Y58mib9J8N+eHtDa6R21TMIWEX29Cortc4IxES/oogmmZXT1yIqJEtAzWMJ/4TU+J6BxpqIO4ddwyskMsdGX+HOwKE2kh/zFW88OPlsIQPUw9tfyiRCP4ICj/ReZLfwLrBUx+TB1+76LohNbta10/PMsU/qGBHUS5MCFmYI90WupngtHD2pjQksOVmwI2jKfsalebfahCJuhAkbIFGkBvCbGQaAXBKSO6xW96zYLNSuFYk8gYLE7kM/fvFjaOjzG96PLYXk1W+0bOW9BfZmEplVUycTX5WcReTOOR6GmYpl4wcgCYTztymBrDuEflLnDCVYMDiOKWBCOMjLD9frEbIxKHlJgJFLBMZdA0wFpfT10Tsv0zAkpFspVyLjCbCfycDNkIIaY/Li6AaW
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 09:32:02.0506 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e120fdb8-f6ea-4b4b-99e5-08df448da2c6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00007107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8691
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Tx CQ consumer index is kept as a 16-bit counter and written into the
24-bit CQ doorbell. Once the counter passes 65535, the doorbell wraps to
zero while the device producer continues, so the CQ is reported in overrun
and Tx stalls.

Widen both CQ indices to 32 bits and mask the doorbell with the 24-bit
consumer index mask. The producer index must widen too because it is
assigned from the consumer index.

Fixes: 1d88ba171942 ("net/mlx5: refactor Tx data path")
Cc: stable@dpdk.org

Signed-off-by: Bing Zhao <bingz@nvidia.com>
Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
---
 drivers/net/mlx5/mlx5_tx.c  | 2 +-
 drivers/net/mlx5/mlx5_tx.h  | 4 ++--
 drivers/net/mlx5/mlx5_txq.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_tx.c b/drivers/net/mlx5/mlx5_tx.c
index 89e38091b4..ca3e68646b 100644
--- a/drivers/net/mlx5/mlx5_tx.c
+++ b/drivers/net/mlx5/mlx5_tx.c
@@ -251,7 +251,7 @@ mlx5_tx_handle_completion(struct mlx5_txq_data *__rte_restrict txq)
 	if (likely(ring_doorbell)) {
 		/* Ring doorbell to notify hardware. */
 		rte_compiler_barrier();
-		*txq->cq_db = rte_cpu_to_be_32(txq->cq_ci);
+		*txq->cq_db = rte_cpu_to_be_32(txq->cq_ci & MLX5_CI_MASK);
 		mlx5_tx_comp_flush(txq, last_cqe);
 	}
 }
diff --git a/drivers/net/mlx5/mlx5_tx.h b/drivers/net/mlx5/mlx5_tx.h
index 69a18f8a49..5a5581abd1 100644
--- a/drivers/net/mlx5/mlx5_tx.h
+++ b/drivers/net/mlx5/mlx5_tx.h
@@ -126,9 +126,9 @@ struct __rte_cache_aligned mlx5_txq_data {
 	uint16_t wqe_comp; /* WQE index since last completion request. */
 	uint16_t wqe_thres; /* WQE threshold to request completion in CQ. */
 	/* WQ related fields. */
-	uint16_t cq_ci; /* Consumer index for completion queue. */
-	uint16_t cq_pi; /* Production index for completion queue. */
 	uint16_t cqe_s; /* Number of CQ elements. */
+	uint32_t cq_ci; /* Consumer index for completion queue (doorbell takes low 24 bits). */
+	uint32_t cq_pi; /* Production index for completion queue. */
 	uint16_t cqe_m; /* Mask for CQ indices. */
 	/* CQ related fields. */
 	uint16_t elts_n:4; /* elts[] length (in log2). */
diff --git a/drivers/net/mlx5/mlx5_txq.c b/drivers/net/mlx5/mlx5_txq.c
index f9b254c6c5..693c7f516e 100644
--- a/drivers/net/mlx5/mlx5_txq.c
+++ b/drivers/net/mlx5/mlx5_txq.c
@@ -171,7 +171,7 @@ txq_sync_cq(struct mlx5_txq_data *txq)
 	}
 	/* Resync CQE and WQE (WQ in reset state). */
 	rte_io_wmb();
-	*txq->cq_db = rte_cpu_to_be_32(txq->cq_ci);
+	*txq->cq_db = rte_cpu_to_be_32(txq->cq_ci & MLX5_CI_MASK);
 	txq->cq_pi = txq->cq_ci;
 	rte_io_wmb();
 }
-- 
2.34.1
