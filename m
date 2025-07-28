Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D96C83F17
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Jul 2025 22:11:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0CE240BA2;
	Tue, 29 Jul 2025 00:10:14 +0200 (CEST)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by mails.dpdk.org (Postfix) with ESMTP id 1CB8340A79
 for <dev@dpdk.org>; Tue, 29 Jul 2025 00:10:12 +0200 (CEST)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-7e33d36491dso693957585a.3
 for <dev@dpdk.org>; Mon, 28 Jul 2025 15:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753740611;
 x=1754345411; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CEuPJly845h3GwOzkyx/hdtbI77aynIptOJU4pCB4vs=;
 b=JOgsSD+9kcVvROEU2duUE/byAW06YRhpBti97HIK8Ow88qatiOwYEwTOPDuPUkcVjh
 MfsYlQ0vo21bQONP/i2DNpX0YE6hgK+WFW1jqeGOniR7tZABd6Tv9DJLl8sfaTAZ0ow2
 dVvqyZ8HwhdTY91YQ0I52jQzizVLZKhqpR4x3EtdQMfXm7O/87J8PUaxa5zxOMyO5CBr
 1GpZ9aGTo8moddYl2y32SJhevpzAGnI3Uy46pEwnDDg9ngHKpenSbibgmEUUvc5hOsH5
 5QeMvFwib6qfoF9HbexATjp63NqpBYEAaOVpqiN5fRgMD1Fm/3NELXKQwvx7ySWAxRsD
 jQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753740611; x=1754345411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CEuPJly845h3GwOzkyx/hdtbI77aynIptOJU4pCB4vs=;
 b=VEytuHDw7oGBbWy6hRUSZozoT6S8lVFcjDnYoyvraaSvKUMAJKqnn7iuk+JixZdpSm
 ZhkubNcFRnnqMjH0Ifenjq7vIZmsA7xI/856MvMF+ZRzXQOP3Yp4u3j48mFkFXLtAsSV
 vxnzqZRbTvH2B905di8uVGDgr/1lCjVLZ7lGvlRX7Q1Lln30MXKbK7SpfzMDUVPuIe7u
 Qef9erTz4rAydh2DoaRB31lXcz8h5L7bFIm8qEsKo61W40VoZzuMBctom5cqzNAOEkEX
 Kw+Uqeoq1srfdbEhmNE2NdIAk2d8LQpPUk9EH/Z6szwTslbmkxXo1PKF0RfRlCb/Omjl
 lgYg==
X-Gm-Message-State: AOJu0YxKfvayd9NAQeCaA8/S1Z9bvhPRqIYRVrUY89JM0qIJYAnzUrCR
 dfJpfT5NLpCWLZiez9rr6Zog8Wc57iTOlsGxmiEgq+t8sWJhpF91jOTGVup4Oe0DJH8WKfukOia
 1L/Uh
X-Gm-Gg: ASbGncuZ/XGTQmxICB9vo+zSzC761yxDBg1nEb2GmSc6SH1KMbHe2QXIfdUBXF9zdIL
 n/42OtfA2kc7p2oGvs38qYoIlDoFLMgKrKEX1TygzQpDBeRQQIqBa5qkgiqnTHlT/cL+8SDbqw0
 Mbqy5iHX8QbJUj1tbUGhND+MR3yj2DYdhbY2nJapigRROQnBvsUs64VRCHFxaQd5kq10hO5u3SJ
 MhE95RhXrAlaeSwruI7cl+qm0wKQzDH8tRktny/DbX2DG03kOzdaBEOSkW4mrMaPss9a7DnKYF9
 qnBf11H9wKVKznBAJyJmWSgITIxxU3k+CHsLbXvLFYSWkuA+xqlCdgDuWnICXXuPNJerN8ytjza
 RzCCZdA25i3LvJBLUQKGKFEw9oqV3scT9Fy7wogJzHXw4zFwPiuHC721cGPnkEQUhN5w/y9VP
X-Google-Smtp-Source: AGHT+IHkfFam2GV7xxkdxXbjaitwd+89P7k7ZKZnYoDhvdXcf33hOgGdVwhG2HwiYMvmKiX6R26e+A==
X-Received: by 2002:a05:620a:aa09:b0:7e1:d0fb:3454 with SMTP id
 af79cd13be357-7e63c1b7d9cmr1764217085a.53.1753740611453; 
 Mon, 28 Jul 2025 15:10:11 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e64327d41esm344024785a.15.2025.07.28.15.10.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 15:10:10 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v7 09/12] pcapng: split packet copy from header insertion
