Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4386BCCA464
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 11:01:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E03B40A84;
	Fri, 16 Oct 2026 13:00:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 3CC13406B6
 for <dev@dpdk.org>; Fri, 16 Oct 2026 13:00:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792148411; x=1823684411;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yFWXIrKPYeSTZ3JozVVtw5PwVf9+d0Gh5bwpIozUpMw=;
 b=W+rq8q1QRE1hvAsMWh3/BX9zLH18vlueKLEV7phDhavcUtDO83TEIyC3
 a1XYfzzX+Q5nmbBfkSeRJ152/Vgx1pJG8pFxW/naUgpUKGtQd3JrdUmxB
 kowK6laViYuDlEnKcJSRWmiSozL6I1TqzMLmvinaOmghOAIViCDTRMhB3
 LJdoOrXtBpf9Jm7m9wzPU1ZVVdpzRDFGNTZgNhBBuEy5nqb0qz3cMFxUD
 HoBrjLpek6FN0Tu+tOyV92F+iJo+YLC+blwzf02gXdFnyl2XrI/nYzyb/
 VmgzBUkHlZ35Tpi7Q/q5xepCQG/buoXBvGL35jKhSVPbRe39yUAFg5rr9 w==;
X-CSE-ConnectionGUID: wTCn/FFNQ3aapYjbzmBIcw==
X-CSE-MsgGUID: fllBQqN+TZK9hcJmjDNijg==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="944143"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="944143"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 04:00:10 -0700
X-CSE-ConnectionGUID: 5FVDLFexSnCHXnNPt8xDbQ==
X-CSE-MsgGUID: BawyvZLwTn+4hM0t+CO8xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="3759402"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa011.fm.intel.com with ESMTP; 16 Oct 2026 04:00:10 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 09/12] build: improve error reporting for unbuildable
 components
Date: Fri, 16 Oct 2026 11:59:47 +0100
Message-ID: <20261016105950.273068-10-bruce.richardson@intel.com>
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

With the addition of automatic dependency tracking so that dependencies
are automatically enabled for libraries and drivers, the error message
for a missing library is now inaccurate (although following it will lead
eventually to a solution by way of other error messages!).

Improve this situation by correctly reporting if a necessary component
is explicitly disabled or cannot be built for some other reason.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

drivers
---
 drivers/meson.build | 27 ++++++++++++++++++++++++++-
 lib/meson.build     | 16 ++++++++++++----
 2 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/drivers/meson.build b/drivers/meson.build
index fe514a0b15..aacfe29c46 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -248,8 +248,33 @@ foreach subpath:subdirs
                     # error out if we can't build a driver and that driver was explicitly
                     # requested, i.e. not via wildcard.
                     if require_drivers and get_option('enable_drivers').contains(drv_path)
+                        # reconstruct the path from the name by replacing the first
+                        # "_" with a "/"; the class never contains an underscore
+                        d_parts = d.split('_')
+                        d_rest = []
+                        foreach i : range(1, d_parts.length())
+                            d_rest += d_parts[i]
+                        endforeach
+                        missing_path = d_parts[0] + '/' + '_'.join(d_rest)
+                        if driver_map.has_key(missing_path)
+                            # disable_drivers/dpdk_drvs_disabled store the canonical
+                            # path, e.g. net/intel/idpf rather than the legacy net/idpf
+                            missing_path = driver_map[missing_path]
+                        endif
+                        if disable_drivers.contains(missing_path)
+                            advice = 'Remove "@0@" from the "disable_drivers" option.'.format(
+                                    missing_path)
+                        elif dpdk_drvs_disabled.contains(missing_path)
+                            advice = 'Driver "@0@" cannot be built: @1@'.format(missing_path,
+                                    get_variable('drv_' + missing_path.underscorify()
+                                            + '_disable_reason'))
+                        else
+                            advice = 'Please check the build configuration for driver "@0@".'.format(
+                                    missing_path)
+                        endif
                         error('Cannot build explicitly requested driver "@0@".\n'.format(drv_path)
-                                +'\tPlease enable missing dependency "@0@"'.format(d))
+                                + '\tMissing dependency "@0@".\n'.format(d)
+                                + '\t' + advice)
                     endif
                 else
                     shared_deps += [get_variable('shared_rte_' + d)]
diff --git a/lib/meson.build b/lib/meson.build
index f7705d7ebe..8adb510513 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -106,7 +106,6 @@ foreach l:requested_libs
         error('Library "@0@" is in both "enable_libs" and "disable_libs".'.format(l))
     endif
 endforeach
-require_libs = requested_libs.length() != 0
 
 # expand the requested libraries to also include the libraries they depend on,
 # with an empty request meaning every library is wanted
@@ -173,7 +172,7 @@ foreach l:libraries
 
     if build
         subdir(l)
-        if not build and require_libs
+        if not build and requested_libs.contains(l)
             error('Cannot build explicitly requested lib "@0@".\n'.format(name)
                     +'\tReason: ' + reason)
         endif
@@ -196,9 +195,18 @@ foreach l:libraries
             endif
             message('Disabling @1@ [@2@]: missing internal dependency "@0@"'
                     .format(d, name, 'lib/' + l))
-            if require_libs
+            if requested_libs.contains(l)
+                if disable_libs.contains(d)
+                    advice = 'Remove "@0@" from the "disable_libs" option.'.format(d)
+                elif dpdk_libs_disabled.contains(d)
+                    advice = 'Library "@0@" cannot be built: @1@'.format(d,
+                            get_variable('lib_' + d.underscorify() + '_disable_reason'))
+                else
+                    advice = 'Please check the build configuration for library "@0@".'.format(d)
+                endif
                 error('Cannot build explicitly requested lib "@0@".\n'.format(name)
-                        + '\tPlease add missing dependency "@0@" to "enable_libs" option'.format(d))
+                        + '\tMissing dependency "@0@".\n'.format(d)
+                        + '\t' + advice)
             endif
         else
             shared_deps += [get_variable('shared_rte_' + d)]
-- 
2.53.0

