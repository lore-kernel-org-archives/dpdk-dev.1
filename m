Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12ECC021AD
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 11:16:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E08AF40648;
	Tue, 18 Feb 2025 12:16:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id B8AB240648
 for <dev@dpdk.org>; Tue, 18 Feb 2025 12:15:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739877360; x=1771413360;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=f5n65BQHe8mgUHNrJ4bOoCsYaiR5xuxVk3zv8i7ORZg=;
 b=SHkKu0dL147cZLW3pKfcuwBmp9tvns94myX9VFL3Oya8kBgFPke6B2sY
 pW6JM4o5A7/N8al9hmhBOndQ8IPQsu3mLlVcm2TdMEK0Eyfu8emy5xjbJ
 XVljEK71DN6ZxiQax9gqGunnMFE/M8guQHynkhTbnD5Lxqmx4yGGIIH9N
 UaOfipGOorldJ/4w+OnWYJx7xG0+BQ4CHrDantpq/u2Xf0KmkSFC5WxxO
 8KGo9nQnnxpQ3pGLaY7CnQMkqYTcyP7ErTYEijjFNPHdItw9ScVHSlDnZ
 fXnNwjTGe6q+elbJwscsCwWd0LeBE3w8LZ3Q0lRKwhXPcRLmbQ41ER8Ev g==;
X-CSE-ConnectionGUID: yoFbVm4jR7uD+Yeaz6pLew==
X-CSE-MsgGUID: xmmeYkrRRXuCdEtB3sAQjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="50780846"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="50780846"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 03:15:58 -0800
X-CSE-ConnectionGUID: KpD29CGWTU6q9Mq8fgMTCQ==
X-CSE-MsgGUID: 0vXarYvzRK2WFIrSbOvEfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="119466304"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa004.fm.intel.com with ESMTP; 18 Feb 2025 03:15:48 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Chengwen Feng <fengchengwen@huawei.com>,
 Nicolas Chautru <nicolas.chautru@intel.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Fan Zhang <fanzhang.oss@gmail.com>,
 Ashish Gupta <ashish.gupta@marvell.com>, Akhil Goyal <gakhil@marvell.com>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 David Hunt <david.hunt@intel.com>, Kevin Laatz <kevin.laatz@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Byron Marohn <byron.marohn@intel.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>, Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Jerin Jacob <jerinj@marvell.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Elena Agostini <eagostini@nvidia.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>, Jiayu Hu <hujiayu.hu@foxmail.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Reshma Pattan <reshma.pattan@intel.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Srikanth Yalavarthi <syalavarthi@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Anoob Joseph <anoobj@marvell.com>, Volodymyr Fialko <vfialko@marvell.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 Ori Kam <orika@nvidia.com>, Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v6 5/8] lib: reduce library dependencies
Date: Tue, 18 Feb 2025 11:15:31 +0000
Message-ID: <b6fd122e3b9d355024f5d392922ec849e65cf243.1739877266.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1739877265.git.anatoly.burakov@intel.com>
References: <cover.1725462264.git.anatoly.burakov@intel.com>
 <cover.1739877265.git.anatoly.burakov@intel.com>
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

From: Bruce Richardson <bruce.richardson@intel.com>

Rather than having each library depend up on EAL + any extra libs, we
can take advantage of recursive dependency support in meson and
just assign the dependencies of each directory directly, rather than
appending to the array. For libraries which only depend upon EAL, keep
that as a default, but for libraries which depend upon even a single
extra lib, that EAL dependency is unnecessary.

Going further, we can identify using the find_duplicate_deps.py script
any unnecessary deps in each library's list, and remove them to slim the
dependency tree down.

