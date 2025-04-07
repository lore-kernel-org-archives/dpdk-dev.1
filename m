Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD6AC36010
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 15:25:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 77CC640B98;
	Mon,  7 Apr 2025 17:25:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id B136B40A7F
 for <dev@dpdk.org>; Mon,  7 Apr 2025 17:25:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744039518; x=1775575518;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XcXR/z3tM6W21o70JP90dI0nkUl8KZQJBD9cP1mCAas=;
 b=mPt9oAynTmdMOTNm6e9z31bO7EWDTqAmXx55ni2Ti0ssU4b83pRiSSeQ
 btS4cAWH+gPfG/kzqewmRZ0YmJpQA84e3ySuI7fFEY2EBX1sSUTQp8VbF
 xxzvFkvCyA8Sjt1PDZ0DsVnur36LqYF63ox7w9sbFyZ9HNt2FT1qwQavK
 keX6Iz+yQH7iIDs7HFEirUCUK2WJDDX2d8fgrE6EvOO6ssJo8lkeLG1T4
 q0Ibh9VjGEg1QsTPImxGiypIsYyvdDHQsO9KxjXA152JJ9OSxvumEFN2t
 gqwayKS/NyeGkaSDOKvwisy0KYld2GemZKLa5woW6106cSgxel5bqjLZK w==;
X-CSE-ConnectionGUID: wEZ+L2atSE+L4tBpr8yIdw==
X-CSE-MsgGUID: sYD74wB/STylGsnJZP+UqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="70809363"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="70809363"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 08:25:17 -0700
X-CSE-ConnectionGUID: jhFOzjNuQB+yjXVBeJ+8gw==
X-CSE-MsgGUID: qZIlEk+tSDWuA+iq9Q5rlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="132125570"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by fmviesa003.fm.intel.com with ESMTP; 07 Apr 2025 08:25:16 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v2 02/10] common/sfc_efx: use common base code build handling
Date: Mon,  7 Apr 2025 16:25:01 +0100
Message-ID: <20250407152509.2203243-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250407152509.2203243-1-bruce.richardson@intel.com>
References: <20250331161000.9886-1-bruce.richardson@intel.com>
 <20250407152509.2203243-1-bruce.richardson@intel.com>
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
Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
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

