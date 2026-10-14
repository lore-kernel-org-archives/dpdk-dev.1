Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD611CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:14:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9E3140A89;
	Wed, 14 Oct 2026 17:14:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 311C9402A4;
 Wed, 14 Oct 2026 17:14:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791990855; x=1823526855;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CCbziOdBT8QPOzyl1zqF3gaIKllaJRXB4EYwtaxuqV4=;
 b=emwZ0UM2RQkADUgi2N+LAD8gFkw3up0EqB2q6K9WRM5hiNAKUBMVGCMF
 FZJatAvyQ65Nvr7RE6DXHiRlpTyS1bLvr6dlbKLwnvA6eSeM99Hwk8N42
 EUV7dyQQJu+eMmBFqHrqnYXb6FLTw5tz6eVVWRhdwq/7jm4RCvc8y7eas
 PLT02spmyVVD0+CQNrjCE4rkIoLh6pfAt6aBpk/ayLO188q0Mp4GndBzm
 YCudnBQi6CWnbfegqwwkyDOHq1jO/eSspzRXuhe4e/atyczHP2Lg0Eztb
 +yKRWgxBWR6t7rMjIGm5wER2Qhq42ENQiO8rUsHurnx/pj4XE0vbr+jXn g==;
X-CSE-ConnectionGUID: Jt3DbcsVSPC9kYEs2N8wXA==
X-CSE-MsgGUID: pyWhFNX2TpKP4Kp/bkTKQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="642325"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="642325"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 08:14:03 -0700
X-CSE-ConnectionGUID: vvpSwm4xSvq8OFcCf/LN2g==
X-CSE-MsgGUID: Ecf9+IUlT6aXPSx3s0bB5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1785400"
Received: from pae-31.iind.intel.com ([10.49.105.72])
 by fmviesa008.fm.intel.com with ESMTP; 14 Oct 2026 08:14:02 -0700
From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
To: dev@dpdk.org
Cc: Gaetan Rivet <grive@u256.net>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Subject: [PATCH v2 1/5] net/failsafe: fix double release of sub-device port
Date: Wed, 14 Oct 2026 22:16:00 +0000
Message-Id: <20261014221604.128677-2-sandeep.penigalapati@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261014221604.128677-1-sandeep.penigalapati@intel.com>
References: <20261014194257.123356-1-sandeep.penigalapati@intel.com>
 <20261014221604.128677-1-sandeep.penigalapati@intel.com>
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

When a sub-device is removed, fs_dev_remove() detaches the underlying
bus device, and that remove path already releases the ethdev port of
the sub-device. The fail-safe code then called
rte_eth_dev_release_port() a second time on the same port, resulting in
a double release of the port during hot-unplug.

Drop the redundant rte_eth_dev_release_port() call and let the bus
remove path own the release of the port.

Fixes: fac0ae546e5f ("net/failsafe: free port by dedicated function")
Cc: stable@dpdk.org
Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
---
 drivers/net/failsafe/failsafe_ether.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/failsafe/failsafe_ether.c b/drivers/net/failsafe/failsafe_ether.c
index f0fd662c7b..4eaa337f55 100644
--- a/drivers/net/failsafe/failsafe_ether.c
+++ b/drivers/net/failsafe/failsafe_ether.c
@@ -301,8 +301,6 @@ fs_dev_remove(struct sub_device *sdev)
 		if (ret < 0) {
 			ERROR("Bus detach failed for sub_device %u",
 			      SUB_ID(sdev));
-		} else {
-			rte_eth_dev_release_port(ETH(sdev));
 		}
 		sdev->state = DEV_PARSED;
 		/* fallthrough */
-- 
2.34.1

