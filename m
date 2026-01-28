Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830D9D46BEE
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 19:01:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5EF864067C;
	Wed, 28 Jan 2026 20:01:41 +0100 (CET)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42]) by mails.dpdk.org (Postfix) with ESMTP id 3E66E40647
 for <dev@dpdk.org>; Wed, 28 Jan 2026 20:01:37 +0100 (CET)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-4327555464cso166646f8f.1
 for <dev@dpdk.org>; Wed, 28 Jan 2026 11:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769626897;
 x=1770231697; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oVMhg3VPWc7Uo8dzr6jNg+mERUcssrdosb/erU4qS1g=;
 b=JRz/PbxAu6Isl8SScD+eUZlM7rbyzX1cS7HgFO4Z8qeeCSCemCUrCEK6zi5qn3XQnX
 iAE3yweQlikbH5I/8qFDA7CCvln3Tahl6SIuMA/MTi6YEpARvJYwSGlJ+WpYT3Gc8yHH
 O0l6tW7+YaYa30BbZoi9k0W0Atwj/AxWCTHJGZxR6stB7E1YrwWwZur05Z7F5apyQVZu
 OBufXkT7LzBWD7JxDVn8aGvs11t/afmL+uc/fU5N8quTUb51ha2M4uphyFGo2J1NqmSi
 fbN5nOQVrMFwgPm49DkLT1vX/FloL/zFI9OUFcTLlgSdlzokQfZJLh5aDqQYXcDkBHZn
 sXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769626897; x=1770231697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oVMhg3VPWc7Uo8dzr6jNg+mERUcssrdosb/erU4qS1g=;
 b=pyD7OU+A6OxYYStOTbMZKoP7z/OANuHDXTst1SQUS2WKQJ2pZsWid8joL4pHzjiHDg
 PVuQoKz3XOnu2dvhWV6ygVQPIpMv9u3bkhb3+Jmkwl35OzmBj+xoUlTvTxmnvQ77xJYg
 pd37p7xca6lDnZ1P4aonVcKaK+tNvYGudZ/gfQ/KdGpjdSMQTJMgmpZ7TI/bgfDPv2Yt
 j5Q68yaHYeq9HgiLNpiCm+hTc3Xp9yNS/d4WCmsP9yzkWaf7vVWOtDUhGDbSuRP/9oEs
 gpSkcwm6FivOiAPs4G69SBo0VvDHCY2MUz+8HYJ5cwquNix6rpwiQmK801svsL6NoJzt
 FGRQ==
X-Gm-Message-State: AOJu0YwutRTUvyypSsBkrOjQ2b9076WPIEsq8QfhRQUht3Q047udfJmB
 QLWrrAoBoAcVH5HMOrnzJixfu2a3Z0xsAK9FrnMkCq27xP20+kaAGju/pGZU6rBIWAy1ABc3NKM
 1BBZM
X-Gm-Gg: AZuq6aKgpP1RkHncGT7DuOXloPYBnX4UVuOELXVzlWa38YdKEhPfc8pwga+L4GIl7dy
 bFXPEWFkt28kh44zZY+zRKQYNGWxel6u5ZPxaPAy0ATLiEFWAkwwbWTyCR9ENdYzzFAExxPrVan
 Qv628a3aqbt/6sm5tzz2rTOybrpq2FTjWklvtpOPgLCQUiqWaUF+KVEAn2WJshRdiPMUvlsPUtz
 wacswFJlBGqjQT5q6++yFzRSEMPDFYUzlzLylNLmYHajbH1HEbSlpfQKuKfGNSiZv2o1puy3rSE
 TPnTNIwxWZhKC79cGzeedxc+EpRdATvl6pRsgCptVK0Pd7nPf1kAv9Qv+AHtQuuAPYsPSe6XFpx
 /FA385u9KKIwic0ZUaZTho++L2h7is9kuboqcUHm6vIBKeQi0G1qAM4eEvkjXHIAjAyJ86YQCQ2
 ooatI00Ypl3Bc7VVJ8ZNY86XRYVrMRB+IvWMEq86f/eGbqPHNsTw==
X-Received: by 2002:a05:6000:1883:b0:431:808:2d32 with SMTP id
 ffacd0b85a97d-435dd02e2edmr7517217f8f.7.1769626896816; 
 Wed, 28 Jan 2026 11:01:36 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e483asm8673333f8f.3.2026.01.28.11.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 11:01:36 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v8 2/5] test: generate larger packet bursts
Date: Wed, 28 Jan 2026 11:00:10 -0800
Message-ID: <20260128190127.465743-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260128190127.465743-1-stephen@networkplumber.org>
References: <20260104222523.329760-1-stephen@networkplumber.org>
 <20260128190127.465743-1-stephen@networkplumber.org>
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

