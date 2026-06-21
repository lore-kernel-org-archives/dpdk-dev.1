Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2EDCD98F0
	for <dpdk-dev@archiver.kernel.org>; Sun, 21 Jun 2026 10:16:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7FF2F4028F;
	Sun, 21 Jun 2026 12:16:58 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id DDFF64027F
 for <dev@dpdk.org>; Sun, 21 Jun 2026 12:16:56 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A25871A0212;
 Sun, 21 Jun 2026 12:16:56 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6C8B41A0063;
 Sun, 21 Jun 2026 12:16:56 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 09272180007B;
 Sun, 21 Jun 2026 18:16:54 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	david.marchand@redhat.com,
	dev@dpdk.org
Subject: [PATCH v2 00/19] dpaa: bus, net, dma and mempool improvements
Date: Sun, 21 Jun 2026 15:46:32 +0530
Message-Id: <20260621101651.1081425-1-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260619122922.3774666-1-hemant.agrawal@nxp.com>
References: <20260619122922.3774666-1-hemant.agrawal@nxp.com>
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

v2: fix checkpatch error and apply it over main branch

This series collects correctness fixes, cleanups and feature additions
across the NXP DPAA bus, net, mempool and DMA drivers.

1. Bus/fman infrastructure cleanups (patches 01, 02, 13)
   - Refine fman symbol naming and fix unintended global scope.
   - Scan the maximum BPID count from the device tree rather than
     using a compile-time constant.
   - Improve the DPAA bus log macro and fix bus-detection logic.

2. BMI Tx statistics (patch 03)
   - Extend fman_hw to read Tx BMI registers and expose the counters
     through the xstats interface.

3. Process-type guards (patch 04)
   - Add secondary-process checks in the net, DMA and crypto drivers
     to prevent segfaults when operations valid only in the primary
     process are called from a secondary.

4. FQ shutdown hardening (patches 05-11)
   - Introduce helpers for qman channel and work-queue lookup so that
     FQ teardown is driven by the FQ descriptor instead of ad-hoc
     parameters.
   - Add channel validation and CGR cleanup to the shutdown path.
   - Clean up the Tx-confirmation FQ on device stop and remove a
     redundant shutdown call from Rx queue setup.

5. net/dpaa improvements (patches 12, 14, 15)
   - Optimise FM de-configuration to avoid redundant portal drains.
   - Streamline FMC MAC-type parsing.
   - Report an error when deferred-start mode is requested (not
     supported by the driver).

6. mempool/dpaa (patches 16-17)
   - Optimise multi-entry buffer-pool acquire/release operations.
   - Release the BPID in the driver destructor to avoid resource leaks
     across repeated bind/unbind cycles.

7. dma/dpaa (patch 18)
   - Add SG-list data validation and a workaround for erratum
     ERR050757.

8. net/dpaa ONIC support (patch 19)
   - Add port-type checks for ONIC (Open Network Interface Card)
     shared-Ethernet ports.

Gagandeep Singh (2):
  bus/dpaa: enhance DPAA FQ shutdown
  dma/dpaa: add SG data validation and ERR050757 fix

Hemant Agrawal (5):
  net/dpaa: clean Tx confirmation FQ on device stop
  net/dpaa: remove redundant FQ shutdown from Rx queue setup
  net/dpaa: optimize FM deconfig
  bus/dpaa: improve log macro and fix bus detection
  net/dpaa: report error on using deferred start

Jun Yang (10):
  bus/dpaa: refine fman naming and fix global scope
  bus/dpaa: scan max BPID from DTS
  drivers: add BMI Tx statistics
  bus/dpaa: define helpers for qman channel and wq
  drivers: shutdown DPAA FQ by fq descriptor
  bus/dpaa: improve FQ shutdown with channel validation
  drivers: add DPAA cgrid cleanup support
  net/dpaa: optimize FMC MAC type parsing
  drivers: optimize DPAA multi-entry buffer pool operations
  drivers: release DPAA bpid on driver destructor

Prashant Gupta (1):
  drivers: add process-type guards for secondary process

Vanshika Shukla (1):
  net/dpaa: add ONIC port checks

 drivers/bus/dpaa/base/fman/fman.c         |  23 ++--
 drivers/bus/dpaa/base/fman/fman_hw.c      | 108 ++++++++---------
 drivers/bus/dpaa/base/qbman/bman.c        |  57 +++------
 drivers/bus/dpaa/base/qbman/bman_driver.c |  48 +++++---
 drivers/bus/dpaa/base/qbman/qman.c        | 115 ++++++++++--------
 drivers/bus/dpaa/base/qbman/qman.h        |  23 +++-
 drivers/bus/dpaa/base/qbman/qman_driver.c |  29 ++++-
 drivers/bus/dpaa/dpaa_bus.c               |  35 ++++--
 drivers/bus/dpaa/dpaa_bus_base_symbols.c  |   4 +
 drivers/bus/dpaa/include/fman.h           |  30 ++++-
 drivers/bus/dpaa/include/fsl_bman.h       |  49 ++++++--
 drivers/bus/dpaa/include/fsl_qman.h       |  22 +++-
 drivers/crypto/dpaa_sec/dpaa_sec.c        |   3 -
 drivers/dma/dpaa/dpaa_qdma.c              | 103 ++++++++++++----
 drivers/mempool/dpaa/dpaa_mempool.c       |  75 ++++++++++--
 drivers/mempool/dpaa/dpaa_mempool.h       |   3 +-
 drivers/net/dpaa/dpaa_ethdev.c            | 132 ++++++++++++++++-----
 drivers/net/dpaa/dpaa_ethdev.h            |  22 +++-
 drivers/net/dpaa/dpaa_flow.c              | 137 +++++++++++++---------
 drivers/net/dpaa/dpaa_flow.h              |   7 +-
 drivers/net/dpaa/dpaa_fmc.c               |  73 +++++++-----
 21 files changed, 746 insertions(+), 352 deletions(-)

-- 
2.25.1

