Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACF5CD5BB8
	for <dpdk-dev@archiver.kernel.org>; Sat, 23 May 2026 19:57:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9592B40676;
	Sat, 23 May 2026 21:56:20 +0200 (CEST)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181]) by mails.dpdk.org (Postfix) with ESMTP id 3408E4065E
 for <dev@dpdk.org>; Sat, 23 May 2026 21:56:15 +0200 (CEST)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-30455f77e0eso2302074eec.0
 for <dev@dpdk.org>; Sat, 23 May 2026 12:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779566174;
 x=1780170974; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=139gzksGNvb60vjMHCV5bmGXdpR7VUEdRflMop0rtSU=;
 b=c8DYQnJfUPX6hFOJJmZ7PS2vnJmuC0K4E4BCEpOEPoZOZcZfmlQEx37loSxNaIjzNM
 haXWLDKmWd2TK5YZL8lGpFNzMLy22Et8YJYuJjW64qRsKSftzcbIU+lP0Hd99+BOApu4
 i42mNd7LR902mwLmRJ+NL2NeurIVKzovGqFa/Ywqf05FG80FnVCiu+JEGBKP8QbyGcjd
 GaeAmM2cGWue3ba7OtOTZJQbkuHYpP/o5twuez+8fCb53JCwTkVwuXI6mSUqOHW5ZigL
 Dju2wgsup6nX3c97Ntmh/IGysJTVSFpaPsXv+rNmv3VUbg/ttTY6bIEiOXcYBUuBZd+X
 3m+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779566174; x=1780170974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=139gzksGNvb60vjMHCV5bmGXdpR7VUEdRflMop0rtSU=;
 b=gMD+3+MRAjMz+UT9AhHzvwupNpeSjy5rLY0Oh0AUBBzgQmesMuKSapO84uK3swrMjn
 OpVk7by9m56qfvTmad+m3zbUcuWlr+Or/dLcuZlk21x1r2IxR+MlypnjuWqIwcOfvrYB
 y4vgvsQj7ABcIBQglIW4dg7FGMYR+E22gJVJXxW8g21JYGTiQt6u6Sigb2lmSZK0kswl
 Oyq3GXbTVVLOlZb6arPLOgCXVYkFpTpz66RfV4sAwfGs17B4AY+qNO1psrcAlNgFp0Bf
 S5/t5o6WqDfOx6r41ICsaST2oFfaX4eIcRjpu/PCeaCpnEgjmyc33Fu27S82C5BlPKtx
 4D1Q==
X-Gm-Message-State: AOJu0YwNQ3DQTgjg7IY4VWtnZBJemx6vscFx/+xnRYq+p5OZCwEQmYk0
 6VPQHzecMletDtHJLnQcJQKJz3ZidfXyY+YhOz2ycqCN4sDw8UaLRNkvyp/viGk4sE6YBGCdOyk
 NJnI0
X-Gm-Gg: Acq92OGmmvrscVBSWqJ0YJm+YWFZkOcQdYIaE0OELI4K4sKGz2GlMTDQpO2i1fZAxB5
 wDzWjVWLSNJC+pQe4mUQNlsgeeu15lQEXDskILsLjvFSWoerPrAg2dBMi5b5/r6Fny9RZ4/IJwC
 9WGJA5UBXLS6oTmXSLo6mycpIn/Bzd8xRJWyNOWSuYhOa/TJGFKdjVAwnQKBjSYEzegV9C7lKW0
 PdiuqiNzkLur/NXWseQUNpCeHkKwlzNVPwy7xfJv2fH3OQe+GPu+BFIBeKTdRplrhwts0zsm32H
 z4Lp1qBn0ByXtLzBxXilOzuxr5FUTbyeRvbUEb8Uwn78qiQ1RPAGgQywR2ZLDzqSnqPXAramKFs
 oB+t3zQrH4R7C8avlJFDxfXAPwkqMGe2byq0fsHuH05h7GhOxddQj1h3mdEdW9SYzbWUN+R0eNT
 9gobTM58HozRq+EPeP8kl8eqn7y5uQjXWylE2ZAw0JuBqQyu4x53nYqN9NwamWENFZnLXGb0aW
X-Received: by 2002:a05:7300:aa8c:b0:2f2:2e0b:24cc with SMTP id
 5a478bee46e88-30449192e35mr4291316eec.24.1779566174195; 
 Sat, 23 May 2026 12:56:14 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30451f3feadsm5257271eec.13.2026.05.23.12.56.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 12:56:13 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 08/27] net/failsafe: convert to stdatomic
Date: Sat, 23 May 2026 12:16:10 -0700
Message-ID: <20260523195604.441947-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523195604.441947-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260523195604.441947-1-stephen@networkplumber.org>
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

