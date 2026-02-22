Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8A6C636A1
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Feb 2026 17:34:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC41740A87;
	Sun, 22 Feb 2026 18:32:59 +0100 (CET)
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com
 [209.85.160.43]) by mails.dpdk.org (Postfix) with ESMTP id CC22A40684
 for <dev@dpdk.org>; Sun, 22 Feb 2026 18:32:45 +0100 (CET)
Received: by mail-oa1-f43.google.com with SMTP id
 586e51a60fabf-41576c5c01cso1065422fac.3
 for <dev@dpdk.org>; Sun, 22 Feb 2026 09:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771781565;
 x=1772386365; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=102cW3DZgOteUVp4vfFWmQ9aDmc7ydz34iwdzNryqPA=;
 b=0tG/uGRNbOF/DXldYtb+4ZT2sPcyHQo2glPpX0psg3iAzOa4w6+byCIeAq8W/alRZG
 39dEk4ZCRdtrRpavIaPiZnnMG93TVTWX31S/bcXb6kv+ZHyiYQMMK3PLFcrrcfBauHSd
 8vo+qgDixSgvbbKVm/KThlwfPly8gPBvgdGpzA2pdgJvObboZeZ3bIHIBJ82rFGwEoTP
 2Lcon4sYYuLF+MrX6h6/VGIIrJVyEh3uD7NblDjarfrziIXfjENCC+tuta2/rUVsd7vf
 yBgJVIRbDgHe+FxUE1osMPalutFYJoNgbvtN+YO9cVFDZ1DYfCYIRxk39wl2+ld0eh3k
 0VCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771781565; x=1772386365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=102cW3DZgOteUVp4vfFWmQ9aDmc7ydz34iwdzNryqPA=;
 b=xSSi8ozsMx8C9GSjvFKrS48oSLAZg6kIFn7U2dgj/LQYtl8pm5Hzypel4KQwJE2Jhs
 gk5krCGzgb8YO+39nU7qdCoz77C17Lep4lQdhGavOD9yjrDbJOUgdCBDfxKawNbYzLXk
 NGpnsVjyapr7zFq4gbZgzaNVyaDTF/tYJElXzevXMdiZ0u5wMyiwASBMiBxH9PlRVsoq
 1WYK0JateNy/6oPpb2isEE0k6AYM83kjlSqa1njdBql8GSVOTnCAP8PY1kDtRt92o+lm
 2zhB83jDo47+XrMbJmYJUL29u0Xuk/Q4RHRS/C8M3/ilgelOKV4oYMBS9+70QPVRwPiC
 tTcw==
X-Gm-Message-State: AOJu0YwLUciwaq4d7y8yUWbtKHAn02iEks/1CJUjWM/m/6MqKMFRZxuw
 IxPNEaRXYQDxrMDeVJx5Ue6pnzoe+2VQzG/VlgHiCIfr48nJlRhnPWG1mB6DbAuWr/bObmKTkED
 PxhuT
X-Gm-Gg: AZuq6aL+8LFbtukHCgErNd7et3b61jrX6RQ6S79HSPy5h5/hcB/cUQA1+M5I6Rsa9md
 QUsvqlxn1d9Dqlu1Ai+EppZAuMKdnvBlv2Tbw4ZW5CUr8ACRDH+TBQevG/gwhVKBL89XuWPSXeC
 3uJpXTnuj++sBVQNieLyFdnseN9/Ufm7Gu+yreCQb3o7OOsJxa6qChlxtUv+6R/8475bpmi91sm
 nILd1xWzpkLufmXT4FCtY5R05jTBXZnSNme7Oy76aiNWjmPxcViPx6BrNFY/ylHAZOtzmsO7IB9
 zTw+1hVL6XbG2m6qISyFfS0LjvRkpLk9wongQDYYsl0qSGqbruFFcVGpqyV5wjvHhW5Nbf+vA2A
 Iw36urz8UqdjPJc/axG1bBwvkGfXFKlIhKpEFliidZQ8hWXnPHSU3/oP0VhsFnAzf0hxFOB68N7
 thotDdzOrzweusVYtbXPh/RXNYQQehk4wCtMc47jzIZOTP3Xk93A83nsWEZj2AMw==
X-Received: by 2002:a05:6870:164c:b0:40e:e642:ad56 with SMTP id
 586e51a60fabf-4157b13cbabmr3815520fac.45.1771781565038; 
 Sun, 22 Feb 2026 09:32:45 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157d2d7922sm5608972fac.12.2026.02.22.09.32.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 09:32:44 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 15/19] net/tap: fix Rx descriptor vs scatter segment
 confusion
