Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC16DD39005
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 18:32:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 007C840DD5;
	Wed, 14 Jan 2026 19:32:19 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 863BC406B7
 for <dev@dpdk.org>; Wed, 14 Jan 2026 19:32:17 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-47edd9024b1so967685e9.3
 for <dev@dpdk.org>; Wed, 14 Jan 2026 10:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768415537;
 x=1769020337; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oVMhg3VPWc7Uo8dzr6jNg+mERUcssrdosb/erU4qS1g=;
 b=3CLxRjtALZBVu9txBjGBri0hDYOu1B6snVwucBOorDZJVoJsbKHFoRLhzy8s8x09Cn
 GPIzGOjeLKQQooIb/AqdNgWjNaFpBJA0/UPT3gZ0BiQ/clNpGh7YIHEg1dvTTqR862RT
 UYSC0kriMNoJyBCnIRr5RZqcVwdCaElkbLIah8ryEUOzYDFk09rZysjvklLckwhPrtym
 XoMBpzLlhjwvDfUrihALiGvyp4QMSiYHkTQj0fVNg8kZ/XISd37HyWte+WAVBqw+v6MG
 2m4cSYqObxsK4DnIqlG+AyxTUnfjdg4dO7Qv/QuEOL6b1dzD2r6W/I+jgsp2bZ6GW0Sa
 N9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768415537; x=1769020337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oVMhg3VPWc7Uo8dzr6jNg+mERUcssrdosb/erU4qS1g=;
 b=P1Aei1f71vb/Yls0wxq8RHkppOwoW38JQFWEj9AClvj8v+65Ea1LHPUpFHdg3WC7C4
 L11+1I5FWk8efzaTzVlMredU0gUBP1CWsSF86qGoy7k7A8aaNFOggDFsZOUYGK5dHBH5
 qr527I2wfhb54f+7giUGgkVQM999Duc1RQ4pTDynjBcEonBppEMLf07rU2NlkAfmGDfD
 42Pg+Wwtrq5x/fC66/LM+zrMhtF/Kx85hPzzQ2rs09hTBmom/SP+cknNc+vbZ43occG+
 a05XbZrkDuAFXGJkzvhUslX3eDZzqO3/s1S/li8uuK5LE1X5CNPJjb36OZ0p+hgROfO+
 NehQ==
X-Gm-Message-State: AOJu0YzWt2wNON/uZAGPIlwNeLz9lfOz5XQBUI/pg5zJ7m73kb+ROOnz
 BLmIecn9p47sNd/6YEodLs+vMfZliCQP2ug9iLMWmki+CzSqcbanUPvCBTm2lEF1UpQYuWcpPpT
 XJN21
X-Gm-Gg: AY/fxX6dZUpJZrCvdCxVzYidCPzXrKMHiLqr1uRhz6bstoClUMfW7lWNr/GVqvhxgcc
 XCdWLOf8THgMMTvCiDjSEBCojGKknGlbuk/eGUEQsc+fGTo/91CJv0HaryGz6f+7ys9lrHznwHN
 kTHs/T1mCReVuSn1MQ00Rth4gjgnnnHZ20bVcwARqZnxF/O0Ndk1Tl69wG0SRaqzPc/0iTgNZT2
 wcJffsibyHrLqhryTDzeDHoZZQx4AqS/fYQ97/Zj6fH5QF5UPvXFbZAyyUnP3s3k4kcFy1e/Ejo
 4ziS3GFTTI1O84sXB7ND3JXrIyGv4FuW+zMBHk5ndTdKfHh6Cy69UC121tiHzys+W38ZWazoDZv
 N6agIVY7PHDUB2Xy8g0jWLmS7UvVYJ8gUpzP1e1tzYHkUsEO+XUv3j4MdRwdsGz5+XD5D/nmbgX
 tEQW1Fr0AyPkPYAyfIaBcx+JbXIRpAzxLD/l7R9+Kj7GAOmomG1A==
X-Received: by 2002:a05:600c:470c:b0:47e:e2b0:15ba with SMTP id
 5b1f17b1804b1-47ee32e03edmr42716415e9.8.1768415537027; 
 Wed, 14 Jan 2026 10:32:17 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f42907141sm4421205e9.9.2026.01.14.10.32.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 10:32:16 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 2/3] test: generate larger packet bursts
Date: Wed, 14 Jan 2026 10:30:45 -0800
Message-ID: <20260114183208.14256-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114183208.14256-1-stephen@networkplumber.org>
References: <20260104222523.329760-1-stephen@networkplumber.org>
 <20260114183208.14256-1-stephen@networkplumber.org>
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

