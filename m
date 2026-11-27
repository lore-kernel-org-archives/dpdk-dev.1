Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E68606A31C
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Nov 2026 19:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=htW0ZQku
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E37940658;
	Fri, 27 Nov 2026 20:42:18 +0100 (CET)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by mails.dpdk.org (Postfix) with ESMTPS id E6A81402C4
 for <dev@dpdk.org>; Fri, 27 Nov 2026 20:42:14 +0100 (CET)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-8b3577deeb0so3822680b3a.3
 for <dev@dpdk.org>; Fri, 27 Nov 2026 11:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1795808533;
 x=1796413333; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qXE3S5yIr4NIpA7L+GG6ry+EYIOidHDxHFDrlw7pzQM=;
 b=htW0ZQku6Xb7L8tuYVeUiy57jiQtsw1H4qAhkafJyRYJa9MoiyJ+UpixsAVg+ZK1oe
 yK8UuhXPZVk0p2f8IgM50sZE4qPBWCm0F+BwmQVit4tpub3M1TqqCR0T62NUU9CsNhpO
 XmDOPyANT2r7gjZvSki49pLjySPpj+FZxB4u3NEQhiLIc/DckJVSunUkOeG7irVYySc2
 HpsfAvuwN8GUMS26cLngUty2j3siJ30RaMRE391M8l0bLPQeGv42823rc+0aR4vzUvq1
 6lpesu4ttee49p6gEN0g1rivvjb76mNqm9juJkkv+UlY/ygIOnWxFZdqJw/ceoPIZF1e
 zXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795808533; x=1796413333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qXE3S5yIr4NIpA7L+GG6ry+EYIOidHDxHFDrlw7pzQM=;
 b=Gl63upQPQQAjWaLlfRdrGK5Bm+F1zWuS+ot+DD5jXVGDszAe7EuQvHxiGjHnepH1mN
 CMrnhtwUFPTeENZ6kR1uSo5c3Vxf4EzzGNlpSqdzEbQrilw5f29dCOnzzB3htx+2MBKW
 fNNTTDITo7F9qL0nwZU3PB/0MyWK052K/yhaGAXetrjBr25HebhU0Y/UAA1bupvjfpgo
 LBpTz9a/KLzruVMtXeseN7iBM0U5GXRUEgUWO0vGBcv914QYGgNKbKQT35O/IupD+PLi
 CbBDQH2yUhAuadbCc/NASt78oPKlfuAVenBQRF2rmIHFTMuu5FcCNjaP76ZwiYOrV8+3
 KQhQ==
X-Gm-Message-State: APuU4Z98paeHHpLEG5q5dpKw/dSRMFmP2LtpmEYAWNVaWqOwtV0Sr/U5
 0/deTwYJKicdzqWw3nwxu8uYbeAjWvnZSOsHBA4SVCRYRn49m+mYcfMCAeyDR2n/9E/cXgqwuhX
 I1gGHpn8=
X-Gm-Gg: AZFdTZewoe6tUOS+FPoZZycM1fJ4Wk5oMJpQ+mAw4QVShM/V/kt65pyg9zEMZRzio1U
 JUeuKpudxZCaRR2d93HeP0DGq39jcDNWyDBFvkEGJNyxH7tu7saxwgyLN1t7uNParDyGFuLwVEy
 xpLn1djJs0sjn0f259nRHl/rIsyr7RzwldxljBVSc50OYsSShTnlmucc+ooQuVWuyi4qPR1Fq7s
 x5YxWUTKhGYIm7C3kbp+kOq4kfLUY06i96Cv9VoflfhMEjpitzFT/zKJiTc5RxioKfuGpIJVfJE
 9RnNI1TbpUYz4xOf0FmZX9lSH5kF53fuMor+UrygrIKaMZ8UH/gBZtmLZAW98EJ9+ig0IbMrput
 SvpvXsmIbXByUtAeh2JLo18v9oA9SScmF6c5h7iHwsLKcCQvvq7ll2qlI4GAydKj9lzZ4t1dVLJ
 bCOf841ru0Tv1liWB8KHNrQdFgyPRkjoECrMIa3Waizu6x8Me08c+Dviz0MQlsLPgjp2y0uRz1o
 FWFlFBnZmvXP6kJJKjoYfj8nLxTgetbQVnVETShcS7xQbTmLY+BHGsDqvG9YiE9oamex7nXfH9L
 hcc9ssAOEfpt0B1RkZmrnIGEqa/+SPE1G/klDo01dVZ0m3+UZbHlp+2xX1v+6WGEIXOm
X-Received: by 2002:a05:6a00:b90:b0:888:4f06:903f with SMTP id
 d2e1a72fcca58-8c87cb4bb44mr23142224b3a.38.1795808533340; 
 Fri, 27 Nov 2026 11:42:13 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c872951febsm12881051b3a.14.2026.11.27.11.42.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 11:42:13 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 2/5] random: always use getentropy
Date: Fri, 27 Nov 2026 11:39:34 -0800
Message-ID: <20261127194209.107396-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127194209.107396-1-stephen@networkplumber.org>
References: <20260915192207.3926217-1-stephen@networkplumber.org>
 <20261127194209.107396-1-stephen@networkplumber.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
 lib/eal/common/rte_random.c  | 6 ++++--
 lib/eal/include/rte_random.h | 7 ++++---
 lib/eal/meson.build          | 3 ---
 3 files changed, 8 insertions(+), 8 deletions(-)

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

