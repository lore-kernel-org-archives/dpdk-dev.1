Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CC4606A319
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 07:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=DRbTAWCW
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DEBE540615;
	Tue, 20 Oct 2026 09:40:23 +0200 (CEST)
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mails.dpdk.org (Postfix) with ESMTP id 15D754021E
 for <dev@dpdk.org>; Mon, 19 Oct 2026 22:20:08 +0200 (CEST)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-536466909b7so40875891cf.0
 for <dev@dpdk.org>; Mon, 19 Oct 2026 13:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792441207; x=1793046007; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8BnoGlNYMYuEWfWr5hXhEpkcdzI1f1w787ECrLfRpjU=;
 b=DRbTAWCWBX1gZbbD92y77ZbFXK4doQNL6jGFk8JiXSyIDCtWCTadhhF/WvUpKHYTBP
 e25G/JbcbFdYSDfdO1VRRI22r+w9gaOkBogp0RvtWTqjjMCJhqvH4LYsCfBODbTd/Oha
 IVa4XYwNnGwuzvIjCcOU8rZzFRu7VNJc8NOlHEGWl4qLmLIR1Dqj3WWiH67/7WJIlYI9
 ntc4H+P/J9xqg7EP8LNlJIciXLZ3KdTNhOpgR4AIPmq7DMbO3TrP5k0dipkHiVwYaLHe
 iol0uPjvUinvdCyi9HQbFljt+FaYbYzKM48tviA4iHjgV5gkiKpiaxE3ZbPJNARAP/ra
 5vEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792441207; x=1793046007;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8BnoGlNYMYuEWfWr5hXhEpkcdzI1f1w787ECrLfRpjU=;
 b=uEwTya2YwOCj0gWMVUgA45h+57ESFy01mWsJshvpW3+tCwFI2aRK1whqM4EzEj+/ax
 F4AvCAGItD9s6DmFRMWsURmyIXI08w0Dg0zmfXtWvMkUIpkH2tcWcx1p0T3wmEq5OvyN
 dx3QdS9zQXVxwR3YIg39yh4s6qxsTRxJmPuHu59csEB/isw3vMHCfCiUxzRjvBtZ5vMJ
 ehe2SxGkCsGQn1koqkQ9E0nNzdAekZIJO/pvdnSw9LIPmMjzZvMZOcZ4+fBJjsA+kG1G
 dChL/NVCiNkDWhh9NFZUH0MoLvvCGHfRxwZjwlaiYaK4V8NkVGXKtWgVFCJkm8qH8dSQ
 bE4Q==
X-Gm-Message-State: AFq9FYKechlaRQP4bVByTuLnk4BLIA+5PaZ9YZWkl1koOL743noTemYS
 P/h44G1msaliAFssZyBZQpG//GBuBKbr6CfEpqtyR9YB+qZtK1JoOeJH5P1ggdLfnbuv1GHnND7
 XE+UH3tOqD8SBlRxFagqvV2Ui43mPLsCGWauiKSAOr3vlYfyKoYglFrfJ/aaOpPJ/lxYeULCs6b
 kYy8gGU+oHXN99BCBjAnRZUGEpSnPY
X-Received: from qtpf3.prod.google.com ([2002:ac8:4703:0:b0:536:52e6:fd86])
 (user=rnwolfe job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:581a:b0:535:28bf:5561
 with SMTP id d75a77b69052e-53645bfdc73mr126350551cf.6.1792441206697; Mon, 19
 Oct 2026 13:20:06 -0700 (PDT)
Date: Mon, 19 Oct 2026 16:20:04 -0400
In-Reply-To: <cover.1792439728.git.rnwolfe@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261019022824.189319-1-rnwolfe@google.com>
 <cover.1792439728.git.rnwolfe@google.com>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <81db29a41dd8190c95aa1ea977c59a3dfc87f062.1792439728.git.rnwolfe@google.com>
Subject: [PATCH v2 2/2] net/gve: refuse an MTU that needs Rx scatter when it
 is off
From: Ryan Wolfe <rnwolfe@google.com>
To: dev@dpdk.org
Cc: joshwash@google.com, stephen@networkplumber.org, stable@dpdk.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 20 Oct 2026 09:40:21 +0200
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

GQI chains a frame larger than one Rx buffer into a multi-segment mbuf
whether or not the application enabled RTE_ETH_RX_OFFLOAD_SCATTER, so
an application that did not ask for scatter can still receive chained
mbufs once the MTU exceeds the Rx buffer.

Refuse such a configuration on GQI. Rx queue setup fails when the
current MTU plus the Ethernet header and the GVE_RX_PAD bytes ahead of
the frame does not fit in the queue's Rx buffer, and an MTU change
fails on the same test against each configured Rx queue. The buffer
length comes from one helper shared with queue setup, so the check
matches the size the device is given. DQO is unchanged.

Fixes: 496d4d2c8b54 ("net/gve: support jumbo frame for GQI")
Cc: stable@dpdk.org

Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Ryan Wolfe <rnwolfe@google.com>
---
 drivers/net/gve/gve_ethdev.c | 18 ++++++++++++++++++
 drivers/net/gve/gve_ethdev.h |  9 +++++++++
 drivers/net/gve/gve_rx.c     | 31 +++++++++++++++++++++++++------
 3 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index 92a5a7679f..e47ec0c55b 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -1031,6 +1031,24 @@ gve_dev_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
 		return -EBUSY;
 	}
 
