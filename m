Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100E2C982FA
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 09:22:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0895B40A79;
	Tue, 22 Sep 2026 11:22:11 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id EDBA8400D6
 for <dev@dpdk.org>; Tue, 22 Sep 2026 11:22:05 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D2B0120015C;
 Tue, 22 Sep 2026 11:22:05 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9C21F20022E;
 Tue, 22 Sep 2026 11:22:05 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 3D92F180006C;
 Tue, 22 Sep 2026 17:22:04 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH v4-S1 2/5] bus/fslmc: reduce probe-time logging and MC traffic
Date: Tue, 22 Sep 2026 14:51:55 +0530
Message-ID: <20260922092158.2340839-3-prashant.gupta_3@nxp.com>
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

From: Hemant Agrawal <hemant.agrawal@nxp.com>

Every DMA map logged its virtual, IOVA and physical addresses at NOTICE.
An application that maps many memory segments prints one such line per
segment during initialisation, which drowns out messages the operator
actually needs; the neighbouring mapping paths already use debug level.

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/bus/fslmc/fslmc_vfio.c           | 3 +--
 drivers/bus/fslmc/portal/dpaa2_hw_dprc.c | 5 +++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfio.c
index 412b70e5ae..adde629ce6 100644
--- a/drivers/bus/fslmc/fslmc_vfio.c
+++ b/drivers/bus/fslmc/fslmc_vfio.c
@@ -900,8 +900,7 @@ fslmc_map_dma(uint64_t vaddr, rte_iova_t iovaddr, size_t len)
 			fslmc_mem_va2iova = RTE_BAD_IOVA;
 		TAILQ_INSERT_TAIL(&fslmc_memsegs, dmaseg, next);
 	}
-	DPAA2_BUS_LOG(NOTICE,
-		"%s(%zx): VA(%" PRIx64 "):IOVA(%" PRIx64 "):PHY(%" PRIx64 ")",
+	DPAA2_BUS_DEBUG("%s(%zx): VA(%" PRIx64 "):IOVA(%" PRIx64 "):PHY(%" PRIx64 ")",
 		is_io ? "DMA I/O map size" : "DMA MEM map size",
 		len, vaddr, iovaddr, phy);
 
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dprc.c b/drivers/bus/fslmc/portal/dpaa2_hw_dprc.c
index 868ed646af..e1a2d39fd0 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dprc.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dprc.c
@@ -52,6 +52,11 @@ rte_dpaa2_create_dprc_device(int vdev_fd __rte_unused,
 	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
 		/** DPRC is always created before it's children are created.*/
 		dev->container = dprc_node;
+
+		if (dev->device.devargs &&
+		    dev->device.devargs->policy == RTE_DEV_BLOCKED)
+			continue;
+
 		if (dev->dev_type == DPAA2_ETH) {
 			int link_state;
 
-- 
2.43.0

