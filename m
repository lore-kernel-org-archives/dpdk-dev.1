Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E840CC83F09
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 15:12:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C844540292;
	Tue,  8 Jul 2025 17:12:01 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id D17CD4025E
 for <dev@dpdk.org>; Tue,  8 Jul 2025 17:11:59 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 29CD0201659E; Tue,  8 Jul 2025 08:11:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 29CD0201659E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1751987519;
 bh=R9KcnOADMer4IzIyeNCkhNkfLd+qrKcPhWQVLTvw3tA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fjQHKm/azaaLapdBuKP/X4hGMM4lXxHP6lOEM4NdPeMlyS6Q6d5pByUyuNKjmbpBs
 DWv//3h6DlD+rbvbuD9wmYMmO757UNmhHSC6kAfinJwXBtIUsXbPp9EwXlId1Z/qEg
 R+YQUplbI36TI79V7kWf4+W0y7D64FRh0jxhTc6I=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: bingz@nvidia.com, dev@dpdk.org, dsosnowski@nvidia.com, matan@nvidia.com,
 orika@nvidia.com, suanmingm@nvidia.com, viacheslavo@nvidia.com,
 mkashani@nvidia.com
Subject: [PATCH v3] net/mlx5: remove use of sizeof(rte_v128u32_t)
Date: Tue,  8 Jul 2025 08:11:56 -0700
Message-Id: <1751987516-30482-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1746457823-11135-1-git-send-email-andremue@linux.microsoft.com>
References: <1746457823-11135-1-git-send-email-andremue@linux.microsoft.com>
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

The reference to rte_v128u32_t (in code and in names) can be removed,
because the code which relies on MLX5_ESEG_MIN_INLINE_SIZE does not
really use rte_v128u32_t type. The relevant code e.g.,
in mlx5_tx_eseg_dmin(), always copies first 2 bytes of the packet
(through uint16_t pointer, these would be first 2 bytes of destination
MAC address) and then does one of the two:

1. Copies following 16 bytes using rte_mov16().
   (Corresponds to first static_assert for MLX5_ESEG_MIN_INLINE_SIZE).
2. If there is a VLAN defined in mbuf, then:
   - the rest of destination MAC address is copied,
   - source MAC address is copied,
   - VLAN is inserted,
   - 2 bytes appearing after VLAN header are copied.
   (Corresponds to 2nd static_assert for MLX5_ESEG_MIN_INLINE_SIZE).

The amount of data copied is inferred from HW arch and packet descriptor
layout, not rte_v128u32_t.

Since rte_mov16() is used in real code and rte_v128u32_t is only used to
carry over the length of the copy, this patch replaces instances of
sizeof(rte_v128u32_t) with a macro named MLX5_SIZE_MOV16 to better
reflect the real usage in mlx5 PMD.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 drivers/net/mlx5/mlx5_defs.h | 2 ++
 drivers/net/mlx5/mlx5_rxtx.c | 6 +++---
 drivers/net/mlx5/mlx5_tx.h   | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_defs.h b/drivers/net/mlx5/mlx5_defs.h
index 9c454983be..d326fec000 100644
--- a/drivers/net/mlx5/mlx5_defs.h
+++ b/drivers/net/mlx5/mlx5_defs.h
@@ -196,4 +196,6 @@
 
 #define MLX5_CNT_SVC_CYCLE_TIME_DEFAULT 500
 
+#define MLX5_SIZE_MOV16 16
+
 #endif /* RTE_PMD_MLX5_DEFS_H_ */
diff --git a/drivers/net/mlx5/mlx5_rxtx.c b/drivers/net/mlx5/mlx5_rxtx.c
index 9c075f6a56..82c5481ad7 100644
--- a/drivers/net/mlx5/mlx5_rxtx.c
+++ b/drivers/net/mlx5/mlx5_rxtx.c
@@ -32,7 +32,7 @@ static_assert(MLX5_CQE_STATUS_HW_OWN < 0, "Must be negative value");
 static_assert(MLX5_CQE_STATUS_SW_OWN < 0, "Must be negative value");
 static_assert(MLX5_ESEG_MIN_INLINE_SIZE ==
 		(sizeof(uint16_t) +
-		 sizeof(rte_v128u32_t)),
+		MLX5_SIZE_MOV16),
 		"invalid Ethernet Segment data size");
 static_assert(MLX5_ESEG_MIN_INLINE_SIZE ==
 		(sizeof(uint16_t) +
@@ -41,7 +41,7 @@ static_assert(MLX5_ESEG_MIN_INLINE_SIZE ==
 		"invalid Ethernet Segment data size");
 static_assert(MLX5_ESEG_MIN_INLINE_SIZE ==
 		(sizeof(uint16_t) +
-		 sizeof(rte_v128u32_t)),
+		MLX5_SIZE_MOV16),
 		"invalid Ethernet Segment data size");
 static_assert(MLX5_ESEG_MIN_INLINE_SIZE ==
 		(sizeof(uint16_t) +
@@ -50,7 +50,7 @@ static_assert(MLX5_ESEG_MIN_INLINE_SIZE ==
 		"invalid Ethernet Segment data size");
 static_assert(MLX5_ESEG_MIN_INLINE_SIZE ==
 		(sizeof(uint16_t) +
-		 sizeof(rte_v128u32_t)),
+		MLX5_SIZE_MOV16),
 		"invalid Ethernet Segment data size");
 static_assert(MLX5_ESEG_MIN_INLINE_SIZE ==
 		(sizeof(uint16_t) +
diff --git a/drivers/net/mlx5/mlx5_tx.h b/drivers/net/mlx5/mlx5_tx.h
index 94f2028513..16307206e2 100644
--- a/drivers/net/mlx5/mlx5_tx.h
+++ b/drivers/net/mlx5/mlx5_tx.h
@@ -1147,7 +1147,7 @@ mlx5_tx_eseg_data(struct mlx5_txq_data *__rte_restrict txq,
 	} else {
 		/* Fill the gap in the title WQEBB with inline data. */
 		rte_mov16(pdst, psrc);
-		psrc += sizeof(rte_v128u32_t);
+		psrc += MLX5_SIZE_MOV16;
 	}
 	pdst = (uint8_t *)(es + 2);
 	MLX5_ASSERT(inlen >= MLX5_ESEG_MIN_INLINE_SIZE);
-- 
2.49.0.vfs.0.4

