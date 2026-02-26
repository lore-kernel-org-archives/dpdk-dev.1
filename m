Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069C8FCE087
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 13:59:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 833C440647;
	Thu, 26 Feb 2026 14:59:55 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 086F84021F
 for <dev@dpdk.org>; Thu, 26 Feb 2026 14:59:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772114392; x=1803650392;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=vtrykjg/860M0YEN/xt4KE0eACoK6FBHWu0XJ7Wv2Ew=;
 b=DglSAHNznBxwZdDOWONbhW2nyDwBiNWPwvsHssJl6VxzyxYcFddxnF3Z
 3YJnW1/TD0s8AuaClVrId4cirDXO9eJAxEMtAA8T3IpdNjb3kog+aTQDF
 8kXZMfJcWc9Xq1X9GXZH2B/7pee36MiGtiWrNnyJ75NdM7PSk/FRn+t2L
 q62ao4UeSDyzHSPH9cQQW4psFCVAqhrwJ/IiX12aRzuoe8x52YP0iB3s7
 NATodMXy81DdIMYebMrnzv/gO2llvsKP8vj9WUJIi8Qti8n9bPyyQM9+L
 LZbeouoJ0He4U7S/sCiz6v0Yf7H84+4DqizkC93xOLco2AkrhUmhMb4Gu A==;
X-CSE-ConnectionGUID: b7MAeJK1SsafhoQ4iitARg==
X-CSE-MsgGUID: jMIasoPNSb2i+emVliBXGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="73219059"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="73219059"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 05:59:51 -0800
X-CSE-ConnectionGUID: EE9I0cHZSzOFlqgL+KV6pg==
X-CSE-MsgGUID: v2DRyqoCRwq8Jp9WHYpLkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="216588100"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa008.jf.intel.com with ESMTP; 26 Feb 2026 05:59:51 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v2 1/2] doc: add deprecation notice for VFIO API
Date: Thu, 26 Feb 2026 13:59:47 +0000
Message-ID: <7afe68e70f330c54c68f81656f9c3271c4d5549d.1772114309.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1772114309.git.anatoly.burakov@intel.com>
 <cover.1772114309.git.anatoly.burakov@intel.com>
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

The entirety of VFIO API will be either made internal and only available to
drivers, or will be removed. Add upcoming changes to deprecation notices.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/rel_notes/deprecation.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index ac667e91a6..a94691daf6 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -139,3 +139,7 @@ Deprecation Notices
 * bus/vmbus: Starting DPDK 25.11, all the vmbus API defined in
   ``drivers/bus/vmbus/rte_bus_vmbus.h`` will become internal to DPDK.
   Those API functions are used internally by DPDK core and netvsc PMD.
+
+* eal: The entire VFIO API (``rte_vfio_*``) will be made internal only, and will only be available to EAL and drivers.
+  Group-based API (``rte_vfio_*_group_*``) will be removed and replaced with unified container device assignment API.
+  This change will be made in 26.11 release.
-- 
2.47.3

