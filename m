Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DE7CCD18E
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 08:45:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC21040611;
	Tue, 14 Oct 2025 10:45:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 559DB40288;
 Tue, 14 Oct 2025 10:45:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760431538; x=1791967538;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5XogHaTpdCnAS8GiSLjUZ1S0IeeBV5e3GTdgH9YpAxA=;
 b=lFJH1m8rs6iV2JAwsr/c3KN2SF48t2R/4ETu2UU4kGALYF/JCU5DE1j5
 ZN0o4z/pNXDRv4xTLSHuvQmbfYrzbdX910pZfx7duHBsOAyHuCXruEXHA
 qZLxxQMg+6CTyrtom3jOIGDp2+J0G/iHSGzi2yFVzhvz459qu4nERHJSp
 RY3yIyjKAsdBMSeAc2seeqG5A3C1iyO42iLNnklIVr+wqLcrpn+J2nwSs
 NHXyHwJBj/RzeqbT1KAEyHhRJ3JProZkm8S33DGCGUqhuCXuwts2ndcqm
 3QHfXwt8+rScX59g2+GOiAJD8xeNaycmjjO0j4UwfXr7WT6QFKbU93nun g==;
X-CSE-ConnectionGUID: XJfVMibESTizUmThkQJgag==
X-CSE-MsgGUID: kkZh8OloQmuMQJnEBtMSwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="61796249"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="61796249"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 01:45:37 -0700
X-CSE-ConnectionGUID: 0jM1SfpTSUeJ2z528jYV2Q==
X-CSE-MsgGUID: gCuLB8IDRlav9hjanGLl8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="181630647"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa007.jf.intel.com with ESMTP; 14 Oct 2025 01:45:36 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH 1/6] net/intel: fix Rx vector capability detection
Date: Tue, 14 Oct 2025 08:45:12 +0000
Message-Id: <20251014084517.1407407-2-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251014084517.1407407-1-ciara.loftus@intel.com>
References: <20251014084517.1407407-1-ciara.loftus@intel.com>
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

The common function for detecting whether an rxq could use a vector
rx path would automatically disqualify rx queues that had the
timestamp offload enabled. This was incorrect behaviour because the
iavf driver which uses this common function supports timestamp offload
on its vector paths. Fix this by removing the conditional check for
timestamp offload.

Fixes: 9eb60580d155 ("net/intel: extract common Rx vector criteria")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/common/rx.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/rx.h
index 741808f573..d3e4492ff1 100644
--- a/drivers/net/intel/common/rx.h
+++ b/drivers/net/intel/common/rx.h
@@ -235,9 +235,8 @@ ci_rxq_vec_capable(uint16_t nb_desc, uint16_t rx_free_thresh, uint64_t offloads)
 			(nb_desc % rx_free_thresh) != 0)
 		return false;
 
-	/* no driver supports timestamping or buffer split on vector path */
-	if ((offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP) ||
-			(offloads & RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT))
+	/* no driver supports buffer split on vector path */
+	if (offloads & RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT)
 		return false;
 
 	return true;
-- 
2.34.1

