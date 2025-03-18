Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4176C28B2F
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Mar 2025 17:35:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37C5F40655;
	Tue, 18 Mar 2025 18:35:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 4FF65402F0
 for <dev@dpdk.org>; Tue, 18 Mar 2025 18:35:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742319341; x=1773855341;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mLA5vAml6IdRoPzI/CyijusJNd/Xt7PEJFTZY1W+J0Q=;
 b=UX8KMR+eQZGfPuEwvjhDR2lUpvmYbK7SFpxAbMl35fKFGI6MD47oaN9L
 HOHQKcy9tFYVXhJnK76wP+FPUScRcUy/ZWlxfO+ic327utcj8qbq1+Hn6
 FKVaZT5gfM5B9zNR+sb76UTyVaXSRl2si2w4TCan8n4u2epVwX2D2Khti
 QZLTzM8zN1isJIuz/jElaXrVO2juxJ+q6fv9bQnmKBSEUL5uOqDeIemTL
 rSpeHajMyJab5vDBLKTLKatm26iipfSLS+GSySV4JBAqOEljpGzn9JVvG
 vjKYWNf1zf1hDcTGi1L4Z1vKg8oMn111WIjZSpP1gcN7sFhgcFdP4IfhR Q==;
X-CSE-ConnectionGUID: YRt/pRp9Tg2ThjFJTaU5yA==
X-CSE-MsgGUID: Z8v8N6V8RYuimDusNPf5ow==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="42725218"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; d="scan'208";a="42725218"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 10:35:41 -0700
X-CSE-ConnectionGUID: qmj/F/7pQmiZRC4XlwqfwQ==
X-CSE-MsgGUID: syJqzYG7QzinJFc9Md+1SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; d="scan'208";a="122313173"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.28])
 by orviesa006.jf.intel.com with ESMTP; 18 Mar 2025 10:35:39 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Pravin Pathak <pravin.pathak@intel.com>
Subject: [PATCH v3 05/11] event/dlb2: build using common AVX handling
Date: Tue, 18 Mar 2025 17:34:58 +0000
Message-ID: <20250318173505.314529-6-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318173505.314529-1-bruce.richardson@intel.com>
References: <20250314172339.12777-1-bruce.richardson@intel.com>
 <20250318173505.314529-1-bruce.richardson@intel.com>
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

remove special-case handling for AVX512, and rely on mechanisms in
the drivers meson.build file.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/event/dlb2/dlb2_sse.c  |  4 ++++
 drivers/event/dlb2/meson.build | 16 ++--------------
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/event/dlb2/dlb2_sse.c b/drivers/event/dlb2/dlb2_sse.c
index f2e1f9fb7e..06474d61dd 100644
--- a/drivers/event/dlb2/dlb2_sse.c
+++ b/drivers/event/dlb2/dlb2_sse.c
@@ -5,6 +5,8 @@
 #include <stdint.h>
 #include <stdbool.h>
 
+#ifndef CC_AVX512_SUPPORT
+
 #include "dlb2_priv.h"
 #include "dlb2_iface.h"
 #include "dlb2_inline_fns.h"
@@ -226,3 +228,5 @@ dlb2_event_build_hcws(struct dlb2_port *qm_port,
 		break;
 	}
 }
+
+#endif /* no CC_AVX512_SUPPORT */
diff --git a/drivers/event/dlb2/meson.build b/drivers/event/dlb2/meson.build
index c024edb311..13d0fa544e 100644
--- a/drivers/event/dlb2/meson.build
+++ b/drivers/event/dlb2/meson.build
@@ -20,22 +20,10 @@ sources = files(
         'pf/base/dlb2_resource.c',
         'rte_pmd_dlb2.c',
         'dlb2_selftest.c',
+        'dlb2_sse.c',
 )
 
-if target_has_avx512
-    cflags += '-DCC_AVX512_SUPPORT'
-    sources += files('dlb2_avx512.c')
-
-elif cc_has_avx512
-    cflags += '-DCC_AVX512_SUPPORT'
-    avx512_tmplib = static_library('avx512_tmp',
-                               'dlb2_avx512.c',
-                               dependencies: [static_rte_eal, static_rte_eventdev],
-                               c_args: cflags + cc_avx512_flags)
-    objs += avx512_tmplib.extract_objects('dlb2_avx512.c')
-else
-    sources += files('dlb2_sse.c')
-endif
+sources_avx512 += files('dlb2_avx512.c')
 
 headers = files('rte_pmd_dlb2.h')
 
-- 
2.43.0

