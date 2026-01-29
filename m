Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56890D73E83
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 20:27:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D59B84065D;
	Thu, 29 Jan 2026 21:26:55 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id CAC1740653
 for <dev@dpdk.org>; Thu, 29 Jan 2026 21:26:49 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-47edd9024b1so11594625e9.3
 for <dev@dpdk.org>; Thu, 29 Jan 2026 12:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769718409;
 x=1770323209; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MCYPMGlc6nQHrOo9GPbYciZ7KorDtY3PLqf6JhFhiGg=;
 b=TH/S2+CHb3zbB8yDob2Sc9+hfZMVgmRnNVjQsXMO/zlrETmy4M/fGogqUW9kjwCEwj
 qrv5r5gJG9YOTSmMI2nNjnrVzw6IDgCylemBNSIKqv62y5OgCZrSWpEa6iowYNx2anRw
 jE095gtqvlzg0bjjI7XOyGyFRVdZrhdlxEHFBgPRgr64y0KwxXXoGf1bvIq+NoE2fCXE
 8i4ke2jTLcREmcddnA68Dx4mY4GYaeMYlsYtLS7JPusFMB7KiIyg+ICFW3jpe1N4zfs6
 QrN5UTr9Ztu43HnyDTgeZ2z3DLObDA1tG+OVmRPGKrbFCR1LkrcuXBpwCGDhYK85qUP8
 eEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769718409; x=1770323209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MCYPMGlc6nQHrOo9GPbYciZ7KorDtY3PLqf6JhFhiGg=;
 b=bx7xMToOMJLayjuggKL9Ak2BMXPRaAxw/AXPrf6hVbOV1v8/F6lMxtmk3qm06la26n
 QxZIDaDfEOqaDsel14MchiY9YU/VZLqSW26+6WMEOzkMNq34kbbJk1UAl9TQIwI+vlBf
 SHEj9S0Z4wLwTP9C+VJQxwuHo4ZqJIeypteo+SIcM5y+SyC+GUMU0XZqCqshk/ge5/mR
 V9ZfqVPsvZwIvtAR9BCSSxhRggY53YN6Tcjyn7qXDiA+Z0CqCdgzE8oKPN7udfrSRthb
 e6mLV6AxOyoxLR0/pV4U/RS+PHVahpnnWESVzPAvtHfG3JWdGoDfqwXprF+SPZwjfAEQ
 WNFQ==
X-Gm-Message-State: AOJu0YzJ+Xawzw7dY7+wyZhcCT36Y9+NPRFYof112nOUt57++2jdaKBj
 ox7HYQMI38qPEcmkXFnSwye/8RHuyuUKdwQZyT3nKVTWPtzBPb9cLSs7aPDQ5xRq0X+9RwVEy3u
 tIGXT
X-Gm-Gg: AZuq6aI+94eduuTNcVrq6XBKdcKtyxyygxIVb4aprF2BFsEjCVKxmZwoxLiqn3e8/2D
 NpiH61Blh7g509eERpAQxWVjdGExQZqHNOwoe7LQshExeviCHnQd+9+MnvxA2TLuA1afuOl508i
 k3UcnclIUBv1pS54zBY5kprC+cQggVZYeiTY36Th6ub3xjVwIIYLdKQ9/amqjft365qYu84bIdf
 PXplWJyc6pIoeaxlb9miZ8To8kBP5To7mtRg9pYX5a6Q2CXz+PaPPzcov0xnUiVkHqjWHPVDcZS
 dFSNKNpyXptCPQsgvXNdn+52KzRXi3PdWlKJTWyj4VefpOfuxRem95juBNI1524b0JdqjCRMgxr
 pTz2A5+14fjEIas4rjRUW052iE8gYkYP2FWUMSudQcO1qzNJLtafRDtIJ2/pLnzXgKZx1QFVLfN
 XxaqGNCSp+KURZXmk3SvtA+F8lcvd4cieDa9rQEX8ysOSPqU9QSAz84ZDhWTHm
X-Received: by 2002:a05:600c:3e10:b0:46e:1a5e:211 with SMTP id
 5b1f17b1804b1-482db491f03mr3737335e9.21.1769718409406; 
 Thu, 29 Jan 2026 12:26:49 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-481a5e2ba7asm4819435e9.20.2026.01.29.12.26.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 12:26:49 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v9 4/5] test: support larger packet sizes in burst generator
Date: Thu, 29 Jan 2026 12:25:30 -0800
Message-ID: <20260129202635.173530-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260129202635.173530-1-stephen@networkplumber.org>
References: <20260104222523.329760-1-stephen@networkplumber.org>
 <20260129202635.173530-1-stephen@networkplumber.org>
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

Widen the parameter types in the packet burst generator functions
to support larger values:
- pkt_len: uint8_t to uint16_t for larger packet sizes
- nb_pkt_segs: uint8_t to uint16_t to match mbuf nb_segs
- nb_pkt_per_burst: int to uint16_t to match tx_burst limit

