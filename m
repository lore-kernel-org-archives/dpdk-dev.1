Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1462E103A99F
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 02:41:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52B3F40E38;
	Wed, 25 Mar 2026 03:40:35 +0100 (CET)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182]) by mails.dpdk.org (Postfix) with ESMTP id B026640E16
 for <dev@dpdk.org>; Wed, 25 Mar 2026 03:40:31 +0100 (CET)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-2c160cb021cso295641eec.1
 for <dev@dpdk.org>; Tue, 24 Mar 2026 19:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774406431;
 x=1775011231; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U8qlHnaWL3xA7pIAnsegSiJnseUdbksPPijuwVzzW1s=;
 b=MbKcA/t0AuHQtkfJyYpk9mF5GmMGma00uJ79EG5hXQmm+jfZG9hI7LfIGR3kw4m2sF
 i7tKw8rM+SMEt3tfOxFXS5TPiLOSXoMsJAK148Oz46MI8xqzOfxzPO+4+cDV4GikfOEA
 DIZCLSSk/g9EZKiYalt+3QlS8hVmkCxc9/ZWDhzavXU4SfTHZ1lrCySxgk+GLd0oEVCY
 8eDWG+XOlXzqv8GqOzlOVWH3FWMArkO+Lzvbs01DlVkEBXEUki2woFNMhbc7PGBEjErq
 zJpH1F805yuWF+17WyZ+IqAyE+JeZVPOlC6HxvPCxETWLnIAzchuigwjpSsV0TK6EqCz
 z3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774406431; x=1775011231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U8qlHnaWL3xA7pIAnsegSiJnseUdbksPPijuwVzzW1s=;
 b=S1xZlD0b+cy9ZgE+bltYEmIyrXujxO6+IyJb/SLilZb8T1ShjL/TYlsPCKOZEz5t2C
 bPgvS8ZvR7TXCWOUgbKOpU8A/mwQJE4I04gqZITPjbB+HvfXaochGveStdA5Four/JJj
 cOSiu4mdP2imAiSxZpMd7yQS2K0aLqgDSm04qs0ihJ/ZxdUQ/WW/i2C/uI8tMOfEU6Id
 T2a57y/rlgQNPKKL8Y3w3YpE6/CZDEEzXo1Rl0g7JZMgz5a/rbg/68SJA7YYvEx89K8R
 ya5VWU095cG6PZFMMzaaQcR0F8bx+j8p9a/rfplasoR+rhum/9gcfyi7+iHUCConaQxo
 bC2g==
X-Gm-Message-State: AOJu0YxGwTX/YbHg2CRnOQduK/6aVWMVD5/tll+4/RKFn76ixZOffsSY
 9tOSijQdOxE6LaldxrPQVeeFlIOSKiPf4krm4fkmv81Jx7f5L6dCHFcKq68FZwVWhMQBzNCF+wF
 1PnuS
X-Gm-Gg: ATEYQzyU6wjUFyyxgnBQwgb45RfCWi/LIhjFErWpqK9/huUUQCY2ydLXUyrhRmc/ZNf
 1C14EKWVWzNFtoSB6qTxQu8HZcYMX6viewMFJMMdDsc3krKeEyjHKovarY68OX1S/Ioj5xn1Cz2
 IpfaycHOMwVURzUMiUqt+w6AEotzM5sYREBm4m4Frl35gIxOw9B26x50WDi9k4TWSQTbIQo+056
 wm4t/5qbJrPOwmm5vi0lKrmLnYbE/QvWSIHwNqfsZwCkrdIIrQqCkhx/rBlv2SgMhqDp1sN3slf
 XFtY9DlFEIFwyTHLiFEYk3+XZWIPaYZUqtHAdz2mOfvARpfqvnqBfokVsmG5OJrMJNze3rPQ9Q4
 x7PP6pF+O35MWvOouMJ3GlALwf5dUu8xLJ4MPMovL5NCbQVTV5RCkRXBgZaYeBi+ThxX9yWJhrY
 kmAX0eu53Ibk5J6TuwhsKEv0d3GTOLNiy6
