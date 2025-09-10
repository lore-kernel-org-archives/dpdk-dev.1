Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E373BCA101F
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Sep 2025 08:06:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6958402C4;
	Wed, 10 Sep 2025 10:06:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id EB22B40270
 for <dev@dpdk.org>; Wed, 10 Sep 2025 10:06:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757491592; x=1789027592;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=QqUPvnzJEpUd4haUx4P02LmT/DLEMUN3iwxJfBJvkvE=;
 b=W+y7HMKidnO27dcHzGPCzEBoPtvl5QaAUjuvbkzeL0vcs3lX+4xTBn4y
 LLWWSwO8RsO9xB5+qtAt8G7AaOE6hTpvnMewuqw8CcJslENT7jmnZTFNM
 eJRCfVnjFhPv5kxBRHWpmhp38hw+G3gkkmQODyyfk7oiTprS+OFwlQCbJ
 8nmTDEDBBkKsblucpS5ixclSqEdHipSTFc8gim2PLJLq1B0p9nkX29nEU
 U3FqcXBFaPR1TjuNB8iB3h2DQtZR5Fw/b7I6urw1jG0BElk3tkyXE29B+
 N7Rie3G4G/VYAtMo9h4ZMRFqAEjiS2IV7CKavB7ZxV33ydmKc1WlhoF+J w==;
X-CSE-ConnectionGUID: VLOfKKUlRha6azcdSUzuig==
X-CSE-MsgGUID: OlGlRSocTy6xWFUfyeNVmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="63622626"
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; d="scan'208";a="63622626"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2025 01:06:31 -0700
X-CSE-ConnectionGUID: v9suzHSXTvqASmmFvttPHA==
X-CSE-MsgGUID: +9VaowzfSa6XNdQMld3tWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; d="scan'208";a="173408653"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by orviesa008.jf.intel.com with ESMTP; 10 Sep 2025 01:06:30 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] net/intel: remove unused Tx struct member
Date: Wed, 10 Sep 2025 09:06:16 +0100
Message-ID: <20250910080616.892711-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
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

The rel_mbufs_type value for tracking the Tx cleanup function is no
longer used in the iavf code. Therefore it can be removed.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index 7dc84da170..22eca21f65 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -84,7 +84,6 @@ struct ci_tx_queue {
 		};
 		struct { /* iavf driver specific values */
 			uint16_t ipsec_crypto_pkt_md_offset;
-			uint8_t rel_mbufs_type;
 #define IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1 BIT(0)
 #define IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 BIT(1)
 			uint8_t vlan_flag;
-- 
2.48.1

