Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF87C3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 14:53:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4CB2140E54;
	Thu, 27 Mar 2025 15:52:28 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id F078540E78;
 Thu, 27 Mar 2025 15:52:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743087148; x=1774623148;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Dt/5HkJlz/PyeGj2Ssqd1lfYkVoZ8yPCgnBj5IZvYco=;
 b=nzmvObzhhHNL0e8p6u64Yf4t7a57EGSmJMjQYBbjz1E5NZ32Phc+rp+L
 5p02IsHEDUi1l3S+wl2YF05jlSvc/9KT8sYvnF5M10iSVCrPjtXeHb/tr
 Qkak0nkuQ4maY3bF+gLna642aFKLBOJV9MDrzmpKrv9+XblziVW0HB8yx
 9+w56lArqHi2h6D8TSAx+Ywkbk/WnPnLl6m9utGtjSRYv0Rsvvz0ruo3B
 /dZs2s8ASQFWxvWoeyMGU3gFuSQ4muEfS/YDGIpMaTsJj/5DPQWl5TG0a
 vM16KElvO8LBcdDAnr+Nk+QHa3XOZajC6z3P4mdc3iALK7IRVCSIG8iwh Q==;
X-CSE-ConnectionGUID: If//5NCFQdGBqkkGQ7vl9Q==
X-CSE-MsgGUID: V+1+n4KLQNqNIBGM5EkgSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="48207083"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="48207083"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 07:52:27 -0700
X-CSE-ConnectionGUID: qkUW33iWTtCYmp+cW5Pvxw==
X-CSE-MsgGUID: PWkrQXKYQW+11qxhqalneg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="162400059"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by orviesa001.jf.intel.com with ESMTP; 27 Mar 2025 07:52:25 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Ian Stokes <ian.stokes@intel.com>, Cunming Liang <cunming.liang@intel.com>,
 Jing Chen <jing.d.chen@intel.com>, Heqing Zhu <heqing.zhu@intel.com>,
 Jijiang Liu <jijiang.liu@intel.com>, Jingjing Wu <jingjing.wu@intel.com>
Subject: [PATCH v3 7/9] net/i40e/base: fix compiler warnings
Date: Thu, 27 Mar 2025 14:51:59 +0000
Message-ID: <20250327145202.2220153-8-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250327145202.2220153-1-bruce.richardson@intel.com>
References: <20250326155230.1315056-1-bruce.richardson@intel.com>
 <20250327145202.2220153-1-bruce.richardson@intel.com>
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

