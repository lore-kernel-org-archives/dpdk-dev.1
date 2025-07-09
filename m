Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DF2C83F0A
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 17:36:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8747540DD5;
	Wed,  9 Jul 2025 19:36:22 +0200 (CEST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id DA73640DCD
 for <dev@dpdk.org>; Wed,  9 Jul 2025 19:36:19 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-234b9dfb842so1892835ad.1
 for <dev@dpdk.org>; Wed, 09 Jul 2025 10:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752082579;
 x=1752687379; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QT1Q53FL2Zs9/qlsW7htu4Lxkt18dkH9YpIwpbocPoo=;
 b=ixEQPvFn8Xm0NVtHjbDNqyJ9PK6VblXxLjcn6JHvGFFSzAz7MD8cJRgHqWOKa/MVmj
 zFYk9x6mnH56Cz/EnZN0UcMEhWBHFIQrqjr3l8TOxT5v7BuJltEruIOBGB3xI6z36bds
 90T9Xdwf8U4uETKXwQoPUGCd4TY9s91VVN8VfriW+L1AOgxi/pmM1LMv1NRQtg04zhOP
 OtLT5OX+fZhHad5/aqTmFxzttBiQ8LBxqNIwXfeAD/QDiCm7Mdnoq9vv+3fTPubf+t7x
 g0wQru0/Bdck/kuVE9Q+zdzxgmXjFqWFxpWpOF+Umfe6JC698GWb5J6wzTdhl3fH/Cea
 vhQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752082579; x=1752687379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QT1Q53FL2Zs9/qlsW7htu4Lxkt18dkH9YpIwpbocPoo=;
 b=AIa57OtmJI/LUx5MPDFs4O2qp2quLMXWdbZQv3V+Tf5tZqcpx59f2f+EJnmjgRqw2f
 uJpjdLDWYvA0e/k1/g+whti0jkqg3XrmjlmocCxPa4NJe6HISTR6gp1oiOmQR/tNqG61
 /98wI0c3hdLAB8JE0oySCqhN8tFLH0qyAspqcWHhKA3xHhghKR1tLmwNUvCY6Oq+elSb
 WnBSmHTqi+6Gml/cb4Dvs/jCqQPlrLtl45I4UKKTMqgO6s76luPfy6imsQKTKbgDL8de
 cKkJPTpBbc16g1V7koVpsJAz1GJjxyCL0gsLWZtTRvvGlhBevphaFN0y1sJn7snKjkak
 s2Gg==
X-Gm-Message-State: AOJu0Yz6N/sWnema6/34JWLFXoC7A1gs0y6W8C+4xn738spkzbgwIs7G
 SkSOCvIMKygay4Xk8dAAwxTuBnbdHZa699Pgl3lfqh3k1w+7x0lwcPQ9YZXum/UJ/GlpWyVjcuC
 W4Z9O
X-Gm-Gg: ASbGncvmrgMsp7MLuFbwI36Mnu5Bim/Ff4CwkCWwwYBKMPVKZgCyzMn3VHKDFZYUgga
 6vcvNBgMtUQkxg8TSt+LlbjOLAQyfLljNV15IcE//lBqG78Xus2u8U6u0QAMWEOoOSXXrG6AjGN
 bCZM/HWWnFC0wM41+vQE6EA16CBzsYagAfpG+ziYX4d7RSoxD0e7PjzP+dqbMr3s8Jm90e+r6hp
 Y93aqz95LYfaQG4u6xOgpyPqefjtoDeWtkdHIA7JS5PfOLXwQhwWwzCGkJUwDBVh2bgTmbOYJJ7
 4w7ny/GndUvHfJVv3fztMrKCwOm2hKbz9iv+pBOVBkGEQJcAe+u7GHnpDz095Ay6WxfRNkEFleW
 AC932vcDS0dIeUiFr92rggq/D1ZahPFnQVgIN
X-Google-Smtp-Source: AGHT+IEU7yp0BIl3nLEc5TxFJl2D8nJEGLNM60kagQAbHXP6sYod+LMNuWKA0R4yOziJDtOrW3BHkQ==
X-Received: by 2002:a17:902:c402:b0:236:6f5f:cab4 with SMTP id
 d9443c01a7336-23ddb1974a6mr60703155ad.5.1752082578882; 
 Wed, 09 Jul 2025 10:36:18 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c845b7467sm138525475ad.230.2025.07.09.10.36.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 10:36:18 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC v2 04/12] net/ring: add new devargs for dumpcap use
Date: Wed,  9 Jul 2025 10:33:30 -0700
Message-ID: <20250709173611.6390-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250709173611.6390-1-stephen@networkplumber.org>
References: <0250411234927.114568-1-stephen@networkplumber.org>
 <20250709173611.6390-1-stephen@networkplumber.org>
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

Need ability to allow process like dumpcap to make a ring ethdev
with a pre-existing ring. Do this via devargs so it can work
with hotplug. It looked like the API rte_eth_from_ring() would
work for this, but it doesn't do the right thing.

