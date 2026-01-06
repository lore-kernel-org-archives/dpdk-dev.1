Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EFDCEFCEB
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Jan 2026 18:34:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5885740E2C;
	Tue,  6 Jan 2026 19:33:31 +0100 (CET)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50]) by mails.dpdk.org (Postfix) with ESMTP id 614B640E1F
 for <dev@dpdk.org>; Tue,  6 Jan 2026 19:33:29 +0100 (CET)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-64daeb28c56so1879847a12.2
 for <dev@dpdk.org>; Tue, 06 Jan 2026 10:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767724409;
 x=1768329209; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/6RhBidtmZN1O5cYdNjxPy7UqrOteedoOhpAu6Pi9bE=;
 b=ePo9lSlzKKK0Gp6tAf+BW1tfYZ/uh0lcISSkERnX9VUB5R76KlqM22tNe5dkHqMwwH
 /prQX2etq//fiMUU75htn9l9QU5wiHz3NgHG8WKdYYycSXJYfJGwv2xP8YAppyV/gi5c
 XmExh6POltPdXCb75kLarDWA3QWKlRF7MlGhdRPhaGlIEAXRsCno9YhTbTw7jihkubbH
 hpB/c9dM1pqwTaXXmB/lmidsmXbGzSV5JfdMnVoszV6v9Z/JOKUwy5O0XYqcThHbOLL1
 Q53JGlbpkHqIb3ZitzWwha5l2uFfI19b4SOWMc+aEa8Kh8IlRYO/3SB4botis8gn94Z3
 3GOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767724409; x=1768329209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/6RhBidtmZN1O5cYdNjxPy7UqrOteedoOhpAu6Pi9bE=;
 b=vR/2nClIVARk+DRZZiqpWoxO44DVnmGDmZdNmNIWS4MJwyUvTqcKViitJcZKRR769G
 qvOEgESX1VnNNd00T+J5V8dmZYFP49LmMlZdDIXCNIh60C2ek186OQa23mxPBhT0jA5A
 xslz3m5Ez+rkpqr46cZjABc95Sme72tIE5KFEdExr6pnxgnCF9gUg5z5YbOoUOxyAvT9
 kFkjRvVVFgQ3XH7hxkeVYd2swNQ6dnxWRjLWUQ4luINPQju1D5kOPrl7WrAr4qhZcOY0
 cnAiadlVZ3GUxxG1mudx8WT6e8yjfu8pYJg8cXSnCvHj+ylzfen5m4fB6v+52+/XVB2l
 k51g==
X-Gm-Message-State: AOJu0YzxUF/cJnFMB9UqqEYEn/TsG1OcCgbDGd0UrLF9tJjSp8PAamCM
 BsHAWrlQN9xR0TThf6k5Rn3QilPOqQMke2X1LFKRIYxerGRe+P/OPIclOWt6GxcmYaPckXlO5FB
 VBu+Ufa8=
X-Gm-Gg: AY/fxX7bHsQJam6WVugQV0p/TO+AiSKsFeKCkkfOtsNj8HbfsSX8HQ3K0eU0wvCyMWk
 VFUXwJuFesEedNBhFd7Drgj7rFPbIUZgqnvYBbbEmtWWE9otkM3c/xUJrlwgOv7iQaNnB2spxuW
 CPLvOtJ0or3jeStYw6fPbq/N2DrWEJNny6YFuFatukQ+rmIhq6nW4tCXvRTCWYjvBYcDmbGnkky
 CDJd7zLOZqUJfyo5hLbYT4pNSeT5AtlMrUdqw7F1CN2bmVlwnt69G63ictXbgTSziBm5GZXFsEa
 QQF+P9pYJWXc4yjP5iuTU/tsd5lq03TexRx1NypK2ogINC6oS5vFc3u3cTFbwYfq8wZoMGesXdi
 tHpOqiBzyyuDWILtO6sjgeG7UrO8PE47B2WSj1/oe9h+VtUSQe/XWDaXU68NtB51gmbNwC0kYBc
 yJ4Tye0zlqN2AyY9EbAuQvh7CaoHYwnTM5lMt4M9RvOA0LYc9oJg==
