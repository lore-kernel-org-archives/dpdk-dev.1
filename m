Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22319C5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 18:04:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA67A40B9C;
	Mon, 26 May 2025 20:03:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 7D57540BA6
 for <dev@dpdk.org>; Mon, 26 May 2025 20:03:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748282626; x=1779818626;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qM0wjugjOHdxCUMaBKqcskXmNxX0sOW/PumIGhQyR6I=;
 b=NGjMDMud260XNuaXJfYQWtbHe2NFGuM7rBO0gbheXgjCst4P9hV07xoN
 SInFIcWBed/ua/b57zMQN449GtXIWpIQON5NuZGKXimo304xNK05krW2u
 Hk2ogDN8/MYk6ou5aofN5jMJl3/d8ZwOC67RxI48n5dH+38jjZR1O3vcr
 NTFmcZFQNP19wl4/KztsTnE2CQz5UV+eZ1ScLSL+yGx6dwxFVrgOA9EUU
 qkdZRiU+3ohnmWDx4UEuYYWJJ9BcdypQH0gRZfBOhMoSH46HDQO689Hec
 V0Py3FJlnJ1BKZ3I4mGdupdG0oEgjyFekrfRuSGzHpl5y0EpwRQkX0apU w==;
X-CSE-ConnectionGUID: +cz2VpHBQwuvdMtD8PLSMA==
X-CSE-MsgGUID: J8dLFZNGSOmh0CMtUswcLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="50375191"
X-IronPort-AV: E=Sophos;i="6.15,316,1739865600"; d="scan'208";a="50375191"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2025 11:03:46 -0700
X-CSE-ConnectionGUID: FOd+AAY4S0O2F45kywbsWw==
X-CSE-MsgGUID: u7tEBH6oQgu2Skkn+f3mZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,316,1739865600"; d="scan'208";a="142478323"
Received: from unknown (HELO silpixa00401120.ir.intel.com) ([10.55.128.58])
 by fmviesa007.fm.intel.com with ESMTP; 26 May 2025 11:03:45 -0700
From: Dhanya Pillai <dhanya.r.pillai@intel.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Janardhanan Arumugam <janardhanan.arumugam@intel.com>,
 Dhanya Pillai <dhanya.r.pillai@intel.com>
Subject: [PATCH v2 09/10] net/ice/base: increase reset timeout to 20 seconds
Date: Mon, 26 May 2025 18:02:57 +0000
Message-ID: <20250526180311.4573-10-dhanya.r.pillai@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250526180311.4573-1-dhanya.r.pillai@intel.com>
References: <20250526180311.4573-1-dhanya.r.pillai@intel.com>
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

Signed-off-by: Janardhanan Arumugam <janardhanan.arumugam@intel.com>
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

