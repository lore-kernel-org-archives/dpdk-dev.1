Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142E9C5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 08:34:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 13DFD40685;
	Mon, 26 May 2025 10:34:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id E00494066A
 for <dev@dpdk.org>; Mon, 26 May 2025 10:34:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748248446; x=1779784446;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vY2IIblzjq+HGXVVgE1KPpYPTpdgvDU4RF0ZHtf0TzE=;
 b=L0PyCt7ZNkJGHFPW5arFCalCekXIJaZHjoSPRXIQzezawE7pUerz/z7D
 sUUOB6oG3PJCfgxdeKx9kU3XSkK/y06RCgislm4Cmcqx/1+f7SwzuW6ls
 z58gaDPVdrFDwN3jQvup4+QEkOJwmEADkl2+JmlyMyhkIERonBP7ekmS9
 /2VvUyXBWRUmcpFqOISec9uvu9rfINdhkQ1OR3rO1WITkVa7cnYkQY7bo
 8Erd1Bp6hYJqaAX7pHLLUBjPsbU3cdx3DO2fp1zZXWTML+/5917/h/als
 l2aO3yE6lQ5NmwP0/Wd9PfTmRGZBJsFoFg/AaDt905//Y+4iQUMa7NrBx A==;
X-CSE-ConnectionGUID: JMq5shkzSCeRFhVMWdZqjw==
X-CSE-MsgGUID: KsMMnETYRJuuJgmVHBDVxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11444"; a="54009028"
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; d="scan'208";a="54009028"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2025 01:34:05 -0700
X-CSE-ConnectionGUID: 8JUUZtcsRPO/qUJ7jjW58Q==
X-CSE-MsgGUID: nKIyKFL9TX62MoxPk2KVTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; d="scan'208";a="142293540"
Received: from unknown (HELO silpixa00401120.ir.intel.com) ([10.55.128.58])
 by fmviesa007.fm.intel.com with ESMTP; 26 May 2025 01:34:04 -0700
From: Dhanya Pillai <dhanya.r.pillai@intel.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Lukasz Krakowiak <lukaszx.krakowiak@intel.com>,
 Dhanya Pillai <dhanya.r.pillai@intel.com>
Subject: [PATCH 5/9] net/ice/base: typo fix in desc for dev ID 579F
Date: Mon, 26 May 2025 08:33:07 +0000
Message-ID: <20250526083325.248384-6-dhanya.r.pillai@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250526083325.248384-1-dhanya.r.pillai@intel.com>
References: <20250526083325.248384-1-dhanya.r.pillai@intel.com>
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

