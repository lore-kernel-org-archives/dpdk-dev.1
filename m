Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564E2C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 11:23:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C74F402DC;
	Thu, 15 May 2025 13:23:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 749BC40289
 for <dev@dpdk.org>; Thu, 15 May 2025 13:23:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747308235; x=1778844235;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=J83hA1HZCAQq2rwVCeb4NIa4Agb/fxUiajpSj9Yl5vs=;
 b=fqmUgIsdiiGL2DtLXMVWebUhrTHsz/qDE+opScfNW8CIoHKfol6TWwaZ
 YM01UEPJ05d9TyZZ9w3iirAoaQCOWzqrM2yz0+4YFMZgg1XQoQMzINmQ2
 xZkw7UBIOJDFWDtrLelt5C3TR3+U0I4DBLugrziOv5k/XQw08IhK+WlkZ
 ZMNlsI1Jc6TBByHLwLf8yns0hXGU3xL0ehvQfC01fU+w2chmpVFkU7qPi
 HJBXWzEVqoj5WO+5S2wCzYL8o2k7cwggq7IMlcynup5EsnAUpIH5Kt+C5
 ZEnRhuoWCiBKz0wyr9ya9usB9V72lh6qUaJLnttv5Q3xhFDMM0VKTfWRX g==;
X-CSE-ConnectionGUID: q9FNj2EMTjqoUg303G2YRA==
X-CSE-MsgGUID: 7QyK7t/uT4mZuPxHVidVvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="60574999"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; d="scan'208";a="60574999"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 04:23:54 -0700
X-CSE-ConnectionGUID: Uk4I4qjJSImaM/Bs1JFIlw==
X-CSE-MsgGUID: exXFndhpSMOhgp/xJ/EsXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; d="scan'208";a="169274423"
Received: from silpixa00401184.ir.intel.com (HELO
 silpixa00401184.ger.corp.intel.com) ([10.237.223.183])
 by orviesa002.jf.intel.com with ESMTP; 15 May 2025 04:23:53 -0700
From: Dhanya Pillai <dhanya.r.pillai@intel.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org,
	Dhanya Pillai <dhanya.r.pillai@intel.com>
Subject: [PATCH v2] net/ice: fix flow creation failure
Date: Thu, 15 May 2025 11:23:44 +0000
Message-ID: <20250515112348.7746-1-dhanya.r.pillai@intel.com>
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
 drivers/net/intel/ice/ice_fdir_filter.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
index 2ff0090aca..b11c8f170c 100644
--- a/drivers/net/intel/ice/ice_fdir_filter.c
+++ b/drivers/net/intel/ice/ice_fdir_filter.c
@@ -2446,7 +2446,7 @@ ice_fdir_parse(struct ice_adapter *ad,
 	       uint32_t array_len,
 	       const struct rte_flow_item pattern[],
 	       const struct rte_flow_action actions[],
-	       uint32_t priority,
+	       uint32_t priority __rte_unused,
 	       void **meta,
 	       struct rte_flow_error *error)
 {
@@ -2461,8 +2461,6 @@ ice_fdir_parse(struct ice_adapter *ad,
 	item = ice_search_pattern_match_item(ad, pattern, array, array_len,
 					     error);
 
-	if (priority >= 1)
-		return -rte_errno;
 
 	if (!item)
 		return -rte_errno;
-- 
2.43.0

