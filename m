Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC5ECA0ED1
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 21:36:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EAC7240615;
	Mon, 11 Aug 2025 23:36:44 +0200 (CEST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id 62EE74028B
 for <dev@dpdk.org>; Mon, 11 Aug 2025 23:36:43 +0200 (CEST)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-45a0dc77a15so6880715e9.2
 for <dev@dpdk.org>; Mon, 11 Aug 2025 14:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754948203;
 x=1755553003; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ut1Cm1OnaRh8sEalCV0FYEgiJVhuwTuCsKpJFkgb8+g=;
 b=Nuiv/y9spIv6qvBJoJLY3k+BJiSenrOAB4s3bvCCl9i6t79DbR+Iy9Yv39qc3vhjlv
 fUvT2pRoLTIzMRY5PqO4E4LQ3DyiCyP28xT5Ie3FthVp9jZZCM9Mu/30Rj7pDqDG3ZwU
 dvOQXHPBBW2nhuDRgTEINe2v8xWRMUZbIFXhx91IDPYlDmjoOpUDZDuVzsRuItN+CzEj
 0p+/x/9qAtZGm0wDw2DdKTUk8Z7X19QR+imTa3fUmgkMO3wmqAqXsAW7X5SnN6/rqgB2
 BiQFC70GUO9Y23rLDBjGJ8/BKKQrk/CnnqxV77E26e6jbTsuTB+Xj40Lx/1kMqB8EPfZ
 Rg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754948203; x=1755553003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ut1Cm1OnaRh8sEalCV0FYEgiJVhuwTuCsKpJFkgb8+g=;
 b=vq5MlqOk/Gi/LBI3iMHFqZionT4+AHnu6jooH0d1leBMKaMV/4Nq07WHluxwF+lqFq
 5bKi/3LtUSvLMusD4NxH5HoIsWUd9MXlHyMbrXzQZWP26zC66BnZt3E5JUc4zoXTIjjk
 NT5nZ+T3rp1MRjUA70DVFsYfS4yOUKNNo6qrvMFMsu1rBf/MsQgeEAWX9VKMr546oyBy
 w5Bkt/XZXiCMk3lfTSYCVyofLW6ENOK7dKwxikOV6dIzB17GQqmvwt8ofZeAsu55J88a
 JNZUz48FNlLMWyvZUtjMS41yz1BtZrCknlmaXRj27ZySj/PSWPqjun5ihlB1ZIiU4NS7
 AaWw==
X-Gm-Message-State: AOJu0Yxm/kQSLtI134bk1rxiV0peLM/KGivRtbkeiOyjLDk22HuWlGa6
 w1cThE1G5ssRYrV7njIeDTMQpV4MtRgkfLV1ToEo4H2w+QT/uapVboUKtEmket7Frp2UWfFY4wU
 gdOcb
X-Gm-Gg: ASbGncvzf1L5pFkOxpl7ej3WD0xvjPtMNuvwzMe719VNeQ6SdAdyuEQ9pTzJgpWy7c+
 3tXm0w0nKyBtfJLP1oiDYHYZX8Gk5dPRdSlPVZhFz3b9C6RhtVIKeT6pq5EyUWWgXNJCZLETFch
 Z4h15iBNKQWmZtD/gsl3wb38qlHqPm4k+IiYyj6nwNho/9Gol1uMx639EWt7v/EesoCy70XITir
 uGMVxe9CxMCumXqnSh4FgDDM6KXbY40xPBHXFfAqXGTwDX5WaKxbm9dycrOYIt0l/x6qs691fbS
 dnJZfCrKdggMpdEjOdgkQGplp86jHu2YbpIg1mtREFHhzxAzEaxMpg5iCyZOslUJfSgK0deMbl/
 8BLAo7EqFVDR6W188M9d3TTw9m5N6ou2c8aphwabaibrBsQTBCl/zqx8gh0R/+Hb3XgJOxHPv
X-Google-Smtp-Source: AGHT+IHGC11xyAnxw0p37GyenidawhWcn6MpTNduYrNtDh+xnn36/lBmfTLPooxnb8Y9n2L9XVOLXQ==
X-Received: by 2002:a05:6000:26c2:b0:3b7:9bd2:7ae7 with SMTP id
 ffacd0b85a97d-3b911017c9emr948991f8f.57.1754948202973; 
 Mon, 11 Aug 2025 14:36:42 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a053a9019sm84661445e9.21.2025.08.11.14.36.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 14:36:42 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 3/6] pdump: fix races in callbacks
Date: Mon, 11 Aug 2025 14:35:01 -0700
Message-ID: <20250811213632.16023-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250811213632.16023-1-stephen@networkplumber.org>
References: <20250811213632.16023-1-stephen@networkplumber.org>
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
2.47.2

