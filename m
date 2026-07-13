Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95719C44501
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Jul 2026 09:26:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A86F6409FA;
	Mon, 13 Jul 2026 11:26:22 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 2DEA44028A
 for <dev@dpdk.org>; Mon, 13 Jul 2026 11:26:21 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C7DBA200012;
 Mon, 13 Jul 2026 11:26:20 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 922CF20000C;
 Mon, 13 Jul 2026 11:26:20 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 3972918000B0;
 Mon, 13 Jul 2026 17:26:19 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Subject: [PATCH v4 00/18] net/dpaa: bug fixes for bus, net and fmlib drivers
Date: Mon, 13 Jul 2026 14:55:58 +0530
Message-Id: <20260713092616.2902828-1-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260619103901.2274740-1-hemant.agrawal@nxp.com>
References: <20260619103901.2274740-1-hemant.agrawal@nxp.com>
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

This series contains bug fixes for the DPAA PMD (bus/dpaa, net/dpaa,
net/dpaa/fmlib and dma/dpaa).

v4: rebased over master;

v3 changes (AI code review feedback):
- P05: Clarify commit message: p_dev == NULL is equivalent to h_scheme == NULL
  since p_dev = (t_device *)h_scheme; consistent with all sibling functions
- P16: Add comment explaining the intentional loop continuation; clarify
  commit message about the loop design
- P17: Add DPAA_DP_LOG(WARNING) before silent return on l3_len == 0 to
  aid debugging of corrupt/uninitialized mbufs

v2 changes:
- P05: Fix commit message API name
- P08: Guard DPAA_PUSH_QUEUES_NUMBER env-var for LS1043A (errata)
- P09: Document dpaa_finish() removal
- P10: Fix wrong Fixes: tag
- P11: Split into two patches with correct Fixes: tags
- P13: Also fix rx_buf_diallocate -> rx_buf_deallocate

All patches are bug fixes tagged with Fixes: and Cc: stable@dpdk.org.



Gagandeep Singh (3):
  bus/dpaa: fix device probe issue
  net/dpaa: fix invalid check on interrupt unregister
  net/dpaa: fix device remove

Hemant Agrawal (11):
  bus/dpaa: fix error handling of qman_create_fq
  bus/dpaa: fix fqid endianness
  bus/dpaa: fix error handling in qman_query
  net/dpaa: fix modify cgr to use index
  bus/dpaa: fix fd leak for ccsr mmap
  net/dpaa: fix xstat name for tx undersized counter
  net/dpaa: fix xstat string typos in BMI stats table
  net/dpaa: remove duplicate ptype entries
  net/dpaa: fix wrong buffer in xstats get by id
  net/dpaa: fix null l3_len check in checksum offload
  net/dpaa: fix mbuf leak in SG fd creation

Jun Yang (1):
  bus/dpaa: fix BMI RX stats register offset

Prashant Gupta (1):
  net/dpaa/fmlib: add null check in scheme delete

Vanshika Shukla (2):
  net/dpaa: fix port_handle leak in fm_prev_cleanup
  dma/dpaa: fix out-of-bounds access in SG descriptor enqueue

 drivers/bus/dpaa/base/qbman/bman_driver.c |  3 ++-
 drivers/bus/dpaa/base/qbman/qman.c        | 11 +++++---
 drivers/bus/dpaa/base/qbman/qman_driver.c |  6 ++---
 drivers/bus/dpaa/dpaa_bus.c               | 17 ++++++-------
 drivers/bus/dpaa/include/fman.h           |  6 ++---
 drivers/dma/dpaa/dpaa_qdma.c              |  7 ++++-
 drivers/net/dpaa/dpaa_ethdev.c            | 31 ++++++++++++-----------
 drivers/net/dpaa/dpaa_flow.c              |  4 +++
 drivers/net/dpaa/dpaa_rxtx.c              |  5 ++++
 drivers/net/dpaa/fmlib/fm_lib.c           |  3 +++
 10 files changed, 57 insertions(+), 36 deletions(-)

-- 
2.25.1

