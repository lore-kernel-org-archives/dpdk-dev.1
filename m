Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8218CC88E75
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 19:22:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C818342E3A;
	Tue, 15 Sep 2026 21:22:23 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 55AF442E12
 for <dev@dpdk.org>; Tue, 15 Sep 2026 21:22:22 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396ccd5cf02so86443a91.3
 for <dev@dpdk.org>; Tue, 15 Sep 2026 12:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789500141;
 x=1790104941; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=66+ZyTVx6pLo5AscgmNYd9JCgq9uMwTEcGq+Ze+3uBs=;
 b=arxcJ2Vb9LKg8zwnRi1Yh0qFRnmeQo7pnDW2qlyq4vF5azCvnYSJxG0DVVl2pzF/oa
 wST29Zz56UNhYzJRpaEmfZCdOaufDw+S4g1eoMDSzu4KrQ/rvMibIMeh7cBGXprc37B1
 R4LTGo5JUeETkGlq9pyn2JzSJ++S6rgMarsV/NDZ4lnwMolnixyLwE6dun22NbA0Ard1
 TTs3Ofuhh/rulw4wZImEa/M6+VRQxrTqk3UMxhY2yxYWYCeKkv/AHzMcKXo3YH2TdMgZ
 0iP/NAXd6riBFgX3sM9xzCdu5tWjoHXgIoQc8QJsvnMnUTgy5Tf753EI4RNj6BEIV0sv
 fSKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789500141; x=1790104941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=66+ZyTVx6pLo5AscgmNYd9JCgq9uMwTEcGq+Ze+3uBs=;
 b=jIearzntCtfns/kVIE+WtE9TeaNIb97lyG1A9mSOd3sVKgqBaoTvr61suWhASDc275
 TctdvrBvxIUiw5jdS1dnJ+ps3/ON2sBMehLJTcuCHxAOhFK4BUF2D3YpNgWu+MfkmWt8
 bR10E8/AQFSfvRIzNhEBzN3h4fL22CbpNfJnNQi95bvu5yE0iyYTGgm8TXNxLxut90Qo
 vpUGnTH6nqKMYLcJrsbaO6p/D3JvAZtpX4ln8CDawgPP00yuckGlatZACu1dNGGkr6jw
 /Krbq9d3EsknO4NsRLGbbEuKjjxc6KSYr/R3oTFxUFevjd3Gie30+YhJpX6UgBSVaaAG
 jadA==
X-Gm-Message-State: AFuF++ndcnhHOJI8SlA5xW1iTmUvXh5+SiFgFJC3CdAh2C+D7V9kD2ev
 0n3OYunGIzrgsEhruhMFkZElIqZxfQ1giFr6zooSRvm11p88NXL0jthY20hce7/zvUwB9Oj18ws
 7bv1Xwn6W4A==
X-Gm-Gg: AYBFou1M4N60uaHRBeYO10h8ipUM2+ovL07eA1Zi5eTsMFWQKlj3EyE67xdH2uPuT2l
 D8Mv6javJ0wgx9Kytzm/6uhStPjFuJbx9JYoxQ/HWXyuqtER2tSS8k7/5oY5f6OHhDplUycviep
 7oODEali9pu8xg/BReTcKSzqdBcB1hbPKjGeGAgNho1VRSJ0Gaj65SprX9nWYCSX7c59ysPpWYa
 ufwW2F2LIHB9MBfZwKNXXej2voZnWIDpWmYANwnkl/MTil1mzmnsS9ANTwDN6lVbLC0qwIXi6Xa
 L4js9aGeZCC3RSrUs8E6p1bgAE5FJPjKUWtVzt4Cl8tFxFILXg/Y2aitEsNXaWVA7tcx/0llgbM
 ra5kIn/EaAZjgLqkZfhHXJWFLUN5OG1ASRKrpE3soX1ddCKvEsPaex+0LG6esKkTMaTQnKUYlxX
 aQ2mbxWWCbcovSwTdHWGt7RvHSaQHy038BSdexJlPpl5R651i6ypZIX5Mbqza+aDzhl3mqogUG3
 b0D4KkvhTys/CFxjqjm8BxOgltVBlhmKReyZQ==
X-Received: by 2002:a17:90b:3bc7:b0:39e:433:23b3 with SMTP id
 98e67ed59e1d1-39e10fbb146mr4548596a91.14.1789500140758; 
 Tue, 15 Sep 2026 12:22:20 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e1bbfdd49sm217535a91.11.2026.09.15.12.22.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 12:22:19 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 02/18] random: always use getentropy
Date: Tue, 15 Sep 2026 12:21:00 -0700
Message-ID: <20260915192207.3926217-3-stephen@networkplumber.org>
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

The cc.has_function() check compiled its test program under strict
-std=c11, where glibc hides the getentropy() declaration behind
_DEFAULT_SOURCE. The probe therefore always failed on Linux and
RTE_LIBEAL_USE_GETENTROPY was never defined, silently falling back
to RDSEED or TSC for the initial PRNG seed.

Now that a getentropy() wrapper exists for Windows it can always be
enabled. Removing the conditional means any future regression is a
link error rather than a silent downgrade of seed quality.

Falling back to the TSC now logs at ERR level, including the errno
from getentropy() so that a blocked syscall can be told apart from
other failures. A TSC derived seed only varies by process start time,
which a co-resident attacker can bound.

This requires glibc >= 2.25, which all supported distributions meet.

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
index 87c7e81bde..5852f7acfb 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -55,6 +55,10 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
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
index f9fcee24ee..2bf3c67439 100644
--- a/lib/eal/meson.build
+++ b/lib/eal/meson.build
@@ -24,9 +24,6 @@ endif
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

