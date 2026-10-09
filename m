Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1527CCA6012
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 10:50:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B94B6406B6;
	Fri,  9 Oct 2026 12:50:27 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 4AA6040658
 for <dev@dpdk.org>; Fri,  9 Oct 2026 12:50:26 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 29E3320000B;
 Fri,  9 Oct 2026 12:50:26 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EA5EE200315;
 Fri,  9 Oct 2026 12:50:25 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id E854B18000B5;
 Fri,  9 Oct 2026 18:50:24 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v7-S1 5/6] dma/dpaa2: validate FLE pool IOVA mapping at vchan
 setup
Date: Fri,  9 Oct 2026 16:20:18 +0530
Message-ID: <20261009105019.1121083-6-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009105019.1121083-1-prashant.gupta_3@nxp.com>
References: <20261006150749.3591526-1-prashant.gupta_3@nxp.com>
 <20261009105019.1121083-1-prashant.gupta_3@nxp.com>
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

The enqueue path turns every FLE virtual address into an IOVA with a
single subtraction:

        fle_iova = (uint64_t)fle - qdma_vq->fle_iova2va_offset;

That offset is derived once from fle_pool->mz, which is the memzone
holding the mempool header, not the mempool object storage. The
objects are allocated from one or more mempool memory chunks, so the
offset derived from the header does not by itself guarantee that all
FLE objects share the same virtual-to-IOVA relationship.

Validate the FLE pool immediately after creation by walking all memory
chunks with rte_mempool_mem_iter(). Verify that every chunk has a valid
IOVA mapping and that all chunks share the same VA-to-IOVA offset. A
pool spanning chunks with different offsets, for example when using
IOVA-as-PA with fragmented hugepages, would result in incorrect IOVAs
being programmed into FLEs.

Reject such pools during vchan setup instead of allowing invalid IOVAs
to reach the enqueue fast path.

On failure, log the pool name, release the mempool and clear the saved
pointer so that a later vchan setup retry does not fail due to a stale
pool-name collision.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
Signed-off-by: Prashant Gupta <prashant.gupta_3@nxp.com>
---
 drivers/dma/dpaa2/dpaa2_qdma.c | 55 +++++++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/dpaa2/dpaa2_qdma.c b/drivers/dma/dpaa2/dpaa2_qdma.c
index e8ec9cddfc..8d10edfd04 100644
--- a/drivers/dma/dpaa2/dpaa2_qdma.c
+++ b/drivers/dma/dpaa2/dpaa2_qdma.c
@@ -1333,6 +1333,32 @@ dpaa2_qdma_vchan_rbp_set(struct qdma_virt_queue *vq,
 	return 0;
 }
 
+struct dpaa2_qdma_fle_pool_check {
+	uint64_t iova2va_offset;
+	bool bad;
+};
+
+static void
+dpaa2_qdma_fle_pool_iova_check(struct rte_mempool *mp __rte_unused,
+		void *opaque, struct rte_mempool_memhdr *memhdr,
+		unsigned int mem_idx)
+{
+	struct dpaa2_qdma_fle_pool_check *check = opaque;
+	uint64_t offset;
+
+	if (memhdr->iova == RTE_BAD_IOVA) {
+		check->bad = true;
+		return;
+	}
+
+	offset = (uint64_t)memhdr->addr - memhdr->iova;
+
+	if (mem_idx == 0)
+		check->iova2va_offset = offset;
+	else if (offset != check->iova2va_offset)
+		check->bad = true;
+}
+
 static int
 dpaa2_qdma_vchan_setup(struct rte_dma_dev *dev, uint16_t vchan,
 	const struct rte_dma_vchan_conf *conf,
@@ -1340,10 +1366,10 @@ dpaa2_qdma_vchan_setup(struct rte_dma_dev *dev, uint16_t vchan,
 {
 	struct dpaa2_dpdmai_dev *dpdmai_dev = dev->data->dev_private;
 	struct qdma_device *qdma_dev = dpdmai_dev->qdma_dev;
+	struct dpaa2_qdma_fle_pool_check fle_check = {0};
 	uint32_t pool_size;
 	char pool_name[64];
 	int ret;
-	uint64_t iova, va;
 
 	DPAA2_QDMA_FUNC_TRACE();
 
@@ -1379,9 +1405,18 @@ dpaa2_qdma_vchan_setup(struct rte_dma_dev *dev, uint16_t vchan,
 		DPAA2_QDMA_ERR("%s create failed", pool_name);
 		return -ENOMEM;
 	}
-	iova = qdma_dev->vqs[vchan].fle_pool->mz->iova;
-	va = qdma_dev->vqs[vchan].fle_pool->mz->addr_64;
-	qdma_dev->vqs[vchan].fle_iova2va_offset = va - iova;
+	rte_mempool_mem_iter(qdma_dev->vqs[vchan].fle_pool,
+			dpaa2_qdma_fle_pool_iova_check, &fle_check);
+
+	if (fle_check.bad) {
+		DPAA2_QDMA_ERR("%s spans inconsistent IOVA offsets",
+				pool_name);
+		ret = -EINVAL;
+		goto err_pool;
+	}
+
+	qdma_dev->vqs[vchan].fle_iova2va_offset =
+		fle_check.iova2va_offset;
 
 	if (qdma_dev->is_silent) {
 		ret = rte_mempool_get_bulk(qdma_dev->vqs[vchan].fle_pool,
@@ -1390,7 +1425,7 @@ dpaa2_qdma_vchan_setup(struct rte_dma_dev *dev, uint16_t vchan,
 		if (ret) {
 			DPAA2_QDMA_ERR("sg cntx get from %s for silent mode",
 				       pool_name);
-			return ret;
+			goto err_pool;
 		}
 		ret = rte_mempool_get_bulk(qdma_dev->vqs[vchan].fle_pool,
 				(void **)qdma_dev->vqs[vchan].cntx_fle_sdd,
@@ -1398,7 +1433,7 @@ dpaa2_qdma_vchan_setup(struct rte_dma_dev *dev, uint16_t vchan,
 		if (ret) {
 			DPAA2_QDMA_ERR("long cntx get from %s for silent mode",
 				       pool_name);
-			return ret;
+			goto err_pool;
 		}
 	} else {
 		qdma_dev->vqs[vchan].ring_cntx_idx = rte_malloc(NULL,
@@ -1406,7 +1441,8 @@ dpaa2_qdma_vchan_setup(struct rte_dma_dev *dev, uint16_t vchan,
 				RTE_CACHE_LINE_SIZE);
 		if (!qdma_dev->vqs[vchan].ring_cntx_idx) {
 			DPAA2_QDMA_ERR("DQ response ring alloc failed.");
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto err_pool;
 		}
 		qdma_dev->vqs[vchan].ring_cntx_idx->start = 0;
 		qdma_dev->vqs[vchan].ring_cntx_idx->tail = 0;
@@ -1422,6 +1458,11 @@ dpaa2_qdma_vchan_setup(struct rte_dma_dev *dev, uint16_t vchan,
 	qdma_dev->vqs[vchan].nb_desc = conf->nb_desc;
 
 	return 0;
+
+err_pool:
+	rte_mempool_free(qdma_dev->vqs[vchan].fle_pool);
+	qdma_dev->vqs[vchan].fle_pool = NULL;
+	return ret;
 }
 
 static int
-- 
2.43.0

