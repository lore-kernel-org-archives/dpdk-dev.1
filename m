Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4682CE7FDF8
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 23:13:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2535D4067C;
	Tue,  3 Feb 2026 00:13:06 +0100 (CET)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52]) by mails.dpdk.org (Postfix) with ESMTP id E5B1640671
 for <dev@dpdk.org>; Tue,  3 Feb 2026 00:13:02 +0100 (CET)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-4359a302794so3416039f8f.1
 for <dev@dpdk.org>; Mon, 02 Feb 2026 15:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770073982;
 x=1770678782; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ovUkmYF0+OUHl2I5Pg4pp/WyHvAQiZvf6VaBNC2OLOo=;
 b=UJsZTNjMK7XuzvmoPE5c2ifKlbw/UDaO0cS2dy6sppegMEbY2kIoEt3bKuoegXXR7s
 3UlSfbVQh1KhRJZEVK+FpGJOZfF8UDeCnvIWz1oFu6eT6sgGs2/337SkgYlMou7py5l8
 BKzQ0n1RyN4Dmw/WA8z83ZpuhS9BdH7f4FRnd4CWjbEgOmU3C7fud0m+P+jsgyFeFa1o
 yIOAwCPI7TipnudJBdQropsYUHPs6dN5+D7kV4isvUeld240qs+/xs8OlBKbbqqf5XOE
 T0FAETBlgB47m2mtv8T94ToBMo5gena5a7fnhPDsgZvlgzdD8DQMt5przefOcX/bDuMi
 KDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770073982; x=1770678782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ovUkmYF0+OUHl2I5Pg4pp/WyHvAQiZvf6VaBNC2OLOo=;
 b=pUZJSZeyemN7Q76O6zj4d+8ghABoipkmbQMVxon7TjGGAcLxW38TDcxoiwK3zRNBCe
 iYdwuhl8KbKiaaKenLSMRWqhurOgf7aXb59tGTMnXhd/dyFD/1xyxn0FHdQvMBEzZcMp
 cAdLIERGkBE19XMuyBaSD10d8PAIBD62BKN1GpBYhHQEBdhOabk9Jms3OEgFTGxxl+MB
 5XJocVGCZ30tqu/Jf/LaKZgtu7ni8XDQ4HxLTjUiCxkFVBTStagDuPdgbnpz8Q/Pw7Au
 o/1e9My3bZifMnMGRmXowmUod3MzWzfEOUtFQUYcU725ZYpxOYysoBFUBbZskYy5bi0w
 9ukg==
X-Gm-Message-State: AOJu0Ywahp3zrEj4XIzhS+TN/fhO1D/14r6XKfGX0kM+XrH0uNS4McGv
 6ZJTQZTlHlldUtUk5fuOdqPrx8W3AZ6nqWFZqRZigDUES0CwJe7Sl1z6f5LDWWhhEH3DrLpfgkU
 C4E24
X-Gm-Gg: AZuq6aJL1ttxueC3b/if1VCxWtbYOZsLXrQTmozZDLPgV8zCmqsuNUyTLr5uxJ+56p3
 8fBAvFHgP13U0peE06PJPTREoCKdvGjJunwbADZ/MM55lPvSDPGaQL7teWw7xDFkBZdbK0FFnx4
 +0EQP9pqYwDLyemWXJDd+bYOHhiuP+ojRucSr4AX6DjYOQ0FzLOhQPMaPwHJjaNVDPA1UdiufEu
 tZoqqj8mjf3kmX0x6hN5QyzdhRqrKaWpwonIiDGkHa7F+XukZI5BulxzgcRxBGsxKd5SbHaJOuk
 dVXC+M6SysdU+BPG+lVJdcz/O9Z+VRaB4anaTa00wPH6TBjelD5hS4WEXHOmy2Ggj9uO7WEnPfx
 8Ieelb6AXR8SIugfMFZpDS53agDW1wBklW0z+9NhpmfvZsDKNb5WQJw8J4NSkBNxWv8AcBH7v0y
 9BenNv94WQ1X4wuxvm8ZVF7X99PjGzm106fvLWFKs3QP8HJkz8UA==
X-Received: by 2002:a05:6000:40df:b0:432:852d:5662 with SMTP id
 ffacd0b85a97d-435f3ad23ecmr18764749f8f.63.1770073982441; 
 Mon, 02 Feb 2026 15:13:02 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e48a6sm45799474f8f.8.2026.02.02.15.13.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 15:13:02 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v12 06/19] net/pcap: use bulk free
Date: Mon,  2 Feb 2026 15:09:09 -0800
Message-ID: <20260202231245.216433-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260202231245.216433-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260202231245.216433-1-stephen@networkplumber.org>
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

Using function rte_pktmbuf_free_bulk is marginally faster here.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 806451dc99..61ba50e356 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -423,8 +423,8 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
 		num_tx++;
 		tx_bytes += caplen;
-		rte_pktmbuf_free(mbuf);
 	}
+	rte_pktmbuf_free_bulk(bufs, nb_pkts);
 
 	/*
 	 * Since there's no place to hook a callback when the forwarding
@@ -449,13 +449,10 @@ eth_tx_drop(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	uint32_t tx_bytes = 0;
 	struct pcap_tx_queue *tx_queue = queue;
 
-	if (unlikely(nb_pkts == 0))
-		return 0;
-
-	for (i = 0; i < nb_pkts; i++) {
+	for (i = 0; i < nb_pkts; i++)
 		tx_bytes += bufs[i]->pkt_len;
-		rte_pktmbuf_free(bufs[i]);
-	}
+
+	rte_pktmbuf_free_bulk(bufs, nb_pkts);
 
 	tx_queue->tx_stat.pkts += nb_pkts;
 	tx_queue->tx_stat.bytes += tx_bytes;
@@ -494,7 +491,6 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			PMD_LOG(ERR,
 				"Dropping multi segment PCAP packet. Size (%zd) > max size (%zd).",
 				len, sizeof(temp_data));
-			rte_pktmbuf_free(mbuf);
 			continue;
 		}
 
@@ -508,9 +504,10 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			break;
 		num_tx++;
 		tx_bytes += len;
-		rte_pktmbuf_free(mbuf);
 	}
 
+	rte_pktmbuf_free_bulk(bufs, nb_pkts);
+
 	tx_queue->tx_stat.pkts += num_tx;
 	tx_queue->tx_stat.bytes += tx_bytes;
 	tx_queue->tx_stat.err_pkts += i - num_tx;
-- 
2.51.0

