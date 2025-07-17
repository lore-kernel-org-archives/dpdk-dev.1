Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D22C83F1A
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Jul 2025 09:42:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FA09402AE;
	Thu, 17 Jul 2025 11:42:42 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 178E8400EF
 for <dev@dpdk.org>; Thu, 17 Jul 2025 11:42:41 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D6DAC1A0FD1
 for <dev@dpdk.org>; Thu, 17 Jul 2025 11:42:40 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9CC6A1A06FC
 for <dev@dpdk.org>; Thu, 17 Jul 2025 11:42:40 +0200 (CEST)
Received: from lsv03379.swis.in-blr01.nxp.com (lsv03379.swis.in-blr01.nxp.com
 [92.120.147.188])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id CB725180008F
 for <dev@dpdk.org>; Thu, 17 Jul 2025 17:42:39 +0800 (+08)
From: vanshika.shukla@nxp.com
To: dev@dpdk.org
Subject: [v9 0/8] DPAA specific fixes
Date: Thu, 17 Jul 2025 15:12:30 +0530
Message-Id: <20250717094238.899294-1-vanshika.shukla@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250703053743.3710482-1-vanshika.shukla@nxp.com>
References: <20250703053743.3710482-1-vanshika.shukla@nxp.com>
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

V8:
This is a resend of the previous patch series with the correct series name.
No changes to the patches themselves.

V7:
Fixed compilation issues on some platforms.

V6:
Removed the "add Tx rate limiting DPAA PMD API" patch.
Handled comments by the reviewer.

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

 doc/guides/nics/dpaa.rst                  |   4 +
 drivers/bus/dpaa/base/fman/fman.c         | 279 ++++++++++++---------
 drivers/bus/dpaa/base/fman/netcfg_layer.c |   8 +-
 drivers/bus/dpaa/base/qbman/bman.c        | 147 +++++++++--
 drivers/bus/dpaa/base/qbman/qman.c        |  50 ++--
 drivers/bus/dpaa/base/qbman/qman_driver.c |   2 -
 drivers/bus/dpaa/bus_dpaa_driver.h        |   9 +-
 drivers/bus/dpaa/dpaa_bus.c               | 129 ++++++++--
 drivers/bus/dpaa/include/fman.h           |  40 +--
 drivers/bus/dpaa/include/fsl_bman.h       |  20 +-
 drivers/bus/dpaa/include/fsl_qman.h       |   2 +-
 drivers/bus/dpaa/include/netcfg.h         |  14 --
 drivers/mempool/dpaa/dpaa_mempool.c       | 229 +++++++++++++----
 drivers/mempool/dpaa/dpaa_mempool.h       |  13 +-
 drivers/net/dpaa/dpaa_ethdev.c            | 291 +++++++++++++++-------
 drivers/net/dpaa/dpaa_ptp.c               |  12 +-
 drivers/net/dpaa/dpaa_rxtx.c              |   4 +-
 17 files changed, 859 insertions(+), 394 deletions(-)

-- 
2.25.1

