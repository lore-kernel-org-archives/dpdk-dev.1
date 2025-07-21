Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531EEC83F25
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 15:25:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7E44406B8;
	Mon, 21 Jul 2025 17:24:57 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 170D740668
 for <dev@dpdk.org>; Mon, 21 Jul 2025 17:24:53 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 582132114265; Mon, 21 Jul 2025 08:24:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 582132114265
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1753111492;
 bh=1EacsaE8lUvTbF3bedFn7LBKEEy1VhFeeVn0o2TOmgs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=h6vY0G+uSCe95+Ks5oMGRXAGRm9/hXimyye6M58TatXeyYvygBimQSPtmP/xPSk9k
 dzLul2ZtEhQTr8R6KyhO2pC0F4ri/eE/vz1cuubXorxHftdszOXDCB1HZbeLm+YMvP
 F7W0dRx571KIOFpdc26ArFoX4bMjeDG8SO/w+F14=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v4 2/3] drivers/net: remove use of non-standard array range
 initialization
Date: Mon, 21 Jul 2025 08:24:43 -0700
Message-Id: <1753111484-27021-3-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1753111484-27021-1-git-send-email-andremue@linux.microsoft.com>
References: <1735243903-26857-1-git-send-email-andremue@linux.microsoft.com>
 <1753111484-27021-1-git-send-email-andremue@linux.microsoft.com>
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

Array range initialization is non-standard and is not provided by
all compilers. MSVC does not implement it and ends up emitting
errors like the one below:

drivers/net/r8169/r8169_phy.c(380):
    error C2143: syntax error: missing ':' before '...'
case CFG_METHOD_48 ... CFG_METHOD_57:

The fix is to explicitly initialize each element in the range.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
Acked-by: Howard Wang <howard_wang@realsil.com.cn>
---
 drivers/common/mlx5/mlx5_malloc.h   |  4 ++--
 drivers/net/mlx5/mlx5_flow_dv.c     |  5 ++++-
 drivers/net/mlx5/mlx5_rx.c          |  4 ++--
 drivers/net/mlx5/mlx5_utils.c       |  4 ++--
 drivers/net/octeon_ep/otx_ep_mbox.c | 24 ++++++++++++++++++++----
 5 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/common/mlx5/mlx5_malloc.h b/drivers/common/mlx5/mlx5_malloc.h
index 6e5cc3d851..27d3e5bdf2 100644
--- a/drivers/common/mlx5/mlx5_malloc.h
+++ b/drivers/common/mlx5/mlx5_malloc.h
@@ -118,8 +118,8 @@ void mlx5_free(void *addr);
 		mem; \
 	}))
 #else
-#define mlx5_malloc_numa_tolerant(flags, size, align, socket)
-	(mlx5_malloc((flags) | MLX5_NUMA_TOLERANT, (size), (align), (socket)));
+#define mlx5_malloc_numa_tolerant(flags, size, align, socket) \
+	(mlx5_malloc((flags) | MLX5_NUMA_TOLERANT, (size), (align), (socket)))
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
index f31b1652bc..c95e69b40f 100644
--- a/drivers/net/mlx5/mlx5_utils.c
+++ b/drivers/net/mlx5/mlx5_utils.c
@@ -29,8 +29,8 @@
 	mem; \
 }))
 #else
-#define pool_malloc(pool, flags, size, align, socket)
-	(pool)->cfg.malloc((uint32_t)(flags) | NUMA_TOLERANT, (size), (align), (socket));
+#define pool_malloc(pool, flags, size, align, socket) \
+	(((pool)->cfg.malloc(((uint32_t)(flags) | MLX5_NUMA_TOLERANT), (size), (align), (socket))))
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
2.50.1.vfs.0.0

