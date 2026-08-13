Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1269FC5B572
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 14:42:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F416402D3;
	Thu, 13 Aug 2026 16:42:12 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id D016940298
 for <dev@dpdk.org>; Thu, 13 Aug 2026 16:42:10 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 64CDB200082;
 Thu, 13 Aug 2026 16:42:10 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2E57C200053;
 Thu, 13 Aug 2026 16:42:10 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id CB1A918000B5;
 Thu, 13 Aug 2026 22:42:08 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Subject: [PATCH v11 00/25] DPAA driver fixes and improvements
Date: Thu, 13 Aug 2026 20:11:40 +0530
Message-Id: <20260813144205.2505031-1-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260813104405.2313474-1-hemant.agrawal@nxp.com>
References: <20260813104405.2313474-1-hemant.agrawal@nxp.com>
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

v11: address AI review comments; skipping false positive ones.
  - net/dpaa: fix lost close error in rte_dpaa_remove()
  - net/dpaa: fix NULL dereference on rte_dpaa_bpid_info in oldev rx
    queue setup
  - net/dpaa: fix error logging in oldev tx queue setup to include
    return code and return proper -EINVAL

v10: address further AI review comments
  - dma/dpaa: expose compile-time static flags (sg_enable,
    data_validation, pci_read) as probe-time devargs with corrected
    logic and updated documentation
  - bus/dpaa: fix pool-channel FQ shutdown always returning -EINVAL
    (wrong affinity check; dedicated and pool channel ranges never
    overlap)
  - mempool/dpaa: fix double-free of bpid_info on pool release

v9: fix bissect issue and other AI review comments

This series collects a set of correctness fixes, cleanups and feature
additions across the NXP DPAA bus, net, mempool and DMA drivers.

1. Bus/fman infrastructure cleanups (patches 01, 02, 12)
   - bus/dpaa: refine fman naming and fix global scope
   - bus/dpaa: scan max BPID from DTS
   - bus/dpaa: improve log macro and fix bus detection

2. Process-type guards (patch 03)
   - drivers: add process-type guards to prevent segfaults in secondary

3. FQ shutdown hardening (patches 04-08)
   - bus/dpaa: shutdown DPAA FQ by fq descriptor
   - bus/dpaa: improve FQ shutdown with channel validation
   - bus/dpaa: add DPAA cgrid cleanup support

4. net/dpaa improvements (patches 09, 11, 13)
   - net/dpaa: optimize FM deconfig
   - net/dpaa: optimize FMC MAC type parsing

5. Statistics (patch 10)
   - drivers: add BMI Tx statistics

6. mempool/dpaa (patch 14)
   - drivers: release DPAA bpid on driver destructor

7. dma/dpaa (patches 15-16)
   - dma/dpaa: add SG data validation and ERR050757 fix
   - dma/dpaa: expose static flags as probe-time devargs

8. net/dpaa features (patches 17-22)
   - net/dpaa: support Rx/Tx taildrop threshold devarg
   - net/dpaa: add Tx rate limiting API
   - bus/dpaa: orp queue create and burst enqueue
   - net/dpaa: support fmcless rxq number as devargs
   - net/dpaa: support non fmX-macY type of shared Ethernet name
   - bus/dpaa: optimize DPAA multi-entry buffer pool operations

9. Shutdown and cleanup (patches 23-24)
   - drivers: improve shutdown fq with channel
   - drivers: improve crypto fq resource handling
   - net/dpaa: enhance VSP port support
   - drivers: add offline (O/H) port device support
   - drivers: add dpaax enter destructor to gate EAL memory frees

10. Documentation and release notes (patch 25)
    - doc: update release notes with NXP DPAA changes

Gagandeep Singh (3):
  net/dpaa: fix device remove
  dma/dpaa: add SG data validation and ERR050757
  drivers: add offline (O/H) port device support

