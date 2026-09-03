Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB450C61DD3
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 13:54:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 97D5940EF1;
	Thu,  3 Sep 2026 15:54:00 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id E6AE9402D8
 for <dev@dpdk.org>; Thu,  3 Sep 2026 15:53:58 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 94CA41A0079;
 Thu,  3 Sep 2026 15:53:58 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5C9101A0025;
 Thu,  3 Sep 2026 15:53:58 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 2290418000B1;
 Thu,  3 Sep 2026 21:53:56 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Subject: [PATCH 00/45] net/dpaa2: features and fixes for NXP DPAA2 drivers
Date: Thu,  3 Sep 2026 19:23:08 +0530
Message-ID: <20260903135353.3358303-1-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
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

This series brings the NXP DPAA2 driver stack up to date with the
functionality carried in the NXP internal tree, together with a number of
bug fixes. It covers the crypto (dpaa2_sec), net, dma, mempool, event and
bus/fslmc drivers.

Fixes first, then features, so the bug fixes can be picked independently of
the larger reworks.

Bug fixes (patches 1-2, 7-11):
 - crypto/dpaa2_sec: buffer overflow in GCM decrypt, and an FLE pool leak
   on the sec FD build failure path
 - dpaa2 device double free on uninit
 - integer overflow in the CCSR region mapping
 - array-bounds warning in the dma dequeue path
 - IOVA validation in the dma pre-populate helpers, which previously
   called rte_panic() on an unmapped address and now returns an error
   to the caller
 - bus/fslmc: bus initialization deferred to probe

Crypto (patches 3-6):
 - AES-GMAC support, AES-CTR ivsize range, a missing ECN capability, and
   support for configuration via environment variables

Flow and classification (patches 18-24, 35-37):
 - MPLS and PPPoE distribution, meter and policing, flow drop action, a
   per-device default flow miss action, Rx hash identification by FLC, a
   minimum key size, an updated MC dpni QoS/flow-steering API, and a rework
   of the flow engine

Datapath and queue management (patches 12-17, 25-34, 38-45):
 - dma context index ring enqueue optimization and a bypass
   memory-translation option
 - Tx queue/channel mapping optimization, Tx confirmation rework, larger
   burst sizes, batched DQRR consumption, per-traffic-class Rx mempools and
   Rx CGIDs, parser restructuring plus tunnel and fragmented packet type
   parsing, PTP enhancements, xstats rework, and removal of the unused soft
   parser code

Please note two points that need reviewer input:

1. Patch 3 ("crypto/dpaa2_sec: support AES-GMAC") adds a new public enum
   value, RTE_CRYPTO_AEAD_AES_GMAC, to lib/cryptodev/rte_crypto_sym.h. It
   is appended at the end of enum rte_crypto_aead_algorithm so it is ABI
   compatible, but it is a cryptodev API addition rather than a
   driver-local change, so it needs cryptodev maintainer review. The
   series does not add a release notes entry for it; I am happy to add
   one, or to split that hunk into its own cryptodev patch, whichever is
   preferred.

2. Patch 10 ("bus/fslmc: defer bus initialization to probe") carries a
   Fixes: tag but no Cc: stable@dpdk.org, because it changes bus
   initialization ordering and is more invasive than a targeted fix. Please
   advise if it should still be marked for backport.

Testing:
 - checkpatches.sh and check-git-log.sh are clean over all 45 patches
 - build tested with the dpaa/dpaa2 driver set enabled, no new compiler
   warnings

The dpaa2 driver documentation is not updated in this series; the new
features are not yet described in doc/guides. I plan to follow up with a
documentation patch unless reviewers would rather see it folded in here.

Gagandeep Singh (20):
  crypto/dpaa2_sec: fix buffer overflow in GCM decrypt
  crypto/dpaa2_sec: fix FLE pool leak on sec FD build failure
  crypto/dpaa2_sec: support AES-GMAC
  crypto/dpaa2_sec: increase ivsize range for AES-CTR
  crypto/dpaa2_sec: add missing ECN capability
  crypto/dpaa2_sec: add support for env variables
  drivers: fix double free of dpaa2 device on uninit
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
  net/dpaa2: do not overwrite mbuf hash with drop priority

