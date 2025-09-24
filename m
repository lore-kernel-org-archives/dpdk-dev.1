Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0566DCAC5A5
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 11:13:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D343F40289;
	Wed, 24 Sep 2025 13:13:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id B4D854027C
 for <dev@dpdk.org>; Wed, 24 Sep 2025 13:13:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758712411; x=1790248411;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cEdAynOmUBSEhssCaSKFTdVa7m/vqDqg1yILrFzDEi0=;
 b=Nas2c6/iTgwPsUX31MGNTMBF9hRqPlNwGwTSHpGDyUS2JRyRbg/fztoe
 EeDmY28QgcDt31sadte8TEfdKC4Q4MaxwG2hkSkq8g8DF8e6o5utvETMa
 3YQgBa83wGNuzh2S/dork3DvevhEW9Vp1mWFH0s4cUb5lLjOGAItno6QO
 sPzqwo4Gk/Vcaf0a2wPapeZUR0QAjv25aR2WkI5XJ3pC8rk5Gyasxpn3v
 wgcmj38IFTyt5kYfWt9Qidvg1Uar60kgBoN9FsbhutQ7wRPa2rx+twY1D
 r304OaVHajO66P/sJw9dIckCeK2WVrG/JBBX9r7dfsYC8fqLaGk4K4fnU w==;
X-CSE-ConnectionGUID: q2arBzLtSliWOyHsSg6ihw==
X-CSE-MsgGUID: J4xPAynRSuyOvxN8L4QPBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="71628106"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; d="scan'208";a="71628106"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2025 04:13:29 -0700
X-CSE-ConnectionGUID: Cxbh8uOmRhqBnqaL7Fe9BA==
X-CSE-MsgGUID: 7JZjKE8SQRukqpLjOz6Rfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; d="scan'208";a="207941636"
Received: from silpixa00401385.ir.intel.com (HELO silpixa00401385..)
 ([10.20.224.226])
 by fmviesa001.fm.intel.com with ESMTP; 24 Sep 2025 04:13:24 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Nicolas Chautru <nicolas.chautru@intel.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Srikanth Yalavarthi <syalavarthi@marvell.com>,
 Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 David Hunt <david.hunt@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>,
 Rosen Xu <rosen.xu@altera.com>,
 Tomasz Kantecki <tomasz.kantecki@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v2] build: validate libraries returned from meson find function
Date: Wed, 24 Sep 2025 11:54:00 +0100
Message-ID: <20250924111318.567771-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250923165830.527416-1-bruce.richardson@intel.com>
References: <20250923165830.527416-1-bruce.richardson@intel.com>
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

The meson find_library() API call sometimes finds a library that is
actually incompatible with the current build, for example, returning a
64-bit library when doing a 32-bit build. To avoid problems with this,
check each library returned from a find_library() call and treat the
library as unfound if its incompatible.

This checking is not necessary (or should not be necessary) for
dependencies got using pkg-config, since the .pc files for each build
type are stored in a different directory on the system.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
v2: expanded the scope of the patch from just fixing the one instance
    I hit, to changing things globally to try and avoid any future issues.
---
 config/meson.build                            | 15 ++++++----
 drivers/baseband/acc/meson.build              | 30 +++++++++++++++----
 drivers/baseband/turbo_sw/meson.build         | 30 +++++++++++++++----
 drivers/common/mlx5/linux/meson.build         |  4 +--
 drivers/common/mlx5/windows/meson.build       |  2 +-
 drivers/ml/cnxk/meson.build                   |  6 +++-
 drivers/net/af_xdp/meson.build                |  3 ++
 drivers/net/mana/meson.build                  |  2 +-
 drivers/net/mlx4/meson.build                  |  2 +-
 drivers/net/pcap/meson.build                  |  6 +++-
 drivers/power/amd_uncore/meson.build          |  2 +-
 drivers/raw/ifpga/meson.build                 |  2 +-
 examples/l2fwd-cat/meson.build                |  2 +-
 examples/l2fwd-keepalive/meson.build          |  2 +-
 .../vm_power_manager/guest_cli/meson.build    |  2 +-
 examples/vm_power_manager/meson.build         |  2 +-
 lib/eal/windows/meson.build                   | 24 +++++++++++----
 meson.build                                   |  3 ++
 18 files changed, 105 insertions(+), 34 deletions(-)

diff --git a/config/meson.build b/config/meson.build
index 55497f0bf5..bb8d475ec8 100644
--- a/config/meson.build
+++ b/config/meson.build
@@ -208,7 +208,8 @@ if not is_windows
 endif
 
 # on some OS, maths functions are in a separate library
