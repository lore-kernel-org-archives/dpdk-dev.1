Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B79CD4F3C
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 12:53:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9BF9E406A2;
	Wed, 20 May 2026 14:53:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 5734640684;
 Wed, 20 May 2026 14:53:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779281598; x=1810817598;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Kd303B3S05erz+N9IjyM7q6QqAv2m+KSrB+6bkHT5Jk=;
 b=PU89w/QGiSdTTUR8/oL2roIcb/YKuDLO3akLizrEKVhy85gZ4Zcxy0Xs
 3anmKIoRMzH9lBSiE2/Dk+WBQRKj7DpUO+WO1G6jsvYiN9zB0ekChVeqc
 SrtUYc3CDyoDoXHc/nIHsGVVBfnxY9/gr4hjGAg/a+ILOmtv20VCi7xC6
 KK4VmlzL/YNhNIvLBziHCaHdlNJBMMrRDYFutU8/ghiCfjyT2iWNEq2bS
 I5WQsKuGYZN738KSO28wAIsdbjmzVQ3/1Xa5Fw5sEcWpG4P4kva4RzvU6
 fJKrdnBMyIyHmV516rtc6AZZlEVry6fWLtZpHPTzPpvSdkoWxVLuRSvdC A==;
X-CSE-ConnectionGUID: i9dG6iAqRrOvR6YrcoeoMQ==
X-CSE-MsgGUID: 3wFBVTuOT4S8aZWmdxy3sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="91570272"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="91570272"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 05:53:18 -0700
X-CSE-ConnectionGUID: ggkphuyOSXWI6Cy/bcqgOA==
X-CSE-MsgGUID: KTrAn+CMQN2okZn+2QiXJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="235908279"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa010.fm.intel.com with ESMTP; 20 May 2026 05:53:17 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Lukasz Czapnik <lukasz.czapnik@intel.com>, stable@dpdk.org,
 Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 03/10] net/e1000/base: fix possible variable overflow
Date: Wed, 20 May 2026 12:52:40 +0000
Message-ID: <20260520125256.354336-4-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520125256.354336-1-ciara.loftus@intel.com>
References: <20260520125256.354336-1-ciara.loftus@intel.com>
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

From: Lukasz Czapnik <lukasz.czapnik@intel.com>

Bits can be lost as temporary math is done on signed variables and the
result is assigned to an unsigned variable. Cast to u32 to force the
compiler to do operations on unsigned temporary variables.

Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/e1000/base/e1000_mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/e1000/base/e1000_mac.c b/drivers/net/intel/e1000/base/e1000_mac.c
index 41aae86ffe..408e8e46e8 100644
--- a/drivers/net/intel/e1000/base/e1000_mac.c
+++ b/drivers/net/intel/e1000/base/e1000_mac.c
@@ -1970,7 +1970,7 @@ s32 e1000_blink_led_generic(struct e1000_hw *hw)
 			     (mode == E1000_LEDCTL_MODE_LED_OFF))) {
 				ledctl_blink &=
 				    ~(E1000_LEDCTL_LED0_MODE_MASK << i);
-				ledctl_blink |= (E1000_LEDCTL_LED0_BLINK |
+				ledctl_blink |= (u32)(E1000_LEDCTL_LED0_BLINK |
 						 E1000_LEDCTL_MODE_LED_ON) << i;
 			}
 		}
-- 
2.43.0

