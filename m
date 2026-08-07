Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42DCC5AC7C
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Aug 2026 06:48:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B36024064A;
	Fri,  7 Aug 2026 08:48:58 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id CD6A7402B6
 for <dev@dpdk.org>; Fri,  7 Aug 2026 08:48:57 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 92AEC1A0131;
 Fri,  7 Aug 2026 08:48:57 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5B5DC1A012E;
 Fri,  7 Aug 2026 08:48:57 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 8F8B318000B1;
 Fri,  7 Aug 2026 14:48:56 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com
Subject: [PATCH v2 0/5] dma/imx_edma5: introduce NXP i.MX95 eDMA5 driver
Date: Fri,  7 Aug 2026 12:18:48 +0530
Message-Id: <20260807064853.1138187-1-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260806084245.561305-1-g.singh@nxp.com>
References: <20260806084245.561305-1-g.singh@nxp.com>
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

Patch breakdown:
  [1/4] Skeleton: bus probe/remove, dmadev registration, MAINTAINERS,
        doc index, and release notes for 26.11.
  [2/4] Device configuration: vchan setup, TCD ring allocation,
        start/stop, and capability reporting.
  [3/4] Data path: enqueue (copy and sg), doorbell, completion poll.
  [4/4] Statistics and dump: per-channel counters and register dump.

Tested on NXP i.MX95 EVK with vfio-platform.

Gagandeep Singh (5):
  bus/platform: match device by devicetree compatible string
  dma/imx_edma5: introduce eDMA5 dmadev skeleton
  dma/imx_edma5: add device configuration
  dma/imx_edma5: add data path
  dma/imx_edma5: add statistics and dump

 MAINTAINERS                                |    5 +
 doc/guides/dmadevs/imx_edma5.rst           |   61 +
 doc/guides/dmadevs/index.rst               |    1 +
 doc/guides/rel_notes/release_26_11.rst     |    6 +
 drivers/bus/platform/bus_platform_driver.h |    3 +-
 drivers/bus/platform/platform.c            |   67 +-
 drivers/dma/imx_edma5/imx_edma5_dmadev.c   | 1162 ++++++++++++++++++++
 drivers/dma/imx_edma5/imx_edma5_dmadev.h   |  220 ++++
 drivers/dma/imx_edma5/imx_edma5_hw.h       |  157 +++
 drivers/dma/imx_edma5/imx_edma5_logs.h     |   16 +
 drivers/dma/imx_edma5/meson.build          |   10 +
 drivers/dma/meson.build                    |    1 +
 12 files changed, 1707 insertions(+), 2 deletions(-)
 create mode 100644 doc/guides/dmadevs/imx_edma5.rst
 create mode 100644 drivers/dma/imx_edma5/imx_edma5_dmadev.c
 create mode 100644 drivers/dma/imx_edma5/imx_edma5_dmadev.h
 create mode 100644 drivers/dma/imx_edma5/imx_edma5_hw.h
 create mode 100644 drivers/dma/imx_edma5/imx_edma5_logs.h
 create mode 100644 drivers/dma/imx_edma5/meson.build

-- 
2.25.1

