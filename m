Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07933CCA470
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 11:21:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7194B40672;
	Tue, 30 Sep 2025 13:21:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 57C4C400D7;
 Tue, 30 Sep 2025 13:21:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759231282; x=1790767282;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OKtJsQsax2JZ5sM/AihnmToxXOQ6P1VWknKc0j4oxYM=;
 b=gcvZNw8mJrFSE34CzFnBdJ+VDi3ly7SSPesBCKWaGsdsPadtVOr7EkgX
 +qtR+i+Ac+Pl4+Hnl0Xgcoi2ApnEXtWTzMoWsPvQo0wHyl+0Ns/vBIpB/
 8HJ/vVTXDlu6rrlvW0HkBxGYAwuBBLBRPIWcNnbzj68+iNn1/WPyA8zxT
 TEQClDXZbFoKTtW9lixbzemiZnwuFzFuVKn8I3yhNYR3ZKocAxEsGVXXr
 D+GGAJ7eh+OOWWFmWCIDbJyR45sNrvhVeceD7A4Cxosq8FhYEpK0riTEU
 3uzhul+9i2r4LpTaBcOVEgaaUB6I/GiFLlRDmk12fGI0jZXuuFQo4eRb4 Q==;
X-CSE-ConnectionGUID: Bz0zMWjfRzSA0GQwPEKMjQ==
X-CSE-MsgGUID: iizjZ9QESsi37+Nefz/lug==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="86927960"
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; d="scan'208";a="86927960"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2025 04:21:22 -0700
X-CSE-ConnectionGUID: NEmyn9LUSnaLRWJwVQ1QhQ==
X-CSE-MsgGUID: Ji8cRhJvQhO7KHI1Tnq4QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; d="scan'208";a="179265241"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa010.fm.intel.com with ESMTP; 30 Sep 2025 04:21:20 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>
Cc: vladimir.medvedkin@intel.com,
	stable@dpdk.org
Subject: [PATCH v1 1/4] net/ice/base: fix integer overflow on NVM init
Date: Tue, 30 Sep 2025 12:21:14 +0100
Message-ID: <664899c1791adcfc6e53fdac5ff9eb65e2fbec7a.1759231103.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1759231103.git.anatoly.burakov@intel.com>
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

