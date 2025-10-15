Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B281CCCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 12:09:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A6BE40EDB;
	Wed, 15 Oct 2025 14:09:33 +0200 (CEST)
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [35.155.198.111])
 by mails.dpdk.org (Postfix) with ESMTP id 751E340273;
 Wed, 15 Oct 2025 14:09:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1760530171; x=1792066171;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=X6DxD+SaS6DRGktxJ6V5W5FA14AVba7PwCEjS4IOzNE=;
 b=K78ZLGOHaETRGhlgO5YjMhDjK/3Uq1px+gwIQeGvKW9PEehbXoQmpW2m
 Tha9ZPy3v/HMBBBCi9+Gk6KDtFOYbbxpAYZjlTn69FGQsp/oB/rQPQz3e
 FxeAfUkcBQ4JVwQjN4aMp/JcVuwfvFne0zwv41nYWZbvPIBxjiAkNiRWI
 CU+v6oJ0ZAgLQgZz3MJpc04cDFnQV5yH1R249Wkno6HgFXHfWsQ/uP2ON
 dz2XBd7wzBXqOwzW+7+tMvd4UhgQqpMoxCZvuxZQ7qifN1SmA1V020R0q
 b97pVvul3LLF5o0T8N9b4yLFoP3jKhXH7le/pFsq93U8mFrWH+sIHzpxM A==;
X-CSE-ConnectionGUID: NBvtH8/mT5qwwAaRz5XnrQ==
X-CSE-MsgGUID: /5xKB/aITfyTfGmlZnEESg==
X-IronPort-AV: E=Sophos;i="6.19,231,1754956800"; 
   d="scan'208";a="4813536"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
 by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 12:09:30 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:9192]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.122:2525]
 with esmtp (Farcaster)
 id 05097ed0-a99f-40d0-b5b7-cca2ef652fcb; Wed, 15 Oct 2025 12:09:30 +0000 (UTC)
X-Farcaster-Flow-ID: 05097ed0-a99f-40d0-b5b7-cca2ef652fcb
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 12:09:30 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.213.14) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 12:09:28 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>, <stable@dpdk.org>,
 Amit Bernstein <amitbern@amazon.com>
Subject: [PATCH v2 09/20] net/ena: fix PCI BAR mapping on 64K page size
Date: Wed, 15 Oct 2025 15:09:16 +0300
Message-ID: <20251015120916.2632-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.213.14]
X-ClientProxiedBy: EX19D044UWA004.ant.amazon.com (10.13.139.7) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
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

On 64K page systems, DPDK `pci_uio` driver aligns the physical address
to a 64K boundary before assigning a virtual address.
If the original physical BAR address is not 64K-aligned,
this adjustment leads to an incorrect mapping.

This patch ensures the BAR virtual address received in the driver accounts
for both PAGE size and BAR physical offset to correctly map each BAR.
The fix is compatible for every PAGE size, applies to every used BAR,
and supports both 32/64 bit DPDK builds.

Example issue:
- BAR0 physical address: 0x80208000 (not 64K-aligned)
- DPDK aligned physical address: 0x80208000 -> 0x80200000
  (masking 0x8000 offset)
- DPDK mapped physical to virtual address: 0x80200000 -> 0x1140000000
- Driver accessed BAR0 virtual address = 0x1140000000
  (causing init failure)
- Resolution is to add correct offset to driver BAR0 address:
  0x1140000000 + 0x8000

Fixes: 1173fca25af9 ("ena: add polling-mode driver")
Cc: stable@dpdk.org
Signed-off-by: Amit Bernstein <amitbern@amazon.com>
Signed-off-by: Shai Brandes <shaibran@amazon.com>
Reviewed-by: Yosef Raisman <yraisman@amazon.com>
---
 doc/guides/rel_notes/release_25_11.rst |  1 +
 drivers/net/ena/ena_ethdev.c           | 28 ++++++++++++++++++++++----
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
index a8fbd0a483..9a9eea371d 100644
--- a/doc/guides/rel_notes/release_25_11.rst
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -58,6 +58,7 @@ New Features
 * **Updated Amazon ENA (Elastic Network Adapter) net driver.**
 
   * Added support for retrieving HW timestamps for Rx packets with nanosecond resolution.
+  * Fixed PCI BAR mapping on 64K page size.
 
 * **Added speed 800G.**
 
diff --git a/drivers/net/ena/ena_ethdev.c b/drivers/net/ena/ena_ethdev.c
index 5147a754b2..aaa4feb11b 100644
--- a/drivers/net/ena/ena_ethdev.c
+++ b/drivers/net/ena/ena_ethdev.c
@@ -9,6 +9,7 @@
 #include <rte_version.h>
 #include <rte_net.h>
 #include <rte_kvargs.h>
+#include <rte_eal_paging.h>
 
 #include "ena_ethdev.h"
 #include "ena_logs.h"
@@ -2364,6 +2365,24 @@ static int ena_init_once(void)
 	return 0;
 }
 
+/*
+ * Returns PCI BAR virtual address.
+ * If the physical address is not page-aligned,
+ * adjusts the virtual address by the page offset.
+ * Assumes page size is a power of 2.
+ */
+static void *pci_bar_addr(struct rte_pci_device *dev, uint32_t bar)
+{
+	const struct rte_mem_resource *res = &dev->mem_resource[bar];
+	size_t offset = res->phys_addr % rte_mem_page_size();
+	void *vaddr = RTE_PTR_ADD(res->addr, offset);
+
+	PMD_INIT_LOG_LINE(INFO, "PCI BAR [%u]: phys_addr=0x%" PRIx64 ", addr=%p, offset=0x%zx, adjusted_addr=%p",
+		bar, res->phys_addr, res->addr, offset, vaddr);
+
+	return vaddr;
+}
+
 static int eth_ena_dev_init(struct rte_eth_dev *eth_dev)
 {
 	struct ena_calc_queue_size_ctx calc_queue_ctx = { 0 };
@@ -2409,16 +2428,17 @@ static int eth_ena_dev_init(struct rte_eth_dev *eth_dev)
 
 	intr_handle = pci_dev->intr_handle;
 
-	adapter->regs = pci_dev->mem_resource[ENA_REGS_BAR].addr;
-	adapter->dev_mem_base = pci_dev->mem_resource[ENA_MEM_BAR].addr;
-
+	adapter->regs = pci_bar_addr(pci_dev, ENA_REGS_BAR);
 	if (!adapter->regs) {
 		PMD_INIT_LOG_LINE(CRIT, "Failed to access registers BAR(%d)",
 			     ENA_REGS_BAR);
 		return -ENXIO;
 	}
-
 	ena_dev->reg_bar = adapter->regs;
+
+	/* Memory BAR may be NULL on non LLQ supported devices */
+	adapter->dev_mem_base = pci_bar_addr(pci_dev, ENA_MEM_BAR);
+
 	/* Pass device data as a pointer which can be passed to the IO functions
 	 * by the ena_com (for example - the memory allocation).
 	 */
-- 
2.17.1

