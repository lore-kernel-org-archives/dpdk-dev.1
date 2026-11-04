Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BA5606A330
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 09:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KOB2hqNz
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C0794028F;
	Wed,  4 Nov 2026 10:55:33 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTPS id 13C8140151;
 Wed,  4 Nov 2026 10:55:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793786130; x=1825322130;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=noX5p8DmNTLTN8IsZnTExulbsNEn/ObGSa9NazjaW1Q=;
 b=KOB2hqNzhkSKiGWnHfAlccDPoPfK1wQpve+5cNRprJUGZA00z5OtJv3v
 Mc3/Ed/dgncHp6q4rVfmwM1C2UuzpHvVJdCnqA8WHdLkBJhWGTalFUiIk
 aZstYyWn+rcEayBr/lzg7q+h7o1bpO8bEU9gVFdXpPFBPf0EkxsOdyRhr
 +CU+/fs9QOBDhi9yz5YMy/5GTP4HVeRcik8F57H0sLh9t5Bv9w6z21HzL
 q/Mz/vjMg9PaUj/HxAdIbLtikHIXUYzr9fdAOVcKZsdnQIoWm2bTq0Twc
 IbMPtGV4J/R4fe3avgu1f+QM13s6B5RAUkojuTLWkpNDhzdNqNFGY9a9A w==;
X-CSE-ConnectionGUID: x8qVpx+URa+0bciY1m+ngg==
X-CSE-MsgGUID: 6JWumBj4R4Ofp2BYvOWJnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2432702"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2432702"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 01:55:28 -0800
X-CSE-ConnectionGUID: BYnE7vtqRVixr/iF2CoTjw==
X-CSE-MsgGUID: aSKWzDKXSlO0EjfffhFQqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6699072"
Received: from silpixa00401177.ir.intel.com (HELO vm-icx177..)
 ([10.20.224.214])
 by orviesa001.jf.intel.com with ESMTP; 04 Nov 2026 01:55:27 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH v2 2/3] net/iavf: fix event handler leak on init failure
Date: Wed,  4 Nov 2026 09:55:08 +0000
Message-ID: <20261104095510.10246-3-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104095510.10246-1-ciara.loftus@intel.com>
References: <20261104095510.10246-1-ciara.loftus@intel.com>
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

iavf_dev_init() takes a reference on the shared event handler, but
does not release it if initialisation subsequently fails. The event
thread and its pipe are then never released.

Release the reference on these error paths. Skip it during reset
recovery, where no reference is taken.

Fixes: cb5c1b91f76f ("net/iavf: add thread for event callbacks")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf_ethdev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index fd1067c252..38bf2e502a 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -3089,6 +3089,8 @@ iavf_dev_init(struct rte_eth_dev *eth_dev)
 
 	if (iavf_init_vf(eth_dev) != 0) {
 		PMD_INIT_LOG(ERR, "Init vf failed");
+		if (!rte_atomic_load_explicit(&vf->in_reset_recovery, rte_memory_order_relaxed))
+			iavf_dev_event_handler_fini();
 		return -1;
 	}
 
@@ -3185,6 +3187,9 @@ iavf_dev_init(struct rte_eth_dev *eth_dev)
 
 	eth_dev->data->mac_addrs = NULL;
 
+	if (!rte_atomic_load_explicit(&vf->in_reset_recovery, rte_memory_order_relaxed))
+		iavf_dev_event_handler_fini();
+
 init_vf_err:
 	iavf_uninit_vf(eth_dev);
 
-- 
2.43.0

