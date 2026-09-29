Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE4CCA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 14:04:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FFE942E12;
	Tue, 29 Sep 2026 16:04:24 +0200 (CEST)
Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com
 [74.125.228.40]) by mails.dpdk.org (Postfix) with ESMTP id E386842DCE
 for <dev@dpdk.org>; Tue, 29 Sep 2026 16:04:17 +0200 (CEST)
Received: by mail-pz2-f40.google.com with SMTP id
 41be03b00d2f7-cc750a1482fso2325166a12.2
 for <dev@dpdk.org>; Tue, 29 Sep 2026 07:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790690657;
 x=1791295457; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hi7rFXmUbl9tv4KQ/uNQDbyoKh870YdIdaGQzFAUSso=;
 b=QL5KLgROJqigWEoefXEzgSpbZP54ibvgzaMuvnmIrzZZbii0NQjM6xd3Vr+mrkGxQ1
 u20GcCE6TPjMTRWQvJiVam+0sjJHWPNCEEY9NpdHjFY3YsJAPTObCCLgE38HRWFF55eh
 X4iGwu9D9Jrif9JkwZyeqA2zY7rdI5QskOZ9sOTEGwyhSMpjUPM4ckT0HyPTENHtEgtZ
 Uaxm98pztCxBuFvTPVy1uHH61L+YypsznEXDGIAh7n+BawoFnKAnTcm49n23VB6mC370
 YN3Jpva6bSZxKkM+yJNOaS/H8+yOlDkD5bzrC1pITY7G44V8uPdDwN32m2TlWHxIhjAj
 atYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790690657; x=1791295457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hi7rFXmUbl9tv4KQ/uNQDbyoKh870YdIdaGQzFAUSso=;
 b=mOGf7/J4ba5dpc4y7+/SW0Lg9xQXQbcqlim9YNCEqn5VucHFXZOUHRcZASqUniTekJ
 3GAyJdWbHYhISEHdH1qG8aabxIYvebEtNd1/6UKEzxe38hILlhIGQRko+ihpmRgo9hgD
 jO/RIFeKYcVxA+w0ARZqB6pB5wa9qQKyN2VI7ZfoShX0bXiRvGfh7/YOW9547CnX4HFP
 xenPsuXIi23z4nKl1D2NN5w2nB6zmN8fA+nNVjeS1rtsca0DHmfDslhoOQou1jFCJe/v
 yuVNHOaz7/t/MduB2cLNs4F3niP+CB9V2pHaEEAPULeJl4zdk4KJYsq/1OcX8WOTY63a
 SS8g==
X-Gm-Message-State: AFuF++mkFwMnKr8tMqqFL05v8ldL56LYpNHh5lJf/x0JhSduLXvLchkn
 E8wXwusuG5Z7ftY2em64f8waTEZdHnIPkA6zZv70Y/P4xAuC15f4tw6UIdPGJGpvyrr8/cMqE25
 YS+raxJY=
X-Gm-Gg: AYBFou0Fi+8k/tYAHN58D/+GJNUsOqkDcKdmKi6AUYv0Mg392y9UyWI+OyokAFtJXVP
 tTYwCBwYXyWzphssJs/iTFJy6ZINceW4QyBNQjDdzmu+swZYL7juAtYTurByTbm1H1FdtDvlbcR
 lbWn9WaxFYv7T4GVVyw5lkKn56Q9ehkshY5SnyWOIUa19z0KRVnyLPrGK3btTGRuuc2cjkwBd+s
 94wFqdjil3IcIzz4EpH6E7SihDPdbSj4McKqmaXhqrqjcvoEnzJs1xHgxTFudPVC5In2aEfOYsL
 aJ8Uoxquv+B50pbaKCtVrX+EbNqUEKoWmh4w0FW8XdQlVOqygiq4TZ3sJvYxoGaCiFypyyKM/Ew
 /y+axKTMSh4q1feEpSgn9pwpuKH9H5LMwLtsKV5DJxAFLXqhMy0tm38H3thTBlLUNzKj+FsvugT
 gCMc6fzLfAMbXip5Rybz/ssngMbpyWnYtqaai/ZPugkh25+P9J7/2SZRSfxs/HZF6VlIp/ZvdQI
 iVDh6aek6beJlLNN2VC+blIrmj6DOnD7ZG2rg==
X-Received: by 2002:a05:6a20:4308:b0:3de:7119:9bb2 with SMTP id
 adf61e73a8af0-3de7119a46fmr5126745637.20.1790690657040; 
 Tue, 29 Sep 2026 07:04:17 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-885e1066470sm998330b3a.18.2026.09.29.07.04.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 07:04:16 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gaetan Rivet <grive@u256.net>
Subject: [PATCH v9 05/25] net/failsafe: convert to stdatomic
Date: Tue, 29 Sep 2026 07:01:51 -0700
Message-ID: <20260929140409.234453-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929140409.234453-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260929140409.234453-1-stephen@networkplumber.org>
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
 drivers/net/failsafe/failsafe_ops.c     | 16 +++++---------
 drivers/net/failsafe/failsafe_private.h | 29 ++++++++++++++-----------
 drivers/net/failsafe/failsafe_rxtx.c    |  2 +-
 3 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/net/failsafe/failsafe_ops.c b/drivers/net/failsafe/failsafe_ops.c
index ddc8808ebe..8761cb07c3 100644
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
@@ -438,16 +438,14 @@ fs_rx_queue_setup(struct rte_eth_dev *dev,
 		fs_rx_queue_release(dev, rx_queue_id);
 		dev->data->rx_queues[rx_queue_id] = NULL;
 	}
-	rxq = rte_zmalloc(NULL,
-			  sizeof(*rxq) +
-			  sizeof(rte_atomic64_t) * PRIV(dev)->subs_tail,
+	rxq = rte_zmalloc("ethdev RX queue",
+			  sizeof(*rxq) + sizeof(*rxq->refcnt) * PRIV(dev)->subs_tail,
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
@@ -616,15 +614,13 @@ fs_tx_queue_setup(struct rte_eth_dev *dev,
 		dev->data->tx_queues[tx_queue_id] = NULL;
 	}
 	txq = rte_zmalloc("ethdev TX queue",
-			  sizeof(*txq) +
-			  sizeof(rte_atomic64_t) * PRIV(dev)->subs_tail,
+			  sizeof(*txq) + sizeof(*txq->refcnt) * PRIV(dev)->subs_tail,
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
index babea6016e..aae091e792 100644
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
+ * a: RTE_ATOMIC(uint64_t)
  */
 #define FS_ATOMIC_P(a) \
-	rte_atomic64_set(&(a), 1)
+	rte_atomic_exchange_explicit(&(a), 1, rte_memory_order_acquire)
 
 /**
- * a: (rte_atomic64_t)
+ * a: RTE_ATOMIC(uint64_t)
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

