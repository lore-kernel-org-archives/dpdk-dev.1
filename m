Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4942D73EAF
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 01:14:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E9124066B;
	Fri, 30 Jan 2026 02:14:06 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id B120540656
 for <dev@dpdk.org>; Fri, 30 Jan 2026 02:13:59 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4801bc32725so11770765e9.0
 for <dev@dpdk.org>; Thu, 29 Jan 2026 17:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769735639;
 x=1770340439; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ovUkmYF0+OUHl2I5Pg4pp/WyHvAQiZvf6VaBNC2OLOo=;
 b=LvAy8sDDUw9eIets3Mdhv+mLiyud8m7CeebM5K9T6eXGaiuhzCfWWIGaDYdOULSCjR
 8GscF+U28GxWHanfQwmUBvJM5zpfNJUgTRYwS/az/ocJVx7lfiKygBZvsRmqJo6rtwYL
 jx2YEMkoP2bXtMVwW0jrxNRXFdMYnEgXHMOE16GwHwBfxcBxkTh1+yZlvJrhBxPP+4ZV
 EsWdX736j+ndr3wuPBUC51ugbJUe/7P8C2Nzp2lfIf4R2m9UnXElCvfaf4sqHVbWXLUQ
 e3BLdsvvbqJUbM0C/ZBRUFFEPh5jg4qVD4gpZtqrNPkvRgJuvcbZazHfp2GJfFlzaYlx
 JumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769735639; x=1770340439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ovUkmYF0+OUHl2I5Pg4pp/WyHvAQiZvf6VaBNC2OLOo=;
 b=LoBcuHP0CKVLPoC0Rg9stV57l5HRZJJZooYaXCORJRzdLOanFwVJXfhSdQpqjhsPKh
 jPsqcpR4pDY+CJzzkJBKVZgxqrSbJjTVMjN6eehOlo4HbI6xkHT84f/VNNS9xRYVzqoy
 WpBt+nLKg0QrrYbZILg8cqlnvp8JEghNV/LOh2dsptuw3oA1wJLjJg1TEFa5v+s3QdcM
 +V5+4JGmf/p/8/p8NrM2MY51xrJGQoSHToYEUSct0r9NbjUuCjvAFdb89cFrh48Ysq/h
 2sxYSRE/AgmvDfN8xIDBGHNy9f7sxAklKc9c1uBmw9Nu/WDuumx04hzk5aUstXmeaLa5
 fYoQ==
X-Gm-Message-State: AOJu0YwxEYmwEvvJaLJKALxzCnlrfcV2fwKSZZP8JAQmoSU2lNr8+hIH
 4MwBuuQvRDaVMrU2yfj/v46aWV6GE18YlnweXT3mREJ38PHlt74LwU1qoWr5sWbBIC15SelQPRC
 3mqa/
X-Gm-Gg: AZuq6aL7lKQyoHjHUL56ByvkC3dktsDWxzlwFHyGmZi6Fuqcsi68Bbk0M4javZie8Ji
 XpyaLGF3cjvRcglzVzOv7f8NHpElIuA8nTbEQW4PLJDVdsZKBwlMy1ZrHaEY8ZaOfYlfHduXxqv
 tqKUorU65jVvLVGzxvGZzsrKkO4uGq+2WJ+buVYZnSXAstruXpK7AKOqYljjFXXFPY/OmAka2X1
 Qp3qh9+iJd35wPJltskECldQW81R7xrO6Rv1hQx+67hQaDKpznkrbcXdGDOHk2tBbcYruZm7Cbm
 EWiqdKNppZS+24RwOrf8vNf7LqoqPcjhpUg7rZacPu7cT1eX3APxfryPeqwOYCeJbdxh+Hpiu8r
 Hnk2WULd/wi7CNZ8eT04gQNqDerGlrV1drcoDMKNjA7XPBi2O2lANr4RzmmEJRtKHK+JffhgSNg
 7pdpGsUxCcAoGRo1s8apu/dm8EMgz7SG7QK3tNdNDp6p2rT0IpXQ==
X-Received: by 2002:a05:600c:4507:b0:475:dcbb:7903 with SMTP id
 5b1f17b1804b1-482db45ea8emr10959235e9.9.1769735639267; 
 Thu, 29 Jan 2026 17:13:59 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-481a5e1d0f9sm2934825e9.18.2026.01.29.17.13.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 17:13:58 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v10 06/19] net/pcap: use bulk free
Date: Thu, 29 Jan 2026 17:12:22 -0800
Message-ID: <20260130011344.204233-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130011344.204233-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260130011344.204233-1-stephen@networkplumber.org>
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

