Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20095C02199
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 12:48:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9596042E8D;
	Fri,  7 Feb 2025 13:46:17 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 0237542E77
 for <dev@dpdk.org>; Fri,  7 Feb 2025 13:46:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738932375; x=1770468375;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=ez9tvYLwcHXT8OjaKg/Ew3PuN3ncALZ0ktliPqDR6/s=;
 b=FGQSgQweaj9hC+6ppeYwOg5rRAJHL5LPDV637iD5WpZ3hBSVJpahn35E
 rt6ntU84n+/iEH+EFnzDZqZmWxxVOa1GcKyQfCDkgeB7NaB2DF5Yo1vpi
 bMnmEVbO/ogNMnMbb0EbELsDlPs0A7QZkQ+hkGf4RFNmnzh+jNsA+csEW
 zwKwysbvVx7ClmOtaTtV0LQH1PHP7HYOOsgzjudrSCKS57wZHPIsV3qkm
 mlcaJiPLVqlWVOgGIfrlMqzABnbDhNwL95DxdsCZ6yKe4OyfNu6BWWhss
 sHxSh/loAZme/kvk4a/wmBxMqTeS3nQovg/0Wq0yqUzjznnaTY6q4TKI7 A==;
X-CSE-ConnectionGUID: IVw42Q4eQxm2dU5DNYYmyg==
X-CSE-MsgGUID: 1fSBJnIYSY6Z25OWmzwVIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43331841"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="43331841"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 04:46:14 -0800
X-CSE-ConnectionGUID: QCYo4VMmT/Gire0Cj3XFaA==
X-CSE-MsgGUID: XQMFU2gLTeu+oXpVqQnDqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111953653"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa007.jf.intel.com with ESMTP; 07 Feb 2025 04:46:13 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v3 17/36] net/e1000/base: correct disable k1 logic
Date: Fri,  7 Feb 2025 12:45:09 +0000
Message-ID: <e46b029a18b1e225386eee1295a33296e98d07e1.1738932115.git.anatoly.burakov@intel.com>
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

From: Vitaly Lifshits <vitaly.lifshits@intel.com>

Starting from MTP PHY type there is a synchronization issue between the
PHY's clock and PCH's synopsis PHY. This causes Tx packets corruptions.

The workaround to this issue is to change P0s power down state from
P0/P0s to P1 prior to disabling K1.

Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_ich8lan.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/intel/e1000/base/e1000_ich8lan.c b/drivers/net/intel/e1000/base/e1000_ich8lan.c
index 97e3144810..18e193861e 100644
--- a/drivers/net/intel/e1000/base/e1000_ich8lan.c
+++ b/drivers/net/intel/e1000/base/e1000_ich8lan.c
@@ -2427,6 +2427,18 @@ s32 e1000_configure_k1_ich8lan(struct e1000_hw *hw, bool k1_enable)
 
 	DEBUGFUNC("e1000_configure_k1_ich8lan");
 
+	/* Due to clock synchronization issue on MTL and above prior to
+	 * disabling k1 it is required to disable P0s state
+	 */
+	if ((!k1_enable) && (hw->mac.type >= e1000_pch_mtp)) {
+		u32 fextnvm12 = E1000_READ_REG(hw, E1000_FEXTNVM12);
+		fextnvm12 |= (1 << 23);
+		fextnvm12 &= ~((1 << 22));
+		E1000_WRITE_REG(hw, E1000_FEXTNVM12, fextnvm12);
+
+		usec_delay(100);
+	}
+
 	ret_val = e1000_read_kmrn_reg_locked(hw, E1000_KMRNCTRLSTA_K1_CONFIG,
 					     &kmrn_reg);
 	if (ret_val)
-- 
2.43.5

