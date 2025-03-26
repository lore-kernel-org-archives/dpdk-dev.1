Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A50EC3600E
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 21:36:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 215D140664;
	Wed, 26 Mar 2025 22:36:25 +0100 (CET)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id 46DEF4021F
 for <dev@dpdk.org>; Wed, 26 Mar 2025 22:36:22 +0100 (CET)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-22401f4d35aso7792445ad.2
 for <dev@dpdk.org>; Wed, 26 Mar 2025 14:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1743024981;
 x=1743629781; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XScZePCdkDVrAPeLWXTrXRl/ZrrnVo3aLJ71gV+MTcc=;
 b=b8h5tdIAVon5HuZDXhwweGqykaj5ZAXBeh1fxTbB65n6u3hjEkyXM/OyDMdSRf9hO3
 R7bULIXSFIs0vMoe46z2RVJUa8K2WnWG8xYv+LF4kPUDGDhc6KpT8n9iNtYyF3KTH7nJ
 Cz56AYkfnZYhYC42hqpNePXVTI5/dhrOAhjD8sg8PYvHHM5jSDDDG8TDJOI8qnjLXA3j
 eUTRScBENk9VYSG8rHrWmeVESXIzCl9KHTQLR6f6nxwmr7Q3gwzTs8piZJ8NGkNMigFg
 6fcyfHl57fHRDs10pnACjJsMPDtOSWD+a8AzZKSyhj7O06JemlswX6H1nM/7zQhdtvnY
 wJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743024981; x=1743629781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XScZePCdkDVrAPeLWXTrXRl/ZrrnVo3aLJ71gV+MTcc=;
 b=g+5p/4mb8RudbSOWd3RsGD71cMReTEFvnB2i5s25b2ZOCtge79ABi6tsKTqELA+fkP
 O5TJ4JP8aesoXpSjytPDRgYIPcIy27PznRlOQKlUYYLTWu9Mg9raCpIMXZQe3StrTjy4
 f8l4zkqNIcM1NIe1fiRyOtSr62IC89zDOoQ4++p0/99+a+g2D7dBgmvwmnA3szYypQhf
 W64rTQImO4q5Fv1G/bxZZ7cfc8vAp0AoxN0GlqLonu4Jd1gYIxK0hsnb1MjhRAwwyshm
 LAHIa+JTpSbabelnxfOVoEP5HYHtiBOhGRDLPYtLekwAGQmtWon8P+nCMm4zeGXZw5xY
 3ltQ==
X-Gm-Message-State: AOJu0Yyldf3LQVIBoRq8eBdW0QUO2xoMFz1tRNMjnBvH4y/1d3vmNc3+
 MLUxb15rbWhSF4AVnDxR3wr6KfTfN/FAxBEts4AiEJB6oS2J7UotCSbJhQgxwMr0qyzYmtDemMV
 g
X-Gm-Gg: ASbGncuqNzAnvuVxranINmHHS3rqPZvb6SAf59VPBxBT30DS8ko39CGT4aufoc7ZzJO
 44f9r1XEhNTO/O/qoPh1MvUEHJxvW/9+QyMsXvMlp/Z1x+CG5hnfZcNT9DfULLAibxQC78q7Gcd
 QkPcy5YvpgsAxuDkmfZwaoNbjHxlHqr0JEXToTDa21zlgUqF3EkY/gDI9tNiZRLoFh/ViDpDcDr
 nidyb5cMcG6ltuVLvRCoZ5yVuvjVo8vgpnSQbyo7kc3167msF2Qz/REH4DVI3iCdt2JkT+AXDp4
 NrvbJo8UlDbMKoTudE+Yy4lgiIn504OPbCe05QImChx8qtkv6zaiy4gwzlD1zD+GIPjFh1R19jc
 N4sHcoatgbUZ8ih7f0cZF
