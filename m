Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B06CC5AD49
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 11:55:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA67240B9D;
	Wed, 28 May 2025 13:55:17 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 47BF94028D
 for <dev@dpdk.org>; Wed, 28 May 2025 13:55:16 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2370D203C26
 for <dev@dpdk.org>; Wed, 28 May 2025 13:55:16 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DDFC1203BE1
 for <dev@dpdk.org>; Wed, 28 May 2025 13:55:15 +0200 (CEST)
Received: from lsv03379.swis.in-blr01.nxp.com (lsv03379.swis.in-blr01.nxp.com
 [92.120.147.188])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 240081800078
 for <dev@dpdk.org>; Wed, 28 May 2025 19:55:15 +0800 (+08)
From: vanshika.shukla@nxp.com
To: dev@dpdk.org
Subject: [v1 00/10] DPAA specific fixes
Date: Wed, 28 May 2025 17:25:03 +0530
Message-Id: <20250528115513.1023689-1-vanshika.shukla@nxp.com>
X-Mailer: git-send-email 2.25.1
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

Gagandeep Singh (1):
  bus/dpaa: improve DPAA cleanup

Hemant Agrawal (2):
  bus/dpaa: avoid using same structure and variable name
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
 doc/guides/nics/dpaa.rst                  |   3 +
 drivers/bus/dpaa/base/fman/fman.c         | 278 ++++++++++++---------
 drivers/bus/dpaa/base/fman/netcfg_layer.c |   8 +-
 drivers/bus/dpaa/base/qbman/bman.c        | 149 +++++++++--
 drivers/bus/dpaa/base/qbman/qman.c        |  50 ++--
 drivers/bus/dpaa/base/qbman/qman_driver.c |   2 -
 drivers/bus/dpaa/bus_dpaa_driver.h        |   9 +-
 drivers/bus/dpaa/dpaa_bus.c               | 179 +++++++++----
 drivers/bus/dpaa/include/fman.h           |  40 +--
 drivers/bus/dpaa/include/fsl_bman.h       |  20 +-
 drivers/bus/dpaa/include/fsl_qman.h       |   2 +-
 drivers/bus/dpaa/include/netcfg.h         |  14 --
 drivers/mempool/dpaa/dpaa_mempool.c       | 230 +++++++++++++----
 drivers/mempool/dpaa/dpaa_mempool.h       |  13 +-
 drivers/net/dpaa/dpaa_ethdev.c            | 291 +++++++++++++++-------
 drivers/net/dpaa/dpaa_flow.c              |  87 ++++++-
 drivers/net/dpaa/dpaa_ptp.c               |  12 +-
 drivers/net/dpaa/dpaa_rxtx.c              |   4 +-
 drivers/net/dpaa/fmlib/fm_lib.c           |  30 +++
 drivers/net/dpaa/fmlib/fm_port_ext.h      |   2 +-
 drivers/net/dpaa/rte_pmd_dpaa.h           |  21 +-
 22 files changed, 1022 insertions(+), 423 deletions(-)

-- 
2.25.1

