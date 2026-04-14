Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13589F9D0E2
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 16:11:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 933B5406FF;
	Tue, 14 Apr 2026 18:10:29 +0200 (CEST)
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com
 [209.85.161.45]) by mails.dpdk.org (Postfix) with ESMTP id AD3A64069D
 for <dev@dpdk.org>; Tue, 14 Apr 2026 18:10:26 +0200 (CEST)
Received: by mail-oo1-f45.google.com with SMTP id
 006d021491bc7-66ee7b9af94so2027694eaf.0
 for <dev@dpdk.org>; Tue, 14 Apr 2026 09:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776183026;
 x=1776787826; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fns9HMM4d3YH9P170C5Ks4p6FiIa/zNkb3rsNjQNKjM=;
 b=OhDD74froj5gbqAMsAaATZj6jA4Fsuc/0dm6AvrlW59mJ4L+pawxzkjJVeDQZWJEpU
 c9HTek/Ocz1y3pfFVEf7W3vkyaoCuX76apmb9eTu2aJbSV8rB1sX6QmW0zw/1JT5HbRa
 XoG4ND5QQL4FQUkLi32pad0f/tIaqMajcd9pthDRAU9LGxb8NbCaptoiuLwYfmXNm5Nr
 9Jzpa43T0FUF4JtQvICSoJuCBpVTLSMeLKWj2A5X9MVLPe5RyEH8kia0oc7GtvoHW05T
 kOGlz0oKY1z12Hh4dMtv1IeqkGFzC6Ff+PTp7eVHZ+LUxKmfXuzaxZ3mWyC0yUcX0mKs
 pSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776183026; x=1776787826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fns9HMM4d3YH9P170C5Ks4p6FiIa/zNkb3rsNjQNKjM=;
 b=qXN2EKh+w/EK7NOSxNEK5pba/vHcs2hnh0/veF2yLW13/VU3yJ/sbv5Wy8gCfKGV6G
 VuHmznZpXYn2cz78PjRk/oSvSOnDNqwEbnkK1UzGVQzursrZEHI3vXD7fR6g/gNgtMnR
 lmZXpwwmrVD9OnO4Jb/TegvSwNyUpHcXfyGv02zXUC4lAI1UFwngR0ZgLYSkvN2kb/Ee
 oAdHuSD1KEofIlaby7fKHnBGkl/h679vKrgZaRypc4xkZPN8QKz5yJE8hs32SOA1avUQ
 iqsLMOIw3qAMP1et+Vp2V5uNNXQ4OiuGpe0R1m1f5a3fm0yfmF6eAfUDk5Z8Y9mjhmKF
 2xEA==
X-Gm-Message-State: AOJu0YyEMM+73+zMxuyBAPoCxWmr5Moh+0xrWRIaqHNyG8tlXcauFMoA
 8kE7EZ+ooSkggTvOrpZmfeSMND40nUJOvg7cK6JursRhrHJdTbki/OW8hR2Jogi/Q7coACaL/vo
 6o1gd
X-Gm-Gg: AeBDiesLO9ecWtSP0FTfY9bglRybRe3zxdkuKPwoch/5SxX5jwYKZj4+pAgNcsP29wM
 HYhuYr4TovBbBDk0X6g0Azb4RhOH1xYFbbWeoqtRwhrcpmtpKCFjN3glKf4HBGKuHMOy8MxXBZA
 YO7WSecBxAxvbJQDPi42Sa4wzepVB/4md1+Q9T0fP1pajONCJCCHlBerYkrOMmC2zA+QxYPslkt
 VJkBBwXO7vVMcV1bHMXrfJXmLFI0z6bthDFDhtcw8Q3T5ySYG1gmOW2gOm0PN9M9pu3OAPOQmNW
 g8gLLNNr18SYFUFCS913RHV/lPnRY0e0nxGqFGzNAczLojnH+FPIMnRj6Ow3imkmWavwA3oRwND
 Fd6iHR2DijUZ2Z4/OnLkFZaJnUx1mDYOeoh7gLDTpC6k2VDXRkJ6+Gs/N8GBQhh+2iwH7XOULUb
 2hYI6r3lXdl4IGUudNxgVihS1Dd5HxUXSBt7wcztmTc6Q=
X-Received: by 2002:a05:6820:622:b0:67e:3e6d:f74a with SMTP id
 006d021491bc7-68be5c5cd0bmr9051355eaf.4.1776183025914; 
 Tue, 14 Apr 2026 09:10:25 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423dd396960sm11809554fac.2.2026.04.14.09.10.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 09:10:25 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v22 10/24] net/pcap: clean up TX dumper return value and types
Date: Tue, 14 Apr 2026 09:08:01 -0700
Message-ID: <20260414161011.756101-11-stephen@networkplumber.org>
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

