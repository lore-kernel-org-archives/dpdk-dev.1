Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45616C71130
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Jul 2025 23:18:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4488140A79;
	Tue,  8 Jul 2025 01:18:27 +0200 (CEST)
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com
 [209.85.216.74]) by mails.dpdk.org (Postfix) with ESMTP id 0A449406A2
 for <dev@dpdk.org>; Tue,  8 Jul 2025 01:18:24 +0200 (CEST)
Received: by mail-pj1-f74.google.com with SMTP id
 98e67ed59e1d1-313d346dc8dso5279492a91.1
 for <dev@dpdk.org>; Mon, 07 Jul 2025 16:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1751930303; x=1752535103; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=xJaKLwxmRrRx7Zcsex4wK6pgKZ9Y9A5HMbGY6tqx9wo=;
 b=kQrVs/CDErnvzeCWlItTTgs2VDsD2eq4yx4kswJc1yl7jslacfCDj9HEcDn+WsPJwr
 3oicCg1zliixcgR7gifrw/dJmFFe/s09rW9TTZ065LFRchM6ndS1Zxp3IdUwr3J34jje
 rfR00XHngkdPnbfc9ExFE2Hj02kUorrvb0w9qrTUTEJMUzPCjYgTEA8y2MjVJBggeXns
 Kntg87K/KAxOrYKmkecVCi61L04+qbT9t3AyeyHly8TfF0KL/8AyXeRKVxv3d3+nmsDV
 uD1eF62l1A7WI6yjCTKXOcUbGr1UICD7eOJQVzwt7Z2YrW8Zf21c92Fvkwhr6x4lT6gW
 DpVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751930303; x=1752535103;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xJaKLwxmRrRx7Zcsex4wK6pgKZ9Y9A5HMbGY6tqx9wo=;
 b=ENQuvgB5jWKchf5i+fYN2n8UlB0hOL8gVDYoinuJ9cP3G6Mo250vZXhP5yGAAGPBt6
 SrWblUzGJs/GSUBFWlh+omDOS37qjVfs4UxM0pQlCYz8Q2oOKm5wzmsqwmXU+lajT49X
 7O/pE94vsZ/rY4F+E7KLoQxthe2bWSEtaT2HaZXXa7Yx8AKFH+F+KzWoQSXNtTBZ+e8o
 tNBJATPE/jN+dpEVPSS4ZXKwXHzoT7NrzfZFRE0AbyZZzHMHIvHa2x6K85k09nQiiQur
 Fm74Paa9cKC4yrlXXhwZbToIzT8Kk4f88/tl4Fg4LIal48IBszuwnV+USZVxmdFzyojM
 ozHQ==
X-Gm-Message-State: AOJu0Yx1Xdazvii9Z0uHItMKN00vunlLuFKU20tjc+ceyZf4gQqanAW5
 LFYvuO4GGxEeISjvZOBsTcI7hy/5fMlHmEkOC269gUTdSNa8R3/Bp4Gh4bs5hDrb0giVigH7dyX
 IN7YkLCVcGQhZzw==
X-Google-Smtp-Source: AGHT+IE70RHmi78rjvXUZPekNKg8g4vsQjmIZZxnKTtsaWNLZgaVhbHP3yp5DxFBUl8WulddlvfUThqUeH55lg==
X-Received: from pfbcv5.prod.google.com ([2002:a05:6a00:44c5:b0:746:1bf8:e16])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3285:b0:220:aea6:2154 with SMTP id
 adf61e73a8af0-22b4214ecebmr1161817637.17.1751930303217; 
 Mon, 07 Jul 2025 16:18:23 -0700 (PDT)
Date: Mon,  7 Jul 2025 16:18:10 -0700
In-Reply-To: <20250707231812.1937260-1-joshwash@google.com>
Mime-Version: 1.0
References: <20250707231812.1937260-1-joshwash@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250707231812.1937260-7-joshwash@google.com>
Subject: [PATCH 6/7] net/gve: fix DQO TSO descriptor limit
From: Joshua Washington <joshwash@google.com>
To: Jeroen de Borst <jeroendb@google.com>,
 Joshua Washington <joshwash@google.com>, 
 Varun Lakkur Ambaji Rao <varun.la@gmail.com>,
 Tathagat Priyadarshi <tathagat.dpdk@gmail.com>, 
 Rushil Gupta <rushilg@google.com>
Cc: dev@dpdk.org, stable@dpdk.org, Ankit Garg <nktgrg@google.com>
Content-Type: text/plain; charset="UTF-8"
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

The DQ queue format expects that any MTU-sized packet or segment will
only cross at most 10 data descriptors.

In the non-TSO case, this means that a given packet simply can have at
most 10 descriptors.

In the TSO case, things are a bit more complex. For large TSO packets,
mbufs must be parsed and split into tso_segsz-sized (MSS) segments. For
any such MSS segment, the number of descriptors that would be used to
transmit the segment must be counted. The following restrictions apply
when counting descriptors:

