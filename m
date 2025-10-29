Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C060DCCF9EB
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 23:54:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8AFF24029C;
	Thu, 30 Oct 2025 00:54:05 +0100 (CET)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id 3EB6A4027A
 for <dev@dpdk.org>; Thu, 30 Oct 2025 00:54:04 +0100 (CET)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-290b48e09a7so4909555ad.0
 for <dev@dpdk.org>; Wed, 29 Oct 2025 16:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761782043;
 x=1762386843; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WS90TD551YbPJu2e4fw1f9hbgcr3Vtx2XUUt/dStqvM=;
 b=Dcj8S3kdrQDAziKIg/fbtzttvcdQQuanTjdH/BRKMEiO+yt8ETVujccT4lahTStpev
 EhyYapB5jp4/CDIgupq8E5PPE//Go+eLqnZr4eczkOc+gb30SK/nypYm0VyIc+xdinNi
 84qmzaOEokgX7sdatVMCxPzb1U2gLjA3IsDeiYMjq8BuuWS1FGH6sSWHVWrLOdsytwMs
 l1siLYq4mAjaTXm0w991Be8nBjfKFtx8Evb0nq93jQYYlUYqN5dq1paNVsMDV4ofTOE1
 e+AErrGTNid33tu3vporVr0lW9GChyC1uUPaGDdvXg79EO6hDNPaQFg3BjfPJs/F1ZIB
 9RRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761782043; x=1762386843;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WS90TD551YbPJu2e4fw1f9hbgcr3Vtx2XUUt/dStqvM=;
 b=CFPmVDXyK7XUD+DQId7YTwerwDnhks/jD3C1uifcGVNo9SYNgkEpaeT8wIAjgruhLN
 zDQKcwVlcOisCfpxmKMJPSmXcJY48acsBmIW3KJVwWrIL5t1IJnos4uQoeHcw/eSGGS7
 LfI2Xgf6ymSi5xoWZaFP3cNLhWsRYG9WrvoWvahHo009fCUk8NqcRvWegup3tNCc8pZS
 O6XZ4iRIju74LNv6VG3JRSje6eKNwkLrmBFW9CydwVLoXEtdFa7kYqCVaQ39mt61YS4J
 PkEAhsxMiGJIh3BEla3/8sAfS3XVaL3v1+EyP/OLUMhOUv2tRfx/+1+On1PNZm/p0YHi
 D6ew==
X-Gm-Message-State: AOJu0YxZYGkCx7/4Bhsa3mKHt4z0N7kTn4ejW9wLBK+8bTAa/sUSVqUz
 uZjsresaPyU2BK90e0Xg7nGUaxlCda3MDtikzm7vChT3o2omeewAVl3PWiggtd6LRLvsnJf5qkX
 oYZT3
X-Gm-Gg: ASbGncvZL4CqPwlDFBZfBvZbyH+guMP/lnFEtt52vfuLOUhPTb0gbBWxpnn8xsREcRb
 vCuAmf/gJK5yfPT7I8oVNHfEHHwIkPypH81l9fdYnwCUDZUBLvDvaVFTle7xs7dab3nG2I+NYDh
 jaPuE2mBq4RoYMutzKkiYZQ95m/Fa008O3Tz5isx45lYBm51JBO6CZ3cO5TY6ROCDzMH23jD7g0
 x0IRAENFvmVXpHNqs8maa0nwky1QjfHE6dGgBynMF/ZsihFwtBjWBiCF+BLtdwVdmJcnMVjOdvV
 UYPDg1OFPbEBjTV76bjqMI1r4+HwEzFv5cG6g0M9o/bZItRft8INirT2Kdf3ekB0ZTnFcI9J7cd
 w5tLHGtJY4/S4j7j+8pt1YtPSea4bLr2RXEsn/B7+88E1iEOOCK8gENl8ZHQNIpKCtD5x7N9itZ
 qXwY0KpOmgMAuubzZsQVfhOsE5C2vCLIW5DTNUHcY=
X-Google-Smtp-Source: AGHT+IEgCGUka98yOQ2D7qrJb2nijMnoXKReLo34OtLFhgFlGSMT5qkAta24omApNFOZ1YcnF0ZU0Q==
X-Received: by 2002:a17:902:e892:b0:290:9ee2:cfb0 with SMTP id
 d9443c01a7336-294dedf47e8mr61747915ad.15.1761782043049; 
 Wed, 29 Oct 2025 16:54:03 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29498d40de4sm167435335ad.77.2025.10.29.16.54.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 16:54:02 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, bruce.richardson@intel.com,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 John McNamara <john.mcnamara@intel.com>
