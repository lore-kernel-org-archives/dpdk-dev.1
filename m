Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D44C0218F
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 13:01:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6AE4642E44;
	Fri, 31 Jan 2025 13:59:48 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 4FA6C42DD3
 for <dev@dpdk.org>; Fri, 31 Jan 2025 13:59:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738328383; x=1769864383;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Oa80xVOKsmbKao3bHRnxXtsxlvl4qmf2T1H46kPnx7g=;
 b=guxG7xQFjD6kQjdgV+m+ErZhkh1em4Rphp1uHegEBVaqLQqUBANcEkBj
 ntqLBXivmCtZsR2oAPfUphvSESqudq/JUwET6J4zraQsMf3Jo4jAXhB5O
 2WXl0xAuSIdSxK/RhtUKkERDcAKNlt8xEX72SsL7Wsf3GtRaA1JBm2mUD
 QvXpxZaTKOqbU32e3jcL0AcVp/m0mLJK+GtpcVoc6Iog6m6b9HFZns8Uj
 6RBmpHL1o9e/2hkeHH6d7IFjbLUSWtUfZRb0nZSFTTmhIaSRBmGKlLAqn
 V9dpl8OYeVGmCceJzGs5UfrkH9biSEqZQUvCLsyRCGvYNAIDvvNn8HwrR g==;
X-CSE-ConnectionGUID: F9L4aPfEQ6qJQx3xD68d3w==
X-CSE-MsgGUID: 5MEar9LnRfmohT/GoSmy+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50315636"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="50315636"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2025 04:59:42 -0800
X-CSE-ConnectionGUID: ajgBDn7uSPit7TUWdudtbw==
X-CSE-MsgGUID: RYudq/PnQ5y/7ZTvYaZzXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="140503390"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa001.fm.intel.com with ESMTP; 31 Jan 2025 04:59:41 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 16/42] net/e1000/base: correct disable k1 logic
Date: Fri, 31 Jan 2025 12:58:29 +0000
Message-ID: <8850c245344d9adc5e8e889d73848b6459627c15.1738328107.git.anatoly.burakov@intel.com>
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
index 4ff213f2c4..b346b95d2f 100644
--- a/drivers/net/intel/e1000/base/e1000_ich8lan.c
+++ b/drivers/net/intel/e1000/base/e1000_ich8lan.c
@@ -2425,6 +2425,18 @@ s32 e1000_configure_k1_ich8lan(struct e1000_hw *hw, bool k1_enable)
 
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

