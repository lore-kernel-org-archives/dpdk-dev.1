Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E020CA0EE6
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 Aug 2025 11:25:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8BC4C40267;
	Tue, 19 Aug 2025 13:25:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 153CF40144
 for <dev@dpdk.org>; Tue, 19 Aug 2025 13:25:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755602742; x=1787138742;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Sx69vkLZ27odjGnfT3rstriC8Nnib1ys9OgxQmlxo9g=;
 b=g96IrIMoa5G4vPA7JBameDfoZX5dU+Co6SCIviWLZ6V9ScHbuh2kHOj/
 KJ43TyilNPQGGlq0UiimsIx4NesA8y8+NAH4O/+FpBH9QRd9r3cTjJrgq
 A3dbdA9HXoOSHsQREpaMrqDLP7wM9EEgo9co+k+zRCT2TtxD/CETrVqhV
 ZwN7pthqkU3fhhZTdh4dma4PFZ87mzYA1VlM5UcWfx8YEVTxOsx0bh0MB
 FK+K909gm6FR418Zkd+obt+DRjGdi3/XWtb9dSrHe9/u/GLhyI+BLVEBo
 508SszlH4twF8dQnZyodT+H0RefVRc310asxBq+Mjm8nvsf7lZ0tPRauD A==;
X-CSE-ConnectionGUID: 76MgTl1YSXOaOieDDkAB1A==
X-CSE-MsgGUID: WDrNJB+nRmKE3MkCf7ot9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="68938702"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; d="scan'208";a="68938702"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2025 04:25:41 -0700
X-CSE-ConnectionGUID: JvL/JFjrQtKh8aCkgepVeA==
X-CSE-MsgGUID: r0CM0ypWS7ObX+8rHZIfxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; d="scan'208";a="167330464"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by fmviesa007.fm.intel.com with ESMTP; 19 Aug 2025 04:25:39 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 David Marchand <david.marchand@redhat.com>
Subject: [PATCH v3 1/2] build: remove obsolete compiler checks
Date: Tue, 19 Aug 2025 12:25:20 +0100
Message-ID: <20250819112521.1608207-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250718121402.856265-1-bruce.richardson@intel.com>
References: <20250718121402.856265-1-bruce.richardson@intel.com>
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

DPDK now recommends compiler versions GCC 8+, and Clang 7+, so remove
checks and workarounds for versions old than these.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
Reviewed-by: David Marchand <david.marchand@redhat.com>

---
V3: fix inconsistency between build files for vhost and net/virtio

V2: Fix feedback from V1.
* remove obsolete comment from arm/meson.build
* sort octeontx alphabetically in driver list
---
 config/arm/meson.build              |  1 -
 config/meson.build                  |  5 ----
 drivers/event/meson.build           |  5 +---
 drivers/meson.build                 |  2 +-
 drivers/net/virtio/meson.build      |  4 ++--
 lib/eal/arm/include/rte_memcpy_64.h |  8 -------
 lib/eal/arm/include/rte_vect.h      | 37 ++---------------------------
 lib/eal/ppc/include/rte_altivec.h   |  1 -
 lib/meson.build                     |  2 +-
 lib/vhost/meson.build               |  4 ++--
 lib/vhost/vhost.c                   | 16 -------------
 11 files changed, 9 insertions(+), 76 deletions(-)

