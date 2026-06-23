Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBFDCDB471
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 16:52:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6C3740A6C;
	Tue, 23 Jun 2026 18:52:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id A8B41409FA;
 Tue, 23 Jun 2026 18:52:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782233534; x=1813769534;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JOgJqqUd1gjaFLR00KY0jG1O/eCgP8fFGSUQ3DyCu84=;
 b=AtmJlus1eS8qevCF0fGJohszcsvcqcp5vdbzYp4phjNdKneXrZdLQaE3
 HmN/WZ+IqotFdmaseGFO8mN15M4FrfHCIDIMN9X1IJ+5IXX08H4md1sT0
 b4usnzflN1zAThBFBtoML37hUkfuJ/sgww+mwx9iG6NJTmnLTIt2ZiOuq
 zNHrDrwsGMFUmpJeJxb6UWWhaIBkMTphbFb4cSUph7A8d2Fyy26PSUury
 NdmOoxiLH3DtQARoiqiaIaj55RsD7O09TIaWoqrrUm5XBBiiH7GLmxCGx
 gpaLqFrqGxYcIrnQVnm2/D4NbpBl+iWbJeIkQ5pAI4Vny+pinORcZOf3b A==;
X-CSE-ConnectionGUID: JVoL1fhMSZyzq02mU97yfQ==
X-CSE-MsgGUID: nenSnhOJR6C0mNmnWUFkhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="100534653"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="100534653"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 09:52:13 -0700
X-CSE-ConnectionGUID: 4SY6DxK3QJ27tZimSse0eQ==
X-CSE-MsgGUID: 59wD+zGbSS2LDJ2oiDCRFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="253928343"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by orviesa004.jf.intel.com with ESMTP; 23 Jun 2026 09:52:12 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Andrew Boyer <andrew.boyer@amd.com>, Shannon Nelson <snelson@pensando.io>,
 Alfredo Cardigliano <cardigliano@ntop.org>
Subject: [PATCH 10/17] net/ionic: replace strncpy with strlcpy
Date: Tue, 23 Jun 2026 17:51:40 +0100
Message-ID: <20260623165150.765443-11-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623165150.765443-1-bruce.richardson@intel.com>
References: <20260623165150.765443-1-bruce.richardson@intel.com>
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

Replace strncpy() with safer strlcpy() which always null-terminates.

Fixes: 5ef518098ec6 ("net/ionic: register and initialize adapter")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/ionic/ionic_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ionic/ionic_main.c b/drivers/net/ionic/ionic_main.c
index 814bb3b8f4..d5545b1ecb 100644
--- a/drivers/net/ionic/ionic_main.c
+++ b/drivers/net/ionic/ionic_main.c
@@ -393,8 +393,8 @@ ionic_identify(struct ionic_adapter *adapter)
 	ident->drv.kernel_ver = 0;
 	snprintf(ident->drv.kernel_ver_str,
 		sizeof(ident->drv.kernel_ver_str), "DPDK");
-	strncpy(ident->drv.driver_ver_str, IONIC_DRV_VERSION,
-		sizeof(ident->drv.driver_ver_str) - 1);
+	strlcpy(ident->drv.driver_ver_str, IONIC_DRV_VERSION,
+		sizeof(ident->drv.driver_ver_str));
 
 	nwords = RTE_MIN(drv_size, cmd_size);
 	for (i = 0; i < nwords; i++)
-- 
2.53.0

