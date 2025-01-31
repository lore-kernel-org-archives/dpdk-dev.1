Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E14C02192
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 13:01:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2548942E46;
	Fri, 31 Jan 2025 13:59:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 0BEE142DD0
 for <dev@dpdk.org>; Fri, 31 Jan 2025 13:59:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738328381; x=1769864381;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=5DM2LBv/v/NQXSEol1ZTZ1NEXM0nZ/5eeWVPc2gZcQg=;
 b=O+x1tAXdwRFM01ENF8VSxtQtiId8nBQWwa0fdAgHrahrOwPMMD7Mh8Ll
 BUWaI7xIjKkiECYX/f/kgYrnBAZH/ns0B92Iw3C8BH/UG6ALRds8VJ8Bl
 sD2asHrCPgUrPfDnIuiZJrsyf+m5byUU2rgHRIE1s2jQqVv9V4uf3C1G/
 JE7xPxcJGy2/c6MLlxSSKTiegMxwy31uQgmcUc6/Cd/ePvELzZ3yWhnO8
 eTC6WjWJbtlKxr5yIgyn4sOXnxOd52dMHzJkuzOKYW8eSutaQHgEuX8d1
 JoTegd+Ij52mpdDmGhVmBKRJ6DRpIC1fUBhB5YSlCAxxo6T6QnAuxoJr4 g==;
X-CSE-ConnectionGUID: lTdhKaCQQSycmPVJkme1IA==
X-CSE-MsgGUID: ri12CwUjTLOqtTYR3SZPIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50315634"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="50315634"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2025 04:59:41 -0800
X-CSE-ConnectionGUID: tmzQYcJjQeCDfptxeM4/mA==
X-CSE-MsgGUID: AZIQlRurTcy1Qi5jdE9PWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="140503387"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa001.fm.intel.com with ESMTP; 31 Jan 2025 04:59:40 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 15/42] net/e1000/base: skip MANC check for 82575
Date: Fri, 31 Jan 2025 12:58:28 +0000
Message-ID: <c8a1ed32c51cda8d1380844814030271468fed27.1738328107.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738328106.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
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

