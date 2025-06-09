Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0B9C5B552
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 10:26:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F23CD40E3E;
	Mon,  9 Jun 2025 12:25:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 4E82040E2A
 for <dev@dpdk.org>; Mon,  9 Jun 2025 12:25:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749464750; x=1781000750;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=tTPwxg+Le2P1b8EGpPNsmqY7jKFSrjjwmltjIZB1uPo=;
 b=mjS8iBYiaMgvZ+ett+YQP3LfLhOtrdKETSIBYjCTVZZ269ub53nDhQjQ
 wsslGVeHjtfM++vwKKXS2a+lNgUTb8DQTbPAU2x2ekQ9ezw172ljYzJal
 KKuIlY5KNnArVh3IiEO3e02/4xM26dw3M/UiGTINskunjuU8AILgTq1sq
 2dNE3JMX07fUSMgNWINeiyP74oKWd4vcXfAK+sAOJC8+x6/L3c8QefXLP
 WPFfz8zg0/oUgyobRTcCGAwOtpO6kuEW1N/84S5WD1QwkcHREqRFxacKL
 w05BbSjKmNQxhWmlmvO+YBg4A2RqTgTxIGwYbogk/5dDaXZfgIpSdcaU4 w==;
X-CSE-ConnectionGUID: GUqRtPXmTm6VscHs3ytZwQ==
X-CSE-MsgGUID: zMDgmDwmRDqnfnddlR+Lng==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="51448516"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="51448516"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 03:25:50 -0700
X-CSE-ConnectionGUID: LBzudEk0TsapwdIlBliS4A==
X-CSE-MsgGUID: uzaPfGSRSUaS9OaiVNWRZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="146356457"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa006.fm.intel.com with ESMTP; 09 Jun 2025 03:25:49 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v1 5/5] net/ixgbe: update README
Date: Mon,  9 Jun 2025 11:25:38 +0100
Message-ID: <0c385c0e442fc0f875771e90fa293ce30bf9d377.1749464704.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1749464704.git.anatoly.burakov@intel.com>
References: 
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

Update readme with new base code snapshot update date.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/base/README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/ixgbe/base/README b/drivers/net/intel/ixgbe/base/README
index 8693c4ebc1..b48438f1db 100644
--- a/drivers/net/intel/ixgbe/base/README
+++ b/drivers/net/intel/ixgbe/base/README
@@ -6,7 +6,7 @@ Intel® IXGBE driver
 ===================
 
 This directory contains source code of ixgbe base driver generated on
-2024-12-20 released by the team which develops
+2025-06-04 released by the team which develops
 basic drivers for any ixgbe NIC. The sub-directory of base/
 contains the original source package.
 This driver is valid for the product(s) listed below
-- 
2.47.1

