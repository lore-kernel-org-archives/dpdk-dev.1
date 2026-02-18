Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34ABCE9A03E
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 09:50:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E36640674;
	Wed, 18 Feb 2026 10:50:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 05CF440647
 for <dev@dpdk.org>; Wed, 18 Feb 2026 10:50:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771408211; x=1802944211;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SM/uixWD0FH7iClDeZVfW+WSg9tDVs8cLmOljjR/S74=;
 b=N89sAJjCmgrUhUrHcJ7FruZ2kyp40eIG6soQO5dtBn+zasI4eX4a3xGk
 q6bbZCBaSJNxoOIpuDbP6OnRP4QUOCl0j/+MBdLExhbIEcYxKZO6sCJvE
 uHO1n3WawHAOPYVssxM9YvIc/6GtDmd3uIwjSiBjoAsv8pxAkJVqP+Loe
 txE3sreD0Md87Zx5gHuNnY9+uK74MB+CT4n73gyBeFX9rZCOdYkFvBAmU
 MzZI9B+tXCwhAMRRg5OgEX6/8YAzSyzSLJ2HL76WfRgzoxaXxy3DF0mvI
 7gNWt9nKHabdkBD82YqyLefuQtXER75dBprE/dCat3dIkwrJLkORvIxog Q==;
X-CSE-ConnectionGUID: OewOtH6aSVWjI6Uf93DLcA==
X-CSE-MsgGUID: KhO9dKftTUear9DcN1Ffjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="83929849"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="83929849"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 01:50:11 -0800
X-CSE-ConnectionGUID: tSg/eCWsSpaGQJnlTvkMeA==
X-CSE-MsgGUID: a+uY32JQSAW7Jsenlrh8Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="214257128"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa007.jf.intel.com with ESMTP; 18 Feb 2026 01:50:10 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v3 08/10] net/ice: permit secondary process Tx path selection
Date: Wed, 18 Feb 2026 09:49:35 +0000
Message-ID: <20260218094937.1652391-9-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260218094937.1652391-1-ciara.loftus@intel.com>
References: <20260205124627.371733-1-ciara.loftus@intel.com>
 <20260218094937.1652391-1-ciara.loftus@intel.com>
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

Commit cf96ec231d02 ("net/ice: use common Tx path selection
infrastructure") changed the way that secondary processes selected their
Tx burst function. Instead of letting secondary processes select their
own function, they now used the function selected by the primary
process. However, the primary process only selects the function at
device start, so if the primary process hadn't started the device by the
time the secondary process was selecting its Tx burst function, the
secondary process would not select the correct function.

This commit addresses this issue by allowing the secondary process to
select the path if the device has not been started yet.

Fixes: cf96ec231d02 ("net/ice: use common Tx path selection infrastructure")

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/ice/ice_rxtx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 637c57b209..31b74be9ba 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -3712,8 +3712,8 @@ ice_set_tx_function(struct rte_eth_dev *dev)
 		.simd_width = RTE_VECT_SIMD_DISABLED,
 	};
 
-	/* The primary process selects the tx path for all processes. */
-	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+	/* If the device has started the function has already been selected. */
+	if (dev->data->dev_started)
 		goto out;
 
 	req_features.simple_tx = ad->tx_simple_allowed;
-- 
2.43.0

