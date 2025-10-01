Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF1FCAC5BB
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 12:29:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C37240B9E;
	Wed,  1 Oct 2025 14:29:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 44571406A2;
 Wed,  1 Oct 2025 14:29:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759321755; x=1790857755;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OKtJsQsax2JZ5sM/AihnmToxXOQ6P1VWknKc0j4oxYM=;
 b=X6x93ymTaYJF8qa937FsMvYHf4ldEK2dRBFP6oqNGK2IWruDyOQClT6r
 lGzOjp2FmaZWH+J1jzdhVm3Kv/ytzmxXAP4IDRoO35PD2edjQIfgCJdCi
 lvWZ9Vo+vsj5jW6n4JVw9ttmnsaJZOUmkfA6GX/l25JRC0Ow54qdzWLgY
 W8laxoVcKridAJyp7ZWcSSG5hXfBmIy6mCpUK3tN/Dg++33oKvipPENWs
 /pPXWZ5GtHAEuICBVhre3c6qLwumXmIJnL+rBmcjnZwWu9j8vGRLHf3ei
 kITZttin5vQaxVUa6PQUqHd4eD3f0EqXn6eAyT+PB2ZFApnCSpg85E+aL w==;
X-CSE-ConnectionGUID: //IqQh8oSTmbcA3Vx3gx6g==
X-CSE-MsgGUID: WRGj/651RwmpRs2vB2WKVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="60807866"
X-IronPort-AV: E=Sophos;i="6.18,306,1751266800"; d="scan'208";a="60807866"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2025 05:29:15 -0700
X-CSE-ConnectionGUID: 3VguumOaSP+AVcxSpV17tA==
X-CSE-MsgGUID: GYlz2BGbRd2IjA6TA7PqNw==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 01 Oct 2025 05:29:14 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>,
 Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
Cc: vladimir.medvedkin@intel.com,
	stable@dpdk.org
Subject: [PATCH v2 1/5] net/ice/base: fix integer overflow on NVM init
Date: Wed,  1 Oct 2025 13:29:04 +0100
Message-ID: <76fae04082cd16611f10cb1b7a4a783ba8eaaa5a.1759321681.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1759321681.git.anatoly.burakov@intel.com>
 <cover.1759321681.git.anatoly.burakov@intel.com>
References: 
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

From: Chinh Cao <chinh.t.cao@intel.com>

The shadow RAM size is defined as 16-bit unsigned, which may result in
overflows under certain scenarios. Fix the value to be 32-bit.

Fixes: a240ff50505b ("net/ice/base: add basic structures")
Cc: stable@dpdk.org

Signed-off-by: Chinh Cao <chinh.t.cao@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ice/base/ice_type.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/ice/base/ice_type.h b/drivers/net/intel/ice/base/ice_type.h
index ae3b944d6e..5f1f1a2f13 100644
--- a/drivers/net/intel/ice/base/ice_type.h
+++ b/drivers/net/intel/ice/base/ice_type.h
@@ -982,7 +982,7 @@ struct ice_flash_info {
 	struct ice_orom_info orom;	/* Option ROM version info */
 	struct ice_nvm_info nvm;	/* NVM version information */
 	struct ice_bank_info banks;	/* Flash Bank information */
-	u16 sr_words;			/* Shadow RAM size in words */
+	u32 sr_words;			/* Shadow RAM size in words */
 	u32 flash_size;			/* Size of available flash in bytes */
 	u8 blank_nvm_mode;		/* is NVM empty (no FW present) */
 };
-- 
2.47.3

