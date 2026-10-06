Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB00CA5FF0
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 09:27:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B68D340270;
	Tue,  6 Oct 2026 11:27:08 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 8F95540270
 for <dev@dpdk.org>; Tue,  6 Oct 2026 11:27:07 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 546DF200231;
 Tue,  6 Oct 2026 11:27:07 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1E755200223;
 Tue,  6 Oct 2026 11:27:07 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 9FCCD1800226;
 Tue,  6 Oct 2026 17:27:06 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Subject: [PATCH v21 00/27] NXP DPAA driver enhancements and fixes
Date: Tue,  6 Oct 2026 14:56:36 +0530
Message-Id: <20261006092703.2138929-1-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261005085337.1069213-1-hemant.agrawal@nxp.com>
References: <20261005085337.1069213-1-hemant.agrawal@nxp.com>
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
remove/close paths, more robust frame queue and congestion-group
shutdown, secondary-process safety guards, BPID and cgrid lifecycle
handling, and several new features: offline (O/H) port device support,
enhanced virtual storage profile (VSP) port support, fmcless Rx queue
configuration via devargs, Rx/Tx taildrop threshold devargs, non
fmX-macY shared Ethernet naming, and DMA scatter-gather and
errata-workaround devargs. Documentation and release notes are updated
accordingly.

v21:
* net/dpaa: jump to free_tx on the tx_conf_queues, cgr_tx and Tx
  CGRID-range failures in dpaa_dev_init(); free_rx releases neither
  tx_queues nor tx_conf_queues, so those two arrays leaked.
* net/dpaa: range-check the drv_rx_taildrop, drv_tx_taildrop and
  drv_fmcless_rxq devarg values before narrowing them, and stop
  treating a parse error as an absent key. A value such as
  4294967296 truncated to 0 and silently disabled taildrop.
* drivers: release the Rx and Tx FQIDs in the offline port close
  path; both queues are created with QMAN_FQ_FLAG_DYNAMIC_FQID, so
  every probe/close cycle leaked one FQID per queue.
* drivers: save errno before logging it in the six offline port
  ask_ctrl ioctl error paths, so the value returned to the caller
  is the one the ioctl failed with.
* net/dpaa: correct the Fixes tag on the FMC init fix; the referred
  commit is f5fe3eed5122, not f5fe3eed51d2.
* drivers: drop the now-unused DPAA_1G_MAC_START_IDX,
  DPAA_2_5G_MAC_START_IDX, HI16_OF_U48() and LO32_OF_U48(), and the
  dead num_rx_fqs store on the FMC init error path.
* mempool/dpaa: pass the destructor priority as a literal to
  RTE_FINI_PRIO(), matching net/dpaa and bus/dpaa; the macro token
  pastes its argument onto RTE_PRIORITY_.
* Commit messages: removed statements describing changes that were
  not in the corresponding diff (the dma_pool_alloc() NULL phy_addr
  claim, the FSL_BM_BURST_MAX replacement, the "old affinity check"
  in qman_shutdown_fq(), and the drain-portal claims about callers
  introduced later in the series).

v20:
* net/dpaa: propagate the dpaa_port_fmc_init() error instead of
  returning success with no Rx queues, as a separate fix with a
  Fixes tag so it can be backported.
* drivers: drop the unused rte_dpaa_bus_oldev_enabled() and add
  rte_pmd_dpaa_oldev.h to doc/api/doxy-api-index.md.
* drivers: use qman_pending_fq_by_cgrid_range() over the whole Rx
  and Tx CGRID range, so a port close costs two FQID space scans
  rather than one per congestion group.
* doc: name the new experimental offline port functions in the
  release notes, document that drv_oldev switches the bus to
  allowlist mode, and log an over-long drv_sh_if_name.

v19:
	addressed AI review comments

Gagandeep Singh (2):
  dma/dpaa: add devargs for SG and errata workaround
  drivers: add offline (O/H) port device support

