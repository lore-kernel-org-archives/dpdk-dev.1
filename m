Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4F2606A31B
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 17:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=m09/4L1q
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09EDE4068A;
	Tue, 20 Oct 2026 19:57:38 +0200 (CEST)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 7EAA240151
 for <dev@dpdk.org>; Tue, 20 Oct 2026 19:57:36 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2dd76b1361dso6910875ad.1
 for <dev@dpdk.org>; Tue, 20 Oct 2026 10:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792519055;
 x=1793123855; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7JQAsaPOpHcq4WORXTbL2AStabQRuBUwBD1yJgKTOkA=;
 b=m09/4L1q/TLDe910rF2pD60vGTC5GuyQpwKfHghc41rgzp9OgvFTUZdoFifvx+seU0
 xjFYosBQoqDZGeSzkaeVeghmLzodHtfC2zJSBR736CmyP84jfkTqwx05WL/K9LSpmmAf
 x45cP1RrRGxiURzRzR+sZR+QNdkfvBs/7JwMkoFMDGOtgyGHIlhMnppJoFbjq4SQb8QV
 7NCwZEm7/E0mJUg6BcCyD4zljHmHK7g9+gaGp0/4Kwyc0b6Xpq0UKko0hT/MfwAgzHQ0
 I2sdUlXtNGem5j1Ge2ira46D2TBVBpzg+agP5PV9Ee7CHSDv0xP4YV9huRD1axO0t3QY
 NvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792519055; x=1793123855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7JQAsaPOpHcq4WORXTbL2AStabQRuBUwBD1yJgKTOkA=;
 b=f6LnH1TR995FX9+TuBAc3RNgmP2edB8lifVC5ZONEuIdr+ZYJxURwCMwwziMASkODv
 m9CopVkYuyXMVZltQMVDHl1oi65FcJA5jJpxCCdU1E87LOGKDN0aumH3fVkFrhKWUvWW
 ivfcXK9ytmyC4aVWvti428TC/NrHZyJorQYhqUVtBuKUuJIKQ64sIVLTVSTdvUaOJoEv
 /7Fjewkkw8KQ9Vwpc0mBu2S2DgW7xemhp02lacNV77MdDrj5fHqli8VfB6tmKQ3Jk4/H
 wBqSNxFH01qb7DupRM/ZNCNp30NSQ0LmziHHv9KLR991xy6JHU2CK3S+I3MYDZlRqEcu
 /QCQ==
X-Gm-Message-State: AFq9FYJHoP4fZL/rnC7ZuQP9RNG8UVGSSdTL1IJgxOAJxkMhyKCSepta
 UVEASlAC/ben7kitJ2haupnc8/JwO0PE5JSN3eq1fu3kMW1S44vgwuYBPq7w+ICu88jASZoUg8l
 REsU5zRw=
X-Gm-Gg: AYBFou3uyuAl1TtFcRA2FZK7mSIyLNOMREdGdLVKLePNYhCE6jjubp227/ekiXyE3cd
 SN+/tByieAdTuD1ZOC5Ji0VMdQtoEk8Lmc9L19MV6Vzc7EQhI4lWz0i1ll06ATURHjyH3AO9z2K
 /LqyrYNzfeI3MJhGjNBWvYcjySDrqCiuwJFwpc20WyDZce0yQOY3uoHUL1ndyUwatYxnLDmnW0A
 Y79SmYIoBRqA0ULPMN/fUWBO0QdEAJoTEAluepurdkhmkJYRrBXzsLZmjFWs0iiOnCOkz7Xso+B
 ILuDUxdIq+pS2ccWAQXkMCzK82jYuqGqYiCVIPbzclzSKj6O4rnPptoa1Y3vanUBashC+P0HM6Y
 fuCn6I6SXMG6LGEeUv4pIH+lEziVYpLpSLnK2gH09+oklBAgftoF0vn+WZMAHoXP8qy1dOSCSfR
 ySHDHr1dHEXTlOFMcfQFIJ8WktC9sxA3ZgzG5NwAAcZ+8iT5Cc+bYoSH/ME6w9xY8CZBSNeg3Vq
 5tWbta4iT4Dnd0mPu2/F/akzzHAdCdaXq/bpA==