diff --git a/config/arm/meson.build b/config/arm/meson.build
index 35b7553e74..c0dc42e7d1 100644
--- a/config/arm/meson.build
+++ b/config/arm/meson.build
@@ -13,7 +13,6 @@ flags_common = [
         #    ['RTE_ARM64_MEMCPY_UNALIGNED_THRESHOLD', 512],
         # Leave below RTE_ARM64_MEMCPY_xxx options commented out,
         # unless there are strong reasons.
-        #    ['RTE_ARM64_MEMCPY_SKIP_GCC_VER_CHECK', false],
         #    ['RTE_ARM64_MEMCPY_ALIGN_MASK', 0xF],
         #    ['RTE_ARM64_MEMCPY_STRICT_ALIGN', false],
 
diff --git a/config/meson.build b/config/meson.build
index f31fef216c..c7a780dcc8 100644
--- a/config/meson.build
+++ b/config/meson.build
@@ -492,11 +492,6 @@ if get_option('b_lto')
     else
         error('compiler does not support fat LTO objects - please turn LTO off')
     endif
-    # workaround for gcc bug 81440
-    if cc.get_id() == 'gcc' and cc.version().version_compare('<8.0')
-        add_project_arguments('-Wno-lto-type-mismatch', language: 'c')
-        add_project_link_arguments('-Wno-lto-type-mismatch', language: 'c')
-    endif
 endif
 
 if get_option('b_sanitize') == 'address' or get_option('b_sanitize') == 'address,undefined'
diff --git a/drivers/event/meson.build b/drivers/event/meson.build
index d6706b57f7..ddaa0300ac 100644
--- a/drivers/event/meson.build
+++ b/drivers/event/meson.build
@@ -11,12 +11,9 @@ drivers = [
         'dpaa',
         'dpaa2',
         'dsw',
+        'octeontx',
         'opdl',
         'skeleton',
         'sw',
 ]
-if not (toolchain == 'gcc' and cc.version().version_compare('<4.8.6') and
-        dpdk_conf.has('RTE_ARCH_ARM64'))
-    drivers += 'octeontx'
-endif
 std_deps = ['eventdev', 'kvargs']
diff --git a/drivers/meson.build b/drivers/meson.build
index b62880db02..2760f4d593 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -237,7 +237,7 @@ foreach subpath:subdirs
         enabled_drivers += name
         lib_name = '_'.join(['rte', class, name])
         cflags += '-DRTE_LOG_DEFAULT_LOGTYPE=' + '.'.join([log_prefix, name])
-        if annotate_locks and cc.get_id() == 'clang' and cc.version().version_compare('>=3.5.0')
+        if annotate_locks and cc.get_id() == 'clang'
             cflags += '-DRTE_ANNOTATE_LOCKS'
             cflags += '-Wthread-safety'
         endif
diff --git a/drivers/net/virtio/meson.build b/drivers/net/virtio/meson.build
index d3caa3a3b4..be653edb34 100644
--- a/drivers/net/virtio/meson.build
+++ b/drivers/net/virtio/meson.build
@@ -29,9 +29,9 @@ if arch_subdir == 'x86'
     if cc_has_avx512
         cflags += ['-DVIRTIO_RXTX_PACKED_VEC']
         sources_avx512 += files('virtio_rxtx_packed.c')
-        if (toolchain == 'gcc' and cc.version().version_compare('>=8.3.0'))
+        if toolchain == 'gcc'
             cflags += '-DVIRTIO_GCC_UNROLL_PRAGMA'
-        elif (toolchain == 'clang' and cc.version().version_compare('>=3.7.0'))
+        elif toolchain == 'clang'
             cflags += '-DVIRTIO_CLANG_UNROLL_PRAGMA'
         endif
     endif
diff --git a/lib/eal/arm/include/rte_memcpy_64.h b/lib/eal/arm/include/rte_memcpy_64.h
index 90039039be..57fe24eb10 100644
--- a/lib/eal/arm/include/rte_memcpy_64.h
+++ b/lib/eal/arm/include/rte_memcpy_64.h
@@ -89,14 +89,6 @@ n <= (size_t)RTE_ARM64_MEMCPY_UNALIGNED_THRESHOLD)
  **************************************/
 
 
