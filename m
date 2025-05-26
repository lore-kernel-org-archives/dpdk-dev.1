Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F64C54FB3
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 18:04:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A917C40A72;
	Mon, 26 May 2025 20:03:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 7A7E040670
 for <dev@dpdk.org>; Mon, 26 May 2025 20:03:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748282620; x=1779818620;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qpF7NU+7oBYN6/B5lYrEVEB6LIJU+5sxTBQQRLF2mnI=;
 b=f35EE1nCUkkNzerdikwxbwv/fNwajvIw4hGnHAX2yB00JMB/KWH2e8GC
 7+Y8N2OyecUzQ3n7ylVn8C4MMxzpCich3IKHpPN+fFxzKT/XsYHnL0GqN
 xrmWSzrlrTk+O18xyrRKfR68TXAEHCYW0pp27hSWtpUss4+HHN7z0jmyV
 WmEqOMSdSBLYlNU5cYAG10KCmVjkHHYYnHXW/+ZpnhraLe2m6JBM3HcBf
 FLLN9CGz90oTyYNNnlWklu8YAUpC8/AxJQ7fZwj53LkUq0qj2stllkhL3
 HhDQmmNd6R9JAH8ANA0O5mubGmqvBLMtaPpV+qaWYgG6lR2GqIHZvDpv6 Q==;
X-CSE-ConnectionGUID: y9+MoNmpQoW24SlB+NrVJA==
X-CSE-MsgGUID: 3PfR8oggQdSwj7u/jQtLuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="50375176"
X-IronPort-AV: E=Sophos;i="6.15,316,1739865600"; d="scan'208";a="50375176"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2025 11:03:40 -0700
X-CSE-ConnectionGUID: D66EK0m6T7yzNwm2onn2UQ==
X-CSE-MsgGUID: OTgeRQ0mRYOlmQeTBzqI0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,316,1739865600"; d="scan'208";a="142478311"
Received: from unknown (HELO silpixa00401120.ir.intel.com) ([10.55.128.58])
 by fmviesa007.fm.intel.com with ESMTP; 26 May 2025 11:03:38 -0700
From: Dhanya Pillai <dhanya.r.pillai@intel.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Lukasz Krakowiak <lukaszx.krakowiak@intel.com>,
 Dhanya Pillai <dhanya.r.pillai@intel.com>
Subject: [PATCH v2 05/10] net/ice/base: typo fix in desc for dev ID 579F
Date: Mon, 26 May 2025 18:02:53 +0000
Message-ID: <20250526180311.4573-6-dhanya.r.pillai@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250526180311.4573-1-dhanya.r.pillai@intel.com>
References: <20250526180311.4573-1-dhanya.r.pillai@intel.com>
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

From: Lukasz Krakowiak <lukaszx.krakowiak@intel.com>

Fix typo in desc for dev ID 579F.

Signed-off-by: Lukasz Krakowiak <lukaszx.krakowiak@intel.com>
Signed-off-by: Dhanya Pillai <dhanya.r.pillai@intel.com>
---
 drivers/net/intel/ice/base/ice_devids.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/ice/base/ice_devids.h b/drivers/net/intel/ice/base/ice_devids.h
index 807b5d0c29..20c6dbd4a5 100644
--- a/drivers/net/intel/ice/base/ice_devids.h
+++ b/drivers/net/intel/ice/base/ice_devids.h
@@ -90,7 +90,7 @@
 #define ICE_DEV_ID_E825C_QSFP		0x579D
 /* Intel(R) Ethernet Connection E825-C for SFP */
 #define ICE_DEV_ID_E825C_SFP		0x579E
-/* Intel(R) Ethernet Connection E825-C 1GbE */
+/* Intel(R) Ethernet Connection E825-C 10GbE */
 #define ICE_DEV_ID_E825C_SGMII		0x579F
 #define ICE_DEV_ID_C825X		0x0DCD
 #endif /* _ICE_DEVIDS_H_ */
-- 
2.43.0

