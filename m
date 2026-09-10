Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E53CC79FB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 13:52:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A2F95427BF;
	Thu, 10 Sep 2026 15:52:04 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 7C22140274
 for <dev@dpdk.org>; Thu, 10 Sep 2026 15:52:03 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3E9451A0072;
 Thu, 10 Sep 2026 15:52:03 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 098001A0453;
 Thu, 10 Sep 2026 15:52:03 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 27D7318000B1;
 Thu, 10 Sep 2026 21:52:02 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Subject: [PATCH v2 00/47] NXP DPAA2 driver updates and fixes
Date: Thu, 10 Sep 2026 19:21:11 +0530
Message-ID: <20260910135158.2181141-1-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903135353.3358303-1-prashant.gupta_3@nxp.com>
References: <20260903135353.3358303-1-prashant.gupta_3@nxp.com>
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

This series brings the NXP DPAA2 drivers (net, crypto, dma, event,
mempool and the fslmc bus) up to date with the current internal tree.
It carries bug fixes, a reworked flow engine, an extended parser, meter
and policer support, PTP enhancements, and a number of performance
improvements in the Rx/Tx and DQRR handling paths.

The series is based on commit c1a46b9d9243 and is intended for 26.11.

Changes in v2:

- Dropped the header-only patches; every remaining patch now contains
  the implementation together with its declarations.
- Addressed all findings reported by checkpatch; the series is clean
  against the current checkpatch.
- Removed the per-device Tx scatter/gather pool member that was never
  assigned, and used the existing global pool instead.
- Widened the DQRR held-mask shift to 64-bit to avoid undefined
  behaviour when the DQRR index exceeds 31.
- Bounded the MAC xstats collection loop by the size of the statistics
  array.
- Treated the traffic class priority mask as a bitmask rather than an
  index.
- Added a per-entry DQRR consume fallback for portals whose DQRR ring
  does not fit the vectored consume encoding.

Each of the review fixes above has been folded into the patch that
introduced the code in question, so the series remains bisectable.

Build tested with gcc, clang and the aarch64 DPAA cross toolchain
(werror enabled, no compiler warnings).

Signed-off-by: Prashant Gupta <prashant.gupta_3@nxp.com>

Gagandeep Singh (18):
  crypto/dpaa2_sec: fix buffer overflow in GCM decrypt
  crypto/dpaa2_sec: fix FLE pool leak on sec FD build failure
  crypto/dpaa2_sec: support AES-GMAC
  crypto/dpaa2_sec: increase ivsize range for AES-CTR
  crypto/dpaa2_sec: add missing ECN capability
  crypto/dpaa2_sec: add support for env variables
  dma/dpaa2: validate IOVA in pre-populate helpers
  dma/dpaa2: optimize context index ring enqueue
  drivers: add dpaa2 DMA bypass memory translation option
  net/dpaa2: set Tx confirmation on device init
  drivers: optimize dpaa2 Tx queue and channel mapping
  net/dpaa2: support larger burst size
  net/dpaa2: support MPLS and PPPoE flow distribution
  net/dpaa2: support meter and policing
  net/dpaa2: support flow drop action
  net/dpaa2: set default flow miss action per device
  net/dpaa2: identify Rx mbuf hash information by FLC
  net/dpaa2: enhance xstat implementation

Hemant Agrawal (17):
  net/dpaa2: fix integer overflow in CCSR region mapping
  net/dpaa2: add minimum key size support
  net/dpaa2: restructure dpaa2 parser processing
  net/dpaa2: parse tunnel and fragmented packet types
  net/dpaa2: remove unused soft parser Tx code
  net/dpaa2: update MC dpni QoS and flow steering API
  net/dpaa2: rework flow engine
  net/dpaa2: support GENEVE flow item
  net/dpaa2: support flow meter and policer actions
  net/dpaa2: support flow table miss actions
  drivers: consume dpaa2 DQRR entries in batches
  drivers: resolve dpaa2 endpoint in the net driver
  drivers: align dpaa2 event port depths with hardware rings
  net/dpaa2: read MC version from device private data
  net/dpaa2: do not overwrite mbuf hash with drop priority
  bus/fslmc: reduce probe-time logging and MC traffic
  net/dpaa2: reject Rx queue deferred start

