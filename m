Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C28CD98F8
	for <dpdk-dev@archiver.kernel.org>; Sat, 20 Jun 2026 02:32:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37CEC4067C;
	Sat, 20 Jun 2026 04:31:48 +0200 (CEST)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com
 [209.85.128.169])
 by mails.dpdk.org (Postfix) with ESMTP id E351140677
 for <dev@dpdk.org>; Sat, 20 Jun 2026 04:31:45 +0200 (CEST)
Received: by mail-yw1-f169.google.com with SMTP id
 00721157ae682-7ff05e5d009so28231897b3.1
 for <dev@dpdk.org>; Fri, 19 Jun 2026 19:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781922705;
 x=1782527505; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=139gzksGNvb60vjMHCV5bmGXdpR7VUEdRflMop0rtSU=;
 b=fqmVm9injWMa9p7+cfp9PxH+WchWC0NdhKR+KEXHpWWTmB3cX/FbFiXBGv/TYbTrhK
 M2YIcOjdfC6s5heiiGVfIMvd5qCyMvlUua4kDIC3rEfDgG3giBpPHCJpMSc/i57etmPn
 PBLgdkteJ9+qkBNjZzVyweoqiQRzHdkxTC5x+2no2E6Z1pevCsP7U7BiORRbZgOYrxmn
 maAIO7VQFlSJBOg6a/6ApwhTgUQ7xYx01Aefn9WKfp3w6jWqOTBiF5HpbrZrxZeHxOd3
 ZaR+noQ1claRUrjxAz7cRL8YN73N/gAIxTAWf1uau1xOUjJDbYOzzKAvGpQrFe37QSut
 7x4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781922705; x=1782527505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=139gzksGNvb60vjMHCV5bmGXdpR7VUEdRflMop0rtSU=;
 b=rMicjdf2jY5KryyQedv22Z6xYQIges6+kNeRFfw2RqcQ0z+vUcgPCVAmGD4Xxso6Kk
 UcKbiJ7cxJXkgeKtUM1HRtLBHCdByw0AgbJF6qrYu9A6u4kU07LXwadhIsDfftsUS7e5
 Bt541LGFE2KWE9WcQ9zl1m/vWYx2QTgZxQdFP4I3+5XrbSe3zFDWGqvUhR4+dwReLvtl
 Po91gLdnNcLEhD/pMN9Zy9z5yzMUA3YoocYUmIylpUMbs89zEdPNxhhe12jfLyrmEKMU
 d74sy7TDV9xmnq5r3iuAZSXIwElgR8/SLDfPEP/gafKxZ/qAeDU9/YbHUDLPQB38bPY4
 42Lg==
X-Gm-Message-State: AOJu0YzVdR1sEw2/oCkZgDteVqaLVeO3awt8HPrGdzkoCQAAD9ZCHc2P
 Gp2QtFv7uoRdS/3KskvigOwusjCNfsxHA9z+g7FDXYMu2qCF9YuNwVpTqLd5zUfdYuQkURdhSgu
 IHjdL
X-Gm-Gg: AfdE7cmPCgQcCok0gaViXZhbJVzlWIsXupDAIAqDxdDajYpUQT8OlS2cJiND3kbt/6k
 sny8A0M5kBv8S0qAIXYHEE0O41ZvX1lhpwi1yGC9zDdc28+so35AvK0t/s2SuDPS+7FoiOuhNWG
 1mxmUZ/eTeyT033uwnUWcTwnKQWUL1PI/+FDv5IvTXBmLjQKW7W0px6JvFGJAf+n32Xdz0psPHN
 YqsM8G/gMY5aej7EwsqxKKj58XXsANGSVmzl4Yy2GTlrKtNoOjig02Idj466fOUi39o1sgBSpFK
 aBap3sLONOcRNbNT7uAR76WTgTTOkmx6Wlm5JJWX+rGPt7JjzsQHSaJuI6qZJEYkAvsf8CVNtfp
 guY7qWXVKUk8fVzI1hMAAmYsEqTN5cV0tMhZMJRjfOCI8gSLhHTEuJK/5jyKCcPbm2PK53Ubt+Q
 /myS25P0V1K4hrlwxNvRSYValFL/eoUTBTp1Lam1TX55oNvruxoUQ=
X-Received: by 2002:a05:690c:b91:b0:7b1:fa45:72e3 with SMTP id
 00721157ae682-801759e4f7fmr53089427b3.4.1781922705035; 
 Fri, 19 Jun 2026 19:31:45 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8025c96ffd5sm6045897b3.9.2026.06.19.19.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 19:31:44 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gaetan Rivet <grive@u256.net>
Subject: [PATCH v5 05/24] net/failsafe: convert to stdatomic
Date: Fri, 19 Jun 2026 19:28:30 -0700
Message-ID: <20260620023134.42877-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260620023134.42877-1-stephen@networkplumber.org>
References: <https://inbox.dpdk.org/dev/20260521042043.1590536-1-stephen@networkplumber.org>
 <20260620023134.42877-1-stephen@networkplumber.org>
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

The functions rte_atomic64 are deprecated, convert this
code to use stdatomic for reference count. Use the memory
order implied by naming P/V.

No need for initialization since refcnt is in space
allocated with rte_zmalloc().

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/failsafe/failsafe_ops.c     | 12 +++++-----
 drivers/net/failsafe/failsafe_private.h | 29 ++++++++++++++-----------
 drivers/net/failsafe/failsafe_rxtx.c    |  2 +-
 3 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/net/failsafe/failsafe_ops.c b/drivers/net/failsafe/failsafe_ops.c
