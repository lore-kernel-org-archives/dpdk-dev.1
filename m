Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119A1CC6B03
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 10:38:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9451402EA;
	Tue, 13 Oct 2026 12:38:38 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id DBBF840279
 for <dev@dpdk.org>; Tue, 13 Oct 2026 12:38:37 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A38291A0085;
 Tue, 13 Oct 2026 12:38:37 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6AED71A0004;
 Tue, 13 Oct 2026 12:38:37 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 997F91800068;
 Tue, 13 Oct 2026 18:38:36 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Subject: [PATCH v25 00/24] NXP DPAA driver enhancements and fixes
Date: Tue, 13 Oct 2026 16:08:09 +0530
Message-Id: <20261013103833.3822265-1-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261012080845.2325199-1-hemant.agrawal@nxp.com>
References: <20261012080845.2325199-1-hemant.agrawal@nxp.com>
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
configuration via devargs, non fmX-macY shared Ethernet naming, and DMA
scatter-gather and errata-workaround devargs. Documentation and release
notes are updated accordingly.

v25:
* Dropped the offline (O/H) port and DPAA cgrid cleanup patches, and
  the Rx/Tx taildrop devargs patch whose Rx threshold was overwritten
  by nb_desc at queue setup. Now 24 patches.
* net/dpaa: keep the shared MAC base profile exempt from the one pool
  per VSP check; it is identified by bp_num, not by vsp_bp[0].

v24:
* fix clang 23 compilation

v23:
* crypto/dpaa_sec: release the FQIDs as contiguous runs again. v22
  released them one at a time, which cost one ioctl per queue, up to
  4096 for inq[], undoing the batching this patch adds. Runs of
  adjacent FQIDs that shut down cleanly are now freed with a single
  qman_release_fqid_range(), and a queue that fails to shut down
  still keeps its FQID reserved.
* net/dpaa: correct the NULL deref trigger in the remove fix commit
  message. dpaa_bus_cleanup() only calls remove for probed devices,
  so the case is an application that closed its ports before
  rte_eal_cleanup().
* net/dpaa: commit message for the fmcless rxq devarg now matches the
  code: a malformed value is rejected instead of using the default.
* bus/dpaa: drop the write-only bman_ip_rev and qm_channel_pme
  globals, which clang 23 rejects with -Wunused-but-set-global.
  Folded into the patches that made them write-only so each builds
  clean on its own.

v22:
* crypto/dpaa_sec: same fix in dpaa_sec_uninit(), releasing only the
  FQIDs whose queues shut down.
* net/dpaa: correct the Fixes tag on the FMC init fix; the referred
  commit is f5fe3eed5122, not f5fe3eed51d2.
* drivers: drop the now-unused DPAA_1G_MAC_START_IDX,
  DPAA_2_5G_MAC_START_IDX, HI16_OF_U48() and LO32_OF_U48(), and the
  dead num_rx_fqs store on the FMC init error path.
* mempool/dpaa: pass the destructor priority as a literal to
  RTE_FINI_PRIO(); the macro token pastes its argument onto
  RTE_PRIORITY_, so the numeric macro has to stay.
* doc: record that the default FMCLESS Rx queue count changed from
  the lcore count to the per-port maximum.

v21:
* net/dpaa: jump to free_tx on the tx_conf_queues, cgr_tx and Tx
  CGRID-range failures in dpaa_dev_init(); free_rx releases neither
  tx_queues nor tx_conf_queues, so those two arrays leaked.
* net/dpaa: range-check the drv_fmcless_rxq devarg value before
  narrowing it, and stop treating a parse error as an absent key.
* Commit messages: removed statements describing changes that were
  not in the corresponding diff.

v20:
* net/dpaa: propagate the dpaa_port_fmc_init() error instead of
  returning success with no Rx queues, as a separate fix with a
  Fixes tag so it can be backported.
* doc: log an over-long drv_sh_if_name.

v19:
	addressed AI review comments

