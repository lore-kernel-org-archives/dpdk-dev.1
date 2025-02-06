Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24150C02198
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 16:11:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 425E34279D;
	Thu,  6 Feb 2025 17:09:38 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 71E9B4275B
 for <dev@dpdk.org>; Thu,  6 Feb 2025 17:09:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738858174; x=1770394174;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=4nKZdbDC+mWV9Tw9MJ803PVlnohXWQZS85kI8MjQJGY=;
 b=UM7Jp/4Vy8a2wgMXxZAwfP00zgvaEH3jFroKkWJm5PJbmZXD+xIP3wTw
 9OJwdNKuxbhgJR1e2tMg77dcXBYmr0vwwLNc5SNDfVsVIFg7FnMLZIW4a
 lPwaGCaZ+UJyw/i2wYumoh3x5UJFMjkWrh8oihb4yYHatA5m/yLdcu7P0
 Njhp9rSjzoeSjQpte+hDjNEFF+c/lNyG4sTwNWXdLJPL63qGBATTTeqLH
 T5nbEMzJ+smZUoxgeZwvYjyiqPeQpB3wGd3VFF1tGFRDcbjwF0gsQ1wzH
 q1YEKmh209FbGhBOyMEsD7KxuqUcX+wgJJrMgmbvRLo2tnVMFjT1pexQV g==;
X-CSE-ConnectionGUID: g1Yg3Tj3QsiLCy+IE8C57Q==
X-CSE-MsgGUID: xZMxULbgQaCh6X/2M0lYDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50860777"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="50860777"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2025 08:09:33 -0800
X-CSE-ConnectionGUID: DMQI9He/R2G7HQPrMGmL3Q==
X-CSE-MsgGUID: yFtqJG9RSeuizza/Tcgugw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="111166850"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa007.fm.intel.com with ESMTP; 06 Feb 2025 08:09:31 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Sasha Neftin <sasha.neftin@intel.com>,
 Jeff Kirsher <jeffrey.t.kirsher@intel.com>, Wei Zhao <wei.zhao1@intel.com>,
 Guinan Sun <guinanx.sun@intel.com>
Subject: [PATCH v1 24/24] net/e1000/base: skip MANC check for 82575
Date: Thu,  6 Feb 2025 16:08:47 +0000
Message-ID: <63259ddf726a037a6e9efb484b3ec53a8aa340d5.1738858026.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738858026.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738858026.git.anatoly.burakov@intel.com>
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

From: Carolyn Wyborny <carolyn.wyborny@intel.com>

On 82575, driver is not supposed to check if managegement control is
enabled, and flush the Rx FIFO unconditionally.

Fixes: 44dddd14059f ("net/e1000/base: remove duplicated codes")
Cc: stable@dpdk.org

Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_base.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/e1000/base/e1000_base.c b/drivers/net/intel/e1000/base/e1000_base.c
index 3ec32e7240..e10bc6907a 100644
--- a/drivers/net/intel/e1000/base/e1000_base.c
+++ b/drivers/net/intel/e1000/base/e1000_base.c
@@ -132,7 +132,8 @@ void e1000_rx_fifo_flush_base(struct e1000_hw *hw)
 	rfctl |= E1000_RFCTL_IPV6_EX_DIS;
 	E1000_WRITE_REG(hw, E1000_RFCTL, rfctl);
 
-	if (!(E1000_READ_REG(hw, E1000_MANC) & E1000_MANC_RCV_TCO_EN))
+	if (hw->mac.type != e1000_82575 ||
+	    !(E1000_READ_REG(hw, E1000_MANC) & E1000_MANC_RCV_TCO_EN))
 		return;
 
 	/* Disable all Rx queues */
-- 
2.43.5

