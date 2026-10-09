Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E1BCA6019
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 15:11:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9FB39402EE;
	Fri,  9 Oct 2026 17:11:08 +0200 (CEST)
Received: from smtp06-ext.udag.de (smtp06-ext.udag.de [62.146.106.76])
 by mails.dpdk.org (Postfix) with ESMTP id 3D58B4025A
 for <dev@dpdk.org>; Fri,  9 Oct 2026 17:11:05 +0200 (CEST)
Received: from machine (unknown [37.228.233.98])
 by smtp06-ext.udag.de (Postfix) with ESMTPA id 7F33CE01C0;
 Fri,  9 Oct 2026 17:11:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dressler.pro;
 s=uddkim-202310; t=1791558664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a0fpRkDHcllzbfWCJZXnNiUxOy5fvabSd8tNsxbx7EY=;
 b=aEk6R+T4ztfeA7uwC6KmKjwlrZ0XynK3SpwG1t5Pb8Ae11yJnpFTA63E+Ts3RlbsQwNRCK
 vbrA9t34MfyVecoG5oKtvLey+Gl0z0/C9fTfUrnPy+p3nOIhOAuDxguY1kYyKrDfTiqLPS
 0VVYZw/UMif0ZiQZCXm17WuvV/NcxoGYsXgs92aV3NUksl8gHlUlYXohfiz0q0w64MQQ5m
 AxQ7QfaWbxc7Cvv8wFgiCr0KREogbsQU+cIt7QbEnwaz7kSdSNKVvYEu5601i89KVPZCg9
 r1Nt1/gsCgzBuAXwkOLnB/qT+kMfuiTXu1NO3D2VZM/n5z8/8U/y3RNbo/kN7Q==
Authentication-Results: smtp06-ext.udag.de;
 auth=pass smtp.auth=dressler-pro-0001 smtp.mailfrom=frank@dressler.pro
From: Frank Dressler <frank@dressler.pro>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: [PATCH v5 2/3] net/af_packet: use kernel to filter single-queue Rx
Date: Fri,  9 Oct 2026 16:10:14 +0100
Message-ID: <20261009151015.742011-3-frank@dressler.pro>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261009151015.742011-1-frank@dressler.pro>
References: <20261005002809.1676723-1-frank@dressler.pro>
 <20261009151015.742011-1-frank@dressler.pro>
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

Currently, when the ignore_outgoing devarg is 1, the PMD still
receives outgoing packets from the kernel but skips over them so
that rte_eth_rx_burst() only returns incoming packets.

Since Linux kernel v4.20, the PACKET_IGNORE_OUTGOING socket option
prevents the kernel from delivering outgoing packets to an
AF_PACKET socket.

This change sets this socket option so that the PMD does not need to
filter out outgoing packets anymore. However, this socket option does
not work for packet sockets which are in a fanout group, so it
is only set in the single-queue scenario. When multiple queues
are used, the PMD-side filtering serves as a fallback.

The kernel has supported this flag since v4.20, and DPDK requires
at least v5.4, so no feature check has been added.

Signed-off-by: Frank Dressler <frank@dressler.pro>
---
 doc/guides/rel_notes/release_26_11.rst    |  3 ++-
 drivers/net/af_packet/rte_eth_af_packet.c | 14 +++++++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index daf5603a41..0cf7671cbb 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -67,7 +67,8 @@ New Features
 * **Updated AF_PACKET driver.**
 
   Added ``ignore_outgoing`` vdev argument to prevent `rte_eth_rx_burst()` from
-  returning transmitted packets.
+  returning transmitted packets. The single-queue scenario is accelerated,
+  as the kernel does the filtering.
 
 * **Updated AF_XDP driver.**
 
diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index 837da9a3af..085bfa9af9 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -1038,6 +1038,18 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
 #endif
 		}
 
+		if (ignore_outgoing != 0 && nb_queues == 1) {
+			rc = setsockopt(qsockfd, SOL_PACKET, PACKET_IGNORE_OUTGOING,
+					&ignore_outgoing, sizeof(ignore_outgoing));
+			if (rc == -1) {
+				PMD_LOG_ERRNO(ERR,
+					"%s: could not set PACKET_IGNORE_OUTGOING "
+					"on AF_PACKET socket for %s",
+					name, pair->value);
+				goto error;
+			}
+		}
+
 		rc = setsockopt(qsockfd, SOL_PACKET, PACKET_RX_RING, req, sizeof(*req));
 		if (rc == -1) {
 			PMD_LOG_ERRNO(ERR,
@@ -1056,7 +1068,7 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
 
 		rx_queue = &((*internals)->rx_queue[q]);
 		rx_queue->framecount = req->tp_frame_nr;
-		rx_queue->ignore_outgoing = ignore_outgoing != 0;
+		rx_queue->ignore_outgoing = ignore_outgoing != 0 && nb_queues > 1;
 
 		rx_queue->map = mmap(NULL, 2 * req->tp_block_size * req->tp_block_nr,
 				    PROT_READ | PROT_WRITE, MAP_SHARED | MAP_LOCKED,
-- 
2.56.0

