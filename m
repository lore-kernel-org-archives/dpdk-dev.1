Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F39D1D492
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Jan 2026 20:45:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD1E74060C;
	Thu,  8 Jan 2026 21:44:58 +0100 (CET)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47]) by mails.dpdk.org (Postfix) with ESMTP id 5AF0E4060B
 for <dev@dpdk.org>; Thu,  8 Jan 2026 21:44:57 +0100 (CET)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-b79d6a70fc8so672707066b.0
 for <dev@dpdk.org>; Thu, 08 Jan 2026 12:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767905097;
 x=1768509897; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DyIDxSumWApMzCSF8tdGruP0CLLMpCU4EQ/b67DAR9A=;
 b=YYWytN3FEFkD0wXo9O7aSO0MbtZtS5wlOLeeuD0kljmQioW+8OhXwkZQnUBYDsnS/K
 hEIelakH4/A+/Oexu0OKuGngar0uoOCBTbVDE1zs3EkkJi+UG3usWZKMAaABFQ1mcfXl
 jnku3/5dVE4Qt19PeI0saSHSqf6aHOA0dYmOYL2onOvbWCPHbAdYTbbxiLGwXWYutI5E
 dqlDGWDeC2AYLC69ikvu4NOFAqs+uWbKJ8nVDwvloi8GLntp1kAKzNNFlhXfKOL5Uvwe
 dz5mHQJxpTOoxKaXCjre9a2oAld0X+suP98f7Dlw1ATBNo1+sKMdoQJwRwImpuQDYZLo
 AVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767905097; x=1768509897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DyIDxSumWApMzCSF8tdGruP0CLLMpCU4EQ/b67DAR9A=;
 b=hPnNK+EaTgKDdeWydhFC+ygOMqaD5Yah0IZveCkgatVBBEUjLQYcTNJ/qRRm//8Oq8
 MXqVCVeZ3mSVrfLw/LqXCBHpyTWqnR7J5/OIkGkS1UO7JIhbYlC/NB45hh9OGZsqipkE
 J/oqzNccHKklnMEmMvMmngUfZYfLXD9PFeYT3pESBkJcKSo+k0sv7xvkxtYBzzp0PMvr
 bTmnnbkIZcpWXdwljSNE2ovq0Z4HWKZU8pWioT7v/pa086jvpr6RlRIUxoSLAK22R2XP
 O0ouFF5/2zpbIcTYiK5UPkU2mNVTQgPzU1GAUyEnOKFOWrOSSNdY6Ulq3nrjT0t/QDsX
 UmRA==
X-Gm-Message-State: AOJu0Ywmt2mLXttJUrbfzDb9XHJ0ur3GKMiIuShvVoNFSkVyK8Rh2k3M
 8hlehpm6QAP7AvyK/fjqNniVcmmfhTHPDr3e2cK/UX7paZVdT0JVQJ1+zGPbXVfjzbziWjqRjoH
 DH79R
X-Gm-Gg: AY/fxX6dhkPgiaNNKP/+hTg74zrjeB02IsSoAcey5adG9qXfM9jG8MVZqe/1/Vce3hf
 itcztVNmu0IdCysvtS1IYbEHcsbHkf2dzzMT/wHUg0BJhdNM2YT/Wrae01nL8Osib3IeeoUc1nR
 QA6dGYEGZAnerbP3J/oXU6fsSJM/9sBV29mJmFQ/HpSuRGUzdF6Jz0dOX8HUugKr8UuCrGraFHn
 OjpvnN/xC5iJpAYqKyioZgmex73ZLbwCAe/e9ktjiG1fxtiKglpd/4BK6f82gxjpCDSorVlGrzP
 gYnRLFGz9KH+UzzwfAze8H76q9JYa9TYxkOJDtpnE1yiHD9/bBtVWHu45OQS4Uo2QIh5cilK0/9
 xUWnRjGKLx4ze644VDcGppaAjozOAtRq3MybI7Xu/Plc+h6JjglQKiJl+TPnNsrIFEiaw0ttlSd
 aP/9ZCvC6oEtsLpzUB6jAlKWQ4v+8aHilk928Bjh9F7Jw4SWOa5Q==
X-Google-Smtp-Source: AGHT+IELNvGCiU4Kh82pUOhO9oBnUGagfE/SB+FLgF0+RAwTzxi/yYkUriax7iZpGD1DqLWG8NOc1Q==
X-Received: by 2002:a17:907:1ca7:b0:b2b:3481:93c8 with SMTP id
 a640c23a62f3a-b84451d97abmr734340166b.19.1767905096882; 
 Thu, 08 Jan 2026 12:44:56 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a56962esm921348766b.66.2026.01.08.12.44.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 12:44:56 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 2/3] test: allow larger packet sizes
Date: Thu,  8 Jan 2026 12:40:47 -0800
Message-ID: <20260108204449.176087-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260108204449.176087-1-stephen@networkplumber.org>
References: <20260104222523.329760-1-stephen@networkplumber.org>
 <20260108204449.176087-1-stephen@networkplumber.org>
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

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/packet_burst_generator.c | 30 ++++++++++++++++++++----------
 app/test/packet_burst_generator.h |  4 ++--
 2 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/app/test/packet_burst_generator.c b/app/test/packet_burst_generator.c
