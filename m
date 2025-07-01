Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FE3C7EE30
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 11:37:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC1D7402E3;
	Tue,  1 Jul 2025 13:37:10 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 2B79040269
 for <dev@dpdk.org>; Tue,  1 Jul 2025 13:37:09 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BB04F20225C
 for <dev@dpdk.org>; Tue,  1 Jul 2025 13:37:08 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 823BD203286
 for <dev@dpdk.org>; Tue,  1 Jul 2025 13:37:08 +0200 (CEST)
Received: from lsv03379.swis.in-blr01.nxp.com (lsv03379.swis.in-blr01.nxp.com
 [92.120.147.188])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 16BE81800079
 for <dev@dpdk.org>; Tue,  1 Jul 2025 19:37:08 +0800 (+08)
From: vanshika.shukla@nxp.com
To: dev@dpdk.org
Subject: [v5 0/9] DPAA specific fixes
Date: Tue,  1 Jul 2025 17:06:58 +0530
Message-Id: <20250701113707.2793004-1-vanshika.shukla@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250611071039.2939950-1-vanshika.shukla@nxp.com>
References: <20250611071039.2939950-1-vanshika.shukla@nxp.com>
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

From: Vanshika Shukla <vanshika.shukla@nxp.com>

This series includes fixes for NXP DPAA drivers.

V5:
Fixed comments by the reviewer.

V4:
Fixed compilation errors in the "bus/dpaa: optimize qman enqueue check" patch
on Ubuntu 22.04.
- Ensured buffer bounds are respected and added validation for buffer count
extracted from mcr->verb.

V3:
Fixed compilation errors for "bus/dpaa: optimize qman enqueue check" patch.

V2:
Handled review comments and checkpatch warnings

Gagandeep Singh (1):
  bus/dpaa: improve DPAA cleanup

Hemant Agrawal (1):
  bus/dpaa: optimize qman enqueue check

Jun Yang (5):
  bus/dpaa: add FMan node
  bus/dpaa: enhance DPAA SoC version
  bus/dpaa: optimize bman acquire/release
  mempool/dpaa: fast acquire and release
  mempool/dpaa: adjust pool element for LS1043A errata

Vanshika Shukla (1):
  net/dpaa: add devargs for enabling err packets on main queue

Vinod Pullabhatla (1):
  net/dpaa: add Tx rate limiting DPAA PMD API

 .mailmap                                  |   1 +
 doc/guides/nics/dpaa.rst                  |   4 +
 drivers/bus/dpaa/base/fman/fman.c         | 279 ++++++++++++---------
 drivers/bus/dpaa/base/fman/netcfg_layer.c |   8 +-
 drivers/bus/dpaa/base/qbman/bman.c        | 147 +++++++++--
 drivers/bus/dpaa/base/qbman/qman.c        |  50 ++--
 drivers/bus/dpaa/base/qbman/qman_driver.c |   2 -
 drivers/bus/dpaa/bus_dpaa_driver.h        |   9 +-
 drivers/bus/dpaa/dpaa_bus.c               | 123 +++++++--
 drivers/bus/dpaa/include/fman.h           |  40 +--
 drivers/bus/dpaa/include/fsl_bman.h       |  20 +-
 drivers/bus/dpaa/include/fsl_qman.h       |   2 +-
 drivers/bus/dpaa/include/netcfg.h         |  14 --
 drivers/mempool/dpaa/dpaa_mempool.c       | 229 +++++++++++++----
 drivers/mempool/dpaa/dpaa_mempool.h       |  13 +-
 drivers/net/dpaa/dpaa_ethdev.c            | 291 +++++++++++++++-------
 drivers/net/dpaa/dpaa_flow.c              |  89 ++++++-
 drivers/net/dpaa/dpaa_ptp.c               |  12 +-
 drivers/net/dpaa/dpaa_rxtx.c              |   4 +-
 drivers/net/dpaa/fmlib/fm_lib.c           |  30 +++
 drivers/net/dpaa/fmlib/fm_port_ext.h      |   2 +-
 drivers/net/dpaa/rte_pmd_dpaa.h           |  21 +-
 22 files changed, 995 insertions(+), 395 deletions(-)

-- 
2.25.1