-if cc.find_library('m', required : false).found()
+math_dep = cc.find_library('m', required : false)
+if math_dep.found() and cc.links(min_c_code, dependencies: math_dep)
     # some libs depend on maths lib
     add_project_link_arguments('-lm', language: 'c')
     dpdk_extra_ldflags += '-lm'
@@ -235,7 +236,7 @@ if meson.is_cross_build() and not meson.get_external_property('numa', true)
 endif
 if find_libnuma
     numa_dep = cc.find_library('numa', required: false)
-    if numa_dep.found() and cc.has_header('numaif.h')
+    if numa_dep.found() and cc.has_header('numaif.h') and cc.links(min_c_code, dependencies: numa_dep)
         dpdk_conf.set10('RTE_HAS_LIBNUMA', true)
         has_libnuma = true
         add_project_link_arguments('-lnuma', language: 'c')
@@ -245,7 +246,7 @@ endif
 
 has_libfdt = false
 fdt_dep = cc.find_library('fdt', required: false)
-if fdt_dep.found() and cc.has_header('fdt.h')
+if fdt_dep.found() and cc.has_header('fdt.h') and cc.links(min_c_code, dependencies: fdt_dep)
     dpdk_conf.set10('RTE_HAS_LIBFDT', true)
     has_libfdt = true
     add_project_link_arguments('-lfdt', language: 'c')
@@ -253,7 +254,7 @@ if fdt_dep.found() and cc.has_header('fdt.h')
 endif
 
 libexecinfo = cc.find_library('execinfo', required: false)
-if libexecinfo.found()
+if libexecinfo.found() and cc.links(min_c_code, dependencies: libexecinfo)
     add_project_link_arguments('-lexecinfo', language: 'c')
     dpdk_extra_ldflags += '-lexecinfo'
 endif
@@ -288,7 +289,8 @@ if not pcap_dep.found()
     # pcap got a pkg-config file only in 1.9.0
     pcap_dep = cc.find_library(pcap_lib, required: false)
 endif
-if pcap_dep.found() and cc.has_header('pcap.h', dependencies: pcap_dep)
+if (pcap_dep.found() and cc.has_header('pcap.h', dependencies: pcap_dep)
+        and cc.links(min_c_code, dependencies: pcap_dep))
     dpdk_conf.set('RTE_HAS_LIBPCAP', 1)
     dpdk_extra_ldflags += '-l@0@'.format(pcap_lib)
 endif
@@ -296,6 +298,9 @@ endif
 # for clang 32-bit compiles we need libatomic for 64-bit atomic ops
 if cc.get_id() == 'clang' and dpdk_conf.get('RTE_ARCH_64') == false
     atomic_dep = cc.find_library('atomic', required: true)
+    if not cc.links(min_c_code, dependencies: atomic_dep)
+        error('broken dependency, "libatomic"')
+    endif
     add_project_link_arguments('-latomic', language: 'c')
     dpdk_extra_ldflags += '-latomic'
 endif
diff --git a/drivers/baseband/acc/meson.build b/drivers/baseband/acc/meson.build
index 64fcf1537a..4e6d715d7c 100644
--- a/drivers/baseband/acc/meson.build
+++ b/drivers/baseband/acc/meson.build
@@ -5,11 +5,31 @@
 dep_dec5g = dependency('flexran_sdk_ldpc_decoder_5gnr', required: false)
 
 if dep_dec5g.found()
-    ext_deps += cc.find_library('stdc++', required: true)
-    ext_deps += cc.find_library('irc', required: true)
-    ext_deps += cc.find_library('imf', required: true)
-    ext_deps += cc.find_library('ipps', required: true)
-    ext_deps += cc.find_library('svml', required: true)
+    stdcpp_dep = cc.find_library('stdc++', required: true)
+    if not cc.links(min_c_code, dependencies: stdcpp_dep)
+        error('broken dependency, "libstdc++"')
+    endif
+    ext_deps += stdcpp_dep
+    irc_dep = cc.find_library('irc', required: true)
+    if not cc.links(min_c_code, dependencies: irc_dep)
+        error('broken dependency, "libirc"')
+    endif
+    ext_deps += irc_dep
+    imf_dep = cc.find_library('imf', required: true)
+    if not cc.links(min_c_code, dependencies: imf_dep)
+        error('broken dependency, "libimf"')
+    endif
+    ext_deps += imf_dep
+    ipps_dep = cc.find_library('ipps', required: true)
+    if not cc.links(min_c_code, dependencies: ipps_dep)
+        error('broken dependency, "libipps"')
+    endif
+    ext_deps += ipps_dep
+    svml_dep = cc.find_library('svml', required: true)
+    if not cc.links(min_c_code, dependencies: svml_dep)
+        error('broken dependency, "libsvml"')
+    endif
+    ext_deps += svml_dep
     ext_deps += dep_dec5g
     ext_deps += dependency('flexran_sdk_ldpc_encoder_5gnr', required: true)
     ext_deps += dependency('flexran_sdk_LDPC_ratematch_5gnr', required: true)