Still open, to be fixed in a follow-up series rather than here:
qman_create_fq() also takes an FQ lookup table entry on 64-bit, and
only qman_destroy_fq() clears it. Releasing it needs the FQ marked
out of service after shutdown (qman_shutdown_fq() leaves fq->state
untouched) and a new exported bus/dpaa helper, so it is grouped with
the pre-existing FMCLESS Rx FQID leak in net/dpaa.

Gagandeep Singh (1):
  dma/dpaa: add devargs for SG and errata workaround

Hemant Agrawal (10):
  net/dpaa: fix double close and null deref on remove
  net/dpaa: fix probe success when FMC init fails
  net/dpaa: fix resource leak on probe failure
  net/dpaa: fix free port resources on close
  bus/dpaa: accept QDMA device name in devargs
  net/dpaa: optimize FM deconfig
  mempool/dpaa: fix write after free on pool free
  net/dpaa: support non fmX-macY type of shared Ethernet name
  bus/dpaa: improve log macro usages
  doc: update release notes with NXP DPAA changes

Jun Yang (10):
  bus/dpaa: refine fman naming
  bus/dpaa: scan max BPID from DTS
  drivers: shutdown DPAA FQ by fq descriptor
  bus/dpaa: improve FQ shutdown with channel validation
  drivers: add BMI Tx statistics
  net/dpaa: optimize FMC MAC type parsing
  drivers: release DPAA bpid on driver destructor
  net/dpaa: support fmcless rxq number as devargs
  bus/dpaa: optimize DPAA multi-entry buffer pool operations
  drivers: improve DPAA crypto fq resource handling

Prashant Gupta (2):
  bus/dpaa: fix FQD dest wq channel decoding
  drivers: add process-type guards for secondary process

Vanshika Shukla (1):
  net/dpaa: enhance VSP port support

 doc/guides/dmadevs/dpaa.rst               |  30 +-
 doc/guides/nics/dpaa.rst                  |  19 +-
 doc/guides/rel_notes/release_26_11.rst    |  19 ++
 drivers/bus/dpaa/base/fman/fman.c         |  23 +-
 drivers/bus/dpaa/base/fman/fman_hw.c      | 202 ++++++++-----
 drivers/bus/dpaa/base/fman/netcfg_layer.c |   8 +-
 drivers/bus/dpaa/base/qbman/bman.c        |  60 ++--
 drivers/bus/dpaa/base/qbman/bman_driver.c |  76 +++--
 drivers/bus/dpaa/base/qbman/bman_priv.h   |   5 -
 drivers/bus/dpaa/base/qbman/qman.c        | 114 ++++----
 drivers/bus/dpaa/base/qbman/qman.h        |  23 +-
 drivers/bus/dpaa/base/qbman/qman_driver.c |  29 +-
 drivers/bus/dpaa/dpaa_bus.c               |  91 +++---
 drivers/bus/dpaa/dpaa_bus_base_symbols.c  |   3 +
 drivers/bus/dpaa/include/fman.h           |  32 +-
 drivers/bus/dpaa/include/fsl_bman.h       |  56 +++-
 drivers/bus/dpaa/include/fsl_qman.h       |  26 +-
 drivers/bus/dpaa/rte_dpaa_logs.h          |   2 +
 drivers/crypto/dpaa_sec/dpaa_sec.c        | 147 ++++++++--
 drivers/dma/dpaa/dpaa_qdma.c              | 120 ++++++--
 drivers/mempool/dpaa/dpaa_mempool.c       |  72 ++++-
 drivers/mempool/dpaa/dpaa_mempool.h       |   2 +-
 drivers/net/dpaa/dpaa_ethdev.c            | 337 +++++++++++++++++-----
 drivers/net/dpaa/dpaa_ethdev.h            |  22 +-
 drivers/net/dpaa/dpaa_flow.c              | 129 +++++----
 drivers/net/dpaa/dpaa_flow.h              |   7 +-
 drivers/net/dpaa/dpaa_fmc.c               |  91 ++++--
 27 files changed, 1240 insertions(+), 505 deletions(-)

-- 
2.25.1

