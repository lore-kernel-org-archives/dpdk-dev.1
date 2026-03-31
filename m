Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07204109B461
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 13:02:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF9B040A6F;
	Tue, 31 Mar 2026 15:02:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 6CEB040A6E;
 Tue, 31 Mar 2026 15:02:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774962137; x=1806498137;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0PEoAmJ+ByjQeRiaF48kC3VnGoy9StUXr6r/6qkW3Ek=;
 b=oD6CMkMRRh350SJTyTZ8YIsFirZBEMuDeSwHtEuZz1tWC0kQicCYRb4e
 SdjqCNBWdANtbVSkaqjZlpxO5FbCTmD/+Ak4F1dW8pLmoeP14oA/Ii6Rz
 5iDreWVzxrqdH9MhtKKcJjpYIEejuTzkGRPNbiS59ChH/iH7M/jxi8qza
 +n1sVVJaVw6YbdGyuUpgkJzMq4WY/bscILlprKuyooHoJwO/NhTDVW8L4
 dWztAoHDLbWGFah139kIBAVIXkMpSIGEHkt+yWh3HyGJOA/LrHK1aqaz7
 hucJ6MZiuqyhNC3mV/TV+J1sOpkxoxiu3MJtJHy1JBi80u8HDoCzvNzeE A==;
X-CSE-ConnectionGUID: /b8I/RHtREGTYLdeeFBKew==
X-CSE-MsgGUID: hvBO4ebyS/+d0SCyyw50oA==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="75868411"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="75868411"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 06:02:16 -0700
X-CSE-ConnectionGUID: /V3fUCrCT52zEQctNw+qNg==
X-CSE-MsgGUID: gOAGTJVSTui+nvfSWvnb9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="223481762"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa008.fm.intel.com with ESMTP; 31 Mar 2026 06:02:15 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH 1/4] net/iavf: fix disabling of promiscuous modes on device
 close
Date: Tue, 31 Mar 2026 13:01:17 +0000
Message-ID: <20260331130120.2471971-2-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331130120.2471971-1-ciara.loftus@intel.com>
References: <20260331130120.2471971-1-ciara.loftus@intel.com>
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

Commit 41515403f184 ("net/iavf: disable promiscuous mode on close")
introduced logic that disabled promiscuous mode when closing the device.
However this logic was effectively disabled by commit 676d986b4b86
("net/iavf: fix crash after VF reset failure") which prevented the
configuration of promiscuous mode when the adapter was marked as
"closed". Re-enable the disabling logic by moving it to earlier in the
device close function, before the adapter is marked as "closed".

Fixes: 676d986b4b86 ("net/iavf: fix crash after VF reset failure")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf_ethdev.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 1eca20bc9a..2858cd4cb5 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -2955,6 +2955,12 @@ iavf_dev_close(struct rte_eth_dev *dev)
 		vf->max_rss_qregion = IAVF_MAX_NUM_QUEUES_DFLT;
 	}
 
+	/* Disable promiscuous mode before resetting the VF. This is to avoid
+	 * potential issues when the PF is bound to the kernel driver.
+	 */
+	if (vf->promisc_unicast_enabled || vf->promisc_multicast_enabled)
+		iavf_config_promisc(adapter, false, false);
+
 	adapter->closed = true;
 
 	/* free iAVF security device context all related resources */
@@ -2966,14 +2972,6 @@ iavf_dev_close(struct rte_eth_dev *dev)
 	iavf_flow_flush(dev, NULL);
 	iavf_flow_uninit(adapter);
 
-	/*
-	 * disable promiscuous mode before reset vf
-	 * it is a workaround solution when work with kernel driver
-	 * and it is not the normal way
-	 */
-	if (vf->promisc_unicast_enabled || vf->promisc_multicast_enabled)
-		iavf_config_promisc(adapter, false, false);
-
 	iavf_vf_reset(hw);
 	iavf_shutdown_adminq(hw);
 	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_WB_ON_ITR) {
-- 
2.43.0

