Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFDBCCD1BE
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 15:48:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DBF4E4060C;
	Thu, 23 Oct 2025 17:47:56 +0200 (CEST)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by mails.dpdk.org (Postfix) with ESMTP id 5235840151
 for <dev@dpdk.org>; Thu, 23 Oct 2025 17:47:53 +0200 (CEST)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-7a226a0798cso813243b3a.2
 for <dev@dpdk.org>; Thu, 23 Oct 2025 08:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761234472;
 x=1761839272; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QpFwMpjjpWhm9/3oSxBY7IrnOg8PAjv60ibsMe/RgpM=;
 b=B0IVbusmGnYdSPggV0rKtRu3zedK5WkrHzU8uOGnPeGRKlvc2Ti0HwdSV4zaJq7/dZ
 je9QovvMXOxfbR783GQFiAnNUCX/7pzW7Ge+fXRb9RilEMDTdkjp2692zD6jFQ1sfa8G
 acXzQTSTqHTqQSc4zFv2bIVBmauK4bKLocTNARpyaUwow+rKS2pGFudR9WBTF2+oZpui
 ix6APi1fCxxqBHUrdA3FvPhF7phKUFG+rIWKv0AyWSxP2L9h8TZ8tRAHOcBPI3j4dQn0
 JLHovRkAb3OaRq9lJMJeOd61Nnye6jp4Txhzib2ID7p4FcQMy6fjRY+baewuxUmyERw/
 51bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761234472; x=1761839272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QpFwMpjjpWhm9/3oSxBY7IrnOg8PAjv60ibsMe/RgpM=;
 b=qV5BH2zbBcQHkkLv8e1puOd3ntaB/nGRdTKLvcwYfqqx3RJLKOhECoaP2uFFSbpC9u
 xXOwVkRMVEn9gw7fIOYfJiqzUXGHPBg01GDqA7Ie/CSnqe9Hbhf6Q6HNjCtnzTwExzyP
 42aeGgYJCjBMiAmCYcikUE1suY9AhCC/vLyeRtZsTAte+iebAD0uKxqn+ED72eYQgGiV
 ZkOg99chBGJaleIz4D4rAKgcZtZDRXbc/EAvXRDpzRuR3ppKos19SFA97kO9reViI8pG
 WI42F7lkxNw/vcPWWjp+wnY8VP7eRlMNPpS1bTUvfBT7Xz5XC/KGChjOKqo+QfmzAtd5
 n3bQ==
X-Gm-Message-State: AOJu0Yzxeo/wHy09PLZhABMG0oYAFVsC3WajLCj1enT6ihjCcIK6+gxV
 DJeGCbnBEsU4jKjlYdLns3TBsoQYhDVoak/bhk7A0Po8FtR1m5JOm6gjAKTYbYTGOk9P3SfHiis
 PtEVhxxY=
X-Gm-Gg: ASbGncs8uxlvXgf4gQQpR/VOUHkWOZ8TKpP/Jtc7omIBi4vK60x8YYCb9H4JoCrnpqZ
 5h50wq0zeejryGIvfBXC6sq8hg0l480TBt4jjdik/WVzPdq3E7k8J1pzWzAC1DrATKAAxs86Vb8
 OxoQ915sZzK2prg6D4ANVq46bdoJ/XPgIojaAFExdQgWgznX1h2BRTz3O+vzr6YvTu6iTeamEVJ
 Z4rIgyVGswIVhqEGzobLGk4jBGabuGcucnW+ABOHPYt2wF7JaMHjDURWUHEe/VBXWQ5nF87luBZ
 98lxpk6Jkq4OwJXgfY2oiOtk6aLwPbZTUpaoNDQNPN5ii1Bg04KTZKnY0jyIMlBNGsi5hhrEfM7
 flt9brzYI5hBrN58nJQHUIMbRigeeQ8tc+6EsaP7lCRqolbhDLjqUtDwU/BTD7YpMx9nFGOQgYM
 mWuSHnzwpVOki0jBe0AHkb5E2x1vJHpbXyyKTKD1hL+AWx+hWU
X-Google-Smtp-Source: AGHT+IESUg9m4mCRahqr3sdK5gl0+moCBUD0SRW8SNcTWpfHL/bd1YVQkUzvDmX/Bb8gXqtWA/v9FA==
X-Received: by 2002:a17:902:ecc1:b0:290:ccf0:7692 with SMTP id
 d9443c01a7336-290ccf076aemr316738085ad.33.1761234472523; 
 Thu, 23 Oct 2025 08:47:52 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946dddc0e4sm27906065ad.8.2025.10.23.08.47.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 08:47:52 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v4 3/8] pdump: fix races in callbacks
Date: Thu, 23 Oct 2025 08:46:24 -0700
Message-ID: <20251023154748.38535-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023154748.38535-1-stephen@networkplumber.org>
References: <250811213632.16023-1-stephen@networkplumber.org>
 <20251023154748.38535-1-stephen@networkplumber.org>
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

