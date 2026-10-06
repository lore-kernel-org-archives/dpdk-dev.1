Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD30CA5FFC
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 15:08:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CBDD5410FA;
	Tue,  6 Oct 2026 17:07:57 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 22BF2410EE
 for <dev@dpdk.org>; Tue,  6 Oct 2026 17:07:57 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 04D501A0010;
 Tue,  6 Oct 2026 17:07:57 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C12781A0005;
 Tue,  6 Oct 2026 17:07:56 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 6C9DD1800226;
 Tue,  6 Oct 2026 23:07:55 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v6-S1 3/6] dma/dpaa2: use memcpy to fill completion index ring
Date: Tue,  6 Oct 2026 20:37:46 +0530
Message-ID: <20261006150749.3591526-4-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261006150749.3591526-1-prashant.gupta_3@nxp.com>
References: <20260929142117.3109066-1-prashant.gupta_3@nxp.com>
 <20261006150749.3591526-1-prashant.gupta_3@nxp.com>
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

From: Jun Yang <jun.yang@nxp.com>

qdma_cntx_idx_ring_eq() copied the completion indices into the ring one
element at a time, masking the tail against DPAA2_QDMA_MAX_DESC on every
iteration. The number of elements and the available free space are both
known on entry, so the per-element masking is avoidable work in the
dequeue path.

Replace the loop with at most two memcpy() calls, one for the region up
to the end of the ring and one for the wrapped remainder, and advance
ring->tail by the full count once.

No functional change.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
Signed-off-by: Prashant Gupta <prashant.gupta_3@nxp.com>
---
 drivers/dma/dpaa2/dpaa2_qdma.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/dpaa2/dpaa2_qdma.c b/drivers/dma/dpaa2/dpaa2_qdma.c
index f7d94bb799..7d3f3d2003 100644
--- a/drivers/dma/dpaa2/dpaa2_qdma.c
+++ b/drivers/dma/dpaa2/dpaa2_qdma.c
@@ -66,16 +66,19 @@ qdma_cntx_idx_ring_eq(struct qdma_cntx_idx_ring *ring,
 	const uint16_t *elem, uint16_t nb,
 	uint16_t *free_space)
 {
-	uint16_t i;
+	uint16_t first;
 
 	if (unlikely(nb > ring->free_space))
 		return 0;
 
-	for (i = 0; i < nb; i++) {
-		ring->cntx_idx_ring[ring->tail] = elem[i];
-		ring->tail = (ring->tail + 1) &
-			(DPAA2_QDMA_MAX_DESC - 1);
-	}
+	first = RTE_MIN(nb, (uint16_t)(DPAA2_QDMA_MAX_DESC - ring->tail));
+	memcpy(&ring->cntx_idx_ring[ring->tail], elem,
+		first * sizeof(uint16_t));
+	if (nb > first)
+		memcpy(&ring->cntx_idx_ring[0], &elem[first],
+			(nb - first) * sizeof(uint16_t));
+
+	ring->tail = (ring->tail + nb) & (DPAA2_QDMA_MAX_DESC - 1);
 	ring->free_space -= nb;
 	ring->nb_in_ring += nb;
 
-- 
2.43.0

