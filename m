Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186E1C77B7C
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 16:02:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E788E40A6D;
	Wed,  2 Jul 2025 18:02:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 7D3394028E
 for <dev@dpdk.org>; Wed,  2 Jul 2025 18:02:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751472130; x=1783008130;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vV9lTuYWMjhEN/NnLk/27mYC+DsLshtSlyEE1GlcC44=;
 b=k/BFSpDQ9piI+JtbbksaODWJ2e8dSwuxA5Od/6XNQs4HC3Fx9xSSW9pg
 Dy60V0nuK05DFqFdLAPFMunX3NGaKqEGlykOn211aBBNqNmzNu44jUeT9
 9Cu5sCtPVv5IVqkMZCcoW8LRqL9dkQr33NZgSY5GbUeUJXf4R7CppRM2x
 RSwr5cAVABSIRamDAZD9oO5lJGdZhLq2P+VWhWr6Xjxe93nmhFrw85W2x
 mCsS8dJWxaS9MBo3TlCkPNPOxCwoFxW7lr3NRyZyOVfpgaUUA/8ZPdAoS
 FQz1ayeUh4wdIjWAxmfQR3BLZkz+Hls7jZM0jYVcHQqbnESqQ2pYQ6dQF Q==;
X-CSE-ConnectionGUID: /wd3ppfvSm+wZDfb8sa3Lg==
X-CSE-MsgGUID: SwdqOnprTzS6g9ulgfqsLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="79218750"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="79218750"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 09:02:08 -0700
X-CSE-ConnectionGUID: tJpC7yTiS7WJzUAwx9WSaA==
X-CSE-MsgGUID: SocPM/wRSX6CeiLBSrdGng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="158498295"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by orviesa003.jf.intel.com with ESMTP; 02 Jul 2025 09:02:07 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Vipin Varghese <vipin.varghese@amd.com>
Subject: [PATCH v2] build/x86: fix support for older compilers
Date: Wed,  2 Jul 2025 17:00:45 +0100
Message-ID: <20250702160138.3441279-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250702155129.3440210-1-bruce.richardson@intel.com>
References: <20250702155129.3440210-1-bruce.richardson@intel.com>
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

gcc -march=native -march=skylake-avx512 -dM -E - < /dev/null | grep AVX512 | wc -l
0

gcc -march=haswell -march=skylake-avx512 -dM -E - < /dev/null | grep AVX512 | wc -l
5

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

