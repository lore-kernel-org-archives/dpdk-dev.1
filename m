Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51ABCC88E53
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 12:02:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2853540C35;
	Tue, 15 Sep 2026 14:02:12 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 3F96240A7A
 for <dev@dpdk.org>; Tue, 15 Sep 2026 14:02:11 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 18ADA200063;
 Tue, 15 Sep 2026 14:02:11 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D6E5F200035;
 Tue, 15 Sep 2026 14:02:10 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 9E90818000BA;
 Tue, 15 Sep 2026 20:02:09 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Subject: [PATCH v3-S3 00/10] net/dpaa2: bus, DMA, eventdev and datapath rework
Date: Tue, 15 Sep 2026 17:31:58 +0530
Message-ID: <20260915120208.4185877-1-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915113459.4166621-1-prashant.gupta_3@nxp.com>
References: <20260915113459.4166621-1-prashant.gupta_3@nxp.com>
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

This is the third of four dpaa2 upstreaming sub-series, applied on top
of v3-S1 and v3-S2. It reworks the fslmc bus, DMA, eventdev and the net
datapath.

Highlights:
  - add a DMA bypass memory translation option and optimize the Tx queue
    and channel mapping;
  - refresh the MC and SoC version information and identify the soft
    parser protocol;
  - assign the Rx CGID per traffic class and inherit the rxq config for
    the event queue;
  - rework Tx confirmation and consume DQRR entries in batches;
  - resolve the dpaa2 endpoint in the net driver and align the event
    port depths with the hardware rings.

Every commit builds cleanly (arm64, -Werror) and the series is
bisectable.

Depends-on: series-39291 ("net/dpaa2: flow, meter and parser features")

Gagandeep Singh (2):
  drivers: add dpaa2 DMA bypass memory translation option
  drivers: optimize dpaa2 Tx queue and channel mapping

Jun Yang (8):
  drivers: refresh dpaa2 MC and SoC version info
  drivers: identify dpaa2 soft parser protocol
  drivers: assign dpaa2 Rx CGID per traffic class
  drivers: inherit dpaa2 rxq config for event queue
  drivers: rework dpaa2 Tx confirmation
  drivers: consume dpaa2 DQRR entries in batches
  drivers: resolve dpaa2 endpoint in the net driver
  drivers: align dpaa2 event port depths with hardware rings

 doc/guides/nics/dpaa2.rst                     |   16 +-
 drivers/bus/fslmc/bus_fslmc_driver.h          |   15 +-
 drivers/bus/fslmc/fslmc_bus.c                 |   93 +-
 drivers/bus/fslmc/fslmc_vfio.c                |  193 ++-
 drivers/bus/fslmc/fslmc_vfio.h                |   30 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c      |   83 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.h      |    7 -
 drivers/bus/fslmc/portal/dpaa2_hw_dprc.c      |   45 +-
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h       |    7 +-
 drivers/bus/fslmc/private.h                   |    3 +
 .../fslmc/qbman/include/fsl_qbman_portal.h    |   12 +-
 drivers/bus/fslmc/qbman/qbman_portal.c        |   78 +-
 drivers/bus/fslmc/qbman/qbman_portal.h        |   11 +-
 drivers/common/dpaax/rte_pmd_dpaax_qdma.h     |    4 +-
 drivers/dma/dpaa2/dpaa2_qdma.c                |   87 +-
 drivers/event/dpaa2/dpaa2_eventdev.c          |   76 +-
 drivers/event/dpaa2/dpaa2_eventdev.h          |    4 +-
 drivers/net/dpaa2/base/dpaa2_hw_dpni.c        |    2 +-
 drivers/net/dpaa2/base/dpaa2_hw_dpni_annot.h  |    6 +-
 drivers/net/dpaa2/dpaa2_ethdev.c              |  516 +++---
 drivers/net/dpaa2/dpaa2_ethdev.h              |   38 +-
 drivers/net/dpaa2/dpaa2_flow.c                |  129 +-
 drivers/net/dpaa2/dpaa2_ptp.c                 |    4 +-
 drivers/net/dpaa2/dpaa2_recycle.c             |   15 +-
 drivers/net/dpaa2/dpaa2_rxtx.c                | 1515 ++++++++---------
 25 files changed, 1579 insertions(+), 1410 deletions(-)

-- 
2.43.0

