Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DB2E95374
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Feb 2026 10:30:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A09B402EE;
	Wed,  4 Feb 2026 11:30:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id D44CB402DE
 for <dev@dpdk.org>; Wed,  4 Feb 2026 11:30:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770201022; x=1801737022;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=iSyyEGjhKPTFQWui3RufAyso2B6CbgKuU/rEoizpLXc=;
 b=aURBsLYcjvBlyyIfnt2wp2lGVmOtdXbOReIcKtB3FO1SVnW+V8jdVdyc
 4sb8xd341ODA0c/AyKsDtNccP99wQjE7A7y4uo+ebj4sm+4u28fyzlExl
 aDUjVNyohNic1ao/pUb411KNH5vn1JGW9YDBto9adMoXIWwOSb7H9W72G
 ukPRS1ibtCnrT1dT7x/dtM3ltyFFcQ6u0kYB5b2t30ujwhCOKnIoTwCzk
 /GOnIhqKYlwpv5nUbfJXSePkyUCqISAL9hmYOTlk8fcCEmQme6UYxpraP
 uvuGtWnlZZOxrlqqWc0TFHd4M/NkD8egCiFP35c+lAOO+cwp52grmcfI8 Q==;
X-CSE-ConnectionGUID: YRQqHZf3Sh2dTbkKEexujQ==
X-CSE-MsgGUID: eLXGHzmfTs6el6RRxItCSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="75236038"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; d="scan'208";a="75236038"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2026 02:30:21 -0800
X-CSE-ConnectionGUID: rrxUldQhStinsdIg88ilZA==
X-CSE-MsgGUID: 3S3o9GK9RKa9QdxheiiuoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; d="scan'208";a="210182421"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa010.fm.intel.com with ESMTP; 04 Feb 2026 02:30:20 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] config/x86: enable compatibility with muon-build
Date: Wed,  4 Feb 2026 10:30:15 +0000
Message-ID: <20260204103015.1895506-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
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

Muon[1] is a reimplementation of meson in C, and in some ways is rather
stricter than meson in processing the build files. Make a few small
changes to the meson.build files to improve muon compatibility without
affecting meson:
* when checking a list of compiler args always use has_multi_arguments
  rather than has_argument, even if list only contains one item.
* when putting lists of compiler args in message output, explicitly
  convert to a string for output using ','.join().

[1] https://github.com/muon-build/muon

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
Note: after this patch, the majority of DPDK configures ok using muon on
my x86 system. Some drivers have not been checked due to missing
dependencies on my system, but one, ml/cnxk, I had to explicitly disable
as it's using a feature not currently supported by muon (cmake_args
parameter to "dependency()").
Despite this limitation, I think occasionally testing things with muon
is useful to more rigorously check our build files.
---
 config/x86/meson.build | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/config/x86/meson.build b/config/x86/meson.build
index d2f4d5c02a..124b204847 100644
--- a/config/x86/meson.build
+++ b/config/x86/meson.build
@@ -68,7 +68,7 @@ if is_linux or cc.get_id() == 'gcc'
 endif
 
 avx512_march_flag = ['-march=x86-64-v4']
-if not cc.has_argument(avx512_march_flag)
+if not cc.has_multi_arguments(avx512_march_flag)
     avx512_march_flag = ['-march=skylake-avx512']
 endif
 # workaround for older compilers, e.g. GCC 8.5 on RHEL 8.
@@ -99,9 +99,9 @@ if (binutils_ok and cc.has_multi_arguments(avx512_march_flag)
     endif
 endif
 if developer_mode and meson.version().version_compare('>=0.60.2')
-    message('Extra C flags needed for AVX2 output: @0@'.format(cc_avx2_flags))
+    message('Extra C flags needed for AVX2 output: [@0@]'.format(','.join(cc_avx2_flags)))
     if cc_has_avx512
-        message('Extra C flags needed for AVX512 output: @0@'.format(cc_avx512_flags))
+        message('Extra C flags needed for AVX512 output: [@0@]'.format(','.join(cc_avx512_flags)))
     endif
 endif
 
-- 
2.51.0

