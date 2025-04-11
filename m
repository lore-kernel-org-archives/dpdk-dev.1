Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F8AC369AE
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Apr 2025 23:50:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9655440E19;
	Sat, 12 Apr 2025 01:49:49 +0200 (CEST)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by mails.dpdk.org (Postfix) with ESMTP id D91A240E03
 for <dev@dpdk.org>; Sat, 12 Apr 2025 01:49:44 +0200 (CEST)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-af59c920d32so1926230a12.0
 for <dev@dpdk.org>; Fri, 11 Apr 2025 16:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744415384;
 x=1745020184; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uRfcWcOieOUVKNrqsYyK972Y9+OhpRQLJc/KoOLdwVA=;
 b=NeUdwlrOnNjJcClORpF+phEsy4sVe6Lg3szokGefCeVNnReWQTFeNMpKiYBsKihIFM
 tIFLqUq0BhFKsuWhyHX6cFEoeyJvS8X7BDg4iiM8RI8mHarQ1tW+iNyndxpuy81yMiy2
 ZwJwLUkXT2ZKlZ5TowsvvsV5fi3ewOQGhrgrtpALqhCYyxHSn8kmVswU13Sm5NGd4Ijf
 q/rOSobD83DHUbcVmJErqVMO7oPfy/WcvbN8aOtVzUBqS70C4xb7LT9/B0VEC96x7SYt
 ldDv+erjkxgTue2vwqa44Wfxew07l7UVt4TqHy9gn4Rv2qpFD9SLyf42071LWvJmCCTF
 dPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744415384; x=1745020184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uRfcWcOieOUVKNrqsYyK972Y9+OhpRQLJc/KoOLdwVA=;
 b=QELrPcwnAcJ8jV2NMbrl5NGH7/l9IzslowTVDuZRbaQ9cMW4kEr/nDld0oNbdZBp/3
 e48ainb/UFJEo9n6zd5HUijgUY9O66Htezn9eb2wiX3nGgp9zsZSz5g5akwLIU6sygY4
 xMy6irtTPzeEjTITX75PrSAcssx0UVdR+XSQXoP8XPlxDdJx4k4YU1HKF21T0ORhSZ5o
 XRlYgzhUQns5RzaHm9B1cy/v9WjynSV/9AU9YYLK0ekk4tbm/D2giMzvC01xmavRagsS
 EiWRJkACWhLsxFkni1EdPsQ4STYllKWx4aJejPavR9vJ2M+N7T6WoEjska8QHSLJU7IH
 ozng==
X-Gm-Message-State: AOJu0YwF8mtT1t1E9/as+rDboDAyOqMOMYKEVg9+p0LzZ0wUAk/0Ijbk
 X7kEiaDuPYQALhKyHLr5oabQobiuJx3j5hJ9exdkd4co5199hDSCQt6VSI7MWddmVXbpSA0VSxu
 c
X-Gm-Gg: ASbGncuQvjioSS+OLvqqyblnld57qvYEAByCWB+O6XSm+ZDE6N8Kq/W9LIPRXJOjoNG
 Ib2og8Zwa0LF7/j+V5O0sRT06GJ8m4PNFpnSNTzIdcF/hh/6WafWfQPh9o3W33Y57R9FNN10GKo
 nPIv7ohcaR7crW0YVDPb0svMndp0xDuwnMdRkWP1AHO3hHTApIOdkOv2gVqED7rxBuLzRP8zsbJ
 0pPD+b/QwqSpcelJ7+cFiysDzwuPu7WQ++4xubUaq71jIYa2YnjXBGHuN4Z/VKJs5NM4V9ZFLLe
 DYw7n7h3sYQnOJ1zSJS8JQ7on7cTzVVy9Rl4CRFmAadGArxG15LJHA11TAcG1olSSkuBolkSFto
 PzlqKaQO2rz8rSp5u
X-Google-Smtp-Source: AGHT+IFP1kZ2KnydUyjo4IiHjZhFfECtsbyfBzEfzOoc49fcDPMkULZ/dsLefRGl1wxZZPvHGMwSeg==
X-Received: by 2002:a17:90a:d60e:b0:2fc:ec7c:d371 with SMTP id
 98e67ed59e1d1-30823660dc4mr5707757a91.3.1744415383922; 
 Fri, 11 Apr 2025 16:49:43 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306dd11e643sm6538661a91.12.2025.04.11.16.49.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 16:49:43 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC 06/13] net/ring: add timestamp devargs
Date: Fri, 11 Apr 2025 16:44:43 -0700
Message-ID: <20250411234927.114568-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250411234927.114568-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
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

