Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D870C79FB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 13:57:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05D6A42EDD;
	Thu, 10 Sep 2026 15:53:08 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 1732042E8E
 for <dev@dpdk.org>; Thu, 10 Sep 2026 15:52:55 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id F1A1C200438;
 Thu, 10 Sep 2026 15:52:54 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BBDD0200436;
 Thu, 10 Sep 2026 15:52:54 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id B489718000B5;
 Thu, 10 Sep 2026 21:52:53 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH v2 46/47] bus/fslmc: reduce probe-time logging and MC traffic
Date: Thu, 10 Sep 2026 19:21:57 +0530
Message-ID: <20260910135158.2181141-47-prashant.gupta_3@nxp.com>
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

From: Hemant Agrawal <hemant.agrawal@nxp.com>

Every DMA map logged its virtual, IOVA and physical addresses at NOTICE.
An application that maps many memory segments prints one such line per
segment during initialisation, which drowns out messages the operator
actually needs; the neighbouring mapping paths already use debug level.

fslmc_vfio_get_bus_info() also issued mc_get_soc_version() twice in a row
into the same structure, so the second command only overwrote the first
result with an identical one. Keep a single query.

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/bus/fslmc/fslmc_vfio.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfio.c
index 4eb8552696..5ccb457a75 100644
--- a/drivers/bus/fslmc/fslmc_vfio.c
+++ b/drivers/bus/fslmc/fslmc_vfio.c
@@ -281,13 +281,6 @@ fslmc_vfio_get_bus_info(void *regs, struct rte_fslmc_bus_info *bus_info)
 		return ret;
 	}
 
-	memset(&mc_plat_info, 0, sizeof(struct mc_soc_version));
-	ret = mc_get_soc_version(&mc_io, CMD_PRI_LOW, &mc_plat_info);
-	if (ret) {
-		DPAA2_BUS_ERR("Unable to get SoC version err:%d", ret);
-		return ret;
-	}
-
 	for (i = 0; i < RTE_DIM(s_soc_type); i++) {
 		if ((mc_plat_info.svr & DPAA2_SVR_MASK) == s_soc_type[i].svr) {
 			dpaa2_svr_family = s_soc_type[i].svr;
@@ -1041,8 +1034,7 @@ fslmc_map_dma(uint64_t vaddr, rte_iova_t iovaddr, size_t len)
 			fslmc_mem_va2iova = RTE_BAD_IOVA;
 		TAILQ_INSERT_TAIL(&fslmc_memsegs, dmaseg, next);
 	}
-	DPAA2_BUS_LOG(NOTICE,
-		"%s(%zx): VA(%" PRIx64 "):IOVA(%" PRIx64 "):PHY(%" PRIx64 ")",
+	DPAA2_BUS_DEBUG("%s(%zx): VA(%" PRIx64 "):IOVA(%" PRIx64 "):PHY(%" PRIx64 ")",
 		is_io ? "DMA I/O map size" : "DMA MEM map size",
 		len, vaddr, iovaddr, phy);
 
-- 
2.43.0

