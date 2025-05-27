Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E427AC54F30
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 13:18:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78ABA40DDB;
	Tue, 27 May 2025 15:18:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 4354F40B9C
 for <dev@dpdk.org>; Tue, 27 May 2025 15:18:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748351884; x=1779887884;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=blR/gFqalweGMeCcjOmbeDN+wFh2qI8J8PeH5CLmZtw=;
 b=U5UT5RXagGhHEbc5x9aKwTVoY7NcUMphcbQLKP/uX6+eSkK9jsQgHoUv
 y4zcjemFbRh2LyJB8AWHRfLDJdFoLMgD1dHG2Z3NJ267pH728BpMa2BuZ
 uGbkAAMr0VR2p0CBVl7Fs+99xxNIcqNQ9AwSiQwTdu+krhyqTJ+5sWWwW
 G/h41F++avcrg3wgFfdJU6+6oVY/MwLOPFxq2/e8pfjIoX7MVGE08S5ou
 L8LwhUI6gUOlEDfcoKWSdcmH6OCq4LrJ3FT86bjxX7QXqWuILKWbvEvuO
 aoKfVk73R3FsnZNFraicI9l1G1B0mYdCeLnjBxn8b4TiekSlWiR+CpmK7 Q==;
X-CSE-ConnectionGUID: /prXT5Z+TS6wGF/X8EuQEg==
X-CSE-MsgGUID: osjGJcUNRdKTh4x0OfEsAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="67884856"
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208";a="67884856"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 06:18:04 -0700
X-CSE-ConnectionGUID: VPAFm90QT0yAleSFih5EBA==
X-CSE-MsgGUID: lDCOP+gHSuS5KDkraGGNjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208";a="143150093"
Received: from unknown (HELO silpixa00401120.ir.intel.com) ([10.55.128.58])
 by fmviesa008.fm.intel.com with ESMTP; 27 May 2025 06:18:03 -0700
From: Dhanya Pillai <dhanya.r.pillai@intel.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org,
	Dhanya Pillai <dhanya.r.pillai@intel.com>
Subject: [PATCH v3 10/10] net/ice/base: update version info
Date: Tue, 27 May 2025 13:17:29 +0000
Message-ID: <20250527131741.7606-11-dhanya.r.pillai@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250527131741.7606-1-dhanya.r.pillai@intel.com>
References: <20250527131741.7606-1-dhanya.r.pillai@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Update the README file with the date of that latest base code snapshot.

Signed-off-by: Dhanya Pillai <dhanya.r.pillai@intel.com>
---
 drivers/net/intel/ice/base/README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/ice/base/README b/drivers/net/intel/ice/base/README
index c32e530789..86f69d1d04 100644
--- a/drivers/net/intel/ice/base/README
+++ b/drivers/net/intel/ice/base/README
@@ -6,7 +6,7 @@ Intel® ICE driver
 ==================
 
 This directory contains source code of ice base driver generated on
-2024-10-11 released by the team which develops
+2025-05-23 released by the team which develops
 basic drivers for any ice NIC. The directory of base/ contains the
 original source package.
 This driver is valid for the product(s) listed below
-- 
2.43.0

