Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34FA606A33E
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 09:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZZ6jMRGW
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 440FC40E31;
	Thu,  5 Nov 2026 10:53:20 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTPS id B1D8C427A3;
 Thu,  5 Nov 2026 10:53:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793872398; x=1825408398;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=28KNd9NWwZneTgxV/t6Sb9DvHczWp3ouBVFo4GbL3a8=;
 b=ZZ6jMRGWsQeUqWbsi4NRAb7dmSnGvFaI9kF1bYOmP39oFoDb8AU9I4TP
 hp31YBC8/D8/6P32WN4DP/nj2RqRh88G2BRTQHRDIbAgl9Y1tyalEK2pW
 H6R8lOUSqHSXQyzAjw8p5A/rnTSWsMDKgTprI2FNrQ8GrYi5GeOuArVEI
 ZqOVeYKu3qyu8Z7YwaMd36N3f64ue6uYojaByL+fqIKhySjNaY/VH7KY6
 Qdm3RLNK+iQXISAsETUl0Gq98tYIkaBybmB8vf5Dhcl9F3GUwz7LyQ3RH
 ox/PkrM1ge/4wxXlkaYbFJ9DMasQqBQjO7kxdFEQ6arOY3bU3dmGuBJwM g==;
X-CSE-ConnectionGUID: aYrD3muLRmG+zP+LqumffA==
X-CSE-MsgGUID: PSsF4g9hScm5VXsY95AqzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2683973"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2683973"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 01:53:18 -0800
X-CSE-ConnectionGUID: QXNhDlNnR6SsF0KJV2rBYA==
X-CSE-MsgGUID: gNKZkIKPQFSdc9vGLC/JqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7034315"
Received: from pae.iind.intel.com (HELO PAE-35.iind.intel.com) ([10.49.105.82])
 by orviesa006.jf.intel.com with ESMTP; 05 Nov 2026 01:53:16 -0800
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>, stable@dpdk.org
Subject: [PATCH 7/8] net/ice: fix DCF representor info leak on close
Date: Thu,  5 Nov 2026 09:47:24 +0000
Message-Id: <03ede32d5d1c9d92658c07ee7b4136e39446bbd0.1793871697.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1793871697.git.anurag.mandal@intel.com>
References: <cover.1793871697.git.anurag.mandal@intel.com>
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

The representor info array is only freed by ice_dcf_dev_uninit(),
which runs on device removal.
Closing the DCF port with rte_eth_dev_close() releases the port
without freeing it.

Free it in ice_dcf_dev_close().
ice_dcf_dev_reset() needs the info to survive, as init notifies
the representors again, so move the rest of close into
ice_dcf_dev_teardown() and call that from reset instead.

Fixes: c7e1a1a3bfeb ("net/ice: refactor DCF VLAN handling")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/ice/ice_dcf_ethdev.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/net/intel/ice/ice_dcf_ethdev.c b/drivers/net/intel/ice/ice_dcf_ethdev.c
index c78b290b0d..26c22265eb 100644
--- a/drivers/net/intel/ice/ice_dcf_ethdev.c
+++ b/drivers/net/intel/ice/ice_dcf_ethdev.c
@@ -1660,20 +1660,28 @@ ice_dcf_init_repr_info(struct ice_dcf_adapter *dcf_adapter)
 	return 0;
 }
 
-static int
-ice_dcf_dev_close(struct rte_eth_dev *dev)
+static void
+ice_dcf_dev_teardown(struct rte_eth_dev *dev)
 {
 	struct ice_dcf_adapter *adapter = dev->data->dev_private;
 
-	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
-		return 0;
-
 	ice_dcf_vf_repr_notify_all(adapter, false);
 	(void)ice_dcf_dev_stop(dev);
 
 	ice_free_queues(dev);
 	ice_dcf_uninit_parent_adapter(dev);
 	ice_dcf_uninit_hw(dev, &adapter->real_hw);
+}
+
+static int
+ice_dcf_dev_close(struct rte_eth_dev *dev)
+{
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return 0;
+
+	ice_dcf_dev_teardown(dev);
+	/* representor info survives ice_dcf_dev_reset, so only release it here */
+	ice_dcf_free_repr_info(dev->data->dev_private);
 
 	return 0;
 }
@@ -1861,9 +1869,8 @@ ice_dcf_dev_reset(struct rte_eth_dev *dev)
 		ice_dcf_reset_hw(dev, hw);
 	}
 
-	ret = ice_dcf_dev_close(dev);
-	if (ret)
-		return ret;
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY)
+		ice_dcf_dev_teardown(dev);
 
 	ret = ice_dcf_dev_init(dev);
 
-- 
2.25.1

