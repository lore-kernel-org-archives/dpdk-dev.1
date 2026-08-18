Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14721C5DF7E
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 11:17:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D3DDF40269;
	Tue, 18 Aug 2026 13:17:38 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id A1AA740269
 for <dev@dpdk.org>; Tue, 18 Aug 2026 13:17:36 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5D617200292;
 Tue, 18 Aug 2026 13:17:36 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 226E1200283;
 Tue, 18 Aug 2026 13:17:36 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 26BDD18000B0;
 Tue, 18 Aug 2026 19:17:34 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Subject: [PATCH v12 00/26] NXP DPAA driver fixes and enhancements
Date: Tue, 18 Aug 2026 16:47:04 +0530
Message-Id: <20260818111730.801760-1-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260813144205.2505031-1-hemant.agrawal@nxp.com>
References: <20260813144205.2505031-1-hemant.agrawal@nxp.com>
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

This series contains a collection of fixes and enhancements for the NXP
DPAA bus, mempool, dma, crypto and net drivers. It addresses several
resource cleanup and shutdown issues, adds new offline (O/H) port device
support, and introduces a number of performance and usability
improvements.

Highlights:
- Fix device remove, Tx confirmation queue leak and FQD dest wq decoding.
- Add process-type guards for secondary process and improve FQ shutdown
  and cgrid cleanup handling.
- Add offline (O/H) port device support with a new PMD-specific API.
- Add Tx rate limiting API, Rx/Tx taildrop threshold devarg, fmcless rxq
  number devarg and non fmX-macY shared Ethernet name support.
- Optimize FMAN deconfig, FMC MAC type parsing and buffer pool
  operations.

v11 -> v12:
- fixed recent AI review comments

Gagandeep Singh (3):
  net/dpaa: fix device remove
  dma/dpaa: add SG data validation and ERR050757
  drivers: add offline (O/H) port device support

Hemant Agrawal (7):
  net/dpaa: fix Tx confirmation queue memory leak
  net/dpaa: optimize FM deconfig
  net/dpaa: support Rx/Tx taildrop threshold devarg
  net/dpaa: add Tx rate limiting API
  net/dpaa: support non fmX-macY type of shared Ethernet name
  bus/dpaa: improve log macro and fix bus detection
  doc: update release notes with NXP DPAA changes

Jun Yang (13):
  bus/dpaa: refine fman naming
  bus/dpaa: scan max BPID from DTS
  drivers: shutdown DPAA FQ by fq descriptor
  drivers: add DPAA cgrid cleanup support
  bus/dpaa: improve FQ shutdown with channel validation
  drivers: add BMI Tx statistics
  net/dpaa: optimize FMC MAC type parsing
  drivers: release DPAA bpid on driver destructor
  bus/dpaa: orp queue create and burst enqueue
  net/dpaa: support fmcless rxq number as devargs
  bus/dpaa: optimize DPAA multi-entry buffer pool operations
  crypto/dpaa_sec: improve  crypto fq resource handling
  drivers: add dpaax enter destructor to gate EAL memory frees

Prashant Gupta (2):
  bus/dpaa: fix FQD dest wq channel decoding
  drivers: add process-type guards for secondary process

Vanshika Shukla (1):
  net/dpaa: enhance VSP port support

 doc/guides/dmadevs/dpaa.rst               |  30 +-
 doc/guides/nics/dpaa.rst                  |  39 +-
 doc/guides/rel_notes/release_26_11.rst    |  40 ++
 drivers/bus/dpaa/base/fman/fman.c         |  42 +-
 drivers/bus/dpaa/base/fman/fman_hw.c      | 200 +++---
 drivers/bus/dpaa/base/qbman/bman.c        |  59 +-
 drivers/bus/dpaa/base/qbman/bman_driver.c |  51 +-
 drivers/bus/dpaa/base/qbman/qman.c        | 264 ++++++--
 drivers/bus/dpaa/base/qbman/qman.h        |  23 +-
 drivers/bus/dpaa/base/qbman/qman_driver.c |  29 +-
 drivers/bus/dpaa/bus_dpaa_driver.h        |  11 +-
 drivers/bus/dpaa/dpaa_bus.c               | 166 +++--
 drivers/bus/dpaa/dpaa_bus_base_symbols.c  |   4 +
 drivers/bus/dpaa/include/fman.h           |  25 +-
 drivers/bus/dpaa/include/fsl_bman.h       |  49 +-
 drivers/bus/dpaa/include/fsl_qman.h       |  55 +-
 drivers/common/dpaax/compat.h             |  22 +-
 drivers/common/dpaax/dpaax_iova_table.c   |  25 +-
 drivers/crypto/dpaa_sec/dpaa_sec.c        | 109 +++-
 drivers/dma/dpaa/dpaa_qdma.c              | 110 +++-
 drivers/mempool/dpaa/dpaa_mempool.c       |  64 +-
 drivers/mempool/dpaa/dpaa_mempool.h       |   3 +-
 drivers/net/dpaa/dpaa_ethdev.c            | 351 ++++++++--
 drivers/net/dpaa/dpaa_ethdev.h            |  28 +-
 drivers/net/dpaa/dpaa_flow.c              | 220 +++++--
 drivers/net/dpaa/dpaa_flow.h              |   7 +-
 drivers/net/dpaa/dpaa_fmc.c               |  84 ++-
 drivers/net/dpaa/dpaa_oldev.c             | 762 ++++++++++++++++++++++
 drivers/net/dpaa/fmlib/fm_lib.c           |  32 +-
 drivers/net/dpaa/fmlib/fm_port_ext.h      |   4 +-
 drivers/net/dpaa/meson.build              |  11 +-
 drivers/net/dpaa/rte_pmd_dpaa.h           |  23 +-
 drivers/net/dpaa/rte_pmd_dpaa_oldev.h     | 145 ++++
 33 files changed, 2614 insertions(+), 473 deletions(-)
 create mode 100644 drivers/net/dpaa/dpaa_oldev.c
 create mode 100644 drivers/net/dpaa/rte_pmd_dpaa_oldev.h

-- 
2.25.1
