Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D863CCF2C9
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Oct 2026 06:42:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A3705406BC;
	Sun, 18 Oct 2026 08:42:05 +0200 (CEST)
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [44.246.68.102]) by mails.dpdk.org (Postfix) with ESMTP id 64FF140276
 for <dev@dpdk.org>; Sun, 18 Oct 2026 08:42:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1792305724; x=1823841724;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=r0ZNm0nXlFCMAgDfL+TCPtVCaiC/1MIZ6pP//MZXwz0=;
 b=qM2VdOW08FXhNYgiaVy6tMAMwQmkcaV5H1+1OtyaRIppomxPETwENh5e
 PYjHYr/tUgyrD+N5PhjYZSAL9eJBZ3FxSDSot1jV0i4bwkfv9Ty5Le3kd
 79EMcoVVpawNWFyDgKtYHgJSL45qjV52TacDTaRnaRVMOpWguyjC5E+zL
 PuEI/Q5B+hIaMn+YbU2B39YJWyK/Zq58WBPGlZ7uHXRDqegIxU0D6jtsd
 s7NEM4/MV1i3f4IGdwFQ+pQqyUgUZVn9FsZHSFnGylY4yBJQYPF8MkjMv
 lZmqPcY2a12u+kpp1p0/pzfthFiJvqItrsrDLPTKsK6jyHqiy++/SGOku w==;
X-CSE-ConnectionGUID: v95mXvtFT4uAledd72bkYQ==
X-CSE-MsgGUID: NASfJUkFRbSKBsHVCu37bA==
X-IronPort-AV: E=Sophos;i="6.27,165,1787011200"; d="scan'208";a="31472833"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2026 06:42:01 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:23330]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.190:2525]
 with esmtp (Farcaster)
 id 78978b4d-2b4f-4276-96a1-842029c4332a; Sun, 18 Oct 2026 06:42:01 +0000 (UTC)
X-Farcaster-Flow-ID: 78978b4d-2b4f-4276-96a1-842029c4332a
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Sun, 18 Oct 2026 06:42:00 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.212.8) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Sun, 18 Oct 2026 06:41:59 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>, Amit Bernstein
 <amitbern@amazon.com>
Subject: [PATCH v2 12/13] net/ena/base: remove x86 Tx LLQ write barrier
Date: Sun, 18 Oct 2026 09:41:49 +0300
Message-ID: <20261018064149.1553-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.212.8]
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
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

ena_com_write_bounce_buffer_to_dev() issues a wmb() before copying each
LLQ entry from the bounce buffer to the write-combining (WC) LLQ memory
region. It was intended to ensure the bounce buffer is fully written
before the copy reads it. That is never needed: a CPU always observes
its own prior stores, on every architecture. wmb() also orders stores
against later stores, not against later loads, so it could not provide
that guarantee anyway.

The barrier is needed on ARM for a different reason: it orders one LLQ
entry's stores to the device ahead of the next entry's. The copy uses
relaxed stores, which on ARM may reach the device partially and out of
order while the burst is still being written. The barrier in the
doorbell write cannot prevent this, as it only orders the entries
against the doorbell, not against each other. With the barrier removed,
c8gn at 32 queues fails with IPP_REASS_ERROR_PRE_VALID_DB ("Data Out of
Window") before the doorbell is written.

On x86 the barrier is redundant. WC stores are weakly ordered there
too, so it never ordered entries against each other. The entries reach
the device before the doorbell because of the memory type, not a fence:
each entry is written as complete 64-byte WC lines, and on Intel the UC
doorbell write flushes pending WC buffers, while on AMD each 64-byte WC
line is flushed once it is fully written. The per-entry SFENCE made the
CPU wait for the previous entry to reach the device before copying the
next one, defeating the purpose of write combining.

Introduce arm_wmb(), a write barrier on ARM and a no-op elsewhere, and
use it in place of wmb() before the bounce buffer copy.

Signed-off-by: Amit Bernstein <amitbern@amazon.com>
Signed-off-by: Shai Brandes <shaibran@amazon.com>
---
 doc/guides/rel_notes/release_26_11.rst |  2 ++
 drivers/net/ena/base/ena_eth_com.c     | 23 ++++++++++++++++++++---
 drivers/net/ena/base/ena_plat_dpdk.h   |  8 ++++++++
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 05281c3d11..c6c8719d2b 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -95,6 +95,8 @@ New Features
 * **Updated Amazon ENA (Elastic Network Adapter) ethernet driver.**
 
   * Added Rx flow steering support using the generic flow API.
+  * Restrict the Tx LLQ write barrier to ARM, where it is required for correct entry ordering,
+    and remove it on x86, where it is redundant and limits throughput.
 
 * **Updated Intel iavf driver.**
 
diff --git a/drivers/net/ena/base/ena_eth_com.c b/drivers/net/ena/base/ena_eth_com.c
index ea0fb374db..5dbb432acc 100644
--- a/drivers/net/ena/base/ena_eth_com.c
+++ b/drivers/net/ena/base/ena_eth_com.c
@@ -132,10 +132,27 @@ static int ena_com_write_bounce_buffer_to_dev(struct ena_com_io_sq *io_sq,
 			    io_sq->qid, io_sq->llq_runtime.entries_in_tx_burst_left);
 	}
 
-	/* Make sure everything was written into the bounce buffer before
-	 * writing the bounce buffer to the device
+	/* Ensure the previous LLQ entry reaches the device before this one.
+	 *
+	 * The original wmb() was intended to ensure the bounce buffer is
+	 * fully written before it is copied to the device. This is not
+	 * required: a CPU always observes its own prior stores, on every
+	 * architecture. Moreover, wmb() orders stores against later stores,
+	 * not against later loads, so it could not provide this guarantee.
+	 *
+	 * The copy below uses relaxed stores to the WC LLQ region: plain
+	 * stores with no barrier, which the CPU may send to the device in any
+	 * order. On ARM, this means an entry may reach the device partially
+	 * and out of order before the doorbell is written. In addition, the
+	 * barrier in the doorbell write cannot prevent this, as it only orders
+	 * the entries against the doorbell, not against each other.
+	 *
+	 * On x86, this barrier is not needed. Each entry is written as complete
+	 * 64-byte WC lines, all of which reach the device before the
+	 * doorbell: on Intel, the UC doorbell write flushes pending WC
+	 * buffers; on AMD, each line is flushed once it is fully written.
 	 */
-	wmb();
+	arm_wmb();
 
 	/* The line is completed. Copy it to dev */
 	ENA_MEMCPY_TO_DEVICE_64(io_sq->desc_addr.pbuf_dev_addr + dst_offset,
diff --git a/drivers/net/ena/base/ena_plat_dpdk.h b/drivers/net/ena/base/ena_plat_dpdk.h
index 4a6d53d0a2..12f1643a85 100644
--- a/drivers/net/ena/base/ena_plat_dpdk.h
+++ b/drivers/net/ena/base/ena_plat_dpdk.h
@@ -73,6 +73,14 @@ typedef RTE_ATOMIC(int32_t) ena_atomic32_t;
 #define rmb rte_rmb
 #define mb rte_mb
 #define mmiowb rte_io_wmb
+
+/* Write memory barrier for ARM architectures - covers 32 and 64 bit ARM */
+#if defined(RTE_ARCH_ARM)
+#define arm_wmb rte_wmb
+#else
+static inline void arm_wmb(void) { }
+#endif
+
 #define __iomem
 
 #ifndef READ_ONCE
-- 
2.17.1

