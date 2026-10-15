Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA9DCC6B33
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 09:18:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28377406A2;
	Thu, 15 Oct 2026 11:17:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id CC2194068E;
 Thu, 15 Oct 2026 11:17:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792055855; x=1823591855;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2H5JXSFlU/2hGEx/69AscYF03hFdxzPEijc9CwDDGiA=;
 b=lpw513O0hgiTlwsPjTTVcc4gV8D/ZilK3LDKpBuWNFAvxt90grH0amWv
 zZFQtRdDCvVqH8vtF+8i9ezmAqvcV4JZvAadjWIfVvTCecocL3mEWAU4O
 NpQZxKathk/Pd4pIR+7DxsSTkS2lX7BA3/0EZ6hktt1U/Zj0ui++4MNnM
 N+mdyGJUPqYYYIug4vAkWfp5o0KaaKHVW8ThBbOrEDpf7IxElDNtG/fL9
 iBKRb4vzbR89I9GlKUSGFXbCerysONAFFdKClVaqsTSe05z6vFKd+VRMg
 0LuB5754DPVSQt2bQ6UI4QhZ1x2YoWLF+O0mvbu8Doc2Iy4ntV4o00ak3 Q==;
X-CSE-ConnectionGUID: 2mJ7TlSEQoi08a58wW0acg==
X-CSE-MsgGUID: 6jVUeueNQYKfH1KUdgUs4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="808480"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="808480"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 02:17:34 -0700
X-CSE-ConnectionGUID: Wjr+U7TjT2KvVDZux08VdA==
X-CSE-MsgGUID: kPc4q9U/RDWjdszFAKSNOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="2000370"
Received: from pae-31.iind.intel.com ([10.49.105.72])
 by fmviesa009.fm.intel.com with ESMTP; 15 Oct 2026 02:17:33 -0700
From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
To: dev@dpdk.org
Cc: grive@u256.net, stephen@networkplumber.org, stable@dpdk.org,
 Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Subject: [PATCH v3 4/6] net/failsafe: ignore unsupported link status update
Date: Thu, 15 Oct 2026 16:19:25 +0000
Message-Id: <20261015161927.194886-5-sandeep.penigalapati@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261015161927.194886-1-sandeep.penigalapati@intel.com>
References: <20261014221604.128677-1-sandeep.penigalapati@intel.com>
 <20261015161927.194886-1-sandeep.penigalapati@intel.com>
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
index 21779f9be8..92a279a5b9 100644
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

