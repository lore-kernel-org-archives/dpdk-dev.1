Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7539C282EC
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 23:55:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD41640664;
	Wed, 12 Mar 2025 00:54:49 +0100 (CET)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id 27D2240264
 for <dev@dpdk.org>; Wed, 12 Mar 2025 00:54:45 +0100 (CET)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-223378e2b0dso89238865ad.0
 for <dev@dpdk.org>; Tue, 11 Mar 2025 16:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741737284;
 x=1742342084; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5n0aon1vJTyaj8UoDGi4nTsxL9gC3qY4k42vM5vrfwM=;
 b=KtEm5LYtAR1CYDxO8AP8xmBMB9geuMaqLn3ycp6RY5NCw7HVrRT0RWDtolKwKO6DLK
 EAR9Rb+ZWbITewOUwHI15omSYA2fWptDAVnkcP/lp8hnX0PbMT28B1shcX6sNf6Zph0v
 bnoc+7MYfd6Gq5Lc841NBElBhRg5Ygkz0Ox+4lSqeVIVktzBBnD/HqR3zfLDTAMkhi+r
 zMvi7ixp7woveAb6axV3PdzRPbWtBScA7afrOY4rSwvnPodGA8iLg84/jBR10h1Rw+xI
 XYyoPxP2y0f8OTXP0Kshc2Wwa5diLDV4kgzfKFkWDdVIGCjTFdUn0MUJ6CxXhOn0HHQH
 pQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741737284; x=1742342084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5n0aon1vJTyaj8UoDGi4nTsxL9gC3qY4k42vM5vrfwM=;
 b=SJg4mzWmags7HUKaKpHwwpEBr90IKH+kWH+b2BTGFbKQWddFoUH4b6VTkdZ++2OSd9
 1qNilQT8vI4KFYMz5A2qpn5Jvm1tyQ7ZFZJjfusls0TQEUoswAMh+xZNZarqW3f/WoYu
 HcGrU1K/gInRzjyV4MUCGrPENIEmxONROkvsHoB493s8lqUhdGUnnJQBZtf8RS9x5+zW
 j4FTwkmiJkt4YDlVG67dQ3chQDPWMTihlIBQlvUrq9dLI4w533/7NRjY7JWEv1QaOU2T
 9ABAsRZdpGUmp+K7gNmS0GjuhcNBTq7VtHKNO5NZMkF7FcF4GS5arhCKokFu6n0Dn52d
 og2g==
X-Gm-Message-State: AOJu0YxvmT3+P6w45rXz1uLvl8BWOVllwWTfetugAUNuF30jyNnUMCI7
 kqORSzb3tpAhShJAq2/Hm3eMB1eRT7gySdSmZeEHlD/QTMRKCJbrgv/pNBjYUznFU3IdGf1o6r9
 D
X-Gm-Gg: ASbGncslt2xM34Yvuqp8Su5SZBpYHCw8Je55p+PRVsCGlOrESbb0j8Jv7fQDi/4tkaV
 0ITNJGfp5jNaZ7HXN8HJEXsrIdws114uFHXClxTnQeUMOHWLdcYRrzsPZ0YLvsKnFvlaBlHs5ZL
 +AryzzC5ynMDM1fYRk9g4MgEMuDxkkbVnfqV2jXx2q2AvXyfyQ0rG0DtAHrfdkwjf1Dkf/HZzd2
 np/YfK5guQ8+dpxWicw6dWAaHtX2fiYDGOvXWb6XfhOsRo3xUjgZqtJnbg5ZVsSRmV8GwLRe8MA
 ntA4TqqB/ptsYHsFjgERencqzOsqB9m3Ev1BxPs/re/nHZg1mWynOrn03yBFML4yQBq47Bwzlnn
 2t0bOsAONrUkjnIv0SpVLNw==
X-Google-Smtp-Source: AGHT+IGON7+7BQ0gtY+4S6sMyCR+HoGShX/QxmUyWm2CkPMZuJzXYlvMyPHFmkPomWW1+orKu52ATw==
X-Received: by 2002:a17:903:22cc:b0:224:76f:9e59 with SMTP id
 d9443c01a7336-22428886833mr292543465ad.10.1741737284304; 
 Tue, 11 Mar 2025 16:54:44 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a91cf4sm103734145ad.200.2025.03.11.16.54.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 16:54:43 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 6/9] net/ioring: implement receive and transmit
