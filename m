Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BC7C3600B
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Mar 2025 16:10:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CAFF040A8A;
	Mon, 31 Mar 2025 18:10:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id C816C406A2
 for <dev@dpdk.org>; Mon, 31 Mar 2025 18:10:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743437445; x=1774973445;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2aFzzD0MwjTMciy0zhNLMsPHL7tIVso+r651WXf2QpM=;
 b=RrbbCtHzh8uMf76Tr0DUH7AneeSMfmgg5UC5dNzHeaeo4DLqCczBrgjf
 jMpCMm9PGLsXrUeKbRtJ2Olf83+JWiOsZVRl9DeJs5EPuPOHAuKutpQuM
 8yyZlM0Ulid7skft9c6u4cefchocCHLC4ser2Na6QgdeB4hLi5Lso89OL
 uzoV4hSjkvh+x/inelLzVDvBTgVukz6C5eQd0nhQyO6wypU27MZAul3Ov
 hPayyId3hWUBI9Jdik77bHe4MjrA0PVT3fT9YHKjThs3oflXM6zKQ+UJ6
 yfW6F2EkDJTO8JB1aR9vbHdxJntMsKYftBMNIpzpk2U3qMMfU2yQt9tv2 A==;
X-CSE-ConnectionGUID: 8z9MoPexSQmZOxMFzLcySg==
X-CSE-MsgGUID: xq2mDN1fQtOX2OQHL2dgFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="62125726"
X-IronPort-AV: E=Sophos;i="6.14,291,1736841600"; d="scan'208";a="62125726"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2025 09:10:44 -0700
X-CSE-ConnectionGUID: Yn3B/9OVRHyzTf8u8QozpQ==
X-CSE-MsgGUID: mpURaCw0RzWiCe0/pVhsSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,291,1736841600"; d="scan'208";a="131132771"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by orviesa004.jf.intel.com with ESMTP; 31 Mar 2025 09:10:43 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [PATCH 06/10] net/octeontx: use common base code build handling
Date: Mon, 31 Mar 2025 17:09:56 +0100
Message-ID: <20250331161000.9886-8-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250331161000.9886-1-bruce.richardson@intel.com>
References: <20250331161000.9886-1-bruce.richardson@intel.com>
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

Use the base code build handling logic in the drivers/meson.build file,
rather than re-implementing it in the driver itself.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/octeontx/base/meson.build | 19 +------------------
 drivers/net/octeontx/meson.build      |  3 ---
 2 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/net/octeontx/base/meson.build b/drivers/net/octeontx/base/meson.build
index 8e5e8c1b55..244466bd36 100644
--- a/drivers/net/octeontx/base/meson.build
+++ b/drivers/net/octeontx/base/meson.build
@@ -1,25 +1,8 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2017 Cavium, Inc
 
-sources = [
+base_sources = files(
         'octeontx_pkovf.c',
         'octeontx_pkivf.c',
         'octeontx_bgx.c',
-]
-
-depends = ['ethdev', 'mempool_octeontx']
-static_objs = []
-foreach d: depends
-    if not is_variable('shared_rte_' + d)
-        subdir_done()
-    endif
-    static_objs += get_variable('static_rte_' + d)
-endforeach
-
-c_args = cflags
-base_lib = static_library('octeontx_base', sources,
-    c_args: c_args,
-    dependencies: static_objs,
 )
-
-base_objs = base_lib.extract_all_objects(recursive: true)
diff --git a/drivers/net/octeontx/meson.build b/drivers/net/octeontx/meson.build
index 541d2d9d0b..fc8a5a73f2 100644
--- a/drivers/net/octeontx/meson.build
+++ b/drivers/net/octeontx/meson.build
@@ -8,7 +8,6 @@ if not is_linux or not dpdk_conf.get('RTE_ARCH_64')
 endif
 
 subdir('base')
-objs = [base_objs]
 
 sources = files(
         'octeontx_ethdev.c',
@@ -18,6 +17,4 @@ sources = files(
 
 deps += ['mempool_octeontx', 'eventdev']
 
-includes += include_directories('base')
-
 cflags += no_wvla_cflag
-- 
2.45.2

