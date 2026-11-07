Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DCF606A326
	for <dpdk-dev@archiver.kernel.org>; Sat,  7 Nov 2026 23:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OdLQ+ok/
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B223E40E7C;
	Sun,  8 Nov 2026 00:57:38 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTPS id 5A22840609;
 Sun,  8 Nov 2026 00:57:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794095857; x=1825631857;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lImcZFU2xJKhe0PlmF6ucSGPARFWPUuhshs/UrQhnr4=;
 b=OdLQ+ok/QzbpJHwSObkZeHTrbUnfscIScR+UY4wsOjMRv/Iy1UZJMwGT
 7lzhhSQrgFdzLyX6IUR45FhYvGOVN3Fi31GHyikahCTtTSOuMEcDMVZl8
 zJccH/+16+q2QtmsKvAaikm9CdYSSDK4zSIGwweky6ih6oNs0UAunF/U3
 qLL4FzziPEmvnYH+6/pbBDvpPWCtEzTqYO9BH2y8Lqb8wtxAuhunSsj5+
 jp+VGua/BAFEdDSNC89BkYAV9tXmqFRRLkgLEGiSVm3yDA+glSjBiZXVg
 SywY6dM28LiM9rRnfAc507jKYv7luPt4sXWBL8p4lReyl2v7JdGSh+25e g==;
X-CSE-ConnectionGUID: +U/HhnItTW6XpsIMiGpo3w==
X-CSE-MsgGUID: ePIlpc9LQyGP5Cvj2WeLDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11959"; a="2885093"
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="2885093"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2026 15:57:37 -0800
X-CSE-ConnectionGUID: dTEKwWdaQHmgBMIHUSV21g==
X-CSE-MsgGUID: cXQFGAYtTomrSMGYZIbJCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="7464653"
Received: from pae.iind.intel.com (HELO PAE-35.iind.intel.com) ([10.49.105.82])
 by orviesa005.jf.intel.com with ESMTP; 07 Nov 2026 15:57:35 -0800
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>, stable@dpdk.org
Subject: [PATCH v2 6/8] net/ice: fix DCF TM config leak on close
Date: Sat,  7 Nov 2026 23:52:16 +0000
Message-Id: <eb70a5f5872afb65b2b2fdb65a14a6935d0b9507.1794094943.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1794094943.git.anurag.mandal@intel.com>
References: <cover.1794094943.git.anurag.mandal@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ice_dcf_uninit_hw() releases the TM nodes and shaper profiles only
when the hierarchy gets committed.
If the application adds nodes or profiles but never commits them,
or the commit fails without clearing them, they leak on close and
reset.

Only clearing the bandwidth needs a committed hierarchy,
so releasing the TM config whenever QoS is supported.

Fixes: 775a25a372f5 ("net/ice: clear QoS bandwidth on DCF close")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ice/ice_dcf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/ice/ice_dcf.c b/drivers/net/intel/ice/ice_dcf.c
index 4bc3c07d81..ad5f9ef78e 100644
--- a/drivers/net/intel/ice/ice_dcf.c
+++ b/drivers/net/intel/ice/ice_dcf.c
@@ -886,11 +886,11 @@ ice_dcf_uninit_hw(struct rte_eth_dev *eth_dev, struct ice_dcf_hw *hw)
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	uint16_t i;
 
-	if (hw->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_QOS)
-		if (hw->tm_conf.committed) {
+	if (hw->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_QOS) {
+		if (hw->tm_conf.committed)
 			ice_dcf_clear_bw(hw);
-			ice_dcf_tm_conf_uninit(eth_dev);
-		}
+		ice_dcf_tm_conf_uninit(eth_dev);
+	}
 
 	ice_dcf_disable_irq0(hw);
 	rte_intr_disable(intr_handle);
-- 
2.25.1

