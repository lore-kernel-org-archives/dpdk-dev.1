Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02197CC6B33
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 11:15:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D38EA40684;
	Thu, 15 Oct 2026 13:14:56 +0200 (CEST)
Received: from smtp04-ext3.udag.de (smtp04-ext3.udag.de [62.146.106.41])
 by mails.dpdk.org (Postfix) with ESMTP id ED4214064A
 for <dev@dpdk.org>; Thu, 15 Oct 2026 13:14:52 +0200 (CEST)
Received: from machine (unknown [37.228.233.98])
 by smtp04-ext3.udag.de (Postfix) with ESMTPA id 48F90E04FD;
 Thu, 15 Oct 2026 13:14:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dressler.pro;
 s=uddkim-202310; t=1792062892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uub8Fg2f7B+Jg1os54+1fTvcjxPlhrCbcO00mO6B17g=;
 b=T2Am29IVKlNs47ES4C5Cn42JP/iubX7xWr+xrNensC//9qXpTXbhI2YF/ZusaVaj1Eqs4H
 p/lARsEBqxjMqPulUJl09xeAQUEw2Qn63zj0IpvMwIW6rvTSi1VMjlLgkc1VJKVF2evqz3
 Bx8hltVqSp8h/JfW252v9TDVYay49A8kopWyuoL5+nMwrjji11L+ApOdUwbazGKFViMEmV
 Xhi5mr0QziJrVKCj3wMkVetK+LPaFSXZ4cNJvVZc6K6e8jXXY/ebs/uVvQ/EVfcLFpqFD7
 EQYOrZ/t8BSFLjz0ra/AW1YyXgKr86cpSrdTOtNTJT0j4T5l5o+IlC5onYRaRQ==
Authentication-Results: smtp04-ext3.udag.de;
 auth=pass smtp.auth=dressler-pro-0001 smtp.mailfrom=frank@dressler.pro
From: Frank Dressler <frank@dressler.pro>
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v6 3/4] net/af_packet: use kernel to filter single-queue Rx
Date: Thu, 15 Oct 2026 12:14:33 +0100
Message-ID: <20261015111434.1470973-4-frank@dressler.pro>
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

Currently, when the ignore_outgoing devarg is 1, the PMD still
receives outgoing packets from the kernel but skips over them so
that rte_eth_rx_burst() only returns incoming packets.

Since Linux 4.20, the PACKET_IGNORE_OUTGOING socket option
prevents the kernel from delivering outgoing packets to an
AF_PACKET socket.

This change sets this socket option so that the PMD does not need to
filter out outgoing packets anymore. However, this socket option does
not work for packet sockets which are in a fanout group, so it
is only set in the single-queue scenario. When multiple queues
are used, the PMD-side filtering serves as a fallback.

This flag is supported since Linux 4.20, and DPDK requires
at least Linux 5.4, so no feature check has been added.

Signed-off-by: Frank Dressler <frank@dressler.pro>
---
 doc/guides/nics/af_packet.rst             |  3 +++
 doc/guides/rel_notes/release_26_11.rst    |  3 ++-
 drivers/net/af_packet/rte_eth_af_packet.c | 14 +++++++++++++-
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/doc/guides/nics/af_packet.rst b/doc/guides/nics/af_packet.rst
index 45adbbf8b2..6df14c510d 100644
--- a/doc/guides/nics/af_packet.rst
+++ b/doc/guides/nics/af_packet.rst
@@ -43,6 +43,9 @@ Only one ``fanout_mode`` can be chosen.
 If left unspecified, the default is to use the ``PACKET_FANOUT_HASH`` behavior
 of AF_PACKET for frame reception.
 
+When ``ignore_outgoing`` is set, ``PACKET_IGNORE_OUTGOING`` is set for
+single-queue ports, which moves the filtering from the PMD to the kernel.
+
 Because this implementation is based on PACKET_MMAP, and PACKET_MMAP has its
 own pre-requisites, it should be noted that the inner workings of PACKET_MMAP
 should be carefully considered before modifying some of these options (namely,
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 4bbb3333ce..e83cb9854f 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -117,7 +117,8 @@ New Features
 * **Updated AF_PACKET driver.**
 
   Added ``ignore_outgoing`` so ``rte_eth_rx_burst()`` returns only incoming
-  packets.
+  packets. The single-queue scenario is accelerated, as the kernel does
+  the filtering.
 
 * **Updated AF_XDP driver.**
 
diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index b744305e00..44b91502fb 100644
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

