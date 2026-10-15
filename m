Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3DDCC6B34
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 09:17:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6386C402DA;
	Thu, 15 Oct 2026 11:17:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id DC6B14026E;
 Thu, 15 Oct 2026 11:17:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792055849; x=1823591849;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ds4l/6HXiYUOL1e8D9Vvw6ikRd6klvklJ32BxiueooQ=;
 b=bcEHbN8iyMHVzs7U/11fws4jUKF+mMJIiKmnlkXk+xkt3SwsKKl0D8k5
 cu22G4ADU8HedejzYCuqhUV2isiGh1zETm0DM0ygrGzBDJweaN7GjtZZ2
 g4Bv3iFKP97g8DxH2VR6oz8G315SO+qMG9eMY2gvEtGsrYGLszvgg58/u
 TysHZ37JwvAqx5I7LpmYOQg2yewUhUshxrLoD9cZKMsukLPk5xzkMhkUS
 N2w6mz38DYLSjJC8iK65pBLdwe116hKnuvOlLzxXkMOI6dBEwSfQhnCvu
 Y7ZNHtcXjCPH1sdTWTTFMwjKCgks+ixDbBajrqodTlI31X04ibGkRYWBZ w==;
X-CSE-ConnectionGUID: 8Qb3hkyxTz2NvZVISCJM4w==
X-CSE-MsgGUID: 13MgTh9oSWmOKkD4+wVMxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="808460"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="808460"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 02:17:27 -0700
X-CSE-ConnectionGUID: LG3aDi4TSbS+3j7ta3ISgA==
X-CSE-MsgGUID: j49qMvYLQZWbF3ewPOTS3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="2000339"
Received: from pae-31.iind.intel.com ([10.49.105.72])
 by fmviesa009.fm.intel.com with ESMTP; 15 Oct 2026 02:17:26 -0700
From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
To: dev@dpdk.org
Cc: grive@u256.net, stephen@networkplumber.org, stable@dpdk.org,
 Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Subject: [PATCH v3 0/6] net/failsafe: fixes for sub-device removal and
 configuration
Date: Thu, 15 Oct 2026 16:19:21 +0000
Message-Id: <20261015161927.194886-1-sandeep.penigalapati@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261014221604.128677-1-sandeep.penigalapati@intel.com>
References: <20261014221604.128677-1-sandeep.penigalapati@intel.com>
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
- Rx/Tx burst still polling a removed sub-device: the fast-path ops are
  copied into rte_eth_fp_ops at start, so swapping the burst functions
  at runtime had no effect;
- sub-device removal not detected without the RMV interrupt (e.g. VFIO
  device release), now handled through a bus device-event callback.

v3:
- Split the removal-detection change (v2 patch 5/5) into a fix for the
  Rx/Tx burst path (5/6) and the new device-event based detection (6/6).
- Patch 1/6: reword and drop the redundant braces; the port is already
  released by rte_eth_dev_close() or rte_dev_remove().
- Patch 2/6: correct the Fixes tag to the fail-safe PMD commit and drop
  the unneeded ETH(sdev) != NULL check.
- Patch 5/6: new, the actual crash fix for the burst path.
- Patch 6/6: simplify the device-event callback and note that the bus
  delivers the event automatically for VFIO.

v2:
- Added an ETH(sdev) != NULL check (removed again in v3).
- Clarified secondary-process detection in a comment.


Sandeep Penigalapati (6):
  net/failsafe: fix double release of sub-device port
  net/failsafe: fix queue release without sub-device op
  net/failsafe: fix MAC address pool size and replay
  net/failsafe: ignore unsupported link status update
  net/failsafe: fix Rx/Tx burst after sub-device removal
  net/failsafe: detect sub-device removal via device event

 drivers/net/failsafe/failsafe_ether.c   | 42 ++++++++++---
 drivers/net/failsafe/failsafe_ops.c     | 27 +++++++-
 drivers/net/failsafe/failsafe_private.h | 13 ++--
 drivers/net/failsafe/failsafe_rxtx.c    | 83 +------------------------
 4 files changed, 65 insertions(+), 100 deletions(-)

-- 
2.34.1

