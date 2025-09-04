Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F94CA1012
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Sep 2025 10:45:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B93A410D5;
	Thu,  4 Sep 2025 12:44:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 6F6A040280
 for <dev@dpdk.org>; Thu,  4 Sep 2025 12:44:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756982689; x=1788518689;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MrUTgj8JeiEHaSVMjHSHNEDYqrpMFmWXW2zQm56JgPs=;
 b=Ko5h+9sNvU/MZ10Xpe2gQ2RupRp1v+G6Kr/1VILvFlpQ5+ZZaNQ/nrW4
 giSFSkYyg/LQYddl1Fe4W7B1pqIcjokqWXMQoBfSNG1ZisuJ4eEq3PTLf
 pd8b3tMkhaI28U2c2LDTCP6Jur8YJ6SAaBFKouxLKAPbeGmE0urnt9OOx
 108HCRwGshNM0r4qeW6u4uBDKbPLwYopIfnynAObqjvlluMu4fYV3y7Hz
 OAzB2+EA2hjJi2qXpyfRWJFA+2NTUo/Q5rOHj51hsf8gNgMku3v6s9Qjv
 BGm1pbO2AAQt0g+7scG76jTyoCPNHAznCipakiJA1UR53qwls14heVrGT w==;
X-CSE-ConnectionGUID: bB4i4fhkR5aslpRL3MnGGQ==
X-CSE-MsgGUID: PpOt3RDkSZqftrcb48mzZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="59463070"
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; d="scan'208";a="59463070"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2025 03:44:48 -0700
X-CSE-ConnectionGUID: Z0UlP5l9QQ2tCIuHBgV1jQ==
X-CSE-MsgGUID: BlA3gx9QReaNSFkL2xD41w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; d="scan'208";a="195512085"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by fmviesa002.fm.intel.com with ESMTP; 04 Sep 2025 03:44:47 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 2/3] net/iavf: fix a log during Tx path selection
Date: Thu,  4 Sep 2025 10:44:39 +0000
Message-Id: <20250904104440.2167205-3-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250904104440.2167205-1-ciara.loftus@intel.com>
References: <20250904104440.2167205-1-ciara.loftus@intel.com>
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

The vector offload context path is now selected for outerchecksum and
qinq insert offloads. Update logging to reflect this.

Fixes: abca31f780e1 ("net/iavf: support VLAN insertion for the AVX-512 path")

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf_rxtx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index ce0a12c348..5b46fa724c 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -4097,7 +4097,7 @@ iavf_set_tx_function(struct rte_eth_dev *dev)
 					    dev->data->port_id);
 			} else if (check_ret == IAVF_VECTOR_CTX_OFFLOAD_PATH) {
 				PMD_DRV_LOG(DEBUG,
-					"AVX2 does not support outer checksum offload.");
+					"AVX2 does not support requested Tx offloads.");
 				goto normal;
 			} else {
 				tx_func_type = IAVF_TX_AVX2_OFFLOAD;
-- 
2.34.1

