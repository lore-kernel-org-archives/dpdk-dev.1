Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A34E8305D
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Feb 2026 07:08:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D19EF40651;
	Tue,  3 Feb 2026 08:07:50 +0100 (CET)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173]) by mails.dpdk.org (Postfix) with ESMTP id DB74F40281
 for <dev@dpdk.org>; Tue,  3 Feb 2026 08:07:47 +0100 (CET)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-2b720bb90d0so5179569eec.0
 for <dev@dpdk.org>; Mon, 02 Feb 2026 23:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770102467; x=1770707267; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sHhyAp+/WUPlHm5QkFRDDgGGYrTrNAs0zLjjxLGEw+s=;
 b=F9vJ0NZMJaBWeXbkUfw1GIOztoHKhxrvclEhKUIW70ygPf2X7fD0ZvYWVF3koJnQM5
 u50Xt6yLllWtyAVNwbH2XXu5ghojYHVN08BFFnLk+qDXp1KWN1AAAkD7vtbZLgKwXq2F
 boGWBkA+UGxpLfHI+YtVkImX1tZCcZLOvbQepj9O8qzo7PO20vhVwOkfWTcbqKs9bIJF
 2CVy9AEXSTebxklNZ8dVzPc3BlopmV5krxvkz9uW2Gri19UuLslGrlfKNwTKY6FNYE/o
 nMksJ9FdOZwXKGR5yjDAJ6ScbddVcYZHiEQAc8qi9nWPGYKYR6S8sLwLT+b0fk9U+Hfc
 MXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770102467; x=1770707267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sHhyAp+/WUPlHm5QkFRDDgGGYrTrNAs0zLjjxLGEw+s=;
 b=lZpR1+HKxNwJsf4FEwT5+Tx8mrprrrSCh20VBIlvnq/TxIAxCEWTvtZmB6ts3AHSZY
 UViNHeiLPhZLKlpqQHRmVwJ+MjVnJvfqSVqvb5G3IltaVog4xkUn96751q1osrJpVcj0
 Mivt2dYpbnTO5TVZ3JqtW077xfVcb5/syBHW1AfxCRjXpRtEtf3kDtYLgJ9Hq+dvgX6Y
 zdl+fNGmVb6wE3a1sj/WckPeAAlyT3779Jxv23GulXHnNpZgS0beCTbweO7k1P1yS9Rd
 epCxB8Ifcf+rNNp5pMR2V9rd9/iZ8kUVSMZgqCYhflZTNHXqbTYp6ePbPCGBmgjqvjsK
 fN5Q==
X-Gm-Message-State: AOJu0YzOl2tY89oZM0/sJ1axNWRYWEwnxZHlvX6O17IzQP2D2sR+NXpF
 IT5ItT9RSB5VcDdRXtVvNJovGpo7yCS08Xc4KSz4n/QmaBLZI8Mb1V1JDsvSaw==
X-Gm-Gg: AZuq6aJ2Q6D1+cwZbZhWBoVBRUHYeIrDDHL7uybbXJ2RHl/6lwiEr0h2xuqI0d8uATq
 Ll7jWYYYkCJbVmG0jjiunSe/87tFP3wgyR/TX0ZlJsscHO70qyxb4URqfqi8AIgCQAS8q7V5GPt
 7syEo/BA7PxnKlT3GOTKKqH7gfg9YHsJ8IDsRUDlpYX4IuDWRmZJAHsjrDPzh5uAiVoP6xNzoLb
 umMJ+WL3D8Quu3ldKxkAGyA7wTkHSFuWVPoXadZ0lY8AXlLAl/jbeYOBKDOn09eugO3pFfvtsti
 o+3mHPhVchmZY+oWMC3FUMvx5bbCCJHUVwRp82kSu/x88jAbZiwmuo9Ug9q3o2WrSEHTgisdi95
 +kk6HWdPpLHaMKhsPeI26unCGR50UPisXeorJ2pSKTOt5gYsaQPHQ5oa7A0oqGxKsepQfT0YhyS
 noEguAKHXDUqAPBHlHoNahIw==
X-Received: by 2002:a05:7300:cac8:b0:2a4:3593:c7d3 with SMTP id
 5a478bee46e88-2b7c866c83amr6637090eec.19.1770102466614; 
 Mon, 02 Feb 2026 23:07:46 -0800 (PST)