Reducing number of dependencies means that meson takes less time
processing and deduplicating the dependency tree for each component, and
also shrinks the dependency graph for DPDK itself.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/argparse/meson.build     | 2 +-
 lib/bbdev/meson.build        | 2 +-
 lib/bitratestats/meson.build | 2 +-
 lib/bpf/meson.build          | 2 +-
 lib/cmdline/meson.build      | 2 +-
 lib/compressdev/meson.build  | 2 +-
 lib/cryptodev/meson.build    | 2 +-
 lib/dispatcher/meson.build   | 2 +-
 lib/distributor/meson.build  | 2 +-
 lib/dmadev/meson.build       | 2 --
 lib/eal/meson.build          | 5 +----
 lib/efd/meson.build          | 2 +-
 lib/ethdev/meson.build       | 2 +-
 lib/eventdev/meson.build     | 3 +--
 lib/fib/meson.build          | 4 +---
 lib/gpudev/meson.build       | 2 +-
 lib/graph/meson.build        | 2 +-
 lib/gro/meson.build          | 2 +-
 lib/gso/meson.build          | 2 +-
 lib/hash/meson.build         | 4 +---
 lib/ip_frag/meson.build      | 2 +-
 lib/ipsec/meson.build        | 2 +-
 lib/kvargs/meson.build       | 2 +-
 lib/latencystats/meson.build | 2 +-
 lib/lpm/meson.build          | 4 +---
 lib/mbuf/meson.build         | 2 +-
 lib/member/meson.build       | 2 +-
 lib/mempool/meson.build      | 2 +-
 lib/metrics/meson.build      | 2 +-
 lib/mldev/meson.build        | 2 +-
 lib/net/meson.build          | 2 +-
 lib/node/meson.build         | 2 +-
 lib/pcapng/meson.build       | 2 +-
 lib/pdcp/meson.build         | 2 +-
 lib/pdump/meson.build        | 2 +-
 lib/pipeline/meson.build     | 2 +-
 lib/port/meson.build         | 2 +-
 lib/power/meson.build        | 3 +--
 lib/rawdev/meson.build       | 2 --
 lib/rcu/meson.build          | 2 +-
 lib/regexdev/meson.build     | 2 +-
 lib/reorder/meson.build      | 2 +-
 lib/rib/meson.build          | 2 +-
 lib/ring/meson.build         | 1 -
 lib/sched/meson.build        | 2 +-
 lib/security/meson.build     | 2 +-
 lib/table/meson.build        | 2 +-
 lib/telemetry/meson.build    | 2 +-
 lib/vhost/meson.build        | 2 +-
 49 files changed, 46 insertions(+), 62 deletions(-)

diff --git a/lib/argparse/meson.build b/lib/argparse/meson.build
index b6a08ca049..96abc8766f 100644
--- a/lib/argparse/meson.build
+++ b/lib/argparse/meson.build
@@ -4,4 +4,4 @@
 sources = files('rte_argparse.c')
 headers = files('rte_argparse.h')
 
-deps += ['log']
+deps = ['log']
diff --git a/lib/bbdev/meson.build b/lib/bbdev/meson.build
index 07685e7578..2e68aa7873 100644
--- a/lib/bbdev/meson.build
+++ b/lib/bbdev/meson.build
@@ -11,4 +11,4 @@ sources = files('rte_bbdev.c')
 headers = files('rte_bbdev.h',
         'rte_bbdev_pmd.h',
         'rte_bbdev_op.h')
-deps += ['mbuf']
+deps = ['mbuf']
diff --git a/lib/bitratestats/meson.build b/lib/bitratestats/meson.build
index ede7e0a579..8defcd53bf 100644
--- a/lib/bitratestats/meson.build
+++ b/lib/bitratestats/meson.build
@@ -3,4 +3,4 @@
 
 sources = files('rte_bitrate.c')
 headers = files('rte_bitrate.h')
-deps += ['ethdev', 'metrics']
+deps = ['metrics']
diff --git a/lib/bpf/meson.build b/lib/bpf/meson.build
index 28df7f469a..ba1d0cb1d0 100644
--- a/lib/bpf/meson.build
+++ b/lib/bpf/meson.build
@@ -33,7 +33,7 @@ headers = files('bpf_def.h',
         'rte_bpf.h',
         'rte_bpf_ethdev.h')
 
-deps += ['mbuf', 'net', 'ethdev']
+deps = ['ethdev']
 
 dep = dependency('libelf', required: false, method: 'pkg-config')
 if dep.found()
diff --git a/lib/cmdline/meson.build b/lib/cmdline/meson.build
index e38e05893a..b3b623156d 100644
--- a/lib/cmdline/meson.build
+++ b/lib/cmdline/meson.build
@@ -33,4 +33,4 @@ else
     sources += files('cmdline_os_unix.c')
 endif
 