Remove the incorrect RTE_MAX_SEGS_PER_PKT macro that claimed
nb_segs is 8-bit when it is actually 16-bit.

Add validation to prevent division by zero when nb_pkt_segs is 0.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/packet_burst_generator.c | 34 ++++++++++++++++++-------------
 app/test/packet_burst_generator.h |  4 ++--
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/app/test/packet_burst_generator.c b/app/test/packet_burst_generator.c
index 4c17737739..346c69e6ce 100644
--- a/app/test/packet_burst_generator.c
+++ b/app/test/packet_burst_generator.c
@@ -205,24 +205,24 @@ initialize_ipv4_header_proto(struct rte_ipv4_hdr *ip_hdr, uint32_t src_addr,
 	return pkt_len;
 }
 
-/*
- * The maximum number of segments per packet is used when creating
- * scattered transmit packets composed of a list of mbufs.
- */
-#define RTE_MAX_SEGS_PER_PKT 255 /**< pkt.nb_segs is a 8-bit unsigned char. */
-
 
 int
 generate_packet_burst(struct rte_mempool *mp, struct rte_mbuf **pkts_burst,
 		struct rte_ether_hdr *eth_hdr, uint8_t vlan_enabled,
 		void *ip_hdr, uint8_t ipv4, struct rte_udp_hdr *udp_hdr,
-		int nb_pkt_per_burst, uint8_t pkt_len, uint8_t nb_pkt_segs)
+		uint16_t nb_pkt_per_burst, uint16_t pkt_len, uint16_t nb_pkt_segs)
 {
-	const uint8_t pkt_seg_data_len = pkt_len / nb_pkt_segs;
+	int i, nb_pkt = 0;
+	size_t eth_hdr_size;
 	struct rte_mbuf *pkt_seg;
 	struct rte_mbuf *pkt;
-	size_t eth_hdr_size;
-	int i, nb_pkt = 0;
+	uint16_t pkt_seg_data_len;
+
+	if (nb_pkt_segs == 0)
+		return -1;
+
+	/* Calculate per-segment data length */
+	pkt_seg_data_len = pkt_len / nb_pkt_segs;
 
 	for (nb_pkt = 0; nb_pkt < nb_pkt_per_burst; nb_pkt++) {
 		pkt = rte_pktmbuf_alloc(mp);
@@ -300,13 +300,19 @@ generate_packet_burst_proto(struct rte_mempool *mp,
 		struct rte_mbuf **pkts_burst, struct rte_ether_hdr *eth_hdr,
 		uint8_t vlan_enabled, void *ip_hdr,
 		uint8_t ipv4, uint8_t proto, void *proto_hdr,
-		int nb_pkt_per_burst, uint8_t pkt_len, uint8_t nb_pkt_segs)
+		uint16_t nb_pkt_per_burst, uint16_t pkt_len, uint16_t nb_pkt_segs)
 {
-	const uint8_t pkt_seg_data_len = pkt_len / nb_pkt_segs;
+	int i, nb_pkt = 0;
+	size_t eth_hdr_size;
 	struct rte_mbuf *pkt_seg;
 	struct rte_mbuf *pkt;
-	size_t eth_hdr_size;
-	int i, nb_pkt = 0;
+	uint16_t pkt_seg_data_len;
+
+	if (nb_pkt_segs == 0)
+		return -1;
+
+	/* Calculate per-segment data length */
+	pkt_seg_data_len = pkt_len / nb_pkt_segs;
 
 	for (nb_pkt = 0; nb_pkt < nb_pkt_per_burst; nb_pkt++) {
 		pkt = rte_pktmbuf_alloc(mp);
diff --git a/app/test/packet_burst_generator.h b/app/test/packet_burst_generator.h
index cce41bcd0f..bc16764e77 100644
--- a/app/test/packet_burst_generator.h
+++ b/app/test/packet_burst_generator.h
@@ -62,14 +62,14 @@ int
 generate_packet_burst(struct rte_mempool *mp, struct rte_mbuf **pkts_burst,
 		struct rte_ether_hdr *eth_hdr, uint8_t vlan_enabled,
 		void *ip_hdr, uint8_t ipv4, struct rte_udp_hdr *udp_hdr,
-		int nb_pkt_per_burst, uint8_t pkt_len, uint8_t nb_pkt_segs);
+		uint16_t nb_pkt_per_burst, uint16_t pkt_len, uint16_t nb_pkt_segs);
 
 int
 generate_packet_burst_proto(struct rte_mempool *mp,
 		struct rte_mbuf **pkts_burst, struct rte_ether_hdr *eth_hdr,
 		uint8_t vlan_enabled, void *ip_hdr,
 		uint8_t ipv4, uint8_t proto, void *proto_hdr,
-		int nb_pkt_per_burst, uint8_t pkt_len, uint8_t nb_pkt_segs);
+		uint16_t nb_pkt_per_burst, uint16_t pkt_len, uint16_t nb_pkt_segs);
 
 #ifdef __cplusplus
 }
-- 
2.51.0

