Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB39606A319
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 09:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fnuluXBS
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6053406BC;
	Tue, 20 Oct 2026 11:11:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 9145E4069F
 for <dev@dpdk.org>; Tue, 20 Oct 2026 11:11:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792487508; x=1824023508;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=FJ1ZlvlawWT9QQOXyt3NMcZoaG/Vwx4oveEJ2m2NSdk=;
 b=fnuluXBSJOmd3Wnh2vR5YPVuwy84b+ucwlJz4bWlyOJX5pkUtp+T5dSx
 LUaaFtR17Fml5Vg0buh6OjsngdMyIdcLh5gfA8S5jIzsXehuN6Y/sEFDS
 kXQJ1tm6DJx/SRB1JWq4Huj6kePTh3nTF9Ex2xqgRAmSoKvKirzpVgRqh
 ar5Jy2rEczmeciGuuAic7tRoEV0prfHF42DCQNNs3PQTIUwtLU2w8tD/T
 qirfkgM2Cvxx+o6EMdfJLPxP7dP+ZxmW/U5BrOwAcTf5BVos6SkVZcJpt
 8P1oLo3i7u8SXiBv1d1uCjWdlXHNz9QORAURkXL5csqY0vrk9TFYXF/39 Q==;
X-CSE-ConnectionGUID: wyDpHlRDSe+sePRmCiC02Q==
X-CSE-MsgGUID: 0oFeNulmSD+0V0NwGTJr6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1286818"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1286818"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 02:11:48 -0700
X-CSE-ConnectionGUID: VB96r/uqSUWK7t+EIDFHNQ==
X-CSE-MsgGUID: xgrrSGjjT86qn822fdhrjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2879463"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa002.fm.intel.com with ESMTP; 20 Oct 2026 02:11:46 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anurag Mandal <anurag.mandal@intel.com>,
 Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v3 07/10] net/iavf: skip RSS teardown during PF-initiated reset
Date: Tue, 20 Oct 2026 10:11:30 +0100
Message-ID: <ddced776cf0b081c3f93b26de8a4a720c153802b.1792487374.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1792487374.git.anatoly.burakov@intel.com>
 <cover.1792487374.git.anatoly.burakov@intel.com>
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
index bb97a89414..cfe5c45e72 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -3254,12 +3254,12 @@ iavf_dev_close(struct rte_eth_dev *dev)
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

