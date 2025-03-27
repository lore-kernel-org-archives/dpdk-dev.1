Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA26FC3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 15:12:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EC9640E2A;
	Thu, 27 Mar 2025 16:12:35 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 674C240E28;
 Thu, 27 Mar 2025 16:12:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743088354; x=1774624354;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ong7xEdq6w4qm1X8t7S2TOhsCHOpVOVLCTn/YgRtDwc=;
 b=ljAJwOPoNKRlR8gFp4uoDB5sUNuALkerB+uuz5QgfxrGXOL7yRz/jRlO
 YDvOfChRYMRkW8m9nsYR9voEHyWNsoV5RRbKURNOlNvPpAGSp85fwJ0MK
 U1JkthHKMb2oUDa7m7VPleA6BXvAWc7WhUen2uXQHk7OD/wWSCY7qzy5a
 KqxDNsytdJ09DaXXuNsXlP4n+ewVfrJdp4GlztzpwoOh9TxLW+gHfrgJg
 nA7oTfW4m9+oDNkT5yb+0F1W6oq59uwE2wM43ng7uGEd9k/L6GwVLd8qn
 6lus9mQyfBSmcGCYZsVEHtbFSA9Q4gQsIeNRmHle3WHRbMWjgCqCtLNYY Q==;
X-CSE-ConnectionGUID: A7PTom+gRXCYc9dVFgTA6w==
X-CSE-MsgGUID: 0mzUZ23oQ/OGX3x8OhD0SQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="61959422"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="61959422"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 08:12:25 -0700
X-CSE-ConnectionGUID: S+kLql/lTty32vQhlh4gCQ==
X-CSE-MsgGUID: ikuO54lpSbe2HxibKadNqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="156162862"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa001.fm.intel.com with ESMTP; 27 Mar 2025 08:12:23 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
 Carolyn Wyborny <carolyn.wyborny@intel.com>
Cc: bruce.richardson@intel.com,
	stable@dpdk.org
Subject: [PATCH v2 2/3] net/ixgbe: fix VF registers for E610
Date: Thu, 27 Mar 2025 15:12:18 +0000
Message-ID: <d4abfd7295d5440eab3b481f20dca75034d9e406.1743088329.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <91f6e1e3f59faf66e6d5f32e4198bfd13b30a317.1743088329.git.anatoly.burakov@intel.com>
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

