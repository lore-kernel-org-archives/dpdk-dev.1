Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11B0C02198
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 18:29:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5831740611;
	Wed,  5 Feb 2025 19:29:41 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 580F940649
 for <dev@dpdk.org>; Wed,  5 Feb 2025 19:29:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738780179; x=1770316179;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TOSOd9A7r0rUTDND9oOL+KikiK14ZU+lWmv2YczJZ6U=;
 b=Kjp3/lgZdNg7ZBoYk2q3jY5vgY9q65Y7FwbVaF0uXNtpSj9Rc3y0cNa3
 O3ysDMrkHXeLBHqr0fanPGQqbmWdbZl07HRL6vlzsJpoZYfcGE6nPRMQX
 apqodQSUKfubV3mkeKMrdpb58bE2pSfK787g3bcK9avAYcibHMfKu/EJI
 +TCvJ20793AwLCqBHry5EYZQd+1TOWMpmdsjc1Z8zHjTJHSHpTDM6Z7vm
 ee6dIr/pqQFZaTAUQPZIxFxnwLhyf78F6qULuX5XAksocduif6HX6iu7V
 pITsORNpk5Aa38BdZ94h5O5mZwSW2a+BP6DHBD2i5sBxHEzEEioGhnA4r A==;
X-CSE-ConnectionGUID: W10jnQNsTAmTc0wSQkoI2A==
X-CSE-MsgGUID: 7EVi5hR8TUKdvg3+I/jlvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39497029"
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; d="scan'208";a="39497029"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2025 10:29:38 -0800
X-CSE-ConnectionGUID: VznWUvtaQpWtfVFPhOW1bw==
X-CSE-MsgGUID: lf7hmAILRGOX0EDS0EBeHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; d="scan'208";a="116024302"
Received: from silpixa00401197coob.ir.intel.com (HELO
 silpixa00401385.ir.intel.com) ([10.237.214.45])
 by fmviesa004.fm.intel.com with ESMTP; 05 Feb 2025 10:29:32 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: john.mcnamara@intel.com, Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Aman Singh <aman.deep.singh@intel.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 John Daley <johndale@cisco.com>, Hyong Youb Kim <hyonkim@cisco.com>,
 Ziyang Xuan <xuanziyang2@huawei.com>,
 Xiaoyun Wang <cloud.wangxiaoyun@huawei.com>, Jie Hai <haijie1@huawei.com>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Jian Wang <jianwang@trustnetic.com>,
 Shai Brandes <shaibran@amazon.com>, Evgeny Schemeilin <evgenys@amazon.com>,
 Ron Beider <rbeider@amazon.com>, Amit Bernstein <amitbern@amazon.com>,
 Wajeeh Atrash <atrwajee@amazon.com>, David Christensen <drc@linux.ibm.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>, Paul Szczepanek <paul.szczepanek@arm.com>,
 Patrick Robb <probb@iol.unh.edu>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
Subject: [PATCH v2 2/2] build: replace support for icc with icx
Date: Wed,  5 Feb 2025 18:29:15 +0000
Message-ID: <20250205182918.4041268-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205182918.4041268-1-bruce.richardson@intel.com>
References: <20250205161823.2849595-1-bruce.richardson@intel.com>
 <20250205182918.4041268-1-bruce.richardson@intel.com>
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

The "Intel C++ Compiler" (icc) has been replaced by the newer clang-based
"Intel oneAPI DPC++/C++ Compiler" (icx) compiler.  DPDK compilation has
also not been tested recently with the icc compiler, so let's remove doc
and code references to icc, and any special macros or build support that
was added for it. Document instead that icx can be used to compile DPDK.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
---
v2:
- remove more references to icc.
- in places where there was a comment indicating there was a workaround
  for icc, but it wasn't obvious what the workaround was, just remove
  the comment for now. The code is not broken, and so the workaround
  remaining is harmless.

Feedback welcome from maintainers on how to correctly remove these
workarounds! Will do v3 to fix them properly if feedback received!
---
 app/test-pmd/testpmd.h                        |  4 ----
 app/test/test_pie.c                           |  5 -----
 app/test/test_red.c                           |  5 -----
 buildtools/check-symbols.sh                   |  6 ++----
 .../contributing/img/patch_cheatsheet.svg     |  2 +-
 doc/guides/linux_gsg/sys_reqs.rst             |  3 +--
 doc/guides/nics/enic.rst                      |  2 +-
 doc/guides/nics/hinic.rst                     |  1 -
 doc/guides/nics/hns3.rst                      |  1 -
 doc/guides/nics/ngbe.rst                      |  1 -
 doc/guides/nics/txgbe.rst                     |  1 -
 doc/guides/prog_guide/lto.rst                 |  2 +-
 .../prog_guide/writing_efficient_code.rst     |  2 +-
 doc/guides/rel_notes/known_issues.rst         | 19 -------------------
 doc/guides/rel_notes/release_25_03.rst        |  5 +++++
 drivers/net/ena/ena_ethdev.c                  |  1 -
 drivers/net/mlx5/mlx5_rxtx_vec_altivec.h      |  2 +-
 drivers/net/virtio/meson.build                |  2 --
 drivers/net/virtio/virtio_rxtx_packed.h       |  5 -----
 dts/framework/config/__init__.py              |  2 --
 dts/framework/testbed_model/posix_session.py  |  2 --
 lib/eal/common/eal_common_dynmem.c            |  1 -
 lib/eal/include/rte_common.h                  |  6 ++----
 lib/eal/x86/include/rte_rtm.h                 |  2 +-
 lib/eal/x86/include/rte_vect.h                | 15 +--------------
 lib/sched/rte_pie.c                           |  4 ----
 lib/sched/rte_red.c                           |  4 ----
 lib/sched/rte_sched.c                         |  5 -----
 lib/vhost/meson.build                         |  2 --
 lib/vhost/vhost.h                             |  5 -----
 30 files changed, 17 insertions(+), 100 deletions(-)

diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index 260e4761bd..9e6a7d553a 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -1292,10 +1292,6 @@ RTE_INIT(__##c) \
 	testpmd_add_driver_commands(&c); \
 }

-/*
- * Work-around of a compilation error with ICC on invocations of the
- * rte_be_to_cpu_16() function.
- */
 #ifdef __GCC__
 #define RTE_BE_TO_CPU_16(be_16_v)  rte_be_to_cpu_16((be_16_v))
 #define RTE_CPU_TO_BE_16(cpu_16_v) rte_cpu_to_be_16((cpu_16_v))
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

diff --git a/buildtools/check-symbols.sh b/buildtools/check-symbols.sh
index e458c0af72..b8ac24391e 100755
--- a/buildtools/check-symbols.sh
+++ b/buildtools/check-symbols.sh
@@ -45,9 +45,8 @@ do
 	fi
 done

-# Filter out symbols suffixed with a . for icc
 for SYM in `awk '{
-	if ($2 != "l" && $4 == ".text.experimental" && !($NF ~ /\.$/)) {
+	if ($2 != "l" && $4 == ".text.experimental") {
 		print $NF
 	}
 }' $DUMPFILE`
@@ -76,9 +75,8 @@ do
 	fi
 done

-# Filter out symbols suffixed with a . for icc
 for SYM in `awk '{
-	if ($2 != "l" && $4 == ".text.internal" && !($NF ~ /\.$/)) {
+	if ($2 != "l" && $4 == ".text.internal") {
 		print $NF
 	}
 }' $DUMPFILE`
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
index 13d632cec7..5a7d9e4a43 100644
--- a/doc/guides/linux_gsg/sys_reqs.rst
+++ b/doc/guides/linux_gsg/sys_reqs.rst
@@ -71,8 +71,7 @@ Compilation of the DPDK

 **Optional Tools:**

-*   Intel\ |reg| C++ Compiler (icc). For installation, additional libraries may be required.
-    See the icc Installation Guide found in the Documentation directory under the compiler installation.
+*   Intel\ |reg| oneAPI DPC++/C++ Compiler.

 *   IBM\ |reg| Advance ToolChain for Powerlinux. This is a set of open source development tools and runtime libraries
     which allows users to take leading edge advantage of IBM's latest POWER hardware features on Linux. To install
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

diff --git a/doc/guides/rel_notes/release_25_03.rst b/doc/guides/rel_notes/release_25_03.rst
index 269ab6f68a..da8e32c9ce 100644
--- a/doc/guides/rel_notes/release_25_03.rst
+++ b/doc/guides/rel_notes/release_25_03.rst
@@ -106,6 +106,11 @@ Removed Items
    Also, make sure to start the actual text at the margin.
    =======================================================

+* **Support for Intel\ |reg| C++ Compiler (icc) (replaced by "icx" support)**
+
+  Support for the older Intel\ |reg| C++ Compiler "icc" has been dropped.
+  The newer Intel\ |reg| oneAPI DPC++/C++ Compiler, "icx", can be used to compile DPDK instead.
+

 API Changes
 -----------
diff --git a/drivers/net/ena/ena_ethdev.c b/drivers/net/ena/ena_ethdev.c
index aea2e5c929..4c6af8285e 100644
--- a/drivers/net/ena/ena_ethdev.c
+++ b/drivers/net/ena/ena_ethdev.c
@@ -1413,7 +1413,6 @@ static int ena_create_io_queue(struct rte_eth_dev *dev, struct ena_ring *ring)
 	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct ena_com_create_io_ctx ctx =
-		/* policy set to _HOST just to satisfy icc compiler */
 		{ ENA_ADMIN_PLACEMENT_POLICY_HOST,
 		  0, 0, 0, 0, 0 };
 	uint16_t ena_qid;
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

diff --git a/lib/eal/common/eal_common_dynmem.c b/lib/eal/common/eal_common_dynmem.c
index b4dc231940..3c34a7defb 100644
--- a/lib/eal/common/eal_common_dynmem.c
+++ b/lib/eal/common/eal_common_dynmem.c
@@ -510,7 +510,6 @@ eal_dynmem_calc_num_pages_per_socket(
 		/* if we didn't satisfy all memory requirements per socket */
 		if (memory[socket] > 0 &&
 				internal_conf->socket_mem[socket] != 0) {
-			/* to prevent icc errors */
 			requested = (unsigned int)(
 				internal_conf->socket_mem[socket] / 0x100000);
 			available = requested -
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
index 5fdcd632ac..70c78e9b77 100644
--- a/lib/eal/x86/include/rte_vect.h
+++ b/lib/eal/x86/include/rte_vect.h
@@ -17,7 +17,7 @@
 #include <rte_common.h>
 #include "generic/rte_vect.h"

-#if defined(__ICC) || defined(_WIN64)
+#if defined(_WIN64)
 #include <smmintrin.h> /* SSE4 */
 #include <immintrin.h>
 #else
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

