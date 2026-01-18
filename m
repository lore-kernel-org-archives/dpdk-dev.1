Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70540C9832F
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 16:51:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6253440663;
	Sun, 18 Jan 2026 17:51:52 +0100 (CET)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46]) by mails.dpdk.org (Postfix) with ESMTP id 71B1240613
 for <dev@dpdk.org>; Sun, 18 Jan 2026 17:51:48 +0100 (CET)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-64baaa754c6so5341761a12.3
 for <dev@dpdk.org>; Sun, 18 Jan 2026 08:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768755108;
 x=1769359908; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oVMhg3VPWc7Uo8dzr6jNg+mERUcssrdosb/erU4qS1g=;
 b=tuOVROwLsUryvsO8Z6HJhl2trVLZ80wYc7x+EkIL8JRWDALAx1CsdCOJO/Vlk03FIQ
 oeHyHr3qO8GEranhH/AAJ8r1ZIlBp035pIiKDKqE5AORpkdSbCCUhBfzMUM3Paz+YXfM
 uxEvwhjghX6rYh0EiSH85yOYhV0CdOk2B+PYO652TecfSB74ONONht8eYXpWO5o/oqBe
 AHiNnIlGI4gm/BBv8m5I5xUkZaWaD/joxS+ixVB7Sj0h5n1jis9iI8PY8t+q3fn0Wi2J
 wwmujvRR4iFhs7z0wIhPEEajzbz2YHCgH5OkAQyJ2Ezj/ZYlXFVk7/z4Xiocoy9g0nbk
 Xy/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768755108; x=1769359908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oVMhg3VPWc7Uo8dzr6jNg+mERUcssrdosb/erU4qS1g=;
 b=dh0iH4vZjaGPd0nDgAaDvIHPUglIAakPcRM13xMJxgfB5RdO0VZ6Fg5bOfn5JtcZ0j
 dOrMT7cObxgJVGmEAPRT6aL9x6m8iCxtvDC12nddpi7ccX6cp75/urJASat8l9tJAre0
 f2BuzHeGXLNZhkAiNsODY2hKX+erHRLCt0V2Bo88+70Ldzs0EwvESVLl5nKnPeQ6WRhk
 XRMCx0HM525r75JLTQVDi+qIx5aenzO4QIS8slLee0wZCtwplntbeEIi4ApfgyFdIU4j
 nR/JD3wFvYb0spIrzuotF7IH3j/y+0wK+gogSYIVgS8+5QXHF+hk0sEmJXSb99HMK+vm
 /p2w==
X-Gm-Message-State: AOJu0Yy/4RVaeUzgE+Ve9X92SF/XQEEsEuWwa1xGKBRcvP5GzDO1oofG
 UC+5Ur1jRYiDWRCvyYGHv/VzUglKp+oCPA9zv+ypJbzzyJBZyhvoqfyTgKfpZxGLqIQkSd8PWkT
 zc3S1
X-Gm-Gg: AY/fxX4g/ZSxWjDuoUHr2JR9i3oHjiHNaA9i2+40b060qu+7tcEcP9ULkc0qgmsLIAs
 xA6Gh+8by1g9Q6sQfzOcWBOKmNxtfKSDuqGzyAwEg0xAXuKCOHxNNIA4cM9ch9+wobpm4pJmV2/
 WaS0Asdka67vTYGAxh6ecAEukhiWqBqDPE59CoSHeH8QkhMZxMaVeL3QJwlhr1LnzDIkma/3Oe7
 5VWCMi4EaKjzL1/wWTsTPX9lqeNcY+r5rfPoRCwkm42lSFqAiyWAimTdKN1bQKcAJpxvHg8Knlp
 wtcqOjOzJlEBy/svRgkzT/qU5b8cqeQ22u+V4UrQwaZh0pFN0tFvexZJ/vMXJWbRsSCJahERcfE
 NnD4qUOmt193NF32q1496AkW5/qSmoRY4oR84Iz3dzdu+GLgEtHNmvMBKbE961azbCZ73pZTTIM
 +Al4mfYRPjo0+A03yo8UwdbjOoExw1sqBn74NHfNFG2jh9XAUtzw==
X-Received: by 2002:a05:6402:3648:b0:64b:5562:c8f7 with SMTP id
 4fb4d7f45d1cf-654524d219dmr4889803a12.5.1768755107435; 
 Sun, 18 Jan 2026 08:51:47 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65452cdb0b8sm8045946a12.12.2026.01.18.08.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 08:51:47 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 2/3] test: generate larger packet bursts
Date: Sun, 18 Jan 2026 08:50:44 -0800
Message-ID: <20260118165138.37730-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118165138.37730-1-stephen@networkplumber.org>
References: <20260104222523.329760-1-stephen@networkplumber.org>
 <20260118165138.37730-1-stephen@networkplumber.org>
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

The packet length in packet burst generator was uint8_t which
limited usefulness for testing larger packet sizes.

The number of packets segments per packet is currently limited
by mbuf nb_segs which is 16 bits. The comment is incorrect.

Change nb_pkt_per_burst to uint16_t since that is the limit
for tx_burst.

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

