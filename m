Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96DCCA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 14:06:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5CE442E95;
	Tue, 29 Sep 2026 16:04:46 +0200 (CEST)
Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com
 [74.125.228.40]) by mails.dpdk.org (Postfix) with ESMTP id 58FC542D78
 for <dev@dpdk.org>; Tue, 29 Sep 2026 16:04:36 +0200 (CEST)
Received: by mail-pz2-f40.google.com with SMTP id
 d2e1a72fcca58-87fd84c0bfeso1686470b3a.3
 for <dev@dpdk.org>; Tue, 29 Sep 2026 07:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790690675;
 x=1791295475; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9EgBCZE+YnzT/yEsPJIsJckOsW3rZl0EXnceCgReRo4=;
 b=WDKFKrxz4PpjPAstAObVTU6FRJNxQxwS5EC7ADL1aD/MfhtbTKBZhBldan8urZ39Vu
 8srjLSKQPFgFbexbkaHly1N40dHY6SgLUE32MKtdQ+rHFzLOhdh4x5Ibi5dNBoKefEYn
 KoWFntTVzyRmBWK6XsObg/J0sOcc+NAhjCWWfumuZ517GP/l/AxFDNBmLsxjjdiM5wDQ
 E6KFHV57rXw5dHVqGbfVDYbmOmzji6iyGj+hRRdp7/7rGSuGfsA6WUXWqdlkn40qYnEq
 8GW8Cr7gMigEU3PZ8sEWFBZstrBhnQ5Cu7oO6mUyYizcwUiK+YhiYkeEkwbSbIHa+hRv
 z1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790690675; x=1791295475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9EgBCZE+YnzT/yEsPJIsJckOsW3rZl0EXnceCgReRo4=;
 b=14aJV+3YSgK42OHjeUDXkwOlwI+V7XscTyJ9uHjrycOop4XF+UEoYj38Vcwi7cagok
 5iNzROT6Oax9PHbZKkqF6s9jbCYHpZFGxkz/kQqF64OcrbpRydYE+TM8WbXNt1vm8m7f
 qZCm65AMJO5h/+XJnTPvOzk8yUdbvlrRzsCc0T7ZofqS0vKijk6vH8sZYO/PTkYV8arP
 KzE/IQJHlbJPLdWaCwJN7tRxFTtHSEKmL4CFVtcc2dT2dB2BZDzGNmKYFHi9CL0a4RM3
 0+ir3juzuDUMfFncGydxIPTHbx5PNoQvcJed4Uc7qvaxZbTy/hNrvD5XtAj4SJj2Id3f
 Z7rg==
X-Gm-Message-State: AFuF++mcKbWZ8J0cqpwd35cPSq5/ttaF1JJRoM1XLJBIDNK3MN2y0uZk
 0zV10jGa1EipGZfZlkDn50BcbirInS+WdmcKeVPwH6j8PWmCCPRwN3JI2C6S2a9JRRKatHMFuPU
 a2XyXuYs=
X-Gm-Gg: AYBFou002H9fYEuou58D9zkKQMx/dKljpGykXpT+60qV6VygCshxNPpWX/MmUSBy/qM
 yYAU2N6zLI2P/njyRz2pezw8OpgUV92CQFQFYxPWoivNHsfqX7gfAh5JbqJyTWhG39iB3ePkbNv
 TCws7yTRZ809OJnwiTfKsG660LgyEKoVB7GVCP92NWNSliCmlSrFOUljJA0v22dQGE5CBzlia+F
 fyGXzGiljr54LgexkZg/XhYkPVc59HAO/2/BVw+sxEi9Dbr+NiRVZ9VB4bSPyBQToZTBwbQKfcM
 U0dIW1k7aLzAZYy1QTWVWYhFzIr7qjJ7bfAMjZbzxtREMshF1+2FqM9rn4C1srqhCiFvB8z4drW
 oC0qvF+DBjc4rhEroQJeBKT+jOn4f85yxXkcBIDP9BVOklObU7JVggTmPapl0aVG938aEvbRDsW
 Acu1Lh1RYfnZxmAn11u+ijVlKI2SVVSsK5cdj5DiH4+YhvYV17p9JLyQ7ZElrWlobzYhnfpdqnv
 7L7NYvgkCgKE/Giu+65EZKRQhuWlqM20gz/mQ==
X-Received: by 2002:a05:6a00:ad8a:b0:877:d02a:42f2 with SMTP id
 d2e1a72fcca58-87e987888a1mr12858979b3a.7.1790690675440; 
 Tue, 29 Sep 2026 07:04:35 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-885e1066470sm998330b3a.18.2026.09.29.07.04.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 07:04:34 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v9 22/25] net/vhost: use stdatomic instead of rte_atomic32
Date: Tue, 29 Sep 2026 07:02:08 -0700
Message-ID: <20260929140409.234453-23-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929140409.234453-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260929140409.234453-1-stephen@networkplumber.org>
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

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/vhost/rte_eth_vhost.c | 62 ++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 22 deletions(-)

diff --git a/drivers/net/vhost/rte_eth_vhost.c b/drivers/net/vhost/rte_eth_vhost.c
index 07d3d15781..f7425d04e6 100644
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
@@ -771,11 +785,13 @@ update_queuing_status(struct rte_eth_dev *dev, bool wait_queuing)
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
 
@@ -783,11 +799,13 @@ update_queuing_status(struct rte_eth_dev *dev, bool wait_queuing)
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
-- 
2.53.0

