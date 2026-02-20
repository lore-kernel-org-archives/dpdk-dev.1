Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CDCC54EFC
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 05:49:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55D7340689;
	Fri, 20 Feb 2026 06:48:53 +0100 (CET)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52]) by mails.dpdk.org (Postfix) with ESMTP id 9DD6140685
 for <dev@dpdk.org>; Fri, 20 Feb 2026 06:48:49 +0100 (CET)
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-896fa834290so19587386d6.1
 for <dev@dpdk.org>; Thu, 19 Feb 2026 21:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771566529;
 x=1772171329; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FswscZpUERaIG3uf2kmmB+PMjrQoK9kFK54jzOCG1eU=;
 b=PMTVD/P/oSmuYuZV082BMfVl1ekiKamguI2PY0Of1jvpOoIy46BToXWnivjIbax94V
 tWcmZXhwwcOpax4bbHqwHFSo5UTccaxlDa1Cqt07fPI6IJrZgldOawJs0DWtsMlfpU2J
 kdYL/Ow5Wr2xLeH18Ol9XEQBYAufF51xm2n5b2GLeRk7A+PbBzEwcNGZG3UuvrsXvnWc
 noPrbTBWMghk76deQT8oeuNtxO6XcUN/gcRuWyXF1fh24bPcHPL8flh7y6DLAn+JzSRH
 BsYrNhqXnJ/p8Hd4ef0SNo0U+6BwfpxHLkBMcZatTAuyL37SU/B27TTr9E22DTUs3GZC
 Ajwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771566529; x=1772171329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FswscZpUERaIG3uf2kmmB+PMjrQoK9kFK54jzOCG1eU=;
 b=DBidi5YZiAQ+y0Wxfu93G+Fthicd2semGv+nQRP26FFWMzDX1unK4ZQcO/4TXSFyfG
 dkGr2iYjc5TmlBkqnuilqnysRq5eCLVayZgHGLo2X662skXdhA6RxVJZ8YkEUSZGz/nt
 9lyMpUIICDaw3J+O5cQac8GeZ+V/G0IF1OXGt0vj1ah9NXeJTWCJ6/ZJVWmeQcPYbLiL
 s6OOOBRYuYkl7aP59hR8pd3rj2T/ozh4wnnz43RSJqTfL+3L4mqO5jMF6Q1l1Ck13Mvf
 RFKcsm8oap+GETVrBS/ULDDfErhnYXTnq+1IdImEGDlHfXnmg8nNZ7ZQN/eIEIythlVq
 Zvhg==
X-Gm-Message-State: AOJu0YzFm56VPAGr02XK658W0lQZJ9Y1SDl4ON1in6T9kvGNd9na9D4z
 kEqtof/6MaAmXI5pM0thvcSdWnWuQ6IjlM2Acphc7YQXe6FNxQJOz9kSWwkZKwLd54DNkkgjg7S
 8xYZP
X-Gm-Gg: AZuq6aKNTuugYGW0uY5tpd11WdSVYkE89SyvECl62uTk3fChpAfcgDhIR3KujDQKh9A
 TF1TYG3m7AAef2m4IXLRSfHnr40Rg2U1Vl3V06A9alYM8J2ghb0lCPnYHqER1iTnKjeR6FBEb4b
 bY4wObaWvHKYorf7hPEPRL7rkSTxkAVHT0nnSh2VO315+k3QEOsiAtOkOquCibl4rSeneNmMkdb
 lRIhKyTwd7m68QBFxLE8I1m08+o93ipTSvkg3XCvTgCZgycxF2Y205ZF3RPyUtwq9kRVjObsN+T
 W2KU3LQVycHZ8O3a1cv5V3UE9iduvcDBAZ+EzZlA/CNr4hMda19bZj4cv4695Ai8FOfOlldNWz5
 0mhyZpxMLM9rtgG8LYHB6GRU7SNb393RKRrGydQqR1gQnmVQQDBsgEEmWSg/cXjUP511O8EQPAV
 8rMohpw4QhPGNuY6zXqm6uFph7sQ5LN0hJ8I3Zjgq1A+G30y/wd4Oi1fBiKWzA/Q==
X-Received: by 2002:ad4:4432:0:b0:896:fd8f:9cdc with SMTP id
 6a1803df08f44-89971a36ac3mr5172426d6.1.1771566528826; 
 Thu, 19 Feb 2026 21:48:48 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8971cdad6c1sm229078096d6.39.2026.02.19.21.48.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 21:48:48 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v17 10/23] net/pcap: add datapath debug logging
Date: Thu, 19 Feb 2026 21:45:45 -0800
Message-ID: <20260220054834.1632201-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220054834.1632201-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260220054834.1632201-1-stephen@networkplumber.org>
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
index 1ab5b1755c..5b59e9d813 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -419,7 +419,7 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		data = rte_pktmbuf_read(mbuf, 0, caplen, temp_data);
 		if (unlikely(data == NULL)) {
 			/* This only happens if mbuf is bogus pkt_len > data_len */
-			PMD_LOG(ERR, "rte_pktmbuf_read failed");
+			PMD_TX_LOG(ERR, "rte_pktmbuf_read failed");
 			dumper_q->tx_stat.err_pkts++;
 		} else {
 			pcap_dump((u_char *)dumper, &header, data);
@@ -501,7 +501,7 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		const uint8_t *data;
 
 		if (unlikely(!rte_pktmbuf_is_contiguous(mbuf) && len > RTE_ETH_PCAP_SNAPSHOT_LEN)) {
-			PMD_LOG(ERR,
+			PMD_TX_LOG(ERR,
 				"Dropping multi segment PCAP packet. Size (%u) > max size (%u).",
 				len, RTE_ETH_PCAP_SNAPSHOT_LEN);
 			tx_queue->tx_stat.err_pkts++;
@@ -512,7 +512,7 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		data = rte_pktmbuf_read(mbuf, 0, len, temp_data);
 		if (unlikely(data == NULL)) {
 			/* This only happens if mbuf is bogus pkt_len > data_len */
-			PMD_LOG(ERR, "rte_pktmbuf_read failed");
+			PMD_TX_LOG(ERR, "rte_pktmbuf_read failed");
 			tx_queue->tx_stat.err_pkts++;
 		} else {
 			/*
@@ -520,7 +520,7 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
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

