Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7B7CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 18:09:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28C5240696;
	Tue,  4 Nov 2025 19:09:36 +0100 (CET)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id DC5504067B
 for <dev@dpdk.org>; Tue,  4 Nov 2025 19:09:34 +0100 (CET)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2953ad5517dso44285185ad.0
 for <dev@dpdk.org>; Tue, 04 Nov 2025 10:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762279774;
 x=1762884574; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aNcJNAY8IpCOth2IwLeY6CPaoXveWEBftcfLb9K4uF0=;
 b=FVHK0retK67XO1nTkVIc89+4Xpn71pu5ODBTcXuTBvlWgiAIjpJ3bE+T0M9uECbXmT
 gCFhYLW1cFdFs2RvjakIeu3OqWLw3LMYR//dk+cJ2d5cg+ziTKqztSKK3yt2wfvGyRYh
 9YdENlVH+48Jx/T+JUg+i7HZtqmiQJmjvf/JV4UBjrFeoOscIK97eWDIKYY2OOMo1s5N
 5Ggh6dlQ4nU6B+Wzq2HAWnFgBd7RsnMpg1ZFaEeDcy4Lea4rLbhBjUcWYpNYpJxeFmLd
 d8LcklS6tGVjYPDiOW64dHPRwug7dNdqASZ+IPFWn9qmyYCINoMKQpw9Jgbzax7PeRal
 cqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762279774; x=1762884574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aNcJNAY8IpCOth2IwLeY6CPaoXveWEBftcfLb9K4uF0=;
 b=HXa4DldXWlW17U/LIHRof9Q+VKjbVV7ulKhJn1Rvg+dOiAM0kwQ0qCBAmhegiGMKMS
 MoZkyTIdfeXT9LS4TNLUHCbwiknFKiTTzEpZyR9OupJ0/skOCqxVRCr7vM6QCLI+/z7w
 lltZ6yt3LptuAUakv/SKWV6rIRmAE4YeBqBbgS28d4pjH6VjWmx4GrysAtE5oEvx5ZyX
 7xg1kOsyUBC7+AdkYS51OyTStdDZaFkNZpvIp4KtOGzZppEORugbMOX/CoMZGBTC1v0Z
 4buS0hyScbQGIVXGC1U2uCwkdYrrgvl2kLAam2htNIdfPGwxiVEB2YKiu5Tw3mL78+3Q
 abQw==
X-Gm-Message-State: AOJu0YyC4XACGyijHAawBop/ic2sqmxMbFUntIJc2//hSZJHcaCPW0jj
 nYSZmRmec+9wZzn4CnBOcAM9r/JUXwUJjQiRLxqa5VchQ43OowDXXxBTR1NSe+jCfqhmVY/naTf
 uLPO/
X-Gm-Gg: ASbGncsAindvVlKqc7zJSvIdZvgbhNSDHlWk5mS30QoHtxOboCaiE6zoecQ3sPVQBbQ
 hNJFZi5yEYf1kP3/4Mkrut66j4U1MaN/ho0aH9TO6DmecNkhsPWFIQEaPETNiZQawFpP9t385Zb
 FXgf+L1jEIX1HvyEg42IhKvpSY57AFBDUPjbAuRA8oFPe+P786E6FZW0+PFT24MN+m5Iztq3kw2
 3Ay0nOcs72jjGQxXKJmgbqRoxASv/t3r1lmgPs7Qp6npTjrWevCnc6TLFXB2DXDF5HddgkfNDM/
 hgLLcMxUfWitS7/7QVchXRe5MelOd2j8cuIxUxpFimqYI5z1euTln8K1nOraIaCJHzTTu9AeGez
 vG3+tDWopB42/W21FcH8MCqwGXrVMDReuCoLypT10AIO3UUad1vxZV0xQqx8Owkxc8G5pOBE41r
 17H04UFio0KICtHxx+oWvAwo1sLh6bZYpTq0jNUUs=
X-Google-Smtp-Source: AGHT+IGoH1i3VrCMDLalyl7ofJL8H44ZJ3EaGtgcgsfZnBPQ8qmX844oOw4Zv8HsuNgqzqCHbc1AMQ==
X-Received: by 2002:a17:902:f609:b0:26d:58d6:3fb2 with SMTP id
 d9443c01a7336-2962adb413bmr5242405ad.12.1762279773882; 
 Tue, 04 Nov 2025 10:09:33 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ba1f86b0688sm3035988a12.28.2025.11.04.10.09.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 10:09:33 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v6 3/8] pdump: fix races in callbacks
Date: Tue,  4 Nov 2025 10:07:07 -0800
Message-ID: <20251104180927.403355-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104180927.403355-1-stephen@networkplumber.org>
References: <20250811213632.16023-1-stephen@networkplumber.org>
 <20251104180927.403355-1-stephen@networkplumber.org>
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