X-Received: by 2002:a17:903:2312:b0:2e4:b37a:d577 with SMTP id
 d9443c01a7336-2e9a6e45ae4mr88374735ad.43.1792519055001; 
 Tue, 20 Oct 2026 10:57:35 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea3b43236esm1997875ad.29.2026.10.20.10.57.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 10:57:34 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 1/3] eal: add function to convert TSC to epoch time
Date: Tue, 20 Oct 2026 10:55:42 -0700
Message-ID: <20261020175732.1552406-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020175732.1552406-1-stephen@networkplumber.org>
References: <20261020152907.2607513-1-dawid.wesierski@intel.com>
 <20261020175732.1552406-1-stephen@networkplumber.org>
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

The pcapng library converts the TSC into nanoseconds since 1/1/1970,
because that is what the pcapng file format records. Nothing about
that conversion is specific to packet capture: it needs the TSC
frequency and a reference point relating the TSC to the wall clock,
both of which EAL already has or can take at init.

Record the TSC alongside a CLOCK_REALTIME reading while the TSC
frequency is being determined, and add rte_tsc_to_ns() to convert any
TSC value using that reference point. The seconds are computed before
the remainder is scaled, so the multiply by NS_PER_S cannot overflow.

The reference point is taken per process rather than shared through the
memory config, so a secondary process may differ from the primary by
the sampling error.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/api/doxy-api-index.md              |  1 +
 doc/guides/rel_notes/release_26_11.rst |  6 +++
 lib/eal/common/eal_common_timer.c      | 59 ++++++++++++++++++++++++++
 lib/eal/include/rte_time.h             | 34 +++++++++++++++
 4 files changed, 100 insertions(+)

diff --git a/doc/api/doxy-api-index.md b/doc/api/doxy-api-index.md
index 62390f7be3..97b908667c 100644
--- a/doc/api/doxy-api-index.md
+++ b/doc/api/doxy-api-index.md
@@ -73,6 +73,7 @@ The public API headers are grouped by topics:
 
 - **timers**:
   [cycles](@ref rte_cycles.h),
+  [time](@ref rte_time.h),
   [timer](@ref rte_timer.h),
   [alarm](@ref rte_alarm.h)
 
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index be758a0c02..5f960692e2 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -73,6 +73,12 @@ New Features
   Added the experimental ``rte_cpu_socket_id()`` function
   to map an OS logical CPU ID to the NUMA socket containing that CPU.
 
+* **Added API to convert TSC to epoch time.**
+
+  Added the experimental ``rte_tsc_to_ns()`` function in ``rte_time.h``
+  to convert a TSC value into nanoseconds since 1/1/1970,
+  using a reference point recorded during EAL initialization.
+
 * **Added pile stack and mempool driver.**
 
   Introduced pile, a lock-free, stack-like implementation,
diff --git a/lib/eal/common/eal_common_timer.c b/lib/eal/common/eal_common_timer.c
index 67ede70c62..4dfb7099b3 100644
--- a/lib/eal/common/eal_common_timer.c
+++ b/lib/eal/common/eal_common_timer.c
@@ -8,8 +8,10 @@
 #include <rte_common.h>
 #include <rte_log.h>
 #include <rte_cycles.h>
+#include <rte_os_shim.h>
 #include <rte_pause.h>
 #include <rte_eal.h>
+#include <rte_time.h>
 
 #include <eal_export.h>
 #include "eal_private.h"
@@ -18,6 +20,10 @@
 /* The frequency of the RDTSC timer resolution */
 static uint64_t eal_tsc_resolution_hz;
 
+/* Reference point relating the TSC to the wall clock, taken at init */
+static uint64_t eal_tsc_base;
+static uint64_t eal_epoch_ns;
+
 /* Pointer to user delay function */
 RTE_EXPORT_SYMBOL(rte_delay_us)
 void (*rte_delay_us)(unsigned int) = NULL;
@@ -39,6 +45,36 @@ rte_get_tsc_hz(void)
 	return eal_tsc_resolution_hz;
 }
 
