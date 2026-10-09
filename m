Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A39CA6012
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 10:50:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D5B640280;
	Fri,  9 Oct 2026 12:50:22 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 6D8134025F
 for <dev@dpdk.org>; Fri,  9 Oct 2026 12:50:21 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4916A20030F;
 Fri,  9 Oct 2026 12:50:21 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1597220031E;
 Fri,  9 Oct 2026 12:50:21 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D94F9180006C;
 Fri,  9 Oct 2026 18:50:19 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Subject: [PATCH v7-S1 0/6] dpaa2: bus, DMA and mempool base fixes
Date: Fri,  9 Oct 2026 16:20:13 +0530
Message-ID: <20261009105019.1121083-1-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261006150749.3591526-1-prashant.gupta_3@nxp.com>
References: <20261006150749.3591526-1-prashant.gupta_3@nxp.com>
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

This series is the first of four that upstream the missing NXP dpaa2
driver changes. It collects the foundational bus/fslmc, dma/dpaa2 and
mempool/dpaa2 fixes that the later series build on:

- defer fslmc bus initialization to probe; reduce probe logging
  and skip ignored devices during DPRC population,
- use memcpy to fill the dpaa2 QDMA completion index ring,
- release FLE objects immediately on completion ring overflow and
  only account them after successful context-ring insertion,
- validate FLE pool memory chunks at vchan setup by verifying
  consistent VA-to-IOVA offsets across the mempool and free the
  pool on setup failure,
- resolve the mempool ops index locally in secondary processes by
  scanning rte_mempool_ops_table, removing the need for IPC.

Every commit builds cleanly (including the aarch64 DPAA cross build with
-Werror) and the series remains bisectable.

Gagandeep Singh (1):
  dma/dpaa2: validate FLE pool IOVA mapping at vchan setup

Hemant Agrawal (1):
  bus/fslmc: reduce probe logging and skip ignored devices

Jun Yang (3):
  dma/dpaa2: use memcpy to fill completion index ring
  dma/dpaa2: release SG FLE on completion ring overflow
  mempool/dpaa2: look up ops index locally in secondary

Prashant Gupta (1):
  bus/fslmc: defer bus initialization to probe

 drivers/bus/fslmc/fslmc_bus.c            | 92 +++++++++++++-----------
 drivers/bus/fslmc/fslmc_vfio.c           |  3 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dprc.c |  4 ++
 drivers/dma/dpaa2/dpaa2_qdma.c           | 86 +++++++++++++++++-----
 drivers/mempool/dpaa2/dpaa2_hw_mempool.c | 24 ++++++-
 5 files changed, 144 insertions(+), 65 deletions(-)

-- 
2.43.0

