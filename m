Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AC1606A31E
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 14:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HCXALaoq
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58A5C4064F;
	Wed, 21 Oct 2026 16:26:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 46BF0409FA
 for <dev@dpdk.org>; Wed, 21 Oct 2026 16:26:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792592783; x=1824128783;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=d67POSVzE02qoBXZ68JG/GDmfuII6ixSotMIuQKhh24=;
 b=HCXALaoqVeALmdGDVn9NfywajAM5puigRviBHrtZ26MkeiUy77hx4gYm
 AY3OjZ0QLqs/VJisYySh2OrVgmxVyenbUL8BLtHXZ7NIF/NLsWwacyYc0
 LH50g24+sL/iv+prVRx/aRReBDik1JCDYcfDyWNrh8BdqqesCtqjEo/Wc
 MsRu8ea2nzuDncOtlD71MDgt8Cn2hVlnBlZ9XdIqJsv0w4YD6aSzHpC+g
 Qe+GnH1tEiVrV1qXz5uzNdGG0j+CSNPtlYcSlEwB8hZ0p49f9inhHhGve
 dHD2D7/nbHIYy5IeAZzDkelaYrxr8Errz63RtILaynykxLcBsoIP0OEjg g==;
X-CSE-ConnectionGUID: Dgm+Y/jWTJCM3CoF0hjp+Q==
X-CSE-MsgGUID: 52CSPVZDRfeIhOCWcr4eOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1192971"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1192971"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 07:26:22 -0700
X-CSE-ConnectionGUID: /kj9kpb0S3OwfdEIqX9xLw==
X-CSE-MsgGUID: gPqUAex2QPq7dV0d5nTlJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3570592"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa010.fm.intel.com with ESMTP; 21 Oct 2026 07:26:21 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v4 08/10] net/iavf: remove redundant reset checks from RSS
 engine
Date: Wed, 21 Oct 2026 15:25:48 +0100
Message-ID: <33dc65f213786b0e455f4026ba08c2cfa3bd70b2.1792592724.git.anatoly.burakov@intel.com>
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