diff --git a/drivers/baseband/turbo_sw/meson.build b/drivers/baseband/turbo_sw/meson.build
index a9035a753e..5fd5e41c69 100644
--- a/drivers/baseband/turbo_sw/meson.build
+++ b/drivers/baseband/turbo_sw/meson.build
@@ -6,11 +6,31 @@ dep_turbo = dependency('flexran_sdk_turbo', required: false)
 dep_dec5g = dependency('flexran_sdk_ldpc_decoder_5gnr', required: false)
 
 if dep_turbo.found()
-    ext_deps += cc.find_library('stdc++', required: true)
-    ext_deps += cc.find_library('irc', required: true)
-    ext_deps += cc.find_library('imf', required: true)
-    ext_deps += cc.find_library('ipps', required: true)
-    ext_deps += cc.find_library('svml', required: true)
+    stdcpp_dep = cc.find_library('stdc++', required: true)
+    if not cc.links(min_c_code, dependencies: stdcpp_dep)
+        error('broken dependency, "libstdc++"')
+    endif
+    ext_deps += stdcpp_dep
+    irc_dep = cc.find_library('irc', required: true)
+    if not cc.links(min_c_code, dependencies: irc_dep)
+        error('broken dependency, "libirc"')
+    endif
+    ext_deps += irc_dep
+    imf_dep = cc.find_library('imf', required: true)
+    if not cc.links(min_c_code, dependencies: imf_dep)
+        error('broken dependency, "libimf"')
+    endif
+    ext_deps += imf_dep
+    ipps_dep = cc.find_library('ipps', required: true)
+    if not cc.links(min_c_code, dependencies: ipps_dep)
+        error('broken dependency, "libipps"')
+    endif
+    ext_deps += ipps_dep
+    svml_dep = cc.find_library('svml', required: true)
+    if not cc.links(min_c_code, dependencies: svml_dep)
+        error('broken dependency, "libsvml"')
+    endif
+    ext_deps += svml_dep
     ext_deps += dep_turbo
     ext_deps += dependency('flexran_sdk_crc', required: true)
     ext_deps += dependency('flexran_sdk_rate_matching', required: true)
diff --git a/drivers/common/mlx5/linux/meson.build b/drivers/common/mlx5/linux/meson.build
index 5548a56199..3fe7db7ec4 100644
--- a/drivers/common/mlx5/linux/meson.build
+++ b/drivers/common/mlx5/linux/meson.build
@@ -23,7 +23,7 @@ foreach libname:libnames
     if not lib.found() and not static_ibverbs
         lib = cc.find_library(libname, required:false)
     endif
-    if lib.found()
+    if lib.found() and cc.links(min_c_code, dependencies: lib)
         libs += lib
         if not static_ibverbs and not dlopen_ibverbs
             ext_deps += lib
@@ -47,7 +47,7 @@ endif
 
 libmtcr_ul_found = false
 lib = cc.find_library('mtcr_ul', required:false)
-if lib.found()
+if lib.found() and cc.links(min_c_code, dependencies: lib)
     libmtcr_ul_found = true
     ext_deps += lib
 endif
diff --git a/drivers/common/mlx5/windows/meson.build b/drivers/common/mlx5/windows/meson.build
index c3bd3aac26..f454788a9f 100644
--- a/drivers/common/mlx5/windows/meson.build
+++ b/drivers/common/mlx5/windows/meson.build
@@ -8,7 +8,7 @@ if not cc.has_header('mlx5devx.h')
 endif
 
 devxlib = cc.find_library('mlx5devx', required: false)
-if not devxlib.found()
+if not devxlib.found() or not cc.links(min_c_code, dependencies: devxlib)
     build = false
     reason = 'missing dependency, "mlx5devx"'
     subdir_done()
