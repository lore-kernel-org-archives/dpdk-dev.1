Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE24EC1E98
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 10:31:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68C5640E5E;
	Thu,  5 Feb 2026 11:30:38 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id CFAEB40E7C
 for <dev@dpdk.org>; Thu,  5 Feb 2026 11:30:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770287434; x=1801823434;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=n7ml+b2+1MiL9JOMXplAf9riDV4aU1QCLWBBXJPK55k=;
 b=m783AfpJpPqsP61+htQmdUGNVVVPGnLq5HU93z4MnBOsllnMsw8IQ4H1
 UnMF9zYhp1/w2P+JtNF1oQAmXYzuL8Lbop+EeRx2ypkm+duAs1zKMV41R
 8XF5TZjae0niVfhLOH8LMTyZrV0tpylH9pHccLCPW3EBirycYkiRPue3q
 TC520nBOYyxqu6F7B2MwCRJuS8VmCxkIfM8yWTnGYgzh8xrU4VWI7Qow1
 7xeX7lcS+0C/sQzUYju4h/wD23c+XZAGFi9fZQT9Wn+WW54TbHa4JzePY
 xOtjIQl1RxdBSVfZz496O2+EHx7oJOwUF+XCCVof04D/5smQs7C2Holz7 A==;
X-CSE-ConnectionGUID: nyjt461LTA6+LilZG2t3zg==
X-CSE-MsgGUID: VQXgNQL0QnunJOv82nMHMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="89064783"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; d="scan'208";a="89064783"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2026 02:30:33 -0800
X-CSE-ConnectionGUID: jR2lVJJ+QDOb302zXuXzUw==
X-CSE-MsgGUID: 9dp7R7a6RCCADQ2Q0yLJOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; d="scan'208";a="210447589"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa008.fm.intel.com with ESMTP; 05 Feb 2026 02:30:33 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 09/10] net/idpf: permit secondary process Tx path selection
Date: Thu,  5 Feb 2026 10:30:07 +0000
Message-ID: <20260205103008.190493-10-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205103008.190493-1-ciara.loftus@intel.com>
References: <20260205103008.190493-1-ciara.loftus@intel.com>
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

Commit 7cab7e67363a ("net/idpf: use common Tx path selection
infrastructure") changed the way that secondary processes selected their
Tx burst function. Instead of letting secondary processes select their
own function, they now used the function selected by the primary
process. However, the primary process only selects the function at
device start, so if the primary process hadn't started the device by the
time the secondary process was selecting its Tx burst function, the
secondary process would not select the correct function.

This commit addresses this issue by allowing the secondary process to
select the path if the device has not been started yet.

Fixes: 7cab7e67363a ("net/idpf: use common Tx path selection infrastructure")

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/idpf/idpf_rxtx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/idpf_rxtx.c
index de880bdc5f..344bca995d 100644
--- a/drivers/net/intel/idpf/idpf_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_rxtx.c
@@ -842,8 +842,8 @@ idpf_set_tx_function(struct rte_eth_dev *dev)
 		.single_queue = (vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE)
 	};
 
-	/* The primary process selects the tx path for all processes. */
-	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+	/* If the device has started the function has already been selected. */
+	if (dev->data->dev_started)
 		goto out;
 
 #ifdef RTE_ARCH_X86
-- 
2.43.0

