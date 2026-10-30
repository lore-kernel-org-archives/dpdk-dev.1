Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE656606A31D
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 09:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Rm4I31fc
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B099040BA4;
	Fri, 30 Oct 2026 10:41:12 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTPS id 79E5240DCA
 for <dev@dpdk.org>; Fri, 30 Oct 2026 10:41:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793353271; x=1824889271;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=icbouuFRNUUwJxNTDRRjOxgKQpDCPNMUB9RH/PRyi9g=;
 b=Rm4I31fc2KwbU1MOn7EKG8k/M7HO7et6vme3OmK/CzKVtTenWNWaIZVv
 b1dW5vXcpejjTzQmfX5QxuZb8q9BWKGEJWfYg0iFv9ctMr/hX87lhZ22D
 +7wRNFUysn1G8f/ZBAv6nK55HXWOxhA/m4QOxvMXFRdI6jvVV5WGYEcOy
 2FJqKcqY18xB4Jz292COa/kmKpCeg6mV3I3FCmGLSR4ChrALXLTi0FkTG
 +oMJDLtOSQ1GtStZeZHWdPkSpnmvoTdQk2ZFnuc+PLaCNgvBanvzXesIH
 Nc6fcMWlWTuXp42RvT0RjCw2i5iKX2+t6lcHYOtRCQSF7PVxbb+c6GVpi w==;
X-CSE-ConnectionGUID: EWGl7pPyRHCJVEv7x2av7A==
X-CSE-MsgGUID: 3qD3vepKQGKvqYCZwsXqiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2126089"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2126089"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 02:41:10 -0700
X-CSE-ConnectionGUID: CBNHWqQ0RJ+0RVAqzEopVA==
X-CSE-MsgGUID: 84mAlP5ATymRPq98nQ2qzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5299694"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 30 Oct 2026 02:41:09 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 9/9] net/i40e: allow L2 and L3 only hash patterns
Date: Fri, 30 Oct 2026 09:40:22 +0000
Message-ID: <4f5228934ad64d1eb663ccd852d30fe4dfe79d18.1793353215.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <5e64cc416c8ab3b038eee6bb55836e0b8ed507ab.1793353214.git.anatoly.burakov@intel.com>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The hash pattern graph had no END edge after ETH, IPv4 and IPv6, so RSS
rules with patterns ending in one of those items were rejected. They
were supported before the rework.

Add the missing END edges.

Fixes: 3332d0afdb61 ("net/i40e: reimplement hash parser")

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_flow_hash.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_flow_hash.c b/drivers/net/intel/i40e/i40e_flow_hash.c
index 78b0544be63..28f2dd0e708 100644
--- a/drivers/net/intel/i40e/i40e_flow_hash.c
+++ b/drivers/net/intel/i40e/i40e_flow_hash.c
@@ -168,8 +168,10 @@ i40e_hash_get_inset(uint64_t rss_types, bool symmetric_enable)
 
 /*
  * Hash pattern graph implementation
- * Pattern: START -> ETH -> [VLAN] -> [VLAN] -> (IPv4|IPv6) -> (TCP|UDP|SCTP|ESP|L2TPV3OIP|AH)
- *          START -> ETH -> [VLAN] -> [VLAN] -> (IPv4|IPv6) frag
+ * Pattern: START -> ETH
+ *          START -> ETH -> [VLAN] -> [VLAN] -> (IPv4|IPv6)
+ *          START -> ETH -> [VLAN] -> [VLAN] -> (IPv4|IPv6) -> (TCP|UDP|SCTP|ESP|L2TPV3OIP|AH)
+ *          START -> ETH -> [VLAN] -> [VLAN] -> IPv6 -> IPV6_FRAG_EXT
  *          START -> ETH -> [VLAN] -> [VLAN] -> (IPv4|IPv6) -> UDP -> (GTPC|ESP|GTPU)
  *          START -> ETH -> [VLAN] -> [VLAN] -> (IPv4|IPv6) -> UDP -> GTPU -> (IPv4|IPv6)
  */
@@ -491,6 +493,7 @@ static const struct flow_graph i40e_hash_pattern_graph = {
 				I40E_HASH_PATTERN_NODE_OUTER_VLAN,
 				I40E_HASH_PATTERN_NODE_IPV4,
 				I40E_HASH_PATTERN_NODE_IPV6,
+				I40E_HASH_PATTERN_NODE_END,
 				FLOW_GRAPH_NODE_EDGE_END
 			}
 		},
@@ -517,6 +520,7 @@ static const struct flow_graph i40e_hash_pattern_graph = {
 				I40E_HASH_PATTERN_NODE_ESP,
 				I40E_HASH_PATTERN_NODE_L2TPV3OIP,
 				I40E_HASH_PATTERN_NODE_AH,
+				I40E_HASH_PATTERN_NODE_END,
 				FLOW_GRAPH_NODE_EDGE_END
 			}
 		},
@@ -529,6 +533,7 @@ static const struct flow_graph i40e_hash_pattern_graph = {
 				I40E_HASH_PATTERN_NODE_ESP,
 				I40E_HASH_PATTERN_NODE_L2TPV3OIP,
 				I40E_HASH_PATTERN_NODE_AH,
+				I40E_HASH_PATTERN_NODE_END,
 				FLOW_GRAPH_NODE_EDGE_END
 			}
 		},
-- 
2.52.0

