Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8EFC54FB3
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 08:34:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DAFB0409FA;
	Mon, 26 May 2025 10:34:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id D695140653
 for <dev@dpdk.org>; Mon, 26 May 2025 10:34:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748248459; x=1779784459;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7m2AI1H/uRJbBkgVdWTElZlcxr98vrlUy+1FsQMYUS4=;
 b=b9GRRXK4WolvEJGJHqkuBTuPVZ1s6jvuBE631KQPuZ0Xt2a4iRthtPCu
 trwACasBjMmNJEAwe7mkyUj9PFm6876/44GAeTq++BgcZsgM4Edc1/WqY
 D5d+PI6WMYwPztLJ8PpxhVYL89SRB0QdGX2Qq9DjUBCGMjWy8kkAoKvVO
 rcQ8YM1hhFMcrU9gCyrq9aFOjEiL12JohvHw1AHb6z15+1QkM5ROF1U3r
 kQRBxdEZyyqfHbc96Kp/2myLhlnaLU6rsq4AiLZlVp0858FkpkWDgB1hr
 b5GFMyBBMQrdTEzZCHxZPHeVbCs3fvEerIm/BOSFmdkkiJx8GFfH2IO5R w==;
X-CSE-ConnectionGUID: L/GW4rN3SsOeWZLFZL2gjg==
X-CSE-MsgGUID: /HeYXJEYSlWaRP3RcdVjGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11444"; a="54009058"
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; d="scan'208";a="54009058"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2025 01:34:18 -0700
X-CSE-ConnectionGUID: nZ6tI8rgSy2xrhw4OWhpDw==
X-CSE-MsgGUID: M5dM9XOqRTKIXV1bL5F9Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; d="scan'208";a="142293617"
Received: from unknown (HELO silpixa00401120.ir.intel.com) ([10.55.128.58])
 by fmviesa007.fm.intel.com with ESMTP; 26 May 2025 01:34:17 -0700
From: Dhanya Pillai <dhanya.r.pillai@intel.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Janardhanan Arumugam <janardhanan.arumugam@intel.com>,
 Dhanya Pillai <dhanya.r.pillai@intel.com>
Subject: [PATCH 9/9] net/ice/base: increase reset timeout to 20 seconds
Date: Mon, 26 May 2025 08:33:11 +0000
Message-ID: <20250526083325.248384-10-dhanya.r.pillai@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250526083325.248384-1-dhanya.r.pillai@intel.com>
References: <20250526083325.248384-1-dhanya.r.pillai@intel.com>
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

From: Janardhanan Arumugam <janardhanan.arumugam@intel.com>

Resets on E830 hardware can take longer than 5 seconds to complete due
to E830 security keys functionality. The current timeout may be too
short, leading to reset failures.

Increase the reset timeout by updating ICE_PF_RESET_WAIT_COUNT, changing
the maximum wait time from 5 seconds to 20 seconds.

This change applies to all hardware, but since the driver polls the
reset done bits every 10 milliseconds this does not affect reset time on
non-E830 devices where the reset completes quicker.

Signed-off-by: Dhanya Pillai <dhanya.r.pillai@intel.com>
---
 drivers/net/intel/ice/base/ice_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/ice/base/ice_common.c b/drivers/net/intel/ice/base/ice_common.c
index 9ba656d8ec..4de9f37989 100644
--- a/drivers/net/intel/ice/base/ice_common.c
+++ b/drivers/net/intel/ice/base/ice_common.c
@@ -9,7 +9,7 @@
 #include "ice_ptp_hw.h"
 #include "ice_switch.h"
 
-#define ICE_PF_RESET_WAIT_COUNT	500
+#define ICE_PF_RESET_WAIT_COUNT	2000
 
 static const char * const ice_link_mode_str_low[] = {
 	ice_arr_elem_idx(0, "100BASE_TX"),
-- 
2.43.0

