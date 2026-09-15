Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B071C982C7
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 11:34:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D9934278D;
	Tue, 15 Sep 2026 13:34:32 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id EA76A40F35
 for <dev@dpdk.org>; Tue, 15 Sep 2026 13:34:28 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CA78120004A;
 Tue, 15 Sep 2026 13:34:28 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 92CEE20005A;
 Tue, 15 Sep 2026 13:34:28 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 81B75180006C;
 Tue, 15 Sep 2026 19:34:27 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH v3-S1 2/5] bus/fslmc: reduce probe-time logging and MC traffic
Date: Tue, 15 Sep 2026 17:04:19 +0530
Message-ID: <20260915113422.4166287-3-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915113422.4166287-1-prashant.gupta_3@nxp.com>
References: <20260915113422.4166287-1-prashant.gupta_3@nxp.com>
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
 drivers/bus/fslmc/fslmc_vfio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

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
 
-- 
2.43.0

