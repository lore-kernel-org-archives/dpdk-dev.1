Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A71CCC6B1D
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:14:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 69C7040DF5;
	Wed, 14 Oct 2026 17:14:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 2E9C240A80;
 Wed, 14 Oct 2026 17:14:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791990856; x=1823526856;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Tr9EmayvoiPyOotoP6t5ePIsNQxOo/WxPdG2YIFiVMY=;
 b=jKGYwmqGaiSW97WMZsMYpTza8PpjgWzmpkqTEZc8Jx4XMGquxCX5udYZ
 SERBbx4HeIRV16MN2vc4WLg0uiNXopdSSqCUXwNuLFxbSu9mEEZdGH0to
 XuG4S/qMdkcDgz+1VelDbquAqYg6JRA9fpZJ7NQOE9pSjzYLJ0Kn2XyOA
 JVJ+lW8Z41WRNtndV/ULomAKpY+14bQqZ/8Q2nPac8GVml4+gjCRAf9Lc
 Qj69nJR2GnCb4BA9KyeP9VW5zUfL7WZd1pp52vpBTjI9Bl/LxHJj18XjN
 CF4kKmDb7+g8m/d7BHKXLuYCeSUioaoW7z1lHpGHjd6JTr+rkFZUMPUTP A==;
X-CSE-ConnectionGUID: XrGuyA22TxG/5BZUKbrPIw==
X-CSE-MsgGUID: +rFZ+4rxQBC5QM67O5IGmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="642342"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="642342"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 08:14:08 -0700
X-CSE-ConnectionGUID: ENYhOIfuQE249oDXjfOMFw==
X-CSE-MsgGUID: hxBHg2pcRKCJPLg9FLrTng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1785431"
Received: from pae-31.iind.intel.com ([10.49.105.72])
 by fmviesa008.fm.intel.com with ESMTP; 14 Oct 2026 08:14:07 -0700
From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
To: dev@dpdk.org
Cc: Gaetan Rivet <grive@u256.net>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Subject: [PATCH v2 4/5] net/failsafe: ignore unsupported link status update
Date: Wed, 14 Oct 2026 22:16:03 +0000
Message-Id: <20261014221604.128677-5-sandeep.penigalapati@intel.com>
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

When applying the configuration to a sub-device,
fs_eth_dev_conf_apply() forces the link up or down with
rte_eth_dev_set_link_up()/rte_eth_dev_set_link_down(). Sub-devices such
as virtio-net do not support software link control and return -ENOTSUP,
which fail-safe treated as a fatal error and aborted the configuration
apply, preventing plug-in of such sub-devices.

Treat -ENOTSUP from the link control as success; the sub-device link
simply follows its physical state.

Fixes: ebea83f899d8 ("net/failsafe: add plug-in support")
Cc: stable@dpdk.org
Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
---
 drivers/net/failsafe/failsafe_ether.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/failsafe/failsafe_ether.c b/drivers/net/failsafe/failsafe_ether.c
index ea12e2722f..f23580ed37 100644
--- a/drivers/net/failsafe/failsafe_ether.c
+++ b/drivers/net/failsafe/failsafe_ether.c
@@ -115,7 +115,11 @@ fs_eth_dev_conf_apply(struct rte_eth_dev *dev,
 			ret = rte_eth_dev_set_link_up(PORT_ID(sdev));
 		else
 			ret = rte_eth_dev_set_link_down(PORT_ID(sdev));
-		if (ret) {
+		if (ret == -ENOTSUP) {
+			/* The sub-device link follows its physical state. */
+			DEBUG("link_status control not supported");
+			ret = 0;
+		} else if (ret) {
 			ERROR("Failed to apply link_status");
 			return ret;
 		}
-- 
2.34.1

