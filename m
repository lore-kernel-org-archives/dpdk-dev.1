Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3576CCA600D
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 15:44:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8759240B8F;
	Thu,  8 Oct 2026 17:44:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 41FCC4027E;
 Thu,  8 Oct 2026 17:44:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791474246; x=1823010246;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=wGR4mc4Ap2LSus6PbvtNo02ead0WF70SYV3PquSc6jc=;
 b=fFnI73x7IWUPWZfpp+1xKqCGAzc3kOQsCWqYuviiaMpEHXjRYeJjkRog
 lHSBAZpQvy7cOF2RCjTUhSYHQSsPv+dYt7540Q+n6Xt4fqk0Yb3A96+Vr
 3H5j31I9Y557ufAQoFzVCgwY8hcctVQHR7Unevby/kWVoU6WVPpb7D4oL
 PMX/d/MlEiYgntfGyv0MuyDu0PvzT2F4ezFsPQ6xkre07hAQ259IwIbHH
 4s4Wud83+bMHQVpFPC6rMjwCDVKsE/SVV86t7BQv6rLjuUFLEgQOcupqi
 TBH3yXJ28pa2PL/VVt1MEtoHyjsLsIMz6JmIfjSHal/gpwN3kChqA1VI6 Q==;
X-CSE-ConnectionGUID: OQMsEVYRTSOlg4i9Ok69Vw==
X-CSE-MsgGUID: 7YdfTkQnRlyL7Kp7lLHFpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="154561"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="154561"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 08:44:04 -0700
X-CSE-ConnectionGUID: BFhdwAAuSbCwAgxGKmLu4A==
X-CSE-MsgGUID: C1GosZkxQnGPnledrZA7wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="1896072"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa011.fm.intel.com with ESMTP; 08 Oct 2026 08:44:03 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Thomas Monjalon <thomas@monjalon.net>, Conor Walsh <conor.walsh@intel.com>,
 Kevin Laatz <kevin.laatz@intel.com>
Subject: [PATCH] dma/idxd: remove experimental on whole driver
Date: Thu,  8 Oct 2026 16:43:51 +0100
Message-ID: <20261008154351.387445-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
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

The idxd DMA driver was marked as experimental in MAINTAINERS file.
Remove this designation as it's been stable for a long time now.

Fixes: e33ad06eaeeb ("dma/idxd: add skeleton for VFIO based DSA device")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---

Putting the fixline as the original start of the driver implementation,
since there is no good commit point to use to identify the stabilization
of the driver. Since this change should be good to backport to all
currently supported LTS releases, the orignal addition of the driver
works fine as a commit being fixed.
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 482bc7df76..51bf6b32bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1368,7 +1368,7 @@ F: doc/guides/compressdevs/features/zsda.ini
 DMAdev Drivers
 --------------
 
-Intel IDXD - EXPERIMENTAL
+Intel IDXD
 M: Bruce Richardson <bruce.richardson@intel.com>
 M: Kevin Laatz <kevin.laatz@intel.com>
 F: drivers/dma/idxd/
-- 
2.53.0