Add argument to ring PMD creation to force packets going
into ring to be timestamped.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/ring/rte_eth_ring.c | 44 +++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ring/rte_eth_ring.c b/drivers/net/ring/rte_eth_ring.c
index 94a739a925..0f97cd1262 100644
--- a/drivers/net/ring/rte_eth_ring.c
+++ b/drivers/net/ring/rte_eth_ring.c
@@ -20,15 +20,18 @@
 #define ETH_RING_ACTION_CREATE		"CREATE"
 #define ETH_RING_ACTION_ATTACH		"ATTACH"
 #define ETH_RING_ACTION_MAX_LEN		8 /* CREATE | ACTION */
+
 #define ETH_RING_INTERNAL_ARG		"internal"
 #define ETH_RING_INTERNAL_ARG_MAX_LEN	19 /* "0x..16chars..\0" */
 
 #define ETH_RING_RING_ARG		"ring"
+#define ETH_RING_TIMESTAMP_ARG		"timestamp"
 
 static const char *valid_arguments[] = {
 	ETH_RING_NUMA_NODE_ACTION_ARG,
 	ETH_RING_INTERNAL_ARG,
 	ETH_RING_RING_ARG,
+	ETH_RING_TIMESTAMP_ARG,
 	NULL
 };
 
@@ -41,6 +44,9 @@ struct ring_internal_args {
 	void *addr; /* self addr for sanity check */
 };
 
+static uint64_t timestamp_dynflag;
+static int timestamp_dynfield_offset = -1;
+
 enum dev_action {
 	DEV_CREATE,
 	DEV_ATTACH
@@ -49,6 +55,8 @@ enum dev_action {
 struct ring_queue {
 	struct rte_ring *rng;
 	uint16_t in_port;
+	uint8_t timestamp;
+
 	RTE_ATOMIC(uint64_t) rx_pkts;
 	RTE_ATOMIC(uint64_t) tx_pkts;
 };
@@ -56,6 +64,7 @@ struct ring_queue {
 struct pmd_internals {
 	unsigned int max_rx_queues;
 	unsigned int max_tx_queues;
+	uint8_t timestamp;
 
 	struct ring_queue rx_ring_queues[RTE_PMD_RING_MAX_RX_RINGS];
 	struct ring_queue tx_ring_queues[RTE_PMD_RING_MAX_TX_RINGS];
@@ -64,6 +73,7 @@ struct pmd_internals {
 	enum dev_action action;
 };
 
+
 static struct rte_eth_link pmd_link = {
 	.link_speed = RTE_ETH_SPEED_NUM_10G,
 	.link_duplex = RTE_ETH_LINK_FULL_DUPLEX,
@@ -99,8 +109,23 @@ eth_ring_tx(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
 {
 	void **ptrs = (void *)&bufs[0];
 	struct ring_queue *r = q;
-	const uint16_t nb_tx = (uint16_t)rte_ring_enqueue_burst(r->rng,
-			ptrs, nb_bufs, NULL);
+	uint16_t nb_tx;
+
+	if (r->timestamp) {
+		unsigned int i;
+		uint64_t cycles = rte_get_tsc_cycles();
+
+		for (i = 0; i < nb_bufs; i++) {
+			struct rte_mbuf *m = bufs[i];
+			*RTE_MBUF_DYNFIELD(m, timestamp_dynfield_offset,
+					   rte_mbuf_timestamp_t *) = cycles;
+			m->ol_flags |= timestamp_dynflag;
+		}
+	}
+
+
+	nb_tx = (uint16_t)rte_ring_enqueue_burst(r->rng, ptrs, nb_bufs, NULL);
+
 	if (r->rng->flags & RING_F_SP_ENQ)
 		r->tx_pkts += nb_tx;
 	else
@@ -176,6 +201,7 @@ eth_tx_queue_setup(struct rte_eth_dev *dev, uint16_t tx_queue_id,
 {
 	struct pmd_internals *internals = dev->data->dev_private;
 
+	internals->tx_ring_queues[tx_queue_id].timestamp = internals->timestamp;
 	dev->data->tx_queues[tx_queue_id] = &internals->tx_ring_queues[tx_queue_id];
 	return 0;
 }
@@ -835,6 +861,20 @@ rte_pmd_ring_probe(struct rte_vdev_device *dev)
 				}
 			}
 		}
+
+		if (rte_kvargs_count(kvlist, ETH_RING_TIMESTAMP_ARG) == 1) {
+			struct pmd_internals *internals = eth_dev->data->dev_private;
+
+			if (timestamp_dynfield_offset == -1) {
+				ret = rte_mbuf_dyn_rx_timestamp_register(&timestamp_dynfield_offset,
+									 &timestamp_dynflag);
+				if (ret < 0)
+					return ret;
+			}
+
+			internals->timestamp = 1;
+		}
+
 	}
 
 out_free:
-- 
2.47.2

