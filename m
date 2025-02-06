Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B90DC02194
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 16:09:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E3ECC41060;
	Thu,  6 Feb 2025 17:09:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id BCA4C40EDC
 for <dev@dpdk.org>; Thu,  6 Feb 2025 17:09:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738858153; x=1770394153;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=eLTCxsCVs1b5VTG/aDOFFmVO4vQFPlMQUHDjvha0QGU=;
 b=T0EeWZMsHpwvhnmn3twkF5j6bcK/JxzQhs5rtdgbg4oKr4YusFcoSdzB
 MybuBJ3EYxclU+UPlgeRbtO9pMNHI2toRbqIPjK5hKAPBSaH2sbBbZlEi
 F30vs8yB27MHUriERa40IZBTbpqvipZD8fcs6qeYr1JFzjplutGguxy0M
 CaBSknu05EwGqK8bkfMoW9hjCBq7fKImeDg6s3/IXX4s0u/7yVxIZ+E1a
 No+QoY8ef2KEkvjpkiG7WOEduVLLzBbMVN8ZhJdpS6HuQst+zNMnntN2q
 HedmDWTL8ZyIr4xR13c5YKBnEih5h+9CgJNJe8xAEVQKtHcfY7mNB4R2t g==;
X-CSE-ConnectionGUID: qZ3v2atjSZyARu9bVn+yxQ==
X-CSE-MsgGUID: KgPvH+IvQHm27jcx4wzDHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50860723"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="50860723"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2025 08:09:12 -0800
X-CSE-ConnectionGUID: bbWwVAxyS9GJ7L0Zen2Y2g==
X-CSE-MsgGUID: 5EZsp4iKQ0ScZBTrqUmXNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="111166732"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa007.fm.intel.com with ESMTP; 06 Feb 2025 08:09:10 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Ferruh Yigit <ferruh.yigit@intel.com>,
 Alvin Zhang <alvinx.zhang@intel.com>
Subject: [PATCH v1 08/24] net/igc/base: fix unused value
Date: Thu,  6 Feb 2025 16:08:31 +0000
Message-ID: <107cc06be82c038a1d340d4b4ebfe52d2674e607.1738858026.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738858026.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738858026.git.anatoly.burakov@intel.com>
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

From: Dima Ruinskiy <dima.ruinskiy@intel.com>

Static analysis has reported that when there is no get link status callback
function, the value set in the if condition is not used and gets
overwritten in the "out" section of the code. Fix by not seting the
variable.

Fixes: 8cb7c57d9b3c ("net/igc: support device initialization")
Cc: stable@dpdk.org

Signed-off-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/igc/base/igc_i225.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/intel/igc/base/igc_i225.c b/drivers/net/intel/igc/base/igc_i225.c
index c7c2ec8ffe..23c68a3948 100644
--- a/drivers/net/intel/igc/base/igc_i225.c
+++ b/drivers/net/intel/igc/base/igc_i225.c
@@ -1114,10 +1114,8 @@ s32 igc_check_for_link_i225(struct igc_hw *hw)
 	 * changed.  The get_link_status flag is set upon receiving
 	 * a Link Status Change or Rx Sequence Error interrupt.
 	 */
-	if (!mac->get_link_status) {
-		ret_val = IGC_SUCCESS;
+	if (!mac->get_link_status)
 		goto out;
-	}
 
 	/* First we want to see if the MII Status Register reports
 	 * link.  If so, then we want to get the current speed/duplex
-- 
2.43.5

