Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC24CA9EBD
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 01:59:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6157F402B4;
	Sat, 10 Oct 2026 03:59:23 +0200 (CEST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id 60BFF4027C
 for <dev@dpdk.org>; Sat, 10 Oct 2026 03:59:21 +0200 (CEST)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-3ab868eb9cfso66095a91.0
 for <dev@dpdk.org>; Fri, 09 Oct 2026 18:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791597560;
 x=1792202360; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=53LYYrW45zPI0m+RiFEoQMQZSjTjHZbBrwkToDe1iDQ=;
 b=qvg/7TSO5sQTVf60hsmCLmHAEH2fvJn0pJmrTKlPOnecFzVf1hTvTWZdokdGHCSQc8
 dxCDy8O11Wt3yeyZ+XOgIjd2+E8Doh70jki6wcGkxxW5Pt3R08XORD/91JroC/6481Ir
 iUU6B9FRowsKsQaJXhR601V7Dgsf3fRU2+beqA6DeMWJzagRSPV6SH3U1j3DrCk4B3lU
 PoENFLbZvPxJA7NqEhpL7bR2yrb54zZziy/E2SvQLptZOHGCsmE8H2qAVb9wJ4JqOfhp
 tnMj+BLuX8zuv6QJq7EgqpTVTkpGbPWQGX6clv9VyYWliGr4ErgjSDk6KM3Umj17pv7H
 /2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791597560; x=1792202360;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=53LYYrW45zPI0m+RiFEoQMQZSjTjHZbBrwkToDe1iDQ=;
 b=JV0uXljH/m3anuJL7KwATGMzCPTY7T1vXsSYLgjPf1QLSFJMBk12E+5LqNtPGuXKGS
 avyXUEiK5BxHs3eVHhm5ka2aKcSw/mWL8OsRa/eehrCMAR6L1ty0MZwEs2ju3PpvEaDB
 SbljJfZ7XlOJynMLHkB7hJ/mCbQQqTd2jX3RNvqHdkAZ2YUIu/NgVI78CgYjvinSMel0
 H1SYm6iH5hEUNK+wzhnsNOwImdnKc9I4lvbE0uU41EtjUrYCQhq0/orpQOJ8JSVNCSLW
 5Z8FN6q7mJZnaAe9Oq+lVuBOogZplez4dPLIIV9BXyA6BbYgKIissMALXx1XsXuv8vyW
 8H2A==
X-Gm-Message-State: AFq9FYKiEWVrylO4YYwYqlc0xOYTnTeBxnRe9YyP7efo7TM+s0k8RcJK
 5KUPzrF9Kpf8mOGnRqO6E5IjcbVshQDJf3fW8txsqRelftRrM1KwRchRX1BQiSn/u2O/MJkLYe6
 +9RizHtE=
X-Gm-Gg: AYBFou2ceRoi1ePX6UhAn2nxaQkOqRWHv/csTXtAIlZwHghZHs1rPmRA1xpR9BWTWbX
 6AYRYp8u5gQPB8A0WJrImVzOuCmz3bC7Cp68S30HxZTHH8ml6BFfnbLax3QXMaKYO4Bwe1NZUuW
 B11bz9a7SwNeQlwyL8kG5QyTfKo4pU7o1iy+1pPWe+bzMkyjRR9pBUbiGNoRclknn7IXY7QbEOo
 MajdQFjbAdEtYt+ILw0u9tCiWfVvPr817Slab6vxRk09SWKfJpkJ33sC9Kp1W0th+UBakVHrA0v
 paEicoLrxwZLWhpA7+lYsKp67FGOY2+Hl2pLVxRpQwEHU04ydyQ4HmVYLNa3pz2QGLOfdCA9Way
 bCx2ocZUoIkIOUBDnrkSemWlR6Ai4DsX6aX7DQ1dFFCKk/59l/P32eOHShaX/kaVDkgWcAQj1Ir
 bPCFHNzrL5OVcvAMl22AqjikOn1KxRG++rwsi2iFI5tOin+e8Hy65zb1iF2SxO0f3S9jmxhO7aC
 qFl9EwqGX5yn/goJ66yP5HDvca8fLyy6EDlZy4=
X-Received: by 2002:a17:90b:28ce:b0:3a4:85c4:68fc with SMTP id
 98e67ed59e1d1-3ab3a79df67mr3270063a91.29.1791597560429; 
 Fri, 09 Oct 2026 18:59:20 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd3d9e1deb2sm1827854a12.15.2026.10.09.18.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 18:59:20 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH] sched: fix data race in RED random number generation
