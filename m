Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C50C55ABA
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 03:26:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 725D840685;
	Thu,  6 Aug 2026 05:25:56 +0200 (CEST)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mails.dpdk.org (Postfix) with ESMTP id 12A2940671
 for <dev@dpdk.org>; Thu,  6 Aug 2026 05:25:54 +0200 (CEST)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-c9ef3e1337fso1295437a12.2
 for <dev@dpdk.org>; Wed, 05 Aug 2026 20:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785986753;
 x=1786591553; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=139gzksGNvb60vjMHCV5bmGXdpR7VUEdRflMop0rtSU=;
 b=F+5zzuJNR/DJxsTRQKLAkDxpIoARKKRLLjiXhp6pIrMeZTvqLkBVdx8qXg888TPIXr
 0HOxEsdM8+g1NbdTMWvKL75EzMiOktpL0oaVOMtubtyM3WVY6UGP0ZIVAfZ8Dm92DnUi
 B1SVvNxhKra9b7tGrnyv/zzRPhHSPXSYK7uFctSUfwQ4LbKb8iwmNCd8Qlqfq5jVEM+Q
 bb1QgZ+YBwI4ykQmkTANjEByJozE6ekOVWqzynsNCzaVJsO4ibronuxouR9ZbhGWV4AN
 Q1u41nk57sZJUmVIZ70rbULwoGCwCBqdQa7L6vyN10tUs1+dSl6R5A6EuRHHgZn2GlbP
 MWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785986753; x=1786591553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=139gzksGNvb60vjMHCV5bmGXdpR7VUEdRflMop0rtSU=;
 b=MJmC9Mh6XV9ithGtd/NVJr/mkzbYTL5ilVkYnQsE7EszqkdSYu4KRKH2fMu6zbmLvr
 wx2JwZjiLRC11y/KfzRKkyTahSngJpFN2kpq82DJdQoZ3KhF4H5zuZDbGZANgC2Q/n/V
 01hcLEYeX8GyP2AFcPjA7lx8grxMYpHhJUdZH/n70i1Y6vtOm8jFvVDeSNSqIIYHFdAt
 VYl/IZjlzaEiYYwBHI/20h0SAMbA/8gzC5v7sEZPmT06U3aCtQ8C/rZK4iM7imZIfTcD
 epsSVgYxPAonqEW6/F9vZNEdVqLKZGd97hmRcnPVcezfrSU6pTdzH9woOy/LAvp0NC43
 Atng==
X-Gm-Message-State: AOJu0YxSd5gbKBSxovRw85YZWECTWP6EdcP5pIB13VJZWOzWoWJRMTEe
 LXFi1P6wKtCXL+MIR3neJHUUs/X3CWOlFSSbfhDWKgHeP2CzhtQ6b3UjZFGryYWa0fhndWPjNmi
 XWNSyFkU=
X-Gm-Gg: AR+sD11Ua+pzm+1VlsiG7pXR884AcaOfsfPagpeYuWBkkU7VAv9EFcVl3mvi5YGrs4V
 x+yFe6wmWkOkG46Uht+w8M8TRXIvg2HMbmle7For1O5LfSNa/AFoGA5qiX0GBg4iLPIANiVS2Ta
 cfJFM0DSMJ/5WNYTF/pnV9zntRflCVCzjEUcH14psMtoExpIraavW5kGXRLBOydYtxesOf/dfkQ
 JuOpiCZThn5RE4nB9TEvq6Zg6mzUI0w8qRrPKq6hI5H68GCj7IW4qknbRyf7xEaqi8bSvKBHZGh
 6QLOm/tjij3dYy26bzdmka1E0nX0KxRf4w2nRpzK5w2AiI/MXBD8rEBUua+GKBcxFT/9F3KXKbm
 ca+u/6370tnO7+D+SYj8LK6Y/HjFwtpHAf9V9hXOamA+td1qJ+ipdyARST6aNfxp4WO5W+QJZuU
 iX7CkibjJjSzhZNBtBHXD5hMwBocJA2HOsuw8Hu43G/VAb863sn/tR19B6fLL+t5VUFFjrD+qCi
 MaF2nQb5MyRu3hcwpeGoWuMdsM=
X-Received: by 2002:a05:6a21:3a82:b0:3c3:704d:57c4 with SMTP id
 adf61e73a8af0-3cb85ded954mr14495070637.12.1785986753210; 
 Wed, 05 Aug 2026 20:25:53 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863b0c61sm23301631eec.6.2026.08.05.20.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 20:25:52 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gaetan Rivet <grive@u256.net>
Subject: [PATCH v7 05/24] net/failsafe: convert to stdatomic
Date: Wed,  5 Aug 2026 20:22:57 -0700
Message-ID: <20260806032544.21337-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806032544.21337-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260806032544.21337-1-stephen@networkplumber.org>
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

