Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0146C982C3
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 11:34:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D07B640A7A;
	Tue, 15 Sep 2026 13:34:28 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 6B83D4067C
 for <dev@dpdk.org>; Tue, 15 Sep 2026 13:34:27 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 266D21A0052;
 Tue, 15 Sep 2026 13:34:27 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E2BF21A002A;
 Tue, 15 Sep 2026 13:34:26 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 9F0211800068;
 Tue, 15 Sep 2026 19:34:25 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Subject: [PATCH v3-S1 0/5] dpaa2: bus, DMA and mempool base fixes
Date: Tue, 15 Sep 2026 17:04:17 +0530
Message-ID: <20260915113422.4166287-1-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
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

- defer fslmc bus initialization to probe and reduce probe-time logging
  and MC traffic,
- fix an array-bounds warning and validate IOVA in the dpaa2 QDMA
  pre-populate helpers,
- support fetching the mempool ops index from the primary process in a
  secondary process.

Every commit builds cleanly (including the aarch64 DPAA cross build with
-Werror) and the series is bisectable.

Gagandeep Singh (1):
  dma/dpaa2: validate IOVA in pre-populate helpers

Hemant Agrawal (1):
  bus/fslmc: reduce probe-time logging and MC traffic

Jun Yang (2):
  dma/dpaa2: fix array-bounds warning in dequeue path
  mempool/dpaa2: support ops index from primary in secondary

Prashant Gupta (1):
  bus/fslmc: defer bus initialization to probe

 drivers/bus/fslmc/fslmc_bus.c            | 92 +++++++++++++----------
 drivers/bus/fslmc/fslmc_vfio.c           |  3 +-
 drivers/dma/dpaa2/dpaa2_qdma.c           | 96 ++++++++++++++++--------
 drivers/mempool/dpaa2/dpaa2_hw_mempool.c | 95 ++++++++++++++++++++++-
 4 files changed, 209 insertions(+), 77 deletions(-)

-- 
2.43.0

