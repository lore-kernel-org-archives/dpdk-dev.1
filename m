Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE4DC531F7
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 15:31:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C72D4406BA;
	Thu, 23 Jul 2026 17:31:26 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id DB8CB406BA
 for <dev@dpdk.org>; Thu, 23 Jul 2026 17:31:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784820684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vzjrxrGpL5Jnw9ueEucmicZhpmefuPB41qpB4LEmqog=;
 b=Z6wJBN39NALMcMoYvwy2ygW1+4q1vQut5Qp3i12JAADDKvn4uWNMLoshmXhQtK2mJujm0u
 tb/TIG1FUqT+6E2i9yY8zgqN8EZszI3v47hdMEZQgTKLzpkGGqMTR0zByShWzAZ34+lANQ
 veUnwu+axk63NH3hO4FX0Cua/pF5rKQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-KQR9RD5dMJaheJ7UucHwMg-1; Thu,
 23 Jul 2026 11:31:22 -0400
X-MC-Unique: KQR9RD5dMJaheJ7UucHwMg-1
X-Mimecast-MFC-AGG-ID: KQR9RD5dMJaheJ7UucHwMg_1784820681
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD4321945106; Thu, 23 Jul 2026 15:31:21 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 77E041800586; Thu, 23 Jul 2026 15:31:20 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: maxime.coquelin@redhat.com,
	dev@dpdk.org
Cc: Chenbo Xia <chenbox@nvidia.com>
Subject: [RFC 1/3] examples: stop using vhost async datapath
Date: Thu, 23 Jul 2026 17:31:08 +0200
Message-ID: <20260723153111.3943368-2-david.marchand@redhat.com>
In-Reply-To: <20260723153111.3943368-1-david.marchand@redhat.com>
References: <20260723153111.3943368-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JP8EVqbVrP0TFEGFzV3ZHSLWa9ukdUzpfGcNEjnK-qE_1784820681
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Stop using vhost async as this feature will be removed in a next commit.
The vhost-crypto example was requesting async copy for no identified
reason.

Thanks to this, we can drop use of experimental api in those examples.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 examples/vhost/Makefile           |   2 -
 examples/vhost/main.c             | 436 +-----------------------------
 examples/vhost/main.h             |  21 +-
 examples/vhost/meson.build        |   2 -
 examples/vhost_crypto/Makefile    |   1 -
 examples/vhost_crypto/main.c      |   3 +-
 examples/vhost_crypto/meson.build |   1 -
 7 files changed, 13 insertions(+), 453 deletions(-)

diff --git a/examples/vhost/Makefile b/examples/vhost/Makefile
index 5b3cea0778..6e0114d094 100644
--- a/examples/vhost/Makefile
+++ b/examples/vhost/Makefile
@@ -28,8 +28,6 @@ CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk)
 LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
 LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 
-CFLAGS += -DALLOW_EXPERIMENTAL_API
-
 build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build
 	$(CC) $(CFLAGS) $(SRCS-y) -o $@ $(LDFLAGS) $(LDFLAGS_SHARED)
 
diff --git a/examples/vhost/main.c b/examples/vhost/main.c
index 5978a50cfe..10a88c46b8 100644
--- a/examples/vhost/main.c
+++ b/examples/vhost/main.c
@@ -2,7 +2,6 @@
  * Copyright(c) 2010-2017 Intel Corporation
  */
 
-#include <ctype.h>
 #include <arpa/inet.h>
 #include <getopt.h>
 #include <linux/if_ether.h>
@@ -26,8 +25,6 @@
 #include <rte_ip.h>
 #include <rte_tcp.h>
 #include <rte_pause.h>
-#include <rte_dmadev.h>
-#include <rte_vhost_async.h>
 #include <rte_thread.h>
 
 #include "main.h"
@@ -62,20 +59,10 @@
 #define TX_DESC_DEFAULT 512
 
 #define INVALID_PORT_ID 0xFF
-#define INVALID_DMA_ID -1
-
-#define DMA_RING_SIZE 4096
-
-#define ASYNC_ENQUEUE_VHOST 1
-#define ASYNC_DEQUEUE_VHOST 2
 
 /* number of mbufs in all pools - if specified on command-line. */
 static int total_num_mbufs = NUM_MBUFS_DEFAULT;
 
