Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94063EDB7CA
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 07:33:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B2E284025A;
	Tue,  7 Apr 2026 09:33:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 901A84014F
 for <dev@dpdk.org>; Tue,  7 Apr 2026 09:33:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775547184; x=1807083184;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=gwDqKUhQ0RvmUhHNuyCDTrp2EBihNZkRECjsnp41SU0=;
 b=XUrVLQrQ1J0MbD+xyyGcRCk95VU3++vKIzfdrQXYXNc35q1JdKe1tjYI
 RP2b1ek0TlZWplxcGgIqqvSxOP++oaBl6vyXmrZdxxl7ozPi5fClsnN+0
 xKdNTocxwCt5Cf0BGnlSZpI1H7L+vJGEe52wJbaC9KwWKqeqezV3La406
 HUDZWKu1Th6Ts+VLG+Guv2DXeK9SGCxHMh1GwhCDwDETGyudxbEhopDIu
 R2oJ5HtD++FjEIGUnKrlvEUoz1KshZDnw7F68LcvFMF+oQnTQfEDJ3DSX
 PUPIRX/XC2I4NVJ2GGSzmrr8uUp3l0QMsydch9F5LvJjEvRGue5wk5t/Z A==;
X-CSE-ConnectionGUID: FtcL9UfiSuKgWtJoHvjqwQ==
X-CSE-MsgGUID: fHGQB1dfQHCbQwR1rW9/Fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="64049902"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; d="scan'208";a="64049902"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2026 00:33:02 -0700
X-CSE-ConnectionGUID: uHdbWHpnQQqb37nC4vx3gg==
X-CSE-MsgGUID: syKpF4/VRH+ciwIRjG+K2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; d="scan'208";a="225346686"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by fmviesa008.fm.intel.com with ESMTP; 07 Apr 2026 00:33:00 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: bruce.richardson@intel.com, manoj.kumar.subbarao@intel.com,
 aman.deep.singh@intel.com, dev@dpdk.org, rajesh3.kumar@intel.com
Subject: [PATCH v2] net/idpf: harden PTP frequency adjustment
Date: Tue,  7 Apr 2026 16:04:05 -0400
Message-ID: <20260407200405.1568940-1-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260312184344.1475052-1-soumyadeep.hore@intel.com>
References: <20260312184344.1475052-1-soumyadeep.hore@intel.com>
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

Normalize ppm to an unsigned magnitude before using it in the
increment value scaling path.

This avoids negating INT64_MIN and also prevents subtracting 62
from the reduced log sum unless the sum is still above the
overflow threshold reported by Coverity.

Coverity issue: 501832

Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
---
v2:
-Addressed Bruce's comments
---
 drivers/net/intel/idpf/idpf_ethdev.c | 38 ++++------------------------
 1 file changed, 5 insertions(+), 33 deletions(-)

diff --git a/drivers/net/intel/idpf/idpf_ethdev.c b/drivers/net/intel/idpf/idpf_ethdev.c
index 5e57a45775..23a2af6332 100644
--- a/drivers/net/intel/idpf/idpf_ethdev.c
+++ b/drivers/net/intel/idpf/idpf_ethdev.c
@@ -1005,42 +1005,14 @@ idpf_timesync_adjust_freq(struct rte_eth_dev *dev, int64_t ppm)
 	struct idpf_vport *vport = dev->data->dev_private;
 	struct idpf_adapter *adapter = vport->adapter;
 	struct idpf_ptp *ptp = adapter->ptp;
-	int64_t incval, diff = 0;
-	bool negative = false;
-	uint64_t div, rem;
-	uint64_t divisor = 1000000ULL << 16;
-	int shift;
+	uint64_t incval;
+	__int128 diff;
 	int ret;
 
+	/* ppm is scaled by 2^16 to match Linux adjfine. */
 	incval = ptp->base_incval;
-
-	if (ppm < 0) {
-		negative = true;
-		ppm = -ppm;
-	}
-
-	/* can incval * ppm overflow ? */
-	if (rte_log2_u64(incval) + rte_log2_u64(ppm) > 62) {
-		rem = ppm % divisor;
-		div = ppm / divisor;
-		diff = div * incval;
-		ppm = rem;
-
-		shift = rte_log2_u64(incval) + rte_log2_u64(ppm) - 62;
-		if (shift > 0) {
-			/* drop precision */
-			ppm >>= shift;
-			divisor >>= shift;
-		}
-	}
-
-	if (divisor)
-		diff = diff + incval * ppm / divisor;
-
-	if (negative)
-		incval -= diff;
-	else
-		incval += diff;
+	diff = ((__int128)incval * ppm) / (1000000LL << 16);
+	incval += (int64_t)diff;
 
 	ret = idpf_ptp_adj_dev_clk_fine(adapter, incval);
 	if (ret) {
-- 
2.47.1