X-Received: by 2002:a05:7300:dc04:b0:2bd:cfce:4c4b with SMTP id
 5a478bee46e88-2c15d32b6acmr784049eec.2.1774406430523; 
 Tue, 24 Mar 2026 19:40:30 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b29b447sm17209452eec.16.2026.03.24.19.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 19:40:30 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 David Marchand <david.marchand@redhat.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v21 09/25] net/pcap: fix error accounting and backpressure on
 transmit
Date: Tue, 24 Mar 2026 19:37:40 -0700
Message-ID: <20260325024018.1275209-10-stephen@networkplumber.org>
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

Fix two problems in eth_pcap_tx():

Oversized multi-segment packets that exceed the bounce buffer are
dropped but were not counted as errors. Add err_pkts accounting
for these drops.

When pcap_sendpacket() fails due to kernel socket backpressure,
the remaining unsent packets were counted as TX errors. Since
backpressure is transient (EAGAIN/EBUSY/EINTR), break the loop
and return the number of packets attempted so the caller retains
ownership of the unsent mbufs per tx_burst semantics.

Fixes: fbbbf553f268 ("net/pcap: fix concurrent multiseg Tx")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 02d5cb591f..ca08b8e342 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -462,7 +462,17 @@ eth_tx_drop(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 }
 
 /*
- * Callback to handle sending packets through a real NIC.
+ * Send a burst of packets to a pcap device.
+ *
+ * On Linux, pcap_sendpacket() calls send() on a blocking PF_PACKET
+ * socket with default kernel buffer sizes and no TX ring (PACKET_TX_RING).
+ * The send() call only blocks when the kernel socket send buffer is full,
+ * providing limited backpressure.
+ *
+ * On error, pcap_sendpacket() returns non-zero and the loop breaks,
+ * leaving remaining packets unsent.
+ *
+ * Bottom line: backpressure is not an error.
  */
 static uint16_t
 eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
@@ -484,26 +494,27 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
 	for (i = 0; i < nb_pkts; i++) {
 		struct rte_mbuf *mbuf = bufs[i];
-		size_t len = rte_pktmbuf_pkt_len(mbuf);
-		int ret;
+		uint32_t len = rte_pktmbuf_pkt_len(mbuf);
+		const uint8_t *data;
 
 		if (unlikely(!rte_pktmbuf_is_contiguous(mbuf) &&
 				len > RTE_ETH_PCAP_SNAPSHOT_LEN)) {
 			PMD_LOG(ERR,
-				"Dropping multi segment PCAP packet. Size (%zd) > max size (%u).",
+				"Dropping multi segment PCAP packet. Size (%u) > max size (%u).",
 				len, RTE_ETH_PCAP_SNAPSHOT_LEN);
+			tx_queue->tx_stat.err_pkts++;
 			rte_pktmbuf_free(mbuf);
 			continue;
 		}
 
-		/* rte_pktmbuf_read() returns a pointer to the data directly
-		 * in the mbuf (when the mbuf is contiguous) or, otherwise,
-		 * a pointer to temp_data after copying into it.
-		 */
-		ret = pcap_sendpacket(pcap,
-			rte_pktmbuf_read(mbuf, 0, len, temp_data), len);
-		if (unlikely(ret != 0))
+		data = rte_pktmbuf_read(mbuf, 0, len, temp_data);
+		RTE_ASSERT(data != NULL);
+
+		if (unlikely(pcap_sendpacket(pcap, data, len) != 0)) {
+			/* Assume failure is backpressure */
+			PMD_LOG(ERR, "pcap_sendpacket() failed: %s", pcap_geterr(pcap));
 			break;
+		}
 		num_tx++;
 		tx_bytes += len;
 		rte_pktmbuf_free(mbuf);
@@ -511,7 +522,6 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
 	tx_queue->tx_stat.pkts += num_tx;
 	tx_queue->tx_stat.bytes += tx_bytes;
-	tx_queue->tx_stat.err_pkts += i - num_tx;
 
 	return i;
 }
-- 
2.53.0

