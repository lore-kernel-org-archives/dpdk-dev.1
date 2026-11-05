Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD01606A31B
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 07:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RAR5dHbV
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D60C402F1;
	Thu,  5 Nov 2026 08:31:36 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012008.outbound.protection.outlook.com [40.107.209.8])
 by mails.dpdk.org (Postfix) with ESMTPS id C118740296;
 Thu,  5 Nov 2026 08:31:34 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qNXxHf61eZBbxmMScs5RWUghvdezOxFrt/49ozD0FZz54CL3cZ5raQTltqYUioajKi1FMMQQzSiKaJDVSjYInjgoD3Va0idYHFPqWKMqw5LY1SyNH3r7UkHh3uO8ZynyXo1FZhQgxc09/CzdtYsRz6TE6JJ8NdyElypR4BorQwuz+bGmCtjN8lvHnbcylEyQwVFGa58YCFv6SFOtql7x7nv1BxbPvcK8R15CEn2AGLlZ4kylEXcc7h8LxBHJ/zIqx5KWb2/VOe59yEtekVs3pJ03ddzrMu9v/qpo1zg23xc/yWSYkbDZlkgRrMe+DNnGuiav6GKXEloDgM0IfmXCfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4x7zHdTqm9hSXaSsFj3DDfL3Rk1pb1N4T3xLN5LafE=;
 b=jvv7tC7dcWVK2N7iJKKG8tzJ3f92UUpwdDttlLK/oRGgAYVS7f8BJJBbYhC9aRkIlpfCfOpv8tA3FOVUakggtVvajSw7fLFmUHdgx9JPwW2VvxBkycwNxcjZ9TYwKHarQJ1ZlQB4RhQM9rr1ESOYra67bfzp2LwCe/99tsSX8TPsFFVlScm+Tex45TWCzz2RaKQd9IqaKOCpGVwjklirzV8eC7DOMRf3CiVGrShR36UXbwNAQFRT0nxHF/FGOrHGYovV9E7CMopjCfMQgKdIuplc9a9bqN1oApXNuBP7Kmb4F2P8Z9EdMuUmlFDZo5RGR7j5Y42xzrqntaPfdiDnlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4x7zHdTqm9hSXaSsFj3DDfL3Rk1pb1N4T3xLN5LafE=;
 b=RAR5dHbVtXq7rcYCQnXK70hSkjkbY81cJ2dg3uO9PgG6uWk4uabeHc9voIr2FerLHRcYJegzr80by7h2v15oSFkWhAfrWjmv3x5mRSokX+2gfLznydaLycwiseYaNaisC09O2sTgHNFp7xQ1JbLM/E20t0ujCjQUeQHHCgzSIRvnq98gfFlhiYXpS3JvP5EAVMiwDTwtCM2wv36igtrkHVzULmeRxspY0q0lFZ0c7tffF0NDaekgJBdyBBhaQ47Dzzwcw2pawN2zHBGeerbnURm5YGCQKge5U3KZQSHidf2zFgfG55CunsQ6lkW2i5vDw7v+JE/eKMsgjI1k7FG7qQ==
