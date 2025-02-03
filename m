Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0070FC0218A
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Feb 2025 04:09:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8E0C40E39;
	Mon,  3 Feb 2025 05:07:34 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 969BA40695
 for <dev@dpdk.org>; Mon,  3 Feb 2025 05:06:49 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 3317C2054928; Sun,  2 Feb 2025 20:06:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3317C2054928
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738555608;
 bh=VeripE8iiHIfrf0YezpTGWSwCeuuHL7L9kQ4YTezn7o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aJPPni/aXCPVF7wgdOKA7rYawp+tk+uhRmT7FI5AldY0dihVCh7G0Xn/sAihMKOdF
 PILR4AOQIEaL+hIhTKIjda59os3I8NVOb/wp6BLRmFekTtShVj+jBESMJV6wzRBopP
 59ZJ1U6ElsHXrEajWv4PEs/EgsKo+IERSXbe7iAo=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: dev@dpdk.org
Cc: konstantin.ananyev@huawei.com, thomas@monjalon.net,
 david.marchand@redhat.com, Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH v19 24/27] lib: add no_wvla_cflag to directories that are not
 VLA-free
Date: Sun,  2 Feb 2025 20:06:27 -0800
Message-Id: <1738555590-12753-25-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738555590-12753-1-git-send-email-andremue@linux.microsoft.com>
References: <1713397319-26135-1-git-send-email-roretzla@linux.microsoft.com>
 <1738555590-12753-1-git-send-email-andremue@linux.microsoft.com>
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

The no_wvla_cflag is added to meson.build files in directories that
are not yet VLA-free.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 lib/acl/meson.build        |  2 ++
 lib/bpf/meson.build        |  2 ++
 lib/dispatcher/meson.build |  2 ++
 lib/eventdev/meson.build   |  2 ++
 lib/ipsec/meson.build      |  2 ++
 lib/member/meson.build     |  2 ++
 lib/metrics/meson.build    |  2 ++
 lib/pdcp/meson.build       |  2 ++
 lib/pdump/meson.build      |  2 ++
 lib/pipeline/meson.build   |  2 ++
 lib/power/meson.build      |  3 +++
 lib/table/meson.build      |  2 ++
 lib/vhost/meson.build      | 15 ++++++++++++---
 13 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/lib/acl/meson.build b/lib/acl/meson.build
index 9cba08321a..fefe131a48 100644
--- a/lib/acl/meson.build
+++ b/lib/acl/meson.build
@@ -7,6 +7,8 @@ if is_windows
     subdir_done()
 endif
 
+cflags += no_wvla_cflag
+
 sources = files('acl_bld.c', 'acl_gen.c', 'acl_run_scalar.c',
         'rte_acl.c', 'tb_mem.c')
 headers = files('rte_acl.h', 'rte_acl_osdep.h')
diff --git a/lib/bpf/meson.build b/lib/bpf/meson.build
index aa258a9061..28df7f469a 100644
--- a/lib/bpf/meson.build
+++ b/lib/bpf/meson.build
@@ -7,6 +7,8 @@ if is_windows
     subdir_done()
 endif
 
+cflags += no_wvla_cflag
+
 if arch_subdir == 'x86' and dpdk_conf.get('RTE_ARCH_32')
     build = false
     reason = 'not supported on 32-bit x86'
diff --git a/lib/dispatcher/meson.build b/lib/dispatcher/meson.build
index ffaef26a6d..5e269b2d40 100644
--- a/lib/dispatcher/meson.build
+++ b/lib/dispatcher/meson.build
@@ -7,6 +7,8 @@ if is_windows
     subdir_done()
 endif
 
+cflags += no_wvla_cflag
+
 sources = files('rte_dispatcher.c')
 headers = files('rte_dispatcher.h')
 
diff --git a/lib/eventdev/meson.build b/lib/eventdev/meson.build
index a04bb86f0f..71dea91727 100644
--- a/lib/eventdev/meson.build
+++ b/lib/eventdev/meson.build
@@ -7,6 +7,8 @@ if is_windows
     subdir_done()
 endif
 
