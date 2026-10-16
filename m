Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69963CCF2C3
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 21:20:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B2CC40679;
	Fri, 16 Oct 2026 23:19:55 +0200 (CEST)
Received: from smtp05-ext.udag.de (smtp05-ext.udag.de [62.146.106.75])
 by mails.dpdk.org (Postfix) with ESMTP id BC7EE40291
 for <dev@dpdk.org>; Fri, 16 Oct 2026 23:19:50 +0200 (CEST)
Received: from machine (unknown [37.228.233.98])
 by smtp05-ext.udag.de (Postfix) with ESMTPA id 60565E0280;
 Fri, 16 Oct 2026 23:19:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dressler.pro;
 s=uddkim-202310; t=1792185590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QHiqN80fuNAtXmAykq/G3wWl5FCrhzruCupOZytxPH8=;
 b=kuOmFFXOK468PCzIc5vH1Z01b8wwknoS0ZYLmQ8hRy6zGSJId8OpQtsBti2bkNHZE6pt1P
 o+NLiLTvkdpInvFq8eVT1Em/SBoaTbPq1S80qwJwx9F22O8p3CPyokQljWO71ZQ77+hMRy
 bk2m21yuBN4G6F+w3RV6Oi6fYGnwg4D4AzVqfXuIFrnJzylILrc9v92ErluKEqAe+Gvf5b
 2HhMB1mLngNSyi84Jt0sNAHdjcrS/775kxrmmZUXrkb2LqyfMti9eILM8AT9BDC0KVVnxD
 Tzy8xPNDloM0ZTJcnPVI6C+cKM41K6OhKI9xWPzIwvzwb80i9wXxpuelNivtiA==
Authentication-Results: smtp05-ext.udag.de;
 auth=pass smtp.auth=dressler-pro-0001 smtp.mailfrom=frank@dressler.pro
From: Frank Dressler <frank@dressler.pro>
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v7 4/4] net/af_packet: use kernel to filter multi-queue Rx
Date: Fri, 16 Oct 2026 22:19:42 +0100
Message-ID: <20261016211942.217041-5-frank@dressler.pro>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016211942.217041-1-frank@dressler.pro>
References: <20261009151015.742011-1-frank@dressler.pro>
 <20261016211942.217041-1-frank@dressler.pro>
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
 drivers/net/af_packet/rte_eth_af_packet.c | 13 +++++++++++++
 2 files changed, 16 insertions(+)

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
diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index 859c817842..eb56c566b4 100644
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

