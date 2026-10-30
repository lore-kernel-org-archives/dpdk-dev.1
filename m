Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEAB606A31D
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 09:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GRUklW/s
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A54FA40A6C;
	Fri, 30 Oct 2026 10:40:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTPS id B09604027B
 for <dev@dpdk.org>; Fri, 30 Oct 2026 10:40:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793353249; x=1824889249;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=i69GU3LmdVjpCYl50MfnwcTezEmYgKx+U/5sW2z37y4=;
 b=GRUklW/sthItuxN852Uc6DM7aVP6usrprXGtUQJi6Dr+bj6j0eLpCJj5
 CJFq94kmFLjBPnaCyW+MOZHbhbWw3WiEnEg6CZ9gGnkjpOLyOsilmXg8f
 XgETqTLGKyTX6hSihhrnDVjCzxDNBCppaLA513h5hiS1T4K7X4U0ef5MR
 MDBio7PuB8I9oKO0LMj9iMdexoH3RqDWns/zJU9m60BYeJhmDkNq/0XUE
 LvVYCua1DsRlus/spmNmOBZNS5Wfja0CR2GTG81OnAq0RIrSESh0k4gCX
 iQCIfrNYGWUDcxrjFE+089TR5sY8ZZIE3vD+fgXFX4kAIBGUyxXIODB7v g==;
X-CSE-ConnectionGUID: FFu0vE3WSyijyc7BYGn1Yw==
X-CSE-MsgGUID: PLfoWTlySRee5kkpN+ROsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2126036"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2126036"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 02:40:49 -0700
X-CSE-ConnectionGUID: xVuQ4h+GQOmcyaCpPTJpiQ==
X-CSE-MsgGUID: VX9ZmPTBTDCJDtl8PUjSmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5299609"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 30 Oct 2026 02:40:49 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 2/9] net/i40e: reject VLAN with tunnel items in FDIR flows
Date: Fri, 30 Oct 2026 09:40:15 +0000
Message-ID: <6cb6188aaf9c36b9b2f0c2ee6fcf75cbcba1f480.1793353214.git.anatoly.burakov@intel.com>
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

The FDIR pattern graph allowed VLAN in front of ESP, L2TPv3 and GTP
items. These use customized pctypes whose input set does not include
the VLAN tag, so the VLAN match was silently ignored. Such patterns
were not accepted before the rework either.

Make VLAN lead to separate IPv4, IPv6 and UDP nodes that have no tunnel
successors.

