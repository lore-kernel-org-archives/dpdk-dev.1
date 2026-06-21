Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC4ACD98F2
	for <dpdk-dev@archiver.kernel.org>; Sun, 21 Jun 2026 17:27:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0EA734021F;
	Sun, 21 Jun 2026 19:27:39 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 0B8F540150
 for <dev@dpdk.org>; Sun, 21 Jun 2026 19:27:37 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BCB3C1A0235;
 Sun, 21 Jun 2026 19:27:36 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 83F311A0232;
 Sun, 21 Jun 2026 19:27:36 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 0D922180004C;
 Mon, 22 Jun 2026 01:27:34 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	david.marchand@redhat.com,
	dev@dpdk.org
Subject: [PATCH v4 00/19] dpaa: driver stability and feature improvements
Date: Sun, 21 Jun 2026 22:57:12 +0530
Message-Id: <20260621172731.2916346-1-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260621152228.2777171-1-hemant.agrawal@nxp.com>
References: <20260621152228.2777171-1-hemant.agrawal@nxp.com>
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

1. Bus/fman infrastructure cleanups (patches 01, 02, 13)
   - bus/dpaa: refine fman naming and fix global scope
   - bus/dpaa: scan max BPID from DTS
   - bus/dpaa: improve log macro and fix bus detection

2. Statistics (patch 03)
   - net/dpaa: add BMI Tx statistics

3. Process-type guards (patch 04)
   - dpaa: add process-type guards to prevent segfaults in secondary

4. FQ shutdown hardening (patches 05-11)
   - bus/dpaa: define helpers for qman channel and wq
   - drivers: shutdown DPAA FQ by fq descriptor
   - bus/dpaa: improve FQ shutdown with channel validation
   - bus/dpaa: enhance DPAA FQ shutdown
   - drivers: add DPAA cgrid cleanup support
   - net/dpaa: clean Tx confirmation FQ on device stop
   - net/dpaa: remove redundant FQ shutdown from Rx queue setup

5. net/dpaa improvements (patches 12, 14, 15)
   - net/dpaa: optimize FM deconfig
   - net/dpaa: optimize FMC MAC type parsing
   - net/dpaa: report error on using deferred start

6. mempool/dpaa (patches 16-17)
   - drivers: optimize DPAA multi-entry buffer pool operations
   - drivers: release DPAA bpid on driver destructor

7. dma/dpaa (patch 18)
   - dma/dpaa: add SG data validation and ERR050757 fix

8. net/dpaa ONIC port support (patch 19)
   - net/dpaa: add ONIC port checks

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
 drivers/bus/dpaa/base/fman/fman_hw.c      | 108 +++++++++----------
 drivers/bus/dpaa/base/qbman/bman.c        |  59 ++++-------
 drivers/bus/dpaa/base/qbman/bman_driver.c |  48 ++++++---
 drivers/bus/dpaa/base/qbman/qman.c        | 115 +++++++++++---------
 drivers/bus/dpaa/base/qbman/qman.h        |  23 +++-
 drivers/bus/dpaa/base/qbman/qman_driver.c |  29 ++++-
 drivers/bus/dpaa/dpaa_bus.c               |  33 ++++--
 drivers/bus/dpaa/dpaa_bus_base_symbols.c  |   4 +
 drivers/bus/dpaa/include/fman.h           |  30 +++++-
 drivers/bus/dpaa/include/fsl_bman.h       |  49 +++++++--
 drivers/bus/dpaa/include/fsl_qman.h       |  22 +++-
 drivers/crypto/dpaa_sec/dpaa_sec.c        |   3 -
 drivers/dma/dpaa/dpaa_qdma.c              | 102 +++++++++++++-----
 drivers/mempool/dpaa/dpaa_mempool.c       |  75 +++++++++++--
 drivers/mempool/dpaa/dpaa_mempool.h       |   3 +-
 drivers/net/dpaa/dpaa_ethdev.c            | 122 ++++++++++++++++++----
 drivers/net/dpaa/dpaa_ethdev.h            |  22 +++-
 drivers/net/dpaa/dpaa_flow.c              | 120 +++++++++++----------
 drivers/net/dpaa/dpaa_flow.h              |   7 +-
 drivers/net/dpaa/dpaa_fmc.c               |  73 ++++++++-----
 21 files changed, 725 insertions(+), 345 deletions(-)

-- 
2.25.1

