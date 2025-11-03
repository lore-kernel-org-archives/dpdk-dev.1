Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2305CCCFA03
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 16:40:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 76AA940613;
	Mon,  3 Nov 2025 17:40:42 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010056.outbound.protection.outlook.com [52.101.56.56])
 by mails.dpdk.org (Postfix) with ESMTP id 13970402BB;
 Mon,  3 Nov 2025 17:40:41 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cL6y2/Zevu2Ayoc8Mk3JVf/SiCboG11kKd/BS/hrcgqTRFnmq5ebysH/Y0lLzeYFN1FbbethQJ+x7uMdI73yAIbHi7tRBFdEHAeGYINCcqN1O5ah3nft7hhh8Xi26LEFijrn0RqZWHsHjc6xS1oNVgq5rHi/BY97xlryBwxewlZR+Je9IhXVgywJFqvFq1QaG18teCmJ2/gZe+WQedmX96mEXswBCRXos9B2X040L9XhJGDLBvzCBqjM5M323ybD9yMkR6BmyZqSnMAAGXgFqkypyL/3LI3ZyEU2hB9pYMh82zwr7qriy84KFfJhYmc+Yc4Ev75aDZ3yeOeoYXr6Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=417tzZXbk54tCYRNrf2vy3tnBCZDoELdzjy+BVKo8Bg=;
 b=xcTZmmWpu1DdRtZt7Np3pozKT09tw0TXNbJVdoAL0xCtcGpCv6+a3jv9IeCMoZ1Itxg5TbljIPjGtgIUS1BCzQKGTaAcBskfbySZWru6EA0Wl5sSiVdJIBbxaxEfS/GiMJyYvNMlOpRI8XdgOTJgcS5JGVvHgSEb/PVBxvzBI3q1yYsSAp6ZAoBq2stzP7KMQKGgWCzT0dyZvX57n7+NsZyboolg+/Vl0DYpjgnbBEoo/+iBb0hpO5cuF9apB06695h1tUaWrb2ixnjLB7w2HBQeOnB09qy8D19VXC+tfmpxGQfZa+XxYJ6OO656sr6Ye5u/qWF5pscHFKt2uyk6sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=417tzZXbk54tCYRNrf2vy3tnBCZDoELdzjy+BVKo8Bg=;
 b=XFq+UyCiRvLTILXkBfxEq7aKoV1XmNPgMSnDrYwzB4zVCt+2AegJ8JYY2mUz2sjIh2XdudXMQ0R+lpaY3LmP4RGV/S9baKzUG3rY6mUd7eLPLSfGzHJcdOoIk/uWBrNwOQzXeK0Ui4kV49jouqHOvM/7AN3CivkJmO8qMmvPQjczZaI0Ajw+1CHe+oUXxNL+xjmJ6s7RdhxvvsCwlVYdbaidSqkZEJcxK/GZHiJ7ystANLTjun0Pzbl61yku5onHfwgQqapTq43g7DCzRRRYuPbBoCtHuhCz9PGRTwB9RokgliQo5F1i+CupyjaEb0AU/vZsNb4X5HoJl2sKaywMRw==
