Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558D4C02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 12:48:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43DED42E8A;
	Fri,  7 Feb 2025 13:46:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id C5D1842E5D
 for <dev@dpdk.org>; Fri,  7 Feb 2025 13:46:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738932379; x=1770468379;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=sO/Dw3E92ngpJrnKVWoxm1KWwiWZXKiQmZ6+unTDaG8=;
 b=M8FXcIyjM2NKLVguLj/r5WKFH3nT7lv2jTzS9cwcxzQC8bhVbIWxV/BZ
 aA7G0U5e4AqIqufVvFqbU35BdWEdFLqSZ912wcqCrr1cDuIamOC2kek2X
 kGvSY44j81sVE6Qj/y54OdminQ4gQNJ1LpGYSBzt6kc1a1oNjlfeHimvL
 EFI7PE7dMpA3vFqCDUekwWfEmYkNVPwjJy7W3wxcuDKhqzZ+ErsGjurcP
 3sc+Smzc4rnDl7MXu3QhfjswETRFeIdsFXfcijryuOpX1XdyfqyGzzW39
 LRJ0tUiX14xwl6dzTiZhLILg8KPj9sdkx7rZ+bf+8Zoezq3VXIgqtMyzy w==;
X-CSE-ConnectionGUID: fjtuNPDKQE2jTXcBi/UhQg==
X-CSE-MsgGUID: 9onsQcX9TRm1DUyMGFgQNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43331851"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="43331851"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 04:46:19 -0800
X-CSE-ConnectionGUID: MjTVxhcwT3OXXEMeRJNgOg==
X-CSE-MsgGUID: OZZWY4caSUCU+auv5WIcVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111953702"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa007.jf.intel.com with ESMTP; 07 Feb 2025 04:46:17 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v3 21/36] net/e1000/base: add profile information field
Date: Fri,  7 Feb 2025 12:45:13 +0000
Message-ID: <8bbb9fd19bf5f91b348ce3f653582c99031a32ea.1738932115.git.anatoly.burakov@intel.com>
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

From: Sasha Neftin <sasha.neftin@intel.com>

Some tools require device profile information to be present, so add it.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_hw.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/intel/e1000/base/e1000_hw.h b/drivers/net/intel/e1000/base/e1000_hw.h
index b3af96977c..7ef856226d 100644
--- a/drivers/net/intel/e1000/base/e1000_hw.h
+++ b/drivers/net/intel/e1000/base/e1000_hw.h
@@ -1056,6 +1056,7 @@ struct e1000_dev_spec_i225 {
 struct e1000_hw {
 	void *back;
 
+	u8 pf_id;               /* device profile info */
 	u8 *hw_addr;
 	u8 *flash_address;
 	unsigned long io_base;
-- 
2.43.5

