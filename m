Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749B8CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 16:53:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CBF83427C1;
	Thu, 14 Aug 2025 18:53:20 +0200 (CEST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46]) by mails.dpdk.org (Postfix) with ESMTP id 689A9402CA
 for <dev@dpdk.org>; Thu, 14 Aug 2025 18:53:19 +0200 (CEST)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-3b9d41bfa35so945555f8f.0
 for <dev@dpdk.org>; Thu, 14 Aug 2025 09:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755190399;
 x=1755795199; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ut1Cm1OnaRh8sEalCV0FYEgiJVhuwTuCsKpJFkgb8+g=;
 b=JJ1e5j8/XfzxPXMnxRbAYIKgkNRdHUP2eErFV6dZdUB4YsvSa59Qu6uhnPsxmongil
 6PGnwcPhThUBS7YGDgWyCeSas6pz4AcImCgc1fB/j2gE/nRvcVseAFapPN/WapP6SE6T
 AyFiYJY3j0yxDQ5ZDYyVKsnZVAqJsNE+TQkqvYZz9Mxzm9SVASzvWFkQbldsyZm7mjza
 67BNjfEmMGiPmlbYEryYGstnGLXH/GqIn3esjx2MLsDQnOkT4SFeiC9zGII6VkZ7uiUo
 5+IDM7nEx/eNaziOAe2hJht49+5I+8p49SCbvWiwj97GsUPRMlMPwPoHbjwBXpLbzja2
 y8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755190399; x=1755795199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ut1Cm1OnaRh8sEalCV0FYEgiJVhuwTuCsKpJFkgb8+g=;
 b=mmQi3tsiFtKxQ2XiB2uTLWFsWONoRhgnl7SYBPdqSk5E8UqjG8YXo9fyHL16guBMYZ
 rOdZJtoRmAylRaATknq7Gtbl9utcbT18vvn7Usbhwuag3DPycfO4caMItmC5MVYZU95v
 zL9BeMm7E2eM5lDSs04dchpqURu9cBaSjA2M+g6aloBeb2il2jx8n+p3wqCLh7nAs/hy
 OWlvZaXgfDNy4u6qSGeQYRI+u75wA7cchHwy6gOY9BdhEPtVKfL1yczY6Tv3Bf2Zwk0X
 WyfUzsXXqOoVfRkJrtXezyMkx75hwhEtH4qLdKQcbGvVLK5t+/Wb7jcx84K7vSybAfao
 DmVA==
X-Gm-Message-State: AOJu0Yx9McZCDQ3ucP+zajpIzY459R18l3rQPkeq0N3oYHFzd+vMff33
 h8SG+Fh8YwmtSbp6HZcyAkFKyYu6quW2Q43MPhxYjzOM4WRln79OJOSMz4P3GBm+bDunshkuk26
 ybCED
X-Gm-Gg: ASbGncv4hBaqiWyOxk5CLOBdtDP/vRMnvulCMcwTDmUHiFw5+mMJR49iG3t0SV6PKBW
 Md2dE6UZCIIScFPlVYhRdlwgZxoQ5Ubf2h+Iw2Cc5eu1vg9xjU7eKrK2GecXrKfzAxsYJllJUDH
 kUCbQS+aodMkO+lpKCIPa0mLowH3h0KYAMRCPgU1CKx8PQIciMSVsOW7yfA+0uVYCW39YAaQmU5
 s93ML2Dh+cCs1O8e+SYLMD8puWPsLr9DsgHviQXykS+kCA8xfh0p0PSWAGmnfYO2Lad8nweC6Qr
 UosqB6bpt4ebcIGefDT3s+200VfrwKKt0MKKGVserEF/39dMcJ0Znd178uTM3Tdm/4ruN1k8N3z
 UxKOi5Sj7TuQE4GCGKV9HwZw6F91CvgQs4w7uqIUlC4biACgecC30dsIkqdTZLOuhTruK20el
X-Google-Smtp-Source: AGHT+IEZhQRJIxXgg2PaP0pjKm8Mc7U8LV67WKaSZK6ffGa0UR21HsMKlvp8cuXGD3ai7THHRZ4QDg==
X-Received: by 2002:a05:6000:1acc:b0:3b8:d1d9:70b0 with SMTP id
 ffacd0b85a97d-3b9edf43f14mr3801851f8f.40.1755190398977; 
 Thu, 14 Aug 2025 09:53:18 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ba54f87e17sm1748197f8f.23.2025.08.14.09.53.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 09:53:18 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v2 3/8] pdump: fix races in callbacks
Date: Thu, 14 Aug 2025 09:52:59 -0700
Message-ID: <20250814165307.12786-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250814165307.12786-1-stephen@networkplumber.org>
References: <20250811213632.16023-1-stephen@networkplumber.org>
 <20250814165307.12786-1-stephen@networkplumber.org>
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

