Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FEE103A99F
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 02:41:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A2A8640E31;
	Wed, 25 Mar 2026 03:40:36 +0100 (CET)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171]) by mails.dpdk.org (Postfix) with ESMTP id 77F4140E19
 for <dev@dpdk.org>; Wed, 25 Mar 2026 03:40:32 +0100 (CET)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-2bdcf5970cdso421104eec.0
 for <dev@dpdk.org>; Tue, 24 Mar 2026 19:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774406431;
 x=1775011231; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fns9HMM4d3YH9P170C5Ks4p6FiIa/zNkb3rsNjQNKjM=;
 b=K/bSsajQ8uSqCAwfaGocRCT+zO/DdjHL+BHo62CK6mkPmqYtS2sjb2pjg6PtfkJsB2
 NTtU3Y1rmSrPxpAs923vDsMyNzEab5A60s9+ILb8E11D9mV3WRifXoNGSKOWvMP0J7ql
 RTYZr4iqcohj13frqM1s2ACpixPKUFe6wX2DjN61gzFxhVDGQ2sYX2BrK3+nzRqd/cwk
 mMqNizRL1bwgz4+Xwxs7/sOVcbl4qwKjS1JP4CAYBjD2iGyNR9bgCeSKdItewcFN0jgh
 olucPGN2F6gzgtoJOIj6UqS2RUuP9q0jof5MAT6ulwbeLbgS5AjItjzz42kCdDE3pU6D
 6gFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774406431; x=1775011231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fns9HMM4d3YH9P170C5Ks4p6FiIa/zNkb3rsNjQNKjM=;
 b=Lcl/canW4MMgSSiUFgRrJ6rAP0+eNTCjC2C6Z0kqUWry6bUM/qTzC208kXbG0M3olP
 8HEc31hDswkjxeJHKZpt16KzGuyfI3pKxoPteriJX4CRuwv/sTY0AVs9Ly+FzE+H2Jl0
 mRtVFJX6SHSBFM+6N5WT7bHbWSsOxsGG7PBBrA2f4O4+EgaAzJ+Yn4NHnv6PAf5nL2m+
 SJ/soZHlgC1KaKz7upVFQggMoL2SdxGA9ZPEm6VEeRmlVDlibA1OWPqB+EBMYOI4juXE
 ZnvTUh7WBznhM1E2Wmc8Ts9UN/pFph6ohC/6bzR/tUZmp2s6hLOFI2N1uFGZGU3PQVdW
 KpTg==
X-Gm-Message-State: AOJu0YzqoVE+Uw8UGGDyAtZjmMeJslRG0/+jsAI/hp0gnvZ/dflyNmV/
 4ftEIF5zx8Eez1grt1y49pxPcCacfBt04Z7gHxgzhUcyIWb8Aq5vRyvK/ON5XYlG39d6aghNMWy
 ud51r
X-Gm-Gg: ATEYQzyLhzQOjCDlqqLmpfb8TcHxXi+cFpivfmkck3P+20SU0l7vWIeyyLogfHcxeeo
 4LNriWB8Cb2RTO1d7RSSawH9qL/VZv2XSNINNCBCw03ecZUFXU5IJgxJ2LFcbgIKZZOqqpdqrkC
 s0LpOYq4kMe9Xd8T77u+4nm9JY7SnOwdpIQP1383woRZbmxVs0Y5DDAl3H+BGMsfegjE+eZfX41
 qo4Ue/yKzGXECK6/9fZFs6cNbugepId7YlyEvJZgmG4HNjNmUsysZtzwjW/0GNdjPqgbximukxS
 Xy1cyCayD3xipgQEkTX050CjuypY//h77upYqaFm4KkIig7RIx8gp9j630vGOjXXFmIEWpFpw2o
 30oIGJvWQcLQWqfJtJCxAghgnb0PrcfFY6BA/wzwrZ9wek8cXtFAXoqYoK8U/5DLC2Mm3YMZ1iS
 7rPKc3MXDLcpnGHJS/EHSl+Rqe7a/Its/8GCDZ/9nL+DE=
X-Received: by 2002:a05:7301:460e:b0:2c1:5889:779c with SMTP id
 5a478bee46e88-2c158897aacmr884642eec.16.1774406431470; 
 Tue, 24 Mar 2026 19:40:31 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b29b447sm17209452eec.16.2026.03.24.19.40.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 19:40:31 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v21 10/25] net/pcap: clean up TX dumper return value and types
Date: Tue, 24 Mar 2026 19:37:41 -0700
Message-ID: <20260325024018.1275209-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325024018.1275209-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260325024018.1275209-1-stephen@networkplumber.org>
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

