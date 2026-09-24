Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC00C9830E
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 13:14:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CE6B42FA7;
	Thu, 24 Sep 2026 15:14:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id B4CAB400D7;
 Thu, 24 Sep 2026 15:14:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790255676; x=1821791676;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CL8nvIZofVsHBCr9DByAJdvZlRzoAfL9I5SwtzROnvg=;
 b=P/FiQqLkQ4WTArVqb4FwcmPIymYDIX12wzSeMOmN7CtzHisVSgLB4uhD
 cGSC9pRjOBlKInYco96Cru31YeZQj5ZDKoJaPcUlEY2EamiO0MVSTYcbL
 saGlQck0Dx/lZPkUVl2K1uf2fUfeczmVilfGmAT8f9+suVnSxbLlm9CCc
 Ir/yhQUzo0f/pIapWB8BfctnEBtDKVpr9igUifBMre1OD9eM74cJbnqbu
 1JaycND2BBJ1ZqqVf7maRV/Q30IKhwZ/jfEFZOepc7bKmxSUE+5bZaKVR
 NblHDnJLiajZdKntiub3TtEtCvULLnVWw9YibJZWbun6tkXPc7TeRzx6p Q==;
X-CSE-ConnectionGUID: A8UuPUZpRSKIK0QPEKKvMg==
X-CSE-MsgGUID: cIiDiB6gQdGwUXotxtGnkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="93915422"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="93915422"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 06:14:35 -0700
X-CSE-ConnectionGUID: 9sP1RVfEQlS8fmbE5NUVoA==
X-CSE-MsgGUID: wDhU77uoTTWwmUb7Hwz7Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="273518515"
Received: from silpixa00401177.ir.intel.com (HELO vm-icx177..)
 ([10.20.224.214])
 by fmviesa007.fm.intel.com with ESMTP; 24 Sep 2026 06:14:33 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH 1/6] net/ice: update Rx supported offloads masks
Date: Thu, 24 Sep 2026 13:13:41 +0000
Message-ID: <20260924131346.100156-2-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924131346.100156-1-ciara.loftus@intel.com>
References: <20260924131346.100156-1-ciara.loftus@intel.com>
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

All Rx paths support offloading the outer UDP cksum. Advertise this in the
Rx path offload masks and the dev_info Rx offload capabilities.

Fixes: 75c6287f250f ("net/ice: fix outer checksum flags")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 1 +
 drivers/net/intel/ice/ice_rxtx.h   | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index dfee07c457b..2722f359cb3 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -4751,6 +4751,7 @@ ice_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 			RTE_ETH_RX_OFFLOAD_TCP_CKSUM |
 			RTE_ETH_RX_OFFLOAD_QINQ_STRIP |
 			RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM |
+			RTE_ETH_RX_OFFLOAD_OUTER_UDP_CKSUM |
 			RTE_ETH_RX_OFFLOAD_VLAN_EXTEND |
 			RTE_ETH_RX_OFFLOAD_RSS_HASH |
 			RTE_ETH_RX_OFFLOAD_TIMESTAMP |
diff --git a/drivers/net/intel/ice/ice_rxtx.h b/drivers/net/intel/ice/ice_rxtx.h
index cd23f7c56f6..b809c8b0e80 100644
--- a/drivers/net/intel/ice/ice_rxtx.h
+++ b/drivers/net/intel/ice/ice_rxtx.h
@@ -87,6 +87,7 @@
 			RTE_ETH_RX_OFFLOAD_TCP_CKSUM |		\
 			RTE_ETH_RX_OFFLOAD_QINQ_STRIP |		\
 			RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM |	\
+			RTE_ETH_RX_OFFLOAD_OUTER_UDP_CKSUM |	\
 			RTE_ETH_RX_OFFLOAD_VLAN_EXTEND |	\
 			RTE_ETH_RX_OFFLOAD_RSS_HASH |		\
 			RTE_ETH_RX_OFFLOAD_TIMESTAMP |		\
@@ -100,6 +101,7 @@
 #define ICE_RX_VECTOR_OFFLOAD_OFFLOADS (	\
 		ICE_RX_VECTOR_OFFLOADS |	\
 		RTE_ETH_RX_OFFLOAD_CHECKSUM |	\
+		RTE_ETH_RX_OFFLOAD_OUTER_UDP_CKSUM |	\
 		RTE_ETH_RX_OFFLOAD_VLAN_STRIP |	\
 		RTE_ETH_RX_OFFLOAD_VLAN_FILTER |\
 		RTE_ETH_RX_OFFLOAD_RSS_HASH)
-- 
2.43.0