+/*
+ * Convert a count of cycles to nanoseconds.
+ *
+ * Compute the whole seconds first, so that the remainder is always
+ * less than the frequency and scaling it by NS_PER_S cannot overflow.
+ */
+static uint64_t
+cycles_to_ns(uint64_t cycles)
+{
+	uint64_t secs = cycles / eal_tsc_resolution_hz;
+	uint64_t rem = cycles % eal_tsc_resolution_hz;
+
+	return secs * NS_PER_S + (rem * NS_PER_S) / eal_tsc_resolution_hz;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_tsc_to_ns, 26.11)
+uint64_t
+rte_tsc_to_ns(uint64_t tsc)
+{
+	/*
+	 * A caller may convert a TSC value sampled before the reference
+	 * point was taken, so handle both directions on an unsigned
+	 * magnitude.
+	 */
+	if (unlikely(tsc < eal_tsc_base))
+		return eal_epoch_ns - cycles_to_ns(eal_tsc_base - tsc);
+
+	return eal_epoch_ns + cycles_to_ns(tsc - eal_tsc_base);
+}
+
 static uint64_t
 estimate_tsc_freq(void)
 {
@@ -52,6 +88,27 @@ estimate_tsc_freq(void)
 	return RTE_ALIGN_MUL_NEAR(rte_rdtsc() - start, CYC_PER_10MHZ);
 }
 
+/*
+ * Record the TSC value matching a wall clock reading, so that any TSC
+ * value can later be expressed as nanoseconds since the Unix epoch.
+ * Read the TSC either side of the clock to halve the sampling error.
+ */
+static void
+init_tsc_base(void)
+{
+	struct timespec ts;
+	uint64_t cycles;
+
+	cycles = rte_get_tsc_cycles();
+	if (clock_gettime(CLOCK_REALTIME, &ts) < 0) {
+		EAL_LOG(WARNING, "Could not read wall clock,"
+			" TSC to epoch conversion unavailable");
+		return;
+	}
+	eal_tsc_base = (cycles + rte_get_tsc_cycles()) / 2;
+	eal_epoch_ns = rte_timespec_to_ns(&ts);
+}
+
 int
 init_tsc_freq(void)
 {
@@ -71,6 +128,7 @@ init_tsc_freq(void)
 		}
 
 		eal_tsc_resolution_hz = mcfg->tsc_hz;
+		init_tsc_base();
 		return 0;
 	}
 
@@ -87,6 +145,7 @@ init_tsc_freq(void)
 	EAL_LOG(DEBUG, "TSC frequency is ~%" PRIu64 " KHz", freq / 1000);
 	eal_tsc_resolution_hz = freq;
 	mcfg->tsc_hz = freq;
+	init_tsc_base();
 	return 0;
 }
 
diff --git a/lib/eal/include/rte_time.h b/lib/eal/include/rte_time.h
index c5c3a233e4..3122e062ab 100644
--- a/lib/eal/include/rte_time.h
+++ b/lib/eal/include/rte_time.h
@@ -5,9 +5,17 @@
 #ifndef _RTE_TIME_H_
 #define _RTE_TIME_H_
 
+/**
+ * @file
+ *
+ * Time and cycle counter conversion.
+ */
+
 #include <stdint.h>
 #include <time.h>
 
+#include <rte_compat.h>
+
 #ifdef __cplusplus
 extern "C" {
 #endif
@@ -102,6 +110,32 @@ rte_ns_to_timespec(uint64_t nsec)
 	return ts;
 }
 
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Convert a TSC value into nanoseconds since the Unix epoch.
+ *
+ * EAL records the TSC alongside a CLOCK_REALTIME reading during
+ * initialization, and this converts using that reference point and the
+ * TSC frequency.  Values sampled before initialization are also handled,
+ * and the result tracks the wall clock as it was at init: later changes
+ * to the system time are not reflected.
+ *
+ * Each process takes its own reference point, so values converted in a
+ * secondary process may differ from the primary by the sampling error.
+ *
+ * Must be called after rte_eal_init(), which fails if the TSC frequency
+ * cannot be determined.
+ *
+ * @param tsc
+ *   A value read from rte_get_tsc_cycles() or rte_rdtsc().
+ * @return
+ *   Nanoseconds since 1/1/1970.
+ */
+__rte_experimental
+uint64_t rte_tsc_to_ns(uint64_t tsc);
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.53.0

