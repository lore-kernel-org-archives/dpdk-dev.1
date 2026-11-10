Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FD7606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 07:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=H+nqz1nM
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6DD4A40283;
	Tue, 10 Nov 2026 08:42:06 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010010.outbound.protection.outlook.com [52.101.56.10])
 by mails.dpdk.org (Postfix) with ESMTPS id 9AE1A4027C;
 Tue, 10 Nov 2026 08:42:05 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kxOITfA15DnsR8Asgc5j13aW9WpDIFRR0BQAl7/ZSnmrEyk4tZq0mRSBh5Hv3YEYLGFoJfr/1SdxWYqUjqn9zGzFmETrF8vBVP/8v+26jUXNLExj6jDobOY3lSzVUh3OOv2PzljtDUYMpnnOeCtlguX+zjpoz1GCVQ4i+SGrYhe+JRm5xYU0B3Ld73/hubHBFLO8NulTVuvtCs8kJIwATUrtt+ZoPTdGlhVEVqWSU9UpYsN/vqiUqU3w+5myiwEa9OllUT3T8UnZvJ8kwm6LClZeqNw2mGsbwCLcE+VImHwhK1Gd9Uo+98/iG9vQXsUr6szkehxoWDapbjTsnldxOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8jgVnSO/3GQrMBI9YEQBGjIZp0H9jJsLHLVpCeMpfU=;
 b=oRZS5WVHWgS+1E1zFR9Uzm7o9kTpTuG34A/FzXXuQlcN5AxBSO5W+RlDXmE0ZkLTemM2Fe9MrbuSbcPXKhblOxSvEa8/NrwxyTA3slbqkf7+656IXAgYRcTvSlEFRfFHt14ltcSy6zpV8yVPyeqslHSf3MGPA3i1S8V0x9MvDHso+yhXWdxHySkKrJilFtTgiYunw8oLa98VG4VTUIdgkw25IeRJ4RbwH8agQer9qb0Bj2kOcgISlswpMQ0AD/j2jVAVmguD9XimzJ05gRohlu7pynGXN8hojS+cvSogy+4tcNZ8y5hZTUvHeMWzFnK7zgEc3K1qa4vu0RRE7Y7Zbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8jgVnSO/3GQrMBI9YEQBGjIZp0H9jJsLHLVpCeMpfU=;
 b=H+nqz1nMe5w2qqgII3Y9x6/K/mMm8mjVB4m+Jbtz/llcrTeu6oP+hUmIHLNR+3V6t0uCkNHbE2OE+2UcD0iqxz78PHk+8IKHn2BpaCJM9OLNG0vAPQIqxu2QbC9UcikcBuBJI+FtNDV4B8WQsQYprx0Uz+sA6lfU9C4gsLI1kAruSMQEadA+cV4YECoG8ow8RRkmEYcq2EtWGWFOqx57tM+aBWE/B2mzdwd2ylZoH1fyE1DzStrrclMH87tuKTo0UEpl5csWPFQar47u6iuDD+7CZiJ1UP64lDo10QZEcnbM8t5a2ekaK0HszdV1CMgv0ER7zDKLwQchAgL6IEmnQQ==
