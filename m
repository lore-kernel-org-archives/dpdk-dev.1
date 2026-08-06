Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649E3C55ABA
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 03:27:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2AFB40BA5;
	Thu,  6 Aug 2026 05:26:16 +0200 (CEST)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by mails.dpdk.org (Postfix) with ESMTP id 77D2D40DD5
 for <dev@dpdk.org>; Thu,  6 Aug 2026 05:26:11 +0200 (CEST)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-c9eefcf9175so1553567a12.3
 for <dev@dpdk.org>; Wed, 05 Aug 2026 20:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785986770;
 x=1786591570; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XT8YOf8a1+B59z95moLpVN2Lfv0ITvACtleTQ59MkC8=;
 b=KTMs8Tx0AM1X/Lhq/N4xTngZ4FfZx1pXuL4PTObb04vPchbOJY3XQ9FAyjLJHBAMrx
 ocngx87jWu8Cq8hgB72vIUCgUM8zMLdMX/9lnK+UP6N7yg4RhUemWjxtsnsLOckDATYb
 yr11MkY2rlWsyRfTUtPm1uPCYeSbNd+05Iwy2dT5oa8OQiIt+z2FaKujZ9QATktPdQHC
 90a7fUZIfXvxEpxyv/h9CPoa7zvjCAL57Cphi7CwD1Fg28vT8pCe47E8pgxDiCSIwzFb
 PJyyz3yx4+/+uS1dIZwzvpWx3X/ObBqlPZcVuvDFs0OvsfgaFjPEi7H2d9Y5YauxHuRq
 HQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785986770; x=1786591570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XT8YOf8a1+B59z95moLpVN2Lfv0ITvACtleTQ59MkC8=;
 b=ckA7mb9D7YMvPSDwOT6rwZvo8hNVKYBwVOZL6dDGdGk8TUOZGH6HqJ5mF4iFH+SS0K
 j/el9NfwW3xnQeGc/Lx0mWsB95On0d8db08yjJkm80o2NsAqCGM3oVmTBNtS0HRlkPb3
 nuP5HlQOH0IMKT01FbSPiDTK1rFeMj7ikP0VJ8LO/tETRrNZ9avPhNe5VpathBrcajnq
 Wj0TXCXNKIQLRhj7iTkIIkuWypasn68CkemAgZIMpwtFEbmAAgWOAa7Z9lEM4MKrQ30B
 guy1qhL5RIBD/P3x5IHn7zhjsVtff8TkOHbTYL7Lx4FDZuPqS6EEu2RyS4d0s7ETnHAT
 ecPw==
X-Gm-Message-State: AOJu0YzkuCSqf9z9mg1HzeY0OlU0xD072O+B2OyTwNDc95eor+WqlS9w
 d6k88T6M65/iIamaxuS1QPF4aZ3+ISTbx8fPj0eLn3Fcto9okGaM0DWSVWaq3nr/2yixR2iIQw1
 WFQzb3eY=
X-Gm-Gg: AR+sD12B7BjFuGucNzc51QIkA8IeD6Aq+UxAxTRBNxKw8czikf2qY2kfOqaEJ5v20nQ
 YFWZmtWq4gv1ZfJiAJwoietENt6agt0jo1Y8BmswrYIPZZcdupQ8poIJK4pbCza7CQYczqCXdBX
 MkybYqLAcJuc7NE/fou4wThNu712Du4zzld00uINPyoMterxpDMDp2Bu1kqkQOpsvoVv93/EFrE
 bazvmFVjYIw/ADDjKvIFcTM+hAEmDfq57H2cCOQ43Sxa0ZCAheLv+auDGPnVVOEU/Vm9b2w0oGe
 MH5RlLvNRX73auqqWx8ps7RnH/MMoSLKIyXiAh53JIMUczcgIt163bVR8+PUZoGPTiYInDC0X9D
 s5/tm8q/9BTLz/pp72lPIbaeRPmBYjvR8ptbfDvIwks5pb8wpW3Tmvuo53npD/1lB+mfrerw/e8
 ORoHo3/3RtBJkLEseijRt8y5VG0QmkVk+MABHUk9axEz6YGBzDlR/CzBRY4ChJURIuT4if0XXEk
 RNtPb1KKv9bWB4lKlavND3/TnTDPiVuNM3Kzw==
