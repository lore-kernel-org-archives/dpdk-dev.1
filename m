Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AD3CC6B3A
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 14:11:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0719140656;
	Thu, 15 Oct 2026 16:11:50 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 634754064C
 for <dev@dpdk.org>; Thu, 15 Oct 2026 16:11:48 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2AA94200087;
 Thu, 15 Oct 2026 16:11:48 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EA17D20006D;
 Thu, 15 Oct 2026 16:11:47 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 2AA0E1800068;
 Thu, 15 Oct 2026 22:11:47 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Subject: [PATCH v26 00/26] NXP DPAA driver enhancements and fixes
Date: Thu, 15 Oct 2026 19:41:18 +0530
Message-Id: <20261015141144.3140281-1-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261013103833.3822265-1-hemant.agrawal@nxp.com>
References: <20261013103833.3822265-1-hemant.agrawal@nxp.com>
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

v26:
* bus/dpaa: split the FQ shutdown hang fix out as its own patch with
  Fixes/Cc: stable, and keep the DTS pool-channel-range scan as a
  separate feature patch.
* dma/dpaa: split the data-validation gating out as its own fix with
  Fixes/Cc: stable, ahead of the SG/errata devargs feature patch.
* bus/dpaa: fixed "scan max BPID from DTS" commit message to describe
  the bman_ip_rev removal and the now-fatal missing-node/CCSR-map
  paths, and moved the BPID range log from pr_info() to
  DPAA_BUS_DEBUG() so it no longer prints to stdout on every start.
* net/dpaa: fixed use-after-free in VSP: the per-profile buffer pool
  is now stored by BPID and size instead of a dpaa_bp_info pointer,
  which could be freed by dpaa_mbuf_free_pool() while the port was
  still around.
* bus/dpaa: stopped bman_release_fast() from writing the verb byte of
  a multi-entry release command before the rest of the entry is
  built.
* dma/dpaa: propagated the enqueue status instead of forcing -EIO on
  a transient ring-full condition in the non-SG path.
* crypto/dpaa_sec: affined a portal in dpaa_sec_uninit() before
  calling qman_shutdown_fq(), and stopped releasing the FQID of a
  queue that failed to shut down on the probe error paths, matching
  the rule the normal uninit path already follows.
* drivers: made the DPAA QDMA secondary-process probe return a
  positive value instead of -ENOTSUP, so the bus skips the device
  quietly instead of logging three errors.
* net/dpaa: dropped the drv_fmcless_rxq devarg; FMCLESS mode now
  always creates the maximum number of queues and lets
  rte_eth_dev_configure() decide how many are used.
* net/dpaa: renamed the global fmlib create_device() and
  get_device_id() helpers to fm_create_device() and
  fm_get_device_id(), the only two global symbols in the driver
  without the fm_/dpaa_ prefix.
* doc: updated the release notes to match the bullets above instead
  of the devargs from the previous version.


Hemant Agrawal (14):
  net/dpaa: fix double close and null deref on remove
  net/dpaa: fix probe success when FMC init fails
  net/dpaa: fix resource leak on probe failure
  net/dpaa: fix free port resources on close
  bus/dpaa: accept QDMA device name in devargs
  bus/dpaa: fix hang on FQ shutdown
  bus/dpaa: scan pool channel range from DTS
  net/dpaa: optimize FM deconfig
  mempool/dpaa: fix write after free on pool free
  dma/dpaa: fix data validation on the completion path
  dma/dpaa: add devargs for SG and errata workaround
  bus/dpaa: improve log macro usages
  net/dpaa: prefix fmlib device helpers
  doc: update release notes with NXP DPAA changes

Jun Yang (9):
  bus/dpaa: refine fman naming
  bus/dpaa: scan max BPID from DTS
  drivers: shutdown DPAA FQ by fq descriptor
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

 doc/guides/dmadevs/dpaa.rst               |  30 +++-
 doc/guides/rel_notes/release_26_11.rst    |  17 ++
 drivers/bus/dpaa/base/fman/fman.c         |  23 ++-
 drivers/bus/dpaa/base/fman/fman_hw.c      | 202 ++++++++++++++--------
 drivers/bus/dpaa/base/fman/netcfg_layer.c |   8 +-
 drivers/bus/dpaa/base/qbman/bman.c        |  66 +++----
 drivers/bus/dpaa/base/qbman/bman_driver.c |  78 +++++----
 drivers/bus/dpaa/base/qbman/bman_priv.h   |   5 -
 drivers/bus/dpaa/base/qbman/qman.c        | 104 +++++------
 drivers/bus/dpaa/base/qbman/qman.h        |  23 ++-
 drivers/bus/dpaa/base/qbman/qman_driver.c |  29 +++-
 drivers/bus/dpaa/dpaa_bus.c               |  94 +++++-----
 drivers/bus/dpaa/dpaa_bus_base_symbols.c  |   3 +
 drivers/bus/dpaa/include/fman.h           |  32 +++-
 drivers/bus/dpaa/include/fsl_bman.h       |  56 +++++-
 drivers/bus/dpaa/include/fsl_qman.h       |  26 ++-
 drivers/bus/dpaa/rte_dpaa_logs.h          |   2 +
 drivers/crypto/dpaa_sec/dpaa_sec.c        | 176 +++++++++++++++++--
 drivers/dma/dpaa/dpaa_qdma.c              | 120 ++++++++++---
 drivers/mempool/dpaa/dpaa_mempool.c       |  53 +++++-
 drivers/net/dpaa/dpaa_ethdev.c            | 192 ++++++++++++--------
 drivers/net/dpaa/dpaa_ethdev.h            |  26 ++-
 drivers/net/dpaa/dpaa_flow.c              | 143 ++++++++-------
 drivers/net/dpaa/dpaa_flow.h              |   7 +-
 drivers/net/dpaa/dpaa_fmc.c               |  91 +++++++---
 drivers/net/dpaa/fmlib/fm_lib.c           |   4 +-
 drivers/net/dpaa/fmlib/ncsw_ext.h         |   4 +-
 27 files changed, 1102 insertions(+), 512 deletions(-)

-- 
2.25.1

