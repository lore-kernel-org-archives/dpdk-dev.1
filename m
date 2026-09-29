Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78AECA5FA1
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 10:46:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7537A41156;
	Tue, 29 Sep 2026 12:45:41 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 3EC6340E7C
 for <dev@dpdk.org>; Tue, 29 Sep 2026 12:45:25 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 23EF12000DC;
 Tue, 29 Sep 2026 12:45:25 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EA2082000E7;
 Tue, 29 Sep 2026 12:45:24 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 6D0C01800224;
 Tue, 29 Sep 2026 18:45:24 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: Prashant Gupta <prashant.gupta_3@nxp.com>
Subject: [PATCH v17 06/23] drivers: add process-type guards for secondary
 process
Date: Tue, 29 Sep 2026 16:15:02 +0530
Message-Id: <20260929104519.1770698-7-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260929104519.1770698-1-hemant.agrawal@nxp.com>
References: <20260928065849.126909-1-hemant.agrawal@nxp.com>
 <20260929104519.1770698-1-hemant.agrawal@nxp.com>
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

From: Prashant Gupta <prashant.gupta_3@nxp.com>

The DPAA QDMA and net/dpaa drivers run primary-only code from paths that
a secondary process also executes.

In dma/dpaa, struct fsl_qdma_engine is allocated from shared memory, but
the register bases stored in it are process-private mmap()s of the QDMA
CCSR region created by the primary. A secondary that probes the device
would advertise a dmadev whose MMIO pointers are not mapped in its own
address space. Reject the probe with -ENOTSUP until a secondary can
establish its own mapping.

In net/dpaa, rte_dpaa_remove() also does primary-only bookkeeping: it
decrements the driver device count and frees the shared Tx
scatter-gather mempool when that count reaches zero. Both are set up
only on the primary probe path, so a secondary must not run them. Let a
secondary release just its local ethdev port and return.

Signed-off-by: Prashant Gupta <prashant.gupta_3@nxp.com>
---
 drivers/dma/dpaa/dpaa_qdma.c   | 14 ++++++++++++++
 drivers/net/dpaa/dpaa_ethdev.c |  6 +++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dpaa/dpaa_qdma.c b/drivers/dma/dpaa/dpaa_qdma.c
index e2cb157c43..0234042ded 100644
--- a/drivers/dma/dpaa/dpaa_qdma.c
+++ b/drivers/dma/dpaa/dpaa_qdma.c
@@ -1433,6 +1433,20 @@ dpaa_qdma_probe(__rte_unused struct rte_dpaa_driver *dpaa_drv,
 	struct rte_dma_dev *dmadev;
 	int ret;
 
+	/*
+	 * struct fsl_qdma_engine lives in memory shared with the primary, and
+	 * reg_base in it is a process-private mmap of the QDMA CCSR region that
+	 * is only valid in the primary. Until a secondary can establish its own
+	 * mapping, do not advertise the device here: registering it would hand
+	 * out a usable dmadev whose MMIO pointers are not mapped in this
+	 * process.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
+		DPAA_QDMA_WARN("%s: not supported in secondary process",
+			dpaa_dev->device.name);
+		return -ENOTSUP;
+	}
+
 	dmadev = rte_dma_pmd_allocate(dpaa_dev->device.name,
 				      rte_socket_id(),
 				      sizeof(struct fsl_qdma_engine));
diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index 79afeaf1b0..c006e3e958 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
  *   Copyright 2016 Freescale Semiconductor, Inc. All rights reserved.
- *   Copyright 2017-2020,2022-2025 NXP
+ *   Copyright 2017-2020,2022-2026 NXP
  *
  */
 /* System headers */
@@ -2684,6 +2684,10 @@ rte_dpaa_remove(struct rte_dpaa_device *dpaa_dev)
 	PMD_INIT_FUNC_TRACE();
 
 	eth_dev = rte_eth_dev_allocated(dpaa_dev->device.name);
+
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return eth_dev ? rte_eth_dev_release_port(eth_dev) : 0;
+
 	if (eth_dev && eth_dev->state != RTE_ETH_DEV_UNUSED) {
 		int close_ret = dpaa_eth_dev_close(eth_dev);
 
-- 
2.25.1

