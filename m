Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB25606A324
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 06:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=N2baIe82
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D995941060;
	Tue,  3 Nov 2026 07:49:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTPS id 478E340278;
 Tue,  3 Nov 2026 07:49:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793688582; x=1825224582;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ebzX+96N0s8oXWSoMCfhtkmGOiQQ3NTGyhwMT+39z4o=;
 b=N2baIe82X1BrJ7S9kv+TgU3IdLa0WWrffu7ArP+MzXjS1e4ifGyYpPSJ
 RafZecWz6Kgm6nQjm6iYBwY+czzVE4WqcP6y3ulCZcacoCT3k1Pun0Rvr
 8g0MzUf6pYDZyRSRtGIjgdVgGraN79OL45gq2TNQe6kG9ic+uvXssZDY+
 pEbQUlZNM4NdYrBMGX9etcSA5ffatv69oIUePdvIVONNiwg2vrVDIfOZG
 JhxBtTBG8feauefpPT9FXMLMddB5PYXin66IvuX/rCGvVTsWvyI0S0SzC
 yjaAjSPh3rPrxa/AcJrEZ1C45m7jTtjEFQeGQAtagMNgjQJ0ZyxCbOwuJ A==;
X-CSE-ConnectionGUID: m5I3HTzsQLqIWb5oS35U5A==
X-CSE-MsgGUID: YJQrcNZ6S6ihQN+GvKRcWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2414707"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2414707"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 22:49:27 -0800
X-CSE-ConnectionGUID: tdALLb+KR5STrQM8+KO8ag==
X-CSE-MsgGUID: tRva3uszQYySkKUGDqHfSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="6450588"
Received: from pae.iind.intel.com (HELO PAE-35.iind.intel.com) ([10.49.105.82])
 by fmviesa003.fm.intel.com with ESMTP; 02 Nov 2026 22:49:24 -0800
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>, stable@dpdk.org
Subject: [PATCH] net/ice: fix RSS rule overwriting an existing one
Date: Tue,  3 Nov 2026 06:44:38 +0000
Message-Id: <20261103064438.390149-1-anurag.mandal@intel.com>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

An RSS flow rule only selects the hash input set of a packet type,
& the hardware keeps a single RSS profile per packet type for a
port or the PF VSI.
When a second rule is created for a packet type already used by
another rule, the existing profile is silently replaced, while both
flow handles remain valid.
For example:
  flow create 0 ingress pattern eth / vlan vid is 1500 / ipv6 / end
    actions rss types ipv6 l3-dst-only end queues end / end
  flow create 0 ingress pattern eth / vlan vid is 2640 / ipv6 / end
    actions rss types ipv6 l3-src-only end queues end / end

Only the second rule is applied, whatever the VLAN ID of the packet,
and destroying it, leaves the first rule without any hardware
configuration.

Reject the creation of an RSS rule when another RSS rule of the port
already uses the same protocol header stack.
An outer VLAN header is ignored in the comparison, as it does not
change the packet type.
The existing rule has to be destroyed first to change the hash input
set of that packet type.

Fixes: 5ad3db8d4bdd ("net/ice: enable advanced RSS")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/ice/ice_hash.c | 43 ++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/net/intel/ice/ice_hash.c b/drivers/net/intel/ice/ice_hash.c
index 2930aca228..6643820ae3 100644
--- a/drivers/net/intel/ice/ice_hash.c
+++ b/drivers/net/intel/ice/ice_hash.c
@@ -1311,6 +1311,40 @@ ice_hash_add_raw_cfg(struct ice_adapter *ad,
 	return 0;
 }
 
+/* Check duplicate packet type RSS rule in same port */
+static bool
+ice_hash_ptype_in_use(struct ice_adapter *ad,
+		      const struct ice_hash_flow_cfg *new_cfg)
+{
+	const struct ice_rss_hash_cfg *hash = &new_cfg->rss_cfg.hash;
+	const struct ice_rss_raw_cfg *raw = &new_cfg->rss_cfg.raw;
+	const struct ice_hash_flow_cfg *cfg;
+	struct rte_flow *flow;
+
+	/* flow_ops_lock is held by ice_flow_create() */
+	TAILQ_FOREACH(flow, &ad->pf.flow_list, node) {
+		cfg = flow->rule;
+		if (flow->engine != &ice_hash_engine || cfg->simple_xor ||
+		    cfg->rss_cfg.raw.raw_ena != raw->raw_ena)
+			continue;
+
+		if (raw->raw_ena) {
+			if (ice_find_first_bit(cfg->rss_cfg.raw.prof.ptypes, ICE_FLOW_PTYPE_MAX) ==
+			    ice_find_first_bit(raw->prof.ptypes, ICE_FLOW_PTYPE_MAX))
+				return true;
+			continue;
+		}
+
+		/* an outer VLAN header does not change the packet type */
+		if (cfg->rss_cfg.hash.hdr_type == hash->hdr_type &&
+		    !((cfg->rss_cfg.hash.addl_hdrs ^ hash->addl_hdrs) &
+		      ~ICE_FLOW_SEG_HDR_VLAN))
+			return true;
+	}
+
+	return false;
+}
+
 static int
 ice_hash_create(struct ice_adapter *ad,
 		void *flow_rule,
@@ -1332,6 +1366,15 @@ ice_hash_create(struct ice_adapter *ad,
 
 		goto out;
 	} else {
+		/* Reject duplicate packet type rule in same port */
+		if (ice_hash_ptype_in_use(ad, filter_ptr)) {
+			PMD_DRV_LOG(ERR, "RSS rule for this packet type already exists");
+			rte_flow_error_set(error, EEXIST,
+					   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+					   "RSS rule for this packet type already exists");
+			goto error;
+		}
+
 		if (filter_ptr->rss_cfg.raw.raw_ena) {
 			ret = ice_hash_add_raw_cfg(ad, &filter_ptr->rss_cfg.raw,
 						   pf->main_vsi->idx);
-- 
2.25.1

