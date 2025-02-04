Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1A5C02196
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:15:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3931342D3F;
	Tue,  4 Feb 2025 16:12:17 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id D86A9427AD
 for <dev@dpdk.org>; Tue,  4 Feb 2025 16:12:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681923; x=1770217923;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0QNfqvtqYn11e9s9VBXQXerhxZYwe8kFB/tZSr3CvU0=;
 b=h8Smg/3HU9FyjTHYpdoZUC7LB++8pgBMS1EMFNoC/yD6dngnVz8SUi9R
 idzqwGHyiGKRxBbLUhRs6fjc50VL/2sFBvlingTM1LLw3RAQUAi51z1yz
 aXsvQGTHkDfaliW2wXfeJ4VA489OjmDeHIN+MoCnaIS/VR5QMN21xM92v
 sFPEDGICWoiBZyypHjIyTts7vrzDu7TPqTb9nmPhbi/knK8l9s8hgXCw2
 9iT6TaC8K/jPkJGbGHSUV5SFU4pQnsJSxwv+RRMsUjU5kZI3ySTGkra1w
 ee9V+pCocwPqjaJ9oF3mrWgmqCC3SF9DCtvKAxOoVZ5dUwp4XMlpDM2Tb A==;
X-CSE-ConnectionGUID: IcJh4lItSByFnFTC/YaG0w==
X-CSE-MsgGUID: GfBpsgFaQoOm7UGM3CShCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097143"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097143"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:12:02 -0800
X-CSE-ConnectionGUID: dJgrvl80RFmRzlwxtLtrHQ==
X-CSE-MsgGUID: TJmMuL0bT6ifVfeubHDRYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792692"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:12:00 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v2 27/54] net/e1000/base: skip MANC check for 82575
Date: Tue,  4 Feb 2025 15:10:33 +0000
Message-ID: <0c60ef37808705d7b0c8fe50dc1814c54cfd7e17.1738681726.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738681725.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738681725.git.anatoly.burakov@intel.com>
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
index 04fe9f4f91..06d6ad427a 100644
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

