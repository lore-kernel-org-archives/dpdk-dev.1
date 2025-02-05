Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40069C02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 16:18:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F4B940289;
	Wed,  5 Feb 2025 17:18:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 4879240270
 for <dev@dpdk.org>; Wed,  5 Feb 2025 17:18:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738772337; x=1770308337;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=p3E9purjKKKWPZ2M2smqgWHN/UhLOLaFH/pMnpcj1eM=;
 b=mhP5J4Sr3IQSVFtrCdeJ2YisPQHhxlzd9t5fWkqdBN7/eFRomuhJhf4x
 KG2Uai1KmYFi+8uOjTNPR+BH39iDxgMNjeRfiT5IX+vyPeakBd5GP9mE9
 9Bhj+3ORhWkcZjIzjSgDv922xGugzwlDuK82x9lhbxzcrtx1bJbND1MdT
 2js5FdEgPnebup0NMJDwBNFge40AHDatMMWfdLscf3KdxYyqYqUM/HMBf
 byuCGw6ThtfPSj0WbOafvBIWYuJ9fGodkxafJYI0XZhS4WwjW4SfB5AJj
 akc3Nvdv2rdvKfwzaMDEqMaYnYpPlEe1F6WobzxxzgsA3sVRjGUgK2g/W Q==;
X-CSE-ConnectionGUID: xzMJv1LNRbS02KCz19P95w==
X-CSE-MsgGUID: 2VzCzl8UQNapnwcTSwX1tA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="38550426"
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; d="scan'208";a="38550426"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2025 08:18:56 -0800
X-CSE-ConnectionGUID: fAYvyvt6Tlq2Aooak+0E0g==
X-CSE-MsgGUID: Uz02eLuITZmff86UHFRSUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; d="scan'208";a="110843848"
Received: from silpixa00401197coob.ir.intel.com (HELO
 silpixa00401385.ir.intel.com) ([10.237.214.45])
 by fmviesa007.fm.intel.com with ESMTP; 05 Feb 2025 08:18:53 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: anatoly.burakov@intel.com, vladimir.medvedkin@intel.com,
 ian.stokes@intel.com, john.mcnamara@intel.com,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] build: remove support for icc compiler
Date: Wed,  5 Feb 2025 16:18:19 +0000
Message-ID: <20250205161823.2849595-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.43.0
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

The Intel-produced compiler "icc" has been replaced by the newer
clang-based "icx" compiler. DPDK compilation has also not been tested
recently with the icc compiler, so let's remove doc and code references
to icc, and any special macros or build support that was added for it.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_pie.c                           |  5 -----
 app/test/test_red.c                           |  5 -----
 .../contributing/img/patch_cheatsheet.svg     |  2 +-
 doc/guides/linux_gsg/sys_reqs.rst             |  3 ---
 doc/guides/nics/enic.rst                      |  2 +-
 doc/guides/nics/hinic.rst                     |  1 -
 doc/guides/nics/hns3.rst                      |  1 -
 doc/guides/nics/ngbe.rst                      |  1 -
 doc/guides/nics/txgbe.rst                     |  1 -
 doc/guides/prog_guide/lto.rst                 |  2 +-
 .../prog_guide/writing_efficient_code.rst     |  2 +-
 doc/guides/rel_notes/known_issues.rst         | 19 -------------------
 drivers/net/mlx5/mlx5_rxtx_vec_altivec.h      |  2 +-
 drivers/net/virtio/meson.build                |  2 --
 drivers/net/virtio/virtio_rxtx_packed.h       |  5 -----
 dts/framework/config/__init__.py              |  2 --
 dts/framework/testbed_model/posix_session.py  |  2 --
 lib/eal/include/rte_common.h                  |  6 ++----
 lib/eal/x86/include/rte_rtm.h                 |  2 +-
 lib/eal/x86/include/rte_vect.h                | 13 -------------
 lib/sched/rte_pie.c                           |  4 ----
 lib/sched/rte_red.c                           |  4 ----
 lib/sched/rte_sched.c                         |  5 -----
 lib/vhost/meson.build                         |  2 --
 lib/vhost/vhost.h                             |  5 -----
 25 files changed, 8 insertions(+), 90 deletions(-)

diff --git a/app/test/test_pie.c b/app/test/test_pie.c
index 8036bac1e6..72ef3869d0 100644
--- a/app/test/test_pie.c
+++ b/app/test/test_pie.c
@@ -41,11 +41,6 @@ test_pie_all(void)
 
 #include <rte_pie.h>
 