1) Every TSO segment (including the very first) will be prepended by a
   _separate_ data descriptor holding only header data,
2) The hardware can send at most up to 16K bytes in a single data
   descriptor, and
3) The start of every mbuf counts as a separator between data
   descriptors -- data is not assumed to be coalesced or copied

The value of nb_mtu_seg_max is set to GVE_TX_MAX_DATA_DESCS-1 to ensure
that the hidden extra prepended descriptor added to the beginning of
each segment in the TSO case is accounted for.

Fixes: 403c671a46b6 ("net/gve: support TSO in DQO RDA")
Cc: tathagat.dpdk@gmail.com
Cc: stable@dpdk.org

Signed-off-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Ankit Garg <nktgrg@google.com>
---
 drivers/net/gve/gve_ethdev.c |  2 +-
 drivers/net/gve/gve_tx_dqo.c | 64 +++++++++++++++++++++++++++++++++++-
 2 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index 81325ba98c..ef1c543aac 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -603,7 +603,7 @@ gve_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 		.nb_max = priv->max_tx_desc_cnt,
 		.nb_min = priv->min_tx_desc_cnt,
 		.nb_align = 1,
-		.nb_mtu_seg_max = GVE_TX_MAX_DATA_DESCS,
+		.nb_mtu_seg_max = GVE_TX_MAX_DATA_DESCS - 1,
 	};
 
 	dev_info->flow_type_rss_offloads = GVE_RTE_RSS_OFFLOAD_ALL;
diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
index 27f98cdeb3..3befbbcacb 100644
--- a/drivers/net/gve/gve_tx_dqo.c
+++ b/drivers/net/gve/gve_tx_dqo.c
@@ -80,6 +80,68 @@ gve_tx_clean_descs_dqo(struct gve_tx_queue *txq, uint16_t nb_descs) {
 		gve_tx_clean_dqo(txq);
 }
 
+/* GVE expects at most 10 data descriptors per mtu-sized segment. Beyond this,
+ * the hardware will assume the driver is malicious and stop transmitting
+ * packets altogether. Validate that a packet can be sent to avoid sending
+ * posting descriptors for an invalid packet.
+ */
+static inline bool
+gve_tx_validate_descs(struct rte_mbuf *tx_pkt, uint16_t nb_descs, bool is_tso)
+{
+	if (!is_tso)
+		return nb_descs <= GVE_TX_MAX_DATA_DESCS;
+
+	int tso_segsz = tx_pkt->tso_segsz;
+	int num_descs, seg_offset, mbuf_len;
+	int headlen = tx_pkt->l2_len + tx_pkt->l3_len + tx_pkt->l4_len;
+
+	/* Headers will be split into their own buffer. */
+	num_descs = 1;
+	seg_offset = 0;
+	mbuf_len = tx_pkt->data_len - headlen;
+
+	while (tx_pkt) {
+		if (!mbuf_len)
+			goto next_mbuf;
+
+		int seg_remain = tso_segsz - seg_offset;
+		if (num_descs == GVE_TX_MAX_DATA_DESCS && seg_remain)
+			return false;
+
+		if (seg_remain < mbuf_len) {
+			seg_offset = mbuf_len % tso_segsz;
+			/* The MSS is bound from above by 9728B, so a
+			 * single TSO segment in the middle of an mbuf
+			 * will be part of at most two descriptors, and
+			 * is not at risk of defying this limitation.
+			 * Thus, such segments are ignored.
+			 */
+			int mbuf_remain = tx_pkt->data_len % GVE_TX_MAX_BUF_SIZE_DQO;
+
+			/* For each TSO segment, HW will prepend
+			 * headers. The remaining bytes of this mbuf
+			 * will be the start of the payload of the next
+			 * TSO segment. In addition, if the final
+			 * segment in this mbuf is divided between two
+			 * descriptors, both must be counted.
+			 */
+			num_descs = 1 + !!(seg_offset) +
+				(mbuf_remain < seg_offset && mbuf_remain);
+		} else {
+			seg_offset += mbuf_len;
+			num_descs++;
+		}
+
+next_mbuf:
+		tx_pkt = tx_pkt->next;
+		if (tx_pkt)
+			mbuf_len = tx_pkt->data_len;
+	}
+
+
+	return true;
+}
+
 static uint16_t
 gve_tx_pkt_nb_data_descs(struct rte_mbuf *tx_pkt)
 {
@@ -166,7 +228,7 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		}
 
 		/* Drop packet if it doesn't adhere to hardware limits. */
-		if (!tso && nb_descs > GVE_TX_MAX_DATA_DESCS) {
+		if (!gve_tx_validate_descs(tx_pkt, nb_descs, tso)) {
 			txq->stats.too_many_descs++;
 			break;
 		}
-- 
2.50.0.727.gbf7dc18ff4-goog

