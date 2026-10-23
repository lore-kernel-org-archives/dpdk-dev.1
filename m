Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8FD606A31B
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:43:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6334540299;
	Fri, 23 Oct 2026 15:43:52 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 8BE0F40268
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:43:51 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 45B7C200034;
 Fri, 23 Oct 2026 15:43:51 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 111F5200020;
 Fri, 23 Oct 2026 15:43:51 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id CEF44180006C;
 Fri, 23 Oct 2026 21:43:49 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Subject: [PATCH v4-S3 00/65] net/dpaa2, event/dpaa2 and fslmc rework
Date: Fri, 23 Oct 2026 19:12:40 +0530
Message-ID: <20261023134346.37727-1-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915120208.4185877-1-prashant.gupta_3@nxp.com>
References: <20260915120208.4185877-1-prashant.gupta_3@nxp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is the final DPAA2 upstreaming sub-series, applied on top of
v7-S1 ("dpaa2: bus, DMA and mempool base fixes") and
v14-S2 ("net/dpaa2 updates").

The series reworks the DPAA2 datapath, flow steering, metering,
eventdev integration and fslmc infrastructure. It consolidates
device configuration handling, improves queue and portal management,
and adds support for additional DPNI, eventdev and datapath
capabilities.

Highlights:
  - add DMA bypass translation support and table-driven devargs parsing;
  - optimize Tx queue, channel and dequeue processing paths;
  - centralize MC version, SoC detection and endpoint handling;
  - rework RSS, flow steering, QoS and default action programming;
  - add rte_mtr support and meter rte_flow actions;
  - improve eventdev scheduling, DPCI support and multi-port operation;
  - support runtime IEEE1588 timestamping;
  - rework xstats collection and MAC statistics handling;
  - unify enqueue/dequeue datapaths across net, crypto and eventdev;
  - add Tx fast paths and reduce confirmation overhead.

Every commit builds cleanly with arm64 and -Werror and the
series remains bisectable.

Breeson Francis (1):
  net/dpaa2: rework xstats with page table and MAC support

Hemant Agrawal (1):
  net/dpaa2: reject Rx queue deferred start

