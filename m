Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E72CA9EBB
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 02:29:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F294E4064F;
	Sat, 10 Oct 2026 04:28:59 +0200 (CEST)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by mails.dpdk.org (Postfix) with ESMTP id 7EAAB402DC
 for <dev@dpdk.org>; Sat, 10 Oct 2026 04:28:55 +0200 (CEST)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-88c72646f03so112327b3a.2
 for <dev@dpdk.org>; Fri, 09 Oct 2026 19:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791599335;
 x=1792204135; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1GJSB2ELg35ukk55VzQQ+LIgh7vCfGQ842QiPY5J9MY=;
 b=gkat5pTDpWeYt/b3FV98a7iqTWGSQC5NlE/E0kBeABL3g7OdIn3qdKDITMILpefwUx
 jpYpO71Np39Hz03L4Y79BQ+xbUwcX+Kg4ga+sd/BghoCMFFMnAMd8MEmc3kKeoH9CuxD
 Ww46MvJd9XF4PS07nxazWukM4Fkf2TAKKvxFCANMgTzg7UID8LS2IB9/Wudm87KAh5LC
 0asOWcGWbI3wCxKq78fZJ4qwGLpMn+6N1vNZZOVs+tfNTttJvW3YZ3v55OFqbHvuijj1
 SroQxng4SSholgSKLAmC65l1SXwHYp2Rw5+Y2xbKZbiPK0asFB6r87aLAGj6MMCNEDMq
 jnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791599335; x=1792204135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1GJSB2ELg35ukk55VzQQ+LIgh7vCfGQ842QiPY5J9MY=;
 b=AIJtwWXzydOocSD0YST7N0+8TPW93TzZ0L35eeYkLgYeN/UtvThJqhUzHYGY3oQEYF
 /uuwQu8szWSZEUFvNnM+YG5NarmuD4WVpFbEdWdyl9aSzRiuZm/PdAE++pYDylAawIFd
 lZ9CTdkoF1Yur7v6yRNvdbbEaBeFyuV1LASh5l2Bk1VhPYku9OkpZtJEUnnAE2ZS7RRi
 CQakN7e63Ms3y/sP2j+IRiQ4CumgfhK8KfSbfNp1Jnr7gALnAtBy0E0gRnkdATGQNHQR
 3+el1Qn6DRQrMo84thmac2Q4UrFkBHeaCOMybO95jwdLtTpiDNvwC+FVVGRhnWKkgwFN
 WW9g==
X-Gm-Message-State: AFq9FYLuqKOT1K0wdlzjyv+9neKtpRLUO68dZ0qdWKJRtWd1kvZj/2h8
 IMJFrCRhspStvOCZp0mMYokc+vqMM3zJqomRFyc/nkB53c5AKexD8AvSD/cd5kOck5ErnNrKkVz
 puDvcuLE=
X-Gm-Gg: AYBFou0Ypo3UMVpSAKH3g3TfS5LvYwDJcXAd3mXhQIxLbXiYJFwyAdYF27/4/Er4LSA
 rv1Y3Ht0MMMsRajtsBJz+6+wbQcrU9U/mtDm2If0Xw4ael3DomWapMcZbUBeWLh+Mbz7hMHikLl
 gvORpNIWV2pB0cut1ZRuCNlPInqxzzFghEvnwVeds171wgtSKJFLWdY3E5jDaSVBx2XEEquxZXG
 ET8TJ6sMwJiVDPyGcSFk4SXIVpEc0hQGy0XX7ZhSwbFQwfogCaxkyCFDpv9G6QLe6HphBYf4Gkb
 3kele1u/7pbH7/Rbs+V7hoeN3yKkKpsf03enlxEaoX3PVc58k+Qhv+t3xJebH9MBfothSgbHGfx
 rs+Bl5plrtDmX1jnUGnCcrJhfaZG3d9zsP9Vji8lhnkbR2INfLBGyDg+EzXxcLqQXK3G7YOlxn4
 5Z4BrY7rJGAET0I3F3H7b9gIiLSHZZIlWI19qVm0b4jbEi92/oo0iYZNFOA59OcczB5jiXBnAKr
 OpEbRxx3bAE8bUccKX/Z7HCttA+2QjgOYtNtQ==
X-Received: by 2002:a17:90b:3a48:b0:3ab:1601:e5d6 with SMTP id
 98e67ed59e1d1-3ab3a2910eamr3412688a91.4.1791599334627; 
 Fri, 09 Oct 2026 19:28:54 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab3690474esm6202882a91.0.2026.10.09.19.28.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 19:28:54 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v2 2/5] random: always use getentropy
