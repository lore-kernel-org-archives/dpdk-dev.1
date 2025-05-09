Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B868CC3ABBC
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 May 2025 16:26:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A06084025D;
	Fri,  9 May 2025 18:26:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 826A04025A
 for <dev@dpdk.org>; Fri,  9 May 2025 18:26:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746807961; x=1778343961;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GKEpMHpyeHMGcThUPqVJHyoMPizjAPRxBMJhH17LlMU=;
 b=n6PU8eUOSxfEnAVhTgQBtHFeWQmBAz4raUZ0xJT/PoyettETu/tAmYXS
 Z7a1U9jNMH0ltzXz9q3vlZHbw3L9iVgJMJ4b5njLSEZxLyP7vG2UBy+QA
 hdllxL8qJnkClwhi0QNLUp4gdcLI32tdIuvS9365Sicpb6watwS6kK9F6
 19c3GKcun1af+xUMNHWB8eqxRvP44VaqxfZHnPQGxKSkO0tADOMLB39fR
 GLF9JnztzTuigfZCjvUIO4AMiZ3E8LLQWAU8aiOj4EWKijCQwwhqGwgxf
 ugovhK0+pgV1LBAnFcb8w46DK4mfIN/6zh2Wq+DHtA2FcUBpbw9ipDwFw A==;
X-CSE-ConnectionGUID: fqVo3bw4RCq4D6Wfga7zGA==
X-CSE-MsgGUID: jG+Sy8J1TOagOnn9KjGHJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48795222"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; d="scan'208";a="48795222"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2025 09:26:00 -0700
X-CSE-ConnectionGUID: cEoq+SM9RkG8SfPxhhixDw==
X-CSE-MsgGUID: Wnx36dobQBW4Yoiqs2r01Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; d="scan'208";a="173836574"
Received: from silpixa00401184.ir.intel.com (HELO
 silpixa00401184.ger.corp.intel.com) ([10.237.223.183])
 by orviesa001.jf.intel.com with ESMTP; 09 May 2025 09:25:57 -0700
From: "Pillai, Dhanya R" <dhanya.r.pillai@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, timothy.miskell@intel.com,
	"Pillai, Dhanya R" <dhanya.r.pillai@intel.com>, Pillai@dpdk.org
Subject: [PATCH] net/ice: update log message
Date: Fri,  9 May 2025 16:25:38 +0000
Message-ID: <20250509162543.142225-1-dhanya.r.pillai@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250502152601.699443-1-dhanya.r.pillai@intel.com>
References: <20250502152601.699443-1-dhanya.r.pillai@intel.com>
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

Clarified log message for DDP package load failure

Signed-off-by: Pillai, Dhanya R <dhanya.r.pillai@intel.com>

Notes

v2 - better commit message
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

