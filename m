Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF2ACD5BAC
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 18:07:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EDEA840691;
	Thu, 21 May 2026 20:07:21 +0200 (CEST)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170]) by mails.dpdk.org (Postfix) with ESMTP id 5CFF14065F
 for <dev@dpdk.org>; Thu, 21 May 2026 20:07:18 +0200 (CEST)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-303dbfbec77so7018227eec.0
 for <dev@dpdk.org>; Thu, 21 May 2026 11:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779386837;
 x=1779991637; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=139gzksGNvb60vjMHCV5bmGXdpR7VUEdRflMop0rtSU=;
 b=XX8zuZrXFQ5eUlKWtqsGJIiWyvrmZMlHfDEFOwQVRE3DWtyQ0LbGOOEVFjQFIVwF4M
 hzo6kjNdizmNr4e3LkiI8c6xP9YklBZ4ix5/jMD7/bZzSC3zAeBknjcgEwdQ/Oze+4+W
 5r+6p1zTU3GXoZYD8pRAPyZsh87oJlq20yOfOpxV4NbYKxIvm8eanePQGzT6NA8To2/Y
 iRiknAMItDV4RdCDVr8ue+YO62jrxwDZk1Vmh8xcKdlkGmyJJh1RmzQ7anVTQEIAPctA
 q5soJ3U3R3dBMiJ3YLqzz2DPgjdJMEz2LgJA4dIa5uKp2mMshQRUdckQu75pDMmzu40c
 49QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779386837; x=1779991637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=139gzksGNvb60vjMHCV5bmGXdpR7VUEdRflMop0rtSU=;
 b=fVy3Hq2krLuhbUHxeUfmr9lH1zDV//Zn7/kSSVNG9wl5mRehzkxgd6rXyLyhcGS6p6
 79U9LtX1YOfb4b0qZhlv0luNoadFK0M5RI0DOxFJonOyu9kZU+EA8OLw8Gh7maCyfePC
 WKDlsi3iAz6xn4WCADMCT2nP6/xXqUALEkGjYL34ZbY7bR53x8XC5DaxT5sI6B9ynSBV
 vlObMh0gnJdtGLYgyXHGbiNxQJmMugN2ad0zTrcJHAxVtP+WZiAkoqJIkYH7GBN3V8HB
 W6BttRdZs0lZvA9TxUkQSdFbZi+zyvfSfqwRTGtkeoDC6Dq5m8TVei/QTWPuWzS2h2xC
 PsVg==
X-Gm-Message-State: AOJu0YxXXE60K4tE0kxk7dZhis4mzFaqyUYVe6PZh858xzlFkoAi4Nh6
 8D9sCb9q0UZxXvBiH7dpyzTpwkOXFqB8vlWEbzBeNhZj5NKbdpUTHnVmLzZ0HRH3CrSO27Baw0+
 f7xSG
X-Gm-Gg: Acq92OFSBhPGgPAn+4anVbyWF1r6Gi0Utw1tMdH8pJyWQ9v0T00tOdcLk7hfZjxTu0i
 MvHcwQi0Bn/UowuJGzfEa5lL4D+H3DaThFDsDAQftDe5WVQR4S4rikSrie7UueRvpZNE2jWZ3e9
 YbRLRxbkb5Cr7l2D/tYRg2GmQiWBTzX9lEOq0iwLQI0ozZHROwW6wV5VzBakmSZuW16jn4eHQSM
 rQOMs+ehSkwRJMXAILVes7hbLqYJplgRXHWT+lZdA2hc7kcGWv2CYzgiiC9k8t0uX636QJskY0x
 5TbaexOUyYhCmi3adBQWthXId6VsGzav4fjydlo+2Xcgqp0K7D9RdkAfIvK1uzlJWj/uA6ZKVpQ
 F5wK8ZQoqQR1ew1zdiwQrUrrAJeUC8Gu3oSkAeEtm9WYHWpEduzQ0pwuAOBCPjGyLoq3ZQCxLAv
 krQuC48ES1aim07ZZLvnMkEAdN4EqGNhRFm25voenW+VUANDZfWbAokZIr55jateB+MiQ7Q5t5
X-Received: by 2002:a05:7300:f609:b0:2be:7885:31df with SMTP id
 5a478bee46e88-30449051a2amr139594eec.17.1779386837412; 
 Thu, 21 May 2026 11:07:17 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304435c10desm1034069eec.27.2026.05.21.11.07.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 11:07:17 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gaetan Rivet <grive@u256.net>
Subject: [RFC v2 07/11] net/failsafe: convert to stdatomic
Date: Thu, 21 May 2026 11:04:19 -0700
Message-ID: <20260521180706.678377-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521180706.678377-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260521180706.678377-1-stephen@networkplumber.org>
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

