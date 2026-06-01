Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73521CD5BD1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 17:21:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A0B544042C;
	Mon,  1 Jun 2026 19:21:11 +0200 (CEST)
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by mails.dpdk.org (Postfix) with ESMTP id 23A44402DB
 for <dev@dpdk.org>; Mon,  1 Jun 2026 19:21:09 +0200 (CEST)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-137dd5161feso191036c88.1
 for <dev@dpdk.org>; Mon, 01 Jun 2026 10:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780334469;
 x=1780939269; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ae8/lHizTTSnCgYj5Ok7GBDXvqThnAgMvwmyZvHaVBc=;
 b=02bET440jANBSdSbpKh2/qY3ZOscx5BbSapUb2UthTM+nydGIUr51tzEWE7QKnrzQv
 /tiy54scAMnIj+PpsPcxEPWQ6MzXrVHqNOTloWtevvufrUqVZkiyGA5jd95ez5RmmRpF
 UQitljoRdbZUUfNgBDk/fg/SYsX1m4C9NzkB+8d4E3dSF72p2YrYlY0uANrMU+ubqjEw
 sNer4qjjqddV+RESDgrpOABoaDiCvIaCj3YVrlOLOmfxgxNo0HUOr/+gIiP0Dumcx+yi
 9guRqgIHhWiBqs7pE0tbc4iscc/x3VAv/dWK3AikNEKjOndNgUoMjiYF56Qq3DyKGiVi
 qAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780334469; x=1780939269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ae8/lHizTTSnCgYj5Ok7GBDXvqThnAgMvwmyZvHaVBc=;
 b=K/uGTD8LJ2kMB4bZ7CYH0xr33isvVFvrlF43mUrbtYAf4qZUC1duTwc0fTe6ZbiSmm
 u+o+btnjOdALSN6byGG9TsyT0RGQawR9chymxCLRTu8M2yuCTjVOH4iD55AfBHXZ36/N
 GfZHO9eCdkJMzH8XzcXP49YWgV9JIMlEQoHX+g1jJxJw7Qul/bVKg+OZPD+MOoegoEkr
 pYqku/ICXtYzX6DfJA4D1e/wqslvQwfBktgoaW7ggZtmwrtkKPXvOWgM4G95hgt1hF8x
 5f2FuTf5sa2wRuYutCAjMIOg4I63VSOgeolUzsvD0tTQFuHD33+R2B2Gj+DQ0vErWs3p
 HQ+Q==
X-Gm-Message-State: AOJu0YxhoZKWKcpXk62A0rssbFjH8q/kiQtC2Z0bsxJ5hgev7eFbj5Zi
 vsw3EBX+5Q2oOOdn7mVkRxo2Jwy4pUMiljLWc54jsH8ql/lgCfuVdWFzLbpGwVmY9p9FsXjN/ky
 By0so
X-Gm-Gg: Acq92OFFXHZSZHjMvqxy7OvuBoaNB6YLmNTZSwEgDdovJtic7NWmQflcpz4NzWDOlCB
 5FKAbaN1ABAtlaBueG+n1cue40yqHcJLiSrE06K2yX44DmxmHCE/w/n/wQGPOBrJt5LxMoE7f+f
 d6cja7Zdjp7Z3x51uqnh9IBOfYTvAaqQSFTtYJocjLbxBMteL6jguiBdJHd0VOOEHfYAKCjGARI
 v/bDUZMhEDI1qp2pGWlDmvr66itYBCatG6qxyGIu6VFr4X+IqxfokzvPTa2L/sKsU77I2XM7hRc
 k3Rf0gtXZr6EFqDf10GXZ+Xt0mxyZkcr3qL3V5F8OC2ajZBa41oZgTttOYkc/bLjOsv4wHNrQ0G
 /nDppsh3nwjzpByh8zByTkJ0pH/cbd6mAJ8gqaFHDtPrmHfOBkoszs1G/X9+3En5wR1zg+Rcxbs
 SorkkRrhOqzOeA9CDRJGUg5LPO6wyEVjlMFYn3cvJwx222hj0XiMdl0cm0g1HrPEy+mEbH/Xze
