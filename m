Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33316C3ABD8
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 May 2025 18:15:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CFF1C402DC;
	Wed, 14 May 2025 20:15:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id E5A54402C8
 for <dev@dpdk.org>; Wed, 14 May 2025 20:15:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747246541; x=1778782541;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=jEFN70iuF0Jn7Okf3QkK1j0ctxQMzUEZrJPzDBCWyKo=;
 b=QhFnP2fY07S4SY8RXuzytfMOjAnvKa8sCGWGpP7rNN93wm7UaFBYuGiA
 ihyi13vVWv2G1h1kXzYFGBlBIzgJzd66vhB+75x+J5g4BiyREmO2n2jKc
 Gwc9olqYhjFjOpZpWsYxTXFRxIiJHXR87+oPcSAkfJIIwlJD9eQgM1aDE
 ddPcweIBpz/qUutYDS3h4JLkgqXE8JjfKkh8ygxvSYttMNkKPfliHaKMw
 8tOebmPUSFKe2mMKKljOprUEwNmWL7qu4sn6KzIEaJ5zp0TIk7cVD7mrF
 PX+1DoFQdsz+sqAIZjmpCziCEykG9/2SBFzVP+UV2hT/uQE7mzl15jjYo A==;
X-CSE-ConnectionGUID: NBZzCQmVTa2RYF8YzRtutg==
X-CSE-MsgGUID: MT4WJkc2QuKMpOOBybi4Ag==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="71666545"
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; d="scan'208";a="71666545"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2025 11:15:39 -0700
X-CSE-ConnectionGUID: EfKNLC5QQ0SbE88vBLWCJw==
X-CSE-MsgGUID: knnu3uqWTr+DUOzS2FIRjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; d="scan'208";a="143078008"
Received: from silpixa00401184.ir.intel.com (HELO
 silpixa00401184.ger.corp.intel.com) ([10.237.223.183])
 by orviesa004.jf.intel.com with ESMTP; 14 May 2025 11:15:38 -0700
From: Dhanya Pillai <dhanya.r.pillai@intel.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org,
	Dhanya Pillai <dhanya.r.pillai@intel.com>
Subject: [PATCH] net/ice: fix flow creation failure
Date: Wed, 14 May 2025 18:15:26 +0000
Message-ID: <20250514181530.5385-1-dhanya.r.pillai@intel.com>
X-Mailer: git-send-email 2.43.0
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

In non-pipeline mode, priority is ignored, a flow rule can be created
as a flow director rule or a switch rule depends on its pattern/action.
Hence removing the priority field check from ice_fdir_parse which is
causing valid flow creation to return failure.

Signed-off-by: Dhanya Pillai <dhanya.r.pillai@intel.com>
---
 drivers/net/intel/ice/ice_fdir_filter.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
index 2ff0090aca..d71d14b013 100644
--- a/drivers/net/intel/ice/ice_fdir_filter.c
+++ b/drivers/net/intel/ice/ice_fdir_filter.c
@@ -2456,13 +2456,12 @@ ice_fdir_parse(struct ice_adapter *ad,
 	uint64_t input_set;
 	bool raw = false;
 	int ret;
+	(void)priority;
 
 	memset(filter, 0, sizeof(*filter));
 	item = ice_search_pattern_match_item(ad, pattern, array, array_len,
 					     error);
 
-	if (priority >= 1)
-		return -rte_errno;
 
 	if (!item)
 		return -rte_errno;
-- 
2.43.0

