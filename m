Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2FAC2D0CD
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 14:06:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1CC8642D55;
	Wed, 21 May 2025 16:06:16 +0200 (CEST)
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com
 [52.119.213.154])
 by mails.dpdk.org (Postfix) with ESMTP id B2B104028F;
 Wed, 21 May 2025 16:06:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1747836374; x=1779372374;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=m/BJW3VYWo9RmJhh+YrD6KgiN19BWutihabRw9RqsT0=;
 b=fEvqMvHcizo6PJkMvWj6zinHZscMsC6P6dXfsIWbnZ2ZJCbw4/HVMX9Q
 LdeFgJe5gH0lWqO2QeB0tSCeAvFbwo/vNlb7Dl5VHzac+DTiD1jGiAl61
 3nUyUhW5AE00sfvdUq8b27Sck2Lbfo3VhZYbWvnFLArpVdy4y3TE9ATvI
 ABdXJNg7Pr72K/ybv22Kt7YX3cWqJ4fESpuEi5+UqDOSj98MwWxMC2c8l
 AGYiR85bNbgufZthOM+GbA8odVVLIbuvAiv7zUd3L71dlWgx+yaQLhOsP
 02b8APutM0PD05bWO+aGI+bl9bavpRyA8aeqP4hzgpZ0XCdfwce95RsPf g==;
X-IronPort-AV: E=Sophos;i="6.15,303,1739836800"; d="scan'208";a="300223052"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO
 smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
 by smtp-border-fw-52004.iad7.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 14:06:11 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.17.79:1694]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.31.17:2525]
 with esmtp (Farcaster)
 id 17d28d2c-66e8-4d77-94c1-914337da81b9; Wed, 21 May 2025 14:06:10 +0000 (UTC)
X-Farcaster-Flow-ID: 17d28d2c-66e8-4d77-94c1-914337da81b9
Received: from EX19D007EUA002.ant.amazon.com (10.252.50.68) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 14:06:09 +0000
Received: from HFA15-CG15235BS.amazon.com (10.106.83.30) by
 EX19D007EUA002.ant.amazon.com (10.252.50.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 14:06:06 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>, <stable@dpdk.org>,
 Amit Bernstein <amitbern@amazon.com>
Subject: [PATCH 7/8] net/ena: fix virtual address calc for unaligned BARs
Date: Wed, 21 May 2025 17:05:52 +0300
Message-ID: <20250521140552.2790-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.106.83.30]
X-ClientProxiedBy: EX19D038UWC003.ant.amazon.com (10.13.139.209) To
 EX19D007EUA002.ant.amazon.com (10.252.50.68)
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

On 64K page systems, DPDK `pci_uio` driver aligns the physical
address to a 64K boundary before assigning a virtual address.
If the original physical BAR address is not 64K-aligned,
this adjustment leads to an incorrect mapping.

The fix ensures that the BAR virtual address received in the driver
accounts for both PAGE size and BAR physical offset to correctly map
each BAR. The fix is compatible for every PAGE size and applies to
every used BAR

Example:
- BAR0 physical address:
  0x80208000 (not 64K-aligned)
- DPDK aligned physical address:
  0x80208000 -> 0x80200000 (masking 0x8000 offset)
- DPDK mapped physical to virtual address:
  0x80200000 -> 0x1140000000
- Driver accessed BAR0 virtual address:
  0x1140000000 (causing init failure)
- Add correct offset to driver BAR0 address:
  0x1140000000 + 0x8000 (init success)

Fixes: 1173fca25af9 ("ena: add polling-mode driver")
Cc: stable@dpdk.org
Signed-off-by: Amit Bernstein <amitbern@amazon.com>
Signed-off-by: Shai Brandes <shaibran@amazon.com>
Reviewed-by: Yosef Raisman <yraisman@amazon.com>
---
 doc/guides/rel_notes/release_25_07.rst |  1 +
 drivers/net/ena/ena_ethdev.c           | 14 ++++++++++++--
 drivers/net/ena/ena_ethdev.h           |  4 ++++
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
index 662b0db49e..ce42b81a24 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -63,6 +63,7 @@ New Features
     or enabling of interrupts when operating in control path interrupt mode.
   * Fixed an issue where the device might be incorrectly reported as unresponsive when using
     polling-based admin queue functionality with a poll interval of less than 500 milliseconds.
+  * Fixed BAR mapping logic to handle 64K page alignment correctly, ensuring accurate offset adjustment.
 
 * **Added Mucse rnp net driver.**
 
diff --git a/drivers/net/ena/ena_ethdev.c b/drivers/net/ena/ena_ethdev.c
index 182e063bf4..bdb4938231 100644
--- a/drivers/net/ena/ena_ethdev.c
+++ b/drivers/net/ena/ena_ethdev.c
@@ -2285,6 +2285,16 @@ static int ena_init_once(void)
 	return 0;
 }
 
+/*
+ * Retrieve the correct PCI BAR virtual address, accounting for physical
+ * address alignment to PAGE boundary.
+ */
+static void *pci_bar_addr(struct rte_pci_device *pci_dev, uint32_t bar)
+{
+	struct rte_mem_resource *resource = &pci_dev->mem_resource[bar];
+	return RTE_PTR_ADD(resource->addr, resource->phys_addr & PAGE_MASK);
+}
+
 static int eth_ena_dev_init(struct rte_eth_dev *eth_dev)
 {
 	struct ena_calc_queue_size_ctx calc_queue_ctx = { 0 };
@@ -2330,8 +2340,7 @@ static int eth_ena_dev_init(struct rte_eth_dev *eth_dev)
 
 	intr_handle = pci_dev->intr_handle;
 
-	adapter->regs = pci_dev->mem_resource[ENA_REGS_BAR].addr;
-	adapter->dev_mem_base = pci_dev->mem_resource[ENA_MEM_BAR].addr;
+	adapter->regs = pci_bar_addr(pci_dev, ENA_REGS_BAR);
 
 	if (!adapter->regs) {
 		PMD_INIT_LOG_LINE(CRIT, "Failed to access registers BAR(%d)",
@@ -2340,6 +2349,7 @@ static int eth_ena_dev_init(struct rte_eth_dev *eth_dev)
 	}
 
 	ena_dev->reg_bar = adapter->regs;
+	adapter->dev_mem_base = pci_bar_addr(pci_dev, ENA_MEM_BAR);
 	/* Pass device data as a pointer which can be passed to the IO functions
 	 * by the ena_com (for example - the memory allocation).
 	 */
diff --git a/drivers/net/ena/ena_ethdev.h b/drivers/net/ena/ena_ethdev.h
index e5d23e2e27..1d5d4456dc 100644
--- a/drivers/net/ena/ena_ethdev.h
+++ b/drivers/net/ena/ena_ethdev.h
@@ -16,8 +16,12 @@
 #include <rte_timer.h>
 #include <rte_dev.h>
 #include <rte_net.h>
+#include <rte_eal_paging.h>
 
 #include "ena_com.h"
+#ifndef PAGE_MASK
+#define PAGE_MASK (rte_mem_page_size() - 1)
+#endif
 
 #define ENA_REGS_BAR	0
 #define ENA_MEM_BAR	2
-- 
2.17.1

