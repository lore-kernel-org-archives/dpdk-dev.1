Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99DCCC6B33
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 11:08:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ABC26400EF;
	Thu, 15 Oct 2026 13:08:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id EF23040041
 for <dev@dpdk.org>; Thu, 15 Oct 2026 13:08:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792062487; x=1823598487;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=fb6ohE5aefM0YgTPw+HApiFcU4/O/N9YT3XiibqmrDc=;
 b=eCetdBMBJV2ykLnAwjLnZpW0mqzbOivQ/rQwEHz224M8olJwISROsA23
 Il9ZZzZ6mo4paLu4Hclvouy+XaQdUg9ZFkj6LE0YaldwlqlJnHbaDkfuX
 +iMNmfR7c5o7qZSMPyrEyz9taKM9wsWjhzz9kH9ZegVSLc5p6vq2Ozo2j
 mPZacioJUOLYG86VEiL0CoZs4yh8RTaFxVsjoAraXyPwDrxvkT2JsA/c3
 oNrtRchVa1cE/9yalh4tfW9PFGvcY6Fr1lXuz4HlgQdOSKTx01D0LX5WA
 RoMkp/vySCu4Z18R+yOGvFfX+5HC5IGoukqD6M/ltmOl4Y0RYsm67bB8F Q==;
X-CSE-ConnectionGUID: ewXzUc5oSxaCLsqORT7/QA==
X-CSE-MsgGUID: Cmjxg1rjS3ykaPjFPWhQHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="837564"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="837564"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 04:08:05 -0700
X-CSE-ConnectionGUID: FCcUf3ZKSs2zHS0sXwPZrA==
X-CSE-MsgGUID: mnL6FfAESl+ii2NXmUaqnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="1725729"
Received: from silpixa00401120.ir.intel.com ([10.20.224.208])
 by orviesa006.jf.intel.com with ESMTP; 15 Oct 2026 04:08:04 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] meson: fix always-true meson version check
Date: Thu, 15 Oct 2026 12:09:44 +0100
Message-ID: <20261015110944.11508-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.56.0
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

Since the minimum version of meson needed to build DPDK has been
increased to 0.61, the version check for >= 0.60.2 will always be true,
so just remove it.

Fixes: c1d15cc8d571 ("build: bump meson version to remove warnings")

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 config/x86/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config/x86/meson.build b/config/x86/meson.build
index 124b204847..e091beb293 100644
--- a/config/x86/meson.build
+++ b/config/x86/meson.build
@@ -98,7 +98,7 @@ if (binutils_ok and cc.has_multi_arguments(avx512_march_flag)
         endif
     endif
 endif
-if developer_mode and meson.version().version_compare('>=0.60.2')
+if developer_mode
     message('Extra C flags needed for AVX2 output: [@0@]'.format(','.join(cc_avx2_flags)))
     if cc_has_avx512
         message('Extra C flags needed for AVX512 output: [@0@]'.format(','.join(cc_avx512_flags)))
-- 
2.56.0

