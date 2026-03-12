Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2850FED2D7
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 06:09:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A486E40430;
	Thu, 12 Mar 2026 07:09:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id ABFD6402E0
 for <dev@dpdk.org>; Thu, 12 Mar 2026 07:09:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773295763; x=1804831763;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=seEzupPuTA0KK5QNh+utGS+rHmIZmedQb/F4UCTdbOI=;
 b=Qa7efuD8nrtlrIod+p1mSwbFEZxNFzUy5gjcNdh8uNaBSYkLGJ/4DJdw
 r5+sEW+n32xxkm7l6QmELwqa723aYFjtNIHLED6zGjJfFt/de+Re99fvQ
 9arHvbmEXcWe56j3Nb7a15zX66nWiYV00aXymAbXB0a1q6I+7WseYpDBO
 Ev3VfbJ2ycDC+PbmqCWR7uIkOItB8mHbUxHCIMcDYmMjmcwfo0shvX8AC
 yYDzGIf7DNrN+9cI6cdfuokDQKOdMh5dSQTLnumnPb/mqVZJztu+SK2Pm
 4GV0TEGsk+F2klbDnY3KIq2SZ1lmUtl267Z97pfbo8ELu+/i66n5WNGzF Q==;
X-CSE-ConnectionGUID: Wi4kefn8TsigGzEFbl/oSA==
X-CSE-MsgGUID: JexdKvCITq+b0vuCfpawYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="78269315"
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; d="scan'208";a="78269315"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2026 23:09:21 -0700
X-CSE-ConnectionGUID: IzljeDknRmqeSscmZCMuGQ==
X-CSE-MsgGUID: Kjjr66u7Qm6xpeYKqzdMNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; d="scan'208";a="225677762"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by orviesa005.jf.intel.com with ESMTP; 11 Mar 2026 23:09:19 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: bruce.richardson@intel.com, manoj.kumar.subbarao@intel.com,
 aman.deep.singh@intel.com, dev@dpdk.org, rajesh3.kumar@intel.com
Subject: [PATCH v1] net/idpf: harden PTP frequency adjustment
Date: Thu, 12 Mar 2026 14:43:44 -0400
Message-ID: <20260312184344.1475052-1-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
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
 drivers/net/intel/idpf/idpf_ethdev.c | 32 +++++++++++++++++-----------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/net/intel/idpf/idpf_ethdev.c b/drivers/net/intel/idpf/idpf_ethdev.c
index 5e57a45775..1c5bd2ee12 100644
--- a/drivers/net/intel/idpf/idpf_ethdev.c
+++ b/drivers/net/intel/idpf/idpf_ethdev.c
@@ -1007,7 +1007,7 @@ idpf_timesync_adjust_freq(struct rte_eth_dev *dev, int64_t ppm)
 	struct idpf_ptp *ptp = adapter->ptp;
 	int64_t incval, diff = 0;
 	bool negative = false;
-	uint64_t div, rem;
+	uint64_t abs_ppm, div, rem;
 	uint64_t divisor = 1000000ULL << 16;
 	int shift;
 	int ret;
@@ -1016,26 +1016,34 @@ idpf_timesync_adjust_freq(struct rte_eth_dev *dev, int64_t ppm)
 
 	if (ppm < 0) {
 		negative = true;
-		ppm = -ppm;
+		abs_ppm = ppm == INT64_MIN ? (uint64_t)INT64_MAX + 1 :
+			(uint64_t)(-ppm);
+	} else {
+		abs_ppm = (uint64_t)ppm;
 	}
 
 	/* can incval * ppm overflow ? */
-	if (rte_log2_u64(incval) + rte_log2_u64(ppm) > 62) {
-		rem = ppm % divisor;
-		div = ppm / divisor;
+	if (rte_log2_u64(incval) + rte_log2_u64(abs_ppm) > 62) {
+		rem = abs_ppm % divisor;
+		div = abs_ppm / divisor;
 		diff = div * incval;
-		ppm = rem;
+		abs_ppm = rem;
+
+		if (abs_ppm != 0) {
+			uint32_t log_sum;
 
-		shift = rte_log2_u64(incval) + rte_log2_u64(ppm) - 62;
-		if (shift > 0) {
-			/* drop precision */
-			ppm >>= shift;
-			divisor >>= shift;
+			log_sum = rte_log2_u64(incval) + rte_log2_u64(abs_ppm);
+			if (log_sum > 62) {
+				shift = log_sum - 62;
+				/* drop precision */
+				abs_ppm >>= shift;
+				divisor >>= shift;
+			}
 		}
 	}
 
 	if (divisor)
-		diff = diff + incval * ppm / divisor;
+		diff = diff + incval * abs_ppm / divisor;
 
 	if (negative)
 		incval -= diff;
-- 
2.47.1

