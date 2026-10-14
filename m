Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD79CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:14:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CFEE0406BA;
	Wed, 14 Oct 2026 17:14:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 149E340144;
 Wed, 14 Oct 2026 17:14:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791990854; x=1823526854;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=R7sS9sLnt4taeTU6/UJh6lTtnnUqQvCOB/PAzQND3xs=;
 b=UeW6lIUxQ7yuI1gbqFsV7ItaoPfIXUj6oAzAZ0t2gN05ynbrRGpJuoOP
 DkaHDh0vp18qrNN/dnzuQ/dc7FBgqKKZuDtguXaxBHlmt5PLg/NTHByKQ
 cqnxxdAQhCFY1n9p1yeM6VMrKK0s/VvQsjKYggz5fXKRafByfwRxiy4sP
 vK8+l0SkxDT/ZCaBq3WtdqT+J4GVlwPGegVJ5Ulqi4zeFb55ig+68F71n
 ElxxF11Tx/PEZYF4LOqJBYYCPSGEGX4+wwqwTMkfImn+evpA+eBJianUF
 hlpjNPMZZVEiFLrLbTZ3Mg1eQGeLPQQH8enya5DgpCaXbfhIPQGadYpoU Q==;
X-CSE-ConnectionGUID: JH+Jqy+bRt6mUOAnvWEv6g==
X-CSE-MsgGUID: /weJePAzSD2dK51jm7ECng==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="642321"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="642321"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 08:14:02 -0700
X-CSE-ConnectionGUID: z+Lm8qiXTVacrVwri2bAsw==
X-CSE-MsgGUID: Jd2Oib8oQIedzZNMmV2S0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1785391"
Received: from pae-31.iind.intel.com ([10.49.105.72])
 by fmviesa008.fm.intel.com with ESMTP; 14 Oct 2026 08:14:00 -0700
From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
To: dev@dpdk.org
Cc: Gaetan Rivet <grive@u256.net>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Subject: [PATCH v2 0/5] net/failsafe: fixes for sub-device removal and
 configuration
Date: Wed, 14 Oct 2026 22:15:59 +0000
Message-Id: <20261014221604.128677-1-sandeep.penigalapati@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261014194257.123356-1-sandeep.penigalapati@intel.com>
References: <20261014194257.123356-1-sandeep.penigalapati@intel.com>
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

v2:
- patch 2/5: add an explicit ETH(sdev) != NULL check before dereferencing
  in fs_rx_queue_release()/fs_tx_queue_release().
- patch 5/5: clarify in a comment that a secondary process detects the
  removal via the shared sub_device state checked by fs_rx_unsafe()/
  fs_tx_unsafe() in the burst path.


Sandeep Penigalapati (5):
  net/failsafe: fix double release of sub-device port
  net/failsafe: fix queue release without sub-device op
  net/failsafe: fix MAC address pool size and replay
  net/failsafe: ignore unsupported link status update
  net/failsafe: detect sub-device removal via device event

 drivers/net/failsafe/failsafe_ether.c   | 40 ++++++++++--
 drivers/net/failsafe/failsafe_ops.c     | 29 ++++++++-
 drivers/net/failsafe/failsafe_private.h | 13 ++--
 drivers/net/failsafe/failsafe_rxtx.c    | 83 +------------------------
 4 files changed, 67 insertions(+), 98 deletions(-)

-- 
2.34.1

