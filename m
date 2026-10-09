Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058A2CA601D
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 11:00:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B185E40693;
	Fri,  9 Oct 2026 12:59:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id B675640684
 for <dev@dpdk.org>; Fri,  9 Oct 2026 12:59:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791543576; x=1823079576;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=yvymFa86vhQKPB3/rBU8Pff6j16E9UM/DAw/Jr8Dgms=;
 b=DsEaJEGLRiELDEw6YtXVp8QwUBaSJI9IAO7EMQ3/vBKIDIWt24vyYGs8
 UBcR9CkCVSKHc/YyUikwu8wUcR5d+BREmoHMMOqgFdV5vVK1hKtK/Cmp0
 2DEC7eBUs+Sbq1JFdSM7OBCf0plWo1qs5FEIG3OiPbctQ3qT4byffl94u
 JomdOBmHdFoFFREESSCPDWGXGveYnKZ3FARujywWhBY6F3V4nzd0+f6cS
 mgsq9vl5IL87k9JZGVqtGd64lPPLTec+6aPG1hlwiy4Wbp6r3eq9kHUNU
 7As5t4whjoDt54eXU9OJS0w3tUbidffQWZMINXM4t/wglXOB8lo3VV9wz w==;
X-CSE-ConnectionGUID: aaF+PfwmQ5C3lSaLWY9jKg==
X-CSE-MsgGUID: 1siu8em4RkCvKth8r8S4mQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="241405"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="241405"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 03:59:36 -0700
X-CSE-ConnectionGUID: vrpBIMomQvq2z98hAmr6Ww==
X-CSE-MsgGUID: KCpjg3AyQpqxSJWcbFv1Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="2088342"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa012.fm.intel.com with ESMTP; 09 Oct 2026 03:59:34 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Wenzhuo Lu <wenzhuo.lu@intel.com>, Wei Zhao <wei.zhao1@intel.com>,
 Beilei Xing <beilei.xing@intel.com>, Wei Dai <wei.dai@picocom.com>
Subject: [PATCH v6 08/25] net/ixgbe: fix syn filter priority
Date: Fri,  9 Oct 2026 11:58:58 +0100
Message-ID: <2507bf5e4a1451674e66bd487f8e9ae0b9d743f9.1791543154.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1791543153.git.anatoly.burakov@intel.com>
 <cover.1791543153.git.anatoly.burakov@intel.com>
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

In rte_flow API, 0 means highest priority. Fix SYN filter priority being
wrongly set to lower priority when API requests priority 0.

Fixes: 429f6ebb42cc ("net/ixgbe: parse TCP SYN filter")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_flow.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index a2b9403d3a1..6ba36a8b44a 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -804,10 +804,10 @@ cons_parse_syn_filter(const struct rte_flow_attr *attr, const struct rte_flow_it
 	filter->queue = q_act->index;
 
 	/* Support 2 priorities, the lowest or highest. */
-	if (!attr->priority) {
-		filter->hig_pri = 0;
-	} else if (attr->priority == (uint32_t)~0U) {
+	if (attr->priority == 0) {
 		filter->hig_pri = 1;
+	} else if (attr->priority == (uint32_t)~0U) {
+		filter->hig_pri = 0;
 	} else {
 		memset(filter, 0, sizeof(struct rte_eth_syn_filter));
 		rte_flow_error_set(error, EINVAL,
-- 
2.52.0

