Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A1E606A31B
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 10:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Xgxyk0Ld
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 918FD40664;
	Fri, 23 Oct 2026 12:36:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 7801C40664
 for <dev@dpdk.org>; Fri, 23 Oct 2026 12:36:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792751779; x=1824287779;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qoqJ0t7FCsuLQXR3+4aoGLnP+8SQSaelxa87vNwpUJQ=;
 b=Xgxyk0LdAdZwmNRXyMwjwDjh4LpIA/JsgGi0bpoLP8jxGFPzAhUHVQA7
 XLs8In9x6/weJDB7KuJXWMmpOxVScZzBQhngFjPzmy58pSIb07BYbn9S7
 iOSn4w7S517SvMw3ZM/DlzxJAgQraUqE9A65cHs1nXMTE5hydD5AD/MMS
 j2DZgZVF1wlHSOcNf6O8UXHXOMwunenknNEYtFmaDf4oyRAiSqKTj7Xun
 rXU5LPnDEyY9py9xNWU+JU6Ab1t0yjku368af0Q2fBgDn35bfzuWBLOY1
 g/+2Uf+bQHKNAXCwSK6Nb1effmIIjieIHJPVpU4rkMlZ5fu2ii9B/D7Ar w==;
X-CSE-ConnectionGUID: I7ISi7vfSDu83dnCcKElUQ==
X-CSE-MsgGUID: 0lRZrcVOQXWpAKvp9i5cDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1522872"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1522872"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 03:36:18 -0700
X-CSE-ConnectionGUID: yJD4FelwTISXXJlwy5CmNw==
X-CSE-MsgGUID: UQiI3cuxSfSTh8kC9Fspdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="4098949"
Received: from pae.iind.intel.com (HELO PAE-35.iind.intel.com) ([10.49.105.82])
 by fmviesa010.fm.intel.com with ESMTP; 23 Oct 2026 03:36:17 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH 2/2] net/i40e: fix FDIR memzone leak
Date: Fri, 23 Oct 2026 10:31:30 +0000
Message-Id: <48c8a9473804319897f5d9655c5ff8d8941cae93.1792750212.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1792750212.git.anurag.mandal@intel.com>
References: <cover.1792750212.git.anurag.mandal@intel.com>
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

The memzone holding the flow director programming packets is reserved
in i40e_fdir_setup() but never freed, as i40e_fdir_teardown() only
releases the FDIR queues and VSI.
It is therefore leaked when the port is closed.

Store the memzone pointer and free it on teardown.

Fixes: a778a1fa2e4e ("i40e: set up and initialize flow director")
Fixes: 71d35259ff67 ("i40e: tear down flow director")

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.h | 1 +
 drivers/net/intel/i40e/i40e_fdir.c   | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
index 68bff99b5d..77f79fc7da 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.h
+++ b/drivers/net/intel/i40e/i40e_ethdev.h
@@ -790,6 +790,7 @@ struct i40e_fdir_info {
 	struct ci_rx_queue *rxq;
 	void *prg_pkt[I40E_FDIR_PRG_PKT_CNT];     /* memory for fdir program packet */
 	uint64_t dma_addr[I40E_FDIR_PRG_PKT_CNT]; /* physic address of packet memory*/
+	const struct rte_memzone *prg_mz;         /* memzone backing prg_pkt */
 	/*
 	 * txq available buffer counter, indicates how many available buffers
 	 * for fdir programming, initialized as I40E_FDIR_PRG_PKT_CNT
diff --git a/drivers/net/intel/i40e/i40e_fdir.c b/drivers/net/intel/i40e/i40e_fdir.c
index 71cab77e83..2464eb47c2 100644
--- a/drivers/net/intel/i40e/i40e_fdir.c
+++ b/drivers/net/intel/i40e/i40e_fdir.c
@@ -241,6 +241,8 @@ i40e_fdir_setup(struct i40e_pf *pf)
 			I40E_FDIR_PKT_LEN * i;
 	}
 
+	pf->fdir.prg_mz = mz;
+
 	pf->fdir.match_counter_index = I40E_COUNTER_INDEX_FDIR(hw->pf_id);
 
 	PMD_DRV_LOG(INFO, "FDIR setup successfully, with programming queue %u.",
@@ -297,6 +299,8 @@ i40e_fdir_teardown(struct i40e_pf *pf)
 	pf->fdir.rxq = NULL;
 	i40e_tx_queue_release(pf->fdir.txq);
 	pf->fdir.txq = NULL;
+	rte_memzone_free(pf->fdir.prg_mz);
+	pf->fdir.prg_mz = NULL;
 	i40e_vsi_release(vsi);
 	pf->fdir.fdir_vsi = NULL;
 }
-- 
2.25.1

