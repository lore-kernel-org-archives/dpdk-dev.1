Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB56ACCD195
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Oct 2025 16:57:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC33042DCE;
	Sun, 19 Oct 2025 18:57:37 +0200 (CEST)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id D639D410F1
 for <dev@dpdk.org>; Sun, 19 Oct 2025 18:57:34 +0200 (CEST)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2698d47e776so26667705ad.1
 for <dev@dpdk.org>; Sun, 19 Oct 2025 09:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760893054;
 x=1761497854; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QpFwMpjjpWhm9/3oSxBY7IrnOg8PAjv60ibsMe/RgpM=;
 b=QiJ+woCUEVwhbTqL13S0NR8yVK2RnrazkaiP7oByfwvJ+Jxs7huo1Wwd2BL8oRX2T/
 h2G6wIAo11es7/5Llvi1QjfLHGyyusqT+WIC+JQqFlt3Raz0oxXUCH2tf50kaANfOnSa
 ZK4FTaWcYdSIdw6MGgyYUWj9DDdYlSgf81ihNoUyWOjwR79u+RCf08kcBuSRLVkFBTji
 8fXs7h1IMP8tMeWdbwxkY53Rp6OFH7UJePGFeFPsMuoGZo8mtHPrUzz2EyF7yZ2uXJLH
 jSRO670hFF2Oy6+s5j/SBfYn+du7c26Hgvgbxm+KKGCqUkOZyiyFdeO47yNBjO2D5Crw
 V/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760893054; x=1761497854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QpFwMpjjpWhm9/3oSxBY7IrnOg8PAjv60ibsMe/RgpM=;
 b=L5GbXODp13i8WzDVrQCv9DtbGuZxBREtkj1NWjMTAgJ+0RMtJBYCtgbzjWHVU6cf9e
 JIH/PDPFPGe6JFKqxOpGDRRHnXZ5Fr+iml9aZAnICIqfWuFKBEL7gJf9hZ49rJKJXG88
 VUjnIuZeaGclC+tuN/shiWlFcxmcUk1TcKH8khVyA3eecAZYAXxs8sMsp1Mh3n9Q6BQi
 RZLNGZR2yXa/QnU3QmhMDDcysBJpV2ZBuVLOopXSxPtIeSiQgOA2mHoRHPDWVvKMQf+Y
 oblerz4g6V18m1tpgAPU+itUdUQjICg546C9h0MsKJnfPU5TR+JqMBZNYZUQirypachj
 lZlw==
X-Gm-Message-State: AOJu0YzRhSm4STSydTFFcROEEid5jBeOb4Sbt5X6vJzVKT4VVpJhz9Cw
 nOT6yy9arAfVrbfnN7TDn7Kzh9/VlYTXAXYHFlAfhPAQP6roILmwLtRBW3qo1B8ivwbhigagUn2
 02cJevdg=
X-Gm-Gg: ASbGncsFtcN0wvUTvBTsa/c8n2KuBYhNXCcZ1hy/EB/WYrVIKs6zkNGZfKp/Q34FCZY
 1eod0VfkU6d5HWmoSfV6YA24K4E7UdiBbcOwSs4BjWbxH7TvZ+YKNCY71PtJ78XiAGWp2+InO2X
 19XZQwQuW6ImnpJA2OBrIQ1WwuKAntxP+P8WrIfJ+kouvAW30FUeV0dLehpilx8T4EMbNRAkzcM
 I6YLIhOsWuXHyDejWym1jV/blSDoohQrYXhYkJbHXF+NkdeGvb3SLW/bE3u//SZ9N6Fe+7V63sm
 Hobz16fM3K0iOuJkNcqZVdsT6mS0wpiVbv030iRyQZ7j/q0eoqhYzZw2ej7rbS5lzb99cP8KQpY
 Nx0qTGNtSbcOQm9o4Blgfz/03C7BBN8g1igV0816Or3ae0HPGVgIw8DwewOq3wpHx4A5rIGsDe0
 OPSKPYI5zKLqK+zh+YAFtYHTNc4O4rsP9oj73XXcg=
X-Google-Smtp-Source: AGHT+IHdy/QIxkZ9KKFF7cwpIeb8aXRbldiTB0vGAoGYZavq2hR27cLlXGx8js/auoej20kwmJyDfQ==
X-Received: by 2002:a17:903:3d0d:b0:24f:8286:9e5d with SMTP id
 d9443c01a7336-290d14e83ddmr121278355ad.26.1760893053943; 
 Sun, 19 Oct 2025 09:57:33 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2924721b6fdsm56940455ad.118.2025.10.19.09.57.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Oct 2025 09:57:33 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v3 3/8] pdump: fix races in callbacks
Date: Sun, 19 Oct 2025 09:56:10 -0700
Message-ID: <20251019165728.164929-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251019165728.164929-1-stephen@networkplumber.org>
References: <250811213632.16023-1-stephen@networkplumber.org>
 <20251019165728.164929-1-stephen@networkplumber.org>
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

