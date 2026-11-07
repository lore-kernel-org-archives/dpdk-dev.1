Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F61606A326
	for <dpdk-dev@archiver.kernel.org>; Sat,  7 Nov 2026 23:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c7FmAl+x
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C827D40EAB;
	Sun,  8 Nov 2026 00:57:41 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTPS id 25B3B40E24;
 Sun,  8 Nov 2026 00:57:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794095860; x=1825631860;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0tqyWSFpZwBNFxEdPjjoaJsapz3fIgpHAGlePTMh1A0=;
 b=c7FmAl+xHiwOHOgbvQ3YtKZ4UMBfsYAffFWzCqrOmS+vgyBx2AuGAwek
 3Ecprpykal29eccLcOGvaPAaWtMp/4I9SQqahLFzxWYOsTVTxGHbIZCp4
 ZD+UxTt83EsW1gVcMXpf7yCnpHSBfGcS+6PAsYGiOdjCJd6+w1+iaTO14
 5YxVlkzSioyzYVAkeYlZCsHqqjiM47Gg3G9iEiRhC2SttFq830OwTJTCR
 O5yIWNIXWWdP2PDwnumgp44VzcrUBTuxxWXkIloB9YR8S5ShjgcpBXeJ3
 87VP7iHdqrHwQWtUqN9o7cGXJXtW9Gij60eqF1mB5JVABap+22tpD/Qkx A==;
X-CSE-ConnectionGUID: Ns7svnY+RdCzbjGGLdJh6g==
X-CSE-MsgGUID: r04kLTsRTjqq/zd4iwkeAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11959"; a="2885097"
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="2885097"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2026 15:57:39 -0800
X-CSE-ConnectionGUID: LL1NJabgR2uaaVuR0QvvEQ==
X-CSE-MsgGUID: yFZUyJIERb2woNVL+XDeBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="7464664"
Received: from pae.iind.intel.com (HELO PAE-35.iind.intel.com) ([10.49.105.82])
 by orviesa005.jf.intel.com with ESMTP; 07 Nov 2026 15:57:38 -0800
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>, stable@dpdk.org
Subject: [PATCH v2 7/8] net/ice: fix DCF representor info leak on close
Date: Sat,  7 Nov 2026 23:52:17 +0000
Message-Id: <729e11d10701946ba661f1974c3ea72a90df2d7e.1794094943.git.anurag.mandal@intel.com>
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
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