-struct dma_for_vhost dma_bind[RTE_MAX_VHOST_DEVICE];
-int16_t dmas_id[RTE_DMADEV_DEFAULT_MAX];
-static int dma_count;
-
 /* mask of enabled ports */
 static uint32_t enabled_port_mask = 0;
 
@@ -211,176 +198,6 @@ struct vhost_bufftable *vhost_txbuff[RTE_MAX_LCORE * RTE_MAX_VHOST_DEVICE];
 #define MBUF_TABLE_DRAIN_TSC	((rte_get_tsc_hz() + US_PER_S - 1) \
 				 / US_PER_S * BURST_TX_DRAIN_US)
 
-static int vid2socketid[RTE_MAX_VHOST_DEVICE];
-
-static inline uint32_t
-get_async_flag_by_socketid(int socketid)
-{
-	return dma_bind[socketid].async_flag;
-}
-
-static inline void
-init_vid2socketid_array(int vid, int socketid)
-{
-	vid2socketid[vid] = socketid;
-}
-
-static inline bool
-is_dma_configured(int16_t dev_id)
-{
-	int i;
-
-	for (i = 0; i < dma_count; i++)
-		if (dmas_id[i] == dev_id)
-			return true;
-	return false;
-}
-
-static inline int
-open_dma(const char *value)
-{
-	struct dma_for_vhost *dma_info = dma_bind;
-	char *input = strndup(value, strlen(value) + 1);
-	char *addrs = input;
-	char *ptrs[2];
-	char *start, *end, *substr;
-	int64_t socketid, vring_id;
-
-	struct rte_dma_info info;
-	struct rte_dma_conf dev_config = { .nb_vchans = 1 };
-	struct rte_dma_vchan_conf qconf = {
-		.direction = RTE_DMA_DIR_MEM_TO_MEM,
-		.nb_desc = DMA_RING_SIZE
-	};
-
-	int dev_id;
-	int ret = 0;
-	uint16_t i = 0;
-	char *dma_arg[RTE_MAX_VHOST_DEVICE];
-	int args_nr;
-
-	if (input == NULL)
-		return -1;
-
-	while (isblank(*addrs))
-		addrs++;
-	if (*addrs == '\0') {
-		ret = -1;
-		goto out;
-	}
-
-	/* process DMA devices within bracket. */
-	addrs++;
-	substr = strtok(addrs, ";]");
-	if (!substr) {
-		ret = -1;
-		goto out;
-	}
-
-	args_nr = rte_strsplit(substr, strlen(substr), dma_arg, RTE_MAX_VHOST_DEVICE, ',');
-	if (args_nr <= 0) {
-		ret = -1;
-		goto out;
-	}
-
-	while (i < args_nr) {
-		char *arg_temp = dma_arg[i];
-		char *txd, *rxd;
-		uint8_t sub_nr;
-		int async_flag;
-
-		sub_nr = rte_strsplit(arg_temp, strlen(arg_temp), ptrs, 2, '@');
-		if (sub_nr != 2) {
-			ret = -1;
-			goto out;
-		}
-
-		txd = strstr(ptrs[0], "txd");
-		rxd = strstr(ptrs[0], "rxd");
-		if (txd) {
-			start = txd;
-			vring_id = VIRTIO_RXQ;
-			async_flag = ASYNC_ENQUEUE_VHOST;
-		} else if (rxd) {
-			start = rxd;
-			vring_id = VIRTIO_TXQ;
-			async_flag = ASYNC_DEQUEUE_VHOST;
-		} else {
-			ret = -1;
-			goto out;
-		}
-
-		start += 3;
-		socketid = strtol(start, &end, 0);
-		if (end == start) {
-			ret = -1;
-			goto out;
-		}
-
-		dev_id = rte_dma_get_dev_id_by_name(ptrs[1]);
-		if (dev_id < 0) {
-			RTE_LOG(ERR, VHOST_CONFIG, "Fail to find DMA %s.\n", ptrs[1]);
-			ret = -1;
-			goto out;
-		}
-
-		/* DMA device is already configured, so skip */
-		if (is_dma_configured(dev_id))
-			goto done;
-
-		if (rte_dma_info_get(dev_id, &info) != 0) {
-			RTE_LOG(ERR, VHOST_CONFIG, "Error with rte_dma_info_get()\n");
-			ret = -1;
-			goto out;
-		}
-
-		if (info.max_vchans < 1) {
-			RTE_LOG(ERR, VHOST_CONFIG, "No channels available on device %d\n", dev_id);
-			ret = -1;
-			goto out;
-		}
-
-		if (rte_dma_configure(dev_id, &dev_config) != 0) {
-			RTE_LOG(ERR, VHOST_CONFIG, "Fail to configure DMA %d.\n", dev_id);
-			ret = -1;
-			goto out;
-		}
-
-		/* Check the max desc supported by DMA device */
-		rte_dma_info_get(dev_id, &info);
-		if (info.nb_vchans != 1) {
-			RTE_LOG(ERR, VHOST_CONFIG, "No configured queues reported by DMA %d.\n",
-					dev_id);
-			ret = -1;
-			goto out;
-		}
-
-		qconf.nb_desc = RTE_MIN(DMA_RING_SIZE, info.max_desc);
-
-		if (rte_dma_vchan_setup(dev_id, 0, &qconf) != 0) {
-			RTE_LOG(ERR, VHOST_CONFIG, "Fail to set up DMA %d.\n", dev_id);
-			ret = -1;
-			goto out;
-		}
-
-		if (rte_dma_start(dev_id) != 0) {
-			RTE_LOG(ERR, VHOST_CONFIG, "Fail to start DMA %u.\n", dev_id);
-			ret = -1;
-			goto out;
-		}
-
-		dmas_id[dma_count++] = dev_id;
-
-done:
-		(dma_info + socketid)->dmas[vring_id].dev_id = dev_id;
-		(dma_info + socketid)->async_flag |= async_flag;
-		i++;
-	}
-out:
-	free(input);
-	return ret;
-}
-
 /*
  * Builds up the correct configuration for VMDQ VLAN pool map
  * according to the pool & queue limits.
@@ -650,7 +467,6 @@ us_vhost_usage(const char *prgname)
 	"		--tx-csum [0|1]: disable/enable TX checksum offload.\n"
 	"		--tso [0|1]: disable/enable TCP segment offload.\n"
 	"		--client: register a vhost-user socket as client mode.\n"
-	"		--dmas: register dma channel for specific vhost device.\n"
 	"		--total-num-mbufs [0-N]: set the number of mbufs to be allocated in mbuf pools, the default value is 147456.\n"
 	"		--builtin-net-driver: enable simple vhost-user net driver\n",
 	       prgname);
@@ -679,8 +495,6 @@ enum {
 	OPT_CLIENT_NUM,
 #define OPT_BUILTIN_NET_DRIVER  "builtin-net-driver"
 	OPT_BUILTIN_NET_DRIVER_NUM,
-#define OPT_DMAS                "dmas"
-	OPT_DMAS_NUM,
 #define OPT_NUM_MBUFS           "total-num-mbufs"
 	OPT_NUM_MBUFS_NUM,
 };
@@ -718,8 +532,6 @@ us_vhost_parse_args(int argc, char **argv)
 				NULL, OPT_CLIENT_NUM},
 		{OPT_BUILTIN_NET_DRIVER, no_argument,
 				NULL, OPT_BUILTIN_NET_DRIVER_NUM},
-		{OPT_DMAS, required_argument,
-				NULL, OPT_DMAS_NUM},
 		{OPT_NUM_MBUFS, required_argument,
 				NULL, OPT_NUM_MBUFS_NUM},
 		{NULL, 0, 0, 0},
@@ -840,15 +652,6 @@ us_vhost_parse_args(int argc, char **argv)
 			}
 			break;
 
-		case OPT_DMAS_NUM:
-			if (open_dma(optarg) == -1) {
-				RTE_LOG(INFO, VHOST_CONFIG,
-					"Wrong DMA args\n");
-				us_vhost_usage(prgname);
-				return -1;
-			}
-			break;
-
 		case OPT_NUM_MBUFS_NUM:
 			ret = parse_num_opt(optarg, INT32_MAX);
 			if (ret == -1) {
@@ -1024,21 +827,7 @@ free_pkts(struct rte_mbuf **pkts, uint16_t n)
 }
 
 static __rte_always_inline void
-complete_async_pkts(struct vhost_dev *vdev)
-{
-	struct rte_mbuf *p_cpl[MAX_PKT_BURST];
-	uint16_t complete_count;
-	int16_t dma_id = dma_bind[vid2socketid[vdev->vid]].dmas[VIRTIO_RXQ].dev_id;
-
-	complete_count = rte_vhost_poll_enqueue_completed(vdev->vid,
-					VIRTIO_RXQ, p_cpl, MAX_PKT_BURST, dma_id, 0);
-	if (complete_count)
-		free_pkts(p_cpl, complete_count);
-
-}
-
-static __rte_always_inline void
-sync_virtio_xmit(struct vhost_dev *dst_vdev, struct vhost_dev *src_vdev,
+virtio_xmit(struct vhost_dev *dst_vdev, struct vhost_dev *src_vdev,
 	    struct rte_mbuf *m)
 {
 	uint16_t ret;
@@ -1076,13 +865,7 @@ drain_vhost(struct vhost_dev *vdev)
 				rte_memory_order_seq_cst);
 	}
 
-	if (!dma_bind[vid2socketid[vdev->vid]].dmas[VIRTIO_RXQ].async_enabled) {
-		free_pkts(m, nr_xmit);
-	} else {
-		uint16_t enqueue_fail = nr_xmit - ret;
-		if (enqueue_fail > 0)
-			free_pkts(&m[ret], enqueue_fail);
-	}
+	free_pkts(m, nr_xmit);
 }
 
 static __rte_always_inline void
@@ -1261,7 +1044,7 @@ virtio_tx_route(struct vhost_dev *vdev, struct rte_mbuf *m, uint16_t vlan_tag)
 
 		TAILQ_FOREACH(vdev2, &vhost_dev_list, global_vdev_entry) {
 			if (vdev2 != vdev)
-				sync_virtio_xmit(vdev2, vdev, m);
+				virtio_xmit(vdev2, vdev, m);
 		}
 		goto queue2nic;
 	}
@@ -1354,21 +1137,7 @@ drain_mbuf_table(struct mbuf_table *tx_q)
 }
 
 uint16_t
-async_enqueue_pkts(struct vhost_dev *dev, uint16_t queue_id,
-		struct rte_mbuf **pkts, uint32_t rx_count)
-{
-	uint16_t enqueue_count;
-	uint16_t dma_id = dma_bind[vid2socketid[dev->vid]].dmas[VIRTIO_RXQ].dev_id;
-
-	complete_async_pkts(dev);
-	enqueue_count = rte_vhost_submit_enqueue_burst(dev->vid, queue_id,
-					pkts, rx_count, dma_id, 0);
-
-	return enqueue_count;
-}
-
-uint16_t
-sync_enqueue_pkts(struct vhost_dev *dev, uint16_t queue_id,
+enqueue_pkts(struct vhost_dev *dev, uint16_t queue_id,
 		struct rte_mbuf **pkts, uint32_t rx_count)
 {
 	return rte_vhost_enqueue_burst(dev->vid, queue_id, pkts, rx_count);
@@ -1408,30 +1177,10 @@ drain_eth_rx(struct vhost_dev *vdev)
 				rte_memory_order_seq_cst);
 	}
 
-	if (!dma_bind[vid2socketid[vdev->vid]].dmas[VIRTIO_RXQ].async_enabled) {
-		free_pkts(pkts, rx_count);
-	} else {
-		uint16_t enqueue_fail = rx_count - enqueue_count;
-		if (enqueue_fail > 0)
-			free_pkts(&pkts[enqueue_count], enqueue_fail);
-	}
-}
-
-uint16_t async_dequeue_pkts(struct vhost_dev *dev, uint16_t queue_id,
-			    struct rte_mempool *mbuf_pool,
-			    struct rte_mbuf **pkts, uint16_t count)
-{
-	int nr_inflight;
-	uint16_t dequeue_count;
-	int16_t dma_id = dma_bind[vid2socketid[dev->vid]].dmas[VIRTIO_TXQ].dev_id;
-
-	dequeue_count = rte_vhost_async_try_dequeue_burst(dev->vid, queue_id,
-			mbuf_pool, pkts, count, &nr_inflight, dma_id, 0);
-
-	return dequeue_count;
+	free_pkts(pkts, rx_count);
 }
 
-uint16_t sync_dequeue_pkts(struct vhost_dev *dev, uint16_t queue_id,
+uint16_t dequeue_pkts(struct vhost_dev *dev, uint16_t queue_id,
 			   struct rte_mempool *mbuf_pool,
 			   struct rte_mbuf **pkts, uint16_t count)
 {
@@ -1526,45 +1275,6 @@ switch_worker(void *arg)
 	return 0;
 }
 
-static void
-vhost_clear_queue_thread_unsafe(struct vhost_dev *vdev, uint16_t queue_id)
-{
-	uint16_t n_pkt = 0;
-	int pkts_inflight;
-
-	int16_t dma_id = dma_bind[vid2socketid[vdev->vid]].dmas[queue_id].dev_id;
-	pkts_inflight = rte_vhost_async_get_inflight_thread_unsafe(vdev->vid, queue_id);
-
-	struct rte_mbuf *m_cpl[pkts_inflight];
-
-	while (pkts_inflight) {
-		n_pkt = rte_vhost_clear_queue_thread_unsafe(vdev->vid, queue_id, m_cpl,
-							pkts_inflight, dma_id, 0);
-		free_pkts(m_cpl, n_pkt);
-		pkts_inflight = rte_vhost_async_get_inflight_thread_unsafe(vdev->vid,
-									queue_id);
-	}
-}
-
-static void
-vhost_clear_queue(struct vhost_dev *vdev, uint16_t queue_id)
-{
-	uint16_t n_pkt = 0;
-	int pkts_inflight;
-
-	int16_t dma_id = dma_bind[vid2socketid[vdev->vid]].dmas[queue_id].dev_id;
-	pkts_inflight = rte_vhost_async_get_inflight(vdev->vid, queue_id);
-
-	struct rte_mbuf *m_cpl[pkts_inflight];
-
-	while (pkts_inflight) {
-		n_pkt = rte_vhost_clear_queue(vdev->vid, queue_id, m_cpl,
-						pkts_inflight, dma_id, 0);
-		free_pkts(m_cpl, n_pkt);
-		pkts_inflight = rte_vhost_async_get_inflight(vdev->vid, queue_id);
-	}
-}
-
 /*
  * Remove a device from the specific data core linked list and from the
  * main linked list. Synchronization  occurs through the use of the
@@ -1621,37 +1331,9 @@ destroy_device(int vid)
 		"(%d) device has been removed from data core\n",
 		vdev->vid);
 
-	if (dma_bind[vid].dmas[VIRTIO_RXQ].async_enabled) {
-		vhost_clear_queue(vdev, VIRTIO_RXQ);
-		rte_vhost_async_channel_unregister(vid, VIRTIO_RXQ);
-		dma_bind[vid].dmas[VIRTIO_RXQ].async_enabled = false;
-	}
-
-	if (dma_bind[vid].dmas[VIRTIO_TXQ].async_enabled) {
-		vhost_clear_queue(vdev, VIRTIO_TXQ);
-		rte_vhost_async_channel_unregister(vid, VIRTIO_TXQ);
-		dma_bind[vid].dmas[VIRTIO_TXQ].async_enabled = false;
-	}
-
 	rte_free(vdev);
 }
 
-static inline int
-get_socketid_by_vid(int vid)
-{
-	int i;
-	char ifname[PATH_MAX];
-	rte_vhost_get_ifname(vid, ifname, sizeof(ifname));
-
-	for (i = 0; i < nb_sockets; i++) {
-		char *file = socket_files + i * PATH_MAX;
-		if (strcmp(file, ifname) == 0)
-			return i;
-	}
-
-	return -1;
-}
-
 static int
 init_vhost_queue_ops(int vid)
 {
@@ -1659,42 +1341,13 @@ init_vhost_queue_ops(int vid)
 		vdev_queue_ops[vid].enqueue_pkt_burst = builtin_enqueue_pkts;
 		vdev_queue_ops[vid].dequeue_pkt_burst = builtin_dequeue_pkts;
 	} else {
-		if (dma_bind[vid2socketid[vid]].dmas[VIRTIO_RXQ].async_enabled)
-			vdev_queue_ops[vid].enqueue_pkt_burst = async_enqueue_pkts;
-		else
-			vdev_queue_ops[vid].enqueue_pkt_burst = sync_enqueue_pkts;
-
-		if (dma_bind[vid2socketid[vid]].dmas[VIRTIO_TXQ].async_enabled)
-			vdev_queue_ops[vid].dequeue_pkt_burst = async_dequeue_pkts;
-		else
-			vdev_queue_ops[vid].dequeue_pkt_burst = sync_dequeue_pkts;
+		vdev_queue_ops[vid].enqueue_pkt_burst = enqueue_pkts;
+		vdev_queue_ops[vid].dequeue_pkt_burst = dequeue_pkts;
 	}
 
 	return 0;
 }
 
-static inline int
-vhost_async_channel_register(int vid)
-{
-	int rx_ret = 0, tx_ret = 0;
-
-	if (dma_bind[vid2socketid[vid]].dmas[VIRTIO_RXQ].dev_id != INVALID_DMA_ID) {
-		rx_ret = rte_vhost_async_channel_register(vid, VIRTIO_RXQ);
-		if (rx_ret == 0)
-			dma_bind[vid2socketid[vid]].dmas[VIRTIO_RXQ].async_enabled = true;
-	}
-
-	if (dma_bind[vid2socketid[vid]].dmas[VIRTIO_TXQ].dev_id != INVALID_DMA_ID) {
-		tx_ret = rte_vhost_async_channel_register(vid, VIRTIO_TXQ);
-		if (tx_ret == 0)
-			dma_bind[vid2socketid[vid]].dmas[VIRTIO_TXQ].async_enabled = true;
-	}
-
-	return rx_ret | tx_ret;
-}
-
-
-
 /*
  * A new device is added to a data core. First the device is added to the main linked list
  * and then allocated to a specific data core.
@@ -1706,7 +1359,6 @@ new_device(int vid)
 	uint16_t i;
 	uint32_t device_num_min = num_devices;
 	struct vhost_dev *vdev;
-	int ret;
 
 	vdev = rte_zmalloc("vhost device", sizeof(*vdev), RTE_CACHE_LINE_SIZE);
 	if (vdev == NULL) {
@@ -1730,14 +1382,6 @@ new_device(int vid)
 		}
 	}
 
-	int socketid = get_socketid_by_vid(vid);
-	if (socketid == -1)
-		return -1;
-
-	init_vid2socketid_array(vid, socketid);
-
-	ret =  vhost_async_channel_register(vid);
-
 	if (init_vhost_queue_ops(vid) != 0)
 		return -1;
 
@@ -1772,26 +1416,6 @@ new_device(int vid)
 		"(%d) device has been added to data core %d\n",
 		vid, vdev->coreid);
 
-	return ret;
-}
-
-static int
-vring_state_changed(int vid, uint16_t queue_id, int enable)
-{
-	struct vhost_dev *vdev = NULL;
-
-	TAILQ_FOREACH(vdev, &vhost_dev_list, global_vdev_entry) {
-		if (vdev->vid == vid)
-			break;
-	}
-	if (!vdev)
-		return -1;
-
-	if (dma_bind[vid2socketid[vid]].dmas[queue_id].async_enabled) {
-		if (!enable)
-			vhost_clear_queue_thread_unsafe(vdev, queue_id);
-	}
-
 	return 0;
 }
 
@@ -1803,7 +1427,6 @@ static const struct rte_vhost_device_ops virtio_net_device_ops =
 {
 	.new_device =  new_device,
 	.destroy_device = destroy_device,
-	.vring_state_changed = vring_state_changed,
 };
 
 /*
@@ -1882,24 +1505,6 @@ sigint_handler(__rte_unused int signum)
 	exit(0);
 }
 
-static void
-reset_dma(void)
-{
-	int i;
-
-	for (i = 0; i < RTE_MAX_VHOST_DEVICE; i++) {
-		int j;
-
-		for (j = 0; j < RTE_MAX_QUEUES_PER_PORT * 2; j++) {
-			dma_bind[i].dmas[j].dev_id = INVALID_DMA_ID;
-			dma_bind[i].dmas[j].async_enabled = false;
-		}
-	}
-
-	for (i = 0; i < RTE_DMADEV_DEFAULT_MAX; i++)
-		dmas_id[i] = INVALID_DMA_ID;
-}
-
 /*
  * Main function, does initialisation and calls the per-lcore functions.
  */
