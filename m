Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0098BC55183
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 10:01:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E673A402C6;
	Fri, 20 Feb 2026 11:01:11 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 1FF3C4026D
 for <dev@dpdk.org>; Fri, 20 Feb 2026 11:01:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771581671; x=1803117671;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=cR6H0lIjvnZwzD0waa7IxRCROyMKRdCxJ9OHiirb2nI=;
 b=b9z5lBPYgUUCY606o/DKvh+v+Gk8SeJDfkJQNwELzkhdAHS6iXFdu1vR
 w0RZnFY7vPdjOGMMYgF3OoIn3TU5vEollJadVb+dA8YVujMMB4G5fdAby
 CK7fN6n+YodlkPv/YGo2EEw96IGpM9CvCgjPlZ76Y9FrOHFDPiwOlCeCf
 6I1DL2rWQe/t83ePyEv3npxzavZyCv2Am1lFf5ahZq41vhpNiJFmIOrx9
 c/WKjC4hYMC8vTW4LMs/vNz7Cis99M6hOyKni6ZPBJPZlA9+z9qu5KYHV
 Z+dA5qdzVbiLsqySS3UMEEB2L3ea2kvy7t2eM7xPMacxCG10zEUzTzQFm Q==;
X-CSE-ConnectionGUID: VzJiwNBYT/acWpQtOBRrxg==
X-CSE-MsgGUID: DG4q67s/Sx6w3hrcv/dmbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="90084283"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; d="scan'208";a="90084283"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2026 02:01:10 -0800
X-CSE-ConnectionGUID: PqojGV0HS82G5pg53Tp8vw==
X-CSE-MsgGUID: ChOd1WzuS5m5BM+PYFsB0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; d="scan'208";a="219816029"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa005.jf.intel.com with ESMTP; 20 Feb 2026 02:01:09 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Qi Zhang <qi.z.zhang@intel.com>, Radu Nicolau <radu.nicolau@intel.com>
Subject: [PATCH v1 1/1] net/iavf: fix incorrect struct in status get
Date: Fri, 20 Feb 2026 10:01:07 +0000
Message-ID: <c87355f75826ec90a506dc8d4548e3f6af2b7e93.1771581658.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
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

Current code for getting crypto status is using sizeof() of cap struct
instead of status structure. This is not a big problem because cap struct
is a lot bigger, but the code is misleading. Fix it to use the correct
struct.

Fixes: 3940cd9b8cb3 ("net/iavf: fix device initialization without inline crypto")
Cc: radu.nicolau@intel.com
Cc: stable@dpdk.org

Reported-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_ipsec_crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/iavf/iavf_ipsec_crypto.c b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
index 6d41b1744e..ab41b1973e 100644
--- a/drivers/net/intel/iavf/iavf_ipsec_crypto.c
+++ b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
@@ -1600,7 +1600,7 @@ iavf_ipsec_crypto_status_get(struct iavf_adapter *adapter,
 	}
 
 	response_len = sizeof(struct inline_ipsec_msg) +
-			sizeof(struct virtchnl_ipsec_cap);
+			sizeof(struct virtchnl_ipsec_status);
 	response = rte_malloc("iavf-device-status-response",
 			response_len, 0);
 	if (response == NULL) {
-- 
2.47.3

