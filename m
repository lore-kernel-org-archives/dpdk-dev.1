Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC1CCCA464
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 10:23:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20EF64060F;
	Fri, 16 Oct 2026 12:23:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 1162D400D5
 for <dev@dpdk.org>; Fri, 16 Oct 2026 12:23:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792146189; x=1823682189;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=A42jbVwZApigKXFXi9nmgADqbTO0BcUJWDVVbb0ZQJo=;
 b=cOKY9H1JBlGyJLBaV7E/AHcoNgDWhTeyuubVrD7U7f6v35ShXKcm0rZ5
 OIHUeCTakM0K0lhfVj9df3nqE2P+SZ44zOSqDeQPpSjswJzXoW8NC8oyb
 QdAIrzquds/djA3XEFA7Xo1ebOvsO8A+PKSPYzZUfs9HRsFR/OchBQ972
 /X8rBcgmiYdY3rpSgm9lVkbuAhUXOrPh4mQjtG/cArFLEdNTh4D+4Jphd
 4Yi2kbhVwVEaoTmLHNnUFPSTFsma0z484xYPJXtd50NcThB2MkXoSEppV
 S3anx7I8oVjO4A+tJ3+u55nN37C0/4x8Ru5+HgW89ol10nVxipxKCv2gG Q==;
X-CSE-ConnectionGUID: Wh//mAOAQWu7fh9o5f53GA==
X-CSE-MsgGUID: 74S+BMSYRuSczRhGNlO2LQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="809304"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="809304"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 03:23:09 -0700
X-CSE-ConnectionGUID: 3AwRRDcGQK+bJsJzpdtiSQ==
X-CSE-MsgGUID: /7l2cO1nQuWKgwm9uq+QmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="2292836"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa006.fm.intel.com with ESMTP; 16 Oct 2026 03:23:08 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v1 2/3] net/e1000/base: retry failed MTA writes on i210/i211
Date: Fri, 16 Oct 2026 11:23:00 +0100
Message-ID: <5bd8e69c32ec6d07cd48ff733fbfd2f7d839beb1.1792146148.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1792146148.git.anatoly.burakov@intel.com>
References: 
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

From: Dima Ruinskiy <dima.ruinskiy@intel.com>

On i210 and i211, writes to the multicast table array (MTA) sometimes
fail silently, leaving the hardware MTA out of sync with the driver's
`mta_shadow` copy.

After updating the MTA in `e1000_update_mc_addr_list_generic()`, read
the registers back on these devices and compare them with `mta_shadow`.
Rewrite any register that does not match, up to three attempts.

Signed-off-by: Grzegorz Siwik <grzegorz.siwik@intel.com>
Signed-off-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Signed-off-by: Yashaswini Raghuram Prathivadi Bhayankaram <yashaswini.raghuram.prathivadi.bhayankaram@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 .mailmap                                 |  1 +
 drivers/net/intel/e1000/base/e1000_mac.c | 34 ++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/.mailmap b/.mailmap
index 6d9e262cfb..f2e35dd968 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1927,6 +1927,7 @@ Yaron Illouz <yaroni@radcom.com>
 Yaroslav Brustinov <ybrustin@cisco.com>
 Yash Sharma <ysharma@marvell.com>
 Yashaswini Kanaujia <ykanaujia@marvell.com>
+Yashaswini Raghuram Prathivadi Bhayankaram <yashaswini.raghuram.prathivadi.bhayankaram@intel.com>
 Yasufumi Ogawa <ogawa.yasufumi@lab.ntt.co.jp> <yasufum.o@gmail.com>
 Ye Chen <yex.chen@intel.com>
 Yehor Malikov <yehor.malikov@solidigm.com>
diff --git a/drivers/net/intel/e1000/base/e1000_mac.c b/drivers/net/intel/e1000/base/e1000_mac.c
index 408e8e46e8..f794e24b75 100644
--- a/drivers/net/intel/e1000/base/e1000_mac.c
+++ b/drivers/net/intel/e1000/base/e1000_mac.c
@@ -549,6 +549,38 @@ u32 e1000_hash_mc_addr_generic(struct e1000_hw *hw, u8 *mc_addr)
 	return hash_value;
 }
 
+/**
+ *  e1000_i21x_mta_workaround - workaround for MTA write failures
+ *  @hw: pointer to the HW structure
+ *
+ *  On I210/I211 sometimes multicast table array writes silently fail.
+ *  Compare to MTA shadow to see if any registers are incorrectly written.
+ *  If a mismatch is found, try to write again up to three times.
+ **/
+static void e1000_i21x_mta_workaround(struct e1000_hw *hw)
+{
+	int failed_cnt = 3;
+	bool is_failed;
+	int i;
+
+	do {
+		is_failed = false;
+		for (i = hw->mac.mta_reg_count - 1; i >= 0; i--) {
+			if (E1000_READ_REG_ARRAY(hw, E1000_MTA, i) !=
+			    hw->mac.mta_shadow[i]) {
+				is_failed = true;
+				E1000_WRITE_REG_ARRAY(hw, E1000_MTA, i,
+						      hw->mac.mta_shadow[i]);
+				E1000_WRITE_FLUSH(hw);
+			}
+		}
+		if (is_failed && --failed_cnt <= 0) {
+			DEBUGOUT("Failed to update MTA register, too many retries\n");
+			break;
+		}
+	} while (is_failed);
+}
+
 /**
  *  e1000_update_mc_addr_list_generic - Update Multicast addresses
  *  @hw: pointer to the HW structure
@@ -584,6 +616,8 @@ void e1000_update_mc_addr_list_generic(struct e1000_hw *hw,
 	for (i = hw->mac.mta_reg_count - 1; i >= 0; i--)
 		E1000_WRITE_REG_ARRAY(hw, E1000_MTA, i, hw->mac.mta_shadow[i]);
 	E1000_WRITE_FLUSH(hw);
+	if (hw->mac.type == e1000_i210 || hw->mac.type == e1000_i211)
+		e1000_i21x_mta_workaround(hw);
 }
 
 /**
-- 
2.52.0

