Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC5AC83F04
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 15:51:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 553F040E3F;
	Wed,  2 Jul 2025 17:51:43 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id ABA2440285
 for <dev@dpdk.org>; Wed,  2 Jul 2025 17:51:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751471502; x=1783007502;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=B2deQ5NU4utmAOH9XRzsjoP8jtRfXmcPAovY6J/2FkI=;
 b=Xn5tO/SFxP/hBmNFFobKaKSbKrx6vkxNEd5LkEDX8qPbMNxsxFuoXLJ7
 OUtYJiOoGXmHr1S/gTX8L7cEFsCrAwPjjaYi+JZCZkgBcfTTlbqUtQUZl
 2c7hVoqzONKu+YWhhNGC7SRvXJ8KPWLudKhbbYoJ1uum4g+NWHNCHvImc
 Mgzbd3l+nXa+MyRD/NgykAzyk9IlBFTQBJCUcaSBNI+U1hE0JpuTmukOU
 185RhWTYTGeKkxOMGh0XoJhBrTZArgY5vw1EYjAmURk0eEJfm0qLWOnx5
 oX7pMUzRmrIYlwFEWtIRXUcge8gtJKdjHQ8pHoPkS1mxMwnrogGaB4Imv A==;
X-CSE-ConnectionGUID: c2vLxxLLTmWFYwOtKqTyOg==
X-CSE-MsgGUID: hp5g8Lk/QxWXv0tGzmKpSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="64826367"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="64826367"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 08:51:41 -0700
X-CSE-ConnectionGUID: YOa9e16PTuq5DBw1KA8szA==
X-CSE-MsgGUID: zqeHvFbsRXCqYucSP8XXwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="158158567"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by fmviesa003.fm.intel.com with ESMTP; 02 Jul 2025 08:51:39 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Vipin Varghese <vipin.varghese@amd.com>
Subject: [PATCH] build/x86: fix support for older compilers
Date: Wed,  2 Jul 2025 16:51:29 +0100
Message-ID: <20250702155129.3440210-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
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

Some older compilers e.g. gcc 8.5, do not support overriding
-march=native with another architecture, leading to build warnings such
as reported in Bugzilla (link below). Add a check for that case, and
explicitly add the avx512 flags if necessary.

Note: it appears that it is only the "native" flag that isn't
overridden, which makes the issue hard to reproduce e.g. using
godbolt.org, or on a modern machine. For example, testing with gcc 8.5
on a haswell machine, using 'native' vs explicit 'haswell':

gcc -march=native -march=skylake-avx512 -dM -E - < /dev/null | grep AVX

gcc -march=haswell -march=skylake-avx512 -dM -E - < /dev/null | grep AVX
...

Bugzilla ID: 1736
Fixes: e361ae3f59d3 ("build: reduce use of AVX compiler flags")

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 config/x86/meson.build | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/config/x86/meson.build b/config/x86/meson.build
index e2ccfb6d12..0dcc5ddee4 100644
--- a/config/x86/meson.build
+++ b/config/x86/meson.build
@@ -71,8 +71,13 @@ avx512_march_flag = '-march=x86-64-v4'
 if not cc.has_argument(avx512_march_flag)
     avx512_march_flag = '-march=skylake-avx512'
 endif
+# workaround for older compilers, e.g. gcc 8.5 on RHEL 8.
+# if march flag overriding doesn't work, explicitly add flags for AVX512.
+if cc.get_define('__AVX512F__', args: [machine_args, avx512_march_flag]) == ''
+    avx512_march_flag = ['-mavx512f', '-mavx512bw', '-mavx512cd', '-mavx512dq', '-mavx512vl']
+endif
 cc_avx512_flags = []
-if (binutils_ok and cc.has_argument(avx512_march_flag)
+if (binutils_ok and cc.has_multi_arguments(avx512_march_flag)
         and '-mno-avx512f' not in get_option('c_args'))
     # check if compiler is working with _mm512_extracti64x4_epi64
     # Ref: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82887
-- 
2.48.1

