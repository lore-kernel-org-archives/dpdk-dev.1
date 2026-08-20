Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515CBC5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 14:43:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 857E74060B;
	Thu, 20 Aug 2026 16:43:17 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id CC43A40150
 for <dev@dpdk.org>; Thu, 20 Aug 2026 16:43:16 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 96D091A019C;
 Thu, 20 Aug 2026 16:43:16 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 61E261A01A7;
 Thu, 20 Aug 2026 16:43:16 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 5B5191800224;
 Thu, 20 Aug 2026 22:43:15 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Subject: [PATCH v14 00/23] NXP DPAA driver enhancements and fixes
Date: Thu, 20 Aug 2026 20:12:49 +0530
Message-Id: <20260820144312.3922316-1-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260819105004.2272880-1-hemant.agrawal@nxp.com>
References: <20260819105004.2272880-1-hemant.agrawal@nxp.com>
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

v14:
* Dropped the ORP queue create and destructor patch.

v13:
* Addressed mailing-list review feedback on the previous revision.
* Dropped the Tx port rate limiting patch.


Gagandeep Singh (3):
  net/dpaa: fix device remove
  dma/dpaa: add devargs for SG and errata workaround
  drivers: add offline (O/H) port device support

Hemant Agrawal (6):
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
 doc/guides/nics/dpaa.rst                  |  33 +-
 doc/guides/rel_notes/release_26_11.rst    |  34 +
 drivers/bus/dpaa/base/fman/fman.c         |  42 +-
 drivers/bus/dpaa/base/fman/fman_hw.c      | 200 +++---
 drivers/bus/dpaa/base/fman/netcfg_layer.c |   8 +-
 drivers/bus/dpaa/base/qbman/bman.c        |  59 +-
 drivers/bus/dpaa/base/qbman/bman_driver.c |  51 +-
 drivers/bus/dpaa/base/qbman/qman.c        | 152 +++--
 drivers/bus/dpaa/base/qbman/qman.h        |  23 +-
 drivers/bus/dpaa/base/qbman/qman_driver.c |  29 +-
 drivers/bus/dpaa/bus_dpaa_driver.h        |  11 +-
 drivers/bus/dpaa/dpaa_bus.c               | 171 +++--
 drivers/bus/dpaa/dpaa_bus_base_symbols.c  |   4 +
 drivers/bus/dpaa/include/fman.h           |  25 +-
 drivers/bus/dpaa/include/fsl_bman.h       |  49 +-
 drivers/bus/dpaa/include/fsl_qman.h       |  37 +-
 drivers/bus/dpaa/rte_dpaa_logs.h          |   2 +
 drivers/crypto/dpaa_sec/dpaa_sec.c        | 109 ++-
 drivers/dma/dpaa/dpaa_qdma.c              | 110 ++-
 drivers/mempool/dpaa/dpaa_mempool.c       |  58 +-
 drivers/mempool/dpaa/dpaa_mempool.h       |   3 +-
 drivers/net/dpaa/dpaa_ethdev.c            | 358 ++++++++--
 drivers/net/dpaa/dpaa_ethdev.h            |  25 +-
 drivers/net/dpaa/dpaa_flow.c              | 134 ++--
 drivers/net/dpaa/dpaa_flow.h              |   7 +-
 drivers/net/dpaa/dpaa_fmc.c               |  84 ++-
 drivers/net/dpaa/dpaa_oldev.c             | 773 ++++++++++++++++++++++
 drivers/net/dpaa/meson.build              |  11 +-
 drivers/net/dpaa/rte_pmd_dpaa_oldev.h     | 149 +++++
 30 files changed, 2310 insertions(+), 471 deletions(-)
 create mode 100644 drivers/net/dpaa/dpaa_oldev.c
 create mode 100644 drivers/net/dpaa/rte_pmd_dpaa_oldev.h

-- 
2.25.1