+	/* GQI chains a frame larger than one Rx buffer into a multi-segment
+	 * mbuf. No Rx offload is per-queue here, so check the port offloads.
+	 */
+	if (gve_is_gqi(priv) &&
+	    !(dev->data->dev_conf.rxmode.offloads & RTE_ETH_RX_OFFLOAD_SCATTER)) {
+		for (uint16_t i = 0; i < dev->data->nb_rx_queues; i++) {
+			struct gve_rx_queue *rxq = dev->data->rx_queues[i];
+
+			if (rxq != NULL &&
+			    gve_rx_gqi_needs_scatter(mtu, rxq->rx_buf_len)) {
+				PMD_DRV_LOG(ERR,
+					    "MTU %u needs Rx scatter with %u byte Rx buffers",
+					    mtu, rxq->rx_buf_len);
+				return -EINVAL;
+			}
+		}
+	}
+
 	err = process_priv->ctrl_ops->set_mtu(priv, mtu);
 	if (err) {
 		PMD_DRV_LOG(ERR, "Failed to set mtu as %u err = %d", mtu, err);
diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
index 19eac9ec0b..f4b72a9159 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -454,6 +454,15 @@ gve_is_gqi(struct gve_priv *priv)
 		priv->queue_format == GVE_GQI_QPL_FORMAT;
 }
 
+/* GQI places GVE_RX_PAD bytes ahead of the frame in its first Rx buffer
+ * and chains the rest of a larger frame into further buffers.
+ */
+static inline bool
+gve_rx_gqi_needs_scatter(uint16_t mtu, uint16_t rx_buf_len)
+{
+	return (uint32_t)mtu + RTE_ETHER_HDR_LEN + GVE_RX_PAD > rx_buf_len;
+}
+
 static inline bool
 gve_get_admin_queue_ok(struct gve_priv *priv)
 {
diff --git a/drivers/net/gve/gve_rx.c b/drivers/net/gve/gve_rx.c
index 09f9d8d480..4a455b3067 100644
--- a/drivers/net/gve/gve_rx.c
+++ b/drivers/net/gve/gve_rx.c
@@ -297,6 +297,16 @@ gve_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
 	dev->data->rx_queues[qid] = NULL;
 }
 
+static uint16_t
+gve_rx_buf_len_gqi(struct rte_mempool *pool)
+{
+	uint32_t mbuf_len =
+		rte_pktmbuf_data_room_size(pool) - RTE_PKTMBUF_HEADROOM;
+
+	return RTE_MIN((uint16_t)GVE_RX_MAX_BUF_SIZE_GQI,
+		       RTE_ALIGN_FLOOR(mbuf_len, GVE_RX_BUF_ALIGN_GQI));
+}
+
 int
 gve_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id,
 		uint16_t nb_desc, unsigned int socket_id,
@@ -306,7 +316,8 @@ gve_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id,
 	const struct rte_memzone *mz;
 	struct gve_rx_queue *rxq;
 	uint16_t free_thresh;
-	uint32_t mbuf_len;
+	uint16_t rx_buf_len;
+	uint64_t offloads;
 	int err = 0;
 
 	/* Ring size is required to be a power of two. */
@@ -316,6 +327,18 @@ gve_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id,
 		return -EINVAL;
 	}
 
+	/* A frame larger than one Rx buffer is chained into a multi-segment
+	 * mbuf, which the application must have asked for.
+	 */
+	offloads = dev->data->dev_conf.rxmode.offloads | conf->offloads;
+	rx_buf_len = gve_rx_buf_len_gqi(pool);
+	if (!(offloads & RTE_ETH_RX_OFFLOAD_SCATTER) &&
+	    gve_rx_gqi_needs_scatter(dev->data->mtu, rx_buf_len)) {
+		PMD_DRV_LOG(ERR, "MTU %u needs Rx scatter with %u byte Rx buffers",
+			    dev->data->mtu, rx_buf_len);
+		return -EINVAL;
+	}
+
 	/* Free memory if needed. */
 	if (dev->data->rx_queues[queue_id]) {
 		gve_rx_queue_release(dev, queue_id);
@@ -351,11 +374,7 @@ gve_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id,
 	rxq->hw = hw;
 	rxq->ntfy_addr = &hw->db_bar[rte_be_to_cpu_32(hw->irq_dbs[rxq->ntfy_id].id)];
 
-	mbuf_len =
-		rte_pktmbuf_data_room_size(rxq->mpool) - RTE_PKTMBUF_HEADROOM;
-	rxq->rx_buf_len =
-		RTE_MIN((uint16_t)GVE_RX_MAX_BUF_SIZE_GQI,
-			RTE_ALIGN_FLOOR(mbuf_len, GVE_RX_BUF_ALIGN_GQI));
+	rxq->rx_buf_len = rx_buf_len;
 
 	/* Allocate software ring */
 	rxq->sw_ring = rte_zmalloc_socket("gve rx sw ring", sizeof(struct rte_mbuf *) * nb_desc,
-- 
2.56.0.218.g1ec904b173-goog

