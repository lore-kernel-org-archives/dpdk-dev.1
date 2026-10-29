Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF88D60A2600
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Oct 2026 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SHAMHDgU
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCB1940262;
	Thu, 29 Oct 2026 17:41:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTPS id C88D7400D6
 for <dev@dpdk.org>; Thu, 29 Oct 2026 17:41:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793292083; x=1824828083;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=obOgP9PmVhajCX47Vb4rzGhy3p5LTFDcifjmQ3p510A=;
 b=SHAMHDgUaFIO+jPBN+03H2G0Pq/4LlgGxpoRfs8LOgmVtIbeatTUvffD
 qDkoMlqqOiokaqeRqmWTAi3dZFoK/D5g65O6oc6oHKQ7xZQTxVfuGoXCh
 7xYOddmxljdNnIuBKcB3JvjURXDsS8bqDLEAlL7YDyOElbnsY7QoA7vPE
 VCvGEqPXsBEVwL0fcT7wQ+uIvexOV8+Kpd+4LvDWzjgDvQLvJNXWEWJkY
 cjHuRGHthkhrb0RjK/rBLBCAGk9Ot8kNQmWHIOF2uRkvQhQpRmQRjR8Rz
 1Vatcw7LQo0q8GkkmMbuzPCBdrO5TlQ3iXohYQ3AzyA0CwtW6NH1AvsVQ w==;
X-CSE-ConnectionGUID: 3+ffBvJrQGmF3mrGR3facw==
X-CSE-MsgGUID: KwZNNdBaTgS5VsFjjgRWsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="1954951"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1954951"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 09:41:02 -0700
X-CSE-ConnectionGUID: 9msVMfXtQa6K8kzHYBXSdg==
X-CSE-MsgGUID: IA3bDPVmT7i4YL0B4c6RMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5280308"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa009.jf.intel.com with ESMTP; 29 Oct 2026 09:41:00 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v1 1/4] net/ixgbe: fix FDIR reconfiguration after port start
Date: Thu, 29 Oct 2026 16:40:55 +0000
Message-ID: <9c545ac681db1bd835a88516322c1441951e3ed6.1793292050.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The flow director configuration is invalidated in dev_stop after the
hardware reset, but dev_start resets the hardware again. A flow created
while the port is stopped configures flow director and marks it as
configured, so the flow replay in dev_start does not reprogram it after
the reset.

Invalidate the flow director configuration after the reset in dev_start
as well.

Fixes: ea0f9067b2cf ("net/ixgbe: reimplement FDIR parser")

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index 46db8c49d09..1c9f22ffc31 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -2537,6 +2537,8 @@ ixgbe_dev_start(struct rte_eth_dev *dev)
 	 * this calls reset and start
 	 */
 	status = ixgbe_pf_reset_hw(hw);
+	/* reset wipes flow director setup, reinit it on next flow replay */
+	ixgbe_fdir_hw_invalidate(dev);
 	if (status != 0)
 		return -1;
 	hw->mac.ops.start_hw(hw);
-- 
2.52.0

