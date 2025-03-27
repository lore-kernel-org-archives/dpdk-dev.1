Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6923C3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 14:24:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE08540E09;
	Thu, 27 Mar 2025 15:24:20 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 8BED3402E6;
 Thu, 27 Mar 2025 15:24:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743085460; x=1774621460;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ong7xEdq6w4qm1X8t7S2TOhsCHOpVOVLCTn/YgRtDwc=;
 b=Bkt5eyUBBPw6Vrp8anIC+2gMNgnzD6Gnk870g/jXmn4eJkGnVx8y5gLl
 NP3xf2bvsLnTJPjLTma/bUtNI4sRdmk66YS3XNcehdbHcRlUYYnR9cIgB
 nsFYQ5/yq4EVlTcp8WE1EqmHFhunCettwstpUGUOhNqapj5dBhBv3kVjU
 Y7Kv7pmLAhb6wS9OyQ/QPWo1x0axzCYVh5HSZwrB7oOQtGdmu6/bM0c0r
 Zx5rFJaTYv/pNOtc2yklzQVHRWHswyE/iRrgvDy45/o0rMIOsHU2zKIiw
 Znd38vDYmoPDqmY5qBP5G3G24164VuacuhzNKCJkLwmF4moFnJTNCWIzl A==;
X-CSE-ConnectionGUID: v0vNYyzGQqWLBUX9tgyEMQ==
X-CSE-MsgGUID: SvSC1HkbSxqmHGM+xRGCeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="54620736"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="54620736"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 07:24:20 -0700
X-CSE-ConnectionGUID: GgZ8hlHyQxaSrH6pu1tkoA==
X-CSE-MsgGUID: 0vlx08vIQfu0Ja0eaSPPcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="125171308"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa006.jf.intel.com with ESMTP; 27 Mar 2025 07:24:17 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
 Carolyn Wyborny <carolyn.wyborny@intel.com>,
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Cc: bruce.richardson@intel.com,
	stable@dpdk.org
Subject: [PATCH v1 2/3] net/ixgbe: fix VF registers for E610
Date: Thu, 27 Mar 2025 14:24:12 +0000
Message-ID: <d4abfd7295d5440eab3b481f20dca75034d9e406.1743085431.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <91f6e1e3f59faf66e6d5f32e4198bfd13b30a317.1743085431.git.anatoly.burakov@intel.com>
References: 
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

When adding E610 support, some case statements for VF definitions were
missing, resulting in picking incorrect registers to write to in certain
cases. Fix it by adding necessary case statements for E610 VF.

Fixes: 316637762a5f ("net/ixgbe/base: enable E610 device")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index b80d5894f8..0fa4898aba 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -7515,6 +7515,7 @@ ixgbe_mrqc_reg_get(enum ixgbe_mac_type mac_type) {
 	case ixgbe_mac_X550_vf:
 	case ixgbe_mac_X550EM_x_vf:
 	case ixgbe_mac_X550EM_a_vf:
+	case ixgbe_mac_E610_vf:
 		return IXGBE_VFMRQC;
 	default:
 		return IXGBE_MRQC;
@@ -7527,6 +7528,7 @@ ixgbe_rssrk_reg_get(enum ixgbe_mac_type mac_type, uint8_t i) {
 	case ixgbe_mac_X550_vf:
 	case ixgbe_mac_X550EM_x_vf:
 	case ixgbe_mac_X550EM_a_vf:
+	case ixgbe_mac_E610_vf:
 		return IXGBE_VFRSSRK(i);
 	default:
 		return IXGBE_RSSRK(i);
-- 
2.47.1

