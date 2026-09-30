Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E59CCA5FAB
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 06:24:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ABAC240DD6;
	Wed, 30 Sep 2026 08:24:42 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 6069340612
 for <dev@dpdk.org>; Wed, 30 Sep 2026 08:24:41 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0D30B200196;
 Wed, 30 Sep 2026 08:24:41 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C8C09200181;
 Wed, 30 Sep 2026 08:24:40 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 021191800068;
 Wed, 30 Sep 2026 14:24:39 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Subject: [PATCH v18 00/24] NXP DPAA driver enhancements and fixes
Date: Wed, 30 Sep 2026 11:54:13 +0530
Message-Id: <20260930062437.3019096-1-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260929104519.1770698-1-hemant.agrawal@nxp.com>
References: <20260929104519.1770698-1-hemant.agrawal@nxp.com>
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

v18:
* Dropped the "net/dpaa: fix device remove" patch. It papered over the
  symptom in rte_dpaa_remove() instead of fixing the cause, and was
  replaced by the two fixes now at the head of the series.
* net/dpaa: fix the double dpaa_eth_dev_close() call and the eth_dev
  dereference before the NULL check in rte_dpaa_remove().
* net/dpaa: unwind rte_dpaa_probe() through cleanup labels so the Tx SG
  mempool failure path closes the device and releases the port instead of
  leaking the port, the queue arrays and the QMan FQID/CGRID ranges.

v17:
* bus/dpaa: clamp the BPID range read from the DTS to the 64 pools the
  depletion mask and SCN registers can describe, reject an empty range,
  and drop a dead bman_ip_rev check.
* drivers: delete the congestion group in dpaa_rx_queue_init() and
  dpaa_tx_queue_init() when the following qman_init_fq() fails, which
  the caller's error path could not do.
* drivers: scan for a frame queue still attached to a congestion group
  unconditionally; an idle member reports a zero CGR byte count, so the
  old shortcut could release a CGRID that was still referenced.
* bus/dpaa: reject a frame queue on another portal's dedicated channel
  and bound the FQ retirement wait, which previously could spin forever.
* net/dpaa: bound the VSP ID against DPAA_VSP_PROFILE_MAX_NUM before
  first use, and expand the VSP commit message to cover all its changes.
* net/dpaa: parse the FMC port name only where the result is used, and
  demote the per-port probe logs from ERR/INFO to DEBUG.
* dma/dpaa: move the #ifdef out of the RTE_PMD_REGISTER_PARAM_STRING()
  argument list, which is undefined behaviour.
* drivers: return -errno rather than a raw -1 from the offline port
  control-device ioctls, issue the FQ-info ioctl from dev_start() rather
  than tx_queue_setup() since ethdev does not order queue setup, reject
  offline port probe in a secondary process, make the ops table const,
  and add the extern "C" guard to the installed header.
* drivers: do not rte_free() the DPAA BPID info array from the RTE_FINI
  destructor; rte_eal_cleanup() has already detached EAL memory, and in
  a secondary the array belongs to the primary.
* bus/dpaa: make drv_oldev usable; the bus devargs were matched against
  the wrong bus name and the offline port devargs were never parsed.
* doc: fold the five NXP DPAA release note entries into one
  "Updated NXP DPAA drivers" entry with sub-bullets.

v16:
* rebased on main

v15:
* Rebased on latest next-net
* Addressed AI review comments

v14:
* Dropped the ORP queue create and destructor patch.

v13:
* Addressed mailing-list review feedback on the previous revision.
* Dropped the Tx port rate limiting patch.

Gagandeep Singh (2):
  dma/dpaa: add devargs for SG and errata workaround
  drivers: add offline (O/H) port device support

Hemant Agrawal (8):
  net/dpaa: fix double close and null deref on remove
  net/dpaa: fix resource leak on probe failure
  net/dpaa: fix free port resources on close
  net/dpaa: optimize FM deconfig
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

 doc/guides/dmadevs/dpaa.rst               |  30 +-
 doc/guides/nics/dpaa.rst                  |  35 +-
 doc/guides/rel_notes/release_26_11.rst    |  21 +
 drivers/bus/dpaa/base/fman/fman.c         |  42 +-
 drivers/bus/dpaa/base/fman/fman_hw.c      | 202 ++++--
 drivers/bus/dpaa/base/fman/netcfg_layer.c |   8 +-
 drivers/bus/dpaa/base/qbman/bman.c        |  60 +-
 drivers/bus/dpaa/base/qbman/bman_driver.c |  65 +-
 drivers/bus/dpaa/base/qbman/qman.c        | 168 +++--
 drivers/bus/dpaa/base/qbman/qman.h        |  23 +-
 drivers/bus/dpaa/base/qbman/qman_driver.c |  29 +-
 drivers/bus/dpaa/bus_dpaa_driver.h        |  11 +-
 drivers/bus/dpaa/dpaa_bus.c               | 189 +++--
 drivers/bus/dpaa/dpaa_bus_base_symbols.c  |   4 +
 drivers/bus/dpaa/include/fman.h           |  36 +-
 drivers/bus/dpaa/include/fsl_bman.h       |  59 +-
 drivers/bus/dpaa/include/fsl_qman.h       |  42 +-
 drivers/bus/dpaa/rte_dpaa_logs.h          |   2 +
 drivers/crypto/dpaa_sec/dpaa_sec.c        | 117 ++-
 drivers/dma/dpaa/dpaa_qdma.c              | 120 ++-
 drivers/mempool/dpaa/dpaa_mempool.c       |  68 +-
 drivers/mempool/dpaa/dpaa_mempool.h       |   2 +-
 drivers/net/dpaa/dpaa_ethdev.c            | 441 +++++++++--
 drivers/net/dpaa/dpaa_ethdev.h            |  23 +-
 drivers/net/dpaa/dpaa_flow.c              | 134 ++--
 drivers/net/dpaa/dpaa_flow.h              |   7 +-
 drivers/net/dpaa/dpaa_fmc.c               |  91 ++-
 drivers/net/dpaa/dpaa_oldev.c             | 845 ++++++++++++++++++++++
 drivers/net/dpaa/meson.build              |  11 +-
 drivers/net/dpaa/rte_pmd_dpaa_oldev.h     | 158 ++++
 30 files changed, 2543 insertions(+), 500 deletions(-)
 create mode 100644 drivers/net/dpaa/dpaa_oldev.c
 create mode 100644 drivers/net/dpaa/rte_pmd_dpaa_oldev.h

-- 
2.25.1

