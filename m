Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B917FCC9AE
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 02:50:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01FA240B8F;
	Tue, 10 Mar 2026 03:49:44 +0100 (CET)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com
 [209.85.210.42]) by mails.dpdk.org (Postfix) with ESMTP id 2C01640A73
 for <dev@dpdk.org>; Tue, 10 Mar 2026 03:49:40 +0100 (CET)
Received: by mail-ot1-f42.google.com with SMTP id
 46e09a7af769-7d743ba241aso1218834a34.1
 for <dev@dpdk.org>; Mon, 09 Mar 2026 19:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773110979;
 x=1773715779; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NXv3eHzpbUBafU1jKtduLLA1C3zZxbHagI5ywhIiTAg=;
 b=w5uhIqfUYKN59tA/lfP3+a2Dgln5aoPDmUYJ5rGaulW3umR15D4r77/y63rJHchzFc
 +iFuM085I+ChfVy1qSh1zFG7ol5ilr1lwJmFirr7p2lvY7F+efSyXR3UUrBGVeuzSQir
 FgzOm5KEp6TwExtBYcAcKWBoxb7bAQfLGZgZgWHlqXGkwi+HwcrPLjxSFuS+vhkLBwTB
 U26nsk3beTIqRFSaUvMBRFjGmbhfVptVWGg6PYmMGl0jUcKpAubwThLZN1dWPkf0+46j
 PnXjTLTcBVnqoQoksdFQ/rhtPtUNmA+Wwa9K/EY8ETFQtBS5fpPFemxm1iW3Yhgq4/uy
 1GlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773110979; x=1773715779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NXv3eHzpbUBafU1jKtduLLA1C3zZxbHagI5ywhIiTAg=;
 b=fQzZ5icAJc/ZorveNNBpSvC2IVrmzvlDeO7dmEwkyuS1rhwsVv96YZrmiDRaxryLWt
 04wOxC9TASxmD7CzkOvoTCjHAgMujLqtNS2LNfP4lUohJ5d1GZQBU48CtFcxOlNQ5+CE
 OmqOVVSxzB2CV9qzWa4LIJbwvkSM+wyvw18Cdj3naH7m6nOkX125Om7FAWyKF66718tC
 jUn40FzQOVQgiUSPaK8gdoLnn/c3+xjDd509hEdEj3Pf/zm/n5IZi6bTuzvQAYEN2a9k
 3Cbllu96zdBvGsWNkxE93ZGWhk8mJZ0NmSCiJMm2e+YvV+J2gycA6V2Jm7pPtlWGC2aR
 h8Ag==
X-Gm-Message-State: AOJu0YzqWJo8u+dutdId7Qlu9KXmUD/C3uuxFXSNEA8ZtXvzWsev+3LN
 ew6MuDiOPvbumeov1KRnpTfsukjEH0oJFyL/10oW3FsaRwh+QoZuWq7ojQ7YsnUO7F9stM/NllK
 CTKlsL+c=
X-Gm-Gg: ATEYQzw25dzaWSat5z/wpCKyFWHxHSZCVhnBJMjCJYsULOqwiVa4Es4QQq4aGMFBFMU
 /vuNhhQd2QH0d6lkCbevMJBDG3Bef+CMkD6xi8pP4fwb9D33gXeyPx8l3zpzkinfyiyx+IKc/OL
 /VTYgtjIa0+A3N7XYnGTMnYBFOh8dKMm6K1Mst7mhwOsiGFqvp0eJ8PyJn/QasLwhRCnUKE9btX
 G5x2L6KCZSFw/3FCZtPOIfLIMLTFHbH+LqsFV4h8xHDuQ5zfNr1OkjrYovOzIk2i2lSUC8NDI0f
 bQaXQxzRyix6eFCUr6Ur1cWDbhoYiQvrFtb5BaWtibQBTGu05mZL451rCxs3nwpPfq/ZNrsQOLH
 cvFqg5NdgMIXAKpi7fDIuaCZeNVEFf8I8h1BfbbnJ5dPKKx6MD2bd4XvCcZNTtEDGf+tJUD01y4
 O3fbAD4jjXBOWywhcIuYrI72NkAGAHzAfa
X-Received: by 2002:a05:6830:81c8:b0:7d7:51af:4aa1 with SMTP id
 46e09a7af769-7d751af5464mr3267411a34.18.1773110979468; 
 Mon, 09 Mar 2026 19:49:39 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d728d1238csm7808572a34.15.2026.03.09.19.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 19:49:38 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v19 10/25] net/pcap: add datapath debug logging
Date: Mon,  9 Mar 2026 19:47:45 -0700
Message-ID: <20260310024925.476543-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310024925.476543-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310024925.476543-1-stephen@networkplumber.org>
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
 drivers/net/pcap/pcap_ethdev.c |  2 +-
 drivers/net/pcap/pcap_osdep.h  | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 47a050df11..258cffb813 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -499,7 +499,7 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		const uint8_t *data;
 
 		if (unlikely(!rte_pktmbuf_is_contiguous(mbuf) && len > RTE_ETH_PCAP_SNAPSHOT_LEN)) {
-			PMD_LOG(ERR,
+			PMD_TX_LOG(ERR,
 				"Dropping multi segment PCAP packet. Size (%u) > max size (%u).",
 				len, RTE_ETH_PCAP_SNAPSHOT_LEN);
 			tx_queue->tx_stat.err_pkts++;
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