Date: Sun, 22 Feb 2026 09:30:50 -0800
Message-ID: <20260222173225.522754-16-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260222173225.522754-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260222173225.522754-1-stephen@networkplumber.org>
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

The TAP PMD was reusing the nb_rx_desc queue setup parameter to control
the maximum number of scatter segments per received packet. Since the
driver reads one packet at a time from the kernel fd via readv(), it has
no descriptor ring and nb_rx_desc as a queue depth has no meaning here.
This meant applications could inadvertently affect scatter receive
behavior by changing the queue size parameter.

Compute the required number of scatter segments from the MTU and the
mempool buffer size instead, capping at TAP_MAX_RX_SEGS (128). The
nb_rx_desc parameter is now ignored.

While here, convert the iovecs pointer-to-VLA in struct rx_queue to a
flexible array member. This eliminates the separate iovec allocation,
removes the on-stack VLA from queue setup, reduces pointer indirection
on the receive path, and simplifies all cleanup paths to a single free.

Replace the runtime sysconf(_SC_IOV_MAX) check with a compile-time
static_assert against IOV_MAX from limits.h.

This is a bug fix, but too big a change to backport to earlier
releases.

Fixes: 0781f5762cfe ("net/tap: support segmented mbufs")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/tap/rte_eth_tap.c | 111 ++++++++++++++++++++--------------
 drivers/net/tap/rte_eth_tap.h |   4 +-
 2 files changed, 66 insertions(+), 49 deletions(-)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index 75fa517ae2..f2cf7da736 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -35,6 +35,7 @@
 #include <linux/if_tun.h>
 #include <linux/sched.h>
 #include <fcntl.h>
+#include <limits.h>
 
 #include <tap_rss.h>
 #include <rte_eth_tap.h>
@@ -69,7 +70,17 @@
 
 static_assert(RTE_PMD_TAP_MAX_QUEUES <= RTE_MP_MAX_FD_NUM, "TAP max queues exceeds MP fd limit");
 
-#define TAP_IOV_DEFAULT_MAX 1024
+/*
+ * Upper bound on the number of scatter segments per received packet.
+ * Actual value is computed at queue setup from MTU and mbuf data size.
+ * One extra iovec slot is reserved for the tun_pi header, so the total
+ * iovec count passed to readv() is max_rx_segs + 1, which must not
+ * exceed IOV_MAX.
+ */
+#define TAP_MAX_RX_SEGS 128
+
+static_assert(TAP_MAX_RX_SEGS + 1 <= IOV_MAX,
+	      "TAP_MAX_RX_SEGS + 1 (for tun_pi) must not exceed IOV_MAX");
 
 #define TAP_RX_OFFLOAD (RTE_ETH_RX_OFFLOAD_SCATTER |	\
 			RTE_ETH_RX_OFFLOAD_IPV4_CKSUM |	\
@@ -444,9 +455,7 @@ pmd_rx_burst(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		int len;
 
 		len = readv(process_private->fds[rxq->queue_id],
-			*rxq->iovecs,
-			1 + (rxq->rxmode->offloads & RTE_ETH_RX_OFFLOAD_SCATTER ?
-			     rxq->nb_rx_desc : 1));
+			    rxq->iovecs,  1 + rxq->max_rx_segs);
 		if (len < (int)sizeof(struct tun_pi))
 			break;
 
