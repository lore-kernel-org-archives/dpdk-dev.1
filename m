Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D883EC54ED1
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 13:18:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8AF2340DD6;
	Tue, 27 May 2025 15:18:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 13EBA40DC9
 for <dev@dpdk.org>; Tue, 27 May 2025 15:18:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748351883; x=1779887883;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qM0wjugjOHdxCUMaBKqcskXmNxX0sOW/PumIGhQyR6I=;
 b=UDmceUHrcK+LIZaaIPoskew5m3xNfEh7FSl2kGQglLe4xCB3L/tq2YFe
 guec6oAROpxxmLY0Ki14dsO0QYWZeyoEKOupvIZ5heVbIIveaL3+KvpSS
 EZ2h9wutfCcRpkDkhjs4q6LiC8sVAHyEcbfwj0mg7ADV0+AaZiX2aH7aD
 CNTFakN/3E87DyINFKZI7rZtej56u5FPg0jPTgf8AJlDxlGIGJ6OjMZJi
 I6BElOm2UM3PKwr+MrkJGo+2wHFY3h2cV3Ys3UDeaYwjBfNddtZGtZZKH
 Kw7WnEX+rXpJ1Gnyrm5kf5hGeEcKWNvhGo4KIpnb/TLdFfjyxmXW9EetX g==;
X-CSE-ConnectionGUID: rD6zelWTSpy3xSniWJgCUA==
X-CSE-MsgGUID: lIPncg9ITCauRUpTfalIxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="67884855"
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208";a="67884855"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 06:18:03 -0700
X-CSE-ConnectionGUID: rOcELZTGRTazYBnbnOvcFQ==
X-CSE-MsgGUID: TYyQ6NKkTq2zSZf7A6GA6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208";a="143150089"
Received: from unknown (HELO silpixa00401120.ir.intel.com) ([10.55.128.58])
 by fmviesa008.fm.intel.com with ESMTP; 27 May 2025 06:18:01 -0700
From: Dhanya Pillai <dhanya.r.pillai@intel.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Janardhanan Arumugam <janardhanan.arumugam@intel.com>,
 Dhanya Pillai <dhanya.r.pillai@intel.com>
Subject: [PATCH v3 09/10] net/ice/base: increase reset timeout to 20 seconds
Date: Tue, 27 May 2025 13:17:28 +0000
Message-ID: <20250527131741.7606-10-dhanya.r.pillai@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250527131741.7606-1-dhanya.r.pillai@intel.com>
References: <20250527131741.7606-1-dhanya.r.pillai@intel.com>
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

