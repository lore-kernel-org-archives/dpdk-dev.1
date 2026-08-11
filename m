Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7C4C5AC67
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 11:57:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA93B40E1F;
	Tue, 11 Aug 2026 13:57:38 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id DF27E4027F
 for <dev@dpdk.org>; Tue, 11 Aug 2026 13:57:36 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9DB411A018C;
 Tue, 11 Aug 2026 13:57:36 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 66D2A1A006E;
 Tue, 11 Aug 2026 13:57:36 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 0CBA918000B1;
 Tue, 11 Aug 2026 19:57:34 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Subject: [PATCH v8 00/26] DPAA driver fixes and improvements
Date: Tue, 11 Aug 2026 17:27:05 +0530
Message-Id: <20260811115731.3421032-1-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260703124950.1895871-1-hemant.agrawal@nxp.com>
References: <20260703124950.1895871-1-hemant.agrawal@nxp.com>
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


Gagandeep Singh (4):
  net/dpaa: fix device remove
  bus/dpaa: enhance DPAA FQ shutdown
  dma/dpaa: add SG data validation and ERR050757
  drivers: add offline (O/H) port device support

Hemant Agrawal (5):
  net/dpaa: optimize FM deconfig
  net/dpaa: support Rx/Tx taildrop threshold devarg
  net/dpaa: add Tx rate limiting API
  net/dpaa: support non fmX-macY type of shared Ethernet name
  bus/dpaa: improve log macro and fix bus detection

Jun Yang (15):
  drivers: improve  crypto fq resource handling
  bus/dpaa: refine fman naming and fix global scope
  bus/dpaa: scan max BPID from DTS
  bus/dpaa: define helpers for qman channel and wq
  drivers: shutdown DPAA FQ by fq descriptor
  bus/dpaa: improve FQ shutdown with channel validation
  bus/dpaa: add DPAA cgrid cleanup support
  drivers: add BMI Tx statistics
  net/dpaa: optimize FMC MAC type parsing
  drivers: release DPAA bpid on driver destructor
  bus/dpaa: orp queue create and burst enqueue
  net/dpaa: support fmcless rxq number as devargs
  drivers: optimize DPAA multi-entry buffer pool operations
  drivers: improve shutdown fq with channel
  drivers: memory free in destructor

Prashant Gupta (1):
  drivers: add process-type guards for secondary process

Vanshika Shukla (1):
  net/dpaa: enhance VSP port support

 doc/guides/nics/dpaa.rst                  |  38 +-
 drivers/bus/dpaa/base/fman/fman.c         |  23 +-
 drivers/bus/dpaa/base/fman/fman_hw.c      | 104 ++--
 drivers/bus/dpaa/base/qbman/bman.c        |  59 +-
 drivers/bus/dpaa/base/qbman/bman_driver.c |  49 +-
 drivers/bus/dpaa/base/qbman/qman.c        | 196 ++++--
 drivers/bus/dpaa/base/qbman/qman.h        |  23 +-
 drivers/bus/dpaa/base/qbman/qman_driver.c |  29 +-
 drivers/bus/dpaa/bus_dpaa_driver.h        |  11 +-
 drivers/bus/dpaa/dpaa_bus.c               | 164 +++--
 drivers/bus/dpaa/dpaa_bus_base_symbols.c  |   4 +
 drivers/bus/dpaa/include/fman.h           |  13 +-
 drivers/bus/dpaa/include/fsl_bman.h       |  49 +-
 drivers/bus/dpaa/include/fsl_qman.h       |  51 +-
 drivers/common/dpaax/compat.h             |  22 +-
 drivers/common/dpaax/dpaax_iova_table.c   |  25 +-
 drivers/crypto/dpaa_sec/dpaa_sec.c        | 106 +++-
 drivers/dma/dpaa/dpaa_qdma.c              |  80 ++-
 drivers/mempool/dpaa/dpaa_mempool.c       |  77 ++-
 drivers/mempool/dpaa/dpaa_mempool.h       |   3 +-
 drivers/net/dpaa/dpaa_ethdev.c            | 281 +++++++--
 drivers/net/dpaa/dpaa_ethdev.h            |  25 +-
 drivers/net/dpaa/dpaa_flow.c              | 211 +++++--
 drivers/net/dpaa/dpaa_flow.h              |   7 +-
 drivers/net/dpaa/dpaa_fmc.c               |  73 ++-
 drivers/net/dpaa/dpaa_oldev.c             | 701 ++++++++++++++++++++++
 drivers/net/dpaa/fmlib/fm_lib.c           |  32 +-
 drivers/net/dpaa/fmlib/fm_port_ext.h      |   4 +-
 drivers/net/dpaa/meson.build              |  11 +-
 drivers/net/dpaa/rte_pmd_dpaa.h           |  21 +-
 drivers/net/dpaa/rte_pmd_dpaa_oldev.h     |  92 +++
 31 files changed, 2136 insertions(+), 448 deletions(-)
 create mode 100644 drivers/net/dpaa/dpaa_oldev.c
 create mode 100644 drivers/net/dpaa/rte_pmd_dpaa_oldev.h

-- 
2.25.1

