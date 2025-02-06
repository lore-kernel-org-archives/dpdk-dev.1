Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E22C02192
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 01:35:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8717340E1D;
	Thu,  6 Feb 2025 02:34:09 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 18ADB4066F
 for <dev@dpdk.org>; Thu,  6 Feb 2025 02:33:39 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 8826F203F5BA; Wed,  5 Feb 2025 17:33:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8826F203F5BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738805617;
 bh=uChABuleYtCEmITg/Decau+IfCFFQhcm3c+EQS1t5FM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=p3JtqA0PGT+2u4GAPnd3IAXGD1AaKhWLvBEhM9M0N6vgLxUMbS8j4v+FY/EQAST6t
 k+kl2CGl0YlwpG8g+dMsQa+oMd8jJUIsu7aZH8txE5L5SAt+w0sHCdlBD+Pe88ih8c
 M9BItH5metPyyssIdmApnnCF2fiwhh7/eJNU7DXI=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: dev@dpdk.org
Cc: konstantin.ananyev@huawei.com, thomas@monjalon.net,
 david.marchand@redhat.com, Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH v22 22/27] app: add no_wvla_cflag to directories that are not
 VLA-free
Date: Wed,  5 Feb 2025 17:33:25 -0800
Message-Id: <1738805610-17507-23-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738805610-17507-1-git-send-email-andremue@linux.microsoft.com>
References: <1713397319-26135-1-git-send-email-roretzla@linux.microsoft.com>
 <1738805610-17507-1-git-send-email-andremue@linux.microsoft.com>
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
index fb282bba1f..a4c7dd44e7 100644
--- a/app/pdump/meson.build
+++ b/app/pdump/meson.build
@@ -9,3 +9,5 @@ endif
 
 sources = files('main.c')
 deps += ['ethdev', 'kvargs', 'pdump']
+
+cflags += no_wvla_cflag
diff --git a/app/proc-info/meson.build b/app/proc-info/meson.build
index 4f83f29a64..316253cd5d 100644
--- a/app/proc-info/meson.build
+++ b/app/proc-info/meson.build
@@ -12,3 +12,5 @@ deps += ['ethdev', 'security', 'eventdev']
 if dpdk_conf.has('RTE_LIB_METRICS')
     deps += 'metrics'
 endif
+
+cflags += no_wvla_cflag
diff --git a/app/test-acl/meson.build b/app/test-acl/meson.build
index c0dc4b221a..7d8b707794 100644
--- a/app/test-acl/meson.build
+++ b/app/test-acl/meson.build
@@ -9,3 +9,5 @@ endif
 
 sources = files('main.c')
 deps += ['acl', 'net']
+
+cflags += no_wvla_cflag
diff --git a/app/test-bbdev/meson.build b/app/test-bbdev/meson.build
index 926e0a5271..85b060edec 100644
--- a/app/test-bbdev/meson.build
+++ b/app/test-bbdev/meson.build
@@ -26,3 +26,5 @@ endif
 if dpdk_conf.has('RTE_BASEBAND_LA12XX')
     deps += ['baseband_la12xx']
 endif
+
+cflags += no_wvla_cflag
diff --git a/app/test-crypto-perf/meson.build b/app/test-crypto-perf/meson.build
index 7b02b518f0..87dd3bc5f1 100644
--- a/app/test-crypto-perf/meson.build
+++ b/app/test-crypto-perf/meson.build
@@ -23,3 +23,5 @@ deps += ['cryptodev', 'net', 'security']
 if dpdk_conf.has('RTE_CRYPTO_SCHEDULER')
     deps += 'crypto_scheduler'
 endif
+
+cflags += no_wvla_cflag
diff --git a/app/test-dma-perf/meson.build b/app/test-dma-perf/meson.build
index b1557b8125..40d6b7f8e4 100644
--- a/app/test-dma-perf/meson.build
+++ b/app/test-dma-perf/meson.build
@@ -13,3 +13,5 @@ sources = files(
         'main.c',
         'benchmark.c',
 )
+
+cflags += no_wvla_cflag
diff --git a/app/test-eventdev/meson.build b/app/test-eventdev/meson.build
index ab8769c755..f0da9fadf2 100644
--- a/app/test-eventdev/meson.build
+++ b/app/test-eventdev/meson.build
@@ -23,3 +23,5 @@ sources = files(
         'test_pipeline_queue.c',
 )
 deps += 'eventdev'
+
+cflags += no_wvla_cflag
diff --git a/app/test-flow-perf/meson.build b/app/test-flow-perf/meson.build
index 766e4516ad..5758f8d9c6 100644
--- a/app/test-flow-perf/meson.build
+++ b/app/test-flow-perf/meson.build
@@ -15,3 +15,5 @@ sources = files(
 )
 
 deps += ['ethdev']
+
+cflags += no_wvla_cflag
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
index a50616a9c7..a1cbcc71d6 100644
--- a/app/test-sad/meson.build
+++ b/app/test-sad/meson.build
@@ -9,3 +9,5 @@ endif
 
 sources = files('main.c')
 deps += ['ipsec', 'net']
+
+cflags += no_wvla_cflag
diff --git a/app/test/meson.build b/app/test/meson.build
index 48cf77fda9..b6285a6b45 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -250,12 +250,19 @@ foreach d:optional_deps
     endif
 endforeach
 
-if cc.has_argument('-Wno-format-truncation')
-    cflags += '-Wno-format-truncation'
-endif
+cflags += no_wvla_cflag
+
+extra_flags = [
+        # Strict-aliasing rules are violated by uint8_t[] to context size casts.
+        '-fno-strict-aliasing',
+        '-Wno-format-truncation',
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