Received: from CH0PR03CA0416.namprd03.prod.outlook.com (2603:10b6:610:11b::7)
 by EAYPR12MB923140.namprd12.prod.outlook.com (2603:10b6:303:2fd::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 07:41:57 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:610:11b:cafe::20) by CH0PR03CA0416.outlook.office365.com
 (2603:10b6:610:11b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Tue,
 10 Nov 2026 07:41:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.0 via Frontend Transport; Tue, 10 Nov 2026 07:41:56 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 9 Nov
 2026 23:41:42 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 23:41:40 -0800
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server id 15.2.2562.56 via Frontend Transport; Mon, 9 Nov
 2026 23:41:38 -0800
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <aman.deep.singh@intel.com>, <haijie1@huawei.com>, <rasland@nvidia.com>,
 Maayan Kashani <mkashani@nvidia.com>, <stable@dpdk.org>
Subject: [PATCH v2] app/testpmd: fix VXLAN-GPE and GENEVE custom port parsing
Date: Tue, 10 Nov 2026 09:41:37 +0200
Message-ID: <20261110074137.4117697-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261105073110.3643780-1-mkashani@nvidia.com>
References: <20261105073110.3643780-1-mkashani@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|EAYPR12MB923140:EE_
X-MS-Office365-Filtering-Correlation-Id: fa04c4d3-fa43-42fb-7eb3-08df3efe18b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|11063799006|56012099006|261022105027099003|261022075727099003|261021121427099003|261021123027099003|10067099003|261028144727099003|261102123227099003|261009223027099003|261026140227099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: JN+SS1ZbOKIjDZrve5J6N1NoeczhpRNuHSWBoSjLzYAzgeBIBU2HHw1mvQbqH41nxKpW0GZGHUWUMmn1YIQqXxYQJAdtu+Xl1cqCu/Lk/etRYdfKxtlQg3jFgQjbFaWWccLW82sx/vamMHtpsI8vYQfV8DOA4raZwv7QszA8YuwTTFlJ7yyKkx0IQTNpzrUbGNqpUvEu1RD8st6VckrJHMHgb5wa3Raw0+feui7dHDVsDN/bTpbN9EgdcM0KqfwvfCxyRfOIgMfiiCSbKAxxwvyvznVHWJ19tAIivHcIFBqM8QxzGQMyfTJB1Ps60L2LdjsKjcPWbyZNbAq6a2NRwqXJkagWlZwi3Q4co/MUEUI9FtqikQKSGWUBvH/9F+khfz5rA8inP/OJgkJgNbJ1Vl65ot0WL0QiNmR0YxcrKed18lfND8peXnnU6Tu5cYK7Pq7OHciPONK2HBPInyhbl4re/6wyw54YgiSbxFbaGEUspi31aVPnm6C0a0qs0kfcBVBdViZQfspMp+DjrH3R2e8R5hZe7Ax9+njilIxb+m/7vFSZyWXvwd4a7XaQuYuK+RuyAejOFu9CL/yg6o9ZoBr980B4TIBhKdw4HufT3X+1O+hiy0/zTmS4EZGUctxsqYmZ0l1X9Fcze9JtW+T/T8MenkzmgAJh3QQdvnIJEgBL/ggkPFGzTw6vzgQ6ZhyCZpqfweUGgN3r2TwBvdyexQ==
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(261021121427099003)(261021123027099003)(10067099003)(261028144727099003)(261102123227099003)(261009223027099003)(261026140227099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CxIyjY8mn3F7TMS+M1v642/NejOZOeDZNfDVj/dhnz9CPqu+c37UP14i7nvbus+Nd+ZJmxDnMmWO7ucIwGPwjNstvY/6MP3TA/2ndTgcZih6CI1A3lxhF1MgdtUyNvI5E5ckzP9I+dsRsmJLo4QwS2sBr60kz5RJsOSjiYa92wEpZTnB5tdyrrZBH5bNPhUimZE9Yc7b/pLEAY+lQlHKNIO/TeghPMCp12VDUY0DkkHoLdGh+lgVGpsD4zkUGVkgOUcvmjsAjGiDfRuQusHKrUCBBNE4HrzpTcTaZ5NZdQerLYcTMq0ZLadzRoJonMiftjhKfA1JIOCyTdkeMR5e7Czhmi66/X+AFg8AdtTZNTuEjFw9UQCztcSsT5P6KTPes7K6iEY9p6JXm2mf2P1wPWYyMG0X5bLfLsDNflsm08Wow0Ll2nYoNuH2hO8byTU1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 07:41:56.5349 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa04c4d3-fa43-42fb-7eb3-08df3efe18b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB923140
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

When parse-tunnel is enabled, temporarily map a configured port to the
corresponding default while calling rte_net_get_ptype(), then restore the
packet. If an option replaces a default port, hide that default from the
parser to preserve the options' previous behavior. Plain VXLAN is
unchanged: the csum engine has always recognized it only on
RTE_VXLAN_DEFAULT_PORT, and rx_vxlan_port configures the device filter
rather than this parser.

Only process inner checksums when the parser identified an inner IP
header and all declared inner headers fit in the first segment. This
preserves tunnel forwarding for valid non-IP payloads and avoids
accessing truncated or non-contiguous inner headers on both default and
configured tunnel ports.

Fixes: 76730c7b9b5a ("app/testpmd: use packet type parsing API")
Cc: stable@dpdk.org

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
---
v2:
- Require inner headers to fit in the first mbuf segment.
- Skip custom-port parsing when both ports use their defaults.
- Preserve replacement semantics for configured tunnel ports.

 app/test-pmd/csumonly.c | 90 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 85 insertions(+), 5 deletions(-)

diff --git a/app/test-pmd/csumonly.c b/app/test-pmd/csumonly.c
index c841651756d..52ced5b15cc 100644
--- a/app/test-pmd/csumonly.c
+++ b/app/test-pmd/csumonly.c
@@ -573,6 +573,75 @@ parse_l4_proto(const struct rte_mbuf *m, uint32_t off, uint32_t ptype, bool in_t
 	return 0;
 }
 
+/*
+ * rte_net_get_ptype() recognizes VXLAN-GPE and GENEVE only on their default
+ * UDP ports. Present the configured port as the corresponding default port,
+ * or hide a default port that has been replaced, while calling the parser.
+ * Plain VXLAN stays on RTE_VXLAN_DEFAULT_PORT: the csum engine has no
+ * equivalent option for it.
+ */
+static uint32_t
+parse_tunnel_udp_custom_port(struct rte_mbuf *m, uint32_t ptype,
+			     struct rte_net_hdr_lens *hdr_lens)
+{
+	uint32_t off = hdr_lens->l2_len + hdr_lens->l3_len;
+	struct rte_net_hdr_lens parsed = {0};
+	struct rte_udp_hdr *uh;
+	uint32_t tunnel_type;
+	uint16_t default_port;
+	rte_be16_t saved_port;
+	uint16_t dst_port;
+	uint32_t new_ptype;
+
+	if (vxlan_gpe_udp_port == RTE_VXLAN_GPE_DEFAULT_PORT &&
+	    geneve_udp_port == RTE_GENEVE_DEFAULT_PORT)
+		return ptype;
+
+	if (rte_pktmbuf_data_len(m) < off + sizeof(*uh))
+		return ptype;
+
+	uh = rte_pktmbuf_mtod_offset(m, struct rte_udp_hdr *, off);
+	dst_port = rte_be_to_cpu_16(uh->dst_port);
+	tunnel_type = ptype & RTE_PTYPE_TUNNEL_MASK;
+	if (dst_port == vxlan_gpe_udp_port)
+		default_port = RTE_VXLAN_GPE_DEFAULT_PORT;
+	else if (dst_port == geneve_udp_port)
+		default_port = RTE_GENEVE_DEFAULT_PORT;
+	else if ((tunnel_type == RTE_PTYPE_TUNNEL_VXLAN_GPE &&
+		  vxlan_gpe_udp_port != RTE_VXLAN_GPE_DEFAULT_PORT) ||
+		 (tunnel_type == RTE_PTYPE_TUNNEL_GENEVE &&
+		  geneve_udp_port != RTE_GENEVE_DEFAULT_PORT))
+		default_port = 0;
+	else
+		return ptype;
+
+	saved_port = uh->dst_port;
+	if (saved_port == rte_cpu_to_be_16(default_port))
+		return ptype;
+	uh->dst_port = rte_cpu_to_be_16(default_port);
+	new_ptype = rte_net_get_ptype(m, &parsed, RTE_PTYPE_ALL_MASK);
+	uh->dst_port = saved_port;
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
+	return rte_pktmbuf_data_len(m) >= headers_len;
+}
+
 /*
  * Receive a burst of packets, and for each packet:
  *  - parse packet, and try to recognize a supported packet type (1)
@@ -669,6 +738,7 @@ pkt_burst_checksum_forward(struct fwd_stream *fs)
 
 	for (i = 0; i < nb_rx; i++) {
 		struct rte_net_hdr_lens hdr_lens = {0};
+		bool process_inner = false;
 
 		if (likely(i < nb_rx - 1))
 			rte_prefetch0(rte_pktmbuf_mtod(pkts_burst[i + 1],
@@ -703,6 +773,9 @@ pkt_burst_checksum_forward(struct fwd_stream *fs)
 		}
 
 		ptype = rte_net_get_ptype(m, &hdr_lens, RTE_PTYPE_ALL_MASK);
+		if (txp->parse_tunnel &&
+		    (ptype & RTE_PTYPE_L4_MASK) == RTE_PTYPE_L4_UDP)
+			ptype = parse_tunnel_udp_custom_port(m, ptype, &hdr_lens);
 		info.l2_len = hdr_lens.l2_len;
 		info.l3_len = hdr_lens.l3_len;
 		info.l4_len = hdr_lens.l4_len;
@@ -718,10 +791,16 @@ pkt_burst_checksum_forward(struct fwd_stream *fs)
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
@@ -730,7 +809,8 @@ pkt_burst_checksum_forward(struct fwd_stream *fs)
 
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

