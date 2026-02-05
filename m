Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC41EC1E97
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 10:31:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C6E140EE5;
	Thu,  5 Feb 2026 11:30:37 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 01FE940E42
 for <dev@dpdk.org>; Thu,  5 Feb 2026 11:30:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770287433; x=1801823433;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wcckzaHOZsAOT9AfnJ+eg4ykadPhxay2+85F3c2KJZk=;
 b=bPrIek0FyDB7Ye+7SLUg/cNJ158peF4PO0y4XTHpOWJ2EkQ2ylZpefpn
 CGYVRjAqBRXCspCf7nxAfwyCCXnqD+vSE+YV1m7fvr03HhE9AfwKjDIK7
 IQ35X4HColQCcHGrmxSWN0dPAbSH+zDic7mZHrRDzPjtM2ZHWezNcE42d
 URAeAS1RwTvq081zIAe5WXFJwZPeQYVLUn5ohuRKPH+XxPcEUz21YgGPe
 dhAXl1U2XS369v4cdDUAAm2TTgKaY7UdYhEPLPIqDXoxmqrYet363w6S+
 oJwQQWuude1K6b7MmDN45onO1CzvnQViYkowVPO8v3axAexo+wVDka8rw Q==;
X-CSE-ConnectionGUID: hdfkks4yQ6y0kSFZhg8mVQ==
X-CSE-MsgGUID: T0V/3a8NQq6jFZauzqgpLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="89064781"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; d="scan'208";a="89064781"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2026 02:30:32 -0800
X-CSE-ConnectionGUID: dbbVhgbhQla1zN5GRYJw1g==
X-CSE-MsgGUID: m8gyEVORQfS8MQaMKxVXDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; d="scan'208";a="210447585"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa008.fm.intel.com with ESMTP; 05 Feb 2026 02:30:32 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 08/10] net/ice: permit secondary process Tx path selection
Date: Thu,  5 Feb 2026 10:30:06 +0000
Message-ID: <20260205103008.190493-9-ciara.loftus@intel.com>
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
index bbd9cfa7a5..8ed47b957f 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -4163,8 +4163,8 @@ ice_set_tx_function(struct rte_eth_dev *dev)
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

