Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1584C55ABF
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 08:42:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE93740615;
	Thu,  6 Aug 2026 10:42:51 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 165B2402BB
 for <dev@dpdk.org>; Thu,  6 Aug 2026 10:42:50 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D68A52002A9;
 Thu,  6 Aug 2026 10:42:49 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9D3EE2002A7;
 Thu,  6 Aug 2026 10:42:49 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D110318000B5;
 Thu,  6 Aug 2026 16:42:48 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com
Subject: [PATCH 0/4] dma/imx_edma5: introduce NXP i.MX95 eDMA5 driver
Date: Thu,  6 Aug 2026 14:12:41 +0530
Message-Id: <20260806084245.561305-1-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
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

Gagandeep Singh (4):
  dma/imx_edma5: introduce eDMA5 dmadev skeleton
  dma/imx_edma5: add device configuration
  dma/imx_edma5: add data path
  dma/imx_edma5: add statistics and dump

 MAINTAINERS                              |    5 +
 doc/guides/dmadevs/imx_edma5.rst         |   61 ++
 doc/guides/dmadevs/index.rst             |    1 +
 doc/guides/rel_notes/release_26_11.rst   |    6 +
 drivers/dma/imx_edma5/imx_edma5_dmadev.c | 1096 ++++++++++++++++++++++
 drivers/dma/imx_edma5/imx_edma5_dmadev.h |  203 ++++
 drivers/dma/imx_edma5/imx_edma5_hw.h     |  158 ++++
 drivers/dma/imx_edma5/imx_edma5_logs.h   |   16 +
 drivers/dma/imx_edma5/meson.build        |   10 +
 drivers/dma/meson.build                  |    1 +
 10 files changed, 1557 insertions(+)
 create mode 100644 doc/guides/dmadevs/imx_edma5.rst
 create mode 100644 drivers/dma/imx_edma5/imx_edma5_dmadev.c
 create mode 100644 drivers/dma/imx_edma5/imx_edma5_dmadev.h
 create mode 100644 drivers/dma/imx_edma5/imx_edma5_hw.h
 create mode 100644 drivers/dma/imx_edma5/imx_edma5_logs.h
 create mode 100644 drivers/dma/imx_edma5/meson.build

-- 
2.25.1