Add argument to ring PMD creation to force packets going
into ring to be timestamped.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/ring/rte_eth_ring.c | 74 ++++++++++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ring/rte_eth_ring.c b/drivers/net/ring/rte_eth_ring.c
index 966c64d9a5..0f97cd1262 100644
--- a/drivers/net/ring/rte_eth_ring.c
+++ b/drivers/net/ring/rte_eth_ring.c
@@ -20,12 +20,18 @@
 #define ETH_RING_ACTION_CREATE		"CREATE"
 #define ETH_RING_ACTION_ATTACH		"ATTACH"
 #define ETH_RING_ACTION_MAX_LEN		8 /* CREATE | ACTION */
+
 #define ETH_RING_INTERNAL_ARG		"internal"
 #define ETH_RING_INTERNAL_ARG_MAX_LEN	19 /* "0x..16chars..\0" */
 
+#define ETH_RING_RING_ARG		"ring"
+#define ETH_RING_TIMESTAMP_ARG		"timestamp"
+
 static const char *valid_arguments[] = {
 	ETH_RING_NUMA_NODE_ACTION_ARG,
 	ETH_RING_INTERNAL_ARG,
+	ETH_RING_RING_ARG,
+	ETH_RING_TIMESTAMP_ARG,
 	NULL
 };
 
@@ -38,6 +44,9 @@ struct ring_internal_args {
 	void *addr; /* self addr for sanity check */
 };
 
+static uint64_t timestamp_dynflag;
+static int timestamp_dynfield_offset = -1;
+
 enum dev_action {
 	DEV_CREATE,
 	DEV_ATTACH
@@ -46,6 +55,8 @@ enum dev_action {
 struct ring_queue {
 	struct rte_ring *rng;
 	uint16_t in_port;
+	uint8_t timestamp;
+
 	RTE_ATOMIC(uint64_t) rx_pkts;
 	RTE_ATOMIC(uint64_t) tx_pkts;
 };
@@ -53,6 +64,7 @@ struct ring_queue {
 struct pmd_internals {
 	unsigned int max_rx_queues;
 	unsigned int max_tx_queues;
+	uint8_t timestamp;
 
 	struct ring_queue rx_ring_queues[RTE_PMD_RING_MAX_RX_RINGS];
 	struct ring_queue tx_ring_queues[RTE_PMD_RING_MAX_TX_RINGS];
@@ -61,6 +73,7 @@ struct pmd_internals {
 	enum dev_action action;
 };
 
+
 static struct rte_eth_link pmd_link = {
 	.link_speed = RTE_ETH_SPEED_NUM_10G,
 	.link_duplex = RTE_ETH_LINK_FULL_DUPLEX,
@@ -96,8 +109,23 @@ eth_ring_tx(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
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
@@ -173,6 +201,7 @@ eth_tx_queue_setup(struct rte_eth_dev *dev, uint16_t tx_queue_id,
 {
 	struct pmd_internals *internals = dev->data->dev_private;
 
+	internals->tx_ring_queues[tx_queue_id].timestamp = internals->timestamp;
 	dev->data->tx_queues[tx_queue_id] = &internals->tx_ring_queues[tx_queue_id];
 	return 0;
 }
@@ -693,6 +722,20 @@ parse_internal_args(const char *key __rte_unused, const char *value,
 	return 0;
 }
 
+static int
+parse_ring_arg(const char *key __rte_unused, const char *value, void *data)
+{
+	struct rte_ring **rp = data;
+
+	*rp = rte_ring_lookup(value);
+	if (*rp == NULL) {
+		PMD_LOG(ERR, "ring '%s' not found", value);
+		return -1;
+	}
+
+	return 0;
+}
+
 static int
 rte_pmd_ring_probe(struct rte_vdev_device *dev)
 {
@@ -770,6 +813,18 @@ rte_pmd_ring_probe(struct rte_vdev_device *dev)
 				&eth_dev);
 			if (ret >= 0)
 				ret = 0;
+		} else if (rte_kvargs_count(kvlist, ETH_RING_RING_ARG) == 1) {
+			struct rte_ring *rxtx[1] = { };
+
+			ret = rte_kvargs_process(kvlist, ETH_RING_RING_ARG, parse_ring_arg, rxtx);
+			if (ret < 0)
+				goto out_free;
+
+			/* Note: rte_eth_from_ring() does not do what is expected here! */
+			ret = do_eth_dev_ring_create(name, dev, rxtx, 1, rxtx, 1,
+						     rte_socket_id(), DEV_ATTACH, &eth_dev);
+			if (ret < 0)
+				goto out_free;
 		} else {
 			ret = rte_kvargs_count(kvlist, ETH_RING_NUMA_NODE_ACTION_ARG);
 			info = rte_zmalloc("struct node_action_list",
@@ -806,6 +861,20 @@ rte_pmd_ring_probe(struct rte_vdev_device *dev)
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
@@ -843,4 +912,5 @@ static struct rte_vdev_driver pmd_ring_drv = {
 RTE_PMD_REGISTER_VDEV(net_ring, pmd_ring_drv);
 RTE_PMD_REGISTER_ALIAS(net_ring, eth_ring);
 RTE_PMD_REGISTER_PARAM_STRING(net_ring,
+	ETH_RING_RING_ARG "=<string> "
 	ETH_RING_NUMA_NODE_ACTION_ARG "=name:node:action(ATTACH|CREATE)");
-- 
2.47.2

