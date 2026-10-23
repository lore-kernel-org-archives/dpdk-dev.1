Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21964606A31E
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 09:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NnTBjnCK
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 227BA40A67;
	Fri, 23 Oct 2026 11:32:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 1322340299
 for <dev@dpdk.org>; Fri, 23 Oct 2026 11:32:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792747969; x=1824283969;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=p6B8KZDe3eHay8EIm6IY77yncPaW3NNv2RmoLHd6Ccg=;
 b=NnTBjnCKUXQkYQRgF8obnFXVqrxzTThPZHEMkTrcPY5/m41/JxHVb/sL
 OYBmcS6dcYAjnBhA9KuzNa0i6s4bR0giJPkxdTTINYD2LHKwwdYqg7EtC
 fK+QAVbUe0LLKuFVLVi5bjndxsaM6RdsKRLNCS/2g//XBPIsbePGeuP2m
 JBHiax9zMWG1x9gpjIkHe0ljFhncj/qImF65958QKmls4wTEWXP+y4C4A
 2RKxM9KK1x4MdJzI5d5Br/ieel6HgalFLdx0rzIbO0TOZ1mAZo63GGeKC
 EnUDIlKWNPz4nQADDT7O9b6d9PmodRH6mm/JkiWz1zeTTjn+BsQ2yfV1X Q==;
X-CSE-ConnectionGUID: JySjHhKeQqKAdM3PITv4cw==
X-CSE-MsgGUID: mRP3wWjHTGOmKBDDDTdriA==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1498292"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1498292"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 02:32:48 -0700
X-CSE-ConnectionGUID: ebOheibgRB+j23VsJJ6Y+w==
X-CSE-MsgGUID: ab6CuioOSNGdxAWt5Q8o8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3509486"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 23 Oct 2026 02:32:47 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anurag Mandal <anurag.mandal@intel.com>,
 Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v5 07/10] net/iavf: skip RSS teardown during PF-initiated reset
Date: Fri, 23 Oct 2026 10:32:27 +0100
Message-ID: <1377834788541020e747d6d4478e5016598dd97d.1792747917.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1792747916.git.anatoly.burakov@intel.com>
 <cover.1792747916.git.anatoly.burakov@intel.com>
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/iavf/iavf_ethdev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index f428eb3becb..41f5a638bc1 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -3245,12 +3245,12 @@ iavf_dev_close(struct rte_eth_dev *dev)
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

