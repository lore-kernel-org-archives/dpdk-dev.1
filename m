Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083DACC6B0E
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 06:51:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30E9C40272;
	Tue, 13 Oct 2026 08:51:33 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id B159C400D6
 for <dev@dpdk.org>; Tue, 13 Oct 2026 08:51:31 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7E60E1A004D;
 Tue, 13 Oct 2026 08:51:31 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 48E541A007B;
 Tue, 13 Oct 2026 08:51:31 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 75BA11800068;
 Tue, 13 Oct 2026 14:51:30 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org,
	fengchengwen@huawei.com
Cc: hemant.agrawal@nxp.com
Subject: [PATCH v5 0/5] dma/imx_edma5: introduce NXP i.MX95 eDMA5 driver
Date: Tue, 13 Oct 2026 12:21:22 +0530
Message-Id: <20261013065127.102157-1-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260812092929.563973-1-g.singh@nxp.com>
References: <20260812092929.563973-1-g.singh@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
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

V5-changes:
  - Added DP logs.
  - removed unwanted checks.
  - fixed comments, coding style.

V4-changes:
  - Removed the redundant local buffer "want"
  - Updated the comment for RTE_PMD_REGISTER_ALIAS
  - Removed stray extra blank line.

V3-changes:
 - Fixed below AI comments:
   - Dead quote-stripping removed (`of_device_is_compatible`)
   - Redundant `goto out` removed
   - New Features entry added for bus platform changes.
   - Scatter-gather doc corrected in both sections
   - Unused CH_MATTR macros removed
   - Fixed SG sub-transfer length cap (`imx_edma5_copy_sg`)
   - Updated Per-job timeout logic.
   - Updated `rte_mem_iova2virt` per-op in IOVA=VA mode logic
   - Updated comments and documentation as per the AI comments.

V2-changes:
 - Added dependent patch: bus/platform: match device by devicetree compatible string
 - Fixed multiple AI reported issues includes:
   - removed the alias from the driver, no need of it
   - removed imx_edma5_write32 from data-path, reported as coherency
     concern.
   - fix submit for previously enqueued jobs.
   - Added dsb in data path
   - Added a commnet for rte_mem_iova2virt() NULL behaviour.
   - Fixed: TCD NBYTES bits 31:30 are SMLOE/DMLOE — full 32-bit length corrupts them
   - Data path is fully synchronous: Acknowledged but intentionally deferred —
     the synchronous design is a deliberate simplification for the initial upstream submission.
     Noted in docs.
   - In-memory TCD64 pool is more complex than needed:
     Noted/deferred — the pool structure was retained for forward compatibility
     with hardware SG chaining.
   - Extended `imx_edma5_dump()` to read and print `CH_CSR` and `CH_ES` registers
     for every configured vchan.
   - Double and stary lines removed.

V1:
This patch series adds a new dmadev Poll-Mode Driver (PMD) for the NXP
i.MX95 eDMA5 (Enhanced DMA Type 5) controller.

Key features supported by this driver:
  - Memory-to-memory copy (RTE_DMA_OP_TYPE_MEMCPY)
  - Scatter-gather memory copy (RTE_DMA_OP_TYPE_SG)
  - 64-bit TCD (Transfer Control Descriptor) format
  - Non-coherent DMA with explicit cache clean/invalidate
  - Per-channel statistics and register dump for debug

Gagandeep Singh (5):
  bus/platform: match device by devicetree compatible string
  dma/imx_edma5: introduce eDMA5 dmadev skeleton
  dma/imx_edma5: add device configuration
  dma/imx_edma5: add data path
  dma/imx_edma5: add statistics and dump

 MAINTAINERS                                |    5 +
 doc/guides/dmadevs/imx_edma5.rst           |   69 ++
 doc/guides/dmadevs/index.rst               |    1 +
 doc/guides/rel_notes/release_26_11.rst     |   15 +
 drivers/bus/platform/bus_platform_driver.h |   11 +-
 drivers/bus/platform/platform.c            |   49 +-
 drivers/dma/imx_edma5/imx_edma5_dmadev.c   | 1156 ++++++++++++++++++++
 drivers/dma/imx_edma5/imx_edma5_dmadev.h   |  235 ++++
 drivers/dma/imx_edma5/imx_edma5_hw.h       |  143 +++
 drivers/dma/imx_edma5/imx_edma5_logs.h     |   22 +
 drivers/dma/imx_edma5/meson.build          |   10 +
 drivers/dma/meson.build                    |    1 +
 12 files changed, 1714 insertions(+), 3 deletions(-)
 create mode 100644 doc/guides/dmadevs/imx_edma5.rst
 create mode 100644 drivers/dma/imx_edma5/imx_edma5_dmadev.c
 create mode 100644 drivers/dma/imx_edma5/imx_edma5_dmadev.h
 create mode 100644 drivers/dma/imx_edma5/imx_edma5_hw.h
 create mode 100644 drivers/dma/imx_edma5/imx_edma5_logs.h
 create mode 100644 drivers/dma/imx_edma5/meson.build

-- 
2.25.1