Jun Yang (11):
  dma/dpaa2: fix array-bounds warning in dequeue path
  mempool/dpaa2: support ops index from primary in secondary
  net/dpaa2: remove unused soft parser driver
  drivers: refresh dpaa2 MC and SoC version info
  drivers: identify dpaa2 soft parser protocol
  drivers: assign dpaa2 Rx CGID per traffic class
  drivers: inherit dpaa2 rxq config for event queue
  net/dpaa2: rename Rx queue flags
  drivers: rework dpaa2 Tx confirmation
  net/dpaa2: ptp enhancements
  net/dpaa2: support Rx mempool per traffic class

Prashant Gupta (1):
  bus/fslmc: defer bus initialization to probe

 doc/guides/rel_notes/release_26_11.rst        |    6 +
 drivers/bus/fslmc/bus_fslmc_driver.h          |   14 +-
 drivers/bus/fslmc/fslmc_bus.c                 |  177 +-
 drivers/bus/fslmc/fslmc_vfio.c                |  196 +-
 drivers/bus/fslmc/fslmc_vfio.h                |   30 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c      |   83 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.h      |    7 -
 drivers/bus/fslmc/portal/dpaa2_hw_dprc.c      |   45 +-
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h       |    7 +-
 drivers/bus/fslmc/private.h                   |    3 +
 .../fslmc/qbman/include/fsl_qbman_portal.h    |   12 +-
 drivers/bus/fslmc/qbman/qbman_portal.c        |   83 +-
 drivers/bus/fslmc/qbman/qbman_portal.h        |   11 +-
 drivers/common/dpaax/rte_pmd_dpaax_qdma.h     |    4 +-
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c   |   98 +-
 drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h     |   45 +-
 drivers/dma/dpaa2/dpaa2_qdma.c                |  155 +-
 drivers/dma/dpaa2/dpaa2_qdma.h                |    1 +
 drivers/event/dpaa2/dpaa2_eventdev.c          |   76 +-
 drivers/event/dpaa2/dpaa2_eventdev.h          |    4 +-
 drivers/mempool/dpaa2/dpaa2_hw_mempool.c      |   88 +-
 drivers/net/dpaa2/base/dpaa2_hw_dpni.c        |  546 --
 drivers/net/dpaa2/base/dpaa2_hw_dpni_annot.h  |    6 +-
 drivers/net/dpaa2/dpaa2_ethdev.c              | 2135 +++--
 drivers/net/dpaa2/dpaa2_ethdev.h              |  759 +-
 drivers/net/dpaa2/dpaa2_flow.c                | 6966 ++++++++++-------
 drivers/net/dpaa2/dpaa2_meter.c               |  588 ++
 drivers/net/dpaa2/dpaa2_parse_dump.h          |  374 -
 drivers/net/dpaa2/dpaa2_parser_decode.h       | 1545 ++++
 drivers/net/dpaa2/dpaa2_ptp.c                 |  161 +-
 drivers/net/dpaa2/dpaa2_recycle.c             |   37 +-
 drivers/net/dpaa2/dpaa2_rxtx.c                | 1902 ++---
 drivers/net/dpaa2/dpaa2_sparser.c             |  137 -
 drivers/net/dpaa2/dpaa2_sparser.h             |  202 -
 drivers/net/dpaa2/dpaa2_tm.c                  |   16 +-
 drivers/net/dpaa2/mc/dpni.c                   |  138 +-
 drivers/net/dpaa2/mc/fsl_dpni.h               |  390 +-
 drivers/net/dpaa2/mc/fsl_dpni_cmd.h           |   33 +-
 drivers/net/dpaa2/meson.build                 |    5 +-
 lib/cryptodev/rte_crypto_sym.h                |    2 +
 lib/cryptodev/rte_cryptodev.c                 |    1 +
 41 files changed, 10532 insertions(+), 6556 deletions(-)
 delete mode 100644 drivers/net/dpaa2/base/dpaa2_hw_dpni.c
 create mode 100644 drivers/net/dpaa2/dpaa2_meter.c
 delete mode 100644 drivers/net/dpaa2/dpaa2_parse_dump.h
 create mode 100644 drivers/net/dpaa2/dpaa2_parser_decode.h
 delete mode 100644 drivers/net/dpaa2/dpaa2_sparser.c
 delete mode 100644 drivers/net/dpaa2/dpaa2_sparser.h

-- 
2.43.0