X-Google-Smtp-Source: AGHT+IHowPDWEDnX7Io1ceh9e+AWQlwlXPLF8bo/miKcVGgcVdd+4gLhcBMKB5R5CEMmIsTmRmfU4w==
X-Received: by 2002:a17:902:fc4b:b0:227:e82b:b585 with SMTP id
 d9443c01a7336-228048b3038mr15417165ad.20.1743024981403; 
 Wed, 26 Mar 2025 14:36:21 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f4597csm115807525ad.75.2025.03.26.14.36.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 14:36:20 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tetsuya Mukawa <mtetsuyah@gmail.com>
Subject: [PATCH 3/4] net/null: optimize Rx
Date: Wed, 26 Mar 2025 14:35:27 -0700
Message-ID: <20250326213608.581345-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250326213608.581345-1-stephen@networkplumber.org>
References: <20250326213608.581345-1-stephen@networkplumber.org>
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

No other rx_burst function checks args, remove it.

Since rx_burst can only safely be called by a single thread
at a time, there is no need for atomic operations on statistics.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/null/rte_eth_null.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/net/null/rte_eth_null.c b/drivers/net/null/rte_eth_null.c
index baae81c572..7ac29b3f81 100644
--- a/drivers/net/null/rte_eth_null.c
+++ b/drivers/net/null/rte_eth_null.c
@@ -37,7 +37,7 @@ struct null_queue {
 	struct rte_mempool *mb_pool;
 	void *dummy_packet;
 
-	RTE_ATOMIC(uint64_t) rx_pkts;
+	uint64_t rx_pkts;
 	RTE_ATOMIC(uint64_t) tx_pkts;
 };
 
@@ -88,9 +88,6 @@ eth_null_rx(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
 	struct null_queue *h = q;
 	unsigned int packet_size;
 
-	if ((q == NULL) || (bufs == NULL))
-		return 0;
-
 	packet_size = h->internals->packet_size;
 	if (rte_pktmbuf_alloc_bulk(h->mb_pool, bufs, nb_bufs) != 0)
 		return 0;
@@ -101,10 +98,8 @@ eth_null_rx(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
 		bufs[i]->port = h->internals->port_id;
 	}
 
-	/* NOTE: review for potential ordering optimization */
-	rte_atomic_fetch_add_explicit(&h->rx_pkts, i, rte_memory_order_seq_cst);
-
-	return i;
+	h->rx_pkts += nb_bufs;
+	return nb_bufs;
 }
 
 static uint16_t
@@ -114,9 +109,6 @@ eth_null_copy_rx(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
 	struct null_queue *h = q;
 	unsigned int packet_size;
 
-	if ((q == NULL) || (bufs == NULL))
-		return 0;
-
 	packet_size = h->internals->packet_size;
 	if (rte_pktmbuf_alloc_bulk(h->mb_pool, bufs, nb_bufs) != 0)
 		return 0;
@@ -129,10 +121,8 @@ eth_null_copy_rx(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
 		bufs[i]->port = h->internals->port_id;
 	}
 
-	/* NOTE: review for potential ordering optimization */
-	rte_atomic_fetch_add_explicit(&h->rx_pkts, i, rte_memory_order_seq_cst);
-
-	return i;
+	h->rx_pkts += nb_bufs;
+	return nb_bufs;
 }
 
 static uint16_t
@@ -326,7 +316,6 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *igb_stats)
 			RTE_MIN(dev->data->nb_rx_queues,
 				RTE_DIM(internal->rx_null_queues)));
 	for (i = 0; i < num_stats; i++) {
-		/* NOTE: review for atomic access */
 		igb_stats->q_ipackets[i] =
 			internal->rx_null_queues[i].rx_pkts;
 		rx_total += igb_stats->q_ipackets[i];
@@ -360,7 +349,6 @@ eth_stats_reset(struct rte_eth_dev *dev)
 
 	internal = dev->data->dev_private;
 	for (i = 0; i < RTE_DIM(internal->rx_null_queues); i++)
-		/* NOTE: review for atomic access */
 		internal->rx_null_queues[i].rx_pkts = 0;
 	for (i = 0; i < RTE_DIM(internal->tx_null_queues); i++)
 		internal->tx_null_queues[i].tx_pkts = 0;
-- 
2.47.2