-deps += ['net']
+deps = ['net']
diff --git a/lib/compressdev/meson.build b/lib/compressdev/meson.build
index c80295dc0d..4b86955baf 100644
--- a/lib/compressdev/meson.build
+++ b/lib/compressdev/meson.build
@@ -16,4 +16,4 @@ driver_sdk_headers = files(
         'rte_compressdev_pmd.h',
         'rte_compressdev_internal.h',
     )
-deps += ['kvargs', 'mbuf']
+deps = ['mbuf']
diff --git a/lib/cryptodev/meson.build b/lib/cryptodev/meson.build
index 4734acf321..74e42ac700 100644
--- a/lib/cryptodev/meson.build
+++ b/lib/cryptodev/meson.build
@@ -20,4 +20,4 @@ driver_sdk_headers += files(
         'cryptodev_pmd.h',
 )
 
-deps += ['kvargs', 'mbuf', 'rcu', 'telemetry']
+deps = ['mbuf', 'rcu']
diff --git a/lib/dispatcher/meson.build b/lib/dispatcher/meson.build
index 5e269b2d40..9de17765b5 100644
--- a/lib/dispatcher/meson.build
+++ b/lib/dispatcher/meson.build
@@ -12,4 +12,4 @@ cflags += no_wvla_cflag
 sources = files('rte_dispatcher.c')
 headers = files('rte_dispatcher.h')
 
-deps += ['eventdev']
+deps = ['eventdev']
diff --git a/lib/distributor/meson.build b/lib/distributor/meson.build
index 24988c5827..ba43273bc3 100644
--- a/lib/distributor/meson.build
+++ b/lib/distributor/meson.build
@@ -14,4 +14,4 @@ else
     sources += files('rte_distributor_match_generic.c')
 endif
 headers = files('rte_distributor.h')
-deps += ['mbuf']
+deps = ['mbuf']
diff --git a/lib/dmadev/meson.build b/lib/dmadev/meson.build
index e66dcb66b0..70b375f1cb 100644
--- a/lib/dmadev/meson.build
+++ b/lib/dmadev/meson.build
@@ -11,5 +11,3 @@ sources = files('rte_dmadev.c', 'rte_dmadev_trace_points.c')
 headers = files('rte_dmadev.h')
 indirect_headers += files('rte_dmadev_core.h', 'rte_dmadev_trace_fp.h')
 driver_sdk_headers += files('rte_dmadev_pmd.h')
-
-deps += ['telemetry']
diff --git a/lib/eal/meson.build b/lib/eal/meson.build
index e1d6c4cf17..d25443d097 100644
--- a/lib/eal/meson.build
+++ b/lib/eal/meson.build
@@ -14,10 +14,7 @@ subdir(exec_env)
 
 subdir(arch_subdir)
 
-deps += ['log', 'kvargs']
-if not is_windows
-    deps += ['telemetry']
-endif
+deps = ['kvargs', 'telemetry']
 if dpdk_conf.has('RTE_USE_LIBBSD')
     ext_deps += libbsd
 endif
diff --git a/lib/efd/meson.build b/lib/efd/meson.build
index 343f14e1f3..da0ee7f803 100644
--- a/lib/efd/meson.build
+++ b/lib/efd/meson.build
@@ -9,4 +9,4 @@ endif
 
 sources = files('rte_efd.c')
 headers = files('rte_efd.h')
-deps += ['ring', 'hash']
+deps = ['hash']
diff --git a/lib/ethdev/meson.build b/lib/ethdev/meson.build
index f1d2586591..fc53a9c309 100644
--- a/lib/ethdev/meson.build
+++ b/lib/ethdev/meson.build
@@ -53,7 +53,7 @@ if is_linux
     )
 endif
 
-deps += ['net', 'kvargs', 'meter', 'telemetry']
+deps = ['net', 'meter']
 
 if is_freebsd
     annotate_locks = false
diff --git a/lib/eventdev/meson.build b/lib/eventdev/meson.build
index 71dea91727..a90bad6809 100644
--- a/lib/eventdev/meson.build
+++ b/lib/eventdev/meson.build
@@ -40,5 +40,4 @@ driver_sdk_headers += files(
         'event_timer_adapter_pmd.h',
 )
 
