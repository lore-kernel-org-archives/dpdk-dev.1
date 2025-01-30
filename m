Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7E9C0218A
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Jan 2025 21:57:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7744342790;
	Thu, 30 Jan 2025 22:56:15 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id EC24B40E4C
 for <dev@dpdk.org>; Thu, 30 Jan 2025 22:55:45 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id ACE5C210C321; Thu, 30 Jan 2025 13:55:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ACE5C210C321
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738274144;
 bh=gJ4dtl4vDiB6IaUpSmjbjNyD8Js5eTVsGfWdlDY+c2I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=a7sMGJwrhpd5kNegCEd+QN4RW0XnTlmLyYQ6f6HsKpZVms/NUTaa1nqngS1WGUV+T
 MjrxriLsifqE1EINhU1NPKJF56suvpKKCByvREklf7fwtkK775j4eKSAPphrDpOc7R
 PNRvXFyoMXLshzzJDVy/O4fLmKKVmOVvWj/4zvrE=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: dev@dpdk.org
Cc: konstantin.ananyev@huawei.com, thomas@monjalon.net,
 david.marchand@redhat.com, Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH v18 22/26] app: add no_vla_cflag to directories that are not
 VLA-free
Date: Thu, 30 Jan 2025 13:55:31 -0800
Message-Id: <1738274135-2086-23-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738274135-2086-1-git-send-email-andremue@linux.microsoft.com>
References: <1713397319-26135-1-git-send-email-roretzla@linux.microsoft.com>
 <1738274135-2086-1-git-send-email-andremue@linux.microsoft.com>
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

The no_vla_cflag is added to meson.build files in directories that
are not yet VLA-free.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 app/pdump/meson.build            |  2 ++
 app/proc-info/meson.build        |  2 ++
 app/test-acl/meson.build         |  2 ++
 app/test-bbdev/meson.build       |  2 ++
 app/test-crypto-perf/meson.build |  2 ++
 app/test-dma-perf/meson.build    |  2 ++
 app/test-eventdev/meson.build    |  2 ++
 app/test-flow-perf/meson.build   |  2 ++
 app/test-pmd/meson.build         | 10 +++++++++-
 app/test-sad/meson.build         |  2 ++
 app/test/meson.build             | 17 ++++++++++++-----
 11 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/app/pdump/meson.build b/app/pdump/meson.build
index fb282bba1f..ae12636b2c 100644
--- a/app/pdump/meson.build
+++ b/app/pdump/meson.build
@@ -9,3 +9,5 @@ endif
 
 sources = files('main.c')
 deps += ['ethdev', 'kvargs', 'pdump']
+
+cflags += no_vla_cflag
diff --git a/app/proc-info/meson.build b/app/proc-info/meson.build
index 4f83f29a64..d2f2bd98d1 100644
--- a/app/proc-info/meson.build
+++ b/app/proc-info/meson.build
@@ -12,3 +12,5 @@ deps += ['ethdev', 'security', 'eventdev']
 if dpdk_conf.has('RTE_LIB_METRICS')
     deps += 'metrics'
 endif
+
+cflags += no_vla_cflag
diff --git a/app/test-acl/meson.build b/app/test-acl/meson.build
index c0dc4b221a..714bd4b5c7 100644
--- a/app/test-acl/meson.build
+++ b/app/test-acl/meson.build
@@ -9,3 +9,5 @@ endif
 
 sources = files('main.c')
 deps += ['acl', 'net']
+
+cflags += no_vla_cflag
diff --git a/app/test-bbdev/meson.build b/app/test-bbdev/meson.build
index 926e0a5271..64181ec630 100644
--- a/app/test-bbdev/meson.build
+++ b/app/test-bbdev/meson.build
@@ -26,3 +26,5 @@ endif
 if dpdk_conf.has('RTE_BASEBAND_LA12XX')
     deps += ['baseband_la12xx']
 endif
+
+cflags += no_vla_cflag
diff --git a/app/test-crypto-perf/meson.build b/app/test-crypto-perf/meson.build
index 7b02b518f0..e75d60eedd 100644
--- a/app/test-crypto-perf/meson.build
+++ b/app/test-crypto-perf/meson.build
@@ -23,3 +23,5 @@ deps += ['cryptodev', 'net', 'security']
 if dpdk_conf.has('RTE_CRYPTO_SCHEDULER')
     deps += 'crypto_scheduler'
 endif
+
+cflags += no_vla_cflag
diff --git a/app/test-dma-perf/meson.build b/app/test-dma-perf/meson.build
index b1557b8125..5f710c03b7 100644
--- a/app/test-dma-perf/meson.build
+++ b/app/test-dma-perf/meson.build
@@ -13,3 +13,5 @@ sources = files(
         'main.c',
         'benchmark.c',
 )
+
+cflags += no_vla_cflag
diff --git a/app/test-eventdev/meson.build b/app/test-eventdev/meson.build
index ab8769c755..12276b2cf3 100644
--- a/app/test-eventdev/meson.build
+++ b/app/test-eventdev/meson.build
@@ -23,3 +23,5 @@ sources = files(
         'test_pipeline_queue.c',
 )
 deps += 'eventdev'
+
+cflags += no_vla_cflag
diff --git a/app/test-flow-perf/meson.build b/app/test-flow-perf/meson.build
index 766e4516ad..d983c71302 100644
--- a/app/test-flow-perf/meson.build
+++ b/app/test-flow-perf/meson.build
@@ -15,3 +15,5 @@ sources = files(
 )
 
 deps += ['ethdev']
+
+cflags += no_vla_cflag
diff --git a/app/test-pmd/meson.build b/app/test-pmd/meson.build
index f1c36529b4..8de1528428 100644
--- a/app/test-pmd/meson.build
+++ b/app/test-pmd/meson.build
@@ -3,7 +3,15 @@
 
 # override default name to drop the hyphen
 name = 'testpmd'
-cflags += '-Wno-deprecated-declarations'
+
+extra_flags = ['-Wno-deprecated-declarations']
+
+foreach arg: extra_flags
+    if cc.has_argument(arg)
+        cflags += arg
+    endif
+endforeach
+
 sources = files(
         '5tswap.c',
         'cmdline.c',
diff --git a/app/test-sad/meson.build b/app/test-sad/meson.build
index a50616a9c7..f166e00511 100644
--- a/app/test-sad/meson.build
+++ b/app/test-sad/meson.build
@@ -9,3 +9,5 @@ endif
 
 sources = files('main.c')
 deps += ['ipsec', 'net']
+
+cflags += no_vla_cflag
diff --git a/app/test/meson.build b/app/test/meson.build
index 48cf77fda9..622c480519 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -250,12 +250,19 @@ foreach d:optional_deps
     endif
 endforeach
 
-if cc.has_argument('-Wno-format-truncation')
-    cflags += '-Wno-format-truncation'
-endif
+cflags += no_vla_cflag
+
+extra_flags = [
+    # Strict-aliasing rules are violated by uint8_t[] to context size casts.
+    '-fno-strict-aliasing',
+    '-Wno-format-truncation',
+]
 
-# Strict-aliasing rules are violated by uint8_t[] to context size casts.
-cflags += '-fno-strict-aliasing'
+foreach arg: extra_flags
+    if cc.has_argument(arg)
+        cflags += arg
+    endif
+endforeach
 
 # Enable using internal APIs in unit tests
 cflags += '-DALLOW_INTERNAL_API'
-- 
2.47.2.vfs.0.1

