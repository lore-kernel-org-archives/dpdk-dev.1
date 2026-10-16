Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24673CCA464
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 11:01:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DAC9E40A81;
	Fri, 16 Oct 2026 13:00:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id EE613406A2
 for <dev@dpdk.org>; Fri, 16 Oct 2026 13:00:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792148411; x=1823684411;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OtZflPyciBmayCMDgJbzKIrxr4gzy+ZhS6d4VXQA6is=;
 b=DhCh24AeRsnFSYeeRoFmT18E+pF/kz/n1Bn9wuyrpV4uptlol7SHS2kM
 zkenJjvab2Gv5lnrXd4F9d2HJoTnlYTdSYa9L6JJfzUDXfj+nY0Lu8j+v
 iJthvH2Wp7agxqLIs80F55CxivCd1mMvPZgltnt0Z00sOcomdYbyQX8zB
 mXoL6bFljF/sB2rRRI61Ydvtu/pgLmPcBQsoPQ/v+hvZxSXY0efBAh1vt
 lg3bQdiH7hVKx0Sh3k2sxsX+tbwGJcoXlhaZ91cejz6c9vasMrZtSsdJv
 ofxPRlF/CuH/7kjFUkNM9By95mxTBjcesgt/FHXg3tTUyBS/SbGoX+J4L A==;
X-CSE-ConnectionGUID: isg70qQpRcqF/kEh6j1MRw==
X-CSE-MsgGUID: eWLfj8xhTSGBAuae29X/0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="944138"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="944138"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 04:00:09 -0700
X-CSE-ConnectionGUID: sCpeLnvZTNibCSUmzR7Pgw==
X-CSE-MsgGUID: rGepMlz5SVe41fQ81hL97Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="3759398"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa011.fm.intel.com with ESMTP; 16 Oct 2026 04:00:09 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 08/12] build: use recursive addition for enabled drivers
 option
Date: Fri, 16 Oct 2026 11:59:46 +0100
Message-ID: <20261016105950.273068-9-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016105950.273068-1-bruce.richardson@intel.com>
References: <20261016105950.273068-1-bruce.richardson@intel.com>
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

As with the libraries, recursively add dependencies of the enabled
drivers to the build list to enable building with, for example, just
--enable_drivers=net/mlx5 or --enable_drivers=net/cpfl.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/meson.build | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/meson.build b/drivers/meson.build
index cb71bc8231..fe514a0b15 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -71,23 +71,26 @@ foreach driver_option : ['disable_drivers', 'enable_drivers']
 endforeach
 
 disable_drivers = run_command(list_dir_globs, disable_drivers, check: true).stdout().split()
-enable_drivers = run_command(list_dir_globs, enable_drivers, check: true).stdout().split()
-foreach d:enable_drivers
+requested_drivers = run_command(list_dir_globs, enable_drivers, check: true).stdout().split()
+foreach d:requested_drivers
     if disable_drivers.contains(d)
         error('Driver "@0@" is in both "enable_drivers" and "disable_drivers".'.format(d))
     endif
 endforeach
-require_drivers = true
-if enable_drivers.length() == 0
-    require_drivers = false
-    enable_drivers = run_command(list_dir_globs, '**', check: true).stdout().split()
-endif
+require_drivers = requested_drivers.length() != 0
 
 # these drivers must always be enabled, otherwise the build breaks
 always_enable = ['bus/pci', 'bus/vdev']
 # we always need a mempool driver, and ring is default, so make it mandatory
 always_enable += ['mempool/ring']
-enable_drivers += always_enable
+
+# expand the requested drivers to also include the drivers they depend on; with
+# no drivers requested every driver is wanted, so no list is needed
+enable_drivers = []
+if require_drivers
+    enable_drivers = run_command(resolve_deps_cmd, dpdk_deps_graph, '--drivers',
+            requested_drivers + always_enable, check: true).stdout().strip().split(',')
+endif
 
 default_cflags = machine_args
 default_cflags += ['-DALLOW_EXPERIMENTAL_API']
@@ -200,7 +203,7 @@ foreach subpath:subdirs
             name = name.split('/')[1]
         endif
 
-        if not enable_drivers.contains(drv_path)
+        if require_drivers and not enable_drivers.contains(drv_path)
             build = false
             reason = 'not in enabled drivers build config'
         elif disable_drivers.contains(drv_path)
-- 
2.53.0

