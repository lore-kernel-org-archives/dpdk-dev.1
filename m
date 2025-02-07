Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1FAC02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 12:49:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60BDF42EC1;
	Fri,  7 Feb 2025 13:46:36 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 6596A42DDE
 for <dev@dpdk.org>; Fri,  7 Feb 2025 13:46:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738932390; x=1770468390;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=l8FDuvz58SyY3mbnrmS7b/ghZXoRUe/6BXz820Vfs/I=;
 b=deJGMLBwfCP3f3IWwJPCQ0lPMpa7RQ9IpfGCvzfhgBA7x0oS6c4+Ki3k
 uI825sWgeMeaD5w3CfbQfAqdaRM/Ep7YEL8RtmN/ECbeejk1iYavLxV9z
 njkU01Tgh1z/OyfeRFASw4Ik1Gplu7Utay3Sxndr65QoxPbkmfhpzSXOP
 Z2Y9NBjMd8sB5WhDpqizyMJvqeP6OaWtMmVhEJqyIQZESaBMGHA/uaaps
 l9Z+UxwdOvCTNP180bHQpoLCecI5wHp5UZ6Tr3ACCgTVsewrukvzIkWvB
 /89Gu8RVJit0AfC9xQLR0Il47MSZJwKaQqyAoTNRM8Ro8UhKAcE6DmWUN Q==;
X-CSE-ConnectionGUID: zihKIWRPRUKSaokD8G0knQ==
X-CSE-MsgGUID: gZrfYwtKQIO+/4YPNTWdpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43331878"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="43331878"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 04:46:29 -0800
X-CSE-ConnectionGUID: cC0Xf8STTWiwA4joaM2jJw==
X-CSE-MsgGUID: BfTw+xyGSeSyoWcsrYdLwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111953802"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa007.jf.intel.com with ESMTP; 07 Feb 2025 04:46:28 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v3 30/36] net/e1000/base: improve NVM checksum handling
Date: Fri,  7 Feb 2025 12:45:22 +0000
Message-ID: <b5c3d7b12868ac50bf59bb13828e65d65d8e2ad0.1738932115.git.anatoly.burakov@intel.com>
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

When reading NVM checksum, we may encounter the following scenarios:

- Checksum may be invalid, and can be updated
- Checksum may be invalid but cannot be updated because NVM is read-only

For the latter case, we should just ignore invalid checksum and not attempt
to update it.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_ich8lan.c | 24 ++++++++++++++------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/net/intel/e1000/base/e1000_ich8lan.c b/drivers/net/intel/e1000/base/e1000_ich8lan.c
index 342a09e8b8..c6dc58d1ab 100644
--- a/drivers/net/intel/e1000/base/e1000_ich8lan.c
+++ b/drivers/net/intel/e1000/base/e1000_ich8lan.c
@@ -4366,13 +4366,23 @@ STATIC s32 e1000_validate_nvm_checksum_ich8lan(struct e1000_hw *hw)
 		return ret_val;
 
 	if (!(data & valid_csum_mask)) {
-		data |= valid_csum_mask;
-		ret_val = hw->nvm.ops.write(hw, word, 1, &data);
-		if (ret_val)
-			return ret_val;
-		ret_val = hw->nvm.ops.update(hw);
-		if (ret_val)
-			return ret_val;
+		DEBUGOUT("NVM checksum valid bit not set");
+
+		if (hw->mac.type < e1000_pch_tgp) {
+			data |= valid_csum_mask;
+			ret_val = hw->nvm.ops.write(hw, word, 1, &data);
+			if (ret_val)
+				return ret_val;
+			ret_val = hw->nvm.ops.update(hw);
+			if (ret_val)
+				return ret_val;
+		} else if (hw->mac.type == e1000_pch_tgp) {
+			/* Tiger Lake systems may have uninitialized NVM
+			 * checksum. Since the NVM cannot be updated by
+			 * software, do not validate the checksum.
+			 */
+			return E1000_SUCCESS;
+		}
 	}
 
 	return e1000_validate_nvm_checksum_generic(hw);
-- 
2.43.5

