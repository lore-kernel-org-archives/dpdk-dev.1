Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E01CF43830
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Apr 2026 14:49:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AADB440A72;
	Wed, 15 Apr 2026 16:48:23 +0200 (CEST)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com
 [209.85.167.178])
 by mails.dpdk.org (Postfix) with ESMTP id CF53D406B7
 for <dev@dpdk.org>; Wed, 15 Apr 2026 16:48:21 +0200 (CEST)
Received: by mail-oi1-f178.google.com with SMTP id
 5614622812f47-4670464029eso3880260b6e.2
 for <dev@dpdk.org>; Wed, 15 Apr 2026 07:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776264501;
 x=1776869301; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fns9HMM4d3YH9P170C5Ks4p6FiIa/zNkb3rsNjQNKjM=;
 b=C7Ea/CS6mcsWVO7sMlBPX0AEg/OZu2XbRjLdKvlyZn5+CPC+UShNboD46oujhpQu7I
 IUcvBzT4JY6tUVLu59qSeQ/BBHcVfK9RBUU5TG/IGaUaQlrkQJxLKLE7seEcYpEDoF4S
 5MCV4zhCADCiW6hI1MjaodSvEVGHQak8on7JtCuct+XFPlKTWG4cwzvSVyHKW3e936+l
 AZ7i/sjuDfzFZo53+2zjmcCTZRnw6VXwLsM68ryoph2fwu1FWoow0OKtXSDL0eRB7wY5
 9aBNU148OzYbxCbl74c7OgOdQHDoUVM2y8QqTqD0BlH5acxGkGRSgchrDxXpdaBMLFkp
 R9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776264501; x=1776869301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fns9HMM4d3YH9P170C5Ks4p6FiIa/zNkb3rsNjQNKjM=;
 b=JoPGvPI1NvrMDohoJouWCjjlCsMwO+erkMupXabAs9YH6+5ZJ9wg2VRHyrpUHrFTSP
 1D8ChEOy7BylZd1pWrxxUe9LWdMFKcLA183tJjL+xi24EOlGj5baR97EMyfpoe3AzZ2x
 NCuzFlsyO0fAm87SH71Tukz4DcZniBqEeVsUiNqvQS4I+xqLPYNB3HVFtvZxenHaLmzs
 3OMSpcoNKTiNx9R/BZBAUAkU0l59msEr/Bq1CzPca91+sS7lBj4+LRlj79DBYqxfPhR7
 07bT6jkNTNiFmtoKD9sz9aNQXsScJxbHFKEsGu24XijwaNYC/xNwYpna1do9qtanQSEJ
 2mKQ==
X-Gm-Message-State: AOJu0Yy2aFSZ/mxusdv6Si5MaBPBVN79EJ9IQvekO5tIRXk1pyabEPz3
 509jOniqh2GuxOdQP8qzG5LqWUXkmdE0r9GjqgzVgXp7yyzt4PxfN/A/kJ89eHFukfO+pbVZW5J
 wEK3S
X-Gm-Gg: AeBDietmhNQH7S7b0N2xk2BtRNzGvMe0ICJlAHMAdSyz1Yy63MhmyPOQksJbsr476bn
 iZuRnYfH1RFzz2IGbOealJvU4GehKCziZrHJbzeejWIs+BqOGXXaRmeHD36w5568uxaf+wMoZKC
 7N0QCSCP4YjYrZfO2Ib4SRAgsZ1JphkHbuWmTMcFZsbWTjPdgHzlYNktk7Ani97kqoSfU9FUsi3
 KSJVeRNLjvtfJn5qk/MLdtRU2ZzRRTS3MJ23nJT9PU8rSJMa98n1tEet8e/nuWFvFgrQkOKVGUY
 rAF53/oZ06h3J+qYUwueCKIF2tzPe3pZtFdJlWx8pxJx6MLzZoMCW9uGljpjOKmjSY9Lwv2mM17
 COa9q7OmZNR+olcZEphqW6Pjqyc47bOd686PBIgxwfV/+xrlButQaJk0OPUDnIlDPYJ5gW0+p4a
 FA7K/zsZITfp50yW1eZhAIAvV3iwICqqHpXv8aNKnm64I=
X-Received: by 2002:a05:6808:6a83:b0:45e:f443:dc3d with SMTP id
 5614622812f47-4789d04388emr11571216b6e.13.1776264501037; 
 Wed, 15 Apr 2026 07:48:21 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4797a53b1fesm945798b6e.16.2026.04.15.07.48.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 07:48:20 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v23 10/24] net/pcap: clean up TX dumper return value and types
Date: Wed, 15 Apr 2026 07:45:59 -0700
Message-ID: <20260415144717.226161-11-stephen@networkplumber.org>
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

