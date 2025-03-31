Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51D8C3600B
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Mar 2025 16:10:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1450040A6C;
	Mon, 31 Mar 2025 18:10:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id D1AE640A6C
 for <dev@dpdk.org>; Mon, 31 Mar 2025 18:10:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743437421; x=1774973421;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9ivePJiyr9mM6851yUVFTDfvASalWp+TzGkIxcK4/C4=;
 b=SdnkZoMg67cg48Ia5ymU56bE66rxv5+c1LBCwuJbl0pd9ew6nhbLazmG
 m0FoYc09CsumQ6NAZXguVPx3080RVT2OwM9ZB56MT63x1Dl0ls7uiAslN
 G8BA8i0epgl8ejPmC73rlhGizNUDXZ1pdU8ALx5DSSZz11IAVGLdGTM/9
 V1vJ4mLDRLfjxsD6m4LitWPdnuq4OVGpJ8Dy+V8fe24w8mf1gykgGsKt0
 JGc33hQPAsizJ4qenDvjGLuW+cv3zdvbYbgz3V6Jpmbr6QU7HsCjR9JMG
 tj7bzaiaez96A3c326f5Luyh919kbod/HoUFtF5ji6XU9Jlj+Olqb2sSE A==;
X-CSE-ConnectionGUID: Z5hhWOs2RHqC2kA+6+8Iyw==
X-CSE-MsgGUID: uGvZ97ErQMKpjZ8jZlaGDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="62125644"
X-IronPort-AV: E=Sophos;i="6.14,291,1736841600"; d="scan'208";a="62125644"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2025 09:10:20 -0700
X-CSE-ConnectionGUID: K8qeuqeWQTioV1oPD1Gm8A==
X-CSE-MsgGUID: jbZEpAUjQdKFBaQDddWUug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,291,1736841600"; d="scan'208";a="131132632"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by orviesa004.jf.intel.com with ESMTP; 31 Mar 2025 09:10:19 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 02/10] common/sfc_efx: use common base code build handling
Date: Mon, 31 Mar 2025 17:09:51 +0100
Message-ID: <20250331161000.9886-3-bruce.richardson@intel.com>
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
 drivers/common/sfc_efx/base/meson.build | 18 +++---------------
 drivers/common/sfc_efx/meson.build      |  3 ---
 2 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/common/sfc_efx/base/meson.build b/drivers/common/sfc_efx/base/meson.build
index c8deb4555e..58bb5f7b4a 100644
--- a/drivers/common/sfc_efx/base/meson.build
+++ b/drivers/common/sfc_efx/base/meson.build
@@ -5,7 +5,7 @@
 # This software was jointly developed between OKTET Labs (under contract
 # for Solarflare) and Solarflare Communications, Inc.
 
-sources = [
+base_sources = files(
         'efx_bootcfg.c',
         'efx_crc32.c',
         'efx_ev.c',
@@ -64,7 +64,7 @@ sources = [
         'rhead_tunnel.c',
         'rhead_tx.c',
         'rhead_virtio.c',
-]
+)
 
 if is_ms_compiler
     extra_flags = [
@@ -80,20 +80,8 @@ else
     ]
 endif
 
-c_args = cflags
 foreach flag: extra_flags
     if cc.has_argument(flag)
-        c_args += flag
+        base_cflags += flag
     endif
 endforeach
-
-if build
-    base_lib = static_library('sfc_base', sources,
-        include_directories: includes,
-        dependencies: static_rte_eal,
-        c_args: c_args)
-
-    base_objs = base_lib.extract_all_objects(recursive: true)
-else
-    base_objs = []
-endif
diff --git a/drivers/common/sfc_efx/meson.build b/drivers/common/sfc_efx/meson.build
index 0cf0a23bf8..d8cb6d7b96 100644
--- a/drivers/common/sfc_efx/meson.build
+++ b/drivers/common/sfc_efx/meson.build
@@ -35,12 +35,9 @@ foreach flag: extra_flags
 endforeach
 
 subdir('base')
-objs = [base_objs]
 
 deps += ['bus_pci']
 sources = files(
         'sfc_efx.c',
         'sfc_efx_mcdi.c',
 )
-
-includes += include_directories('base')
-- 
2.45.2