X-Google-Smtp-Source: AGHT+IHxD4lfAC/VxGRq+vPCxYfHi+R+Wl+vFYssTZ+UfoY3zeUC+EAUIsx1FGg7QCfsu/o7rdl6nw==
X-Received: by 2002:a05:6402:4403:b0:64b:48b1:7c12 with SMTP id
 4fb4d7f45d1cf-65097dd29c4mr6065a12.3.1767724408868; 
 Tue, 06 Jan 2026 10:33:28 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507bf6d4acsm2728525a12.30.2026.01.06.10.33.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 10:33:28 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 08/12] net/pcap: optimize calculation of receive timestamp
Date: Tue,  6 Jan 2026 10:26:47 -0800
Message-ID: <20260106182823.192350-9-stephen@networkplumber.org>
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

Avoid doing slow instructions in receive path when calculating
timestamp. Give all packets in the same rx burst the same timestamp.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 175d6998f9..e283fb3787 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -20,6 +20,7 @@
 #include <bus_vdev_driver.h>
 #include <rte_os_shim.h>
 #include <rte_time.h>
+#include <rte_reciprocal.h>
 
 #include "pcap_osdep.h"
 
@@ -41,7 +42,7 @@
 
 static struct timespec start_time;
 static uint64_t start_cycles;
-static uint64_t hz;
+static struct rte_reciprocal_u64 hz_inv;
 
 static uint64_t timestamp_rx_dynflag;
 static int timestamp_dynfield_offset = -1;
@@ -362,8 +363,6 @@ eth_null_rx(void *queue __rte_unused,
 	return 0;
 }
 
-#define NSEC_PER_SEC	1000000000L
-
 /*
  * This function stores nanoseconds in `tv_usec` field of `struct timeval`,
  * because `ts` goes directly to nanosecond-precision dump.
@@ -374,8 +373,10 @@ calculate_timestamp(struct timeval *ts) {
 	struct timespec cur_time;
 
 	cycles = rte_get_timer_cycles() - start_cycles;
-	cur_time.tv_sec = cycles / hz;
-	cur_time.tv_nsec = (cycles % hz) * NSEC_PER_SEC / hz;
+	cur_time.tv_sec = rte_reciprocal_divide_u64(cycles, &hz_inv);
+	/* compute remainder */
+	cycles -= cur_time.tv_sec * rte_get_timer_hz();
+	cur_time.tv_nsec = rte_reciprocal_divide_u64(cycles * NS_PER_S, &hz_inv);
 
 	ts->tv_sec = start_time.tv_sec + cur_time.tv_sec;
 	ts->tv_usec = start_time.tv_nsec + cur_time.tv_nsec;
@@ -394,6 +395,7 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	unsigned int i;
 	struct pmd_process_private *pp;
 	struct pcap_tx_queue *dumper_q = queue;
+	struct pcap_pkthdr header;
 	uint16_t num_tx = 0;
 	uint32_t tx_bytes = 0;
 	pcap_dumper_t *dumper;
@@ -406,13 +408,14 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	if (unlikely(dumper == NULL || nb_pkts == 0))
 		return 0;
 
-	/* writes the nb_pkts packets to the previously opened pcap file
-	 * dumper */
+	/* all packets in burst have same timestamp */
+	calculate_timestamp(&header.ts);
+
+	/* writes the nb_pkts packets to the previously opened pcap file dumper */
 	for (i = 0; i < nb_pkts; i++) {
 		struct rte_mbuf *mbuf = bufs[i];
 		size_t len = rte_pktmbuf_pkt_len(mbuf);
 		uint8_t temp_data[RTE_ETH_PCAP_SNAPLEN];
-		struct pcap_pkthdr header;
 
 		if (unlikely(len > mtu))
 			continue;
@@ -420,7 +423,6 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		if ((mbuf->ol_flags & RTE_MBUF_F_TX_VLAN) && rte_vlan_insert(&mbuf))
 			continue;
 
-		calculate_timestamp(&header.ts);
 		header.len = len;
 		header.caplen = len;
 
@@ -1530,7 +1532,8 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 
 	timespec_get(&start_time, TIME_UTC);
 	start_cycles = rte_get_timer_cycles();
-	hz = rte_get_timer_hz();
+
+	hz_inv = rte_reciprocal_value_u64(rte_get_timer_hz());
 
 	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
 		eth_dev = rte_eth_dev_attach_secondary(name);
-- 
2.51.0

