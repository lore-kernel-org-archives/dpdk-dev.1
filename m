Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E650B606A322
	for <dpdk-dev@archiver.kernel.org>; Sat, 24 Oct 2026 16:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=OHu6EGUf
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5F7D40658;
	Sat, 24 Oct 2026 18:47:09 +0200 (CEST)
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mails.dpdk.org (Postfix) with ESMTP id 1FA6240264
 for <dev@dpdk.org>; Thu, 22 Oct 2026 23:28:21 +0200 (CEST)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93dd3c3badbso48612485a.2
 for <dev@dpdk.org>; Thu, 22 Oct 2026 14:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792704500; x=1793309300; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lKdZZQ5SB0CGE+MGLIsJYiV+DX4PkR5deVC3mLoGoVo=;
 b=OHu6EGUfCzt0RIPoGFG3cIk4SKnYNjYineJ8aosZQ13ORsSSNb7vvfvLS4ph9cthaL
 5XaH++ToIOJhxE+L/cFbgqa23LGsca9W6y0hpLiOCgGitwBhttlxLQEW/1VhZpO16+Om
 A1UxWA+N/dEFOgXJ3VadH3QH1Gzg8Eo9jKpEbNTm/dDfYKv9Fj8sU2w6ABkHF3EZZ7oy
 lZCASRUhROjyenRCJ7cF1h4bl+iDOAGkR5xrehcRdJL0+AOVlc0PSuIjhUVhXK1f3iRC
 OD7o7gLW60UiGmBsrWqw1Dpy79WO7kypaZB6nxL4lvHKNxTWLSxdAi2KaiSSTXy5quHa
 uJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792704500; x=1793309300;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lKdZZQ5SB0CGE+MGLIsJYiV+DX4PkR5deVC3mLoGoVo=;
 b=ylIuBw+LpKYzOgJTMTAEFhShxVi2pY71eWT4tOyo7rdNDYNqLDVN+b+k6KXvGRk5xQ
 m6e/4IoNg7pLF49faphKoIqJWnllqPo3MgHvaiY59laYm/tTdkg0e+WQVEe5oG9gMgBB
 rONtfU7dwpCMuRyYpxXor11kHzMQyuPFwhOTd3jmNeEzLjIKtAkhCBkJ6feG1R2cjOv9
 TkL26UKxTA+UgZTMhXz6iwhXJmo/BcHPWcNKftXo7dzEeHZGxW0rOe5lR0VBTxP2NOwl
 ByYHb+wuQ5JoGYoWbgNDbXjHYTz0tbBX59hZhBbrkL2B0wGIFbxapati8I7DOc+KeGFW
 Zu9w==
X-Gm-Message-State: AFq9FYL0Ax2zTpoPHYrW+Z+l7kTJftf6cOBqU3+vBdQiC3bpFtCiek0i
 E2pQFUMFU8AYfKJckCkexEpiBl+CbOUwI1HaxsgEsEQHvqfJJWopxaXMq9BhYQJQsJekBWtL0nC
 FGfn0V1z2fsV+MXdGyQZStR2ZfM68fVJRLUX9aC+H8FxvuOPoeENbzuVRSm+jak4wjOliyMgktR
 Gocv4vR/8HlVTquw0v6TNIGTvHa/gi
