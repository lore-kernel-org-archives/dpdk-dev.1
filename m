Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E762CD5BDE
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 05:56:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC86040280;
	Wed, 27 May 2026 07:56:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id EA5184021E;
 Wed, 27 May 2026 07:56:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779861364; x=1811397364;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=FKQD5+L4OHXPiIbHQbPOBr7UVtZ72N8Cr60z9E1R2Wk=;
 b=X096dsbat/6NJiptXqvLoyj2vlGOj3kK9QYfD6EyY3grd6GiGvOGn2+i
 er/ZgJ09/zpPDjCPClkJ568gjqWmdVe/IxjRLvI7yA8u+04pC2DnRl3es
 PCiHOKtUCagko+e04imFN+FN3b57Qee81txrloxKjMkQ2ReH+pSJNDRvt
 Z2b0RCqUuea5c3gNF5oB5ptc/CGRXgfrMfOY2oZxU5CnZHn3RjNBU5q4m
 ffoMWniMZZ9oN5+sO5CB+SMdjVJKGb2IZzymJzAnbKpyWCPKJWE0Fzqgq
 8cHFDJSxwt5sL97UCCQQZjR/j8Fy/uUjX2Z46IX1BtbIMEmUH/dYP1daz A==;
X-CSE-ConnectionGUID: 6SCwKu2oRRqnM0Qw4iYgvw==
X-CSE-MsgGUID: X4kKZAHSQHSBz0AQfr1azA==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="84308457"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="84308457"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 22:56:02 -0700
X-CSE-ConnectionGUID: jlM+wh88TzKtGFZ9TYVdXQ==
X-CSE-MsgGUID: ef6oaw3rTeefYfLU954KYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="272468717"
Received: from icx005.iind.intel.com (HELO icx005..) ([10.190.212.217])
 by orviesa002.jf.intel.com with ESMTP; 26 May 2026 22:56:00 -0700
From: KAVYA AV <kavyax.a.v@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: shaiq.wani@intel.com,
	KAVYA AV <kavyax.a.v@intel.com>,
	stable@dpdk.org
Subject: [PATCH] net/ice: use configured outer TPID for VLAN filter in DVM
Date: Wed, 27 May 2026 16:14:42 +0000
Message-ID: <20260527161442.394593-1-kavyax.a.v@intel.com>
X-Mailer: git-send-email 2.43.0
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

In Double VLAN Mode (DVM), the hardware switch recipe
ICE_SW_LKUP_VLAN matches on both the VLAN ID and the TPID.
Previously, ice_vlan_filter_set() always initialized the VLAN
filter with the hardcoded RTE_ETHER_TYPE_VLAN (0x8100), regardless
of the outer TPID configured by the user via vlan_tpid_set().

This caused a mismatch when a non-standard outer TPID such as
0x88a8 (IEEE 802.1ad) was configured: the hardware filter was
programmed with TPID 0x8100 while incoming packets carried TPID
0x88a8, resulting in all such packets being dropped by the VLAN
pruning logic.

Fix this by replacing the hardcoded RTE_ETHER_TYPE_VLAN with
pf->outer_ethertype in the ICE_VLAN() macro call. This field is
already updated by ice_vlan_tpid_set() when the user configures
the outer TPID, and defaults to RTE_ETHER_TYPE_VLAN at
initialization, so the change is safe for standard 802.1q traffic.

In SVM, the TPID is not part of the hardware lookup key, so this
change has no functional impact in that mode.

Fixes: 295b34f55b00 ("net/ice: fix VLAN 0 adding based on VLAN mode")
Cc: stable@dpdk.org

Signed-off-by: KAVYA AV <kavyax.a.v@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 0f2e7aee14..eaf3354000 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -5038,7 +5038,8 @@ static int
 ice_vlan_filter_set(struct rte_eth_dev *dev, uint16_t vlan_id, int on)
 {
 	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
-	struct ice_vlan vlan = ICE_VLAN(RTE_ETHER_TYPE_VLAN, vlan_id);
+	/* Use the configured outer_ethertype instead of hardcoded 0x8100 */
+	struct ice_vlan vlan = ICE_VLAN(pf->outer_ethertype, vlan_id);
 	struct ice_vsi *vsi = pf->main_vsi;
 	int ret;
 
-- 
2.43.0

