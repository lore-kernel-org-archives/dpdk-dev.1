Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A55C3600B
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Mar 2025 16:10:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 243CD406BA;
	Mon, 31 Mar 2025 18:10:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id EA05C40689
 for <dev@dpdk.org>; Mon, 31 Mar 2025 18:10:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743437417; x=1774973417;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NNU/0d+l51+SpIVPBgrA0j/98tInPUKtGEaS8MoZLLE=;
 b=SnXhlcUdnFb7CE6yknCkAmbyrMYV3nEXbOH3cPRs/1jB2YspiQYvdE7N
 Tktu/jZNYjK11Ni7IX3bX7KN63tqjuBL0JhSHU4q91jsTn4eTkeUeKh7h
 nRtymO79NYLylfYvrMRGKA3IoIsgsa3RlQRcfVpbesmzF4+tOC4Vgil0J
 4JQx62m8Zv81PYYf84QcNEmSjTiZ849sBprc/fulogKqbTMrLLUuXr9T+
 d3LJsu3dgO6dHFzvQrZaT1csbCN73CiuCDo09K63PFbbo9e6tl9V4S8Bp
 2bHi9/0FpYGlA31EK+aJNBvyHXMbsl4zVrwW1ocwdUtfX5hhP0i0sEmLc A==;
X-CSE-ConnectionGUID: Qu5blijiRom3LxfnQbKCLg==
X-CSE-MsgGUID: 9MAWbDN6SkywXxIn7dAQiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="62125632"
X-IronPort-AV: E=Sophos;i="6.14,291,1736841600"; d="scan'208";a="62125632"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2025 09:10:16 -0700
X-CSE-ConnectionGUID: MO/TEA5STS+SYxr2VTDylQ==
X-CSE-MsgGUID: RbjEo9c+SFidHnuqENVPBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,291,1736841600"; d="scan'208";a="131132522"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by orviesa004.jf.intel.com with ESMTP; 31 Mar 2025 09:10:16 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 01/10] build: add generic support for base code in drivers
Date: Mon, 31 Mar 2025 17:09:50 +0100
Message-ID: <20250331161000.9886-2-bruce.richardson@intel.com>
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

Add support to the drivers meson.build file for base code files with
extra cflags for compilation. This should remove the need for custom
logic in each driver.

In future, we may want to move the base code handling down the file a
little in order to get lock checking. However, this lock checking is not
done currently on base code builds, so not all drivers can safely pass
these checks. Therefore, we handle the base code files before we add on
the extra lock annotation flags.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/meson.build | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/meson.build b/drivers/meson.build
index c15319dc24..b2d2537dc8 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -145,7 +145,13 @@ foreach subpath:subdirs
         pkgconfig_extra_libs = []
         testpmd_sources = []
         require_iova_in_mbuf = true
+        # for handling base code files which may need extra cflags
+        base_sources = []
+        base_cflags = []
 
+        if fs.is_dir(drv_path / 'base')
+            includes += include_directories(drv_path / 'base')
+        endif
         if name.contains('/')
             name = name.split('/')[1]
         endif
@@ -216,6 +222,20 @@ foreach subpath:subdirs
             continue
         endif
 
+        # not all drivers base code is lock annotation safe, so do base code builds before
+        # adding on the lock annotation flags. NOTE: If no custom cflags, the lock annotation
+        # checks will be done though.
+        if base_cflags != []
+            base_lib = static_library(lib_name + '_base_lib',
+                    base_sources,
+                    dependencies: static_deps,
+                    include_directories: includes,
+                    c_args: cflags + base_cflags)
+            objs += base_lib.extract_objects(base_sources)
+        else
+            sources += base_sources
+        endif
+
         enabled_drivers += name
         lib_name = '_'.join(['rte', class, name])
         cflags += '-DRTE_LOG_DEFAULT_LOGTYPE=' + '.'.join([log_prefix, name])
-- 
2.45.2

