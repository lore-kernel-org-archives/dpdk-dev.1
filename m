Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AF1F9D0DA
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 16:11:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 942AC40689;
	Tue, 14 Apr 2026 18:10:28 +0200 (CEST)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com
 [209.85.167.172])
 by mails.dpdk.org (Postfix) with ESMTP id C67FB40684
 for <dev@dpdk.org>; Tue, 14 Apr 2026 18:10:25 +0200 (CEST)
Received: by mail-oi1-f172.google.com with SMTP id
 5614622812f47-4648447e29bso1651137b6e.0
 for <dev@dpdk.org>; Tue, 14 Apr 2026 09:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776183025;
 x=1776787825; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U8qlHnaWL3xA7pIAnsegSiJnseUdbksPPijuwVzzW1s=;
 b=gtaFhdZkLIAEHLd0zRLhNnVUG2SF8PIImY0KvvxG1OlRO+P9Tgsffj5us8DzaopYiE
 g2VZgK8JN4UJqavIVwTFUUHD+CkFGSC8Hzz7ykghq14syNckVMAP5ZMG27rr5pnBtXW1
 GF4M7urO7Qs1G0hPN/y/MctVKTHaW2RwRLcBCOF0IaebWPCo/Pgc0LQDdYRfkLkjeuvS
 rDuxLS+GyL9/2b+NTxM0lYS7Bu7e4N5yHSJibu/0o7vciEGhDMWeBSMhtCfftEiR7W80
 iUHY6KTx18iJXX5ZkTngRk5lOhyEBPqtmZFk/HrvclTOjgn2PM1qwzu225a6bG+/BSAu
 AdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776183025; x=1776787825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U8qlHnaWL3xA7pIAnsegSiJnseUdbksPPijuwVzzW1s=;
 b=qLp3DdwUrwnnRyQLdrCOIHwIFJnmw03U2QKqHWWtra9TC/Lsm315jPlhQMxCf8cbeL
 8UKVrc09OaXeUsI4Z2MWB0r3G7iiLt+bB+TD1GE5I6tKRkaUZTaBl4lT4yWqUTSavOiu
 Q9mvOOTqgP0ZysKJiHTDcztAUMCM1nWaBLb7Au2298b6PTejmhF1RsgKQ1e18h8vqAZQ
 wBWWyLVHJ/fYe/4PZJQ2XG5zPXJhVPg23ahMgrAk4xKKEQUgb5+gzKtPUV24fU6FoVHJ
 oOQyw4Qo47xq2IbGHoX+GKY7GTJbJ+nXYIwMKB4KlN/WFqxrpfbcplCXH3l0/tDURZSw
 MiCg==
X-Gm-Message-State: AOJu0Yw2zfhW81h39+YhegJMM/R/pjyykGcCe3EPLFmGamLaalRoqS7y
 KFQji8lpniUoDFki496Eg42jpMyWJkDz2UmpoNJqZKhm27N8ZlpVzkZbr1zNaL79FBHOKTI+UKT
 nMGy3
X-Gm-Gg: AeBDies0hWXO2y2RwTXw4hokhOrbspAkG8OlWlVuKFvQZDoHwT9ek5YS72MAJLnyib+
 VGG1P5hBIy6BV4ACO7vNz1VpZ2csjYKZNEWxUK5Bspw/G7eyk6UdkBIdP21UwFyBX1FtPGBucSj
 uJNwC13gC/GxIocsbIioNIv5LtiiZXS5yo2m0ZBLbdURrTVBRhOKqe1eq/I/4J97bJifNOZBaEq
 3FqtsAN2VDSDHZmBX5zP9pmYesBVwjexhQblD6h85fQl9bZpM/WwXiu+jbPJ3t5Vkg7Zq/dioVj
 mDYjlWFdisVruDh10rpScUCPq8ShmdGL6iUX4GDY0nYJN0aQ5HAxL53FQvBYNZhPM1nmhJvQKbZ
 siDZkRJIQfDb8WO+r9094mf/YIZUPw9sNUIuLSq2GnY3c71DnQ1MAZbXB5zH6KpavUOG3y6w7er
 X2TEbB83AU9y8O0e6lQ6ZGok1du73tkDA0/s1BT51zlSY=
X-Received: by 2002:a05:6808:192a:b0:45c:8f03:1e18 with SMTP id
 5614622812f47-4789f40f64fmr8895794b6e.44.1776183024969; 
 Tue, 14 Apr 2026 09:10:24 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423dd396960sm11809554fac.2.2026.04.14.09.10.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 09:10:24 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 David Marchand <david.marchand@redhat.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v22 09/24] net/pcap: fix error accounting and backpressure on
 transmit
Date: Tue, 14 Apr 2026 09:08:00 -0700
Message-ID: <20260414161011.756101-10-stephen@networkplumber.org>
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

