Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43462F8D755
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 18:48:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A0B0240A71;
	Thu, 16 Apr 2026 20:47:53 +0200 (CEST)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178]) by mails.dpdk.org (Postfix) with ESMTP id CF8F140A6B
 for <dev@dpdk.org>; Thu, 16 Apr 2026 20:47:51 +0200 (CEST)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-2bd9a485bd6so16362419eec.1
 for <dev@dpdk.org>; Thu, 16 Apr 2026 11:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776365271;
 x=1776970071; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U8qlHnaWL3xA7pIAnsegSiJnseUdbksPPijuwVzzW1s=;
 b=fTJdsplJQpZ3l9VX2Y+YceJGj4h3IsBcmooy/9knWBD3bOObfCNqkZcNi7pA4E9lga
 W/akVk/i1saZ0TFQENac9uD7POayPNtt6Bzw/FrnkAtasZR0PuFscd9gc4zhaih91dt2
 N2sRrk3takbvfj8Qi8Tc92Ds1GCMZxCeoyYjZVD4qAzCx2lmUC2YpHknbnFjPhopbDHT
 +e8wee/rOXyoxs1YKSk3JCsW1Yb5G5o1V6LzlB7t62wJ1qcoBHJlDCVSuqIuJqEwREKN
 dLHKRDnrIdvJhoKfFV8Uv3EyG2tnK3NYe5n0akXhyJUL3L3E2no9knI/JSioG1lj6rCv
 cp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776365271; x=1776970071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U8qlHnaWL3xA7pIAnsegSiJnseUdbksPPijuwVzzW1s=;
 b=PFLiRvoeqXMjWdCZJKSiTZMD4VqrkMMhtiGJfpX43BYcV13TPyQCGTVPE7W6l2uKXx
 +o3qgzU8JnSC4LoeGKmwPhFzKjIxWezw1sQqBK9c3hwOJLJ/kzIUAltluLG+EC59vpVp
 srAbTPrpdOHdtM75heuIRyb+fc+sz8S9py6rOm7OJ2e75wqRfnix9SyCBhtMVXbE75Ai
 2zNUtXpzZkouYsrfQcai0GmMKPwmrO6vx2P9f3sBwNsZHFwJH2BLtB2mGlhh61Uu+TkF
 jTYYN48LbTeRCS0S7VIOQ0qFoAOdggKHAD2SX2CpqJTTIxIh5dXYXTrqiKgoYfeGo7ow
 /zDQ==
X-Gm-Message-State: AOJu0YzdzUwgTGUi1/i661idv5USRw3hAkhsl1KBn5hlO1tIHWoVMDu3
 hGffm5j8MINx2wrFFEIe1hoL95o5eGm0af5G5gGGhNltXjJpWOve7KAm1EfmOZCa1b0TTBYiVM6
 aorGN
X-Gm-Gg: AeBDieuoESij42D6bd+hxwXajtCIaYVq4f4yh5yJeuO9ffZpmjfERdrKbc24392/pCh
 gzZ3y394KclRcwjN2UCvAuFUZ9Sd9q/z8yltkRrfVXDUD0Ol+zhXMcxiOpIQA8x5aYIKhHXzKwM
 nqXv+PuNYi28ovoLG88CdHg3IEZ+A/X+aJWm2lqjDdd183tDNzLbHPGb5imj7eZF0ie8f6fXPAP
 hvta/7cBdhK53WbIMp3kpks1Gr0CKzCN2oiF9jIG8hfSFiKKeeROpDafvOhiGgxgMFrAjleHmNq
 oAghZx9UZEu3zDmRMeT5z37CRqsZnzCvXNt7cD6ag/GEe0GWAx66Yg1Sk5zE/CYJT1XSyiWanBJ
 iTUXnczjB5ubLg1/D9iREzTD/vLgi4BmetMmlclQLPK02NFSraGXMQ/t3+0ioALep7t5QviGCc4
 +WxmBblV0AA6B3Wy6rnF3ARmHTs4o6avmpZvnlJdS/CJE=
X-Received: by 2002:a05:7301:4003:b0:2d9:ad46:4a92 with SMTP id
 5a478bee46e88-2e2e561007fmr243122eec.13.1776365270911; 
 Thu, 16 Apr 2026 11:47:50 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8c606222sm10741314eec.8.2026.04.16.11.47.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 11:47:50 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Ferruh Yigit <ferruh.yigit@amd.com>,
 David Marchand <david.marchand@redhat.com>
Subject: [PATCH v24 09/24] net/pcap: fix error accounting and backpressure on
 transmit
Date: Thu, 16 Apr 2026 11:45:31 -0700
Message-ID: <20260416184731.1347342-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416184731.1347342-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260416184731.1347342-1-stephen@networkplumber.org>
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

