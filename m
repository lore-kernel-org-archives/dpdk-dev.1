Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD95EC1E97
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 10:31:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D4DF40EDB;
	Thu,  5 Feb 2026 11:30:35 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 52B2B40E4F
 for <dev@dpdk.org>; Thu,  5 Feb 2026 11:30:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770287431; x=1801823431;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Jc8eIV3UzZPqAHky3IZnp1j0yE9o24OhRDzKZdvucTI=;
 b=CZTXcJYRKZRZ+XJ8nZCYUA6QlYJCwlrnkSbrCHHgvHxaMLsFeh1rARTm
 s7gqGUbu3JNmxEOveJhEK4Wece+i0Ie1bNzevgE5aunlC6zwDhDr5QxI9
 RbB1ZbjXEEVjRQDzH28dO1RG//N9p5I2pyWOu1E0S6qa+QSHG+pigzSn5
 VPRyL5wCRSfVUqRc8lS8fEhMeiOpOeL4Rq4frCvyBcKOzsSjIXwhb/Js1
 5dwTJzEyycr8D6rS5YVvjRKi0On50L8Rul9KU22hBhDcxPT0zA2n+5jYE
 xkXu84uqL1ohBUmtkL174MOQz3jqIlcVmbVwIS/ewOUIPJcfQgQYE0pFh Q==;
X-CSE-ConnectionGUID: rnqbHlEkTDm4c4a7ykOGVw==
X-CSE-MsgGUID: 5ZI3IY2QTXOwIJnC5yTovg==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="89064775"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; d="scan'208";a="89064775"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2026 02:30:31 -0800
X-CSE-ConnectionGUID: mDF5kXr0SbuH2/1iRYlB0w==
X-CSE-MsgGUID: /dADz1QoSMWfW0yjQYBcNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; d="scan'208";a="210447575"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa008.fm.intel.com with ESMTP; 05 Feb 2026 02:30:30 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 06/10] net/i40e: permit secondary process Tx path selection
Date: Thu,  5 Feb 2026 10:30:04 +0000
Message-ID: <20260205103008.190493-7-ciara.loftus@intel.com>
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

Commit 8d57c1788806 ("net/i40e: use common Tx path selection
infrastructure") changed the way that secondary processes selected their
Tx burst function. Instead of letting secondary processes select their
own function, they now used the function selected by the primary
process. However, the primary process only selects the function at
device start, so if the primary process hadn't started the device by the
time the secondary process was selecting its Tx burst function, the
secondary process would not select the correct function.

This commit addresses this issue by allowing the secondary process to
select the path if the device has not been started yet.

Fixes: 8d57c1788806 ("net/i40e: use common Tx path selection infrastructure")

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/i40e/i40e_rxtx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index 3deeff165d..1c46e19582 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -3597,8 +3597,8 @@ i40e_set_tx_function(struct rte_eth_dev *dev)
 		.simple_tx = ad->tx_simple_allowed
 	};
 
-	/* The primary process selects the tx path for all processes. */
-	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+	/* If the device has started the function has already been selected. */
+	if (dev->data->dev_started)
 		goto out;
 
 	if (ad->tx_vec_allowed) {
-- 
2.43.0

