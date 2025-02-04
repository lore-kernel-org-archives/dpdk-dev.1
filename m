Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2462C02196
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:14:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF69F427D4;
	Tue,  4 Feb 2025 16:12:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 59B2D4111B
 for <dev@dpdk.org>; Tue,  4 Feb 2025 16:11:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681916; x=1770217916;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wJVCXPfLIEKWLr792mInal2afgOHMm9zFSw+TJTXRVo=;
 b=dEqA4VwN/cLyNOtdQk6GdGbOoEOr0sfhiNyw3SaB9n6XfYAio1JFDMJl
 AwwGYj7QxeIwPSZ8yo1q9oD8b+erdvJ4qQ6mC6dkNRNObrQ/elJU1r3mn
 QLXPzMkzG5srd/cPjWaYagv9ogtU++lKysbbqDDeY9/1HE5TjlUGY0Kk+
 Mx7/ptUMi8aojBBx4Y2KCix93kudfiQdsGNPnC/dtN3OaibdJPkVClrTi
 JrQRDIhnZCh8UuQIzkeceR8q1sl3u/phAF7fXNhc8YYrBQwQOC32wLX56
 NpkGYTKco+LovfSxSCBKE3h3W2xK1t90BpddaPKfuhkES9sWRqiVd6a53 w==;
X-CSE-ConnectionGUID: P5m5FoBwS8iyjXvxR0qx1w==
X-CSE-MsgGUID: 9iRp17KUT8KQ7mT0vmh1tw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097130"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097130"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:11:55 -0800
X-CSE-ConnectionGUID: lFqHGMKhS5e8pZkfkCZ5eA==
X-CSE-MsgGUID: dnwuekrXSHuFHIj1KN485A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792664"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:11:54 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v2 22/54] net/e1000/base: fix typo in LTR calculation
Date: Tue,  4 Feb 2025 15:10:28 +0000
Message-ID: <5c15dc7fa1e6d2e93de91420884dc1af8b1ac535.1738681726.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738681725.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738681725.git.anatoly.burakov@intel.com>
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

The LTR maximum value was incorrectly written using the scale from the
LTR minimum value. This would cause incorrect values to be sent, in cases
where the initial calculation lead to different min/max scales. Fix the
typo to correctly calculate the LTR maximum value.

Signed-off-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_i225.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/e1000/base/e1000_i225.c b/drivers/net/intel/e1000/base/e1000_i225.c
index 0b029c0ac2..611f3e8408 100644
--- a/drivers/net/intel/e1000/base/e1000_i225.c
+++ b/drivers/net/intel/e1000/base/e1000_i225.c
@@ -997,7 +997,7 @@ static s32 e1000_set_ltr_i225(struct e1000_hw *hw, bool link)
 		ltrv = E1000_READ_REG(hw, E1000_LTRMAXV);
 		if (ltr_max != (ltrv & E1000_LTRMAXV_LTRV_MASK)) {
 			ltrv = E1000_LTRMAXV_LSNP_REQ | ltr_max |
-			      (scale_min << E1000_LTRMAXV_SCALE_SHIFT);
+			      (scale_max << E1000_LTRMAXV_SCALE_SHIFT);
 			E1000_WRITE_REG(hw, E1000_LTRMAXV, ltrv);
 		}
 	}
-- 
2.43.5

