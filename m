Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DEED277C1
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Jan 2026 17:23:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 975EC40E27;
	Sat, 10 Jan 2026 18:23:46 +0100 (CET)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53]) by mails.dpdk.org (Postfix) with ESMTP id 5FBFF40E19
 for <dev@dpdk.org>; Sat, 10 Jan 2026 18:23:44 +0100 (CET)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-42fb0fc5aa9so2392247f8f.1
 for <dev@dpdk.org>; Sat, 10 Jan 2026 09:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768065824;
 x=1768670624; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=clsSR+u1LNexEtPZAR6K4lNMtgo48D2alenrFeC1/E0=;
 b=kVkTc5aviBWrfAaGwd2ykMsm/TaAhv4NizCIQvGWBn74/anp9m+kjMEP0Pmqkqu1ne
 yeXRr7r/5BeMyGaSrbYeVijiWGf+VXstznzC7A4RnixFE2BMTMqzq8e6IqIdwm6vT57F
 E1ovRUyd3gA9xcUrnWi46igmPtM3T2nIfeQCNlFJ2rI+z43WhS1blV1a6rdNZxmrwmVI
 Ikzq9Mb105aNrfQw1eFrry1hAN610ubzkYDt4Auqhft/9QUYRJ/TbboHNgbIs47x7W4p
 uTjiYNKjXiLOjnUlrNu11jnRpmlT5eZqK9l4peTHKyCuo3JQjFa7hkmfvLgkfRIZ3uZ4
 PS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768065824; x=1768670624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=clsSR+u1LNexEtPZAR6K4lNMtgo48D2alenrFeC1/E0=;
 b=ci0/COhjWFvC+0Xryg72J8QpBNyMmapIW7XgIg/KyObBcalxjCxgDwo0kmojkEG6pX
 MYmfb+vASRzFVufcr7k5gMW7iaW7epkHJMCpAKhxOgVrd7H/Wxeizn8tx3ZOgM2iU/YX
 Y2+MpAsPUm1DBVqXT97exMVrf6qjnE/cVdU3tNoHS5OHRJF9BkbMR7kEV4UmKZOtXBbO
 mZJQxqAXXIlTgprQ7saSacg26onBH9PnIWf0u2R58akrQPW5Q6YWU+dNDGxYK3kE9GQw
 Errp9FoUNTRiubfrKmu7naoZl993yxavTaA4lltt1Zaji034s996zMB9DGXgHxNwSloq
 HbhQ==
X-Gm-Message-State: AOJu0YzsH2BekxV558pENVi2nJVDFjp09F5gVmQEnrBbV6x0TijDRCQn
 9/9gp6xK962ATapSOEp/keBoq8lC/ubQ+Pfo4Te8idsursMXE46WgkOjlgK8Be8LXZca499eGoD
 PnI8I
X-Gm-Gg: AY/fxX4s62qa08/AiwE9CbadSTmw5WRXJ5oeMfWJ/lw3m4sFs3REdv7o8Uzq74NWFgb
 pBp6nklBXKkuMDmupGweQR2753BubIVXP8NERMy7uknPRKRvbmITBegCtuF5t9yLUxHQqzUvixL
 NtcYFExlGDhH9Ibb9VxlYcMWgbc4ZwVL3ANLkeJ0SQA2xzcHERMetDheTBmC9n1eSA6fczBNAEY
 Ws+SpuvCRIhvtOLX3IA5kz31XsnTqq515toI+Y2CZVef9CAmbpk9UignuuT2FoFZadjThEkIlTM
 kBY6QmBXgO7KuSWTCOWivOwuH759kv7c4hNaqCjkq+xClPMsBw/vfS/w3AY6NhJ4an7p+jx0g+D
 w3B8nPnduVvIaUKQH0D56/F57cPmUaIINOlQyFYmtV+WCZo/h+6UazJFit3UjYat2g0XPmOx3/z
 OLX4im4CpczG6Bc/gH6XUpd4LiHBSSbIngqu9sOxKHDDagcIEBDQ==
X-Google-Smtp-Source: AGHT+IGCLp3p8ExqC/NReRUQgi7sc0z0vyOT18NEo+KO1VPKYUJTv+ZurcVJUjMzK3gNRWnzlywyfg==
X-Received: by 2002:a5d:588f:0:b0:431:8f8:7f1a with SMTP id
 ffacd0b85a97d-432c3750285mr14922254f8f.31.1768065823897; 
 Sat, 10 Jan 2026 09:23:43 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e16f4sm29558206f8f.11.2026.01.10.09.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jan 2026 09:23:43 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 2/3] test: generate larger packet bursts
Date: Sat, 10 Jan 2026 09:22:37 -0800
Message-ID: <20260110172336.9859-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260110172336.9859-1-stephen@networkplumber.org>
References: <20260104222523.329760-1-stephen@networkplumber.org>
 <20260110172336.9859-1-stephen@networkplumber.org>
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
 app/test/packet_burst_generator.c | 38 +++++++++++++++++--------------
 app/test/packet_burst_generator.h |  4 ++--
 2 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/app/test/packet_burst_generator.c b/app/test/packet_burst_generator.c
index 4c17737739..548296e33e 100644
--- a/app/test/packet_burst_generator.c
+++ b/app/test/packet_burst_generator.c
@@ -205,24 +205,23 @@ initialize_ipv4_header_proto(struct rte_ipv4_hdr *ip_hdr, uint32_t src_addr,
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
+	uint16_t last_seg_data_len;
+
+	/* Calculate per-segment data length */
+	pkt_seg_data_len = pkt_len / nb_pkt_segs;
+	last_seg_data_len = pkt_seg_data_len + (pkt_len % nb_pkt_segs);
 
 	for (nb_pkt = 0; nb_pkt < nb_pkt_per_burst; nb_pkt++) {
 		pkt = rte_pktmbuf_alloc(mp);
@@ -243,10 +242,10 @@ generate_packet_burst(struct rte_mempool *mp, struct rte_mbuf **pkts_burst,
 				goto nomore_mbuf;
 			}
 			pkt_seg = pkt_seg->next;
-			if (i != nb_pkt_segs - 1)
+			if (i != (int)(nb_pkt_segs - 1))
 				pkt_seg->data_len = pkt_seg_data_len;
 			else
-				pkt_seg->data_len = pkt_seg_data_len + pkt_len % nb_pkt_segs;
+				pkt_seg->data_len = last_seg_data_len;
 		}
 		pkt_seg->next = NULL; /* Last segment of packet. */
 
@@ -300,13 +299,18 @@ generate_packet_burst_proto(struct rte_mempool *mp,
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
+	uint16_t last_seg_data_len;
+
+	/* Calculate per-segment data length */
+	pkt_seg_data_len = pkt_len / nb_pkt_segs;
+	last_seg_data_len = pkt_seg_data_len + (pkt_len % nb_pkt_segs);
 
 	for (nb_pkt = 0; nb_pkt < nb_pkt_per_burst; nb_pkt++) {
 		pkt = rte_pktmbuf_alloc(mp);
@@ -330,7 +334,7 @@ generate_packet_burst_proto(struct rte_mempool *mp,
 			if (i != nb_pkt_segs - 1)
 				pkt_seg->data_len = pkt_seg_data_len;
 			else
-				pkt_seg->data_len = pkt_seg_data_len + pkt_len % nb_pkt_segs;
+				pkt_seg->data_len = last_seg_data_len;
 		}
 		pkt_seg->next = NULL; /* Last segment of packet. */
 
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

