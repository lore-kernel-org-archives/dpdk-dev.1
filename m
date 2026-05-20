Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108AACD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 12:54:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BEEF940C35;
	Wed, 20 May 2026 14:53:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 952724067D
 for <dev@dpdk.org>; Wed, 20 May 2026 14:53:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779281605; x=1810817605;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+MYt6WgtpPNf842SiztvFHy/+KgIaFV4PUGNmTHji4M=;
 b=YQ/57c6V3q55eYFR5yDU6fm1jVCwmAXrRnFIQcKtE7XaJTj5Eyp0sSuY
 bwgEQXHjPhZ8xx+lQKe2YyrH/0p56GlG4ozTU8O+z6Qbw0jWsYrhRSdRw
 j5HzZV0+tcSNdsXIegA+75upXnmdDgjij8qyLRWjxzEuSoT3MuDeciTNn
 NIJewMwVXV522tle8bSw6eiOyy5CXcSRG8j1IUOVRThNIwCZsR2Xm2/VS
 eXeDrswjwddDEKfSsapFADt21RRnbuVwxFbgnNpglPPBrk+gyfDgV+Klc
 7UD7GIO1mdzF7FmU5YKqPqvAV0p5jAEkmUKbVxcw6g1QsNz5P4DmkCWW0 g==;
X-CSE-ConnectionGUID: ppu0stXNSEy6cXm0ka9iWw==
X-CSE-MsgGUID: Nl3zJCJxTsenVb8E7jnzow==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="91570290"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="91570290"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 05:53:25 -0700
X-CSE-ConnectionGUID: LX1ENJKZRaSmM+8SPO7G+Q==
X-CSE-MsgGUID: GB0sO2aFSNS5SAcolbLspg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="235908316"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa010.fm.intel.com with ESMTP; 20 May 2026 05:53:24 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 10/10] net/e1000/base: update version info
Date: Wed, 20 May 2026 12:52:47 +0000
Message-ID: <20260520125256.354336-11-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520125256.354336-1-ciara.loftus@intel.com>
References: <20260520125256.354336-1-ciara.loftus@intel.com>
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

Update the last shared code update date.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/e1000/base/README | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/e1000/base/README b/drivers/net/intel/e1000/base/README
index 976391b170..f0c1e4af48 100644
--- a/drivers/net/intel/e1000/base/README
+++ b/drivers/net/intel/e1000/base/README
@@ -1,9 +1,9 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2010-2025 Intel Corporation
+ * Copyright(c) 2010-2026 Intel Corporation
  */
 
 This directory contains source code of the base driver code for em/igb/igc,
-with this snapshot generated on 2025-06-04-14.40.
+with this snapshot generated on 2026-05-07-13.50.
 
 This driver is valid for the product(s) listed below
 * Intel® Ethernet Controller 82540
-- 
2.43.0

