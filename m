Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C79E63CBF
	for <dpdk-dev@archiver.kernel.org>; Sun, 25 Jan 2026 20:24:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8FC63402DB;
	Sun, 25 Jan 2026 21:24:40 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id 3677E402BE
 for <dev@dpdk.org>; Sun, 25 Jan 2026 21:24:34 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4801c731d0aso30148395e9.1
 for <dev@dpdk.org>; Sun, 25 Jan 2026 12:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769372674;
 x=1769977474; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oVMhg3VPWc7Uo8dzr6jNg+mERUcssrdosb/erU4qS1g=;
 b=dFihK2K/ttEey7ZiSf+QDh2aJiD7klUjdagca50Sc1LdV0c0LAmIK2XZKTA9haE+Hx
 u71kHjA8F+aLtVj4jAM4oTK9xu1rvidT6KB1Mb6kQ3mlQmJEXif7ZJDGCwYSxVtd43zg
 jLoaIKX2Cp9JpUp2aSpguEanV/I3N6h+7+5X53wjGDS/ujTv03PueZAW4f+5Rqccd2MT
 j3BZ4NqJm0QIO5AnhbzW6hD++6MuYhofYEAEaHMGC49DhfEyu6y467FRy8x89gbuKkho
 fEo00/kLaGr73ER3kF2dykVi+Zp9fzFAnMArPyMNOEYntrL7pJyW6vGaEe4r3w/LCoxk
 0zFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769372674; x=1769977474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oVMhg3VPWc7Uo8dzr6jNg+mERUcssrdosb/erU4qS1g=;
 b=Ozmvy3Q9nysG1hAQH9VPAtMNRyRSL759C5jirlw6JPU0jtOYU33UASJo1TFy7N9rB7
 dLU7pR9ze14VCk6qssIjaU44DSQFwS6F0vC0VlcPDUhrLPPpmsw+GMkM2DYMsaC4pId3
 NkOKPDSvk1nadL3xrjT23ujHD0dn2Je244aNrDncrt4GtT1jllvhKf2xLukc+Kz8r1H1
 UIQpc/opZhqXFB00oBUrRsiA84cjdapy/V2Z9JSf3Y/PY8sPWZcvcPDBB4h6Fpv9r/tN
 kUy4Gr1WrXb7zC7QGFolIGGRHo7cAaAay7rNpDWAJSi7omj3zRBD1KxOt6iWmIIlU9+x
 vfXw==
X-Gm-Message-State: AOJu0Yz52tgu2uJFtSe5dBUJxQ0d0lxWP43etQAEGxnBjxycFblldefK
 HmKaG/W+GNOfg/k4pdmXM6Z4fOKMgHxV6X8VgVwbzjyR/9UsOyFTdxIa3iiN4DRzlXyr0XxbT/L
 LVLYJ
X-Gm-Gg: AZuq6aI5j/ZePjDC1lB9tpEqcAdk3o9qYjlUjbJotnyzh08iVREw1JhQhnhxh66xN62
 IJ4Dz7eSERNHfpgnfEXzePdHlZRAd7ks1FKfyIaE7TUi/gw4GH8kyqRRRvJ7pZHfTU37jgerI3Q
 88ra91A8d+dLVYGax6e3rc1mNdYcY52cs8GjKR/f07kY2LB9Ev/LOYh1IgASkyxunHWW/MG6/Pw
 Q26BDTCuLQ+AfjeVTFQXWt5AviVsk5BR+b7/9smsluHf1+v6bzaPq00QRnaoffQpxBzqxFx7Lq8
 UdBK9avfkTX95NOnrVrH+lq9FwmXwtWkSX36nWw3M/4JCSy8aBduKQxD8fG++kts29qSm6optH+
 fJV3D+XsIvsHPiFyquTK5Ma+Qu0dL25HS0TV35Z0SfJl8RRQ0Ig0jx4HWqtfWXYQJnTesm3zCff
 nRlAGaLdt4m10Y7x52PvpPBH/t+N2ZtLNCbTOEKI/dc4EP8oQx+g==
X-Received: by 2002:a05:600c:548d:b0:480:1e40:3d2 with SMTP id
 5b1f17b1804b1-4805cf673b0mr39148685e9.29.1769372673739; 
 Sun, 25 Jan 2026 12:24:33 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24bedsm23682024f8f.17.2026.01.25.12.24.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 12:24:33 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v7 2/5] test: generate larger packet bursts
Date: Sun, 25 Jan 2026 12:23:02 -0800
Message-ID: <20260125202425.532542-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260125202425.532542-1-stephen@networkplumber.org>
References: <20260104222523.329760-1-stephen@networkplumber.org>
 <20260125202425.532542-1-stephen@networkplumber.org>
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

