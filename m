Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D134C55167
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jul 2026 05:02:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 941E940E1B;
	Fri, 31 Jul 2026 07:00:25 +0200 (CEST)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by mails.dpdk.org (Postfix) with ESMTP id D3B644067C
 for <dev@dpdk.org>; Fri, 31 Jul 2026 07:00:14 +0200 (CEST)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-ca7bea5e5b3so406078a12.1
 for <dev@dpdk.org>; Thu, 30 Jul 2026 22:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785474014;
 x=1786078814; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+rMjPg4GlttfWbZcGo1+h/a9N4mrvcoQ5k1/HRUXQLA=;
 b=T5Hb6dzCIIhRwIOB030B5QVELH0ik4pb0xJVGS3DVpV1SGrZ71wkNZAJbLwmgs7Bac
 VT6VKnvTk5vzVzOQEIs43pbzeqg7uTFN1yc1xfrzbkpG3bvnYe3GRf/om/70RPQe0Vc6
 sFynsItbYC83ttVkF5FbEj2h2UaHdCoWICHYv8Ut3HXuv5dlwiHEc9MFf5J3A3YPZD5Y
 2fVOgZwJHZSe6Sx3Ujj3NPoRsJ/l7+2RAEaQWW4lE01KninJ+ZBr/IWePy0LkNxa0CsG
 rSiBayezrIQRVh+//k7BQh82NHRGmmgOqOabSp8A8M2BwktYzaljI4fQ+1UnZ1EB1KIc
 VuLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785474014; x=1786078814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+rMjPg4GlttfWbZcGo1+h/a9N4mrvcoQ5k1/HRUXQLA=;
 b=TMDCFcPh/rA8XmWrwzEqHd52RELgF01zaZ8LEntvz9vQydr5lvKLgWhkAgDEDXSoz3
 bpdPnRJcgDXjfyiFwAz7olbf4FJTnvVWOMs1WrtWg++sMUsaFoxAmFniGxzCEvG0OkON
 CuPdqydiSkX43pKs5FFEeCA4kCxHT3m0ez0KCStG2pxX+SscB8JTcYIReh3TWYSj0ND8
 RTxwifWDnEv0CN1CCJ9xWRv9iFx7FW7oYHjvGDjlZqNJcE5vXD72g6XNQI1/E9I7RxkF
 Kn9gMhzY2jxWHepgqpU7ajAhZpz/PjX4trMF8u09eFTNAQk1MbExf30IkrYcl8Y091YS
 YrOg==
X-Gm-Message-State: AOJu0Yz8tp387ERWI/1vWyeJ6xAAMHCsR2uuZH3TCvx05DtPRs+Z+zzV
 +ETO5gybw3zNPpRq63CWyBXBCPaq33vIFeXfwpv/1FB054eN+7cgyXIsc2qYR+qMPOA4wwzb2aT
 P/YN0
X-Gm-Gg: AR+sD13ZvdCfJK7rR5dOq3FMpj2Ggq2FeCnWyOxKCSkVNheGMb/RSLudHLevJv6RMfZ
 2SYynQXeF3UBzlpN2SCboG0F9YmEv9nhJD9NUBWaRZfaeLy9xAAXq/0M36sZmfrXsNSsCJvIofz
 mkvyd+ehxWC9fbvIiuiyC7xrqMJcmNCR8qDdxIWlEwvaBda31RCGK5tcZ2F/VBCeOKTgqxxi55a
 QcQEwjlwFUP1V12Wtsb34Idcckw9aBWWykvzaQzZfgo8Q8ynnMXSHTTQPosbIpwHNEQgb8xjphZ
 oFm7iWeQjuFJcLrq7/RB8HwIbI0ympQHVcHwbY8rRmVRWQ323NCwdkJxfc3ARcDwNwSymw1Adof
 uJjdSCyRrpcOy+cfQ/d9e+pdDwfxyKYVU1jfFqOMfBUtbspmg3hhq8RwSesQ0+NAFxW7aKsejn4
 WPRjTGc6OoJYkqzBiRnRXv8IGsS5aS61fiXApbc5pdAaEfhjlmWL60wR7pyEWbbygE7IJVCBbyJ
 CkwXRe3W8yPjVyHe6Et4VcMX1BvAwjdhwQEtPM=
X-Received: by 2002:a05:6a20:da14:b0:3bf:983d:e9b4 with SMTP id
 adf61e73a8af0-3c91b17da81mr467631637.33.1785474013908; 
 Thu, 30 Jul 2026 22:00:13 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153e06f0f9sm823245eec.23.2026.07.30.22.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 22:00:13 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v6 21/24] net/vhost: use stdatomic instead of rte_atomic32
Date: Thu, 30 Jul 2026 21:57:59 -0700
Message-ID: <20260731045948.769926-22-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731045948.769926-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260731045948.769926-1-stephen@networkplumber.org>
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

Factor the per-queue allow_queuing store and while_queuing wait into
a small update_queue() helper used by both rx and tx loops.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/vhost/rte_eth_vhost.c | 103 +++++++++++++++++++-----------
 1 file changed, 65 insertions(+), 38 deletions(-)