Hemant Agrawal (11):
  net/dpaa: fix double close and null deref on remove
  net/dpaa: fix probe success when FMC init fails
  net/dpaa: fix resource leak on probe failure
  net/dpaa: fix free port resources on close
  bus/dpaa: accept QDMA device name in devargs
  net/dpaa: optimize FM deconfig
  mempool/dpaa: fix write after free on pool free
  net/dpaa: support Rx/Tx taildrop threshold devarg
  net/dpaa: support non fmX-macY type of shared Ethernet name
  bus/dpaa: improve log macro usages
  doc: update release notes with NXP DPAA changes

Jun Yang (11):
  bus/dpaa: refine fman naming
  bus/dpaa: scan max BPID from DTS
  drivers: shutdown DPAA FQ by fq descriptor
  drivers: add DPAA cgrid cleanup support
  bus/dpaa: improve FQ shutdown with channel validation
  drivers: add BMI Tx statistics
  net/dpaa: optimize FMC MAC type parsing
  drivers: release DPAA bpid on driver destructor
  net/dpaa: support fmcless rxq number as devargs
  bus/dpaa: optimize DPAA multi-entry buffer pool operations
  crypto/dpaa_sec: improve crypto fq resource handling

Prashant Gupta (2):
  bus/dpaa: fix FQD dest wq channel decoding
  drivers: add process-type guards for secondary process

Vanshika Shukla (1):
  net/dpaa: enhance VSP port support

 doc/api/doxy-api-index.md                 |   1 +
 doc/guides/dmadevs/dpaa.rst               |  30 +-
 doc/guides/nics/dpaa.rst                  |  50 +-
 doc/guides/rel_notes/release_26_11.rst    |  28 +
 drivers/bus/dpaa/base/fman/fman.c         |  42 +-
 drivers/bus/dpaa/base/fman/fman_hw.c      | 202 +++--
 drivers/bus/dpaa/base/fman/netcfg_layer.c |   8 +-
 drivers/bus/dpaa/base/qbman/bman.c        |  60 +-
 drivers/bus/dpaa/base/qbman/bman_driver.c |  65 +-
 drivers/bus/dpaa/base/qbman/qman.c        | 175 +++--
 drivers/bus/dpaa/base/qbman/qman.h        |  23 +-
 drivers/bus/dpaa/base/qbman/qman_driver.c |  29 +-
 drivers/bus/dpaa/bus_dpaa_driver.h        |   4 +-
 drivers/bus/dpaa/dpaa_bus.c               | 187 +++--
 drivers/bus/dpaa/dpaa_bus_base_symbols.c  |   4 +
 drivers/bus/dpaa/include/fman.h           |  36 +-
 drivers/bus/dpaa/include/fsl_bman.h       |  56 +-
 drivers/bus/dpaa/include/fsl_qman.h       |  50 +-
 drivers/bus/dpaa/rte_dpaa_logs.h          |   2 +
 drivers/crypto/dpaa_sec/dpaa_sec.c        | 117 ++-
 drivers/dma/dpaa/dpaa_qdma.c              | 120 ++-
 drivers/mempool/dpaa/dpaa_mempool.c       |  67 +-
 drivers/mempool/dpaa/dpaa_mempool.h       |   2 +-
 drivers/net/dpaa/dpaa_ethdev.c            | 507 ++++++++++---
 drivers/net/dpaa/dpaa_ethdev.h            |  25 +-
 drivers/net/dpaa/dpaa_flow.c              | 134 ++--
 drivers/net/dpaa/dpaa_flow.h              |   7 +-
 drivers/net/dpaa/dpaa_fmc.c               |  91 ++-
 drivers/net/dpaa/dpaa_oldev.c             | 866 ++++++++++++++++++++++
 drivers/net/dpaa/meson.build              |  11 +-
 drivers/net/dpaa/rte_pmd_dpaa_oldev.h     | 158 ++++
 31 files changed, 2647 insertions(+), 510 deletions(-)
 create mode 100644 drivers/net/dpaa/dpaa_oldev.c
 create mode 100644 drivers/net/dpaa/rte_pmd_dpaa_oldev.h

-- 
2.25.1

