Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC000CA0EEB
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 Aug 2025 01:01:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E929B4065E;
	Wed, 20 Aug 2025 03:01:07 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 66A7340395
 for <dev@dpdk.org>; Wed, 20 Aug 2025 03:01:04 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 888FA2115A59; Tue, 19 Aug 2025 18:01:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 888FA2115A59
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1755651663;
 bh=+14x/TJTi41EhyYw9HsFkymIWdPAkIu8yJwcpRv7NpY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZL7CW+TlCsVYCHDnRejfClTHZ9MJO8OaYe8wNpwlXsGKz2e17d2xkoSUgzE5IrLrR
 Xjekgrq6Gg5sCzHvJhVRuDUBnWKxYRqybYNGIe4hJ0V/oQRxBDDzrLm97gl/LJFkku
 lQa5r6mTNzqi5lyGxWDoTfX2YP9w8rEbANGGMKZE=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v5 2/3] drivers/net: make code compatible with MSVC
Date: Tue, 19 Aug 2025 18:00:57 -0700
Message-Id: <1755651658-13063-3-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1755651658-13063-1-git-send-email-andremue@linux.microsoft.com>
References: <1735243903-26857-1-git-send-email-andremue@linux.microsoft.com>
 <1755651658-13063-1-git-send-email-andremue@linux.microsoft.com>
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

Added temporary workaround for bug
(https://bugs.dpdk.org/show_bug.cgi?id=1758).

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 drivers/common/mlx5/mlx5_malloc.h   |  4 ++--
 drivers/net/mlx5/mlx5_flow_dv.c     |  5 ++++-
 drivers/net/mlx5/mlx5_rx.c          |  4 ++--
 drivers/net/mlx5/mlx5_utils.c       |  4 ++--
 drivers/net/octeon_ep/otx_ep_mbox.c | 24 ++++++++++++++++++++----
 5 files changed, 30 insertions(+), 11 deletions(-)

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
diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
index 7b9e5018b8..54e1d0490a 100644
--- a/drivers/net/mlx5/mlx5_flow_dv.c
+++ b/drivers/net/mlx5/mlx5_flow_dv.c
@@ -19652,7 +19652,10 @@ mlx5_flow_dv_discover_counter_offset_support(struct rte_eth_dev *dev)
 		.size = sizeof(value.buf),
 	};
 	struct mlx5dv_flow_matcher_attr dv_attr = {
-		.type = IBV_FLOW_ATTR_NORMAL | IBV_FLOW_ATTR_FLAGS_EGRESS,
+		/* Cast below is needed to avoid warning until bug
+		 * (https://bugs.dpdk.org/show_bug.cgi?id=1758) is fixed.
+		 */
+		.type = IBV_FLOW_ATTR_NORMAL | (enum ibv_flow_attr_type)IBV_FLOW_ATTR_FLAGS_EGRESS,
 		.priority = 0,
 		.match_criteria_enable = 0,
 		.match_mask = (void *)&mask,
diff --git a/drivers/net/mlx5/mlx5_rx.c b/drivers/net/mlx5/mlx5_rx.c
index 5e8c312d00..1385b23d94 100644
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
index f31b1652bc..b5b8a13f51 100644
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
2.50.1.vfs.0.1