Received: from mac.com ([136.24.82.250]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b7a16cfaa8sm21073318eec.4.2026.02.02.23.07.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 23:07:46 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: stephen@networkplumber.org,
	Scott Mitchell <scott.k.mitch1@gmail.com>
Subject: [PATCH v5 3/4] net/af_packet: tx poll control
Date: Mon,  2 Feb 2026 23:07:39 -0800
Message-Id: <20260203070740.62305-4-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260203070740.62305-1-scott.k.mitch1@gmail.com>
References: <20260202081456.4322-1-scott.k.mitch1@gmail.com>
 <20260203070740.62305-1-scott.k.mitch1@gmail.com>
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

From: Scott Mitchell <scott.k.mitch1@gmail.com>

Add txpollnotrdy devarg (default=true) to control whether poll()
is called when the TX ring is not ready. This allows users to
avoid blocking behavior if application threads are in asynchronous
poll mode where blocking the thread has negative side effects and
backpressure is applied via different means.

Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
---
 doc/guides/nics/af_packet.rst             |  6 ++++-
 doc/guides/rel_notes/release_26_03.rst    |  1 +
 drivers/net/af_packet/rte_eth_af_packet.c | 33 ++++++++++++++++++-----
 3 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/doc/guides/nics/af_packet.rst b/doc/guides/nics/af_packet.rst
index 1505b98ff7..782a962c3f 100644
--- a/doc/guides/nics/af_packet.rst
+++ b/doc/guides/nics/af_packet.rst
@@ -29,6 +29,10 @@ Some of these, in turn, will be used to configure the PACKET_MMAP settings.
 *   ``framesz`` - PACKET_MMAP frame size (optional, default 2048B; Note: multiple
     of 16B);
 *   ``framecnt`` - PACKET_MMAP frame count (optional, default 512).
+*   ``txpollnotrdy`` - Control behavior if tx is attempted but there is no
+    space available to write to the kernel. If 1, call poll() and block until
+    space is available to tx. If 0, don't call poll() and return from tx (optional,
+    default 1).
 
 For details regarding ``fanout_mode`` argument, you can consult the
 `PACKET_FANOUT documentation <https://www.man7.org/linux/man-pages/man7/packet.7.html>`_.
@@ -75,7 +79,7 @@ framecnt=512):
 
 .. code-block:: console
 
-    --vdev=eth_af_packet0,iface=tap0,blocksz=4096,framesz=2048,framecnt=512,qpairs=1,qdisc_bypass=0,fanout_mode=hash
+    --vdev=eth_af_packet0,iface=tap0,blocksz=4096,framesz=2048,framecnt=512,qpairs=1,qdisc_bypass=0,fanout_mode=hash,txpollnotrdy=0
 
 Features and Limitations
 ------------------------
diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index c7e7c7d25b..3b6be19645 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -59,6 +59,7 @@ New Features
 
   * Fixed kernel memory barrier protocol for memory availability
   * Fixed shared memory frame overhead offset calculation
+  * Added ``txpollnotrdy`` devarg to avoid ``poll()`` blocking calls
 
 Removed Items
 -------------
diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index 51ac95ff5e..9df1b1fd4c 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -39,9 +39,11 @@
 #define ETH_AF_PACKET_FRAMECOUNT_ARG	"framecnt"
 #define ETH_AF_PACKET_QDISC_BYPASS_ARG	"qdisc_bypass"
 #define ETH_AF_PACKET_FANOUT_MODE_ARG	"fanout_mode"
+#define ETH_AF_PACKET_TX_POLL_NOT_READY_ARG	"txpollnotrdy"
 
 #define DFLT_FRAME_SIZE		(1 << 11)
 #define DFLT_FRAME_COUNT	(1 << 9)
+#define DFLT_TX_POLL_NOT_RDY	true
 
 static const uint16_t eth_af_packet_frame_size_max = RTE_IPV4_MAX_PKT_LEN;
 #define ETH_AF_PACKET_FRAME_OVERHEAD (TPACKET2_HDRLEN - sizeof(struct sockaddr_ll))