The pdump callback can race with other cpu's in the datapath.
Handle this by using reference counts and LSB in manner
similar to seqcount and bpf code.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/pdump/rte_pdump.c | 48 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/lib/pdump/rte_pdump.c b/lib/pdump/rte_pdump.c
index ba75b828f2..bfd63fa8c2 100644
--- a/lib/pdump/rte_pdump.c
+++ b/lib/pdump/rte_pdump.c
@@ -12,6 +12,7 @@
 #include <rte_memzone.h>
 #include <rte_errno.h>
 #include <rte_string_fns.h>
+#include <rte_pause.h>
 #include <rte_pcapng.h>
 
 #include "rte_pdump.h"
@@ -62,6 +63,7 @@ static struct pdump_rxtx_cbs {
 	const struct rte_bpf *filter;
 	enum pdump_version ver;
 	uint32_t snaplen;
+	RTE_ATOMIC(uint32_t) use_count;
 } rx_cbs[RTE_MAX_ETHPORTS][RTE_MAX_QUEUES_PER_PORT],
 tx_cbs[RTE_MAX_ETHPORTS][RTE_MAX_QUEUES_PER_PORT];
 
@@ -78,6 +80,36 @@ static struct {
 	const struct rte_memzone *mz;
 } *pdump_stats;
 
+static void
+pdump_cb_wait(struct pdump_rxtx_cbs *cbs)
+{
+	/* make sure the data loads happens before the use count load */
+	rte_atomic_thread_fence(rte_memory_order_acquire);
+
+	/* wait until use_count is even (not in use) */
+	RTE_WAIT_UNTIL_MASKED(&cbs->use_count, 1, ==, 0, rte_memory_order_relaxed);
+}
+
+static __rte_always_inline void
+pdump_cb_hold(struct pdump_rxtx_cbs *cbs)
+{
+	uint32_t count = cbs->use_count + 1;
+
+	rte_atomic_store_explicit(&cbs->use_count, count, rte_memory_order_relaxed);
+
+	/* prevent stores after this from happening before the use_count update */
+	rte_atomic_thread_fence(rte_memory_order_release);
+}
+
+static __rte_always_inline void
+pdump_cb_release(struct pdump_rxtx_cbs *cbs)
+{
+	uint32_t count = cbs->use_count + 1;
+
+	/* Synchronizes-with the load acquire in pdump_cb_wait */
+	rte_atomic_store_explicit(&cbs->use_count, count, rte_memory_order_release);
+}
+
 /* Create a clone of mbuf to be placed into ring. */
 static void
 pdump_copy(uint16_t port_id, uint16_t queue,
@@ -146,11 +178,14 @@ pdump_rx(uint16_t port, uint16_t queue,
 	struct rte_mbuf **pkts, uint16_t nb_pkts,
 	uint16_t max_pkts __rte_unused, void *user_params)
 {
-	const struct pdump_rxtx_cbs *cbs = user_params;
+	struct pdump_rxtx_cbs *cbs = user_params;
 	struct rte_pdump_stats *stats = &pdump_stats->rx[port][queue];
 
+	pdump_cb_hold(cbs);
 	pdump_copy(port, queue, RTE_PCAPNG_DIRECTION_IN,
 		   pkts, nb_pkts, cbs, stats);
+	pdump_cb_release(cbs);
+
 	return nb_pkts;
 }
 
@@ -158,14 +193,18 @@ static uint16_t
 pdump_tx(uint16_t port, uint16_t queue,
 		struct rte_mbuf **pkts, uint16_t nb_pkts, void *user_params)
 {
-	const struct pdump_rxtx_cbs *cbs = user_params;
+	struct pdump_rxtx_cbs *cbs = user_params;
 	struct rte_pdump_stats *stats = &pdump_stats->tx[port][queue];
 
+	pdump_cb_hold(cbs);
 	pdump_copy(port, queue, RTE_PCAPNG_DIRECTION_OUT,
 		   pkts, nb_pkts, cbs, stats);
+	pdump_cb_release(cbs);
+
 	return nb_pkts;
 }
 
+
 static int
 pdump_register_rx_callbacks(enum pdump_version ver,
 			    uint16_t end_q, uint16_t port, uint16_t queue,
@@ -186,6 +225,7 @@ pdump_register_rx_callbacks(enum pdump_version ver,
 					port, qid);
 				return -EEXIST;
 			}
+			cbs->use_count = 0;
 			cbs->ver = ver;
 			cbs->ring = ring;
 			cbs->mp = mp;
@@ -218,6 +258,7 @@ pdump_register_rx_callbacks(enum pdump_version ver,
 					-ret);
 				return ret;
 			}
+			pdump_cb_wait(cbs);
 			cbs->cb = NULL;
 		}
 	}
@@ -246,6 +287,7 @@ pdump_register_tx_callbacks(enum pdump_version ver,
 					port, qid);
 				return -EEXIST;
 			}
+			cbs->use_count = 0;
 			cbs->ver = ver;
 			cbs->ring = ring;
 			cbs->mp = mp;
@@ -277,6 +319,8 @@ pdump_register_tx_callbacks(enum pdump_version ver,
 					-ret);
 				return ret;
 			}
+
+			pdump_cb_wait(cbs);
 			cbs->cb = NULL;
 		}
 	}
-- 
2.51.0