X-Received: by 2002:a05:7300:fd84:b0:2de:c5ca:c1f3 with SMTP id
 5a478bee46e88-304fa527b52mr5385897eec.4.1780334468675; 
 Mon, 01 Jun 2026 10:21:08 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed5d26d1sm9569021eec.30.2026.06.01.10.21.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 10:21:08 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v2] doc, eal, devtools: discourage new __rte_always_inline
Date: Mon,  1 Jun 2026 10:21:04 -0700
Message-ID: <20260601172104.311909-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527163734.599602-1-stephen@networkplumber.org>
References: <20260527163734.599602-1-stephen@networkplumber.org>
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

Modern compilers at -O2 make good inlining decisions for small
static inline functions; forced inlining via __rte_always_inline
should be reserved for cases where it is required for correctness
or for documented measured performance reasons.

Document the policy in the coding style guide and add a
checkpatches.sh entry that flags when new uses of the attribute
are introduced. Checkpatches is not an absolute blocker to
acceptance, only an indicator that more review is needed.

Add additional comments about use of __rte_always_inline,
__rte_noinline, __rte_hot, and __rte_cold to the rte_common.h
to aid developers.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 devtools/checkpatches.sh                 |  8 +++++
 doc/guides/contributing/coding_style.rst | 26 ++++++++++++++++-
 lib/eal/include/rte_common.h             | 37 ++++++++++++++++++++++--
 3 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/devtools/checkpatches.sh b/devtools/checkpatches.sh
