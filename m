Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B972C982FA
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 09:22:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B190242788;
	Tue, 22 Sep 2026 11:22:12 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 70AFC410F2
 for <dev@dpdk.org>; Tue, 22 Sep 2026 11:22:08 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 422CD200185;
 Tue, 22 Sep 2026 11:22:08 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0511120017F;
 Tue, 22 Sep 2026 11:22:08 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 97F6E18000BA;
 Tue, 22 Sep 2026 17:22:06 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v4-S1 4/5] dma/dpaa2: validate IOVA in pre-populate helpers
Date: Tue, 22 Sep 2026 14:51:57 +0530
Message-ID: <20260922092158.2340839-5-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922092158.2340839-1-prashant.gupta_3@nxp.com>
References: <20260915113422.4166287-1-prashant.gupta_3@nxp.com>
 <20260922092158.2340839-1-prashant.gupta_3@nxp.com>
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

fle_sdd_pre_populate() and fle_sdd_sg_pre_populate() converted the SDD
and SG entry virtual addresses to IOVA with DPAA2_VADDR_TO_IOVA(), which
does not verify that the range is actually mapped in the IOMMU/SMMU. An
unmapped buffer was silently programmed into the hardware descriptor,
leading to an SMMU translation fault at transfer time that is hard to
trace back to the missing mapping.

Use DPAA2_VADDR_TO_IOVA_AND_CHECK() for the SDD, source SG and
destination SG buffers and report the offending address and size when
the translation is missing, so the misconfiguration is caught early and
clearly. Both helpers now return an error code which is propagated to
the caller instead of continuing with an invalid descriptor.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/dma/dpaa2/dpaa2_qdma.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dpaa2/dpaa2_qdma.c b/drivers/dma/dpaa2/dpaa2_qdma.c
index 3b272f6593..c68e9e8b84 100644
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
@@ -1381,6 +1393,13 @@ dpaa2_qdma_vchan_setup(struct rte_dma_dev *dev, uint16_t vchan,
 	va = qdma_dev->vqs[vchan].fle_pool->mz->addr_64;
 	qdma_dev->vqs[vchan].fle_iova2va_offset = va - iova;
 
+	rte_mempool_mem_iter(qdma_dev->vqs[vchan].fle_pool,
+		dpaa2_qdma_fle_pool_iova_check, &bad_map);
+	if (bad_map) {
+		DPAA2_QDMA_ERR("No IOMMU map for %s", pool_name);
+		return -ENOMEM;
+	}
+
 	if (qdma_dev->is_silent) {
 		ret = rte_mempool_get_bulk(qdma_dev->vqs[vchan].fle_pool,
 				(void **)qdma_dev->vqs[vchan].cntx_sg,
-- 
2.43.0

