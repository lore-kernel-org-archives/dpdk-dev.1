Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243EBC9832A
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 14:21:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E616427CF;
	Tue, 29 Sep 2026 16:21:23 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 631B140E0A
 for <dev@dpdk.org>; Tue, 29 Sep 2026 16:21:22 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 255242000F9;
 Tue, 29 Sep 2026 16:21:22 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E31D62000F3;
 Tue, 29 Sep 2026 16:21:21 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id ADC6918000BA;
 Tue, 29 Sep 2026 22:21:20 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Subject: [PATCH v5-S1 0/5] dpaa2: bus, DMA and mempool base fixes
Date: Tue, 29 Sep 2026 19:51:12 +0530
Message-ID: <20260929142117.3109066-1-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922092158.2340839-1-prashant.gupta_3@nxp.com>
References: <20260922092158.2340839-1-prashant.gupta_3@nxp.com>
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

- defer fslmc bus initialization to probe; reduce probe-time logging
  and skip ignored devices during DPRC population,
- fix a GCC -Warray-bounds warning and an SG FD double-put in the
  dpaa2 QDMA dequeue path,
- validate the FLE pool IOVA mapping at vchan setup and free the pool
  on failure,
- resolve the mempool ops index locally in secondary processes by
  scanning rte_mempool_ops_table, removing the need for IPC.

Every commit builds cleanly (including the aarch64 DPAA cross build with
-Werror) and the series is bisectable.

Gagandeep Singh (1):
  dma/dpaa2: validate FLE pool IOVA mapping at vchan setup

Hemant Agrawal (1):
  bus/fslmc: reduce probe-time logging and skip ignored devices

Jun Yang (2):
  mempool/dpaa2: look up ops index locally in secondary
  dma/dpaa2: fix array-bounds warning and SG FD double-put

Prashant Gupta (1):
  bus/fslmc: defer bus initialization to probe

 drivers/bus/fslmc/fslmc_bus.c            | 92 ++++++++++++++++++--------------
 drivers/bus/fslmc/fslmc_vfio.c           |  3 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dprc.c |  4 ++
 drivers/dma/dpaa2/dpaa2_qdma.c           | 46 ++++++++++++----
 drivers/mempool/dpaa2/dpaa2_hw_mempool.c | 25 +++++++--
 5 files changed, 113 insertions(+), 57 deletions(-)

-- 
2.43.0
