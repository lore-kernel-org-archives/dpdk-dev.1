Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D11CAC587
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Sep 2025 15:51:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 321DB4066C;
	Tue,  9 Sep 2025 17:50:57 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id D67D440285
 for <dev@dpdk.org>; Tue,  9 Sep 2025 17:50:51 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 0D0F4211AA0F; Tue,  9 Sep 2025 08:50:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0D0F4211AA0F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1757433051;
 bh=MW/df7K8i8VKgWHDYC5TCDiEJjdPcdWQxRqPWzRz8cg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=O9+/5NE8wnJFmfMkkdzmxqWtB1hjZY0DDntdAmbPOhwdZsXM0tB0pntTydKG/6LQq
 gu7M+yyOADGoDyIesIfTFMgnYDPjZ0ya7UBzNrfs1Xk9CEzCnDPvsOcocJnaXnCH2s
 bCwJ+oAocOBMNU47QC59tWEEgpMsQZeTgngwN1L4=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v6 2/3] drivers/net: make code compatible with MSVC
Date: Tue,  9 Sep 2025 08:50:47 -0700
Message-Id: <1757433048-18537-3-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1757433048-18537-1-git-send-email-andremue@linux.microsoft.com>
References: <1735243903-26857-1-git-send-email-andremue@linux.microsoft.com>
 <1757433048-18537-1-git-send-email-andremue@linux.microsoft.com>
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

Removed use of non-standard array range initialization, which is
non-standard and is not supported by MSVC.

Fixed macro mlx5_malloc_numa_tolerant: added missing backslash.

Fixed macro pool_malloc: added missing backslash and added prefix
MLX5_ to "NUMA_TOLERANT" parameter.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 drivers/common/mlx5/mlx5_malloc.h   |  4 ++--
 drivers/net/mlx5/mlx5_rx.c          |  4 ++--
 drivers/net/mlx5/mlx5_utils.c       |  4 ++--
 drivers/net/octeon_ep/otx_ep_mbox.c | 24 ++++++++++++++++++++----
 4 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/common/mlx5/mlx5_malloc.h b/drivers/common/mlx5/mlx5_malloc.h
index 6e5cc3d851..46ea5bc8f0 100644
--- a/drivers/common/mlx5/mlx5_malloc.h
+++ b/drivers/common/mlx5/mlx5_malloc.h
@@ -118,8 +118,8 @@ void mlx5_free(void *addr);
 		mem; \
 	}))
 #else
-#define mlx5_malloc_numa_tolerant(flags, size, align, socket)
-	(mlx5_malloc((flags) | MLX5_NUMA_TOLERANT, (size), (align), (socket)));
+#define mlx5_malloc_numa_tolerant(flags, size, align, socket) \
+	mlx5_malloc((flags) | MLX5_NUMA_TOLERANT, (size), (align), (socket))
 #endif
 #ifdef __cplusplus
 }
diff --git a/drivers/net/mlx5/mlx5_rx.c b/drivers/net/mlx5/mlx5_rx.c
index 271018d6d1..420a03068d 100644
--- a/drivers/net/mlx5/mlx5_rx.c
+++ b/drivers/net/mlx5/mlx5_rx.c
@@ -1093,7 +1093,7 @@ mlx5_rx_burst(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
 				break;
 			}
 			pkt = seg;
-			MLX5_ASSERT(len >= (rxq->crc_present << 2));
+			MLX5_ASSERT(len >= (int)(rxq->crc_present << 2));
 			pkt->ol_flags &= RTE_MBUF_F_EXTERNAL;
 			if (rxq->cqe_comp_layout && mcqe)
 				cqe = &rxq->title_cqe;
@@ -1273,7 +1273,7 @@ mlx5_rx_burst_out_of_order(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts
 		}
 		if (!pkt) {
 			pkt = seg;
-			MLX5_ASSERT(len >= (rxq->crc_present << 2));
+			MLX5_ASSERT(len >= (int)(rxq->crc_present << 2));
 			pkt->ol_flags &= RTE_MBUF_F_EXTERNAL;
 			if (rxq->cqe_comp_layout && mcqe)
 				cqe = &rxq->title_cqe;
diff --git a/drivers/net/mlx5/mlx5_utils.c b/drivers/net/mlx5/mlx5_utils.c
index fc35003a4a..cba8cc3f49 100644
--- a/drivers/net/mlx5/mlx5_utils.c
+++ b/drivers/net/mlx5/mlx5_utils.c
@@ -29,8 +29,8 @@
 	mem; \
 }))
 #else
-#define pool_malloc(pool, flags, size, align, socket)
-	(pool)->cfg.malloc((uint32_t)(flags) | NUMA_TOLERANT, (size), (align), (socket));
+#define pool_malloc(pool, flags, size, align, socket) \
+	((pool)->cfg.malloc((uint32_t)(flags) | MLX5_NUMA_TOLERANT, (size), (align), (socket)))
 #endif
 
 int mlx5_logtype_ipool;
diff --git a/drivers/net/octeon_ep/otx_ep_mbox.c b/drivers/net/octeon_ep/otx_ep_mbox.c
index 1d7e08d2cc..e0fb6842e0 100644
--- a/drivers/net/octeon_ep/otx_ep_mbox.c
+++ b/drivers/net/octeon_ep/otx_ep_mbox.c
@@ -17,10 +17,26 @@
  * with new command and it's version info.
  */
 static uint32_t otx_ep_cmd_versions[OTX_EP_MBOX_CMD_MAX] = {
-	[0 ... OTX_EP_MBOX_CMD_DEV_REMOVE] = OTX_EP_MBOX_VERSION_V1,
-	[OTX_EP_MBOX_CMD_GET_FW_INFO ... OTX_EP_MBOX_NOTIF_LINK_STATUS] = OTX_EP_MBOX_VERSION_V2,
-	[OTX_EP_MBOX_NOTIF_PF_FLR] = OTX_EP_MBOX_VERSION_V3
-
+	/* [0 ... OTX_EP_MBOX_CMD_DEV_REMOVE] = OTX_EP_MBOX_VERSION_V1, */
+	OTX_EP_MBOX_VERSION_V1,
+	OTX_EP_MBOX_VERSION_V1,
+	OTX_EP_MBOX_VERSION_V1,
+	OTX_EP_MBOX_VERSION_V1,
+	OTX_EP_MBOX_VERSION_V1,
+	OTX_EP_MBOX_VERSION_V1,
+	OTX_EP_MBOX_VERSION_V1,
+	OTX_EP_MBOX_VERSION_V1,
+	OTX_EP_MBOX_VERSION_V1,
+	OTX_EP_MBOX_VERSION_V1,
+	OTX_EP_MBOX_VERSION_V1,
+	/* [OTX_EP_MBOX_CMD_GET_FW_INFO ... OTX_EP_MBOX_NOTIF_LINK_STATUS] =
+	 *		OTX_EP_MBOX_VERSION_V2,
+	 */
+	OTX_EP_MBOX_VERSION_V2,
+	OTX_EP_MBOX_VERSION_V2,
+	OTX_EP_MBOX_VERSION_V2,
+	/* [OTX_EP_MBOX_NOTIF_PF_FLR] = OTX_EP_MBOX_VERSION_V3 */
+	OTX_EP_MBOX_VERSION_V3,
 };
 
 static int
-- 
2.50.1.vfs.0.2

