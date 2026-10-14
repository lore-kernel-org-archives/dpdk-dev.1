Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B2ACC6B1D
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 12:43:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C810940698;
	Wed, 14 Oct 2026 14:43:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 3A43A4021E;
 Wed, 14 Oct 2026 14:43:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791981807; x=1823517807;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Tr9EmayvoiPyOotoP6t5ePIsNQxOo/WxPdG2YIFiVMY=;
 b=b3YgcM/cLyfMQWP4mU8DzW7IZ0z+XAZPp5UTF/ZWVWNotWtiTxeKkmHP
 o7IuEB6+FAu3o7lpVIKRrvCyxgOQiD14aji/6Ix+rOnoU9oL+0Nx7Bn5X
 RcUH1fweW2eDoDa7+Xik+xZMC4QwaqBPhQeU0qvBrLK/0VBDtlhM11ob6
 DbVcb1XaG3mjIeVrQSYryypZLtMdvTSuU0wv/drvRhYpRKLPH9FLUO9jr
 hLvtURO69xt+L8K4CnJDOxNoi26hnCKT+P6Rdp28Dpz4/HSTWitM1+NGb
 CRumKHSZFLJCgHgzuwnspvZRCkWMDReeFIkT+Qym86SyMrEQH1xbKzHFr Q==;
X-CSE-ConnectionGUID: ib31AzjrSFuCxCYYNbezyg==
X-CSE-MsgGUID: WSIlczqKThuc3YCfk6Z4Gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="625471"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="625471"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 05:41:28 -0700
X-CSE-ConnectionGUID: aCjzZl3aTPuiMejmNdeBtQ==
X-CSE-MsgGUID: w3LSLa8ERW6F/F5y3EHvXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1342560"
Received: from pae-31.iind.intel.com ([10.49.105.72])
 by orviesa008.jf.intel.com with ESMTP; 14 Oct 2026 05:41:28 -0700
From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
To: dev@dpdk.org
Cc: Gaetan Rivet <grive@u256.net>, stable@dpdk.org,
 Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Subject: [PATCH 4/5] net/failsafe: ignore unsupported link status update
Date: Wed, 14 Oct 2026 19:42:56 +0000
Message-Id: <20261014194257.123356-5-sandeep.penigalapati@intel.com>
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

