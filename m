Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5F2E6529D
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Feb 2026 17:20:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA0F94065A;
	Sun,  1 Feb 2026 18:20:04 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id D8D4240150
 for <dev@dpdk.org>; Sun,  1 Feb 2026 18:19:53 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-48068ed1eccso33310165e9.2
 for <dev@dpdk.org>; Sun, 01 Feb 2026 09:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769966393;
 x=1770571193; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MCYPMGlc6nQHrOo9GPbYciZ7KorDtY3PLqf6JhFhiGg=;
 b=ndrCfMZYvSByarSIIA6o+izGsoz4vphMgSGunKU/hHf+25+oKdP+dloyJwEvmyZffg
 VOOgPhU/fk5uNOSkdM7EAeP5X2N7Vfg1JxFz2ntKKOJNq5alpiCt9tMwVBY5Crpts9l+
 LO5x4G4v6bYKjv5HWd+NSswbWPtZp3Va2ZGUUM/WV0Oox/Rka410AbJTvn8sq9d0hVD/
 Nuzq/jHh6KjB5tOUoJd3tPdIZ9NBBkcmqU0KOUQTKjz0ZSVGegY1JZm73JfY8zr5a9kt
 DXKZgGeRUnkqVmn8S+N2IBMbJIoaO3FN2pzU+FcGmnxigiucsvMcejAMjq4oGx/zYYXu
 SiIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769966393; x=1770571193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MCYPMGlc6nQHrOo9GPbYciZ7KorDtY3PLqf6JhFhiGg=;
 b=U0RP6oI4LhOEVimrgc5bJiz2Y+2nO1FPnRbOM9ueTKt4TRG9p4E6IY5AI/ESnBPEkm
 UnDRH4tuEKZ+oZEvsAMpketjN0LB0GYbwxYQ6YwBZTREhRCTYLeSRS5d70SolL7QV/jU
 j+2+t1cQvoZfv8GU+5xLHYdy0ghzBFlN1nMI2pu79GsUblf/9QdAWT8I6gQRUDkyU5ym
 Cx+qJ4SZz99otCvaFtVUMqmPbE3jR4B/Gwia9uOq9+/Kfv+0SgqEgKxoghMjgMDHztRu
 wB0VLiD2+AtSe3+ZfyCo/HFcwqCuI5xxn46YpIcGQdEcdDmMJN8ZX0Iej+kDlSUlotTw
 c9Zw==
X-Gm-Message-State: AOJu0YwXrpcvXAMXmmzi+7e+0mi/NJITgLz0W+Kgsp4vMpVeb33YSlRL
 ZF4Xt0mlA0U2109IvrsRBVvM9elfefrrYtVSVGk9EQQMVhCOaIY09Csa+IKPyWIsMAEGT062HXX
 NzoY4
X-Gm-Gg: AZuq6aL0XWj4+1NMMHiJtQ5CgwBywseOLpjcUxqcG0/bZ9qHw7/cPxKVqbOzQgd07ka
 NOpDbo8JdYrS6oB5HxhTfAkEQnRmJZ95Krp1JAbP03MDne3ZhJsDFGiHLleC2GjCIspT1dtj5og
 q1rNWtbwQ3nBasRVllM8TULgmSfczs3wHAb204f8r54LhiWm4xNnvqLloNFNBlALSmPHcvKgf92
 pt2GMRN61MDwpuFCn2kT9sbVeSgBOgZyZQECs4oHHPPTva3w+SQbPztsqJp+J5V7P3d1n/ZR2qQ
 WwvMnBOAlT1vksNsDfd3WdkJ3fuMMrxzIenrbl1fsPX/RhNwVlSKPzzmm/4NEv37aGk+IGHlCCm
 1VDwHYoEJaqKMFyOLseERKl6Y/55dOKoKYft+GC/eljETUL7J3P6QCjO2yxs98rZP1Mm1UYemEc
 SXJPxeOfSNGQcrdqisgSy4EOaSx/8jEsU1SCDe2cOkLoj7Vfm2CQ==
X-Received: by 2002:a05:600c:64c9:b0:480:6999:27ec with SMTP id
 5b1f17b1804b1-482db45ca9dmr114259555e9.13.1769966393463; 
 Sun, 01 Feb 2026 09:19:53 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806cdd79c7sm346810765e9.2.2026.02.01.09.19.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Feb 2026 09:19:53 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v10 5/6] test: support larger packet sizes in burst generator
Date: Sun,  1 Feb 2026 09:17:36 -0800
Message-ID: <20260201171938.89492-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260201171938.89492-1-stephen@networkplumber.org>
References: <20260104222523.329760-1-stephen@networkplumber.org>
 <20260201171938.89492-1-stephen@networkplumber.org>
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

