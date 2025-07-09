Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C12C83F0A
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 17:37:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4687540E20;
	Wed,  9 Jul 2025 19:36:26 +0200 (CEST)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTP id 9A09840E09
 for <dev@dpdk.org>; Wed,  9 Jul 2025 19:36:22 +0200 (CEST)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-235ef62066eso2603275ad.3
 for <dev@dpdk.org>; Wed, 09 Jul 2025 10:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752082582;
 x=1752687382; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CEuPJly845h3GwOzkyx/hdtbI77aynIptOJU4pCB4vs=;
 b=oPbLR8QusJWLgQDrvyLsvggcnNTsHCSItE65EEfvf5FX6AWFTcDMPXkbSIe9CUtJsF
 jRFL24OYGVPFoe5dXuMv+Fg+MVi1EYMO2zIl10Kdh+X5P+yhj60Yd4Z3kEASVdQbg2Lo
 j5XfkqfHE5Ey6XNspW6v2MznYL+3S4XlHFIS1EeqwxRkKvEFdjD8DJg+dvgeQkwD2vEz
 nahqd4nc0vMLEQvc+nhNvO9TXr+sBtlLs0YZlvyIIG23ztQTOQ0acJr0e3/sWnHf2xcu
 9W2azWgzi2L3G/iG3YxoBdiEPsVk7kmrT984OpunjzszOiczs/qGSmWQzbNeifry6r4x
 wleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752082582; x=1752687382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CEuPJly845h3GwOzkyx/hdtbI77aynIptOJU4pCB4vs=;
 b=Xa/I+ePBMxzZwj8arr04NUtAAjkbxC25ThByBTgjhQyj9tBrPMLWSv2Hd2gZ6JhakT
 cBe2NXfEAqShb/mhfHlCCIb396fJ1jrfVTpXagYtgCtKnYMiv1hlHTH7wVkfcfYpfHVv
 NaM6yU2VsACKZS+BOgCkNm6v1RWv3BuOyFtZkOmXEvia6ciJeegG61aNXNmDUFe2zsWE
 ets7jMWVp6z5QSVFp0FfEmS8GTAO8yq2EnXXcfbUe/JKw4E7TOKx/wXCoGwkYqQF9SIG
 Vk+8gGNQWOPhHB93MHcojO/tBHQRF1bJYhEKNXHuvC6J1i2Ql7tvZMdmjz503kTRr3+e
 Kfmw==
X-Gm-Message-State: AOJu0YzPkMQLBPKHOforiQRE6KKdGsKtQ5STuP7KPGTKHHbVVN+qVT88
 gLDmQKsz835LoCtCCYsbqX6TFqgOruY/I3bVu1kAuPpOpv49hmn9pLIubca/OYgGYfSuBJPCmXy
 VBz2U
X-Gm-Gg: ASbGncs/VbzWsw9VTLm9GIT+/qrswcxxFhj4SKigrhJORjmq+/G3Ls/u20Cqah655Gx
 Cc1bjpNWZg3hTqcEcHe7T4Evtd5iM3X5MK+JRMwqmPg6Md0GZrdKd7ncNejItw3hCjgcBSJQyxD
 4uB8RJYnEBnSBD7bgPnasRQwocsJwOoQdCMmPhf04ujQSxWUTQNohsIK7k8jNRdtocA/WJMl7iW
 j929y7718z/7xjPDm7orQ5oxl0/CD8Nkmp/W6IjkU5SMo0dYtEocXRa5249lrhSZJK+5M7j71ZV
 FYyMVajmfYP6zCLfT1zdMseu28whOLB2l3JyQFm99oAC1qJZPzLVg0cV12/4PcGNxD1kmAb8/XG
 uCPTMwVig44VEXv9rLbKvfjJ6R/gp2JeELWf+
X-Google-Smtp-Source: AGHT+IE00vCzn8HOw66cMR7tGZle2dRLcxqRAh87hwylanEIljuwITeLMnvQevKkCCfO0f23iKgTjA==
X-Received: by 2002:a17:902:fc50:b0:236:7079:fafd with SMTP id
 d9443c01a7336-23ddb30f7edmr50375895ad.36.1752082581696; 
 Wed, 09 Jul 2025 10:36:21 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c845b7467sm138525475ad.230.2025.07.09.10.36.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 10:36:21 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [RFC v2 07/12] pcapng: split packet copy from header insertion
Date: Wed,  9 Jul 2025 10:33:33 -0700
Message-ID: <20250709173611.6390-8-stephen@networkplumber.org>
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

