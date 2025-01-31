Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9C9C0218F
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 13:02:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26AA142E51;
	Fri, 31 Jan 2025 13:59:59 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 6B13942DD5
 for <dev@dpdk.org>; Fri, 31 Jan 2025 13:59:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738328391; x=1769864391;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=LDm08QT7sKDW7BfrQukcDBCtPGWD2aSiSmcBxevpFnY=;
 b=O7HN99J/G0N2eP4kfCvwHZzBldri1uyBMU0kdTDTpefVHw7i1ofMqGrn
 yr/CSOiruNok/UlnyEYErmvuWjrS3U8nVf5/bkkEQ2eya+a2XurZPODMB
 3cw+BaN2ZtrZ5gdPDHx5+/l8E7+mNFKBHDmymowJ8BZ2wVy7dnWCLomlx
 iPWkRGRPj8weStXnscXYW+Nkv2RgBIrww2P6S+OmSbl6VWtBNt9xSPgfM
 jgA9Tv89cQ/jn84JUX2KeW9QEVUjsz5OBxdqZO+PFx/vEUK6QISqmfJgK
 GPRDFLAXgmWIw4oRAaUY7wv/2JknfDhXV2SixzhoTgUCj382VZCAS2aka g==;
X-CSE-ConnectionGUID: +9xp3wTMRp2WAOmk70H1aQ==
X-CSE-MsgGUID: dq0KafB6R9qaYItkndg8Kw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50315647"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="50315647"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2025 04:59:50 -0800
X-CSE-ConnectionGUID: Isz5ZxPAToqlO0z2FkxRXw==
X-CSE-MsgGUID: CFyvX1uiRGShWXAMjWJDng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="140503407"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa001.fm.intel.com with ESMTP; 31 Jan 2025 04:59:49 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 24/42] net/e1000/base: use longer ULP exit timeout on more
 HW
Date: Fri, 31 Jan 2025 12:58:37 +0000
Message-ID: <a848686316c2b1d0abf29be6ce6c73aabcc0103a.1738328107.git.anatoly.burakov@intel.com>
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

From: Nir Efrati <nir.efrati@intel.com>

Add some definitions related to ULP WoL, and set longer ULP exit timeout on
more MAC types.

Signed-off-by: Nir Efrati <nir.efrati@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_hw.h      | 1 +
 drivers/net/intel/e1000/base/e1000_ich8lan.c | 2 +-
 drivers/net/intel/e1000/base/e1000_ich8lan.h | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/e1000/base/e1000_hw.h b/drivers/net/intel/e1000/base/e1000_hw.h
index cbef1fc10c..2edf64f473 100644
--- a/drivers/net/intel/e1000/base/e1000_hw.h
+++ b/drivers/net/intel/e1000/base/e1000_hw.h
@@ -1012,6 +1012,7 @@ struct e1000_dev_spec_ich8lan {
 	u16 eee_lp_ability;
 	enum e1000_ulp_state ulp_state;
 	bool ulp_capability_disabled;
+	bool wake_on_ulp_exit;
 	bool during_suspend_flow;
 	bool during_dpg_exit;
 	u16 lat_enc;
diff --git a/drivers/net/intel/e1000/base/e1000_ich8lan.c b/drivers/net/intel/e1000/base/e1000_ich8lan.c
index 7c89ecb623..d55797f817 100644
--- a/drivers/net/intel/e1000/base/e1000_ich8lan.c
+++ b/drivers/net/intel/e1000/base/e1000_ich8lan.c
@@ -1291,7 +1291,7 @@ s32 e1000_disable_ulp_lpt_lp(struct e1000_hw *hw, bool force)
 			E1000_WRITE_REG(hw, E1000_H2ME, mac_reg);
 		}
 
-		if (hw->mac.type == e1000_pch_cnp)
+		if (hw->mac.type >= e1000_pch_cnp)
 			ulp_exit_timeout = 100;
 
 		while (E1000_READ_REG(hw, E1000_FWSM) &
diff --git a/drivers/net/intel/e1000/base/e1000_ich8lan.h b/drivers/net/intel/e1000/base/e1000_ich8lan.h
index 4780417bae..fbe118723c 100644
--- a/drivers/net/intel/e1000/base/e1000_ich8lan.h
+++ b/drivers/net/intel/e1000/base/e1000_ich8lan.h
@@ -48,6 +48,7 @@
 
 #define E1000_H2ME		0x05B50    /* Host to ME */
 #define E1000_H2ME_ULP		0x00000800 /* ULP Indication Bit */
+#define E1000_H2ME_HOST_WOL_ON_ULP_EXIT	0x00000008 /* Host WOL on ULP exit */
 #define E1000_H2ME_ENFORCE_SETTINGS	0x00001000 /* Enforce Settings */
 
 #define ID_LED_DEFAULT_ICH8LAN	((ID_LED_DEF1_DEF2 << 12) | \
-- 
2.43.5

