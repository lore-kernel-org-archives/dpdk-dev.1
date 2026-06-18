Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB337CD98ED
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 14:13:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B689140E3A;
	Thu, 18 Jun 2026 16:12:05 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 1314140DDD;
 Thu, 18 Jun 2026 16:12:03 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E5F951A0010;
 Thu, 18 Jun 2026 16:12:02 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AE5991A0019;
 Thu, 18 Jun 2026 16:12:02 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 606FC1800086;
 Thu, 18 Jun 2026 22:12:01 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	david.marchand@redhat.com,
	dev@dpdk.org
Cc: stable@dpdk.org,
	Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v1 07/17] bus/dpaa: fix fd leak for ccsr mmap
Date: Thu, 18 Jun 2026 19:41:41 +0530
Message-Id: <20260618141151.3990283-8-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260618141151.3990283-1-hemant.agrawal@nxp.com>
References: <20260618141151.3990283-1-hemant.agrawal@nxp.com>
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

The CCSR file descriptor was kept open after mmap() was done.
Close the fd immediately after mmap() as it is no longer needed,
preventing a file descriptor leak.

Fixes: 8e253882cd ("bus/dpaa: support interrupt portal based fd")
Cc: stable@dpdk.org

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/dpaa/base/qbman/bman_driver.c | 3 ++-
 drivers/bus/dpaa/base/qbman/qman_driver.c | 6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/dpaa/base/qbman/bman_driver.c b/drivers/bus/dpaa/base/qbman/bman_driver.c
index 23e44ac10b..71a2028383 100644
--- a/drivers/bus/dpaa/base/qbman/bman_driver.c
+++ b/drivers/bus/dpaa/base/qbman/bman_driver.c
@@ -145,7 +145,7 @@ void bman_thread_irq(void)
 
 int bman_init_ccsr(const struct device_node *node)
 {
-	static int ccsr_map_fd;
+	int ccsr_map_fd;
 	uint64_t phys_addr;
 	const uint32_t *bman_addr;
 	uint64_t regs_size;
@@ -169,6 +169,7 @@ int bman_init_ccsr(const struct device_node *node)
 
 	bman_ccsr_map = mmap(NULL, regs_size, PROT_READ |
 			     PROT_WRITE, MAP_SHARED, ccsr_map_fd, phys_addr);
+	close(ccsr_map_fd);
 	if (bman_ccsr_map == MAP_FAILED) {
 		pr_err("Can not map BMan CCSR base Bman: "
 		       "0x%x Phys: 0x%" PRIx64 " size 0x%" PRIu64,
diff --git a/drivers/bus/dpaa/base/qbman/qman_driver.c b/drivers/bus/dpaa/base/qbman/qman_driver.c
index 3bab8b8337..45b094e0c6 100644
--- a/drivers/bus/dpaa/base/qbman/qman_driver.c
+++ b/drivers/bus/dpaa/base/qbman/qman_driver.c
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2008-2016 Freescale Semiconductor Inc.
- * Copyright 2017-2022, 2025 NXP
+ * Copyright 2017-2022, 2025-2026 NXP
  *
  */
 
@@ -270,7 +270,7 @@ int qman_global_init(void)
 	const struct device_node *dt_node;
 	size_t lenp;
 	const u32 *chanid;
-	static int ccsr_map_fd;
+	int ccsr_map_fd;
 	const uint32_t *qman_addr;
 	uint64_t phys_addr;
 	uint64_t regs_size;
@@ -358,9 +358,9 @@ int qman_global_init(void)
 		pr_err("Can not open /dev/mem for qman ccsr map\n");
 		return ccsr_map_fd;
 	}
-
 	qman_ccsr_map = mmap(NULL, regs_size, PROT_READ | PROT_WRITE,
 			     MAP_SHARED, ccsr_map_fd, phys_addr);
+	close(ccsr_map_fd);
 	if (qman_ccsr_map == MAP_FAILED) {
 		pr_err("Can not map qman ccsr base\n");
 		return -EINVAL;
-- 
2.43.0

