Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CADC9830E
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 12:50:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D9E0432DA;
	Fri, 25 Sep 2026 14:50:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 383D840294;
 Fri, 25 Sep 2026 14:50:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790340613; x=1821876613;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3LEn5M2/mBNF931vRBkr/XkeIVNiMZDszM6LD3a1Zrw=;
 b=YzW4onJ0Z3kfdNPd7Om6i2o0wB6FhBYuYYPoZlT9GBP2/ot0g1Qv08UA
 IZG+ZsrJMLN0lDep5FzTzsSn6CLntW5Lku8emXLn55S7+381ctXxn0+bl
 SE8u7Z0uzHmC3NlMt98xXshl7KL4wBizF26I2vWCmsQM9U4PAUvtlQ+SQ
 7J5N6um8Y/XOmq7VIu8RWHZobKBttlNmiGS/JKkPzT4NgLPZrMOCr9d7k
 OWYRnjLva9f14MsnfK7jII59aqDzezTJZYG1agmfzuz+G28jXxkM6ojwc
 uawMWY9yTHsDRqBFHPJGdm+r5C2M8LdPKh/gt0sXhW1PILco2e2e3jcxY g==;
X-CSE-ConnectionGUID: 2elB7JPVTLur1I2jXhspUg==
X-CSE-MsgGUID: 6FAshP5AQDmvATFV0EOh0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="93620649"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="93620649"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 05:50:11 -0700
X-CSE-ConnectionGUID: CKtgTunDTnmN53eWttjheg==
X-CSE-MsgGUID: zUsADcElRo2hJoHvir0Kyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="303830846"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa002.jf.intel.com with ESMTP; 25 Sep 2026 05:50:10 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, Bruce Richardson <bruce.richardson@intel.com>,
 stable@dpdk.org
Subject: [PATCH v2] eal: fix C++ builds when stdatomics is set
Date: Fri, 25 Sep 2026 13:49:58 +0100
Message-ID: <20260925124958.44356-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924141246.4037433-1-bruce.richardson@intel.com>
References: <20260924141246.4037433-1-bruce.richardson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

When the DPDK build is configured to use stdatomics rather than compiler
builtin atomics, the C++ chkincs builds were failing

In file included from buildtools/chkincs/staging/generic/rte_atomic.h:18,
                 from /home/morten/upstreaming/dpdk-stack-std/lib/eal/x86/include/rte_atomic.h:12,
                 from buildtools/chkincs/chkincs-cpp.p/rte_atomic.cpp:1:
buildtools/chkincs/staging/rte_stdatomic.h:30:9: error: ‘memory_order’ does not name a type
   30 | typedef memory_order rte_memory_order;
      |         ^~~~~~~~~~~~

The cause is differences in atomics in C (C11) and C++ (e.g. C++17 as
supported by current GCC). As explained by AI analysis:

   _Atomic(T) is a C11 feature. In C++ mode, GCC 15 does not support it
   as a type specifier, and <stdatomic.h> in C++17 doesn't expose
   memory_order in the global namespace (that's only in C++23). DPDK
   headers also use _Atomic in anonymous unions and under extern "C",
   which are incompatible with C++'s std::atomic<T> mapping.

To fix this in a resilient manner we need to go from two blocks in
rte_atomic.h to three. We have the existing non-standard/builtin
atomics path, but the standard atomic path now needs to be split into C
compatible and C++ compatible blocks. This fixes the build issues with
C++ while keeping existing C builds unchanged.

Bugzilla ID: 1985
Fixes: 5c381a3587d1 ("eal: provide stdatomic API")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 .ci/linux-build.sh              | 11 +++--
 lib/eal/include/rte_stdatomic.h | 75 +++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+), 6 deletions(-)

diff --git a/.ci/linux-build.sh b/.ci/linux-build.sh
index e0b914a142..b09d72dd87 100755
--- a/.ci/linux-build.sh
+++ b/.ci/linux-build.sh
@@ -111,13 +111,12 @@ OPTS="$OPTS -Dplatform=generic"
 OPTS="$OPTS -Ddefault_library=$DEF_LIB"
 if [ "$STDATOMIC" = "true" ]; then
     OPTS="$OPTS -Denable_stdatomic=true"
+fi
+OPTS="$OPTS -Dcheck_includes=true"
+if [ "${CC%%clang}" != "$CC" ]; then
+    export CXX=clang++
 else
