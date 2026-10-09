Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A43CA6019
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 15:03:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B858402EE;
	Fri,  9 Oct 2026 17:02:58 +0200 (CEST)
Received: from smtp02-ext3.udag.de (smtp02-ext3.udag.de [62.146.106.33])
 by mails.dpdk.org (Postfix) with ESMTP id CAC0E402D5
 for <dev@dpdk.org>; Fri,  9 Oct 2026 17:02:54 +0200 (CEST)
Received: from machine (unknown [37.228.233.98])
 by smtp02-ext3.udag.de (Postfix) with ESMTPA id 11ADDE0172;
 Fri,  9 Oct 2026 17:02:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dressler.pro;
 s=uddkim-202310; t=1791558174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oUSh86oeSLdi7Oq2eouE6sKB93aQe3iKDA45AmC8GVQ=;
 b=nuUec9tgIeZidtmrxg8pfLejJFnUWXUNs4RzXJP6zFxWHlCwbd4wrjadzEB2ZBzbmxIyS1
 wf3Z6YCN4MLUOZBiXVl8+Uh+A2KmDwgUD2Ex9alMZ/i5YvlQzNexwyLgu7X/+vB6X+VaLz
 ep1DfIlsMarAWQxK/5q3j08Rqxud8ebvw8x+IvhpyWaGVnX4Q0pjwBO0gwJk/hl88TFPd7
 6ZH0Uw4Ccm78mYbQ9m4UYht00+MutHfC1Nq1UfUD1ssZgAhaW7tEQcB27rGZVXcN+WEbRx
 X5reLOWMtq+Y46kBYgSfZLJCkWgIdNyg58AuMitH9SXfYeI7URiTUDglkNI0NQ==
Authentication-Results: smtp02-ext3.udag.de;
 auth=pass smtp.auth=dressler-pro-0001 smtp.mailfrom=frank@dressler.pro
From: Frank Dressler <frank@dressler.pro>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: [PATCH v4 3/3] net/af_packet: use kernel to filter multi-queue Rx
Date: Fri,  9 Oct 2026 16:02:40 +0100
Message-ID: <20261009150240.739865-4-frank@dressler.pro>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261009150240.739865-1-frank@dressler.pro>
References: <20261005002809.1676723-1-frank@dressler.pro>
 <20261009150240.739865-1-frank@dressler.pro>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The AF_PACKET PMD currently needs to filter out outgoing packets in
the PMD when the ignore_outgoing devarg is enabled and multiple queues
are used. Kernel-side filtering is only supported for the single-queue
scenario.

Since v6.2 the Linux kernel supports filtering outgoing packets for
AF_PACKET socket fanout groups via PACKET_FANOUT_FLAG_IGNORE_OUTGOING
which means that the PMD does not need to do this anymore.

Earlier kernels ignore this flag and have no direct way to detect
whether the flag is supported.

This change opportunistically sets this flag for all kernel versions
in multi-queue scenarios. Kernels that do not support this flag
silently ignore it. Filtering outgoing packets then falls back to the
PMD-based approach.

With this change, for all kernels v6.2 or newer, all the filtering of
outgoing packets will happen in the kernel.

Signed-off-by: Frank Dressler <frank@dressler.pro>
---
 doc/guides/rel_notes/release_26_11.rst    |  4 ++--
 drivers/net/af_packet/rte_eth_af_packet.c | 13 +++++++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 0cf7671cbb..c4ef38b362 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -67,8 +67,8 @@ New Features
 * **Updated AF_PACKET driver.**
 
   Added ``ignore_outgoing`` vdev argument to prevent `rte_eth_rx_burst()` from
-  returning transmitted packets. The single-queue scenario is accelerated,
-  as the kernel does the filtering.
+  returning transmitted packets. Single queue is always filtered in the kernel.
+  Multiple queues are filtered in the kernel since v6.2, otherwise in the PMD.
 
 * **Updated AF_XDP driver.**
 
diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index 085bfa9af9..e3ed511b45 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -32,6 +32,11 @@
 #include <unistd.h>
 #include <poll.h>
 
+/* Added in Linux 6.2. Older kernels ignore it. */
+#ifndef PACKET_FANOUT_FLAG_IGNORE_OUTGOING
+#define PACKET_FANOUT_FLAG_IGNORE_OUTGOING 0x4000
+#endif
+
 #define ETH_AF_PACKET_IFACE_ARG		"iface"
 #define ETH_AF_PACKET_NUM_Q_ARG		"qpairs"
 #define ETH_AF_PACKET_BLOCKSIZE_ARG	"blocksz"
@@ -995,6 +1000,14 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
 		goto error;
 	}
 
+	/*
+	 * Set the flag opportunistically if multiple queues are requested.
+	 * It takes effect from Linux v6.2. Older kernels ignore it and the
+	 * PMD filters instead.
+	 */
+	if (ignore_outgoing != 0 && nb_queues > 1)
+		fanout_arg |= PACKET_FANOUT_FLAG_IGNORE_OUTGOING << 16;
+
 	for (q = 0; q < nb_queues; q++) {
 		/* Open an AF_PACKET socket for this queue... */
 		qsockfd = socket(AF_PACKET, SOCK_RAW, 0);
-- 
2.56.0

