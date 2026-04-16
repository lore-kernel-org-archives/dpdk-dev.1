Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C93F8D766
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 18:52:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D47FE40BA4;
	Thu, 16 Apr 2026 20:52:02 +0200 (CEST)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by mails.dpdk.org (Postfix) with ESMTP id 7ED2E40A87
 for <dev@dpdk.org>; Thu, 16 Apr 2026 20:51:58 +0200 (CEST)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-12c6df0b9bbso122281c88.1
 for <dev@dpdk.org>; Thu, 16 Apr 2026 11:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776365517;
 x=1776970317; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fns9HMM4d3YH9P170C5Ks4p6FiIa/zNkb3rsNjQNKjM=;
 b=wR+dx+cUnToF/fU1Ly5GcEyg0yGxkRgaBTdEJg+AZ5sCYkJBj36uY374KLtjOC0+uR
 oxxX3Uny53Dkz5wLjAS+d+NLB38uc6ayT8UPKOWPCcJFRV1v9b3+enLbCxYe0OUPKn9N
 Uy0ZXrcTfd0JatSbMAaOyyroCsorR0gzG7YAUKzY3AoEUkd8Lq5mzKq6QLnrA2HnA5rH
 RYglYc04bkBLD7SJNso3G/E5RAnXc+AHy2P2Ac/TC+tiG3p0zYwFUxpkBITAKsLDaP5W
 uTM3/lpSJ4lfUMIUjqj78YHb9m1McWeIF1NMkr/dcpBHvJla97yom0FwniocdnthRNga
 xfpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776365517; x=1776970317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fns9HMM4d3YH9P170C5Ks4p6FiIa/zNkb3rsNjQNKjM=;
 b=dvEcL/uh/7NDrgRtlkuqEItTVVwrvBx0YuPgYgbF1wIZ5hwXOfZ1u76TFUsH1jY/lP
 4Z/KNZv1XBpLKXISjYwqAl69fyNommWi4K/kdPrXROif0KtRdqX1V+lUKuMvDm015Hv6
 uHn//IGDl2mQMA+RKVXQ1CR04r4Mikm7dGghh2oiz+KEUKYXbPyFzEIW5z3G6QE7hEJr
 FDcGa9CMQrsSuJSRvIMndy/EzOQn33WOWIsP7ImJ8Aeufmzw5fz/w+CvaEQUVP2EATHf
 X18MUBZhJAUXhL4hOY64fW3SwJ9EMLBgSDxYwQV5yhLnJDW79ppy4mlYPgGdS4Dt9vEc
 s4eQ==
X-Gm-Message-State: AOJu0YzXU0wOpCjxnoL4MhwyY+2wfkVchoohDISeDQoSLeAdYLGntMCZ
 PNcYnczRqqV7wU618d9Pb+uFYmBaivEVNL03slnrZYvJwJUXhn8IVgacVbj/C6diCYNy/ziFeVx
 tMWkp
X-Gm-Gg: AeBDieus302BfSMsHPYhd6Pct6WKfe7BWHk53HKtv34RzUurLkHA4lagXZHUkUQcABK
 WmuLMqRGla1DAtWPpN3lmY/RXeMH7CSCBn9slkIA/JzfNkjq/hPaepTPixGcO2dEjedJNe9a+KA
 XmZ4d5XXJpj7pRN55kw8m7YtUpY1dlTCCDlZEx4+z8K1v697qdYEH9j6C6Oz7DuI4cZGcOv927P
 l04Gj2td6XtyyuFqIVcEJllNIOGBOrPCvzV8UTaZeJXcT61yG0f0Bkv+2hXcFZX14rUKdojPP7e
 tEMo60A8r0DE2PcoGBMaQmDXoQy6aD/1o3bHbqBYasmDBHj3ACN+9QIoDP1M0q8JmAdH/tNEnVE
 wBcEHlMogYc8hBGskIDfvGKX0DRh4vuG6/3UGSP9pgBq62GJTl5YR99/YAY0kHdzrf94pg6vxU5
 f/6IcrYzMmbtboDj7rNlW1AsEFCGB8aBsd8/6W776xXA0=
X-Received: by 2002:a05:7301:d0b:b0:2d1:d434:cfe3 with SMTP id
 5a478bee46e88-2e2e110a423mr287359eec.0.1776365517540; 
 Thu, 16 Apr 2026 11:51:57 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8f6615d5sm10602510eec.24.2026.04.16.11.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 11:51:57 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v24 10/24] net/pcap: clean up TX dumper return value and types
Date: Thu, 16 Apr 2026 11:48:27 -0700
Message-ID: <20260416185144.1359260-11-stephen@networkplumber.org>
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

Use uint32_t for packet lengths to match rte_pktmbuf_pkt_len()
return type. Split rte_pktmbuf_read() out of the pcap_dump() call
and add RTE_ASSERT for bogus mbuf detection. Remove incorrect
err_pkts accounting since the dumper loop cannot partially fail,
and return the loop index for consistency with eth_pcap_tx.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index ca08b8e342..8df66ebb96 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -407,7 +407,8 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	 * dumper */
 	for (i = 0; i < nb_pkts; i++) {
 		struct rte_mbuf *mbuf = bufs[i];
-		size_t len, caplen;
+		uint32_t len, caplen;
+		const uint8_t *data;
 
 		len = rte_pktmbuf_pkt_len(mbuf);
 		caplen = RTE_MIN(len, RTE_ETH_PCAP_SNAPSHOT_LEN);
@@ -415,15 +416,16 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		calculate_timestamp(&header.ts);
 		header.len = len;
 		header.caplen = caplen;
-		/* rte_pktmbuf_read() returns a pointer to the data directly
-		 * in the mbuf (when the mbuf is contiguous) or, otherwise,
-		 * a pointer to temp_data after copying into it.
-		 */
-		pcap_dump((u_char *)dumper, &header,
-			rte_pktmbuf_read(mbuf, 0, caplen, temp_data));
+
+		data = rte_pktmbuf_read(mbuf, 0, caplen, temp_data);
+
+		/* This could only happen if mbuf is bogus pkt_len > data_len */
+		RTE_ASSERT(data != NULL);
+		pcap_dump((u_char *)dumper, &header, data);
 
 		num_tx++;
 		tx_bytes += caplen;
+
 		rte_pktmbuf_free(mbuf);
 	}
 
@@ -435,9 +437,8 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	pcap_dump_flush(dumper);
 	dumper_q->tx_stat.pkts += num_tx;
 	dumper_q->tx_stat.bytes += tx_bytes;
-	dumper_q->tx_stat.err_pkts += nb_pkts - num_tx;
 
-	return nb_pkts;
+	return i;
 }
 
 /*
-- 
2.53.0

