Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1E3CD3424
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 08:07:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 99E804028B;
	Wed,  6 May 2026 10:07:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id CC21C4028B
 for <dev@dpdk.org>; Wed,  6 May 2026 10:07:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778054839; x=1809590839;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=077DInSFvft6POgrC0CvForrYfXrAPYPl96i7wvslis=;
 b=OoGcLGmtARk/YoLOe0Ka0YA4/uM6MBIw2bME6wU0A1RZold/F5BY9EOR
 VjzVZDBVGXIkB4pcEj8mBAcaiyKESAMmMc9ymT5fI9IP38dtB1FWZi5Eu
 dPQYHLleWt3Vm/rZDDeSuVJcY2wVNHj3mF0+02lR7HOixuqILSPQt+Tv/
 DumLwA93+tFQWBbYfddvEe4c3DmZWGEnlvk+HY3jG9Hapc9aahObGerho
 /hnh0M2jYioybf61W1ElzO7ut1+56yF8Em+1imuUXtnky+4HFrhrpzH3K
 G9acDlmdPamhiNZWZx6w7s5tnW2JhBj/GG9HGquKMf0nd5usxrws07jKV Q==;
X-CSE-ConnectionGUID: MbwJc3aJSdCr7eUcgJW1AQ==
X-CSE-MsgGUID: 8FZHIK00TtKEJ5hiG+Tvlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="82845785"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; d="scan'208";a="82845785"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2026 01:07:17 -0700
X-CSE-ConnectionGUID: /klrGMGeS/mjzki2mLuA8Q==
X-CSE-MsgGUID: 8Kgvx2ONQ3eoeGVbj7ZLJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; d="scan'208";a="240056130"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by orviesa003.jf.intel.com with ESMTP; 06 May 2026 01:07:15 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: bruce.richardson@intel.com, manoj.kumar.subbarao@intel.com,
 aman.deep.singh@intel.com, dev@dpdk.org, rajesh3.kumar@intel.com
Subject: [PATCH v3] net/idpf: harden PTP frequency adjustment
Date: Wed,  6 May 2026 16:41:33 -0400
Message-ID: <20260506204134.18634-1-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260407200405.1568940-1-soumyadeep.hore@intel.com>
References: <20260407200405.1568940-1-soumyadeep.hore@intel.com>
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

Use the direct __int128 calculation on 64-bit builds to keep the
frequency adjustment path short and readable, while preserving the
portable split-and-scale calculation on 32-bit builds where __int128
may be unavailable.

Both paths avoid the INT64_MIN negation issue in the original code.

Coverity issue: 501832

Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
---
v3:
- Fixed build failure for 32 bit systems
---
v2:
- Addressed Bruce's comments
---
 drivers/net/intel/idpf/idpf_ethdev.c | 78 ++++++++++++++++++----------
 1 file changed, 50 insertions(+), 28 deletions(-)

diff --git a/drivers/net/intel/idpf/idpf_ethdev.c b/drivers/net/intel/idpf/idpf_ethdev.c
index 5e57a45775..31291379d3 100644
--- a/drivers/net/intel/idpf/idpf_ethdev.c
+++ b/drivers/net/intel/idpf/idpf_ethdev.c
@@ -1005,42 +1005,64 @@ idpf_timesync_adjust_freq(struct rte_eth_dev *dev, int64_t ppm)
 	struct idpf_vport *vport = dev->data->dev_private;
 	struct idpf_adapter *adapter = vport->adapter;
 	struct idpf_ptp *ptp = adapter->ptp;
-	int64_t incval, diff = 0;
-	bool negative = false;
-	uint64_t div, rem;
-	uint64_t divisor = 1000000ULL << 16;
-	int shift;
+	uint64_t incval;
 	int ret;
 
 	incval = ptp->base_incval;
 
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
+#ifdef RTE_ARCH_64
+	/* ppm is scaled by 2^16 to match Linux adjfine. */
+	{
+		__int128 diff;
+
+		diff = ((__int128)incval * ppm) / (1000000LL << 16);
+		incval += (int64_t)diff;
+	}
+#else
+	{
+		int64_t diff = 0;
+		bool negative = false;
+		uint64_t abs_ppm, div, rem;
+		uint64_t divisor = 1000000ULL << 16;
+		int shift;
+
+		if (ppm < 0) {
+			negative = true;
+			abs_ppm = ppm == INT64_MIN ? (uint64_t)INT64_MAX + 1 :
+				(uint64_t)(-ppm);
+		} else {
+			abs_ppm = (uint64_t)ppm;
+		}
 
-		shift = rte_log2_u64(incval) + rte_log2_u64(ppm) - 62;
-		if (shift > 0) {
-			/* drop precision */
-			ppm >>= shift;
-			divisor >>= shift;
+		/* can incval * ppm overflow ? */
+		if (rte_log2_u64(incval) + rte_log2_u64(abs_ppm) > 62) {
+			rem = abs_ppm % divisor;
+			div = abs_ppm / divisor;
+			diff = div * incval;
+			abs_ppm = rem;
+
+			if (abs_ppm != 0) {
+				uint32_t log_sum;
+
+				log_sum = rte_log2_u64(incval) + rte_log2_u64(abs_ppm);
+				if (log_sum > 62) {
+					shift = log_sum - 62;
+					/* drop precision */
+					abs_ppm >>= shift;
+					divisor >>= shift;
+				}
+			}
 		}
-	}
 
-	if (divisor)
-		diff = diff + incval * ppm / divisor;
+		if (divisor)
+			diff += incval * abs_ppm / divisor;
 
-	if (negative)
-		incval -= diff;
-	else
-		incval += diff;
+		if (negative)
+			incval -= diff;
+		else
+			incval += diff;
+	}
+#endif
 
 	ret = idpf_ptp_adj_dev_clk_fine(adapter, incval);
 	if (ret) {
-- 
2.47.1