Date: Fri,  9 Oct 2026 18:59:15 -0700
Message-ID: <20261010015916.1689925-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

The RED scheduler used its own random number generator which was
weak and buggy. Change standard rte_rand() which has better
randomness and is thread safe.

There is no prior deprecation notice for relatedd symbols. They were
never meant to be part of the API: rte_fast_rand() is the internal
generator of the dropper and the two variables are its state, all
exposed only because the drop test is inline in rte_red.h.

Fixes: de3cfa2c9823 ("sched: initial import")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst |  3 +++
 lib/sched/rte_red.c                    |  9 +--------
 lib/sched/rte_red.h                    | 26 ++------------------------
 3 files changed, 6 insertions(+), 32 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 88c06025b0..d4a3a7e7f2 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -226,6 +226,9 @@ Removed Items
   The only remaining method for detecting LLDP packets is by using
   the mbuf packet type in conjunction with the ``enable_lldp`` devarg.
 
+* sched: Removed the private random number generator used by RED: the
+  inline function ``rte_fast_rand()``.
+
 
 API Changes
 -----------
diff --git a/lib/sched/rte_red.c b/lib/sched/rte_red.c
index d7534d0bee..6d20afa9dc 100644
--- a/lib/sched/rte_red.c
+++ b/lib/sched/rte_red.c
@@ -5,14 +5,9 @@
 #include <math.h>
 #include <eal_export.h>
 #include "rte_red.h"
-#include <rte_random.h>
 #include <rte_common.h>
 
-static int rte_red_init_done = 0;     /**< Flag to indicate that global initialisation is done */
-RTE_EXPORT_SYMBOL(rte_red_rand_val)
-uint32_t rte_red_rand_val = 0;        /**< Random value cache */
-RTE_EXPORT_SYMBOL(rte_red_rand_seed)
-uint32_t rte_red_rand_seed = 0;       /**< Seed for random number generation */
+static int rte_red_init_done;         /**< Flag to indicate that global initialisation is done */
 
 /**
  * table[i] = log2(1-Wq) * Scale * -1
@@ -116,8 +111,6 @@ rte_red_config_init(struct rte_red_config *red_cfg,
 	 *  Initialize the RED module if not already done
 	 */
 	if (!rte_red_init_done) {
-		rte_red_rand_seed = rte_rand();
-		rte_red_rand_val = rte_fast_rand();
 		__rte_red_init_tables();
 		rte_red_init_done = 1;
 	}
diff --git a/lib/sched/rte_red.h b/lib/sched/rte_red.h
index 3b90cc46a9..ad11941ed5 100644
--- a/lib/sched/rte_red.h
+++ b/lib/sched/rte_red.h
@@ -15,6 +15,7 @@
 #include <rte_debug.h>
 #include <rte_cycles.h>
 #include <rte_branch_prediction.h>
+#include <rte_random.h>
 
 #ifdef __cplusplus
 extern "C" {
@@ -34,8 +35,6 @@ extern "C" {
 /**
  * Externs
  */
-extern uint32_t rte_red_rand_val;
-extern uint32_t rte_red_rand_seed;
 extern uint16_t rte_red_log2_1_minus_Wq[RTE_RED_WQ_LOG2_NUM];
 extern uint16_t rte_red_pow2_frac_inv[16];
 
@@ -102,23 +101,6 @@ rte_red_config_init(struct rte_red_config *red_cfg,
 	const uint16_t max_th,
 	const uint16_t maxp_inv);
 
-/**
- * @brief Generate random number for RED
- *
- * Implementation based on:
- * http://software.intel.com/en-us/articles/fast-random-number-generator-on-the-intel-pentiumr-4-processor/
- *
- * 10 bit shift has been found through empirical tests (was 16).
- *
- * @return Random number between 0 and (2^22 - 1)
- */
-static inline uint32_t
-rte_fast_rand(void)
-{
-	rte_red_rand_seed = (214013 * rte_red_rand_seed) + 2531011;
-	return rte_red_rand_seed >> 10;
-}
-
 /**
  * @brief calculate factor to scale average queue size when queue
  *        becomes empty
@@ -293,12 +275,8 @@ __rte_red_drop(const struct rte_red_config *red_cfg, struct rte_red *red)
 
 	pa_den = red_cfg->pa_const - pa_num_count;
 
-	/* If drop, generate and save random number to be used next time */
-	if (unlikely((rte_red_rand_val % pa_den) < pa_num)) {
-		rte_red_rand_val = rte_fast_rand();
-
+	if (unlikely((rte_rand() % pa_den) < pa_num))
 		return 1;
-	}
 
 	/* No drop */
 	return 0;
-- 
2.53.0

