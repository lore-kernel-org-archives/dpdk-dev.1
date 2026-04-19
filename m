Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0785FEA719A
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Apr 2026 16:12:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 083FE40687;
	Sun, 19 Apr 2026 18:11:22 +0200 (CEST)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com
 [209.85.160.54]) by mails.dpdk.org (Postfix) with ESMTP id A7CC340654
 for <dev@dpdk.org>; Sun, 19 Apr 2026 18:11:19 +0200 (CEST)
Received: by mail-oa1-f54.google.com with SMTP id
 586e51a60fabf-404254ffe8aso1684088fac.0
 for <dev@dpdk.org>; Sun, 19 Apr 2026 09:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776615079;
 x=1777219879; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N7iXBplBG8Eg5RmF7+FEKMO/cppB3qRb6ZwgqQ1fhXk=;
 b=ZlvHo7CiwWvwawwVj1dh17lwsOyq+FT0BlGvezJ/FhlYtjyFeLcXP529CwXGe/Xfgm
 p2CSbm33NR1SkMwh7LmUgyo8aNd1nuASbAxN1oIp+b4S3GFSx7INjFWe82dM6DfDWqhj
 2G9r8Sbox+IiggJ/q3m57CFYAgPBCWg6gqaYvVTFxjIqHX01KmTWKXVhWPRWc9jRmjK+
 BguEwQQ80F16136A2aVINWU9KuhvS/jCCIl7dxSsQxuj4W7sQ/twxhIej9TmaSrKAxNd
 BbVmyVb77pzcsc8wmbn0UBndZ+VYRD+mL+AlObwWkqF7H2QPcLJpQs2DuQPPdgPxxfVM
 4Fug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776615079; x=1777219879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N7iXBplBG8Eg5RmF7+FEKMO/cppB3qRb6ZwgqQ1fhXk=;
 b=QEI03gyh9lrUiVoablXQ1/lXV3pOFkgxJKfyhuA6Wd75LhEkSzIqNo2JoXuK986UIo
 2ObwJPSHcJoD0lGeh07dD1uSTRzskqDpajuMzTg4xVd9CZfABRtSy74qE93URmg8+A5q
 z2aWzMZcZwe/lQcj3r1J+jEoPKV35iomUqwv6aC7BB4MUYMvj4Y1d6+GY0jkaOF4vBwQ
 EU7Ej/uygR8G16gmhiHgiTPvrkmAADQQYyFGCpgsXElc2P6A0BM7Sz9NiIorriSdvWgr
 ypa4HRlM+o+eVJc51cnaKA9MEbxHX7JDlh2dMMX2UPEoLP7Jl9kp2tbE6YzMUYCyePIi
 g5Ig==
X-Gm-Message-State: AOJu0YzQwXHWTSNl9sFG9cAkACnDaRkfGizrPSh1BHiBIx/FgamtMLtP
 XJMsdYiDbQmpGu7zUw9IwCBPddH3f5gl1tzgfbsMN89dDP8vEGOyRqElYxlD8YABAAdgDgagKz1
 b3Z7V
X-Gm-Gg: AeBDies3giP6bH3t4Xl6C/BhJiCp7W/UivXNPkp0ZTrwuWWqWhtWJMkeswMw3cSlGEZ
 sdi1pDipKdbgLChzRvx/vtaGkCzPDw96H6I/4DyfZeIoxKK3mjvhI63knt/q5l5PJzb56AF9BJf
 /8nVVMh7JxZxK0ngg3cADkVGgtQUtk5Nd9oVdHNDDARlV4Z2CJipL6BEzCYy3gGmyqWzLYD1CEJ
 cqeG0YJkjjdobMZT3eXQ6Civnh3JaRDI8KDM13s/sf7wqhHrnaLwx4hy9z0npxHd4wqmrMzkLIB
 sRE38VJGuv+fedEOuzF5ccW1gbzRbyvGPGyWX2/iqWc7v+YGRBS+ESKYS4CsTSxtldFyq+6IS/c
 wN5lBF5mdQV4pHmkJcNMa/GNUs1PdXnWaKUw+LK6dTszgCx13+gZbQz/igIP36R/6Vr4JA6OdrZ
 uTLiYgD/LBo51OFNTmEtOVFR+PhacG/aqlmdgFe5wV2xQ=
X-Received: by 2002:a05:6871:d216:b0:417:3161:bfcc with SMTP id
 586e51a60fabf-42a998935bcmr5471915fac.5.1776615078984; 
 Sun, 19 Apr 2026 09:11:18 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b930bca47sm5970632fac.7.2026.04.19.09.11.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 09:11:18 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v25 11/24] net/pcap: add datapath debug logging
Date: Sun, 19 Apr 2026 09:09:44 -0700
Message-ID: <20260419161059.205954-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260419161059.205954-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260419161059.205954-1-stephen@networkplumber.org>
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
index edab1723f9..707d71fe81 100644
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

