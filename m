Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511DBCEFCEB
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Jan 2026 18:34:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3834C40E28;
	Tue,  6 Jan 2026 19:33:29 +0100 (CET)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47]) by mails.dpdk.org (Postfix) with ESMTP id C87E140E21
 for <dev@dpdk.org>; Tue,  6 Jan 2026 19:33:27 +0100 (CET)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-6505cac9879so2026633a12.1
 for <dev@dpdk.org>; Tue, 06 Jan 2026 10:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767724407;
 x=1768329207; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=761W4hB7gDhxx+1axUd2hz4AE5zmbD43q96G8ZIdXpM=;
 b=wFMByAbcHS6ampoviaXpTJNDgizJEyV958KGjLBP/IF+N/6KBmEUbv7wFoOUYYGhxG
 eruR26yLCfV2Jhk2r84Dop27zbKC77nru6Qq75BIWfHE+kA3tqprIUGK3mtYRCzaEBMc
 ZESoT/AL/pydzYbQosgbprVeUeDbgPNOxsMLk0sxfZR50yRrvPui914KQ3tH6lolVZ+L
 7c7UdzEV+6VNGWioPXaDPHUX5YjLnACGSrPgV2lsdwqzV/30o4GlrJSaTRfP9eJg0JhI
 mWqeRnbHvTfaTQ0SJRNDrgFLSnHOlzydfq6Owdn5xiQZFzrv/Oi6ckMdvUDTnH3+4u1e
 ndyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767724407; x=1768329207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=761W4hB7gDhxx+1axUd2hz4AE5zmbD43q96G8ZIdXpM=;
 b=fuUwG1Zew/RAvHyAdM4STWXXbJWxkoLHvlZGyzkVtG4tWenmpmjK8dhV4kyKWbPf5B
 YJi8X8N6JOmBB10JDLANV8NVCrgF2QqaazOJH05ZmOS4myByGF8d1LihuqsuPAxzlGrC
 D41ieqLukXFDqpUCKGBRltIfo2mvVN01s0BQNQE8bHQZTD0ORhiNoTvkghwGIwLcIRTE
 16QJ2Imf0LI0ls3/kH2qt5YRi3lKAVnYJH2LRu/z4NbUK3LZv/Q4Qf0KfrqUAqq/LDX5
 nxYy38AO88ivxp5yVLkFY9xx4RAjV6Y+6uU70Xvd6kZasbRsQsGRkcQe4uBmiFSmjs46
 ConA==
X-Gm-Message-State: AOJu0Yy8uqLaW4DblGMQbNB0rrc82Euzk9d6Qmm0V2Ojb+gS013IGhfU
 rgx6vZwdgI+OAJMN0fjX/iHzovLsBw71QXifautU3BfQCmXYNtpS7ymfV2imHT2IwsizDGw+utv
 nr5DRXuA=
X-Gm-Gg: AY/fxX4OU8qHwcMpzTsk9kuX0MyoRwYOKZl2hVUeQoEXd1MEjqvXsBRw0XHTZjI6pvb
 3D39+N0642N2nS30gg/fhq4Q/AAqWo/93DlO4If8WtQkGWdTCmCDADBf0qR29z+PQPW3j0XyKrj
 ZWM6p+X07lZycHq+dxwRXrmYv5Yw6mXZZfjVwWA5A9OWWfPuiN4ewuYUTHSDnmwmDDQsNbxqnve
 8Ht+1EJP8Nq5ZF1Um6cw3KvfWq3QzuR2nRkt2VcTQ5+s82K3gsHR4eF1m/kGg2TvtfLW2W/qvJT
 PMlfPfl3i10/0KE2w8MHNAjsFPCYnEP3JYeQfu6vKiNaWqZgkMjvx12pnoalF1/jeTX2qPE3Lzg
 8ktv0fnWuYNzg7MXaAd4YlllLSYknaC2dHy+q5e9uQ0lT4WBap3ZSWaqzUTbxrIJ3ZCEDkYkGAx
 txrLWgczCBIisWo1TtfVQAMI+0FatF3MSFZJlmn7BcY7rWjrnVmQ==
