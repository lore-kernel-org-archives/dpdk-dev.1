Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09015C02199
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 12:47:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B450442E82;
	Fri,  7 Feb 2025 13:46:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 24C4142E6D
 for <dev@dpdk.org>; Fri,  7 Feb 2025 13:46:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738932373; x=1770468373;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=BDp9ITEaOKLAlQxb5oc/r43mFeltFl8g//7+cBBYgiM=;
 b=APtc+ja/VhxIUXEel3tcgdibMH6jJtUMt3N71BSy1TxAqjbNqXaB4ied
 bI89yieb5/382JPMZldE4QGTox130zoHBE0rBShKA2NPEUlnCeG8a33UY
 GxBbvB1vL2QVF7+B/DZguvkPzYE7btojED3zd6hhLAsbWZikImwdlmEwu
 6/WHYzzE3I5fvx77iAdxP/lRziNAgUzFI/rSMCip8ghkCTXA4XWPyAUW/
 ZYmWGKMlvmIwhs4P4+vAK/sWxKqVHuPYoP4JKdnycdIbt3S4UxFFIPDJv
 KIeJHEX8zcfk1RbKtIm7OxkSQSFjAoSdanOGJhTqA+xSr3YmgAZhSeci2 Q==;
X-CSE-ConnectionGUID: Xj1k6y84Tl2MdgT8yd+OsA==
X-CSE-MsgGUID: gTiltqpQQguZNwjTr7FJQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43331832"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="43331832"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 04:46:12 -0800
X-CSE-ConnectionGUID: oAFT6DsgT/WPIdN1iFxZzg==
X-CSE-MsgGUID: okQOTNd4SSGNu5lE7Ds41A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111953630"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa007.jf.intel.com with ESMTP; 07 Feb 2025 04:46:10 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v3 15/36] net/e1000/base: add PHY reset support for i225
Date: Fri,  7 Feb 2025 12:45:07 +0000
Message-ID: <1df7cac135629f7ba46e4a66a6e05f6b3a307a2b.1738932115.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738932113.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738932113.git.anatoly.burakov@intel.com>
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

From: Evgeny Efimov <evgeny.efimov@intel.com>

Use PHY reset generic implementation for i225.

Signed-off-by: Evgeny Efimov <evgeny.efimov@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_i225.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/intel/e1000/base/e1000_i225.c b/drivers/net/intel/e1000/base/e1000_i225.c
index 7ea551014e..b8b57b6628 100644
--- a/drivers/net/intel/e1000/base/e1000_i225.c
+++ b/drivers/net/intel/e1000/base/e1000_i225.c
@@ -165,6 +165,7 @@ static s32 e1000_init_phy_params_i225(struct e1000_hw *hw)
 	phy->ops.check_reset_block = e1000_check_reset_block_generic;
 	phy->ops.commit		= e1000_phy_sw_reset_generic;
 	phy->ops.release	= e1000_release_phy_base;
+	phy->ops.reset		= e1000_phy_hw_reset_generic;
 
 	ctrl_ext = E1000_READ_REG(hw, E1000_CTRL_EXT);
 
-- 
2.43.5