-#ifdef __INTEL_COMPILER
-#pragma warning(disable:2259)       /* conversion may lose significant bits */
-#pragma warning(disable:181)        /* Arg incompatible with format string */
-#endif
-
 /**< structures for testing rte_pie performance and function */
 struct test_rte_pie_config {        /**< Test structure for RTE_PIE config */
 	struct rte_pie_config *pconfig; /**< RTE_PIE configuration parameters */
diff --git a/app/test/test_red.c b/app/test/test_red.c
index 6bf58ad4dd..7f38ed1469 100644
--- a/app/test/test_red.c
+++ b/app/test/test_red.c
@@ -40,11 +40,6 @@ test_red_all(void)
 
 #include <rte_red.h>
 
-#ifdef __INTEL_COMPILER
-#pragma warning(disable:2259)       /* conversion may lose significant bits */
-#pragma warning(disable:181)        /* Arg incompatible with format string */
-#endif
-
 #define TEST_HZ_PER_KHZ 1000
 #define TEST_NSEC_MARGIN 500        /**< nanosecond margin when calculating clk freq */
 
diff --git a/doc/guides/contributing/img/patch_cheatsheet.svg b/doc/guides/contributing/img/patch_cheatsheet.svg
index 986e4db815..4debb07b98 100644
--- a/doc/guides/contributing/img/patch_cheatsheet.svg
+++ b/doc/guides/contributing/img/patch_cheatsheet.svg
@@ -718,7 +718,7 @@
              style="font-style:normal;font-variant:normal;font-weight:300;font-stretch:normal;font-size:21px;line-height:125%;font-family:monospace;-inkscape-font-specification:'Monospace Bold';text-align:start;writing-mode:lr-tb;text-anchor:start"
              id="tspan4092-8-7"
              y="454.36987"
-             x="49.093246">+ build gcc icc clang </tspan></text>
+             x="49.093246">+ build gcc clang </tspan></text>
         <text
            style="font-style:normal;font-weight:normal;font-size:40px;line-height:0%;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none"
            xml:space="preserve"
diff --git a/doc/guides/linux_gsg/sys_reqs.rst b/doc/guides/linux_gsg/sys_reqs.rst
index 13d632cec7..16dda13172 100644
--- a/doc/guides/linux_gsg/sys_reqs.rst
+++ b/doc/guides/linux_gsg/sys_reqs.rst
@@ -71,9 +71,6 @@ Compilation of the DPDK
 
 **Optional Tools:**
 
-*   Intel\ |reg| C++ Compiler (icc). For installation, additional libraries may be required.
-    See the icc Installation Guide found in the Documentation directory under the compiler installation.
-
 *   IBM\ |reg| Advance ToolChain for Powerlinux. This is a set of open source development tools and runtime libraries
     which allows users to take leading edge advantage of IBM's latest POWER hardware features on Linux. To install
     it, see the IBM official installation document.
diff --git a/doc/guides/nics/enic.rst b/doc/guides/nics/enic.rst
index 6731ebe626..a400bbc4f7 100644
--- a/doc/guides/nics/enic.rst
+++ b/doc/guides/nics/enic.rst
@@ -378,7 +378,7 @@ AVX2 SIMD instructions. It is meant for bulk, throughput oriented workloads
 where reducing cycles/packet in PMD is a priority. In order to use the
 vectorized handler, take the following steps.
 
-- Use a recent version of gcc, icc, or clang and build 64-bit DPDK. If
+- Use a recent version of gcc or clang and build 64-bit DPDK. If
   the compiler is known to support AVX2, DPDK build system
   automatically compiles the vectorized handler. Otherwise, the
   handler is not available.
diff --git a/doc/guides/nics/hinic.rst b/doc/guides/nics/hinic.rst
index 3610023122..c47737c714 100644
--- a/doc/guides/nics/hinic.rst
+++ b/doc/guides/nics/hinic.rst
@@ -55,5 +55,4 @@ for details.
 
 Limitations or Known issues
 ---------------------------
-Build with ICC is not supported yet.
 X86-32, Power8, ARMv7 and BSD are not supported yet.
diff --git a/doc/guides/nics/hns3.rst b/doc/guides/nics/hns3.rst
index a93b300895..1239c21604 100644
--- a/doc/guides/nics/hns3.rst
+++ b/doc/guides/nics/hns3.rst
@@ -451,5 +451,4 @@ sve burst function. When enabling IEEE 1588, Rx/Tx burst mode should be
 simple or common. It is recommended that enable IEEE 1588 before ethdev
 start. In this way, the correct Rx/Tx burst function can be selected.
 
-Build with ICC is not supported yet.
 X86-32, Power8, ARMv7 and BSD are not supported yet.
diff --git a/doc/guides/nics/ngbe.rst b/doc/guides/nics/ngbe.rst
index b002fa4c19..fe9fb1b07d 100644
--- a/doc/guides/nics/ngbe.rst
+++ b/doc/guides/nics/ngbe.rst
@@ -81,5 +81,4 @@ for details.
 Limitations or Known issues
 ---------------------------
 
-Build with ICC is not supported yet.
 Power8, ARMv7 and BSD are not supported yet.
diff --git a/doc/guides/nics/txgbe.rst b/doc/guides/nics/txgbe.rst
index e55b0e643a..93fb592759 100644
--- a/doc/guides/nics/txgbe.rst
+++ b/doc/guides/nics/txgbe.rst
@@ -186,5 +186,4 @@ For a detailed usage description please refer to "Traffic Management" section in
 Limitations or Known issues
 ---------------------------
 
-Build with ICC is not supported yet.
 Power8, ARMv7 and BSD are not supported yet.
diff --git a/doc/guides/prog_guide/lto.rst b/doc/guides/prog_guide/lto.rst
index ff9f47a8f4..5791e35494 100644
--- a/doc/guides/prog_guide/lto.rst
+++ b/doc/guides/prog_guide/lto.rst
@@ -10,7 +10,7 @@ program" optimization at link time and is available only for compilers
 that support that feature.
 To be more specific, compiler (in addition to performing LTO) have to
 support creation of ELF objects containing both normal code and internal
-representation (called fat-lto-objects in gcc and icc).
+representation (called fat-lto-objects in gcc).
 This is required since during build some code is generated by parsing
 produced ELF objects (pmdinfogen).
 
diff --git a/doc/guides/prog_guide/writing_efficient_code.rst b/doc/guides/prog_guide/writing_efficient_code.rst
index b849f1db07..b63fa8e459 100644
--- a/doc/guides/prog_guide/writing_efficient_code.rst
+++ b/doc/guides/prog_guide/writing_efficient_code.rst
@@ -247,7 +247,7 @@ However, this technique is not always efficient; it depends on many factors incl
 Branch Prediction
 ~~~~~~~~~~~~~~~~~
 
-The Intel® C/C++ Compiler (icc)/gcc built-in helper functions likely() and unlikely()
+The gcc built-in helper functions likely() and unlikely()
 allow the developer to indicate if a code branch is likely to be taken or not.
 For instance:
 
diff --git a/doc/guides/rel_notes/known_issues.rst b/doc/guides/rel_notes/known_issues.rst
index 899da771ab..73c72ba484 100644
--- a/doc/guides/rel_notes/known_issues.rst
+++ b/doc/guides/rel_notes/known_issues.rst
@@ -422,25 +422,6 @@ Differences in how different Intel NICs handle maximum packet length for jumbo f
    Poll Mode Driver (PMD).
 
 
-GCC might generate Intel® AVX instructions for processors without Intel® AVX support
-------------------------------------------------------------------------------------
-
-**Description**:
-   When compiling DPDK (and any DPDK app), gcc may generate Intel® AVX instructions, even when the
-   processor does not support Intel® AVX.
-
-**Implication**:
-   Any DPDK app might crash while starting up.
-
-**Resolution/Workaround**:
-   Either compile using icc or set ``EXTRA_CFLAGS='-O3'`` prior to compilation.
-
-**Affected Environment/Platform**:
-   Platforms which processor does not support Intel® AVX.
-
-**Driver/Module**:
-   Environment Abstraction Layer (EAL).
-
 Ethertype filter could receive other packets (non-assigned) in Niantic
 ----------------------------------------------------------------------
 
diff --git a/drivers/net/mlx5/mlx5_rxtx_vec_altivec.h b/drivers/net/mlx5/mlx5_rxtx_vec_altivec.h
index fea0c0a7dc..42ebe09dd9 100644
--- a/drivers/net/mlx5/mlx5_rxtx_vec_altivec.h
+++ b/drivers/net/mlx5/mlx5_rxtx_vec_altivec.h
@@ -25,7 +25,7 @@
 #include "mlx5_rxtx_vec.h"
 #include "mlx5_autoconf.h"
 
-#if !defined(__INTEL_COMPILER) && !defined(RTE_TOOLCHAIN_MSVC)
+#if !defined(RTE_TOOLCHAIN_MSVC)
 #pragma GCC diagnostic ignored "-Wstrict-aliasing"
 #endif
 
diff --git a/drivers/net/virtio/meson.build b/drivers/net/virtio/meson.build
index 02742da5c2..3a121fc5ee 100644
--- a/drivers/net/virtio/meson.build
+++ b/drivers/net/virtio/meson.build
@@ -37,8 +37,6 @@ if arch_subdir == 'x86'
             cflags += '-DVIRTIO_GCC_UNROLL_PRAGMA'
         elif (toolchain == 'clang' and cc.version().version_compare('>=3.7.0'))
             cflags += '-DVIRTIO_CLANG_UNROLL_PRAGMA'
-        elif (toolchain == 'icc' and cc.version().version_compare('>=16.0.0'))
-            cflags += '-DVIRTIO_ICC_UNROLL_PRAGMA'
         endif
     endif
     sources += files('virtio_rxtx_simple_sse.c')
diff --git a/drivers/net/virtio/virtio_rxtx_packed.h b/drivers/net/virtio/virtio_rxtx_packed.h
index 536112983c..12bfcee809 100644
--- a/drivers/net/virtio/virtio_rxtx_packed.h
+++ b/drivers/net/virtio/virtio_rxtx_packed.h
@@ -77,11 +77,6 @@
 	for (iter = val; iter < size; iter++)
 #endif
 
-#ifdef VIRTIO_ICC_UNROLL_PRAGMA
-#define virtio_for_each_try_unroll(iter, val, size) _Pragma("unroll 4") \
-	for (iter = val; iter < size; iter++)
-#endif
-
 #ifndef virtio_for_each_try_unroll
 #define virtio_for_each_try_unroll(iter, val, size) \
 	for (iter = val; iter < size; iter++)
diff --git a/dts/framework/config/__init__.py b/dts/framework/config/__init__.py
index 6bf4885815..781c1ab831 100644
--- a/dts/framework/config/__init__.py
+++ b/dts/framework/config/__init__.py
@@ -116,8 +116,6 @@ class Compiler(StrEnum):
     #:
     clang = auto()
     #:
-    icc = auto()
-    #:
     msvc = auto()
 
 
diff --git a/dts/framework/testbed_model/posix_session.py b/dts/framework/testbed_model/posix_session.py
index c0cca2ac50..101513b45e 100644
--- a/dts/framework/testbed_model/posix_session.py
+++ b/dts/framework/testbed_model/posix_session.py
@@ -381,8 +381,6 @@ def get_compiler_version(self, compiler_name: str) -> str:
                 ).stdout.split("\n")[0]
             case "msvc":
                 return self.send_command("cl", SETTINGS.timeout).stdout
