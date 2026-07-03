Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C132C43602
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 12:49:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D728402C5;
	Fri,  3 Jul 2026 14:49:58 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 046AF4026F
 for <dev@dpdk.org>; Fri,  3 Jul 2026 14:49:55 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A95FC1A001F;
 Fri,  3 Jul 2026 14:49:55 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 73FDA1A0004;
 Fri,  3 Jul 2026 14:49:55 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 1BE85180004C;
 Fri,  3 Jul 2026 20:49:53 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	david.marchand@redhat.com,
	dev@dpdk.org
Subject: [PATCH v7 00/16] DPAA bus/net/mempool/DMA driver fixes and
 improvements
Date: Fri,  3 Jul 2026 18:19:34 +0530
Message-Id: <20260703124950.1895871-1-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260702053359.3243907-1-hemant.agrawal@nxp.com>
References: <20260702053359.3243907-1-hemant.agrawal@nxp.com>
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

This series collects a set of correctness fixes, cleanups and feature
additions across the NXP DPAA bus, net, mempool and DMA drivers.

1. Bus/fman infrastructure cleanups (patches 01, 02, 12)
   - bus/dpaa: refine fman naming and fix global scope
   - bus/dpaa: scan max BPID from DTS
   - bus/dpaa: improve log macro and fix bus detection

2. Process-type guards (patch 03)
   - drivers: add process-type guards to prevent segfaults in secondary

3. FQ shutdown hardening (patches 04-08)
   - bus/dpaa: define helpers for qman channel and wq
   - bus/dpaa: shutdown DPAA FQ by fq descriptor
   - bus/dpaa: improve FQ shutdown with channel validation
   - bus/dpaa: enhance DPAA FQ shutdown
   - bus/dpaa: add DPAA cgrid cleanup support

4. net/dpaa improvements (patches 09, 11, 13)
   - net/dpaa: add ONIC port checks
   - net/dpaa: optimize FM deconfig
   - net/dpaa: optimize FMC MAC type parsing

5. Statistics (patch 10)
   - drivers: add BMI Tx statistics

6. mempool/dpaa (patches 14-15)
   - drivers: optimize DPAA multi-entry buffer pool operations
   - drivers: release DPAA bpid on driver destructor

7. dma/dpaa (patch 16)
   - dma/dpaa: add SG data validation and ERR050757 fix

v7 changes:
- Drop three net/dpaa patches from v6 that need further review:
  "net/dpaa: clean Tx confirmation FQ on device stop",
  "net/dpaa: remove redundant FQ shutdown from Rx queue setup",
  "net/dpaa: report error on using deferred start".
- Rebased onto 26.07-rc2.

v6 changes:
- Fix bman_release_fast() in patch 14: replace rte_memcpy() on the
  small bm_bufs[] stack array with memcpy(); the SIMD implementation
  of rte_memcpy reads in 32/64-byte chunks and triggers
  -Warray-bounds with GCC 15 / ASAN builds on the 64-byte array.
  memcpy() is correct here as this is a local stack buffer with no
  DMA or multi-process constraints.

v5 changes:
- Rebased onto current upstream main; resolved conflict in
  drivers/crypto/dpaa_sec/dpaa_sec.c where upstream removed the
  cryptodev_name[] local variable and snprintf() call in
  cryptodev_dpaa_sec_probe() -- patch 03 now uses dpaa_dev->name
  directly in rte_cryptodev_pmd_create().
- Resolved conflict in drivers/net/dpaa/dpaa_ethdev.c where upstream
  removed rte_dpaa_device.eth_dev -- patch 03 now uses
  rte_eth_dev_allocated() to look up the Ethernet device by name.

v4 changes:
- Fix dpaa_bus_dev_compare() to return the strncmp result (previously
  always returned 0, breaking device matching).
- Remove the dead get_tx_port_type() function that triggered a clang
  -Wunused-function CI failure.
- Guard all dpaa_fm_deconfig() call sites against NULL port_handle to
  prevent a NULL dereference on partially initialised interfaces.
- Move the penv variable declaration in dpaa_qdma_init() to the point of
  use (C99 inline), fixing a spurious -Wunused-variable warning during
  bisect of earlier patches in the series.

Gagandeep Singh (2):
  bus/dpaa: enhance DPAA FQ shutdown
  dma/dpaa: add SG data validation and ERR050757 fix

Hemant Agrawal (2):
  net/dpaa: optimize FM deconfig
  bus/dpaa: improve log macro and fix bus detection

Jun Yang (10):
  bus/dpaa: refine fman naming and fix global scope
  bus/dpaa: scan max BPID from DTS
  bus/dpaa: define helpers for qman channel and wq
  bus/dpaa: shutdown DPAA FQ by fq descriptor
  bus/dpaa: improve FQ shutdown with channel validation
  bus/dpaa: add DPAA cgrid cleanup support
  drivers: add BMI Tx statistics
  net/dpaa: optimize FMC MAC type parsing
  drivers: optimize DPAA multi-entry buffer pool operations
  drivers: release DPAA bpid on driver destructor

Prashant Gupta (1):
  drivers: add process-type guards for secondary process

Vanshika Shukla (1):
  net/dpaa: add ONIC port checks

 drivers/bus/dpaa/base/fman/fman.c         |  23 ++--
 drivers/bus/dpaa/base/fman/fman_hw.c      | 108 +++++++++---------
 drivers/bus/dpaa/base/qbman/bman.c        |  59 ++++------
 drivers/bus/dpaa/base/qbman/bman_driver.c |  48 +++++---
 drivers/bus/dpaa/base/qbman/qman.c        | 113 +++++++++++--------
 drivers/bus/dpaa/base/qbman/qman.h        |  23 +++-
 drivers/bus/dpaa/base/qbman/qman_driver.c |  29 ++++-
 drivers/bus/dpaa/dpaa_bus.c               |  12 +-
 drivers/bus/dpaa/dpaa_bus_base_symbols.c  |   4 +
 drivers/bus/dpaa/include/fman.h           |  30 ++++-
 drivers/bus/dpaa/include/fsl_bman.h       |  49 ++++++--
 drivers/bus/dpaa/include/fsl_qman.h       |  22 +++-
 drivers/crypto/dpaa_sec/dpaa_sec.c        |   3 -
 drivers/dma/dpaa/dpaa_qdma.c              | 102 +++++++++++++----
 drivers/mempool/dpaa/dpaa_mempool.c       |  75 +++++++++++--
 drivers/mempool/dpaa/dpaa_mempool.h       |   3 +-
 drivers/net/dpaa/dpaa_ethdev.c            | 111 +++++++++++++++----
 drivers/net/dpaa/dpaa_ethdev.h            |  22 +++-
 drivers/net/dpaa/dpaa_flow.c              | 129 ++++++++++++----------
 drivers/net/dpaa/dpaa_flow.h              |   7 +-
 drivers/net/dpaa/dpaa_fmc.c               |  73 +++++++-----
 21 files changed, 697 insertions(+), 348 deletions(-)

-- 
2.25.1

