Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3E1C3600C
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Mar 2025 16:03:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6022340655;
	Tue, 25 Mar 2025 17:03:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 0512C402EA
 for <dev@dpdk.org>; Tue, 25 Mar 2025 17:03:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742918603; x=1774454603;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gnNFbusRIOEb8W3355JItJaLYwF8tEa/loyj4WK3fQ0=;
 b=GSg8RorFS2gjejQcJIanm6170n115eZy5sUwgw81dgzEw2F2cRQlRBD1
 Ns6ti1CeuWIjRMPXR4Q5/GY68y9s2QyDMR6EaYyMAEqTvZC4hYRML7xFc
 TQ2sIAszPUJmmv/Td5vA5vMXVf7Al3mAdx4+/KvxoPiXtlMvPDoGSPhFs
 +iNf4NVrd3f3YHREDCdP7FsRx4g6eZWSNS3Cnar+G0Bq89U24m1y06OJw
 gyT5+TB0oDyRnWeyKqiVdZzbn8pszDVHRGqrnMd3DN8YHIJCbObLMdOVK
 4/bdtVLEMdQTltWZD/vBzq8GZGlBamAbdWzWgxNPgvxvnolTKMr0cVL9H A==;
X-CSE-ConnectionGUID: lcBSIeUvSiOJwVTcJHYHmA==
X-CSE-MsgGUID: u8zLtzS4SZa5VoFGozBVQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="61565764"
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; d="scan'208";a="61565764"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2025 09:03:22 -0700
X-CSE-ConnectionGUID: F9Uzq2XTRM+AF6AMUw4V/w==
X-CSE-MsgGUID: SM9R7HRxRdKpdlRM80ayBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; d="scan'208";a="129086682"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by fmviesa005.fm.intel.com with ESMTP; 25 Mar 2025 09:03:20 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Pravin Pathak <pravin.pathak@intel.com>
Subject: [PATCH v5 05/11] event/dlb2: build using common AVX handling
Date: Tue, 25 Mar 2025 16:02:47 +0000
Message-ID: <20250325160254.1724560-6-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250325160254.1724560-1-bruce.richardson@intel.com>
References: <20250314172339.12777-1-bruce.richardson@intel.com>
 <20250325160254.1724560-1-bruce.richardson@intel.com>
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
2.45.2

