Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6F8C982D0
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 20:13:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60BA2432CC;
	Thu, 17 Sep 2026 22:11:49 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id CE8DC43278
 for <dev@dpdk.org>; Thu, 17 Sep 2026 22:11:42 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 d9443c01a7336-2dd53691be5so301975ad.1
 for <dev@dpdk.org>; Thu, 17 Sep 2026 13:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789675902;
 x=1790280702; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J8241PZii+xEZnNsynb1ZoVvK0QGK++yyF3Wi3sjao4=;
 b=f8ZgrBqeTxPvRZWqecQrj2SAVIHKzgUfVHrfxrSKpt/7WwU3n2DA/BFW6Y2mkgF7YP
 ZKE12BGBVVHN1BqwcPpvzh7EQ9fAGc+4L09NCZGNVsqToYPTIejG9I0DTlMJB005vQPh
 eS55VkGTINxVka3n8zdXQRzr84yZnxBFfaC604C1kaeHqYnIBYFiaTk11kDLof5bHAH7
 n5uDC/287q85HrmUrfU+OPb3FHSdcJdhR4KW2Ta5LhIRMdGHmdh9wkrxbbYJBGqW5CYj
 9BwE0JuXOLYvd4iRCRs5S6nt92EsGxH1/2l7a9K2XS0z2ZdwiqImFXrGM739Dx1NbkHO
 oRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789675902; x=1790280702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=J8241PZii+xEZnNsynb1ZoVvK0QGK++yyF3Wi3sjao4=;
 b=SNgonKAQpWfnBBfmP513kJeV6MsyrQL+q3ETafNm/KsaZyjEgCWcAdF0CfGGuXEVc3
 zqJsgXu4SB4LzGhcjNmr44PKMziVMxlTVSIiP8MhefFSfp5ylC7sRYc9hdlO3zLTmite
 ZTVa53be+tATO7wFiICOquhCe6xvVnQoy9wBD4ByzENGEBKh+zWSMwPOgsitLVMmPA2D
 ytJ0qCzDDRy7ONoIJKWq1Ctcby7xbB2g8OoNaKLHw+RO0pd4J5yTMQ8ogNiFEb0PYzQL
 JBG7LY84Wcv0VJuniy+h2XjqzkAXPwsO4DGQ7DiV44FVtTT0amUf+GqyoaH/gWDyj2sE
 /a3A==
X-Gm-Message-State: AFuF++k9xgDEW4s6e0OZWLB5n/QM2je25B+zs4VJoozHpL6MlYoF0bHk
 99r/htkdTeS05Fv0YyeWI/94PNDtWL2WGvils9EGmFCHQ0fdCSShQaTsFwbQB6q9d0Cx0cQS0U9
 7QdaF
X-Gm-Gg: AYBFou2JNdbSVkDgqHTepH4U2pfV2Tu9umgb6mr9Es8fVtigZWwqJLewMkhZ54RPxYF
 T4OYKw3gNdTDQEAOUkEfA36keVvBZx/6i/KLtMQiJhF8+uW74/egX7EPa9j928pz0PWVTYN1rpN
 HrWJZhZO80sOqg2zqHKIafEKx0KsvtEpUiOvmIFeZEuox/1kUf3Ya7KLgRT4f9Z6a/ULY5YNiOV
 xVJcbTTOe4dfshsiljb76IC6L44ziHjOS/EnJci2ssg3r79W2PY4bcg6YGjjlesZJppcBTy5lgV
 8DvXAC5RVF5lYes7C2eUFXUsD9blLTOKDMR8V1/jT28BXWSme5ij5NfEgk5eLCefI4deP0jX7H9
 OI0qpWZ+PynjDLuoPwD7C+e7nbb/rWM5xKP7l9YyMXqq3V6dB0TjsF5k3VHtC2BACohoHbaWrqx
 Y3DoXuUK866rYdTRlKZdVGxwtLq+K9DhkcDePRpeGmtqExDrziaQBTRdClEuKsTjCqO1s60m3m5
 00X4Coq8P/xqJ7Y2Kkzch1jYvefHvs7rYfB3g==
X-Received: by 2002:a17:902:f792:b0:2dd:ad74:ac82 with SMTP id
 d9443c01a7336-2ddb1bbff1emr6030525ad.29.1789675901888; 
 Thu, 17 Sep 2026 13:11:41 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd89f0870bsm31368345ad.63.2026.09.17.13.11.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 13:11:41 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v8 22/25] net/vhost: use stdatomic instead of rte_atomic32
Date: Thu, 17 Sep 2026 13:10:26 -0700
Message-ID: <20260917201119.2168234-23-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917201119.2168234-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260917201119.2168234-1-stephen@networkplumber.org>
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
index 2e3a007966..2acf670c94 100644
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

