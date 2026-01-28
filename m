Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7D5D46BF4
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 19:12:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04753406BB;
	Wed, 28 Jan 2026 20:12:29 +0100 (CET)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180]) by mails.dpdk.org (Postfix) with ESMTP id 72A1D406A2
 for <dev@dpdk.org>; Wed, 28 Jan 2026 20:12:26 +0100 (CET)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-2b4520f6b32so483851eec.0
 for <dev@dpdk.org>; Wed, 28 Jan 2026 11:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769627545; x=1770232345; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YQD+UZnE/x+JI78VtpePZq9iPel0TiL+1/Swo8B8MJw=;
 b=ZXMUlzzfxpbkwktSQ2YmxLOeHZeS95X2XDVHjoHDs6oz4AmoFZyOiCGUOvJDIcDBKv
 8POjCsLRER3zYMD0ebcmCWfsO3vnBw8ZkcO4n2qjNBwHOixPqDgb5IQzbmq/Y+gZLbfX
 uegwBRWLq2//XlBbodf4pRHdMcgf4y/53a5mkhdmCMfp73Xyf3FRu+michmIVa7G9B8d
 viP20GQhoS/bz+gtr0upc0raNbP3IYJub4dlA1awJ6UpxB5Rvu4n5L3Nxk2kfQUQpNkB
 9uK4E8BTjGAIarYjw2aN+DIJguBHsK8rAUTUnBWwMEA+r/28Sg0GRhRS0S7X97SOMdZ5
 y2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769627545; x=1770232345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YQD+UZnE/x+JI78VtpePZq9iPel0TiL+1/Swo8B8MJw=;
 b=itVe3iZV32d7D8gxtqGohy5yXXX40W43+a5utaFD5iXXiuLv6v3iSuRcn9D1PReHyt
 +6Y7W8X00wUSQ4Ak/V2darHsnVoCUR0Si8EEWQuahdRoVxTqZ5GAe9A4hI3Vtkwp1L63
 Ne341B8Qu7uSs/ShErvfQdEJHGIy+uMoI53405tpnFI4BjLGrfOfZv2Wt097L4m5sX7s
 bjqRzQ+J84Gh8Qi6jjv6c2hagNf8b/3JlC8JOZebt+ktx767hO03o99PW1OrNGkBbDbI
 FDk36Aiu8GkDXgyTf+cxCc+MV5squ1dwBBo9PmVinEDRqVSdWNMQRVMbWcfZBgDMT9bJ
 LLAw==
X-Gm-Message-State: AOJu0Yw6kpaVNWr4vhRhhaV3M7bZCsFNIe5Gp789xmCnf4hqvuL0M50i
 CoZmsc2OFBhzdf7DowsmbItj/C9dX7pladbVwgX/Xw/h4SDV+wlUa//ut6e6NA==
X-Gm-Gg: AZuq6aIUr05NSk8VwRwDJkmqAknlPOJDTU3Zl48JD3fXfbRMc5U/fjLKLAg4nYbSHBN
 tBUkLLsxu4Xk2sxqg6SVztRX3vOfPoGpctlg6w3QFKUmyLO5w2Ru5P9b35+GAxTUQdymDinKVgh
 xTZg50u5YAO0ZpFtTTsstW3ngT1bzFx9sTZ3G9jociFQIO1i8vT8lAT5cezwymkhpxLuF/B/dy7
 1rdhrREIvEAvmcWCgPj6y9+3BLWojgDuLLNs7ttkPejSOs6MAu9bFgxHCXyV1BpDc5G2Rcj5rEk
 oLhUSZe0Xmxo+D3EwkQojzxn0ymoYp9iF+mv0dm946owuHz9j7jwatBfVqt6k7vRLmQdOFgfWmM
 +8TbNBHlPy3flUAIPfgXRv28SppozOpiTx2fqwBi0ifb49ZEoaC6KF7k3zWHuYD+tq7tWRbP3AU
 jX9JJG7GZUzUXuKOpK+C/0Gq1Gn2jpEfiZIqcgLaitu5JxRykp8A==
X-Received: by 2002:a05:7300:dc14:b0:2ae:5ad4:718d with SMTP id
 5a478bee46e88-2b78da0e059mr3852142eec.43.1769627545242; 
 Wed, 28 Jan 2026 11:12:25 -0800 (PST)
Received: from mr41p01nt-relayp04.apple.com ([17.199.85.102])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b7a1adc5ecsm4261286eec.24.2026.01.28.11.12.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Jan 2026 11:12:24 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: stephen@networkplumber.org,
	Scott Mitchell <scott.k.mitch1@gmail.com>