X-Received: from qvbm18.prod.google.com ([2002:a05:6214:8412:b0:918:74d8:1f24])
 (user=rnwolfe job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2b4e:b0:93f:3285:1f38
 with SMTP id af79cd13be357-93f6f868069mr123966385a.77.1792704499825; Thu, 22
 Oct 2026 14:28:19 -0700 (PDT)
Date: Thu, 22 Oct 2026 17:28:18 -0400
In-Reply-To: <20261022100049.7a318767@phoenix.local>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261022100049.7a318767@phoenix.local>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261022212819.1750996-1-rnwolfe@google.com>
Subject: [PATCH v2] net/gve: enforce the Rx scatter offload in GQI
From: Ryan Wolfe <rnwolfe@google.com>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, joshwash@google.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 24 Oct 2026 18:47:07 +0200
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

rte_eth_dev_configure() sets the MTU from rxmode.mtu without calling
mtu_set, and keeps Rx queues that are already set up. Stopping the port
and reconfiguring it with a larger MTU, or without
RTE_ETH_RX_OFFLOAD_SCATTER, therefore skipped both the MTU change check
and the Rx queue setup check. gve also never gave the device that MTU.

Even with the MTU programmed, a GQI device does not limit what it
receives to it: on a network with a larger MTU it still delivers
bigger frames, chained over several Rx buffers. So the configuration
checks alone cannot keep chained mbufs from an application that did
not enable scatter.

Move the configuration check into gve_rx_check_scatter() and call it
from gve_dev_start() as well as gve_dev_mtu_set(), program the
configured MTU into the device at start, and have the GQI Rx path drop
a frame that spans more than one buffer, counted in the Rx errors,
when the port has not enabled scatter. A dropped descriptor's mbuf is
now freed, since the refill replaces it.

Fixes: cffdca824388 ("net/gve: refuse an MTU that needs Rx scatter when it is off")

Reported-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Ryan Wolfe <rnwolfe@google.com>
---
v2:
- program the configured MTU into the device at start (Stephen)
- on GQI-QPL hardware the device does not enforce the driver MTU on Rx:
  8000-byte frames still arrive chained over 4 buffers at MTU 1500, so
  also drop and count chained frames in the Rx path when scatter is off,
  and free a dropped descriptor's mbuf
- retitled from "net/gve: check the Rx scatter MTU at device start"
- commit message fix and no Cc: stable (Stephen)

Tested on a GQI-QPL gVNIC with testpmd. At MTU 1500 without scatter,
25000 8000-byte and 25000 1000-byte UDP datagrams, interleaved, gave
25000 Rx errors and 25000 packets received, with no nombuf on a
16384-mbuf pool and traffic still flowing afterwards; with scatter on,
the 8042-byte frames arrive as 4-segment mbufs. A small ethdev program
that reconfigures a started-and-stopped port to MTU 8000 without
scatter, keeping its Rx queues, now gets -EINVAL from
rte_eth_dev_start() (it started before).

 drivers/net/gve/gve_ethdev.c | 75 +++++++++++++++++++++++++++---------
 drivers/net/gve/gve_ethdev.h |  2 +
 drivers/net/gve/gve_rx.c     | 20 +++++++++-
 3 files changed, 76 insertions(+), 21 deletions(-)

diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index 7506c46d9a..8ee52fdd47 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -459,11 +459,38 @@ gve_start_queues(struct rte_eth_dev *dev)
 	return ret;
 }
 