X-Google-Smtp-Source: AGHT+IHMvPc4Vh1RSI6Vq3G2UG9JTmsC92IayIh+ihabJfShGVV9K+qb1KDnfCeh+5w5VHgmAbSewA==
X-Received: by 2002:a05:6402:42d3:b0:64b:6dfc:dd34 with SMTP id
 4fb4d7f45d1cf-65097cde534mr35329a12.0.1767724407325; 
 Tue, 06 Jan 2026 10:33:27 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507bf6d4acsm2728525a12.30.2026.01.06.10.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 10:33:26 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 07/12] net/pcap: avoid use of volatile
Date: Tue,  6 Jan 2026 10:26:46 -0800
Message-ID: <20260106182823.192350-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260106182823.192350-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
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

Using volatile for statistics generates expensive atomic rmw
operations when not necessary.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 38 ++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 1658685a28..175d6998f9 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -47,10 +47,10 @@ static uint64_t timestamp_rx_dynflag;
 static int timestamp_dynfield_offset = -1;
 
 struct queue_stat {
-	volatile unsigned long pkts;
-	volatile unsigned long bytes;
-	volatile unsigned long err_pkts;
-	volatile unsigned long rx_nombuf;
+	uint64_t pkts;
+	uint64_t bytes;
+	uint64_t err_pkts;
+	uint64_t rx_nombuf;
 };
 
 struct queue_missed_stat {
@@ -267,6 +267,9 @@ eth_pcap_rx_infinite(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	pcap_q->rx_stat.pkts += i;
 	pcap_q->rx_stat.bytes += rx_bytes;
 
+	/* ensure store operations of statistics are visible */
+	rte_atomic_thread_fence(rte_memory_order_release);
+
 	return i;
 }
 
@@ -345,6 +348,9 @@ eth_pcap_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	pcap_q->rx_stat.pkts += num_rx;
 	pcap_q->rx_stat.bytes += rx_bytes;
 
+	/* ensure store operations of statistics are visible */
+	rte_atomic_thread_fence(rte_memory_order_release);
+
 	return num_rx;
 }
 
@@ -440,6 +446,9 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	dumper_q->tx_stat.bytes += tx_bytes;
 	dumper_q->tx_stat.err_pkts += nb_pkts - num_tx;
 
+	/* ensure store operations of statistics are visible */
+	rte_atomic_thread_fence(rte_memory_order_release);
+
 	return nb_pkts;
 }
 
@@ -464,6 +473,9 @@ eth_tx_drop(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	tx_queue->tx_stat.pkts += nb_pkts;
 	tx_queue->tx_stat.bytes += tx_bytes;
 
+	/* ensure store operations of statistics are visible */
+	rte_atomic_thread_fence(rte_memory_order_release);
+
 	return nb_pkts;
 }
 
@@ -515,6 +527,9 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	tx_queue->tx_stat.bytes += tx_bytes;
 	tx_queue->tx_stat.err_pkts += nb_pkts - num_tx;
 
+	/* ensure store operations of statistics are visible */
+	rte_atomic_thread_fence(rte_memory_order_release);
+
 	return nb_pkts;
 }
 
@@ -821,13 +836,16 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 	      struct eth_queue_stats *qstats)
 {
 	unsigned int i;
-	unsigned long rx_packets_total = 0, rx_bytes_total = 0;
-	unsigned long rx_missed_total = 0;
-	unsigned long rx_nombuf_total = 0, rx_err_total = 0;
-	unsigned long tx_packets_total = 0, tx_bytes_total = 0;
-	unsigned long tx_packets_err_total = 0;
+	uint64_t rx_packets_total = 0, rx_bytes_total = 0;
+	uint64_t rx_missed_total = 0;
+	uint64_t rx_nombuf_total = 0, rx_err_total = 0;
+	uint64_t tx_packets_total = 0, tx_bytes_total = 0;
+	uint64_t tx_packets_err_total = 0;
 	const struct pmd_internals *internal = dev->data->dev_private;
 
+	/* ensure that current statistics are visible */
+	rte_atomic_thread_fence(rte_memory_order_acquire);
+
 	for (i = 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS &&
 			i < dev->data->nb_rx_queues; i++) {
 		if (qstats != NULL) {
@@ -884,6 +902,8 @@ eth_stats_reset(struct rte_eth_dev *dev)
 		internal->tx_queue[i].tx_stat.err_pkts = 0;
 	}
 
+	/* ensure store operations of statistics are visible */
+	rte_atomic_thread_fence(rte_memory_order_release);
 	return 0;
 }
 
-- 
2.51.0

