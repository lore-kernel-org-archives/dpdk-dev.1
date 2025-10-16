Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C749BCCD183
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 10:28:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7EA2D41101;
	Thu, 16 Oct 2025 12:28:10 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id ECE7A40269
 for <dev@dpdk.org>; Thu, 16 Oct 2025 12:28:08 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BB1971A2718;
 Thu, 16 Oct 2025 12:28:08 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 85FFB1A26F1;
 Thu, 16 Oct 2025 12:28:08 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id BEB29180007B;
 Thu, 16 Oct 2025 18:28:07 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: dev@dpdk.org,
	stephen@networkplumber.org
Subject: [PATCH v2 00/15] dpaa2: Fixes and enhancements for DPMAC, stats,
 and parser
Date: Thu, 16 Oct 2025 15:57:50 +0530
Message-ID: <20251016102805.2453687-1-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014064035.1312896-1-prashant.gupta_3@nxp.com>
References: <20251014064035.1312896-1-prashant.gupta_3@nxp.com>
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

v2: fix checkpatch errors and comment from Hemant

This patch series introduces a set of improvements and bug fixes for the DPAA2 Ethernet driver. Key highlights include:

- Fixes for checksum parsing and error queue buffer handling
- Enhancements to flow rule resizing and parser result prefetching
- Addition of DPMAC MC header support and Policer statistics per traffic class
- Support for eCPRI header/message dump and DPMAC counters
- Upgrade of fslmc base firmware to version 10.39.0
- Introduction of devargs to drop parse-failed packets in hardware

These changes improve robustness, observability, and performance of the DPAA2 driver stack.


Brick Yang (2):
  net/dpaa2: fix L3/L4 csum results in packet parse
  net/dpaa2: fix to recv packets with additional parse errors

Hemant Agrawal (3):
  drivers: dpaa2 upgrade fslmc base FW to 10.39.0
  net/dpaa2: replace global variable to driver flag
  net/dpaa2: add devargs to drop parse packets in HW

Ioana Ciornei (1):
  net/dpaa2: setup the speed cap based on the actual MAC

Jun Yang (4):
  net/dpaa2: fix error frame dump issue
  net/dpaa2: fix flow rule's resizing issue
  net/dpaa2: optimize to prefetch next parser result
  net/dpaa2: add eCPRI header and message dump

Prashant Gupta (4):
  net/dpaa2: fix uninitialized variable issue
  net/dpaa2: fix to free buffers from error queue
  net/dpaa2: add dpmac MC header file
  net/dpaa2: add Policer stats for each TC

Vanshika Shukla (1):
  net/dpaa2: support dpmac counters in stats

 .mailmap                                     |   1 +
 doc/guides/nics/dpaa2.rst                    |   4 +
 doc/guides/rel_notes/release_25_11.rst       |   3 +
 drivers/bus/fslmc/bus_fslmc_driver.h         |   1 +
 drivers/bus/fslmc/mc/dpbp.c                  |  78 ++-
 drivers/bus/fslmc/mc/dprc.c                  |   2 +
 drivers/bus/fslmc/mc/fsl_dpbp.h              |  41 +-
 drivers/bus/fslmc/mc/fsl_dpmng.h             |   4 +-
 drivers/bus/fslmc/mc/fsl_dprc.h              |   1 +
 drivers/net/dpaa2/base/dpaa2_hw_dpni.c       |   3 +-
 drivers/net/dpaa2/base/dpaa2_hw_dpni_annot.h |  10 +-
 drivers/net/dpaa2/dpaa2_ethdev.c             | 350 +++++++++++-
 drivers/net/dpaa2/dpaa2_ethdev.h             |  65 ++-
 drivers/net/dpaa2/dpaa2_flow.c               | 123 ++++-
 drivers/net/dpaa2/dpaa2_mux.c                |   8 +-
 drivers/net/dpaa2/dpaa2_parse_dump.h         | 124 +++++
 drivers/net/dpaa2/dpaa2_rxtx.c               | 123 +++--
 drivers/net/dpaa2/mc/dpkg.c                  |   7 +-
 drivers/net/dpaa2/mc/dpni.c                  |  50 +-
 drivers/net/dpaa2/mc/dprtc.c                 |  38 +-
 drivers/net/dpaa2/mc/fsl_dpdmux.h            |  13 +-
 drivers/net/dpaa2/mc/fsl_dpkg.h              |   7 +-
 drivers/net/dpaa2/mc/fsl_dpmac.h             | 526 +++++++++++++++++++
 drivers/net/dpaa2/mc/fsl_dpni.h              |  37 +-
 drivers/net/dpaa2/mc/fsl_dpni_cmd.h          |  15 +-
 drivers/net/dpaa2/mc/fsl_dprtc.h             |  39 +-
 drivers/net/dpaa2/mc/fsl_dprtc_cmd.h         |   7 +-
 27 files changed, 1520 insertions(+), 160 deletions(-)
 create mode 100644 drivers/net/dpaa2/mc/fsl_dpmac.h

-- 
2.43.0

