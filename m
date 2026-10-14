Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A77CC6B1D
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 12:40:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 96DCE4060A;
	Wed, 14 Oct 2026 14:40:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 8ECFB40144;
 Wed, 14 Oct 2026 14:40:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791981654; x=1823517654;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=lKcwuim9L7RK0GiA7bo8edujUgfbjU43Y6dO750+XFc=;
 b=OGvI1n4+MERRHXrKuekOKwnWw8f+RNq4SdTwx0c0Ku6A3NUr1bIBhZtp
 HcZJPZzDAKQDlcfAr4pdB8C+kw6YdPPb2+UvCyCMpNAp1hqpQ4MxWhwhi
 jW+C6onMiT2dDSWwRLb3vkVT8BnE0NMP5OiCtfpdPF7DPYrtNy9O3dlOW
 17/xhXxxBYNQ3Cu011lxiQUSyVcfT68uyVFxsRsSFWQ0xWfJu35on7PLz
 0GI3MEigJfy2Y6lVPlkNgqoaGY7gbhzu5X/mkYen/ZBPyW0bFLtfu/zEw
 WwOw8m0ig1i3KWG0fd1cMUFQrK6Wxrlkw64GRJNaZRW30OT0QhGR/bORr g==;
X-CSE-ConnectionGUID: K6XrZlzaQzGWpPHux45k+w==
X-CSE-MsgGUID: 47m2bjn8Q2ec6lKlePjEXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="625407"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="625407"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 05:40:53 -0700
X-CSE-ConnectionGUID: 8tTWxHlGRVyufTrz1vX6Zg==
X-CSE-MsgGUID: YTtn1b87S8ipcGPZLOlBiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1342356"
Received: from pae-31.iind.intel.com ([10.49.105.72])
 by orviesa008.jf.intel.com with ESMTP; 14 Oct 2026 05:40:53 -0700
From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
To: dev@dpdk.org
Cc: Gaetan Rivet <grive@u256.net>, stable@dpdk.org,
 Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Subject: [PATCH 0/5] net/failsafe: fixes for sub-device removal and
 configuration
Date: Wed, 14 Oct 2026 19:42:52 +0000
Message-Id: <20261014194257.123356-1-sandeep.penigalapati@intel.com>
X-Mailer: git-send-email 2.34.1
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

This series collects fixes for the fail-safe PMD found while testing
live migration of a VF-backed sub-device (iavf) paired with a virtio-net
standby sub-device.

- double release of the sub-device port on hot-unplug;
- NULL queue-release op on sub-devices that do not implement it;
- MAC address pool size off-by-one and replay of zeroed MAC slots;
- unsupported link-status control (-ENOTSUP) treated as fatal;
- sub-device removal not detected without the RMV interrupt (e.g. VFIO
  device release), now handled through a bus device-event callback.


Sandeep Penigalapati (5):
  net/failsafe: fix double release of sub-device port
  net/failsafe: fix queue release without sub-device op
  net/failsafe: fix MAC address pool size and replay
  net/failsafe: ignore unsupported link status update
  net/failsafe: detect sub-device removal via device event

 drivers/net/failsafe/failsafe_ether.c   | 40 ++++++++++--
 drivers/net/failsafe/failsafe_ops.c     | 24 ++++++-
 drivers/net/failsafe/failsafe_private.h | 13 ++--
 drivers/net/failsafe/failsafe_rxtx.c    | 83 +------------------------
 4 files changed, 62 insertions(+), 98 deletions(-)

-- 
2.34.1