index ddc8808ebe..fcb0051777 100644
--- a/drivers/net/failsafe/failsafe_ops.c
+++ b/drivers/net/failsafe/failsafe_ops.c
@@ -11,7 +11,7 @@
 #endif
 
 #include <rte_debug.h>
-#include <rte_atomic.h>
+#include <rte_stdatomic.h>
 #include <ethdev_driver.h>
 #include <rte_malloc.h>
 #include <rte_flow.h>
@@ -440,14 +440,13 @@ fs_rx_queue_setup(struct rte_eth_dev *dev,
 	}
 	rxq = rte_zmalloc(NULL,
 			  sizeof(*rxq) +
-			  sizeof(rte_atomic64_t) * PRIV(dev)->subs_tail,
+			  sizeof(uint64_t) * PRIV(dev)->subs_tail,
 			  RTE_CACHE_LINE_SIZE);
 	if (rxq == NULL) {
 		fs_unlock(dev, 0);
 		return -ENOMEM;
 	}
-	FOREACH_SUBDEV(sdev, i, dev)
-		rte_atomic64_init(&rxq->refcnt[i]);
+
 	rxq->qid = rx_queue_id;
 	rxq->socket_id = socket_id;
 	rxq->info.mp = mb_pool;
@@ -617,14 +616,13 @@ fs_tx_queue_setup(struct rte_eth_dev *dev,
 	}
 	txq = rte_zmalloc("ethdev TX queue",
 			  sizeof(*txq) +
-			  sizeof(rte_atomic64_t) * PRIV(dev)->subs_tail,
+			  sizeof(uint64_t) * PRIV(dev)->subs_tail,
 			  RTE_CACHE_LINE_SIZE);
 	if (txq == NULL) {
 		fs_unlock(dev, 0);
 		return -ENOMEM;
 	}
-	FOREACH_SUBDEV(sdev, i, dev)
-		rte_atomic64_init(&txq->refcnt[i]);
+
 	txq->qid = tx_queue_id;
 	txq->socket_id = socket_id;
 	txq->info.conf = *tx_conf;
diff --git a/drivers/net/failsafe/failsafe_private.h b/drivers/net/failsafe/failsafe_private.h
index babea6016e..89b06f9756 100644
--- a/drivers/net/failsafe/failsafe_private.h
+++ b/drivers/net/failsafe/failsafe_private.h
@@ -10,7 +10,7 @@
 #include <sys/queue.h>
 #include <pthread.h>
 
-#include <rte_atomic.h>
+#include <rte_stdatomic.h>
 #include <dev_driver.h>
 #include <ethdev_driver.h>
 #include <rte_devargs.h>
@@ -75,7 +75,7 @@ struct rxq {
 	int event_fd;
 	unsigned int enable_events:1;
 	struct rte_eth_rxq_info info;
-	rte_atomic64_t refcnt[];
+	RTE_ATOMIC(uint64_t) refcnt[];
 };
 
 struct txq {
@@ -83,7 +83,7 @@ struct txq {
 	uint16_t qid;
 	unsigned int socket_id;
 	struct rte_eth_txq_info info;
-	rte_atomic64_t refcnt[];
+	RTE_ATOMIC(uint64_t) refcnt[];
 };
 
 struct rte_flow {
@@ -320,33 +320,36 @@ extern int failsafe_mac_from_arg;
  */
 
 /**
- * a: (rte_atomic64_t)
+ * a: _Atomic uint64_t
  */
 #define FS_ATOMIC_P(a) \
-	rte_atomic64_set(&(a), 1)
+	rte_atomic_exchange_explicit(&(a), 1, rte_memory_order_acquire)
 
 /**
- * a: (rte_atomic64_t)
+ * a: _Atomic uint64_t
  */
 #define FS_ATOMIC_V(a) \
-	rte_atomic64_set(&(a), 0)
+	rte_atomic_store_explicit(&(a), 0, rte_memory_order_release)
 
 /**
  * s: (struct sub_device *)
  * i: uint16_t qid
  */
 #define FS_ATOMIC_RX(s, i) \
-	rte_atomic64_read( \
-	 &((struct rxq *) \
-	 (fs_dev(s)->data->rx_queues[i]))->refcnt[(s)->sid])
+	rte_atomic_load_explicit( \
+		&((struct rxq *) \
+		  (fs_dev(s)->data->rx_queues[i]))->refcnt[(s)->sid], \
+		rte_memory_order_seq_cst)
+
 /**
  * s: (struct sub_device *)
  * i: uint16_t qid
  */
 #define FS_ATOMIC_TX(s, i) \
-	rte_atomic64_read( \
-	 &((struct txq *) \
-	 (fs_dev(s)->data->tx_queues[i]))->refcnt[(s)->sid])
+	rte_atomic_load_explicit( \
+		&((struct txq *) \
+		  (fs_dev(s)->data->tx_queues[i]))->refcnt[(s)->sid], \
+		rte_memory_order_seq_cst)
 
 #ifdef RTE_EXEC_ENV_FREEBSD
 #define FS_THREADID_TYPE void*
diff --git a/drivers/net/failsafe/failsafe_rxtx.c b/drivers/net/failsafe/failsafe_rxtx.c
index fe67293299..500483bda3 100644
--- a/drivers/net/failsafe/failsafe_rxtx.c
+++ b/drivers/net/failsafe/failsafe_rxtx.c
@@ -3,7 +3,7 @@
  * Copyright 2017 Mellanox Technologies, Ltd
  */
 
-#include <rte_atomic.h>
+#include <rte_stdatomic.h>
 #include <rte_debug.h>
 #include <rte_mbuf.h>
 #include <ethdev_driver.h>
-- 
2.53.0

