Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EF9D2F7D1
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 10:54:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74D984027D;
	Fri,  5 Dec 2025 11:54:19 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id CDA5A40156
 for <dev@dpdk.org>; Fri,  5 Dec 2025 11:54:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764932059; x=1796468059;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=knSPcIE9pER649rTZDFd8iE5MCQLD4DYoTpkQs2qgi0=;
 b=XShWRzKcV86QfdI+1Y/ku0YlBdHMx3/hs7vAIifBNDcLAoprJJ52rLv5
 mYxrL7SDmlvCuoqbXVG01/8twBSRl0cA/qObnr1VFguwJp+BMHG7sOY1f
 PivniD1B5iZtXlzDe5LNjRP6eAj3CZ3r0byKVqOYQucqkdMKWPonS1Aj/
 5Z6FyFB8WAurcYYC2SdRTRL9kEHOFH+fLPxlL5A/waxTk/H1iKWLpjvCk
 wmL0j2ounbTYWE13HWLoCXPLbsoTtItmEt1ERuu6TknPRJmmNXIFdtHrh
 0Ku6ZWs5yzCykZANRKncoX3fqvf2M8Z8mn68X8ApL5+tEyZKDnpOhbCwH g==;
X-CSE-ConnectionGUID: 9/Nzzr9tTLWHRWFb8/3Gnw==
X-CSE-MsgGUID: tIwfxdwUQx+UNqoL6gP3/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="77287902"
X-IronPort-AV: E=Sophos;i="6.20,251,1758610800"; d="scan'208";a="77287902"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2025 02:54:17 -0800
X-CSE-ConnectionGUID: mVy5BB+fR66ad5RzZNTnIQ==
X-CSE-MsgGUID: YQf+hBspTHO0D7L3EeJEYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,251,1758610800"; d="scan'208";a="232644174"
Received: from unknown (HELO localhost.localdomain.iind.intel.com)
 ([10.49.105.165])
 by orviesa001.jf.intel.com with ESMTP; 05 Dec 2025 02:54:16 -0800
From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
 Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Subject: [PATCH] net/iavf: add fragment RSS types for symmetric Toeplitz
Date: Fri,  5 Dec 2025 12:55:37 -0500
Message-ID: <20251205175537.137011-1-sandeep.penigalapati@intel.com>
X-Mailer: git-send-email 2.43.5
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

The ICE PMD supports RTE_ETH_RSS_FRAG_IPV4 and RTE_ETH_RSS_FRAG_IPV6
with symmetric Toeplitz, but these were missing from IAVF PMD.
Added the fragment RSS types to enable fragment hashing support in VF,
matching the PF driver capability.

Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
---
 .mailmap                           | 1 +
 drivers/net/intel/iavf/iavf_hash.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index 2f089326ff..fa2e10afe8 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1418,6 +1418,7 @@ Samik Gupta <samik.gupta@broadcom.com>
 Samina Arshad <samina.arshad@intel.com>
 Sampath Peechu <speechu@cisco.com>
 Samuel Gauthier <samuel.gauthier@6wind.com>
+Sandeep Penigalapati <sandeep.penigalapati@intel.com>
 Sandilya Bhagi <sbhagi@solarflare.com>
 Sangjin Han <sangjin@eecs.berkeley.edu>
 Sangtani Parag Satishbhai <parag-satishbhai.sangtani@broadcom.com>
diff --git a/drivers/net/intel/iavf/iavf_hash.c b/drivers/net/intel/iavf/iavf_hash.c
index 217f0500ab..72c77f75ac 100644
--- a/drivers/net/intel/iavf/iavf_hash.c
+++ b/drivers/net/intel/iavf/iavf_hash.c
@@ -1390,6 +1390,7 @@ iavf_any_invalid_rss_type(enum rte_eth_hash_function rss_func,
 
 		if (!(rss_type &
 		   (RTE_ETH_RSS_IPV4 | RTE_ETH_RSS_IPV6 |
+		    RTE_ETH_RSS_FRAG_IPV4 | RTE_ETH_RSS_FRAG_IPV6 |
 		    RTE_ETH_RSS_NONFRAG_IPV4_UDP | RTE_ETH_RSS_NONFRAG_IPV6_UDP |
 		    RTE_ETH_RSS_NONFRAG_IPV4_TCP | RTE_ETH_RSS_NONFRAG_IPV6_TCP |
 		    RTE_ETH_RSS_NONFRAG_IPV4_SCTP | RTE_ETH_RSS_NONFRAG_IPV6_SCTP)))
-- 
2.43.5