@@ -78,6 +80,9 @@ struct __rte_cache_aligned pkt_tx_queue {
 	unsigned int framecount;
 	unsigned int framenum;
 
+	bool txpollnotrdy;
+	bool sw_cksum;
+
 	volatile unsigned long tx_pkts;
 	volatile unsigned long err_pkts;
 	volatile unsigned long tx_bytes;
@@ -106,6 +111,7 @@ static const char *valid_arguments[] = {
 	ETH_AF_PACKET_FRAMECOUNT_ARG,
 	ETH_AF_PACKET_QDISC_BYPASS_ARG,
 	ETH_AF_PACKET_FANOUT_MODE_ARG,
+	ETH_AF_PACKET_TX_POLL_NOT_READY_ARG,
 	NULL
 };
 
@@ -258,10 +264,12 @@ eth_af_packet_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	uint32_t num_tx_bytes = 0;
 	uint16_t i;
 
-	memset(&pfd, 0, sizeof(pfd));
-	pfd.fd = pkt_q->sockfd;
-	pfd.events = POLLOUT;
-	pfd.revents = 0;
+	if (pkt_q->txpollnotrdy) {
+		memset(&pfd, 0, sizeof(pfd));
+		pfd.fd = pkt_q->sockfd;
+		pfd.events = POLLOUT;
+		pfd.revents = 0;
+	}
 
 	framecount = pkt_q->framecount;
 	framenum = pkt_q->framenum;
@@ -291,8 +299,9 @@ eth_af_packet_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		 * This results in poll() returning POLLOUT.
 		 */
 		if (unlikely(!tx_ring_status_available(tpacket_read_status(&ppd->tp_status)) &&
-			(poll(&pfd, 1, -1) < 0 || (pfd.revents & POLLERR) != 0 ||
-			 !tx_ring_status_available(tpacket_read_status(&ppd->tp_status))))) {
+			(!pkt_q->txpollnotrdy || poll(&pfd, 1, -1) < 0 ||
+			(pfd.revents & POLLERR) != 0 ||
+			!tx_ring_status_available(tpacket_read_status(&ppd->tp_status))))) {
 			/* Ring is full, stop here. Don't process bufs[i]. */
 			break;
 		}
@@ -804,6 +813,7 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
                        unsigned int framecnt,
 		       unsigned int qdisc_bypass,
 		       const char *fanout_mode,
+			bool txpollnotrdy,
                        struct pmd_internals **internals,
                        struct rte_eth_dev **eth_dev,
                        struct rte_kvargs *kvlist)
@@ -1022,6 +1032,7 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
 			tx_queue->rd[i].iov_len = req->tp_frame_size;
 		}
 		tx_queue->sockfd = qsockfd;
+		tx_queue->txpollnotrdy = txpollnotrdy;
 
 		rc = bind(qsockfd, (const struct sockaddr*)&sockaddr, sizeof(sockaddr));
 		if (rc == -1) {
@@ -1111,6 +1122,7 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
 	unsigned int qpairs = 1;
 	unsigned int qdisc_bypass = 1;
 	const char *fanout_mode = NULL;
+	bool txpollnotrdy = DFLT_TX_POLL_NOT_RDY;
 
 	/* do some parameter checking */
 	if (*sockfd < 0)
@@ -1175,6 +1187,10 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
 			fanout_mode = pair->value;
 			continue;
 		}
+		if (strstr(pair->key, ETH_AF_PACKET_TX_POLL_NOT_READY_ARG) != NULL) {
+			txpollnotrdy = atoi(pair->value) != 0;
+			continue;
+		}
 	}
 
 	if (framesize > blocksize) {
@@ -1243,12 +1259,14 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
 		PMD_LOG(DEBUG, "%s:\tfanout mode %s", name, fanout_mode);
 	else
 		PMD_LOG(DEBUG, "%s:\tfanout mode %s", name, "default PACKET_FANOUT_HASH");
+	PMD_LOG(INFO, "%s:\ttxpollnotrdy %d", name, txpollnotrdy ? 1 : 0);
 
 	if (rte_pmd_init_internals(dev, *sockfd, qpairs,
 				   blocksize, blockcount,
 				   framesize, framecount,
 				   qdisc_bypass,
 				   fanout_mode,
+				   txpollnotrdy,
 				   &internals, &eth_dev,
 				   kvlist) < 0)
 		return -1;
@@ -1346,4 +1364,5 @@ RTE_PMD_REGISTER_PARAM_STRING(net_af_packet,
 	"framesz=<int> "
 	"framecnt=<int> "
 	"qdisc_bypass=<0|1> "
-	"fanout_mode=<hash|lb|cpu|rollover|rnd|qm>");
+	"fanout_mode=<hash|lb|cpu|rollover|rnd|qm> "
+	"txpollnotrdy=<0|1>");
-- 
2.39.5 (Apple Git-154)