@@ -1909,7 +1514,7 @@ main(int argc, char *argv[])
 	struct rte_mempool *mbuf_pool = NULL;
 	unsigned lcore_id, core_id = 0;
 	unsigned nb_ports, valid_num_ports;
-	int ret, i;
+	int ret;
 	uint16_t portid;
 	rte_thread_t tid;
 	uint64_t flags = RTE_VHOST_USER_NET_COMPLIANT_OL_FLAGS;
@@ -1923,9 +1528,6 @@ main(int argc, char *argv[])
 	argc -= ret;
 	argv += ret;
 
-	/* initialize dma structures */
-	reset_dma();
-
 	/* parse app arguments */
 	ret = us_vhost_parse_args(argc, argv);
 	if (ret < 0)
@@ -2004,20 +1606,10 @@ main(int argc, char *argv[])
 	if (client_mode)
 		flags |= RTE_VHOST_USER_CLIENT;
 
-	for (i = 0; i < dma_count; i++) {
-		if (rte_vhost_async_dma_configure(dmas_id[i], 0) < 0) {
-			RTE_LOG(ERR, VHOST_PORT, "Failed to configure DMA in vhost.\n");
-			rte_exit(EXIT_FAILURE, "Cannot use given DMA device\n");
-		}
-	}
-
 	/* Register vhost user driver to handle vhost messages. */
