Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2575CA5FFC
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 15:08:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC4DE410E8;
	Tue,  6 Oct 2026 17:08:01 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 4539C410D4
 for <dev@dpdk.org>; Tue,  6 Oct 2026 17:07:59 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 27B5E1A0013;
 Tue,  6 Oct 2026 17:07:59 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E60E71A0005;
 Tue,  6 Oct 2026 17:07:58 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 8FA991800226;
 Tue,  6 Oct 2026 23:07:57 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v6-S1 5/6] dma/dpaa2: validate FLE pool IOVA mapping at vchan
 setup
Date: Tue,  6 Oct 2026 20:37:48 +0530
Message-ID: <20261006150749.3591526-6-prashant.gupta_3@nxp.com>
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

From: Gagandeep Singh <g.singh@nxp.com>

The enqueue path turns every FLE virtual address into an IOVA with a
single subtraction:

	fle_iova = (uint64_t)fle - qdma_vq->fle_iova2va_offset;

That offset is derived once from fle_pool->mz, which is the memzone
holding the mempool header, not the memzone(s) holding the objects. The
objects are reserved separately by rte_mempool_populate_default(), so
nothing so far confirmed that the offset taken from the header is also
the offset of the chunks the FLEs are allocated from.

Walk the pool with rte_mempool_mem_iter() after creation and check both
properties the fast path depends on. First, that every chunk is
reachable through the IOMMU/SMMU, using DPAA2_VADDR_TO_IOVA_AND_CHECK().
Second, that every chunk has the same VA to IOVA delta as the offset
cached in the virtual queue, which a pool spread over chunks with
different deltas would violate, for example with IOVA as PA and
fragmented hugepages. Either way the IOVAs programmed into the FLEs
would be wrong, so reject the setup instead.

On failure log the pool name, release the pool with rte_mempool_free()
and clear the pointer, so that a later vchan-setup retry does not trip
over a stale pool-name collision.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
Signed-off-by: Prashant Gupta <prashant.gupta_3@nxp.com>
---
 drivers/dma/dpaa2/dpaa2_qdma.c | 44 ++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/dma/dpaa2/dpaa2_qdma.c b/drivers/dma/dpaa2/dpaa2_qdma.c
index 3b272f6593..27ca10f94f 100644
--- a/drivers/dma/dpaa2/dpaa2_qdma.c
+++ b/drivers/dma/dpaa2/dpaa2_qdma.c
@@ -1331,6 +1331,35 @@ dpaa2_qdma_vchan_rbp_set(struct qdma_virt_queue *vq,
 	return 0;
 }
 
+struct dpaa2_qdma_fle_pool_check {
+	uint64_t iova2va_offset;
+	int bad_map;
+	int bad_offset;
+};
+
+static void
+dpaa2_qdma_fle_pool_iova_check(struct rte_mempool *mp __rte_unused,
+	void *opaque, struct rte_mempool_memhdr *memhdr,
+	unsigned int mem_idx __rte_unused)
+{
+	struct dpaa2_qdma_fle_pool_check *check = opaque;
+
+	if (DPAA2_VADDR_TO_IOVA_AND_CHECK(memhdr->addr,
+			memhdr->len) == RTE_BAD_IOVA) {
+		check->bad_map = 1;
+		return;
+	}
+
+	/* The enqueue path converts every FLE address with a single
+	 * subtraction of iova2va_offset, so that offset has to hold for
+	 * every chunk the objects are taken from. With IOVA as PA and
+	 * fragmented hugepages a pool can span chunks with different
+	 * VA to IOVA deltas, which would silently produce wrong IOVAs.
+	 */
+	if (((uint64_t)memhdr->addr - memhdr->iova) != check->iova2va_offset)
+		check->bad_offset = 1;
+}
+
 static int
 dpaa2_qdma_vchan_setup(struct rte_dma_dev *dev, uint16_t vchan,
 	const struct rte_dma_vchan_conf *conf,
@@ -1338,6 +1367,7 @@ dpaa2_qdma_vchan_setup(struct rte_dma_dev *dev, uint16_t vchan,
 {
 	struct dpaa2_dpdmai_dev *dpdmai_dev = dev->data->dev_private;
 	struct qdma_device *qdma_dev = dpdmai_dev->qdma_dev;
+	struct dpaa2_qdma_fle_pool_check fle_check = {0};
 	uint32_t pool_size;
 	char pool_name[64];
 	int ret;
@@ -1381,6 +1411,20 @@ dpaa2_qdma_vchan_setup(struct rte_dma_dev *dev, uint16_t vchan,
 	va = qdma_dev->vqs[vchan].fle_pool->mz->addr_64;
 	qdma_dev->vqs[vchan].fle_iova2va_offset = va - iova;
 
+	fle_check.iova2va_offset = qdma_dev->vqs[vchan].fle_iova2va_offset;
+	rte_mempool_mem_iter(qdma_dev->vqs[vchan].fle_pool,
+		dpaa2_qdma_fle_pool_iova_check, &fle_check);
+	if (fle_check.bad_map || fle_check.bad_offset) {
+		if (fle_check.bad_map)
+			DPAA2_QDMA_ERR("No IOMMU map for %s", pool_name);
+		else
+			DPAA2_QDMA_ERR("%s spans inconsistent IOVA offsets",
+				pool_name);
+		rte_mempool_free(qdma_dev->vqs[vchan].fle_pool);
+		qdma_dev->vqs[vchan].fle_pool = NULL;
+		return -ENOMEM;
+	}
+
 	if (qdma_dev->is_silent) {
 		ret = rte_mempool_get_bulk(qdma_dev->vqs[vchan].fle_pool,
 				(void **)qdma_dev->vqs[vchan].cntx_sg,
-- 
2.43.0

