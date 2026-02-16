Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE95E83822
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 18:15:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DBAF6406B4;
	Mon, 16 Feb 2026 19:14:27 +0100 (CET)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id 591DB40673
 for <dev@dpdk.org>; Mon, 16 Feb 2026 19:14:25 +0100 (CET)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-48375f1defeso26902635e9.0
 for <dev@dpdk.org>; Mon, 16 Feb 2026 10:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771265665;
 x=1771870465; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bLQEXF4oQp8VW72iMl8TvWJIt005z+tVzCLb453vGco=;
 b=BYjutyqE5YZ/hGfCTxBaj/zoRLJRD7PryQxKEKr1QfxJV9QP6dRgZWr2qDZHVbP4bT
 DX3DB7m8X1fuRVWhhCIGYQrU1xrAnYdL1lkVGs1cbsa8EYcPF1v6ZIO3uYea4PziIcFq
 K7DbVg2ibL7dWFm14BvCDmEDbzA3tWZwzkh0h8WAL5vqeXmJM10bR+KdxYi4m/sfxs/3
 /9ATv/+642UH/Sta2Q7dkFh5tHuMc7lTxz7isBESwDdBzRLApMmxC+jUDsDUKPi6Hlw/
 QSJKkxMmqKIL+zjdErC06FffV+KiReli7U5dGLvwE3qogZgD+fEnGQtwXwxU5aIdfUJ/
 lS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771265665; x=1771870465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bLQEXF4oQp8VW72iMl8TvWJIt005z+tVzCLb453vGco=;
 b=WxqfWIKTbCFweVVGNgD94S51xcs7vacgRND3kVmS4mCVKfo1rrBlxFt5eEi3yADQ+h
 +fAUYnyvpgYZTQP562OTU7dbbdBSq62kvDT+aNq+iElYNygXK3JUCuQoRqVhVmI4I/3D
 OfoOKAqt+FyOEFATB92SwTW/GB3HUm3FLkM2xE93gQGXkyWU901UiG17gK4VP/HMz8k9
 u0S/neTK4e7DwFoOWEFTFgl0/2uufubtwUms9kUjl6cW8HDTvg4ytmcS9n6BsoJ4khP5
 h5k0qneF1H+VcitlY7BPBDtUpkt4LkgK3oybR37i0u84aX4KzhOLovkskNpuYWrKzcpE
 aH0Q==
X-Gm-Message-State: AOJu0Yywk0BiaUFN32EnUvxGNQfimtrEPmGUXOVN5Y/Hjy5EdLEGm1Am
 Rs8+57FrEvwnKjS4PkIm7hz2mxdeCAhrA5A1+ltrIJKbrQkYjTUZ9YIxJRRjvFO24bB+b+u/eBH
 eTmsxYLg=
X-Gm-Gg: AZuq6aKiMv2K8kEfqLx/E08xkiDsPMwcBmYlU5S1c85/5Yn7I9k+XVEm2gx4bG4KuQm
 iBZasbbwQ9ZWMgYByn5/mecmakEwkBszEfo/Mw0X9clRN6nb1avHAFgkbEe2W/avEISQUBkuhtX
 mZEc+htDZOoCirZfhy32BBsxbbCkl/Frc9kWvh3GeVllmT2c5tUiz3scruJIVFYvWZv3pZIKzag
 Nuon39b79CQDW5/UGC0WHNejJvMr7i6axVdIFxazW7SBvfpIgp003biDZMX/Bdf99akNjSJodvp
 /oy2Jgwt44IXdGJhYZ2Cawn9u+PD+UlIZ3Au+7QLzjp8dmFH9kpazXeU3wdxzSUNc/aW/QeO24Y
 05fyhNM6YzygIrMRzb+R/mhlV/l2Wkxy0/EjppFF9yhKVeujdoSoxQBSOxwICBoxKDi4Dbw6Gob
 zU2xA+2Hn6VU8CIKsso1Zt5fzy1DWhwjCh9nAEAj8LyHmr/wABVPtFqzuU6r99RA==
X-Received: by 2002:a05:600c:1c22:b0:47d:18b0:bb9a with SMTP id
 5b1f17b1804b1-48373a786f3mr210544565e9.33.1771265664881; 
 Mon, 16 Feb 2026 10:14:24 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796acffcesm26064725f8f.37.2026.02.16.10.14.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 10:14:24 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v16 09/21] net/pcap: add datapath debug logging
Date: Mon, 16 Feb 2026 10:12:04 -0800
Message-ID: <20260216181407.428877-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260216181407.428877-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260216181407.428877-1-stephen@networkplumber.org>
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
index 42c5a37177..8162e611e4 100644
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
@@ -502,7 +502,7 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		const uint8_t *data;
 
 		if (unlikely(!rte_pktmbuf_is_contiguous(mbuf) && len > RTE_ETH_PCAP_SNAPSHOT_LEN)) {
-			PMD_LOG(ERR,
+			PMD_TX_LOG(ERR,
 				"Dropping multi segment PCAP packet. Size (%u) > max size (%u).",
 				len, RTE_ETH_PCAP_SNAPSHOT_LEN);
 			tx_queue->tx_stat.err_pkts++;
@@ -513,12 +513,12 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		data = rte_pktmbuf_read(mbuf, 0, len, temp_data);
 		if (unlikely(data == NULL)) {
 			/* This only happens if mbuf is bogus pkt_len > data_len */
-			PMD_LOG(ERR, "rte_pktmbuf_read failed");
+			PMD_TX_LOG(ERR, "rte_pktmbuf_read failed");
 			tx_queue->tx_stat.err_pkts++;
 		} else {
 			/* Unfortunately, libpcap collapses transient (-EBUSY) and hard errors. */
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