X-Received: by 2002:a05:6a21:46c9:b0:3c3:6528:c87 with SMTP id
 adf61e73a8af0-3cb85dcc76emr14249165637.1.1785986770606; 
 Wed, 05 Aug 2026 20:26:10 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863b0c61sm23301631eec.6.2026.08.05.20.26.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 20:26:10 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v7 21/24] net/vhost: use stdatomic instead of rte_atomic32
Date: Wed,  5 Aug 2026 20:23:13 -0700
Message-ID: <20260806032544.21337-22-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806032544.21337-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260806032544.21337-1-stephen@networkplumber.org>
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

Convert allow_queuing, while_queuing, started, and dev_attached from
rte_atomic32_t to RTE_ATOMIC(uint32_t) and replace rte_atomic32_*()
with rte_atomic_*_explicit().

The data-path / control-thread handshake on allow_queuing and
while_queuing is a Dekker-style mutual-visibility pattern: each side
stores its own flag and then loads the peer's. Both legs must be
seq_cst to forbid store-load reordering; anything weaker permits both
sides to miss each other. The previous rte_atomic32_set/read compiled
to plain volatile stores/loads and provided no such ordering, so this
also closes a latent ordering hole on weakly-ordered ISAs.

The data-path exit store of while_queuing=0 is release, ordering
preceding slot accesses before the control thread observes the data
path as idle.

The flags started and dev_attached are consulted only inside
update_queuing_status, where the per-queue handshake provides the
real synchronization; their loads and stores are relaxed.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/vhost/rte_eth_vhost.c | 92 +++++++++++++++++++------------
 1 file changed, 58 insertions(+), 34 deletions(-)