index f5dd77443f..2a3d364178 100755
--- a/devtools/checkpatches.sh
+++ b/devtools/checkpatches.sh
@@ -137,6 +137,14 @@ check_forbidden_additions() { # <patch>
 		-f $(dirname $(readlink -f $0))/check-forbidden-tokens.awk \
 		"$1" || res=1
 
+	# forbid new use of __rte_always_inline
+	awk -v FOLDERS="lib drivers app examples" \
+		-v EXPRESSIONS='\\<__rte_always_inline\\>' \
+		-v RET_ON_FAIL=1 \
+		-v MESSAGE='Adding __rte_always_inline; prefer plain inline' \
+		-f $(dirname $(readlink -f $0))/check-forbidden-tokens.awk \
+		"$1" || res=1
+
 	# refrain from using compiler __rte_atomic_thread_fence()
 	# It should be avoided on x86 for SMP case.
 	awk -v FOLDERS="lib drivers app examples" \
diff --git a/doc/guides/contributing/coding_style.rst b/doc/guides/contributing/coding_style.rst
index 243a3c2959..8f9e77d1c1 100644
--- a/doc/guides/contributing/coding_style.rst
+++ b/doc/guides/contributing/coding_style.rst
@@ -747,11 +747,35 @@ Static Variables and Functions
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 * All functions and variables that are local to a file must be declared as ``static`` because it can often help the compiler to do some optimizations (such as, inlining the code).
-* Functions that should be inlined should to be declared as ``static inline`` and can be defined in a .c or a .h file.
+* Functions that should be inlined should be declared as ``static inline`` and can be defined in a .c or a .h file.
 
 .. note::
 	Static functions defined in a header file must be declared as ``static inline`` in order to prevent compiler warnings about the function being unused.
 
+Use of ``__rte_always_inline``
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The ``__rte_always_inline`` attribute forces the compiler to inline a function regardless of its size or call-graph heuristics.
+Prefer plain ``inline`` (or no annotation at all for static functions) and let the compiler decide.
+Modern compilers at ``-O2`` make good inlining decisions for small ``static inline`` functions in headers,
+and forced inlining can hurt performance by inflating function bodies, increasing register pressure, and overriding profile-guided optimization.
+
+``__rte_always_inline`` should only be used when one of the following applies:
+
+* The function contains ``__rte_constant()`` checks that gate a constant-folded fast path,
+  and the optimization is lost if the function is not inlined into the caller.
+  Examples include byte-order helpers and length-dispatched copy/compare routines.
+
+* The function wraps inline assembly or a compiler intrinsic whose correctness depends on being inlined into the caller's register context (for example, intrinsics requiring a compile-time constant argument).
+
+* Measurement on a representative workload shows that the annotation is required to retain performance, and the reason is documented in the commit message that introduces it.
+
+Each use must be justified at the point it is introduced. Adding ``__rte_always_inline`` because nearby code uses it is not a justification;
+if the constant or intrinsic that requires inlining is several call levels up the call chain,
+restructure the code rather than annotating the entire chain.
+
+The complementary attribute ``__rte_noinline`` is useful for explicitly marking cold paths (error handling, initialization, slow-path fallbacks) where outlining the function can reduce instruction-cache pressure on the hot path.
+
 Const Attribute
 ~~~~~~~~~~~~~~~
 
diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index 71415346cf..e358be7fcf 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -482,7 +482,22 @@ static void __attribute__((destructor(RTE_PRIO(prio)), used)) func(void)
 #endif
 
 /**
- * Force a function to be inlined
+ * Force a function to be inlined, regardless of the compiler's size and
+ * call-graph heuristics.
+ *
+ * Prefer plain @c inline (or no annotation on a static function) and let the compiler decide.
+ * Modern compilers at -O2 inline small static functions well,
+ * and forcing it can hurt by inflating call sites, raising register pressure,
+ * and overriding profile-guided optimization.
+ *
+ * Reserve this attribute for cases where inlining is required for
+ * correctness, or for a documented and measured performance reason, e.g.
+ *  - a constant-folded fast path gated by @c __rte_constant() that is lost
+ *    unless the function is inlined into the caller;
+ *  - a wrapper around inline asm or an intrinsic that needs a
+ *    compile-time-constant argument from the caller's context.
+ *
+ * See the DPDK coding style guide for the full policy.
  */
 #ifdef RTE_TOOLCHAIN_MSVC
 #define __rte_always_inline __forceinline
@@ -491,7 +506,11 @@ static void __attribute__((destructor(RTE_PRIO(prio)), used)) func(void)
 #endif
 
 /**
- * Force a function to be noinlined
+ * Force a function not to be inlined.
+ *
+ * Useful for explicitly outlining cold paths such as error handling,
+ * initialization, slow-path fallbacks, so they do not bloat the hot path
+ * or add to its instruction-cache footprint.
  */
 #ifdef RTE_TOOLCHAIN_MSVC
 #define __rte_noinline __declspec(noinline)
@@ -501,6 +520,12 @@ static void __attribute__((destructor(RTE_PRIO(prio)), used)) func(void)
 
 /**
  * Hint function in the hot path
+ *
+ * The compiler may optimize the function more aggressively, treat calls
+ * to it as likely for branch prediction, and group it with other hot
+ * functions to improve instruction-cache locality. This affects code
+ * placement and prediction, not inlining; combine with an inline
+ * annotation if both are wanted.
  */
 #ifdef RTE_TOOLCHAIN_MSVC
 #define __rte_hot
@@ -510,6 +535,14 @@ static void __attribute__((destructor(RTE_PRIO(prio)), used)) func(void)
 
 /**
  * Hint function in the cold path
+ *
+ * The compiler optimizes the function for size rather than speed,
+ * marks branches that reach it as unlikely, and may move it to a separate
+ * section to keep it off the hot path and reduce instruction-cache
+ * pressure there.
+ *
+ * Suitable for error handling, logging, and setup/teardown code.
+ * Functions marked @c __rte_noreturn are already treated as cold.
  */
 #ifdef RTE_TOOLCHAIN_MSVC
 #define __rte_cold
-- 
2.53.0