diff --git a/drivers/ml/cnxk/meson.build b/drivers/ml/cnxk/meson.build
index 0680a0faa5..ef7e21d747 100644
--- a/drivers/ml/cnxk/meson.build
+++ b/drivers/ml/cnxk/meson.build
@@ -72,7 +72,11 @@ ext_deps += dlpack_dep
 ext_deps += dmlc_dep
 ext_deps += tvm_dep
 ext_deps += tvmdp_dep
-ext_deps += cc.find_library('stdc++', required: true)
+stdcpp_dep = cc.find_library('stdc++', required: true)
+if not cc.links(min_c_code, dependencies: stdcpp_dep)
+    error('broken dependency, "libstdc++"')
+endif
+ext_deps += stdcpp_dep
 
 deps += ['bus_vdev']
 
diff --git a/drivers/net/af_xdp/meson.build b/drivers/net/af_xdp/meson.build
index 2d37bcc869..b35888b869 100644
--- a/drivers/net/af_xdp/meson.build
+++ b/drivers/net/af_xdp/meson.build
@@ -20,6 +20,9 @@ xdp_dep = dependency('libxdp', version : libxdp_ver, required: false, method: 'p
 bpf_dep = dependency('libbpf', required: false, method: 'pkg-config')
 if not bpf_dep.found()
     bpf_dep = cc.find_library('bpf', required: false)
+    if bpf_dep.found() and not cc.links(min_c_code, dependencies: bpf_dep)
+        bpf_dep = disabler()
+    endif
 endif
 
 cflags += no_wvla_cflag
diff --git a/drivers/net/mana/meson.build b/drivers/net/mana/meson.build
index e320da7fc4..19d4b3695e 100644
--- a/drivers/net/mana/meson.build
+++ b/drivers/net/mana/meson.build
@@ -27,7 +27,7 @@ foreach libname:libnames
     if not lib.found()
         lib = cc.find_library(libname, required:false)
     endif
-    if lib.found()
+    if lib.found() and cc.links(min_c_code, dependencies: lib)
         libs += lib
         ext_deps += lib
     else
diff --git a/drivers/net/mlx4/meson.build b/drivers/net/mlx4/meson.build
index 869d2895c8..1eb67f3c47 100644
--- a/drivers/net/mlx4/meson.build
+++ b/drivers/net/mlx4/meson.build
@@ -31,7 +31,7 @@ foreach libname:libnames
     if not lib.found() and not static_ibverbs
         lib = cc.find_library(libname, required:false)
     endif
-    if lib.found()
+    if lib.found() and cc.links(min_c_code, dependencies: lib)
         libs += lib
         if not static_ibverbs and not dlopen_ibverbs
             ext_deps += lib
diff --git a/drivers/net/pcap/meson.build b/drivers/net/pcap/meson.build
index 676c55018e..f30fc8338b 100644
--- a/drivers/net/pcap/meson.build
+++ b/drivers/net/pcap/meson.build
@@ -13,7 +13,11 @@ sources = files(
 
 ext_deps += pcap_dep
 if is_windows
-    ext_deps += cc.find_library('iphlpapi', required: true)
+    iphlpapi_dep = cc.find_library('iphlpapi', required: true)
+    if not cc.links(min_c_code, dependencies: iphlpapi_dep)
+        error('broken dependency, "iphlpapi"')
+    endif
+    ext_deps += iphlpapi_dep
 endif
 
 require_iova_in_mbuf = false
diff --git a/drivers/power/amd_uncore/meson.build b/drivers/power/amd_uncore/meson.build
index 8cbab47b01..cab260b64e 100644
--- a/drivers/power/amd_uncore/meson.build
+++ b/drivers/power/amd_uncore/meson.build
@@ -9,7 +9,7 @@ endif
 
 ESMI_header = '#include<e_smi/e_smi.h>'
 lib = cc.find_library('e_smi64', required: false)
-if not lib.found()
+if not lib.found() or not cc.links(min_c_code, dependencies: lib)
     build = false
     reason = 'missing dependency, "libe_smi"'
 else
diff --git a/drivers/raw/ifpga/meson.build b/drivers/raw/ifpga/meson.build
index 4295ec04bd..395894af2a 100644
--- a/drivers/raw/ifpga/meson.build
+++ b/drivers/raw/ifpga/meson.build
@@ -11,7 +11,7 @@ rtdep = dependency('librt', required: false)
 if not rtdep.found()
     rtdep = cc.find_library('rt', required: false)
 endif
-if not rtdep.found()
+if not rtdep.found() or not cc.links(min_c_code, dependencies: rtdep)
     build = false
     reason = 'missing dependency, "librt"'
     subdir_done()
diff --git a/examples/l2fwd-cat/meson.build b/examples/l2fwd-cat/meson.build
index ebcc3f66f2..5e8ff3a56c 100644
--- a/examples/l2fwd-cat/meson.build
+++ b/examples/l2fwd-cat/meson.build
@@ -7,7 +7,7 @@
 # DPDK instance, use 'make'
 
 pqos = cc.find_library('pqos', required: false)
-build = pqos.found()
+build = (pqos.found() and cc.links(min_c_code, dependencies: pqos))
 if not build
     subdir_done()
 endif
diff --git a/examples/l2fwd-keepalive/meson.build b/examples/l2fwd-keepalive/meson.build
index ed49c61238..e3f72aedb8 100644
--- a/examples/l2fwd-keepalive/meson.build
+++ b/examples/l2fwd-keepalive/meson.build
@@ -8,7 +8,7 @@
 
 allow_experimental_apis = true
 librt = cc.find_library('rt', required: false)
-if not librt.found()
+if not librt.found() or not cc.links(min_c_code, dependencies: librt)
     build = false
     subdir_done()
 endif
diff --git a/examples/vm_power_manager/guest_cli/meson.build b/examples/vm_power_manager/guest_cli/meson.build
index 00bc32526d..6a6809240e 100644
--- a/examples/vm_power_manager/guest_cli/meson.build
+++ b/examples/vm_power_manager/guest_cli/meson.build
@@ -17,5 +17,5 @@ sources = files(
 allow_experimental_apis = true
 
 opt_dep = cc.find_library('virt', required : false)
-build = opt_dep.found()
+build = (opt_dep.found() and cc.links(min_c_code, dependencies: opt_dep))
 ext_deps += opt_dep
diff --git a/examples/vm_power_manager/meson.build b/examples/vm_power_manager/meson.build
index dcf23198eb..53949ce6d8 100644
--- a/examples/vm_power_manager/meson.build
+++ b/examples/vm_power_manager/meson.build
@@ -38,7 +38,7 @@ else
 endif
 
 opt_dep = cc.find_library('virt', required : false)
-build = opt_dep.found()
+build = (opt_dep.found() and cc.links(min_c_code, dependencies: opt_dep))
 ext_deps += opt_dep
 
 opt_dep = dependency('jansson', required : false, method: 'pkg-config')
diff --git a/lib/eal/windows/meson.build b/lib/eal/windows/meson.build
index c526ede405..afa029d1fc 100644
--- a/lib/eal/windows/meson.build
+++ b/lib/eal/windows/meson.build
@@ -24,12 +24,24 @@ sources += files(
 
 dpdk_conf.set10('RTE_EAL_NUMA_AWARE_HUGEPAGES', true)
 
-ext_deps += [
-        cc.find_library('dbghelp'),
-        cc.find_library('setupapi'),
-        cc.find_library('ws2_32'),
-]
+dbghelp_dep = cc.find_library('dbghelp')
+if not cc.links(min_c_code, dependencies: dbghelp_dep)
+    error('broken dependency, "dbghelp"')
+endif
+setupapi_dep = cc.find_library('setupapi')
+if not cc.links(min_c_code, dependencies: setupapi_dep)
+    error('broken dependency, "setupapi"')
+endif
+ws2_32_dep = cc.find_library('ws2_32')
+if not cc.links(min_c_code, dependencies: ws2_32_dep)
+    error('broken dependency, "ws2_32"')
+endif
+ext_deps += [dbghelp_dep, setupapi_dep, ws2_32_dep]
 if is_ms_linker
         # Contrary to docs, VirtualAlloc2() is exported by mincore.lib.
-        ext_deps += cc.find_library('mincore')
+        mincore_dep = cc.find_library('mincore')
+        if not cc.links(min_c_code, dependencies: mincore_dep)
+            error('broken dependency, "mincore"')
+        endif
+        ext_deps += mincore_dep
 endif
diff --git a/meson.build b/meson.build
index 2423884df7..fcf3d79a3d 100644
--- a/meson.build
+++ b/meson.build
@@ -51,6 +51,9 @@ testpmd_drivers_sources = []
 testpmd_drivers_deps = []
 abi_version_file = files('ABI_VERSION')
 
+# minimal C code for testing library linking compatibility
+min_c_code = 'int main(void) { return 0; }'
+
 if host_machine.cpu_family().startswith('x86')
     arch_subdir = 'x86'
 elif host_machine.cpu_family().startswith('arm') or host_machine.cpu_family().startswith('aarch')
-- 
2.48.1

