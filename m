Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5825AFED2F8
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 09:45:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8121040430;
	Thu, 12 Mar 2026 10:45:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id BBF6B402E0
 for <dev@dpdk.org>; Thu, 12 Mar 2026 10:45:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773308704; x=1804844704;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=jqzDf4K2aHA0TgA2gfGmq79RGti7yssM7u/1kj8Jw4k=;
 b=CvyHeLKMwlbAGzw9Jt9xgJHqi6h3CPCqbg2nZOX8bVfXk1vQglCxvY3k
 6Hq1CY4SiSW2MqB8vQmf8DVvyB26OygjFQGem6AnsaQZIEnRoWV5C0SdQ
 5EvbOAfG+P0LB20kr3hgLVTShYBGaXsyTDMUZPNakPix4Z3zsBoRe/K3i
 RBptjd4Z4iq91bYZJqkDMsrz2uBh6xVTtc2JDK/HqZSdkMV4c01T8wVdz
 VZjoZgjK+rhkUhz+g9KH7TFOFI5B6pOHPQEskp1NfZkI4gwf+U/vnvfR3
 34xPxYCL8IYxagFvYU/ZwHj2inyZXFaKY+o3BNuLk5PijXVGpyd1tof4k A==;
X-CSE-ConnectionGUID: PHCYZRKHTPapy8q9gkYngA==
X-CSE-MsgGUID: gdKWhSzWTQGfGw8Hu621pA==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="74435536"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; d="scan'208";a="74435536"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2026 02:45:03 -0700
X-CSE-ConnectionGUID: rrp4Eq3WRc+deZmogGExuQ==
X-CSE-MsgGUID: JzyIDk3yT3OKof56bF+wAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; d="scan'208";a="225217851"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by orviesa004.jf.intel.com with ESMTP; 12 Mar 2026 02:45:00 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: bruce.richardson@intel.com, manoj.kumar.subbarao@intel.com,
 aman.deep.singh@intel.com, dev@dpdk.org, rajesh3.kumar@intel.com
Subject: [PATCH v1] net/i40e: remove dead ENOENT assignment
Date: Thu, 12 Mar 2026 18:19:26 -0400
Message-ID: <20260312221926.1476679-1-soumyadeep.hore@intel.com>
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

Ignore ENOENT from firmware without rewriting the return value.

The previous code assigned I40E_SUCCESS to ret in the ENOENT case,
but that value was never consumed before the next iteration or the
function return path.

Replace the positive ENOENT branch with a negative check so the
control flow stays the same without the unused assignment.

Coverity issue: 501831

Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index b891215191..5381071df2 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -7273,9 +7273,7 @@ i40e_remove_macvlan_filters(struct i40e_vsi *vsi,
 
 		if (ret != I40E_SUCCESS) {
 			/* Do not report as an error when firmware returns ENOENT */
-			if (aq_status == I40E_AQ_RC_ENOENT) {
-				ret = I40E_SUCCESS;
-			} else {
+			if (aq_status != I40E_AQ_RC_ENOENT) {
 				PMD_DRV_LOG(ERR, "Failed to remove macvlan filter");
 				goto DONE;
 			}
-- 
2.47.1

