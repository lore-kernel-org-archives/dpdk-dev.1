Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95263EDF023
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 09:11:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24D9940695;
	Fri, 13 Feb 2026 10:10:40 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 7265B40678
 for <dev@dpdk.org>; Fri, 13 Feb 2026 10:10:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770973838; x=1802509838;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=uPE33KVplWCde1icdrjFxNtpLc/I37yxXvzHVuzaT3g=;
 b=a1AUfn/ZmPtwqb3yBJGB80brmqBssp5TwoHUqgUoJWcRNukNo4vX8naf
 5YnHHwx1FNnArXz4SZ2ERBv8einqvoQOcmpq5NlXHfaRVlvMJ9JSrislu
 EKDXhJOTlY+F4K4ZHkb6ofch+bBE5tsLv46pfY53heQfHRtOxUTV4RhMi
 SrSAR4RlQEciufiC60U4dj1UPlXF//8MBYcMKOLShK5Xtn0ZGg710QJAk
 NDhm9+ZXzzjnTbfaXHjQmcbe1UEGZTpQqvo8XraWXWfJBboGWVj1nkzzu
 34Hq1/P5nZYq1d55dBmFb9SLjmAwcvFwzTaFULpIqziEfAUfNDv9l1kIz A==;
X-CSE-ConnectionGUID: GzyNdXkHRISzoLmw/44rRg==
X-CSE-MsgGUID: 2hoCGUpnQMW+9cYinr1KHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="89567893"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="89567893"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 01:10:37 -0800
X-CSE-ConnectionGUID: PpO91kEIRa2DPfh8LXbEYw==
X-CSE-MsgGUID: sHNv0rAbRKOb04wxC7mALg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="211966100"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa006.jf.intel.com with ESMTP; 13 Feb 2026 01:10:36 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Qi Zhang <qi.z.zhang@intel.com>, Jie Wang <jie1x.wang@intel.com>
Subject: [PATCH v6 10/12] net/iavf: fix IPv4 flow subscription
Date: Fri, 13 Feb 2026 09:10:12 +0000
Message-ID: <cf659545e392dd511624ca7adcd2a7793b208ab4.1770973745.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770973745.git.anatoly.burakov@intel.com>
 <cover.1770973745.git.anatoly.burakov@intel.com>
References: 
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

Currently, when IPv4 is parsed as part of flow subscription input set, we
add two bytes to the total number of bytes in the input set for IPv4 source
or destination addresses, whereas they should be 4 bytes. Fix to add the
correct number of bytes.

Fixes: 6d42380e5983 ("net/iavf: add flow subscrption supported pattern")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 drivers/net/intel/iavf/iavf_fsub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_fsub.c b/drivers/net/intel/iavf/iavf_fsub.c
index 18df9c6500..cf1030320f 100644
--- a/drivers/net/intel/iavf/iavf_fsub.c
+++ b/drivers/net/intel/iavf/iavf_fsub.c
@@ -314,11 +314,11 @@ iavf_fsub_parse_pattern(const struct rte_flow_item pattern[],
 
 				if (ipv4_mask->hdr.src_addr) {
 					*input |= IAVF_INSET_IPV4_SRC;
-					input_set_byte += 2;
+					input_set_byte += 4;
 				}
 				if (ipv4_mask->hdr.dst_addr) {
 					*input |= IAVF_INSET_IPV4_DST;
-					input_set_byte += 2;
+					input_set_byte += 4;
 				}
 				if (ipv4_mask->hdr.time_to_live) {
 					*input |= IAVF_INSET_IPV4_TTL;
-- 
2.47.3

