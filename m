Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E58FD4F05
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 16:15:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 616DA40E50;
	Tue, 10 Mar 2026 17:14:15 +0100 (CET)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com
 [209.85.210.53]) by mails.dpdk.org (Postfix) with ESMTP id 58573402BA
 for <dev@dpdk.org>; Tue, 10 Mar 2026 17:14:12 +0100 (CET)
Received: by mail-ot1-f53.google.com with SMTP id
 46e09a7af769-7d738fe814cso3173909a34.3
 for <dev@dpdk.org>; Tue, 10 Mar 2026 09:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773159251;
 x=1773764051; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NXv3eHzpbUBafU1jKtduLLA1C3zZxbHagI5ywhIiTAg=;
 b=2/hAulWlY78rLfTIoO6yzfg+fkRx5EKN/7IMrKhd/pCmqz3Fwv7GQtm+SyEfuAioLe
 RKQMQfhzbSgftwOIaWjtLA70jrkxioTyEkUAjVjWsoD7gn/joJsPsRi2LkyPQgaYH9d9
 DHzyV6sm7kfEaxo/tqTmaFj9vYJfdl0G5G8RUIo1X1qr9SRT3NkOV/3zyfhKQuYEFFqx
 XANbVL3vQ9qKAIzmiOBImU0SKoE1iP5xniv4AhwZmYCf3bXLJBWAb6hHsb5HtPLynoWF
 0CgQjXSU+VmwDST2QJVGu3PYMYHAlv5D+4pPWLMldh68jkV33X0RfdtI24nShPOIuVKI
 RsZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773159251; x=1773764051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NXv3eHzpbUBafU1jKtduLLA1C3zZxbHagI5ywhIiTAg=;
 b=GOie6gFvo6N2/ZZiNGn6ppj63iCNiX8f6D9VPTq4ziyjtOZgL/YkSEjQlTuRUAFspj
 e0OZw4mMN+t6G8CID+FEfzayAJkZ8Y70Jv3deLMTxOvHURhrqKsocL02EzehExu2Qa2p
 mUa1mAfcAuI/9hfQusA+uByIPqQz8HZC7vdmRZWTO7q58xxM6QHAOjWNhlGgi6Dwkm7U
 Y22lPSRHgoDSR20HGS1GeDZXyUCjdWiiiIpLyw5aIYwJxiRjWmdq6mjOxg5vLofsyzt0
 ztv3gfI4ANtSaQQfGe8NBPyDO6zjhADC9MCf9WXmtpUETN9UE77lw2VKYOIip3qDvUTQ
 ItlA==
X-Gm-Message-State: AOJu0YxEyPcp06Gd9A4GXQsYS4ptfi60mLmDuQrbQuexsDJp4beUaptD
 ca/dXck082sygMJ/JcvHWbSEPfopefIQKGE0z4ZQABXa07ho6FHpGCZDUEO/cDH7DiKP2WKkRl+
 WJl73Uv0=
X-Gm-Gg: ATEYQzy3EuHT8ATlikRdp0+TYzHMyWJOdiw8zln/6f85Pd99EUeY0+M3hrQtN9Vxwvt
 hRnuLYCc5W641+vnmeJlMiGqDcaDMgWRylACTFGXhXzjWgJ8FbiPue8v9lpD59Exsz9cgaRjCWt
 6ObnQ613hw0V2EpN0OSFKXiMKOmOwKpZR9JLHDqlHUL4OYn6RjasAu/rXS6edikN6uUGkHXZwW5
 bzAWQFgT731wEuUF25w+tPzNBIvChRAK1oNwKqIOwV8JLQXlZEzhhnw/XxjoxqoaQCJLRLWk3Wk
 9AqQzitmHmiYJE6CHHJXWa4TSQOOrGv1GrvuJHNDPg/sP5TZL/EzBkzU2aVqEBzr6FKVHchnjcE
 i9WzD1x3x7Q71gUhKK7anW3mZEGpwgJrFxccPDNBEsp0EArFJgXXiHHhbyLTT8FORm8l9ozbZDg
 jgtqWPf8JYl4WoThmLi+0J+Xs1QcEiuBop
X-Received: by 2002:a05:6830:4989:b0:7d7:52a3:a5ee with SMTP id
 46e09a7af769-7d752a3c3admr5173696a34.34.1773159251614; 
 Tue, 10 Mar 2026 09:14:11 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d738e3f421sm7304004a34.25.2026.03.10.09.14.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 09:14:11 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v20 10/25] net/pcap: add datapath debug logging
Date: Tue, 10 Mar 2026 09:09:48 -0700
Message-ID: <20260310161356.194553-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310161356.194553-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
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

