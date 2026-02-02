Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AABE7FDF2
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 22:19:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16ABA40671;
	Mon,  2 Feb 2026 23:18:36 +0100 (CET)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41]) by mails.dpdk.org (Postfix) with ESMTP id 572D54065F
 for <dev@dpdk.org>; Mon,  2 Feb 2026 23:18:35 +0100 (CET)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-4359249bbacso124396f8f.0
 for <dev@dpdk.org>; Mon, 02 Feb 2026 14:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770070715;
 x=1770675515; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MCYPMGlc6nQHrOo9GPbYciZ7KorDtY3PLqf6JhFhiGg=;
 b=YBudqLbZaZXS97dxEwxwmzTO/tuAI4iybHPGRypgFHmlE7gyWP/2rUCqtiEOKflLGy
 ziZmPbYqv2J1IjiXOHqGIpnmYQmtrUVu8seFYKcRm4Z2cuC6I/Zx9wV3XVYFJ6Nt3QKE
 GYNQoxsbn+abq8Mawkb24mN8Esck45C0skhwfsg2h3bX5xUAyPpEuzQXCYHgThGtA3XN
 lhc9aTPmu0Vu3q8D1aQ/NxYYBbRfWIDg2xI2YSYQQP0uDMUXuCAvLt92Lc45ptcs+UpF
 uRWZZsM3TZdUefBzGgNffiVyC82SDZJk/4+nt+/LR5OdoCqKMlZB4skV9PTDDQ2cB7E4
 Jzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770070715; x=1770675515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MCYPMGlc6nQHrOo9GPbYciZ7KorDtY3PLqf6JhFhiGg=;
 b=inkonBP16+Lvntx+pTw9hOtSnCxZUDfkFAC32AlhKsqSJzhply5nbTjbgmZ2DuKyMH
 UnncdA8PXmBCMqdx9o7v7zaMs12Z3cEdGB0fc4Ai5epL6qtVYrmCSu6xVlN6ADCh+wr9
 B7vKHuNveCWh6P1cl7jHToEyL8gScoz/ircIp4fsScPsap4Osm/MCosi9XkbKcMYqS7T
 3Du/zFfpmChJRIF6l+b5xzVMmec089h56yDxnUKTRRWZ7CMde3ckgR3BAAUbgp1zTmVl
 oQaVwh7x1OUG0JdwC1WRmlhwta//dfPLdtNCDsuHjZpH1xJKYXf6D1y1LPciE+0bnpgi
 0NJA==
X-Gm-Message-State: AOJu0Yz1OGHDB+Uk6voLm+7C3IErwhP5oYwXZYdi+4LiDfJxA2ib7Gy4
 ShBIAEwL1FeW+Zpg7EWN5JYZyZ/orEqnD9X/DEFvchuOkYzYyJEHGAIs8Hkq1ikF8gN8zP1AHVG
 5+2op
X-Gm-Gg: AZuq6aIDRMQ5IKsoU0emGfDJ/4gsrO//rhtMLyT33XSJm1xrgZGhCut9aQ+iQF1tCNr
 aqsG1/cz37bLvO8MoFhILXmEBFBOXMa/Ab4u0O62gf/xhnSqXTCovYesMs7Mvwy/UFBhP7kCJPT
 VqUWwr+9dXdmqRCwy8r01hYrlSRwu3EaQC4BNxx6PByNv03RMgdNBGoFpFyoTDvIupNBE3/XoHr
 VryTGaVRkhJ6h4FUN5v4HRAxzHYqu1qFdtm6hPpW1ArHCYuOF36Q6sYXcJy1a5cITP5//C1xg59
 7gD/bO2DFsnREpgTC9sWnq+Rpbhcje7fvTU38p4EI18+Xxc3k3KOYj6vOQiD6RSD8zFg0AUj1/k
 Y7gPzERmZ0JQqg8y78X5vcIPNGtgE44iFSucU5Ot5JAj8S0ASxMOxzgwLHAanRYUF1M/U7bpmHp
 6uFpY/hy5sMvmyf1vSce83rwOvckH3gExrlKwGBrpFY34BtsSJPg==
X-Received: by 2002:a5d:5c8a:0:b0:430:f2ee:b21f with SMTP id
 ffacd0b85a97d-43611427af4mr1462857f8f.22.1770070714872; 
 Mon, 02 Feb 2026 14:18:34 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10ee04csm47109336f8f.12.2026.02.02.14.18.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 14:18:34 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v11 5/7] test: support larger packet sizes in burst generator
Date: Mon,  2 Feb 2026 14:16:50 -0800
Message-ID: <20260202221820.204680-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260202221820.204680-1-stephen@networkplumber.org>
References: <20260104222523.329760-1-stephen@networkplumber.org>
 <20260202221820.204680-1-stephen@networkplumber.org>
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

