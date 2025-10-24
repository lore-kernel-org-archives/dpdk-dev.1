Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB6BCCD1BF
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 21:55:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B389402D1;
	Fri, 24 Oct 2025 23:55:07 +0200 (CEST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id C784C402D1
 for <dev@dpdk.org>; Fri, 24 Oct 2025 23:55:02 +0200 (CEST)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-33bcf228ee4so2405955a91.1
 for <dev@dpdk.org>; Fri, 24 Oct 2025 14:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761342902;
 x=1761947702; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aNcJNAY8IpCOth2IwLeY6CPaoXveWEBftcfLb9K4uF0=;
 b=2CFSifBFweYDLxNUx47Niz+O72DwysWLkvRCFyJ1SgcMuwCEAaAz4lkbyp82+QBpNK
 VDEypYsq1BI31Kgyf4OZ0SOMv8IRDMpob/bvYCc0CzTgKS0H0I8olizV/ObSQfoH1ur/
 wdbLjpk6UEb0iFxA4kLhDvRa1+ldV6F+RPiI8T/RVXMtBKrqB3/1jfLnB8zZHPjSnQ1N
 k5cYqS5ZbYdwzcQlyvSlWXL+Q8YmNkoAc4afcHn9aj4QlR93NuvTSKzy+iHl/dBEAXTq
 pgTB0l1NpTE+ZKrTSDX/qBEIhxD6DXyXj1D8qXHnJ0pUwbZsjWXjMPvIWxUQglaCYIe5
 o76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761342902; x=1761947702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aNcJNAY8IpCOth2IwLeY6CPaoXveWEBftcfLb9K4uF0=;
 b=tZgXCth2jkCV20D7h69TcOarUPiO2AJLER+iN1QewNRNblImPRFj2zXNcMfRFBjPMN
 uqm+d3UkvslYOlwJTCtC+xw2j+8T4I9z9iLM9+IuRf5SktVotbBZDoRhFBs0UO3ZKhga
 Ji/QIfylrYykjVAXfKv5YlEpgjBwm9WyHL6MQwGawjky97C5bY7KPIMKbfgzRbqGk2ky
 JCtdE1ZfTtZ+utmZ/VakS29/e3/3VsqD4jrQPWxqmfWwWPG7/99oHfDUCJ3lzCAJInzx
 t7/s2TIwDkSAufL6qASrro5azgTN3/yDwPucsWw5yLODfwv6j8Qdk5JIJc7XqvDhGbS3
 O7pw==
X-Gm-Message-State: AOJu0YyeNa6ur4edlxDLKlVDcAYYZI2Qc2oRp2rAGxgWh5viUEjJWqj9
 cTScH1gl3FDmfBNNBHgCP3JfhcfOzektZznVLKo+1qPvdRkqHTJi7qWzO54gptIYkAtVZcxjVWu
 yl78Y
X-Gm-Gg: ASbGncvh8p3r9JFFrHg9WiulFqM3zJKnz65VGkCu43p3LeFGOq+mjRhpGEOlt4FAxXF
 5S8lKQ6mQHCIjepEU6IUcMlYSUoQGEL2vi6Qcxr2WYRuoEYc9KDV0XfZSHEYZNOA3Yh67CfHtuJ
 93s0lsaF0Jyd0IyMyGDoQZ1osV8bvs3yirv4FwQRfrS4/2rmKXZwetfkf8BdDh3nBrqyf+4p1P6
 YSFdRSlY0dn5/q32XHadvi1cgtePlt5ze8xKXwLu1GRiq4C4JH6TgNT7xyGUYcofw35/RNf44qz
 l91IYXNezGNd80tLi1vGtmcCTje3w6Aa5HZlbtTwFYe2mX1M3fQz/TCX8KGLakd8QYEllgH7CwT
 WsQEfJsiB7Gvz0/I4WT3g+Qwx+cd1TgOn0AWz4aPQ1yzF5aReanW0HAE95VElYWViRBXvcs21Ea
 05I7UH5AnCC/aAYUpQKNmNx2I2hpDHanH3Bv5+aN8=
X-Google-Smtp-Source: AGHT+IG4knAScH54v5F+0TvvZ9CydhlkAn/2zHJlh7tmjlC+977va0RNgea6LriNnUnrpU5Tyr2dVg==
X-Received: by 2002:a17:90b:3f8d:b0:32d:d408:e86 with SMTP id
 98e67ed59e1d1-33bcf85b2e0mr40140372a91.7.1761342901906; 
 Fri, 24 Oct 2025 14:55:01 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a414012de3sm252530b3a.2.2025.10.24.14.55.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 14:55:01 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v5 3/8] pdump: fix races in callbacks
Date: Fri, 24 Oct 2025 14:53:58 -0700
Message-ID: <20251024215456.282171-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024215456.282171-1-stephen@networkplumber.org>
References: <250811213632.16023-1-stephen@networkplumber.org>
 <20251024215456.282171-1-stephen@networkplumber.org>
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
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

