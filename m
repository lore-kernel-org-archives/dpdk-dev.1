Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD86CC02194
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:16:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C50D442DCE;
	Tue,  4 Feb 2025 16:12:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id A19F94278B
 for <dev@dpdk.org>; Tue,  4 Feb 2025 16:12:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681932; x=1770217932;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rki0/tboz9WWTyn09tHhwGJNJ2KJXfXkQdb9CXQTYH4=;
 b=k0rBbFnual3sLrTZ8zpXZ5x20dpq3jiMxthxz7LLW43SYeGRtoXOYEjO
 b4bqKGGccIK0tcZsUA1TCZqUoTHgCjouJFsy1c1LNqCeYnZBboKjZBQ2i
 b+h2+ShXVDyCVMnsBqfY5hn+A65nFir5R6O4ACbM16u7JLPoj/uqPynel
 PchMftVTt+uOB7rCe7SjTPvUo6q4RPZRzH7oZCDbJ6LsTSkmF1+1mMAVX
 8jp4BebzKK8VsJ7FSHmeizZpC44IFf2DGB2OE6el3ZdmBTZS2w2TiveEg
 xkS+uRmAS8d+l94ELnQ6VAHxpqvzJkYhxpNK4Pob1jGSvZqrpQN42Choq A==;
X-CSE-ConnectionGUID: SpgdqPofR/iWODytvKK8wg==
X-CSE-MsgGUID: aqjnh6nKQcScxANIbkFabg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097157"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097157"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:12:12 -0800
X-CSE-ConnectionGUID: v3ng/mEuS5ytaAz1PkoyQQ==
X-CSE-MsgGUID: Nk+b41VTTyiiAAVFK5B0qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792732"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:12:10 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v2 35/54] net/e1000/base: add definition for EXFWSM register
Date: Tue,  4 Feb 2025 15:10:41 +0000
Message-ID: <d21a396a02d7e85ccf38b3143dc5a241b4575f17.1738681726.git.anatoly.burakov@intel.com>
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

