Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28250C0218F
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 13:02:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 104BF42E69;
	Fri, 31 Jan 2025 13:59:58 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 5442D42E4A
 for <dev@dpdk.org>; Fri, 31 Jan 2025 13:59:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738328390; x=1769864390;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=UnZi/OfageeXm7nkmEfDinoOEMMZI4hZLTXXb22atag=;
 b=FHkMetgF6WghMKs2uZY1RCd2xe2u3p59FEfo98d3MPITDvXfTl0JnfqW
 nXHwjpJOn00hVjNplFTCCZNVNvDfdmDhcJYJobj5fAUL1rgE86TJE0E9G
 rVUZbAqa1Xcif0a/WMFrkNWS45SLXKryXTF/aTzrKm/vCmVxCwG8c4CUi
 afKZrGO4EkPdxGZoOcwj2TyipI2fbXyakWEyEE8Pr+iT8g5qs5VuT33SA
 sRhGVDjsp7AOFjgyiswkUFWPgepDdUugOyahZx6yE4wuejtoBdWnHKAIe
 SFtxGUIgfEGXzoh/QmQwiiZ0NN6IHuTJ5ngzcLxjwEcsVNt94WpBvOi+A w==;
X-CSE-ConnectionGUID: nIHz4gFjQu2k+mHMfBmhKQ==
X-CSE-MsgGUID: cYJ0vNybSa2w4VcbWKQocg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50315645"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="50315645"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2025 04:59:49 -0800
X-CSE-ConnectionGUID: Gdv82f3SQcG9qgAjFm1tbQ==
X-CSE-MsgGUID: xEOJmrVwRSSY3xZPkC0w4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="140503406"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa001.fm.intel.com with ESMTP; 31 Jan 2025 04:59:48 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 23/42] net/e1000/base: add definition for EXFWSM register
Date: Fri, 31 Jan 2025 12:58:36 +0000
Message-ID: <b32fa20cd5d45dc705c576d044c0be03beaaad81.1738328107.git.anatoly.burakov@intel.com>
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

Add Extended Firmware Semaphore (EXFWSM) register definition.

Signed-off-by: Nir Efrati <nir.efrati@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_defines.h | 3 ++-
 drivers/net/intel/e1000/base/e1000_regs.h    | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/e1000/base/e1000_defines.h b/drivers/net/intel/e1000/base/e1000_defines.h
index bfc65fd17c..6227ac5340 100644
--- a/drivers/net/intel/e1000/base/e1000_defines.h
+++ b/drivers/net/intel/e1000/base/e1000_defines.h
@@ -480,7 +480,8 @@
 
 /* Low Power IDLE Control */
 #define E1000_LPIC_LPIET_SHIFT		24	/* Low Power Idle Entry Time */
-
+#define E1000_EXFWSM_DPG_EXIT_DONE	0x00000001
+#define E1000_EXFWSM_POWER_UP_FROM_ULP_IND	0x00000002
 /* PBA constants */
 #define E1000_PBA_8K		0x0008    /* 8KB */
 #define E1000_PBA_10K		0x000A    /* 10KB */
diff --git a/drivers/net/intel/e1000/base/e1000_regs.h b/drivers/net/intel/e1000/base/e1000_regs.h
index 1a12940b9f..d399126db9 100644
--- a/drivers/net/intel/e1000/base/e1000_regs.h
+++ b/drivers/net/intel/e1000/base/e1000_regs.h
@@ -539,6 +539,7 @@
 #define E1000_FACTPS	0x05B30
 #define E1000_SWSM	0x05B50 /* SW Semaphore */
 #define E1000_FWSM	0x05B54 /* FW Semaphore */
+#define E1000_EXFWSM	0x05B58 /* Extended FW Semaphore */
 /* Driver-only SW semaphore (not used by BOOT agents) */
 #define E1000_SWSM2	0x05B58
 #define E1000_DCA_ID	0x05B70 /* DCA Requester ID Information - RO */
-- 
2.43.5

