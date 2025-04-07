Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31459C369A2
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 15:25:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A9A340B90;
	Mon,  7 Apr 2025 17:25:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id D3B9540A7F
 for <dev@dpdk.org>; Mon,  7 Apr 2025 17:25:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744039517; x=1775575517;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NNU/0d+l51+SpIVPBgrA0j/98tInPUKtGEaS8MoZLLE=;
 b=G6/Irbjybl9pr5r2qCxktPW/uUQwj0W/iZovZdEkjzep9Yo4q8VHcldb
 KjHZ3n0xt6IuzHIjWwPbQA4hLV8dh6vigpaaQfhc55JXi2LH90CDf5I8y
 HfS3rkDXuSU2o6dIz2EvsBH7+L3Vpfc+FTC35jrVr72b2T+CDKv5dZSxp
 PxFgh+ZoUBzLdFA/aoSnmEvIYUsxwmz2hH8WntHDhEO0QAtQB3XsgkX+Y
 iE6x7jEcZDYQhXTsA5DbzSfHY1HJRujLlgg7JqDxf6ycUG/FVww1P9sBQ
 YlLllcy+51HxDJ9sifbckV60/yMQls2rYrmuBt5H11kM1m83+LiEaogMz A==;
X-CSE-ConnectionGUID: dOz2AXGmTA+guxmhRraa6Q==
X-CSE-MsgGUID: YKyDWEamT22++08+nIfkcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="70809361"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="70809361"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 08:25:16 -0700
X-CSE-ConnectionGUID: HA2AAC+AQEWn3hRz9SO/Eg==
X-CSE-MsgGUID: T+5I8G1XQyST7ik0C1vDaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="132125567"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by fmviesa003.fm.intel.com with ESMTP; 07 Apr 2025 08:25:15 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 01/10] build: add generic support for base code in drivers
Date: Mon,  7 Apr 2025 16:25:00 +0100
Message-ID: <20250407152509.2203243-2-bruce.richardson@intel.com>
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