Jun Yang (63):
  net/dpaa2: refactor and optimize Rx parser result decode
  net/dpaa2: generate devargs table and string from one list
  crypto/dpaa2_sec: use table-driven devargs parsing
  dma/dpaa2: use table-driven devargs parsing
  net/dpaa2: unify debug dump via log based helpers
  net/dpaa2: expose Rx L3/L4/L5 offsets via mbuf dynfield
  net/dpaa2: optimize dpaa2 Tx queue and channel mapping
  bus/fslmc: split bus-level device walk from VFIO primitives
  bus/fslmc: centralize MC version and SoC detection in the bus layer
  net/dpaa2: remove unused soft parser loader
  net/dpaa2: cache per-rxq DPNI queue cfg and share CGID per TC
  The dpaa2 PMD so far supported only two Tx buffer release schemes:
    direct release by hardware, and an absolute Tx confirmation mode
    (drv_tx_conf=1) where every transmitted buffer is returned on a Tx
    confirmation queue that software must poll to free the buffers.
    Absolute confirmation adds a confirmation descriptor and a poll cost
    for all packets, even those the hardware could free on its own.
  net/dpaa2: support runtime IEEE1588 timestamping
  bus/fslmc: consume dpaa2 DQRR entries in batches
  bus/fslmc: align dpaa2 event port depths with hardware rings
  net/dpaa2: support multi-DPNI FS redirect and QoS table v3
  net/dpaa2: unify xstats layout and add DPMAC counter struct
  net/dpaa2: reimplement xstats_get() on top of xstats_get_by_id()
  net/dpaa2: fetch only requested MAC xstats in one MC call
  net/dpaa2: rework flow with per-table profile and group types
  net/dpaa2: reimplement RSS distribution via rte_flow
  net/dpaa2: expand IP address extracts for RSS hashing
  net/dpaa2: add policer v2 MC command and L2/L3 byte units
  net/dpaa2: support rte_mtr and METER rte_flow action
  net/dpaa2: program flow table miss actions via rte_flow
  net/dpaa2: support DCB Rx mode via rte_flow
  bus/fslmc: support DPCI peer and dynamic queues
  bus/fslmc: add alloc/free DPIO API for non-affine portals
  event/dpaa2: rework event port model and DPCI handling
  event/dpaa2: fix Tx adapter enqueue for mixed destinations
  event/dpaa2: rework self test for dynamic link and balance check
  event/dpaa2: add DPCON based standalone Rx scheduler
  event/dpaa2: add push mode to DPCON Rx scheduler
  event/dpaa2: drain Rx scheduler queues on destroy
  event/dpaa2: track and detach attached Rx queues
  net/dpaa2: add multi-port Tx API
  event/dpaa2: limit attached Rx flows per event queue
  eventdev: fix port link/unlink callback return documentation
  event/dpaa2: allow event queue link to multiple ports
  event/dpaa2: report available DPIO count and fix create cleanup
  event/dpaa2: use event port DPIO for dequeue wait
  bus/fslmc: consolidate DPIO interrupt setup and bound coalescing
  event/dpaa2: honor configured dequeue timeout
  bus/fslmc: use EAL API for DPIO interrupt
  bus/fslmc: defer DPIO interrupt setup and bind portal to worker core
  bus/fslmc: move Tx SG mempool to fslmc bus
  net/dpaa2: move DPNI endpoint lookup out of the fslmc bus
  net/dpaa2: add APIs to query device info and set default action
  net/dpaa2: consolidate dequeue paths and optimize fast path
  net/dpaa2: bind per-queue DPIO for rx-queue interrupts
  net/dpaa2: add API to clean Tx confirmation queue
  event/dpaa2: fix DQRR held buffer accounting on enqueue
  bus/fslmc: store dequeue dpio in mbuf seq dynfield
  bus/fslmc: use explicit flags for mbuf seqn encoding
  net/dpaa2: unify tx burst path for ordered and atomic enqueue
  crypto/dpaa2_sec: unify enqueue burst path for ordered enqueue
  bus/fslmc: track atomic DCA context per dequeue dpio
  bus/fslmc: move enqueue response descriptors to per-queue
  event/dpaa2: add ordered schedule type support
  bus/fslmc: make DPAA2 ORP/ODP ordering per-queue instead of per-device
  event/dpaa2: support multi-port enqueue in selftest random event
    generator
  event/dpaa2: do not fail device creation on DPCI errors
  net/dpaa2: add Tx fast path for no-confirmation case

 doc/guides/nics/dpaa2.rst                     |   29 +-
 doc/guides/rel_notes/release_26_11.rst        |   10 +
 drivers/bus/fslmc/bus_fslmc_driver.h          |   46 +-
 drivers/bus/fslmc/fslmc_bus.c                 |  321 +-
 drivers/bus/fslmc/fslmc_logs.h                |    2 +
 drivers/bus/fslmc/fslmc_vfio.c                |  562 +-
 drivers/bus/fslmc/fslmc_vfio.h                |   72 +-
 drivers/bus/fslmc/mc/dpci.c                   |   37 +-
 drivers/bus/fslmc/mc/fsl_dpci.h               |   12 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpci.c      |  304 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpcon.c     |   25 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c      |  668 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.h      |   37 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dprc.c      |   52 +-
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h       |  305 +-
 drivers/bus/fslmc/private.h                   |   15 +-
 .../fslmc/qbman/include/fsl_qbman_portal.h    |   24 +-
 drivers/bus/fslmc/qbman/qbman_portal.c        |  100 +-
 drivers/bus/fslmc/qbman/qbman_portal.h        |   11 +-
 drivers/bus/fslmc/qbman/qbman_sys.h           |    4 +-
 drivers/common/dpaax/dpaax_devarg.h           |   69 +
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c   |  559 +-
 drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h     |   11 +-
 drivers/dma/dpaa2/dpaa2_qdma.c                |   92 +-
 drivers/dma/dpaa2/dpaa2_qdma.h                |   15 +-
 drivers/event/dpaa2/dpaa2_eventdev.c          | 1266 ++-
 drivers/event/dpaa2/dpaa2_eventdev.h          |   61 +-
 drivers/event/dpaa2/dpaa2_eventdev_selftest.c |  370 +-
 drivers/event/dpaa2/dpaa2_scheduler.c         |  673 ++
 drivers/event/dpaa2/meson.build               |    3 +-
 drivers/net/dpaa2/base/dpaa2_hw_dpni.c        |  544 --
 drivers/net/dpaa2/base/dpaa2_hw_dpni_annot.h  |    6 +-
 drivers/net/dpaa2/dpaa2_ethdev.c              | 3201 ++++---
 drivers/net/dpaa2/dpaa2_ethdev.h              |  997 +-
 drivers/net/dpaa2/dpaa2_flow.c                | 8426 ++++++++---------
 drivers/net/dpaa2/dpaa2_meter.c               |  584 ++
 drivers/net/dpaa2/dpaa2_parse_dump.h          |  707 +-
 drivers/net/dpaa2/dpaa2_parser_decode.h       | 1148 +++
 drivers/net/dpaa2/dpaa2_pmd_logs.h            |   34 +-
 drivers/net/dpaa2/dpaa2_ptp.c                 |  177 +-
 drivers/net/dpaa2/dpaa2_recycle.c             |   18 +-
 drivers/net/dpaa2/dpaa2_rxtx.c                | 2818 +++---
 drivers/net/dpaa2/dpaa2_sparser.c             |  137 -
 drivers/net/dpaa2/dpaa2_sparser.h             |  202 -
 drivers/net/dpaa2/mc/dpni.c                   |  127 +-
 drivers/net/dpaa2/mc/fsl_dpni.h               |  378 +-
 drivers/net/dpaa2/mc/fsl_dpni_cmd.h           |   30 +-
 drivers/net/dpaa2/mc/fsl_net.h                |    4 +-
 drivers/net/dpaa2/meson.build                 |    3 +-
 drivers/net/dpaa2/rte_pmd_dpaa2.h             |  238 +-
 lib/eventdev/eventdev_pmd.h                   |    9 +-
 51 files changed, 14514 insertions(+), 11029 deletions(-)
 create mode 100644 drivers/common/dpaax/dpaax_devarg.h
 create mode 100644 drivers/event/dpaa2/dpaa2_scheduler.c
 delete mode 100644 drivers/net/dpaa2/base/dpaa2_hw_dpni.c
 create mode 100644 drivers/net/dpaa2/dpaa2_meter.c
 create mode 100644 drivers/net/dpaa2/dpaa2_parser_decode.h
 delete mode 100644 drivers/net/dpaa2/dpaa2_sparser.c
 delete mode 100644 drivers/net/dpaa2/dpaa2_sparser.h

-- 
2.43.0