Date: Tue, 11 Mar 2025 16:51:24 -0700
Message-ID: <20250311235424.172440-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250311235424.172440-1-stephen@networkplumber.org>
References: <20241210212757.83490-1-stephen@networkplumber.org>
 <20250311235424.172440-1-stephen@networkplumber.org>
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

Use io_uring to read and write from TAP device.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/ioring/rte_eth_ioring.c | 362 +++++++++++++++++++++++++++-
 1 file changed, 361 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ioring/rte_eth_ioring.c b/drivers/net/ioring/rte_eth_ioring.c
index f01db960a7..4d064c2c22 100644
--- a/drivers/net/ioring/rte_eth_ioring.c
+++ b/drivers/net/ioring/rte_eth_ioring.c
@@ -2,6 +2,7 @@
  * Copyright (c) Stephen Hemminger
  */
 
+#include <assert.h>
 #include <ctype.h>
 #include <errno.h>
 #include <fcntl.h>
@@ -9,8 +10,10 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <liburing.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
+#include <sys/uio.h>
 #include <net/if.h>
 #include <linux/if.h>
 #include <linux/if_arp.h>
@@ -27,6 +30,12 @@
 #include <rte_kvargs.h>
 #include <rte_log.h>
 
+#define IORING_DEFAULT_BURST	64
+#define IORING_NUM_BUFFERS	1024
+#define IORING_MAX_QUEUES	128
+
+static_assert(IORING_MAX_QUEUES <= RTE_MP_MAX_FD_NUM, "Max queues exceeds MP fd limit");
+
 #define IORING_DEFAULT_IFNAME	"itap%d"
 #define IORING_MP_KEY		"ioring_mp_send_fds"
 
@@ -34,6 +43,20 @@ RTE_LOG_REGISTER_DEFAULT(ioring_logtype, NOTICE);
 #define RTE_LOGTYPE_IORING ioring_logtype
 #define PMD_LOG(level, ...) RTE_LOG_LINE_PREFIX(level, IORING, "%s(): ", __func__, __VA_ARGS__)
 
+#ifdef RTE_ETHDEV_DEBUG_RX
+#define PMD_RX_LOG(level, ...) \
+	RTE_LOG_LINE_PREFIX(level, IORING, "%s() rx: ", __func__, __VA_ARGS__)
+#else
+#define PMD_RX_LOG(...) do { } while (0)
+#endif
+
+#ifdef RTE_ETHDEV_DEBUG_TX
+#define PMD_TX_LOG(level, ...) \
+	RTE_LOG_LINE_PREFIX(level, IORING, "%s() tx: ", __func__, __VA_ARGS__)
+#else
+#define PMD_TX_LOG(...) do { } while (0)
+#endif
+
 #define IORING_IFACE_ARG	"iface"
 #define IORING_PERSIST_ARG	"persist"
 
@@ -43,6 +66,30 @@ static const char * const valid_arguments[] = {
 	NULL
 };
 
+struct rx_queue {
+	struct rte_mempool *mb_pool;	/* rx buffer pool */
+	struct io_uring io_ring;	/* queue of posted read's */
+	uint16_t port_id;
+	uint16_t queue_id;
+
+	uint64_t rx_packets;
+	uint64_t rx_bytes;
+	uint64_t rx_nombuf;
+	uint64_t rx_errors;
+};
+
+struct tx_queue {
+	struct io_uring io_ring;
+
+	uint16_t port_id;
+	uint16_t queue_id;
+	uint16_t free_thresh;
+
+	uint64_t tx_packets;
+	uint64_t tx_bytes;
+	uint64_t tx_errors;
+};
+
 struct pmd_internals {
 	int keep_fd;			/* keep alive file descriptor */
 	char ifname[IFNAMSIZ];		/* name assigned by kernel */
@@ -300,6 +347,15 @@ eth_dev_info(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->if_index = if_nametoindex(pmd->ifname);
 	dev_info->max_mac_addrs = 1;
 	dev_info->max_rx_pktlen = RTE_ETHER_MAX_LEN;
+	dev_info->max_rx_queues = IORING_MAX_QUEUES;
+	dev_info->max_tx_queues = IORING_MAX_QUEUES;
+	dev_info->min_rx_bufsize = 0;
+
+	dev_info->default_rxportconf = (struct rte_eth_dev_portconf) {
+		.burst_size = IORING_DEFAULT_BURST,
+		.ring_size = IORING_NUM_BUFFERS,
+		.nb_queues = 1,
+	};
 
 	return 0;
 }
@@ -311,6 +367,14 @@ eth_dev_close(struct rte_eth_dev *dev)
 
 	PMD_LOG(INFO, "Closing %s", pmd->ifname);
 
+	int *fds = dev->process_private;
+	for (uint16_t i = 0; i < dev->data->nb_rx_queues; i++) {
+		if (fds[i] == -1)
+			continue;
+		close(fds[i]);
+		fds[i] = -1;
+	}
+
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
 		return 0;
 
@@ -324,6 +388,295 @@ eth_dev_close(struct rte_eth_dev *dev)
 	return 0;
 }
 
