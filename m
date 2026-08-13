Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB895C5CFEB
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 10:44:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5986642670;
	Thu, 13 Aug 2026 12:44:17 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id B51FF427A9
 for <dev@dpdk.org>; Thu, 13 Aug 2026 12:44:15 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9BDD01A003F;
 Thu, 13 Aug 2026 12:44:15 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5D0241A0023;
 Thu, 13 Aug 2026 12:44:15 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 2604218000B0;
 Thu, 13 Aug 2026 18:44:14 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: Prashant Gupta <prashant.gupta_3@nxp.com>
Subject: [PATCH v10 04/25] drivers: add process-type guards for secondary
 process
Date: Thu, 13 Aug 2026 16:13:44 +0530
Message-Id: <20260813104405.2313474-5-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260813104405.2313474-1-hemant.agrawal@nxp.com>
References: <20260812174609.1100111-1-hemant.agrawal@nxp.com>
 <20260813104405.2313474-1-hemant.agrawal@nxp.com>
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

Add RTE_PROC_PRIMARY checks in device initialization paths for
dma/dpaa and net/dpaa rivers. Secondary processes should skip
hardware initialization to prevent segfaults when accessing
hardware registers that are only mapped in the primary process.

Signed-off-by: Prashant Gupta <prashant.gupta_3@nxp.com>
---
 drivers/bus/dpaa/base/qbman/qman.c | 14 ++------------
 drivers/bus/dpaa/base/qbman/qman.h | 23 ++++++++++++++++++++++-
 drivers/dma/dpaa/dpaa_qdma.c       |  3 +++
 drivers/net/dpaa/dpaa_ethdev.c     |  6 +++++-
 4 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/drivers/bus/dpaa/base/qbman/qman.c b/drivers/bus/dpaa/base/qbman/qman.c
index d289df2d33..931d487de4 100644
--- a/drivers/bus/dpaa/base/qbman/qman.c
+++ b/drivers/bus/dpaa/base/qbman/qman.c
@@ -2707,14 +2707,6 @@ int qman_delete_cgr(struct qman_cgr *cgr)
 	return ret;
 }
 
-#define GENMASK(h, l) \
-	(((~0U) >> (sizeof(unsigned int) * 8 - ((h) - (l) + 1))) << (l))
-
-/* 'fqid' is a 24-bit field in every h/w descriptor */
-#define QM_FQID_MASK    GENMASK(23, 0)
-#define qm_fqid_set(p, v) ((p)->fqid = cpu_to_be32((v) & QM_FQID_MASK))
-#define qm_fqid_get(p)    (be32_to_cpu((p)->fqid) & QM_FQID_MASK)
-
 static int
 _qm_mr_consume_and_match_verb(struct qm_portal *p, int v)
 {
@@ -2801,7 +2793,6 @@ qman_shutdown_fq(u32 fqid)
 	u32 res;
 	u8 state;
 	u32 channel, wq;
-	u16 dest_wq;
 
 	DPAA_BUS_DEBUG("In shutdown for queue = %x", fqid);
 	p = get_affine_portal();
@@ -2831,9 +2822,8 @@ qman_shutdown_fq(u32 fqid)
 	}
 
 	/* Need to store these since the MCR gets reused */
-	dest_wq = be16_to_cpu(mcr->queryfq.fqd.dest_wq);
-	channel = dest_wq & 0x7;
-	wq = dest_wq >> 3;
+	channel = qm_fqd_get_chan(&mcr->queryfq.fqd);
+	wq = qm_fqd_get_wq(&mcr->queryfq.fqd);
 
 	switch (state) {
 	case QM_MCR_NP_STATE_TEN_SCHED:
diff --git a/drivers/bus/dpaa/base/qbman/qman.h b/drivers/bus/dpaa/base/qbman/qman.h
index 43a16d1e3b..bd97689a91 100644
--- a/drivers/bus/dpaa/base/qbman/qman.h
+++ b/drivers/bus/dpaa/base/qbman/qman.h
@@ -1,12 +1,15 @@
 /* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2008-2016 Freescale Semiconductor Inc.
- * Copyright 2017 NXP
+ * Copyright 2017,2026 NXP
  *
  */
 
 #include "qman_priv.h"
 
+#define GENMASK(h, l) \
+	(((~0U) >> (sizeof(u32) * 8 - ((h) - (l) + 1))) << (l))
+
 /***************************/
 /* Portal register assists */
 /***************************/
@@ -42,6 +45,14 @@
 #define QM_CL_RR0		0x3900
 #define QM_CL_RR1		0x3940
 
+#define QM_FQD_CHAN_OFF                3
+#define QM_FQD_WQ_MASK         GENMASK(2, 0)
+/* 'fqid' is a 24-bit field in every h/w descriptor */
+#define QM_FQID_MASK    GENMASK(23, 0)
+
+#define qm_fqid_set(p, v) ((p)->fqid = cpu_to_be32((v) & QM_FQID_MASK))
+#define qm_fqid_get(p)    (be32_to_cpu((p)->fqid) & QM_FQID_MASK)
+
 /* BTW, the drivers (and h/w programming model) already obtain the required
  * synchronisation for portal accesses via lwsync(), hwsync(), and
  * data-dependencies. Use of barrier()s or other order-preserving primitives
@@ -911,3 +922,13 @@ static inline void __qm_isr_write(struct qm_portal *portal, enum qm_isr_reg n,
 	__qm_out(&portal->addr, QM_REG_ISR + (n << 2), val);
 #endif
 }
+
+static inline int qm_fqd_get_chan(const struct qm_fqd *fqd)
+{
+	return be16_to_cpu(fqd->dest_wq) >> QM_FQD_CHAN_OFF;
+}
+
+static inline int qm_fqd_get_wq(const struct qm_fqd *fqd)
+{
+	return be16_to_cpu(fqd->dest_wq) & QM_FQD_WQ_MASK;
+}
diff --git a/drivers/dma/dpaa/dpaa_qdma.c b/drivers/dma/dpaa/dpaa_qdma.c
index e2cb157c43..3981bf277e 100644
--- a/drivers/dma/dpaa/dpaa_qdma.c
+++ b/drivers/dma/dpaa/dpaa_qdma.c
@@ -1351,6 +1351,9 @@ dpaa_qdma_init(struct rte_dma_dev *dmadev)
 	int ret;
 	uint32_t i, j, k;
 
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return 0;
+
 	if (dpaa_get_devargs(dmadev->device->devargs, DPAA_DMA_ERROR_CHECK)) {
 		s_hw_err_check = true;
 		DPAA_QDMA_INFO("Enable DMA error checks");
diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index 4181fefe82..e1245c862a 100644
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
@@ -2677,6 +2677,10 @@ rte_dpaa_remove(struct rte_dpaa_device *dpaa_dev)
 	PMD_INIT_FUNC_TRACE();
 
 	eth_dev = rte_eth_dev_allocated(dpaa_dev->device.name);
+
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return eth_dev ? rte_eth_dev_release_port(eth_dev) : 0;
+
 	if (eth_dev && eth_dev->state != RTE_ETH_DEV_UNUSED) {
 		dpaa_eth_dev_close(eth_dev);
 		ret = rte_eth_dev_release_port(eth_dev);
-- 
2.25.1

