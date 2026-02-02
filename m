Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76244E73140
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 08:15:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F22DA40A87;
	Mon,  2 Feb 2026 09:15:05 +0100 (CET)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170]) by mails.dpdk.org (Postfix) with ESMTP id F3FBA40A72
 for <dev@dpdk.org>; Mon,  2 Feb 2026 09:15:03 +0100 (CET)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-2b785801c93so11479584eec.0
 for <dev@dpdk.org>; Mon, 02 Feb 2026 00:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770020103; x=1770624903; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sHhyAp+/WUPlHm5QkFRDDgGGYrTrNAs0zLjjxLGEw+s=;
 b=dbeZt63BcXfRjUE57SWeiQotmVy0Iojp5vIjanT/M3s8k865lCddLX+wa0DMlAVE7g
 HtOCoX6pAf75DBniRmLI5ektAl+kWJf0JTcREEh7+4qinwEhik+dwnWcgS/jztvW1DF4
 hzB/6/QND9Lj0IYqbr8hveIU3oRAvTLRTaX+VDoEqYFldt1XQxYGvKxPfqsoY1jpTUIh
 Qc+GftTB6tjigRih+zv3MII8H/XzVdcsXro70d8f7aM60UTsVrfUGcHP5v0N4u8Q9VMU
 n4HVTgZeL9CYRclsaOJS7OrfFAfdidNUFgZHeOyc15nqV7MBZu9H3oh9OVv87aUQSvuY
 HpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770020103; x=1770624903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sHhyAp+/WUPlHm5QkFRDDgGGYrTrNAs0zLjjxLGEw+s=;
 b=taJB+OuVIV87iu6exZRHFuBidyulKTGpj2TZLvD/JEW41grO0rNCjRjdQe+qA7EMtq
 BUZinPE3hEuCxvr1OdLv6WnIxuFIvl3geyFJmFkj2Caq7bY8h5wczFPn5fEkk+dPYMTM
 a1d5fcpvO/qPB+Ce0iPB4V73ygXXdSUEDbnegNWWkqfILLUS/YamwkSvUK75qV4MBFFL
 Y/tf93WLTrVPOzm83b8fp88SWz/P8mdUEaafZx7MVm6piZ2rM7+l6S7CeA2XJ9Tgs+9S
 LF8Cx8M1bd/2+qSLK8Rc8z+cUQcbsBjv+XpKW/58GoSOOsLP3yL5/3k1EOc5XJSOcLcZ
 5gAA==
X-Gm-Message-State: AOJu0YxhTXapQnKZyq4UUY6BPANdIQbDqjchd5hckCQGuED8B8wVZDT8
 SXOMF47PlLYhdd5BLTN57CBijjv7UNUxsSkszfNDP6bo4V9rK1+RYrk0ZNhFaA==
X-Gm-Gg: AZuq6aJ8IxM8JomGBsT812TAkPJDe05C4BkrrmUVPNTk97G1bYrI9C2K5uB1oUYvMDA
 F2WVMEX2/UblG8koq7RY+PaqSDNtSyCqpKE+0+WkSkY2OJu431ZSGxsMazHg3s6YBLK8LYWMW5R
 cwj3Z9Gg0MmBRex5q7zot6Ofucky4X9xzQ25n2ZS/BqY1+RUMkD/GO6q+mAciUcEEFQiQfRedFj
 jpDUGW6vE9dGwwxa9Bod/HPHYN9DOuAv/lvpaTlrVboFbzOSH7iDXJiIyKUAJgnyIKRK1bbfzXl
 CtfWMCbzyd3MvnZFP2fPw1yqgD5iL7AjRZsgl51DrqIi39JFJqDYDcC5fwnOBrnPP/EC09hU4qO
 6Crd+gKw7F1Uyhc/IhYgsOV5Yn1pomWSEwchGW/TXfZLxLOKCvFBtUIX7KNeEimxBJLaBrjm16S
 UzaN73ucZ++npu3iLF6izYZw==
X-Received: by 2002:a05:693c:2d85:b0:2b7:4157:9cec with SMTP id
 5a478bee46e88-2b7c88d959emr4175219eec.26.1770020102625; 
 Mon, 02 Feb 2026 00:15:02 -0800 (PST)
Received: from mac.com ([136.24.82.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-124a9d7f597sm17142131c88.5.2026.02.02.00.15.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 00:15:02 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: stephen@networkplumber.org,
	Scott Mitchell <scott.k.mitch1@gmail.com>
Subject: [PATCH v4 3/4] net/af_packet: tx poll control
Date: Mon,  2 Feb 2026 00:14:55 -0800
Message-Id: <20260202081456.4322-4-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260202081456.4322-1-scott.k.mitch1@gmail.com>
References: <20260128191032.78916-1-scott.k.mitch1@gmail.com>
 <20260202081456.4322-1-scott.k.mitch1@gmail.com>
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