Subject: [PATCH v3 3/4] net/af_packet: tx poll control
Date: Wed, 28 Jan 2026 11:10:31 -0800
Message-Id: <20260128191032.78916-4-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260128191032.78916-1-scott.k.mitch1@gmail.com>
References: <20260128093607.62908-1-scott.k.mitch1@gmail.com>
 <20260128191032.78916-1-scott.k.mitch1@gmail.com>
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
 doc/guides/nics/af_packet.rst             |  6 +++-
 drivers/net/af_packet/rte_eth_af_packet.c | 34 ++++++++++++++++++-----
 2 files changed, 32 insertions(+), 8 deletions(-)

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
diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index e357ae168b..be8e3260aa 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -18,6 +18,7 @@
 #include <bus_vdev_driver.h>
 
 #include <errno.h>
+#include <stdbool.h>
 #include <linux/if_ether.h>
 #include <linux/if_packet.h>
 #include <arpa/inet.h>
@@ -39,9 +40,11 @@
 #define ETH_AF_PACKET_FRAMECOUNT_ARG	"framecnt"
 #define ETH_AF_PACKET_QDISC_BYPASS_ARG	"qdisc_bypass"
 #define ETH_AF_PACKET_FANOUT_MODE_ARG	"fanout_mode"
+#define ETH_AF_PACKET_TX_POLL_NOT_READY_ARG	"txpollnotrdy"
 
 #define DFLT_FRAME_SIZE		(1 << 11)
 #define DFLT_FRAME_COUNT	(1 << 9)
+#define DFLT_TX_POLL_NOT_RDY	true
 
 static const uint16_t ETH_AF_PACKET_FRAME_SIZE_MAX = RTE_IPV4_MAX_PKT_LEN;
 #define ETH_AF_PACKET_FRAME_OVERHEAD (TPACKET2_HDRLEN - sizeof(struct sockaddr_ll))
@@ -78,6 +81,9 @@ struct __rte_cache_aligned pkt_tx_queue {
 	unsigned int framecount;
 	unsigned int framenum;
 
+	bool txpollnotrdy;
+	bool sw_cksum;
+
 	volatile unsigned long tx_pkts;
 	volatile unsigned long err_pkts;
 	volatile unsigned long tx_bytes;
@@ -106,6 +112,7 @@ static const char *valid_arguments[] = {
 	ETH_AF_PACKET_FRAMECOUNT_ARG,
 	ETH_AF_PACKET_QDISC_BYPASS_ARG,
 	ETH_AF_PACKET_FANOUT_MODE_ARG,
+	ETH_AF_PACKET_TX_POLL_NOT_READY_ARG,
 	NULL
 };
 
@@ -265,10 +272,12 @@ eth_af_packet_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
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
@@ -308,8 +317,9 @@ eth_af_packet_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
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
@@ -820,6 +830,7 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
                        unsigned int framecnt,
 		       unsigned int qdisc_bypass,
 		       const char *fanout_mode,
+		       bool txpollnotrdy,
                        struct pmd_internals **internals,
                        struct rte_eth_dev **eth_dev,
                        struct rte_kvargs *kvlist)
@@ -1038,6 +1049,7 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
 			tx_queue->rd[i].iov_len = req->tp_frame_size;
 		}
 		tx_queue->sockfd = qsockfd;
+		tx_queue->txpollnotrdy = txpollnotrdy;
 
 		rc = bind(qsockfd, (const struct sockaddr*)&sockaddr, sizeof(sockaddr));
 		if (rc == -1) {
@@ -1126,6 +1138,7 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
 	unsigned int qpairs = 1;
 	unsigned int qdisc_bypass = 1;
 	const char *fanout_mode = NULL;
+	bool txpollnotrdy = DFLT_TX_POLL_NOT_RDY;
 
 	/* do some parameter checking */
 	if (*sockfd < 0)
@@ -1193,6 +1206,10 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
 			fanout_mode = pair->value;
 			continue;
 		}
+		if (strstr(pair->key, ETH_AF_PACKET_TX_POLL_NOT_READY_ARG) != NULL) {
+			txpollnotrdy = atoi(pair->value) != 0;
+			continue;
+		}
 	}
 
 	if (framesize > blocksize) {
@@ -1261,12 +1278,14 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
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
@@ -1364,4 +1383,5 @@ RTE_PMD_REGISTER_PARAM_STRING(net_af_packet,
 	"framesz=<int> "
 	"framecnt=<int> "
 	"qdisc_bypass=<0|1> "
-	"fanout_mode=<hash|lb|cpu|rollover|rnd|qm>");
+	"fanout_mode=<hash|lb|cpu|rollover|rnd|qm> "
+	"txpollnotrdy=<0|1>");
-- 
2.39.5 (Apple Git-154)

