Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86494C88E77
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 19:22:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 078F142E4C;
	Tue, 15 Sep 2026 21:22:30 +0200 (CEST)
Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com
 [74.125.228.41]) by mails.dpdk.org (Postfix) with ESMTP id 6C46442DCE
 for <dev@dpdk.org>; Tue, 15 Sep 2026 21:22:28 +0200 (CEST)
Received: by mail-pz2-f41.google.com with SMTP id
 41be03b00d2f7-cc50d1b048eso34192a12.1
 for <dev@dpdk.org>; Tue, 15 Sep 2026 12:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789500147;
 x=1790104947; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RIOjAFWGgkcZt+PWSl0Jni2bTy3jALEBxAB5zE7b9a4=;
 b=bz2MzvyLEi3cEsTrsYrMd4oOSYTlESV92N67ihfzVlgwRNHqo0uw71sGfW83/eYWKG
 fn8ZI/MC5xJakzwIolWsyUe2bkKC+KgMEek4k2X22Pxi4NBYIsCeieBwPITSzljWDxX5
 gdVNUklbBiiHijzD+xRZJlY8inrwF9lt9Aeo3+8w7/dE1pmzA/2k+jKhDilq+ZDdWova
 XqiKLAps1DJP7fX9togVU4fsOgU2DI2q5xmxtbFUhGSgDQ6WHtB1zUultX3RFV3RCATv
 b1dr3lddoRyQH39sMZRLT3HvRN0hdymlTYC63rMZHJU9RHDvNGUgO89vLFXwzdzl8pWy
 RikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789500147; x=1790104947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RIOjAFWGgkcZt+PWSl0Jni2bTy3jALEBxAB5zE7b9a4=;
 b=GdN10osCuIel0akRazSU6VeXTdHSTTOXDS2cpPMqNTkKhl0a13pHLZMPis15YeQfvR
 S3JXu8dOh4GgvjDp61CDbYxzDkmuWPrqIMYRODXhldQ/cPygNVQIsQzvQsOMdvRaWTAP
 BRgrCOvf8gZyYSaRJXg9tJ+eWCY6Ued5hDAcjH6iaxhw0J1vPNf78If/mnYbuEHW5aEF
 9rI0pgBvfaP3NciyJpBeWNhsgQ8aIcXCLIIBWVjqq9H7JrI0dvqpS59Ba587YAzQCzfp
 3RjkwKG2Dlq7qSyGjlMBf41zfitj50bVhaE8Eoc9Dsgr77B/S5PEvp6nZajaYlvkvUSr
 PPjQ==
X-Gm-Message-State: AFuF++koNdxP6zekXk/xEWgqqZWuBx18KAzaeWdrn98UR2CUjsKLk75q
 OUQ7UbjghwyNmm+75uzYvAjJDspwdeWJaOb4mpxgub/SPB3UydXOtwVOm5Ut2OzalhcKdbnMQ+n
 iG5sYzTGteg==
X-Gm-Gg: AYBFou3AogDjnoHxlLPRfHrt7rBkYzwNdXcOm+aLbSElkeZdqiiEfWcmnqfH8gKPjod
 5V3atoa+spm9Ygwba6seZ9YkJKjtDg6/L6Blmm9Ruq5TTUKYpmdJLTO25pHdJAWuzvk2pK6GMK/
 lBqcmhDussaA3EtD1c+NrzVD0RaaZIqHgBfsR6tQnCV0gcWZdbOAtkfJVjvDz3fOAoUSOjXM3Ms
 0AyLCIM1yi+Ht+RtFVR6hdP8Ldusgaj6jXKfKXOWgas/c6CwUlpeluGzf5yPBY2YN2e8CxSzsnR
 i2b5w88gjtmGNdJsy1TmzSI5vbXPn1i2WWOuv9oVnHOlrt1Uueh5oJCNkwcMFbDeJWKXN5JNGKd
 C2TCOdrdGoiq4Jn9UgEmtoAYLoEFTg1lg83UeVb1h//eSUlmnxwcXVckiN4QHJalvg2FkCSgbwW
 Jh7TUUEfRO894obj+WOsctQvylxGBlI41PBeiAvfedEwKMwWELoGkAuQUymyFMdj1HMfLV3ZvWM
 +34aJqa4ccsB3XKLyf2QntJVwQStOhVIqhU9w==
X-Received: by 2002:a17:90a:1188:b0:39d:f064:3a68 with SMTP id
 98e67ed59e1d1-39df0646a31mr9590492a91.21.1789500147455; 
 Tue, 15 Sep 2026 12:22:27 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e1bbfdd49sm217535a91.11.2026.09.15.12.22.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 12:22:26 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH 04/18] sched: fix data race in RED random number generation
Date: Tue, 15 Sep 2026 12:21:02 -0700
Message-ID: <20260915192207.3926217-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915192207.3926217-1-stephen@networkplumber.org>
References: <20260915192207.3926217-1-stephen@networkplumber.org>
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

RED used a private LCG whose seed and cached value were globals shared
by all lcores without synchronisation. The QoS framework documents
running different ports on different threads, so this is a data race.
The values do not tear, but updates are lost and drop decisions become
correlated across queues.

Use rte_rand32() in the drop test instead. Its state is per lcore, so
nothing is shared and no cache is needed. PIE already does this with
rte_drand().

This removes rte_fast_rand(), rte_red_rand_seed and rte_red_rand_val,
which were only used by RED itself. Removing exported symbols breaks
ABI, so this cannot be backported.

There is no prior deprecation notice for these symbols. They were
never meant to be part of the API: rte_fast_rand() is the internal
generator of the dropper and the two variables are its state, all
exposed only because the drop test is inline in rte_red.h. Keeping
them for a release would mean keeping the data race, which is the
bug being fixed.

Fixes: de3cfa2c9823 ("sched: initial import")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst | 12 +++++++++++-
 lib/sched/rte_red.c                    |  9 +--------
 lib/sched/rte_red.h                    | 26 ++------------------------
 3 files changed, 14 insertions(+), 33 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 1dc634d504..c1742b3c60 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -85,6 +85,12 @@ Removed Items
     ``rte_rib6_is_equal``
   * table: ``RTE_LPM_IPV6_ADDR_SIZE``
 
+* sched: Removed the private random number generator used by RED: the
+  inline function ``rte_fast_rand()`` in ``rte_red.h`` and its global
+  state ``rte_red_rand_seed`` and ``rte_red_rand_val``. Its state was
+  shared by all lcores without synchronisation. RED now uses
+  ``rte_rand32()``, which has per lcore state.
+
 
 API Changes
 -----------
@@ -101,7 +107,6 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
-
 ABI Changes
 -----------
 
@@ -117,6 +122,11 @@ ABI Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* sched: Removed the exported variables ``rte_red_rand_seed`` and
+  ``rte_red_rand_val``. They held the state of the private random
+  number generator used by RED, which has been replaced by
+  ``rte_rand32()``.
+
 
 Known Issues
 ------------
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
index 3b90cc46a9..8c9d86f6f5 100644
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
+	if (unlikely((rte_rand32() % pa_den) < pa_num))
 		return 1;
-	}
 
 	/* No drop */
 	return 0;
-- 
2.53.0