+/* Setup another fd to TAP device for the queue */
+static int
+eth_queue_setup(struct rte_eth_dev *dev, const char *name, uint16_t queue_id)
+{
+	int *fds = dev->process_private;
+
+	if (fds[queue_id] != -1)
+		return 0;	/* already setup */
+
+	struct ifreq ifr = { };
+	int tap_fd = tap_open(name, &ifr, 0);
+	if (tap_fd < 0) {
+		PMD_LOG(ERR, "tap_open failed");
+		return -1;
+	}
+
+	PMD_LOG(DEBUG, "opened %d for queue %u", tap_fd, queue_id);
+	fds[queue_id] = tap_fd;
+	return 0;
+}
+
+static int
+eth_queue_fd(uint16_t port_id, uint16_t queue_id)
+{
+	struct rte_eth_dev *dev = &rte_eth_devices[port_id];
+	int *fds = dev->process_private;
+
+	return fds[queue_id];
+}
+
+/* setup an submit queue to read mbuf */
+static inline void
+eth_rx_submit(struct rx_queue *rxq, int fd, struct rte_mbuf *mb)
+{
+	struct io_uring_sqe *sqe = io_uring_get_sqe(&rxq->io_ring);
+
+	if (unlikely(sqe == NULL)) {
+		PMD_LOG(DEBUG, "io_uring no rx sqe");
+		rxq->rx_errors++;
+		rte_pktmbuf_free(mb);
+	} else {
+		void *base = rte_pktmbuf_mtod(mb, void *);
+		size_t len = mb->buf_len;
+
+		io_uring_prep_read(sqe, fd, base, len, 0);
+		io_uring_sqe_set_data(sqe, mb);
+	}
+}
+
+static uint16_t
+eth_ioring_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
+{
+	struct rx_queue *rxq = queue;
+	struct io_uring_cqe *cqe;
+	unsigned int head, num_cqe = 0;
+	uint16_t num_rx = 0;
+	uint32_t num_bytes = 0;
+	int fd = eth_queue_fd(rxq->port_id, rxq->queue_id);
+
+	io_uring_for_each_cqe(&rxq->io_ring, head, cqe) {
+		struct rte_mbuf *mb = (void *)(uintptr_t)cqe->user_data;
+		ssize_t len = cqe->res;
+
+		PMD_RX_LOG(DEBUG, "cqe %u len %zd", num_cqe, len);
+		num_cqe++;
+
+		if (unlikely(len < RTE_ETHER_HDR_LEN)) {
+			if (len < 0)
+				PMD_LOG(ERR, "io_uring_read: %s", strerror(-len));
+			else
+				PMD_LOG(ERR, "io_uring_read missing hdr");
+
+			rxq->rx_errors++;
+			goto resubmit;
+		}
+
+		struct rte_mbuf *nmb = rte_pktmbuf_alloc(rxq->mb_pool);
+		if (unlikely(nmb == 0)) {
+			PMD_LOG(DEBUG, "Rx mbuf alloc failed");
+			++rxq->rx_nombuf;
+			goto resubmit;
+		}
+
+		mb->pkt_len = len;
+		mb->data_len = len;
+		mb->port = rxq->port_id;
+		__rte_mbuf_sanity_check(mb, 1);
+
+		num_bytes += len;
+		bufs[num_rx++] = mb;
+
+		mb = nmb;
+resubmit:
+		eth_rx_submit(rxq, fd, mb);
+
+		if (num_rx == nb_pkts)
+			break;
+	}
+	io_uring_cq_advance(&rxq->io_ring, num_cqe);
+
+	rxq->rx_packets += num_rx;
+	rxq->rx_bytes += num_bytes;
+	return num_rx;
+}
+
+static int
+eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id, uint16_t nb_rx_desc,
+		   unsigned int socket_id,
+		   const struct rte_eth_rxconf *rx_conf __rte_unused,
+		   struct rte_mempool *mb_pool)
+{
+	struct pmd_internals *pmd = dev->data->dev_private;
+
+	PMD_LOG(DEBUG, "setup port %u queue %u rx_descriptors %u",
+		dev->data->port_id, queue_id, nb_rx_desc);
+
+	/* open shared tap fd maybe already setup */
+	if (eth_queue_setup(dev, pmd->ifname, queue_id) < 0)
+		return -1;
+
+	struct rx_queue *rxq = rte_zmalloc_socket(NULL, sizeof(*rxq),
+						  RTE_CACHE_LINE_SIZE, socket_id);
+	if (rxq == NULL) {
+		PMD_LOG(ERR, "rxq alloc failed");
+		return -1;
+	}
+
+	rxq->mb_pool = mb_pool;
+	rxq->port_id = dev->data->port_id;
+	rxq->queue_id = queue_id;
+	dev->data->rx_queues[queue_id] = rxq;
+
+	if (io_uring_queue_init(nb_rx_desc, &rxq->io_ring, 0) != 0) {
+		PMD_LOG(ERR, "io_uring_queue_init failed: %s", strerror(errno));
+		return -1;
+	}
+
+	struct rte_mbuf **mbufs = alloca(nb_rx_desc * sizeof(struct rte_mbuf *));
+	if (mbufs == NULL) {
+		PMD_LOG(ERR, "alloca for %u failed", nb_rx_desc);
+		return -1;
+	}
+
+	if (rte_pktmbuf_alloc_bulk(mb_pool, mbufs, nb_rx_desc) < 0) {
+		PMD_LOG(ERR, "Rx mbuf alloc %u bufs failed", nb_rx_desc);
+		return -1;
+	}
+
+	int fd = eth_queue_fd(rxq->port_id, rxq->queue_id);
+	for (uint16_t i = 0; i < nb_rx_desc; i++)
+		eth_rx_submit(rxq, fd, mbufs[i]);
+
+	io_uring_submit(&rxq->io_ring);
+	return 0;
+}
+
+static void
+eth_rx_queue_release(struct rte_eth_dev *dev, uint16_t queue_id)
+{
+	struct rx_queue *rxq = dev->data->rx_queues[queue_id];
+
+	struct io_uring_sqe *sqe = io_uring_get_sqe(&rxq->io_ring);
+	if (sqe == NULL) {
+		PMD_LOG(ERR, "io_uring_get_sqe failed: %s", strerror(errno));
+	} else {
+		io_uring_prep_cancel(sqe, NULL, IORING_ASYNC_CANCEL_ANY);
+		io_uring_submit_and_wait(&rxq->io_ring, 1);
+	}
+
+	io_uring_queue_exit(&rxq->io_ring);
+}
+
+static int
+eth_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id,
+		   uint16_t nb_tx_desc, unsigned int socket_id,
+		   const struct rte_eth_txconf *tx_conf)
+{
+	struct pmd_internals *pmd = dev->data->dev_private;
+
+	/* open shared tap fd maybe already setup */
+	if (eth_queue_setup(dev, pmd->ifname, queue_id) < 0)
+		return -1;
+
+	struct tx_queue *txq = rte_zmalloc_socket(NULL, sizeof(*txq),
+						  RTE_CACHE_LINE_SIZE, socket_id);
+	if (txq == NULL) {
+		PMD_LOG(ERR, "txq alloc failed");
+		return -1;
+	}
+
+	txq->port_id = dev->data->port_id;
+	txq->queue_id = queue_id;
+	txq->free_thresh = tx_conf->tx_free_thresh;
+	dev->data->tx_queues[queue_id] = txq;
+
+	if (io_uring_queue_init(nb_tx_desc, &txq->io_ring, 0) != 0) {
+		PMD_LOG(ERR, "io_uring_queue_init failed: %s", strerror(errno));
+		return -1;
+	}
+
+	return 0;
+}
+
+static void
+eth_tx_queue_release(struct rte_eth_dev *dev, uint16_t queue_id)
+{
+	struct tx_queue *txq = dev->data->tx_queues[queue_id];
+
+	struct io_uring_sqe *sqe = io_uring_get_sqe(&txq->io_ring);
+	if (sqe == NULL) {
+		PMD_LOG(ERR, "io_uring_get_sqe failed: %s", strerror(errno));
+	} else {
+		io_uring_prep_cancel(sqe, NULL, IORING_ASYNC_CANCEL_ANY);
+		io_uring_submit_and_wait(&txq->io_ring, 1);
+	}
+
+	io_uring_queue_exit(&txq->io_ring);
+}
+
+static void
+eth_ioring_tx_cleanup(struct tx_queue *txq)
+{
+	struct io_uring_cqe *cqe;
+	unsigned int head;
+	unsigned int tx_done = 0;
+	uint64_t tx_bytes = 0;
+
+	io_uring_for_each_cqe(&txq->io_ring, head, cqe) {
+		struct rte_mbuf *mb = (void *)(uintptr_t)cqe->user_data;
+
+		PMD_TX_LOG(DEBUG, " mbuf len %u result: %d", mb->pkt_len, cqe->res);
+		if (unlikely(cqe->res < 0)) {
+			++txq->tx_errors;
+		} else {
+			++tx_done;
+			tx_bytes += mb->pkt_len;
+		}
+
+		rte_pktmbuf_free(mb);
+	}
+	io_uring_cq_advance(&txq->io_ring, tx_done);
+
+	txq->tx_packets += tx_done;
+	txq->tx_bytes += tx_bytes;
+}
+
+static uint16_t
+eth_ioring_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
+{
+	struct tx_queue *txq = queue;
+	uint16_t num_tx;
+
+	if (unlikely(nb_pkts == 0))
+		return 0;
+
+	PMD_TX_LOG(DEBUG, "%d packets to xmit", nb_pkts);
+
+	if (io_uring_sq_space_left(&txq->io_ring) < txq->free_thresh)
+		eth_ioring_tx_cleanup(txq);
+
+	int fd = eth_queue_fd(txq->port_id, txq->queue_id);
+
+	for (num_tx = 0; num_tx < nb_pkts; num_tx++) {
+		struct rte_mbuf *mb = bufs[num_tx];
+
+		struct io_uring_sqe *sqe = io_uring_get_sqe(&txq->io_ring);
+		if (sqe == NULL)
+			break;	/* submit ring is full */
+
+		io_uring_sqe_set_data(sqe, mb);
+
+		if (rte_mbuf_refcnt_read(mb) == 1 &&
+		    RTE_MBUF_DIRECT(mb) && mb->nb_segs == 1) {
+			void *base = rte_pktmbuf_mtod(mb, void *);
+			io_uring_prep_write(sqe, fd, base, mb->pkt_len, 0);
+
+			PMD_TX_LOG(DEBUG, "tx mbuf: %p submit", mb);
+		} else {
+			PMD_LOG(ERR, "Can't do mbuf without space yet!");
+			++txq->tx_errors;
+			continue;
+		}
+	}
+	if (num_tx > 0)
+		io_uring_submit(&txq->io_ring);
+
+	return num_tx;
+}
+
 static const struct eth_dev_ops ops = {
 	.dev_start		= eth_dev_start,
 	.dev_stop		= eth_dev_stop,
@@ -339,9 +692,12 @@ static const struct eth_dev_ops ops = {
 	.promiscuous_disable	= eth_dev_promiscuous_disable,
 	.allmulticast_enable	= eth_dev_allmulticast_enable,
 	.allmulticast_disable	= eth_dev_allmulticast_disable,
+	.rx_queue_setup		= eth_rx_queue_setup,
+	.rx_queue_release	= eth_rx_queue_release,
+	.tx_queue_setup		= eth_tx_queue_setup,
+	.tx_queue_release	= eth_tx_queue_release,
 };
 
-
 static int
 ioring_create(struct rte_eth_dev *dev, const char *tap_name, uint8_t persist)
 {
@@ -379,6 +735,10 @@ ioring_create(struct rte_eth_dev *dev, const char *tap_name, uint8_t persist)
 	}
 
 	PMD_LOG(DEBUG, "%s setup", ifr.ifr_name);
+
+	dev->rx_pkt_burst = eth_ioring_rx;
+	dev->tx_pkt_burst = eth_ioring_tx;
+
 	return 0;
 
 error:
-- 
2.47.2

