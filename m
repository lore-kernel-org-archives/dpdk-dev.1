Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1713CC6B33
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 11:15:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 978D640693;
	Thu, 15 Oct 2026 13:14:57 +0200 (CEST)
Received: from smtp04-ext3.udag.de (smtp04-ext3.udag.de [62.146.106.41])
 by mails.dpdk.org (Postfix) with ESMTP id 87C3A4064A
 for <dev@dpdk.org>; Thu, 15 Oct 2026 13:14:53 +0200 (CEST)
Received: from machine (unknown [37.228.233.98])
 by smtp04-ext3.udag.de (Postfix) with ESMTPA id F18A5E0504;
 Thu, 15 Oct 2026 13:14:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dressler.pro;
 s=uddkim-202310; t=1792062893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qOwvSfffhV/3RY44k93CDKOVk+FoM+F0KzY5QQToieo=;
 b=Kb0MLxydjk1vSlCmQT3mnGhqYA9Na2nGKA/Verm5FweCtBDlUj5/Lc3RECvSYMqk4q8qWc
 737ZtQJX3VwVmmvKxMYjbnN1hCI/l0o2OhgX8vsHsb2XGSParEuPiCSkE4opO+edKLls+7
 E695VFGMMlefQp8q0uPL01m9iboqBjk4NmQ0Xr8SmM9XDVGomuqahh/n9xOwgrSVIUTCFJ
 EVzwNqTAXUqoE87oE1pnID75Ea+RU4zphtL3rKSQFctc9O2LZ0SppjTcHHdIB2d+4Erw5p
 T9hBIHyBtDmv4MOksWXmgJrYuny6mLucRj4lw47KcdmrYatAKxWOrdCEW0VaDw==
Authentication-Results: smtp04-ext3.udag.de;
 auth=pass smtp.auth=dressler-pro-0001 smtp.mailfrom=frank@dressler.pro
From: Frank Dressler <frank@dressler.pro>
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v6 4/4] net/af_packet: use kernel to filter multi-queue Rx
Date: Thu, 15 Oct 2026 12:14:34 +0100
Message-ID: <20261015111434.1470973-5-frank@dressler.pro>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261015111434.1470973-1-frank@dressler.pro>
References: <20261009151015.742011-1-frank@dressler.pro>
 <20261015111434.1470973-1-frank@dressler.pro>
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

Since Linux 6.2, the kernel filters outgoing packets for a fanout
group when PACKET_FANOUT_FLAG_IGNORE_OUTGOING is set.

This change opportunistically sets this flag for all kernel versions
in multi-queue scenarios. Kernels before Linux 6.2 ignore the flag
and have no way to detect support. The PMD filtering is kept as a
fallback for kernels that do not support the flag.

Signed-off-by: Frank Dressler <frank@dressler.pro>
---
 doc/guides/nics/af_packet.rst             |  3 +++
 doc/guides/rel_notes/release_26_11.rst    |  3 ++-
 drivers/net/af_packet/rte_eth_af_packet.c | 13 +++++++++++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/doc/guides/nics/af_packet.rst b/doc/guides/nics/af_packet.rst
index 6df14c510d..702822a428 100644
--- a/doc/guides/nics/af_packet.rst
+++ b/doc/guides/nics/af_packet.rst
@@ -45,6 +45,9 @@ of AF_PACKET for frame reception.
 
 When ``ignore_outgoing`` is set, ``PACKET_IGNORE_OUTGOING`` is set for
 single-queue ports, which moves the filtering from the PMD to the kernel.
+For multi-queue ports ``PACKET_FANOUT_FLAG_IGNORE_OUTGOING`` is set to
+achieve the same but this only works from Linux 6.2. For earlier Linux
+versions, the PMD does the filtering for multi-queue ports.
 
 Because this implementation is based on PACKET_MMAP, and PACKET_MMAP has its
 own pre-requisites, it should be noted that the inner workings of PACKET_MMAP
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index e83cb9854f..9740e9fdce 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -118,7 +118,8 @@ New Features
 
   Added ``ignore_outgoing`` so ``rte_eth_rx_burst()`` returns only incoming
   packets. The single-queue scenario is accelerated, as the kernel does
-  the filtering.
+  the filtering. Multi-queue ports are also filtered in the kernel since
+  Linux 6.2, otherwise in the PMD.
 
 * **Updated AF_XDP driver.**
 
diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index 44b91502fb..0d044ab661 100644
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
+	 * It takes effect from Linux 6.2. Older kernels ignore it and the
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