-#if RTE_CC_IS_GNU && !defined RTE_ARM64_MEMCPY_SKIP_GCC_VER_CHECK
-#if (GCC_VERSION < 50400)
-#warning "The GCC version is quite old, which may result in sub-optimal \
-performance of the compiled code. It is suggested that at least GCC 5.4.0 \
-be used."
-#endif
-#endif
-
 static __rte_always_inline
 void rte_mov16(uint8_t *dst, const uint8_t *src)
 {
diff --git a/lib/eal/arm/include/rte_vect.h b/lib/eal/arm/include/rte_vect.h
index c97d299a3e..149458288e 100644
--- a/lib/eal/arm/include/rte_vect.h
+++ b/lib/eal/arm/include/rte_vect.h
@@ -67,11 +67,8 @@ vaddvq_u16(uint16x8_t a)
 
 #endif
 
-#if (defined(RTE_ARCH_ARM) && defined(RTE_ARCH_32)) || \
-(defined(RTE_ARCH_ARM64) && RTE_CC_IS_GNU && (GCC_VERSION < 70000))
-/* NEON intrinsic vcopyq_laneq_u32() is not supported in ARMv7-A(AArch32)
- * On AArch64, this intrinsic is supported since GCC version 7.
- */
+#if defined(RTE_ARCH_ARM) && defined(RTE_ARCH_32)
+/* NEON intrinsic vcopyq_laneq_u32() is not supported in ARMv7-A(AArch32) */
 static inline uint32x4_t
 vcopyq_laneq_u32(uint32x4_t a, const int lane_a,
 		 uint32x4_t b, const int lane_b)
@@ -80,36 +77,6 @@ vcopyq_laneq_u32(uint32x4_t a, const int lane_a,
 }
 #endif
 
-#if defined(RTE_ARCH_ARM64)
-#if RTE_CC_IS_GNU && (GCC_VERSION < 70000)
-
-/* NEON intrinsic vreinterpretq_u64_p128() is supported since GCC version 7 */
-static inline uint64x2_t
-vreinterpretq_u64_p128(poly128_t x)
-{
-	return (uint64x2_t)x;
-}
-
-/* NEON intrinsic vreinterpretq_p64_u64() is supported since GCC version 7 */
-static inline poly64x2_t
-vreinterpretq_p64_u64(uint64x2_t x)
-{
-	return (poly64x2_t)x;
-}
-
-/* NEON intrinsic vgetq_lane_p64() is supported since GCC version 7 */
-static inline poly64_t
-vgetq_lane_p64(poly64x2_t x, const int lane)
-{
-	RTE_ASSERT(lane >= 0 && lane <= 1);
-
-	poly64_t *p = (poly64_t *)&x;
-
-	return p[lane];
-}
-#endif
-#endif
-
 /*
  * If (0 <= index <= 15), then call the ASIMD ext instruction on the
  * 128 bit regs v0 and v1 with the appropriate index.
diff --git a/lib/eal/ppc/include/rte_altivec.h b/lib/eal/ppc/include/rte_altivec.h
index 7c088d2d16..bc8548f11e 100644
--- a/lib/eal/ppc/include/rte_altivec.h
+++ b/lib/eal/ppc/include/rte_altivec.h
@@ -6,7 +6,6 @@
 #ifndef _RTE_ALTIVEC_H_
 #define _RTE_ALTIVEC_H_
 
-/* To include altivec.h, GCC version must be >= 4.8 */
 #include <altivec.h>
 
 /*
diff --git a/lib/meson.build b/lib/meson.build
index 0d56b2083b..a67efaf718 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -244,7 +244,7 @@ foreach l:libraries
         cflags += '-DRTE_USE_FUNCTION_VERSIONING'
     endif
     cflags += '-DRTE_LOG_DEFAULT_LOGTYPE=lib.' + l
-    if annotate_locks and cc.get_id() == 'clang' and cc.version().version_compare('>=3.5.0')
+    if annotate_locks and cc.get_id() == 'clang'
         cflags += '-DRTE_ANNOTATE_LOCKS'
         cflags += '-Wthread-safety'
     endif
diff --git a/lib/vhost/meson.build b/lib/vhost/meson.build
index 9c6325aa0e..0a7a76f6db 100644
--- a/lib/vhost/meson.build
+++ b/lib/vhost/meson.build
@@ -8,9 +8,9 @@ endif
 if has_libnuma
     dpdk_conf.set10('RTE_LIBRTE_VHOST_NUMA', true)
 endif
-if (toolchain == 'gcc' and cc.version().version_compare('>=8.3.0'))
+if toolchain == 'gcc'
     cflags += '-DVHOST_GCC_UNROLL_PRAGMA'
-elif (toolchain == 'clang' and cc.version().version_compare('>=3.7.0'))
+elif toolchain == 'clang'
     cflags += '-DVHOST_CLANG_UNROLL_PRAGMA'
 endif
 dpdk_conf.set('RTE_LIBRTE_VHOST_POSTCOPY', cc.has_header('linux/userfaultfd.h'))
diff --git a/lib/vhost/vhost.c b/lib/vhost/vhost.c
index a2e3e2635d..416f082dca 100644
--- a/lib/vhost/vhost.c
+++ b/lib/vhost/vhost.c
@@ -128,16 +128,8 @@ __vhost_iova_to_vva(struct virtio_net *dev, struct vhost_virtqueue *vq,
 static __rte_always_inline void
 vhost_set_bit(unsigned int nr, volatile uint8_t *addr)
 {
-#if defined(RTE_TOOLCHAIN_GCC) && (GCC_VERSION < 70100)
-	/*
-	 * __sync_ built-ins are deprecated, but rte_atomic_ ones
-	 * are sub-optimized in older GCC versions.
-	 */
-	__sync_fetch_and_or_1(addr, (1U << nr));
-#else
 	rte_atomic_fetch_or_explicit((volatile uint8_t __rte_atomic *)addr, (1U << nr),
 		rte_memory_order_relaxed);
-#endif
 }
 
 static __rte_always_inline void
@@ -207,17 +199,9 @@ __vhost_log_cache_sync(struct virtio_net *dev, struct vhost_virtqueue *vq)
 	for (i = 0; i < vq->log_cache_nb_elem; i++) {
 		struct log_cache_entry *elem = vq->log_cache + i;
 
-#if defined(RTE_TOOLCHAIN_GCC) && (GCC_VERSION < 70100)
-		/*
-		 * '__sync' builtins are deprecated, but 'rte_atomic' ones
-		 * are sub-optimized in older GCC versions.
-		 */
-		__sync_fetch_and_or(log_base + elem->offset, elem->val);
-#else
 		rte_atomic_fetch_or_explicit(
 			(unsigned long __rte_atomic *)(log_base + elem->offset),
 			elem->val, rte_memory_order_relaxed);
-#endif
 	}
 
 	rte_atomic_thread_fence(rte_memory_order_release);
-- 
2.48.1

