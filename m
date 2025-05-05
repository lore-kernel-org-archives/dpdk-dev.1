Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AA7C3ABB0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 15:10:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 986E34025D;
	Mon,  5 May 2025 17:10:29 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 544A44003C
 for <dev@dpdk.org>; Mon,  5 May 2025 17:10:28 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 442EE2115DB4; Mon,  5 May 2025 08:10:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 442EE2115DB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1746457827;
 bh=hjnhI+a2zBiB9M0AH5Lw2HpZ6cKUaSrcsf1cacSiFw4=;
 h=From:To:Cc:Subject:Date:From;
 b=qlEo/WwZzxxXTg+Vtl8r0YtBsKAIqYDWKOydbIYkmXgBrB3+IIV4aYWmAEWUzFwj0
 QsgEqlprmg692mmEwH5lYjWzIMJmTG7CFjgdiNPxJCRYwyirOUqgau4/Qs8K9cuspv
 nTf/vsoiI/TFhwSs/mKYplq+oLdtDxX1+/HWGZ50=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Cc: dev@dpdk.org,
	Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH] net/mlx5: declare size of rte_v128u32_t
Date: Mon,  5 May 2025 08:10:23 -0700
Message-Id: <1746457823-11135-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
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

When compiling with MSVC the error below is hit:

drivers\net\mlx5\mlx5_tx.h(1148): error C2065: 'rte_v128u32_t':
    undeclared identifier

Turns out that with MSVC the data type rte_v128u32_t is not used, but
its size needs to be known. This patch defines a macro to store that
size and replaces instances of sizeof(rte_v128u32_t) with that macro.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 drivers/net/mlx5/mlx5_defs.h | 2 ++
 drivers/net/mlx5/mlx5_rxtx.c | 6 +++---
 drivers/net/mlx5/mlx5_tx.h   | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_defs.h b/drivers/net/mlx5/mlx5_defs.h
index 9c454983be..c5e2c59309 100644
--- a/drivers/net/mlx5/mlx5_defs.h
+++ b/drivers/net/mlx5/mlx5_defs.h
@@ -196,4 +196,6 @@
 
 #define MLX5_CNT_SVC_CYCLE_TIME_DEFAULT 500
 
+#define MLX5_SIZEOF_V128U32_T 16
+
 #endif /* RTE_PMD_MLX5_DEFS_H_ */
diff --git a/drivers/net/mlx5/mlx5_rxtx.c b/drivers/net/mlx5/mlx5_rxtx.c
index 9c075f6a56..b30d620f54 100644
--- a/drivers/net/mlx5/mlx5_rxtx.c
+++ b/drivers/net/mlx5/mlx5_rxtx.c
@@ -32,7 +32,7 @@ static_assert(MLX5_CQE_STATUS_HW_OWN < 0, "Must be negative value");
 static_assert(MLX5_CQE_STATUS_SW_OWN < 0, "Must be negative value");
 static_assert(MLX5_ESEG_MIN_INLINE_SIZE ==
 		(sizeof(uint16_t) +
-		 sizeof(rte_v128u32_t)),
+		MLX5_SIZEOF_V128U32_T),
 		"invalid Ethernet Segment data size");
 static_assert(MLX5_ESEG_MIN_INLINE_SIZE ==
 		(sizeof(uint16_t) +
@@ -41,7 +41,7 @@ static_assert(MLX5_ESEG_MIN_INLINE_SIZE ==
 		"invalid Ethernet Segment data size");
 static_assert(MLX5_ESEG_MIN_INLINE_SIZE ==
 		(sizeof(uint16_t) +
-		 sizeof(rte_v128u32_t)),
+		MLX5_SIZEOF_V128U32_T),
 		"invalid Ethernet Segment data size");
 static_assert(MLX5_ESEG_MIN_INLINE_SIZE ==
 		(sizeof(uint16_t) +
@@ -50,7 +50,7 @@ static_assert(MLX5_ESEG_MIN_INLINE_SIZE ==
 		"invalid Ethernet Segment data size");
 static_assert(MLX5_ESEG_MIN_INLINE_SIZE ==
 		(sizeof(uint16_t) +
-		 sizeof(rte_v128u32_t)),
+		MLX5_SIZEOF_V128U32_T),
 		"invalid Ethernet Segment data size");
 static_assert(MLX5_ESEG_MIN_INLINE_SIZE ==
 		(sizeof(uint16_t) +
diff --git a/drivers/net/mlx5/mlx5_tx.h b/drivers/net/mlx5/mlx5_tx.h
index 55568c41b1..5647f6a37d 100644
--- a/drivers/net/mlx5/mlx5_tx.h
+++ b/drivers/net/mlx5/mlx5_tx.h
@@ -1145,7 +1145,7 @@ mlx5_tx_eseg_data(struct mlx5_txq_data *__rte_restrict txq,
 	} else {
 		/* Fill the gap in the title WQEBB with inline data. */
 		rte_mov16(pdst, psrc);
-		psrc += sizeof(rte_v128u32_t);
+		psrc += MLX5_SIZEOF_V128U32_T;
 	}
 	pdst = (uint8_t *)(es + 2);
 	MLX5_ASSERT(inlen >= MLX5_ESEG_MIN_INLINE_SIZE);
-- 
2.49.0.vfs.0.0

