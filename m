Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B597CCD5BDE
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 23:26:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A5F740697;
	Wed, 27 May 2026 01:25:59 +0200 (CEST)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180]) by mails.dpdk.org (Postfix) with ESMTP id 7B1B140674
 for <dev@dpdk.org>; Wed, 27 May 2026 01:25:55 +0200 (CEST)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-3045c195251so4410799eec.1
 for <dev@dpdk.org>; Tue, 26 May 2026 16:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779837954;
 x=1780442754; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=139gzksGNvb60vjMHCV5bmGXdpR7VUEdRflMop0rtSU=;
 b=SEFhRSYN9endXe/5FEmsbMEZb/uC9Gm81x/ty1uV3NJNSGqmBcRkXLpEkyqX3hfsHY
 /f/h098VYJyHS5V9Gn4k6uR7ILxDg5jW4l0BDya1incs8pXVXUdBPuudGJEDQN4yYj+g
 OvWMADLlXj3V+u7ypbtu2E+GIcffCNjPnaZlLB7QtdPthV2pMbUkCUsh2CRI0lVBqmO1
 8GtQdb2ZRXRhQPWpbKNWgBeBgWm+8P3s8pFtRem7PRquaY0AAzes62x/KFxDfY33pF9K
 505DwbgnMIKTWQUypA5z33kxqVzjoekS6IbpUCEsKjCoaC68NdZkCjpH02j5Fw/5zgQS
 QG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779837954; x=1780442754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=139gzksGNvb60vjMHCV5bmGXdpR7VUEdRflMop0rtSU=;
 b=CGk8kbDQNlwpLw53GBAaDLq3Zi+JqCmc1q/2oEL5LgDv8+XqrCpPGDGVPs8xpgdPrS
 L3tTAKIV3FKcIKUide4JfVvXaBGXXeas5skJPjlqlfgU/JZoR/G3uoKJ6qfgGBMbd7GA
 u/vV1gvQjduSkZ8gHHn0bFIfGoeVJS8huo0iZ8K4h6xKxwt55Vnz9VuQIdnU1TMDLQjc
 LWk65xfZisFHmkYDTGTUoBUUZKPZJGXXadh8jy+iW2cCMVpN3TH8iPLJNRUPRi2slnwS
 eTiBV5QDBYqOwu1N9h5+w+u2+ArbirHAzLN0dRvjCcqZ3s7QcQvhp4aDAvP2eD1HbdkD
 O2YA==
X-Gm-Message-State: AOJu0YyAUpPz29Clzen5/5Y/JYTud1S7FnuBRinYXkvFwerLM6Eh22BP
 zxc4ja+JsCvwINegxSPQ2aoMAa8c6d/EDwqMWuXt7Nub8xciTLHJI40+4QayqbVg/3Z8YmsJ9d1
 IOpM0
X-Gm-Gg: Acq92OE2OjivgpE0/ypdICUjjh1hyg8N8T+DGBhJMwO8W9hY7udbRKS0g5sn4EC1zUF
 +LVW9VL5a9gvup2DFST7X7Zu7qICzXhob+TqFS/t0wUb3Ey5gLex8ZeS69MSITf9kakuqVR2cRW
 3kSm/wn9YZs9PeF03pgQJsFHo14XcT3qzhLg412/h1ZwD+glxFQtVg+aPwetOsyK3y9J39K6BBK
 J+ESiJiRItxh4Qlx4aLVHn8iVRhbvvcUcpymSuYDgk2xLk3YMt3F2zMcEqIa1GHQ4GMCtDHp0N4
 vKsbNQisyw4ZrLKdnGUAvd08qZC7FHj+wHRXF9McZ1o5eDvIwj9TtGrUHmBVWRtfhf+Vrsup2p0
 +pWt3c92atlrkzry3YtE370Q79RZSroNIvnyfcmFrwC/STqEMT31tZHCXmIFnIaOVbIYOl1oEr0
 KoykTw+gX8olHidJwA5zVz3UD4JlHGBFyF5mKMHE74ht5qERmdeuZM7rjPZ5I3Mw==
X-Received: by 2002:a05:7301:9f05:b0:2ee:be86:7b90 with SMTP id
 5a478bee46e88-3044912f80cmr7845205eec.29.1779837954503; 
 Tue, 26 May 2026 16:25:54 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452230f1bsm11296132eec.14.2026.05.26.16.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 16:25:54 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gaetan Rivet <grive@u256.net>
Subject: [PATCH v4 08/27] net/failsafe: convert to stdatomic
Date: Tue, 26 May 2026 16:23:58 -0700
Message-ID: <20260526232542.620966-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526232542.620966-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260526232542.620966-1-stephen@networkplumber.org>
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