index 4c17737739..4f659e4d71 100644
--- a/app/test/packet_burst_generator.c
+++ b/app/test/packet_burst_generator.c
@@ -216,13 +216,18 @@ int
 generate_packet_burst(struct rte_mempool *mp, struct rte_mbuf **pkts_burst,
 		struct rte_ether_hdr *eth_hdr, uint8_t vlan_enabled,
 		void *ip_hdr, uint8_t ipv4, struct rte_udp_hdr *udp_hdr,
-		int nb_pkt_per_burst, uint8_t pkt_len, uint8_t nb_pkt_segs)
+		int nb_pkt_per_burst, uint16_t pkt_len, uint8_t nb_pkt_segs)
 {
-	const uint8_t pkt_seg_data_len = pkt_len / nb_pkt_segs;
+	int i, nb_pkt = 0;
+	size_t eth_hdr_size;
 	struct rte_mbuf *pkt_seg;
 	struct rte_mbuf *pkt;
-	size_t eth_hdr_size;
-	int i, nb_pkt = 0;
+	uint16_t pkt_seg_data_len;
+	uint16_t last_seg_data_len;
+
+	/* Calculate per-segment data length */
+	pkt_seg_data_len = pkt_len / nb_pkt_segs;
+	last_seg_data_len = pkt_seg_data_len + (pkt_len % nb_pkt_segs);
 
 	for (nb_pkt = 0; nb_pkt < nb_pkt_per_burst; nb_pkt++) {
 		pkt = rte_pktmbuf_alloc(mp);
@@ -246,7 +251,7 @@ generate_packet_burst(struct rte_mempool *mp, struct rte_mbuf **pkts_burst,
 			if (i != nb_pkt_segs - 1)
 				pkt_seg->data_len = pkt_seg_data_len;
 			else
-				pkt_seg->data_len = pkt_seg_data_len + pkt_len % nb_pkt_segs;
+				pkt_seg->data_len = last_seg_data_len;
 		}
 		pkt_seg->next = NULL; /* Last segment of packet. */
 
@@ -300,13 +305,18 @@ generate_packet_burst_proto(struct rte_mempool *mp,
 		struct rte_mbuf **pkts_burst, struct rte_ether_hdr *eth_hdr,
 		uint8_t vlan_enabled, void *ip_hdr,
 		uint8_t ipv4, uint8_t proto, void *proto_hdr,
-		int nb_pkt_per_burst, uint8_t pkt_len, uint8_t nb_pkt_segs)
+		int nb_pkt_per_burst, uint16_t pkt_len, uint8_t nb_pkt_segs)
 {
-	const uint8_t pkt_seg_data_len = pkt_len / nb_pkt_segs;
+	int i, nb_pkt = 0;
+	size_t eth_hdr_size;
 	struct rte_mbuf *pkt_seg;
 	struct rte_mbuf *pkt;
-	size_t eth_hdr_size;
-	int i, nb_pkt = 0;
+	uint16_t pkt_seg_data_len;
+	uint16_t last_seg_data_len;
+
+	/* Calculate per-segment data length */
+	pkt_seg_data_len = pkt_len / nb_pkt_segs;
+	last_seg_data_len = pkt_seg_data_len + (pkt_len % nb_pkt_segs);
 
 	for (nb_pkt = 0; nb_pkt < nb_pkt_per_burst; nb_pkt++) {
 		pkt = rte_pktmbuf_alloc(mp);
@@ -330,7 +340,7 @@ generate_packet_burst_proto(struct rte_mempool *mp,
 			if (i != nb_pkt_segs - 1)
 				pkt_seg->data_len = pkt_seg_data_len;
 			else
-				pkt_seg->data_len = pkt_seg_data_len + pkt_len % nb_pkt_segs;
+				pkt_seg->data_len = last_seg_data_len;
 		}
 		pkt_seg->next = NULL; /* Last segment of packet. */
 
diff --git a/app/test/packet_burst_generator.h b/app/test/packet_burst_generator.h
index cce41bcd0f..600addee3a 100644
--- a/app/test/packet_burst_generator.h
+++ b/app/test/packet_burst_generator.h
@@ -62,14 +62,14 @@ int
 generate_packet_burst(struct rte_mempool *mp, struct rte_mbuf **pkts_burst,
 		struct rte_ether_hdr *eth_hdr, uint8_t vlan_enabled,
 		void *ip_hdr, uint8_t ipv4, struct rte_udp_hdr *udp_hdr,
-		int nb_pkt_per_burst, uint8_t pkt_len, uint8_t nb_pkt_segs);
+		int nb_pkt_per_burst, uint16_t pkt_len, uint8_t nb_pkt_segs);
 
 int
 generate_packet_burst_proto(struct rte_mempool *mp,
 		struct rte_mbuf **pkts_burst, struct rte_ether_hdr *eth_hdr,
 		uint8_t vlan_enabled, void *ip_hdr,
 		uint8_t ipv4, uint8_t proto, void *proto_hdr,
-		int nb_pkt_per_burst, uint8_t pkt_len, uint8_t nb_pkt_segs);
+		int nb_pkt_per_burst, uint16_t pkt_len, uint8_t nb_pkt_segs);
 
 #ifdef __cplusplus
 }
-- 
2.51.0