-deps += ['ring', 'ethdev', 'hash', 'mempool', 'mbuf', 'timer', 'cryptodev', 'dmadev']
-deps += ['telemetry']
+deps = ['ethdev', 'hash', 'timer', 'cryptodev', 'dmadev']
diff --git a/lib/fib/meson.build b/lib/fib/meson.build
index 0c19cc8201..ac040d5372 100644
--- a/lib/fib/meson.build
+++ b/lib/fib/meson.build
@@ -10,9 +10,7 @@ endif
 
 sources = files('rte_fib.c', 'rte_fib6.c', 'dir24_8.c', 'trie.c')
 headers = files('rte_fib.h', 'rte_fib6.h')
-deps += ['rib']
-deps += ['rcu']
-deps += ['net']
+deps = ['rib', 'rcu']
 
 if dpdk_conf.has('RTE_ARCH_X86_64')
     if target_has_avx512
diff --git a/lib/gpudev/meson.build b/lib/gpudev/meson.build
index d21fadc052..5d883b85a1 100644
--- a/lib/gpudev/meson.build
+++ b/lib/gpudev/meson.build
@@ -13,4 +13,4 @@ sources = files(
         'gpudev.c',
 )
 
-deps += ['mbuf']
+deps = ['mbuf']
diff --git a/lib/graph/meson.build b/lib/graph/meson.build
index 0cb15442ab..f58f107d52 100644
--- a/lib/graph/meson.build
+++ b/lib/graph/meson.build
@@ -25,4 +25,4 @@ indirect_headers += files(
         'rte_graph_worker_common.h',
 )
 
-deps += ['eal', 'pcapng', 'mempool', 'ring']
+deps = ['pcapng']
diff --git a/lib/gro/meson.build b/lib/gro/meson.build
index dbce05220d..c6de6ceebc 100644
--- a/lib/gro/meson.build
+++ b/lib/gro/meson.build
@@ -10,4 +10,4 @@ sources = files(
         'gro_vxlan_udp4.c',
 )
 headers = files('rte_gro.h')
-deps += ['ethdev']
+deps = ['ethdev']
diff --git a/lib/gso/meson.build b/lib/gso/meson.build
index 622411df8f..bc99109933 100644
--- a/lib/gso/meson.build
+++ b/lib/gso/meson.build
@@ -10,4 +10,4 @@ sources = files(
         'rte_gso.c',
 )
 headers = files('rte_gso.h')
-deps += ['ethdev']
+deps = ['ethdev']
diff --git a/lib/hash/meson.build b/lib/hash/meson.build
index 7ce504ee8b..e6cb1ebe3b 100644
--- a/lib/hash/meson.build
+++ b/lib/hash/meson.build
@@ -26,6 +26,4 @@ sources = files(
         'rte_thash_gf2_poly_math.c',
 )
 
-deps += ['net']
-deps += ['ring']
-deps += ['rcu']
+deps = ['net', 'rcu']
diff --git a/lib/ip_frag/meson.build b/lib/ip_frag/meson.build
index ea2de09f75..cacf391460 100644
--- a/lib/ip_frag/meson.build
+++ b/lib/ip_frag/meson.build
@@ -10,4 +10,4 @@ sources = files(
         'ip_frag_internal.c',
 )
 headers = files('rte_ip_frag.h')
