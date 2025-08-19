Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15619CA0EEB
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 Aug 2025 11:25:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1C26402D9;
	Tue, 19 Aug 2025 13:25:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 45F2D40144
 for <dev@dpdk.org>; Tue, 19 Aug 2025 13:25:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755602747; x=1787138747;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LcDvt58+W+spNpe+qUUyCTzQ6NbPnczieIkB9lCvFJI=;
 b=Pd1qz4NwZbuQYWN+Qn8LGgP4fnXz5iFC74zlMZoBFe8QKtoc43n0gFJL
 Vd7ur4mdizKlm6Mxl1q5JRcvWh91T9xPmW//rOP+kG4wQpzGQILYcBhte
 CDSaJ+AQiw9Xgw9+uKjYuaOoLxq+NohIze3iRto3SoG9nDkAl9XO+Xw/g
 tOTCPvDR5BK8DsoncOjB4p9pi+aoTEiDlUMziydL7FcexSm8QqWUFXwU/
 34bQN3DpMcm0UTsVn5Mi66/jkKeWBC7/qEiLWBqX5+1K+y6kJojJlwlEm
 vnfgL37FEyj2DDlrcE4VBnH/4q44U0+M2QgHFFD93t6ZFD/ryTcioktjY A==;
X-CSE-ConnectionGUID: nKRxs+6mQJiwTdD8N4iorw==
X-CSE-MsgGUID: i5RlAYdcRvKr0tMCOJ0zGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="68938713"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; d="scan'208";a="68938713"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2025 04:25:46 -0700
X-CSE-ConnectionGUID: fV2nunTNTf+erJmO22qnLg==
X-CSE-MsgGUID: PmQs42LcQxaG76AUCq1IQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; d="scan'208";a="167330494"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by fmviesa007.fm.intel.com with ESMTP; 19 Aug 2025 04:25:45 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 2/2] virtio: simplify use of pragmas
Date: Tue, 19 Aug 2025 12:25:21 +0100
Message-ID: <20250819112521.1608207-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250819112521.1608207-1-bruce.richardson@intel.com>
References: <20250718121402.856265-1-bruce.richardson@intel.com>
 <20250819112521.1608207-1-bruce.richardson@intel.com>
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

In virtio/vhost there is use of pragmas to get clang or gcc to unroll
loops. This was originally done using compiler version checks in the
meson.build file, but with all supported gcc and clang versions now
supporting the needed pragmas, we can simplify things by just having the
headers check directly for gcc or clang.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/virtio/meson.build          |  5 -----
 drivers/net/virtio/virtio_rxtx_packed.h | 16 ++++++----------
 lib/vhost/meson.build                   |  5 -----
 lib/vhost/vhost.h                       | 14 +++++---------
 4 files changed, 11 insertions(+), 29 deletions(-)

diff --git a/drivers/net/virtio/meson.build b/drivers/net/virtio/meson.build
index be653edb34..54a28538c3 100644
--- a/drivers/net/virtio/meson.build
+++ b/drivers/net/virtio/meson.build
@@ -29,11 +29,6 @@ if arch_subdir == 'x86'
     if cc_has_avx512
         cflags += ['-DVIRTIO_RXTX_PACKED_VEC']
         sources_avx512 += files('virtio_rxtx_packed.c')
-        if toolchain == 'gcc'
-            cflags += '-DVIRTIO_GCC_UNROLL_PRAGMA'
-        elif toolchain == 'clang'
-            cflags += '-DVIRTIO_CLANG_UNROLL_PRAGMA'
-        endif
     endif
     cflags += ['-DVIRTIO_RXTX_VEC']
     sources += files('virtio_rxtx_simple_sse.c')
diff --git a/drivers/net/virtio/virtio_rxtx_packed.h b/drivers/net/virtio/virtio_rxtx_packed.h
index 12bfcee809..f7cc60bb51 100644
--- a/drivers/net/virtio/virtio_rxtx_packed.h
+++ b/drivers/net/virtio/virtio_rxtx_packed.h
@@ -67,19 +67,15 @@
 #endif
 #define PACKED_BATCH_MASK (PACKED_BATCH_SIZE - 1)
 
-#ifdef VIRTIO_GCC_UNROLL_PRAGMA
-#define virtio_for_each_try_unroll(iter, val, size) _Pragma("GCC unroll 4") \
-	for (iter = val; iter < size; iter++)
-#endif
-
-#ifdef VIRTIO_CLANG_UNROLL_PRAGMA
+#if defined __clang__
 #define virtio_for_each_try_unroll(iter, val, size) _Pragma("unroll 4") \
 	for (iter = val; iter < size; iter++)
-#endif
-
-#ifndef virtio_for_each_try_unroll
-#define virtio_for_each_try_unroll(iter, val, size) \
+#elif defined __GNUC__
+#define virtio_for_each_try_unroll(iter, val, size) _Pragma("GCC unroll 4") \
 	for (iter = val; iter < size; iter++)
+#else
+#define virtio_for_each_try_unroll(iter, val, num) \
+	for (iter = val; iter < num; iter++)
 #endif
 
 static inline void
diff --git a/lib/vhost/meson.build b/lib/vhost/meson.build
index 0a7a76f6db..6a24981d10 100644
--- a/lib/vhost/meson.build
+++ b/lib/vhost/meson.build
@@ -8,11 +8,6 @@ endif
 if has_libnuma
     dpdk_conf.set10('RTE_LIBRTE_VHOST_NUMA', true)
 endif
-if toolchain == 'gcc'
-    cflags += '-DVHOST_GCC_UNROLL_PRAGMA'
-elif toolchain == 'clang'
-    cflags += '-DVHOST_CLANG_UNROLL_PRAGMA'
-endif
 dpdk_conf.set('RTE_LIBRTE_VHOST_POSTCOPY', cc.has_header('linux/userfaultfd.h'))
 
 cflags += no_wvla_cflag
diff --git a/lib/vhost/vhost.h b/lib/vhost/vhost.h
index 6ffc3f20c1..e9e71c1707 100644
--- a/lib/vhost/vhost.h
+++ b/lib/vhost/vhost.h
@@ -69,17 +69,13 @@
 			    sizeof(struct vring_packed_desc))
 #define PACKED_BATCH_MASK (PACKED_BATCH_SIZE - 1)
 
-#ifdef VHOST_GCC_UNROLL_PRAGMA
-#define vhost_for_each_try_unroll(iter, val, size) _Pragma("GCC unroll 4") \
-	for (iter = val; iter < size; iter++)
-#endif
-
-#ifdef VHOST_CLANG_UNROLL_PRAGMA
+#if defined __clang__
 #define vhost_for_each_try_unroll(iter, val, size) _Pragma("unroll 4") \
 	for (iter = val; iter < size; iter++)
-#endif
-
-#ifndef vhost_for_each_try_unroll
+#elif defined __GNUC__
+#define vhost_for_each_try_unroll(iter, val, size) _Pragma("GCC unroll 4") \
+	for (iter = val; iter < size; iter++)
+#else
 #define vhost_for_each_try_unroll(iter, val, num) \
 	for (iter = val; iter < num; iter++)
 #endif
-- 
2.48.1