+/* GQI chains a frame larger than one Rx buffer into a multi-segment
+ * mbuf. No Rx offload is per-queue here, so check the port offloads.
+ */
+static int
+gve_rx_check_scatter(struct rte_eth_dev *dev, uint16_t mtu)
+{
+	struct gve_priv *priv = dev->data->dev_private;
+	uint16_t i;
+
+	if (!gve_is_gqi(priv) ||
+	    (dev->data->dev_conf.rxmode.offloads & RTE_ETH_RX_OFFLOAD_SCATTER))
+		return 0;
+
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
+		struct gve_rx_queue *rxq = dev->data->rx_queues[i];
+
+		if (rxq != NULL && gve_rx_gqi_needs_scatter(mtu, rxq->rx_buf_len)) {
+			PMD_DRV_LOG(ERR, "MTU %u needs Rx scatter with %u byte Rx buffers",
+				    mtu, rxq->rx_buf_len);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 static int
 gve_dev_start(struct rte_eth_dev *dev)
 {
 	struct gve_process_private *process_priv = dev->process_private;
-	struct gve_priv *priv;
+	struct gve_priv *priv = dev->data->dev_private;
+	uint16_t i;
 	int ret;
 
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
@@ -471,6 +498,31 @@ gve_dev_start(struct rte_eth_dev *dev)
 		return -EPERM;
 	}
 
+	/* rte_eth_dev_configure() sets the MTU and the Rx offloads without
+	 * calling mtu_set, and keeps Rx queues already set up, so check them
+	 * again and give the device the MTU the check was made against.
+	 */
+	ret = gve_rx_check_scatter(dev, dev->data->mtu);
+	if (ret != 0)
+		return ret;
+
+	ret = process_priv->ctrl_ops->set_mtu(priv, dev->data->mtu);
+	if (ret != 0) {
+		PMD_DRV_LOG(ERR, "Failed to set MTU %u: %d", dev->data->mtu, ret);
+		return ret;
+	}
+
+	/* The device chains frames up to its own MTU, not the one it was
+	 * given; the Rx path drops them unless scatter is on.
+	 */
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
+		struct gve_rx_queue *rxq = dev->data->rx_queues[i];
+
+		if (rxq != NULL)
+			rxq->scatter = !!(dev->data->dev_conf.rxmode.offloads &
+					  RTE_ETH_RX_OFFLOAD_SCATTER);
+	}
+
 	ret = gve_start_queues(dev);
 	if (ret != 0) {
 		PMD_DRV_LOG(ERR, "Failed to start queues");
@@ -480,7 +532,6 @@ gve_dev_start(struct rte_eth_dev *dev)
 	dev->data->dev_started = 1;
 	gve_link_update(dev, 0);
 
-	priv = dev->data->dev_private;
 	/* No stats available yet for Dqo. */
 	if (gve_is_gqi(priv)) {
 		ret = gve_alloc_stats_report(priv,
@@ -1031,23 +1082,9 @@ gve_dev_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
 		return -EBUSY;
 	}
 
-	/* GQI chains a frame larger than one Rx buffer into a multi-segment
-	 * mbuf. No Rx offload is per-queue here, so check the port offloads.
-	 */
-	if (gve_is_gqi(priv) &&
-	    !(dev->data->dev_conf.rxmode.offloads & RTE_ETH_RX_OFFLOAD_SCATTER)) {
-		for (uint16_t i = 0; i < dev->data->nb_rx_queues; i++) {
-			struct gve_rx_queue *rxq = dev->data->rx_queues[i];
-
-			if (rxq != NULL &&
-			    gve_rx_gqi_needs_scatter(mtu, rxq->rx_buf_len)) {
-				PMD_DRV_LOG(ERR,
-					    "MTU %u needs Rx scatter with %u byte Rx buffers",
-					    mtu, rxq->rx_buf_len);
-				return -EINVAL;
-			}
-		}
-	}
+	err = gve_rx_check_scatter(dev, mtu);
+	if (err != 0)
+		return err;
 
 	err = process_priv->ctrl_ops->set_mtu(priv, mtu);
 	if (err) {
diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
index 26c6a304a6..3a8ddfbbb6 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -263,6 +263,8 @@ struct gve_rx_queue {
 	struct rte_mbuf **refill_bufs;
 
 	uint8_t is_gqi_qpl;
+	/* the port enabled RTE_ETH_RX_OFFLOAD_SCATTER (GQI) */
+	bool scatter;
 	bool timestamp_enabled;
 };
 
diff --git a/drivers/net/gve/gve_rx.c b/drivers/net/gve/gve_rx.c
index 4a455b3067..31c187ca83 100644
--- a/drivers/net/gve/gve_rx.c
+++ b/drivers/net/gve/gve_rx.c
@@ -139,12 +139,21 @@ gve_rx(struct gve_rx_queue *rxq, volatile struct gve_rx_desc *rxd, uint16_t rx_i
 	struct rte_mbuf *rxe;
 
 	if (ctx->drop_pkt)
-		goto finish_frag;
+		goto drop_frag;
 
 	if (rxd->flags_seq & GVE_RXF_ERR) {
 		ctx->drop_pkt = true;
 		rxq->stats.errors++;
-		goto finish_frag;
+		goto drop_frag;
+	}
+
+	/* The device chains a frame larger than one Rx buffer whatever MTU
+	 * it was given, so drop it unless the application enabled scatter.
+	 */
+	if (is_first_frag && !is_last_frag && !rxq->scatter) {
+		ctx->drop_pkt = true;
+		rxq->stats.errors++;
+		goto drop_frag;
 	}
 
 	if (is_first_frag)
@@ -171,6 +180,12 @@ gve_rx(struct gve_rx_queue *rxq, volatile struct gve_rx_desc *rxd, uint16_t rx_i
 		}
 	}
 
+	goto finish_frag;
+
+drop_frag:
+	/* The refill puts a new mbuf in this slot, so free the old one. */
+	rte_pktmbuf_free(rxq->sw_ring[rx_id]);
+	rxq->sw_ring[rx_id] = NULL;
 finish_frag:
 	ctx->total_frags++;
 	return is_last_frag;
@@ -375,6 +390,7 @@ gve_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id,
 	rxq->ntfy_addr = &hw->db_bar[rte_be_to_cpu_32(hw->irq_dbs[rxq->ntfy_id].id)];
 
 	rxq->rx_buf_len = rx_buf_len;
+	rxq->scatter = !!(offloads & RTE_ETH_RX_OFFLOAD_SCATTER);
 
 	/* Allocate software ring */
 	rxq->sw_ring = rte_zmalloc_socket("gve rx sw ring", sizeof(struct rte_mbuf *) * nb_desc,
-- 
2.56.0.257.gf7497c7d27-goog