-            case "icc":
-                return self.send_command(f"{compiler_name} -V", SETTINGS.timeout).stdout
             case _:
                 raise ValueError(f"Unknown compiler {compiler_name}")
 
diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index 7a252c1997..3f77b7624e 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -59,8 +59,6 @@ extern "C" {
 #define RTE_CC_IS_GNU 0
 #if defined __clang__
 #define RTE_CC_CLANG
-#elif defined __INTEL_COMPILER
-#define RTE_CC_ICC
 #elif defined __GNUC__
 #define RTE_CC_GCC
 #undef RTE_CC_IS_GNU
@@ -160,7 +158,7 @@ typedef uint16_t unaligned_uint16_t;
  * Macros to cause the compiler to remember the state of the diagnostics as of
  * each push, and restore to that point at each pop.
  */
-#if !defined(__INTEL_COMPILER) && !defined(RTE_TOOLCHAIN_MSVC)
+#if !defined(RTE_TOOLCHAIN_MSVC)
 #define __rte_diagnostic_push _Pragma("GCC diagnostic push")
 #define __rte_diagnostic_pop  _Pragma("GCC diagnostic pop")
 #else
@@ -172,7 +170,7 @@ typedef uint16_t unaligned_uint16_t;
  * Macro to disable compiler warnings about removing a type
  * qualifier from the target type.
  */
-#if !defined(__INTEL_COMPILER) && !defined(RTE_TOOLCHAIN_MSVC)
+#if !defined(RTE_TOOLCHAIN_MSVC)
 #define __rte_diagnostic_ignored_wcast_qual _Pragma("GCC diagnostic ignored \"-Wcast-qual\"")
 #else
 #define __rte_diagnostic_ignored_wcast_qual
diff --git a/lib/eal/x86/include/rte_rtm.h b/lib/eal/x86/include/rte_rtm.h
index b84e58e059..6689d036c8 100644
--- a/lib/eal/x86/include/rte_rtm.h
+++ b/lib/eal/x86/include/rte_rtm.h
@@ -7,7 +7,7 @@
 
 #include <immintrin.h>
 
-/* Official RTM intrinsics interface matching gcc/icc, but works
+/* Official RTM intrinsics interface matching gcc, but works
    on older gcc compatible compilers and binutils. */
 
 #include <rte_common.h>
diff --git a/lib/eal/x86/include/rte_vect.h b/lib/eal/x86/include/rte_vect.h
index 5fdcd632ac..04b54ee52b 100644
--- a/lib/eal/x86/include/rte_vect.h
+++ b/lib/eal/x86/include/rte_vect.h
@@ -74,19 +74,6 @@ __extension__ ({                \
 })
 #endif
 
-/*
- * Prior to version 12.1 icc doesn't support _mm_set_epi64x.
- */
-#if (defined(__ICC) && __ICC < 1210)
-#define _mm_set_epi64x(a, b)     \
-__extension__ ({                 \
-	rte_xmm_t m;             \
-	m.u64[0] = b;            \
-	m.u64[1] = a;            \
-	(m.x);                   \
-})
-#endif /* (defined(__ICC) && __ICC < 1210) */
-
 #ifdef __AVX512F__
 
 #define RTE_X86_ZMM_SIZE	(sizeof(__m512i))
diff --git a/lib/sched/rte_pie.c b/lib/sched/rte_pie.c
index 2eb0b0f74e..a9f650e60f 100644
--- a/lib/sched/rte_pie.c
+++ b/lib/sched/rte_pie.c
@@ -9,10 +9,6 @@
 #include "rte_sched_log.h"
 #include "rte_pie.h"
 
-#ifdef __INTEL_COMPILER
-#pragma warning(disable:2259) /* conversion may lose significant bits */
-#endif
-
 int
 rte_pie_rt_data_init(struct rte_pie *pie)
 {
diff --git a/lib/sched/rte_red.c b/lib/sched/rte_red.c
index 45a452f68e..fa27a141ed 100644
--- a/lib/sched/rte_red.c
+++ b/lib/sched/rte_red.c
@@ -7,10 +7,6 @@
 #include <rte_random.h>
 #include <rte_common.h>
 
-#ifdef __INTEL_COMPILER
-#pragma warning(disable:2259) /* conversion may lose significant bits */
-#endif
-
 static int rte_red_init_done = 0;     /**< Flag to indicate that global initialisation is done */
 uint32_t rte_red_rand_val = 0;        /**< Random value cache */
 uint32_t rte_red_rand_seed = 0;       /**< Seed for random number generation */
diff --git a/lib/sched/rte_sched.c b/lib/sched/rte_sched.c
index bbdb5d1d86..d8ee4e7e91 100644
--- a/lib/sched/rte_sched.c
+++ b/lib/sched/rte_sched.c
@@ -22,11 +22,6 @@
 
 #include "rte_approx.h"
 
-
-#ifdef __INTEL_COMPILER
-#pragma warning(disable:2259) /* conversion may lose significant bits */
-#endif
-
 #ifndef RTE_SCHED_PORT_N_GRINDERS
 #define RTE_SCHED_PORT_N_GRINDERS 8
 #endif
diff --git a/lib/vhost/meson.build b/lib/vhost/meson.build
index 51bcf17244..2eec51b2e7 100644
--- a/lib/vhost/meson.build
+++ b/lib/vhost/meson.build
@@ -12,8 +12,6 @@ if (toolchain == 'gcc' and cc.version().version_compare('>=8.3.0'))
     cflags += '-DVHOST_GCC_UNROLL_PRAGMA'
 elif (toolchain == 'clang' and cc.version().version_compare('>=3.7.0'))
     cflags += '-DVHOST_CLANG_UNROLL_PRAGMA'
-elif (toolchain == 'icc' and cc.version().version_compare('>=16.0.0'))
-    cflags += '-DVHOST_ICC_UNROLL_PRAGMA'
 endif
 dpdk_conf.set('RTE_LIBRTE_VHOST_POSTCOPY', cc.has_header('linux/userfaultfd.h'))
 cflags += [
diff --git a/lib/vhost/vhost.h b/lib/vhost/vhost.h
index 1f4192f5d1..63d2aa9502 100644
--- a/lib/vhost/vhost.h
+++ b/lib/vhost/vhost.h
@@ -79,11 +79,6 @@
 	for (iter = val; iter < size; iter++)
 #endif
 
-#ifdef VHOST_ICC_UNROLL_PRAGMA
-#define vhost_for_each_try_unroll(iter, val, size) _Pragma("unroll (4)") \
-	for (iter = val; iter < size; iter++)
-#endif
-
 #ifndef vhost_for_each_try_unroll
 #define vhost_for_each_try_unroll(iter, val, num) \
 	for (iter = val; iter < num; iter++)
-- 
2.43.0

