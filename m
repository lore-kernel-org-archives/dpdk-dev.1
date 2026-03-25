Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248E6103A9A0
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 02:41:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 14A5F40E42;
	Wed, 25 Mar 2026 03:40:38 +0100 (CET)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171]) by mails.dpdk.org (Postfix) with ESMTP id A99D540E1B
 for <dev@dpdk.org>; Wed, 25 Mar 2026 03:40:35 +0100 (CET)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-2bd9a485bd6so3577311eec.1
 for <dev@dpdk.org>; Tue, 24 Mar 2026 19:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774406435;
 x=1775011235; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+p0BlIi5nyoRG41T/6sRoBq1TfDZiXU1XmUIeFK5dPw=;
 b=IPfGE8olsFXWFmS7yBqTt5vCvfxY5IcM4u4UZEMAngdBvptqlQQKcHODrqe70AyvBe
 M8nlp16rGGbRy+dUOG/638VljZkOwuy5wWFJHr034CvrcD6AWVEfb15YIUcUB7ddoEsR
 EsQHp6jyPRNhl+urGpO8GoWfxp+LIvN1nS1YViPU20Fy9U8mghmZ3B7UW3dxSMeLzbbF
 Q8mr+ZalBIWfve4dxY5U356JTTOFbMOF0j/lqbagZW3apEyn2Tzspzy+lMzhADHm4F8C
 Yzi1viFedcjbapkN4B7FJ3ETiwqVN1YmiAsKcXqHYDoAXGXotdJR9xI5vsOgNZGiYeMj
 QXeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774406435; x=1775011235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+p0BlIi5nyoRG41T/6sRoBq1TfDZiXU1XmUIeFK5dPw=;
 b=tNs0L6xBpFMdxOip5WEnZLZE1iIOygICaomrVgOh1uTyZj96fy8+7nb5O36HJDtI0g
 hJsvo1EvlPK2MsE/fIQsAu0n9Kr3ezdy5w9dY4aCNnm0HccISyNHCEoJpUlF9424bVoX
 4HizO7jZAtFzpWN6QDBCHWYP4TJ7j1DTQoslCZGI+mV+mnAPa6+qBQwNKMSBZccUsL6k
 nNMrlCnacVVZX6VLnOBC3ov71SQI17jgAtlYfRJyDwvMh+YTLqoWLPE703UnReiuIZZv
 13uiXnACG4i2W/S/uP+NLxdT6ckSVsWavbOoMAM4OfY3LN34f8sKVFDu2GNUDCJuL7t1
 SRnQ==
X-Gm-Message-State: AOJu0YyX+FHqJpt5usODu5kV4b/ms6yF57Ew2qR1gVA75WtRbObr3Ygy
 +60KwQa52iNwotj/I/lDycHLX/N9mG8maqDLKXvYUocemyf7LW94V11+pH7Dq0Hyg9KdBxGx45u
 wPoSV
X-Gm-Gg: ATEYQzwro9LVHxkWyhfQOrEzyi5pe1pckmxb4RiizaPqyWo95ClMqWQHpDJ8HAINZCC
 sDHvedoQjeSl3WcY9tlyVuvGuAGY3FrVbiGVOPADy1RC7oz5X929Mc+wHrIVUSJkpgugAhb85lA
 0mNwrDTYWgAl0usLbYb4tUCkgTLoMAelDCw4Tz0BMMcCBjGC7fSi/0LZ7vn/hJtdTVrLFAQo35V
 rVqiU2sgWUimeZQIJ0WmSTQVyFaf3ru4ISaEcHxSJfFRteodd/kzN+nH8PKbnhv8mxChv3Z2neJ
 HdKyHtwnRWD41kyeXX6TPtKCu3QPVitS2rVsj1rTRSJJ2exZQki9aUpe+QJjaP0nRP/1Y273dio
 XBzAAOWigVq2XOBS6LAHft2QHa/Tmw6giDARUG5F7C6jX10/9zhT2fBFJjt1ayMxrolyLF5gMVP
 WIc6Xc3su/DCd5KpB/RbG8y4DTmpOGfOB9/7zTFB77DyY=
X-Received: by 2002:a05:7300:a584:b0:2b7:1e86:3604 with SMTP id
 5a478bee46e88-2c15d2b7001mr1037009eec.6.1774406432337; 
 Tue, 24 Mar 2026 19:40:32 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b29b447sm17209452eec.16.2026.03.24.19.40.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 19:40:32 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v21 11/25] net/pcap: add datapath debug logging
Date: Tue, 24 Mar 2026 19:37:42 -0700
Message-ID: <20260325024018.1275209-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325024018.1275209-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260325024018.1275209-1-stephen@networkplumber.org>
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
index 8df66ebb96..cfdbf3eace 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -500,7 +500,7 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
 		if (unlikely(!rte_pktmbuf_is_contiguous(mbuf) &&
 				len > RTE_ETH_PCAP_SNAPSHOT_LEN)) {
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
2.53.0

