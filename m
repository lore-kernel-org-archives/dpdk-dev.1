Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F0FC9830E
	for <dpdk-dev@archiver.kernel.org>; Sun, 27 Sep 2026 10:50:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C5734026D;
	Sun, 27 Sep 2026 12:50:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id E290B400D6;
 Sun, 27 Sep 2026 12:50:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790506242; x=1822042242;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=x6qXdQAOoVshDMsOpTP6FuY2LnZ8wAFOF1kSZ7lD6CE=;
 b=EGH1XRhIKHxsjIq1bzCd6aelWKieSWOlQrHawFosOwPDM8NWMFHpbe7X
 A/klO4YZ1+3NFAr9fMnEEcAWgfXE4NPHg/ljjLuVx5jodw15+B75vuZVo
 iqn16IxReyC3sZvn1zYbA2quZ+qEO2ZtWfXjkbGSO1uwCbtV16g7u3rv1
 ZrwRU7zI5K6vpF3XbBspdBj8T3wJrxaP9ykkFY/US20H/f0a3TwuD3xBK
 jjSFezedqy0UCMcng0w5ok3loa4teL9KsOHmxnuaA7kLSnduiQLC74weJ
 9QLD75znmVrRcC1EN3HEHR5GhV+uDPChcOH66k1Td7OWvG1pSzWi+x6vK g==;
X-CSE-ConnectionGUID: YWjazSPJSkC8LAGttYYNOA==
X-CSE-MsgGUID: RnzXBPemRk+Nk64yQKR4Zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11917"; a="90129580"
X-IronPort-AV: E=Sophos;i="6.27,126,1787036400"; d="scan'208";a="90129580"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2026 03:50:40 -0700
X-CSE-ConnectionGUID: 419jF/L0TN+dTx6/yP8Gxg==
X-CSE-MsgGUID: o7gaxHPSRauj/Iy/rcYRjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,126,1787036400"; d="scan'208";a="271264778"
Received: from unknown (HELO localhost.localdomain.iind.intel.com)
 ([10.49.105.104])
 by fmviesa009.fm.intel.com with ESMTP; 27 Sep 2026 03:50:38 -0700
From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
To: dev@dpdk.org
Cc: Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
 Andrzej Wilczynski <andrzejx.wilczynski@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Subject: [PATCH] net/ixgbe: fix VF link status for E610
Date: Sun, 27 Sep 2026 13:52:40 -0400
Message-Id: <20260927175240.160260-1-sandeep.penigalapati@intel.com>
X-Mailer: git-send-email 2.27.0
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

E610 VFs report a wrong link speed (e.g. 10G while the PF is at 1G)
because the speed is decoded from the VFLINKS register, which E610 does
not use for VF link state.

Commit adbd71030575 ("net/ixgbe/base: fix link status for E610") added a
mailbox operation to fetch the link state from the PF and bumped the VF
mailbox API to 1.6, but the PMD never used it: ixgbevf_negotiate_api()
caps the API at 1.3 and ixgbevf_check_link() reads VFLINKS instead of the
base helper.

Negotiate the mailbox API up to 1.6 and query the PF for the link state
on E610 VFs. Other MAC types are unchanged.

Fixes: adbd71030575 ("net/ixgbe/base: fix link status for E610")
Cc: stable@dpdk.org
Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index 284df77023..78e19f94c0 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -1470,6 +1470,9 @@ ixgbevf_negotiate_api(struct ixgbe_hw *hw)
 
 	/* start with highest supported, proceed down */
 	static const enum ixgbe_pfvf_api_rev sup_ver[] = {
+		ixgbe_mbox_api_16,
+		ixgbe_mbox_api_15,
+		ixgbe_mbox_api_14,
 		ixgbe_mbox_api_13,
 		ixgbe_mbox_api_12,
 		ixgbe_mbox_api_11,
@@ -4133,6 +4136,18 @@ ixgbevf_check_link(struct ixgbe_hw *hw, ixgbe_link_speed *speed,
 	if (!mac->get_link_status)
 		goto out;
 
+	/* E610 VF reads link state from the PF over the mailbox */
+	if (hw->mac.type == ixgbe_mac_E610_vf) {
+		ret_val = ixgbevf_get_pf_link_state(hw, speed, link_up);
+		if (ret_val) {
+			*speed = IXGBE_LINK_SPEED_UNKNOWN;
+			mac->get_link_status = true;
+		} else {
+			mac->get_link_status = !(*link_up);
+		}
+		goto out;
+	}
+
 	/* if link status is down no point in checking to see if pf is up */
 	links_reg = IXGBE_READ_REG(hw, IXGBE_VFLINKS);
 	if (!(links_reg & IXGBE_LINKS_UP))
-- 
2.27.0

