Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46498EC1EAF
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 12:47:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3300A410F9;
	Thu,  5 Feb 2026 13:46:48 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 18AAE40E8A
 for <dev@dpdk.org>; Thu,  5 Feb 2026 13:46:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770295603; x=1801831603;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=S8uDXyoUtSX6y9HrvQ01cEEsjPijHPgMqmHktgUUSaE=;
 b=LolU03RM1966UCGPuJVkmrN9rjmnQ7rWpFTXCF9pg8H7PnGlkwMJPzG7
 50SV2MmJhrKoAJTi4dlxQeW0QJYZAMFwqvy8R4Ni6F9oy+NhUxn6BhdF/
 3tRdRQ1R6DSUAx6SAYlRwra2zzvCbrfcL4OVmyJGvujTIW1RYD7/4NU+q
 hDI1oA8++pMai1qEpKaDvIFg4Gdg/YjQhtmfYUuujS8xj4DR+58Wj64nt
 OW96tx3Ijs3nFdTOcg56MaVnN4comF/lbTDoztegYVJts3zuR5Z96ZW3J
 e5maC86QHYEh17Tpt8HoU7w0R2FgxBHBXcEb5skIQrgv3x2z7M8UmV4Pd w==;
X-CSE-ConnectionGUID: p0m6YW+kSVSz14zBOq6K+Q==
X-CSE-MsgGUID: oUT+btFpR2+gzbbi/LEXmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71481860"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; d="scan'208";a="71481860"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2026 04:46:42 -0800
X-CSE-ConnectionGUID: 7loT6SW5R1qMFWTW2Opp4w==
X-CSE-MsgGUID: uSvytHJ8TkSkmEPUA1ZjdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; d="scan'208";a="233454878"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa002.fm.intel.com with ESMTP; 05 Feb 2026 04:46:42 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 07/10] net/iavf: permit secondary process Tx path selection
Date: Thu,  5 Feb 2026 12:46:24 +0000
Message-ID: <20260205124627.371733-8-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205124627.371733-1-ciara.loftus@intel.com>
References: <20260205103008.190493-1-ciara.loftus@intel.com>
 <20260205124627.371733-1-ciara.loftus@intel.com>
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

Commit ebcfb039afa8 ("net/iavf: use common Tx path selection
infrastructure") changed the way that secondary processes selected their
Tx burst function. Instead of letting secondary processes select their
own function, they now used the function selected by the primary
process. However, the primary process only selects the function at
device start, so if the primary process hadn't started the device by the
time the secondary process was selecting its Tx burst function, the
secondary process would not select the correct function.

This commit addresses this issue by allowing the secondary process to
select the path if the device has not been started yet.

Fixes: ebcfb039afa8 ("net/iavf: use common Tx path selection infrastructure")

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf_rxtx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index bca80eccfa..abe0f7c529 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -4235,8 +4235,8 @@ iavf_set_tx_function(struct rte_eth_dev *dev)
 		.simd_width = RTE_VECT_SIMD_DISABLED,
 	};
 
-	/* The primary process selects the tx path for all processes. */
-	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+	/* If the device has started the function has already been selected. */
+	if (dev->data->dev_started)
 		goto out;
 
 #ifdef RTE_ARCH_X86
-- 
2.43.0

