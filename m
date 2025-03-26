Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D9CC3600B
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 15:53:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3666D4067E;
	Wed, 26 Mar 2025 16:52:50 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 9FC1A40662;
 Wed, 26 Mar 2025 16:52:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743004368; x=1774540368;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Dt/5HkJlz/PyeGj2Ssqd1lfYkVoZ8yPCgnBj5IZvYco=;
 b=XN2IsN3VuuPiE6mrL168aUvtliLPfi4F62t8G1VHfEiExBljyc8/GkNA
 BEYsjnBoVSe6YrGgANirD8kPHxZRymL/E3zoIEPhdSYsm60kHOeZ+H6Lb
 qo/ioYbchxhqu1iVcWkVjni97wpT6jCTo/o/to0xX6xKNAYDsw5L5/Cuf
 V6gZKzd3KYdTQcObhrM5AkIGqBlL578Z0m1E8eNOZ7+DpN4NAE9r6s9Ey
 yoKDnT9RxMOtETPGTEn4VuFxNduM/aHKMEK3loxKqDTHKkCFoX/XhNwiC
 3hXYfcov+KGfHiP48y/E1dy6K17/wrOy1pklGcsUYlLGr5hwiihQ8Kmot A==;
X-CSE-ConnectionGUID: Gu7sffKSTVmJSfdCLUb2Sw==
X-CSE-MsgGUID: 18Uit9pFQ02J+a9PmHx6WA==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44188326"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; d="scan'208";a="44188326"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2025 08:52:47 -0700
X-CSE-ConnectionGUID: S65Qurj0Rf2bUSdBnld7YA==
X-CSE-MsgGUID: lHyQ1ihPSCmXproDgq/35Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; d="scan'208";a="124550922"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by orviesa009.jf.intel.com with ESMTP; 26 Mar 2025 08:52:45 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Ian Stokes <ian.stokes@intel.com>, Jijiang Liu <jijiang.liu@intel.com>,
 Cunming Liang <cunming.liang@intel.com>, Jing Chen <jing.d.chen@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>, Heqing Zhu <heqing.zhu@intel.com>
Subject: [PATCH 5/7] net/i40e/base: fix compiler warnings
Date: Wed, 26 Mar 2025 15:52:27 +0000
Message-ID: <20250326155230.1315056-6-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250326155230.1315056-1-bruce.richardson@intel.com>
References: <20250326155230.1315056-1-bruce.richardson@intel.com>
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

Add a single-line fix to the base code, and then the remaining two
compiler warning disable flags can be removed from the driver base code
build file.

Fixes: 8db9e2a1b232 ("i40e: base driver")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/i40e/base/i40e_diag.c |  2 +-
 drivers/net/intel/i40e/base/meson.build | 13 +------------
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/net/intel/i40e/base/i40e_diag.c b/drivers/net/intel/i40e/base/i40e_diag.c
index 4ca102cdd5..71b2e53e85 100644
--- a/drivers/net/intel/i40e/base/i40e_diag.c
+++ b/drivers/net/intel/i40e/base/i40e_diag.c
@@ -34,7 +34,7 @@ static enum i40e_status_code i40e_diag_reg_pattern_test(struct i40e_hw *hw,
 {
 	const u32 patterns[] = {0x5A5A5A5A, 0xA5A5A5A5, 0x00000000, 0xFFFFFFFF};
 	u32 pat, val, orig_val;
-	int i;
+	unsigned int i;
 
 	orig_val = rd32(hw, reg);
 	for (i = 0; i < ARRAY_SIZE(patterns); i++) {
diff --git a/drivers/net/intel/i40e/base/meson.build b/drivers/net/intel/i40e/base/meson.build
index 2648e5d0c4..766383101b 100644
--- a/drivers/net/intel/i40e/base/meson.build
+++ b/drivers/net/intel/i40e/base/meson.build
@@ -11,18 +11,7 @@ sources = [
         'i40e_nvm.c',
 ]
 
-error_cflags = [
-        '-Wno-sign-compare',
-        '-Wno-strict-aliasing',
-]
-c_args = cflags
-foreach flag: error_cflags
-    if cc.has_argument(flag)
-        c_args += flag
-    endif
-endforeach
-
 base_lib = static_library('i40e_base', sources,
     dependencies: static_rte_eal,
-    c_args: c_args)
+    c_args: cflags)
 base_objs = base_lib.extract_all_objects(recursive: true)
-- 
2.45.2

