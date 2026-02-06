Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4482AECD9B0
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Feb 2026 01:12:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D7F340430;
	Fri,  6 Feb 2026 02:12:32 +0100 (CET)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177]) by mails.dpdk.org (Postfix) with ESMTP id 45AE340430
 for <dev@dpdk.org>; Fri,  6 Feb 2026 02:12:31 +0100 (CET)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-2b8392fb4dcso1617198eec.0
 for <dev@dpdk.org>; Thu, 05 Feb 2026 17:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770340350; x=1770945150; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/IpzyO0BwV9hdXB2wx6CJ6/wPANjvXFkl7vC3tG4rbE=;
 b=cG2Dvht9shrk0XFfWw2Wsn3MkNgj4VW1I45vaZj8lsL0EG3jM63Ma82+ANCvP0E7du
 Pk+itQJUBWFD4EvFAUOWFIqrB+G7y+SeZRBEYo4vOaAMP9ac+WwJ9kp6d0xw8StzMqXJ
 32oMQR9CwhuQSrnqqxUi7eq/L8IfEFhyRQXBeTwF3ur31IoLa/mJQddDANSDBpq7OlEo
 fCnrPQIw3gpSU2/qybpJ0e231U3Y2eA5qa6QeocbTl6mbLt9FO31A8zyX6ydwSDEn5fP
 Hi74vTROFnbehTG4Z6yiVXT5eAY45/yNVMB3W2Bd2OhMXzZnRAD2iVfh6UdbhE9MsDxs
 Y5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770340350; x=1770945150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/IpzyO0BwV9hdXB2wx6CJ6/wPANjvXFkl7vC3tG4rbE=;
 b=ZQguwETZMBPevRAHjwFPxHdTeq6ACUEfh7+m8omy6RAaSa1VdCMOWV3+9e6LxwlJzH
 Zi0wu6Na9HCJEsb+pEeYuwKM4dyZ4mgzSAkSbyR2qqoZm3ifdSJzjTXEEg+LuX5EmqQu
 1Z7CJMSQ5QLbS0TNionUBxH0WLRNkgNyNZxAdW69cyoY1OiOGB0Z8iZxH1G1+wulrtfk
 vdfrq8ukq5rW2ImlSZ4tDGeg7QSm8InESInA+PwgHINbJrF8FTM/OYgv12O5W+Et8Ikp
 SKqoiszdooSx1DIj/iJeZfK6BAhIKRpPJIJQs7Bbas258N66yQcxAIn/vPwEnr9RWx8e
 DJAw==
X-Gm-Message-State: AOJu0Yw81JISaCm2j/hY/oHf0fhMzHRgvXq27oKkrznJJcgVFfJrMZv7
 cnD4nvfFK78aVZtsdtVVZvcrXvXJFssWMTMyVe6siAe6FmmwkrOs3zr/V1h26Q==
X-Gm-Gg: AZuq6aKq3xUnn83gYMZwKqrGMrTjHdj+yi+iaVw+87Tr9u2ZKoaijF4qPmpOFRP32fG
 XyoyHc0TVvv2JbwbhZBkHR05y7ezR9ajEj3LD/p/+1rqiHnTnUA98prDOnC9AcK3nh42F2IUEGx
 8w1sjIBS4Y4nmkb1KGiDxo4aoP4e19adQEYTKp6xG52BAMWlEcWS0n/Wuagp6YlIPGlVYnFrMxR
 TVNZJYDDkuMhP4yYabMhFk+XEo4Y74kgH2Smy+GxzsK2ZXx+kL5ScH8351gvkBTpe3trYRlT14f
 ihjgbMVpWFZXoocmvpkmDyvy+teDHZc4paYJMYPtRjphvyXip2HQ/5S+KDITS8ZWzAOp30jsCbY
 g6um9p1rRj4PL73GV51dMzkmTLkoEcoBYndGBSvrkkeZZrKrGl6ipBxcKhZ6+HfdzVLnRaOtXEs
 mcH+OsuRGfg3Yu2qQoCLf2rzB4I48yFcxI3Z2uJBmAlL9pbv0ruF3v
X-Received: by 2002:a05:693c:3117:b0:2b7:2d5e:914d with SMTP id
 5a478bee46e88-2b8563d8ba2mr546322eec.9.1770340350036; 
 Thu, 05 Feb 2026 17:12:30 -0800 (PST)
Received: from mr41p01nt-relayp03.apple.com ([216.157.103.139])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b855afc852sm711730eec.13.2026.02.05.17.12.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Feb 2026 17:12:29 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: stephen@networkplumber.org,
	Scott Mitchell <scott.k.mitch1@gmail.com>
Subject: [PATCH v6 3/4] net/af_packet: tx poll control
Date: Thu,  5 Feb 2026 17:11:40 -0800
Message-Id: <20260206011141.2377-4-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260206011141.2377-1-scott.k.mitch1@gmail.com>
References: <20260203070740.62305-1-scott.k.mitch1@gmail.com>
 <20260206011141.2377-1-scott.k.mitch1@gmail.com>
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
index 5eebed5023..6a173e2e82 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -59,6 +59,7 @@ New Features
 
   * Fixed kernel memory barrier protocol for memory availability
   * Fixed shared memory frame overhead offset calculation
+  * Added ``txpollnotrdy`` devarg to avoid ``poll()`` blocking calls
 
 * **Updated AMD axgbe ethernet driver.**
 
diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index 9acce990d1..07e7e3cd4a 100644
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