Subject: [RFC] ethdev: fix UAF in rte_eth_tx_burst with filtering
Date: Wed, 29 Oct 2025 16:54:00 -0700
Message-ID: <20251029235400.1486861-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
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

When packets are filtered by Tx callback, they return value
needs to include those packets; otherwise the application will
do a duplicate free of those mbufs.

The example would be application that sent a burst of 8 packets,
and 2 were filtered but the PMD was busy and could not send any.
The result should be a return value of 2 and mbufs 0..1 should
be freed and 2..7 should be untouched and up to application to
resend or drop.

Original buggy code would return 0 and 0..1 would be freed
2..7 would be unused. Application would then try and drop
or resend an already freed mbuf.

Bugzilla ID: 1816
Fixes: 4dc294158cac ("ethdev: support optional Rx and Tx callbacks")
Cc: bruce.richardson@intel.com
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ethdev/rte_ethdev.h | 47 ++++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index a66c2abbdb..d2cfe390f9 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -6714,6 +6714,10 @@ rte_eth_tx_burst(uint16_t port_id, uint16_t queue_id,
 	}
 #endif
 
+	uint16_t requested_pkts = nb_pkts;
+	uint16_t filtered_pkts = 0;
+	rte_mbuf_history_mark_bulk(tx_pkts, nb_pkts, RTE_MBUF_HISTORY_OP_TX);
+
 #ifdef RTE_ETHDEV_RXTX_CALLBACKS
 	{
 		void *cb;
@@ -6727,22 +6731,41 @@ rte_eth_tx_burst(uint16_t port_id, uint16_t queue_id,
 		cb = rte_atomic_load_explicit(&p->txq.clbk[queue_id],
 				rte_memory_order_relaxed);
 		if (unlikely(cb != NULL))
-			nb_pkts = rte_eth_call_tx_callbacks(port_id, queue_id,
-					tx_pkts, nb_pkts, cb);
+			filtered_pkts = nb_pkts -
+				rte_eth_call_tx_callbacks(port_id, queue_id, tx_pkts, nb_pkts, cb);
 	}
 #endif
 
-	uint16_t requested_pkts = nb_pkts;
-	rte_mbuf_history_mark_bulk(tx_pkts, nb_pkts, RTE_MBUF_HISTORY_OP_TX);
-
-	nb_pkts = p->tx_pkt_burst(qd, tx_pkts, nb_pkts);
-
-	if (requested_pkts > nb_pkts)
-		rte_mbuf_history_mark_bulk(tx_pkts + nb_pkts,
-				requested_pkts - nb_pkts, RTE_MBUF_HISTORY_OP_TX_BUSY);
+	uint16_t sent_pkts = p->tx_pkt_burst(qd, tx_pkts, nb_pkts - filtered_pkts);
+	uint16_t result_pkts = sent_pkts + filtered_pkts;
+
+	if (unlikely(result_pkts < requested_pkts)) {
+		uint16_t unsent_pkts = requested_pkts - result_pkts;
+
+		if (unlikely(filtered_pkts > 0)) {
+			/* Need to reshuffle packet list so that unsent packets are
+			 * after the return value
+			 *
+			 * Original: MMMMMM
+			 * Filter:   MMMMMF filtered = 1
+			 * Tx_burst: SSSUUF sent = 3 unsent = 2
+			 *
+			 * Return:   SSSFUU
+			 *   return from tx_burst is 4
+			 */
+			memmove(tx_pkts + result_pkts, tx_pkts + sent_pkts,
+				unsent_pkts * sizeof(struct rte_mbuf *));
+
+			/* Tx filter process does not drop the packets until here */
+			rte_pktmbuf_free_bulk(tx_pkts + sent_pkts, filtered_pkts);
+		}
+
+		rte_mbuf_history_mark_bulk(tx_pkts + result_pkts, unsent_pkts,
+					   RTE_MBUF_HISTORY_OP_TX_BUSY);
+	}
 
-	rte_ethdev_trace_tx_burst(port_id, queue_id, (void **)tx_pkts, nb_pkts);
-	return nb_pkts;
+	rte_ethdev_trace_tx_burst(port_id, queue_id, (void **)tx_pkts, result_pkts);
+	return result_pkts;
 }
 
 /**
-- 
2.51.0

