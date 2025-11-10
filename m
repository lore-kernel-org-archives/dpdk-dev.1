Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55140CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 13:55:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 318A9402CC;
	Mon, 10 Nov 2025 14:55:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 5C2294026D
 for <dev@dpdk.org>; Mon, 10 Nov 2025 14:55:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762782943; x=1794318943;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=4RHuTessVPj6J+QcW4Ka2t45jZWgo8iHAYz0N2IFAPI=;
 b=TqQYJ8eJauCobEZwL03nsM8GVLAfSNMZEvKEnOTOFu8+Zao8w52tAqRy
 S0dYa5yEu8UIpnFCJ+9NI7Sh1UdJtAYQc9l6DktT+/mdNEvVeY90Wx9QG
 1cvSxHHdNKTHkWboD1vpDzH5oZMTR75sbtCbDN2WWEBBmp1ndeelGk862
 yXM0YZEHFlu+dJj9cCp9awuK9IW50Ek9+9VNFa28nwJBqcpxR7dlwbJZ/
 1psWUKLwMYhlVD5MNCEihJna9wnfYmlgSb5+ml/T6Ih47cLgrT3tm7EZQ
 ofeS67FwHgBQ7zvhaNSa1u6Ej8hFv38Njfcev8IYqztmfxrsZ5NV+FBqB w==;
X-CSE-ConnectionGUID: A72s2z+uS+28WXTwSLxUWA==
X-CSE-MsgGUID: LlBMBqurQ8OTfS8zVrMt2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="52389398"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; d="scan'208";a="52389398"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2025 05:55:42 -0800
X-CSE-ConnectionGUID: Y1PZchZqRJ2ZvE79Ev4npA==
X-CSE-MsgGUID: yiZ2XVYhSDWo4GAYZWc1Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; d="scan'208";a="188320988"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa007.fm.intel.com with ESMTP; 10 Nov 2025 05:55:41 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Andrzej Wilczynski <andrzejx.wilczynski@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: [PATCH v1 1/1] net/ixgbe: fix PF link state request mailbox size
Date: Mon, 10 Nov 2025 13:55:39 +0000
Message-ID: <2ff7218cef6c77858929c2aad49bf33d925f1865.1762782930.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
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

From: Andrzej Wilczynski <andrzejx.wilczynski@intel.com>

Currently, when requesting PF link state over VF mailbox, the buffer sized
3 dwords is allocated. However, the `ixgbevf_write_msg_read_ack` function
is actually called with buffer size of 6 dwords. This leaves an admittedly
remote possibility of buffer overrun. Fix by adjusting requested size to 3.

Fixes: adbd71030575 ("net/ixgbe/base: fix link status for E610")

Signed-off-by: Andrzej Wilczynski <andrzejx.wilczynski@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/base/ixgbe_vf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/ixgbe/base/ixgbe_vf.c b/drivers/net/intel/ixgbe/base/ixgbe_vf.c
index 46a62bb851..eb16fb1942 100644
--- a/drivers/net/intel/ixgbe/base/ixgbe_vf.c
+++ b/drivers/net/intel/ixgbe/base/ixgbe_vf.c
@@ -482,7 +482,7 @@ int ixgbevf_get_pf_link_state(struct ixgbe_hw *hw, ixgbe_link_speed *speed,
 
 	msgbuf[0] = IXGBE_VF_GET_PF_LINK_STATE;
 
-	err = ixgbevf_write_msg_read_ack(hw, msgbuf, msgbuf, 6);
+	err = ixgbevf_write_msg_read_ack(hw, msgbuf, msgbuf, 3);
 	if (err || (msgbuf[0] & IXGBE_VT_MSGTYPE_FAILURE)) {
 		err = IXGBE_ERR_MBX;
 		*speed = IXGBE_LINK_SPEED_UNKNOWN;
-- 
2.47.3

