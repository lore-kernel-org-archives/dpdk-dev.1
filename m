Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7563E606A320
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 09:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lo0lHJZ/
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B7D740A70;
	Fri, 23 Oct 2026 11:32:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id EC92F40299
 for <dev@dpdk.org>; Fri, 23 Oct 2026 11:32:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792747970; x=1824283970;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=swdNBFBcF0G3iE42aoWI/aEJ3E7oTXtdl58ovfSV3ig=;
 b=lo0lHJZ/1Kqe9EG5JBGb+SOR82iMs/VuiMoXZLiGSxAwPVDJ+Eb80dfi
 qObLmJ5F1y9Xy6rN9VQMwvILU2rfjKnrMj5ZAa2inoE1+iSVBh2uQr67j
 C3od1ffjaQx6XGy2Ea6lP/4OqjFKp7E2568sB0/cKagXMkIeJCuHebtC4
 yNRcsayVLs8tLU1TrXEPv9qtwDN8I7IuQtc5tmJB5y8fbI8VepqJP8lYf
 nZ85RC1Y+2guWzOmQ7pDxwgP5LQVf21j13ixkZ9ep1x4vALclc4hc39E1
 PiUnMgeZ2lF3JgDziqzt8uhco5puLMVAwN4GxNqadq2ypKgKKUWZ2EbPS w==;
X-CSE-ConnectionGUID: StBV2hHiQn+oHM9hpROMjA==
X-CSE-MsgGUID: iU310LhaRtqqTfUfU949AA==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1498294"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1498294"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 02:32:49 -0700
X-CSE-ConnectionGUID: tCjPT0gZT+ydls3PD0OVjA==
X-CSE-MsgGUID: j9MW/8nLQNu80RRzQ8eZ0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3509490"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 23 Oct 2026 02:32:49 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v5 08/10] net/iavf: remove redundant reset checks from RSS
 engine
Date: Fri, 23 Oct 2026 10:32:28 +0100
Message-ID: <34a4794ed70fc331e2b8ac518540fed926815504.1792747917.git.anatoly.burakov@intel.com>
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

The RSS engine checks `vf_reset` during init, destroy and uninit to avoid
sending virtchnl commands while the VF is resetting. These checks are no
longer needed:

- `iavf_hash_init()` only registers the parser and sends no commands.
- `iavf_dev_close()` skips both flow flush and RSS teardown during
  PF-initiated reset recovery.
- the generic flow layer frees rule memory without relying on engine
  callbacks.
- `iavf_execute_vf_cmd()` already refuses to send commands while
  `vf_reset` is set.

Remove these checks as they are no longer needed.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/iavf/iavf_hash.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_hash.c b/drivers/net/intel/iavf/iavf_hash.c
index 6352bf28f93..fe5d725064b 100644
--- a/drivers/net/intel/iavf/iavf_hash.c
+++ b/drivers/net/intel/iavf/iavf_hash.c
@@ -762,9 +762,6 @@ iavf_hash_init(struct iavf_adapter *ad)
 	struct iavf_flow_parser *parser;
 	int ret;
 
-	if (vf->vf_reset)
-		return -EIO;
-
 	if (!vf->vf_res)
 		return -EINVAL;
 
@@ -1601,13 +1598,9 @@ iavf_hash_destroy(__rte_unused struct iavf_adapter *ad,
 		  struct rte_flow *flow,
 		  __rte_unused struct rte_flow_error *error)
 {
-	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(ad);
 	struct virtchnl_rss_cfg *rss_cfg;
 	int ret = 0;
 
-	if (vf->vf_reset)
-		return 0;
-
 	rss_cfg = (struct virtchnl_rss_cfg *)flow->rule;
 
 	ret = iavf_add_del_rss_cfg(ad, rss_cfg, false);
@@ -1633,9 +1626,6 @@ iavf_hash_uninit(struct iavf_adapter *ad)
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(ad);
 	struct rte_eth_rss_conf *rss_conf;
 
-	if (vf->vf_reset)
-		return;
-
 	if (!vf->vf_res)
 		return;
 
-- 
2.52.0

