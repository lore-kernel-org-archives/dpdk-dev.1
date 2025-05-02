Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0213CC3ABAC
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 May 2025 15:26:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37224402A0;
	Fri,  2 May 2025 17:26:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 643714029E
 for <dev@dpdk.org>; Fri,  2 May 2025 17:26:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746199567; x=1777735567;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=uRPpjI/H/zcP4z2ZgiBW1OExyvVyuhAy9GgZs3rLlc0=;
 b=gkOBsx0jPTGD7Kvca49OQ0U8eAGO36ozLs0ozf55N5GSSkmW4eFgUUeJ
 atJ4s2h4ZfpLuJJOlcev8mFp+oekBLxht1bVpCvsk+PPfaxuhBHXLMqiJ
 xwGzorkOHJNpaHziXO1lwZ1uFV4NqbaO+ZEbBi3hlQeRngjMQOl8wGW4Q
 2xsDB0jC7jSoopQ/7tVnmiU0qE18LbACQUmHwE7AWAqQLp9pDhkq0WWdM
 IVTVm0KCeP90LFK3ZsoMXUadk0Wekx0iBjKA0q9vVrcPhuq3/fKKTu270
 GJUAQEOqKrTbqR9YDEYs+aw03AeEbdXT+4imoWH/vt9pGpkD/gc7FNmg7 g==;
X-CSE-ConnectionGUID: Hh1eyi3eQRW+Bg1PIU/EOA==
X-CSE-MsgGUID: oB2lK1xCReW8KZUagsnK3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="65412229"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; d="scan'208";a="65412229"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2025 08:26:06 -0700
X-CSE-ConnectionGUID: omLdUFNRQX2p7yNSRWKdbQ==
X-CSE-MsgGUID: 6Jif80u5RsC2OF2X+WDs6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; d="scan'208";a="134973532"
Received: from silpixa00401184.ir.intel.com (HELO
 silpixa00401184.ger.corp.intel.com) ([10.237.223.183])
 by fmviesa008.fm.intel.com with ESMTP; 02 May 2025 08:26:05 -0700
From: "Pillai, Dhanya R" <dhanya.r.pillai@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, timothy.miskell@intel.com,
	"Pillai, Dhanya R" <dhanya.r.pillai@intel.com>, Pillai@dpdk.org
Subject: [PATCH] net/ice: update log message
Date: Fri,  2 May 2025 15:25:59 +0000
Message-ID: <20250502152601.699443-1-dhanya.r.pillai@intel.com>
X-Mailer: git-send-email 2.43.0
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

Added log message for ddp package load failure.

mailmap: update contributor entry

Signed-off-by: Pillai, Dhanya R <dhanya.r.pillai@intel.com>
---
 .mailmap                           | 1 +
 drivers/net/intel/ice/ice_ethdev.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index d8439b79ce..0f66ad834f 100644
--- a/.mailmap
+++ b/.mailmap
@@ -353,6 +353,7 @@ Devendra Singh Rawat <dsinghrawat@marvell.com>
 Dex Chen <dex.chen@ruckuswireless.com>
 Dexia Li <dexia.li@jaguarmicro.com>
 Dexuan Cui <decui@microsoft.com>
+Dhanya Pillai <dhanya.r.pillai@intel.com>
 Dharmik Thakkar <dharmikjayesh.thakkar@arm.com> <dharmik.thakkar@arm.com>
 Dheemanth Mallikarjun <dheemanthm@vmware.com>
 Dhruv Tripathi <dhruv.tripathi@arm.com>
diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 21d3795954..bd55e0e7e1 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -2026,7 +2026,7 @@ int ice_load_pkg(struct ice_adapter *adapter, bool use_dsn, uint64_t dsn)
 
 	err = ice_copy_and_init_pkg(hw, buf, bufsz, adapter->devargs.ddp_load_sched);
 	if (!ice_is_init_pkg_successful(err)) {
-		PMD_INIT_LOG(ERR, "ice_copy_and_init_hw failed: %d", err);
+		PMD_INIT_LOG(ERR, "Failed to load ddp package: %d", err);
 		free(buf);
 		return -1;
 	}
-- 
2.43.0