Hemant Agrawal (9):
  net/dpaa2: fix integer overflow in CCSR region mapping
  net/dpaa2: add minimum key size support
  net/dpaa2: restructure dpaa2 parser processing
  net/dpaa2: parse tunnel and fragmented packet types
  net/dpaa2: remove unused soft parser Tx code
  net/dpaa2: update MC dpni QoS and flow steering API
  net/dpaa2: rework flow engine
  bus/fslmc: reduce probe-time logging and MC traffic
  net/dpaa2: reject Rx queue deferred start

Jun Yang (14):
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
  drivers: consume dpaa2 DQRR entries in batches
  drivers: resolve dpaa2 endpoint in the net driver
  drivers: align dpaa2 event port depths with hardware rings

Prashant Gupta (2):
  bus/fslmc: defer bus initialization to probe
  net/dpaa2: read MC version from device private data

 drivers/bus/fslmc/bus_fslmc_driver.h          |   15 +-
 drivers/bus/fslmc/fslmc_bus.c                 |  185 +-
 drivers/bus/fslmc/fslmc_vfio.c                |  196 +-
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
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c   |   50 +-
 drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h     |   45 +-
 drivers/dma/dpaa2/dpaa2_qdma.c                |  162 +-
 drivers/dma/dpaa2/dpaa2_qdma.h                |    1 +
 drivers/event/dpaa2/dpaa2_eventdev.c          |   76 +-
 drivers/event/dpaa2/dpaa2_eventdev.h          |    4 +-
 drivers/mempool/dpaa2/dpaa2_hw_mempool.c      |   88 +-
 drivers/net/dpaa2/base/dpaa2_hw_dpni.c        |  546 --
 drivers/net/dpaa2/base/dpaa2_hw_dpni_annot.h  |    6 +-
 drivers/net/dpaa2/dpaa2_ethdev.c              | 2142 +++--
 drivers/net/dpaa2/dpaa2_ethdev.h              |  755 +-
 drivers/net/dpaa2/dpaa2_flow.c                | 6933 ++++++++++-------
 drivers/net/dpaa2/dpaa2_meter.c               |  588 ++
 drivers/net/dpaa2/dpaa2_parse_dump.h          |  374 -
 drivers/net/dpaa2/dpaa2_parser_decode.h       | 1539 ++++
 drivers/net/dpaa2/dpaa2_pmd_logs.h            |   67 +
 drivers/net/dpaa2/dpaa2_ptp.c                 |  176 +-
 drivers/net/dpaa2/dpaa2_recycle.c             |   37 +-
 drivers/net/dpaa2/dpaa2_rxtx.c                | 1903 ++---
 drivers/net/dpaa2/dpaa2_sparser.c             |  137 -
 drivers/net/dpaa2/dpaa2_sparser.h             |  202 -
 drivers/net/dpaa2/dpaa2_tm.c                  |   16 +-
 drivers/net/dpaa2/mc/dpni.c                   |  138 +-
 drivers/net/dpaa2/mc/fsl_dpni.h               |  390 +-
 drivers/net/dpaa2/mc/fsl_dpni_cmd.h           |   33 +-
 drivers/net/dpaa2/meson.build                 |    5 +-
 lib/cryptodev/rte_crypto_sym.h                |    2 +
 40 files changed, 10537 insertions(+), 6554 deletions(-)
 delete mode 100644 drivers/net/dpaa2/base/dpaa2_hw_dpni.c
 create mode 100644 drivers/net/dpaa2/dpaa2_meter.c
 delete mode 100644 drivers/net/dpaa2/dpaa2_parse_dump.h
 create mode 100644 drivers/net/dpaa2/dpaa2_parser_decode.h
 delete mode 100644 drivers/net/dpaa2/dpaa2_sparser.c
 delete mode 100644 drivers/net/dpaa2/dpaa2_sparser.h


base-commit: 9231dc7c072223628a81f5c755796d95230a5572
-- 
2.43.0