Date: Mon, 28 Jul 2025 15:08:17 -0700
Message-ID: <20250728220955.332924-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250728220955.332924-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250728220955.332924-1-stephen@networkplumber.org>
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

In new model, the packet was already copied, only need
to wrap it in pcapng format.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/pcapng/rte_pcapng.c | 178 +++++++++++++++++++++-------------------
 lib/pcapng/rte_pcapng.h |  27 +++++-
 2 files changed, 120 insertions(+), 85 deletions(-)

diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index 2a07b4c1f5..6db5d4da50 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -1,3 +1,4 @@
+
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2019 Microsoft Corporation
  */
@@ -432,8 +433,24 @@ pcapng_vlan_insert(struct rte_mbuf *m, uint16_t ether_type, uint16_t tci)
 	return 0;
 }
 
+/* pad the packet to 32 bit boundary */
+static inline int
+pcapng_mbuf_pad32(struct rte_mbuf *m)
+{
+	uint32_t pkt_len = rte_pktmbuf_pkt_len(m);
+	uint32_t padding = RTE_ALIGN(pkt_len, sizeof(uint32_t)) - pkt_len;
+
+	if (padding > 0) {
+		void *tail = rte_pktmbuf_append(m, padding);
+		if (tail == NULL)
+			return -1;
+		memset(tail, 0, padding);
+	}
+	return 0;
+}
+
 /*
- *   The mbufs created use the Pcapng standard enhanced packet  block.
+ *  The mbufs created use the Pcapng standard enhanced packet block.
  *
  *                         1                   2                   3
  *     0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
@@ -468,71 +485,28 @@ pcapng_vlan_insert(struct rte_mbuf *m, uint16_t ether_type, uint16_t tci)
  *    |                      Block Total Length                       |
  *    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
  */
-
-/* Make a copy of original mbuf with pcapng header and options */
-RTE_EXPORT_SYMBOL(rte_pcapng_copy)
-struct rte_mbuf *
-rte_pcapng_copy(uint16_t port_id, uint32_t queue,
-		const struct rte_mbuf *md,
-		struct rte_mempool *mp,
-		uint32_t length,
-		enum rte_pcapng_direction direction,
-		const char *comment)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pcapng_insert, 25.07)
+int
+rte_pcapng_insert(struct rte_mbuf *m, uint32_t queue,
+		  enum rte_pcapng_direction direction, uint32_t orig_len,
+		  uint64_t timestamp, const char *comment)
 {
 	struct pcapng_enhance_packet_block *epb;
-	uint32_t orig_len, pkt_len, padding, flags;
-	struct pcapng_option *opt;
-	uint64_t timestamp;
-	uint16_t optlen;
-	struct rte_mbuf *mc;
-	bool rss_hash;
-
-#ifdef RTE_LIBRTE_ETHDEV_DEBUG
-	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, NULL);
-#endif
-	orig_len = rte_pktmbuf_pkt_len(md);
+	uint32_t pkt_len = rte_pktmbuf_pkt_len(m);
+	uint32_t flags;
 
-	/* Take snapshot of the data */
-	mc = rte_pktmbuf_copy(md, mp, 0, length);
-	if (unlikely(mc == NULL))
-		return NULL;
-
-	/* Expand any offloaded VLAN information */
-	if ((direction == RTE_PCAPNG_DIRECTION_IN &&
-	     (md->ol_flags & RTE_MBUF_F_RX_VLAN_STRIPPED)) ||
-	    (direction == RTE_PCAPNG_DIRECTION_OUT &&
-	     (md->ol_flags & RTE_MBUF_F_TX_VLAN))) {
-		if (pcapng_vlan_insert(mc, RTE_ETHER_TYPE_VLAN,
-				       md->vlan_tci) != 0)
-			goto fail;
-	}
+	if (unlikely(pcapng_mbuf_pad32(m) < 0))
+		return -1;
 
-	if ((direction == RTE_PCAPNG_DIRECTION_IN &&
-	     (md->ol_flags & RTE_MBUF_F_RX_QINQ_STRIPPED)) ||
-	    (direction == RTE_PCAPNG_DIRECTION_OUT &&
-	     (md->ol_flags & RTE_MBUF_F_TX_QINQ))) {
-		if (pcapng_vlan_insert(mc, RTE_ETHER_TYPE_QINQ,
-				       md->vlan_tci_outer) != 0)
-			goto fail;
-	}
+	uint16_t optlen = pcapng_optlen(sizeof(flags));
 
