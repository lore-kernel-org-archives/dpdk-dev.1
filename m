Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14847FD0049
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Mar 2026 02:08:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4019D40E36;
	Sun,  1 Mar 2026 03:07:49 +0100 (CET)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by mails.dpdk.org (Postfix) with ESMTP id 4997B40E1D
 for <dev@dpdk.org>; Sun,  1 Mar 2026 03:07:46 +0100 (CET)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-8cb513e860cso353768185a.2
 for <dev@dpdk.org>; Sat, 28 Feb 2026 18:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772330865;
 x=1772935665; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6YX0DxmhvHWoazMg8+ubjBHG4y2LSKfO/7kCcD6gyeQ=;
 b=IK1GkO4jjy6elkPZHM+PHLonJ/SuGFeoWMlKpfJTHWZt0AF4D9QnDhUOeDr2FrQgI1
 DODpN8S/e5bq0ouSbMk7ltxWCvYLmrTrB7sbeXYLsbAhrs0HX0rG5Ik6zwJn6n0psjd3
 jiQR9b7ez3ZwUfyOVKsTXwBWpnxZOtE8RqvphrRHNrJ39mcmXGmC9nw8Ce9invBYLlhV
 1nEsMzSeFcIBDUZu9sR0vMQVaEuZ8By3U1xrGWUDU5Ze0xfFukXycGevlgBtff7dHsN/
 aSGrlzZzm56h3Fl+CPX3pjBSWeQXz2aUc0GfFDh+ABrFpPhJojy4u+C1ZfyJeKdh570P
 6Bvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772330865; x=1772935665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6YX0DxmhvHWoazMg8+ubjBHG4y2LSKfO/7kCcD6gyeQ=;
 b=EACyInfWo9pB9+Uh/U6T13j/cemJh73G70nDiNWXM5AJLqTUTkkOmyewuyn/M5kfJ1
 0S66gzGGZYQFzuI2zHP7qYPHByO0pZBeoSq6iZEiiAPebEpisJ9hsVygeADYPralOyVY
 nhQl0+Dy6esfFfn3lucyoV58FEgfw+zzfVJZnhmIpR7d2lRd9ps2rYIE+lkJoiNIGrKq
 QYUQqfaJj/Swjea9dO9jtTL/+XjDjERdkencNkz2F/UZpxu/Q/eCU/iMed1LO18TeNrg
 sllnEBloSSQI2D/VD0YZQAZLqd7I3LcYOcoK28H+M5B85D5LJ3tjqV2hkJBKTxpXikCm
 y26A==
X-Gm-Message-State: AOJu0YxcKgKMqoEkkDXf0Z+0I/tOA0E87Cwjy5mLmLpSuJ3acZ6CwXSQ
 0DzdffHGcBuH6ttPTybHNwIXCt1gWLZyyc6a6k38O0DRgt0QJMBpdSTEyYEr5yKPJMxsv77JB73
 LjUUF
X-Gm-Gg: ATEYQzz4X2mum+qqxE3Q5DrJ0m6A1VaLHqpMEXaaVEbbfk+WQfWtkHHblCxinJ3SaSo
 wpLm0kkkqNo68Pt04+U25VNHnn71soI4HQEPDf2q2mnyI4/LR+zW3K+1JwXZ/ARZ2uU9qi4U1gq
 itz53UnoylKR1zvGjHK6W9EqL2dezbTjT8ck+z3CTZdSjspLsk9Tz63DgLGJQ8XbpQNaRYst/5o
 rSf0sdTtbEIsnwp5vMhSN2KdyksLmpUZ0zEoNZCOGdPeO/V6KlZdV6FBbNydRBk+A73i4zujpSM
 Yvl9uQm7bImw0KMdcQ9gZgwxC8ek8Uxkbi102t+bmtcXlkJ+KB5Z96XWlGTYR78idvFMPEFhgko
 UW3jzEF4860bLPMBTOx7bY7Lu4J1OaRtC/IN6zWbKCGdcoRQISn8G4kfh3BpCtxEUdJL9HcKOG5
 tJuIG3jyDpFgVk7ZaLevz59a1xRuxSuRMyKlrxLgLEAU9X9MtZ2jK2Ndp4HClCKw==
