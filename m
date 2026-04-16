Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2033F8D765
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 18:52:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24FC040B8C;
	Thu, 16 Apr 2026 20:52:04 +0200 (CEST)
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by mails.dpdk.org (Postfix) with ESMTP id 77BBB40A82
 for <dev@dpdk.org>; Thu, 16 Apr 2026 20:51:59 +0200 (CEST)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-12c080efc1eso836855c88.0
 for <dev@dpdk.org>; Thu, 16 Apr 2026 11:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776365518;
 x=1776970318; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+p0BlIi5nyoRG41T/6sRoBq1TfDZiXU1XmUIeFK5dPw=;
 b=l6vecwwtfLN8hIPRz371a8OWF79E27sCZ0KlRyG3rNFh+cAbVQ5l8spY3XyLZW9UIG
 xW1xl1wDOkMpriHhZMmRUtktJqTn+BI8lqRofUSj7CQ0NJJtP3iqThSN8fzIMOhVzIiF
 bxmXdG1kdsX/0+Z98u8Oh7/sQrH4cHaTVELazOoRACmRfGm96Kj+bknvE9QYrDzeyIkA
 Py+KrQjAWr11x0rmBBz2wzfoxbp1jh0roVinHSjBhNB785KYLU/JXzcAyEe4cg8f8bWl
 j1CeAoJMFILpi6jB8COWGOXkQu86FPeNbBsLS5UrCluGLsJeEdH0422IamlfdOyFNorN
 +fyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776365518; x=1776970318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+p0BlIi5nyoRG41T/6sRoBq1TfDZiXU1XmUIeFK5dPw=;
 b=iwNqxwEXAA/thSq4jq/+VYMLVGK/arGpQvI35ri11NAg+rtbfsS2qV0ERfdy6Xq+UN
 dWRJ7fIUo5KshhWUUQ2eMEYKsTjNvVaU4FfpSgCwPxEPbtWkLm3vVLnUYtKUEskjxq3Y
 F51FRSCgqKYhh+vTRCPQl6NnTQ3f3+MxcUWAPasGiZLBXBAyGuSLjIgrzxO2pp3y8pSE
 ACSMFoF6KeR/UFicqvonQeLgtSrYaFCqldGLdNXcnzh5s608l7R5L0vNqot7DEfdhNtd
 5ALZBJft8mR68WWztp1ASyrP17zxsvSdcIcpwEG5JPvoa4KKka8b5zVhU+p7CAdvxTHZ
 thlQ==
X-Gm-Message-State: AOJu0YzuuZTfYDxwN7VaAngQs4e9vvhWoEHn2cE7FAqiNwWsTnritcFe
 d0hg4dupE/HMDH+erMWW8FWfBSgLjOZ1e/vGpzgRsId+F82gUIYGkqHkKXEcoV4wyJQfp7c4Ej/
 I14gg
X-Gm-Gg: AeBDievSrCAvu1yOT89XuxdRZJr+hIJR9c8s41UEy/NsK1ucvIK2TzHKzr1JqVklD3Z
 5CRKpwyoz/wRcnycoViZCiqiTDTyIXz8t90sQb14YCZCNbzegNy1bw3PPKf9FxvVZuhWBu+VHIU
 42DCLIlE4nQB+PQT9gDq3UGTPAXP7qgghvVWeEKSE3XC6yD138BRV8syYQUqToXMSrU7dagj3nS
 vaiCFMd494QgBhuFHVYlmsOLiR+c4CFi7vWqWzSQdjWadkTG8svgSTMxd0t5s3v0jjBSNbIiZYD
 W6g7FNtBoZN3oKbynkMGDlkBWKjUDbfRqJ12LTw0m0NFyyUzQlR+pReoZY+gzNGFJUYi/ZlDquE
 x+eO/fEKvLUJ4uaMtvWMji19GwSftG2e45/PnY16WlJTAypQ10YUrxJIJkBL/wDLoswyAkV8wQV
 gTjFfUZ4yrz+9GzW2BqTS8Tf+M3ikLc2Mi9cFPOV0d+m4=
X-Received: by 2002:a05:7300:b905:b0:2c9:ee15:a0ee with SMTP id
 5a478bee46e88-2e2e3e677c4mr194683eec.12.1776365518463; 
 Thu, 16 Apr 2026 11:51:58 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8f6615d5sm10602510eec.24.2026.04.16.11.51.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 11:51:58 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v24 11/24] net/pcap: add datapath debug logging
Date: Thu, 16 Apr 2026 11:48:28 -0700
Message-ID: <20260416185144.1359260-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416185144.1359260-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260416185144.1359260-1-stephen@networkplumber.org>
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

