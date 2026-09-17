Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC8CC982D0
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 20:11:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0413442EE5;
	Thu, 17 Sep 2026 22:11:31 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 0FE9942FC7
 for <dev@dpdk.org>; Thu, 17 Sep 2026 22:11:28 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 d9443c01a7336-2d8fb334e72so321635ad.1
 for <dev@dpdk.org>; Thu, 17 Sep 2026 13:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789675887;
 x=1790280687; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EID+btdzsQnYPKce2NqjEeot3okjRStHQ0GK8kvxqOg=;
 b=hfmmgz6QJcS5Aslr49UONvVu8uExh5mUWU3ojxEt0TvK4oq/5QNhBh82oIMK1+vdKg
 GGTDWkQsX0ioXWaaF41EDEpvg1K2ggzeJOBdGDPKsYUPT/ZuezqKwxmwS7cn6QyOYxww
 3wNV/1IZJmiNWr5VvULicUi/cgV6cqnvb3IqU7cIO7b+Eh2KITmKSUbtxR1dIQipCC9g
 82h/mMMpwtb1SwsIe2iih29R6MgSx0X99YA99iRIq19zyaTLkqAftb3e9uQpASFSl7Gq
 u84rdJy18xs2RdFIjrtsR5OHG3Vc/wY/ZPmI7IrNkfD8UblTKStYOIL5VNwohRz9DKiO
 SyCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789675887; x=1790280687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EID+btdzsQnYPKce2NqjEeot3okjRStHQ0GK8kvxqOg=;
 b=slxZVnFpoEgOdLmXC43CugXIpp3khSZdK41P9n0/exauoHfvdqZ9ruUq50sWW3lnM9
 omPrIAlci8vAgzlvcN3GTFHJQWzxRs5PSfZbJgJVVHI16AjXo/b53TunRD1DTFjsG+Cc
 QUiEs3W4PrFDxD7XF1I8CIVv5pm2EAPKG85GIqzAKOETfmSbh7XubvYQersB1SaWvCOz
 fJGi7z3Yw1MwxCc23Y9poOzVVt14jpgVA8jnEr4I17M8AYFXihNVRdnU0zyIMhFsL/J7
 7KgouqAVzzGBXOiBu5Me+GtVPQgICdqhjhxS44S4AAVrHcdJZ7sXgbhB4cWHC7uAUKAb
 EOYA==
X-Gm-Message-State: AFuF++mccQ9oncYBI8InsUfByB9H7ZOphtLPzKj9KQp2qhVubfg2HLbC
 dxaCwsdc+p9st6vMr8HHBflDCF0ZS6qVr+gZL8k8IP75/NfH9hy++VIqieLHd26/54JVJ88Z6yY
 J2H3L
X-Gm-Gg: AYBFou3Jn2kO8NOumlAauQTVha2BlZ7d4GenSh3QmvUSumfwUzzwJ2Pxnpg/Z6PsA7z
 WKVRL1GJ2+HfE+xhf2LvhqQ8HpjQDO9M6ZEVnIpJsL2rae6/t3GqPnOGCsxsuUDDcz2x6oRXwUb
 qTDixTaZ3Gy0OgPrTdQTvrDdN0qiGJ+/fxXJhbQnU2sjdizmd2w5B/vw+0T7o6COlvI91Ujpm+/
 dK0EhILox5WPlwyEXr1qAFLGlJW2GFCMZWObxq9v6XXHEHYyas1y8blekIfaRKFkqrPutF2K0ii
 y4Qf6MhOI2ZJN50HGYBFNc9ebswCpUsXSVT590fOtcxaHGpMbEw1wtUXxjt559uMBNztdQ8csPW
 2ZmhJe1lTipqrwdmh7C8HM55obv1cjU3f1qsNmQEOlcf5+5KLSvBllNnLjAbCuzvLdmBM2AvYRh
 NhmCJ0JirwiEpJzfc3VzWPVsuUQOp+DILPJ+5TQtScqfjVYQTKjXtiV+Bq1YfU8pF4gxUnpegvi
 8UYOBJT9yOHygFu2nI+6TQi+/+vfc2mzc4XcA==
X-Received: by 2002:a17:903:4b03:b0:2db:18fe:bb08 with SMTP id
 d9443c01a7336-2ddb1b99467mr4584835ad.10.1789675887179; 
 Thu, 17 Sep 2026 13:11:27 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd89f0870bsm31368345ad.63.2026.09.17.13.11.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 13:11:26 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gaetan Rivet <grive@u256.net>
Subject: [PATCH v8 05/25] net/failsafe: convert to stdatomic
Date: Thu, 17 Sep 2026 13:10:09 -0700
Message-ID: <20260917201119.2168234-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917201119.2168234-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260917201119.2168234-1-stephen@networkplumber.org>
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
index ddc8808ebe..98ecde8786 100644
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
+			  sizeof(*rxq->refcnt) * PRIV(dev)->subs_tail,
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

