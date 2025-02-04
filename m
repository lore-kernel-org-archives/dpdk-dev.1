Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9026CC02194
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:16:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FC4C410E4;
	Tue,  4 Feb 2025 16:12:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id DF317427E3
 for <dev@dpdk.org>; Tue,  4 Feb 2025 16:12:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681934; x=1770217934;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PFy8a+j6WfVjeya00vpRLIoDdJ23WhNZnPSA5zRQXG4=;
 b=jB70MSnI6NIt3WVYxqMu4EXAnp2hhSfSOU6/6IneozpmcA7WQVEc0l0w
 9UdouPFMt0uhGDz1lrDAZ9nDJPHu8S3kw2So+1FdwGIb1kDh+BnqXHmv2
 ZC2H2GvcTtTjtxK3HrFkVAvajxqfD2pfZIX1ISi0CwnvpfY4+e0hzMuof
 CuqnoYhqNWTQOyhXDNilcgdENRUGAlXo8idJivqz1UgMAjwzUk5mUQ1q1
 0Cj9isp/WEXvOfFprjZC+auzy3FX4kVsHBW5xFOCIt0NcvSlmEywbmY9p
 voo6WSfzHss6HS5XTLkvImSQ7kk+R7aX8thfJfndvKf1Jap/3oEtZlY6t g==;
X-CSE-ConnectionGUID: cyFi8IyESs+t8iC4ELUFZQ==
X-CSE-MsgGUID: ORpuc2HlRwqV1cgPl7nAcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097159"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097159"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:12:13 -0800
X-CSE-ConnectionGUID: 42wetSEiQP+m2JJvMGJtbA==
X-CSE-MsgGUID: uHixmf/9RFCdIs9hrF77bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792737"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:12:11 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v2 36/54] net/e1000/base: use longer ULP exit timeout on more
 HW
Date: Tue,  4 Feb 2025 15:10:42 +0000
Message-ID: <6ca40c9702ff78d6803e9d2145bea1fbc95a65ae.1738681726.git.anatoly.burakov@intel.com>
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
index 1b8292191a..0ab21ed669 100644
--- a/drivers/net/intel/e1000/base/e1000_hw.h
+++ b/drivers/net/intel/e1000/base/e1000_hw.h
@@ -1021,6 +1021,7 @@ struct e1000_dev_spec_ich8lan {
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

