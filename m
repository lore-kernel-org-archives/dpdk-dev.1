Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04178C79FB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 13:53:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE32B42DC1;
	Thu, 10 Sep 2026 15:52:20 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 278BF427D4
 for <dev@dpdk.org>; Thu, 10 Sep 2026 15:52:16 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0BCAA1A0446;
 Thu, 10 Sep 2026 15:52:16 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CACFA1A0054;
 Thu, 10 Sep 2026 15:52:15 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id C2F9418000B6;
 Thu, 10 Sep 2026 21:52:14 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v2 11/47] dma/dpaa2: optimize context index ring enqueue
Date: Thu, 10 Sep 2026 19:21:22 +0530
Message-ID: <20260910135158.2181141-12-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910135158.2181141-1-prashant.gupta_3@nxp.com>
References: <20260903135353.3358303-1-prashant.gupta_3@nxp.com>
 <20260910135158.2181141-1-prashant.gupta_3@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

From: Gagandeep Singh <g.singh@nxp.com>

qdma_cntx_idx_ring_eq() copied the context indices into the ring one
element at a time in a loop, updating the tail on every iteration.

Replace the per-element loop with rte_memcpy(), handling the ring
wrap-around as at most two contiguous copies, and update the tail once.
This reduces the per-burst overhead on the dequeue completion path.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/dma/dpaa2/dpaa2_qdma.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/dpaa2/dpaa2_qdma.c b/drivers/dma/dpaa2/dpaa2_qdma.c
index 8a180ab400..277be37b41 100644
--- a/drivers/dma/dpaa2/dpaa2_qdma.c
+++ b/drivers/dma/dpaa2/dpaa2_qdma.c
@@ -66,15 +66,23 @@ qdma_cntx_idx_ring_eq(struct qdma_cntx_idx_ring *ring,
 	const uint16_t *elem, uint16_t nb,
 	uint16_t *free_space)
 {
-	uint16_t i;
-
 	if (unlikely(nb > ring->free_space))
 		return 0;
 
-	for (i = 0; i < nb; i++) {
-		ring->cntx_idx_ring[ring->tail] = elem[i];
-		ring->tail = (ring->tail + 1) &
-			(DPAA2_QDMA_MAX_DESC - 1);
+	if ((ring->tail + nb) < DPAA2_QDMA_MAX_DESC) {
+		rte_memcpy(&ring->cntx_idx_ring[ring->tail],
+			elem, nb * sizeof(uint16_t));
+		ring->tail += nb;
+	} else {
+		rte_memcpy(&ring->cntx_idx_ring[ring->tail],
+			elem,
+			(DPAA2_QDMA_MAX_DESC - ring->tail) *
+			sizeof(uint16_t));
+		rte_memcpy(&ring->cntx_idx_ring[0],
+			&elem[DPAA2_QDMA_MAX_DESC - ring->tail],
+			(nb - DPAA2_QDMA_MAX_DESC + ring->tail) *
+			sizeof(uint16_t));
+		ring->tail = (ring->tail + nb) & (DPAA2_QDMA_MAX_DESC - 1);
 	}
 	ring->free_space -= nb;
 	ring->nb_in_ring += nb;
-- 
2.43.0