-    OPTS="$OPTS -Dcheck_includes=true"
-    if [ "${CC%%clang}" != "$CC" ]; then
-        export CXX=clang++
-    else
-        export CXX=g++
-    fi
+    export CXX=g++
 fi
 if [ "$MINI" = "true" ]; then
     OPTS="$OPTS -Denable_drivers=net/null"
diff --git a/lib/eal/include/rte_stdatomic.h b/lib/eal/include/rte_stdatomic.h
index 7258b393f1..d31eb4bfab 100644
--- a/lib/eal/include/rte_stdatomic.h
+++ b/lib/eal/include/rte_stdatomic.h
@@ -8,6 +8,8 @@
 #include <assert.h>
 
 #ifdef RTE_ENABLE_STDATOMIC
+
+#ifndef __cplusplus
 #ifndef _MSC_VER
 #ifdef __STDC_NO_ATOMICS__
 #error enable_stdatomic=true but atomics not supported by toolchain
@@ -114,6 +116,79 @@ static_assert(rte_memory_order_seq_cst == __ATOMIC_SEQ_CST,
 #define __rte_atomic_thread_fence(memorder) \
 	atomic_thread_fence(memorder)
 
+#else /* __cplusplus */
+
+/* C++ cannot use the C11 _Atomic member layout that DPDK public headers
+ * rely on, so keep the builtin-based implementation for C++ and continue
+ * to expose the existing rte_atomic_* API surface.
+ */
+#define RTE_ATOMIC(type) type
+
+#define __rte_atomic
+
+/* The memory order is an integer type in GCC built-ins,
+ * not an enumerated type like in C11.
+ */
+typedef int rte_memory_order;
+
+#define rte_memory_order_relaxed __ATOMIC_RELAXED
+#define rte_memory_order_consume __ATOMIC_CONSUME
+#define rte_memory_order_acquire __ATOMIC_ACQUIRE
+#define rte_memory_order_release __ATOMIC_RELEASE
+#define rte_memory_order_acq_rel __ATOMIC_ACQ_REL
+#define rte_memory_order_seq_cst __ATOMIC_SEQ_CST
+
+#define rte_atomic_load_explicit(ptr, memorder) \
+	__atomic_load_n(ptr, memorder)
+
+#define rte_atomic_store_explicit(ptr, val, memorder) \
+	__atomic_store_n(ptr, val, memorder)
+
+#define rte_atomic_exchange_explicit(ptr, val, memorder) \
+	__atomic_exchange_n(ptr, val, memorder)
+
+#define rte_atomic_compare_exchange_strong_explicit(ptr, expected, desired, \
+		succ_memorder, fail_memorder) \
+	__atomic_compare_exchange_n(ptr, expected, desired, 0, \
+		succ_memorder, fail_memorder)
+
+#define rte_atomic_compare_exchange_weak_explicit(ptr, expected, desired, \
+		succ_memorder, fail_memorder) \
+	__atomic_compare_exchange_n(ptr, expected, desired, 1, \
+		succ_memorder, fail_memorder)
+
+#define rte_atomic_fetch_add_explicit(ptr, val, memorder) \
+	__atomic_fetch_add(ptr, val, memorder)
+
+#define rte_atomic_fetch_sub_explicit(ptr, val, memorder) \
+	__atomic_fetch_sub(ptr, val, memorder)
+
+#define rte_atomic_fetch_and_explicit(ptr, val, memorder) \
+	__atomic_fetch_and(ptr, val, memorder)
+
+#define rte_atomic_fetch_xor_explicit(ptr, val, memorder) \
+	__atomic_fetch_xor(ptr, val, memorder)
+
+#define rte_atomic_fetch_or_explicit(ptr, val, memorder) \
+	__atomic_fetch_or(ptr, val, memorder)
+
+#define rte_atomic_fetch_nand_explicit(ptr, val, memorder) \
+	__atomic_fetch_nand(ptr, val, memorder)
+
+#define rte_atomic_flag_test_and_set_explicit(ptr, memorder) \
+	__atomic_test_and_set(ptr, memorder)
+
+#define rte_atomic_flag_clear_explicit(ptr, memorder) \
+	__atomic_clear(ptr, memorder)
+
+/* We provide internal macro here to allow conditional expansion
+ * in the body of the per-arch rte_atomic_thread_fence inline functions.
+ */
+#define __rte_atomic_thread_fence(memorder) \
+	__atomic_thread_fence(memorder)
+
+#endif /* __cplusplus */
+
 #else /* !RTE_ENABLE_STDATOMIC */
 
 #define RTE_ATOMIC(type) type
-- 
2.53.0

