Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FB8C54FB3
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 18:04:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6960B40BA4;
	Mon, 26 May 2025 20:03:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id AEFC040668
 for <dev@dpdk.org>; Mon, 26 May 2025 20:03:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748282628; x=1779818628;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=blR/gFqalweGMeCcjOmbeDN+wFh2qI8J8PeH5CLmZtw=;
 b=YWT3CX0nbHsOCVeA4Ux26WVKHjFw8qD5ZzR0tjdnQ9goI56QloDURmSx
 mgzLLETKUsH9Lc18SdYPnYe5WOo97UsggSDaxg7rkuleYmmKIdDmQBeLR
 0joA6pqtSIV3XoRWEg4umBmLl8uaeo5c4t2sSO4QsMkSqw4mFKFvuzEqW
 vxR7D0c1USZ5mzSGO+0I07ZIDp6E0uGKQ1ahgt6inyNVgPBVbhQA4XL4T
 zp+D9D+f+GoVHsb/PlBqexvr22/ua39/mFGn259mXcFFgBVUTxNvnSTgp
 7SApYZGk4uPxodgLuwzLywYGCu3wzzDCstQZC25GT7HyOMzCG2jaQexrJ Q==;
X-CSE-ConnectionGUID: NQt46v6dRpqiQOqmxfx6UA==
X-CSE-MsgGUID: NeP1CkIuRVGDb5m66K9nQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="50375193"
X-IronPort-AV: E=Sophos;i="6.15,316,1739865600"; d="scan'208";a="50375193"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2025 11:03:47 -0700
X-CSE-ConnectionGUID: leduEiR4RruEvIhAXkWyuA==
X-CSE-MsgGUID: MfhRDRWhTCCNPtH4PN3FSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,316,1739865600"; d="scan'208";a="142478326"
Received: from unknown (HELO silpixa00401120.ir.intel.com) ([10.55.128.58])
 by fmviesa007.fm.intel.com with ESMTP; 26 May 2025 11:03:46 -0700
From: Dhanya Pillai <dhanya.r.pillai@intel.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org,
	Dhanya Pillai <dhanya.r.pillai@intel.com>
Subject: [PATCH v2 10/10] net/ice/base: update version info
Date: Mon, 26 May 2025 18:02:58 +0000
Message-ID: <20250526180311.4573-11-dhanya.r.pillai@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250526180311.4573-1-dhanya.r.pillai@intel.com>
References: <20250526180311.4573-1-dhanya.r.pillai@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Update the README file with the date of that latest base code snapshot.

Signed-off-by: Dhanya Pillai <dhanya.r.pillai@intel.com>
---
 drivers/net/intel/ice/base/README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/ice/base/README b/drivers/net/intel/ice/base/README
index c32e530789..86f69d1d04 100644
--- a/drivers/net/intel/ice/base/README
+++ b/drivers/net/intel/ice/base/README
@@ -6,7 +6,7 @@ Intel® ICE driver
 ==================
 
 This directory contains source code of ice base driver generated on
-2024-10-11 released by the team which develops
+2025-05-23 released by the team which develops
 basic drivers for any ice NIC. The directory of base/ contains the
 original source package.
 This driver is valid for the product(s) listed below
-- 
2.43.0

