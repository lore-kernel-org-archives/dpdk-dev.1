Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E609A606A335
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 10:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iBfIrudF
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D691E40275;
	Mon, 26 Oct 2026 11:51:55 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTPS id D11464026A;
 Mon, 26 Oct 2026 11:51:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793011914; x=1824547914;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=6Ks60M93GUeI9FJno4c6263ydYZKgUqJjvwPjfe7sJY=;
 b=iBfIrudFrvWncXWIrxr7DpUofyfeaCczlScecEjIZDNEDrC6SdazCwi5
 +tRP+np4T/vheLw2Tio0AvkMKkNqhskrSLbX0GWj0f9XODp4+kINXzV/0
 jUwyfotbUkwfuLy5efbFHQL1wZVNS9tbM7utqiqGmVuDyFObExEoW5WQy
 k2JZ7DhgTnGxxof18UJl3/InNAe/X4aENl1Oqr2aSXsf3+YFysFZZ+Tf2
 xjaNQMozCVhcKrpOx/S4f/mRL52XYByez8amvZ57DYvD8RXbuL5TpJQ2N
 m7Zr9xKly5VdEkvZmdgP2iJ5yhmXkZkF0zS2Gjm6/R3HwXbq/kpYT0lUs g==;
X-CSE-ConnectionGUID: 7q7bTjQFQSiqb3gQIokJrw==
X-CSE-MsgGUID: 9PC2jNBoRf6Mn81hhdMpNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1782002"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1782002"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 03:51:52 -0700
X-CSE-ConnectionGUID: VWvRpgZES8eHQM8tL04n0w==
X-CSE-MsgGUID: yDPZInHLR66+D9dPisRu0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4587115"
Received: from pae.iind.intel.com (HELO PAE-35.iind.intel.com) ([10.49.105.82])
 by fmviesa001.fm.intel.com with ESMTP; 26 Oct 2026 03:51:49 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, vladimir.medvedkin@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>, stable@dpdk.org
Subject: [PATCH] net/iavf: fix RSS rule overwriting an existing one
Date: Mon, 26 Oct 2026 10:47:11 +0000
Message-Id: <20261026104711.175208-1-anurag.mandal@intel.com>
X-Mailer: git-send-email 2.25.1
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

An RSS flow rule only selects the hash input set of a packet type, and
the PF keeps a single configuration per packet type for the VF VSI.
When a second rule is created for a packet type already used by another
rule, the PF silently replaces the first configuration, while both flow
handles remain valid.
For example,:

  flow create 0 ingress pattern eth / vlan vid is 1500 / ipv6 / end
    actions rss types ipv6 l3-dst-only end queues end / end
  flow create 0 ingress pattern eth / vlan vid is 2640 / ipv6 / end
    actions rss types ipv6 l3-src-only end queues end / end

Only the second rule is applied, whatever the VLAN ID of the packet, and
destroying it leaves the first rule without any hardware configuration.

Reject the creation of an RSS rule when another RSS rule of the port
already uses the same protocol header stack. The existing rule has to
be destroyed first to change the hash input set of that packet type.
Raw pattern rules are not checked, as their packet type is only known
by the PF parser.

Fixes: 7be10c3004be ("net/iavf: add RSS configuration for VF")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/iavf/iavf_hash.c | 47 ++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/net/intel/iavf/iavf_hash.c b/drivers/net/intel/iavf/iavf_hash.c
index fe5d725064..c079511898 100644
--- a/drivers/net/intel/iavf/iavf_hash.c
+++ b/drivers/net/intel/iavf/iavf_hash.c
@@ -1571,6 +1571,44 @@ iavf_hash_parse_pattern_action(struct iavf_adapter *ad,
 	return ret;
 }
 
+/* Check duplicate packet type RSS rule in same VSI */
+static bool
+iavf_hash_ptype_in_use(struct iavf_adapter *ad,
+		       const struct virtchnl_proto_hdrs *hdrs)
+{
+	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(ad);
+	const struct virtchnl_rss_cfg *cfg;
+	struct rte_flow *flow;
+	bool found = false;
+	int i;
+
+	/* the packet type of a raw pattern is only known by the PF parser */
+	if (hdrs->count == 0)
+		return false;
+
+	rte_spinlock_lock(&vf->flow_ops_lock);
+	TAILQ_FOREACH(flow, &vf->flow_list, node) {
+		cfg = flow->rule;
+		if (flow->engine != &iavf_hash_engine || cfg == NULL ||
+		    cfg->proto_hdrs.tunnel_level != hdrs->tunnel_level ||
+		    cfg->proto_hdrs.count != hdrs->count)
+			continue;
+
+		for (i = 0; i < hdrs->count; i++) {
+			if (cfg->proto_hdrs.proto_hdr[i].type != hdrs->proto_hdr[i].type)
+				break;
+		}
+
+		if (i == hdrs->count) {
+			found = true;
+			break;
+		}
+	}
+	rte_spinlock_unlock(&vf->flow_ops_lock);
+
+	return found;
+}
+
 static int
 iavf_hash_create(struct iavf_adapter *ad,
 		 struct rte_flow *flow, void *meta,
@@ -1579,6 +1617,15 @@ iavf_hash_create(struct iavf_adapter *ad,
 	struct virtchnl_rss_cfg *rss_cfg = meta;
 	int ret = 0;
 
+	/* Reject duplicate packet type rule in same VSI */
+	if (iavf_hash_ptype_in_use(ad, &rss_cfg->proto_hdrs)) {
+		PMD_DRV_LOG(ERR, "RSS rule for this packet type already exists");
+		rte_flow_error_set(error, EEXIST,
+				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				   "RSS rule for this packet type already exists");
+		return -rte_errno;
+	}
+
 	ret = iavf_add_del_rss_cfg(ad, rss_cfg, true);
 	if (!ret) {
 		flow->rule = rss_cfg;
-- 
2.25.1