Hemant Agrawal (6):
  net/dpaa: optimize FM deconfig
  net/dpaa: support Rx/Tx taildrop threshold devarg
  net/dpaa: add Tx rate limiting API
  net/dpaa: support non fmX-macY type of shared Ethernet name
  bus/dpaa: improve log macro and fix bus detection
  doc: update release notes with NXP DPAA changes

Jun Yang (14):
  bus/dpaa: refine fman naming and fix global scope
  bus/dpaa: scan max BPID from DTS
  drivers: shutdown DPAA FQ by fq descriptor
  bus/dpaa: improve FQ shutdown with channel validation
  bus/dpaa: add DPAA cgrid cleanup support
  drivers: add BMI Tx statistics
  net/dpaa: optimize FMC MAC type parsing
  drivers: release DPAA bpid on driver destructor
  bus/dpaa: orp queue create and burst enqueue
  net/dpaa: support fmcless rxq number as devargs
  bus/dpaa: optimize DPAA multi-entry buffer pool operations
  drivers: improve shutdown fq with channel
  drivers: improve  crypto fq resource handling
  drivers: add dpaax enter destructor to gate EAL memory frees

Prashant Gupta (1):
  drivers: add process-type guards for secondary process

Vanshika Shukla (1):
  net/dpaa: enhance VSP port support

 doc/guides/dmadevs/dpaa.rst               |  29 +-
 doc/guides/nics/dpaa.rst                  |  39 +-
 doc/guides/rel_notes/release_26_11.rst    |  29 +
 drivers/bus/dpaa/base/fman/fman.c         |  23 +-
 drivers/bus/dpaa/base/fman/fman_hw.c      | 111 ++--
 drivers/bus/dpaa/base/qbman/bman.c        |  59 +-
 drivers/bus/dpaa/base/qbman/bman_driver.c |  51 +-
 drivers/bus/dpaa/base/qbman/qman.c        | 207 +++++--
 drivers/bus/dpaa/base/qbman/qman.h        |  23 +-
 drivers/bus/dpaa/base/qbman/qman_driver.c |  29 +-
 drivers/bus/dpaa/bus_dpaa_driver.h        |  11 +-
 drivers/bus/dpaa/dpaa_bus.c               | 164 +++--
 drivers/bus/dpaa/dpaa_bus_base_symbols.c  |   4 +
 drivers/bus/dpaa/include/fman.h           |  20 +-
 drivers/bus/dpaa/include/fsl_bman.h       |  49 +-
 drivers/bus/dpaa/include/fsl_qman.h       |  54 +-
 drivers/common/dpaax/compat.h             |  22 +-
 drivers/common/dpaax/dpaax_iova_table.c   |  25 +-
 drivers/crypto/dpaa_sec/dpaa_sec.c        | 109 +++-
 drivers/dma/dpaa/dpaa_qdma.c              | 110 +++-
 drivers/mempool/dpaa/dpaa_mempool.c       |  64 +-
 drivers/mempool/dpaa/dpaa_mempool.h       |   3 +-
 drivers/net/dpaa/dpaa_ethdev.c            | 310 ++++++++--
 drivers/net/dpaa/dpaa_ethdev.h            |  25 +-
 drivers/net/dpaa/dpaa_flow.c              | 221 +++++--
 drivers/net/dpaa/dpaa_flow.h              |   7 +-
 drivers/net/dpaa/dpaa_fmc.c               |  73 ++-
 drivers/net/dpaa/dpaa_oldev.c             | 705 ++++++++++++++++++++++
 drivers/net/dpaa/fmlib/fm_lib.c           |  32 +-
 drivers/net/dpaa/fmlib/fm_port_ext.h      |   4 +-
 drivers/net/dpaa/meson.build              |  11 +-
 drivers/net/dpaa/rte_pmd_dpaa.h           |  23 +-
 drivers/net/dpaa/rte_pmd_dpaa_oldev.h     |  93 +++
 33 files changed, 2282 insertions(+), 457 deletions(-)
 create mode 100644 drivers/net/dpaa/dpaa_oldev.c
 create mode 100644 drivers/net/dpaa/rte_pmd_dpaa_oldev.h

-- 
2.25.1