+cflags += no_wvla_cflag
+
 sources = files(
         'eventdev_private.c',
         'eventdev_trace_points.c',
diff --git a/lib/ipsec/meson.build b/lib/ipsec/meson.build
index 5c5a4aae78..02d18f5829 100644
--- a/lib/ipsec/meson.build
+++ b/lib/ipsec/meson.build
@@ -7,6 +7,8 @@ if is_windows
     subdir_done()
 endif
 
+cflags += no_wvla_cflag
+
 sources = files('esp_inb.c', 'esp_outb.c',
                 'sa.c', 'ses.c', 'ipsec_sad.c',
                 'ipsec_telemetry.c')
diff --git a/lib/member/meson.build b/lib/member/meson.build
index 02ef59795e..f92cbb7f25 100644
--- a/lib/member/meson.build
+++ b/lib/member/meson.build
@@ -7,6 +7,8 @@ if is_windows
     subdir_done()
 endif
 
+cflags += no_wvla_cflag
+
 headers = files('rte_member.h')
 
 sources = files(
diff --git a/lib/metrics/meson.build b/lib/metrics/meson.build
index 8c1c4b4b49..6722f666d2 100644
--- a/lib/metrics/meson.build
+++ b/lib/metrics/meson.build
@@ -9,3 +9,5 @@ if dpdk_conf.has('RTE_HAS_JANSSON')
 endif
 
 deps += ['ethdev', 'telemetry']
+
+cflags += no_wvla_cflag
diff --git a/lib/pdcp/meson.build b/lib/pdcp/meson.build
index f4f9246bcb..eef46dd55a 100644
--- a/lib/pdcp/meson.build
+++ b/lib/pdcp/meson.build
@@ -7,6 +7,8 @@ if is_windows
     subdir_done()
 endif
 
+cflags += no_wvla_cflag
+
 sources = files(
         'pdcp_cnt.c',
         'pdcp_crypto.c',
diff --git a/lib/pdump/meson.build b/lib/pdump/meson.build
index da8d51b616..553dfdd5e6 100644
--- a/lib/pdump/meson.build
+++ b/lib/pdump/meson.build
@@ -7,6 +7,8 @@ if is_windows
     subdir_done()
 endif
 
+cflags += no_wvla_cflag
+
 sources = files('rte_pdump.c')
 headers = files('rte_pdump.h')
 deps += ['ethdev', 'bpf', 'pcapng']
diff --git a/lib/pipeline/meson.build b/lib/pipeline/meson.build
index fd5e0dc6bb..823c7929a7 100644
--- a/lib/pipeline/meson.build
+++ b/lib/pipeline/meson.build
@@ -7,6 +7,8 @@ if is_windows
     subdir_done()
 endif
 
+cflags += no_wvla_cflag
+
 sources = files(
         'rte_pipeline.c',
         'rte_port_in_action.c',
diff --git a/lib/power/meson.build b/lib/power/meson.build
index b3a7bc7b2e..56b59071ea 100644
--- a/lib/power/meson.build
+++ b/lib/power/meson.build
@@ -11,6 +11,9 @@ if not is_linux
     build = false
     reason = 'only supported on Linux'
 endif
+
+cflags += no_wvla_cflag
+
 sources = files(
         'power_common.c',
         'rte_power_cpufreq.c',
diff --git a/lib/table/meson.build b/lib/table/meson.build
index 9b3d9ac759..e27957fe89 100644
--- a/lib/table/meson.build
+++ b/lib/table/meson.build
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2017 Intel Corporation
 
+cflags += no_wvla_cflag
+
 sources = files(
         'rte_swx_keycmp.c',
         'rte_swx_table_em.c',
diff --git a/lib/vhost/meson.build b/lib/vhost/meson.build
index 51bcf17244..c2908e7a41 100644
--- a/lib/vhost/meson.build
+++ b/lib/vhost/meson.build
@@ -16,11 +16,20 @@ elif (toolchain == 'icc' and cc.version().version_compare('>=16.0.0'))
     cflags += '-DVHOST_ICC_UNROLL_PRAGMA'
 endif
 dpdk_conf.set('RTE_LIBRTE_VHOST_POSTCOPY', cc.has_header('linux/userfaultfd.h'))
-cflags += [
-        '-fno-strict-aliasing',
-        '-Wno-address-of-packed-member',
+
+cflags += no_wvla_cflag
+
+extra_flags = [
+    '-fno-strict-aliasing',
+    '-Wno-address-of-packed-member',
 ]
 
+foreach arg: extra_flags
+    if cc.has_argument(arg)
+        cflags += arg
+    endif
+endforeach
+
 sources = files(
         'fd_man.c',
         'iotlb.c',
-- 
2.47.2.vfs.0.1