-	for (i = 0; i < nb_sockets; i++) {
+	for (int i = 0; i < nb_sockets; i++) {
 		char *file = socket_files + i * PATH_MAX;
 
-		if (dma_count && get_async_flag_by_socketid(i) != 0)
-			flags = flags | RTE_VHOST_USER_ASYNC_COPY;
-
 		ret = rte_vhost_driver_register(file, flags);
 		if (ret != 0) {
 			unregister_drivers(i);
@@ -2070,14 +1662,6 @@ main(int argc, char *argv[])
 	RTE_LCORE_FOREACH_WORKER(lcore_id)
 		rte_eal_wait_lcore(lcore_id);
 
-	for (i = 0; i < dma_count; i++) {
-		if (rte_vhost_async_dma_unconfigure(dmas_id[i], 0) < 0) {
-			RTE_LOG(ERR, VHOST_PORT,
-				"Failed to unconfigure DMA %d in vhost.\n", dmas_id[i]);
-			rte_exit(EXIT_FAILURE, "Cannot use given DMA device\n");
-		}
-	}
-
 	/* clean up the EAL */
 	rte_eal_cleanup();
 
diff --git a/examples/vhost/main.h b/examples/vhost/main.h
index c986cbc5a9..3cf6bd7f07 100644
--- a/examples/vhost/main.h
+++ b/examples/vhost/main.h
@@ -8,7 +8,6 @@
 #include <sys/queue.h>
 
 #include <rte_ether.h>
-#include <rte_pci.h>
 
 /* Macros for printing using RTE_LOG */
 #define RTE_LOGTYPE_VHOST_CONFIG RTE_LOGTYPE_USER1
@@ -92,17 +91,6 @@ struct lcore_info {
 	struct vhost_dev_tailq_list vdev_list;
 };
 
-struct dma_info {
-	struct rte_pci_addr addr;
-	int16_t dev_id;
-	bool async_enabled;
-};
-
-struct dma_for_vhost {
-	struct dma_info dmas[RTE_MAX_QUEUES_PER_PORT * 2];
-	uint32_t async_flag;
-};
-
 /* we implement non-extra virtio net features */
 #define VIRTIO_NET_FEATURES	0
 
@@ -116,14 +104,9 @@ uint16_t builtin_enqueue_pkts(struct vhost_dev *dev, uint16_t queue_id,
 uint16_t builtin_dequeue_pkts(struct vhost_dev *dev, uint16_t queue_id,
 			struct rte_mempool *mbuf_pool,
 			struct rte_mbuf **pkts, uint16_t count);
-uint16_t sync_enqueue_pkts(struct vhost_dev *dev, uint16_t queue_id,
-			 struct rte_mbuf **pkts, uint32_t count);
-uint16_t sync_dequeue_pkts(struct vhost_dev *dev, uint16_t queue_id,
-			struct rte_mempool *mbuf_pool,
-			struct rte_mbuf **pkts, uint16_t count);
-uint16_t async_enqueue_pkts(struct vhost_dev *dev, uint16_t queue_id,
+uint16_t enqueue_pkts(struct vhost_dev *dev, uint16_t queue_id,
 			 struct rte_mbuf **pkts, uint32_t count);
-uint16_t async_dequeue_pkts(struct vhost_dev *dev, uint16_t queue_id,
+uint16_t dequeue_pkts(struct vhost_dev *dev, uint16_t queue_id,
 			struct rte_mempool *mbuf_pool,
 			struct rte_mbuf **pkts, uint16_t count);
 #endif /* _MAIN_H_ */
diff --git a/examples/vhost/meson.build b/examples/vhost/meson.build
index e938be8f45..a04852bb2f 100644
--- a/examples/vhost/meson.build
+++ b/examples/vhost/meson.build
@@ -12,8 +12,6 @@ if not is_linux
 endif
 
 deps += 'vhost'
-deps += 'dmadev'
-allow_experimental_apis = true
 sources = files(
         'main.c',
         'virtio_net.c',
diff --git a/examples/vhost_crypto/Makefile b/examples/vhost_crypto/Makefile
index cc7f2abb90..130953c38e 100644
--- a/examples/vhost_crypto/Makefile
+++ b/examples/vhost_crypto/Makefile
@@ -6,7 +6,6 @@ APP = vhost-crypto
 
 # all source are stored in SRCS-y
 SRCS-y := main.c
-CFLAGS += -DALLOW_EXPERIMENTAL_API
 
 PKGCONF ?= pkg-config
 
diff --git a/examples/vhost_crypto/main.c b/examples/vhost_crypto/main.c
index 8bdfc40c4b..e196221548 100644
--- a/examples/vhost_crypto/main.c
+++ b/examples/vhost_crypto/main.c
@@ -622,8 +622,7 @@ main(int argc, char *argv[])
 		}
 
 		for (j = 0; j < lo->nb_sockets; j++) {
-			ret = rte_vhost_driver_register(lo->socket_files[j],
-				RTE_VHOST_USER_ASYNC_COPY);
+			ret = rte_vhost_driver_register(lo->socket_files[j], 0);
 			if (ret < 0) {
 				RTE_LOG(ERR, USER1, "socket %s already exists\n",
 					lo->socket_files[j]);
diff --git a/examples/vhost_crypto/meson.build b/examples/vhost_crypto/meson.build
index 1c294c286f..47c8fa829f 100644
--- a/examples/vhost_crypto/meson.build
+++ b/examples/vhost_crypto/meson.build
@@ -6,7 +6,6 @@
 # To build this example as a standalone application with an already-installed
 # DPDK instance, use 'make'
 
-allow_experimental_apis = true
 deps += ['vhost', 'cryptodev']
 sources = files(
         'main.c',
-- 
2.54.0

