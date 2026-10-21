Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBEF606A321
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 14:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=J4ORXQer
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A2AB40A70;
	Wed, 21 Oct 2026 16:26:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 5D0BF406B6
 for <dev@dpdk.org>; Wed, 21 Oct 2026 16:26:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792592781; x=1824128781;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=gfBCbbEF1EI0DX8e2LNbNwZl3U7EsOrUx0GR/WpK/wc=;
 b=J4ORXQermZqZ3b7eY44mtZTPnioX6ACRB6E7PRpBWCrJPOLyZMGqVtG9
 LaVB3rKEhlZUhYDAUU2J/zUG45p46+PoHKss2XikxpPd5bWNHUqsEJxtJ
 +TjrQ581Armo00tlov14Ir7UFAXwEMpuiWlvKPiB4mdGUt3EBwu3/1yAV
 6cWGliBnW/Zw5IsVpeuokXaEsmkBD/202RZrMW34Y65hDJnpfGFIsP+uO
 3eK6DD4NyVHp2eYzWLdNmRa1vYzXztVkecrgFtmFsqL0lNfJXgo/45QV3
 VZn15aVJ4jPEVP7NNgdEWHCdWXGORUEwRaMlq9c4U2P6w9lX9/if2qQbq g==;
X-CSE-ConnectionGUID: iU818+k2RUanNnhz7BudpQ==
X-CSE-MsgGUID: iGLVT+lqQHa89dh7ARHW0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1192967"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1192967"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 07:26:20 -0700
X-CSE-ConnectionGUID: +YiS8xmFSYyj9hhlgBuamg==
X-CSE-MsgGUID: nZIa9SrsSOqoA5RZ9vu8bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3570568"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa010.fm.intel.com with ESMTP; 21 Oct 2026 07:26:19 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anurag Mandal <anurag.mandal@intel.com>,
 Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v4 07/10] net/iavf: skip RSS teardown during PF-initiated reset
Date: Wed, 21 Oct 2026 15:25:47 +0100
Message-ID: <5a5434a307a61a2463a154db7b30baeb40834fd5.1792592724.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1792592724.git.anatoly.burakov@intel.com>
 <cover.1792592724.git.anatoly.burakov@intel.com>
References: 
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

During PF-initiated reset recovery, `iavf_dev_close()` skips flow flush
to avoid sending virtchnl messages to the PF. However, `iavf_hash_uninit()`
is still called unconditionally, even though any existing RSS configuration
is now invalid because of PF-initiated reset.

Move the RSS teardown under the same `pf_reset_in_progress` check as flow
flush, so that no RSS configuration messages are sent during PF-initiated
reset recovery.

Fixes: 4dad1a6815d6 ("net/iavf: skip flow flush during PF-initiated reset")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_ethdev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 891880cf6e6..26f891515ec 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -3246,12 +3246,12 @@ iavf_dev_close(struct rte_eth_dev *dev)
 	/* free iAVF security device context all related resources */
 	iavf_security_ctx_destroy(adapter);
 
-	/* remove RSS configuration */
-	iavf_hash_uninit(adapter);
-
 	/* Skip the virtchnl-emitting teardown on a PF-initiated reset */
-	if (!vf->pf_reset_in_progress)
+	if (!vf->pf_reset_in_progress) {
+		/* remove RSS configuration */
+		iavf_hash_uninit(adapter);
 		iavf_flow_flush(dev, NULL);
+	}
 	iavf_flow_uninit(adapter);
 
 	/*
-- 
2.52.0

