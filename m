Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696C9CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 14:21:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E5F6B42E6F;
	Tue, 29 Sep 2026 16:21:34 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 86A9D411F3
 for <dev@dpdk.org>; Tue, 29 Sep 2026 16:21:26 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 688CF2000F5;
 Tue, 29 Sep 2026 16:21:26 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3C099200119;
 Tue, 29 Sep 2026 16:21:26 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D53C518000BE;
 Tue, 29 Sep 2026 22:21:24 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v5-S1 4/5] dma/dpaa2: validate FLE pool IOVA mapping at vchan
 setup
Date: Tue, 29 Sep 2026 19:51:16 +0530
Message-ID: <20260929142117.3109066-5-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929142117.3109066-1-prashant.gupta_3@nxp.com>
References: <20260922092158.2340839-1-prashant.gupta_3@nxp.com>
 <20260929142117.3109066-1-prashant.gupta_3@nxp.com>
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

After allocating the FLE mempool in dpaa2_qdma_vchan_setup(), iterate
over every memory chunk with rte_mempool_mem_iter() and verify that each
chunk is reachable through the IOMMU/SMMU by calling
DPAA2_VADDR_TO_IOVA_AND_CHECK(). If any chunk has no mapping, log the
pool name, release the pool with rte_mempool_free() and clear the pointer
to NULL before returning -ENOMEM, so that a subsequent vchan-setup retry
does not trip over a stale pool-name collision.
Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/dma/dpaa2/dpaa2_qdma.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dpaa2/dpaa2_qdma.c b/drivers/dma/dpaa2/dpaa2_qdma.c
index 3b272f6593..409993ab08 100644
--- a/drivers/dma/dpaa2/dpaa2_qdma.c
+++ b/drivers/dma/dpaa2/dpaa2_qdma.c
@@ -1331,6 +1331,18 @@ dpaa2_qdma_vchan_rbp_set(struct qdma_virt_queue *vq,
 	return 0;
 }
 
+static void
+dpaa2_qdma_fle_pool_iova_check(struct rte_mempool *mp __rte_unused,
+	void *opaque, struct rte_mempool_memhdr *memhdr,
+	unsigned int mem_idx __rte_unused)
+{
+	int *bad_map = opaque;
+
+	if (DPAA2_VADDR_TO_IOVA_AND_CHECK(memhdr->addr,
+			memhdr->len) == RTE_BAD_IOVA)
+		*bad_map = 1;
+}
+
 static int
 dpaa2_qdma_vchan_setup(struct rte_dma_dev *dev, uint16_t vchan,
 	const struct rte_dma_vchan_conf *conf,
@@ -1340,7 +1352,7 @@ dpaa2_qdma_vchan_setup(struct rte_dma_dev *dev, uint16_t vchan,
 	struct qdma_device *qdma_dev = dpdmai_dev->qdma_dev;
 	uint32_t pool_size;
 	char pool_name[64];
-	int ret;
+	int ret, bad_map = 0;
 	uint64_t iova, va;
 
 	DPAA2_QDMA_FUNC_TRACE();
@@ -1381,6 +1393,15 @@ dpaa2_qdma_vchan_setup(struct rte_dma_dev *dev, uint16_t vchan,
 	va = qdma_dev->vqs[vchan].fle_pool->mz->addr_64;
 	qdma_dev->vqs[vchan].fle_iova2va_offset = va - iova;
 
+	rte_mempool_mem_iter(qdma_dev->vqs[vchan].fle_pool,
+		dpaa2_qdma_fle_pool_iova_check, &bad_map);
+	if (bad_map) {
+		DPAA2_QDMA_ERR("No IOMMU map for %s", pool_name);
+		rte_mempool_free(qdma_dev->vqs[vchan].fle_pool);
+		qdma_dev->vqs[vchan].fle_pool = NULL;
+		return -ENOMEM;
+	}
+
 	if (qdma_dev->is_silent) {
 		ret = rte_mempool_get_bulk(qdma_dev->vqs[vchan].fle_pool,
 				(void **)qdma_dev->vqs[vchan].cntx_sg,