Fixes: 05432a6e4676 ("net/i40e: reimplement FDIR parser")

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_flow_fdir.c | 65 +++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_flow_fdir.c b/drivers/net/intel/i40e/i40e_flow_fdir.c
index 197b93f3746..276738907ad 100644
--- a/drivers/net/intel/i40e/i40e_flow_fdir.c
+++ b/drivers/net/intel/i40e/i40e_flow_fdir.c
@@ -45,7 +45,8 @@ struct i40e_fdir_engine_priv {
 
 /**
  * FDIR graph implementation (non-tunnel)
- * Pattern: START -> ETH -> [VLAN] -> (IPv4 | IPv6) -> [TCP | UDP | SCTP | ESP | L2TPv3 | GTP] -> END
+ * Pattern: START -> ETH -> (IPv4 | IPv6) -> [TCP | UDP | SCTP | ESP | L2TPv3 | GTP] -> END
+ *          START -> ETH -> VLAN -> (IPv4 | IPv6) -> [TCP | UDP | SCTP] -> END
  * With RAW flexible payload support:
  *   - L2: ETH/VLAN -> RAW -> RAW -> RAW -> END
  *   - L3: IPv4/IPv6 -> RAW -> RAW -> RAW -> END
@@ -53,6 +54,9 @@ struct i40e_fdir_engine_priv {
  * GTP tunnel support:
  *   - IPv4/IPv6 -> UDP -> GTP -> END (GTP-C, GTP-U outer)
  *   - IPv4/IPv6 -> UDP -> GTP -> IPv4/IPv6 -> END (GTP-U with inner IP)
+ * VLAN cannot be combined with ESP, L2TPv3 or GTP: these use customized
+ * pctypes whose input set does not include the VLAN tag, so VLAN is followed
+ * by separate IP/UDP nodes that do not lead to any of them.
  */
 
 enum i40e_fdir_node_id {
@@ -70,6 +74,9 @@ enum i40e_fdir_node_id {
 	I40E_FDIR_NODE_GTPU,
 	I40E_FDIR_NODE_INNER_IPV4,
 	I40E_FDIR_NODE_INNER_IPV6,
+	I40E_FDIR_NODE_VLAN_IPV4,
+	I40E_FDIR_NODE_VLAN_IPV6,
+	I40E_FDIR_NODE_VLAN_UDP,
 	I40E_FDIR_NODE_RAW,
 	I40E_FDIR_NODE_END,
 	I40E_FDIR_NODE_MAX,
@@ -1345,6 +1352,31 @@ static const struct flow_graph i40e_fdir_graph = {
 			.validate = i40e_fdir_node_ipv6_validate,
 			.process = i40e_fdir_node_inner_ipv6_process,
 		},
+		[I40E_FDIR_NODE_VLAN_IPV4] = {
+			.name = "VLAN_IPv4",
+			.type = RTE_FLOW_ITEM_TYPE_IPV4,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY |
+				       FLOW_GRAPH_NODE_EXPECT_SPEC |
+				       FLOW_GRAPH_NODE_EXPECT_RANGE,
+			.validate = i40e_fdir_node_ipv4_validate,
+			.process = i40e_fdir_node_ipv4_process,
+		},
+		[I40E_FDIR_NODE_VLAN_IPV6] = {
+			.name = "VLAN_IPv6",
+			.type = RTE_FLOW_ITEM_TYPE_IPV6,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY |
+				       FLOW_GRAPH_NODE_EXPECT_SPEC,
+			.validate = i40e_fdir_node_ipv6_validate,
+			.process = i40e_fdir_node_ipv6_process,
+		},
+		[I40E_FDIR_NODE_VLAN_UDP] = {
+			.name = "VLAN_UDP",
+			.type = RTE_FLOW_ITEM_TYPE_UDP,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY |
+				       FLOW_GRAPH_NODE_EXPECT_SPEC,
+			.validate = i40e_fdir_node_udp_validate,
+			.process = i40e_fdir_node_udp_process,
+		},
 		[I40E_FDIR_NODE_RAW] = {
 			.name = "RAW",
 			.type = RTE_FLOW_ITEM_TYPE_RAW,
@@ -1378,8 +1410,8 @@ static const struct flow_graph i40e_fdir_graph = {
 		},
 		[I40E_FDIR_NODE_VLAN] = {
 			.next = (size_t[]) {
-				I40E_FDIR_NODE_IPV4,
-				I40E_FDIR_NODE_IPV6,
+				I40E_FDIR_NODE_VLAN_IPV4,
+				I40E_FDIR_NODE_VLAN_IPV6,
 				I40E_FDIR_NODE_RAW,
 				I40E_FDIR_NODE_END,
 				FLOW_GRAPH_NODE_EDGE_END
@@ -1471,6 +1503,33 @@ static const struct flow_graph i40e_fdir_graph = {
 				FLOW_GRAPH_NODE_EDGE_END
 			}
 		},
+		[I40E_FDIR_NODE_VLAN_IPV4] = {
+			.next = (size_t[]) {
+				I40E_FDIR_NODE_TCP,
+				I40E_FDIR_NODE_VLAN_UDP,
+				I40E_FDIR_NODE_SCTP,
+				I40E_FDIR_NODE_RAW,
+				I40E_FDIR_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_FDIR_NODE_VLAN_IPV6] = {
+			.next = (size_t[]) {
+				I40E_FDIR_NODE_TCP,
+				I40E_FDIR_NODE_VLAN_UDP,
+				I40E_FDIR_NODE_SCTP,
+				I40E_FDIR_NODE_RAW,
+				I40E_FDIR_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_FDIR_NODE_VLAN_UDP] = {
+			.next = (size_t[]) {
+				I40E_FDIR_NODE_RAW,
+				I40E_FDIR_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
 		[I40E_FDIR_NODE_RAW] = {
 			.next = (size_t[]) {
 				I40E_FDIR_NODE_RAW,
-- 
2.52.0

