Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C605C02199
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 12:48:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B897F42E9A;
	Fri,  7 Feb 2025 13:46:28 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 5682942E57
 for <dev@dpdk.org>; Fri,  7 Feb 2025 13:46:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738932383; x=1770468383;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=rki0/tboz9WWTyn09tHhwGJNJ2KJXfXkQdb9CXQTYH4=;
 b=k+9p4vXMK93VJKdkGpTtU9KKlaY+yB3gI87hYEfoP//QkAa9UpACTxGQ
 xHFJ3Bida/BJ2DTKVnmem70Sa+tVgQQUvLi0MKz4BFNDsvHdlS1U6ggJJ
 hcaBBk4bfRZjA1i8IDJlegwlPoa3Hu7cf5TpZKhreJMri/3+D6gMk/oTl
 NX1InsxRz3nfelDtR63R+Uo3jAalWCx7E2W0C4xgy+dy7kdRAUVQp9Prx
 KJB9Gh3SmnpSUANues5EfOMciDF6JggTcNQ3rsVQGA4G561gn2LvW/5l8
 fM9ihMg6fvo1sN/gn+SKamewJY3iDtdkJmI1H2PcCUVTlLKoichLrVLy6 Q==;
X-CSE-ConnectionGUID: TJ6lNLlpTqu52ZXGWb1pLg==
X-CSE-MsgGUID: OAIq4u+kTZebNRcrGL+uUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43331856"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="43331856"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 04:46:22 -0800
X-CSE-ConnectionGUID: e7TmTnB5TnWbX8pyBOF8eA==
X-CSE-MsgGUID: 9tC6DBrZSFqdfQuH23ZtpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111953748"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa007.jf.intel.com with ESMTP; 07 Feb 2025 04:46:21 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v3 24/36] net/e1000/base: add definition for EXFWSM register
Date: Fri,  7 Feb 2025 12:45:16 +0000
Message-ID: <9006a369da2a2a30d092498ac9f963969f957ef6.1738932115.git.anatoly.burakov@intel.com>
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

From: Nir Efrati <nir.efrati@intel.com>

Add Extended Firmware Semaphore (EXFWSM) register definition.

Signed-off-by: Nir Efrati <nir.efrati@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_defines.h | 3 ++-
 drivers/net/intel/e1000/base/e1000_regs.h    | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/e1000/base/e1000_defines.h b/drivers/net/intel/e1000/base/e1000_defines.h
index c311858d35..2b7d8631c9 100644
--- a/drivers/net/intel/e1000/base/e1000_defines.h
+++ b/drivers/net/intel/e1000/base/e1000_defines.h
@@ -481,7 +481,8 @@
 
 /* Low Power IDLE Control */
 #define E1000_LPIC_LPIET_SHIFT		24	/* Low Power Idle Entry Time */
-
+#define E1000_EXFWSM_DPG_EXIT_DONE	0x00000001
+#define E1000_EXFWSM_POWER_UP_FROM_ULP_IND	0x00000002
 /* PBA constants */
 #define E1000_PBA_8K		0x0008    /* 8KB */
 #define E1000_PBA_10K		0x000A    /* 10KB */
diff --git a/drivers/net/intel/e1000/base/e1000_regs.h b/drivers/net/intel/e1000/base/e1000_regs.h
index ad091d1734..643edbb9cb 100644
--- a/drivers/net/intel/e1000/base/e1000_regs.h
+++ b/drivers/net/intel/e1000/base/e1000_regs.h
@@ -538,6 +538,7 @@
 #define E1000_FACTPS	0x05B30
 #define E1000_SWSM	0x05B50 /* SW Semaphore */
 #define E1000_FWSM	0x05B54 /* FW Semaphore */
+#define E1000_EXFWSM	0x05B58 /* Extended FW Semaphore */
 /* Driver-only SW semaphore (not used by BOOT agents) */
 #define E1000_SWSM2	0x05B58
 #define E1000_DCA_ID	0x05B70 /* DCA Requester ID Information - RO */
-- 
2.43.5