Date: Fri,  9 Oct 2026 19:27:04 -0700
Message-ID: <20261010022851.1872825-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261010022851.1872825-1-stephen@networkplumber.org>
References: <20260915192207.3926217-1-stephen@networkplumber.org>
 <20261010022851.1872825-1-stephen@networkplumber.org>
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

The current meson build check for getentropy support is broken
and getentropy never gets used!

The cc.has_function() checks with -std=c11 but glibc hides
getentropy behind _DEFAULT_SOURCE. Therefore the probe always
failed, and code would fallback to RDSEED or TSC
for the initial PRNG seed.

Now that a getentropy() wrapper exists for Windows it can always be used.

Falling back to the TSC now logs at ERR level, including the errno
from getentropy() so that a blocked syscall can be told apart from
other failures. A TSC derived seed only varies by process start time,
which is easily determined by local attacker.

A backport needs the preceding patch which adds the Windows
getentropy() shim, otherwise the Windows build breaks.

Bugzilla ID: 2035
Fixes: faf8fd252785 ("eal: improve entropy for initial PRNG seed")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst | 4 ++++
 lib/eal/common/rte_random.c            | 6 ++++--
 lib/eal/include/rte_random.h           | 7 ++++---
 lib/eal/meson.build                    | 3 ---
 4 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 88c06025b0..9bef8b4774 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -158,6 +158,10 @@ New Features
   Added ``rte_bbdev_queue_stats_get()`` function to retrieve statistics
   for a specific queue, complementing the existing device-level statistics API.
 
+* **Updated random number generation.**
+
+  * The initial seed is now always taken from ``getentropy()``.
+
 
 Removed Items
 -------------
diff --git a/lib/eal/common/rte_random.c b/lib/eal/common/rte_random.c
index 537fa035ee..b036c50349 100644
--- a/lib/eal/common/rte_random.c
+++ b/lib/eal/common/rte_random.c
@@ -7,6 +7,8 @@
 #include <x86intrin.h>
 #endif
 #endif
+#include <errno.h>
+#include <string.h>
 #include <unistd.h>
 
 #include <rte_bitops.h>
@@ -219,7 +221,6 @@ rte_drand(void)
 static uint64_t
 __rte_random_initial_seed(void)
 {
-#ifdef RTE_LIBEAL_USE_GETENTROPY
 	int ge_rc;
 	uint64_t ge_seed;
 
@@ -227,7 +228,6 @@ __rte_random_initial_seed(void)
 
 	if (ge_rc == 0)
 		return ge_seed;
-#endif
 #ifdef __RDSEED__
 	unsigned int rdseed_low;
 	unsigned int rdseed_high;
@@ -238,6 +238,8 @@ __rte_random_initial_seed(void)
 		return (uint64_t)rdseed_low | ((uint64_t)rdseed_high << 32);
 #endif
 	/* second fallback: seed using rdtsc */
+	EAL_LOG(ERR, "getentropy() failed (%s), seeding PRNG from TSC: seed has low entropy",
+		strerror(errno));
 	return rte_get_tsc_cycles();
 }
 
diff --git a/lib/eal/include/rte_random.h b/lib/eal/include/rte_random.h
index 15cbe6215a..978ecda203 100644
--- a/lib/eal/include/rte_random.h
+++ b/lib/eal/include/rte_random.h
@@ -20,9 +20,10 @@ extern "C" {
 /**
  * Seed the pseudo-random generator.
  *
- * The generator is automatically seeded by the EAL init with a timer
- * value. It may need to be re-seeded by the user with a real random
- * value.
+ * The generator is automatically seeded by the EAL init from the
+ * random source provided by the operating system, so there is no need
+ * to re-seed it to get unpredictable values. Seeding it explicitly is
+ * useful to make a run repeatable.
  *
  * This function is not multi-thread safe in regards to other
  * rte_srand() calls, nor is it in relation to concurrent rte_rand(),
diff --git a/lib/eal/meson.build b/lib/eal/meson.build
index 092f5c5261..a261bdd48b 100644
--- a/lib/eal/meson.build
+++ b/lib/eal/meson.build
@@ -22,9 +22,6 @@ endif
 if dpdk_conf.has('RTE_HAS_LIBARCHIVE')
     ext_deps += libarchive
 endif
-if cc.has_function('getentropy', prefix : '#include <unistd.h>')
-    cflags += '-DRTE_LIBEAL_USE_GETENTROPY'
-endif
 
 if is_freebsd
     annotate_locks = false
-- 
2.53.0

