Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDF0F9D0E2
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 16:11:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE99A40A73;
	Tue, 14 Apr 2026 18:10:30 +0200 (CEST)
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com
 [209.85.161.51]) by mails.dpdk.org (Postfix) with ESMTP id BAE7240693
 for <dev@dpdk.org>; Tue, 14 Apr 2026 18:10:27 +0200 (CEST)
Received: by mail-oo1-f51.google.com with SMTP id
 006d021491bc7-68244d317e5so3543815eaf.0
 for <dev@dpdk.org>; Tue, 14 Apr 2026 09:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776183027;
 x=1776787827; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+p0BlIi5nyoRG41T/6sRoBq1TfDZiXU1XmUIeFK5dPw=;
 b=URm2EvviWH32plwSk63iVpoNIOs+CRVnkl7zR0Qg8afq7yRFhuJOzokVyIKheBloRo
 hryAY5J8Yq1gOxkrXUSVFFBVnrqD6NG2Pa0kOh1oBaOC6PHq0chAVLfhDEwaaoXw7WCp
 +nOIP1owCwH6N/K+W8nVi4ncF7Z6TnNLuwQK7FXSnKp1rM6uIYHddpWGprwoyeTpTHRj
 ZZL2dh3aP+Jh8auZqzhZmhD76WsSRCakWBeICH8LDrhL8FNQcYuhjyJsRICmzCLRYCp9
 yhTjDxkpNMCtIxNMbDMIPTXVFZ/0gt4Z5CfYt3tw5sOGZ78J5/y+YnI1iWTGmByvW/P0
 RLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776183027; x=1776787827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+p0BlIi5nyoRG41T/6sRoBq1TfDZiXU1XmUIeFK5dPw=;
 b=I9rtmTdUBDRYGBmzNDxuletEGz9jT2WE29rjdbEYADPGvu/ghoOFZKm6QvV1emRCvN
 zmWrhgdh3F+SS9Vf+cgCl6/4eby0hExTigxi6xMk+NSlbSXEVdKVgsYn1BsjPepDb004
 u8h9TgAVEYY/j03sVvb8IDIpvJvpVUwQ3KzppgoOARgiK3ZtkVdkf2WeQZpU4aoGxCEM
 Csf1iGDER1eYsG7tBqB560lJomWBAPQ36eXd3VKGjQiSxj1aXaq4X2VJCOYs8siDdaKM
 esDKyJfy25+OqOBjftgQptvXmH4IEw5xVadEHnGTRKvYG7uoyMJpeJIUYqlC9ttLOwXp
 h1bg==
X-Gm-Message-State: AOJu0YxnxITzSK/nwhGWrS9A6RJZQsmjGC2zypSlAOnrIXZd1ERIM5rV
 qucapjP7SbKGGQcqcbBuW5MoWtyp9OwtUuuHoprwzSzTyBe9L+a+P+RLG3+1OBsgXCW/aOiQYkb
 tIzU5
X-Gm-Gg: AeBDievI9qfHyHLM6+7h5cIeuov/saA2St7LrYOIMgeeMadzzMg3/udAmVQ0m8PIVrt
 18PitkuI2grFDoPWB2YpMJ0mCIHB4esZGLllbtZBNQj0DF6ERPs2603bLzT6wlgY+ovF7I6gPR0
 dv6lowfOe5nsUVgzNShe6ZDYs7sEbzCZwV7QeJp/L4jlD3N/48ZUs21Rkwz4ub4DXUR70t8HQNT
 JCffkYFnbqn45dq3wRRfpj7NMSu/1beu2hGqLLHApqxvcDCm2vWRAsxJU61syHxqo5Zs5e1obtx
 OXSVcyemBgQGyNdfbUDJoApglrB5+zfZua39q0E8mlBItHG9xlNVXUqq1Ayn8joVY/jwCiq4hwK
 84MTrC/QU4A4/66tyd8acOLL/fI61hVmQj/SC9NN25nON3TYqajQO2bncSFUfsuYRCz74ahrzLO
 31lwDaVBAJuaugnNKcQf0Ebk7Jh/b+KTP79w1VGQlwxIY=
X-Received: by 2002:a05:6820:160c:b0:682:644b:ba03 with SMTP id
 006d021491bc7-68be5c594e1mr9455607eaf.16.1776183026897; 
 Tue, 14 Apr 2026 09:10:26 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423dd396960sm11809554fac.2.2026.04.14.09.10.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 09:10:26 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v22 11/24] net/pcap: add datapath debug logging
Date: Tue, 14 Apr 2026 09:08:02 -0700
Message-ID: <20260414161011.756101-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414161011.756101-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260414161011.756101-1-stephen@networkplumber.org>
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

