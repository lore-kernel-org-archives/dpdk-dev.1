Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB4EF43830
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Apr 2026 14:49:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E0C340A6B;
	Wed, 15 Apr 2026 16:48:25 +0200 (CEST)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com
 [209.85.167.178])
 by mails.dpdk.org (Postfix) with ESMTP id 0C65140A6F
 for <dev@dpdk.org>; Wed, 15 Apr 2026 16:48:23 +0200 (CEST)
Received: by mail-oi1-f178.google.com with SMTP id
 5614622812f47-46808125c65so2422702b6e.2
 for <dev@dpdk.org>; Wed, 15 Apr 2026 07:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776264502;
 x=1776869302; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+p0BlIi5nyoRG41T/6sRoBq1TfDZiXU1XmUIeFK5dPw=;
 b=T5EJQ2LL812pk4YgxZBeJQi8GzoMCoYfi8SayizhVjiWpxFl1K0JM+tH8n0In3xSFh
 mqFNBh9Zy+/zHy4uQyOtgqP4aLLKKjSz2FJTseKtncnr2FRNI8Wu+OSpDYqIwlFFu3HA
 EZ6fOv/pnuEqn1vuStXt4WLBWkgg9v2Ri5aqLmx345q0Q7OcovOJwBl5t06nb4Pa5qOm
 6+3frYcWqkncq/ZHeXLirUakPGrLikatC6rL37gO6hDAnqo+YR4V/pV5IjDn1weDHS2N
 /NSt5WdKvbVVvoFFkRzt6IbsRLquTu5prryKpiEROYI94Pfu9m/4/BiQuh/NSLVtiOUr
 AXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776264502; x=1776869302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+p0BlIi5nyoRG41T/6sRoBq1TfDZiXU1XmUIeFK5dPw=;
 b=ZFcyvHxfgveWw6FzFke5L8XC54IsxNI2g4ZeEOMPD/vYxhqNAOoiNwSh9UdsJmLDr8
 ohRPxLZteZOvcCq1el6EboyJ7KW3lNB5taUb+E+STkDy/LCUyLAWwbnJ6Aanen0scSnA
 E/Xy/5A+xU3SMUgAGQKWPz0APhRcpWrOdoPsCB87qYO9m8BIrOm94y01wQ+LuEfBFPgq
 EjynBf1IP1ZmKI1WFKBKmj1zGWhWHxdAToKAGpnNK/P4Cp05M+DwnLUAG+mQP7SPLLNt
 Bc8NrDvR8p11M2P/DrTTtdXAG9PJ9Yi3filuxZ4TtpUSkMej2L7klu9jL38Sv8dOqo4B
 ReEA==
X-Gm-Message-State: AOJu0YzjPpjcXnxTlI7Bz26/5zmC6PRabKa7M93IiNTNA902ceA5QTQh
 6xsplXG6zsc8qzOoY35kz5g5ArSQkSdGdHNQ1pLDcUsoulpldDeipANg7zfVubvJWJzM3PI67gM
 6xwdv
X-Gm-Gg: AeBDietQxs3ZcMiuluhEYowE0eE9OZah9ebxi5Ra29IYPf1naXxDGkytVkGtVPaiG0R
 T8udTRX+48llXqNyOE6DZY0RRX+BnBJaC1/YxYgMWjrX1lL/Z+aG2G+4unHmtk31EX9dNTLxJCs
 //5srdKi0K+FakRB7j2g58T2cOQHh6w0tKWvXUKTYtAC/R75yU+FsuUBehtTrEVWa8xhGz71Do1
 Xfh/wZRWuIl+/V7iYz+kGEGN5RbmTvhttp1YwEiCk6RvFAHso6QBXZOkJ821/Rm2K05nPlOgafa
 uPGIu6s+wtLQcLLDVR5KwsPDOjsnbdq/VjeoRFl+em4ZrRy0h/GMj7EuXbfmBXJecNKxnbCRIq8
 lssz0JZlv0g7U5vt0svDVUWWAxZ3aUAo/24Hm+CI5eN0/3Blx2KVGj8I0wjkme54zKeOzhyqyXb
 7hH0E8yU2U6Dov+i9PkaFJX6GcctWD+bmoag7sTpNI7bc=
X-Received: by 2002:a05:6808:4f52:b0:472:f551:767e with SMTP id
 5614622812f47-4789e42cbdbmr11036718b6e.8.1776264502294; 
 Wed, 15 Apr 2026 07:48:22 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4797a53b1fesm945798b6e.16.2026.04.15.07.48.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 07:48:21 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v23 11/24] net/pcap: add datapath debug logging
Date: Wed, 15 Apr 2026 07:46:00 -0700
Message-ID: <20260415144717.226161-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415144717.226161-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260415144717.226161-1-stephen@networkplumber.org>
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