Received: from SJ0PR13CA0123.namprd13.prod.outlook.com (2603:10b6:a03:2c6::8)
 by CY5PR12MB6252.namprd12.prod.outlook.com (2603:10b6:930:20::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Thu, 5 Nov 2026
 07:31:29 +0000
Received: from BY1PEPF00026969.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::3f) by SJ0PR13CA0123.outlook.office365.com
 (2603:10b6:a03:2c6::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Thu, 5
 Nov 2026 07:31:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF00026969.mail.protection.outlook.com (10.167.244.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 07:31:29 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 23:31:13 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 23:31:13 -0800
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server id 15.2.2562.56 via Frontend Transport;
 Wed, 4 Nov 2026 23:31:11 -0800
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <aman.deep.singh@intel.com>, <haijie1@huawei.com>, <rasland@nvidia.com>,
 Maayan Kashani <mkashani@nvidia.com>, <stable@dpdk.org>
Subject: [PATCH] app/testpmd: fix VXLAN-GPE and GENEVE custom port parsing
Date: Thu, 5 Nov 2026 09:31:10 +0200
Message-ID: <20261105073110.3643780-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF00026969:EE_|CY5PR12MB6252:EE_
X-MS-Office365-Filtering-Correlation-Id: ae8876a9-31f9-4640-36d4-08df3b0ecea8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|261009223027099003|11063799006|56012099006|261102123227099003|261021121427099003|261022075727099003|261028144727099003|261026140227099003|261021123027099003|261022105027099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: +bUSFm5EOzW38j5FJb42ZL30TI2LBNzGJoYEO2cd5tUQG8AdzkP601ek01EeDMW4ubXdLesFF82RJJRN6ehwAT+eJoqhlD8pffKrz3YQYuzLlLoypqYZrwIlv6oqrD6nalVj7jruUZ4o3cBpofTNyJ9IvKSaOw7sCyuWud2F5Cev/7CSZZTuDBGm4uSc83q4PlMCvZxTYGIf+DYuZUSEr/eExjPMc6VFCcceKkBmrxe2V34f9LctXiuD0hOodcVp/DY/W32sqd0qbx5mUN51Oyf2xk+X4r2zry92YCqmEJtCA6u3OiHpgpv9RT7b/r6PNZ6qHlbTfStO1a3vIln52ViFhzGaiU0kxa+p4EYxvgmdYb+34DNMVQapQ8HJ6BNiRXXZ2VPYnONsWfri3rJpj9Fci2SD9uAi0emQH8ZkfUjAx9uBrcmakoYT8PIiSPDMcziuAQ9ly/PdKF12Vm3MxGGnjNsb4GwBpaORDOLU/CSnMpzt5mNQqPi6S3mTNAs2odIYUBsICKXnp9zZekdgTzMfOJqhbQhtFzvfJfjODbEUkuiHdJvRde/bU7yztWZ9XMxkoWIXeW5tbNGZwoSjUcC1dloG0KdLI4tuPl3MxeY5a5OdOJVF7W+mWXJLKNGZEoBDx6mVaTWaw7vBajmIGPnsEbJbbN+eerwUfJZzuqhwdxFN+MqP3nlucSuQNUnVczWam3mC+Ml7N0liqmcoVw==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(261009223027099003)(11063799006)(56012099006)(261102123227099003)(261021121427099003)(261022075727099003)(261028144727099003)(261026140227099003)(261021123027099003)(261022105027099003)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RirbfLpF72jDKkb4w2EkN5AJUpEbIoNjppA80UoHDoniueBrdHc9V+gSe8OUxGliHYJ7u+hR2AWnFdvfvbk5DTDRMPmCMUmnE3WrxrVk2YaLI+8J/1SFccFZW1IwLr7ocz4TWPHyKxjYxVZD12mKaSwK06E/50M/rAahIlO6iXfL0imLpToWqg2/j3zhBiUefIbYla9vlor/+dpekcbqysHagPkKKsVpvx0Nsr4QJghCSp1U+TSxTtc9sRCXTdFepFA9ajYuBT4ABInOn0H8FEyIIM6XDhkaHghjWoLN+273kWx1FLg3luTB59BKiceDdPMtX+Q4EGqE6FL/DfIqB2lznHA0Z883TBZvqFQ1k7I8UWj3Y+k6U7hIQ4sag6kIeofariVFKoM/wYPvSDnow9yYJopVfOy0FNUC1K5fshLwGjsvp3QG3OR9/ZV25Oha
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 07:31:29.2367 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae8876a9-31f9-4640-36d4-08df3b0ecea8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF00026969.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6252
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

The csum forwarding engine parses packets with rte_net_get_ptype(),
which recognizes VXLAN-GPE and GENEVE tunnels only on their default UDP
ports. Since the switch to that API, --vxlan-gpe-port and
--geneve-parsed-port no longer take effect: a packet whose outer UDP
destination port matches a configured non-default port is not detected
as a tunnel, so tunnel Tx flags, outer checksum handling and tunnel TSO
are skipped.

When parse-tunnel is enabled and the outer UDP port matches one of those
options, temporarily present the corresponding default port to
rte_net_get_ptype() and restore the original port afterwards. This reuses
the existing parser without a new library API. Plain VXLAN is unchanged:
the csum engine has always recognized it only on RTE_VXLAN_DEFAULT_PORT,
and rx_vxlan_port configures the device filter rather than this parser.

Only process inner checksums when the parser identified an inner IP
header and all declared inner headers fit in the packet. This preserves
tunnel forwarding for valid non-IP payloads and avoids accessing
truncated inner headers on both default and configured tunnel ports.

Fixes: 76730c7b9b5a ("app/testpmd: use packet type parsing API")
Cc: stable@dpdk.org

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
---
 app/test-pmd/csumonly.c | 84 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 79 insertions(+), 5 deletions(-)

diff --git a/app/test-pmd/csumonly.c b/app/test-pmd/csumonly.c
index c841651756d..e0ce91fed80 100644
--- a/app/test-pmd/csumonly.c
+++ b/app/test-pmd/csumonly.c
@@ -573,6 +573,69 @@ parse_l4_proto(const struct rte_mbuf *m, uint32_t off, uint32_t ptype, bool in_t
 	return 0;
 }
 
+/*
+ * rte_net_get_ptype() recognizes VXLAN-GPE and GENEVE only on their default
+ * UDP ports. --vxlan-gpe-port and --geneve-parsed-port select other ports.
+ * When one of those matches, present the default port to the existing parser
+ * and restore the original port afterwards. Plain VXLAN stays on
+ * RTE_VXLAN_DEFAULT_PORT: the csum engine has no equivalent option for it.
+ * If a configured port overlaps a tunnel port already recognized by
+ * rte_net_get_ptype(), keep the library's classification.
+ */
+static uint32_t
+parse_tunnel_udp_custom_port(struct rte_mbuf *m, uint32_t ptype,
+			     struct rte_net_hdr_lens *hdr_lens)
+{
+	uint32_t off = hdr_lens->l2_len + hdr_lens->l3_len;
+	struct rte_net_hdr_lens parsed = {0};
+	struct rte_udp_hdr *uh;
+	uint16_t default_port;
+	rte_be16_t saved_port;
+	uint16_t dst_port;
+	uint32_t new_ptype;
+
+	if (rte_pktmbuf_data_len(m) < off + sizeof(*uh))
+		return ptype;
+
+	uh = rte_pktmbuf_mtod_offset(m, struct rte_udp_hdr *, off);
+	dst_port = rte_be_to_cpu_16(uh->dst_port);
+	if (vxlan_gpe_udp_port != RTE_VXLAN_GPE_DEFAULT_PORT &&
+	    dst_port == vxlan_gpe_udp_port)
+		default_port = RTE_VXLAN_GPE_DEFAULT_PORT;
+	else if (geneve_udp_port != RTE_GENEVE_DEFAULT_PORT &&
+		 dst_port == geneve_udp_port)
+		default_port = RTE_GENEVE_DEFAULT_PORT;
+	else
+		return ptype;
+
+	saved_port = uh->dst_port;
+	uh->dst_port = rte_cpu_to_be_16(default_port);
+	new_ptype = rte_net_get_ptype(m, &parsed, RTE_PTYPE_ALL_MASK);
+	uh->dst_port = saved_port;
+
+	if (RTE_ETH_IS_TUNNEL_PKT(new_ptype) == 0)
+		return ptype;
+
+	*hdr_lens = parsed;
+	return new_ptype;
+}
+
+static bool
+can_process_inner_headers(const struct rte_mbuf *m, uint32_t ptype,
+			  const struct rte_net_hdr_lens *hdr_lens)
+{
+	uint32_t headers_len;
+
+	if ((ptype & RTE_PTYPE_INNER_L3_MASK) == 0)
+		return false;
+
+	headers_len = hdr_lens->l2_len + hdr_lens->l3_len +
+		hdr_lens->inner_l2_len + hdr_lens->inner_l3_len +
+		hdr_lens->inner_l4_len;
+
+	return rte_pktmbuf_pkt_len(m) >= headers_len;
+}
+
 /*
  * Receive a burst of packets, and for each packet:
  *  - parse packet, and try to recognize a supported packet type (1)
@@ -669,6 +732,7 @@ pkt_burst_checksum_forward(struct fwd_stream *fs)
 
 	for (i = 0; i < nb_rx; i++) {
 		struct rte_net_hdr_lens hdr_lens = {0};
+		bool process_inner = false;
 
 		if (likely(i < nb_rx - 1))
 			rte_prefetch0(rte_pktmbuf_mtod(pkts_burst[i + 1],
@@ -703,6 +767,9 @@ pkt_burst_checksum_forward(struct fwd_stream *fs)
 		}
 
 		ptype = rte_net_get_ptype(m, &hdr_lens, RTE_PTYPE_ALL_MASK);
+		if (txp->parse_tunnel && RTE_ETH_IS_TUNNEL_PKT(ptype) == 0 &&
+		    (ptype & RTE_PTYPE_L4_MASK) == RTE_PTYPE_L4_UDP)
+			ptype = parse_tunnel_udp_custom_port(m, ptype, &hdr_lens);
 		info.l2_len = hdr_lens.l2_len;
 		info.l3_len = hdr_lens.l3_len;
 		info.l4_len = hdr_lens.l4_len;
@@ -718,10 +785,16 @@ pkt_burst_checksum_forward(struct fwd_stream *fs)
 			info.l2_len = hdr_lens.inner_l2_len;
 			info.l3_len = hdr_lens.inner_l3_len;
 			info.l4_len = hdr_lens.inner_l4_len;
-			eth_hdr = (struct rte_ether_hdr *)((char *)l3_hdr +
-				hdr_lens.l3_len + hdr_lens.l4_len + hdr_lens.tunnel_len);
-			info.ethertype = get_ethertype_by_ptype(eth_hdr,
-						ptype & RTE_PTYPE_INNER_L3_MASK);
+			process_inner = can_process_inner_headers(m, ptype, &hdr_lens);
+			if (process_inner) {
+				eth_hdr = (struct rte_ether_hdr *)((char *)l3_hdr +
+					hdr_lens.l3_len + hdr_lens.l4_len +
+					hdr_lens.tunnel_len);
+				info.ethertype = get_ethertype_by_ptype(eth_hdr,
+							ptype & RTE_PTYPE_INNER_L3_MASK);
+			} else {
+				info.ethertype = 0;
+			}
 			tx_ol_flags |= get_tunnel_ol_flags_by_ptype(ptype);
 		}
 		/* update l3_hdr and outer_l3_hdr if a tunnel was parsed */
@@ -730,7 +803,8 @@ pkt_burst_checksum_forward(struct fwd_stream *fs)
 
 			outer_l3_hdr = l3_hdr;
 			l3_hdr = (char *)l3_hdr + info.outer_l3_len + info.l2_len;
-			info.l4_proto = parse_l4_proto(m, l3_off, ptype, true);
+			if (process_inner)
+				info.l4_proto = parse_l4_proto(m, l3_off, ptype, true);
 		}
 		/* step 2: depending on user command line configuration,
 		 * recompute checksum either in software or flag the
-- 
2.25.1

