Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6C4CC6B38
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 11:20:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67CE0402DA;
	Fri, 16 Oct 2026 13:20:03 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id A739E400D7
 for <dev@dpdk.org>; Fri, 16 Oct 2026 13:20:02 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 653A4200207;
 Fri, 16 Oct 2026 13:20:02 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3B6A9200201;
 Fri, 16 Oct 2026 13:20:02 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 6FFAE18000B5;
 Fri, 16 Oct 2026 19:20:01 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Subject: [PATCH v27 00/25] NXP DPAA driver enhancements and fixes
Date: Fri, 16 Oct 2026 16:49:33 +0530
Message-Id: <20261016111958.163060-1-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261015141144.3140281-1-hemant.agrawal@nxp.com>
References: <20261015141144.3140281-1-hemant.agrawal@nxp.com>
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

This series collects a set of fixes and enhancements for the NXP DPAA
bus, mempool, dma, crypto and net drivers targeting 26.11.
 
It includes memory-leak and resource-cleanup fixes on the device
remove/close paths, more robust frame queue shutdown, secondary-process
safety guards, BPID lifecycle handling, and several new features:
enhanced virtual storage profile (VSP) port support, fmcless Rx queue
configuration, non fmX-macY shared Ethernet naming, and DMA
scatter-gather and errata-workaround devargs. Documentation and release
notes are updated accordingly.
 
V27:
- fixed qm_channel_pool_num check issue.
- fixed commit message as devarg for fmcless rxq number was removed.
- Added missing export internal symbol and fq destroy.
- merged both FQ shutdown patches as we cannot change the sequence
   because of the dependency.
- mac_idx has a user which is dpaa flow so no change. Added static to
   g_fmc_model and updated release notes.
- Issues reported in v25 which are not handled, were optional, so
   skipping them.

Hemant Agrawal (13):
  net/dpaa: fix double close and null deref on remove
  net/dpaa: fix probe success when FMC init fails
  net/dpaa: fix resource leak on probe failure
  net/dpaa: fix free port resources on close
  mempool/dpaa: fix write after free on pool free
  dma/dpaa: fix data validation on the completion path
  net/dpaa: prefix fmlib device helpers
  bus/dpaa: accept QDMA device name in devargs
  bus/dpaa: scan pool channel range from DTS
  net/dpaa: optimize FM deconfig
  dma/dpaa: add devargs for SG and errata workaround
  bus/dpaa: improve log macro usages
  doc: update release notes with NXP DPAA changes

Jun Yang (9):
  bus/dpaa: fix hang on FQ shutdown
  bus/dpaa: refine fman naming
  bus/dpaa: scan max BPID from DTS
  drivers: add BMI Tx statistics
  net/dpaa: optimize FMC MAC type parsing
  drivers: release DPAA bpid on driver destructor
  net/dpaa: create max Rx queues in FMCLESS mode
  bus/dpaa: optimize DPAA multi-entry buffer pool operations
  drivers: improve DPAA crypto fq resource handling

Prashant Gupta (2):
  bus/dpaa: fix FQD dest wq channel decoding
  drivers: add process-type guards for secondary process

Vanshika Shukla (1):
  net/dpaa: enhance VSP port support

 doc/guides/dmadevs/dpaa.rst               |  30 +++-
 doc/guides/rel_notes/release_26_11.rst    |  17 ++
 drivers/bus/dpaa/base/fman/fman.c         |  23 ++-
 drivers/bus/dpaa/base/fman/fman_hw.c      | 202 ++++++++++++++--------
 drivers/bus/dpaa/base/fman/netcfg_layer.c |   8 +-
 drivers/bus/dpaa/base/qbman/bman.c        |  66 +++----
 drivers/bus/dpaa/base/qbman/bman_driver.c |  78 +++++----
 drivers/bus/dpaa/base/qbman/bman_priv.h   |   5 -
 drivers/bus/dpaa/base/qbman/qman.c        | 110 ++++++------
 drivers/bus/dpaa/base/qbman/qman.h        |  23 ++-
 drivers/bus/dpaa/base/qbman/qman_driver.c |  39 ++++-
 drivers/bus/dpaa/dpaa_bus.c               |  94 +++++-----
 drivers/bus/dpaa/dpaa_bus_base_symbols.c  |   4 +
 drivers/bus/dpaa/include/fman.h           |  32 +++-
 drivers/bus/dpaa/include/fsl_bman.h       |  56 +++++-
 drivers/bus/dpaa/include/fsl_qman.h       |  27 ++-
 drivers/bus/dpaa/rte_dpaa_logs.h          |   2 +
 drivers/crypto/dpaa_sec/dpaa_sec.c        | 176 +++++++++++++++++--
 drivers/dma/dpaa/dpaa_qdma.c              | 120 ++++++++++---
 drivers/mempool/dpaa/dpaa_mempool.c       |  53 +++++-
 drivers/net/dpaa/dpaa_ethdev.c            | 192 ++++++++++++--------
 drivers/net/dpaa/dpaa_ethdev.h            |  26 ++-
 drivers/net/dpaa/dpaa_flow.c              | 143 ++++++++-------
 drivers/net/dpaa/dpaa_flow.h              |   7 +-
 drivers/net/dpaa/dpaa_fmc.c               |  93 ++++++----
 drivers/net/dpaa/fmlib/fm_lib.c           |   4 +-
 drivers/net/dpaa/fmlib/ncsw_ext.h         |   4 +-
 27 files changed, 1121 insertions(+), 513 deletions(-)

-- 
2.25.1