X-Received: by 2002:a05:620a:280c:b0:8c6:edcc:3f80 with SMTP id
 af79cd13be357-8cbc8d83713mr965744485a.13.1772330865490; 
 Sat, 28 Feb 2026 18:07:45 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf736bffsm802292985a.50.2026.02.28.18.07.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 18:07:45 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v18 10/23] net/pcap: add datapath debug logging
Date: Sat, 28 Feb 2026 18:05:43 -0800
Message-ID: <20260301020726.852401-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260301020726.852401-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260301020726.852401-1-stephen@networkplumber.org>
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

Add datapath debug logging macros (PMD_RX_LOG, PMD_TX_LOG) gated
on RTE_ETHDEV_DEBUG_RX/TX. Use PMD_TX_LOG in transmit error paths
to aid debugging without impacting normal datapath performance.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c |  8 ++++----
 drivers/net/pcap/pcap_osdep.h  | 14 ++++++++++++++
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 14014a9e4b..4ae08d3b3c 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -420,7 +420,7 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		data = rte_pktmbuf_read(mbuf, 0, caplen, temp_data);
 		if (unlikely(data == NULL)) {
 			/* This only happens if mbuf is bogus pkt_len > data_len */
-			PMD_LOG(ERR, "rte_pktmbuf_read failed");
+			PMD_TX_LOG(ERR, "rte_pktmbuf_read failed");
 			dumper_q->tx_stat.err_pkts++;
 		} else {
 			pcap_dump((u_char *)dumper, &header, data);
@@ -502,7 +502,7 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		const uint8_t *data;
 
 		if (unlikely(!rte_pktmbuf_is_contiguous(mbuf) && len > RTE_ETH_PCAP_SNAPSHOT_LEN)) {
-			PMD_LOG(ERR,
+			PMD_TX_LOG(ERR,
 				"Dropping multi segment PCAP packet. Size (%u) > max size (%u).",
 				len, RTE_ETH_PCAP_SNAPSHOT_LEN);
 			tx_queue->tx_stat.err_pkts++;
@@ -513,7 +513,7 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		data = rte_pktmbuf_read(mbuf, 0, len, temp_data);
 		if (unlikely(data == NULL)) {
 			/* This only happens if mbuf is bogus pkt_len > data_len */
-			PMD_LOG(ERR, "rte_pktmbuf_read failed");
+			PMD_TX_LOG(ERR, "rte_pktmbuf_read failed");
 			tx_queue->tx_stat.err_pkts++;
 		} else {
 			/*
@@ -521,7 +521,7 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			 * Assume it is EBUSY, ENOMEM, or EINTR, something that can be retried.
 			 */
 			if (pcap_sendpacket(pcap, data, len) != 0) {
-				PMD_LOG(ERR, "pcap_sendpacket() failed: %s", pcap_geterr(pcap));
+				PMD_TX_LOG(ERR, "pcap_sendpacket() failed: %s", pcap_geterr(pcap));
 				break;
 			}
 			num_tx++;
diff --git a/drivers/net/pcap/pcap_osdep.h b/drivers/net/pcap/pcap_osdep.h
index a0e2b5ace9..fe7399ff9f 100644
--- a/drivers/net/pcap/pcap_osdep.h
+++ b/drivers/net/pcap/pcap_osdep.h
@@ -13,6 +13,20 @@
 extern int eth_pcap_logtype;
 #define RTE_LOGTYPE_ETH_PCAP eth_pcap_logtype
 
+#ifdef RTE_ETHDEV_DEBUG_RX
+#define PMD_RX_LOG(level, ...) \
+	RTE_LOG_LINE_PREFIX(level, ETH_PCAP, "%s() rx: ", __func__, __VA_ARGS__)
+#else
+#define PMD_RX_LOG(...) do { } while (0)
+#endif
+
+#ifdef RTE_ETHDEV_DEBUG_TX
+#define PMD_TX_LOG(level, ...) \
+	RTE_LOG_LINE_PREFIX(level, ETH_PCAP, "%s() tx: ", __func__, __VA_ARGS__)
+#else
+#define PMD_TX_LOG(...) do { } while (0)
+#endif
+
 int osdep_iface_index_get(const char *name);
 int osdep_iface_mac_get(const char *name, struct rte_ether_addr *mac);
 
-- 
2.51.0