Received: from MN2PR22CA0021.namprd22.prod.outlook.com (2603:10b6:208:238::26)
 by SN7PR12MB8434.namprd12.prod.outlook.com (2603:10b6:806:2e6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Mon, 3 Nov
 2025 16:40:34 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:238:cafe::2b) by MN2PR22CA0021.outlook.office365.com
 (2603:10b6:208:238::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 16:40:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.0 via Frontend Transport; Mon, 3 Nov 2025 16:40:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Nov
 2025 08:40:08 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 08:40:08 -0800
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 3 Nov 2025 08:40:05 -0800
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <david.marchand@redhat.com>, <stephen@networkplumber.org>,
 <bruce.richardson@intel.com>, Shani Peretz <shperetz@nvidia.com>,
 <stable@dpdk.org>, Aman Singh <aman.deep.singh@intel.com>, Dengdui Huang
 <huangdengdui@huawei.com>
Subject: [PATCH] app/testpmd: fix inner header parsing for tunnel TSO
Date: Mon, 3 Nov 2025 18:40:01 +0200
Message-ID: <20251103164001.437863-1-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|SN7PR12MB8434:EE_
X-MS-Office365-Filtering-Correlation-Id: be8c423a-6286-427a-7a51-08de1af7b488
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+t3ivewjwPo06aaYLVm8h/SIvM7NUzt3WhlXoy5m3Ehu+QkWAZ2g+Tj+lMxy?=
 =?us-ascii?Q?VtR3bDOBZG0NrD89fmdgn0ADKTEeGl4d/fVZqNOUHYwvJZB/SQe89lgExh0T?=
 =?us-ascii?Q?mEd+3JcTv6RI6pP/1U45MQMAkbz9nuiatIbVYjvCpKTMdlHRiV2C2qjK1bCB?=
 =?us-ascii?Q?GA+p/Z/uA+b+Qgg4ijyCoMNBMH7rdGeLoyG+2pZzhnq8eZK0TokzHXlo0PBB?=
 =?us-ascii?Q?CJOC7GhCf0tz+rgR+qZ+BBcsmVXCDDA6QomRmxgnVlbDOfwSumZ+pRYe4js5?=
 =?us-ascii?Q?qiYtgOflF+1G6JhGwnuzG2O40CLSDmUyK++4kjleIvASdY1hW2CD15LOQWwu?=
 =?us-ascii?Q?Vj+JBqTCuQqBfxhVucmjfyzDh0L6kikv5jmt5TUBLHGfg2cArQ4TCBZ5OWkA?=
 =?us-ascii?Q?4WAtmhWl9OB+H6ZJXKkx86cobGsfNVrMQPFEDYLoqMPFDGo0w3gVAgrYWMvP?=
 =?us-ascii?Q?IGlEZv9psx/y8CtPjI1hLlhD/dcfBaTxOE07pqeoAc15XXfqR3675EU2RF1s?=
 =?us-ascii?Q?dA8L/+SDX0MWONy6tOPrUpNJHeMqENOKFFyKAuDyyDlzbyuyhGBYg4B8b9Jp?=
 =?us-ascii?Q?lsrRAoOj3gynZGan/7T7jczGf7pksu9avxIqSVf7UzlGDH9ncUJX9LKHpYFT?=
 =?us-ascii?Q?ELgbGuTswl+Mys6qh8D85GkYdr2cctLcPwh9WIW5twTFekBpSL5VBarOb0mo?=
 =?us-ascii?Q?b88X8IkicKnePBFZz/kBt95L9UITGo3OqDxs6fTeNz5+Al6Q7FYOR58Aqxmx?=
 =?us-ascii?Q?jXHSL4IAlBGYynU+uZaqdwtXQxV66xvA0NY2QAwC6Gw+KY1SMqUKkDIzXNL8?=
 =?us-ascii?Q?Seb2rLsaWcgnN5iYAF7Ou3aEZiVHwdGfh67U87i4wocr+vNoCes5TgK/uxvQ?=
 =?us-ascii?Q?RRlrE1Gufm/0El/7RI5Ax31Fp50QEYqjzkiIHlEakvU0HyTx6VCju8KbIH2x?=
 =?us-ascii?Q?7Kodb+Dg3cCt0sW5HbkvbGZchMcFQvW6SwOe9t5rs/os/2RRVPiUhEGDuJTz?=
 =?us-ascii?Q?zUAMxqi6PuvKpfEFLuKq4YENTWQ43xkS8Q/KyikxCPHViHfp/eJU6Qr3DZMi?=
 =?us-ascii?Q?eSg9cMeEVuptLWFGb4z53PnZXMh44G27sqrNejkoFt92+B1DhcNZn+ZIfk/Q?=
 =?us-ascii?Q?UPqV3y0kFkBucgSkkr0495SOwPwUU0MEbOzYAb9/RvXyBuQAhZq/vUGcO9RM?=
 =?us-ascii?Q?7oDZ7D5HITkeVLb9iVFc4w2IkDuqgn/5x3WMADOhEpRLYrBlQGEqPUWwHXVA?=
 =?us-ascii?Q?DJ12CT9FzX60AXe50TK4OlhfbRJPanl3O/JVQmbELJwL7YbtB7noqpG1iVh1?=
 =?us-ascii?Q?5Zcar0twdpEHLxW8RbDQNpHUTcAMs/N1jajPg7Yo2w+MbLcSNzztk2Kof/uw?=
 =?us-ascii?Q?/eesH4+WcWUFCBzvS5G8cZl7lrZGuwW5uxC8Ob1gZlHykGyHee2koOKnL8tl?=
 =?us-ascii?Q?IOusrVImvPfWdRusm7PUIeL50ky4D4sPKwzY0AYoI6geYy/Mo7P2RX1qC1fC?=
 =?us-ascii?Q?LDjw1QhYEbrpUJN1vPhxlqBeLMFFwQ058a0E40cOlvzpc0fH9atbUaXBYEFn?=
 =?us-ascii?Q?4fMFnWuBkYtUpoIwNio=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 16:40:31.9493 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be8c423a-6286-427a-7a51-08de1af7b488
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8434
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

The csumonly forwarding mode had two issues preventing TSO from working
correctly:

First, inner L2 length calculation was incorrect. The inner_l2_len field
from rte_net_get_ptype() includes the outer L4 header and tunnel header
lengths for UDP-based tunnels (VXLAN, GENEVE), but the code was using
it directly as the inner Ethernet header length.
Fixed by subtracting these from inner_l2_len to get the inner Ethernet
header length.

Second, inner L4 protocol detection failed when outer and inner L3 types
differed. The parse_l4_proto() function used RTE_ETH_IS_IPV4_HDR()
which checks the outer L3 type, even when parsing inner headers.
For packets with IPv6 outer and IPv4 inner headers (or vice versa),
this caused the inner L4 protocol to be undetected, preventing TSO.

Fixed by checking the appropriate L3 type mask (outer vs inner) based
on the parse_inner parameter.

Fixes: a738c43ffaee ("app/testpmd: fix tunnel inner info")
Cc: stable@dpdk.org

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
---
 app/test-pmd/csumonly.c | 51 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 6 deletions(-)

diff --git a/app/test-pmd/csumonly.c b/app/test-pmd/csumonly.c
index a6e872e5a4..17e2af9a65 100644
--- a/app/test-pmd/csumonly.c
+++ b/app/test-pmd/csumonly.c
@@ -529,8 +529,24 @@ static uint8_t
 parse_l4_proto(const struct rte_mbuf *m, uint32_t off, uint32_t ptype, bool parse_inner)
 {
 	int frag = 0, ret;
+	bool is_ipv4, is_ipv6;
+
+	if (parse_inner) {
+		/* Check inner L3 type for tunneled packets */
+		uint32_t inner_l3 = ptype & RTE_PTYPE_INNER_L3_MASK;
+		is_ipv4 = (inner_l3 == RTE_PTYPE_INNER_L3_IPV4) ||
+			  (inner_l3 == RTE_PTYPE_INNER_L3_IPV4_EXT) ||
+			  (inner_l3 == RTE_PTYPE_INNER_L3_IPV4_EXT_UNKNOWN);
+		is_ipv6 = (inner_l3 == RTE_PTYPE_INNER_L3_IPV6) ||
+			  (inner_l3 == RTE_PTYPE_INNER_L3_IPV6_EXT) ||
+			  (inner_l3 == RTE_PTYPE_INNER_L3_IPV6_EXT_UNKNOWN);
+	} else {
+		/* Check outer L3 type */
+		is_ipv4 = RTE_ETH_IS_IPV4_HDR(ptype);
+		is_ipv6 = RTE_ETH_IS_IPV6_HDR(ptype);
+	}
 
-	if (RTE_ETH_IS_IPV4_HDR(ptype)) {
+	if (is_ipv4) {
 		const struct rte_ipv4_hdr *ip4h;
 		struct rte_ipv4_hdr ip4h_copy;
 		ip4h = rte_pktmbuf_read(m, off, sizeof(*ip4h), &ip4h_copy);
@@ -538,7 +554,7 @@ parse_l4_proto(const struct rte_mbuf *m, uint32_t off, uint32_t ptype, bool pars
 			return 0;
 
 		return ip4h->next_proto_id;
-	} else if (RTE_ETH_IS_IPV6_HDR(ptype)) {
+	} else if (is_ipv6) {
 		const struct rte_ipv6_hdr *ip6h;
 		struct rte_ipv6_hdr ip6h_copy;
 		ip6h = rte_pktmbuf_read(m, off, sizeof(*ip6h), &ip6h_copy);
@@ -552,9 +568,15 @@ parse_l4_proto(const struct rte_mbuf *m, uint32_t off, uint32_t ptype, bool pars
 			return ip6h->proto;
 
 		off += sizeof(struct rte_ipv6_hdr);
+		/* Check offset before parsing extension headers. */
+		if (off >= m->pkt_len)
+			return 0;
 		ret = rte_net_skip_ip6_ext(ip6h->proto, m, &off, &frag);
 		if (ret < 0)
 			return 0;
+		/* Ensure offset is valid after skipping IPv6 extension headers. */
+		if (off > m->pkt_len)
+			return 0;
 		return ret;
 	}
 
@@ -703,7 +725,21 @@ pkt_burst_checksum_forward(struct fwd_stream *fs)
 		if (txp->parse_tunnel && RTE_ETH_IS_TUNNEL_PKT(ptype) != 0) {
 			info.is_tunnel = 1;
 			update_tunnel_outer(&info);
-			info.l2_len = hdr_lens.inner_l2_len;
+			/* For tunnels with inner L2 (e.g., VXLAN, GENEVE with Ethernet),
+			 * inner_l2_len includes outer L4 + tunnel headers.
+			 * Subtract them to get only inner L2 length.
+			 * For tunnels without inner L2, inner_l2_len already contains
+			 * only headers before inner L3, no adjustment needed.
+			 */
+			if (ptype & RTE_PTYPE_INNER_L2_MASK) {
+				if (unlikely(hdr_lens.inner_l2_len <
+					     hdr_lens.l4_len + hdr_lens.tunnel_len))
+					info.l2_len = 0;
+				else
+					info.l2_len = hdr_lens.inner_l2_len -
+						hdr_lens.l4_len - hdr_lens.tunnel_len;
+			} else
+				info.l2_len = hdr_lens.inner_l2_len;
 			info.l3_len = hdr_lens.inner_l3_len;
 			info.l4_len = hdr_lens.inner_l4_len;
 			eth_hdr = (struct rte_ether_hdr *)((char *)l3_hdr +
@@ -714,11 +750,14 @@ pkt_burst_checksum_forward(struct fwd_stream *fs)
 		}
 		/* update l3_hdr and outer_l3_hdr if a tunnel was parsed */
 		if (info.is_tunnel) {
-			uint16_t l3_off = info.outer_l2_len +  info.outer_l3_len + info.l2_len;
+			uint16_t l3_off = info.outer_l2_len +  info.outer_l3_len +
+				hdr_lens.l4_len + hdr_lens.tunnel_len + info.l2_len;
 
 			outer_l3_hdr = l3_hdr;
-			l3_hdr = (char *)l3_hdr + info.outer_l3_len + info.l2_len;
-			info.l4_proto = parse_l4_proto(m, l3_off, ptype, true);
+			l3_hdr = (char *)eth_hdr + info.l2_len;
+			/* Validate offset is within packet bounds before parsing */
+			if (l3_off < info.pkt_len)
+				info.l4_proto = parse_l4_proto(m, l3_off, ptype, true);
 		}
 		/* step 2: depending on user command line configuration,
 		 * recompute checksum either in software or flag the
-- 
2.34.1