diff --git a/drivers/net/vhost/rte_eth_vhost.c b/drivers/net/vhost/rte_eth_vhost.c
index 05940f2461..2acf670c94 100644
--- a/drivers/net/vhost/rte_eth_vhost.c
+++ b/drivers/net/vhost/rte_eth_vhost.c
@@ -73,8 +73,8 @@ struct vhost_stats {
 
 struct vhost_queue {
 	int vid;
-	rte_atomic32_t allow_queuing;
-	rte_atomic32_t while_queuing;
+	RTE_ATOMIC(uint32_t) allow_queuing;
+	RTE_ATOMIC(uint32_t) while_queuing;
 	struct pmd_internal *internal;
 	struct rte_mempool *mb_pool;
 	uint16_t port;
@@ -86,14 +86,14 @@ struct vhost_queue {
 };
 
 struct pmd_internal {
-	rte_atomic32_t dev_attached;
+	RTE_ATOMIC(uint32_t) dev_attached;
 	char *iface_name;
 	uint64_t flags;
 	uint64_t disable_flags;
 	uint64_t features;
 	uint16_t max_queues;
 	int vid;
-	rte_atomic32_t started;
+	RTE_ATOMIC(uint32_t) started;
 	bool vlan_strip;
 	bool rx_sw_csum;
 	bool tx_sw_csum;
@@ -406,12 +406,19 @@ eth_vhost_rx(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
 	uint16_t i, nb_rx = 0;
 	uint16_t nb_receive = nb_bufs;
 
-	if (unlikely(rte_atomic32_read(&r->allow_queuing) == 0))
+	/* Fast-path early exit; racy load is fine here -- if we miss a
+	 * transition we get caught by the seq_cst check below.
+	 */
+	if (unlikely(rte_atomic_load_explicit(&r->allow_queuing, rte_memory_order_relaxed) == 0))
 		return 0;
 
-	rte_atomic32_set(&r->while_queuing, 1);
-
-	if (unlikely(rte_atomic32_read(&r->allow_queuing) == 0))
+	/* Announce presence, then re-check. The store and the following
+	 * load MUST both be seq_cst so they are totally ordered with the
+	 * control thread's store-to-allow_queuing / load-of-while_queuing
+	 * pair. Anything weaker permits both sides to miss each other.
+	 */
+	rte_atomic_store_explicit(&r->while_queuing, 1, rte_memory_order_seq_cst);
+	if (unlikely(rte_atomic_load_explicit(&r->allow_queuing, rte_memory_order_seq_cst) == 0))
 		goto out;
 
 	/* Dequeue packets from guest TX queue */
@@ -446,7 +453,7 @@ eth_vhost_rx(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
 	}
 
 out:
-	rte_atomic32_set(&r->while_queuing, 0);
+	rte_atomic_store_explicit(&r->while_queuing, 0, rte_memory_order_release);
 
 	return nb_rx;
 }
@@ -460,12 +467,19 @@ eth_vhost_tx(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
 	uint64_t nb_bytes = 0;
 	uint64_t nb_missed = 0;
 
-	if (unlikely(rte_atomic32_read(&r->allow_queuing) == 0))
+	/* Fast-path early exit; racy load is fine here -- if we miss a
+	 * transition we get caught by the seq_cst check below.
+	 */
+	if (unlikely(rte_atomic_load_explicit(&r->allow_queuing, rte_memory_order_relaxed) == 0))
 		return 0;
 
-	rte_atomic32_set(&r->while_queuing, 1);
-
-	if (unlikely(rte_atomic32_read(&r->allow_queuing) == 0))
+	/* Announce presence, then re-check. The store and the following
+	 * load MUST both be seq_cst so they are totally ordered with the
+	 * control thread's store-to-allow_queuing / load-of-while_queuing
+	 * pair. Anything weaker permits both sides to miss each other.
+	 */
+	rte_atomic_store_explicit(&r->while_queuing, 1, rte_memory_order_seq_cst);
+	if (unlikely(rte_atomic_load_explicit(&r->allow_queuing, rte_memory_order_seq_cst) == 0))
 		goto out;
 
 	for (i = 0; i < nb_bufs; i++) {
@@ -515,7 +529,7 @@ eth_vhost_tx(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
 	for (i = 0; likely(i < nb_tx); i++)
 		rte_pktmbuf_free(bufs[i]);
 out:
-	rte_atomic32_set(&r->while_queuing, 0);
+	rte_atomic_store_explicit(&r->while_queuing, 0, rte_memory_order_release);
 
 	return nb_tx;
 }
@@ -756,8 +770,12 @@ update_queuing_status(struct rte_eth_dev *dev, bool wait_queuing)
 	if (!dev->data->rx_queues || !dev->data->tx_queues)
 		return;
 
-	if (rte_atomic32_read(&internal->started) == 0 ||
-	    rte_atomic32_read(&internal->dev_attached) == 0)
+	/* These are control-plane flags consulted only here;
+	 * the real data-path handshake is on vq->allow_queuing below.
+	 * Relaxed is sufficient.
+	 */
+	if (rte_atomic_load_explicit(&internal->started, rte_memory_order_relaxed) == 0 ||
+	    rte_atomic_load_explicit(&internal->dev_attached, rte_memory_order_relaxed) == 0)
 		allow_queuing = 0;
 
 	state = vring_states[dev->data->port_id];
@@ -767,11 +785,13 @@ update_queuing_status(struct rte_eth_dev *dev, bool wait_queuing)
 		vq = dev->data->rx_queues[i];
 		if (vq == NULL)
 			continue;
-		if (allow_queuing && state->cur[vq->virtqueue_id])
-			rte_atomic32_set(&vq->allow_queuing, 1);
-		else
-			rte_atomic32_set(&vq->allow_queuing, 0);
-		while (wait_queuing && rte_atomic32_read(&vq->while_queuing))
+
+		rte_atomic_store_explicit(&vq->allow_queuing,
+					  (allow_queuing && state->cur[vq->virtqueue_id]),
+					  rte_memory_order_seq_cst);
+
+		while (wait_queuing &&
+		       rte_atomic_load_explicit(&vq->while_queuing, rte_memory_order_seq_cst))
 			rte_pause();
 	}
 
@@ -779,11 +799,13 @@ update_queuing_status(struct rte_eth_dev *dev, bool wait_queuing)
 		vq = dev->data->tx_queues[i];
 		if (vq == NULL)
 			continue;
-		if (allow_queuing && state->cur[vq->virtqueue_id])
-			rte_atomic32_set(&vq->allow_queuing, 1);
-		else
-			rte_atomic32_set(&vq->allow_queuing, 0);
-		while (wait_queuing && rte_atomic32_read(&vq->while_queuing))
+
+		rte_atomic_store_explicit(&vq->allow_queuing,
+					  (allow_queuing && state->cur[vq->virtqueue_id]),
+					  rte_memory_order_seq_cst);
+
+		while (wait_queuing &&
+		       rte_atomic_load_explicit(&vq->while_queuing, rte_memory_order_seq_cst))
 			rte_pause();
 	}
 }
@@ -848,7 +870,7 @@ new_device(int vid)
 	}
 
 	internal->vid = vid;
-	if (rte_atomic32_read(&internal->started) == 1) {
+	if (rte_atomic_load_explicit(&internal->started, rte_memory_order_relaxed) == 1) {
 		queue_setup(eth_dev, internal);
 		if (dev_conf->intr_conf.rxq)
 			eth_vhost_configure_intr(eth_dev);
@@ -863,7 +885,7 @@ new_device(int vid)
 
 	vhost_dev_csum_configure(eth_dev);
 
-	rte_atomic32_set(&internal->dev_attached, 1);
+	rte_atomic_store_explicit(&internal->dev_attached, 1, rte_memory_order_relaxed);
 	update_queuing_status(eth_dev, false);
 
 	VHOST_LOG_LINE(INFO, "Vhost device %d created", vid);
@@ -893,7 +915,7 @@ destroy_device(int vid)
 	eth_dev = list->eth_dev;
 	internal = eth_dev->data->dev_private;
 
-	rte_atomic32_set(&internal->dev_attached, 0);
+	rte_atomic_store_explicit(&internal->dev_attached, 0, rte_memory_order_relaxed);
 	update_queuing_status(eth_dev, true);
 	eth_vhost_unconfigure_intr(eth_dev);
 
@@ -1148,11 +1170,11 @@ eth_dev_start(struct rte_eth_dev *eth_dev)
 	}
 
 	queue_setup(eth_dev, internal);
-	if (rte_atomic32_read(&internal->dev_attached) == 1 &&
+	if (rte_atomic_load_explicit(&internal->dev_attached, rte_memory_order_relaxed) == 1 &&
 			dev_conf->intr_conf.rxq)
 		eth_vhost_configure_intr(eth_dev);
 
-	rte_atomic32_set(&internal->started, 1);
+	rte_atomic_store_explicit(&internal->started, 1, rte_memory_order_relaxed);
 	update_queuing_status(eth_dev, false);
 
 	for (i = 0; i < eth_dev->data->nb_rx_queues; i++)
@@ -1170,7 +1192,7 @@ eth_dev_stop(struct rte_eth_dev *dev)
 	uint16_t i;
 
 	dev->data->dev_started = 0;
-	rte_atomic32_set(&internal->started, 0);
+	rte_atomic_store_explicit(&internal->started, 0, rte_memory_order_relaxed);
 	update_queuing_status(dev, true);
 
 	for (i = 0; i < dev->data->nb_rx_queues; i++)
@@ -1471,8 +1493,10 @@ vhost_dev_priv_dump(struct rte_eth_dev *dev, FILE *f)
 	fprintf(f, "features: 0x%" PRIx64 "\n", internal->features);
 	fprintf(f, "max_queues: %u\n", internal->max_queues);
 	fprintf(f, "vid: %d\n", internal->vid);
-	fprintf(f, "started: %d\n", rte_atomic32_read(&internal->started));
-	fprintf(f, "dev_attached: %d\n", rte_atomic32_read(&internal->dev_attached));
+	fprintf(f, "started: %u\n",
+		rte_atomic_load_explicit(&internal->started, rte_memory_order_relaxed));
+	fprintf(f, "dev_attached: %u\n",
+		rte_atomic_load_explicit(&internal->dev_attached, rte_memory_order_relaxed));
 	fprintf(f, "vlan_strip: %d\n", internal->vlan_strip);
 	fprintf(f, "rx_sw_csum: %d\n", internal->rx_sw_csum);
 	fprintf(f, "tx_sw_csum: %d\n", internal->tx_sw_csum);
-- 
2.53.0

