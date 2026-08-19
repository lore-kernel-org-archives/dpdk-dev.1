Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40505C5DF86
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Aug 2026 11:39:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D182402BA;
	Wed, 19 Aug 2026 13:39:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 5AC7740041
 for <dev@dpdk.org>; Wed, 19 Aug 2026 13:39:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787139593; x=1818675593;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=RsrFPFVZnhJ48zOaPndhom7r91yPVU55BCeqDORGcHI=;
 b=nZ1bDc0yVgSw3lbS3CD47HMdKPKBDPKlQ2tde38zGs5eRPJGuv9qXXhQ
 +4JTi4lIToNLsfPQ8WicW0HrnXu7mnaJtShOBUWr8cg/rwGvKs1QWFP7P
 ASBoA8gI7OCOFgmXCrgKJ8A9pnIleMplswBhGW4XmKReHVUmTJ7IV+U3s
 zZ2f8fRXK6UATvsDGqBRZvfBPE3nhUQ1hzk3QjhXlyH8vUCD5mKQEWXgO
 V0IIRkkeCcSg7eh+WC2aWVM4myhNaQpe1ejKh2iKHviRj3rQu/cLoy6Vc
 INgc3hTSa2gRN6oxs5UNT/XcW+qTJGkrrTnb3uzYkGYx+M4tJov5f4vdt g==;
X-CSE-ConnectionGUID: pzvFxarMSdKgO04ZaMExFw==
X-CSE-MsgGUID: YrKP1udbSTGmJQNFu7A9Vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="110436325"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="110436325"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 04:39:52 -0700
X-CSE-ConnectionGUID: 0qpbqZoOSI6zAgTCGpxheA==
X-CSE-MsgGUID: V0DA15uGTjW8q1PPrhmT9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="262899933"
Received: from unknown (HELO localhost.localdomain.iind.intel.com)
 ([10.49.105.104])
 by fmviesa008.fm.intel.com with ESMTP; 19 Aug 2026 04:39:50 -0700
From: sandeep.penigalapati@intel.com
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Subject: [PATCH] net/ice/base: add missing devices to supported products
Date: Wed, 19 Aug 2026 14:41:47 -0400
Message-Id: <20260819184147.254069-1-sandeep.penigalapati@intel.com>
X-Mailer: git-send-email 2.27.0
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

From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>

The ice base driver already supports the E822, E823, E825 and E835
controllers. Add them to the list of supported products in the README.

Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
---
 drivers/net/intel/ice/base/README | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/intel/ice/base/README b/drivers/net/intel/ice/base/README
index 1f6b53c4c2..ca82e1ec86 100644
--- a/drivers/net/intel/ice/base/README
+++ b/drivers/net/intel/ice/base/README
@@ -12,7 +12,11 @@ original source package.
 This driver is valid for the product(s) listed below
 
 * Intel® Ethernet Network Adapters E810
+* Intel® Ethernet Network Adapters E822
+* Intel® Ethernet Network Adapters E823
+* Intel® Ethernet Network Adapters E825
 * Intel® Ethernet Network Adapters E830
+* Intel® Ethernet Network Adapters E835
 
 Updating the driver
 ===================
-- 
2.27.0