@@ -483,9 +492,9 @@ pmd_rx_burst(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			new_tail->next = seg->next;
 
 			/* iovecs[0] is reserved for packet info (pi) */
-			(*rxq->iovecs)[mbuf->nb_segs].iov_len =
+			rxq->iovecs[mbuf->nb_segs].iov_len =
 				buf->buf_len - data_off;
-			(*rxq->iovecs)[mbuf->nb_segs].iov_base =
+			rxq->iovecs[mbuf->nb_segs].iov_base =
 				(char *)buf->buf_addr + data_off;
 
 			seg->data_len = RTE_MIN(seg->buf_len - data_off, len);
@@ -1049,7 +1058,6 @@ tap_dev_close(struct rte_eth_dev *dev)
 
 		if (rxq != NULL) {
 			tap_rxq_pool_free(rxq->pool);
-			rte_free(rxq->iovecs);
 			rte_free(rxq);
 			dev->data->rx_queues[i] = NULL;
 		}
@@ -1115,7 +1123,6 @@ tap_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
 	process_private = rte_eth_devices[rxq->in_port].process_private;
 
 	tap_rxq_pool_free(rxq->pool);
-	rte_free(rxq->iovecs);
 
 	if (dev->data->tx_queues[qid] == NULL)
 		tap_queue_close(process_private, qid);
@@ -1495,7 +1502,7 @@ tap_setup_queue(struct rte_eth_dev *dev,
 static int
 tap_rx_queue_setup(struct rte_eth_dev *dev,
 		   uint16_t rx_queue_id,
-		   uint16_t nb_rx_desc,
+		   uint16_t nb_rx_desc __rte_unused,
 		   unsigned int socket_id,
 		   const struct rte_eth_rxconf *rx_conf __rte_unused,
 		   struct rte_mempool *mp)
@@ -1504,30 +1511,51 @@ tap_rx_queue_setup(struct rte_eth_dev *dev,
 	struct pmd_process_private *process_private = dev->process_private;
 	struct rx_queue *rxq;
 	struct rte_mbuf **tmp;
-	long iov_max = sysconf(_SC_IOV_MAX);
+	uint16_t max_rx_segs;
+	const uint32_t max_rx_pktlen = dev->data->mtu + RTE_ETHER_HDR_LEN + RTE_ETHER_CRC_LEN;
+	const uint16_t seg_size = rte_pktmbuf_data_room_size(mp);
+	uint16_t data_off = RTE_PKTMBUF_HEADROOM;
+	int ret = 0;
 
-	if (iov_max <= 0) {
-		TAP_LOG(WARNING,
-			"_SC_IOV_MAX is not defined. Using %d as default",
-			TAP_IOV_DEFAULT_MAX);
-		iov_max = TAP_IOV_DEFAULT_MAX;
+	/*
+	 * The nb_rx_desc parameter is ignored: the TAP PMD reads one packet
+	 * at a time from the kernel fd, so there is no descriptor ring.
+	 *
+	 * Compute the number of scatter segments needed to receive the
+	 * largest possible packet (MTU + L2 overhead).  The first segment
+	 * has headroom reserved, subsequent segments use the full data area.
+	 */
+	if (seg_size <= RTE_PKTMBUF_HEADROOM) {
+		TAP_LOG(ERR, "%s: mbuf pool has no usable data room", dev->device->name);
+		return -EINVAL;
 	}
-	uint16_t nb_desc = RTE_MIN(nb_rx_desc, iov_max - 1);
-	struct iovec (*iovecs)[nb_desc + 1];
-	int data_off = RTE_PKTMBUF_HEADROOM;
-	int ret = 0;
-	int fd;
-	int i;
 
-	if (rx_queue_id >= dev->data->nb_rx_queues || !mp) {
+	const uint16_t first_seg_size = seg_size - RTE_PKTMBUF_HEADROOM;
+	if (max_rx_pktlen > first_seg_size)
+		max_rx_segs = 1 + (max_rx_pktlen - first_seg_size + seg_size - 1) /
+				   seg_size;
+	else
+		max_rx_segs = 1;
+
+	if (max_rx_segs > TAP_MAX_RX_SEGS) {
+		TAP_LOG(ERR,
+			"%s: MTU %u requires %u scatter segments, max is %u",
+			dev->device->name, dev->data->mtu,
+			max_rx_segs, TAP_MAX_RX_SEGS);
+		return -EINVAL;
+	}
+
+	if (max_rx_segs > 1 &&
+	    !(dev->data->dev_conf.rxmode.offloads & RTE_ETH_RX_OFFLOAD_SCATTER)) {
+		/* non-fatal since applications might be doing it wrong now */
 		TAP_LOG(WARNING,
-			"nb_rx_queues %d too small or mempool NULL",
-			dev->data->nb_rx_queues);
-		return -1;
+			"%s: MTU %u requires %u scatter segments, but offload not set",
+			dev->device->name, dev->data->mtu, max_rx_segs);
 	}
 
-	rxq = rte_zmalloc_socket(dev->device->name, sizeof(*rxq), 0,
-				  socket_id);
+	rxq = rte_zmalloc_socket(dev->device->name,
+				 sizeof(*rxq) + (max_rx_segs + 1) * sizeof(struct iovec),
+				 RTE_CACHE_LINE_SIZE, socket_id);
 	if (!rxq) {
 		TAP_LOG(ERR,
 			"%s: Couldn't allocate rx queue structure",
@@ -1540,30 +1568,20 @@ tap_rx_queue_setup(struct rte_eth_dev *dev,
 	rxq->trigger_seen = 1; /* force initial burst */
 	rxq->in_port = dev->data->port_id;
 	rxq->queue_id = rx_queue_id;
-	rxq->nb_rx_desc = nb_desc;
+	rxq->max_rx_segs = max_rx_segs;
 	rxq->rxmode = &dev->data->dev_conf.rxmode;
-	iovecs = rte_zmalloc_socket(dev->device->name, sizeof(*iovecs), 0,
-				    socket_id);
-	if (!iovecs) {
-		TAP_LOG(WARNING,
-			"%s: Couldn't allocate %d RX descriptors",
-			dev->device->name, nb_desc);
-		rte_free(rxq);
-		return -ENOMEM;
-	}
-	rxq->iovecs = iovecs;
 
 	dev->data->rx_queues[rx_queue_id] = rxq;
-	fd = tap_setup_queue(dev, rx_queue_id, 1);
+	int fd = tap_setup_queue(dev, rx_queue_id, 1);
 	if (fd == -1) {
 		ret = fd;
 		goto error;
 	}
 
-	(*rxq->iovecs)[0].iov_len = sizeof(struct tun_pi);
-	(*rxq->iovecs)[0].iov_base = &rxq->pi;
+	rxq->iovecs[0].iov_len = sizeof(struct tun_pi);
+	rxq->iovecs[0].iov_base = &rxq->pi;
 
-	for (i = 1; i <= nb_desc; i++) {
+	for (uint16_t i = 1; i <= max_rx_segs; i++) {
 		*tmp = rte_pktmbuf_alloc(rxq->mp);
 		if (!*tmp) {
 			TAP_LOG(WARNING,
@@ -1572,8 +1590,8 @@ tap_rx_queue_setup(struct rte_eth_dev *dev,
 			ret = -ENOMEM;
 			goto error;
 		}
-		(*rxq->iovecs)[i].iov_len = (*tmp)->buf_len - data_off;
-		(*rxq->iovecs)[i].iov_base =
+		rxq->iovecs[i].iov_len = (*tmp)->buf_len - data_off;
+		rxq->iovecs[i].iov_base =
 			(char *)(*tmp)->buf_addr + data_off;
 		data_off = 0;
 		tmp = &(*tmp)->next;
@@ -1592,7 +1610,6 @@ tap_rx_queue_setup(struct rte_eth_dev *dev,
 
 error:
 	tap_rxq_pool_free(rxq->pool);
-	rte_free(rxq->iovecs);
 	rte_free(rxq);
 	dev->data->rx_queues[rx_queue_id] = NULL;
 	return ret;
@@ -1614,8 +1631,8 @@ tap_tx_queue_setup(struct rte_eth_dev *dev,
 	if (tx_queue_id >= dev->data->nb_tx_queues)
 		return -1;
 
-	txq = rte_zmalloc_socket(dev->device->name, sizeof(*txq), 0,
-				  socket_id);
+	txq = rte_zmalloc_socket(dev->device->name, sizeof(*txq),
+				 RTE_CACHE_LINE_SIZE, socket_id);
 	if (!txq) {
 		TAP_LOG(ERR,
 			"%s: Couldn't allocate tx queue structure",
diff --git a/drivers/net/tap/rte_eth_tap.h b/drivers/net/tap/rte_eth_tap.h
index 365d5a5fe1..78182b1185 100644
--- a/drivers/net/tap/rte_eth_tap.h
+++ b/drivers/net/tap/rte_eth_tap.h
@@ -49,11 +49,11 @@ struct rx_queue {
 	uint16_t in_port;               /* Port ID */
 	uint16_t queue_id;		/* queue ID*/
 	struct pkt_stats stats;         /* Stats for this RX queue */
-	uint16_t nb_rx_desc;            /* max number of mbufs available */
+	uint16_t max_rx_segs;           /* max scatter segments per packet */
 	struct rte_eth_rxmode *rxmode;  /* RX features */
 	struct rte_mbuf *pool;          /* mbufs pool for this queue */
-	struct iovec (*iovecs)[];       /* descriptors for this queue */
 	struct tun_pi pi;               /* packet info for iovecs */
+	struct iovec iovecs[];          /* iov[0] = pi, iov[1..max_rx_segs] = data */
 };
 
 struct tx_queue {
-- 
2.51.0