-	/* record HASH on incoming packets */
-	rss_hash = (direction == RTE_PCAPNG_DIRECTION_IN &&
-		    (md->ol_flags & RTE_MBUF_F_RX_RSS_HASH));
+	/* make queue optional? */
+	optlen += pcapng_optlen(sizeof(queue));
 
-	/* pad the packet to 32 bit boundary */
-	pkt_len = rte_pktmbuf_pkt_len(mc);
-	padding = RTE_ALIGN(pkt_len, sizeof(uint32_t)) - pkt_len;
-	if (padding > 0) {
-		void *tail = rte_pktmbuf_append(mc, padding);
+	/* does packet have valid RSS hash to include */
+	bool rss_hash = (direction == RTE_PCAPNG_DIRECTION_IN &&
+			 (m->ol_flags & RTE_MBUF_F_RX_RSS_HASH));
 
-		if (tail == NULL)
-			goto fail;
-		memset(tail, 0, padding);
-	}
-
-	optlen = pcapng_optlen(sizeof(flags));
-	optlen += pcapng_optlen(sizeof(queue));
 	if (rss_hash)
 		optlen += pcapng_optlen(sizeof(uint8_t) + sizeof(uint32_t));
 
@@ -540,10 +514,10 @@ rte_pcapng_copy(uint16_t port_id, uint32_t queue,
 		optlen += pcapng_optlen(strlen(comment));
 
 	/* reserve trailing options and block length */
-	opt = (struct pcapng_option *)
-		rte_pktmbuf_append(mc, optlen + sizeof(uint32_t));
+	struct pcapng_option *opt = (struct pcapng_option *)
+		rte_pktmbuf_append(m, optlen + sizeof(uint32_t));
 	if (unlikely(opt == NULL))
-		goto fail;
+		return -1;
 
 	switch (direction) {
 	case RTE_PCAPNG_DIRECTION_IN:
@@ -556,24 +530,20 @@ rte_pcapng_copy(uint16_t port_id, uint32_t queue,
 		flags = 0;
 	}
 
-	opt = pcapng_add_option(opt, PCAPNG_EPB_FLAGS,
-				&flags, sizeof(flags));
-
-	opt = pcapng_add_option(opt, PCAPNG_EPB_QUEUE,
-				&queue, sizeof(queue));
+	opt = pcapng_add_option(opt, PCAPNG_EPB_FLAGS, &flags, sizeof(flags));
+	opt = pcapng_add_option(opt, PCAPNG_EPB_QUEUE, &queue, sizeof(queue));
 
 	if (rss_hash) {
 		uint8_t hash_opt[5];
 
-		/* The algorithm could be something else if
-		 * using rte_flow_action_rss; but the current API does not
-		 * have a way for ethdev to report  this on a per-packet basis.
+		/* The algorithm could be something else but the current API does not
+		 * have a way for to record this on a per-packet basis
+		 * and the PCAPNG hash types don't match the DPDK types.
 		 */
 		hash_opt[0] = PCAPNG_HASH_TOEPLITZ;
 
-		memcpy(&hash_opt[1], &md->hash.rss, sizeof(uint32_t));
-		opt = pcapng_add_option(opt, PCAPNG_EPB_HASH,
-					&hash_opt, sizeof(hash_opt));
+		memcpy(&hash_opt[1], &m->hash.rss, sizeof(uint32_t));
+		opt = pcapng_add_option(opt, PCAPNG_EPB_HASH, &hash_opt, sizeof(hash_opt));
 	}
 
 	if (comment)
@@ -583,19 +553,14 @@ rte_pcapng_copy(uint16_t port_id, uint32_t queue,
 	/* Note: END_OPT necessary here. Wireshark doesn't do it. */
 
 	/* Add PCAPNG packet header */
-	epb = (struct pcapng_enhance_packet_block *)
-		rte_pktmbuf_prepend(mc, sizeof(*epb));
+	epb = (struct pcapng_enhance_packet_block *) rte_pktmbuf_prepend(m, sizeof(*epb));
 	if (unlikely(epb == NULL))
-		goto fail;
+		return -1;
 
 	epb->block_type = PCAPNG_ENHANCED_PACKET_BLOCK;
-	epb->block_length = rte_pktmbuf_pkt_len(mc);
-
-	/* Interface index is filled in later during write */
-	mc->port = port_id;
+	epb->block_length = rte_pktmbuf_pkt_len(m);
 
-	/* Put timestamp in cycles here - adjust in packet write */
-	timestamp = rte_get_tsc_cycles();
+	/* Put timestamp in cycles here - adjusted in packet write */
 	epb->timestamp_hi = timestamp >> 32;
 	epb->timestamp_lo = (uint32_t)timestamp;
 	epb->capture_length = pkt_len;
@@ -603,9 +568,56 @@ rte_pcapng_copy(uint16_t port_id, uint32_t queue,
 
 	/* set trailer of block length */
 	*(uint32_t *)opt = epb->block_length;
+	return 0;
+}
+
+/* Make a copy of original mbuf with pcapng header and options */
+RTE_EXPORT_SYMBOL(rte_pcapng_copy)
+struct rte_mbuf *
+rte_pcapng_copy(uint16_t port_id, uint32_t queue,
+		const struct rte_mbuf *md,
+		struct rte_mempool *mp,
+		uint32_t length,
+		enum rte_pcapng_direction direction,
+		const char *comment)
+{
+	uint32_t orig_len = rte_pktmbuf_pkt_len(md);
+	struct rte_mbuf *mc;
 
-	return mc;
+#ifdef RTE_LIBRTE_ETHDEV_DEBUG
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, NULL);
+#endif
+
+	/* Take snapshot of the data */
+	mc = rte_pktmbuf_copy(md, mp, 0, length);
+	if (unlikely(mc == NULL))
+		return NULL;
+
+	/* Expand any offloaded VLAN information */
+	if ((direction == RTE_PCAPNG_DIRECTION_IN &&
+	     (md->ol_flags & RTE_MBUF_F_RX_VLAN_STRIPPED)) ||
+	    (direction == RTE_PCAPNG_DIRECTION_OUT &&
+	     (md->ol_flags & RTE_MBUF_F_TX_VLAN))) {
+		if (pcapng_vlan_insert(mc, RTE_ETHER_TYPE_VLAN,
+				       md->vlan_tci) != 0)
+			goto fail;
+	}
+
+	if ((direction == RTE_PCAPNG_DIRECTION_IN &&
+	     (md->ol_flags & RTE_MBUF_F_RX_QINQ_STRIPPED)) ||
+	    (direction == RTE_PCAPNG_DIRECTION_OUT &&
+	     (md->ol_flags & RTE_MBUF_F_TX_QINQ))) {
+		if (pcapng_vlan_insert(mc, RTE_ETHER_TYPE_QINQ,
+				       md->vlan_tci_outer) != 0)
+			goto fail;
+	}
+
+	/* Interface index is filled in later during write */
+	mc->port = port_id;
 
+	if (likely(rte_pcapng_insert(mc, queue, direction, orig_len,
+				     rte_get_tsc_cycles(), comment) == 0))
+		return mc;
 fail:
 	rte_pktmbuf_free(mc);
 	return NULL;
diff --git a/lib/pcapng/rte_pcapng.h b/lib/pcapng/rte_pcapng.h
index 48f2b57564..4914ac9622 100644
--- a/lib/pcapng/rte_pcapng.h
+++ b/lib/pcapng/rte_pcapng.h
@@ -99,7 +99,7 @@ enum rte_pcapng_direction {
 };
 
 /**
- * Format an mbuf for writing to file.
+ * Make a copy of mbuf for writing to file.
  *
  * @param port_id
  *   The Ethernet port on which packet was received
@@ -117,7 +117,7 @@ enum rte_pcapng_direction {
  * @param direction
  *   The direction of the packer: receive, transmit or unknown.
  * @param comment
- *   Packet comment.
+ *   Packet comment (optional).
  *
  * @return
  *   - The pointer to the new mbuf formatted for pcapng_write
@@ -129,6 +129,29 @@ rte_pcapng_copy(uint16_t port_id, uint32_t queue,
 		uint32_t length,
 		enum rte_pcapng_direction direction, const char *comment);
 
+/**
+ * Format an mbuf for writing to file.
+ *
+ * @param m
+ *   The mbuf to modify.
+ * @param queue
+ *   The queue on the Ethernet port where packet was received
+ *   or is going to be transmitted.
+ * @param direction
+ *   The direction of the packer: receive, transmit or unknown.
+ * @param orig_len
+ *   The length of the original packet which maybe less than actual
+ *   packet if only a snapshot was captured.
+ * @param timestamp
+ *   The timestamp for packet in TSC cycles.
+ * @param comment
+ *   Packet comment (optional).
+ */
+__rte_experimental
+int
+rte_pcapng_insert(struct rte_mbuf *m, uint32_t queue,
+		  enum rte_pcapng_direction direction, uint32_t orig_len,
+		  uint64_t timestamp, const char *comment);
 
 /**
  * Determine optimum mbuf data size.
-- 
2.47.2