-deps += ['ethdev', 'hash']
+deps = ['ethdev', 'hash']
diff --git a/lib/ipsec/meson.build b/lib/ipsec/meson.build
index 02d18f5829..e6673aa9ba 100644
--- a/lib/ipsec/meson.build
+++ b/lib/ipsec/meson.build
@@ -16,6 +16,6 @@ sources = files('esp_inb.c', 'esp_outb.c',
 headers = files('rte_ipsec.h', 'rte_ipsec_sa.h', 'rte_ipsec_sad.h')
 indirect_headers += files('rte_ipsec_group.h')
 
-deps += ['mbuf', 'net', 'cryptodev', 'security', 'hash', 'telemetry']
+deps = ['security', 'hash']
 
 annotate_locks = false
diff --git a/lib/kvargs/meson.build b/lib/kvargs/meson.build
index 7eae744a8f..7282b0ff8d 100644
--- a/lib/kvargs/meson.build
+++ b/lib/kvargs/meson.build
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2017 Intel Corporation
 
-deps += 'log'
+deps = ['log']
 sources = files('rte_kvargs.c')
 headers = files('rte_kvargs.h')
diff --git a/lib/latencystats/meson.build b/lib/latencystats/meson.build
index 286558dd79..f8b9a8aeec 100644
--- a/lib/latencystats/meson.build
+++ b/lib/latencystats/meson.build
@@ -3,4 +3,4 @@
 
 sources = files('rte_latencystats.c')
 headers = files('rte_latencystats.h')
-deps += ['metrics', 'ethdev']
+deps = ['metrics']
diff --git a/lib/lpm/meson.build b/lib/lpm/meson.build
index fae4f79fb9..5031b085c4 100644
--- a/lib/lpm/meson.build
+++ b/lib/lpm/meson.build
@@ -18,6 +18,4 @@ indirect_headers += files(
         'rte_lpm_sse.h',
         'rte_lpm_sve.h',
 )
-deps += ['hash']
-deps += ['rcu']
-deps += ['net']
+deps = ['hash']
diff --git a/lib/mbuf/meson.build b/lib/mbuf/meson.build
index 2cee9057a5..22f5a3038b 100644
--- a/lib/mbuf/meson.build
+++ b/lib/mbuf/meson.build
@@ -20,4 +20,4 @@ headers = files(
         'rte_mbuf_pool_ops.h',
         'rte_mbuf_dyn.h',
 )
-deps += ['mempool']
+deps = ['mempool']
diff --git a/lib/member/meson.build b/lib/member/meson.build
index f92cbb7f25..bd6d955fc9 100644
--- a/lib/member/meson.build
+++ b/lib/member/meson.build
@@ -18,7 +18,7 @@ sources = files(
         'rte_member_vbf.c',
 )
 
-deps += ['hash', 'ring']
+deps = ['hash']
 
 # compile AVX512 version if:
 if dpdk_conf.has('RTE_ARCH_X86_64') and binutils_ok
diff --git a/lib/mempool/meson.build b/lib/mempool/meson.build
index 8099a56466..0c0b3ea0c5 100644
--- a/lib/mempool/meson.build
+++ b/lib/mempool/meson.build
@@ -19,4 +19,4 @@ headers = files(
         'rte_mempool.h',
         'rte_mempool_trace_fp.h',
 )
-deps += ['ring', 'telemetry']
+deps = ['ring']
diff --git a/lib/metrics/meson.build b/lib/metrics/meson.build
index 6722f666d2..93a248f255 100644
--- a/lib/metrics/meson.build
+++ b/lib/metrics/meson.build
@@ -8,6 +8,6 @@ if dpdk_conf.has('RTE_HAS_JANSSON')
     ext_deps += jansson_dep
 endif
 
-deps += ['ethdev', 'telemetry']
+deps = ['ethdev']
 
 cflags += no_wvla_cflag
diff --git a/lib/mldev/meson.build b/lib/mldev/meson.build
index 2c933baad6..6069fff1f0 100644
--- a/lib/mldev/meson.build
+++ b/lib/mldev/meson.build
@@ -41,7 +41,7 @@ driver_sdk_headers += files(
         'mldev_utils.h',
 )
 
-deps += ['mempool', 'mbuf']
+deps = ['mbuf']
 
 if get_option('buildtype').contains('debug')
         cflags += [ '-DRTE_LIBRTE_ML_DEV_DEBUG' ]
diff --git a/lib/net/meson.build b/lib/net/meson.build
index c9b34afc98..ded5a5a8f4 100644
--- a/lib/net/meson.build
+++ b/lib/net/meson.build
@@ -37,7 +37,7 @@ sources = files(
         'rte_net.c',
         'rte_net_crc.c',
 )
-deps += ['mbuf']
+deps = ['mbuf']
 
 use_function_versioning = true
 
diff --git a/lib/node/meson.build b/lib/node/meson.build
index 0bed97a96c..368ce1dc63 100644
--- a/lib/node/meson.build
+++ b/lib/node/meson.build
@@ -34,4 +34,4 @@ headers = files(
 
 # Strict-aliasing rules are violated by uint8_t[] to context size casts.
 cflags += '-fno-strict-aliasing'
-deps += ['graph', 'mbuf', 'lpm', 'ethdev', 'mempool', 'cryptodev', 'ip_frag']
+deps = ['graph', 'lpm', 'cryptodev', 'ip_frag']
diff --git a/lib/pcapng/meson.build b/lib/pcapng/meson.build
index 4549925d41..e8f059a9b0 100644
--- a/lib/pcapng/meson.build
+++ b/lib/pcapng/meson.build
@@ -4,4 +4,4 @@
 sources = files('rte_pcapng.c')
 headers = files('rte_pcapng.h')
 
-deps += ['ethdev']
+deps = ['ethdev']
diff --git a/lib/pdcp/meson.build b/lib/pdcp/meson.build
index eef46dd55a..6eef683252 100644
--- a/lib/pdcp/meson.build
+++ b/lib/pdcp/meson.build
@@ -20,4 +20,4 @@ sources = files(
 headers = files('rte_pdcp.h')
 indirect_headers += files('rte_pdcp_group.h')
 
-deps += ['mbuf', 'net', 'cryptodev', 'security', 'reorder']
+deps = ['security', 'reorder']
diff --git a/lib/pdump/meson.build b/lib/pdump/meson.build
index 553dfdd5e6..9bb2f203b1 100644
--- a/lib/pdump/meson.build
+++ b/lib/pdump/meson.build
@@ -11,4 +11,4 @@ cflags += no_wvla_cflag
 
 sources = files('rte_pdump.c')
 headers = files('rte_pdump.h')
-deps += ['ethdev', 'bpf', 'pcapng']
+deps = ['bpf', 'pcapng']
diff --git a/lib/pipeline/meson.build b/lib/pipeline/meson.build
index 823c7929a7..bda5607c18 100644
--- a/lib/pipeline/meson.build
+++ b/lib/pipeline/meson.build
@@ -27,4 +27,4 @@ headers = files(
         'rte_swx_extern.h',
         'rte_swx_ctl.h',
 )
-deps += ['port', 'table', 'meter', 'sched', 'cryptodev', 'ipsec']
+deps = ['table', 'ipsec']
diff --git a/lib/port/meson.build b/lib/port/meson.build
index b597772872..0524c3c049 100644
--- a/lib/port/meson.build
+++ b/lib/port/meson.build
@@ -40,7 +40,7 @@ headers = files(
         'rte_swx_port_ring.h',
         'rte_swx_port_source_sink.h',
 )
-deps += ['ethdev', 'sched', 'ip_frag', 'cryptodev', 'eventdev']
+deps = ['sched', 'ip_frag', 'eventdev']
 
 if dpdk_conf.has('RTE_HAS_LIBPCAP')
     dpdk_conf.set('RTE_PORT_PCAP', 1)
diff --git a/lib/power/meson.build b/lib/power/meson.build
index 56b59071ea..d4f8a97a3e 100644
--- a/lib/power/meson.build
+++ b/lib/power/meson.build
@@ -29,5 +29,4 @@ headers = files(
         'rte_power_qos.h',
         'rte_power_uncore.h',
 )
-
-deps += ['timer', 'ethdev']
+deps = ['timer', 'ethdev']
diff --git a/lib/rawdev/meson.build b/lib/rawdev/meson.build
index 7dfc3d5cf9..8841f003d7 100644
--- a/lib/rawdev/meson.build
+++ b/lib/rawdev/meson.build
@@ -9,5 +9,3 @@ endif
 
 sources = files('rte_rawdev.c')
 headers = files('rte_rawdev.h', 'rte_rawdev_pmd.h')
-
-deps += ['telemetry']
diff --git a/lib/rcu/meson.build b/lib/rcu/meson.build
index fb1f49ba63..aaf876ebd8 100644
--- a/lib/rcu/meson.build
+++ b/lib/rcu/meson.build
@@ -10,7 +10,7 @@ endif
 sources = files('rte_rcu_qsbr.c')
 headers = files('rte_rcu_qsbr.h')
 
-deps += ['ring']
+deps = ['ring']
 
 # FIXME: this library was enabled for mingw target (a Windows target).
 # Relying on no_wvla_cflag would trigger a build error until the VLA in rte_rcu_qsbr.c is removed.
diff --git a/lib/regexdev/meson.build b/lib/regexdev/meson.build
index 426e764ece..3e20fa387d 100644
--- a/lib/regexdev/meson.build
+++ b/lib/regexdev/meson.build
@@ -10,4 +10,4 @@ endif
 sources = files('rte_regexdev.c')
 headers = files('rte_regexdev.h', 'rte_regexdev_driver.h')
 indirect_headers += files('rte_regexdev_core.h')
-deps += ['mbuf']
+deps = ['mbuf']
diff --git a/lib/reorder/meson.build b/lib/reorder/meson.build
index 03aed53d90..1e088a7d97 100644
--- a/lib/reorder/meson.build
+++ b/lib/reorder/meson.build
@@ -3,4 +3,4 @@
 
 sources = files('rte_reorder.c')
 headers = files('rte_reorder.h')
-deps += ['mbuf']
+deps = ['mbuf']
diff --git a/lib/rib/meson.build b/lib/rib/meson.build
index e98f708481..70a9072255 100644
--- a/lib/rib/meson.build
+++ b/lib/rib/meson.build
@@ -4,4 +4,4 @@
 
 sources = files('rte_rib.c', 'rte_rib6.c')
 headers = files('rte_rib.h', 'rte_rib6.h')
-deps += ['net', 'mempool']
+deps = ['net']
diff --git a/lib/ring/meson.build b/lib/ring/meson.build
index 21f2c12989..69dd50a078 100644
--- a/lib/ring/meson.build
+++ b/lib/ring/meson.build
@@ -18,4 +18,3 @@ indirect_headers += files (
         'rte_ring_rts.h',
         'rte_ring_rts_elem_pvt.h',
 )
-deps += ['telemetry']
diff --git a/lib/sched/meson.build b/lib/sched/meson.build
index df75db51ed..7ca8ec09df 100644
--- a/lib/sched/meson.build
+++ b/lib/sched/meson.build
@@ -15,4 +15,4 @@ headers = files(
         'rte_sched_common.h',
         'rte_pie.h',
 )
-deps += ['mbuf', 'meter']
+deps = ['mbuf', 'meter']
diff --git a/lib/security/meson.build b/lib/security/meson.build
index 1034a7a299..e4545a8c72 100644
--- a/lib/security/meson.build
+++ b/lib/security/meson.build
@@ -3,4 +3,4 @@
 
 sources = files('rte_security.c')
 headers = files('rte_security.h', 'rte_security_driver.h')
-deps += ['mempool', 'cryptodev', 'net']
+deps = ['cryptodev', 'net']
diff --git a/lib/table/meson.build b/lib/table/meson.build
index e27957fe89..38cacbb388 100644
--- a/lib/table/meson.build
+++ b/lib/table/meson.build
@@ -41,7 +41,7 @@ headers = files(
         'rte_table_lpm_ipv6.h',
         'rte_table_stub.h',
 )
-deps += ['mbuf', 'port', 'lpm', 'hash', 'acl']
+deps = ['port', 'lpm', 'acl']
 
 indirect_headers += files(
         'rte_lru_arm64.h',
diff --git a/lib/telemetry/meson.build b/lib/telemetry/meson.build
index 489d000047..3e3a2cfc32 100644
--- a/lib/telemetry/meson.build
+++ b/lib/telemetry/meson.build
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2018 Intel Corporation
 
-deps += 'log'
+deps = ['log']
 sources = files('telemetry.c', 'telemetry_data.c', 'telemetry_legacy.c')
 headers = files('rte_telemetry.h')
 includes += include_directories('../metrics')
diff --git a/lib/vhost/meson.build b/lib/vhost/meson.build
index 33773b6d21..ca288cfba5 100644
--- a/lib/vhost/meson.build
+++ b/lib/vhost/meson.build
@@ -52,4 +52,4 @@ headers = files(
 driver_sdk_headers = files(
         'vdpa_driver.h',
 )
-deps += ['ethdev', 'cryptodev', 'hash', 'pci', 'dmadev']
+deps = ['ethdev', 'cryptodev', 'hash', 'pci', 'dmadev']
-- 
2.43.5