diff --git a/drivers/net/vhost/rte_eth_vhost.c b/drivers/net/vhost/rte_eth_vhost.c
index 05940f2461..3b1eedfe42 100644
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
@@ -744,6 +758,19 @@ eth_vhost_unconfigure_intr(struct rte_eth_dev *eth_dev)
 	}
 }
 
+static inline void
+update_queue(struct vhost_queue *vq, uint32_t allow, bool wait_queuing)
+{
+	/* seq_cst: pairs with the data-path's seq_cst store of
+	 * while_queuing and seq_cst load of allow_queuing.  See
+	 * eth_vhost_rx().
+	 */
+	rte_atomic_store_explicit(&vq->allow_queuing, allow, rte_memory_order_seq_cst);
+	if (wait_queuing)
+		rte_wait_until_equal_32((volatile uint32_t *)(uintptr_t)&vq->while_queuing,
+					0, rte_memory_order_seq_cst);
+}
+
 static void
 update_queuing_status(struct rte_eth_dev *dev, bool wait_queuing)
 {
@@ -751,14 +778,18 @@ update_queuing_status(struct rte_eth_dev *dev, bool wait_queuing)
 	struct vhost_queue *vq;
 	struct rte_vhost_vring_state *state;
 	unsigned int i;
-	int allow_queuing = 1;
+	bool allow_queuing = true;
 
 	if (!dev->data->rx_queues || !dev->data->tx_queues)
 		return;
 
-	if (rte_atomic32_read(&internal->started) == 0 ||
-	    rte_atomic32_read(&internal->dev_attached) == 0)
-		allow_queuing = 0;
+	/* These are control-plane flags consulted only here;
+	 * the real data-path handshake is on vq->allow_queuing below.
+	 * Relaxed is sufficient.
+	 */
+	if (rte_atomic_load_explicit(&internal->started, rte_memory_order_relaxed) == 0 ||
+	    rte_atomic_load_explicit(&internal->dev_attached, rte_memory_order_relaxed) == 0)
+		allow_queuing = false;
 
 	state = vring_states[dev->data->port_id];
 
@@ -767,24 +798,18 @@ update_queuing_status(struct rte_eth_dev *dev, bool wait_queuing)
 		vq = dev->data->rx_queues[i];
 		if (vq == NULL)
 			continue;
-		if (allow_queuing && state->cur[vq->virtqueue_id])
-			rte_atomic32_set(&vq->allow_queuing, 1);
-		else
-			rte_atomic32_set(&vq->allow_queuing, 0);
-		while (wait_queuing && rte_atomic32_read(&vq->while_queuing))
-			rte_pause();
+
+		update_queue(vq, !!(allow_queuing && state->cur[vq->virtqueue_id]),
+			     wait_queuing);
 	}
 
 	for (i = 0; i < dev->data->nb_tx_queues; i++) {
 		vq = dev->data->tx_queues[i];
 		if (vq == NULL)
 			continue;
-		if (allow_queuing && state->cur[vq->virtqueue_id])
-			rte_atomic32_set(&vq->allow_queuing, 1);
-		else
-			rte_atomic32_set(&vq->allow_queuing, 0);
-		while (wait_queuing && rte_atomic32_read(&vq->while_queuing))
-			rte_pause();
+
+		update_queue(vq, !!(allow_queuing && state->cur[vq->virtqueue_id]),
+			     wait_queuing);
 	}
 }
 
@@ -848,7 +873,7 @@ new_device(int vid)
 	}
 
 	internal->vid = vid;
-	if (rte_atomic32_read(&internal->started) == 1) {
+	if (rte_atomic_load_explicit(&internal->started, rte_memory_order_relaxed) == 1) {
 		queue_setup(eth_dev, internal);
 		if (dev_conf->intr_conf.rxq)
 			eth_vhost_configure_intr(eth_dev);
@@ -863,7 +888,7 @@ new_device(int vid)
 
 	vhost_dev_csum_configure(eth_dev);
 
-	rte_atomic32_set(&internal->dev_attached, 1);
+	rte_atomic_store_explicit(&internal->dev_attached, 1, rte_memory_order_relaxed);
 	update_queuing_status(eth_dev, false);
 
 	VHOST_LOG_LINE(INFO, "Vhost device %d created", vid);
@@ -893,7 +918,7 @@ destroy_device(int vid)
 	eth_dev = list->eth_dev;
 	internal = eth_dev->data->dev_private;
 
-	rte_atomic32_set(&internal->dev_attached, 0);
+	rte_atomic_store_explicit(&internal->dev_attached, 0, rte_memory_order_relaxed);
 	update_queuing_status(eth_dev, true);
 	eth_vhost_unconfigure_intr(eth_dev);
 
@@ -1148,11 +1173,11 @@ eth_dev_start(struct rte_eth_dev *eth_dev)
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
@@ -1170,7 +1195,7 @@ eth_dev_stop(struct rte_eth_dev *dev)
 	uint16_t i;
 
 	dev->data->dev_started = 0;
-	rte_atomic32_set(&internal->started, 0);
+	rte_atomic_store_explicit(&internal->started, 0, rte_memory_order_relaxed);
 	update_queuing_status(dev, true);
 
 	for (i = 0; i < dev->data->nb_rx_queues; i++)
@@ -1471,8 +1496,10 @@ vhost_dev_priv_dump(struct rte_eth_dev *dev, FILE *f)
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

